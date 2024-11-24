<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Contacts</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #2196F3;
            color: white;
            padding: 20px 0;
            text-align: center;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .container {
            width: 60%;
            margin: 50px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        input[type="text"], input[type="submit"] {
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .suggestion-box {
            border: 1px solid #ccc;
            border-radius: 5px;
            max-height: 150px;
            overflow-y: auto;
            margin-top: 10px;
        }
        .suggestion-item {
            padding: 10px;
            border-bottom: 1px solid #eee;
            cursor: pointer;
        }
        .suggestion-item:hover {
            background-color: #f0f0f0;
        }
    </style>
    <script>
        function fetchSuggestions() {
            var query = document.getElementById("search").value;
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "searchSuggestions.jsp?query=" + query, true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    document.getElementById("suggestions").innerHTML = xhr.responseText;
                }
            };
            xhr.send();
        }

        function fillInput(value) {
            document.getElementById("search").value = value;
            document.getElementById("suggestions").innerHTML = "";
        }
    </script>
</head>
<body>
<header>
    <h1>Contact Management System</h1>
</header>

<div class="container">
    <h2>Search Contacts</h2>
    <form action="searchContactsAction.jsp" method="post">
        <label for="search">Enter Name or Phone Number to Search:</label>
        <input type="text" id="search" name="search" onkeyup="fetchSuggestions()" required>
        <div class="suggestion-box" id="suggestions"></div>
        <input type="submit" value="Search">
    </form>
    <br>
    <a href="index.html">Go Back to Home</a>
</div>

</body>
</html>
