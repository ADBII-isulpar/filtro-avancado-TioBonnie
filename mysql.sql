CREATE DATABASE IF NOT EXISTS `tiago_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `tiago_db`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `Clientes`
--

CREATE TABLE `Clientes` (
  `id` int NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Despejando dados para a tabela `Clientes`
--

INSERT INTO `Clientes` (`id`, `nome`, `email`) VALUES
(1, 'Ana Souza', 'ana@email.com'),
(2, 'Bruno Lima', 'bruno@email.com'),
(3, 'Carla Mendes', 'carla@email.com'),
(4, 'Diego Rocha', 'diego@email.com'),
(5, 'Elisa Ramos', 'elisa@email.com');

-- --------------------------------------------------------

--
-- Estrutura para tabela `Descontos`
--

CREATE TABLE `Descontos` (
  `id` int NOT NULL,
  `produto_id` int DEFAULT NULL,
  `inicio` date DEFAULT NULL,
  `fim` date DEFAULT NULL,
  `porcentagem` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Despejando dados para a tabela `Descontos`
--

INSERT INTO `Descontos` (`id`, `produto_id`, `inicio`, `fim`, `porcentagem`) VALUES
(1, 2, '2025-02-01', '2025-02-28', 10.00),
(2, 3, '2025-03-01', '2025-04-30', 15.00),
(3, 5, '2025-06-01', '2025-06-30', 20.00);

-- --------------------------------------------------------

--
-- Estrutura para tabela `ItensPedido`
--

CREATE TABLE `ItensPedido` (
  `id` int NOT NULL,
  `pedido_id` int DEFAULT NULL,
  `produto_id` int DEFAULT NULL,
  `quantidade` int DEFAULT NULL,
  `preco_unitario` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Despejando dados para a tabela `ItensPedido`
--

INSERT INTO `ItensPedido` (`id`, `pedido_id`, `produto_id`, `quantidade`, `preco_unitario`) VALUES
(1, 1, 1, 1, 3500.00),
(2, 1, 2, 1, 120.00),
(3, 2, 3, 2, 450.00),
(4, 2, 4, 1, 900.00),
(5, 3, 2, 1, 120.00),
(6, 4, 5, 2, 300.00),
(7, 5, 2, 1, 120.00),
(8, 5, 5, 1, 300.00);

-- --------------------------------------------------------

--
-- Estrutura para tabela `Pedidos`
--

CREATE TABLE `Pedidos` (
  `id` int NOT NULL,
  `cliente_id` int DEFAULT NULL,
  `data_pedido` date NOT NULL,
  `total_pedido` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Despejando dados para a tabela `Pedidos`
--

INSERT INTO `Pedidos` (`id`, `cliente_id`, `data_pedido`, `total_pedido`) VALUES
(1, 1, '2025-01-15', 3620.00),
(2, 2, '2025-02-10', 1470.00),
(3, 2, '2025-03-20', 120.00),
(4, 3, '2025-05-05', 1550.00),
(5, 4, '2025-06-25', 300.00);

-- --------------------------------------------------------

--
-- Estrutura para tabela `Produtos`
--

CREATE TABLE `Produtos` (
  `id` int NOT NULL,
  `nome` varchar(100) NOT NULL,
  `preco` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Despejando dados para a tabela `Produtos`
--

INSERT INTO `Produtos` (`id`, `nome`, `preco`) VALUES
(1, 'Notebook', 3500.00),
(2, 'Mouse Gamer', 120.00),
(3, 'Teclado Mecânico', 450.00),
(4, 'Monitor 24', 900.00),
(5, 'Headset', 300.00),
(6, 'Cadeira Gamer', 1100.00);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `Clientes`
--
ALTER TABLE `Clientes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Índices de tabela `Descontos`
--
ALTER TABLE `Descontos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `produto_id` (`produto_id`);

--
-- Índices de tabela `ItensPedido`
--
ALTER TABLE `ItensPedido`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pedido_id` (`pedido_id`),
  ADD KEY `produto_id` (`produto_id`);

--
-- Índices de tabela `Pedidos`
--
ALTER TABLE `Pedidos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cliente_id` (`cliente_id`);

--
-- Índices de tabela `Produtos`
--
ALTER TABLE `Produtos`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `Clientes`
--
ALTER TABLE `Clientes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `Descontos`
--
ALTER TABLE `Descontos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `ItensPedido`
--
ALTER TABLE `ItensPedido`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `Pedidos`
--
ALTER TABLE `Pedidos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `Produtos`
--
ALTER TABLE `Produtos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `Descontos`
--
ALTER TABLE `Descontos`
  ADD CONSTRAINT `Descontos_ibfk_1` FOREIGN KEY (`produto_id`) REFERENCES `Produtos` (`id`);

--
-- Restrições para tabelas `ItensPedido`
--
ALTER TABLE `ItensPedido`
  ADD CONSTRAINT `ItensPedido_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `Pedidos` (`id`),
  ADD CONSTRAINT `ItensPedido_ibfk_2` FOREIGN KEY (`produto_id`) REFERENCES `Produtos` (`id`);

--
-- Restrições para tabelas `Pedidos`
--
ALTER TABLE `Pedidos`
  ADD CONSTRAINT `Pedidos_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `Clientes` (`id`);
COMMIT;

