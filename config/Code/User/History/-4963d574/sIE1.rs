use std::collections::HashMap;

#[derive(Debug, Clone)]
pub enum DataValue {
    Int(i64),
    Float(f64),
    Bool(bool),
    Str(String),
    Null,
}

#[derive(Debug, Clone)]
pub struct DataFrame {
    columns: Vec<String>,
    data: Vec<Vec<DataValue>>,
}

impl DataFrame {
    pub fn new(columns: Vec<String>) -> Self {
        DataFrame {
            columns,
            data: Vec::new(),
        }
    }

    pub fn from_rows(columns: Vec<String>, rows: Vec<Vec<DataValue>>) -> Self {
        DataFrame { columns, data: rows }
    }

    pub fn add_row(&mut self, row: Vec<DataValue>) {
        assert_eq!(row.len(), self.columns.len(), "Row length must match columns");
        self.data.push(row);
    }

    pub fn shape(&self) -> (usize, usize) {
        (self.data.len(), self.columns.len())
    }

    pub fn columns(&self) -> &Vec<String> {
        &self.columns
    }

    pub fn data(&self) -> &Vec<Vec<DataValue>> {
        &self.data
    }
}