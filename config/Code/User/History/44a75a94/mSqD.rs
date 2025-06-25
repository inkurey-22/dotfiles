mod lib;

use lib::{DataFrame, DataValue};

fn main() {
    // Create a DataFrame with columns
    let columns = vec!["id".to_string(), "name".to_string(), "score".to_string()];
    let mut df = DataFrame::new(columns);

    df.read_csv("data.csv").expect("Failed to read CSV file");
    // Add some rows
    df.add_row(vec![
        DataValue::Int(1),
        DataValue::Str("Alice".to_string()),
        DataValue::Float(85.5),
    ]);
    df.add_row(vec![
        DataValue::Int(2),
        DataValue::Str("Bob".to_string()),
        DataValue::Float(92.0),
    ]);
    df.add_row(vec![
        DataValue::Int(3),
        DataValue::Str("Charlie".to_string()),
        DataValue::Null,
    ]);

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
}