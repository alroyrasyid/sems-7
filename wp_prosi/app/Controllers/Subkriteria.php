<?php

namespace App\Controllers;

use App\Models\Kriteria_Model;
use App\Models\Subkriteria_Model;
use App\Models\TingkatBobotKriteria_Model;
use App\Libraries\Flasher;
use CodeIgniter\Model;
use PhpParser\Node\Expr\AssignOp\Mod;

class Subkriteria extends BaseController
{

    var $title = 'Subkriteria'; //ganti title sesuai title
    var $controller = 'subkriteria'; //ganti controller sesuai controller

    public function index()
    {
        $Subkriteria_Model = new Subkriteria_Model();
        $data = $Subkriteria_Model->tampil();

        $data = array(
            'title' => $this->title,
            'controller' => $this->controller,
            'data' => $data,
        );

        //di bawah ini sesuai direktori di views
        echo view('template/admin_header', $data);
        echo view('template/admin_nav');
        echo view('master_data/subkriteria/index', $data);
        echo view('template/admin_footer');
    }

    public function tambah()
    {
        $namePage = 'Tambah';

        $Kriteria_Model = new Kriteria_Model();
        $dataKriteria = $Kriteria_Model->tampil();

        $TingkatBobotKriteria_Model = new TingkatBobotKriteria_Model();
        $dataTingkatBobotKriteria = $TingkatBobotKriteria_Model->tampil();

        $data = array(
            'title' => $this->title,
            'controller' => $this->controller,
            'namePage' => $namePage,
            'dataKriteria' => $dataKriteria,
            'dataTingkatBobotKriteria' => $dataTingkatBobotKriteria,
        );

        echo view('template/admin_header', $data);
        echo view('template/admin_nav');
        echo view('master_data/subkriteria/tambah', $data);
        echo view('template/admin_footer');
    }

    public function edit($id)
    {
        $namePage = 'Edit';

        $Subkriteria_Model = new Subkriteria_Model();
        $data = $Subkriteria_Model->tampilById($id);

        $Kriteria_Model = new Kriteria_Model();
        $dataKriteria = $Kriteria_Model->tampil();

        $TingkatBobotKriteria_Model = new TingkatBobotKriteria_Model();
        $dataTingkatBobotKriteria = $TingkatBobotKriteria_Model->tampil();

        $data = array(
            'title' => $this->title,
            'controller' => $this->controller,
            'namePage' => $namePage,
            'data' => $data,
            'dataKriteria' => $dataKriteria,
            'dataTingkatBobotKriteria' => $dataTingkatBobotKriteria,
        );

        echo view('template/admin_header', $data);
        echo view('template/admin_nav');
        echo view('master_data/subkriteria/edit', $data);
        echo view('template/admin_footer');
    }

    public function simpan()
    {
        $kriteria = $this->request->getPost('kriteria');
        $subkriteria = $this->request->getPost('subkriteria');
        $skor = $this->request->getPost('skor');
        $keterangan = $this->request->getPost('keterangan');

        $data = [
            'kriteria' => $kriteria,
            'subkriteria' => $subkriteria,
            'skor' => $skor,
            'keterangan' => $keterangan
        ];

        $Subkriteria_Model = new Subkriteria_Model();
        $result = $Subkriteria_Model->simpan($data);

        if ($result) {
            Flasher::success('Data berhasil disimpan!');
        } else {
            Flasher::error('Gagal menyimpan data!');
        }
        return redirect()->to(site_url($this->controller));
    }

    public function update($id)
    {
        $kriteria = $this->request->getPost('kriteria');
        $subkriteria = $this->request->getPost('subkriteria');
        $skor = $this->request->getPost('skor');
        $keterangan = $this->request->getPost('keterangan');

        $data = [
            'kriteria' => $kriteria,
            'subkriteria' => $subkriteria,
            'skor' => $skor,
            'keterangan' => $keterangan
        ];

        $where = ['id' => $id];

        $Subkriteria_Model = new Subkriteria_Model();
        $result = $Subkriteria_Model->updateEdit($data, $where);

        if ($result) {
            Flasher::success('Data berhasil diupdate!');
        } else {
            Flasher::error('Gagal update atau tidak ada perubahan data!');
        }
        return redirect()->to(site_url($this->controller));
    }

    public function hapus($id)
    {
        $Subkriteria_Model = new Subkriteria_Model();
        $result = $Subkriteria_Model->hapus($id);

        if ($result) {
            Flasher::success('Data berhasil dihapus!');
        } else {
            Flasher::error('Gagal menghapus data!');
        }
        return redirect()->to(site_url($this->controller));
    }
}
