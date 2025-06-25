mod lib;

use lib::{DataFrame, DataValue};

fn main() {
    // Create a DataFrame with columns
    let columns = vec!["id".to_string(), "name".to_string(), "score".to_string()];
    let df = DataFrame::read_csv("data.csv").unwrap_or_else(|_| DataFrame::new(columns));

    // Print shape
    let (rows, cols) = df.shape();
    println!("Shape: {} rows, {} columns", rows, cols);

    // Print columns
    println!("Columns: {:?}", df.columns());

    // Print all data
    println!("Data:");
    for row in df.data() {
        println!("{:?}", row);
    }

    // Print head (first 2 rows)
    println!("Head (first 2 rows):");
    let head = df.head(2);
    for row in head.data() {
        println!("{:?}", row);
    }

    df.write_csv("new.csv").unwrap_or_else(|err| {
        eprintln!("Error writing CSV: {}", err);
    });
}