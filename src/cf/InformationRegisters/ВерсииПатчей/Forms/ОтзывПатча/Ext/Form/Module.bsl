﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Патч = Параметры.Патч;
	Версия = Параметры.Версия;
	ИдентификаторПатча = Параметры.УникальныйИдентификатор;
	
	Заголовок = НСтр("ru = 'Отзыв патча для версии %1'");
	Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Заголовок, Версия);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Отозвать(Команда)
	Если Не ПроверитьЗаполнение() Тогда
		Возврат;
	КонецЕсли;
	
	ТекстВопроса = НСтр("ru = 'Отозвать версию патча?'");
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПодтвердитьОтзывПатча", ЭтотОбъект);
	КнопкиДаНет = РежимДиалогаВопрос.ДаНет;
	ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, КнопкиДаНет, , КодВозвратаДиалога.Да);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПодтвердитьОтзывПатча(Результат, ДополнительныеПараметры) Экспорт
	Если Результат <> КодВозвратаДиалога.Да Тогда
		Возврат;
	КонецЕсли;
	ОтозватьПатчНаСервере();
	
	Закрыть("Успешно");
КонецПроцедуры

&НаСервере
Процедура ОтозватьПатчНаСервере()
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("УникальныйИдентификатор", ИдентификаторПатча);
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ВерсииПатчей.УникальныйИдентификатор КАК УникальныйИдентификатор,
		|	ВерсииПатчей.Параметры КАК Параметры,
		|	ВерсииПатчей.ПодписанДляКонфигурации КАК ПодписанДляКонфигурации
		|ИЗ
		|	РегистрСведений.ВерсииПатчей КАК ВерсииПатчей
		|ГДЕ
		|	ВерсииПатчей.УникальныйИдентификатор = &УникальныйИдентификатор";
	СвойстваВерсии = Запрос.Выполнить().Выгрузить()[0];
	
	ТекстСообщения = НСтр("ru = 'Причина'") + ":" + Символы.ПС + ОписаниеПричиныОтзыва;
	
	УстановитьПривилегированныйРежим(Истина);
	ТекстОшибки = ПатчиСлужебный.ОтзывПатчаСБазовымиВерсиями(СвойстваВерсии, ПричинаОтзыва, ТекстСообщения);
	УстановитьПривилегированныйРежим(Ложь);
	
	Если ЗначениеЗаполнено(ТекстОшибки) Тогда
		ВызватьИсключение ТекстОшибки;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти
