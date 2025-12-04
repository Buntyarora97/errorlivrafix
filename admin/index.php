<?php
session_start();
require_once '../includes/database.php';
require_once '../includes/models/Admin.php';

if (isset($_SESSION['admin_id'])) {
    header('Location: dashboard.php');
    exit;
}

$error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username'] ?? '');
    $password = $_POST['password'] ?? '';

    if (empty($username) || empty($password)) {
        $error = 'Please enter both username and password.';
    } else {
        $admin = Admin::verifyPassword($username, $password);
        if ($admin) {
            $_SESSION['admin_id'] = $admin['id'];
            $_SESSION['admin_username'] = $admin['username'];
            $_SESSION['admin_role'] = $admin['role'];
            header('Location: dashboard.php');
            exit;
        } else {
            $error = 'Invalid username or password.';
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - LIVVRA</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="assets/css/admin.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body.login-page {
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            background: linear-gradient(135deg, #2C3E50 0%, #1A252F 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .login-container { width: 100%; max-width: 420px; margin: 0 auto; }
        .login-box {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
        }
        .login-logo {
            background: linear-gradient(135deg, #2C3E50 0%, #1A252F 100%);
            padding: 40px 30px;
            text-align: center;
            border-bottom: 3px solid #C9A227;
        }
        .login-logo .logo-icon {
            width: 70px; height: 70px;
            background: linear-gradient(135deg, #C9A227, #A88B1F);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 15px;
            box-shadow: 0 8px 25px rgba(201, 162, 39, 0.4);
        }
        .login-logo .logo-icon i { font-size: 2rem; color: #fff; }
        .login-logo h1 { color: #C9A227; font-size: 2rem; font-weight: 700; margin: 0; letter-spacing: 3px; }
        .login-logo p { color: rgba(255, 255, 255, 0.7); font-size: 0.9rem; margin: 8px 0 0; }
        .login-box form { padding: 35px 30px 20px; }
        .login-box .form-group { margin-bottom: 22px; position: relative; }
        .login-box .form-group label { display: none; }
        .login-box .form-group .input-icon {
            position: absolute; left: 15px; top: 50%; transform: translateY(-50%);
            color: #6C757D; font-size: 1rem; z-index: 1;
        }
        .login-box .form-control {
            width: 100%; padding: 14px 15px 14px 45px;
            border: 2px solid #E5E7EB; border-radius: 10px;
            font-size: 1rem; font-family: inherit;
            background: #F8F9FA; transition: all 0.3s ease;
        }
        .login-box .form-control:focus {
            outline: none; border-color: #C9A227; background: #fff;
            box-shadow: 0 0 0 4px rgba(201, 162, 39, 0.15);
        }
        .login-box .btn-primary {
            width: 100%; padding: 14px 20px;
            background: linear-gradient(135deg, #C9A227, #A88B1F);
            color: #fff; border: none; border-radius: 10px;
            font-size: 1rem; font-weight: 600; cursor: pointer;
            text-transform: uppercase; letter-spacing: 1px; margin-top: 10px;
            transition: all 0.3s ease;
        }
        .login-box .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(201, 162, 39, 0.4);
        }
        .login-box .alert {
            margin: 0 30px; padding: 15px 20px;
            background: #F8D7DA; color: #721C24;
            border-radius: 10px; border-left: 4px solid #DC3545;
            display: flex; align-items: center; gap: 10px;
        }
        .login-footer {
            background: #F8F9FA; padding: 20px 30px;
            text-align: center; border-top: 1px solid #E5E7EB;
        }
        .login-footer p { color: #6C757D; font-size: 0.85rem; margin: 0 0 8px; }
        .login-footer .developer-credit { font-size: 0.8rem; color: #6C757D; }
        .login-footer .developer-credit a {
            color: #C9A227; text-decoration: none; font-weight: 500;
        }
        .login-footer .developer-credit a:hover { text-decoration: underline; }
    </style>
</head>
<body class="login-page">
    <div class="login-container">
        <div class="login-box">
            <div class="login-logo">
                <div class="logo-icon">
                    <i class="fas fa-leaf"></i>
                </div>
                <h1>LIVVRA</h1>
                <p>Admin Control Panel</p>
            </div>

            <?php if ($error): ?>
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i>
                <?php echo htmlspecialchars($error); ?>
            </div>
            <?php endif; ?>

            <form method="POST" action="">
                <div class="form-group">
                    <label for="username"><i class="fas fa-user"></i> Username</label>
                    <i class="fas fa-user input-icon"></i>
                    <input type="text" id="username" name="username" class="form-control" placeholder="Enter your username" autocomplete="username" required>
                </div>
                <div class="form-group">
                    <label for="password"><i class="fas fa-lock"></i> Password</label>
                    <i class="fas fa-lock input-icon"></i>
                    <input type="password" id="password" name="password" class="form-control" placeholder="Enter your password" autocomplete="current-password" required>
                </div>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-sign-in-alt"></i> Login to Dashboard
                </button>
            </form>
            
            <div class="login-footer">
                <p>&copy; <?php echo date('Y'); ?> LIVVRA - Dr Tridosha Herbotech</p>
                <p class="developer-credit">Developed by <a href="https://digitaldots.in" target="_blank">Digitaldots</a></p>
            </div>
        </div>
    </div>
</body>
</html>