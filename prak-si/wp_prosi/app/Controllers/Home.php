<?php

namespace App\Controllers;

use App\Models\Contoh_Model;

// use CodeIgniter\Model;
// use PhpParser\Node\Expr\AssignOp\Mod;

class Home extends BaseController
{
    var $title = 'Kelompok dan Kredit'; //ganti title sesuai title
    var $controller = 'home'; //ganti controller sesuai controller

    public function index()
    {
        $Contoh_Model = new Contoh_Model();

        $tampil_contoh = $Contoh_Model->tampil();

        $data = array(
            'title' => $this->title,
            'controller' => $this->controller,
            'tampil_contoh' => $tampil_contoh,
        );

        //di bawah ini sesuai direktori di views
        echo view('template/admin_header', $data);
        echo view('template/admin_nav');
        echo view('home/index', $data);
        echo view('template/admin_footer');
    }
}
