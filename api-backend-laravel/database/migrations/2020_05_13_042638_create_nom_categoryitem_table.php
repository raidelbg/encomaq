<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

class CreateNomCategoryitemTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up(): void
    {
        Schema::create('nom_categoryitem', function (Blueprint $table) {
            $table->bigIncrements('idcategoryitem');
            $table->string('categoryitemname', 150);
            $table->tinyInteger('state')->default(1);
            $table->timestamp('created_at', 0)->default(DB::raw('now()'));
            $table->timestamp('updated_at', 0)->default(DB::raw('now()'));
            $table->softDeletes()->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down(): void
    {
        Schema::dropIfExists('nom_categoryitem');
    }
}
