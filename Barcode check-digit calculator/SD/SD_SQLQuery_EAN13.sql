/*
 1 2 3 4 5 6 7 8 9 10 11 12  -> sequenza di lettura cifre ->13

 (sommare tutti i pari) moltiplicare il risultato per 3
 sommare tutti i dispari (da 1 a 11)
 il 13° numero del codice EAN13 (check digit) lo ricava la funzione

*/
create or alter function dbo.sd_EAN13_CalcCheckDigit(
	@ean varchar (12) 
)
returns int

as
begin--inizio udf

declare @res integer

declare @i integer

set @res=1* (
	cast(substring (@ean,1,1) as int)+
	cast(substring (@ean,3,1) as int)+
	cast(substring (@ean,5,1) as int)+
	cast(substring (@ean,7,1) as int)+
	cast(substring (@ean,9,1) as int)+
	cast(substring (@ean,11,1) as int)
	)

set @res=@res+ 3*(
	cast(substring (@ean,2,1) as int)+
	cast(substring (@ean,4,1) as int)+
	cast(substring (@ean,6,1) as int)+
	cast(substring (@ean,8,1) as int)+
	cast(substring (@ean,10,1) as int)+
	cast(substring (@ean,12,1) as int)
	)

if (@res % 10)=0
	set @res=0
else	
begin
	set @i=@res/10
	set @i= @i+1
	set @i= 10*@i
	set @res=(@i)-@res			
end

if (LEN(@ean)!=12)
	set @res=99	

return @res

end


/* test, avvio                                    -- risultato ottenuto */
print dbo.sd_EAN13_CalcCheckDigit('102030405060') --9
print dbo.sd_EAN13_CalcCheckDigit('010203040506') --7
print dbo.sd_EAN13_CalcCheckDigit('112233445566') --6
print dbo.sd_EAN13_CalcCheckDigit('000000000000') --0
print dbo.sd_EAN13_CalcCheckDigit('111111111111') --6
print dbo.sd_EAN13_CalcCheckDigit('222222222222') --2
print dbo.sd_EAN13_CalcCheckDigit('333333333333') --8
print dbo.sd_EAN13_CalcCheckDigit('444444444444') --4
print dbo.sd_EAN13_CalcCheckDigit('555555555555') --0
print dbo.sd_EAN13_CalcCheckDigit('666666666666') --6
print dbo.sd_EAN13_CalcCheckDigit('888888888888') --8
print dbo.sd_EAN13_CalcCheckDigit('999999999999') --4
print dbo.sd_EAN13_CalcCheckDigit('012301230123') --2
print dbo.sd_EAN13_CalcCheckDigit('282828282828') --4
print dbo.sd_EAN13_CalcCheckDigit('003004001008') --0
-- non conformi
print dbo.sd_EAN13_CalcCheckDigit('0030') --99
print dbo.sd_EAN13_CalcCheckDigit('0a1b2c3d4e5f') --Conversione non riuscita durante la conversione del valore varchar 'a' nel tipo di dati int
print dbo.sd_EAN13_CalcCheckDigit(NULL) --
print dbo.sd_EAN13_CalcCheckDigit('0030040010089999') --0 -> avviene un troncamento dovuto alla specifica varchar(12) in input 