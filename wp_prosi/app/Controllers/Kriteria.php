<?php

namespace App\Controllers;

use App\Models\Kriteria_Model;
use App\Models\TingkatBobotKriteria_Model;
use App\Libraries\Flasher;
use CodeIgniter\Model;
use PhpParser\Node\Expr\AssignOp\Mod;

class Kriteria extends BaseController
{
    var $title = 'Kriteria'; //ganti title sesuai title
    var $controller = 'kriteria'; //ganti controller sesuai controller

    public function index()
    {
        $Kriteria_Model = new Kriteria_Model();
        $data = $Kriteria_Model->tampil();

        $data = array(
            'title' => $this->title,
            'controller' => $this->controller,
            'data' => $data,
        );

        //di bawah ini sesuai direktori di views
        echo view('template/admin_header', $data);
        echo view('template/admin_nav');
        echo view('master_data/kriteria/index', $data);
        echo view('template/admin_footer');
    }

    public function tambah()
    {
        $namePage = 'Tambah';

        $TingkatBobotKriteria_Model = new TingkatBobotKriteria_Model();
        $dataTingkatBobotKriteria = $TingkatBobotKriteria_Model->tampil();

        $data = array(
            'title' => $this->title,
            'controller' => $this->controller,
            'namePage' => $namePage,
            'dataTingkatBobotKriteria' => $dataTingkatBobotKriteria,
        );

        echo view('template/admin_header', $data);
        echo view('template/admin_nav');
        echo view('master_data/kriteria/tambah', $data);
        echo view('template/admin_footer');
    }

    public function edit($id)
    {
        $namePage = 'Edit';

        $Kriteria_Model = new Kriteria_Model();
        $data = $Kriteria_Model->tampilById($id);

        $TingkatBobotKriteria_Model = new TingkatBobotKriteria_Model();
        $dataTingkatBobotKriteria = $TingkatBobotKriteria_Model->tampil();

        $data = array(
            'title' => $this->title,
            'controller' => $this->controller,
            'namePage' => $namePage,
            'data' => $data,
            'dataTingkatBobotKriteria' => $dataTingkatBobotKriteria,
        );

        echo view('template/admin_header', $data);
        echo view('template/admin_nav');
        echo view('master_data/kriteria/edit', $data);
        echo view('template/admin_footer');
    }

    public function simpan()
    {
        date_default_timezone_set('Asia/Jakarta');
        $timestamp = date('Y-m-d H:i:s');
        $kriteria = $this->request->getPost('kriteria');
        $bobot = $this->request->getPost('bobot');

        $data = [
            'timestamp' => $timestamp,
            'kriteria' => $kriteria,
            'bobot' => $bobot,
        ];

        $Kriteria_Model = new Kriteria_Model();
        $result = $Kriteria_Model->simpan($data);

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
        $bobot = $this->request->getPost('bobot');

        $data = [
            'kriteria' => $kriteria,
            'bobot' => $bobot,
        ];

        $where = ['id' => $id];

        $Kriteria_Model = new Kriteria_Model();
        $result = $Kriteria_Model->updateEdit($data, $where);

        if ($result) {
            Flasher::success('Data berhasil diupdate!');
        } else {
            Flasher::error('Gagal update atau tidak ada perubahan data!');
        }
        return redirect()->to(site_url($this->controller));
    }

    public function hapus($id)
    {
        $Kriteria_Model = new Kriteria_Model();
        $result = $Kriteria_Model->hapus($id);

        if ($result) {
            Flasher::success('Data berhasil dihapus!');
        } else {
            Flasher::error('Gagal menghapus data!');
        }
        return redirect()->to(site_url($this->controller));
    }
}
