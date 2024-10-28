<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <style>
        /* Basic CSS styles */
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .table-wrapper {
            background: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .table-title {
            margin: -20px -20px 10px;
            padding: 16px;
            background: #007bff;
            color: #fff;
            border-radius: 5px 5px 0 0;
        }
        .table-title h2 {
            margin: 0;
        }
        .btn {
            padding: 8px 12px;
            color: #fff;
            background: #28a745;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn-danger {
            background: #dc3545;
        }
        .table {
            width: 100%;
            border-collapse: collapse;
        }
        .table th, .table td {
            padding: 12px;
            border: 1px solid #e9e9e9;
            text-align: left;
        }
        .modal {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1050;
            overflow: auto;
        }
        .modal-dialog {
            max-width: 400px;
            margin: 100px auto;
            background: #fff;
            border-radius: 5px;
            padding: 20px;
        }
    </style>
</head>
<body>
<div class="table-wrapper">
    <div class="table-title">
        <h2>User Management</h2>
        <button class="btn" onclick="openModal('addUserModal')">Add New User</button>
    </div>
    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Identification Document</th>
            <th>Nationality</th>
            <th>Registration Date</th>
            <th>Account Expiration Date</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="user" items="${users}">
            <tr>
                <td>${user.id}</td>
                <td>${user.firstName}</td>
                <td>${user.lastName}</td>
                <td>${user.identificationDocument}</td>
                <td>${user.nationality}</td>
                <td>${user.registrationDate}</td>
                <td>${user.accountExpirationDate}</td>
                <td>
                    <button onclick="openModal('editUserModal', '${user.id}', '${user.firstName}', '${user.lastName}', '${user.identificationDocument}', '${user.nationality}', '${user.registrationDate}', '${user.accountExpirationDate}')">
                        <i class="material-icons">edit</i>
                    </button>
                    <button onclick="openModal('deleteUserModal', '${user.id}')">
                        <i class="material-icons">delete</i>
                    </button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- Add User Modal -->
<div id="addUserModal" class="modal">
    <div class="modal-dialog">
        <form action="<c:url value='/users' />" method="post">
            <h4>Add User</h4>
            <input type="text" name="firstName" placeholder="First Name" required><br>
            <input type="text" name="lastName" placeholder="Last Name" required><br>
            <input type="text" name="identificationDocument" placeholder="Identification Document" required><br>
            <input type="text" name="nationality" placeholder="Nationality" required><br>
            <input type="text" name="registrationDate" placeholder="Registration Date" required><br>
            <input type="text" name="accountExpirationDate" placeholder="Account Expiration Date" required><br>
            <button type="button" onclick="closeModal('addUserModal')">Cancel</button>
            <button type="submit">Add</button>
        </form>
    </div>
</div>

<!-- Edit User Modal -->
<div id="editUserModal" class="modal">
    <div class="modal-dialog">
        <form id="editUserForm" action="" method="post">
            <h4>Edit User</h4>
            <input type="hidden" id="editUserId" name="id">
            <input type="text" id="editFirstName" name="firstName" placeholder="First Name" required><br>
            <input type="text" id="editLastName" name="lastName" placeholder="Last Name" required><br>
            <input type="text" id="editIdentificationDocument" name="identificationDocument" placeholder="Identification Document" required><br>
            <input type="text" id="editNationality" name="nationality" placeholder="Nationality" required><br>
            <input type="text" id="editRegistrationDate" name="registrationDate" placeholder="Registration Date" required><br>
            <input type="text" id="editAccountExpirationDate" name="accountExpirationDate" placeholder="Account Expiration Date" required><br>
            <button type="button" onclick="closeModal('editUserModal')">Cancel</button>
            <button type="submit">Save</button>
        </form>
    </div>
</div>

<!-- Delete User Modal -->
<div id="deleteUserModal" class="modal">
    <div class="modal-dialog">
        <h4>Delete User</h4>
        <p>Are you sure you want to delete this user?</p>
        <form id="deleteUserForm" method="post">
            <input type="hidden" id="deleteUserId" name="id">
            <button type="button" onclick="closeModal('deleteUserModal')">Cancel</button>
            <button type="submit" class="btn btn-danger">Delete</button>
        </form>
    </div>
</div>

<script>
    const baseUrl = '<c:url value="/users" />';
    function openModal(modalId, userId = '', firstName = '', lastName = '', identificationDocument = '', nationality = '', registrationDate = '', accountExpirationDate = '') {
        document.getElementById(modalId).style.display = 'block';
        if (modalId === 'editUserModal') {
            document.getElementById('editUserId').value = userId;
            document.getElementById('editFirstName').value = firstName;
            document.getElementById('editLastName').value = lastName;
            document.getElementById('editIdentificationDocument').value = identificationDocument;
            document.getElementById('editNationality').value = nationality;
            document.getElementById('editRegistrationDate').value = registrationDate;
            document.getElementById('editAccountExpirationDate').value = accountExpirationDate;
        }
        if (modalId === 'deleteUserModal') {
            document.getElementById('deleteUserId').value = userId;
            const form = document.getElementById('deleteUserForm');
            form.action = baseUrl + '/' + userId;
        }
    }

    function closeModal(modalId) {
        document.getElementById(modalId).style.display = 'none';
    }
</script>
</body>
</html>