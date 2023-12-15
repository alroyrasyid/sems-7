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

            <!-- Vertical Form -->
            <form class="row g-3" method="post" action="<?= base_url($controller . '/simpan'); ?>">
                <div class="col-12">
                    <label for="kriteria" class="form-label">Kriteria</label>
                    <input type="text" class="form-control" id="kriteria" name="kriteria">
                </div>
                <div class="col-12">
                    <label for="bobot" class="form-label">Bobot</label>
                    <select name="bobot" id="bobot" class="form-select">
                        <option>Pilih..</option>
                        <?php foreach ($dataTingkatBobotKriteria as $data) : ?>
                            <option value="<?= $data->id; ?>"><?= $data->nilai; ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="d-flex justify-content-between pt-3">
                    <a href="<?= base_url($controller); ?>" class="btn btn-secondary">Kembali</a>
                    <button type="submit" class="btn btn-success">Simpan</button>
                </div>
            </form><!-- Vertical Form -->

        </div>
    </div>
</div>