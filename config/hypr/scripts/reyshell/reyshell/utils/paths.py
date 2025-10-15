from __future__ import annotations

import hashlib
import json
import os
import shutil
import tempfile
from pathlib import Path

config_dir = Path.home() / ".config"
data_dir = Path.home() / ".local/share"
state_dir = Path.home() / ".local/state"
cache_dir = Path.home() / ".cache"
pictures_dir = Path(os.getenv("XDG_PICTURES_DIR", Path.home() / "Pictures"))
videos_dir = Path(os.getenv("XDG_VIDEOS_DIR", Path.home() / "Videos"))

r_config_dir = config_dir / "reyshell"
r_data_dir = data_dir / "reyshell"
r_state_dir = state_dir / "reyshell"
r_cache_dir = cache_dir / "reyshell"

user_config_path = r_config_dir / "cli.json"
cli_data_dir = Path(__file__).parent.parent / "data"
templates_dir = cli_data_dir / "templates"

scheme_path = r_state_dir / "scheme.json"
scheme_data_dir = cli_data_dir / "schemes"
scheme_cache_dir = r_cache_dir / "schemes"

wallpapers_dir = pictures_dir / "Wallpapers"
wallpaper_path_path = r_state_dir / "wallpaper/path.txt"
wallpaper_link_path = r_state_dir / "wallpaper/current"
wallpaper_thumbnail_path = r_state_dir / "wallpaper/thumbnail.jpg"
wallpapers_cache_dir = r_cache_dir / "wallpapers"

screenshots_dir = pictures_dir / "Screenshots"
screenshots_cache_dir = r_cache_dir / "screenshots"

recordings_dir = videos_dir / "Recordings"
recording_path = r_state_dir / "record/recording.mp4"
recording_notif_path = r_state_dir / "record/notifid.txt"


def compute_hash(path: Path | str) -> str:
    sha = hashlib.sha256()

    with open(path, "rb") as f:
        while chunk := f.read(8192):
            sha.update(chunk)

    return sha.hexdigest()


def atomic_dump(path: Path, content: dict[str, any]) -> None:
    with tempfile.NamedTemporaryFile("w", encoding="utf-8") as f:
        json.dump(content, f)
        f.flush()
        shutil.move(f.name, path)
