<!DOCTYPE html>
<html>
    <head>
    </head>
    <body>

        <?php
        function buscarHTML($link) {
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $link);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($ch, CURLOPT_ENCODING, "");
            $result = curl_exec($ch);
            curl_close($ch);
            return $result;
        }

        function separarPorDia($htmlSite, $tipoOrdem, $identificadorTag) {
            //tipoOrdem:
            //0 - Por dia
            //1 - Fixa - (Do dia x até o dia y)
            if ($tipoOrdem == 0) {
                $htmlSite .= $identificadorTag;
                preg_match_all('/' . $identificadorTag . '(.*)(?=' . $identificadorTag . ')/Us', $htmlSite, $dias, PREG_SET_ORDER);
                foreach ($dias as &$value) {
                    $value = $value[1];
                }
            }
            return $dias;
        }

        function separarFilmes($dia, $identificadorTag) {
            $dia .= $identificadorTag;
            preg_match_all('/' . $identificadorTag . '(.*)(?=' . $identificadorTag . ')/Us', $dia, $filmes, PREG_SET_ORDER);
            foreach ($filmes as &$value) {
                $value = $value[1];
            }
            return $filmes;
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
            preg_match_all('/\(\.\*\)/', $inicioTag, $cont, PREG_SET_ORDER);
            $finalTag = str_replace('/', '\/', $finalTag);
            preg_match('/' . $inicioTag . '(.*)' . $finalTag . '/Us', $filme, $nome);
            return $nome[1 + count($cont)];
        }

        function acharClassificacaoEtaria($filme, $inicioTag, $finalTag) {
            preg_match_all('/\(\.\*\)/', $inicioTag, $cont, PREG_SET_ORDER);
            $finalTag = str_replace('/', '\/', $finalTag);
            preg_match('/' . $inicioTag . '(.*)' . $finalTag . '/U', $filme, $classificacao);
            return $classificacao[1 + count($cont)];
        }

        function acharTipoExibicao($filme, $inicioTag, $finalTag) {
            preg_match_all('/\(\.\*\)/', $inicioTag, $cont, PREG_SET_ORDER);
            $finalTag = str_replace('/', '\/', $finalTag);
            preg_match('/' . $inicioTag . '(.*)' . $finalTag . '/Us', $filme, $tipo);
            return $tipo[1 + count($cont)];
        }

        function verificarSeE3D($filme, $identificador) {
            if (preg_match('/' . $identificador . '/', $filme)) {
                return '3D';
            } else {
                return 'Normal';
            }
        }

        function acharHorario($filme, $inicioTag, $finalTag) {
            preg_match_all('/\(\.\*\)/', $inicioTag, $cont, PREG_SET_ORDER);
            $finalTag = str_replace('/', '\/', $finalTag);
            preg_match('/' . $inicioTag . '(.*)' . $finalTag . '/Us', $filme, $horario);
            $hora = str_replace(':', 'h', $horario[1 + count($cont)]);
            return $hora;
        }

        function acharSala($filme, $inicioTag, $finalTag) {
            preg_match_all('/\(\.\*\)/', $inicioTag, $cont, PREG_SET_ORDER);
            $finalTag = str_replace('/', '\/', $finalTag);
            preg_match('/' . $inicioTag . '(.*)' . $finalTag . '/Us', $filme, $sala);
            return $sala[1 + count($cont)];
        }

        function acharExtras($filme, $listaExtras) {
            // Quanto vale cada extra:
            //2^(n° do extra + 2)
            $retorno = 0;
            if ($listaExtras != false) {
                for ($n = 0; $n < count($listaExtras); $n ++) {
                    if (preg_match('/' . $listaExtras[$n][1] . '/', $filme)) {
                        $retorno += pow(2, $n);
                    }
                }
            }
            return $retorno;
        }

        function eMatine($hora, $inicioNoite) {
            $hora = str_replace("h", "", $hora);
            $hora = intval($hora);
            if ($hora <= $inicioNoite) {
                return true;
            } else {
                return false;
            }
        }

        function acharIndicedePrecos($hora, $inicioNoite, $retorno, $filme) {
            $retorno *= 4;
            if (!eMatine($hora, $inicioNoite)) {
                $retorno += 1;
            }
            if ($filme == '3D') {
                $retorno += 2;
            }
            return $retorno;
        }

        function criarListaDePrecos($listaExpressoes, $listaTipos, $busca) {
            $listaPrecos = [];
            for ($o = 0; $o < count($listaExpressoes); $o++) {
                for ($p = 0; $p < count($listaExpressoes[$o]); $p++) {
                    $tipo = $listaTipos[$o];
                    $expressao = $listaExpressoes[$o][$p];
                    $pesquisa = $tipo.$expressao;
                    preg_match_all('/\(\.\*\)/', $pesquisa, $c, PREG_SET_ORDER);
                    preg_match('/'.$pesquisa.'/Us', $busca, $preco);
                    $listaPrecos[$o][$p] = $preco[count($c)];
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
                return $listaPrecos[$indice][6];
            }
        }

        function executar($link, $organizacaoSite, $identificadorData, $identificadorFilme, $inicioHorario, $finalHorario, $inicioNome, $finalNome, $inicioClassificacao, $finalClassificacao, $inicioExibicao, $finalExibicao, $identificador3d, $listaExtras, $horarioInicioNoite, $listaExpressoes, $listaTipos, $feriados) {
            $busca = buscarHTML($link);
            $dias = separarPorDia($busca, $organizacaoSite, $identificadorData);
            $listaPrecos = criarListaDePrecos($listaExpressoes, $listaTipos, $busca);
            for ($a = 0; $a < count($dias); $a++) {
                $filmesdia = separarFilmes($dias[$a], $identificadorFilme);
                $filmesdia = multiplicarPorHorarios($filmesdia, $inicioHorario, $finalHorario);
                $dias[$a] = $filmesdia;
                $filmesdia = [];
                for ($b = 0; $b < count($dias[$a]); $b++) {
                    $filmesdia[$b][0] = acharNomeDoFilme($dias[$a][$b], $inicioNome, $finalNome);
                    $filmesdia[$b][1] = acharClassificacaoEtaria($dias[$a][$b], $inicioClassificacao, $finalClassificacao);
                    $filmesdia[$b][2] = acharTipoExibicao($dias[$a][$b], $inicioExibicao, $finalExibicao);
                    $filmesdia[$b][3] = verificarSeE3D($dias[$a][$b], $identificador3d);
                    $filmesdia[$b][4] = acharHorario($dias[$a][$b], $inicioHorario, $finalHorario);
                    $extras = acharExtras($dias[$a][$b], $listaExtras);
                    $indicePrecos = acharIndicedePrecos($filmesdia[$b][4], $horarioInicioNoite, $extras, $filmesdia[$b][3]);
                    $filmesdia[$b][5] = calcularPreco($indicePrecos, $listaPrecos, $feriados, $a);
                }

                $dias[$a] = $filmesdia;
            }

            return $dias;
        }
        //Cada site deve ter seu automatizador de listasDePreco
        $listaExpressoes = [['2.. e 3..: R\$ (.*) \(matin', '2.. e 3..: R\$ (.*) \(matin', '(.*)4..: R\$ (.*) o dia todo', '(.*)5..\,6..\,Sab.\,Dom. e Feriados: R\$ (.*) \(matin', '(.*)5..\,6..\,Sab.\,Dom. e Feriados: R\$ (.*) \(matin', '(.*)5..\,6..\,Sab.\,Dom. e Feriados: R\$ (.*) \(matin'], ['2.. e 3..:(.*) - R\$ (.*) \(noite\)', '2.. e 3..:(.*) - R\$ (.*) \(noite\)', '(.*)4..: R\$ (.*) o dia todo', '(.*)5..\,6..\,Sab.\,Dom. e Feriados: (.*) - R\$ (.*) \(noite\)', '(.*)5..\,6..\,Sab.\,Dom. e Feriados: (.*) - R\$ (.*) \(noite\)', '(.*)5..\,6..\,Sab.\,Dom. e Feriados: (.*) - R\$ (.*) \(noite\)'], ['2.. e 3..: R\$ (.*) o dia todo', '2.. e 3..: R\$ (.*) o dia todo', '(.*)4..: R\$ (.*) o dia todo', '(.*)5..\,6..\,Sab.\,Dom. e Feriados: R\$ (.*) o dia todo', '(.*)5..\,6..\,Sab.\,Dom. e Feriados: R\$ (.*) o dia todo', '(.*)5..\,6..\,Sab.\,Dom. e Feriados: R\$ (.*) o dia todo'], ['2.. e 3..: R\$ (.*) o dia todo', '2.. e 3..: R\$ (.*) o dia todo', '(.*)4..: R\$ (.*) o dia todo', '(.*)5..\,6..\,Sab.\,Dom. e Feriados: R\$ (.*) o dia todo', '(.*)5..\,6..\,Sab.\,Dom. e Feriados: R\$ (.*) o dia todo', '(.*)5..\,6..\,Sab.\,Dom. e Feriados: R\$ (.*) o dia todo']];
        $listaTipos = ['Inteira<\/b><br \/>', 'Inteira<\/b><br \/>', 'Cinemark 3D<\/b><br \/>', 'Cinemark 3D<\/b><br \/>'];
        $feriados = ["01/01", "06/01", "25/03", "21/04", "01/05", "29/06", "07/09", "03/10", "12/10", "02/11", "15/11", "21/11", "21/12", "25/12"];
        $resultado = executar('www.cinemark.com.br/programacao/natal/midway-mall-natal/22/681/', 0, 'id="date', '<div class="filme">', '<span id="HH_681_(.*)">', '</span>(?=</p>)?', 'id="xxxx">', '</a>', 'censura\/censura', '.png', 'exibicao..jpg" title="', '" alt', 'alt="3D"', false, 1701, $listaExpressoes, $listaTipos, $feriados);
        echo $resultado[0][25][0] . '|' . $resultado[0][25][1] . '|' . $resultado[0][25][2] . '|' . $resultado[0][25][3] . '|' . $resultado[0][25][4]. '|' . $resultado[0][25][5];




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
        ?>

    </body>
</html>												