<?php

namespace App\Controllers;

use App\Models\Contoh_Model;
use App\Models\Kriteria_Model;

// use CodeIgniter\Model;
// use PhpParser\Node\Expr\AssignOp\Mod;

class Bobot_dan_kriteria extends BaseController
{
    var $title = 'Bobot Kriteria'; //ganti title sesuai title
    var $controller = 'bobot_dan_kriteria'; //ganti controller sesuai controller

    public function index()
    {
        $Kriteria_Model = new Kriteria_Model();
        $dataKriteria = $Kriteria_Model->tampil();

        //mendapat total bobot
        $totalBobot = 0;

        foreach ($dataKriteria as $kriteria) {
            $totalBobot += $kriteria->nilai_bobot;
        }

        //mendapat hasil normalisasi bobot
        //mendapat total bobot normalisasi
        $hasilNormalisasiBobot = array();
        $totalBobotNormalisasi = 0;

        foreach ($dataKriteria as $kriteria) {
            $hasil = number_format($kriteria->nilai_bobot / $totalBobot, 5);
            $hasilNormalisasiBobot[] = $hasil;
            $totalBobotNormalisasi += $hasil;
        }

        $data = array(
            'title' => $this->title,
            'controller' => $this->controller,
            'dataKriteria' => $dataKriteria,
            'totalBobot' => $totalBobot,
            'hasilNormalisasiBobot' => $hasilNormalisasiBobot,
            'totalBobotNormalisasi' => $totalBobotNormalisasi,
        );

        //di bawah ini sesuai direktori di views
        echo view('template/admin_header', $data);
        echo view('template/admin_nav');
        echo view('bobot_dan_kriteria/index', $data);
        echo view('template/admin_footer');
    }
}
