<div class="pagetitle">
    <h1><?= $title; ?></h1>
    <nav class="d-flex justify-content-end">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<?= base_url(); ?>">Home</a></li>
            <li class="breadcrumb-item active"><?= $title; ?></li>
        </ol>
    </nav>
</div><!-- End Page Title -->

<section class="section">
    <?php if (session()->has('header_success')) : ?>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <?= session()->getFlashdata('header_success') ?>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <?php endif; ?>

    <?php if (session()->has('header_error')) : ?>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <?= session()->getFlashdata('header_error') ?>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <?php endif; ?>
    <div class="row">
        <div class="col-lg-12">

            <div class="card">
                <div class="card-body">
                    <!-- <h5 class="card-title">Datatables</h5>
                    <p>Add lightweight datatables to your project with using the <a href="https://github.com/fiduswriter/Simple-DataTables" target="_blank">Simple DataTables</a> library. Just add <code>.datatable</code> class name to any table you wish to conver to a datatable. Check for <a href="https://fiduswriter.github.io/simple-datatables/demos/" target="_blank">more examples</a>.</p> -->
                    <div class="nav justify-content-end py-4">
                        <a href="<?= base_url($controller . '/tambah') ?>" class="btn btn-success">Tambah <?= $title; ?></a>
                    </div>
                    <!-- Table with stripped rows -->
                    <table class="table datatable">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>Kriteria Penilaian</th>
                                <th>Nilai</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
                            $no = 0;
                            foreach ($data as $row) : $no++;
                            ?>
                                <tr>
                                    <td><?= $no; ?></td>
                                    <td><?= $row->kriteria_penilaian; ?></td>
                                    <td><?= $row->nilai; ?></td>
                                    <td>
                                        <a href="<?= base_url($controller . '/edit//' . $row->id) ?>"><span class="badge bg-secondary">Edit</span></a>
                                        <a href="<?= base_url($controller . '/hapus//' . $row->id) ?>"><span class="badge bg-danger" onclick="return confirm('Apakah anda yakin ingin menghapus?')">Hapus</span></a>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                    <!-- End Table with stripped rows -->
                </div>
            </div>
        </div>
    </div>
</section>