estadosECidades = [];
var app = {
    // Application Constructor
    initialize: function() {
        this.bindEvents();
    },
    // Bind Event Listeners
    //
    // Bind any events that are required on startup. Common events are:
    // 'load', 'deviceready', 'offline', and 'online'.
    bindEvents: function() {
        document.addEventListener('deviceready', this.onDeviceReady, false);
    },
    // deviceready Event Handler
    //
    // The scope of 'this' is the event. In order to call the 'receivedEvent'
    // function, we must explicitly call 'app.receivedEvent(...);'
    onDeviceReady: function() {
        app.receivedEvent('deviceready');
    },
    // Update DOM on a Received Event
    receivedEvent: function(id) {
        var parentElement = document.getElementById(id);
        var listeningElement = parentElement.querySelector('.listening');
        var receivedElement = parentElement.querySelector('.received');

        listeningElement.setAttribute('style', 'display:none;');
        receivedElement.setAttribute('style', 'display:block;');

        console.log('Received Event: ' + id);
    }
};
function localizacaoOK() {
    $("#geolocation").html('Dist&acirc;ncia m&aacute;xima de voc&ecirc; at&eacute; os cinemas:');
    $("#blockmap").html('<center><select class="form-control selectwidthauto" name="distmaxima"><option value="10">10km</option><option value="15">15km</option><option value="200">200km</option><option value="300">300km</option></select></center>');
    $("#btnContinuar").css("display", "none");
    $("#submit-button").css("display", "block");
}
function pesquisaEstados() {
    var xmlhttp = new XMLHttpRequest();
    var url = "http://10.49.6.162:3000/estado/";
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            var myArr = JSON.parse(xmlhttp.responseText);
            console.log(myArr.json);
            var retorno = myArr.json;
            for (var i = 0; i < retorno.length; i++) {
                estadosECidades[i] = [];
                estadosECidades[i][0] = retorno[i];
                var idestado = estadosECidades[i][0].idestado;
                pesquisaCidades(i, idestado);
            }
            popularSelectEstado();
        }
        
    };
    xmlhttp.open("GET", url, true);
    xmlhttp.send();
    
}
function pesquisaCidades(i, idestado) {
    var xmlhttp = new XMLHttpRequest();
    var url = "http://10.49.6.162:3000/cidade/"+idestado;
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            var myArr = JSON.parse(xmlhttp.responseText);
            var retorno = myArr.json;
            for (var a = 0; a < retorno.length; a++) {
                estadosECidades[i][a+1] = retorno[a];
            }
            popularSelectCidade(0);
        }
    };
    xmlhttp.open("GET", url, true);
    xmlhttp.send();
}
function popularSelectEstado() {
    document.getElementById("selectEstado").innerHTML = '';
    for (var i = 0; i < estadosECidades.length; i++) {
        document.getElementById("selectEstado").innerHTML += '<option value="'+estadosECidades[i][0].idestado+'">'+estadosECidades[i][0].siglaEstado+'</option>';
    }
}
function popularSelectCidade(i) {
    document.getElementById("selectCidade").innerHTML = '';
    for (var a = 1; a < estadosECidades[i].length; a++) {
        document.getElementById("selectCidade").innerHTML += '<option value="'+estadosECidades[i][a].idcidade+'">'+estadosECidades[i][a].cidade+'</option>';
    }
}
function atualizarSelectCidade(idestado) {
    document.getElementById("selectCidade").innerHTML = '';
    for (var i = 0; i < estadosECidades.length; i++) {
        if (estadosECidades[i][0].idestado == idestado) {
            for (var a = 1; a < estadosECidades[i].length; a++) {
                document.getElementById("selectCidade").innerHTML += '<option value="'+estadosECidades[i][a].idcidade+'">'+estadosECidades[i][a].cidade+'</option>';
            }
        }
    }
}
function getUrlVars() {
    var vars = {};
    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
        vars[key] = value;
    });
    return vars;
}
function buscarPorCidade() {
    
}
function distanciaEntrePontos(latitude1, longitude1, latitude2, longitude2) {
    var raioDaTerra = 6371;
    latitude1 = latitude1 * Math.PI / 180;
    longitude1 = longitude1 * Math.PI / 180;
    latitude2 = latitude2 * Math.PI / 180;
    longitude2 = longitude2 * Math.PI / 180;
    var distLatitudes = latitude2 - latitude1;
    var distLongitudes = longitude2 - longitude1;
    var a = Math.sin(distLatitudes / 2) * Math.sin(distLatitudes / 2) + Math.cos(latitude1) * Math.cos(latitude2) * Math.sin(distLongitudes / 2) * Math.sin(distLongitudes / 2);
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return Math.round(raioDaTerra * c * 1000);
}
cinemasAprovados = [];
filmesEmCinemas = [];
generos = [[12, 'Aventura'], [14, 'Fantasia'], [16, 'Anima��o'], [18, 'Drama'], [27, 'Terror'], [28, 'A��o'], [35, 'Com�dia'], [36, 'Hist�ria'], [37, 'Faroeste'], [53, 'Thriller'], [80, 'Crime'], [99, 'Document�rio'], [878, 'Fic��o cient�fica'], [9648, 'Mist�rio'], [10402, 'M�sica'], [10749, 'Romance'], [10751, 'Fam�lia'], [10752, 'Guerra'], [10770, 'Cinema TV']];
ajaxAgora = 0;
retorno;
informacoes;
tamanho;
copiaCinemasAprovados = [];
cinemas;
function buscarInformacoes() {
    informacoes = getUrlVars();
    if (informacoes["latitude"] != "") {
        //Procurar por localiza��o
        //alert(informacoes["latitude"]+'<br>'+informacoes["longitude"]+'<br>'+'-5.8104571', '-35.2086688');
        var xmlhttp = new XMLHttpRequest();
        var url = "http://10.49.6.162:3000/localizacao/";
        xmlhttp.onreadystatechange = function() {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var myArr = JSON.parse(xmlhttp.responseText);
                retorno = myArr.json;
                cinemas = JSON.parse(JSON.stringify(retorno));
                tamanho = retorno.length;
                verDistanciaCinema();
            }
        };
        xmlhttp.open("GET", url, true);
        xmlhttp.send();
    } else {
        //Procurar por cidade
        
    }
}
function verDistanciaCinema() {
    //alert(retorno.length);
    if (distanciaEntrePontos(informacoes["latitude"], informacoes["longitude"], retorno[0].latitude, retorno[0].longitude) <= informacoes["distmaxima"] * 1000) {
        //alert("T� aqui");
        var requestGoogle = new XMLHttpRequest();
        var url = 'https://maps.googleapis.com/maps/api/distancematrix/json?origins='+informacoes["latitude"]+','+informacoes["longitude"]+'&destinations='+retorno[0].latitude+','+retorno[0].longitude+'&language=pt-BR&key=AIzaSyBXluJ5mRYjycCycD0qVU1M_mvavsC1r1w';
        requestGoogle.onreadystatechange = function() {
            if (requestGoogle.readyState == 4 && requestGoogle.status == 200) {
                //alert("T� nesse lugar");
                distancia = JSON.parse(requestGoogle.responseText).rows[0].elements[0].distance;
                if (distancia.value <= informacoes["distmaxima"] * 1000) {
                    //alert(distancia.value+': Cinema '+(tamanho - retorno.length + 1)+" aprovado");
                    var lista = [retorno[0].idcinema, distancia.text];
                    cinemasAprovados.push(lista);
                    //alert("Tanmanho: "+cinemasAprovados.length);
                    //alert("T� nesse canto");
                    //alert("Ajax Agora: "+ajaxAgora);
                } else{
                    //alert(distancia.value+': reprovada1');
                }
                retorno.shift();
                proximoLoopDistanciaCinema();
            }
        };
        requestGoogle.open("GET", url, true);
        requestGoogle.send();
    } else {
        //alert("T� acul�");
        var distancia = distanciaEntrePontos(informacoes["latitude"], informacoes["longitude"], retorno[0].latitude, retorno[0].longitude);
        //alert(distancia.value+': reprovada2');
        retorno.shift();
        proximoLoopDistanciaCinema();
    }
}
function proximoLoopDistanciaCinema() {
    if (retorno.length != 0) {
        verDistanciaCinema();
    } else {
        copiaCinemasAprovados = JSON.parse(JSON.stringify(cinemasAprovados));
        ligarCinemaComFilmes();
    }
}

