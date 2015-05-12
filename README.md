This is a demo application of [meteorSegmentation](https://github.com/leetschau/meteorSegmentation/) package.

# Build Segmentation Dictionary

First a Chinese words list are necessary, for example:

    $ cat segdb.json
    [ "上海",
    "上虞",
    "上饶",
    "不丹",
    "专业",
    "专家",
    "专用",
    "专科" ]

Then convert it into a segmentation dictionary (saved in file "segdict.json")
using a node script "mkdict.js":

    $ cat mkdict.js
    var _ = require('underscore');
    var fs = require('fs');
    var data = require('./segdb.json');
    var mkDict = function(inp) {
      sortDict = _.sortBy(inp, function(word){ return -1 * word.length; });
      return _.groupBy(sortDict, function(word){ return word[0]; });
    };
    var dict = mkDict(data);
    fs.writeFile('segdict.json', JSON.stringify(dict));

Run it and import the result dictionary file into mongoDB:

    $ node mkdict
    $ mongoimport -d test --collection segdict --type json --file segdict.json

For now it's imported into a local database.

# Run Application and Unit Test

Run application: `MONGO_URL="mongodb://localhost:27017/test" meteor`.

Run unit test: `meteor test-packages`.
