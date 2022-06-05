With CTE1 as
	(
	  Select *, Cast(Cast(Price_USD as Float) as Numeric(10,2)) as Cast_price, Cast(Cast(Marketcap as Float) as Numeric(20,2)) as Cast_MktCap
	  from Company_List
	),
	CTE2 as
	(
	Select CTE1.Rank,CTE1.Name,CTE1.Symbol, CTE1.Country, CTE1.Cast_price, CTE1.Cast_MktCap, 
	row_number() over(partition by Country order by Cast_price desc) as Price_Rank
	-- dense_rank() over(partition by country order by  Cast_price desc) as Common_Rank
	from CTE1
	),
	CTE3 as
	(
	Select CTE1.Rank, CTE1.Name,CTE1.Symbol, CTE1.Country, CTE1.Cast_price, CTE1.Cast_MktCap, 
	row_number() over(partition by Country order by Cast_MktCap desc) as MarketCapital_Rank
	-- dense_rank() over(partition by country order by  Cast_price desc) as Common_Rank
	from CTE1
	),
	CTE4 as 
	(
	Select CTE2.Name, CTE2.Symbol, CTE2.Country, CTE2.Cast_price, CTE2.Cast_MktCap, CTE2.Price_Rank, CTE3.MarketCapital_Rank 
	from CTE2 join CTE3 on CTE2.Rank = CTE3.Rank
	)
	Insert Into [dbo].[Rank_Analysis]
	([Name], Symbol, Country, Cast_price, Cast_MktCap, Price_Rank, MarketCapital_Rank)

	Select * from CTE4;
-- END

Select * from Rank_analysis