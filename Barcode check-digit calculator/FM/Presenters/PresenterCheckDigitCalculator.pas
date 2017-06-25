unit PresenterCheckDigitCalculator;

interface

uses InterfaceCheckDigitCalculator, ModelCheckDigitCalculator, SysUtils;

type TPresenterCheckDigitCalculator = class
    private
        FViewCheckDigitCalculator: ICheckDigitCalculator;
        FModel: TModelCheckDigitCalculator;
    public
        procedure ShowCheckDigit();
    published
        constructor Create(AViewCheckDigitCalculator: ICheckDigitCalculator);
end;

implementation

{ TPresenterCheckDigitCalculator }

constructor TPresenterCheckDigitCalculator.Create(
  AViewCheckDigitCalculator: ICheckDigitCalculator);
begin
    FViewCheckDigitCalculator:=AViewCheckDigitCalculator
end;




procedure TPresenterCheckDigitCalculator.ShowCheckDigit;
var LIncompleteBarcode: string;
LCheckDigit: integer;
LCompleteBarcode: string;
begin
    LIncompleteBarcode:=FViewCheckDigitCalculator.GetIncompleteBarcode;
    if (LIncompleteBarcode <> '') then begin
        FModel:=TModelCheckDigitCalculator.Create(strToInt64(LIncompleteBarcode));
        LCheckDigit:=FModel.GetCheckDigit;
        FViewCheckDigitCalculator.SetCheckDigit(LCheckDigit);
        LCompleteBarcode:=LIncompleteBarcode+intToStr(LCheckDigit);
        FViewCheckDigitCalculator.SetCompleteBarcode(strToInt64(LCompleteBarcode));
    end;
end;




end.