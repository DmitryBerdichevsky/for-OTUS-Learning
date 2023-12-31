﻿#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Сформировать(Команда)
	
	СкомпоноватьРезультат(РежимКомпоновкиРезультата.Непосредственно);
	СформироватьОтчет();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура СформироватьОтчет()
	
	ОтчетОбъект = РеквизитФормыВЗначение("Отчет");
	
	ТаблицаРезультата = ОтчетОбъект.ТаблицаДанных;
	ТаблицаРезультата.Сортировать("Библиотека,НаименованиеКонфигурации,ПорядковыйНомерВерсииКонфигурации,ПорядковыйНомерВерсииБиблиотеки");
	
	Макет = ОтчетОбъект.ПолучитьМакет("Макет");
	
	ЦветВыделенияЯчейки = WebЦвета.Желтый;
	
	ТабДок = Новый ТабличныйДокумент;
	
	ОбластьШапка = Макет.ПолучитьОбласть("Шапка|ИнформацияОПроекте");
	ОбластьШапка.Параметры.Библиотека = ПолучитьЗначениеПараметра("Библиотека");
	ТабДок.Вывести(ОбластьШапка);
	
	МассивВерсийБиблиотеки = Новый Массив;
	СоответствиеДляВерсийБиблиотеки = Новый Соответствие;
	
	СоставКолонок =
		"ВерсияБиблиотеки,ПубликуемыйНомерВерсииБиблиотеки,НомерВерсииБиблиотеки,ПлановаяДатаВыпускаВерсииБиблиотеки,ПорядковыйНомерВерсииБиблиотеки";
		
	ТаблицаВерсий = ТаблицаРезультата.Скопировать(,СоставКолонок);
	ТаблицаВерсий.Сортировать("ПорядковыйНомерВерсииБиблиотеки");
	
	Для Каждого СтрокаТаблицы из ТаблицаВерсий Цикл
		
		Если МассивВерсийБиблиотеки.Найти(СтрокаТаблицы.ВерсияБиблиотеки) = Неопределено Тогда
			
			МассивВерсийБиблиотеки.Добавить(СтрокаТаблицы.ВерсияБиблиотеки);
			
			Если ЗначениеЗаполнено(СтрокаТаблицы.ПубликуемыйНомерВерсииБиблиотеки) Тогда
				НомерВерсииБиблиотеки = СтрокаТаблицы.ПубликуемыйНомерВерсииБиблиотеки;
			Иначе
				НомерВерсииБиблиотеки = СтрокаТаблицы.НомерВерсииБиблиотеки;
			КонецЕсли;
			
			СтруктураИнформацииОВерсииБиблиотеки = Новый Структура;
			СтруктураИнформацииОВерсииБиблиотеки.Вставить("ПлановаяДатаВыпуска", СтрокаТаблицы.ПлановаяДатаВыпускаВерсииБиблиотеки);
			СтруктураИнформацииОВерсииБиблиотеки.Вставить("НомерВерсии", НомерВерсииБиблиотеки);
			
			СоответствиеДляВерсийБиблиотеки.Вставить(СтрокаТаблицы.ВерсияБиблиотеки, СтруктураИнформацииОВерсииБиблиотеки);
		КонецЕсли;
		
	КонецЦикла;
	
	ОбластьШапкаВерсияБиблиотеки = Макет.ПолучитьОбласть("Шапка|ВерсияБиблиотеки");
	
	ТабДок.ФиксацияСлева = ТабДок.ШиринаТаблицы;
	
	МинимальнаяГраницаПоГоризонтали = 0;
	МаксимальнаяГраницаПоГоризонтали = 0;
	ГраницаПоВертикали = 4;
	
	// Вывод версий библиотеки в шапке
	Для Каждого ВерсияБиблиотеки из МассивВерсийБиблиотеки Цикл
		
		СтруктураИнформацииОВерсииБиблиотеки = СоответствиеДляВерсийБиблиотеки[ВерсияБиблиотеки];
		
		ОбластьШапкаВерсияБиблиотеки.Параметры.НомерВерсииБиблиотеки = СтруктураИнформацииОВерсииБиблиотеки.НомерВерсии;
		ОбластьШапкаВерсияБиблиотеки.Параметры.ВерсияБиблиотеки = ВерсияБиблиотеки;
		
		ОбластьШапкаВерсияБиблиотеки.Параметры.ДатаВыпускаБиблиотеки = СтруктураИнформацииОВерсииБиблиотеки.ПлановаяДатаВыпуска;
		Область = ТабДок.Присоединить(ОбластьШапкаВерсияБиблиотеки);
		
		Если МинимальнаяГраницаПоГоризонтали = 0 Тогда
			МинимальнаяГраницаПоГоризонтали = Область.Лево;
		КонецЕсли;
			
		МаксимальнаяГраницаПоГоризонтали = Область.Право;
			
	КонецЦикла;
	
	Если МассивВерсийБиблиотеки.Количество()>0 Тогда 
		
		ОбластьДляОбъединения =
			ТабДок.Область(ГраницаПоВертикали, МинимальнаяГраницаПоГоризонтали, ГраницаПоВертикали, МаксимальнаяГраницаПоГоризонтали);
		
		ОбластьДляОбъединения.Объединить();
		ОбластьДляОбъединения.Текст = НСтр("ru='Версия библиотеки'");
		
	КонецЕсли;
	
	ОбластьШапкаОписаниеПроблем = Макет.ПолучитьОбласть("Шапка|ОписаниеПроблем");
	ТабДок.Присоединить(ОбластьШапкаОписаниеПроблем);
	
	ОбластьСтрока = Макет.ПолучитьОбласть("Строка|ИнформацияОПроекте");
	
	ТабДок.ФиксацияСверху = ТабДок.ВысотаТаблицы;
	
	// Вывод строк по конфигурациям
	
	ТекущийПроект = Неопределено;
	ТекущаяВерсия = Неопределено;
	
	ГруппаОткрыта = Ложь;
	
	Для Каждого СтрокаТаблицы из ТаблицаРезультата Цикл
		
		Если СтрокаТаблицы.ПроектКонфигурации <> ТекущийПроект Тогда
			
			Если ГруппаОткрыта Тогда
				ТабДок.ЗакончитьГруппуСтрок();
			КонецЕсли;
			
			// Вывод строки группировки по проекту-конфигурации
			ОбластьПроект = Макет.ПолучитьОбласть("Проект|ИнформацияОПроекте");
			ОбластьПроект.Параметры.Проект = СтрокаТаблицы.ПроектКонфигурации;
			ОбластьПроект.Параметры.Ответственный = СтрокаТаблицы.Ответственный;
			ТабДок.Вывести(ОбластьПроект);
			
			Для Каждого ВерсияБиблиотеки из МассивВерсийБиблиотеки Цикл
				
				ОбластьСтрокаВерсияБиблиотекиВПроекте = Макет.ПолучитьОбласть("Проект|ВерсияБиблиотеки");
				ОбластьСтрокаОписаниеПроблемВПроекте = Макет.ПолучитьОбласть("Проект|ОписаниеПроблем");
				
				СтруктураОтбора = Новый Структура;
				СтруктураОтбора.Вставить("ПроектКонфигурации", СтрокаТаблицы.ПроектКонфигурации);
				СтруктураОтбора.Вставить("ВерсияБиблиотеки", ВерсияБиблиотеки);
				
				МассивСтрокПоПроекту = ТаблицаРезультата.НайтиСтроки(СтруктураОтбора);
				
				ПризнакВключенияВерсии = "";
				
				Для Каждого СтрокаПоПроекту из МассивСтрокПоПроекту Цикл
					Если СтрокаПоПроекту.ВерсияБиблиотекиВключенаВВерсиюКонфигурации Тогда
						ПризнакВключенияВерсии = НСтр("ru='Включена'");
						Прервать;
					КонецЕсли;
				КонецЦикла;
				
				ОбластьСтрокаВерсияБиблиотекиВПроекте.Параметры.ПризнакВключенияВерсии = ПризнакВключенияВерсии;
				ТабДок.Присоединить(ОбластьСтрокаВерсияБиблиотекиВПроекте);
				
			КонецЦикла;
			
			ТабДок.Присоединить(ОбластьСтрокаОписаниеПроблемВПроекте);
			
			ТабДок.НачатьГруппуСтрок();
			ГруппаОткрыта = Истина;
			
		КонецЕсли;
		
		Если СтрокаТаблицы.ПроектКонфигурации = ТекущийПроект И СтрокаТаблицы.ВерсияКонфигурации = ТекущаяВерсия Тогда
			Продолжить;
		Иначе
			ТекущийПроект = СтрокаТаблицы.ПроектКонфигурации;
			ТекущаяВерсия = СтрокаТаблицы.ВерсияКонфигурации;
		КонецЕсли;
		
		// Вывод строки конфигурации
				
		ВыведеннаяОбласть = ВывестиСтрокуКонфигурации(СтрокаТаблицы, ТабДок, ОбластьСтрока);
		
		Если НЕ ЗначениеЗаполнено(СтрокаТаблицы.ВерсияПлатформыДляВерсииКонфигурации) Тогда
			ОбластьПоля = ТабДок.Область(ВыведеннаяОбласть.Верх, 4, ВыведеннаяОбласть.Низ, 4);
			ОбластьПоля.ЦветФона = ЦветВыделенияЯчейки;
			ОбластьПоля.Примечание.Текст = НСтр("ru='Не заполнено'");
		КонецЕсли;
		
		Если НЕ ЗначениеЗаполнено(СтрокаТаблицы.ДатаВключенияБиблиотек) Тогда
			ОбластьПоля = ТабДок.Область(ВыведеннаяОбласть.Верх, 5, ВыведеннаяОбласть.Низ, 5);
			ОбластьПоля.ЦветФона = ЦветВыделенияЯчейки;
			ОбластьПоля.Примечание.Текст = НСтр("ru='Не заполнено'");
		КонецЕсли;
		
		Если НЕ ЗначениеЗаполнено(СтрокаТаблицы.ПлановаяДатаВыпускаВерсииКонфигурации) Тогда
			ОбластьПоля = ТабДок.Область(ВыведеннаяОбласть.Верх, 6, ВыведеннаяОбласть.Низ, 6);
			ОбластьПоля.ЦветФона = ЦветВыделенияЯчейки;
			ОбластьПоля.Примечание.Текст = НСтр("ru='Не заполнено'");
		КонецЕсли;
		
		Если НЕ ЗначениеЗаполнено(СтрокаТаблицы.ДатаПрекращенияПоддержкиВерсииКонфигурации) Тогда
			ОбластьПоля = ТабДок.Область(ВыведеннаяОбласть.Верх, 7, ВыведеннаяОбласть.Низ, 7);
			ОбластьПоля.ЦветФона = ЦветВыделенияЯчейки;
			ОбластьПоля.Примечание.Текст = НСтр("ru='Не заполнено'");
		КонецЕсли;
		
		ИмеютсяПроблемы = Ложь;
		ОписаниеПроблем = "";
		
		// Вывод колонок по версиям библиотеки
		
		Для Каждого ВерсияБиблиотеки из МассивВерсийБиблиотеки Цикл
			
			ОбластьСтрокаВерсияБиблиотеки = Макет.ПолучитьОбласть("Строка|ВерсияБиблиотеки");
			
			НеЗаполненаДатаВыпускаБиблиотеки = Ложь;
			ВключенаНеПоследняяВерсияБиблиотеки = Ложь;
			ДатаВыпускаБиблиотекиПозжеДатыВключенияБиблиотек = Ложь;
			РазныеВерсииПлатформы = Ложь;
			ДатаПрекращенияПоддержкиБиблиотекиРанее = Ложь;
			
			СтруктураОтбора = Новый Структура;
			СтруктураОтбора.Вставить("ПроектКонфигурации", СтрокаТаблицы.ПроектКонфигурации);
			СтруктураОтбора.Вставить("ВерсияКонфигурации", СтрокаТаблицы.ВерсияКонфигурации);
			СтруктураОтбора.Вставить("ВерсияБиблиотеки", ВерсияБиблиотеки);
			
			// Формируется информация о включаемых библиотеках
			
			МассивСтрок = ТаблицаРезультата.НайтиСтроки(СтруктураОтбора);
			
			Если МассивСтрок.Количество()>0 Тогда
				
				СтрокаДляВерсииБиблиотеки = МассивСтрок[0];
				
				Если СтрокаДляВерсииБиблиотеки.ВерсияБиблиотекиВключенаВВерсиюКонфигурации Тогда
				    ОбластьСтрокаВерсияБиблиотеки.Параметры.ПризнакВключенияВерсии = НСтр("ru='Включена'");
				Иначе
					ОбластьСтрокаВерсияБиблиотеки.Параметры.ПризнакВключенияВерсии = "";
				КонецЕсли;
				
				// Выполняется расчет контрольных показателей, на основе которых в отчете
				// сигнализируется о наличии ситуаций, считающихся проблемными.
				
				Если СтрокаДляВерсииБиблиотеки.ВерсияБиблиотекиВключенаВВерсиюКонфигурации Тогда
					
					// Не указана плановая дата выпуска для библиотеки
					Если НЕ ЗначениеЗаполнено(СтрокаДляВерсииБиблиотеки.ПлановаяДатаВыпускаВерсииБиблиотеки)Тогда
						НеЗаполненаДатаВыпускаБиблиотеки = Истина;
					КонецЕсли;
					
					// В проект встроена не последняя версия библиотеки
					Если ЗначениеЗаполнено(СтрокаДляВерсииБиблиотеки.ПлановаяДатаВыпускаВерсииБиблиотеки)
						И ЗначениеЗаполнено(СтрокаДляВерсииБиблиотеки.ДатаВключенияБиблиотек)
						И СтрокаДляВерсииБиблиотеки.ПлановаяДатаВыпускаВерсииБиблиотеки <> СтрокаДляВерсииБиблиотеки.ПлановаяДатаВыпускаПоследнейВерсииБиблиотеки Тогда
						ВключенаНеПоследняяВерсияБиблиотеки = Истина;
					КонецЕсли;
						
					// Для проекта и библиотеки указаны разные версии платформы
					Если СтрокаДляВерсииБиблиотеки.ВерсияПлатформыДляВерсииКонфигурации <> СтрокаДляВерсииБиблиотеки.ВерсияПлатформыДляВерсииБиблиотеки
						И ЗначениеЗаполнено(СтрокаДляВерсииБиблиотеки.ВерсияПлатформыДляВерсииКонфигурации) Тогда
						РазныеВерсииПлатформы = Истина;
					КонецЕсли;
						
					// Дата выпуска библиотеки позже даты включения библиотек в проект
					Если СтрокаДляВерсииБиблиотеки.ПлановаяДатаВыпускаВерсииБиблиотеки > СтрокаДляВерсииБиблиотеки.ДатаВключенияБиблиотек Тогда
						ДатаВыпускаБиблиотекиПозжеДатыВключенияБиблиотек = Истина;
					КонецЕсли;
					
					// Дата окончания поддержки версии библиотеки ранее даты окончания поддержки версии конфигурации
					Если СтрокаДляВерсииБиблиотеки.ДатаПрекращенияПоддержкиВерсииБиблиотеки < СтрокаДляВерсииБиблиотеки.ДатаПрекращенияПоддержкиВерсииКонфигурации
						И СтрокаДляВерсииБиблиотеки.ДатаПрекращенияПоддержкиВерсииБиблиотеки <> '00010101' Тогда
						
						ДатаПрекращенияПоддержкиБиблиотекиРанее = Истина;
					КонецЕсли;
					
				КонецЕсли;
				
			Иначе
				ОбластьСтрокаВерсияБиблиотеки.Параметры.ПризнакВключенияВерсии = "";
			КонецЕсли;
			
			ОбластьСтрокаВерсияБиблиотеки.Параметры.Версия = ВерсияБиблиотеки;
			
			ДополнительныеПараметры = Новый Структура;
			ДополнительныеПараметры.Вставить("НеЗаполненаДатаВыпускаБиблиотеки", НеЗаполненаДатаВыпускаБиблиотеки);
			ДополнительныеПараметры.Вставить("ВключенаНеПоследняяВерсияБиблиотеки", ВключенаНеПоследняяВерсияБиблиотеки);
			ДополнительныеПараметры.Вставить("ДатаВыпускаБиблиотекиПозжеДатыВключенияБиблиотек", ДатаВыпускаБиблиотекиПозжеДатыВключенияБиблиотек);
			ДополнительныеПараметры.Вставить("РазныеВерсииПлатформы", РазныеВерсииПлатформы);
			ДополнительныеПараметры.Вставить("ДатаПрекращенияПоддержкиБиблиотекиРанее", ДатаПрекращенияПоддержкиБиблиотекиРанее);
			
			ИмеютсяПроблемы = ИмеютсяПроблемыДляВыделения(ОписаниеПроблем, СтрокаТаблицы, ДополнительныеПараметры);
			
			Область = ТабДок.Присоединить(ОбластьСтрокаВерсияБиблиотеки);
			
			Если ИмеютсяПроблемы Тогда
				Область.ЦветФона = ЦветВыделенияЯчейки;
			КонецЕсли;
			
		КонецЦикла;
		
		// Вывод информации по имеющимся проблемам
		ОбластьСтрокаОписаниеПроблем = Макет.ПолучитьОбласть("Строка|ОписаниеПроблем");
		ОбластьСтрокаОписаниеПроблем.Параметры.ОписаниеПроблем = ОписаниеПроблем;
		Область = ТабДок.Присоединить(ОбластьСтрокаОписаниеПроблем);
		
	КонецЦикла;
	
	Если ГруппаОткрыта Тогда
		ТабДок.ЗакончитьГруппуСтрок();
	КонецЕсли;
	
	Результат = ТабДок;
	
