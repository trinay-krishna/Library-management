<%@ page import="java.util.List" %>
<%@ page import="com.lib.Book" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: space-between;

        }

        header, footer {
            background-color: #4CAF50;
            color: white;
            text-align: center;
            padding: 10px 0;
        }

        .container {
            padding: 20px;
            flex: 1;

        }

        .add-book-button {
            display: block;
            margin: 0 auto 20px auto;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-align: center;
            font-size: 16px;
        }

        .add-book-button:hover {
            background-color: #0056b3;
        }

        .form-popup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            border: 1px solid #ddd;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            z-index: 10;
        }

        .form-popup input[type="text"],
        .form-popup input[type="number"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .form-popup button {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        .form-popup button:hover {
            background-color: #45a049;
        }

        .book-card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 15px;
            margin-bottom: 20px;
        }

        .book-card h3 {
            margin: 0 0 10px 0;
        }

        .edit-button {
            padding: 8px 16px;
            background-color: #f39c12;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .edit-button:hover {
            background-color: #d35400;
        }

        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 5;
        }
    </style>
</head>
<body>

<header>
    <h1>Admin Dashboard</h1>
</header>

<div class="container">
    <!-- Add Book Button -->
    <button class="add-book-button" onclick="openAddBookForm()">Add Book</button>

    <!-- Add Book Form -->
    <div class="form-popup" id="addBookForm">
        <h2>Add Book</h2>
        <form id="addBook" action="/WTLibb/createBook" method="POST">
            <input type="text" id="bookName" name="bookName" placeholder="Book Name" required>
            <input type="text" id="genre" name="genre" placeholder="Genre" required>
            <input type="number" id="quantity" name="quantity" placeholder="Available Quantity" min="1" required>
            <button type="submit">Add Book</button>
        </form>
        <button onclick="closeForm()">Close</button>
    </div>

    <!-- Book Cards -->
    <div id="booksContainer">
        <!-- Example Book -->
        <%
        List<Book> books = (List<Book>) request.getAttribute("books");
        if (books != null && !books.isEmpty()) {
        for (Book book : books) {
        %>
        <div class="book-card">
            <h3>Book Name: <%= book.getName()%></h3>
            <p>Genre: <%= book.getGenre()%></p>
            <p>Available Quantity: <%= book.getAvailableQuantity()%></p>
            <button class="edit-button" onclick="openEditBookForm('<%= book.getName()%>', '<%= book.getGenre()%>', <%= book.getAvailableQuantity()%>, <%=book.getId()%>)">Edit</button>
            <button class="edit-button" onClick="handleDeleteClick(<%=book.getId()%>)">Delete </button>
        </div>
        <% }
        }
        else { %>
        <h1 style="text-align: center;">There are currently no books in the library</h1>
        <% } %>
    </div>


</div>

<!-- Edit Book Form -->
<div class="form-popup" id="editBookForm">
    <h2>Edit Book</h2>
    <form id="editBook" action="/WTLibb/editBook" method="POST">
        <input type="text" id="editBookName" name="bookName" placeholder="Book Name" required>
        <input type="text" id="editGenre" name="genre" placeholder="Genre" required>
        <input type="number" id="editQuantity" name="available_quantity" placeholder="Available Quantity" min="1" required>
        <input type="hidden" id="bookID" name="id">
        <button type="submit">Save Changes</button>
    </form>
    <button onclick="closeForm()">Close</button>
</div>

<!-- Overlay -->
<div class="overlay" id="overlay" onclick="closeForm()"></div>

<footer>
    <p>Admin Dashboard - Library Management System</p>
</footer>

<script>
    // Open Add Book Form
    function openAddBookForm() {
        document.getElementById('addBookForm').style.display = 'block';
        document.getElementById('overlay').style.display = 'block';
    }

    // Open Edit Book Form with Prefilled Data
    function openEditBookForm(name, genre, quantity, id) {
        document.getElementById('editBookName').value = name;
        document.getElementById('editGenre').value = genre;
        document.getElementById('editQuantity').value = quantity;
        document.getElementById('editBookForm').style.display = 'block';
        document.getElementById('overlay').style.display = 'block';
        document.getElementById('bookID').value = id;
    }

    // Close Any Form
    function closeForm() {
        document.getElementById('addBookForm').style.display = 'none';
        document.getElementById('editBookForm').style.display = 'none';
        document.getElementById('overlay').style.display = 'none';
    }

    function handleDeleteClick( id ) {

        fetch("/WTLibb/deleteBook", {
            method: "POST",
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(id),
        }).then(res => res.text()).then(res => window.location.reload());
    }

</script>

</body>
</html>
