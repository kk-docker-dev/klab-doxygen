<!DOCTYPE html>
<html>
<head>
  <title>Doxygen server</title>
  <style>
    body {
      background-color: #ddd;
    }
    h1 {
      padding: 20px;
      text-align: left;
      background-color: lightblue;
      box-shadow: 0px 0px 10px #333;
      font-family: Calibri, sans-serif;
    }
    h2 {
      padding: 0px 20px;
      font-family: Calibri, sans-serif;
    }
    ul {
      list-style: none;
      font-family: Calibri, sans-serif;
    }
    li {
      width: 300px;
      padding: 10px 20px;
      margin: 0px 0px 0px -20px;
      margin-bottom: 10px;
      background-color: #ccc;
      box-shadow: 0px 0px 2px #333;
      font-family: Calibri, sans-serif;
    }
    li a {
      color: #333;
      font-size: 20px;
      font-weight: bold;
      text-decoration: none;
      font-family: Calibri, sans-serif;
    }
    footer {
      padding: 10px;
      margin-top: 20px;
      text-align: right;
      font-family: Calibri, sans-serif;
    }
  </style>
</head>
<body>
  <h1>Klab's Doxygen server</h1>
  <h2>Explore the documentation of below projects:</h2>
  <ul>
    <?php
      $files = scandir(getcwd());
      sort($files);
      foreach ($files as $file) {
        if ($file != '.' && $file != '..' && $file != 'index.php') {
          if (is_dir($file)) {
            echo '<li><a href="'.$file.'">'.$file.'</a></li>';
          } else {
            echo '<li>'.$file.'</li>';
          }
        }
      }
    ?>
  </ul>
  <footer>
    <p>Last update on <?php echo date("M d Y H:i:s"); ?></p>
  </footer>
</body>
</html>
