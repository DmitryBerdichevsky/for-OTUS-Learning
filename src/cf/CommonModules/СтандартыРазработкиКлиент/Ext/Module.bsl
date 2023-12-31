﻿////////////////////////////////////////////////////////////////////////////////
// Подсистема "Органайзер".
// 
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Открыть указанный стандарт.
// Если стандарт внешний, то он открывается в браузере.
// Если стандарт внутренний, то открывается форма элемента справочника этого стандарта.
//
// Параметры:
//  Стандарт - СправочникСсылка - открываемый стандарт.
//
Процедура ОткрытьСтандарт(Стандарт) Экспорт
	
	НавигационнаяСсылка = СтандартыРазработкиВызовСервера.НавигационнаяСсылкаНаСтандарт(Стандарт);
	
	Если НавигационнаяСсылка <> Неопределено Тогда
		ПерейтиПоНавигационнойСсылке(НавигационнаяСсылка);
	КонецЕсли;
	
КонецПроцедуры

// Открыть форму "Справочник.СтандартыРазработки.Форма.ФормаИзучения".
// Если Поручение = Ложь, то это форма для сохранения стандартов, которые нужно изучить самому.
// Если Поручение = Истина, то это форма для поручения изучения указанных стандартов пользователям,
// которых можно добавить при помощи подбора.
//
// Параметры:
//  Стандарты - Массив ссылок на стандарты, которые нужно изучить.
//  Поручение - Булево - признак поручения (см. выше).
//  ПараметрыОткрытия - Структура - дополнительные параметры открытия формы.
//
Процедура ОткрытьФормуИзученияСтандартов(Стандарты, Поручение = Ложь, ПараметрыОткрытия = Неопределено) Экспорт
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Стандарты", Стандарты);
	ПараметрыФормы.Вставить("НесколькоПользователей", Поручение);
	Дополнительно = ПараметрыОткрытия <> Неопределено;
	
	ОткрытьФорму("Справочник.СтандартыРазработки.Форма.ФормаИзучения",
		ПараметрыФормы,
		?(Дополнительно, ПараметрыОткрытия.Источник, Неопределено),
		?(Дополнительно, ПараметрыОткрытия.Уникальность, Ложь),
		?(Дополнительно, ПараметрыОткрытия.Окно, Неопределено),
		?(Дополнительно, ПараметрыОткрытия.НавигационнаяСсылка, Неопределено));
	
КонецПроцедуры

// Обработчик выбора стандарта в списке.
// Выбранный стандарт открывается при помощи процедуры ОткрытьСтандарт().
//
// Параметры:
//  Элемент - элемент формы в котором выполняется выбор.
//  ВыбраннаяСтрока - идентификатор выбранной строки.
//  Поле - поле в котором выполнен выбор.
//  СтандартнаяОбработка - Булево - признак стандартной обработки.
//
Процедура ПриВыбореСтандартаВСписке(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка) Экспорт
	
	ДанныеСтроки = Элемент.ДанныеСтроки(ВыбраннаяСтрока);
	
	Если ДанныеСтроки <> Неопределено И Не ДанныеСтроки.ЭтоГруппа Тогда
		СтандартнаяОбработка = Ложь;
		ОткрытьСтандарт(ВыбраннаяСтрока);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
