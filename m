Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793715383;
	b=rEtK68lLl7InZ0ZuxEOcjckxJOIV79TLAil68QBxOEmhB4bzjk+sE9y20DgoGXbXaKOP
	 hylIFxuU3plR+1MoPpx7aOylR8HobaAv0MZ3YH0KtRQdspLimMGRt9yEUcLgslsibVkSe
	 mLEdRGE9MICWNAwj4eMlu88cFn2qXMTl9M6havz1KLMQXD/7w/fpfk9qQYrrMI2QcUWRY
	 UU+ZWCQUAAFfPA7+O+Lhwt/BXH9zr6D4thXPMsE4AGoYkBextAWDXhmQR3w9T484nN6EK
	 eMYoMlfYIoPi+knGVItBXLiHpY5x6NWIkcFNcz7RnkObPiBJcAZ6U3G8f+RN5kBK6Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793715383;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zXECr++TlRCvJUjfvzX5pSjXBTUtNnoQkMAq/3cCFQ0=;
	b=uc1KZtxU5vmBTTLqyyND3JuoW2VaENex1nHFPfEeijDxrOblCgGodcVVd1OF4MTI6Eq1
	 rAh+AOil2qkQGgSbf8jZqWFk6iH+63CanqSf43MZF43fcyUKEvedgqaHmP3e01LdHM744
	 8BAzqU8kLIb2+k43p8o8mgsvnORJYwOxls213MNAEEAdFkyKI+P7rzOB+2uK9bww5dswp
	 DYIbm/Sl2NdaZA6F3RGNsDREGaLH2RPIw2dnQGHfLd37H4EjF3pSiNMnPmP7TjPTeI0P+
	 fz0gpitf/ZfJKvjWp5o/pVWWY8n+skG/AsZYfK6qLMexDra0HY58pwaXOFMUNNYZ0sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0wUZ6jk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20C5606A328
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0wUZ6jk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A961F000C1;
	Tue,  3 Nov 2026 14:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793715382;
	bh=zXECr++TlRCvJUjfvzX5pSjXBTUtNnoQkMAq/3cCFQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V0wUZ6jkD7UvmlwIvhakpk8Uux2sEnPki+h8XE7buBhgUN2oTilyoDzNWpSyEhViu
	 atMoCvlF6cFjRuF49/fWUtr9rn6cbRvkO0PgWLFNigAqZF9098nqk5DrBkdHtBH6vz
	 ITsrlXMcER9ZCjfVLhzAqEx6nBbTaoXVMKT7tl2YQxp43gK7qKaC/253IKPGxqBuMY
	 XDwX2cIJIGslg0+JOL7uM12eYoy5LrPIGC8Qc8rsaBPonzMtIIUsHcGJIP8hYB43MF
	 v2UZFcgrblMzQmGxYZ+u5yfMZ58Gd1MH6E8mXNnl8KviIW6LoUGaKHKE2BbnRLXLTb
	 7Ih0ywrEQmDyw==
Message-ID: <sashiko-outbox-195431@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v12 3/4] selftests/bpf: add iocost cost model test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: bpf@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
In-Reply-To: <20261103132613.1952975-4-cui.tao@linux.dev>
References: <20261103132613.1952975-1-cui.tao@linux.dev>
 <20261103132613.1952975-4-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 14:16:21 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] selftests/bpf: missing leading slash in cgroup paths in iocost_m=
odel tests
- [Medium] selftests/bpf: iocost_bpf_supported() requires /proc/config.gz t=
o run tests
- [Low] selftests/bpf: unpaired cleanup_cgroup_environment() in iocost_model
- [Low] selftests/bpf: missing rmdir() on error paths in nullb_create()
--

commit 853e704fa28b8b44bb71705b9e1a9ac55510a4dd
Author: Tao Cui <cuitao@kylinos.cn>

selftests/bpf: add iocost cost model test

This commit adds two BPF iocost cost models (a doubled linear HDD model and=
 a
multi-stream sequentiality model) along with selftests that attach them to a
configfs-created null_blk device and verify pricing, tracepoints, model
switching, and device removal.

> diff --git a/tools/testing/selftests/bpf/prog_tests/iocost_model.c b/tool=
s/testing/selftests/bpf/prog_tests/iocost_model.c
> new file mode 100644
> index 0000000000000..fa9280fe9e34b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/iocost_model.c
> @@ -0,0 +1,748 @@

[ ... ]

