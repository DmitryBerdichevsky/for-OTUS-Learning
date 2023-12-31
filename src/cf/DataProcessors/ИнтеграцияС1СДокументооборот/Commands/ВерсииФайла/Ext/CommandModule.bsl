﻿#Область ОбработчикиСобытий

// Обработчик команды
//
// Параметры:
//   ПараметрКоманды - Произвольный
//   ПараметрыВыполненияКоманды - ПараметрыВыполненияКоманды:
//     * Источник - ФормаКлиентскогоПриложения:
//         ** Наименование - Строка
//
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ПараметрыФормы = Новый Структура;
	Если ТипЗнч(ПараметрыВыполненияКоманды.Источник) = Тип("ФормаКлиентскогоПриложения") Тогда
		ПараметрыФормы.Вставить("ID", ПараметрыВыполненияКоманды.Источник.ID);
		ПараметрыФормы.Вставить("Наименование", ПараметрыВыполненияКоманды.Источник.Наименование);
	КонецЕсли;
	
	ОткрытьФорму(
		"Обработка.ИнтеграцияС1СДокументооборот.Форма.ВерсииФайла",
		ПараметрыФормы,
		ПараметрыВыполненияКоманды.Источник,
		ПараметрыВыполненияКоманды.Уникальность,
		ПараметрыВыполненияКоманды.Окно);
	
КонецПроцедуры

#КонецОбласти