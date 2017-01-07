module Contacts.Contacts
( Agenda(..)
, Contact(..)
, addContact
, isValidContact)
where

import           Data.List

data Agenda = Agenda {
  contacts :: [Contact]
} deriving (Show, Eq)

data Contact = Contact {
  name  :: String
, phone :: String
} deriving (Eq)

instance Show Contact where
  show contact = name contact ++ ", " ++ phone contact ++ "\n"

addContact :: Contact -> Agenda -> Agenda
addContact contact agenda = Agenda { contacts = newContacts }
  where oldContacts = contacts agenda
        newContacts = contact : oldContacts

isValidContact :: Contact -> Bool
isValidContact (Contact name phone) = not isNameEmpty && not isPhoneEmpty
  where isNameEmpty = null name
        isPhoneEmpty = null phone
