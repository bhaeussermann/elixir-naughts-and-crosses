# NaughtsAndCrosses

An Elixir umbrella for Naughts & Crosses (tic-tac-toe).  
Includes two apps: 
- `naughts_and_crosses`: Contains the game logic and implements it in a simple console application.
- `naughts_and_crosses_web`: A Phoenix web application that presents the game on a web page.

## Console App

### Building & Running

To build the application run the following commands:

```
cd apps/naughts_and_crosses
mix escript.build
```

And to run the application run

```
./naughts_and_crosses
```

## Web App

### Building & Running

To start the Phoenix server:

- Change to the web directory: `cd apps/naughts_and_crosses_web`
- Install dependencies: `mix deps.get`
- Install Node.js dependencies: `cd assets && npm install`
- Start Phoenix endpoint: `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
