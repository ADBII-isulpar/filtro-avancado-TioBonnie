
-- Estrutura para tabela `departamentos`
--

CREATE TABLE `departamentos` (
  `id` int NOT NULL,
  `nome` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Despejando dados para a tabela `departamentos`
--

INSERT INTO `departamentos` (`id`, `nome`) VALUES
(1, 'Vendas'),
(2, 'TI'),
(3, 'Financeiro');

-- --------------------------------------------------------

--
-- Estrutura para tabela `funcionarios`
--

CREATE TABLE `funcionarios` (
  `id` int NOT NULL,
  `nome` varchar(100) NOT NULL,
  `salario` decimal(10,2) NOT NULL,
  `departamento_id` int DEFAULT NULL,
  `gerente_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Despejando dados para a tabela `funcionarios`
--

INSERT INTO `funcionarios` (`id`, `nome`, `salario`, `departamento_id`, `gerente_id`) VALUES
(1, 'Ana', 3000.00, 1, NULL),
(2, 'Bruno', 2600.00, 1, 1),
(3, 'Carlos', 2400.00, 1, 1),
(4, 'Daniela', 6000.00, 2, NULL),
(5, 'Eduardo', 5500.00, 2, 4),
(6, 'Fernanda', 4000.00, 3, NULL),
(7, 'Gustavo', 2000.00, 3, 6);

-- --------------------------------------------------------

--
-- Estrutura para tabela `funcionario_projeto`
--

CREATE TABLE `funcionario_projeto` (
  `funcionario_id` int NOT NULL,
  `projeto_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Despejando dados para a tabela `funcionario_projeto`
--

INSERT INTO `funcionario_projeto` (`funcionario_id`, `projeto_id`) VALUES
(1, 1),
(2, 1),
(2, 2),
(3, 2),
(4, 3),
(5, 3),
(6, 4);

-- --------------------------------------------------------

--
-- Estrutura para tabela `projetos`
--

CREATE TABLE `projetos` (
  `id` int NOT NULL,
  `nome` varchar(100) NOT NULL,
  `departamento_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Despejando dados para a tabela `projetos`
--

INSERT INTO `projetos` (`id`, `nome`, `departamento_id`) VALUES
(1, 'Projeto Alpha', 1),
(2, 'Projeto Beta', 1),
(3, 'Projeto Gamma', 2),
(4, 'Projeto Delta', 3);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `departamentos`
--
ALTER TABLE `departamentos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `funcionarios`
--
ALTER TABLE `funcionarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `departamento_id` (`departamento_id`),
  ADD KEY `gerente_id` (`gerente_id`);

--
-- Índices de tabela `funcionario_projeto`
--
ALTER TABLE `funcionario_projeto`
  ADD PRIMARY KEY (`funcionario_id`,`projeto_id`),
  ADD KEY `projeto_id` (`projeto_id`);

--
-- Índices de tabela `projetos`
--
ALTER TABLE `projetos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `departamento_id` (`departamento_id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `departamentos`
--
ALTER TABLE `departamentos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `funcionarios`
--
ALTER TABLE `funcionarios`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `projetos`
--
ALTER TABLE `projetos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `funcionarios`
--
ALTER TABLE `funcionarios`
  ADD CONSTRAINT `funcionarios_ibfk_1` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`),
  ADD CONSTRAINT `funcionarios_ibfk_2` FOREIGN KEY (`gerente_id`) REFERENCES `funcionarios` (`id`);

--
-- Restrições para tabelas `funcionario_projeto`
--
ALTER TABLE `funcionario_projeto`
  ADD CONSTRAINT `funcionario_projeto_ibfk_1` FOREIGN KEY (`funcionario_id`) REFERENCES `funcionarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `funcionario_projeto_ibfk_2` FOREIGN KEY (`projeto_id`) REFERENCES `projetos` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `projetos`
--
ALTER TABLE `projetos`
  ADD CONSTRAINT `projetos_ibfk_1` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`);
COMMIT;


-- 1. Funcionários do depto "Vendas" com salário acima de 2500
SELECT f.nome, f.salario
FROM funcionarios f
JOIN departamentos d ON f.departamento_id = d.id
WHERE d.nome = 'Vendas' AND f.salario > 2500;

-- 2. Nome dos funcionários + nome do departamento + projeto
SELECT f.nome AS funcionario, d.nome AS departamento, p.nome AS projeto
FROM funcionarios f
JOIN departamentos d ON f.departamento_id = d.id
JOIN funcionario_projeto fp ON f.id = fp.funcionario_id
JOIN projetos p ON fp.projeto_id = p.id;

-- 3. Salário médio de cada departamento
SELECT d.nome AS departamento, AVG(f.salario) AS salario_medio
FROM funcionarios f
JOIN departamentos d ON f.departamento_id = d.id
GROUP BY d.nome;

-- 4. Departamentos com salário médio > 5000
SELECT d.nome AS departamento, AVG(f.salario) AS salario_medio
FROM funcionarios f
JOIN departamentos d ON f.departamento_id = d.id
GROUP BY d.nome
HAVING AVG(f.salario) > 5000;

-- 5. Quantidade de funcionários em cada projeto
SELECT p.nome AS projeto, COUNT(fp.funcionario_id) AS qtd_funcionarios
FROM projetos p
LEFT JOIN funcionario_projeto fp ON p.id = fp.projeto_id
GROUP BY p.nome;

-- 6. Funcionários + gerente + departamento
SELECT f.nome AS funcionario, g.nome AS gerente, d.nome AS departamento
FROM funcionarios f
LEFT JOIN funcionarios g ON f.gerente_id = g.id
JOIN departamentos d ON f.departamento_id = d.id;

-- 7. Funcionários que participam de mais de 1 projeto
SELECT f.nome AS funcionario, COUNT(fp.projeto_id) AS qtd_projetos
FROM funcionarios f
JOIN funcionario_projeto fp ON f.id = fp.funcionario_id
GROUP BY f.nome
HAVING COUNT(fp.projeto_id) > 1;

-- 8. Projetos sem nenhum funcionário
SELECT p.nome AS projeto
FROM projetos p
LEFT JOIN funcionario_projeto fp ON p.id = fp.projeto_id
WHERE fp.funcionario_id IS NULL;

-- 9. Departamentos + soma dos salários
SELECT d.nome AS departamento, SUM(f.salario) AS total_salarios
FROM funcionarios f
JOIN departamentos d ON f.departamento_id = d.id
GROUP BY d.nome;

-- 10. Funcionários + quantidade de projetos
SELECT f.nome AS funcionario, COUNT(fp.projeto_id) AS qtd_projetos
FROM funcionarios f
LEFT JOIN funcionario_projeto fp ON f.id = fp.funcionario_id
GROUP BY f.nome;
