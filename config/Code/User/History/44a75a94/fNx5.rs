mod lib;

use std::cmp::Ordering;

use lib::{DataFrame, DataValue};

fn is_older_than_30(value: &DataValue) -> bool {
    match value {
        DataValue::Int(v) => *v > 30,
        _ => false,
    }
}

fn more_wealthy_than(value1: &DataValue, value2: &DataValue) -> Ordering {
    match (value1, value2) {
        (DataValue::Float(v1), DataValue::Float(v2)) => v1.partial_cmp(v2).unwrap_or(Ordering::Equal),
        _ => Ordering::Equal, // Default case if types do not match
    }
}

fn main() {
    // Create a DataFrame with columns
    let columns = vec!["id".to_string(), "name".to_string(), "score".to_string()];
    let df = DataFrame::read_csv("data.csv").unwrap_or_else(|_| DataFrame::new(columns));

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

    let sorted = df.sort("wealth");
    sorted.write_csv("sorted_data.csv").unwrap_or_else(|_| {
        eprintln!("Failed to write sorted data to CSV");
    });
}