КонецПроцедуры

&НаСервере
Функция ИмеютсяПроблемыДляВыделения(ОписаниеПроблем, СтрокаТаблицы, ДополнительныеПараметры)
	
	ИмеютсяПроблемы = Ложь;
	
	Если ДополнительныеПараметры.НеЗаполненаДатаВыпускаБиблиотеки Тогда
		СформироватьОписаниеПроблем(ОписаниеПроблем, НСтр("ru='Не указана дата выпуска используемой версии библиотеки'"));
		ИмеютсяПроблемы = Истина;
	КонецЕсли;
	
	Если ДополнительныеПараметры.ВключенаНеПоследняяВерсияБиблиотеки 
		И НЕ ДополнительныеПараметры.ДатаВыпускаБиблиотекиПозжеДатыВключенияБиблиотек Тогда
		
		СформироватьОписаниеПроблем(ОписаниеПроблем, НСтр("ru='В версию конфигурации включена не последняя версия библиотеки'"));
		
		Если ЗначениеЗаполнено(СтрокаТаблицы.ПоследняяВерсияБиблиотеки) Тогда
			
			Если ЗначениеЗаполнено(СтрокаТаблицы.ПубликуемыйНомерПоследнейВерсииБиблиотеки) Тогда
				НомерВерсии = СтрокаТаблицы.ПубликуемыйНомерПоследнейВерсииБиблиотеки;
			Иначе
				НомерВерсии = СтрокаТаблицы.НомерПоследнейВерсииБиблиотеки;
			КонецЕсли;
			
			ОписаниеПроблем = ОписаниеПроблем + " (" + НомерВерсии + НСтр("ru=' выпуск '")
							  + Формат(СтрокаТаблицы.ПлановаяДатаВыпускаПоследнейВерсииБиблиотеки, "ДФ=дд.ММ.гг") + ")";
			
		КонецЕсли;
						  
		ИмеютсяПроблемы = Истина;
	КонецЕсли;
	
	Если ДополнительныеПараметры.ДатаВыпускаБиблиотекиПозжеДатыВключенияБиблиотек Тогда
		СформироватьОписаниеПроблем(ОписаниеПроблем, НСтр("ru='Дата выпуска библиотеки позже срока включения библиотек в версию конфигурации'"));
		ИмеютсяПроблемы = Истина;
	КонецЕсли;
	
	Если ДополнительныеПараметры.ДатаПрекращенияПоддержкиБиблиотекиРанее Тогда
		СформироватьОписаниеПроблем(ОписаниеПроблем, НСтр("ru='Дата окончания поддержки версии библиотеки ранее даты окончания поддержки версии конфигурации'"));
		ИмеютсяПроблемы = Истина;
	КонецЕсли;
	
	Если ДополнительныеПараметры.РазныеВерсииПлатформы Тогда
		СформироватьОписаниеПроблем(ОписаниеПроблем, НСтр("ru='Для версии конфигурации и версии библиотеки указаны разные версии платформы'"));
		ИмеютсяПроблемы = Истина;
	КонецЕсли;
	
	Возврат ИмеютсяПроблемы;
	
