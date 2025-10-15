import re
import subprocess
from colorsys import hls_to_rgb, rgb_to_hls
from pathlib import Path

from reyshell.utils.logging import log_exception
from reyshell.utils.paths import config_dir, r_state_dir, templates_dir


def adjust_lightness(hex_color: str, percent: float) -> str:
    r = int(hex_color[0:2], 16) / 255.0
    g = int(hex_color[2:4], 16) / 255.0
    b = int(hex_color[4:6], 16) / 255.0
    h, l, s = rgb_to_hls(r, g, b)
    l = max(0.0, min(1.0, l + percent / 100.0))
    r, g, b = hls_to_rgb(h, l, s)
    return f"{int(r * 255):02x}{int(g * 255):02x}{int(b * 255):02x}"


def adjust_saturation(hex_color: str, percent: float) -> str:
    r = int(hex_color[0:2], 16) / 255.0
    g = int(hex_color[2:4], 16) / 255.0
    b = int(hex_color[4:6], 16) / 255.0
    h, l, s = rgb_to_hls(r, g, b)
    s = max(0.0, min(1.0, s + percent / 100.0))
    r, g, b = hls_to_rgb(h, l, s)
    return f"{int(r * 255):02x}{int(g * 255):02x}{int(b * 255):02x}"


def hex_to_rgb(c: str) -> str:
    r = int(c[0:2], 16)
    g = int(c[2:4], 16)
    b = int(c[4:6], 16)
    return f"{r},{g},{b}"


def gen_conf(colours: dict[str, str]) -> str:
    conf = ""
    for name, colour in colours.items():
        conf += f"${name} = {colour}\n"
    return conf


def gen_scss(colours: dict[str, str]) -> str:
    scss = ""
    for name, colour in colours.items():
        scss += f"${name}: #{colour};\n"
    return scss


def gen_replace(colours: dict[str, str], template: Path, hash: bool = False, rgb_format: bool = False) -> str:
    template_text = template.read_text()

    def replace_color(match):
        var = match.group("var")
        ops = match.group("ops") or ""

        if var not in colours:
            return match.group(0)

        color = colours[var]

        # Find all operator/percent pairs
        for op, percent in re.findall(r"(\+{1,2}|\-{1,2})(\d+)%", ops):
            value = float(percent)
            if op in {"+", "-"}:
                color = adjust_lightness(color, value if op == "+" else -value)
            elif op in {"++", "--"}:
                color = adjust_saturation(color, value if op == "++" else -value)

        if rgb_format:
            return hex_to_rgb(color)
        if hash:
            return f"#{color}"
        return color

    pattern = re.compile(r"\{\{\s*\$(?P<var>\w+)(?P<ops>(?:\s*(?:\+{1,2}|\-{1,2})\d+%)*)\s*\}\}")
    return pattern.sub(replace_color, template_text)


def c2s(c: str, *i: list[int]) -> str:
    """Hex to ANSI sequence (e.g. ffffff, 11 -> \x1b]11;rgb:ff/ff/ff\x1b\\)"""
    return f"\x1b]{';'.join(map(str, i))};rgb:{c[0:2]}/{c[2:4]}/{c[4:6]}\x1b\\"


def gen_sequences(colours: dict[str, str]) -> str:
    """10: foreground
    11: background
    12: cursor
    17: selection
    4:
        0 - 7: normal colours
        8 - 15: bright colours
        16+: 256 colours
    """
    return (
        c2s(colours["onSurface"], 10)
        + c2s(colours["surface"], 11)
        + c2s(colours["secondary"], 12)
        + c2s(colours["secondary"], 17)
        + c2s(colours["term0"], 4, 0)
        + c2s(colours["term1"], 4, 1)
        + c2s(colours["term2"], 4, 2)
        + c2s(colours["term3"], 4, 3)
        + c2s(colours["term4"], 4, 4)
        + c2s(colours["term5"], 4, 5)
        + c2s(colours["term6"], 4, 6)
        + c2s(colours["term7"], 4, 7)
        + c2s(colours["term8"], 4, 8)
        + c2s(colours["term9"], 4, 9)
        + c2s(colours["term10"], 4, 10)
        + c2s(colours["term11"], 4, 11)
        + c2s(colours["term12"], 4, 12)
        + c2s(colours["term13"], 4, 13)
        + c2s(colours["term14"], 4, 14)
        + c2s(colours["term15"], 4, 15)
        + c2s(colours["primary"], 4, 16)
        + c2s(colours["secondary"], 4, 17)
        + c2s(colours["tertiary"], 4, 18)
    )


def write_file(path: Path, content: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content)


@log_exception
def apply_terms(sequences: str) -> None:
    state = r_state_dir / "sequences.txt"
    state.parent.mkdir(parents=True, exist_ok=True)
    state.write_text(sequences)

    pts_path = Path("/dev/pts")
    for pt in pts_path.iterdir():
        if pt.name.isdigit():
            try:
                with pt.open("a") as f:
                    f.write(sequences)
            except PermissionError:
                pass


