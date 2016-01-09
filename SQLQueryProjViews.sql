
---cria��o de views---
Use CBDLeiloes
Go
IF OBJECT_ID ('SchemaProduto.vUtilizadorProvendoAvenda', 'V') IS NOT NULL
	DROP Trigger SchemaProduto.vUtilizadorProvendoAvenda;
GO
Create view SchemaProduto.vUtilizadorProvendoAvenda /*a view que lista o numero de produtos a venda no momento*/
as 
SELECT ProdutoUtilizadorID, COUNT(ProdutoId) as ProdutosVendidos  
from  SchemaProduto.Produto,SchemaUtilizador.Utilizador       
where   UtilizadorId= ProdutoUtilizadorID and DATEDIFF(S, GETDATE(), ProdutoDataLimiteLeilao)>0
group by ProdutoUtilizadorID;
Go
 --select * from SchemaProduto.vUtilizadorProvendoAvenda;

--cria��o de view que lista o numero de produtos vendidos.
IF OBJECT_ID ('SchemaProduto.vUtilizadorProdutosVendidos', 'V') IS NOT NULL
	DROP Trigger SchemaProduto.vUtilizadorProdutosVendidos;
GO
create view SchemaProduto.vUtilizadorProdutosVendidos
as
select UtilizadorId,  count(ProdutoId) as Produtosvendidos from SchemaUtilizador.Utilizador, SchemaProduto.Produto

where ProdutoUtilizadorID= UtilizadorId and DATEDIFF(S, GETDATE(), ProdutoDataLimiteLeilao)<0 group by UtilizadorId;
Go

IF OBJECT_ID ('SchemaUtilizador.vUtililizadorLicitacaoCompra', 'V') IS NOT NULL
	DROP Trigger SchemaUtilizador.vUtililizadorLicitacaoCompra;
GO
create view SchemaUtilizador.vUtililizadorLicitacaoCompra
as
select UtilizadorId , COUNT(CompraProdutoID) as ProdutoComprado  from SchemaUtilizador.Compra, SchemaUtilizador.Utilizador, SchemaLicitacao.Licitacao
where LicitacaoUtilizadorID= UtilizadorId and CompraLicitacaoID= LicitacaoId
group by UtilizadorId;
Go