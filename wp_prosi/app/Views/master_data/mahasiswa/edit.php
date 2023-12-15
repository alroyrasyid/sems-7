<div class="pagetitle">
    <h1><?= $title; ?></h1>
    <nav class=" d-flex justify-content-end">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<?= base_url(); ?>">Home</a></li>
            <li class="breadcrumb-item"><a href="<?= base_url($controller); ?>"><?= $title; ?></a></li>
            <li class="breadcrumb-item active"><?= $namePage; ?></li>
        </ol>
    </nav>
</div><!-- End Page Title -->

<div class="col-lg-6 mx-auto">

    <div class="card">
        <div class="card-body">
            <h5 class="card-title"><?= $namePage . " " . $title; ?></h5>
            <?php
            foreach ($data as $row)
            ?>
            <!-- Vertical Form -->
            <form class="row g-3" method="post" action="<?= base_url($controller . '/update//' . $row->id); ?>">
                <div class="col-12">
                    <label for="id" class="form-label">ID</label>
                    <input type="text" class="form-control" id="id" name="id" value="<?= $row->id; ?>" disabled>
                </div>
                <div class="col-12">
                    <label for="kode_alternatif" class="form-label">Kode Alternatif</label>
                    <input type="text" class="form-control" id="kode_alternatif" name="kode_alternatif" value="<?= $row->kode_alternatif; ?>">
                </div>
                <div class="col-12">
                    <label for="nama" class="form-label">Nama</label>
                    <input type="text" class="form-control" id="nama" name="nama" value="<?= $row->nama; ?>">
                </div>
                <div class="d-flex justify-content-between pt-3">
                    <a href="<?= base_url($controller); ?>" class="btn btn-secondary">Kembali</a>
                    <button type="submit" class="btn btn-success">Update</button>
                </div>
            </form><!-- Vertical Form -->

        </div>
    </div>
</div>