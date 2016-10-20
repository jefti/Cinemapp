CREATE DATABASE  IF NOT EXISTS `cinemapp_bd` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `cinemapp_bd`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win32 (AMD64)
--
-- Host: localhost    Database: cinemapp_bd
-- ------------------------------------------------------
-- Server version	5.5.5-10.1.13-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cidade`
--

DROP TABLE IF EXISTS `cidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cidade` (
  `idcidade` int(11) NOT NULL AUTO_INCREMENT,
  `nomeCidade` varchar(45) NOT NULL,
  `idestado` int(11) NOT NULL,
  PRIMARY KEY (`idcidade`,`idestado`),
  KEY `fk_cidade_estado1_idx` (`idestado`),
  CONSTRAINT `fk_cidade_estado1` FOREIGN KEY (`idestado`) REFERENCES `estado` (`idestado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cidade`
--

LOCK TABLES `cidade` WRITE;
/*!40000 ALTER TABLE `cidade` DISABLE KEYS */;
INSERT INTO `cidade` VALUES (5,'Natal',5),(6,'Aracaju',6);
/*!40000 ALTER TABLE `cidade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cinema`
--

DROP TABLE IF EXISTS `cinema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cinema` (
  `idcinema` int(11) NOT NULL AUTO_INCREMENT,
  `nomeCinema` varchar(45) NOT NULL,
  `latitude` varchar(45) NOT NULL,
  `longitude` varchar(45) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `idendereco` int(11) NOT NULL,
  PRIMARY KEY (`idcinema`,`idendereco`),
  KEY `fk_cinema_endereco1_idx` (`idendereco`),
  CONSTRAINT `fk_cinema_endereco1` FOREIGN KEY (`idendereco`) REFERENCES `endereco` (`idendereco`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cinema`
--

