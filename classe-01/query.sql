CREATE DATABASE ecommerce;

CREATE TABLE categorias (
  id SERIAL NOT NULL PRIMARY KEY,
  nome VARCHAR(50)
);
CREATE TABLE clientes (
  id SERIAL NOT NULL PRIMARY KEY,
  cpf CHAR(11) NOT NULL UNIQUE,
  nome VARCHAR(150) NOT NULL
);
CREATE TABLE vendedores (
  id SERIAL NOT NULL PRIMARY KEY,
  cpf CHAR(11) NOT NULL UNIQUE,
  nome VARCHAR(150) NOT NULL
);
CREATE TABLE produtos (
  id SERIAL NOT NULL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  descricao TEXT,
  preco INT NOT NULL,
  quantidade_em_estoque INT NOT NULL,
  categoria_id INT REFERENCES categorias(id)
);
CREATE TABLE pedidos (
  id SERIAL NOT NULL PRIMARY KEY,
  valor INT NOT NULL,
  cliente_cpf CHAR(11) NOT NULL REFERENCES clientes(cpf),
  vendedor_cpf CHAR(11) NOT NULL REFERENCES vendedores(cpf)
);
CREATE TABLE itens_do_pedido (
  id SERIAL NOT NULL PRIMARY KEY,
  pedido_id INT NOT NULL REFERENCES pedidos(id),
  quantidade INT NOT NULL,
  produto_id INT NOT NULL REFERENCES produtos(id) 
);

INSERT INTO categorias (nome) VALUES
  ('frutas'),
  ('verduras'),
  ('massas'),
  ('bebidas'),
  ('utilidades')
;

INSERT INTO produtos (nome, descricao, preco, quantidade_em_estoque, categoria_id
) VALUES
('Mamão', 'Rico em vitamina A, potássio e vitamina C', 300,	123, 1),
('Maça', 'Fonte de potássio e fibras.', 90, 34,	1),
('Cebola', 'Rico em quercetina, antocianinas, vitaminas do complexo B, C.',	50,	76,	2),
('Abacate', 'NÃO CONTÉM GLÚTEN.', 150, 64, 1),
('Tomate', 'Rico em vitaminas A, B e C.', 125, 88, 2),
('Acelga', 'NÃO CONTÉM GLÚTEN.', 235, 13, 2),
('Macarrão parafuso', 'Sêmola de trigo enriquecida com ferro e ácido fólico, ovos e corantes naturais', 690, 5, 3),
('Massa para lasanha', 'Uma reunião de família precisa ter comida boa e muita alegria.', 875, 19, 3),
('Refrigerante coca cola lata', 'Sabor original', 350, 189, 4),
('Refrigerante Pepsi 2l', 'NÃO CONTÉM GLÚTEN. NÃO ALCOÓLICO.', 700, 12, 4),
('Cerveja Heineken 600ml', 'Heineken é uma cerveja lager Puro Malte, refrescante e de cor amarelo-dourado', 1200, 500, 4),
('Agua mineral sem gás', 'Smartwater é água adicionado de sais mineirais (cálcio, potássio e magnésio) livre de sódio e com pH neutro.',130, 478, 4),
('Vassoura', 'Pigmento, matéria sintética e metal.', 2350, 30, 5),
('Saco para lixo', 'Reforçado para garantir mais segurança', 1340, 90, 5),
('Escova dental', 'Faça uma limpeza profunda com a tecnologia inovadora', 1000, 44, 5),
('Balde para lixo 50l',	'Possui tampa e fabricado com material reciclado', 2290, 55, 5),
('Manga', 'Rico em Vitamina A, potássio e vitamina C', 198, 176, 1),
('Uva', 'NÃO CONTÉM GLÚTEN.', 420, 90, 1);

INSERT INTO clientes (cpf, nome) VALUES
('80371350042', 'José Augusto Silva'),
('67642869061', 'Antonio Oliveira'),
('63193310034', 'Ana Rodrigues'),
('75670505018', 'Maria da Conceição');

