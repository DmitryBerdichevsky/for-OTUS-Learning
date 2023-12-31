﻿
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтение
	|ГДЕ ИСТИНА
	|;
	|РазрешитьИзменениеЕслиРазрешеноЧтение
	|ГДЕ
	|	ЗначениеРазрешено(Пользователь)";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

Функция ДанныеКонфликтующейЗаписиОЗамещении(ДанныеПроверямойЗаписи, ДанныеЗамещаемойЗаписи) Экспорт
	
	ТекстЗапроса =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
	|	ЗамещениеПользователейПоРаботеСОшибками.Пользователь КАК Пользователь,
	|	ЗамещениеПользователейПоРаботеСОшибками.Проект КАК Проект,
	|	ЗамещениеПользователейПоРаботеСОшибками.ДатаНачалаЗамещения КАК ДатаНачалаЗамещения,
	|	ЗамещениеПользователейПоРаботеСОшибками.ДатаОкончанияЗамещения КАК ДатаОкончанияЗамещения
	|ИЗ
	|	РегистрСведений.ЗамещениеПользователейПоРаботеСОшибками КАК ЗамещениеПользователейПоРаботеСОшибками
	|ГДЕ
	|	ЗамещениеПользователейПоРаботеСОшибками.Пользователь = &ПроверяемыйПользователь
	|	И ЗамещениеПользователейПоРаботеСОшибками.Проект = &ПроверяемыйПроект
	|	И ((&ПроверяемаяДатаНачалаЗамещения >= ЗамещениеПользователейПоРаботеСОшибками.ДатаНачалаЗамещения
	|				ИЛИ ЗамещениеПользователейПоРаботеСОшибками.ДатаНачалаЗамещения = ДАТАВРЕМЯ(1, 1, 1))
	|				И &ПроверяемаяДатаНачалаЗамещения <= ЗамещениеПользователейПоРаботеСОшибками.ДатаОкончанияЗамещения
	|			ИЛИ &ПроверяемаяДатаОкончанияЗамещения >= ЗамещениеПользователейПоРаботеСОшибками.ДатаНачалаЗамещения
	|				И (&ПроверяемаяДатаОкончанияЗамещения <= ЗамещениеПользователейПоРаботеСОшибками.ДатаОкончанияЗамещения
	|					ИЛИ ЗамещениеПользователейПоРаботеСОшибками.ДатаОкончанияЗамещения = ДАТАВРЕМЯ(1, 1, 1))
	|			ИЛИ &ПроверяемаяДатаНачалаЗамещения <= ЗамещениеПользователейПоРаботеСОшибками.ДатаНачалаЗамещения
	|				И (&ПроверяемаяДатаОкончанияЗамещения >= ЗамещениеПользователейПоРаботеСОшибками.ДатаОкончанияЗамещения
	|					ИЛИ &ПроверяемаяДатаОкончанияЗамещения = ДАТАВРЕМЯ(1, 1, 1)))
	|	И (ЗамещениеПользователейПоРаботеСОшибками.Пользователь <> &ПользовательЗамещаемойЗаписи
	|			ИЛИ ЗамещениеПользователейПоРаботеСОшибками.Проект <> &ПроектЗамещаемойЗаписи
	|			ИЛИ ЗамещениеПользователейПоРаботеСОшибками.ДатаНачалаЗамещения <> &ДатаНачалаЗамещенияЗамещаемойЗаписи
	|			ИЛИ ЗамещениеПользователейПоРаботеСОшибками.ДатаОкончанияЗамещения <> &ДатаОкончанияЗамещенияЗамещаемойЗаписи)"
	;
	
	Запрос = Новый Запрос(ТекстЗапроса);
	
	Запрос.УстановитьПараметр("ПроверяемыйПользователь", ДанныеПроверямойЗаписи.Пользователь);
	Запрос.УстановитьПараметр("ПроверяемыйПроект", ДанныеПроверямойЗаписи.Проект);
	Запрос.УстановитьПараметр("ПроверяемаяДатаНачалаЗамещения", ДанныеПроверямойЗаписи.ДатаНачалаЗамещения);
	Запрос.УстановитьПараметр("ПроверяемаяДатаОкончанияЗамещения", ДанныеПроверямойЗаписи.ДатаОкончанияЗамещения);
	
	Запрос.УстановитьПараметр("ПользовательЗамещаемойЗаписи", ДанныеЗамещаемойЗаписи.Пользователь);
	Запрос.УстановитьПараметр("ПроектЗамещаемойЗаписи", ДанныеЗамещаемойЗаписи.Проект);
	Запрос.УстановитьПараметр("ДатаНачалаЗамещенияЗамещаемойЗаписи", ДанныеЗамещаемойЗаписи.ДатаНачалаЗамещения);
	Запрос.УстановитьПараметр("ДатаОкончанияЗамещенияЗамещаемойЗаписи", ДанныеЗамещаемойЗаписи.ДатаОкончанияЗамещения);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Результат = Новый Структура;
	Результат.Вставить("Пользователь", Справочники.Пользователи.ПустаяСсылка());
	Результат.Вставить("Проект", Справочники.Проекты.ПустаяСсылка());
	Результат.Вставить("ДатаНачалаЗамещения", '00010101');
	Результат.Вставить("ДатаОкончанияЗамещения", '00010101');
	
	Если Выборка.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(Результат, Выборка);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

#КонецЕсли
