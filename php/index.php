
<?php
date_default_timezone_set('America/Sao_Paulo');
ini_set('default_charset','UTF-8');
ini_set('max_execution_time', 3600);
error_reporting(E_ALL & ~E_NOTICE);
function buscarHTML($link) {
    $useragent = "Mozilla / 5.0 (Windows NT 6.1) AppleWebKit / 537,36 (KHTML, como Gecko) Chrome / 51.0.2704.103 Safari / 537,36";
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $link);
    curl_setopt($ch, CURLOPT_USERAGENT, $useragent);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_ENCODING, "utf-8");
    $result = curl_exec($ch);
    curl_close($ch);
    return $result;
}
function pregFunction($inicioTag, $finalTag, $string) {
    preg_match_all('/\(\.\*\)/', $inicioTag, $cont, PREG_SET_ORDER);
    $finalTag = str_replace('/', '\/', $finalTag);
    preg_match('/' . $inicioTag . '(.*)' . $finalTag . '/U', $string, $valor);
    return $valor[1 + count($cont)];
}
function pregAllFunction($inicioTag, $finalTag, $string) {
    preg_match_all('/\(\.\*\)/', $inicioTag, $cont, PREG_SET_ORDER);
    $finalTag = str_replace('/', '\/', $finalTag);
    preg_match_all('/' . $inicioTag . '(.*)(?=' . $finalTag . ')/Us', $string, $valor, PREG_SET_ORDER);
    foreach ($valor as &$value) {
        $value = $value[1 + count($cont)];
    }
    return $valor;
}
function separarPorDia($htmlSite, $tipoOrdem, $identificadorTag) {
    //tipoOrdem:
    //0 - Por dia
    //1 - Fixa - (Do dia x atï¿½ o dia y)
    if ($tipoOrdem == 0) {
        $htmlSite .= $identificadorTag;
        $dias = pregAllFunction($identificadorTag, $identificadorTag, $htmlSite);
    }
    return $dias;
}
function separarFilmes($dia, $identificadorTag) {
    $dia .= $identificadorTag;
    return pregAllFunction($identificadorTag, $identificadorTag, $dia);
}
function multiplicarPorHorarios($filmes, $inicioTagHorarios, $finalTagHorarios) {
    $contador = 0;
    $filmesMultiplicados = [];
    $finalTagHorarios = str_replace('/', '\/', $finalTagHorarios);
    for ($z = 0; $z < count($filmes); $z++) {
        preg_match('/' . $inicioTagHorarios . '(.*)' . $finalTagHorarios . '/s', $filmes[$z], $horariocompleto);
        preg_match_all('/' . $inicioTagHorarios . '(.*)' . $finalTagHorarios . '/Us', $filmes[$z], $horarios, PREG_SET_ORDER);
        for ($y = 0; $y < count($horarios); $y++) {
            $filmesMultiplicados[$contador] = str_replace($horariocompleto[0], $horarios[$y][0], $filmes[$z]);
            //echo '<div>' . $filmesMultiplicados[$contador] . '</div>';
            $contador++;
        }
    }
    return $filmesMultiplicados;
}
function acharNomeDoFilme($filme, $inicioTag, $finalTag) {
    return pregFunction($inicioTag, $finalTag, $filme);
}
function acharClassificacaoEtaria($filme, $inicioTag, $finalTag) {
    $classificacao = pregFunction($inicioTag, $finalTag, $filme);
    if ($classificacao != "10" && $classificacao != "12" && $classificacao != "14" && $classificacao != "16" && $classificacao != "18") {
        return 0;
    }
    return (int)$classificacao;
}
function acharTipoExibicao($filme, $inicioTag, $finalTag) {
    return pregFunction($inicioTag, $finalTag, $filme);
}
function verificarSeE3D($filme, $identificador) {
    if (preg_match('/' . $identificador . '/', $filme)) {
        return "true";
    } else {
        return "false";
    }
}
function acharHorario($filme, $inicioTag, $finalTag) {
    preg_match_all('/\(\.\*\)/', $inicioTag, $cont, PREG_SET_ORDER);
    $finalTag = str_replace('/', '\/', $finalTag);
    preg_match('/' . $inicioTag . '(.....)' . $finalTag . '/Us', $filme, $valor);
    $horaParcial =  $valor[1 + count($cont)];
    $hora = str_replace(':', 'h', $horaParcial);
    return $hora;
    
}
//function acharSala($filme, $inicioTag, $finalTag) {
//    return pregFunction($inicioTag, $finalTag, $filme);
//}
function acharExtras($filme, $listaExtras) {
    // Quanto vale cada extra:
    //2^(nï¿½ do extra + 2)
    $retorno = 0;
    $extras = '';
     if ($listaExtras != false) {
        for ($n = 0; $n < count($listaExtras); $n ++) {
            if (preg_match('/' . $listaExtras[$n][1] . '/', $filme)) {
                $retorno += $listaExtras[$n][0];
                if ($extras != '') {
                    $extras .= ', '.$listaExtras[$n][2];
                } else {
                    $extras .= $listaExtras[$n][2];
                }
            }
            
        }
    }
    return [$extras, $retorno];
}
function eMatine($hora, $inicioNoite) {
    $hora = str_replace("h", "", $hora);
    $hora = intval($hora);
    if ($hora < $inicioNoite) {
        return true;
    } else {
        return false;
    }
}
function acharIndicedePrecos($hora, $inicioNoite, $retorno, $filme) {
    if (!eMatine($hora, $inicioNoite)) {
        $retorno += 1;
    }
    if ($filme == "true") {
        $retorno += 2;
    }
    echo "IndicePrecos relativo a Extras: ".$retorno;
    return $retorno;
}
function criarListaDePrecos($listaExpressoes, $listaTipos, $busca) {
    $listaPrecos = [];
    for ($o = 0; $o < count($listaExpressoes); $o++) {
        for ($p = 0; $p < count($listaExpressoes[$o]); $p++) {
            $tipo = $listaTipos[!($o % 2) ? $o/2 : ($o-1)/2];
            $expressao = $listaExpressoes[$o][$p];
            $pesquisa = $tipo.$expressao;
            preg_match_all('/\(\.\*\)/', $pesquisa, $cont, PREG_SET_ORDER);
            preg_match('/'.$pesquisa.'/Us', $busca, $preco);
            $listaPrecos[$o][$p] = $preco[count($cont)];
        }
    }
   return $listaPrecos;
}
function calcularPreco($indice, $listaPrecos, $feriados, $faltaQuantosDias) {
    $data = date('d/m', strtotime('+'.$faltaQuantosDias.' day'));
    $diaSemana = date('N', strtotime('+'.$faltaQuantosDias.' day'));
    $diaSemana --;
    //$diaSemana = date('Y-m-d', strtotime('+1 day');
    if (array_search($data, $feriados) == false) {
        if($diaSemana == 6) {$diaSemana = 5; }
        return $listaPrecos[$indice][$diaSemana];
    } else {
        return $listaPrecos[$indice][5];
    }
}
function cadastrarFilme($nome, $classifEtaria) {
    //Dados para a conexï¿½o com o banco de dados
    echo 1;
    $generos = [];
    $servidor = 'localhost:3306';
    $usuario = 'root';
    $senha = 'root';
    $banco = 'cinemapp_bd';

    //Executa a conexï¿½o com o MySQL
    $link = mysqli_connect($servidor, $usuario, $senha, $banco);
    if (!$link) {
        echo "Nao pï¿½de se conectar ao banco de dados MySQL.<br>";
        echo "Debugging errno: " . mysqli_connect_errno();
        exit;
    }
    mysqli_set_charset($link, 'utf8');
    mysqli_query($link, "SET NAMES utf8");
    mysqli_query($link, "SET CHARACTER_SET utf8");
    
    echo '<br>2';
    //echo '<br>'.$link;

    $sql = 'SELECT idfilme FROM filme WHERE nomeDoFilme = "'.$nome.'"';
    echo '<br>'.$sql;
    $result = mysqli_query($link, $sql);
    if($result)
        echo '<br> select ok!';
    else {
        echo '<br> falha no select!';
    }
    
    if ($tbl = mysqli_fetch_array($result)) {
        echo '<br>nï¿½o vazio';
        $idfilme = $tbl[0];
    } else {
        
        $saida = json_decode(buscarHTML("https://api.themoviedb.org/3/search/movie?api_key=ca07563cc734bc1679ebeb98b0421676&language=pt-BR&include_adult=false&query=".urlencode($nome)));
        $saida = ($saida->results[0]);
        $nomeFilme = $saida->title;
        $sql = 'SELECT idfilme FROM filme WHERE nomeDoFilme = "'.$nomeFilme.'"';
        $result = mysqli_query($link, $sql);
        $imagem = "https://image.tmdb.org/t/p/w300_and_h450_bestv2".$saida->poster_path;
        $sinopse = $saida->overview;
        $idGeneros = $saida->genre_ids;
        $avaliacao = $saida->vote_average;
        $headers =  'MIME-Version: 1.0' . "\r\n"; 
        $headers .= 'From: João Marcos <j-m-lima@hotmail.com>' . "\r\n";
        $headers .= 'Content-type: text/html; charset=utf-8' . "\r\n";
        if ($imagem == "https://image.tmdb.org/t/p/w300_and_h450_bestv2") {
            $imagem = "http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg";
        }
        if ($sinopse == "" || $sinopse == null) {
            $sinopse = "Sem Sinopse Disponível";
        }
        if ($nomeFilme == "") {
            $idGeneros = "[]";
            $nomeFilme = $nome;
            $avaliacao = 0;
            //mail('joao.marcos.lima.14.9@gmail.com', 'Filme sem Informações', 'Estão faltando as seguintes informações: Sinopse, Generos,\nAvaliacao e Imagem.', $headers);
        } else if ($avaliacao == 0) {
            //mail('joao.marcos.lima.14.9@gmail.com', 'Filme sem Informações', 'Estão faltando as seguintes informações: Avaliacao.', $headers);
        }
        if ($tbl = mysqli_fetch_array($result)) {
            echo '<br>nï¿½o vazio';
            $idfilme = $tbl[0];
        } else {
            echo 'vazio';
            
            echo '<br>cheguei no insert';
            echo 'Avaliacao: '.$avaliacao;
            $sql = 'INSERT INTO filme (nomeDoFilme, avaliacao, classificacaoEtaria, sinopse, imagem) VALUES ("'.$nomeFilme.'", '.round($avaliacao, 1).', '.$classifEtaria.', "'.htmlspecialchars($sinopse).'", "'.$imagem.'")';
            echo '<br>'.$sql;
            $result = mysqli_query($link, $sql);
            if ($result) {echo 1.1;} else {echo("<br>Error description: " . mysqli_error($link));echo 1.2;}
            $sql = 'SELECT idfilme FROM filme WHERE nomeDoFilme = "'.$nomeFilme.'"';
            $result = mysqli_query($link, $sql);
            $idfilme = mysqli_fetch_array($result)[0];
            if ($idGeneros != "[]") {
                foreach ($idGeneros as &$value) {
                    $sql = 'INSERT INTO filme_genero (idfilme, idgenero) VALUES ('.$idfilme.', '.$value.')';
                    $result = mysqli_query($link, $sql);
                }
            }
            
        }
        
    }
    mysqli_close($link);
    return $idfilme;
}
function cadastrarLocais($endereco) {
    //Dados para a conexï¿½o com o banco de dados
    echo '<br>Entrou no cadastro de local!';
    $servidor = 'localhost:3306';
    $usuario = 'root';
    $senha = 'root';
    $banco = 'cinemapp_bd';
    //Executa a conexï¿½o com o MySQL
    $link = mysqli_connect($servidor, $usuario, $senha, $banco);
    if (!$link) {
        echo "NÃ£o pode se conectar ao banco de dados MySQL.";
        echo "Debugging errno: " . mysqli_connect_errno();
        exit;
    }
    
    mysqli_query($link, "SET NAMES utf8");
    mysqli_query($link, "SET CHARACTER_SET utf8");
    
    $sql = 'SELECT idcinema FROM cinema WHERE nomeCinema = "'.$endereco[2].'"';
    $result = mysqli_query($link, $sql);
    if ($tbl = mysqli_fetch_array($result)) {
        print_r($tbl);
        $idcinema = $tbl[0];
        echo '<br>Local já existe!';
    } else {
        print_r($tbl);
        echo '<br>Local não existe!';
        $sql = 'SELECT idestado FROM estado WHERE siglaEstado = "'.$endereco[0].'"';
        $result = mysqli_query($link, $sql);
        if ($tbl = mysqli_fetch_array($result)) {
            $idestado = $tbl[0];
        } else {
            echo '<br>Estado não existe!';
            $sql = 'INSERT INTO estado (siglaEstado) VALUES ("'.$endereco[0].'")';
            mysqli_query($link, $sql);
            $sql = 'SELECT idestado FROM estado WHERE siglaEstado = "'.$endereco[0].'"';
            $result = mysqli_query($link, $sql);
            $idestado = mysqli_fetch_array($result)[0];
        }
        $sql = 'SELECT idcidade FROM cidade WHERE (nomeCidade = "'.$endereco[1].'") AND (idestado = "'.$idestado.'")';
        $result = mysqli_query($link, $sql);
        if ($tbl = mysqli_fetch_array($result)) {
            $idcidade = $tbl[0];
        } else {
            echo '<br>Cidade não existe!';
            $sql = 'INSERT INTO cidade (nomeCidade, idestado) VALUES ("'.$endereco[1].'", "'.$idestado.'")';
            mysqli_query($link, $sql);
            $sql = 'SELECT idcidade FROM cidade WHERE nomeCidade = "'.$endereco[1].'"';
            $result = mysqli_query($link, $sql);
            $idcidade = mysqli_fetch_array($result)[0];
        }
        $sql = 'SELECT idendereco FROM endereco WHERE (bairro = "'.$endereco[3].'") AND (logradouro = "'.$endereco[4].'") AND (numero = '.$endereco[5].') AND (idcidade = "'.$idcidade.'")';
        $result = mysqli_query($link, $sql);
        if ($tbl = mysqli_fetch_array($result)) {
            $idendereco = $tbl[0];
        } else {
            echo '<br>Endereço não existe!';
            $sql = 'INSERT INTO endereco (bairro, logradouro, numero, idcidade) VALUES ("'.$endereco[3].'", "'.$endereco[4].'", '.$endereco[5].', "'.$idcidade.'")';
            $result = mysqli_query($link, $sql);
            if ($result) {echo "<br>Cadastro de Local efetuado com sucesso!";} else {echo("<br>Error description: " . mysqli_error($link));}
            $sql = 'SELECT idendereco FROM endereco WHERE logradouro = "'.$endereco[4].'" AND numero = '.$endereco[5].' AND idcidade = "'.$idcidade.'"';
            $result = mysqli_query($link, $sql);
            $idendereco = mysqli_fetch_array($result)[0];
        }
        $sql = 'INSERT INTO cinema (nomeCinema, telefone, idendereco, latitude, longitude) VALUES ("'.$endereco[2].'", "'.$endereco[6].'", "'.$idendereco.'", "'.$endereco[7].'", "'.$endereco[8].'")';
        $result = mysqli_query($link, $sql);
        if (!$result) {
            echo("Error description: " . mysqli_error($link));
        }
        
        $sql = 'SELECT idcinema FROM cinema WHERE nomeCinema = "'.$endereco[2].'"';
        $result = mysqli_query($link, $sql);
        $idcinema = mysqli_fetch_array($result)[0];
        
    }
    mysqli_close($link);
    return $idcinema;
}
function cadastrarSessoes($matriz) {
    $servidor = 'localhost:3306';
    $usuario = 'root';
    $senha = 'root';
    $banco = 'cinemapp_bd';
    
    $link = mysqli_connect($servidor, $usuario, $senha, $banco);
    if (!$link) {
        echo "NÃ£o pÃ´de se conectar ao banco de dados MySQL.";
        echo "Debugging errno: " . mysqli_connect_errno();
        exit;
    }
    
    mysqli_query($link, "SET NAMES utf8");
    mysqli_query($link, "SET CHARACTER_SET utf8");
    
    $sql_remocao = 'DELETE FROM sessao WHERE idcinema = '.$matriz[0][0][1];
    $result = mysqli_query($link, $sql_remocao);
    if (!$result) {
        echo '<br>Nï¿½o deletou';
    } else {
        echo '<br>Deletou';
    }
    for ($i = 0; $i < count($matriz); $i++ ) {
        for ($a = 0; $a < count($matriz[$i]); $a++) {
            
            $sql_insercao = 'INSERT INTO sessao (idfilme, idcinema, tipo_exibicao, e_3d, horario, preco, data, extras) VALUES ('.$matriz[$i][$a][0].', '.$matriz[$i][$a][1].', "'.$matriz[$i][$a][2].'", '.$matriz[$i][$a][3].', "'.$matriz[$i][$a][4].'", "'.$matriz[$i][$a][5].'", "'.$matriz[$i][$a][6].'", "'.$matriz[$i][$a][7].'")';
            echo $sql_insercao;
            $result = mysqli_query($link, $sql_insercao);
            if (!$result) {
                echo '<br>Nï¿½o cadastrou ' . mysqli_error($link);
            } else {
                echo '<br>Cadastrou';
            }
        }
    }
}
function executar($endereco, $link, $organizacaoSite, $identificadorData, $identificadorFilme, $inicioHorario, $finalHorario, $inicioNome, $finalNome, $inicioClassificacao, $finalClassificacao, $inicioExibicao, $finalExibicao, $identificador3d, $listaExtras, $horarioInicioNoite, $listaExpressoes, $listaTipos, $feriados, $codificacao) {
    $busca = buscarHTML($link);
    echo $busca;
    if ($codificacao != "UTF-8") {
        $busca = iconv($codificacao, "UTF-8//TRANSLIT", $busca);
    }
    $dias = separarPorDia($busca, $organizacaoSite, $identificadorData);
    $listaPrecos = criarListaDePrecos($listaExpressoes, $listaTipos, $busca);
    print_r($listaPrecos);
    for ($a = 0; $a < count($dias); $a++) {
        $filmesdia = separarFilmes($dias[$a], $identificadorFilme);
        print_r($filmesdia);
        $filmesdia = multiplicarPorHorarios($filmesdia, $inicioHorario, $finalHorario);
        $dias[$a] = $filmesdia;
        $filmesdia = [];
        echo count($dias[$a]);
        echo 'tÃ´ aqui';
        for ($b = 0; $b < count($dias[$a]); $b++) {
            $extrasSessao = '';
            echo 'tÃ´ ali';
            $nomeDoFilme = acharNomeDoFilme($dias[$a][$b], $inicioNome, $finalNome);
            echo '<br>Nome do Filme: '.$nomeDoFilme.'<br>';
            $clasEtariaDoFilme = acharClassificacaoEtaria($dias[$a][$b], $inicioClassificacao, $finalClassificacao);
            $filmesdia[$b][0] = cadastrarFilme($nomeDoFilme, $clasEtariaDoFilme);
            echo '<br>idFilme: '.$filmesdia[$b][0].'<br>';
            $filmesdia[$b][1] = cadastrarLocais($endereco);
            echo '<br>Local: '.$filmesdia[$b][1].'<br>';
            $filmesdia[$b][2] = acharTipoExibicao($dias[$a][$b], $inicioExibicao, $finalExibicao);
            echo '<br>Tipo de Exibição: '.$filmesdia[$b][2].'<br>';
            $filmesdia[$b][3] = verificarSeE3D($dias[$a][$b], $identificador3d);
            $filmesdia[$b][4] = acharHorario($dias[$a][$b], $inicioHorario, $finalHorario);
            echo "<br>Horário:".$filmesdia[$b][4];
            $extras = acharExtras($dias[$a][$b], $listaExtras, $extrasSessao);
            $indicePrecos = acharIndicedePrecos($filmesdia[$b][4], $horarioInicioNoite, $extras[1], $filmesdia[$b][3]);
            $filmesdia[$b][5] = calcularPreco($indicePrecos, $listaPrecos, $feriados, $a);
            $filmesdia[$b][6] = date('d/m', strtotime('+'.$a.' day'));
            $filmesdia[$b][7] = $extras[0];
            echo "Data: ".$filmesdia[$b][6]." a: ".$a." hoje: ".date('d/m')."<br>";
        }
        $dias[$a] = $filmesdia;
    }
    cadastrarSessoes($dias);
}

