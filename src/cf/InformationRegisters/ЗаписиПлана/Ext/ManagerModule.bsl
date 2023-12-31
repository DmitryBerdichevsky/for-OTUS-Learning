﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Выполняет запись в регистр
//
// Параметры:
//  ДанныеЗаписи  - Структура - - содержит:
//   * ИдентификаторПлана - Число
//   * Сотрудник          - СправочникСсылка.Пользователи
//   * Работа             - СправочникСсылка.ЗадачиПроцессов, СправочникСсылка.ТехническиеПроекты, СправочникСсылка.Ошибки, СправочникСсылка.ВидыДеятельности
//   * Цель               - Строка
//   * Комментарий        - Строка
//
Процедура ЗаписатьДанные(ДанныеЗаписи) Экспорт
	
	НаборЗаписей = СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.ИдентификаторПлана.Установить(ДанныеЗаписи.ИдентификаторПлана);
	НаборЗаписей.Отбор.Сотрудник.Установить(ДанныеЗаписи.Сотрудник);
	НаборЗаписей.Отбор.Работа.Установить(ДанныеЗаписи.Работа);
	НаборЗаписей.Отбор.ТипСтрокиПлана.Установить(ДанныеЗаписи.ТипСтрокиПлана);
	НаборЗаписей.Отбор.Группировка.Установить(ДанныеЗаписи.Группировка);
	
	НаборЗаписей.Прочитать();
	Если НаборЗаписей.Количество() = 0 Тогда
		
		ЗаписьНабора = НаборЗаписей.Добавить();
		
	Иначе
		
		ЗаписьНабора = НаборЗаписей[0];
		
	КонецЕсли;
	
	ЗаполнитьЗначенияСвойств(ЗаписьНабора, ДанныеЗаписи);
	
	НаборЗаписей.Записать();
	
КонецПроцедуры

// Удаляет запись плана
//
// Параметры:
//  ДанныеЗаписи  - Структура - - содержит:
//   * ИдентификаторПлана - Число
//   * Сотрудник          - СправочникСсылка.Пользователи
//   * Работа             - СправочникСсылка.ЗадачиПроцессов, СправочникСсылка.ТехническиеПроекты, СправочникСсылка.Ошибки, СправочникСсылка.ВидыДеятельности
//   * Цель               - Строка
//   * Комментарий        - Строка
//
Процедура УдалитьЗаписьПлана(ДанныеЗаписи) Экспорт
	
	НаборЗаписей = СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.ИдентификаторПлана.Установить(ДанныеЗаписи.ИдентификаторПлана);
	НаборЗаписей.Отбор.Сотрудник.Установить(ДанныеЗаписи.Сотрудник);
	НаборЗаписей.Отбор.Работа.Установить(ДанныеЗаписи.Работа);
	НаборЗаписей.Отбор.ТипСтрокиПлана.Установить(ДанныеЗаписи.ТипСтрокиПлана);
	НаборЗаписей.Отбор.Группировка.Установить(ДанныеЗаписи.Группировка);
	НаборЗаписей.Записать();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ОбработчикиОбновления

Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст ="
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ЗаписиПлана.ИдентификаторПлана КАК ИдентификаторПлана
	|ИЗ
	|	РегистрСведений.ЗаписиПлана КАК ЗаписиПлана
	|ГДЕ
	|	ЗаписиПлана.ТипСтрокиПлана = ЗНАЧЕНИЕ(Перечисление.ТипыСтрокПлана.ПустаяСсылка)";
	
	Результат = Запрос.Выполнить().Выгрузить();
	
	ДополнительныеПараметры = ОбновлениеИнформационнойБазы.ДополнительныеПараметрыОтметкиОбработки();
	ДополнительныеПараметры.ЭтоНезависимыйРегистрСведений = Истина;
	ДополнительныеПараметры.ПолноеИмяРегистра = "РегистрСведений.ЗаписиПлана";
	ОбновлениеИнформационнойБазы.ОтметитьКОбработке(Параметры, Результат, ДополнительныеПараметры);
	