function ligarCinemaComFilmes() {
    //alert("Eu t� aqui e o tamanho da array � "+copiaCinemasAprovados.length);
        var requestFilmes = new XMLHttpRequest();
        var url = 'http://10.49.6.162:3000/filme/'+copiaCinemasAprovados[0][0];
        requestFilmes.onreadystatechange = function() {
            if (requestFilmes.readyState == 4 && requestFilmes.status == 200) {
                //alert("Deu certo!");
                var filmes = JSON.parse(requestFilmes.responseText).json;
                inserirFilmes(filmes);
                cinemasAprovados[indexCinema()][2] = [];
                for (var d = 0; d < filmes.length; d++) {
                    //alert(d);
                    //alert(index);
                    cinemasAprovados[indexCinema()][2][d] = filmes[d].idfilme;
                    //alert(cinemasAprovados[indexCinema()][2][d]);
                }
                copiaCinemasAprovados.shift();
                //alert("Tamanho: "+cinemasAprovados.length);
                proximoLoopLigarCinemasComFilmes();
            }
        };
        requestFilmes.open("GET", url, true);
        requestFilmes.send();
}
function indexCinema() {
    return (cinemasAprovados.length) - (copiaCinemasAprovados.length);
}
function proximoLoopLigarCinemasComFilmes() {
    if (copiaCinemasAprovados.length != 0) {
        ligarCinemaComFilmes();
    } else {
        $("#telaCarregando").css("display", "none");
        $("#TelaApp").css("display", "block");
        $("#resultados").html(JSON.stringify(cinemasAprovados) + JSON.stringify(filmesEmCinemas));
        popularCinemas();
        //alert(cinemasAprovados.length);
        //$("#txtCinemas").val(JSON.stringify(cinemasAprovados));
        
        //document.forms["form"].submit();
    }
}
function inserirFilmes(filmes) {
    for (var i = 0; i < filmes.length; i++) {
        var filmeRegistrado = false;
        for (var a = 0; a < filmesEmCinemas.length; a++) {
            if (filmesEmCinemas[a][0] == filmes[i].idfilme) {
                filmeRegistrado == true;
                break;
            }
        }
        if (!filmeRegistrado) {
            filmesEmCinemas.push([filmes[i].idfilme, filmes[i].avaliacao, filmes[i].nomeDoFilme, filmes[i].classifEtaria, filmes[i].sinopse, filmes[i].imagem, filmes[i].generos.split(", ")]);
        }
    }
}

