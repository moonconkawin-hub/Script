<!DOCTYPE html>
<html lang="th">
<head>
  <meta charset="UTF-8">
  <title>MOONCONHUB Key</title>
  <style>
    body {
      background: #111;
      color: white;
      font-family: Arial, sans-serif;
      text-align: center;
      padding-top: 80px;
    }

    .box {
      background: #1e1e1e;
      width: 360px;
      margin: auto;
      padding: 25px;
      border-radius: 15px;
    }

    input {
      width: 90%;
      padding: 12px;
      margin: 10px;
      border-radius: 8px;
      border: none;
      font-size: 16px;
    }

    button {
      width: 95%;
      padding: 12px;
      background: #007bff;
      color: white;
      border: none;
      border-radius: 8px;
      font-size: 16px;
      cursor: pointer;
    }

    #key {
      margin-top: 20px;
      color: #00ff88;
      font-weight: bold;
      word-break: break-all;
    }
  </style>
</head>
<body>

  <div class="box">
    <h2>MOONCONHUB KEY</h2>
    <p>กรอกอีเมลเพื่อรับคีย์</p>

    <input type="email" id="email" placeholder="example@gmail.com">
    <button onclick="generateKey()">รับคีย์</button>

    <div id="key"></div>
  </div>

  <script>
    async function generateKey() {
      const email = document.getElementById("email").value.trim().toLowerCase();

      if (!email) {
        document.getElementById("key").innerText = "กรุณากรอกอีเมล";
        return;
      }

      const text = "MOONCONHUB-" + email;
      const hashBuffer = await crypto.subtle.digest(
        "SHA-256",
        new TextEncoder().encode(text)
      );

      const hashArray = Array.from(new Uint8Array(hashBuffer));
      const hashHex = hashArray
        .map(b => b.toString(16).padStart(2, "0"))
        .join("")
        .toUpperCase();

      const finalKey = "MOONCONHUB-" + hashHex.substring(0, 16);

      document.getElementById("key").innerText = finalKey;
    }
  </script>

</body>
</html>
