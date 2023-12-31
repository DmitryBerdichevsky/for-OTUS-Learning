﻿
#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	СтруктураОтбора = Новый Структура;
	
	ПараметрыФормы = Новый Структура("КлючВарианта, Отбор, СформироватьПриОткрытии, ВидимостьКомандВариантовОтчетов", 
 		                             "ЗатратыВремени",
		                             СтруктураОтбора, 
		                             Ложь,
		                             Истина);
										 
	Если ТипЗнч(ПараметрКоманды) = Тип("СправочникСсылка.ТехническиеПроекты") Тогда
		
		СтруктураОтбора = Новый Структура;
		СтруктураОтбора.Вставить("ТехническийПроект", ПараметрКоманды);
		
		ПараметрыФормы = Новый Структура("КлючВарианта, Отбор, СформироватьПриОткрытии, ВидимостьКомандВариантовОтчетов", 
 		                                 "ЗатратыВремениПоТехническомуПроекту",
		                                 СтруктураОтбора, 
		                                 Истина,
		                                 Истина);

	ИначеЕсли ТипЗнч(ПараметрКоманды) = Тип("СправочникСсылка.ЗадачиПроцесса") Тогда
		
		СтруктураОтбора = Новый Структура;
		СтруктураОтбора.Вставить("Задача", ПараметрКоманды);
		
		ПараметрыФормы = Новый Структура("КлючВарианта, Отбор, СформироватьПриОткрытии, ВидимостьКомандВариантовОтчетов", 
 		                                 "ЗатратыВремениПоЗадаче",
		                                 СтруктураОтбора, 
		                                 Истина,
		                                 Истина);
										 
	ИначеЕсли ТипЗнч(ПараметрКоманды) = Тип("СправочникСсылка.Ошибки") Тогда
		
		СтруктураОтбора = Новый Структура;
		СтруктураОтбора.Вставить("Ошибка", ПараметрКоманды);
		
		ПараметрыФормы = Новый Структура("КлючВарианта, Отбор, СформироватьПриОткрытии, ВидимостьКомандВариантовОтчетов", 
 		                                 "ЗатратыВремениПоОшибке",
		                                 СтруктураОтбора, 
		                                 Истина,
		                                 Истина);
										 
	ИначеЕсли ТипЗнч(ПараметрКоманды) = Тип("СправочникСсылка.Пользователи") Тогда
		
		СтруктураОтбора = Новый Структура;
		СтруктураОтбора.Вставить("Пользователь", ПараметрКоманды);
		
		ПараметрыФормы = Новый Структура("КлючВарианта, Отбор, СформироватьПриОткрытии, ВидимостьКомандВариантовОтчетов", 
 		                                 "ЗатратыВремениПоПользователю",
		                                 СтруктураОтбора, 
		                                 Истина,
		                                 Истина);
		
	ИначеЕсли ТипЗнч(ПараметрКоманды) = Тип("ДокументСсылка.УчетВремени") Тогда
		
		СтруктураОтбора = Новый Структура;
		СтруктураОтбора.Вставить("Регистратор", ПараметрКоманды);
		
		ПараметрыФормы = Новый Структура("КлючВарианта, Отбор, СформироватьПриОткрытии, ВидимостьКомандВариантовОтчетов", 
 		                                 "ЗатратыВремениПоРегистратору",
		                                 СтруктураОтбора, 
		                                 Истина,
		                                 Истина);
										 
	КонецЕсли;
		
	ОткрытьФорму("Отчет.ЗатратыВремени.Форма",
		ПараметрыФормы, ,
		Истина,
		ПараметрыВыполненияКоманды.Окно);
		
КонецПроцедуры

#КонецОбласти