function popularCinemas() {
    var cinema;
    var idcinemas =[];
    
    alert("T� aqui!");
    for (var i = 0; i < cinemasAprovados.length; i++) {
        idcinemas.push(cinemasAprovados[i][0]);
        //alert('i: '+i);
        for (var a = 0; a < cinemas.length; a++) {
            //alert('a: '+a);
            //alert(JSON.stringify(cinemas[a]));
            if (cinemas[a].idcinema == cinemasAprovados[i][0]) {
                cinema = cinemas[a];
            }//alert('Aqui:'+cinema.idcinema+' - '+cinema.nome);
            break;
        }
        //alert(cinema.idcinema+' - '+cinema.nome);
        document.getElementById("SelectCinema").innerHTML += '<option value="'+cinema.idcinema+'">'+cinema.nome+'</option>';
    }
    popularFilmes(idcinemas);
}
function popularFilmes(idcinemas) {
    var filmes = [];
    alert(JSON.stringify(idcinemas));
    var d;
    for (var c = 0; c < idcinemas.length; c++) {
        for (d = 0; d < cinemasAprovados.length; d++) {
            if (cinemasAprovados[d][0] == idcinemas[c]) {
                d = cinemasAprovados[d][2];
                break;
            }
        }
        alert(d);
        for (var b = 0; b < d.length; b++) {
            //alert('E aqui!');
            //alert ('IndexOf: '+filmes.indexOf(d[b]));
            if (filmes.indexOf(d[b]) == -1) {
                //alert('IdFilme: '+d[b]);
                filmes.push(d[b]);
            } else {
                //alert ('IndexOf: '+filmes.indexOf(d[b]));
            }
        }
    }
    alert(JSON.stringify(filmes));
    for (var e = 0; e < filmes.length; e++) {
        for (var f = 0; f < filmesEmCinemas.length; f++) {
            if (filmesEmCinemas[f][0] == filmes[e]) {
                document.getElementById("SelectFilmes").innerHTML += '<option value="'+filmes[e]+'">'+filmesEmCinemas[f][2]+'</option>';
                break;
            }
        }
    }
    for (var e = 0; e < filmes.length; e++) {
        for (var f = 0; f < filmesEmCinemas.length; f++) {
            if (filmesEmCinemas[f][0] == filmes[e]) {
                document.getElementById("SelectFilmes").innerHTML += '<option value="'+filmes[e]+'">'+filmesEmCinemas[f][2]+'</option>';
                break;
            }
        }
    }

}
/*
                for (d = 0; d < filmesEmCinemas.length; d++) {
                    if (filmesEmCinemas[d].idfilme == filmes[b]) {
                        d = filmesEmCinemas[d].nomeDoFilme;
                        break;
                    }
                }
 
 
 
 
 * 
 *         alert('i: '+i);
        for (var a = 0; a < cinemas.length; a++) {
            alert('a: '+a);
            alert(JSON.stringify(cinemas[a]));
            if (cinemas[a].idcinema == cinemasAprovados[i][0]) {cinema = cinemas[a];alert('Aqui:'+cinema.idcinema+' - '+cinema.nome);}
        alert(cinema.idcinema+' - '+cinema.nome);
        document.getElementById("SelectCinema").innerHTML += '<option value="'+cinema.idcinema+'">'+cinema.nome+'</option>';
    }
    function modelarbanco(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS estado (idestado INTEGER PRIMARY KEY NOT NULL, siglaEstado TEXT NOT NULL)');
        tx.executeSql('CREATE TABLE IF NOT EXISTS cidade (idcidade INTEGER PRIMARY KEY NOT NULL, nomeCidade TEXT NOT NULL, idestado INTEGER NOT NULL, FOREIGN KEY(idestado) REFERENCES estado(idestado))');
        tx.executeSql('CREATE TABLE IF NOT EXISTS endereco (idendereco INTEGER PRIMARY KEY NOT NULL, bairro TEXT NOT NULL, logradouro TEXT NOT NULL, numero INTEGER NOT NULL, idcidade INTEGER NOT NULL, FOREIGN KEY(idcidade) REFERENCES cidade(idcidade))');
        tx.executeSql('CREATE TABLE IF NOT EXISTS cinema (idcinema INTEGER PRIMARY KEY NOT NULL, nomeCinema TEXT NOT NULL, latitude TEXT NOT NULL, longitude TEXT NOT NULL, telefone TEXT NOT NULL, idendereco INTEGER NOT NULL, FOREIGN KEY(idendereco) REFERENCES endereco(idendereco))');
        tx.executeSql('CREATE TABLE IF NOT EXISTS filme (idfilme INTEGER PRIMARY KEY NOT NULL, avaliacao DOUBLE NOT NULL, nomeDoFilme TEXT NOT NULL, classificacaoEtaria INTEGER NOT NULL, sinopse TEXT NOT NULL, diretor TEXT NOT NULL, elenco TEXT NOT NULL)');
        tx.executeSql('CREATE TABLE IF NOT EXISTS genero (idgenero INTEGER PRIMARY KEY NOT NULL, nomeGenero TEXT NOT NULL)');
        tx.executeSql('CREATE TABLE IF NOT EXISTS filme_genero (idfilme INTEGER NOT NULL, idgenero INTEGER NOT NULL, FOREIGN KEY(idfilme) REFERENCES filme(idfilme), FOREIGN KEY(idgenero) REFERENCES genero(idgenero)');
    }
    function errobanco(err) {
        alert("Error processing SQL: "+err.code);
    }
    function sucessobanco() {
        alert("Sucesso!");
    }
 */