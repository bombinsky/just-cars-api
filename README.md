# Just Cars API

This is a set of API endpoints which allows to add, list and show adverts.
To see the details of endpoints please use Postman collection located in: 

```docs/Just-Cars-API.postman_collection.json```
 
There is **Authorization** token required for whole API and **X-ID-Token** required in action create.
Please generate them and replace in existing collection before the requests with following rake tasks.
```
  rake generate:authorization_token
  rake generate:authentication_token[email-1@no-domain.com]
```
## Filtering of adverts is available with following parameters.

1. **phrase** : string - at last three chars will be searched in title, description and user.nickname

2. **min_price** : string but in decimal amount format
 
3. **max_price** : string but in decimal amount format

4. **min_created_at** : string but in date format YYYY-MM-DD

5. **max_created_at** : string but in date format YYYY-MM-DD
 
6. **page** : integer grater than 0

7. **per_page** : integer grater than 0

8. **order** : one value among the set of available sorts 
    
    - _score_desc (default) 
    - created_at_desc 
    - created_at_asc 
    - price_desc 
    - price_asc 
    - title_asc 
    - title_desc 

 
## Application setup for docker users
First set all required secrets for specific environment.
```
EDITOR=yours_favorit_editor_here rails credentials:edit --environment=development


secret_key_base: (provide rails application secret)
hmac_secret: (provide salt for JWT)
```

To run application in docker first copy override-example then simply build services and up them. 

Be patient. Web will wait for elastic search for significant time on up.

```
cp docker-compose.override-example.yml docker-compose.override.yml
docker-compose build
docker-compose up
```

With all services up load seeds but only once. 

``` docker-compose run --rm web rake db:seed ```

Reindexing of adverts in case of any problems can be done with.

``` docker-compose run --rm web rake reindex:adverts ```

And finally take one hour valid authorization token for all requests and authentication token to use it in create advert request.

```
docker-compose run --rm web rake generate:authorization_token
docker-compose run --rm web rake generate:authentication_token[email-1@no-domain.com]
```

## Prerequisites - information for none docker users

PostgreSQL  

```
brew install postgresql
pg_ctl -D /usr/local/var/postgres start

```

Elasticsearch

```
brew install elasticsearch
brew services start elasticsearch

```

Required environmental variables

```
DATABASE_URL (required by postgres non docker users can also use config/database.yml)  
ELASTICSEARCH_URL (required by elastisearch localhost:9200 is by default)
```

Secrets used by application

```
secret_key_base: (rails application secret)   
hmac_secret: (salt for JWT)
```

## Simple running instruction for none docker users.

1. Set all required secrets for specific environment.    

    ``` EDITOR=yours_favorit_editor_here rails credentials:edit --environment=development ```

2. Setup connection for postgres. You can copy then edit config/database.yml using config/database.yml.example

   ``` cp config/database.yml.example cp config/database.yml ```

3. Setup database with seeds

    ``` rake db:setup```

4. Run application server

    ``` rails s```

5. Generate authorization token required in all requests and authentication token required by action create.
   It will be valid for one hour and the value is expected in following headers **Authorization** and **X-ID-Token**.

```
rake generate:authorization_token
rake generate:authentication_token[email-1@no-domain.com]
```

## Other commands useful during development

1. Run  specs. This requires elastic search service so first it should be run depends on your development environment.   

    ``` brew services start elasticsearch ```
    ``` rspec ```

2. Run specs with code coverage

    ``` COVERAGE=true rspec ```
    ``` open tmp/reports/coverage/index.html ```

3. Launch console if needed

    ``` rails c ```

4. Check new code with cops during development

    ``` pronto run -r=flay rails_best_practices reek rubocop brakeman -c origin/master ```

5. Run pronto with cops on whole code like

    ```pronto run --commit=$(git log --pretty=format:%H | tail -1)```
