<?php

namespace App\Controllers;

use App\Models\Mahasiswa_Model;
use App\Libraries\Flasher;
use CodeIgniter\Model;
use PhpParser\Node\Expr\AssignOp\Mod;

class Mahasiswa extends BaseController
{
    var $title = 'Mahasiswa'; //ganti title sesuai title
    var $controller = 'mahasiswa'; //ganti controller sesuai controller

    public function index()
    {
        $Mahasiswa_Model = new Mahasiswa_Model();

        $data = $Mahasiswa_Model->tampil();

        $data = array(
            'title' => $this->title,
            'controller' => $this->controller,
            'data' => $data,
        );

        //di bawah ini sesuai direktori di views
        echo view('template/admin_header', $data);
        echo view('template/admin_nav');
        echo view('master_data/mahasiswa/index', $data);
        echo view('template/admin_footer');
    }

    public function edit($id)
    {
        $namePage = 'Edit';

        $Mahasiswa_Model = new Mahasiswa_Model();
        $data = $Mahasiswa_Model->tampilById($id);

        $data = array(
            'title' => $this->title,
            'controller' => $this->controller,
            'namePage' => $namePage,
            'data' => $data,
        );

        echo view('template/admin_header', $data);
        echo view('template/admin_nav');
        echo view('master_data/mahasiswa/edit', $data);
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
        echo view('master_data/mahasiswa/tambah', $data);
        echo view('template/admin_footer');
    }

    public function simpan()
    {
        $kode_alternatif = $this->request->getPost('kode_alternatif');
        $nama = $this->request->getPost('nama');

        $data = [
            'kode_alternatif' => $kode_alternatif,
            'nama' => $nama,
        ];

        $Mahasiswa_Model = new Mahasiswa_Model();
        $result = $Mahasiswa_Model->simpan($data);

        if ($result) {
            Flasher::success('Data berhasil disimpan!');
        } else {
            Flasher::error('Gagal menyimpan data!');
        }
        return redirect()->to(site_url($this->controller));
    }

    public function update($id)
    {
        $kode_alternatif = $this->request->getPost('kode_alternatif');
        $nama = $this->request->getPost('nama');

        $data = [
            'kode_alternatif' => $kode_alternatif,
            'nama' => $nama,
        ];

        $where = ['id' => $id];

        $Mahasiswa_Model = new Mahasiswa_Model();
        $result = $Mahasiswa_Model->updateEdit($data, $where);

        if ($result) {
            Flasher::success('Data berhasil diupdate!');
        } else {
            Flasher::error('Gagal update atau tidak ada perubahan data!');
        }

        return redirect()->to(site_url($this->controller));
    }

    public function hapus($id)
    {
        $Mahasiswa_Model = new Mahasiswa_Model();
        $result = $Mahasiswa_Model->hapus($id);

        if ($result) {
            Flasher::success('Data berhasil dihapus!');
        } else {
            Flasher::error('Gagal menghapus data!');
        }

        return redirect()->to(site_url($this->controller));
    }
}
