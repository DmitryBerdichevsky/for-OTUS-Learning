﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ОткрытьФорму(
		"Отчет.Процессы.Форма",
		Новый Структура("Отбор,СформироватьПриОткрытии", Новый Структура("Процесс", ПараметрКоманды), Истина),
		,
		"Процесс=" + ПараметрКоманды,
		ПараметрыВыполненияКоманды.Окно
	);
	
КонецПроцедуры