КонецФункции

&НаСервере
Процедура СформироватьОписаниеПроблем(ПолноеОписаниеПроблем, ОписаниеПроблемы)
	
	Если ЗначениеЗаполнено(ПолноеОписаниеПроблем) Тогда
		ПолноеОписаниеПроблем = ПолноеОписаниеПроблем + Символы.ПС + Символы.ПС;
	КонецЕсли;
	
	ПолноеОписаниеПроблем = ПолноеОписаниеПроблем + ОписаниеПроблемы;
		
КонецПроцедуры

&НаСервере
Функция ВывестиСтрокуКонфигурации(СтрокаТаблицы, ТабДок, ОбластьСтрока)
	
	Если Значениезаполнено(Строкатаблицы.ПубликуемыйНомерВерсииКонфигурации) Тогда
		НомерВерсииКонфигурации = СтрокаТаблицы.ПубликуемыйНомерВерсииКонфигурации;
	Иначе
		НомерВерсииКонфигурации = СтрокаТаблицы.НомерВерсииКонфигурации;
	КонецЕсли;
	
	ОбластьСтрока.Параметры.Проект = СтрокаТаблицы.ПроектКонфигурации;
	ОбластьСтрока.Параметры.Версия = СтрокаТаблицы.ВерсияКонфигурации;
	ОбластьСтрока.Параметры.НомерВерсииКонфигурации = НомерВерсииКонфигурации;
	ОбластьСтрока.Параметры.ВерсияПлатформы = СтрокаТаблицы.ВерсияПлатформыДляВерсииКонфигурации;
	ОбластьСтрока.Параметры.СрокВключенияБиблиотек = СтрокаТаблицы.ДатаВключенияБиблиотек;
	ОбластьСтрока.Параметры.ПлановаяДатаВыпуска = СтрокаТаблицы.ПлановаяДатаВыпускаВерсииКонфигурации;
	ОбластьСтрока.Параметры.ДатаОкончанияПоддержки = СтрокаТаблицы.ДатаПрекращенияПоддержкиВерсииКонфигурации;
	
	Возврат ТабДок.Вывести(ОбластьСтрока);
	
КонецФункции

&НаСервере
Функция ПолучитьЗначениеПараметра(ИмяПараметра)
	
	Параметр = Новый ПараметрКомпоновкиДанных(ИмяПараметра);
	ИспользуемыеНастройки = Отчет.КомпоновщикНастроек.ПолучитьНастройки();
	
	ЗначениеПараметра = ИспользуемыеНастройки.ПараметрыДанных.НайтиЗначениеПараметра(Параметр);
	
	Если ЗначениеПараметра = Неопределено Тогда
		Возврат "";
	Иначе
		Возврат ЗначениеПараметра.Значение;
	КонецЕсли;
	
КонецФункции

#КонецОбласти