INSERT INTO vendedores (cpf, nome) VALUES
('82539841031',	'Rodrigo Sampaio'),
('23262546003',	'Beatriz Souza Santos'),
('28007155023',	'Carlos Eduardo');


-- VENDA 1

UPDATE produtos SET quantidade_em_estoque = (quantidade_em_estoque - 1) WHERE id = 1 OR id = 10 OR id = 15 AND quantidade_em_estoque > 1;
UPDATE produtos SET quantidade_em_estoque = (quantidade_em_estoque - 6) WHERE id = 11 AND quantidade_em_estoque > 6;
UPDATE produtos SET quantidade_em_estoque = (quantidade_em_estoque - 5) WHERE id = 2 AND quantidade_em_estoque > 5;

INSERT INTO pedidos (valor, cliente_cpf, vendedor_cpf) VALUES
((
  ((SELECT preco
   FROM produtos
   WHERE id = 1)) + 
  ((SELECT preco
   FROM produtos
   WHERE id = 10)) +
  ((SELECT preco
   FROM produtos
   WHERE id = 15)) +
  ((SELECT preco
   FROM produtos
   WHERE id = 11) * 6) +
  ((SELECT preco
   FROM produtos
   WHERE id = 2) * 5)
), '80371350042', '28007155023');

INSERT INTO itens_do_pedido (pedido_id, quantidade, produto_id) VALUES
(1, 1, 1),
(1, 1, 10),
(1, 1, 15),
(1, 6, 11),
(1, 5, 2);


--VENDA 2

UPDATE produtos SET quantidade_em_estoque = (quantidade_em_estoque - 10) WHERE id = 17 OR id = 5 AND quantidade_em_estoque > 10;
UPDATE produtos SET quantidade_em_estoque = (quantidade_em_estoque - 3) WHERE id = 18 AND quantidade_em_estoque > 3;
UPDATE produtos SET quantidade_em_estoque = (quantidade_em_estoque - 5) WHERE id = 1 AND quantidade_em_estoque > 5;
UPDATE produtos SET quantidade_em_estoque = (quantidade_em_estoque - 2) WHERE id = 6 AND quantidade_em_estoque > 2;

INSERT INTO pedidos (valor, cliente_cpf, vendedor_cpf) VALUES
((
  ((SELECT preco
   FROM produtos
   WHERE id = 17) * 10) + 
  ((SELECT preco
   FROM produtos
   WHERE id = 5) * 10) +
  ((SELECT preco
   FROM produtos
   WHERE id = 18) * 3) +
  ((SELECT preco
   FROM produtos
   WHERE id = 1) * 5) +
  ((SELECT preco
   FROM produtos
   WHERE id = 6) * 2)
), '63193310034', '23262546003');

INSERT INTO itens_do_pedido (pedido_id, quantidade, produto_id) VALUES
(2, 10, 17),
(2, 10, 5),
(2, 3, 18),
(2, 5, 1),
(2, 2, 6);


-- VENDA 3

UPDATE produtos SET quantidade_em_estoque = (quantidade_em_estoque - 1) WHERE id = 13 AND quantidade_em_estoque > 1;
UPDATE produtos SET quantidade_em_estoque = (quantidade_em_estoque - 6) WHERE id = 12 AND quantidade_em_estoque > 6;
UPDATE produtos SET quantidade_em_estoque = (quantidade_em_estoque - 5) WHERE id = 17 AND quantidade_em_estoque > 5;

INSERT INTO pedidos (valor, cliente_cpf, vendedor_cpf) VALUES
((
  ((SELECT preco
   FROM produtos
   WHERE id = 13)) + 
  ((SELECT preco
   FROM produtos
   WHERE id = 12) * 6) +
  ((SELECT preco
   FROM produtos
   WHERE id = 17) * 5)
), '75670505018', '23262546003');

INSERT INTO itens_do_pedido (pedido_id, quantidade, produto_id) VALUES
(3, 1, 13),
(3, 6, 12),
(3, 5, 17);


-- VENDA 4

SELECT * FROM clientes; 

