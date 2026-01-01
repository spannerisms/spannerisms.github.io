function addNotes() {
	var footnotes = document.getElementById("footnoteslist");

	var j = 1;

	for (const footnoteX of footnotes.children) {
		var footId = footnoteX.id;
		if (footId === null) continue;

		footnoteX.setAttribute("footid", j);

		var footRefs = document.querySelectorAll('[href="#' + footId + '"]');

		var backlinks = j + ". ";
	   
	  	for (var k = 0; k < footRefs.length; k++) {
			var fanchor = "fn-" + j + "-" + "k"
			footRefs[k].setAttribute("footid", j);
			footRefs[k].innerHTML = "[" + j + "]";
			footRefs[k].setAttribute("id", fanchor);
			backlinks += '<a href="#' + fanchor + '">&crarr;</a> '
		}

		footnoteX.innerHTML = backlinks + footnoteX.innerHTML;
		j++;
	}
}

document.addEventListener('DOMContentLoaded', function() {
	addNotes();
});