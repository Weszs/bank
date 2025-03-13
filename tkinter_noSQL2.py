import tkinter as tk
from tkinter import ttk, messagebox
import mysql.connector

# Database connection
def connect_db():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="somsm123",
        database="mybankbd"
    )

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
root.title("Banking App")
root.geometry("800x500")

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
    grid_frame["columns"] = ("ID", "Account Holder", "Balance")

    grid_frame.column("#0", width=0, stretch=tk.NO)
    grid_frame.column("ID", anchor=tk.W, width=100)
    grid_frame.column("Account Holder", anchor=tk.W, width=200)
    grid_frame.column("Balance", anchor=tk.W, width=150)

    grid_frame.heading("#0", text="", anchor=tk.W)
    grid_frame.heading("ID", text="ID", anchor=tk.W)
    grid_frame.heading("Account Holder", text="Account Holder", anchor=tk.W)
    grid_frame.heading("Balance", text="Balance", anchor=tk.W)

    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("SELECT id, account_holder, balance FROM account_data")
    for row in cursor.fetchall():
        grid_frame.insert("", tk.END, values=row)

    cursor.close()
    conn.close()

# Placeholder functions
def create_account():
    messagebox.showinfo("Create Account", "Feature not implemented yet")
def delete_account():
    messagebox.showinfo("Delete Account", "Feature not implemented yet")
def edit_account():
    messagebox.showinfo("Edit Account", "Feature not implemented yet")
def transfer():
    messagebox.showinfo("Transfer", "Feature not implemented yet")
def withdraw():
    messagebox.showinfo("Withdraw", "Feature not implemented yet")
def deposit():
    messagebox.showinfo("Deposit", "Feature not implemented yet")
def view_transactions():
    messagebox.showinfo("View Transactions", "Feature not implemented yet")

root.mainloop()
