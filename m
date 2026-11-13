Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594262;
	b=yqTO+GO6F8PeiDbfHWh4RSwgpURR0ryhL+xDh9MZ6eVYbEEty38sJr5oATIrcesqhdEu
	 efslIeMFaeLjct2IMzSo4iENPECra6UZ6ott4EMkVFk/OTAor2HXJk9k7CzL/kA197R9w
	 4NjLL2Lhpx/GYpae+gZtVLAZ8+qcsGBxK319qg4M8mWwrOTOA6aptHthi+nhKQq6YWkoK
	 FY5XOmnI6myKQcskArONnU0cIGuYvghQ9lPFGwafIv+OD/2qzzYz1F9kxvEgMilZbiS2G
	 HnL3hgkbWvKAwUznzXTr4hy2KShMu7EoVhulFYQdsV9k4ks82lnIMvUZp+luOhNzBeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594262;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1pyNJO921Vu42tK8vaReNYdiW18XzlYnhxoS+KfCHz0=;
	b=k8IoqxE5OW42qywmHXcIz/gqHjn7gBCyXfNiuuXaeQCGNaD68yRmwiFM6qANn9VehVn3
	 vuZlAxjMB6HUxoZAvQBApX+XmsLqj9Kl6VHPt/jI1aKfQFLLXGtc16JEDJfLwTsDUY0TQ
	 1bzrCjr14tPt2dnUb5UDPPaKR6+QNTbafVFUMsWAc+iq3rUHjFIoVALGC1QbEb+1iDtgZ
	 dKjYQl/yz6wyn3RwO9uEOlz+/D/WjdS7t/y3CfaVdOUtI4tqPYb52DxFrx15ZgT4mhiDY
	 AklgHVnertLkSF/Rf9b3PstxpHeDFG0bOWaX0ORjw4RB55AAbVPXh+A8yn2Py55kbFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iA4Oh43q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF4D606A32E
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 18:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iA4Oh43q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390CA1F000C4;
	Fri, 13 Nov 2026 18:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794594262;
	bh=1pyNJO921Vu42tK8vaReNYdiW18XzlYnhxoS+KfCHz0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=iA4Oh43q5ujHH9vBWawW8QhD7BsXYkO6AUNt//1GaPa1bqMxM/6Cu1EhM7c+S3ze8
	 jTyLGpNUbwMML9tkw1rWcg4Ng/boOAAkVWvx2pp2y6xUDCxDJgnDMa0BbZes6EIra2
	 CngL5fQqnkwbFwTJ2rtCZ2oXFMd+1B7mxuTNl+j23bH6y/YCzemCNU2CYNgwDRCu14
	 lA8bvg78IwNK60B1XYLv2/zXql0KamgbH/Qc3XZgYYR46w8CQjPFvKr46OE/H8kBQF
	 fjYXJFh2ube/1E+JZSVpveEtQajBoJPN1XYSFI8g+0yi1pp2jA2jH/ryTqpoS1ZHBV
	 U99qLs4B/EXwg==
Message-ID: <sashiko-outbox-213403@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Skip memcg_proactive_reclaim
 when data lands in shmem
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kurt Lin" <lylin1023@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261113180159.602033-1-lylin1023@gmail.com>
References: <20261113180159.602033-1-lylin1023@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 18:24:21 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] selftests/bpf: workload_dir() never falls back to . when /tmp is
  overlayfs
- [Low] selftests/bpf: unflushed per-CPU memcg stats read in
  charged_as_shmem()
--

commit e2cf55e88beac1906e9ded044c8e29f6b8bf9980
Author: Kurt Lin <lylin1023@gmail.com>

selftests/bpf: Skip memcg_proactive_reclaim when data lands in shmem

This commit skips the memcg_proactive_reclaim selftest when memory.stat
shows that the test file's pages were charged as shmem, such as when /tmp
is an overlayfs backed by tmpfs.

> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_proactive_recla=
im.c b/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c
> index c22dcfabe856e..c035506760416 100644
> --- a/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c
> @@ -46,6 +46,28 @@ static const char *workload_dir(void)
>  	return NULL;
>  }
> =20
> +/*
> + * statfs() only sees the top of a stacking filesystem. When /tmp is an
> + * overlayfs whose upper layer lives on tmpfs, as in virtme-ng guests, t=
he
> + * check above passes but the written data still ends up as shmem. Ask t=
he
> + * cgroup how the pages were actually charged.
> + */
> +static bool charged_as_shmem(void)
> +{
> +	static char buf[8192];
> +	unsigned long long shmem;
> +	char *p;
> +
> +	if (read_cgroup_file(CG_PATH, "memory.stat", buf, sizeof(buf)))
> +		return false;
> +
> +	p =3D strstr(buf, "\nshmem ");
> +	if (!p || sscanf(p, "\nshmem %llu", &shmem) !=3D 1)
> +		return false;
> +
> +	return shmem >=3D FILE_SIZE / 2;
> +}

[Severity: Low]
Can charged_as_shmem() read 0 for shmem when per-CPU memcg stats have not
been flushed yet?

Reading memory.stat calls __mem_cgroup_flush_stats(memcg, false), which ski=
ps
the rstat flush unless pending updates exceed MEMCG_CHARGE_BATCH *
num_online_cpus():

mm/memcontrol.c:memcg_vmstats_needs_flush() {
	return atomic_long_read(&vmstats->stats_updates) >
		MEMCG_CHARGE_BATCH * num_online_cpus();
}

On a 64K-page kernel with 24 or more online CPUs (or a 4K-page kernel with
384 or more CPUs), writing 32 MiB of shmem does not cross that threshold, so
charged_as_shmem() sees shmem as 0 and fails to skip the test.  Retrying
until the "file " counter in memory.stat reaches at least FILE_SIZE / 2
(across the 2s periodic flusher window, as in cgroup_iter_memcg.c) would
ensure the stats are flushed before checking shmem.

>  void test_memcg_proactive_reclaim(void)
>  {
>  	struct memcg_proactive_reclaim *skel =3D NULL;
> @@ -99,6 +121,12 @@ void test_memcg_proactive_reclaim(void)
>  	if (!ASSERT_OK(fsync(data_fd), "fsync"))
>  		goto out;
> =20
> +	if (charged_as_shmem()) {
> +		printf("%s:SKIP: %s is backed by shmem\n", __func__, dir);
> +		test__skip();
> +		goto out;
> +	}

[Severity: Low]
Does jumping straight to out here prevent falling back to "." when /tmp is
overlayfs over tmpfs?

workload_dir() checks dirs[] =3D { "/tmp", "." } so the test can use the
current working directory when /tmp is on tmpfs.  When /tmp is an overlayfs
over tmpfs, statfs("/tmp", &st) sees OVERLAYFS_SUPER_MAGIC and returns
"/tmp" on the first iteration, and this check then skips the whole test
without ever trying "." even if test_progs is running from a writable
disk-backed directory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113180159.6020=
33-1-lylin1023@gmail.com?part=3D1
