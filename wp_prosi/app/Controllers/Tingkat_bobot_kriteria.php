<?php

namespace App\Controllers;

use App\Models\TingkatBobotKriteria_Model;

use App\Libraries\Flasher;

use CodeIgniter\Model;
use PhpParser\Node\Expr\AssignOp\Mod;

class Tingkat_bobot_kriteria extends BaseController
{
    var $title = 'Tingkat Bobot Kriteria'; //ganti title sesuai title
    var $controller = 'tingkat_bobot_kriteria'; //ganti controller sesuai controller

    public function index()
    {
        $TingkatBobotKriteria_Model = new TingkatBobotKriteria_Model();
        $data = $TingkatBobotKriteria_Model->tampil();

        $data = array(
            'title' => $this->title,
            'controller' => $this->controller,
            'data' => $data,
        );

        //di bawah ini sesuai direktori di views
        echo view('template/admin_header', $data);
        echo view('template/admin_nav');
        echo view('master_data/tingkat_bobot_kriteria/index', $data);
        echo view('template/admin_footer');
    }

    public function edit($id)
    {
        $namePage = 'Edit';

        $TingkatBobotKriteria_Model = new TingkatBobotKriteria_Model();
        $data = $TingkatBobotKriteria_Model->tampilById($id);

        $data = array(
            'title' => $this->title,
            'controller' => $this->controller,
            'namePage' => $namePage,
            'data' => $data,
        );

        echo view('template/admin_header', $data);
        echo view('template/admin_nav');
        echo view('master_data/tingkat_bobot_kriteria/edit', $data);
        echo view('template/admin_footer');
    }

    public function tambah()
    {
        $namePage = 'Tambah';

        $data = array(
            'title' => $this->title,
            'controller' => $this->controller,
            'namePage' => $namePage,
        );

        echo view('template/admin_header', $data);
        echo view('template/admin_nav');
        echo view('master_data/tingkat_bobot_kriteria/tambah', $data);
        echo view('template/admin_footer');
    }

    public function simpan()
    {
        $kriteria_penilaian = $this->request->getPost('kriteria_penilaian');
        $nilai = $this->request->getPost('nilai');

        $data = [
            'kriteria_penilaian' => $kriteria_penilaian,
            'nilai' => $nilai,
        ];

        $TingkatBobotKriteria_Model = new TingkatBobotKriteria_Model();
        $result = $TingkatBobotKriteria_Model->simpan($data);

        if ($result) {
            Flasher::success('Data berhasil disimpan!');
        } else {
            Flasher::error('Gagal menyimpan data!');
        }
        return redirect()->to(site_url($this->controller));
    }

    public function update($id)
    {
        $kriteria_penilaian = $this->request->getPost('kriteria_penilaian');
        $nilai = $this->request->getPost('nilai');

        $data = [
            'kriteria_penilaian' => $kriteria_penilaian,
            'nilai' => $nilai,
        ];

        $where = ['id' => $id];

        $TingkatBobotKriteria_Model = new TingkatBobotKriteria_Model();
        $result = $TingkatBobotKriteria_Model->updateEdit($data, $where);

        if ($result) {
            Flasher::success('Data berhasil diupdate!');
        } else {
            Flasher::error('Gagal update atau tidak ada perubahan data!');
        }
        return redirect()->to(site_url($this->controller));
    }

    public function hapus($id)
    {
        $TingkatBobotKriteria_Model = new TingkatBobotKriteria_Model();
        $result = $TingkatBobotKriteria_Model->hapus($id);

        if ($result) {
            Flasher::success('Data berhasil dihapus!');
        } else {
            Flasher::error('Gagal menghapus data!');
        }

        return redirect()->to(site_url($this->controller));
    }
}
