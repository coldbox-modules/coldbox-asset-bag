# coldbox-asset-bag

[![Master Branch Build Status](https://img.shields.io/travis/coldbox-modules/coldbox-asset-bag/master.svg?style=flat-square&label=master)](https://travis-ci.org/coldbox-modules/coldbox-asset-bag)

## An asset bag to manage css and javascript dependencies

### The Problem

You want to dynamically include javascript and css based on the code being executed.

You _don't_ want these assets included in the middle of your views.
Instead, you want them included either in the head or footer of your page.
(This is especially important for a framework like Vue where inline javascript breaks the page.)

### This Solution

`coldbox-asset-bag` provides an API to add assets any time during the request lifecycle. It allows adding of css and
javascript assets along with their inline varities and stores them in either the head and footer sections.
Finally, it can render the assets to the appropriate tags in your layout or view.

### Usage

#### Getting an AssetBag

You can create an `AssetBag` anywhere using the `AssetBag@coldbox-asset-bag` injection. However, you will likely not
need to do this. An empty asset bag is added to the `prc` scope in the `preProcess` interceptor. This can be accessed
at `prc.assetBag`.

#### Adding Assets

Out of the box, assets are either CSS or Javascript. They can reference a filepath or be inline content. They can be
added to the `head` or the `footer`. Here are the associated methods:

##### `addJavascriptToHead`

Add a javascript asset to the head of the asset bag.

| Argument | Type   | Required | Default | Description                      |
| -------- | ------ | -------- | ------- | -------------------------------- |
| filepath | string | `true`   |         | The path to the javascript file. |

**Example:**

```cfc
assetBag.addJavascriptToHead( "/includes/js/app.js" );
```

##### `addInlineJavascriptToHead`

Add inline javascript to the head of the asset bag.

| Argument | Type   | Required | Default | Description             |
| -------- | ------ | -------- | ------- | ----------------------- |
| content  | string | `true`   |         | The javascript content. |

**Example:**

```cfc
assetBag.addInlineJavascriptToHead(
    "console.log('Hello, from head');"
);
```

##### `addCssToHead`

Add a css asset to the head of the asset bag.

| Argument | Type   | Required | Default | Description               |
| -------- | ------ | -------- | ------- | ------------------------- |
| filepath | string | `true`   |         | The path to the css file. |

**Example:**

```cfc
assetBag.addCssToHead( "/includes/css/app.css" );
```

##### `addInlineCssToHead`

Add inline css to the head of the asset bag.

| Argument | Type   | Required | Default | Description      |
| -------- | ------ | -------- | ------- | ---------------- |
| content  | string | `true`   |         | The css content. |

**Example:**

```cfc
assetBag.addInlineCssToHead(
    "* { outline: 1px dashed red; }"
);
```

##### `addJavascriptToFooter`

Add a javascript asset to the footer of the asset bag.

| Argument | Type   | Required | Default | Description                      |
| -------- | ------ | -------- | ------- | -------------------------------- |
| filepath | string | `true`   |         | The path to the javascript file. |

**Example:**

```cfc
assetBag.addJavascriptToFooter( "/includes/js/app.js" );
```

##### `addInlineJavascriptToFooter`

Add inline javascript to the footer of the asset bag.

| Argument | Type   | Required | Default | Description             |
| -------- | ------ | -------- | ------- | ----------------------- |
| content  | string | `true`   |         | The javascript content. |

**Example:**

```cfc
assetBag.addInlineJavascriptToFoooter(
    "console.log('Hello, from footer');"
);
```

##### `addCssToFooter`

Add a css asset to the footer of the asset bag.

| Argument | Type   | Required | Default | Description               |
| -------- | ------ | -------- | ------- | ------------------------- |
| filepath | string | `true`   |         | The path to the css file. |

**Example:**

```cfc
assetBag.addCssToFooter( "/includes/css/app.css" );
```

##### `addInlineCssToFooter`

Add inline css to the footer of the asset bag.

| Argument | Type   | Required | Default | Description      |
| -------- | ------ | -------- | ------- | ---------------- |
| content  | string | `true`   |         | The css content. |

**Example:**

```cfc
assetBag.addInlineCssToFooter(
    "* { outline: 1px dashed red; }"
);
```

#### Rendering the Asset Bag

The asset bag can either render the head or the footer. Rendering the asset bag converts all the assets to their
rendered versions and returns a string combined together. This is likely going to be placed in your layout file.

##### `renderHead`

Renders the contents of the asset bag's head to a string.

| Argument     | Type | Required | Default | Description |
| ------------ | ---- | -------- | ------- | ----------- |
| No arguments |      |          |         |             |

##### `renderFooter`

Renders the contents of the asset bag's footer to a string.

| Argument     | Type | Required | Default | Description |
| ------------ | ---- | -------- | ------- | ----------- |
| No arguments |      |          |         |             |

**Example:**

```cfm
<cfoutput>
<html>
    <head>
        <!-- ... -->
        #assetBag.renderHead()#
    </head>
    <body>
        <!-- ... -->
        #assetBag.renderFooter()#
    </body>
</html>
</cfoutput>
```

#### Setting Asset Priorities

Once you add an asset to the asset bag, you can set it's priority with the `setPriority` method.

```cfc
assetBag.addCssToHead( "/includes/css/app1.css" );
assetBag.addCssToHead( "/includes/css/app2.css" ).setPriority( 1 );
```

A warning, this can get unwieldy very quickly. It's hard to know what asset was set with what priority where.
There are probably better ways of bundling javascript for your appplication, like [ColdBox Elixir](https://coldbox-elixir.ortusbooks.com/).----------
Just remember that priority is like z-index in css — choose 1–3 values and stick to them instead of trying to
out do yourself each time.
