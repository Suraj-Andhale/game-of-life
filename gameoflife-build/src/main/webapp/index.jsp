<%@ page import="Game.of.life.GameOfLife" %>

<html>
<head>
<title>Game of Life</title>
<style>
body { font-family: Arial; text-align: center; }
button { padding: 10px 20px; font-size: 18px; }
pre { background: #000; color: #0f0; padding: 20px; }
</style>
</head>

<body>

<h1>🔥 Conway's Game of Life</h1>

<form method="post">
<button type="submit">Run Simulation</button>
</form>

<%
if(request.getMethod().equalsIgnoreCase("POST")) {
GameOfLife game = new GameOfLife();

```
java.io.ByteArrayOutputStream baos = new java.io.ByteArrayOutputStream();
java.io.PrintStream ps = new java.io.PrintStream(baos);
java.io.PrintStream old = System.out;

System.setOut(ps);
game.main(null);   // Runs your existing code
System.out.flush();
System.setOut(old);
```

%>

<pre><%= baos.toString() %></pre>

<%
}
%>

</body>
</html>