UPDATE produtos SET quantidade_em_estoque = (quantidade_em_estoque - 1) WHERE id = 16 OR id = 7 AND quantidade_em_estoque > 1;
UPDATE produtos SET quantidade_em_estoque = (quantidade_em_estoque - 6) WHERE id = 18 AND quantidade_em_estoque > 6;
UPDATE produtos SET quantidade_em_estoque = (quantidade_em_estoque - 3) WHERE id = 1 AND quantidade_em_estoque > 3;
UPDATE produtos SET quantidade_em_estoque = (quantidade_em_estoque - 20) WHERE id = 5 AND quantidade_em_estoque > 20;
UPDATE produtos SET quantidade_em_estoque = (quantidade_em_estoque - 2) WHERE id = 6 AND quantidade_em_estoque > 2;

INSERT INTO pedidos (valor, cliente_cpf, vendedor_cpf) VALUES
((
  ((SELECT preco
   FROM produtos
   WHERE id = 16)) +
  ((SELECT preco
   FROM produtos
   WHERE id = 7)) +
  ((SELECT preco
   FROM produtos
   WHERE id = 18) * 6) +
  ((SELECT preco
   FROM produtos
   WHERE id = 1) * 3) + 
  ((SELECT preco
   FROM produtos
   WHERE id = 5) * 20) +
  ((SELECT preco
   FROM produtos
   WHERE id = 6) * 2)
), '75670505018', '82539841031');

INSERT INTO itens_do_pedido (pedido_id, quantidade, produto_id) VALUES
(4, 1, 16),
(4, 1, 7),
(4, 6, 18),
(4, 3, 1),
(4, 20, 5),
(4, 2, 6);


-- VENDA 5

SELECT * FROM vendedores; 

UPDATE produtos SET quantidade_em_estoque = (quantidade_em_estoque - 8) WHERE id = 18 OR id = 5 AND quantidade_em_estoque > 8;
UPDATE produtos SET quantidade_em_estoque = (quantidade_em_estoque - 1) WHERE id = 8 AND quantidade_em_estoque > 1;
UPDATE produtos SET quantidade_em_estoque = (quantidade_em_estoque - 3) WHERE id = 17 AND quantidade_em_estoque > 3;
UPDATE produtos SET quantidade_em_estoque = (quantidade_em_estoque - 2) WHERE id = 11 AND quantidade_em_estoque > 2;

INSERT INTO pedidos (valor, cliente_cpf, vendedor_cpf) VALUES
((
  ((SELECT preco
   FROM produtos
   WHERE id = 18) * 8) +
  ((SELECT preco
   FROM produtos
   WHERE id = 5) * 8) +
  ((SELECT preco
   FROM produtos
   WHERE id = 8)) +
  ((SELECT preco
   FROM produtos
   WHERE id = 17) * 3) + 
  ((SELECT preco
   FROM produtos
   WHERE id = 11) * 2)
), '67642869061', '82539841031');

INSERT INTO itens_do_pedido (pedido_id, quantidade, produto_id) VALUES
(5, 8, 18),
(5, 8, 5),
(5, 1, 8),
(5, 3, 17),
(5, 2, 11);


--LISTAGENS

SELECT * FROM produtos 
JOIN categorias ON produtos.categoria_id = categorias.id
ORDER BY produtos.id;

SELECT * FROM pedidos
JOIN clientes ON pedidos.cliente_cpf = clientes.cpf 
JOIN vendedores ON pedidos.vendedor_cpf = vendedores.cpf
ORDER BY pedidos.id;

SELECT categorias.id, categorias.nome, sum(quantidade_em_estoque) FROM produtos 
JOIN categorias ON produtos.categoria_id = categorias.id
GROUP BY categorias.nome, categorias.id
ORDER BY SUM(quantidade_em_estoque) DESC;

SELECT produtos.id, produtos.nome, sum(itens_do_pedido.quantidade) FROM produtos
JOIN itens_do_pedido ON produtos.id = itens_do_pedido.produto_id
GROUP BY produtos.id
ORDER BY SUM(itens_do_pedido.quantidade) DESC
;