(define-resource conversatie ()
  :class (s-prefix "schema:Conversation")
  :properties `((:dossiernummer :string ,(s-prefix "schema:identifier"))
                (:betreft :string ,(s-prefix "schema:about"))
                (:current-type-communicatie :string ,(s-prefix "ext:currentType")) ;; TODO: this should come from a code-list, rather than a string
                (:reactietermijn :string ,(s-prefix "schema:processingTime")))
  :has-many `((bericht :via ,(s-prefix "schema:hasPart")
                    :as "berichten"))
  :has-one `((bericht :via ,(s-prefix "ext:lastMessage")
                      :as "laatste-bericht"))
  :resource-base (s-url "http://data.lblod.info/id/conversaties/")
  :features '(include-uri)
  :on-path "conversaties")

(define-resource bericht ()
  :class (s-prefix "schema:Message")
  :properties `((:verzonden :datetime ,(s-prefix "schema:dateSent"))
                (:aangekomen :datetime ,(s-prefix "schema:dateReceived"))
                (:inhoud :string ,(s-prefix "schema:text"))
                (:type-communicatie :string ,(s-prefix "dct:type")))
  :has-one `((bestuurseenheid :via ,(s-prefix "schema:sender")
                    :as "van")
            (gebruiker :via ,(s-prefix "schema:author")
                  :as "auteur")
            (bestuurseenheid :via ,(s-prefix "schema:recipient")
                  :as "naar")
            (email :via ,(s-prefix "ext:notificatieEmail")
                  :as "notificatie-email")
            (conversatie :via ,(s-prefix "schema:hasPart")
                  :inverse t
                  :as "conversatie"))
  :has-many `((file :via ,(s-prefix "nie:hasPart")
                    :as "bijlagen"))
  :resource-base (s-url "http://data.lblod.info/id/berichten/")
  :features '(include-uri)
  :on-path "berichten")
