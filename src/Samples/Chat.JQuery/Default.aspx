﻿<%@ Page %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>AspComet chat sample</title>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js" type="text/javascript"></script>
		<script src="lib/json2.js" type="text/javascript"></script>
		<script src="lib/jquery.comet.js" type="text/javascript"></script>
		<script type="text/javascript" language="javascript">

			$(document).ready(function() {
				var name = window.prompt('Enter your nick name:');

				$.comet.init('/comet.axd');

				$.comet.subscribe('/chat', function(comet) {
					$('<li>' + (comet.data.sender || 'System') + ': ' + comet.data.message + '</li>').
						appendTo('#messages').css({ fontStyle: comet.data.sender ? 'none' : 'italic' });
				});

				$.comet.publish('/chat', { message: name + ' has joined the chat!' });

				$('#entry').submit(function() {
					$.comet.publish('/chat', { sender: name, message: $('#message').val() });
					$('#message').focus().val('');
					return false;
				});

				$('#message').focus();
			});

		</script>
		<style type="text/css">
		
		* { margin: 0; padding: 0; }
		body { height: 100%; font: 75% Arial, Helvetica, sans-serif; }
		ul#messages { position: absolute; bottom: 0; top:0; left: 0; right: 0; margin: 0 0 32px 0; padding: 5px; overflow: auto; background: #eee; list-style-type: none; }
		form#entry { height: 22px; position: absolute; bottom: 0; left: 0; width: 100%; padding: 5px 0; background: #ddd; }
		form#entry input { margin: 0 0 0 5px; }
		input#message { width: 30em; }
		
		</style>
	</head>
	<body>
		<ul id="messages">
		</ul>
		
		<form id="entry" action="">
			<input type="text" id="message" />
			<input type="submit" value="&raquo;" />
		</form>
	</body>
</html>
