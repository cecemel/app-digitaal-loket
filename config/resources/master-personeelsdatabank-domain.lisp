(define-resource employee-dataset ()
  :class (s-prefix "empl:EmployeeDataset") ;; < qb:DataSet
  :properties `((:title :string ,(s-prefix "dct:title"))
                (:description :string ,(s-prefix "dct:description")))
  :has-one `((bestuurseenheid :via ,(s-prefix "dct:creator")
                              :as "bestuurseenheid"))
  :has-many `((employee-period-slice :via ,(s-prefix "qb:slice")
                                     :as "periods")
              (employee-unit-measure :via ,(s-prefix "dct:subject")
                                     :as "subjects"))
  :resource-base (s-url "http://data.lblod.info/employee-datasets/")
  :on-path "employee-datasets")

(define-resource employee-period-slice () ;; < qb:Slice  // Observations for a specific period
  :class (s-prefix "empl:EmployeePeriodSlice")
  :properties `((:label :string ,(s-prefix "rdfs:label")))
  :has-one `((employee-dataset :via ,(s-prefix "qb:slice")
                               :inverse t
                               :as "dataset")
             (employee-time-period :via ,(s-prefix "sdmxDim:timePeriod")
                                   :as "time-period"))
  :has-many `((employee-observation :via ,(s-prefix "qb:observation")
                                    :as "observations"))
  :resource-base (s-url "http://data.lblod.info/employee-period-slices/")
  :on-path "employee-period-slices")

(define-resource employee-observation () ;; < qb:Observation
  :class (s-prefix "empl:EmployeeObservation")
  :properties `((:value :number ,(s-prefix "sdmxMeasure:obsValue")))
  :has-one `((employee-unit-measure :via ,(s-prefix "sdmxAttr:unitMeasure")
                                    :as "unit-measure")
             (educational-level :via ,(s-prefix "sdmxDim:educationLev")
                                :as "educational-level")
             (geslacht-code :via ,(s-prefix "sdmxDim:sex")
                            :as "sex")
             (working-time-category :via ,(s-prefix "empl:workingTimeCategory")
                                    :as "working-time-category")
             (employee-legal-status :via ,(s-prefix "empl:legalStatus")
                                    :as "legal-status")
             (employee-period-slice :via ,(s-prefix "qb:observation")
                                    :inverse t
                                    :as "slice"))
  :resource-base (s-url "http://data.lblod.info/employee-observations/")
  :on-path "employee-observations")

(define-resource employee-time-period ()
  :class (s-prefix "empl:EmployeeTimePeriod") ;; < time:DateTimeInterval
  :properties `((:label :string ,(s-prefix "skos:prefLabel"))
                (:start :datetime ,(s-prefix "time:hasBeginning")))
  :has-many `((employee-period-slice :via ,(s-prefix "sdmxDim:timePeriod")
                                     :inverse t
                                     :as "slices"))
  :resource-base (s-url "http://data.lblod.info/employee-time-periods/")
  :on-path "employee-time-periods")

(define-resource employee-unit-measure ()
  :class (s-prefix "empl:UnitMeasure")
  :properties `((:label :string ,(s-prefix "skos:prefLabel")))
  :resource-base (s-url "http://data.lblod.info/employee-unit-measures/")
  :features '(include-uri)
  :on-path "employee-unit-measures")

(define-resource educational-level ()
  :class (s-prefix "empl:EducationalLevel")
  :properties `((:label :string ,(s-prefix "skos:prefLabel")))
  :resource-base (s-url "http://data.lblod.info/educational-levels/")
  :features '(include-uri)
  :on-path "educational-levels")

(define-resource working-time-category ()
  :class (s-prefix "empl:WorkingTimeCategory")
  :properties `((:label :string ,(s-prefix "skos:prefLabel")))
  :resource-base (s-url "http://data.lblod.info/working-time-categories/")
  :features '(include-uri)
  :on-path "working-time-categories")

(define-resource employee-legal-status ()
  :class (s-prefix "empl:LegalStatus")
  :properties `((:label :string ,(s-prefix "skos:prefLabel")))
  :resource-base (s-url "http://data.lblod.info/employee-legal-statuses/")
  :features '(include-uri)
  :on-path "employee-legal-statuses")

