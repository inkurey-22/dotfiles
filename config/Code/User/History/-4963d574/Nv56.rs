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

    pub fn write_csv(&self, file_path: &str) -> Result<(), Box<dyn std::error::Error>> {
        let mut wtr = csv::Writer::from_path(file_path)?;
        wtr.write_record(&self.columns)?;

        for row in &self.data {
            let record: Vec<String> = row.iter().map(|v| match v {
                DataValue::Int(i) => i.to_string(),
                DataValue::Float(f) => f.to_string(),
                DataValue::Bool(b) => b.to_string(),
                DataValue::Str(s) => s.clone(),
                DataValue::Null => String::new(),
            }).collect();
            wtr.write_record(record)?;
        }

        wtr.flush()?;
        Ok(())
    }

    pub fn head(&self, n: usize) -> DataFrame {
        let mut head_rows = Vec::new();
        for row in self.data.iter().take(n) {
            head_rows.push(row.clone());
        }
        DataFrame::from_rows(self.columns.clone(), head_rows)
    }

    pub fn tail(&self, n: usize) -> DataFrame {
        let mut tail_rows = Vec::new();
        for row in self.data.iter().rev().take(n) {
            tail_rows.push(row.clone());
        }
        tail_rows.reverse(); // Reverse to maintain original order
        DataFrame::from_rows(self.columns.clone(), tail_rows)
    }

    pub fn shape(&self) -> (usize, usize) {
        (self.data.len(), self.columns.len())
    }

    pub fn info(&self) -> String {
        let mut info = format!(
            "DataFrame with {} rows and {} columns\n",
            self.data.len(),
            self.columns.len()
        );
        info.push_str("Columns:\n");
        for (i, col) in self.columns.iter().enumerate() {
            // Infer type by scanning the first non-null value in the column
            let dtype = self
                .data
                .iter()
                .map(|row| row.get(i))
                .flatten()
                .find_map(|v| match v {
                    DataValue::Int(_) => Some("Integer"),
                    DataValue::Float(_) => Some("Float"),
                    DataValue::Bool(_) => Some("Boolean"),
                    DataValue::Str(_) => Some("String"),
                    DataValue::Null => None,
                })
                .unwrap_or("Unknown");
            info.push_str(&format!("{}: {} ({})\n", i, col, dtype));
        }
        print!("{}", info);
        info
    }

    pub fn describe(&self) -> String {
        use std::f64;

        let mut desc = String::new();

        for (i, col) in self.columns.iter().enumerate() {
            // Collect all numeric values in this column
            let nums: Vec<f64> = self.data.iter()
                .filter_map(|row| match row.get(i) {
                    Some(DataValue::Int(v)) => Some(*v as f64),
                    Some(DataValue::Float(v)) => Some(*v),
                    _ => None,
                })
                .collect();

            if nums.is_empty() {
                continue; // Skip non-numeric columns
            }

            let count = nums.len();
            let mean = nums.iter().sum::<f64>() / count as f64;
            let min = nums.iter().cloned().fold(f64::INFINITY, f64::min);
            let max = nums.iter().cloned().fold(f64::NEG_INFINITY, f64::max);
            let std = if count > 1 {
                let var = nums.iter().map(|v| (v - mean).powi(2)).sum::<f64>() / (count as f64);
                var.sqrt()
            } else {
                0.0
            };

            desc.push_str(&format!(
                "Column: {}\nCount: {}\nMean: {:.2}\nStd: {:.2}\nMin: {:.2}\nMax: {:.2}\n\n",
                col, count, mean, std, min, max
            ));
        }

        print!("{}", desc);
        desc
    }

    pub fn filter<F>(&self, column: &str, filter_func: F) -> DataFrame
    where
        F: Fn(&DataValue) -> bool,
    {
        let col_idx = match self.columns.iter().position(|c| c == column) {
            Some(idx) => idx,
            None => return DataFrame::from_rows(self.columns.clone(), vec![]), // Return empty if column not found
        };

        let filtered_rows: Vec<Vec<DataValue>> = self
            .data
            .iter()
            .filter(|row| {
                row.get(col_idx)
                    .map(|val| filter_func(val))
                    .unwrap_or(false)
            })
            .cloned()
            .collect();

        DataFrame::from_rows(self.columns.clone(), filtered_rows)
    }

    pub fn sort<F>(&self, column: &str) -> DataFrame {
        let col_idx = match self.columns.iter().position(|c| c == column) {
            Some(idx) => idx,
            None => return DataFrame::from_rows(self.columns.clone(), vec![]), // Return empty if column not found
        };

        let mut sorted_data = self.data.clone();
        sorted_data.sort_by(|a, b| {
            a.get(col_idx)
                .cmp(&b.get(col_idx))
                .then_with(|| a.cmp(b)) // Secondary sort to maintain order
        });

        DataFrame::from_rows(self.columns.clone(), sorted_data)
    }
}