//Cada site deve ter seu automatizador de listasDePreco

$enderecoCinemarkNatal = ['RN', 'Natal', 'Cinemark Midway Mall', 'Centro', 'Av. Bernardo Vieira', '3775', '(84) 3221-6571', '-5.810457', '-35.206555'];
$enderecoCinemarkAracajuJardins = ['SE', 'Aracaju', 'Cinemark Shopping Jardins', 'Jardim', 'Av.Ministro Geraldo Barreto Sobral', '215', '(79) 3217-5610', '-10.9436232', '-37.0600782'];
$enderecoCinepolisNatalShopping = ['RN', 'Natal', 'Cinepolis Natal Shopping', 'Candelaria', 'Av. Senador Salgado Filho', '2234', '(84) 3209-8199', '-5.842221', '-35.211424'];

$d2e3 = '2.. e 3..:'; $d4 = '(.*)4..: R\$ (.*) o dia todo'; $d5eEtc = '(.*)5..\,6..\,Sab.\,Dom. e Feriados: ';
$listaTipos = ['Inteira(.*)', 'Cinemark 3D(.*)'];
$listaExpressoes = [[$d2e3.' R\$ (.*) \(matin', $d2e3.' R\$ (.*) \(matin', $d4, $d5eEtc.'R\$ (.*) \(matin', $d5eEtc.'R\$ (.*) \(matin', $d5eEtc.'R\$ (.*) \(matin'],
    [$d2e3.'(.*) - R\$ (.*) \(noite\)', $d2e3.'(.*) - R\$ (.*) \(noite\)', $d4, $d5eEtc.'(.*) - R\$ (.*) \(noite\)', $d5eEtc.'(.*) - R\$ (.*) \(noite\)', $d5eEtc.'(.*) - R\$ (.*) \(noite\)'],
    [$d2e3.' R\$ (.*) o dia todo', $d2e3.' R\$ (.*) o dia todo', $d4, $d5eEtc.'R\$ (.*) o dia todo', $d5eEtc.'R\$ (.*) o dia todo', $d5eEtc.'R\$ (.*) o dia todo'],
    [$d2e3.' R\$ (.*) o dia todo', $d2e3.' R\$ (.*) o dia todo', $d4, $d5eEtc.'R\$ (.*) o dia todo', $d5eEtc.'R\$ (.*) o dia todo', $d5eEtc.'R\$ (.*) o dia todo']];
