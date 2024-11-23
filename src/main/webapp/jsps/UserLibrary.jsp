<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.lib.BookRequest" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Library</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9; /* Light background */
        }

        /* Header styling */
        header {
            background-color: #4CAF50; /* Green header */
            padding: 15px 20px;
            color: white;
            text-align: right;
            font-size: 1.2rem;
            font-weight: bold;
        }

        header a {
            color: white;
            text-decoration: none;
            padding: 0 15px;
        }

        header a:hover {
            text-decoration: underline;
        }

        /* Footer styling */
        footer {
            background-color: #4CAF50; /* Green footer */
            padding: 15px;
            color: white;
            text-align: center;
            font-size: 1rem;
            position: fixed;
            width: 100%;
            bottom: 0;
        }

        /* Book cards grid layout */
        .container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); /* Responsive grid */
            gap: 20px;
            padding: 20px;
            box-sizing: border-box; /* Ensure padding doesn't affect layout */
        }

        /* Individual book card styling */
        .book-card {
            border: 1px solid #ddd;
            border-radius: 10px; /* Rounded corners */
            padding: 15px;
            text-align: center;
            background: linear-gradient(145deg, #ffffff, #f2f2f2); /* Subtle gradient */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Card shadow */
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .book-card:hover {
            transform: scale(1.05); /* Slight zoom on hover */
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2); /* Enhanced shadow */
        }

        .book-card h3 {
            font-size: 1.4rem;
            color: #333;
            margin-bottom: 10px;
        }

        .book-card p {
            font-size: 1rem;
            color: #666;
        }

        /* Button styling */
        .container button {
            padding: 12px 20px;
            background: linear-gradient(90deg, #2196F3, #21CBF3); /* Cool blue gradient */
            border: none;
            border-radius: 10px; /* Rounded edges */
            color: white;
            font-size: 1rem;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .container button:hover {
            background: linear-gradient(90deg, #1E88E5, #1EAAF5); /* Darker hover gradient */
            transform: translateY(-3px);
            box-shadow: 0 6px 10px rgba(0, 0, 0, 0.2);
        }

        .container button:active {
            transform: translateY(0);
            box-shadow: 0 3px 5px rgba(0, 0, 0, 0.2);
        }

        /* Input styling */
        .container input {
            padding: 10px;
            margin: 5px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            width: calc(100% - 22px);
        }
        .header {
            display: flex;
            justify-content: center;
        }

        .header a{
            display: flex;
            justify-content: center;
            align-items: center;

            font-size: 30px;

        }

        .header h1{
            flex: 1;
            text-align: center;
        }


    </style>

</head>
<body>

<!-- Header -->
<header class="header">
    <h1>Your Library</h1>
    <a href="/WTLibb/userHome" style="color:white; text-decoration:none;">Home</a>
</header>

<!-- Book List -->
<div class="container">
    <%
    List<BookRequest> books = (List<BookRequest>) request.getAttribute("books");
    if (books != null && !books.isEmpty()) {
    for (BookRequest book : books) {
    %>
    <div class="book-card">
        <h3><%=book.getName()%></h3>
        <p>Genre: <%=book.getGenre()%></p>

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
    } else {
    %>
    <h3 style="text-align:center;">No books found in your library.</h3>
    <%
    }
    %>
</div>

<!-- Footer -->
<footer>
    <p>&copy; 2024 Library Management System</p>
</footer>

</body>
</html>
