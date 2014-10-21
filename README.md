# GLaDyS - high security logging for scientific studies

*Note: this codebase is under rapid development. Please check back
 in the near future if you are interested in using this project for your data collection needs.*

This project seeks to provide the core functionality for logging study
participant data. It is written as a simple, stand-alone application
to simplify security concerns associated with product studies.

## Usage

Intended usage is as follows:

* A participants.yml file is created, which contains the list of
  participants.
* A daily_questions.yml file is created, which contains the list of
  questions.
* (Details here will change until the community site is completed)
  meta.yml, which contains configuration values of where to send
  cryptographic checksums and completion pings.

These are specified via YAML config files in the hopes it will allow
for easier automated deployment from other sites. A database is still
used.

### Core function:
* Every day an SMS/email is sent to participants with a securely generated one time URL.
* The participant visits this URL and is greeted with a list of questions to answer.

### Potential changes to this story:
* If the URL is not used within 16 hours, it expires forever.
* If a participant does not enter data for more than 3 days, they are
  automatically removed from the study.
* If a participant feels that they need to removed from the study,
  they may do so at any time. They will be prompted to provide details
  on their reasons for doing so. These reasons will be communicated to
  the study organizer.
* The study organizer may halt the study.

### Please help consider

* Should we randomize the order / initial state of boolean and select type quetions?
* What should we be doing to become more rigorous?

### Assumed services

To keep things simple for v1 we will be assuming this application will
be deployed to heroku.

Email will be handled by mandrill, and SMS by twillio.

### Questions data format

Examples (list of yaml formatted attributes):
```
- id: 1
  kind: :double
  required: false
  question_text: What is your current weight in pounds?
  detailed_description: If possible, please check your weight now using a normal household scale.

- id: 2
  kind: :select
  required: true
  question_text: What is the chance a randomly chosen answer to this question will
    be correct?
  options_for_select:
  - 25%
  - 50%
  - 60%
  - 25%
```

Specification:
* `id` - **required** - 64 bit integer
* `kind` - **required** - one of `[:double, :select, :boolean]`
* `required` - **required** - boolean
* `question_text` - **required** - non-empty string
* `optoins_for_select` - optional - a list of non-empty strings, only allowed if `type` is `:select`.


### Participants data format

Example (list of yaml formatted attributes):

```
- first_name: Foo
  last_name: Bar
  email: foo@example.com
  phone_number: "+15551234567"
  contact_method: :phone

- first_name: Foo2
  last_name: Bar2
  email: foo2@example.com
  phone_number: "+15551234568"
  contact_method: :email
```

Specification:
* `first_name` - **required** - non-empty string
* `last_name` - **required** - non-empty string
* `email` - optional (required if contact_method is `:email`).
  non-null email address as defined by [RFC 5321](http://tools.ietf.org/html/rfc5321)
* `phone_number` - optional (required if contact_method is `:phone`).
  non-null string that is compatable with twillio.
* `contact_method` - **required** - one of `[:phone, :email]`
