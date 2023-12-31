﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	СтруктураБыстрогоОтбора = Неопределено;
	Параметры.Свойство("СтруктураБыстрогоОтбора", СтруктураБыстрогоОтбора);
	
	ТекущийПользователь = Пользователи.ТекущийПользователь();
	Список.Параметры.УстановитьЗначениеПараметра("Ответственный", ТекущийПользователь);
	
	Если ОбщегоНазначенияСППРКлиентСервер.НеобходимОтборПоКолонкеПриСозданииНаСервере("Действие", СписокДействий, СтруктураБыстрогоОтбора) Тогда
		УстановитьОтборПоДействию();
	КонецЕсли;
	
	Если ОбщегоНазначенияСППРКлиентСервер.НеобходимОтборПоКолонкеПриСозданииНаСервере("СрокОтработки", СписокСроков, СтруктураБыстрогоОтбора) Тогда
		УстановитьОтборПоСрокуОтработки();
	КонецЕсли;
	
	Если ОбщегоНазначенияСППРКлиентСервер.НеобходимОтборПоКолонкеПриСозданииНаСервере("ВыполнитьНеПозднее", СписокСроковВыполненияОбщейЗадачи, СтруктураБыстрогоОтбора) Тогда
		УстановитьОтборПоСрокуВыполненияОбщейЗадачи();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПередЗагрузкойДанныхИзНастроекНаСервере(Настройки)
	
	Если ОбщегоНазначенияСППРКлиентСервер.НеобходимОтборПоКолонкеПередЗагрузкойИзНастроек("Действие",
			"СписокДействий",
			СписокДействий,
			СтруктураБыстрогоОтбора,
			Настройки) Тогда
			
		УстановитьОтборПоДействию();
	КонецЕсли;
	
	Если ОбщегоНазначенияСППРКлиентСервер.НеобходимОтборПоКолонкеПередЗагрузкойИзНастроек("СрокОтработки",
			"СписокСроков",
			СписокСроков,
			СтруктураБыстрогоОтбора,
			Настройки) Тогда
			
		УстановитьОтборПоСрокуОтработки();
	КонецЕсли;
	
	Если ОбщегоНазначенияСППРКлиентСервер.НеобходимОтборПоКолонкеПередЗагрузкойИзНастроек("ВыполнитьНеПозднее",
			"СписокСроковВыполненияОбщейЗадачи",
			СписокСроковВыполненияОбщейЗадачи,
			СтруктураБыстрогоОтбора,
			Настройки) Тогда
			
		УстановитьОтборПоСрокуВыполненияОбщейЗадачи();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СписокДействийПриИзменении(Элемент)
	
	УстановитьОтборПоДействию();
	
КонецПроцедуры