> +static int nullb_create(const char *name, char *dev, size_t dev_sz)
> +{
> +	char path[128];
> +	char p2[128];
> +	int err;
> +
> +	snprintf(path, sizeof(path), "/sys/kernel/config/nullb/%s", name);
> +	if (mkdir(path, 0755)) {
> +		if (errno !=3D EEXIST)
> +			return -errno;
> +		/*
> +		 * a leftover instance from an earlier crashed run may
> +		 * still be powered: tear it down before reusing the
> +		 * name
> +		 */
> +		snprintf(p2, sizeof(p2),
> +			 "/sys/kernel/config/nullb/%s/power", name);
> +		configfs_write(p2, "0");
> +		if (rmdir(path) && errno !=3D ENOENT)
> +			return -errno;
> +		if (mkdir(path, 0755) && errno !=3D EEXIST)
> +			return -errno;
> +	}
> +
> +	snprintf(path, sizeof(path), "/sys/kernel/config/nullb/%s/size", name);
> +	err =3D configfs_write(path, "128");
> +	if (err)
> +		return err;
> +
> +	snprintf(path, sizeof(path), "/sys/kernel/config/nullb/%s/power", name);
> +	err =3D configfs_write(path, "1");
> +	if (err)
> +		return err;

[Severity: Low]
As reported by Sashiko on RFC v11 [1], if configfs_write() fails when writi=
ng
to size or power in nullb_create(), does this return early and leave the
/sys/kernel/config/nullb/<name> directory and its underlying kernel
nullb_device allocated?

In serial_test_iocost_model() and serial_test_iocost_model_streams(), the
callers also return directly on nullb_create() failure without calling
nullb_remove(IOCOST_NULLB). Should nullb_create() remove the instance
directory on these error paths just like the read_file_token() failure path
below?

> +
> +	snprintf(path, sizeof(path), "/sys/block/%s/dev", name);
> +	err =3D read_file_token(path, dev, dev_sz);
> +	if (err) {
> +		/* do not leave a powered instance behind */
> +		snprintf(path, sizeof(path),
> +			 "/sys/kernel/config/nullb/%s/power", name);
> +		configfs_write(path, "0");
> +		snprintf(path, sizeof(path),
> +			 "/sys/kernel/config/nullb/%s", name);
> +		rmdir(path);
> +	}
> +	return err;
> +}

[ ... ]

> +static bool iocost_bpf_supported(void)
> +{
> +	FILE *f;
> +	char line[128];
> +	bool on =3D false;
> +
> +	f =3D popen("zcat /proc/config.gz 2>/dev/null", "r");
> +	if (!f)
> +		return false;
> +	while (fgets(line, sizeof(line), f)) {
> +		if (strstr(line, "CONFIG_BLK_CGROUP_IOCOST_BPF=3Dy"))
> +			on =3D true;
> +	}
> +	pclose(f);
> +	return on;
> +}

[Severity: Medium]
As reported by Tejun Heo on RFC v11 [2], won't iocost_bpf_supported() still
return false and cause iocost_test_env() to skip all three tests whenever
/proc/config.gz is not present on the system, even if the running kernel has
CONFIG_BLK_CGROUP_IOCOST_BPF=3Dy enabled?

When CONFIG_IKCONFIG_PROC is disabled, popen() still succeeds while zcat
outputs nothing, so fgets() reads zero lines and on remains false. In RFC v=
11
it was noted that the any variable tracking whether any lines were read was
set but never used; here any was removed rather than used to avoid skipping
when /proc/config.gz is unavailable (or falling back to /boot/config-<relea=
se>
or BTF probing).

[ ... ]

> +	cg =3D cgroup_setup_and_join("iocost_pairing");
> +	if (!ASSERT_GE(cg, 0, "setup_cg")) {
> +		iocost_model__destroy(skel);
> +		nullb_remove(IOCOST_NULLB);
> +		return;
> +	}

[ ... ]

