function showDialog() {
	var dialog = document.getElementById('mainWindow');
	document.getElementById('showDialog').onclick = function() {
		dialog.show();
	};
}


function closeDialog() {
	var dialog = document.getElementById('mainWindow');
	document.getElementById('startSimulation').onclick = function() {
		dialog.close();
	};
}