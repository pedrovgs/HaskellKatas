module Contacts.Main where

import           Contacts.Contacts
import           Control.Monad

main = do
  putStrLn "Welcome to the Kata Agenda!"
  addContactToTheAgenda Agenda { contacts = [] }

addContactToTheAgenda :: Agenda -> IO ()
addContactToTheAgenda agenda = do
  putStrLn "Introduce the name of your contact."
  contactName <- getLine
  putStrLn "Introduce the phone of your contact."
  contactPhone <- getLine
  let contact = Contact { name = contactName, phone = contactPhone }
  if isValidContact contact
    then do putStrLn "Valid contact introduced."
            let updatedAgenda = addContact contact agenda
            showAgenda updatedAgenda
            addContactToTheAgenda updatedAgenda
  else do putStrLn "Try again, the contact information can't be null."
          addContactToTheAgenda agenda

showAgenda :: Agenda -> IO ()
showAgenda agenda = do
  putStrLn "This is the list of contacts you have in your agenda:"
  let formattedContacts = formatContacts $ contacts agenda
  putStrLn formattedContacts

formatContacts :: [Contact] -> String
formatContacts []       = "Empty"
formatContacts contacts = concatMap show contacts
