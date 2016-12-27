module FindingTheRightTriangle.FindingTheRightTriangleSpec where

import           FindingTheRightTriangle.FindingTheRightTriangle
import           Test.Hspec

spec = describe "FindingTheRightTriangle requirements" $ do
  it "every side of each triangle is less than or equal to 10" $
    all (\(a,b,c) -> a <= 10 && b <= 10 && c <= 10) findRightTriangles
  it "the perimeter of every triangle is equal to 24" $
    all (\(a,b,c) -> (a + b + c) == 24) findRightTriangles
  it "every triangle is a right triangle" $
    all (\(a,b,c) -> a^2 + b^2 == c^2) findRightTriangles
