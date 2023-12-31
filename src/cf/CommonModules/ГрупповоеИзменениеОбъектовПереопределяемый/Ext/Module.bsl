﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Определить объекты метаданных, в формах списков которых
// будут выведены команды объединения дублей и замены ссылок
// см. ПоискИУдалениеДублейКлиент.ОбъединитьВыделенные и ПоискИУдалениеДублейКлиент.ЗаменитьВыделенные
// 
// Параметры:
//  Объекты - Массив из ОбъектМетаданных
//
// Пример:
//	Объекты.Добавить(Метаданные.Справочники._ДемоНоменклатура);
//	Объекты.Добавить(Метаданные.Справочники._ДемоКонтрагенты);
//
Процедура ПриОпределенииОбъектовСКомандойГрупповогоИзмененияОбъектов(Объекты) Экспорт

	

КонецПроцедуры

// Определить объекты метаданных, в модулях менеджеров которых ограничивается возможность 
// редактирования реквизитов при групповом изменении.
//
// Параметры:
//   Объекты - Соответствие - в качестве ключа указать полное имя объекта метаданных,
//                            подключенного к подсистеме "Групповое изменение объектов". 
//                            Дополнительно в значении могут быть перечислены имена экспортных функций:
//                            "РеквизитыНеРедактируемыеВГрупповойОбработке",
//                            "РеквизитыРедактируемыеВГрупповойОбработке".
//                            Каждое имя должно начинаться с новой строки.
//                            Если указано "*", значит в модуле менеджера определены обе функции.
//
// Пример: 
//   Объекты.Вставить(Метаданные.Документы.ЗаказПокупателя.ПолноеИмя(), "*"); // определены обе функции.
//   Объекты.Вставить(Метаданные.БизнесПроцессы.ЗаданиеСРолевойАдресацией.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
//   Объекты.Вставить(Метаданные.Справочники.Партнеры.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке
//		|РеквизитыНеРедактируемыеВГрупповойОбработке");
//
Процедура ПриОпределенииОбъектовСРедактируемымиРеквизитами(Объекты) Экспорт
	
	Объекты.Вставить(Метаданные.Справочники.ВерсииПроекта.ПолноеИмя(), "РеквизитыНеРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.Ветки.ПолноеИмя(), "РеквизитыНеРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ВидыДоступа.ПолноеИмя(), "РеквизитыНеРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ЗадачиПроцесса.ПолноеИмя(), "РеквизитыНеРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.Идеи.ПолноеИмя(), "РеквизитыНеРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.КонтрольныеТочкиТехническихПроектов.ПолноеИмя(), "РеквизитыНеРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.МакетыОбъектовМетаданных.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ОбъектыМетаданных.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.Ошибки.ПолноеИмя(), "РеквизитыНеРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.Подсистемы.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ПравилаПроверкиОбъектов.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ПрофилиПользователей.ПолноеИмя(), "РеквизитыНеРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.Процессы.ПолноеИмя(), "РеквизитыНеРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.РазделыПроекта.ПолноеИмя(), "РеквизитыНеРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.Регламенты.ПолноеИмя(), "РеквизитыНеРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ТехническиеПроекты.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ФормыОбъектовМетаданных.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ФункцииСистемы.ПолноеИмя(), "РеквизитыНеРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ЦелевыеЗадачи.ПолноеИмя(), "РеквизитыНеРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ШагиПроцесса.ПолноеИмя(), "РеквизитыНеРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.СценарииРаботыПользователей.ПолноеИмя(), "РеквизитыНеРедактируемыеВГрупповойОбработке");
	
КонецПроцедуры

#КонецОбласти
