<?php

namespace App\Controllers;

use App\Models\Contoh_Model;
use App\Models\Mahasiswa_Model;
use App\Models\Kriteria_Model;
use App\Models\KonversiNilai_Model;

// use CodeIgniter\Model;
// use PhpParser\Node\Expr\AssignOp\Mod;

class Perankingan_wp extends BaseController
{
    var $title = 'Perankingan WP'; //ganti title sesuai title
    var $controller = 'perankingan_wp'; //ganti controller sesuai controller

    public function index()
    {
        $rankings = [];

        $Mahasiswa_Model = new Mahasiswa_Model();
        $dataMahasiswa = $Mahasiswa_Model->tampil();

        $Kriteria_Model = new Kriteria_Model();
        $dataKriteria = $Kriteria_Model->tampil();

        $KonversiNilai_Model = new KonversiNilai_Model();
        $dataKonversiNilai = $KonversiNilai_Model->tampil();

        //total bobot
        $totalBobot = 0;

        foreach ($dataKriteria as $kriteria) {
            $totalBobot += $kriteria->nilai_bobot;
        }

        //normalisasi bobot
        //total bobot normalisasi
        $hasilNormalisasiBobot = [];
        $totalBobotNormalisasi = 0;

        foreach ($dataKriteria as $kriteria) {
            $hasil = number_format($kriteria->nilai_bobot / $totalBobot, 5);
            $hasilNormalisasiBobot[] = $hasil;
            $totalBobotNormalisasi += $hasil;
        }

        //hasil skor
        $hasilSkor = [];

        foreach ($dataMahasiswa as $rowMahasiswa) {
            $noBobot = 0;
            $skorHasil = 1;
            foreach ($dataKriteria as $rowDataKriteria) {
                $noBobot++;

                foreach ($dataKonversiNilai as $rowKonversiNilai) {
                    if ($rowKonversiNilai->alternatif == $rowMahasiswa->id && $rowKonversiNilai->kriteria_subkriteria == $rowDataKriteria->id) {
                        $skot_tingkat_bobot = $rowKonversiNilai->skot_tingkat_bobot_kriteria;

                        $exponent = ($rowDataKriteria->keterangan == 'Cost') ? -$hasilNormalisasiBobot[$noBobot - 1] : $hasilNormalisasiBobot[$noBobot - 1];

                        $skorHasil *= pow($skot_tingkat_bobot, $exponent);
                    }
                }
            }
            $hasilSkor[] = number_format($skorHasil, 5);
        }

        //total skor
        $totalSkor = array_sum($hasilSkor);

        //hasil vektor
        $hasilVektor = [];

        $no = 0;
        foreach ($dataMahasiswa as $rowMahasiswa) {
            $hasilVektor[] = number_format($hasilSkor[$no] / $totalSkor, 5);
            $rankingItem = array(
                'kode_alternatif' => $rowMahasiswa->kode_alternatif,
                'nama' => $rowMahasiswa->nama,
                'hasilVektor' => number_format($hasilSkor[$no] / $totalSkor, 5),
            );
            $rankings[] = $rankingItem;
            $no++;
        }

        //perankingan
        usort($rankings, function ($a, $b) {
            return $b['hasilVektor'] <=> $a['hasilVektor'];
        });

        $data = array(
            'title' => $this->title,
            'controller' => $this->controller,
            'dataMahasiswa' => $dataMahasiswa,
            'hasilSkor' => $hasilSkor,
            'totalSkor' => $totalSkor,
            'hasilVektor' => $hasilVektor,
            'rankings' => $rankings,
        );

        //di bawah ini sesuai direktori di views
        echo view('template/admin_header', $data);
        echo view('template/admin_nav');
        echo view('perankingan_wp/index', $data);
        echo view('template/admin_footer');
    }
}
