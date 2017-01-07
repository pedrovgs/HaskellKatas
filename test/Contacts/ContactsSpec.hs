module Contacts.ContactsSpec where

import           Contacts.Contacts
import           Test.Hspec
import           Test.QuickCheck
import           Utils.List

spec = describe "Contacts requirements" $ do
  it "valid contacts are added to the agenda" $
    property prop_ContactIsAddedToTheContactsList
  it "empty names are not valid for contacts" $
    property prop_ContactsWithEmptyNamesAreNotValid
  it "empty phones are not valid for contacts" $
    property prop_ContactsWithEmptyPhonesAreNotValid

prop_ContactIsAddedToTheContactsList :: Contact -> Agenda -> Bool
prop_ContactIsAddedToTheContactsList contact agenda =
  newContactsNumber == oldContactsNumber + 1
  && containsAll oldContacts newContacts
  && contact `elem` newContacts
  where updatedAgenda = addContact contact agenda
        oldContacts = contacts agenda
        newContacts = contacts updatedAgenda
        oldContactsNumber = length oldContacts
        newContactsNumber = length newContacts

prop_ContactsWithEmptyNamesAreNotValid :: Property
prop_ContactsWithEmptyNamesAreNotValid = forAll validPhone
  (\anyPhone -> let contact = Contact { name = "", phone = anyPhone }
                in not $ isValidContact contact)

prop_ContactsWithEmptyPhonesAreNotValid :: Property
prop_ContactsWithEmptyPhonesAreNotValid = forAll nonEmptyString
  (\anyName -> let contact = Contact { name = anyName, phone = "" }
                in not $ isValidContact contact)

instance Arbitrary Agenda where
  arbitrary = do contacts <- listOf arbitrary
                 return Agenda { contacts = contacts }

instance Arbitrary Contact where
  arbitrary = do name <- nonEmptyString
                 phone <- validPhone
                 return Contact { name = name, phone = phone}

nonEmptyString :: Gen String
nonEmptyString = suchThat arbitrary (not . null)

validPhone :: Gen String
validPhone = vectorOf 9 (choose ('1', '9'))
