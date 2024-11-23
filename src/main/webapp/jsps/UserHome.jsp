<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.lib.BookRequest" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Management - User Home</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f2f5; /* Soft background color */
        }

        header {
            background-color: #4CAF50;
            padding: 15px 20px;
            color: white;
            text-align: right;
            font-size: 1.2rem;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        header a {
            color: white;
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s;
        }

        header a:hover {
            color: #d4f8d4;
        }

        footer {
            background-color: #4CAF50;
            padding: 10px;
            color: white;
            text-align: center;
            position: fixed;
            width: 100%;
            bottom: 0;
        }

        .search-bar {
            padding: 20px;
            text-align: center;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .search-bar input {
            padding: 15px;
            width: 70%;
            font-size: 1.1rem;
            border: 1px solid #ccc;
            border-radius: 30px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: all 0.3s;
        }

        .search-bar input:focus {
            outline: none;
            border-color: #4CAF50;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); /* Adaptive card sizes */
            gap: 20px;
            padding: 20px;
            box-sizing: border-box;
            max-width: 1200px;
            margin: 0 auto; /* Center content */
        }

        .book-card {
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            text-align: center;
            padding: 20px;
            position: relative;
        }

        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }

        .book-card h3 {
            font-size: 1.4rem;
            margin-bottom: 10px;
            color: #333;
        }

        .book-card p {
            color: #777;
            margin: 0 0 10px;
        }

        .container button {
            padding: 12px 20px; /* Adjusted padding for a more balanced look */
            background: linear-gradient(90deg, #4CAF50, #8BC34A); /* Gradient background */
            border: none;
            border-radius: 10px; /* Rounded edges */
            color: white;
            font-size: 1rem;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Subtle shadow */
        }

        .container button:hover {
            background: linear-gradient(90deg, #45a049, #7DBE45); /* Slightly darker gradient on hover */
            transform: translateY(-3px); /* Lift effect */
            box-shadow: 0 6px 10px rgba(0, 0, 0, 0.2); /* Stronger shadow on hover */
        }

        .container button:active {
            transform: translateY(0); /* Reset position when clicked */
            box-shadow: 0 3px 5px rgba(0, 0, 0, 0.2); /* Slightly reduced shadow */
        }

        .container input {
            padding: 10px;
            margin: 5px;
            border-radius: 30px;
            border: 1px solid #ddd;
        }

        .book-card::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, #4CAF50, #8BC34A);
        }
    </style>
</head>
<body>

<!-- Header -->
<header>
    <a href="/WTLibb/userLibrary" style="color:white; text-decoration:none;">Your Library</a>
</header>

<!-- Search Bar -->
<div class="search-bar">
    <input
            type="text"
            id="searchBar"
            placeholder="Search books by name..."
    />
</div>

<!-- Book List -->
<div class="container" id="bookContainer">
    <%
    List<BookRequest> books = (List<BookRequest>) request.getAttribute("books");
    if (books != null) {
    for (BookRequest book : books) {
    %>
    <div class="book-card" data-name="<%=book.getName().toLowerCase()%>">
        <h3><%=book.getName()%></h3>
        <p>Genre: <%=book.getGenre()%></p>

        <% if (book.getStatus() == 0) { %>
        <!-- If book is not borrowed, show Borrow button -->
        <form action="/WTLibb/borrow?id=<%=book.getID()%>" method="POST">
            <input type="hidden" name="bookID" value="<%=book.getID()%>" />
            <button type="submit">Borrow</button>
        </form>
        <% } %>

        <% if (book.getStatus() == 1) { %>
        <!-- If book is borrowed, show Renew and Return buttons -->
        <form action="/WTLibb/renew?id=<%=book.getID()%>" method="POST">
            <input type="hidden" name="bookID" value="<%=book.getID()%>" />
            <button type="submit">Renew</button>
        </form>
        <form action="/WTLibb/return?id=<%=book.getID()%>" method="POST">
            <input type="hidden" name="bookID" value="<%=book.getID()%>" />
            <button type="submit">Return</button>
        </form>
        <% } %>
    </div>
    <%
    }
    }
    %>
</div>

<%
String error = (String) request.getAttribute("error");
if (error != null) { %>
<h1><%= error %></h1>
<% } %>

<!-- Footer -->
<footer>
    <p>&copy; 2024 Library Management System</p>
</footer>

<!-- JavaScript -->
<script>
    // Search functionality
    document.getElementById('searchBar').addEventListener('input', function () {
        const searchQuery = this.value.toLowerCase();
        const bookCards = document.querySelectorAll('.book-card');

        bookCards.forEach(card => {
            const bookName = card.getAttribute('data-name');
            if (bookName.includes(searchQuery)) {
                card.style.display = 'block'; // Show the card if it matches the search query
            } else {
                card.style.display = 'none'; // Hide the card if it doesn't match
            }
        });
    });
</script>

</body>
</html>
