﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"ПрисоединитьДополнительныеТаблицы
	|ЭтотСписок КАК КартинкиСправки
	|
	|ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ЭлементыСправки.КартинкиДляСправки КАК КартинкиДляСправки
	|	ПО КартинкиДляСправки.Картинка = КартинкиСправки.Ссылка;
	|РазрешитьЧтениеИзменение
	|ГДЕ
	|	ВЫБОР
	|		КОГДА ТипЗначения(КартинкиДляСправки.Ссылка.Владелец) = Тип(Справочник.ФормыОбъектовМетаданных)
	|		ТОГДА ЗначениеРазрешено(ВЫРАЗИТЬ(КартинкиДляСправки.Ссылка.Владелец КАК Справочник.ФормыОбъектовМетаданных).Владелец)
	|		ИНАЧЕ ЗначениеРазрешено(КартинкиДляСправки.Ссылка.Владелец)
	|	КОНЕЦ";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти
	
#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаполнитьОбъектыМетаданных(ОбъектыМетаданных, Проект) Экспорт
	
	КоллекцияОбъектов = ОбъектыМетаданных.ПолучитьЭлементы();	
	КоллекцияОбъектов.Очистить();
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ТаблицаТипОбъектаИндексКартинки.ИндексКартинки КАК ИндексКартинки,
	|	ТаблицаТипОбъектаИндексКартинки.ТипОбъекта КАК ТипОбъекта
	|ПОМЕСТИТЬ ТаблицаТипОбъектаИндексКартинки
	|ИЗ
	|	&ТаблицаТипОбъектаИндексКартинки КАК ТаблицаТипОбъектаИндексКартинки
	|ГДЕ
	|	НЕ ТаблицаТипОбъектаИндексКартинки.ЭтоГруппа
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	ТаблицаТипОбъектаИндексКартинки.ТипОбъекта
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
	|	КартинкиСправки.Ссылка КАК КартинкаСправки,
	|	КартинкиСправки.Наименование КАК Наименование,
	|	КартинкиСправки.Размер КАК Размер,
	|	КартинкиСправки.Расширение КАК Расширение,
	|	Подсистемы.Ссылка КАК Подсистема,
	|	Подсистемы.Имя КАК ИмяПодсистемы,
	|	ОбъектыМетаданных.Ссылка КАК ОбъектМетаданных,
	|	ОбъектыМетаданных.Имя КАК ИмяОбъектаМетаданных,
	|	ОбъектыМетаданных.Родитель КАК ТипОбъекта,
	|	ОбъектыМетаданных.Родитель.Имя КАК ИмяТипаОбъекта,
	|	ФормыОбъектовМетаданных.Ссылка КАК ФормаОбъекта,
	|	ФормыОбъектовМетаданных.Имя КАК ИмяФормыОбъекта,
	|	ФормыОбъектовМетаданных.Владелец КАК ФормаОбъектаОбъект,
	|	ФормыОбъектовМетаданных.Владелец.Имя КАК ФормаОбъектаИмяОбъекта,
	|	ФормыОбъектовМетаданных.Владелец.Родитель КАК ФормаОбъектаТипОбъекта,
	|	ФормыОбъектовМетаданных.Владелец.Родитель.Имя КАК ФормаОбъектаИмяТипаОбъекта,
	|	ЕСТЬNULL(ТаблицаТипОбъектаИндексКартинки.ИндексКартинки, 91) КАК ИндексКартинки
	|ИЗ
	|	Справочник.ЭлементыСправки КАК ЭлементыСправки
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ЭлементыСправки.КартинкиДляСправки КАК КартинкиДляСправкиТЧ
	|		ПО (КартинкиДляСправкиТЧ.Ссылка = ЭлементыСправки.Ссылка)
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.КартинкиСправки КАК КартинкиСправки
	|		ПО (КартинкиДляСправкиТЧ.Картинка = КартинкиСправки.Ссылка)
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Подсистемы КАК Подсистемы
	|		ПО ЭлементыСправки.Владелец = Подсистемы.Ссылка
	|			И (Подсистемы.Владелец = &Проект)
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ОбъектыМетаданных КАК ОбъектыМетаданных
	|		ПО ЭлементыСправки.Владелец = ОбъектыМетаданных.Ссылка
	|			И (ОбъектыМетаданных.Владелец = &Проект)
	|		ЛЕВОЕ СОЕДИНЕНИЕ ТаблицаТипОбъектаИндексКартинки КАК ТаблицаТипОбъектаИндексКартинки
	|		ПО (ОбъектыМетаданных.Родитель.Имя = ТаблицаТипОбъектаИндексКартинки.ТипОбъекта)
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ФормыОбъектовМетаданных КАК ФормыОбъектовМетаданных
	|		ПО ЭлементыСправки.Владелец = ФормыОбъектовМетаданных.Ссылка
	|			И (ФормыОбъектовМетаданных.Владелец.Владелец = &Проект)
	|ГДЕ
	|	(НЕ ОбъектыМетаданных.Ссылка ЕСТЬ NULL
	|			ИЛИ НЕ ФормыОбъектовМетаданных.Ссылка ЕСТЬ NULL
	|			ИЛИ НЕ Подсистемы.Ссылка ЕСТЬ NULL)
	|
	|УПОРЯДОЧИТЬ ПО
	|	ОбъектМетаданных,
	|	ФормаОбъекта,
	|	Подсистема";
	
	ТаблицаТипОбъектаИндексКартинки = РаботаСОбъектамиМетаданных.ТаблицаТипОбъектаИндексКартинки();	
	
	Запрос.УстановитьПараметр("Проект", Проект);
	Запрос.УстановитьПараметр("ТаблицаТипОбъектаИндексКартинки", ТаблицаТипОбъектаИндексКартинки);
	
	Результат = Запрос.Выполнить();
	
	Выборка = Результат.Выбрать();
	
	ЭлементыДерева = Новый Соответствие;
	
	Пока Выборка.Следующий() Цикл
		Если ЗначениеЗаполнено(Выборка.Подсистема) Тогда
			
			ТипОбъекта = ЭлементыДерева.Получить(Справочники.Подсистемы.ПустаяСсылка());
			Если ТипОбъекта = Неопределено Тогда
				ТипОбъекта = КоллекцияОбъектов.Добавить();
				ТипОбъекта.Ссылка = Справочники.Подсистемы.ПустаяСсылка();
				ТипОбъекта.Представление = НСтр("ru = 'Подсистемы'");
				ТипОбъекта.ИндексКартинки = 19;
				ЭлементыДерева.Вставить(ТипОбъекта.Ссылка, ТипОбъекта);
			КонецЕсли;
			
			Подсистема = ЭлементыДерева.Получить(Выборка.Подсистема);
			Если Подсистема = Неопределено Тогда
				Подсистема = ТипОбъекта.ПолучитьЭлементы().Добавить(); 
				Подсистема.Ссылка = Выборка.Подсистема;
				Подсистема.Представление = Выборка.ИмяПодсистемы;
				Подсистема.ИндексКартинки = 19;
				ЭлементыДерева.Вставить(Подсистема.Ссылка, Подсистема);
			КонецЕсли;
			
			КартинкаСправки = Подсистема.ПолучитьЭлементы().Добавить();
			КартинкаСправки.Ссылка = Выборка.КартинкаСправки;
			КартинкаСправки.Представление = Выборка.Наименование;
			КартинкаСправки.ИндексКартинки = 97;
			КартинкаСправки.Размер = Выборка.Размер;
			КартинкаСправки.Расширение = Выборка.Расширение;
						
		ИначеЕсли ЗначениеЗаполнено(Выборка.ОбъектМетаданных) Тогда
			
			ТипОбъекта = ЭлементыДерева.Получить(Выборка.ТипОбъекта);
			Если ТипОбъекта = Неопределено Тогда
				ТипОбъекта = КоллекцияОбъектов.Добавить();
				ТипОбъекта.Ссылка = Выборка.ТипОбъекта;
				ТипОбъекта.Представление = Выборка.ИмяТипаОбъекта;
				ТипОбъекта.ИндексКартинки = Выборка.ИндексКартинки;
				ЭлементыДерева.Вставить(ТипОбъекта.Ссылка, ТипОбъекта);
			КонецЕсли;
			
			ОбъектМетаданных = ЭлементыДерева.Получить(Выборка.ОбъектМетаданных);
			Если ОбъектМетаданных = Неопределено Тогда
				ОбъектМетаданных = ТипОбъекта.ПолучитьЭлементы().Добавить(); 
				ОбъектМетаданных.Ссылка = Выборка.ОбъектМетаданных;
				ОбъектМетаданных.Представление = Выборка.ИмяОбъектаМетаданных;
				ОбъектМетаданных.ИндексКартинки = Выборка.ИндексКартинки;
				ЭлементыДерева.Вставить(ОбъектМетаданных.Ссылка, ОбъектМетаданных);
			КонецЕсли;

			КартинкаСправки = ОбъектМетаданных.ПолучитьЭлементы().Добавить();
			КартинкаСправки.Ссылка = Выборка.КартинкаСправки;
			КартинкаСправки.Представление = Выборка.Наименование;
	        КартинкаСправки.ИндексКартинки = 97;
			КартинкаСправки.Размер = Выборка.Размер;
			КартинкаСправки.Расширение = Выборка.Расширение;

		ИначеЕсли ЗначениеЗаполнено(Выборка.ФормаОбъекта) Тогда
			
			ТипОбъекта = ЭлементыДерева.Получить(Выборка.ФормаОбъектаТипОбъекта);
			Если ТипОбъекта = Неопределено Тогда
				ТипОбъекта = КоллекцияОбъектов.Добавить();
				ТипОбъекта.Ссылка = Выборка.ФормаОбъектаТипОбъекта;
				ТипОбъекта.Представление = Выборка.ФормаОбъектаИмяТипаОбъекта;
				ТипОбъекта.ИндексКартинки = Выборка.ИндексКартинки;
				ЭлементыДерева.Вставить(ТипОбъекта.Ссылка, ТипОбъекта);
			КонецЕсли;

			ОбъектМетаданных = ЭлементыДерева.Получить(Выборка.ФормаОбъектаОбъект);
			Если ОбъектМетаданных = Неопределено Тогда
				ОбъектМетаданных = ТипОбъекта.ПолучитьЭлементы().Добавить();
				ОбъектМетаданных.Ссылка = Выборка.ФормаОбъектаОбъект;
				ОбъектМетаданных.Представление = Выборка.ФормаОбъектаИмяОбъекта;
				ОбъектМетаданных.ИндексКартинки = Выборка.ИндексКартинки;
				ЭлементыДерева.Вставить(ОбъектМетаданных.Ссылка, ОбъектМетаданных);
			КонецЕсли;
			
			ФормаОбъекта = ЭлементыДерева.Получить(Выборка.ФормаОбъекта);
			Если ФормаОбъекта = Неопределено Тогда
				ФормаОбъекта = ОбъектМетаданных.ПолучитьЭлементы().Добавить(); 
				ФормаОбъекта.Ссылка = Выборка.ФормаОбъекта;
				ФормаОбъекта.Представление = Выборка.ИмяФормыОбъекта;
				ФормаОбъекта.ИндексКартинки = 47;
				ЭлементыДерева.Вставить(ФормаОбъекта.Ссылка, ФормаОбъекта);
			КонецЕсли;

			КартинкаСправки = ФормаОбъекта.ПолучитьЭлементы().Добавить();
			КартинкаСправки.Ссылка = Выборка.КартинкаСправки;
			КартинкаСправки.Представление = Выборка.Наименование;
			КартинкаСправки.ИндексКартинки = 97;
			КартинкаСправки.Размер = Выборка.Размер;
			КартинкаСправки.Расширение = Выборка.Расширение;
			
		КонецЕсли;
		
	КонецЦикла;
		
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьНеИспользуемыеКартинки(НеиспользуемыеКартинки) Экспорт
		
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
	|	КартинкиСправки.Ссылка,
	|	КартинкиСправки.Представление,
	|	КартинкиСправки.Размер,
	|	КартинкиСправки.Расширение
	|ИЗ
	|	Справочник.КартинкиСправки КАК КартинкиСправки
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ЭлементыСправки КАК ЭлементыСправки
	|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ЭлементыСправки.КартинкиДляСправки КАК КартинкиДляСправкиТЧ
	|			ПО (КартинкиДляСправкиТЧ.Ссылка = ЭлементыСправки.Ссылка)
	|		ПО (КартинкиДляСправкиТЧ.Картинка = КартинкиСправки.Ссылка)
	|ГДЕ
	|	ЭлементыСправки.Ссылка ЕСТЬ NULL ";
		
	Результат = Запрос.Выполнить();
	
	НеИспользуемыеКартинки.Загрузить(Результат.Выгрузить());
		
КонецПроцедуры

#КонецОбласти

#КонецЕсли