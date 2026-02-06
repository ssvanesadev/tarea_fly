<?php
//Hacemos conexión con getenv() y comprobamos que existe
$databaseUrl = getenv('DATABASE_URL');

if (!$databaseUrl) {
    die('DATABASE_URL no está definida');
}

// Parseamos la URL para extraer los componentes
$dbConfig = parse_url($databaseUrl);

// Extraemos los datos necesarios
$host   = $dbConfig['host'];
$user   = $dbConfig['user'];
$pass   = $dbConfig['pass'];
$port   = $dbConfig['port'] ?? 3306; //Puerto por defecto de MySQL
$dbname = ltrim($dbConfig['path'], '/');


// Construimos el DSN (Data Source Name)
$dsn = "mysql:host=$host;port=$port;dbname=$dbname;charset=utf8mb4";

try {
    // Creamos la conexión PDO
    $pdo = new PDO($dsn, $user, $pass, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
    ]);

    echo "<h1>Conexión exitosa a MySQL</h1>";

    // Consultamos la tabla 'users' que crea el script init.sql
    $stmt = $pdo->query("SELECT id, name FROM users");
    $users = $stmt->fetchAll();

    if ($users) {
        echo "<h3>Cuentas de usuarios:</h3><ul>";
        foreach ($users as $row) {
            echo "<li>ID: " . $user['id'] . " - Nombre: " . htmlspecialchars($user['name']) . "</li>";
        }
        echo "</ul>";
    } else {
        echo "<p>No hay usuarios en la tabla.</p>";
    }

} catch (PDOException $e) {
    echo "<h1>Error de conexión</h1>";
    echo "<p>" . $e->getMessage() . "</p>";
}
