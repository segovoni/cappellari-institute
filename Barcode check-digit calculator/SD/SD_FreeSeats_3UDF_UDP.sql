

/* FUNCTION UDF sd_LocateAreFreeSeats */
create function sd_LocateAreFreeSeats(
	 @peopleN int, @postiLiberiLetti int)
	returns bit 
	as
	begin

		declare @output bit
		set @output='false'

		if @peopleN <= @postiLiberiLetti 
			begin
				set @output='true'
			end
		else
			begin	
				return @output
			end

		return @output
	end


/* codice esecuzione,  **/
select * from myfreeseats where dbo.sd_LocateAreFreeSeats(15,totPostiLiberiRow)='true'



/*******************************************************************************************************/


/* PROCEDURE UDP sd_LocateFreeNSeatsRows */
/* visualizza le sole file (rowNumber) ove ci sono gli N posti consecutivi richiesti (parametro @peopleN) **/

create procedure sd_LocateFreeNSeatsRows 
	 @peopleN int

	as
	begin

		select distinct rownumber, totpostiliberirow		 
		from 
			MyFreeSeats
		where 
			totpostiliberirow>=@peopleN
		order by 
			rownumber

	end


/* stringa di esecuzione */	
exec sd_LocateFreeNSeatsRows @peopleN=2  