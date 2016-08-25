var express = require('express'),
    app     = express(),
    mysql   = require('mysql'),
    connectionpool = mysql.createPool({
        host     : 'localhost',
        user     : 'root',
        password : 'root',
        database : 'cinemapp_bd'
    });
function existeFiltro(temFiltro) {
    if (temFiltro) {
        return " AND ";
    }else {
        return " WHERE ";
    }
}
app.get('/estado/:idestado', function(req,res){
    connectionpool.getConnection(function(err, connection) {
        if (err) {
            console.error('CONNECTION error: ',err);
            res.statusCode = 503;
            res.send({
                result: 'error',
                err:    err.code
            });
        } else {
            sql = 'SELECT `cidade`.`idcidade` AS `idcidade`, `cidade`.`nomeCidade` AS `cidade` FROM `cidade` WHERE `cidade`.`idestado` = '+req.params.idestado;
            connection.query(sql, req.params.id, function(err, rows, fields) {
                if (err) {
                    console.error(err);
                    res.statusCode = 500;
                    res.send({
                        result: 'error',
                        err:    err.code
                    });
                }
                res.header("Access-Control-Allow-Origin", "*");
                res.send({
                    result: 'success',
                    err:    '',
                    json:   rows,
                    length: rows.length
                });
                connection.release();
            });
        }
    });
});
app.get('/:estado/:cidade/:cinema/:genero/:filme', function(req,res){
    connectionpool.getConnection(function(err, connection) {
        var sql = "SELECT `estado`.`siglaEstado` AS `estado`, `cidade`.`nomeCidade` AS `cidade`, `cinema`.`nomeCinema` AS `cinema`,`filme`.`nomeDoFilme` AS `nome`, `filme`.`classificacaoEtaria` AS `classificacao`, `sessao`.`horario` AS `horario`, `sessao`.`preco` AS `preco`, `sessao`.`tipo_exibicao` AS `tipo_exibicao`, `sessao`.`e_3d` AS `e_3d`, `sessao`.`data` AS `data`, GROUP_CONCAT(`genero`.`nomeGenero` SEPARATOR ', ') AS `generos` FROM `filme` JOIN `filme_genero` ON `filme`.`idfilme` = `filme_genero`.`idfilme` JOIN `genero` ON `filme_genero`.`idgenero` = `genero`.`idgenero` JOIN `sessao` ON `sessao`.`idfilme` = `filme`.`idfilme` JOIN `cinema` ON `cinema`.`idcinema` = `sessao`.`idcinema` JOIN `endereco` ON `endereco`.`idendereco` = `cinema`.`idendereco` JOIN `cidade` ON `endereco`.`idcidade` = `cidade`.`idcidade`JOIN `estado` ON `estado`.`idestado` = `cidade`.`idestado`";
        var temFiltro = false;
        if (err) {
            console.error('CONNECTION error: ',err);
            res.statusCode = 503;
            res.send({
                result: 'error',
                err:    err.code
            });
        } else {
            if (req.params.filme != '-------') {
                sql +=existeFiltro(temFiltro);
                temFiltro = true;
                sql += "`filme`.`nomeDoFilme` = '"+req.params.filme+"'";
            }
            if (req.params.cinema != '-------') {
                sql +=existeFiltro(temFiltro);
                temFiltro = true;
                
                sql += "`cinema`.`nomeCinema` = '"+req.params.cinema+"'";
            } else {
                if (req.params.cidade != '-------') {
                    sql +=existeFiltro(temFiltro);
                    temFiltro = true;
                    sql += "`cidade`.`nomeCidade` = '"+req.params.cidade+"'";
                } else {
                    if (req.params.estado != '-------') {
                        sql +=existeFiltro(temFiltro);
                        temFiltro = true;
                        sql += "`estado`.`siglaEstado` = '"+req.params.estado+"'";
                    }
                }
            }
            sql += " GROUP BY `sessao`.`idsessao`"
            if (req.params.genero != '-------') {
                sql += " HAVING `generos` LIKE '%"+req.params.genero+"%'";
            }
            console.log('SQL: '+sql+'<=');
            connection.query(sql, req.params.id, function(err, rows, fields) {
                if (err) {
                    console.error(err);
                    res.statusCode = 500;
                    res.send({
                        result: 'error',
                        err:    err.code
                    });
                }
                res.header('Access-Control-Allow-Origin', '*');
                res.send({
                    result: 'success',
                    err:    '',
                    json:   rows,
                    length: rows.length
                });
                connection.release();
            });
        }
    });
});
 
app.listen(3000);
console.log('Rest Demo Listening on port 3000');
