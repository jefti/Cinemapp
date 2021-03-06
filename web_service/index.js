var express = require('express'),
        app = express(),
        mysql = require('mysql'),
        bodyparser = require('body-parser'),
        connectionpool = mysql.createPool({
            host: 'localhost',
            user: 'root',
            password: 'root',
            database: 'cinemapp_bd'
        });
app.use(bodyparser.urlencoded({extended: true}));
app.use(bodyparser.json());

function existeFiltro(temFiltro) {
    if (temFiltro) {
        return " AND ";
    } else {
        return " WHERE ";
    }
}
app.post('/', function (req, res) {
    connectionpool.getConnection(function (err, connection) {
        if (err) {
            console.error('CONNECTION error: ', err);
            res.statusCode = 503;
            res.send({
                result: 'error',
                err: err.code
            });
        } else {
            if (req.body.tipo == "cidade") {
                sql = 'SELECT `cidade`.`idcidade` AS `idcidade`, `cidade`.`nomeCidade` AS `cidade` FROM `cidade` WHERE `cidade`.`idestado` = ' + req.body.idestado;
                connection.query(sql, function (err, rows) {
                    if (err) {
                        console.error(err);
                        res.statusCode = 500;
                        res.send({
                            result: 'error',
                            err: err.code
                        });
                    }
                    res.header("Access-Control-Allow-Origin", "*");
                    res.send({
                        result: 'success',
                        err: '',
                        json: rows,
                        length: rows.length
                    });
                    connection.release();
                });
            } else if (req.body.tipo == "filme") {
                sql = 'SELECT `filme`.`idfilme` AS `idfilme`, `filme`.`nomeDoFilme` AS `filme` FROM `filme` JOIN sessao ON `filme`.`idfilme` = `sessao`.`idfilme` WHERE `sessao`.`idcinema` = ' + req.body.idcinema + ' GROUP BY `filme`.`idfilme`';
                connection.query(sql, function (err, rows) {
                    if (err) {
                        console.error(err);
                        res.statusCode = 500;
                        res.send({
                            result: 'error',
                            err: err.code
                        });
                    }
                    res.header("Access-Control-Allow-Origin", "*");
                    res.send({
                        result: 'success',
                        err: '',
                        json: rows,
                        length: rows.length
                    });
                    connection.release();
                });
            } else if (req.body.tipo == "genero") {

            } else if (req.body.tipo == "estado") {
                sql = 'SELECT `estado`.`idestado` AS `idestado`, `estado`.`siglaEstado` AS `siglaEstado` FROM `estado`';
                connection.query(sql, function (err, rows) {
                    if (err) {
                        console.error(err);
                        res.statusCode = 500;
                        res.send({
                            result: 'error',
                            err: err.code
                        });
                    }
                    res.header("Access-Control-Allow-Origin", "*");
                    res.send({
                        result: 'success',
                        err: '',
                        json: rows,
                        length: rows.length
                    });
                    connection.release();
                });
            }

        }
    });
});
app.get('/estado/', function (req, res) {
    connectionpool.getConnection(function (err, connection) {
        if (err) {
            console.error('CONNECTION error: ', err);
            res.statusCode = 503;
            res.send({
                result: 'error',
                err: err.code
            });
        } else {
            sql = 'SELECT `estado`.`idestado` AS `idestado`, `estado`.`siglaEstado` AS `siglaEstado` FROM `estado`';
            connection.query(sql, req.params.id, function (err, rows, fields) {
                if (err) {
                    console.error(err);
                    res.statusCode = 500;
                    res.send({
                        result: 'error',
                        err: err.code
                    });
                }
                res.header("Access-Control-Allow-Origin", "*");
                res.send({
                    result: 'success',
                    err: '',
                    json: rows,
                    length: rows.length
                });
                connection.release();
            });
        }
    });
});
app.get('/localizacao/', function (req, res) {
    connectionpool.getConnection(function (err, connection) {
        if (err) {
            console.error('CONNECTION error: ', err);
            res.statusCode = 503;
            res.send({
                result: 'error',
                err: err.code
            });
        } else {
            sql = 'SELECT `cinema`.`idcinema` AS `idcinema`, `cinema`.`latitude` AS `latitude`, `cinema`.`longitude` AS `longitude`, `cinema`.`nomeCinema` AS `nome` FROM `cinema`';
            connection.query(sql, req.params.id, function (err, rows, fields) {
                if (err) {
                    console.error(err);
                    res.statusCode = 500;
                    res.send({
                        result: 'error',
                        err: err.code
                    });
                }
                res.header("Access-Control-Allow-Origin", "*");
                res.send({
                    result: 'success',
                    err: '',
                    json: rows,
                    length: rows.length
                });
                connection.release();
            });
        }
    });
});
app.get('/cinemaporcidade/:idcidade', function (req, res) {
    connectionpool.getConnection(function (err, connection) {
        if (err) {
            console.error('CONNECTION error: ', err);
            res.statusCode = 503;
            res.send({
                result: 'error',
                err: err.code
            });
        } else {
            sql = 'SELECT `cinema`.`idcinema` AS `idcinema`, `cinema`.`nomeCinema` AS `nome` FROM `cinema` JOIN `endereco` ON `cinema`.`idendereco` = `endereco`.`idendereco` JOIN `cidade` ON `endereco`.`idcidade` = `cidade`.`idcidade` WHERE `cidade`.`idcidade` = ' + req.params.idcidade;

            console.log("sql: " + sql + " <=");
            connection.query(sql, req.params.id, function (err, rows, fields) {
                if (err) {
                    console.error(err);
                    res.statusCode = 500;
                    res.send({
                        result: 'error',
                        err: err.code
                    });
                }
                res.header("Access-Control-Allow-Origin", "*");
                res.send({
                    result: 'success',
                    err: '',
                    json: rows,
                    length: rows.length
                });
                connection.release();
            });
        }
    });
});
app.get('/cidade/:idestado', function (req, res) {
    connectionpool.getConnection(function (err, connection) {
        if (err) {
            console.error('CONNECTION error: ', err);
            res.statusCode = 503;
            res.send({
                result: 'error',
                err: err.code
            });
        } else {
            sql = 'SELECT `cidade`.`idcidade` AS `idcidade`, `cidade`.`nomeCidade` AS `cidade` FROM `cidade` WHERE `cidade`.`idestado` = ' + req.params.idestado;
            connection.query(sql, req.params.id, function (err, rows, fields) {
                if (err) {
                    console.error(err);
                    res.statusCode = 500;
                    res.send({
                        result: 'error',
                        err: err.code
                    });
                }
                res.header("Access-Control-Allow-Origin", "*");
                res.send({
                    result: 'success',
                    err: '',
                    json: rows,
                    length: rows.length
                });
                connection.release();
            });
        }
    });
});
app.get('/filme/:idcinema', function (req, res) {
    connectionpool.getConnection(function (err, connection) {
        if (err) {
            console.error('CONNECTION error: ', err);
            res.statusCode = 503;
            res.send({
                result: 'error',
                err: err.code
            });
        } else {
            sql = 'SELECT `filme`.`idfilme` AS `idfilme`, `filme`.`avaliacao` AS `avaliacao`, `filme`.`nomeDoFilme` AS `nomeDoFilme`, `filme`.`classificacaoEtaria` AS `classifEtaria`, `filme`.`sinopse` AS `sinopse`, `filme`.`imagem` AS `imagem`, GROUP_CONCAT(DISTINCT `genero`.`idgenero` SEPARATOR ", ") AS `generos` FROM `genero` JOIN `filme_genero` ON `genero`.`idgenero` = `filme_genero`.`idgenero` JOIN `filme` ON `filme_genero`.`idfilme` = `filme`.`idfilme` JOIN sessao ON `filme`.`idfilme` = `sessao`.`idfilme` WHERE `sessao`.`idcinema` = ' + req.params.idcinema + ' GROUP BY `filme`.`nomeDoFilme`';
            connection.query(sql, req.params.id, function (err, rows, fields) {
                if (err) {
                    console.error(err);
                    res.statusCode = 500;
                    res.send({
                        result: 'error',
                        err: err.code
                    });
                }
                res.header("Access-Control-Allow-Origin", "*");
                res.send({
                    result: 'success',
                    err: '',
                    json: rows,
                    length: rows.length,
                });
                connection.release();
            });
        }
    });
});
app.get('/cinema/:idcinema', function (req, res) {
    connectionpool.getConnection(function (err, connection) {
        if (err) {
            console.error('CONNECTION error: ', err);
            res.statusCode = 503;
            res.send({
                result: 'error',
                err: err.code
            });
        } else {
            sql = 'SELECT `filme`.`idfilme` AS `idfilme`, `filme`.`nomeDoFilme` AS `filme` FROM `filme` JOIN sessao ON `filme`.`idfilme` = `sessao`.`idfilme` WHERE `sessao`.`idcinema` = ' + req.params.idcinema + ' GROUP BY `filme`.`idfilme`';
            connection.query(sql, req.params.id, function (err, rows, fields) {
                if (err) {
                    console.error(err);
                    res.statusCode = 500;
                    res.send({
                        result: 'error',
                        err: err.code
                    });
                }
                res.header("Access-Control-Allow-Origin", "*");
                res.send({
                    result: 'success',
                    err: '',
                    json: rows,
                    length: rows.length
                });
                connection.release();
            });
        }
    });
});
app.get('/sessoes/:cinema/:genero/:filme/:horariomin/:horariomax/:tipoexibicao/:classificacao/:preco/:notamin/:numinteracoes', function (req, res) {
    connectionpool.getConnection(function (err, connection) {
        console.log('Numero: ' + req.params.numinteracoes + '<=');
        var temFiltro = false;
        if (err) {
            console.error('CONNECTION error: ', err);
            res.statusCode = 503;
            res.send({
                result: 'error',
                err: err.code
            });
        } else {
            sql = "SELECT `filme`.`nomeDoFilme` AS `filme`, `cinema`.`nomeCinema` AS `cinema`, `filme`.`avaliacao` AS `avaliacao`, `filme`.`imagem` AS `imagem`, `filme`.`classificacaoEtaria` AS `classificacao`, `sessao`.`horario` AS `horario`, `sessao`.`preco` AS `preco`, `sessao`.`tipo_exibicao` AS `tipo_exibicao`, `sessao`.`e_3d` AS `e_3d`, `sessao`.`data` AS `data`, GROUP_CONCAT(`genero`.`idgenero` SEPARATOR ', ') AS `generos` FROM `filme` JOIN `filme_genero` ON `filme`.`idfilme` = `filme_genero`.`idfilme` JOIN `genero` ON `filme_genero`.`idgenero` = `genero`.`idgenero` JOIN `sessao` ON `sessao`.`idfilme` = `filme`.`idfilme` JOIN `cinema` ON `cinema`.`idcinema` = `sessao`.`idcinema`";
            if (req.params.cinema != '*') {
                sql += existeFiltro(temFiltro);
                temFiltro = true;
                console.log("cinema: " + req.params.cinema + "/n");
                var array = req.params.cinema.split(",");
                sql += "(`cinema`.`idcinema` = '" + array[0] + "'";
                if (array.length >= 2) {
                    for (var i = 1; i < array.length; i++) {
                        sql += " OR `cinema`.`idcinema` = '" + array[i] + "'";
                    }
                }
                sql += ")";
                

            }
            if (req.params.filme != '*') {
                sql += existeFiltro(temFiltro);
                temFiltro = true;
                sql += "`filme`.`idfilme` = '" + req.params.filme + "'";
            }
            if (req.params.horariomin != '*') {
                sql += existeFiltro(temFiltro);
                temFiltro = true;
                sql += "`sessao`.`horario` >= '" + req.params.horariomin + "'";
            }
            if (req.params.horariomax != '*') {
                sql += existeFiltro(temFiltro);
                temFiltro = true;
                sql += "`sessao`.`horario` <= '" + req.params.horariomax + "'";
            }
            if (req.params.tipoexibicao != '*') {
                sql += existeFiltro(temFiltro);
                temFiltro = true;
                if (req.params.tipoexibicao == "Du") {
                    sql += "(`sessao`.`tipo_exibicao` = 'Dublado' OR `sessao`.`tipo_exibicao` = 'Nacional')";
                } else {
                    sql += "`sessao`.`tipo_exibicao` = 'Legendado'";
                }
            }
            if (req.params.classificacao != '*') {
                sql += existeFiltro(temFiltro);
                temFiltro = true;
                sql += "`filme`.`classificacaoEtaria` <= '" + req.params.classificacao + "'";
            }
            if (req.params.preco != '*') {
                sql += existeFiltro(temFiltro);
                temFiltro = true;
                sql += "`sessao`.`preco` <= '" + req.params.preco + "'";
            }
            if (req.params.notamin != '0') {
                sql += existeFiltro(temFiltro);
                temFiltro = true;
                sql += "`filme`.`avaliacao` >= '" + req.params.notamin + "'";
            }
            sql += 'GROUP BY `sessao`.`idsessao`';
            if (req.params.genero != '*') {
                sql += " HAVING `generos` LIKE '%" + req.params.genero + "%'";
            }
            sql += 'ORDER BY `sessao`.`data`, `sessao`.`horario` LIMIT ' + req.params.numinteracoes + ', 11';
            console.log('SQL: ' + sql + '<=');
            connection.query(sql, req.params.id, function (err, rows, fields) {
                if (err) {
                    console.error(err);
                    res.statusCode = 500;
                    res.send({
                        result: 'error',
                        err: err.code
                    });
                }
                res.header("Access-Control-Allow-Origin", "*");
                res.send({
                    result: 'success',
                    err: '',
                    json: rows,
                    length: rows.length
                });
                connection.release();
            });
        }
    });
});
app.get('/:estado/:cidade/:cinema/:genero/:filme', function (req, res) {
    connectionpool.getConnection(function (err, connection) {
        var sql = "SELECT `estado`.`siglaEstado` AS `estado`, `cidade`.`nomeCidade` AS `cidade`, `cinema`.`nomeCinema` AS `cinema`,`filme`.`nomeDoFilme` AS `nome`, `filme`.`classificacaoEtaria` AS `classificacao`, `sessao`.`horario` AS `horario`, `sessao`.`preco` AS `preco`, `sessao`.`tipo_exibicao` AS `tipo_exibicao`, `sessao`.`e_3d` AS `e_3d`, `sessao`.`data` AS `data`, GROUP_CONCAT(`genero`.`nomeGenero` SEPARATOR ', ') AS `generos` FROM `filme` JOIN `filme_genero` ON `filme`.`idfilme` = `filme_genero`.`idfilme` JOIN `genero` ON `filme_genero`.`idgenero` = `genero`.`idgenero` JOIN `sessao` ON `sessao`.`idfilme` = `filme`.`idfilme` JOIN `cinema` ON `cinema`.`idcinema` = `sessao`.`idcinema` JOIN `endereco` ON `endereco`.`idendereco` = `cinema`.`idendereco` JOIN `cidade` ON `endereco`.`idcidade` = `cidade`.`idcidade`JOIN `estado` ON `estado`.`idestado` = `cidade`.`idestado`";
        var temFiltro = false;
        if (err) {
            console.error('CONNECTION error: ', err);
            res.statusCode = 503;
            res.send({
                result: 'error',
                err: err.code
            });
        } else {
            if (req.params.filme != '*') {
                sql += existeFiltro(temFiltro);
                temFiltro = true;
                sql += "`filme`.`nomeDoFilme` = '" + req.params.filme + "'";
            }
            if (req.params.cinema != '*') {
                sql += existeFiltro(temFiltro);
                temFiltro = true;

                sql += "`cinema`.`nomeCinema` = '" + req.params.cinema + "'";
            } else {
                if (req.params.cidade != '*') {
                    sql += existeFiltro(temFiltro);
                    temFiltro = true;
                    sql += "`cidade`.`nomeCidade` = '" + req.params.cidade + "'";
                } else {
                    if (req.params.estado != '*') {
                        sql += existeFiltro(temFiltro);
                        temFiltro = true;
                        sql += "`estado`.`siglaEstado` = '" + req.params.estado + "'";
                    }
                }
            }
            sql += " GROUP BY `sessao`.`idsessao`"
            if (req.params.genero != '-------') {
                sql += " HAVING `generos` LIKE '%" + req.params.genero + "%'";
            }
            console.log('SQL: ' + sql + '<=');
            connection.query(sql, req.params.id, function (err, rows, fields) {
                if (err) {
                    console.error(err);
                    res.statusCode = 500;
                    res.send({
                        result: 'error',
                        err: err.code
                    });
                }
                res.header('Access-Control-Allow-Origin', '*');
                res.send({
                    result: 'success',
                    err: '',
                    json: rows,
                    length: rows.length
                });
                connection.release();
            });
        }
    });
});
app.listen(3000);
console.log('Rest Demo Listening on port 3000');