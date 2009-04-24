CREATE TABLE expenses (expense_id INTEGER PRIMARY KEY AUTOINCREMENT, expense_name TEXT, expense_cost FLOAT, expense_necessary BOOLEAN, created_at DATETIME);
INSERT INTO expenses (expense_id, expense_name, expense_cost, expense_necessary, created_at) VALUES (1, 'Cherry Pie', 2.00, 1, current_timestamp);
INSERT INTO expenses (expense_id, expense_name, expense_cost, expense_necessary, created_at) VALUES (2, 'Cake', 5.00, 0, current_timestamp);
INSERT INTO expenses (expense_id, expense_name, expense_cost, expense_necessary, created_at) VALUES (3, 'Cookie', 25.00, 0, current_timestamp);