-- ATIV 1
Respostas - Revisão de Administração de Banco de Dados II
Parte A — Fundamentos e consultas básicas
1. DDL / DML
A diferença fundamental entre DDL e DML reside no que elas gerenciam: DDL gerencia a estrutura dos objetos da base de dados, enquanto DML gerencia os dados dentro desses objetos.
DDL (Data Definition Language - Linguagem de Definição de Dados): Usada para criar, alterar e excluir a estrutura de objetos na base de dados.
Exemplo: CREATE TABLE.
Uso: Utiliza-se para definir a arquitetura da base de dados, como na criação de uma nova tabela para armazenar informações de clientes.
SQL
CREATE TABLE Clientes (
    id INT PRIMARY KEY,
    nome VARCHAR(100)
);




DML (Data Manipulation Language - Linguagem de Manipulação de Dados): Usada para inserir, atualizar, consultar e excluir dados das tabelas.
Exemplo: INSERT INTO.
Uso: Utiliza-se nas operações rotineiras de um sistema, como cadastrar um novo cliente na tabela Clientes.
SQL
INSERT INTO Clientes (id, nome) VALUES (1, 'João Silva');

-- ATIV 2
A cláusula WHERE filtra as linhas antes que qualquer agrupamento ou função de agregação seja aplicado. A cláusula HAVING filtra os grupos depois de o agrupamento e as funções de agregação terem sido calculados.
Exemplo em que HAVING é obrigatório:
Para encontrar os departamentos que têm mais de 10 funcionários, é preciso primeiro contar os funcionários em cada departamento (GROUP BY) e, só depois, filtrar os resultados dessa contagem.
SQL
SELECT departamento_id, COUNT(id) as total_funcionarios
FROM Funcionarios
GROUP BY departamento_id
HAVING COUNT(id) > 10;


HAVING é obrigatório porque a condição de filtro (COUNT(id) > 10) atua sobre o resultado de uma função de agregação, o que não é permitido na cláusula WHERE.

--ATIV 3 
SELECT nome, salario
FROM Funcionarios
WHERE salario > 3000
ORDER BY salario DESC;

-- ATIV 4
SELECT produto, SUM(quantidade * valor_unitario) AS faturamento_total
FROM Vendas
GROUP BY produto
ORDER BY faturamento_total DESC;

--ATIV 5
SELECT produto, SUM(quantidade * valor_unitario) AS faturamento_total
FROM Vendas
GROUP BY produto
HAVING SUM(quantidade * valor_unitario) > 5000;

--ATIV 6
SELECT
 p.id AS pedido_id,
 p.data_pedido,
 c.nome AS nome_cliente
FROM
 Pedidos AS p
INNER JOIN
 Clientes AS c ON p.cliente_id = c.id;

--ATIV 7
SELECT
 p.id AS pedido_id,
 p.data_pedido,
 c.nome AS nome_cliente,
 pr.nome AS nome_produto,
 ip.quantidade,
 (ip.quantidade * ip.preco_unitario) AS valor_total_linha
FROM
 Pedidos AS p
INNER JOIN
 Clientes AS c ON p.cliente_id = c.id
INNER JOIN
 ItensPedido AS ip ON p.id = ip.pedido_id
INNER JOIN
 Produtos AS pr ON ip.produto_id = pr.id;

 --ATIV 8
 SELECT
 c.nome,
 p.id AS pedido_id
FROM
 Clientes AS c
LEFT JOIN
 Pedidos AS p ON c.id = p.cliente_id;

 --ATIV 9
 SELECT
 pr.nome,
 ip.pedido_id
FROM
 ItensPedido AS ip
RIGHT JOIN
 Produtos AS pr ON ip.produto_id = pr.id;

 --ATIV 10
 SELECT c.nome, p.id AS pedido_id
FROM Clientes AS c
LEFT JOIN Pedidos AS p ON c.id = p.cliente_id
UNION
SELECT c.nome, p.id AS pedido_id
FROM Clientes AS c
RIGHT JOIN Pedidos AS p ON c.id = p.cliente_id;

--ATIV 11
SELECT
 ip.pedido_id,
 pr.nome AS nome_produto,
 p.data_pedido
FROM
 ItensPedido AS ip
INNER JOIN
 Pedidos AS p ON ip.pedido_id = p.id
INNER JOIN
 Descontos AS d ON ip.produto_id = d.produto_id
 AND p.data_pedido BETWEEN d.inicio AND d.fim;

 --ATIV 12
 SELECT
 c.id AS cliente_id,
 p.id AS pedido_id,
 c.nome AS nome_cliente
FROM
 Clientes AS c
INNER JOIN
 Pedidos AS p ON c.id = p.cliente_id;

--ATIV 13
SELECT
 c.id AS cliente_id,
 c.nome,
 SUM(ip.quantidade * ip.preco_unitario) AS faturamento_total_cliente
FROM
 Clientes AS c
JOIN
 Pedidos AS p ON c.id = p.cliente_id
JOIN
 ItensPedido AS ip ON p.id = ip.pedido_id
GROUP BY
 c.id, c.nome
ORDER BY
 faturamento_total_cliente DESC;

--ATIV 14
SELECT
 pr.nome,
 COALESCE(SUM(ip.quantidade), 0) AS quantidade_total_vendida
FROM
 Produtos AS pr
LEFT JOIN
 ItensPedido AS ip ON pr.id = ip.produto_id
GROUP BY
 pr.id, pr.nome
ORDER BY
 pr.nome;

--ATIV 15
SELECT
 p.id AS pedido_id,
 p.data_pedido,
 c.nome AS cliente_nome,
 p.total_pedido
FROM
 Pedidos AS p
INNER JOIN
 Clientes AS c ON p.cliente_id = c.id
WHERE
 p.data_pedido BETWEEN '2025-01-01' AND '2025-06-30'
ORDER BY
 p.data_pedido ASC;
