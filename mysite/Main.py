import tkinter as tk
from tkinter import ttk, messagebox, simpledialog
import mysql.connector
from datetime import datetime
from decimal import Decimal  # Import Decimal for precise arithmetic

# Database connection
def connect_db():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="somsm123",
        database="mybankbd"
    )

# Create transactions table (if it doesn't exist)
def create_transactions_table():
    conn = None
    try:
        conn = connect_db()
        cursor = conn.cursor()
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS transactions (
                id INT AUTO_INCREMENT PRIMARY KEY,
                source_id INT NOT NULL,
                destination_id INT NOT NULL,
                amount DECIMAL(10, 2) NOT NULL,
                transaction_date DATETIME NOT NULL,
                balance_after_transaction DECIMAL(10, 2),
                FOREIGN KEY (source_id) REFERENCES account_data(id),
                FOREIGN KEY (destination_id) REFERENCES account_data(id)
            )
        """)
        conn.commit()
    except mysql.connector.Error as err:
        messagebox.showerror("Database Error", f"An error occurred: {err}")
    finally:
        if conn and conn.is_connected():
            cursor.close()
            conn.close()

# Login function
def login():
    username = entry_username.get()
    password = entry_password.get()

    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM login_details WHERE username=%s AND password=%s", (username, password))
    user = cursor.fetchone()

    if user:
        messagebox.showinfo("Login Successful", "Welcome!")
        login_frame.pack_forget()  # Hide login frame
        show_main_menu()  # Show bank features
        display_accounts()  # Display bank accounts in a grid
    else:
        messagebox.showerror("Login Failed", "Invalid credentials")

    cursor.close()
    conn.close()

# Tkinter window
root = tk.Tk()
root.title("77487, Dorser APP")
root.geometry("600x500")

# Login Frame
login_frame = tk.Frame(root)
login_frame.pack(pady=50)

tk.Label(login_frame, text="Username:").grid(row=0, column=0)
entry_username = tk.Entry(login_frame)
entry_username.grid(row=0, column=1)

tk.Label(login_frame, text="Password:").grid(row=1, column=0)
entry_password = tk.Entry(login_frame, show="*")
entry_password.grid(row=1, column=1)

tk.Button(login_frame, text="Login", command=login).grid(row=2, columnspan=2, pady=10)

# Main Menu Frame (Initially Hidden)
menu_frame = tk.Menu(root)

def show_main_menu():
    root.config(menu=menu_frame)
    
    file_menu = tk.Menu(menu_frame, tearoff=0)
    file_menu.add_command(label="Exit", command=root.quit)
    menu_frame.add_cascade(label="File", menu=file_menu)

    edit_menu = tk.Menu(menu_frame, tearoff=0)
    edit_menu.add_command(label="Create Account", command=create_account)
    edit_menu.add_command(label="Delete Account", command=delete_account)
    edit_menu.add_command(label="Edit Account", command=edit_account)
    edit_menu.add_command(label="Transfer", command=transfer)
    edit_menu.add_command(label="Withdraw", command=withdraw)
    edit_menu.add_command(label="Deposit", command=deposit)
    edit_menu.add_command(label="View Transactions", command=view_transactions)
    
    menu_frame.add_cascade(label="Edit", menu=edit_menu)

# Grid Frame for displaying accounts
grid_frame = ttk.Treeview(root)

def display_accounts():
    global grid_frame
    grid_frame.pack(pady=20)
    grid_frame["columns"] = ("ID", "First Name", "Last Name", "Address", "Balance")

    grid_frame.column("#0", width=0, stretch=tk.NO)
    grid_frame.column("ID", anchor=tk.W, width=50)
    grid_frame.column("First Name", anchor=tk.W, width=150)
    grid_frame.column("Last Name", anchor=tk.W, width=150)
    grid_frame.column("Address", anchor=tk.W, width=250)
    grid_frame.column("Balance", anchor=tk.W, width=100)

    grid_frame.heading("#0", text="", anchor=tk.W)
    grid_frame.heading("ID", text="ID", anchor=tk.W)
    grid_frame.heading("First Name", text="First Name", anchor=tk.W)
    grid_frame.heading("Last Name", text="Last Name", anchor=tk.W)
    grid_frame.heading("Address", text="Address", anchor=tk.W)
    grid_frame.heading("Balance", text="Balance", anchor=tk.W)

    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("SELECT id, first_name, last_name, address, balance FROM account_data")
    for row in cursor.fetchall():
        grid_frame.insert("", tk.END, values=row)

    cursor.close()
    conn.close()

# Function to refresh the account grid
def refresh_accounts():
    for row in grid_frame.get_children():
        grid_frame.delete(row)
    display_accounts()

# Create Account Function
def create_account():
    first_name = simpledialog.askstring("Create Account", "Enter First Name:")
    if first_name:
        last_name = simpledialog.askstring("Create Account", "Enter Last Name:")
        if last_name:
            address = simpledialog.askstring("Create Account", "Enter Address:")
            if address:
                initial_balance = simpledialog.askfloat("Create Account", "Enter Initial Balance:")
                if initial_balance is not None:
                    try:
                        conn = connect_db()
                        cursor = conn.cursor()
                        cursor.execute(
                            "INSERT INTO account_data (first_name, last_name, address, balance) VALUES (%s, %s, %s, %s)",
                            (first_name, last_name, address, initial_balance)
                        )
                        conn.commit()
                        messagebox.showinfo("Success", "Account created successfully!")
                    except mysql.connector.Error as err:
                        messagebox.showerror("Database Error", f"An error occurred: {err}")
                    finally:
                        if conn.is_connected():
                            cursor.close()
                            conn.close()
                        refresh_accounts()

# Delete Account Function
def delete_account():
    selected_item = grid_frame.selection()
    if selected_item:
        account_id = grid_frame.item(selected_item, "values")[0]
        confirm = messagebox.askyesno("Confirm Delete", "Are you sure you want to delete this account?")
        if confirm:
            try:
                conn = connect_db()
                cursor = conn.cursor()
                cursor.execute("DELETE FROM account_data WHERE id=%s", (account_id,))
                conn.commit()
                messagebox.showinfo("Success", "Account deleted successfully!")
            except mysql.connector.Error as err:
                messagebox.showerror("Database Error", f"An error occurred: {err}")
            finally:
                if conn.is_connected():
                    cursor.close()
                    conn.close()
                refresh_accounts()
    else:
        messagebox.showwarning("No Selection", "Please select an account to delete.")

# Edit Account Function
def edit_account():
    selected_item = grid_frame.selection()
    if selected_item:
        account_id = grid_frame.item(selected_item, "values")[0]
        first_name = simpledialog.askstring("Edit Account", "Enter New First Name:")
        if first_name:
            last_name = simpledialog.askstring("Edit Account", "Enter New Last Name:")
            if last_name:
                address = simpledialog.askstring("Edit Account", "Enter New Address:")
                if address:
                    try:
                        conn = connect_db()
                        cursor = conn.cursor()
                        cursor.execute(
                            "UPDATE account_data SET first_name=%s, last_name=%s, address=%s WHERE id=%s",
                            (first_name, last_name, address, account_id)
                        )
                        conn.commit()
                        messagebox.showinfo("Success", "Account updated successfully!")
                    except mysql.connector.Error as err:
                        messagebox.showerror("Database Error", f"An error occurred: {err}")
                    finally:
                        if conn.is_connected():
                            cursor.close()
                            conn.close()
                        refresh_accounts()
    else:
        messagebox.showwarning("No Selection", "Please select an account to edit.")

# Deposit Function
def deposit():
    selected_item = grid_frame.selection()
    if selected_item:
        account_id = grid_frame.item(selected_item, "values")[0]
        amount = simpledialog.askfloat("Deposit", "Enter Amount to Deposit:")
        if amount is not None and amount > 0:
            try:
                conn = connect_db()
                cursor = conn.cursor()

                # Update balance
                cursor.execute("UPDATE account_data SET balance = balance + %s WHERE id=%s", (amount, account_id))

                # Record transaction
                transaction_date = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                cursor.execute("""
                    INSERT INTO transactions (source_id, destination_id, amount, transaction_date, balance_after_transaction) 
                    VALUES (%s, %s, %s, %s, %s)
                """, (account_id, account_id, amount, transaction_date, amount))

                conn.commit()
                messagebox.showinfo("Success", f"Deposited ${amount:.2f} successfully!")
            except mysql.connector.Error as err:
                messagebox.showerror("Database Error", f"An error occurred: {err}")
            finally:
                if conn.is_connected():
                    cursor.close()
                    conn.close()
                refresh_accounts()
    else:
        messagebox.showwarning("No Selection", "Please select an account to deposit into.")

# Withdraw Function
def withdraw():
    selected_item = grid_frame.selection()
    if selected_item:
        account_id = grid_frame.item(selected_item, "values")[0]
        amount = simpledialog.askfloat("Withdraw", "Enter Amount to Withdraw:")
        if amount is not None and amount > 0:
            try:
                conn = connect_db()
                cursor = conn.cursor()

                # Fetch current balance
                cursor.execute("SELECT balance FROM account_data WHERE id=%s", (account_id,))
                balance = cursor.fetchone()[0]

                # Convert amount to Decimal
                amount_decimal = Decimal(str(amount))

                if balance >= amount_decimal:
                    new_balance = balance - amount_decimal

                    # Update balance
                    cursor.execute("UPDATE account_data SET balance = %s WHERE id=%s", (float(new_balance), account_id))

                    # Record transaction
                    transaction_date = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                    cursor.execute("""
                        INSERT INTO transactions (source_id, destination_id, amount, transaction_date, balance_after_transaction) 
                        VALUES (%s, %s, %s, %s, %s)
                    """, (account_id, account_id, float(-amount_decimal), transaction_date, float(new_balance)))

                    conn.commit()
                    messagebox.showinfo("Success", f"Withdrew ${amount:.2f} successfully!")
                else:
                    messagebox.showerror("Error", "Insufficient balance!")
            except mysql.connector.Error as err:
                messagebox.showerror("Database Error", f"An error occurred: {err}")
            finally:
                if conn.is_connected():
                    cursor.close()
                    conn.close()
                refresh_accounts()
    else:
        messagebox.showwarning("No Selection", "Please select an account to withdraw from.")

# Transfer Function
def transfer():
    selected_item = grid_frame.selection()
    if selected_item:
        source_id = grid_frame.item(selected_item, "values")[0]  # Get source account ID
        destination_id = simpledialog.askinteger("Transfer", "Enter Destination Account ID:")
        if destination_id:
            amount = simpledialog.askfloat("Transfer", "Enter Amount to Transfer:")
            if amount is not None and amount > 0:
                try:
                    conn = connect_db()
                    cursor = conn.cursor()

                    # Check if the destination account exists
                    cursor.execute("SELECT id FROM account_data WHERE id=%s", (destination_id,))
                    if cursor.fetchone():
                        # Check if the source account has sufficient balance
                        cursor.execute("SELECT balance FROM account_data WHERE id=%s", (source_id,))
                        source_balance = cursor.fetchone()[0]

                        # Convert amount to Decimal
                        amount_decimal = Decimal(str(amount))

                        if source_balance >= amount_decimal:
                            # Deduct from source account
                            source_balance_after = source_balance - amount_decimal
                            cursor.execute("UPDATE account_data SET balance = %s WHERE id=%s", (float(source_balance_after), source_id))

                            # Add to destination account
                            cursor.execute("SELECT balance FROM account_data WHERE id=%s", (destination_id,))
                            destination_balance = cursor.fetchone()[0]
                            destination_balance_after = destination_balance + amount_decimal
                            cursor.execute("UPDATE account_data SET balance = %s WHERE id=%s", (float(destination_balance_after), destination_id))

                            # Record the transaction for the source account (debit)
                            transaction_date = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                            cursor.execute(
                                "INSERT INTO transactions (source_id, destination_id, amount, transaction_date, balance_after_transaction) VALUES (%s, %s, %s, %s, %s)",
                                (source_id, destination_id, float(-amount_decimal), transaction_date, float(source_balance_after))
                            )

                            # Record the transaction for the destination account (credit)
                            cursor.execute(
                                "INSERT INTO transactions (source_id, destination_id, amount, transaction_date, balance_after_transaction) VALUES (%s, %s, %s, %s, %s)",
                                (source_id, destination_id, float(amount_decimal), transaction_date, float(destination_balance_after))
                            )

                            conn.commit()
                            messagebox.showinfo("Success", f"Transferred ${amount:.2f} successfully!")
                        else:
                            messagebox.showerror("Error", "Insufficient balance!")
                    else:
                        messagebox.showerror("Error", "Destination account does not exist!")
                except mysql.connector.Error as err:
                    messagebox.showerror("Database Error", f"An error occurred: {err}")
                finally:
                    if conn.is_connected():
                        cursor.close()
                        conn.close()
                    refresh_accounts()
    else:
        messagebox.showwarning("No Selection", "Please select an account to transfer from.")

# View Transactions Function
def view_transactions():
    selected_item = grid_frame.selection()
    if selected_item:
        account_id = grid_frame.item(selected_item, "values")[0]
        try:
            conn = connect_db()
            cursor = conn.cursor()
            cursor.execute("""
                SELECT source_id, destination_id, amount, transaction_date, balance_after_transaction
                FROM transactions
                WHERE source_id = %s OR destination_id = %s
                ORDER BY transaction_date DESC
            """, (account_id, account_id))
            transactions = cursor.fetchall()

            if transactions:
                # Create a new window for transaction history
                transaction_window = tk.Toplevel(root)
                transaction_window.title("Transaction History")
                transaction_window.geometry("900x400")

                # Create a Treeview widget for the transaction table
                transaction_tree = ttk.Treeview(transaction_window, columns=("Type", "Source ID", "Destination ID", "Amount", "Date", "Balance After"), show="headings")
                transaction_tree.heading("Type", text="Type")
                transaction_tree.heading("Source ID", text="Source ID")
                transaction_tree.heading("Destination ID", text="Destination ID")
                transaction_tree.heading("Amount", text="Amount")
                transaction_tree.heading("Date", text="Date")
                transaction_tree.heading("Balance After", text="Balance After")

                # Set column widths
                transaction_tree.column("Type", width=100, anchor=tk.CENTER)
                transaction_tree.column("Source ID", width=100, anchor=tk.CENTER)
                transaction_tree.column("Destination ID", width=100, anchor=tk.CENTER)
                transaction_tree.column("Amount", width=150, anchor=tk.CENTER)
                transaction_tree.column("Date", width=200, anchor=tk.CENTER)
                transaction_tree.column("Balance After", width=150, anchor=tk.CENTER)

                # Insert transaction data into the Treeview
                for transaction in transactions:
                    source_id, destination_id, amount, transaction_date, balance_after = transaction

                    # Determine the transaction type
                    if source_id == destination_id:
                        if amount > 0:
                            transaction_type = "Deposit"
                        else:
                            transaction_type = "Withdrawal"
                    else:
                        transaction_type = "Transfer"

                    # Insert the transaction into the Treeview
                    transaction_tree.insert("", tk.END, values=(transaction_type, source_id, destination_id, amount, transaction_date, balance_after))

                # Add a scrollbar
                scrollbar = ttk.Scrollbar(transaction_window, orient=tk.VERTICAL, command=transaction_tree.yview)
                transaction_tree.configure(yscroll=scrollbar.set)
                scrollbar.pack(side=tk.RIGHT, fill=tk.Y)

                # Pack the Treeview
                transaction_tree.pack(fill=tk.BOTH, expand=True)
            else:
                messagebox.showinfo("Transaction History", "No transactions found for this account.")
        except mysql.connector.Error as err:
            messagebox.showerror("Database Error", f"An error occurred: {err}")
        finally:
            if conn.is_connected():
                cursor.close()
                conn.close()
    else:
        messagebox.showwarning("No Selection", "Please select an account to view transactions.")

# Create transactions table on startup
create_transactions_table()

root.mainloop()