LOCK TABLES `cinema` WRITE;
/*!40000 ALTER TABLE `cinema` DISABLE KEYS */;
INSERT INTO `cinema` VALUES (4,'Cinemark Midway Mall','-5.810457','-35.206555','(84) 3221-6571',2312),(5,'Cinemark Shopping Jardins','-10.9436232','-37.0600782','(79) 3217-5610',2313),(6,'Cinepolis Natal Shopping','-5.842221','-35.211424','(84) 3209-8199',2314);
/*!40000 ALTER TABLE `cinema` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `endereco`
--

DROP TABLE IF EXISTS `endereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `endereco` (
  `idendereco` int(11) NOT NULL AUTO_INCREMENT,
  `bairro` varchar(100) DEFAULT NULL,
  `logradouro` varchar(100) DEFAULT NULL,
  `numero` int(11) DEFAULT NULL,
  `idcidade` int(11) NOT NULL,
  PRIMARY KEY (`idendereco`,`idcidade`),
  KEY `fk_endereco_cidade1_idx` (`idcidade`),
  CONSTRAINT `fk_endereco_cidade1` FOREIGN KEY (`idcidade`) REFERENCES `cidade` (`idcidade`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2315 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `endereco`
--

LOCK TABLES `endereco` WRITE;
/*!40000 ALTER TABLE `endereco` DISABLE KEYS */;
INSERT INTO `endereco` VALUES (2312,'Centro','Av. Bernardo Vieira',3775,5),(2313,'Jardim','Av.Ministro Geraldo Barreto Sobral',215,6),(2314,'Candelaria','Av. Senador Salgado Filho',2234,5);
/*!40000 ALTER TABLE `endereco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado`
--

DROP TABLE IF EXISTS `estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estado` (
  `idestado` int(11) NOT NULL AUTO_INCREMENT,
  `siglaEstado` varchar(2) NOT NULL,
  PRIMARY KEY (`idestado`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado`
--

LOCK TABLES `estado` WRITE;
/*!40000 ALTER TABLE `estado` DISABLE KEYS */;
INSERT INTO `estado` VALUES (5,'RN'),(6,'SE');
/*!40000 ALTER TABLE `estado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filme`
--

DROP TABLE IF EXISTS `filme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filme` (
  `idfilme` int(11) NOT NULL AUTO_INCREMENT,
  `avaliacao` double NOT NULL,
  `nomeDoFilme` varchar(100) NOT NULL,
  `classificacaoEtaria` int(2) NOT NULL,
  `sinopse` varchar(1000) NOT NULL,
  `diretor` varchar(45) DEFAULT NULL,
  `elenco` varchar(45) DEFAULT NULL,
  `imagem` varchar(500) NOT NULL,
  PRIMARY KEY (`idfilme`)
) ENGINE=InnoDB AUTO_INCREMENT=612 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filme`
--

LOCK TABLES `filme` WRITE;
/*!40000 ALTER TABLE `filme` DISABLE KEYS */;
INSERT INTO `filme` VALUES (564,0,'É Fada!',12,'Uma fada tagarela e atrapalhada (Kéfera Buchmann) recebe a missão de ajudar uma jovem garota (Klara Castanho) que não acredita no mundo da magia.',NULL,NULL,'https://image.tmdb.org/t/p/w300_and_h450_bestv2/o5OfgLXvWydLL0IvOAPuSDijFxF.jpg'),(565,5.3,'Cegonhas - A História que Não te Contaram',0,'Todo mundo já sabe de onde vêm os bebês: eles são trazidos pelas cegonhas. Mas agora você vai conhecer a mega estrutura por trás desta fábrica de bebês: na verdade, as cegonhas controlam um grande empreendimento que enfrenta muitas dificuldades para coordenar todas as entregas nos horários e locais certos.',NULL,NULL,'https://image.tmdb.org/t/p/w300_and_h450_bestv2/pxD4pPwRmyY4z7MPFpZuNRnQ3rx.jpg'),(566,2,'Cinderela Baiana',0,'',NULL,NULL,'https://image.tmdb.org/t/p/w300_and_h450_bestv2/axky0gKIW2DSs2v3flPzTGOu0Ut.jpg'),(567,5.6,'Festa da Salsicha',16,'Dentro de um supermercado, os alimentos sonham em serem escolhidos pelas pessoas e se mudarem para as casas dos compradores. Mas eles nem suspeitam que serão cortados, ralados, cozidos e devorados! Quando uma salsicha descobre a terrível verdade, ela reúne outros alimentos com a tarefa de voltarem ao mercado e avisarem todos os colegas do risco que correm.',NULL,NULL,'https://image.tmdb.org/t/p/w300_and_h450_bestv2/AoBWBZwxbnfiUAwGPN8ctuR01wE.jpg'),(568,4.8,'Gênios do Crime',12,'A história gira em torno de Dave Ghantt (Zach Galifianakis), um guarda noturno de uma companhia de carros blindados no sul dos Estados Unidos que organiza um dos mais ousados assaltos a banco da história norte-americana. Mesmo sem ter experiência e contando com a ajuda dos colegas mais atrapalhados, ele consegue roubar 17 milhões de dólares. Baseado em uma história real.',NULL,NULL,'https://image.tmdb.org/t/p/w300_and_h450_bestv2/ckvMZK6b5HeIbUywqbLDY6BUFRX.jpg'),(569,4.9,'Inferno',12,'O renomado professor de simbologia de Harvard, Robert Langdon (Tom Hanks) visita a Itália e se envolve em mais uma aventura envolvendo símbolos ocultos e corporações secretas. Ele se vê em uma jornada em que procura desvendar os mistérios do clássico da literatura &quot;A Divina Comédia&quot;, de Dante Alighieri.',NULL,NULL,'https://image.tmdb.org/t/p/w300_and_h450_bestv2/d7FGOJuAfgCwypol5r1qs1OtqZr.jpg'),(570,6.1,'O Lar das Crianças Peculiares',12,'Do visionário diretor Tim Burton, e baseado no romance best-seller &quot;O Orfanato da Srta. Peregrine para Crianças Peculiares&quot;, chega uma experiência cinematográfica inesquecível. Quando seu querido avô deixa para Jacob (Asa Butterfield) pistas sobre um mistério que se estende por diferentes mundos e tempos, ele encontra um lugar mágico conhecido como O Lar das Crianças Peculiares. Mas o mistério e o perigo se aprofundam quando ele começa a conhecer os moradores e aprende sobre seus poderes especiais… e seus poderosos inimigos.',NULL,NULL,'https://image.tmdb.org/t/p/w300_and_h450_bestv2/5TiGmItHz4y6GqMN5zDEO67B8Ie.jpg'),(571,4.6,'Sete Homens e um Destino',14,'Refilmagem do clássico faroeste Sete Homens e um Destino (1960), que por sua vez é um remake de Os Sete Samurais, de Akira Kurosawa. Os habitantes de um pequeno vilarejo sofrem com os constantes ataques de um bando de pistoleiros. Revoltada com os saques, Emma Cullen (Haley Bennett) deseja justiça e pede auxílio ao pistoleiro Sam Chisolm (Denzel Washington), que reúne um grupo de especialistas para contra-atacar os bandidos.',NULL,NULL,'https://image.tmdb.org/t/p/w300_and_h450_bestv2/Fyvx5EmHYiACHoY0TTynlhrh07.jpg'),(572,0,'Tô Ryca',12,'Selminha (Samantha Schmütz) é uma frentista que tem a chance de deixar seus dias de pobreza para trás ao descobrir uma herança de família. Mas para conseguir colocar a mão nessa grana, ela terá que cumprir o desafio lançado por seu tio: Selminha precisa gastar 30 milhões de reais em 30 dias, sem acumular nada e nem contar para ninguém. Mas, nessa louca maratona, ela vai acabar descobrindo que tem coisas que o dinheiro não compra.',NULL,NULL,'https://image.tmdb.org/t/p/w300_and_h450_bestv2/2eKX2mFZsWtFWMDvStVlbVOeHfM.jpg'),(573,4.9,'A Maldição da Floresta',12,'O longa conta a história de uma família inglesa que vai morar em uma parte isolada da Irlanda. O intuito do pai é estudar a floresta para futuras construções. Mas sua ação acaba perturbando seres demoníacos que vivem no local e começam uma série de ataques contra a família.',NULL,NULL,'https://image.tmdb.org/t/p/w300_and_h450_bestv2/6NUTxX9p2X7DprrEoxLvZvjLNiu.jpg'),(574,0,'Assassino a Preço Fixo 2 – A Ressurreição',14,'O matador profissional Arthur Bishop (Statham) quer deixar seu passado negro para trás. No entanto, a sua paz dura pouco quando surge um trabalho: realizar três assassinatos impossíveis, que só ele é capaz de cometer',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(575,0,'FICI -  Tainá 2 - A Aventura Continua',0,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(576,0,'FICI - A Sociedade Secreta de Souptown',0,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(577,0,'FICI - Carrossel, o filme',0,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(578,0,'FICI - Heavysaurs, Dinossauros da Pesada',0,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(579,0,'FICI - Jack e a Mecânica do Coração',0,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(580,0,'FICI - Kikoriki, a turma invencível ',0,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(581,0,'FICI - Molly, a Monstrinha',0,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(582,0,'FICI - No Mundo da Lua',0,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(583,0,'FICI - O Pequeno Príncipe',0,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(584,0,'FICI - Pequenos que nem você',0,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(585,0,'FICI - Zootopia - Essa cidade é o bicho',0,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(586,7.1,'Kubo e as Cordas Mágicas',0,'Kubo vive uma normal e tranquila vida em uma pequena vila no Japão com sua mãe. Até que um espírito vingativo do passado muda completamente sua vida, ao fazer com que todos os tipos de deuses e monstros o persigam. Agora, para sobreviver, Kubo terá de encontrar uma armadura mágica que foi usada pelo seu falecido pai, um lendário guerreiro samurai.',NULL,NULL,'https://image.tmdb.org/t/p/w300_and_h450_bestv2/3Kr9CIIMcXTPlm6cdZ9y3QTe4Y7.jpg'),(587,7.4,'Zootopia',0,'Judy Hopps é a pequena coelha de uma fazenda isolada, filha de agricultores que plantam cenouras há décadas. Mas ela tem sonhos maiores: pretende se mudar para a cidade grande, Zootopia, onde todas as espécies de animais convivem em harmonia, na intenção de se tornar a primeira coelha policial. Judy enfrenta o preconceito e as manipulações dos outros animais, mas conta com a ajuda inesperada da raposa Nick Wilde, conhecida por sua malícia e suas infrações. A inesperada dupla se dedica à busca de um animal desaparecido, descobrindo uma conspiração que afeta toda a cidade.',NULL,NULL,'https://image.tmdb.org/t/p/w300_and_h450_bestv2/7RxLO0mzqy1GChHmx16zGWnuZal.jpg'),(588,0,'Inferno - O Filme',14,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(589,6.3,'O Bebê de Bridget Jones',12,'Depois de tantas idas e vindas, Bridget Jones (Renée Zellweger) e Mark (Colin Firth) finalmente se casam. Não demora muito, entretanto, para que a vida pregue mais uma peça neles e eles acabam se separando. Em crise no tabalho, tentando manter uma boa relação com o ex e engatando um novo romance (Patrick Dempsey), Bridget tem uma surpreendente revelação: está grávida - e não tem certeza de quem é o pai da criança.',NULL,NULL,'https://image.tmdb.org/t/p/w300_and_h450_bestv2/g0OC7EYa2VUGilDJFxFu7lSgCJW.jpg'),(590,8,'Chocolate',14,'',NULL,NULL,'https://image.tmdb.org/t/p/w300_and_h450_bestv2/bJJSyos810HNnkd3STt4jmVgJgT.jpg'),(591,0,'Deixe-me Viver de Luiz Sérgio',14,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(592,0,'Animais Fantásticos e Onde Habitam',0,'Baseado no livro homônimo de J.K. Rowling. O excêntrico magizoologista Newt Scamander (Eddie Redmayne) chega à cidade de Nova York com sua maleta, um objeto mágico onde ele carrega uma coleção de fantásticos animais do mundo da magia que coletou durante as suas viagens. Em meio a comunidade bruxa norte-americana que teme muito mais a exposição aos trouxas do que os ingleses, Newt precisará usar suas habilidades e conhecimentos para capturar uma variedade de criaturas que acabam saindo da sua maleta.',NULL,NULL,'https://image.tmdb.org/t/p/w300_and_h450_bestv2/pGjKVOxF8PirC2sXQLXSLh2nD0h.jpg'),(593,6.2,'O Contador de Histórias',14,'Anos 70. Aos 6 anos Roberto Carlos Ramos (Marco Ribeiro) foi escolhido por sua mãe (Jú Colombo) para ser interno em uma instituição oficial que, segundo apregoava a propaganda, visava a formação de crianças em médicos, advogados e engenheiros. Entretanto a realidade era bem diferente, o que fez com que Roberto aprendesse as regras de sobrevivência no local. Pouco depois de completar 7 anos ele é transferido, passando a conviver com crianças até 14 anos. Aos 13 anos, ainda analfabeto, Roberto tem contato com as drogas e já acumula mais de 100 tentativas de fuga. Considerado irrecuperável por muitos, Roberto recebe a visita da psicóloga francesa Margherit Duvas (Maria de Medeiros). Tratando-o com respeito, ela inicia o processo de recuperação e aprendizagem de Roberto.',NULL,NULL,'https://image.tmdb.org/t/p/w300_and_h450_bestv2/3wOi7xgVbGBrMUyJRVe0CY3L010.jpg'),(594,0,'O Shaolin do Sertão',12,'Durante a década de 80, lutadores de vale-tudo passam por dificuldades devido à falta de lutas profissionais. A fim de manter a paixão pela luta, eles desafiam os valentões no interior do Ceará que aceitam participar da competição criada. É assim que Aluiso Li (Edmilson Filho) vê a sua chance de ouro para realizar o sonho de se tornar um verdadeiro mestre das lutas como os heróis de seus filmes favoritos.',NULL,NULL,'https://image.tmdb.org/t/p/w300_and_h450_bestv2/b0QuOKWVsxXEFt24Ln1eBxlH3vS.jpg'),(595,0,'FICI - 9x Animação',0,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(596,0,'FICI - Anima Mundi para Crianças',0,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(597,0,'FICI - Histórias Animadas - Prêmio Brasil de Cinema Infantil ',0,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(598,0,'FICI - Histórias Curtas -  Prêmio Brasil de Cinema Infantil',0,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(599,0,'FICI - Molly, a Monstrinha - O Pequeno Jornalista',0,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(600,0,'FICI - Mostra Teen - Prêmio Brasil de Cinema Infantil ',0,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(601,0,'FICI - O Bom Dinossauro',0,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(602,0,'FICI - Te Vi na TV',0,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(603,0,'FICI - O Que Queremos para o Mundo?',0,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(604,0,'FICI - Tainá, A Origem',0,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(605,0,'Ouija - Origem do Mal',14,'Doris é uma garotinha solitária e pouco popular na escola. Sua mãe é especialista em aplicar golpes em clientes, fingindo se comunicar com espíritos. Mas quando Doris usa um tabuleiro de Ouija para se comunicar com o falecido pai, acaba liberando uma série de seres malignos que se apoderam de seu corpo e ameaçam todos ao redor.',NULL,NULL,'https://image.tmdb.org/t/p/w300_and_h450_bestv2/8bDJt4f1ooDY3vNWVoVjw8PvsGH.jpg'),(606,0,'FICI - Mostra Novos Jovens: O Escaravelho do Diabo',12,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(607,0,'FICI - Mostra Novos Jovens: O Menino no Espelho',0,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(608,0,'FICI - Lobos e Ovelhas',0,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(609,0,'FICI - Mune, O Guardião da Lua',0,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(610,0,'FICI - Dofus - Livro 1: Julith',0,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg'),(611,0,'FICI - Kikoriki, a Lenda do Dragão Dourado',0,'',NULL,NULL,'http://www2.trt8.jus.br/leilao/imagens/img_indisponivel.jpg');
/*!40000 ALTER TABLE `filme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filme_genero`
--

DROP TABLE IF EXISTS `filme_genero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filme_genero` (
  `idfilme` int(11) NOT NULL,
  `idgenero` int(11) NOT NULL,
  PRIMARY KEY (`idfilme`,`idgenero`),
  KEY `fk_temFilmeGenero_genero1_idx` (`idgenero`),
  CONSTRAINT `fk_temFilmeGenero_filme` FOREIGN KEY (`idfilme`) REFERENCES `filme` (`idfilme`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_temFilmeGenero_genero1` FOREIGN KEY (`idgenero`) REFERENCES `genero` (`idgenero`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filme_genero`
--

LOCK TABLES `filme_genero` WRITE;
/*!40000 ALTER TABLE `filme_genero` DISABLE KEYS */;
INSERT INTO `filme_genero` VALUES (564,35),(565,16),(565,35),(565,10751),(566,18),(567,12),(567,14),(567,16),(567,35),(568,28),(568,35),(568,80),(569,28),(569,53),(569,80),(569,9648),(570,14),(571,12),(571,28),(571,37),(572,35),(573,14),(573,27),(586,12),(586,14),(586,16),(586,10751),(587,12),(587,16),(587,35),(587,10751),(589,35),(589,10749),(590,18),(592,12),(592,14),(592,10751),(593,18),(594,35),(605,27),(605,53);
/*!40000 ALTER TABLE `filme_genero` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genero`
--

DROP TABLE IF EXISTS `genero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genero` (
  `idgenero` int(11) NOT NULL AUTO_INCREMENT,
  `nomeGenero` varchar(45) NOT NULL,
  PRIMARY KEY (`idgenero`)
) ENGINE=InnoDB AUTO_INCREMENT=10771 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genero`
--

LOCK TABLES `genero` WRITE;
/*!40000 ALTER TABLE `genero` DISABLE KEYS */;
INSERT INTO `genero` VALUES (12,'Aventura'),(14,'Fantasia'),(16,'Animação'),(18,'Drama'),(27,'Terror'),(28,'Ação'),(35,'Comédia'),(36,'História'),(37,'Faroeste'),(53,'Thriller'),(80,'Crime'),(99,'Documentário'),(878,'Ficção científica'),(9648,'Mistério'),(10402,'Música'),(10749,'Romance'),(10751,'Família'),(10752,'Guerra'),(10770,'Cinema TV');
/*!40000 ALTER TABLE `genero` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessao`
--

DROP TABLE IF EXISTS `sessao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessao` (
  `idsessao` int(11) NOT NULL AUTO_INCREMENT,
  `preco` varchar(45) NOT NULL,
  `horario` varchar(45) NOT NULL,
  `tipo_exibicao` varchar(45) NOT NULL,
  `e_3d` tinyint(1) NOT NULL,
  `data` varchar(5) DEFAULT NULL,
  `idcinema` int(11) NOT NULL,
  `idfilme` int(11) NOT NULL,
  `extras` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idsessao`,`idcinema`,`idfilme`),
  KEY `fk_sessao_cinema1_idx` (`idcinema`),
  KEY `fk_sessao_filme1_idx` (`idfilme`),
  CONSTRAINT `fk_sessao_cinema1` FOREIGN KEY (`idcinema`) REFERENCES `cinema` (`idcinema`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_sessao_filme1` FOREIGN KEY (`idfilme`) REFERENCES `filme` (`idfilme`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=16721 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessao`
--

LOCK TABLES `sessao` WRITE;
/*!40000 ALTER TABLE `sessao` DISABLE KEYS */;
INSERT INTO `sessao` VALUES (16074,'19,00','12h50','Dublado',0,'19/10',4,569,''),(16075,'19,00','15h40','Dublado',0,'19/10',4,569,''),(16076,'19,00','18h30','Dublado',0,'19/10',4,569,''),(16077,'19,00','21h20','Dublado',0,'19/10',4,569,''),(16078,'19,00','13h50','Legendado',0,'19/10',4,569,''),(16079,'19,00','16h40','Legendado',0,'19/10',4,569,''),(16080,'19,00','19h30','Legendado',0,'19/10',4,569,''),(16081,'19,00','22h20','Legendado',0,'19/10',4,569,''),(16082,'19,00','12h55','Legendado',0,'19/10',4,593,''),(16083,'19,00','15h50','Legendado',0,'19/10',4,593,''),(16084,'19,00','18h50','Legendado',0,'19/10',4,593,''),(16085,'19,00','21h50','Legendado',0,'19/10',4,593,''),(16086,'19,00','13h15','Dublado',0,'19/10',4,570,''),(16087,'19,00','16h20','Dublado',0,'19/10',4,570,''),(16088,'19,00','19h15','Dublado',0,'19/10',4,570,''),(16089,'19,00','22h10','Dublado',0,'19/10',4,570,''),(16090,'19,00','14h50','Nacional',0,'19/10',4,594,''),(16091,'19,00','17h30','Nacional',0,'19/10',4,594,''),(16092,'19,00','20h00','Nacional',0,'19/10',4,594,''),(16093,'19,00','22h30','Nacional',0,'19/10',4,594,''),(16094,'19,00','13h00','Nacional',0,'19/10',4,564,''),(16095,'19,00','14h00','Nacional',0,'19/10',4,564,''),(16096,'19,00','15h00','Nacional',0,'19/10',4,564,''),(16097,'19,00','16h10','Nacional',0,'19/10',4,564,''),(16098,'19,00','17h10','Nacional',0,'19/10',4,564,''),(16099,'19,00','18h20','Nacional',0,'19/10',4,564,''),(16100,'19,00','19h20','Nacional',0,'19/10',4,564,''),(16101,'19,00','20h30','Nacional',0,'19/10',4,564,''),(16102,'19,00','21h30','Nacional',0,'19/10',4,564,''),(16103,'23,00','14h00','Dublado',0,'20/10',4,565,''),(16104,'23,00','11h00','Dublado',0,'20/10',4,595,''),(16105,'23,00','13h00','Dublado',0,'20/10',4,596,''),(16106,'23,00','10h00','Nacional',0,'20/10',4,597,''),(16107,'23,00','14h00','Nacional',0,'20/10',4,598,''),(16108,'23,00','15h00','Dublado',0,'20/10',4,581,''),(16109,'23,00','10h00','Dublado',0,'20/10',4,599,''),(16110,'23,00','14h00','Dublado',0,'20/10',4,599,''),(16111,'23,00','16h00','Nacional',0,'20/10',4,600,''),(16112,'32,00','10h45','Dublado',1,'20/10',4,583,''),(16113,'32,00','18h30','Dublado',1,'20/10',4,583,''),(16114,'23,00','10h45','Dublado',0,'20/10',4,584,''),(16115,'26,00','18h30','Dublado',0,'20/10',4,569,''),(16116,'26,00','21h20','Dublado',0,'20/10',4,569,''),(16117,'23,00','13h50','Legendado',0,'20/10',4,569,''),(16118,'23,00','16h40','Legendado',0,'20/10',4,569,''),(16119,'26,00','19h30','Legendado',0,'20/10',4,569,''),(16120,'26,00','22h20','Legendado',0,'20/10',4,569,''),(16121,'23,00','12h55','Legendado',0,'20/10',4,593,''),(16122,'23,00','15h50','Legendado',0,'20/10',4,593,''),(16123,'26,00','18h50','Legendado',0,'20/10',4,593,''),(16124,'26,00','21h50','Legendado',0,'20/10',4,593,''),(16125,'23,00','16h30','Dublado',0,'20/10',4,570,''),(16126,'26,00','19h15','Dublado',0,'20/10',4,570,''),(16127,'26,00','22h10','Dublado',0,'20/10',4,570,''),(16128,'23,00','14h50','Nacional',0,'20/10',4,594,''),(16129,'26,00','17h30','Nacional',0,'20/10',4,594,''),(16130,'26,00','20h00','Nacional',0,'20/10',4,594,''),(16131,'26,00','22h30','Nacional',0,'20/10',4,594,''),(16132,'23,00','16h10','Nacional',0,'20/10',4,564,''),(16133,'26,00','18h20','Nacional',0,'20/10',4,564,''),(16134,'26,00','20h30','Nacional',0,'20/10',4,564,''),(16135,'26,00','21h30','Nacional',0,'20/10',4,564,''),(16136,'23,00','14h00','Dublado',0,'21/10',4,565,''),(16137,'26,00','17h30','Dublado',0,'21/10',4,576,''),(16138,'23,00','15h00','Dublado',0,'21/10',4,596,''),(16139,'23,00','16h30','Nacional',0,'21/10',4,577,''),(16140,'23,00','13h30','Dublado',0,'21/10',4,578,''),(16141,'23,00','15h30','Dublado',0,'21/10',4,581,''),(16142,'32,00','14h30','Dublado',1,'21/10',4,582,''),(16143,'32,00','12h30','Dublado',1,'21/10',4,601,''),(16144,'32,00','18h30','Dublado',1,'21/10',4,583,''),(16145,'23,00','13h10','Nacional',0,'21/10',4,602,''),(16146,'26,00','21h20','Dublado',0,'21/10',4,569,''),(16147,'23,00','13h50','Legendado',0,'21/10',4,569,''),(16148,'23,00','16h40','Legendado',0,'21/10',4,569,''),(16149,'26,00','19h30','Legendado',0,'21/10',4,569,''),(16150,'26,00','22h20','Legendado',0,'21/10',4,569,''),(16151,'23,00','13h01','Legendado',0,'21/10',4,593,''),(16152,'23,00','15h50','Legendado',0,'21/10',4,593,''),(16153,'26,00','18h50','Legendado',0,'21/10',4,593,''),(16154,'26,00','21h50','Legendado',0,'21/10',4,593,''),(16155,'23,00','16h30','Dublado',0,'21/10',4,570,''),(16156,'26,00','19h15','Dublado',0,'21/10',4,570,''),(16157,'26,00','22h10','Dublado',0,'21/10',4,570,''),(16158,'23,00','14h50','Nacional',0,'21/10',4,594,''),(16159,'26,00','17h30','Nacional',0,'21/10',4,594,''),(16160,'26,00','20h00','Nacional',0,'21/10',4,594,''),(16161,'26,00','22h30','Nacional',0,'21/10',4,594,''),(16162,'23,00','16h10','Nacional',0,'21/10',4,564,''),(16163,'26,00','18h20','Nacional',0,'21/10',4,564,''),(16164,'26,00','20h30','Nacional',0,'21/10',4,564,''),(16165,'26,00','21h30','Nacional',0,'21/10',4,564,''),(16166,'26,00','22h45','Nacional',0,'21/10',4,564,''),(16167,'23,00','14h00','Dublado',0,'22/10',4,565,''),(16168,'23,00','12h30','Dublado',0,'22/10',4,595,''),(16169,'23,00','11h30','Dublado',0,'22/10',4,576,''),(16170,'23,00','15h30','Dublado',0,'22/10',4,576,''),(16171,'23,00','13h00','Nacional',0,'22/10',4,577,''),(16172,'23,00','13h30','Dublado',0,'22/10',4,578,''),(16173,'26,00','18h30','Dublado',0,'22/10',4,578,''),(16174,'26,00','17h30','Dublado',0,'22/10',4,579,''),(16175,'23,00','10h30','Dublado',0,'22/10',4,580,''),(16176,'32,00','10h45','Dublado',1,'22/10',4,583,''),(16177,'32,00','14h00','Dublado',1,'22/10',4,583,''),(16178,'23,00','15h00','Nacional',0,'22/10',4,603,''),(16179,'23,00','10h45','Dublado',0,'22/10',4,584,''),(16180,'23,00','11h00','Nacional',0,'22/10',4,604,''),(16181,'32,00','16h10','Dublado',1,'22/10',4,585,''),(16182,'26,00','21h20','Dublado',0,'22/10',4,569,''),(16183,'23,00','13h50','Legendado',0,'22/10',4,569,''),(16184,'23,00','16h40','Legendado',0,'22/10',4,569,''),(16185,'26,00','19h30','Legendado',0,'22/10',4,569,''),(16186,'26,00','22h20','Legendado',0,'22/10',4,569,''),(16187,'23,00','12h55','Legendado',0,'22/10',4,593,''),(16188,'23,00','15h50','Legendado',0,'22/10',4,593,''),(16189,'26,00','18h50','Legendado',0,'22/10',4,593,''),(16190,'26,00','21h50','Legendado',0,'22/10',4,593,''),(16191,'23,00','16h30','Dublado',0,'22/10',4,570,''),(16192,'26,00','19h15','Dublado',0,'22/10',4,570,''),(16193,'26,00','22h10','Dublado',0,'22/10',4,570,''),(16194,'23,00','14h50','Nacional',0,'22/10',4,594,''),(16195,'26,00','17h30','Nacional',0,'22/10',4,594,''),(16196,'26,00','20h00','Nacional',0,'22/10',4,594,''),(16197,'26,00','22h30','Nacional',0,'22/10',4,594,''),(16198,'23,00','16h10','Nacional',0,'22/10',4,564,''),(16199,'26,00','18h20','Nacional',0,'22/10',4,564,''),(16200,'26,00','20h30','Nacional',0,'22/10',4,564,''),(16201,'26,00','21h30','Nacional',0,'22/10',4,564,''),(16202,'23,00','13h05','Dublado',0,'23/10',4,569,''),(16203,'23,00','15h40','Dublado',0,'23/10',4,569,''),(16204,'26,00','18h30','Dublado',0,'23/10',4,569,''),(16205,'26,00','21h20','Dublado',0,'23/10',4,569,''),(16206,'26,00','19h30','Legendado',0,'23/10',4,569,''),(16207,'26,00','22h20','Legendado',0,'23/10',4,569,''),(16208,'23,00','12h55','Legendado',0,'23/10',4,593,''),(16209,'23,00','15h50','Legendado',0,'23/10',4,593,''),(16210,'26,00','18h50','Legendado',0,'23/10',4,593,''),(16211,'26,00','21h50','Legendado',0,'23/10',4,593,''),(16212,'23,00','13h15','Dublado',0,'23/10',4,570,''),(16213,'23,00','16h20','Dublado',0,'23/10',4,570,''),(16214,'26,00','19h15','Dublado',0,'23/10',4,570,''),(16215,'26,00','22h10','Dublado',0,'23/10',4,570,''),(16216,'23,00','14h50','Nacional',0,'23/10',4,594,''),(16217,'26,00','17h30','Nacional',0,'23/10',4,594,''),(16218,'26,00','20h00','Nacional',0,'23/10',4,594,''),(16219,'26,00','22h30','Nacional',0,'23/10',4,594,''),(16220,'23,00','14h00','Nacional',0,'23/10',4,564,''),(16221,'23,00','15h00','Nacional',0,'23/10',4,564,''),(16222,'23,00','16h10','Nacional',0,'23/10',4,564,''),(16223,'26,00','17h10','Nacional',0,'23/10',4,564,''),(16224,'26,00','18h20','Nacional',0,'23/10',4,564,''),(16225,'26,00','19h20','Nacional',0,'23/10',4,564,''),(16226,'26,00','20h30','Nacional',0,'23/10',4,564,''),(16227,'26,00','21h30','Nacional',0,'23/10',4,564,''),(16228,'18,00','13h05','Dublado',0,'24/10',4,569,''),(16229,'18,00','15h40','Dublado',0,'24/10',4,569,''),(16230,'21,00','18h30','Dublado',0,'24/10',4,569,''),(16231,'21,00','21h20','Dublado',0,'24/10',4,569,''),(16232,'21,00','19h30','Legendado',0,'24/10',4,569,''),(16233,'21,00','22h20','Legendado',0,'24/10',4,569,''),(16234,'18,00','12h55','Legendado',0,'24/10',4,593,''),(16235,'18,00','15h50','Legendado',0,'24/10',4,593,''),(16236,'21,00','18h50','Legendado',0,'24/10',4,593,''),(16237,'21,00','21h50','Legendado',0,'24/10',4,593,''),(16238,'18,00','13h15','Dublado',0,'24/10',4,570,''),(16239,'18,00','16h20','Dublado',0,'24/10',4,570,''),(16240,'21,00','19h15','Dublado',0,'24/10',4,570,''),(16241,'21,00','22h10','Dublado',0,'24/10',4,570,''),(16242,'21,00','20h00','Nacional',0,'24/10',4,594,''),(16243,'21,00','22h30','Nacional',0,'24/10',4,594,''),(16244,'18,00','14h00','Nacional',0,'24/10',4,564,''),(16245,'18,00','16h10','Nacional',0,'24/10',4,564,''),(16246,'21,00','18h20','Nacional',0,'24/10',4,564,''),(16247,'21,00','19h20','Nacional',0,'24/10',4,564,''),(16248,'21,00','20h30','Nacional',0,'24/10',4,564,''),(16249,'21,00','21h30','Nacional',0,'24/10',4,564,''),(16250,'18,00','13h05','Dublado',0,'25/10',4,569,''),(16251,'18,00','15h40','Dublado',0,'25/10',4,569,''),(16252,'21,00','18h30','Dublado',0,'25/10',4,569,''),(16253,'21,00','21h20','Dublado',0,'25/10',4,569,''),(16254,'21,00','19h30','Legendado',0,'25/10',4,569,''),(16255,'21,00','22h20','Legendado',0,'25/10',4,569,''),(16256,'18,00','12h55','Legendado',0,'25/10',4,593,''),(16257,'18,00','15h50','Legendado',0,'25/10',4,593,''),(16258,'21,00','18h50','Legendado',0,'25/10',4,593,''),(16259,'21,00','21h50','Legendado',0,'25/10',4,593,''),(16260,'18,00','13h15','Dublado',0,'25/10',4,570,''),(16261,'18,00','16h20','Dublado',0,'25/10',4,570,''),(16262,'21,00','19h15','Dublado',0,'25/10',4,570,''),(16263,'21,00','22h10','Dublado',0,'25/10',4,570,''),(16264,'21,00','20h00','Nacional',0,'25/10',4,594,''),(16265,'21,00','22h30','Nacional',0,'25/10',4,594,''),(16266,'18,00','14h00','Nacional',0,'25/10',4,564,''),(16267,'18,00','16h10','Nacional',0,'25/10',4,564,''),(16268,'21,00','18h20','Nacional',0,'25/10',4,564,''),(16269,'21,00','19h20','Nacional',0,'25/10',4,564,''),(16270,'21,00','20h30','Nacional',0,'25/10',4,564,''),(16271,'21,00','21h30','Nacional',0,'25/10',4,564,''),(16272,'22,00','17h55','Dublado',0,'19/10',5,574,''),(16273,'22,00','20h40','Dublado',0,'19/10',5,574,''),(16274,'22,00','16h30','Dublado',0,'19/10',5,565,''),(16275,'22,00','21h40','Dublado',0,'19/10',5,568,''),(16276,'22,00','14h10','Dublado',0,'19/10',5,569,''),(16277,'22,00','16h50','Dublado',0,'19/10',5,569,''),(16278,'22,00','19h30','Dublado',0,'19/10',5,569,''),(16279,'22,00','22h20','Dublado',0,'19/10',5,569,''),(16280,'22,00','14h00','Dublado',0,'19/10',5,586,''),(16281,'22,00','12h40','Dublado',0,'19/10',5,593,''),(16282,'22,00','15h40','Dublado',0,'19/10',5,593,''),(16283,'22,00','18h40','Dublado',0,'19/10',5,593,''),(16284,'22,00','21h30','Dublado',0,'19/10',5,593,''),(16285,'22,00','18h20','Dublado',0,'19/10',5,570,''),(16286,'22,00','19h10','Dublado',0,'19/10',5,570,''),(16287,'22,00','22h10','Dublado',0,'19/10',5,570,''),(16288,'22,00','12h50','Nacional',0,'19/10',5,594,''),(16289,'22,00','15h20','Nacional',0,'19/10',5,594,''),(16290,'22,00','17h50','Nacional',0,'19/10',5,594,''),(16291,'22,00','20h30','Nacional',0,'19/10',5,594,''),(16292,'22,00','13h20','Dublado',0,'19/10',5,605,''),(16293,'22,00','16h00','Dublado',0,'19/10',5,605,''),(16294,'22,00','18h30','Dublado',0,'19/10',5,605,''),(16295,'22,00','21h00','Dublado',0,'19/10',5,605,''),(16296,'22,00','18h50','Nacional',0,'19/10',5,572,''),(16297,'22,00','21h20','Nacional',0,'19/10',5,572,''),(16298,'22,00','14h30','Nacional',0,'19/10',5,564,''),(16299,'22,00','17h05','Nacional',0,'19/10',5,564,''),(16300,'22,00','19h50','Nacional',0,'19/10',5,564,''),(16301,'22,00','22h00','Nacional',0,'19/10',5,564,''),(16302,'26,00','20h10','Dublado',0,'20/10',5,574,''),(16303,'26,00','22h30','Dublado',0,'20/10',5,574,''),(16304,'24,00','16h30','Dublado',0,'20/10',5,565,''),(16305,'24,00','13h00','Dublado',0,'20/10',5,595,''),(16306,'24,00','11h00','Dublado',0,'20/10',5,596,''),(16307,'26,00','18h30','Nacional',0,'20/10',5,577,''),(16308,'26,00','17h30','Dublado',0,'20/10',5,579,''),(16309,'24,00','15h00','Dublado',0,'20/10',5,581,''),(16310,'24,00','09h30','Dublado',0,'20/10',5,599,''),(16311,'24,00','14h00','Dublado',0,'20/10',5,599,''),(16312,'24,00','09h30','Nacional',0,'20/10',5,606,''),(16313,'24,00','14h00','Nacional',0,'20/10',5,607,''),(16314,'31,00','10h45','Dublado',1,'20/10',5,583,''),(16315,'24,00','10h45','Dublado',0,'20/10',5,584,''),(16316,'24,00','14h10','Dublado',0,'20/10',5,569,''),(16317,'24,00','16h50','Dublado',0,'20/10',5,569,''),(16318,'26,00','19h30','Dublado',0,'20/10',5,569,''),(16319,'26,00','22h20','Dublado',0,'20/10',5,569,''),(16320,'24,00','14h00','Dublado',0,'20/10',5,586,''),(16321,'24,00','12h40','Dublado',0,'20/10',5,593,''),(16322,'24,00','15h40','Dublado',0,'20/10',5,593,''),(16323,'26,00','18h45','Dublado',0,'20/10',5,593,''),(16324,'26,00','21h30','Dublado',0,'20/10',5,593,''),(16325,'26,00','17h10','Dublado',0,'20/10',5,570,''),(16326,'26,00','20h00','Dublado',0,'20/10',5,570,''),(16327,'26,00','20h40','Dublado',0,'20/10',5,570,''),(16328,'24,00','12h50','Nacional',0,'20/10',5,594,''),(16329,'24,00','15h20','Nacional',0,'20/10',5,594,''),(16330,'26,00','17h50','Nacional',0,'20/10',5,594,''),(16331,'26,00','20h30','Nacional',0,'20/10',5,594,''),(16332,'24,00','13h20','Dublado',0,'20/10',5,605,''),(16333,'24,00','16h00','Dublado',0,'20/10',5,605,''),(16334,'26,00','18h40','Dublado',0,'20/10',5,605,''),(16335,'26,00','21h10','Dublado',0,'20/10',5,605,''),(16336,'26,00','18h50','Nacional',0,'20/10',5,572,''),(16337,'26,00','21h20','Nacional',0,'20/10',5,572,''),(16338,'24,00','13h05','Nacional',0,'20/10',5,564,''),(16339,'24,00','15h25','Nacional',0,'20/10',5,564,''),(16340,'26,00','17h40','Nacional',0,'20/10',5,564,''),(16341,'26,00','19h50','Nacional',0,'20/10',5,564,''),(16342,'26,00','22h00','Nacional',0,'20/10',5,564,''),(16343,'26,00','20h10','Dublado',0,'21/10',5,574,''),(16344,'26,00','22h30','Dublado',0,'21/10',5,574,''),(16345,'24,00','16h35','Dublado',0,'21/10',5,565,''),(16346,'24,00','11h20','Dublado',0,'21/10',5,566,''),(16347,'24,00','15h00','Dublado',0,'21/10',5,595,''),(16348,'24,00','11h30','Dublado',0,'21/10',5,576,''),(16349,'26,00','17h30','Dublado',0,'21/10',5,576,''),(16350,'24,00','13h30','Dublado',0,'21/10',5,578,''),(16351,'24,00','15h30','Dublado',0,'21/10',5,579,''),(16352,'24,00','10h30','Dublado',0,'21/10',5,580,''),(16353,'31,00','14h30','Dublado',1,'21/10',5,608,''),(16354,'24,00','13h00','Dublado',0,'21/10',5,581,''),(16355,'31,00','16h30','Dublado',1,'21/10',5,609,''),(16356,'31,00','10h45','Dublado',1,'21/10',5,583,''),(16357,'24,00','10h45','Dublado',0,'21/10',5,584,''),(16358,'24,00','11h00','Nacional',0,'21/10',5,604,''),(16359,'24,00','12h30','Nacional',0,'21/10',5,602,''),(16360,'31,00','18h30','Dublado',1,'21/10',5,585,''),(16361,'26,00','21h10','Dublado',0,'21/10',5,568,''),(16362,'24,00','14h10','Dublado',0,'21/10',5,569,''),(16363,'24,00','16h50','Dublado',0,'21/10',5,569,''),(16364,'26,00','19h30','Dublado',0,'21/10',5,569,''),(16365,'26,00','22h20','Dublado',0,'21/10',5,569,''),(16366,'24,00','14h00','Dublado',0,'21/10',5,586,''),(16367,'24,00','12h40','Dublado',0,'21/10',5,593,''),(16368,'24,00','15h40','Dublado',0,'21/10',5,593,''),(16369,'26,00','18h45','Dublado',0,'21/10',5,593,''),(16370,'26,00','21h30','Dublado',0,'21/10',5,593,''),(16371,'26,00','17h10','Dublado',0,'21/10',5,570,''),(16372,'26,00','20h10','Dublado',0,'21/10',5,570,''),(16373,'24,00','12h50','Nacional',0,'21/10',5,594,''),(16374,'24,00','15h20','Nacional',0,'21/10',5,594,''),(16375,'26,00','17h50','Nacional',0,'21/10',5,594,''),(16376,'26,00','20h30','Nacional',0,'21/10',5,594,''),(16377,'26,00','23h10','Nacional',0,'21/10',5,594,''),(16378,'24,00','13h20','Dublado',0,'21/10',5,605,''),(16379,'24,00','16h00','Dublado',0,'21/10',5,605,''),(16380,'26,00','18h35','Dublado',0,'21/10',5,605,''),(16381,'26,00','21h00','Dublado',0,'21/10',5,605,''),(16382,'26,00','23h20','Dublado',0,'21/10',5,605,''),(16383,'26,00','18h50','Nacional',0,'21/10',5,572,''),(16384,'26,00','21h20','Nacional',0,'21/10',5,572,''),(16385,'24,00','13h05','Nacional',0,'21/10',5,564,''),(16386,'24,00','15h25','Nacional',0,'21/10',5,564,''),(16387,'26,00','17h40','Nacional',0,'21/10',5,564,''),(16388,'26,00','19h50','Nacional',0,'21/10',5,564,''),(16389,'26,00','22h00','Nacional',0,'21/10',5,564,''),(16390,'26,00','20h50','Dublado',0,'22/10',5,574,''),(16391,'24,00','16h35','Dublado',0,'22/10',5,565,''),(16392,'24,00','11h20','Dublado',0,'22/10',5,566,''),(16393,'24,00','11h00','Dublado',0,'22/10',5,595,''),(16394,'24,00','15h30','Dublado',0,'22/10',5,576,''),(16395,'24,00','13h00','Dublado',0,'22/10',5,596,''),(16396,'24,00','12h30','Nacional',0,'22/10',5,577,''),(16397,'24,00','16h30','Dublado',0,'22/10',5,610,''),(16398,'26,00','17h30','Dublado',0,'22/10',5,578,''),(16399,'24,00','11h30','Dublado',0,'22/10',5,579,''),(16400,'24,00','14h30','Dublado',0,'22/10',5,611,''),(16401,'24,00','13h30','Dublado',0,'22/10',5,581,''),(16402,'31,00','18h30','Dublado',1,'22/10',5,582,''),(16403,'31,00','10h30','Dublado',1,'22/10',5,601,''),(16404,'31,00','10h45','Dublado',1,'22/10',5,583,''),(16405,'24,00','10h45','Dublado',0,'22/10',5,584,''),(16406,'24,00','15h00','Dublado',0,'22/10',5,584,''),(16407,'26,00','20h50','Dublado',0,'22/10',5,568,''),(16408,'24,00','11h35','Dublado',0,'22/10',5,569,''),(16409,'24,00','14h10','Dublado',0,'22/10',5,569,''),(16410,'24,00','16h50','Dublado',0,'22/10',5,569,''),(16411,'26,00','19h30','Dublado',0,'22/10',5,569,''),(16412,'26,00','22h20','Dublado',0,'22/10',5,569,''),(16413,'24,00','14h00','Dublado',0,'22/10',5,586,''),(16414,'24,00','12h40','Dublado',0,'22/10',5,593,''),(16415,'24,00','15h40','Dublado',0,'22/10',5,593,''),(16416,'26,00','18h45','Dublado',0,'22/10',5,593,''),(16417,'26,00','21h30','Dublado',0,'22/10',5,593,''),(16418,'26,00','17h10','Dublado',0,'22/10',5,570,''),(16419,'26,00','20h10','Dublado',0,'22/10',5,570,''),(16420,'24,00','12h50','Nacional',0,'22/10',5,594,''),(16421,'24,00','15h20','Nacional',0,'22/10',5,594,''),(16422,'26,00','17h50','Nacional',0,'22/10',5,594,''),(16423,'26,00','20h30','Nacional',0,'22/10',5,594,''),(16424,'24,00','13h20','Dublado',0,'22/10',5,605,''),(16425,'24,00','16h00','Dublado',0,'22/10',5,605,''),(16426,'26,00','18h40','Dublado',0,'22/10',5,605,''),(16427,'26,00','21h10','Dublado',0,'22/10',5,605,''),(16428,'26,00','18h50','Nacional',0,'22/10',5,572,''),(16429,'26,00','21h20','Nacional',0,'22/10',5,572,''),(16430,'24,00','13h05','Nacional',0,'22/10',5,564,''),(16431,'24,00','15h25','Nacional',0,'22/10',5,564,''),(16432,'26,00','17h40','Nacional',0,'22/10',5,564,''),(16433,'26,00','19h50','Nacional',0,'22/10',5,564,''),(16434,'26,00','22h00','Nacional',0,'22/10',5,564,''),(16435,'24,00','13h30','Dublado',0,'23/10',5,574,''),(16436,'24,00','15h50','Dublado',0,'23/10',5,574,''),(16437,'26,00','18h20','Dublado',0,'23/10',5,574,''),(16438,'26,00','20h50','Dublado',0,'23/10',5,574,''),(16439,'24,00','16h30','Dublado',0,'23/10',5,565,''),(16440,'24,00','13h50','Dublado',0,'23/10',5,567,''),(16441,'24,00','15h50','Dublado',0,'23/10',5,568,''),(16442,'26,00','21h40','Dublado',0,'23/10',5,568,''),(16443,'24,00','14h10','Dublado',0,'23/10',5,569,''),(16444,'24,00','16h50','Dublado',0,'23/10',5,569,''),(16445,'26,00','19h30','Dublado',0,'23/10',5,569,''),(16446,'26,00','22h20','Dublado',0,'23/10',5,569,''),(16447,'24,00','14h00','Dublado',0,'23/10',5,586,''),(16448,'24,00','12h40','Dublado',0,'23/10',5,593,''),(16449,'24,00','15h40','Dublado',0,'23/10',5,593,''),(16450,'26,00','18h40','Dublado',0,'23/10',5,593,''),(16451,'26,00','21h30','Dublado',0,'23/10',5,593,''),(16452,'26,00','18h20','Dublado',0,'23/10',5,570,''),(16453,'26,00','19h10','Dublado',0,'23/10',5,570,''),(16454,'26,00','22h10','Dublado',0,'23/10',5,570,''),(16455,'24,00','12h50','Nacional',0,'23/10',5,594,''),(16456,'24,00','15h20','Nacional',0,'23/10',5,594,''),(16457,'26,00','17h50','Nacional',0,'23/10',5,594,''),(16458,'26,00','20h30','Nacional',0,'23/10',5,594,''),(16459,'24,00','13h20','Dublado',0,'23/10',5,605,''),(16460,'24,00','16h00','Dublado',0,'23/10',5,605,''),(16461,'26,00','18h30','Dublado',0,'23/10',5,605,''),(16462,'26,00','21h00','Dublado',0,'23/10',5,605,''),(16463,'26,00','18h50','Nacional',0,'23/10',5,572,''),(16464,'26,00','21h20','Nacional',0,'23/10',5,572,''),(16465,'24,00','13h05','Nacional',0,'23/10',5,564,''),(16466,'24,00','14h30','Nacional',0,'23/10',5,564,''),(16467,'24,00','15h25','Nacional',0,'23/10',5,564,''),(16468,'26,00','17h05','Nacional',0,'23/10',5,564,''),(16469,'26,00','17h40','Nacional',0,'23/10',5,564,''),(16470,'26,00','19h50','Nacional',0,'23/10',5,564,''),(16471,'26,00','22h00','Nacional',0,'23/10',5,564,''),(16472,'21,00','13h30','Dublado',0,'24/10',5,574,''),(16473,'21,00','15h50','Dublado',0,'24/10',5,574,''),(16474,'23,00','18h20','Dublado',0,'24/10',5,574,''),(16475,'23,00','20h50','Dublado',0,'24/10',5,574,''),(16476,'21,00','16h30','Dublado',0,'24/10',5,565,''),(16477,'21,00','13h50','Dublado',0,'24/10',5,567,''),(16478,'21,00','15h50','Dublado',0,'24/10',5,568,''),(16479,'23,00','21h40','Dublado',0,'24/10',5,568,''),(16480,'21,00','14h10','Dublado',0,'24/10',5,569,''),(16481,'21,00','16h50','Dublado',0,'24/10',5,569,''),(16482,'23,00','19h30','Dublado',0,'24/10',5,569,''),(16483,'23,00','22h20','Dublado',0,'24/10',5,569,''),(16484,'21,00','14h00','Dublado',0,'24/10',5,586,''),(16485,'21,00','12h40','Dublado',0,'24/10',5,593,''),(16486,'21,00','15h40','Dublado',0,'24/10',5,593,''),(16487,'23,00','18h40','Dublado',0,'24/10',5,593,''),(16488,'23,00','21h30','Dublado',0,'24/10',5,593,''),(16489,'23,00','18h20','Dublado',0,'24/10',5,570,''),(16490,'23,00','19h10','Dublado',0,'24/10',5,570,''),(16491,'23,00','22h10','Dublado',0,'24/10',5,570,''),(16492,'21,00','12h50','Nacional',0,'24/10',5,594,''),(16493,'21,00','15h20','Nacional',0,'24/10',5,594,''),(16494,'23,00','17h50','Nacional',0,'24/10',5,594,''),(16495,'23,00','20h30','Nacional',0,'24/10',5,594,''),(16496,'21,00','13h20','Dublado',0,'24/10',5,605,''),(16497,'21,00','16h00','Dublado',0,'24/10',5,605,''),(16498,'23,00','18h30','Dublado',0,'24/10',5,605,''),(16499,'23,00','21h00','Dublado',0,'24/10',5,605,''),(16500,'23,00','18h50','Nacional',0,'24/10',5,572,''),(16501,'23,00','21h20','Nacional',0,'24/10',5,572,''),(16502,'21,00','13h05','Nacional',0,'24/10',5,564,''),(16503,'21,00','14h30','Nacional',0,'24/10',5,564,''),(16504,'21,00','15h25','Nacional',0,'24/10',5,564,''),(16505,'23,00','17h05','Nacional',0,'24/10',5,564,''),(16506,'23,00','17h40','Nacional',0,'24/10',5,564,''),(16507,'23,00','19h50','Nacional',0,'24/10',5,564,''),(16508,'23,00','22h00','Nacional',0,'24/10',5,564,''),(16509,'21,00','13h30','Dublado',0,'25/10',5,574,''),(16510,'21,00','15h50','Dublado',0,'25/10',5,574,''),(16511,'23,00','18h20','Dublado',0,'25/10',5,574,''),(16512,'23,00','20h50','Dublado',0,'25/10',5,574,''),(16513,'21,00','16h30','Dublado',0,'25/10',5,565,''),(16514,'21,00','13h50','Dublado',0,'25/10',5,567,''),(16515,'21,00','15h50','Dublado',0,'25/10',5,568,''),(16516,'23,00','21h40','Dublado',0,'25/10',5,568,''),(16517,'21,00','14h10','Dublado',0,'25/10',5,569,''),(16518,'21,00','16h50','Dublado',0,'25/10',5,569,''),(16519,'23,00','19h30','Dublado',0,'25/10',5,569,''),(16520,'23,00','22h20','Dublado',0,'25/10',5,569,''),(16521,'21,00','14h00','Dublado',0,'25/10',5,586,''),(16522,'21,00','12h40','Dublado',0,'25/10',5,593,''),(16523,'21,00','15h40','Dublado',0,'25/10',5,593,''),(16524,'23,00','18h40','Dublado',0,'25/10',5,593,''),(16525,'23,00','21h30','Dublado',0,'25/10',5,593,''),(16526,'23,00','18h20','Dublado',0,'25/10',5,570,''),(16527,'23,00','19h10','Dublado',0,'25/10',5,570,''),(16528,'23,00','22h10','Dublado',0,'25/10',5,570,''),(16529,'21,00','12h50','Nacional',0,'25/10',5,594,''),(16530,'21,00','15h20','Nacional',0,'25/10',5,594,''),(16531,'23,00','17h50','Nacional',0,'25/10',5,594,''),(16532,'23,00','20h30','Nacional',0,'25/10',5,594,''),(16533,'21,00','13h20','Dublado',0,'25/10',5,605,''),(16534,'21,00','16h00','Dublado',0,'25/10',5,605,''),(16535,'23,00','18h30','Dublado',0,'25/10',5,605,''),(16536,'23,00','21h00','Dublado',0,'25/10',5,605,''),(16537,'23,00','18h50','Nacional',0,'25/10',5,572,''),(16538,'23,00','21h20','Nacional',0,'25/10',5,572,''),(16539,'21,00','13h05','Nacional',0,'25/10',5,564,''),(16540,'21,00','14h30','Nacional',0,'25/10',5,564,''),(16541,'21,00','15h25','Nacional',0,'25/10',5,564,''),(16542,'23,00','17h05','Nacional',0,'25/10',5,564,''),(16543,'23,00','17h40','Nacional',0,'25/10',5,564,''),(16544,'23,00','19h50','Nacional',0,'25/10',5,564,''),(16545,'23,00','22h00','Nacional',0,'25/10',5,564,''),(16546,'25,00','16h20','',1,'19/10',6,570,''),(16547,'25,00','19h10','',1,'19/10',6,570,''),(16548,'25,00','22h10','',1,'19/10',6,570,''),(16549,'22,00','16h00','',0,'19/10',6,588,'MacroXE'),(16550,'22,00','18h40','',0,'19/10',6,588,'MacroXE'),(16551,'22,00','21h20','',0,'19/10',6,588,'MacroXE'),(16552,'34,00','14h20','',0,'19/10',6,588,'VIP'),(16553,'34,00','19h50','',0,'19/10',6,588,'VIP'),(16554,'19,00','16h40','',0,'19/10',6,594,''),(16555,'19,00','22h00','',0,'19/10',6,594,''),(16556,'34,00','17h00','',0,'19/10',6,593,'VIP'),(16557,'34,00','22h25','',0,'19/10',6,593,'VIP'),(16558,'19,00','15h50','',0,'19/10',6,593,''),(16559,'19,00','18h40','',0,'19/10',6,593,''),(16560,'19,00','21h30','',0,'19/10',6,593,''),(16561,'19,00','13h50','',0,'19/10',6,586,''),(16562,'19,00','15h30','',0,'19/10',6,564,''),(16563,'19,00','18h10','',0,'19/10',6,564,''),(16564,'19,00','20h20','',0,'19/10',6,564,''),(16565,'19,00','14h00','',0,'19/10',6,591,''),(16566,'31,00','16h20','',1,'20/10',6,570,''),(16567,'31,00','19h10','',1,'20/10',6,570,''),(16568,'31,00','22h10','',1,'20/10',6,570,''),(16569,'26,00','16h00','',0,'20/10',6,588,'MacroXE'),(16570,'29,00','18h40','',0,'20/10',6,588,'MacroXE'),(16571,'29,00','21h20','',0,'20/10',6,588,'MacroXE'),(16572,'45,00','14h20','',0,'20/10',6,588,'VIP'),(16573,'45,00','19h50','',0,'20/10',6,588,'VIP'),(16574,'23,00','16h40','',0,'20/10',6,594,''),(16575,'26,00','22h00','',0,'20/10',6,594,''),(16576,'45,00','17h00','',0,'20/10',6,593,'VIP'),(16577,'45,00','22h25','',0,'20/10',6,593,'VIP'),(16578,'23,00','15h50','',0,'20/10',6,593,''),(16579,'26,00','18h40','',0,'20/10',6,593,''),(16580,'26,00','21h30','',0,'20/10',6,593,''),(16581,'23,00','13h50','',0,'20/10',6,586,''),(16582,'23,00','15h30','',0,'20/10',6,564,''),(16583,'26,00','18h10','',0,'20/10',6,564,''),(16584,'26,00','20h20','',0,'20/10',6,564,''),(16585,'23,00','14h00','',0,'20/10',6,591,''),(16586,'31,00','16h20','',1,'21/10',6,570,''),(16587,'31,00','19h10','',1,'21/10',6,570,''),(16588,'31,00','22h10','',1,'21/10',6,570,''),(16589,'26,00','13h30','',0,'21/10',6,588,'MacroXE'),(16590,'26,00','16h00','',0,'21/10',6,588,'MacroXE'),(16591,'29,00','18h40','',0,'21/10',6,588,'MacroXE'),(16592,'29,00','21h20','',0,'21/10',6,588,'MacroXE'),(16593,'45,00','14h20','',0,'21/10',6,588,'VIP'),(16594,'45,00','19h50','',0,'21/10',6,588,'VIP'),(16595,'23,00','16h40','',0,'21/10',6,594,''),(16596,'26,00','22h00','',0,'21/10',6,594,''),(16597,'45,00','17h00','',0,'21/10',6,593,'VIP'),(16598,'45,00','22h25','',0,'21/10',6,593,'VIP'),(16599,'23,00','13h00','',0,'21/10',6,593,''),(16600,'23,00','15h50','',0,'21/10',6,593,''),(16601,'26,00','18h40','',0,'21/10',6,593,''),(16602,'26,00','21h30','',0,'21/10',6,593,''),(16603,'23,00','13h50','',0,'21/10',6,586,''),(16604,'23,00','13h20','',0,'21/10',6,564,''),(16605,'23,00','15h30','',0,'21/10',6,564,''),(16606,'26,00','18h10','',0,'21/10',6,564,''),(16607,'26,00','20h20','',0,'21/10',6,564,''),(16608,'26,00','19h30','',0,'21/10',6,591,''),(16609,'31,00','16h20','',1,'22/10',6,570,''),(16610,'31,00','19h10','',1,'22/10',6,570,''),(16611,'31,00','22h10','',1,'22/10',6,570,''),(16612,'26,00','13h30','',0,'22/10',6,588,'MacroXE'),(16613,'26,00','16h00','',0,'22/10',6,588,'MacroXE'),(16614,'29,00','18h40','',0,'22/10',6,588,'MacroXE'),(16615,'29,00','21h20','',0,'22/10',6,588,'MacroXE'),(16616,'45,00','14h20','',0,'22/10',6,588,'VIP'),(16617,'45,00','19h50','',0,'22/10',6,588,'VIP'),(16618,'23,00','16h40','',0,'22/10',6,594,''),(16619,'26,00','22h00','',0,'22/10',6,594,''),(16620,'45,00','17h00','',0,'22/10',6,593,'VIP'),(16621,'45,00','22h25','',0,'22/10',6,593,'VIP'),(16622,'23,00','13h00','',0,'22/10',6,593,''),(16623,'23,00','15h50','',0,'22/10',6,593,''),(16624,'26,00','18h40','',0,'22/10',6,593,''),(16625,'26,00','21h30','',0,'22/10',6,593,''),(16626,'23,00','13h50','',0,'22/10',6,586,''),(16627,'23,00','13h20','',0,'22/10',6,564,''),(16628,'23,00','15h30','',0,'22/10',6,564,''),(16629,'26,00','18h10','',0,'22/10',6,564,''),(16630,'26,00','20h20','',0,'22/10',6,564,''),(16631,'26,00','19h30','',0,'22/10',6,591,''),(16632,'31,00','16h20','',1,'23/10',6,570,''),(16633,'31,00','19h10','',1,'23/10',6,570,''),(16634,'31,00','22h10','',1,'23/10',6,570,''),(16635,'26,00','16h00','',0,'23/10',6,588,'MacroXE'),(16636,'29,00','18h40','',0,'23/10',6,588,'MacroXE'),(16637,'29,00','21h20','',0,'23/10',6,588,'MacroXE'),(16638,'45,00','14h20','',0,'23/10',6,588,'VIP'),(16639,'45,00','19h50','',0,'23/10',6,588,'VIP'),(16640,'23,00','16h40','',0,'23/10',6,594,''),(16641,'26,00','22h00','',0,'23/10',6,594,''),(16642,'45,00','17h00','',0,'23/10',6,593,'VIP'),(16643,'45,00','22h25','',0,'23/10',6,593,'VIP'),(16644,'23,00','15h50','',0,'23/10',6,593,''),(16645,'26,00','18h40','',0,'23/10',6,593,''),(16646,'26,00','21h30','',0,'23/10',6,593,''),(16647,'23,00','13h50','',0,'23/10',6,586,''),(16648,'23,00','15h30','',0,'23/10',6,564,''),(16649,'26,00','18h10','',0,'23/10',6,564,''),(16650,'26,00','20h20','',0,'23/10',6,564,''),(16651,'23,00','14h00','',0,'23/10',6,591,''),(16652,'26,00','16h20','',1,'24/10',6,570,''),(16653,'26,00','19h10','',1,'24/10',6,570,''),(16654,'26,00','22h10','',1,'24/10',6,570,''),(16655,'21,00','16h00','',0,'24/10',6,588,'MacroXE'),(16656,'24,00','18h40','',0,'24/10',6,588,'MacroXE'),(16657,'24,00','21h20','',0,'24/10',6,588,'MacroXE'),(16658,'36,00','19h50','',0,'24/10',6,588,'VIP'),(16659,'18,00','16h40','',0,'24/10',6,594,''),(16660,'21,00','22h00','',0,'24/10',6,594,''),(16661,'36,00','14h00','',0,'24/10',6,593,'VIP'),(16662,'36,00','17h00','',0,'24/10',6,593,'VIP'),(16663,'36,00','22h25','',0,'24/10',6,593,'VIP'),(16664,'18,00','15h50','',0,'24/10',6,593,''),(16665,'21,00','18h40','',0,'24/10',6,593,''),(16666,'21,00','21h30','',0,'24/10',6,593,''),(16667,'18,00','13h50','',0,'24/10',6,586,''),(16668,'18,00','15h30','',0,'24/10',6,564,''),(16669,'21,00','18h10','',0,'24/10',6,564,''),(16670,'21,00','20h20','',0,'24/10',6,564,''),(16671,'18,00','14h00','',0,'24/10',6,591,''),(16672,'26,00','16h20','',1,'25/10',6,570,''),(16673,'26,00','19h10','',1,'25/10',6,570,''),(16674,'26,00','22h10','',1,'25/10',6,570,''),(16675,'21,00','16h00','',0,'25/10',6,588,'MacroXE'),(16676,'24,00','18h40','',0,'25/10',6,588,'MacroXE'),(16677,'24,00','21h20','',0,'25/10',6,588,'MacroXE'),(16678,'36,00','14h20','',0,'25/10',6,588,'VIP'),(16679,'36,00','19h50','',0,'25/10',6,588,'VIP'),(16680,'18,00','16h40','',0,'25/10',6,594,''),(16681,'21,00','22h00','',0,'25/10',6,594,''),(16682,'36,00','17h00','',0,'25/10',6,593,'VIP'),(16683,'36,00','22h25','',0,'25/10',6,593,'VIP'),(16684,'18,00','15h50','',0,'25/10',6,593,''),(16685,'21,00','18h40','',0,'25/10',6,593,''),(16686,'21,00','21h30','',0,'25/10',6,593,''),(16687,'18,00','13h50','',0,'25/10',6,586,''),(16688,'18,00','15h30','',0,'25/10',6,564,''),(16689,'21,00','18h10','',0,'25/10',6,564,''),(16690,'21,00','20h20','',0,'25/10',6,564,''),(16691,'18,00','14h00','',0,'25/10',6,591,''),(16692,'28,00','00h01','',1,'26/10',6,592,'MacroXE'),(16693,'34,00','13h00','',1,'27/10',6,592,'MacroXE'),(16694,'34,00','16h05','',1,'27/10',6,592,'MacroXE'),(16695,'34,00','19h05','',1,'27/10',6,592,'MacroXE'),(16696,'34,00','22h05','',1,'27/10',6,592,'MacroXE'),(16697,'34,00','13h00','',1,'28/10',6,592,'MacroXE'),(16698,'34,00','16h05','',1,'28/10',6,592,'MacroXE'),(16699,'34,00','19h05','',1,'28/10',6,592,'MacroXE'),(16700,'34,00','22h05','',1,'28/10',6,592,'MacroXE'),(16701,'34,00','13h00','',1,'29/10',6,592,'MacroXE'),(16702,'34,00','16h05','',1,'29/10',6,592,'MacroXE'),(16703,'34,00','19h05','',1,'29/10',6,592,'MacroXE'),(16704,'34,00','22h05','',1,'29/10',6,592,'MacroXE'),(16705,'34,00','13h00','',1,'30/10',6,592,'MacroXE'),(16706,'34,00','16h05','',1,'30/10',6,592,'MacroXE'),(16707,'34,00','19h05','',1,'30/10',6,592,'MacroXE'),(16708,'34,00','22h05','',1,'30/10',6,592,'MacroXE'),(16709,'29,00','13h00','',1,'31/10',6,592,'MacroXE'),(16710,'29,00','16h05','',1,'31/10',6,592,'MacroXE'),(16711,'29,00','19h05','',1,'31/10',6,592,'MacroXE'),(16712,'29,00','22h05','',1,'31/10',6,592,'MacroXE'),(16713,'29,00','13h00','',1,'01/11',6,592,'MacroXE'),(16714,'29,00','16h05','',1,'01/11',6,592,'MacroXE'),(16715,'29,00','19h05','',1,'01/11',6,592,'MacroXE'),(16716,'29,00','22h05','',1,'01/11',6,592,'MacroXE'),(16717,'34,00','13h00','',1,'02/11',6,592,'MacroXE'),(16718,'34,00','16h05','',1,'02/11',6,592,'MacroXE'),(16719,'34,00','19h05','',1,'02/11',6,592,'MacroXE'),(16720,'34,00','22h05','',1,'02/11',6,592,'MacroXE');
/*!40000 ALTER TABLE `sessao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `visao_principal`
--

DROP TABLE IF EXISTS `visao_principal`;
/*!50001 DROP VIEW IF EXISTS `visao_principal`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `visao_principal` AS SELECT 
 1 AS `nome`,
 1 AS `classificacao`,
 1 AS `horario`,
 1 AS `preco`,
 1 AS `tipo_exibicao`,
 1 AS `e_3d`,
 1 AS `data`,
 1 AS `generos`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `visao_principal`
--

/*!50001 DROP VIEW IF EXISTS `visao_principal`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `visao_principal` AS select `filme`.`nomeDoFilme` AS `nome`,`filme`.`classificacaoEtaria` AS `classificacao`,`sessao`.`horario` AS `horario`,`sessao`.`preco` AS `preco`,`sessao`.`tipo_exibicao` AS `tipo_exibicao`,`sessao`.`e_3d` AS `e_3d`,`sessao`.`data` AS `data`,group_concat(`genero`.`nomeGenero` separator ', ') AS `generos` from (((`filme` left join `filme_genero` on((`filme`.`idfilme` = `filme_genero`.`idfilme`))) left join `genero` on((`filme_genero`.`idgenero` = `genero`.`idgenero`))) join `sessao` on((`sessao`.`idfilme` = `filme`.`idfilme`))) group by `sessao`.`idsessao` order by `sessao`.`data`,`sessao`.`horario` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-10-19 23:38:41
