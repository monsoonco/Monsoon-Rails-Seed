## Usage
Example of using template with name `rails_api_ember_template.rb`:
```bash
rails new <your-project-name> --skip --skip-bundle --template https://raw.githubusercontent.com/monsoonco/monsoon-rails-templates/master/rails_api_ember_template.rb
```
## Tests
Scripts are tested with cucumber. Here is an example of running cucumber scenarios for `rails_api_ember_template.rb`:
```bash
cucumber features/rails_api_ember_template.feature
```
In tests assertions are made against [dummy](https://github.com/monsoonco/monsoon-rails-templates/tree/master/dummy) directory, which contains files that are added by the script (preserving rails directory layout). You can quickly look at what should you expect from running a script there.
