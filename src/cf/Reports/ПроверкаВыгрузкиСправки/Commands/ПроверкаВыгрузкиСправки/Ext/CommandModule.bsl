﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	СтруктураОтбора = Новый Структура("Проект", ПараметрКоманды);
	
	ПараметрыФормы = Новый Структура("КлючВарианта, Отбор, СформироватьПриОткрытии, ВидимостьКомандВариантовОтчетов", 
		"ПроверкаВыгрузкиСправкиКонтекстная",
		СтруктураОтбора, 
		Истина,
		Ложь);
		
	ОткрытьФорму(
		"Отчет.ПроверкаВыгрузкиСправки.Форма",
		ПараметрыФормы, ,
		Истина,
		ПараметрыВыполненияКоманды.Окно);

КонецПроцедуры
