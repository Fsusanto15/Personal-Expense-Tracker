# Expense Tracker (iOS / SwiftUI)

A simple personal expense tracker built for the take-home assignment by Neurogine Group Sdn Bhd. You can add an expense (title, amount, date), see the expenses in a list, delete, and a  total expenses.

## What it does

- Add an expense with a title, amount, and date
- See all expenses in a list
- Swipe to delete an expense
- See a total of all expenses at the bottom of the list
- Data is saved to local storage and offline consideration
- Handles empty state, a loading state, and an error state if something goes wrong reading the saved data

## Stack

- SwiftUI
- MVVM
- Local file storage
- dependency injection


The idea is pretty standard MVVM: Views to display things and forward user actions. ViewModels hold the state and the logic. And a protocol (ExpenseRepository) so the ViewModels don't know or care how the data is actually stored.

## Why I picked local file storage over Core Data or UserDefaults

The assignment gave three options: Core Data, UserDefaults, or "other local storage." I went with a plain JSON file written through FileManager, which is under local storage option. UserDefaults is intended for small settings, not a list of records that grows over time while Core Data performs beyond this simple approach. Therefore, I chose local storage.

## The two screens

**Expense List** — shows all expenses plus the total. Has three states: loading, loaded (which splits into empty vs. has-data), and error. Tapping the + button pushes to the Add screen.

**Add Expense** — a form with title, amount, and date. The Save button only enabled once the form is actually valid, and there's an inline message to inform the error message.

I went with .navigationDestination (a normal push, like UINavigationController in UIKit pushing a screen) rather than a sheet, since Add here felt more like moving to the next screen than a quick modal popup.

## Validation

The validation of input:
- Empty or whitespace-only title
- Invalid amount number
- Zero or negative number


## Testing

I added a couple of unit tests:
- FileExpenseRepository: saving then loading returns the same data, and loading when no file exists yet returns an empty list instead of crashing or throwing.
- AddExpenseViewModel: the validation logic (empty title, bad amount, etc.) is checked directly, without needing to go through any UI.

I didn't go further than this given the time box, but these two cover the parts of the app I was most worried about silently breaking.

## What I left out on purpose

- **Categories, search/filter** — not required, and I'd rather submit something solid and small than something padded out with extra features I didn't have time to polish.
- **Editing an existing expense** — only adding and deleting are supported. Editing wasn't asked for, and the model is already set up so it wouldn't be a big change to add later.
- **A shared currency-formatting helper** — the currency formatting line is duplicated in two places (the list total and each row). I could have pulled it into one shared helper, but for two call sites it didn't feel worth adding another file for yet.

## Couple features if given more chances and time

- Add editing, the function only supports add and delete expenses. Would like to edit title, amount or date, but id is immutable.
- Add categories, categories on each expense and able to cluster or filtering based on categories.
- Add a few more tests, particularly around deleting expenses and the list ViewModel's state transitions.