@log_exception
def apply_hypr(conf: str) -> None:
    write_file(config_dir / "hypr/colors.conf", conf)


@log_exception
def apply_fuzzel(colours: dict[str, str]) -> None:
    template = gen_replace(colours, templates_dir / "fuzzel.ini")
    write_file(config_dir / "fuzzel/fuzzel.ini", template)


@log_exception
def apply_btop(colours: dict[str, str]) -> None:
    template = gen_replace(colours, templates_dir / "btop.theme", hash=True)
    write_file(config_dir / "btop/themes/reyshell.theme", template)
    subprocess.run(["killall", "-USR2", "btop"], check=False, stderr=subprocess.DEVNULL)


@log_exception
def apply_kitty(colours: dict[str, str]) -> None:
    template = gen_replace(colours, templates_dir / "kitty.conf", hash=True)
    write_file(config_dir / "kitty/colors.conf", template)


@log_exception
def apply_micro(colours: dict[str, str]) -> None:
    template = gen_replace(colours, templates_dir / "micro.micro", hash=True)
    write_file(config_dir / "micro/colorschemes/reyshell.micro", template)


@log_exception
def apply_clipse(colours: dict[str, str]) -> None:
    template = gen_replace(colours, templates_dir / "clipse.json", hash=True)
    write_file(config_dir / "clipse/custom_theme.json", template)


def find_firefox_profiles():
    paths = []
    linux_profiles = Path.home() / ".mozilla" / "firefox"

    if linux_profiles.exists():
        for d in linux_profiles.iterdir():
            if d.is_dir() and (d / "chrome").is_dir():
                paths.append(d / "chrome")
    return paths


@log_exception
def apply_firefox(colours: dict[str, str]) -> None:
    template = gen_replace(colours, templates_dir / "firefox.css", hash=True)
    chrome_dirs = find_firefox_profiles()
    for chrome_dir in chrome_dirs:
        write_file(chrome_dir / "reyshell.css", template)


@log_exception
def apply_discord(scss: str) -> None:
    import tempfile

    with tempfile.TemporaryDirectory("w") as tmp_dir:
        (Path(tmp_dir) / "_colours.scss").write_text(scss)
        conf = subprocess.check_output(["sass", "-I", tmp_dir, templates_dir / "discord.scss"], text=True)

    for client in "Equicord", "Vencord", "BetterDiscord", "equibop", "vesktop", "legcord":
        write_file(config_dir / client / "themes/reyshell.theme.css", conf)


@log_exception
def apply_gtk(colours: dict[str, str], mode: str) -> None:
    template = gen_replace(colours, templates_dir / "gtk.css", hash=True)
    write_file(config_dir / "gtk-3.0/gtk.css", template)
    write_file(config_dir / "gtk-4.0/gtk.css", template)

    subprocess.run(
        [
            "dconf",
            "write",
            "/org/gnome/desktop/interface/gtk-theme",
            "'adw-gtk3'" if mode == "light" else "'adw-gtk3-dark'",
        ],
        check=False,
    )

    subprocess.run(
        ["dconf", "write", "/org/gnome/desktop/interface/color-scheme", f"'prefer-{mode}'"], check=False
    )

    subprocess.run(
        [
            "dconf",
            "write",
            "/org/gnome/desktop/interface/icon-theme",
            f"'Papirus-{mode.capitalize()}'",
        ],
        check=False,
    )


@log_exception
def apply_qt(colours: dict[str, str], mode: str) -> None:
    template = gen_replace(colours, templates_dir / f"qt{mode}.colors", hash=True)
    write_file(config_dir / "qt5ct/colors/reyshell.colors", template)
    write_file(config_dir / "qt6ct/colors/reyshell.colors", template)

    qtct = (templates_dir / "qtct.conf").read_text()
    qtct = qtct.replace("{{ $mode }}", mode.capitalize())

    for ver in 5, 6:
        conf = qtct.replace("{{ $config }}", str(config_dir / f"qt{ver}ct"))

        if ver == 5:
            conf += """
[Fonts]
fixed="Adwaita Mono,11,-1,5,50,0,0,0,0,0"
general="Adwaita Sans,11,-1,5,50,0,0,0,0,0"
"""
        else:
            conf += """
[Fonts]
fixed="Adwaita Mono,11,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
general="Adwaita Sans,11,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
"""
        write_file(config_dir / f"qt{ver}ct/qt{ver}ct.conf", conf)


def apply_colours(colours: dict[str, str], mode: str) -> None:
    apply_terms(gen_sequences(colours))
    apply_hypr(gen_conf(colours))
    apply_fuzzel(colours)
    apply_btop(colours)
    apply_kitty(colours)
    apply_micro(colours)
    apply_clipse(colours)
    apply_firefox(colours)
    apply_discord(gen_scss(colours))
    apply_gtk(colours, mode)
    apply_qt(colours, mode)