//$listaTipos = ['Inteira<\/b><br \/>', 'Inteira<\/b><br \/>', 'Cinemark 3D<\/b><br \/>', 'Cinemark 3D<\/b><br \/>'];
$feriados = ["01/01", "06/01", "25/03", "21/04", "01/05", "29/06", "07/09", "03/10", "12/10", "02/11", "15/11", "21/11", "21/12", "25/12"];
executar($enderecoCinemarkNatal, 'http://www.cinemark.com.br/programacao/natal/midway-mall-natal/22/681', 0, 'id="date', '<div class="filme">', '<span id="HH_681_(.*)">', '</span>(?=</p>)?', 'id="xxxx">', '(?=( 3D)?(&nbsp;)?</a>)', 'censura\/censura', '.png', 'exibicao..jpg" title="', '" alt', 'alt="3D"', false, 1701, $listaExpressoes, $listaTipos, $feriados, "UTF-8");
executar($enderecoCinemarkAracajuJardins, 'http://www.cinemark.com.br/programacao/aracaju/shopping-jardins/10/706', 0, 'id="date', '<div class="filme">', '<span id="HH_706_(.*)">', '</span>(?=</p>)?', 'id="xxxx">', '(?=( 3D)?(&nbsp;)?</a>)', 'censura\/censura', '.png', 'exibicao..jpg" title="', '" alt', 'alt="3D"', false, 1701, $listaExpressoes, $listaTipos, $feriados, "UTF-8");


