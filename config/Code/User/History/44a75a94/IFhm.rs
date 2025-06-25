mod lib;

use std::cmp::Ordering;

use lib::{DataFrame, DataValue};

fn is_older_than_30(value: &DataValue) -> bool {
    match value {
        DataValue::Int(v) => *v > 30,
        _ => false,
    }
}

fn sort_by_wealth(a: &DataValue, b: &DataValue) -> Ordering {
    match (a, b) {
        (DataValue::Float(a_val), DataValue::Float(b_val)) => a_val.partial_cmp(b_val).unwrap_or(Ordering::Equal),
        _ => Ordering::Equal,
    }
}

fn sort_by_name(a: &DataValue, b: &DataValue) -> Ordering {
    match (a, b) {
        (DataValue::Str(a_str), DataValue::Str(b_str)) => a_str.cmp(b_str),
        _ => Ordering::Equal,
    }
}

fn main() {
    // Create a DataFrame with columns
    let columns = vec!["id".to_string(), "name".to_string(), "score".to_string()];
    let df = DataFrame::read_csv("data.csv").unwrap_or_else(|_| DataFrame::new(columns, vec![]));

    // Print shape
    let (rows, cols) = df.shape();
    println!("Shape: {} rows, {} columns", rows, cols);

    // Print infos
    df.info();

    // Describe
    df.describe();

    let filtered = df.filter("age", is_older_than_30);
    filtered.write_csv("filtered_data.csv").unwrap_or_else(|_| {
        eprintln!("Failed to write filtered data to CSV");
    });

    let sorted = df.sort("name", sort_by_name);
    sorted.write_csv("sorted_data.csv").unwrap_or_else(|_| {
        eprintln!("Failed to write sorted data to CSV");
    });
}
