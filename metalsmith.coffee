jade = require 'jade'
moment = require 'moment'
Metalsmith  = require 'metalsmith'
assets      = require 'metalsmith-assets'
bexcerpts   = require 'metalsmith-better-excerpts'
collections = require 'metalsmith-collections'
drafts      = require 'metalsmith-drafts'
feed        = require 'metalsmith-feed'
markdown    = require 'metalsmith-markdown'
metallic    = require 'metalsmith-metallic'
paginate    = require 'metalsmith-paginate'
paths       = require 'metalsmith-paths'
permalinks  = require 'metalsmith-permalinks'
relative    = require 'metalsmith-relative'
templates   = require 'metalsmith-templates'

smith = Metalsmith(__dirname)
    .metadata
        site:
            url: 'http://eddie.ringle.io'
            title: 'Eddie Ringle'
            tagline: 'I do some things sometimes'
        moment: moment
        postDateFormat: 'MMMM D, YYYY - h:mma'
    .source './contents'
    .use assets(
        source: './assets',
        destination: './assets'
    )
    .use bexcerpts()
    .use collections(
        posts:
            pattern: 'contents/posts/*.md',
            sortBy: 'date',
            reverse: true
    )
    .use drafts()
    .use metallic()
    .use markdown()
    .use paginate(
        perPage: 100,
        path: 'posts/page'
    )
    .use paths()
    .use permalinks(
        pattern: ':collection/:title'
    )
    .use relative()
    .use feed(
        collection: 'posts'
    )
    .use templates('jade')
    .build (err) ->
        throw err if err