> +		ASSERT_OK(join_cgroup("iocost_pairing"), "join_pairing");
> +		snprintf(qbuf, sizeof(qbuf), "%s 1000", dev);
> +		ASSERT_OK(write_cgroup_file("iocost_pairing", "io.weight",
> +				     qbuf), "weight_pairing");
> +		snprintf(qbuf, sizeof(qbuf),
> +			 "%s enable=3D1 ctrl=3Duser min=3D100.00 max=3D100.00", dev);
> +		ASSERT_OK(configfs_write("/sys/fs/cgroup/io.cost.qos", qbuf),
> +			  "qos_enable");
> +
> +		devfd =3D open(path, O_RDONLY);
> +		if (!ASSERT_OK(devfd < 0 ? -errno : 0, "open_dev_priced")) {
> +			iocost_model__destroy(skel);
> +			snprintf(qbuf, sizeof(qbuf), "%s enable=3D0", dev);
> +			(void)configfs_write("/sys/fs/cgroup/io.cost.qos", qbuf);
> +			nullb_remove(IOCOST_NULLB);
> +			cleanup_cgroup_environment();
> +			return;
> +		}
> +		ASSERT_OK(read_cost_usage("iocost_pairing",
> +					  dev, &u1), "cost_usage_pre");
> +		for (i =3D 0; i < 500; i++)
> +			(void)read(devfd, buf, sizeof(buf));
> +		close(devfd);
> +		ASSERT_GT(skel->bss->calc_costs, 0, "model_priced");
> +		/*
> +		 * the usage stat is flushed by the iocost timer, give
> +		 * the current period a chance to end before reading
> +		 */
> +		sleep(3);
> +		ASSERT_OK(read_cost_usage("iocost_pairing",
> +					  dev, &u2), "cost_usage_post");

[Severity: Medium]
Does passing "iocost_pairing" (and "iocost_ms" in
serial_test_iocost_model_streams() below) without a leading slash to
cgroup_setup_and_join(), join_cgroup(), write_cgroup_file(), and
read_cost_usage()->read_cgroup_file() leak the test cgroups in the root cgr=
oup
hierarchy?

In tools/testing/selftests/bpf/cgroup_helpers.c, format_cgroup_path_pid()
formats paths without inserting a slash before path:

    #define format_cgroup_path_pid(buf, path, pid) \
        snprintf(buf, sizeof(buf), "%s%s%d%s", CGROUP_MOUNT_PATH, \
        CGROUP_WORK_DIR, pid, path)

Without a leading slash, this creates
/mnt/cgroup-test-work-dir<pid>iocost_pairing as a sibling of
/mnt/cgroup-test-work-dir<pid> rather than a child inside it. When
cleanup_cgroup_environment() runs, __cleanup_cgroup_environment() only runs
nftw() on /mnt/cgroup-test-work-dir<pid>, leaving the sibling cgroup
directories and their associated kernel cgroup, blkcg, and cgroup storage
allocated after the test finishes. Should these relative cgroup paths be
"/iocost_pairing" and "/iocost_ms"?

[ ... ]

> +	err =3D iocost_ms__load(skel);
> +	if (!ASSERT_OK(err, "skel_load")) {
> +		cleanup_cgroup_environment();
> +		iocost_ms__destroy(skel);
> +		nullb_remove(IOCOST_NULLB);
> +		return;
> +	}
> +
> +	err =3D iocost_ms__attach(skel);
> +	if (ASSERT_OK(err, "attach")) {
> +		err =3D readback_model(dev, model, sizeof(model));
> +		if (ASSERT_OK(err, "readback"))
> +			ASSERT_STREQ(model, "bpf", "model_bpf");
> +
> +		/*
> +		 * drive IO through the model: enable the controller, price
> +		 * from a cgroup, and check the model actually charged them
> +		 */
> +		cg =3D cgroup_setup_and_join("iocost_ms");
> +		if (!ASSERT_GE(cg, 0, "setup_cg_ms")) {
> +			iocost_ms__destroy(skel);
> +			nullb_remove(IOCOST_NULLB);
> +			cleanup_cgroup_environment();
> +			return;
> +		}

[ ... ]

> +	}
> +
> +	iocost_ms__destroy(skel);
> +	nullb_remove(IOCOST_NULLB);
> +	cleanup_cgroup_environment();
> +}

[Severity: Low]
In serial_test_iocost_model_streams(), cgroup_setup_and_join() is only call=
ed
inside the if (ASSERT_OK(err, "attach")) block, and it already calls
cleanup_cgroup_environment() internally if it fails.

If iocost_ms__load() fails, if iocost_ms__attach() fails, or if
cgroup_setup_and_join() fails, won't calling cleanup_cgroup_environment() in
those paths attempt to clean up an uninitialized or already-cleaned cgroup
environment and log spurious errors for /mnt/cgroup.procs?

[1] https://lore.kernel.org/r/20261028143534.135968-4-cui.tao@linux.dev
[2] https://lore.kernel.org/r/b69d96a507aec382c279d62cfb038fa9@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103132613.1952=
975-1-cui.tao@linux.dev?part=3D3
