﻿#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ПараметрыФормы = Новый Структура("Механизм", ПараметрКоманды);
	ОткрытьФорму("РегистрСведений.СтатусыВстраиванияМеханизмов.Форма.ФормаСтатусыВстраиванияМеханизма", 
		ПараметрыФормы, 
		ПараметрыВыполненияКоманды.Источник, 
		ПараметрыВыполненияКоманды.Уникальность, 
		ПараметрыВыполненияКоманды.Окно, 
		ПараметрыВыполненияКоманды.НавигационнаяСсылка);
		
КонецПроцедуры

#КонецОбласти