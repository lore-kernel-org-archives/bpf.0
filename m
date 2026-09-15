Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBEB3BE645
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 12:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475905; cv=none; b=D+dw9u7FhvEU+P1AOTOF+sxKXlf4xcHEEQisJCZi5zN7jKeeQMzTHkV1XpxxqoPRbA1P61rqu1Xxmh4xwml7wmQw5Eofna9aB62fpqUFciAH6YLUPiEY8uEqe9Xi9NAzds9bJdb5Dya2c2Nrs57RGRZosyyV3WhsUVLVCVnuGns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475905; c=relaxed/simple;
	bh=llf2vURYdbNN5dguVWEMKEctwKuc9Lw3r2hTPUN99SA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DXCSey61M+6g8nut0AjW34F1Mi2m2OmiKFPDrnfLoZPG1kZ03JRAdM5wgPc8Q7s1JJ8lqHtDVsqOu0jIJHwCbfe5ebGIYuLUjFaLcrSqG1FRq8Qddlvd3+0B0KW1Lsu8Z9ZiIBn9NkbToIMlWk4jjGFI30S8XuF2VF4ej8vwLcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LunbPXYL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LunbPXYL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE431F000FF;
	Tue, 15 Sep 2026 12:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789475903;
	bh=fB24mJEPK7c0+gGLUk1T7cGxfwfbXzhUZ2uNHpG4qQ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LunbPXYLuK4kfcAavDmDubx+T3bdW+BfyiTq479uGvuJvD62/B53h9ar0yuSc27MK
	 n3j6AGyATzVYd+oI0VWaYvoDA10XBAbxORNirycvDDPiRf1mxgO8xHhuLkq4MjS84L
	 VQjWVvKG32Dcm7OMk6c5JYIa4B1hd2JxnamEwa5gYY4nDDutDTA45cdySXbUfHQubH
	 BmAVu0cnTfdqDqi+xy+4jQ1uSA7BfxgfQAV4sYZ1b0XkWnsHT3Ho4S9fy78OOZMdHF
	 5quanyiAUavI+Ih3Bv4L10xhdy8TjMaQ10KfKsOQ5hmgzZGzqz4eehkVnykSK8goPT
	 BIy0jLEH0GumA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v11 2/2] selftests/bpf: Add memcg async reclaim
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <93289af4317b57caa4e393d73fe6c786b24a4c2a.1789475073.git.zhuhui@kylinos.cn>
References: <cover.1789475073.git.zhuhui@kylinos.cn>
 <93289af4317b57caa4e393d73fe6c786b24a4c2a.1789475073.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:38:22 +0000
Message-Id: <20260915123823.BFE431F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: TOCTOU race condition in temporary file handling
--

commit 06564da4fc281d602c319554603ab58e4dd5a9b8
Author: Hui Zhu <zhuhui@kylinos.cn>

selftests/bpf: Add memcg async reclaim test

This commit adds a test for BPF-driven async proactive reclaim where a BPF=
=20
program watches refault stats of a memory-pressured cgroup. It also adds a=
=20
second test to verify that a dying target cgroup is properly skipped during=
=20
reclaim.

> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c=
 b/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
> new file mode 100644
> index 0000000000000..7c7d299b3b28a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
[ ... ]
> +static int write_file(const char *filename)
> +{
> +	int ret =3D -1;
> +	size_t written =3D 0;
> +	char *buffer;
> +	FILE *fp;
> +
> +	fp =3D fopen(filename, "wb");

[Severity: Medium]
Could opening the file by name with "wb" follow a symlink? If an attacker
replaces the file in the window after mkstemp() closes its file descriptor,
and this test runs with root privileges in an accessible directory, it looks
like it could lead to an arbitrary file overwrite.

> +	if (!fp)
> +		goto out;
> +
> +	buffer =3D malloc(BUFFER_SIZE);
[ ... ]
> +static int
> +run_high_low_workload(double *high_elapsed, double *low_elapsed, int rea=
d_times)
> +{
> +	char high_data_file[PATH_MAX];
> +	char low_data_file[PATH_MAX];
> +	char high_time_file[PATH_MAX];
> +	char low_time_file[PATH_MAX];
> +	const char *dir =3D workload_files_dir();
> +	pid_t high_pid =3D -1, low_pid =3D -1;
> +	pid_t wait_ret;
> +	int fd, status;
> +	int ret =3D -1;
> +
> +	snprintf(high_data_file, sizeof(high_data_file),
> +		 "%s/memcg_async_high_data_XXXXXX", dir);
> +	snprintf(low_data_file, sizeof(low_data_file),
> +		 "%s/memcg_async_low_data_XXXXXX", dir);
> +	snprintf(high_time_file, sizeof(high_time_file),
> +		 "%s/memcg_async_high_time_XXXXXX", dir);
> +	snprintf(low_time_file, sizeof(low_time_file),
> +		 "%s/memcg_async_low_time_XXXXXX", dir);
> +
> +	fd =3D mkstemp(high_data_file);
> +	if (!ASSERT_GE(fd, 0, "mkstemp"))
> +		goto cleanup;
> +	close(fd);

[Severity: Medium]
Does immediately closing the file descriptor from mkstemp() leave the filen=
ame
vulnerable to a symlink replacement attack? It seems the file is created
securely, but the binding is lost.

> +
> +	fd =3D mkstemp(low_data_file);
> +	if (!ASSERT_GE(fd, 0, "mkstemp"))
> +		goto cleanup;
> +	close(fd);
[ ... ]
> +void test_memcg_async_reclaim_dying(void)
> +{
> +	u64 trigger_cgroup_id, target_cgroup_id;
> +	u64 calls_before, bytes_before;
> +	char data_file[PATH_MAX] =3D "";
> +	struct reclaim_events_seen seen =3D {};
> +	struct memcg_async_reclaim *skel =3D NULL;
> +	struct ring_buffer *rb =3D NULL;
> +	pid_t reader_pid =3D -1;
> +	int err, fd, i;
> +
> +	err =3D setup_dying_cgroups(&trigger_cgroup_id, &target_cgroup_id);
> +	if (!ASSERT_OK(err, "setup_dying_cgroups"))
> +		return;
> +
> +	err =3D setup_bpf(trigger_cgroup_id, target_cgroup_id, &skel);
> +	if (!ASSERT_OK(err, "setup_bpf"))
> +		goto out;
> +
> +	rb =3D ring_buffer__new(bpf_map__fd(skel->maps.reclaim_events),
> +			      on_reclaim_event, &seen, NULL);
> +	if (!ASSERT_OK_PTR(rb, "ring_buffer__new"))
> +		goto out;
> +
> +	snprintf(data_file, sizeof(data_file),
> +		 "%s/memcg_async_dying_XXXXXX", workload_files_dir());
> +	fd =3D mkstemp(data_file);
> +	if (!ASSERT_GE(fd, 0, "mkstemp"))
> +		goto out;
> +	close(fd);

[Severity: Medium]
Like the instance above, does closing this file descriptor create a TOCTOU
race window before the keepalive reader opens and writes to it?

> +
> +	reader_pid =3D spawn_keepalive_reader(data_file);
> +	if (!ASSERT_GT(reader_pid, 0, "fork keepalive reader"))
> +		goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789475073.gi=
t.zhuhui@kylinos.cn?part=3D2
