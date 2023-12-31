﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	СсылкаНаОбъект = Параметры.Ссылка;
	
	Если ЗначениеЗаполнено(СсылкаНаОбъект) Тогда
		СформироватьДиаграмму();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ДиаграммаОбработкаРасшифровки(Элемент, Расшифровка, СтандартнаяОбработка)
	
	Если ТипЗнч(Расшифровка) = Тип("СправочникСсылка.РеквизитыОбъектовМетаданных") Тогда
		
		СтандартнаяОбработка = Ложь;
		
		МассивОбъектовМетаданных = ПолучитьМассивОбъектовПоРасшифровке(Расшифровка);
		
		Для Каждого ОбъектМетаданных из МассивОбъектовМетаданных Цикл
			
			ПараметрыФормы = Новый Структура();
			ПараметрыФормы.Вставить("Ключ", ОбъектМетаданных);
			ПараметрыФормы.Вставить("Реквизит", Расшифровка);
			
			ОткрытьФорму("Справочник.ОбъектыМетаданных.ФормаОбъекта", ПараметрыФормы, ЭтаФорма);
		КонецЦикла;
		
	Иначе
		СтандартнаяОбработка = Истина;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Обновить(Команда)
	
	Если ЗначениеЗаполнено(СсылкаНаОбъект) Тогда
		СформироватьДиаграмму();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Печать(Команда)
	
	Диаграмма.Напечатать();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура СформироватьДиаграмму()
	
	ERДиаграммы.СформироватьERДиаграммуОбъекта(СсылкаНаОбъект, Диаграмма);
	
КонецПроцедуры

&НаСервере
Функция ПолучитьМассивОбъектовПоРасшифровке(ЗначениеРасшифровки)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	РеквизитыОбъектовМетаданных.Владелец КАК ОбъектМетаданных
	|ИЗ
	|	Справочник.РеквизитыОбъектовМетаданных КАК РеквизитыОбъектовМетаданных
	|ГДЕ
	|	РеквизитыОбъектовМетаданных.Ссылка = &Ссылка"
	;
	
	Запрос.УстановитьПараметр("Ссылка", ЗначениеРасшифровки);
	
	МассивОбъектов = Новый Массив();
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		МассивОбъектов.Добавить(Выборка.ОбъектМетаданных);
	КонецЕсли;
	
	Возврат МассивОбъектов;
		
КонецФункции

#КонецОбласти