$d2e3 = 'Segunda(.*)'; $d4 = 'Quarta(.*)R\$ (.*) \(inteira'; $d5eEtc = 'Quinta(.*)';
$listaExtras = [[4, 'icovip', 'VIP'], [8, 'icomacroxe', 'MacroXE']];
$listaTipos = ['Salas Tradicionais<\/b>(.*)', 'Salas 3D<\/b>(.*)', 'Salas VIP<\/b>(.*)', 'Salas VIP 3D<\/b>(.*)', 'Salas Macro XE Tradicionais<\/b>(.*)', 'Salas Macro XE 3D<\/b>(.*)'];
$listaExpressoes = [[$d2e3.'R\$ (.*) \(inteira', $d2e3.'R\$ (.*) \(inteira', $d4, $d5eEtc.'R\$ (.*) \(inteira', $d5eEtc.'R\$ (.*) \(inteira', $d5eEtc.'R\$ (.*) \(inteira'],
    [$d2e3.'(.*)Noite(.*)R\$ (.*) \(inteira', $d2e3.'(.*)Noite(.*)R\$ (.*) \(inteira', $d4, $d5eEtc.'(.*)Noite(.*)R\$ (.*) \(inteira', $d5eEtc.'(.*)Noite(.*)R\$ (.*) \(inteira', $d5eEtc.'(.*)Noite(.*)R\$ (.*) \(inteira'],
    [$d2e3.'R\$ (.*) \(inteira', $d2e3.'R\$ (.*) \(inteira', $d4, $d5eEtc.'R\$ (.*) \(inteira', $d5eEtc.'R\$ (.*) \(inteira', $d5eEtc.'R\$ (.*) \(inteira'],
    [$d2e3.'R\$ (.*) \(inteira', $d2e3.'R\$ (.*) \(inteira', $d4, $d5eEtc.'R\$ (.*) \(inteira', $d5eEtc.'R\$ (.*) \(inteira', $d5eEtc.'R\$ (.*) \(inteira'],
    [$d2e3.'R\$ (.*) \(inteira', $d2e3.'R\$ (.*) \(inteira', $d4, $d5eEtc.'R\$ (.*) \(inteira', $d5eEtc.'R\$ (.*) \(inteira', $d5eEtc.'R\$ (.*) \(inteira'],
    [$d2e3.'R\$ (.*) \(inteira', $d2e3.'R\$ (.*) \(inteira', $d4, $d5eEtc.'R\$ (.*) \(inteira', $d5eEtc.'R\$ (.*) \(inteira', $d5eEtc.'R\$ (.*) \(inteira'],
    [$d2e3.'R\$ (.*) \(inteira', $d2e3.'R\$ (.*) \(inteira', $d4, $d5eEtc.'R\$ (.*) \(inteira', $d5eEtc.'R\$ (.*) \(inteira', $d5eEtc.'R\$ (.*) \(inteira'],
    [$d2e3.'R\$ (.*) \(inteira', $d2e3.'R\$ (.*) \(inteira', $d4, $d5eEtc.'R\$ (.*) \(inteira', $d5eEtc.'R\$ (.*) \(inteira', $d5eEtc.'R\$ (.*) \(inteira'],
    [$d2e3.'R\$ (.*) \(inteira', $d2e3.'R\$ (.*) \(inteira', $d4, $d5eEtc.'R\$ (.*) \(inteira', $d5eEtc.'R\$ (.*) \(inteira', $d5eEtc.'R\$ (.*) \(inteira'],
    [$d2e3.'(.*)Noite(.*)R\$ (.*) \(inteira', $d2e3.'(.*)Noite(.*)R\$ (.*) \(inteira', $d4, $d5eEtc.'(.*)Noite(.*)R\$ (.*) \(inteira', $d5eEtc.'(.*)Noite(.*)R\$ (.*) \(inteira', $d5eEtc.'(.*)Noite(.*)R\$ (.*) \(inteira'],
    [$d2e3.'R\$ (.*) \(inteira', $d2e3.'R\$ (.*) \(inteira', $d4, $d5eEtc.'R\$ (.*) \(inteira', $d5eEtc.'R\$ (.*) \(inteira', $d5eEtc.'R\$ (.*) \(inteira'],
    [$d2e3.'R\$ (.*) \(inteira', $d2e3.'R\$ (.*) \(inteira', $d4, $d5eEtc.'R\$ (.*) \(inteira', $d5eEtc.'R\$ (.*) \(inteira', $d5eEtc.'R\$ (.*) \(inteira']];
