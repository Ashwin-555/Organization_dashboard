from flask import Flask, render_template, request, redirect, url_for, jsonify
from flask_mysqldb import MySQL

app = Flask(__name__)

# MySQL Configuration
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'  # Change this if needed
app.config['MYSQL_PASSWORD'] = 'Ash@123win'  # Change this
app.config['MYSQL_DB'] = 'employee_db'

mysql = MySQL(app)

# Home Page
@app.route('/')
def index():
    return render_template('index.html')

# Department Pages
@app.route('/department/<department_name>')
def department_page(department_name):
    cur = mysql.connection.cursor()
    cur.execute("SELECT employee_id, name, role FROM employees WHERE department = %s", (department_name,))
    employee_details = cur.fetchall()
    
    cur.execute("SELECT employee_id, name, performance_rating, feedback FROM employees WHERE department = %s", (department_name,))
    performance_details = cur.fetchall()
    
    cur.execute("SELECT employee_id, name, working_hours, attendance_status FROM employees WHERE department = %s", (department_name,))
    attendance_details = cur.fetchall()
    
    cur.close()
    return render_template(f'{department_name}.html', department_name=department_name, 
                           employee_details=employee_details, performance_details=performance_details, 
                           attendance_details=attendance_details)

# Get Employees API

@app.route('/api/employees/<department>', methods=['GET'])
def get_employees(department):
    try:
        cur = mysql.connection.cursor()
        cur.execute("SELECT employee_id, name, role, performance_rating, feedback, working_hours, attendance_status FROM employees WHERE department = %s", (department,))
        employees = cur.fetchall()
        cur.close()

        if not employees:
            return jsonify({"employees": []})  # Return empty list if no data

        employee_list = [
            {
                "employee_id": emp[0],
                "name": emp[1],
                "role": emp[2],
                "performance_rating": emp[3],
                "feedback": emp[4],
                "working_hours": emp[5],
                "attendance_status": emp[6]
            }
            for emp in employees
        ]

        return jsonify({"employees": employee_list})
    
    except Exception as e:
        return jsonify({"error": str(e)}), 500



# Add Employee API
@app.route('/api/<department_name>/add_employee', methods=['POST'])
def add_employee(department_name):
    data = request.json  # Get JSON data from the request

    # Ensure all fields are received
    if not all(key in data for key in ["employee_id", "name", "role", "performance_rating", "feedback", "working_hours", "attendance_status"]):
        return jsonify({'error': 'Missing required fields'}), 400

    try:
        cur = mysql.connection.cursor()
        cur.execute(
            """INSERT INTO employees 
            (employee_id, name, role, performance_rating, feedback, working_hours, attendance_status, department) 
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)""",
            (data['employee_id'], data['name'], data['role'], data['performance_rating'],
             data['feedback'], data['working_hours'], data['attendance_status'], department_name)
        )
        mysql.connection.commit()
        cur.close()

        return jsonify({'message': 'Employee added successfully'})
    except Exception as e:
        return jsonify({'error': str(e)}), 500

# Employee Form Page
@app.route('/department/<department_name>/add_employee')
def add_employee_form(department_name):
    return render_template('employee_details.html', department_name=department_name)
# Remove Employee API
@app.route('/api/<department>/remove_employee/<int:employee_id>', methods=['DELETE'])
def remove_employee(department, employee_id):
    try:
        cur = mysql.connection.cursor()
        cur.execute("DELETE FROM employees WHERE employee_id = %s AND department = %s", (employee_id, department))
        mysql.connection.commit()
        cur.close()
        return jsonify({'message': f'Employee {employee_id} removed successfully from {department}'})
    except Exception as e:
        return jsonify({'error': str(e)}), 500


if __name__ == '__main__':
    app.run(debug=True)