КонецПроцедуры

Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ПолноеИмяОбъекта = "РегистрСведений.ЗаписиПлана";
	ДополнительныеПараметры = ОбновлениеИнформационнойБазы.ДополнительныеПараметрыВыборкиДанныхДляОбработки();
	ДополнительныеПараметры.ИмяИзмеренияДляОтбора = "ИдентификаторПлана";
	Выборка = ОбновлениеИнформационнойБазы.ВыбратьИзмеренияНезависимогоРегистраСведенийДляОбработки(Параметры.Очередь,
	                                                                                                ПолноеИмяОбъекта,
	                                                                                                ДополнительныеПараметры);
	
	ЗаписейОбработано = 0;
	ПроблемныхЗаписей = 0;
	
	Пока Выборка.Следующий() Цикл
		
		НачатьТранзакцию();
		Попытка
			
			БлокировкаДанных = Новый БлокировкаДанных;
			ЭлементБлокировкиДанных = БлокировкаДанных.Добавить(ПолноеИмяОбъекта);
			ЭлементБлокировкиДанных.УстановитьЗначение("ИдентификаторПлана", Выборка.ИдентификаторПлана);
			ЭлементБлокировкиДанных.Режим = РежимБлокировкиДанных.Исключительный;
			БлокировкаДанных.Заблокировать();
			
			НаборЗаписей = РегистрыСведений.ЗаписиПлана.СоздатьНаборЗаписей();
			НаборЗаписей.Отбор.ИдентификаторПлана.Установить(Выборка.ИдентификаторПлана);
			НаборЗаписей.Прочитать();
			
			Если НаборЗаписей.Количество() = 0 Тогда
				
				ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(НаборЗаписей);
				
			Иначе
				
				НаборЗаписей.Очистить();
				ОбработатьЗаписиПланаДляДобавленияГруппировок(Выборка.ИдентификаторПлана, НаборЗаписей);
				ОбновлениеИнформационнойБазы.ЗаписатьНаборЗаписей(НаборЗаписей);
				
			КонецЕсли;
			
			ЗаписейОбработано = ЗаписейОбработано + 1;
			ЗафиксироватьТранзакцию();
			
		Исключение
			ОтменитьТранзакцию();
			ПроблемныхЗаписей = ПроблемныхЗаписей + 1;
			
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Не удалось обработать запись плана с идентификатором: %1 по причине:
					|%2'"), 
					НаборЗаписей, ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
			ЗаписьЖурналаРегистрации(ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(), УровеньЖурналаРегистрации.Предупреждение,
				Метаданные.РегистрыСведений.ВерсииПатчей, , ТекстСообщения);
		КонецПопытки;
		
	КонецЦикла;
	
	Если ПроблемныхЗаписей <> 0 Тогда
		ТекстСообщения = НСтр("ru = 'Процедура ОбработатьНаборыСвойствДляПереходаНаНовуюВерсию завершилась с ошибкой. Не все записи планов удалось обновить.'");
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;
	
	Параметры.ОбработкаЗавершена = ОбновлениеИнформационнойБазы.ОбработкаДанныхЗавершена(Параметры.Очередь, ПолноеИмяОбъекта);
	
КонецПроцедуры

