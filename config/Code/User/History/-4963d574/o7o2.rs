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
    
    pub fn read_csv(file_path: &str) -> Result<Self, Box<dyn std::error::Error>> {
        let mut rdr = csv::Reader::from_path(file_path)?;
        let headers = rdr.headers()?.iter().map(String::from).collect();
        let mut rows = Vec::new();

        for result in rdr.records() {
            let record = result?;
            let row: Vec<DataValue> = record.iter().map(|s| {
                if let Ok(i) = s.parse::<i64>() {
                    DataValue::Int(i)
                } else if let Ok(f) = s.parse::<f64>() {
                    DataValue::Float(f)
                } else if s == "true" {
                    DataValue::Bool(true)
                } else if s == "false" {
                    DataValue::Bool(false)
                } else if s.is_empty() {
                    DataValue::Null
                } else {
                    DataValue::Str(s.to_string())
                }
            }).collect();
            rows.push(row);
        }

        Ok(DataFrame::from_rows(headers, rows))
    }

    pub fn head(&self, n: usize) -> DataFrame {
        let mut head_rows = Vec::new();
        for row in self.data.iter().take(n) {
            head_rows.push(row.clone());
        }
        DataFrame::from_rows(self.columns.clone(), head_rows)
    }
}
