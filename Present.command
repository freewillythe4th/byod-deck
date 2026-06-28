#!/bin/bash
# Double-click to present. Serves this folder on a local port and opens both
# the deck and the presenter notes, so the notes preview tracks reliably.
cd "$(dirname "$0")" || exit 1
PORT=8753
# free the port if a previous run is still holding it
lsof -ti tcp:$PORT 2>/dev/null | xargs kill -9 2>/dev/null
python3 -m http.server $PORT >/dev/null 2>&1 &
SERVER_PID=$!
sleep 1
open "http://localhost:$PORT/presenter.html"
open "http://localhost:$PORT/deck.html"
echo ""
echo "  Bring Your Own Deals - presenting on http://localhost:$PORT"
echo "  Deck:      http://localhost:$PORT/deck.html"
echo "  Notes:     http://localhost:$PORT/presenter.html"
echo ""
echo "  Put the deck on the projector, keep the notes on your laptop."
echo "  Close this window (or press Ctrl-C) when you are done."
echo ""
trap "kill $SERVER_PID 2>/dev/null" EXIT
wait $SERVER_PID
