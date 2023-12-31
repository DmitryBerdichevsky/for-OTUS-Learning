﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если ЗначениеЗаполнено(Параметры.Ссылка) Тогда
		Если ТипЗнч(Параметры.Ссылка) = Тип("СправочникСсылка.ТехническиеПроекты") Тогда
			ТекстДляХранилища = ТехническиеПроекты.ТекстДляХранилищаКонфигурации(Параметры.Ссылка);
		ИначеЕсли ТипЗнч(Параметры.Ссылка) = Тип("СправочникСсылка.Ошибки") Тогда
			ТекстДляХранилища = Справочники.Ошибки.ТекстДляХранилищаКонфигурации(Параметры.Ссылка);
		ИначеЕсли ТипЗнч(Параметры.Ссылка) = Тип("СправочникСсылка.ЗадачиПроцесса") Тогда
			ТекстДляХранилища = Справочники.ЗадачиПроцесса.ТекстДляХранилищаКонфигурации(Параметры.Ссылка);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Элементы.ТекстДляХранилища.УстановитьГраницыВыделения(1,СтрДлина(ТекстДляХранилища)+1);
	
КонецПроцедуры

#КонецОбласти