window.addEventListener('message', (event) => {
	const item = event.data;
	if (item.type == "Dot") {
		if (item.display) {
  			document.getElementById("dot").style.display = "block"
		} else{
			document.getElementById("dot").style.display = "none"
		}
	}
});