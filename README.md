### Run Web Crawler on Luma site
```ruby
ruby luma/main.rb
```
### Export products
```ruby
ruby luma/main.rb -e
```
##### Export html (default)
```ruby
ruby luma/main.rb -e html
```
##### Export csv
```ruby
ruby luma/main.rb -e csv
```
##### Export json
```ruby
ruby luma/main.rb -e json
```

### Sort products
##### Sort by name
```ruby
ruby luma/main.rb -s name -t asc
```
##### Sort by Highest Price
```ruby
ruby luma/main.rb -s price -t desc
```

### Log
##### show log and create file in path logs/YYYY-mm-dd.txt
```ruby
ruby luma/main.rb -l
```

### Deep Page
##### Fetch number of pages
###### Fetch just 5 pages
```ruby
ruby luma/main.rb -p 5
```