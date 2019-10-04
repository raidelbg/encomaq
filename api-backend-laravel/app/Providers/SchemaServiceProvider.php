<?php

namespace App\Providers;

use Illuminate\Database\DatabaseManager;
use Illuminate\Support\ServiceProvider;

class SchemaServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     *
     * @return void
     */
    public function register()
    {

        if ( env('DB_CONNECTION' ) === 'pgsql' ) {

            $this->app->singleton('db', function ( $app ) {

                config( [ 'database.connections.pgsql.schema' => $this->resolveSchema() ] );

                return new DatabaseManager( $app, $app[ 'db.factory' ] );

            });

        }

    }

    /**
     * Bootstrap services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }

    protected function resolveSchema()
    {

        $schema = app('request' )->header( 'schema-db' );

        return ( isset( $schema ) != false ) ? $schema : 'public';

    }
}