&НаКлиенте
Процедура СписокДействийНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	СтруктураПараметров = Новый Структура("СписокВыбора", СписокДействий);
	
	ОткрытьФорму("РегистрСведений.ВыполнениеОбщихЗадач.Форма.ВыборДействияПоОбщейЗадаче", СтруктураПараметров, Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура СписокДействийОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	СписокДействий = ВыбранноеЗначение;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокСроковПриИзменении(Элемент)
	
	УстановитьОтборПоСрокуОтработки();
	
КонецПроцедуры

&НаКлиенте
Процедура СписокСроковНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	СтруктураПараметров = Новый Структура("СписокВыбора", СписокСроков);
	
	ОткрытьФорму("ОбщаяФорма.ВыборСроковОтработки", СтруктураПараметров, Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура СписокСроковОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	СписокСроков = ВыбранноеЗначение;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокСроковВыполненияОбщейЗадачиПриИзменении(Элемент)
	
	УстановитьОтборПоСрокуВыполненияОбщейЗадачи();
	
КонецПроцедуры

&НаКлиенте
Процедура СписокСроковВыполненияОбщейЗадачиНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	СтруктураПараметров = Новый Структура("СписокВыбора", СписокСроковВыполненияОбщейЗадачи);
	
	ОткрытьФорму("ОбщаяФорма.ВыборСроковОтработки", СтруктураПараметров, Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура СписокСроковВыполненияОбщейЗадачиОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	СписокСроковВыполненияОбщейЗадачи = ВыбранноеЗначение;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьОтборПоДействию()
	
	ОтборТребуетсяЗапланировать = (СписокДействий.НайтиПоЗначению("Требуется запланировать") <> Неопределено);
	ОтборВыполнить = (СписокДействий.НайтиПоЗначению("Выполнить") <> Неопределено);
	
	ГруппаИЛИПоДействию =
		ОбщегоНазначенияКлиентСервер.СоздатьГруппуЭлементовОтбора(Список.КомпоновщикНастроек.ФиксированныеНастройки.Отбор.Элементы,
																	"Отбор по действию",
																	ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИли);
																	
    ГруппаИЛИПоДействию.Использование = ОтборТребуетсяЗапланировать ИЛИ ОтборВыполнить;
	
	ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(ГруппаИЛИПоДействию, "СтатусВыполнения", ВидСравненияКомпоновкиДанных.Равно, Перечисления.СтатусыОбщихЗадач.ТребуетсяЗапланировать,,ОтборТребуетсяЗапланировать);
	ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(ГруппаИЛИПоДействию, "СтатусВыполнения", ВидСравненияКомпоновкиДанных.Равно, Перечисления.СтатусыОбщихЗадач.Запланирована,,ОтборВыполнить);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьОтборПоСрокуОтработки()
	
	ТекущаяДата = НачалоДня(ТекущаяДата());
	
	ДатаЗавтра = ОбщегоНазначенияСППР.СледующаяДатаПоОсновномуКалендарю();
	
	ГруппаИЛИСрокОбщая = ОбщегоНазначенияКлиентСервер.СоздатьГруппуЭлементовОтбора(Список.КомпоновщикНастроек.ФиксированныеНастройки.Отбор.Элементы,
																			"Отбор по сроку отработки",
																			ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИли);
																			
	ГруппаИЛИТребуетсяЗапланировать = ОбщегоНазначенияКлиентСервер.СоздатьГруппуЭлементовОтбора(ГруппаИЛИСрокОбщая,
																			"Отбор по сроку отработки (требуется запланировать)",
																			ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИли);
																			
	ГруппаИЛИВыполнить = ОбщегоНазначенияКлиентСервер.СоздатьГруппуЭлементовОтбора(ГруппаИЛИСрокОбщая,
																			"Отбор по сроку отработки (выполнить)",
																			ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИли);
																			
	ГруппаИТребуетсяЗапланироватьСегодня = ОбщегоНазначенияКлиентСервер.СоздатьГруппуЭлементовОтбора(ГруппаИЛИТребуетсяЗапланировать,
																			"Отбор по сроку отработки (требуется запланировать) на сегодня",
																			ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИ);
																			
	ГруппаИВыполнитьСегодня = ОбщегоНазначенияКлиентСервер.СоздатьГруппуЭлементовОтбора(ГруппаИЛИВыполнить,
																			"Отбор по сроку отработки (выполнить) на сегодня",
																			ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИ);
	
	ЕстьОтборПоВчера	= (СписокСроков.НайтиПоЗначению("Вчера") <> Неопределено);
	ЕстьОтборПоСегодня	= (СписокСроков.НайтиПоЗначению("Сегодня") <> Неопределено);
	ЕстьОтборПоЗавтра	= (СписокСроков.НайтиПоЗначению("Завтра") <> Неопределено);
	ЕстьОтборПоПотом	= (СписокСроков.НайтиПоЗначению("Потом") <> Неопределено);
	
	ЕстьОтборТребуетсяЗапланировать = (СписокДействий.НайтиПоЗначению("Требуется запланировать") <> Неопределено);
	ЕстьОтборВыполнить = (СписокДействий.НайтиПоЗначению("Выполнить") <> Неопределено);
	
	ГруппаИЛИСрокОбщая.Использование = (ЕстьОтборПоВчера ИЛИ ЕстьОтборПоСегодня ИЛИ ЕстьОтборПоЗавтра ИЛИ ЕстьОтборПоПотом)
										И (ЕстьОтборТребуетсЯЗапланировать ИЛИ ЕстьОтборВыполнить ИЛИ СписокДействий.Количество() = 0);
										
	ГруппаИЛИТребуетсяЗапланировать.Использование = (ЕстьОтборПоВчера ИЛИ ЕстьОтборПоСегодня ИЛИ ЕстьОтборПоЗавтра ИЛИ ЕстьОтборПоПотом)
										И (ЕстьОтборТребуетсяЗапланировать ИЛИ СписокДействий.Количество() = 0);
										
	ГруппаИЛИВыполнить.Использование = (ЕстьОтборПоВчера ИЛИ ЕстьОтборПоСегодня ИЛИ ЕстьОтборПоЗавтра ИЛИ ЕстьОтборПоПотом)
										И (ЕстьОтборВыполнить ИЛИ СписокДействий.Количество() = 0);
										
	ГруппаИТребуетсяЗапланироватьСегодня.Использование = ЕстьОтборПоСегодня И (ЕстьОтборТребуетсяЗапланировать ИЛИ СписокДействий.Количество() = 0);
	ГруппаИВыполнитьСегодня.Использование = ЕстьОтборПоСегодня И (ЕстьОтборВыполнить ИЛИ СписокДействий.Количество() = 0);
	
	ЕстьОтборПоСрокуТребуетсяЗапланировать = ЕстьОтборТребуетсяЗапланировать ИЛИ СписокДействий.Количество() = 0;
	ЕстьОтборПоСрокуВыполнить = ЕстьОтборВыполнить ИЛИ СписокДействий.Количество() = 0;
	
	ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(ГруппаИЛИТребуетсяЗапланировать, "ЗапланироватьНеПозднее", ВидСравненияКомпоновкиДанных.Меньше, ТекущаяДата,,ЕстьОтборПоВчера И ЕстьОтборПоСрокуТребуетсяЗапланировать);
	ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(ГруппаИТребуетсяЗапланироватьСегодня, "ЗапланироватьНеПозднее", ВидСравненияКомпоновкиДанных.БольшеИлиРавно, ТекущаяДата,,ЕстьОтборПоСегодня И ЕстьОтборПоСрокуТребуетсяЗапланировать);
	ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(ГруппаИТребуетсяЗапланироватьСегодня, "ЗапланироватьНеПозднее", ВидСравненияКомпоновкиДанных.Меньше, ДатаЗавтра,,ЕстьОтборПоСегодня И ЕстьОтборПоСрокуТребуетсяЗапланировать);
	ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(ГруппаИЛИТребуетсяЗапланировать, "ЗапланироватьНеПозднее", ВидСравненияКомпоновкиДанных.Равно, ДатаЗавтра,,ЕстьОтборПоЗавтра И ЕстьОтборПоСрокуТребуетсяЗапланировать);
	ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(ГруппаИЛИТребуетсяЗапланировать, "ЗапланироватьНеПозднее", ВидСравненияКомпоновкиДанных.Больше, ДатаЗавтра,,ЕстьОтборПоПотом И ЕстьОтборПоСрокуТребуетсяЗапланировать);
	
	ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(ГруппаИЛИВыполнить, "СрокВыполнения", ВидСравненияКомпоновкиДанных.Меньше, ТекущаяДата,,ЕстьОтборПоВчера И ЕстьОтборПоСрокуВыполнить);
	ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(ГруппаИВыполнитьСегодня, "СрокВыполнения", ВидСравненияКомпоновкиДанных.БольшеИлиРавно, ТекущаяДата,,ЕстьОтборПоСегодня И ЕстьОтборПоСрокуВыполнить);
	ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(ГруппаИВыполнитьСегодня, "СрокВыполнения", ВидСравненияКомпоновкиДанных.Меньше, ДатаЗавтра,,ЕстьОтборПоСегодня И ЕстьОтборПоСрокуВыполнить);
	ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(ГруппаИЛИВыполнить, "СрокВыполнения", ВидСравненияКомпоновкиДанных.Равно, ДатаЗавтра,,ЕстьОтборПоЗавтра И ЕстьОтборПоСрокуВыполнить);
	ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(ГруппаИЛИВыполнить, "СрокВыполнения", ВидСравненияКомпоновкиДанных.Больше, ДатаЗавтра,,ЕстьОтборПоПотом И ЕстьОтборПоСрокуВыполнить);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьОтборПоСрокуВыполненияОбщейЗадачи()
	
	ТекущаяДата = НачалоДня(ТекущаяДата());
	
	ДатаЗавтра = ОбщегоНазначенияСППР.СледующаяДатаПоОсновномуКалендарю();
	
	ГруппаИЛИСрокОбщая = ОбщегоНазначенияКлиентСервер.СоздатьГруппуЭлементовОтбора(Список.КомпоновщикНастроек.ФиксированныеНастройки.Отбор.Элементы,
																			"Отбор по сроку выполнения общей задачи",
																			ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИли);
																			
	ГруппаИЛИТребуетсяЗапланировать = ОбщегоНазначенияКлиентСервер.СоздатьГруппуЭлементовОтбора(ГруппаИЛИСрокОбщая,
																			"Отбор по сроку выполнения общей задачи (требуется запланировать)",
																			ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИли);
																			
	ГруппаИЛИВыполнить = ОбщегоНазначенияКлиентСервер.СоздатьГруппуЭлементовОтбора(ГруппаИЛИСрокОбщая,
																			"Отбор по сроку выполнения общей задачи (выполнить)",
																			ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИли);
																			
	ГруппаИТребуетсяЗапланироватьСегодня = ОбщегоНазначенияКлиентСервер.СоздатьГруппуЭлементовОтбора(ГруппаИЛИТребуетсяЗапланировать,
																			"Отбор по сроку выполнения общей задачи (требуется запланировать) на сегодня",
																			ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИ);
																			
	ГруппаИВыполнитьСегодня = ОбщегоНазначенияКлиентСервер.СоздатьГруппуЭлементовОтбора(ГруппаИЛИВыполнить,
																			"Отбор по сроку выполнения обще задачи (выполнить) на сегодня",
																			ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИ);
	
	ЕстьОтборПоВчера	= (СписокСроковВыполненияОбщейЗадачи.НайтиПоЗначению("Вчера") <> Неопределено);
	ЕстьОтборПоСегодня	= (СписокСроковВыполненияОбщейЗадачи.НайтиПоЗначению("Сегодня") <> Неопределено);
	ЕстьОтборПоЗавтра	= (СписокСроковВыполненияОбщейЗадачи.НайтиПоЗначению("Завтра") <> Неопределено);
	ЕстьОтборПоПотом	= (СписокСроковВыполненияОбщейЗадачи.НайтиПоЗначению("Потом") <> Неопределено);
	
	ЕстьОтборТребуетсяЗапланировать = (СписокДействий.НайтиПоЗначению("Требуется запланировать") <> Неопределено);
	ЕстьОтборВыполнить = (СписокДействий.НайтиПоЗначению("Выполнить") <> Неопределено);
	
	ГруппаИЛИСрокОбщая.Использование = (ЕстьОтборПоВчера ИЛИ ЕстьОтборПоСегодня ИЛИ ЕстьОтборПоЗавтра ИЛИ ЕстьОтборПоПотом)
										И (ЕстьОтборТребуетсЯЗапланировать ИЛИ ЕстьОтборВыполнить ИЛИ СписокДействий.Количество() = 0);
										
	ГруппаИЛИТребуетсяЗапланировать.Использование = (ЕстьОтборПоВчера ИЛИ ЕстьОтборПоСегодня ИЛИ ЕстьОтборПоЗавтра ИЛИ ЕстьОтборПоПотом)
										И (ЕстьОтборТребуетсяЗапланировать ИЛИ СписокДействий.Количество() = 0);
										
	ГруппаИЛИВыполнить.Использование = (ЕстьОтборПоВчера ИЛИ ЕстьОтборПоСегодня ИЛИ ЕстьОтборПоЗавтра ИЛИ ЕстьОтборПоПотом)
										И (ЕстьОтборВыполнить ИЛИ СписокДействий.Количество() = 0);
										
	ГруппаИТребуетсяЗапланироватьСегодня.Использование = ЕстьОтборПоСегодня И (ЕстьОтборТребуетсяЗапланировать ИЛИ СписокДействий.Количество() = 0);
	ГруппаИВыполнитьСегодня.Использование = ЕстьОтборПоСегодня И (ЕстьОтборВыполнить ИЛИ СписокДействий.Количество() = 0);
	
	ЕстьОтборПоСрокуТребуетсяЗапланировать = ЕстьОтборТребуетсяЗапланировать ИЛИ СписокДействий.Количество() = 0;
	ЕстьОтборПоСрокуВыполнить = ЕстьОтборВыполнить ИЛИ СписокДействий.Количество() = 0;
	
	ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(ГруппаИЛИТребуетсяЗапланировать, "ВыполнитьНеПозднее", ВидСравненияКомпоновкиДанных.Меньше, ТекущаяДата,,ЕстьОтборПоВчера И ЕстьОтборПоСрокуТребуетсяЗапланировать);
	ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(ГруппаИТребуетсяЗапланироватьСегодня, "ВыполнитьНеПозднее", ВидСравненияКомпоновкиДанных.БольшеИлиРавно, ТекущаяДата,,ЕстьОтборПоСегодня И ЕстьОтборПоСрокуТребуетсяЗапланировать);
	ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(ГруппаИТребуетсяЗапланироватьСегодня, "ВыполнитьНеПозднее", ВидСравненияКомпоновкиДанных.Меньше, ДатаЗавтра,,ЕстьОтборПоСегодня И ЕстьОтборПоСрокуТребуетсяЗапланировать);
	ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(ГруппаИЛИТребуетсяЗапланировать, "ВыполнитьНеПозднее", ВидСравненияКомпоновкиДанных.Равно, ДатаЗавтра,,ЕстьОтборПоЗавтра И ЕстьОтборПоСрокуТребуетсяЗапланировать);
	ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(ГруппаИЛИТребуетсяЗапланировать, "ВыполнитьНеПозднее", ВидСравненияКомпоновкиДанных.Больше, ДатаЗавтра,,ЕстьОтборПоПотом И ЕстьОтборПоСрокуТребуетсяЗапланировать);
	
	ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(ГруппаИЛИВыполнить, "ВыполнитьНеПозднее", ВидСравненияКомпоновкиДанных.Меньше, ТекущаяДата,,ЕстьОтборПоВчера И ЕстьОтборПоСрокуВыполнить);
	ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(ГруппаИВыполнитьСегодня, "ВыполнитьНеПозднее", ВидСравненияКомпоновкиДанных.БольшеИлиРавно, ТекущаяДата,,ЕстьОтборПоСегодня И ЕстьОтборПоСрокуВыполнить);
	ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(ГруппаИВыполнитьСегодня, "ВыполнитьНеПозднее", ВидСравненияКомпоновкиДанных.Меньше, ДатаЗавтра,,ЕстьОтборПоСегодня И ЕстьОтборПоСрокуВыполнить);
	ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(ГруппаИЛИВыполнить, "ВыполнитьНеПозднее", ВидСравненияКомпоновкиДанных.Равно, ДатаЗавтра,,ЕстьОтборПоЗавтра И ЕстьОтборПоСрокуВыполнить);
	ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(ГруппаИЛИВыполнить, "ВыполнитьНеПозднее", ВидСравненияКомпоновкиДанных.Больше, ДатаЗавтра,,ЕстьОтборПоПотом И ЕстьОтборПоСрокуВыполнить);
	
КонецПроцедуры
																		
#КонецОбласти