executar($enderecoCinepolisNatalShopping, 'http://www.cinepolis.com.br/programacao/cinema.php?cc=31', 0, 'tabelahorarios" id', 'bgcolor', 'aria-label="Comprar ingresso">', '</a>-', 'data-order="', '">', 'aria-label="', ' anos"', '<td class="horarios"(.*)aria-label="', '">', 'ico3d', $listaExtras, 1656, $listaExpressoes, $listaTipos, $feriados, "ISO-8859-1");
/*
function mascararTabela() {
    return [[['A Era do Gelo', 0, 'Dublado', true, '16h00', '26,00', '13/07', ['Joï¿½o Marcos'], ['A', 'B', 'C'], ['Animacao', 'Comedia'], 'Sinopse de A Era do Gelo', $endereco],
        ['Procurando Dory', 0, 'Dublado', false, '12h00', '18,00', '13/07', ['Jayne Kelly'], ['D', 'E', 'F'], ['Animacao', 'Comedia'], 'Sinopse de Procurando Dory', $endereco]],
        [['Esquadrï¿½o Suicida', 16, 'Legendado', false, '18h00', '30,00', '14/07', ['Josï¿½ Medeiros'], ['G', 'H', 'I'], ['Ficï¿½ï¿½o', 'Super-Herï¿½i'], 'Sinopse de Esquadrï¿½o Suicida', $endereco],
            ['Doutor Estranho', 12, 'Dublado', true, '14h00', '22,00', '14/07', ['Maria Josï¿½'], ['J', 'K', 'L'], ['Suspense', 'Super-Herï¿½i', 'Ficï¿½ï¿½o'], 'Sinopse de Doutor Estranho', $endereco]]];
}
 */

function comentarios() {
//Campos para determinados sites:
//Cinemark:
//$link: 'http://www.cinemark.com.br/programacao/natal/midway-mall-natal/22/681'
//$identificadorTag: dia - 'id="date'
//$identificadorTag: filme - '<div class="filme">'
//$tagHorario: InicioTag: '<span id="HH_681_(.*)">' FinalTag: '</span>(?=</p>)'
//NomedoFilme: InicioTag: 'id="xxxx">' FinalTag: '</a>'
//Identificador3D: 'alt="3D"'
//ClassifEtaria: Inicio: 'censura/censura' Final: '.png'
//Tipo de Exibicao: Inicio: 'exibicao..jpg" title="' Final: '" alt'
//tagSala: Inicio: 'title="Sala ' Final: '">'
//Ingresso.com:
//$link: http://www.ingresso.com/natal/home/local/cinema/cinemark-natal/#/bairro=Tirol
//$identificadorTag: dia - '<div id="outrosLocais_'
//$identificadorTag: filme - '<div id="local1'
//NomedoFilme: InicioTag: 'class="nomeEspetaculo">' FinalTag: '</a>'
}
?>