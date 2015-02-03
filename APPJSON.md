app.json
======

Much like Heroku, Vektra uses an `app.json` file as a manifest for describing
your apps.

## Example app.json

```js
{
  "name": "example"
	"routes": {
    "web": [
      { "path": "example" }
     ]
   }
}
```

## Schema reference

### name

(string, optional) A clean and simple name to identify the app (30
characters max).

```js
{
  "name": "example"
}
```

### routes

(object, optional) A key-value object for process routes. Keys are process
names.  Values are arrays containing key-value objects for routes that should
map to that process. The key-value route object may define keys:

 - `path`: (string, optional)
 - `subdomain`: (string, optional)

#### path routes

If only a `path` is supplied then your app will be available at that path. So
in the example below our app will be available at `ourdomain.com/example`.

```js
{
	"routes": {
    "web": [
      { "path": "example" }
     ]
   }
}
```

#### subdomain routes

If only a `subdomain` is supplied then your app will be available at that
subdomain. So in the example below our app will be available at
`example.ourdomain.com`.

```js
{
	"routes": {
    "web": [
      { "subdomain": "example" }
     ]
   }
}
```

#### path and subdomain routes

If `path` and `subdomain` are both supplied for a route they will be used in
conjunction. So in the example below our app will be available at
`example.ourdomain.com/example`.

```js
{
	"routes": {
    "web": [
      { "path": "example", "subdomain": "example" }
     ]
   }
}
```
