# Treehacks 2022 Project

## `Model` Folder

Composed of the original training data and processed data. Data was gathered from participants in experimental speed dating events from 2002-2004. During the events, the attendees would have a four minute "first date" with every other participant of interest. At the end of their four minutes, participants were asked if they would like to see their date again. They were also asked to rate their date on six attributes: Attractiveness, Sincerity, Intelligence, Fun, Ambition, and Shared Interests.

It also contains the notebook for explanatory data analysis, data preprocessing, and model training. It also contains two saved models.

## `Backend` folder

It contains an API server that utilizes the ML model to match the users. It also has a structure of database for storing the matching and user profiles.

## `Frontend` folder

The front end project is a Flutter App that provides all platform apps. The front end app connects with the backend API server to provide the matching functionality. The user interface was designed for simplicity and ease of use. The logic was different from any current dating app.
