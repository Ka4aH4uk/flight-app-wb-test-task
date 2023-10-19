# flight-app-wb-test-task

##### "FlightApp" is a small mobile test application developed using SwiftUI. It provides information about cheap flights and allows users to like their favorite flights. The app uses an API for flight data and has some hard-coded elements.
____
### Описание 
"FlightApp" - это небольшое тестовое мобильное приложение, состоящее из двух экранов и разработанное с помощью SwiftUI. Основной целью приложения является предоставление пользователям информации о доступных дешевых авиаперелетах и возможностью выбора понравившихся перелетов с помощью "Like". Приложение использует API для получения списка авиаперелетов, остальное - хардкод.
____
### Первый экран: список авиаперелетов

Первый экран приложения представляет собой список актуальных дешевых авиаперелетов. 

Каждая ячейка списка содержит следующую информацию: город отправления, город прибытия, дата отправления, дата возвращения, стоимость билета в рублях, иконка "Like", количество оставшихся билетов и логотип авиакомпании.

![Первый экран](https://github.com/Ka4aH4uk/flight-app-wb-test-task/blob/main/FlightAppScreen1.png)

____
### Второй экран: детализация авиаперелета

Второй экран - это страница с подробной информацией об авиаперелете, которая открывается при выборе одной из ячеек на первом экране. 

На втором экране содержится следующая информация: кнопка "Like" с двумя состояниями, кнопка подписки на уведомления, стоимость билета в рублях, пикер с авиакассами, переключатель с возможностью выбора багажа, город отправления, город прибытия, дата отправления, дата возвращения, код аэропорта, время в пути, логотип авиакомпании, кнопка "Подробнее" и "Купить билет", ведущая на сайт авиакассы.

![Второй экран](https://github.com/Ka4aH4uk/flight-app-wb-test-task/blob/main/FlightAppScreen2.png)

___
### Примечания:

- Дизайн приложения на усмотрение разработчика.
- Список авиаперелетов запрашивается один раз при старте приложения.
- Во время загрузки списка, отображается индикатор загрузки.
- Если пользователь отмечает "Like" на втором экране и возвращается на первый экран, то в списке "лайкнутого" перелета иконка "Like" будет активной.
- Приложение использует API для получения списка авиаперелетов.

___
<p align="center">
  <img src="https://github.com/Ka4aH4uk/flight-app-wb-test-task/blob/main/Simulator%20Screen%20Recording.gif" alt="Gif">
</p>