Процедура ОбработатьЗаписиПланаДляДобавленияГруппировок(ИдентификаторПлана, НаборЗаписей)
	
	ВидДеятельностиРаботаСОшибками = Константы.ВидДеятельностиДляРаботыСОшибками.Получить();
	
	Запрос = Новый Запрос;
	Запрос.Текст = "
	|ВЫБРАТЬ
	|	ЗаписиПлана.ИдентификаторПлана КАК ИдентификаторПлана,
	|	ЗаписиПлана.Сотрудник          КАК Сотрудник,
	|	ВЫБОР
	|		КОГДА ТИПЗНАЧЕНИЯ(ЗаписиПлана.Работа) = ТИП(Справочник.ЗадачиПроцесса)
	|			ТОГДА ВЫБОР
	|					КОГДА ТИПЗНАЧЕНИЯ(ЗаписиПлана.Работа.Предмет) = ТИП(Справочник.ТехническиеПроекты)
	|						ТОГДА ЗаписиПлана.Работа.Предмет
	|					ИНАЧЕ ЗНАЧЕНИЕ(Перечисление.ТипыГруппировокСтрокПлана.НеПроектныеЗадачи)
	|				КОНЕЦ
	|		КОГДА ТИПЗНАЧЕНИЯ(ЗаписиПлана.Работа) = ТИП(Справочник.ТехническиеПроекты)
	|			ТОГДА ЗаписиПлана.Работа
	|		КОГДА ТИПЗНАЧЕНИЯ(ЗаписиПлана.Работа) = ТИП(Справочник.Ошибки)
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ТипыГруппировокСтрокПлана.РаботаСОшибками)
	|		КОГДА ТИПЗНАЧЕНИЯ(ЗаписиПлана.Работа) = ТИП(Справочник.ВидыДеятельности)
	|			ТОГДА ВЫБОР
	|					КОГДА ЗаписиПлана.Работа = &ВидДеятельностиРаботаСОшибками
	|						ТОГДА ЗНАЧЕНИЕ(Перечисление.ТипыГруппировокСтрокПлана.РаботаСОшибками)
	|					ИНАЧЕ ЗНАЧЕНИЕ(Перечисление.ТипыГруппировокСтрокПлана.ВидыДеятельности)
	|				КОНЕЦ 
	|	КОНЕЦ КАК ГруппировкаСтроки,
	|	ЗаписиПлана.Работа КАК Работа,
	|	ЗаписиПлана.ПланируемыеТрудозатраты КАК ПланируемыеТрудозатраты,
	|	ЗаписиПлана.Цель КАК Цель,
	|	ЗаписиПлана.Достигнуто КАК Достигнуто,
	|	ЗаписиПлана.Комментарий КАК Комментарий,
	|	ЗаписиПлана.ПеренестиВСледующийПлан КАК ПеренестиВСледующийПлан,
	|	ЗаписиПлана.Результат КАК Результат
	|ИЗ
	|	РегистрСведений.ЗаписиПлана КАК ЗаписиПлана
	|ГДЕ
	|	ЗаписиПлана.ИдентификаторПлана = &ИдентификаторПлана
	|ИТОГИ
	|	СУММА(ПланируемыеТрудозатраты)
	|ПО
	|	ИдентификаторПлана,
	|	Сотрудник,
	|	ГруппировкаСтроки";
	
	Запрос.УстановитьПараметр("ИдентификаторПлана",             ИдентификаторПлана);
	Запрос.УстановитьПараметр("ВидДеятельностиРаботаСОшибками", ВидДеятельностиРаботаСОшибками);
	
	РезультатЗапроса = Запрос.Выполнить();
	ВыборкаИдентификатор =РезультатЗапроса.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	
	Пока ВыборкаИдентификатор.Следующий() Цикл
	
		ВыборкаСотрудник = ВыборкаИдентификатор.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
		
		Пока ВыборкаСотрудник.Следующий() Цикл
			
			ДанныеЗаписиСотрудник = НаборЗаписей.Добавить();
			ДанныеЗаписиСотрудник.ИдентификаторПлана      = ВыборкаИдентификатор.ИдентификаторПлана;
			ДанныеЗаписиСотрудник.Сотрудник               = ВыборкаСотрудник.Сотрудник;
			ДанныеЗаписиСотрудник.ТипСтрокиПлана          = Перечисления.ТипыСтрокПлана.Сотрудник;
			ДанныеЗаписиСотрудник.ПланируемыеТрудозатраты = ВыборкаСотрудник.ПланируемыеТрудозатраты;
			
			ВыборкаГруппировкаСтроки = ВыборкаСотрудник.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
			
			Пока ВыборкаГруппировкаСтроки.Следующий() Цикл
				
				ВыборкаРаботы = ВыборкаГруппировкаСтроки.Выбрать();
				
				КоличествоРабот = 0;
				
				Пока ВыборкаРаботы.Следующий() Цикл
					
					ДанныеЗаписи = НаборЗаписей.Добавить();
					ДанныеЗаписи.ИдентификаторПлана      = ВыборкаИдентификатор.ИдентификаторПлана;
					ДанныеЗаписи.Сотрудник               = ВыборкаСотрудник.Сотрудник;
					ДанныеЗаписи.ТипСтрокиПлана          = Перечисления.ТипыСтрокПлана.Работа;
					ДанныеЗаписи.Группировка             = ВыборкаГруппировкаСтроки.ГруппировкаСтроки;
					ДанныеЗаписи.ПланируемыеТрудозатраты = ВыборкаРаботы.ПланируемыеТрудозатраты;
					ДанныеЗаписи.Работа                  = ВыборкаРаботы.Работа;
					ДанныеЗаписи.Цель                    = ВыборкаРаботы.Цель;
					ДанныеЗаписи.Достигнуто              = ВыборкаРаботы.Достигнуто;
					ДанныеЗаписи.Комментарий             = ВыборкаРаботы.Комментарий;
					ДанныеЗаписи.ПеренестиВСледующийПлан = ВыборкаРаботы.ПеренестиВСледующийПлан;
					ДанныеЗаписи.Результат               = ВыборкаРаботы.Результат;
					
					КоличествоРабот = КоличествоРабот + 1;
					
				КонецЦикла;
				
				Если ТипЗнч(ВыборкаГруппировкаСтроки.ГруппировкаСтроки) = Тип("СправочникСсылка.ТехническиеПроекты")
					И КоличествоРабот = 1
					И ВыборкаГруппировкаСтроки.ГруппировкаСтроки = ДанныеЗаписи.Работа Тогда
					
					ДанныеЗаписи.Работа         = Неопределено;
					ДанныеЗаписи.ТипСтрокиПлана = Перечисления.ТипыСтрокПлана.Группировка;
					
				ИначеЕсли ВыборкаГруппировкаСтроки.ГруппировкаСтроки = Перечисления.ТипыГруппировокСтрокПлана.РаботаСОшибками
					И КоличествоРабот = 1
					И ДанныеЗаписи.Работа = ВидДеятельностиРаботаСОшибками Тогда
					
					ДанныеЗаписи.Работа         = Неопределено;
					ДанныеЗаписи.ТипСтрокиПлана = Перечисления.ТипыСтрокПлана.Группировка;
					ДанныеЗаписи.Группировка    = ВидДеятельностиРаботаСОшибками;
					
				Иначе
					
					ДанныеЗаписиГруппировка = НаборЗаписей.Добавить();
					ДанныеЗаписиГруппировка.ИдентификаторПлана      = ВыборкаИдентификатор.ИдентификаторПлана;
					ДанныеЗаписиГруппировка.Сотрудник               = ВыборкаСотрудник.Сотрудник;
					ДанныеЗаписиГруппировка.ТипСтрокиПлана          = Перечисления.ТипыСтрокПлана.Группировка;
					ДанныеЗаписиГруппировка.Группировка             = ВыборкаГруппировкаСтроки.ГруппировкаСтроки;
					ДанныеЗаписиГруппировка.ПланируемыеТрудозатраты = ВыборкаГруппировкаСтроки.ПланируемыеТрудозатраты;
					
				КонецЕсли;
				
			КонецЦикла;
			
		КонецЦикла;
	
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли