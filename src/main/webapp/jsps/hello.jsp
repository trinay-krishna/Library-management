<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style>
        h2 {
            color: red;
        }
    </style>
</head>
<body>
    <h2 class="hello">
        Hello Route
    </h2>
    <button class="changeH2">Click</button>
<script>
    const btnChange = document.querySelector('.changeH2');
    const h2 = document.querySelector('.hello');

    btnChange.addEventListener('click', () => {
        h2.textContent = "Change";
    });
</script>
</body>
</html>