﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ПараметрыФормы = Новый Структура("Объект", ПараметрКоманды);
	
	ОткрытьФорму("ОбщаяФорма.СравнениеВерсий",
				 ПараметрыФормы,
				 ПараметрыВыполненияКоманды.Источник,
				 ,
				 ,
				 ПараметрыВыполненияКоманды.НавигационнаяСсылка,
				 Неопределено);
	
КонецПроцедуры
