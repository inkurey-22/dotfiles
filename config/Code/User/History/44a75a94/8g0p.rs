mod lib;

use lib::{DataFrame, DataValue};

fn is_older_than_30(value: &DataValue) -> bool {
    match value {
        DataValue::Int(v) => *v > 30,
        _ => false,
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

    let filtered = df.filter(df, "age", )
}
