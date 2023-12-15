<?php

namespace App\Controllers;

use App\Models\Contoh_Model;
use App\Models\KonversiNilai_Model;
use App\Models\Kriteria_Model;
use App\Models\Mahasiswa_Model;
use App\Models\Subkriteria_Model;
use App\Libraries\Flasher;

use function PHPUnit\Framework\isNull;

// use CodeIgniter\Model;
// use PhpParser\Node\Expr\AssignOp\Mod;

class Konversi_nilai extends BaseController
{
    var $title = 'Konversi Nilai'; //ganti title sesuai title
    var $controller = 'konversi_nilai'; //ganti controller sesuai controller

    public function index()
    {
        $namePage = 'Data Alternatif';

        $Kriteria_Model = new Kriteria_Model();
        $jumlahKriteria = $Kriteria_Model->jumlah();
        $dataKriteria = $Kriteria_Model->tampil();

        $Mahasiswa_Model = new Mahasiswa_Model();
        $dataMahasiswa = $Mahasiswa_Model->tampil();

        $KonversiNilai_Model = new KonversiNilai_Model();
        $dataKonversiNilai = $KonversiNilai_Model->tampil();

        //mendapat total bobot
        $totalBobot = 0;

        foreach ($dataKriteria as $kriteria) {
            $totalBobot += $kriteria->nilai_bobot;
        }

        //mendapat normalisasi bobot
        //mendapat total bobot normalisasi
        $hasilNormalisasiBobot = [];
        $totalBobotNormalisasi = 0;

        foreach ($dataKriteria as $kriteria) {
            $hasil = number_format($kriteria->nilai_bobot / $totalBobot, 5);
            $hasilNormalisasiBobot[] = $hasil;
            $totalBobotNormalisasi += $hasil;
        }

        //mendapat hasil skor
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

        $data = array(
            'title' => $this->title,
            'controller' => $this->controller,
            'namePage' => $namePage,
            'jumlahKriteria' => $jumlahKriteria,
            'dataMahasiswa' => $dataMahasiswa,
            'dataKonversiNilai' => $dataKonversiNilai,
            'dataKriteria' => $dataKriteria,
            'hasilNormalisasiBobot' => $hasilNormalisasiBobot,
            'hasilSkor' => $hasilSkor,
            'totalSkor' => $totalSkor,
        );

        //di bawah ini sesuai direktori di views
        echo view('template/admin_header', $data);
        echo view('template/admin_nav');
        echo view('konversi_nilai/index', $data);
        echo view('template/admin_footer');
    }

    public function edit($id)
    {
        $namePage = 'Edit';

        $Mahasiswa_Model = new Mahasiswa_Model();
        $dataMahasiswa = $Mahasiswa_Model->tampilById($id);

        $Kriteria_Model = new Kriteria_Model();
        $dataKriteria = $Kriteria_Model->tampil();

        $Subkriteria_Model = new Subkriteria_Model();
        $dataSubkriteria = $Subkriteria_Model->tampil();

        $KonversiNilai_Model = new KonversiNilai_Model();
        $dataKonversiNilai = $KonversiNilai_Model->tampil();

        $data = array(
            'title' => $this->title,
            'controller' => $this->controller,
            'namePage' => $namePage,
            'dataMahasiswa' => $dataMahasiswa,
            'dataKriteria' => $dataKriteria,
            'dataKonversiNilai' => $dataKonversiNilai,
            'dataSubkriteria' => $dataSubkriteria,

        );

        echo view('template/admin_header', $data);
        echo view('template/admin_nav');
        echo view('konversi_nilai/edit', $data);
        echo view('template/admin_footer');
    }

    public function update($id)
    {
        $Kriteria_Model = new Kriteria_Model();
        $dataKriteria = $Kriteria_Model->tampil();

        $result = false;

        foreach ($dataKriteria as $rowDataKriteria) {

            $subkriteria = $this->request->getPost('kriteria[' . $rowDataKriteria->id . ']');
            $id_konversi = $this->request->getPost('konversi[' . $rowDataKriteria->id . ']');

            $data = [
                'alternatif' => $id,
                'subkriteria' => $subkriteria,
            ];

            $where = [
                'id' => $id_konversi,
            ];

            $KonversiNilai_Model = new KonversiNilai_Model();
            if ($id_konversi == null and $subkriteria != 0) {
                $result = $KonversiNilai_Model->simpan($data);
            } else if ($id_konversi != null and $subkriteria != 0) {
                $result = $KonversiNilai_Model->updateEdit($data, $where);
            }

            unset($KonversiNilai_Model, $data, $where, $id_konversi, $subkriteria);
        }

        if ($result) {
            Flasher::success('Data berhasil diupdate!');
        } else {
            Flasher::error('Gagal update atau tidak ada perubahan data!');
        }
        return redirect()->to(site_url($this->controller));
    }
}
