document.addEventListener("DOMContentLoaded", function(event) {
    const query = getParameterByName(event.target.URL);
    if (query.startsWith("!")) {
        window.location.href = 'https://duckduckgo.com/?q=' + encodeURIComponent(query);
    }
});

// Gets the query parameter from google
function getParameterByName(url) {
    let name = "q";
    name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
    var regex = new RegExp("[\\?&]q=([^&#]*)"),
        results = regex.exec(url);
    return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}
