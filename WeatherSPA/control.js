
function onlocation() {
    fetch("http://localhost:8000/api/weather", {
        method : "POST",
        mode: 'cors',
        body: new URLSearchParams(new FormData(document.getElementById("weatherForm"))),
    })
    .then((response) => {
        if (!response.ok) {
            throw new Error(response.error)
        }
        return response.json();
    })
    .then(data => {
        document.getElementById('name').innerHTML = data.name;
        var weather = data.weather[0];
        document.getElementById('weathermain').innerHTML = weather.main;
        seticon(weather.icon);
    })
    .catch(function(error) {
        document.getElementById('weathermain').innerHTML = error;
    });
}

function seticon(icon) {
    document.getElementById("icon").src = "http://openweathermap.org/img/wn/" + icon + "@4x.png";
}

seticon("10d");