document.addEventListener('DOMContentLoaded', function () {
    // Mendapatkan ID dari URL
    var url = window.location.href;
    var urlParts = url.split('/');
    var idFromURL = urlParts[urlParts.length - 1];

    if (!idFromURL) {
        idFromURL = 'home';
    }

    var dynamicElement = document.getElementById(idFromURL);

    if (idFromURL == 'tingkat_bobot_kriteria' || idFromURL == 'kriteria' || idFromURL == 'subkriteria') {
        dynamicElement.classList.add('navsel');
    } else if (dynamicElement) {
        dynamicElement.classList.remove('collapsed');
    }

    setTimeout(function () {
        var preloaderContainer = document.querySelector('.preloader-container');
        preloaderContainer.style.transform = 'translateY(-100%)';
        setTimeout(function () {
            preloaderContainer.style.display = 'none';
        }, 400);
    }, 400);
});