module Hierarchies where

-- Novi tipovi
data UnderGStudent = UnderGStudent
  { uGHunamInfo   :: HumanInfo
  , uGStudentInfo :: StudentInfo
  } deriving (Show)

data PhDStudent = PhDStudent
  { phDHumanInfo   :: HumanInfo
  , phDStudentInfo :: StudentInfo
  , thesis         :: String
  } deriving (Show)

data StudentInfo = StudentInfo
  { index :: Int
  } deriving (Show)

data HumanInfo = HumanInfo
  { name      :: String
  , surname   :: String
  , birthYear :: Int
  } deriving (Show)

-- Ljudi su ljudi jer se muče, to ih čini ljudima
class Human a where
  struggle :: a -> String
  -- Podrazumevana implementacija
  struggle = const "A poor man is struggling."

-- Predavači su pre svega ljudi, a potom moraju znati i da se
-- predstave
class Human a => Lecturer a where
  introduce :: a -> String

-- UnderGStudent instanca čoveka, UnderGStudent je čovek
instance Human UnderGStudent where
  struggle (UnderGStudent (HumanInfo n _ _) _) = n ++ " is gravely struggling."

-- PhDStudent instanca čoveka, PhDStudent je čovek
instance Human PhDStudent

-- PhdStudent instanca predavača
instance Lecturer PhDStudent where
  introduce (PhDStudent (HumanInfo n _ _) _ t) =
    "I am " ++ n ++ " and my research is directed towards " ++ t ++ "."

--------------------------------------------------------------------------------
-- Primeri:

pera = UnderGStudent (HumanInfo "Petar" "Petrovic" 1987) (StudentInfo 8791)
-- λ> name . uGHunamInfo $ pera
-- "Petar"
--
-- λ> struggle pera
-- "Petar is gravely struggling."

zika =
  PhDStudent
    (HumanInfo "Zika" "Zikic" 1983)
    (StudentInfo 123)
    "functional programming"
-- λ> name . phDHumanInfo $ zika
-- "Zika"
--
-- λ> thesis zika
-- "functional programming"
--
-- PhDStudent koristi default-nu implementaciju struggle funkcije
-- λ> struggle zika
-- "A poor man is struggling."
--
-- λ> introduce zika
-- "I am Zika and my research is directed towards functional programming."
