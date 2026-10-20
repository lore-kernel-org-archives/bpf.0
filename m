Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505838;
	b=i4zDihDVFTlCfTjeHhN+8qldhYCyllWvNwbgrL0fXJHNrP2hDuMnmU6yjehtIgzL3/TR
	 5fx2s8HdCZB2MZJiy1TlKnMwZwNXg2QqCgLXQJ7UR4Q/mi47bJt8KFuymlL/5Kk2BHxRF
	 CUh4h64phfqkub3SYGia/RT106hELAem2SAbU+kJa1H8jhogFdiNzWBy0ckhU79uqGgct
	 zE6lYoFWCzB6NjtCDp0cqHkikD1G2JoBlalRdos7iN1fEgK7UKOmYNUzs0C5fNvgSByFc
	 BR5HCH9YAVMU+gytt39RR9Q2+8dIQiJKT/Ggv0Lr5Oi/4F8lZba9EENLVzT0jE/h2Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505838;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=0boloPQ39hIjmi7oYpL3vbRuNspjkXMV1QcRUTOY9KY=;
	b=FKdJp0gr3lBL0KophQki6Oni2tv/y8y/yhBYh8jzZ015neooHtzyl2cEFkWTvD9ztq+T
	 p52PkjTTzZShbk3E/vkyvNqL3FBrOjHqHgUwoYev7j0Y6aktKo77NCwx0xpdOq2NjhUDy
	 YmwUaP3hCRyixj88kdnTX0kmLu7fG4/960VuPsy47cZ5fBpivMZX4wgN2MAI85CDz7wKc
	 6fjt4gY5DLaMX2DEbvdU1rVPzf1XidBiZfGg5f4l7U0PrA3uGqtS76WRl0vtzoUYS+Mzh
	 HrYwpmIIScojpJ8X3PGJQ4oY8TTWCtvubOL/BR9VNqkzseMf6cEqadCD4Sn799ox76g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oFmHTbdV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AF0606C235;
	Tue, 20 Oct 2026 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oFmHTbdV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E191F000C4;
	Tue, 20 Oct 2026 14:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792505837;
	bh=0boloPQ39hIjmi7oYpL3vbRuNspjkXMV1QcRUTOY9KY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=oFmHTbdVaIZyDMV2+MXK93b0xcpiCMIArymKGSs5HODPzEjkCmK1QTVs1FBDygftt
	 rCwLauNqlCg0qH1xatW6cJBAfHIKe9N4dzHZLyki5HbIlX4kfQVNpEFYVkq512igXh
	 YvtB+7G9JD2pWDCoYDvO22KHzv10jBaJs5KExTn65Jxdp+RIrRC9iTZG4FN7ux1zUn
	 /KfihV7VLxNQCQXE+PtG+SC5faNWi6ZmccD1g6bFr9co2S3oxYoQot5AZKhx0bnFNv
	 yZP7cbDUobRqBjEkT6O4Lk9W3hplK/MG+/c0k0vMIMyBAvoDOWRmSWO+gcN2tvUanK
	 7QLzYCAwhDNCA==
Content-Type: multipart/mixed; boundary="===============8750485772685352005=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <382819e642302a560c3a9caa157a604c0711828de9ecde51ef490d7cf2f34a3d@mail.kernel.org>
In-Reply-To: <09a19ff6dfc65af56dca0ec5cee051766470f36a.1792503001.git.xukuohai@huawei.com>
References: <09a19ff6dfc65af56dca0ec5cee051766470f36a.1792503001.git.xukuohai@huawei.com>
Subject: Re: [PATCH bpf-next 02/16] libbpf: Create arena percpu chunk from the arena percpu ELF section
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,emil@etsalapatis.com,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 14:17:17 +0000 (UTC)

--===============8750485772685352005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Create arena percpu chunk from the arena percpu ELF section

TL;DR: Reading the possible-CPUs sysfs file at open time may make
bpf_object_open() fail, breaking 'bpftool gen skeleton' in sandboxes without
/sys; suggests computing nr_chunks lazily in relocate.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -3267,6 +3274,41 @@ static int bpf_object__init_arena_data(struct bpf_object *obj)
>  	return 0;
>  }
>
> +static int init_arena_percpu_data(struct bpf_object *obj, void *percpu_data, size_t percpu_sz)
> +{
> +	static const char *fcpu = "/sys/devices/system/cpu/possible";
> +	bool *mask = NULL;
> +	int possible_cpus;
> +	int err;
> +
> +	if (percpu_sz == 0) {
> +		pr_warn("arena percpu: empty %s section\n", ARENA_PERCPU_SEC);
> +		return -EINVAL;
> +	}
> +
> +	err = parse_cpu_mask_file(fcpu, &mask, &possible_cpus);
> +	if (err) {
> +		pr_warn("arena percpu: failed to get possible cpus: %s\n",
> +			errstr(err));
> +		return err;
> +	}

Can this make bpf_object_open() fail on hosts where
/sys/devices/system/cpu/possible cannot be read?

init_arena_percpu_data() is reached from bpf_object__init_user_btf_maps()
during bpf_object_open(), so opening any object with a .arena.percpu section
now reads this sysfs file.  Until now libbpf only needed the possible CPU
count at load or runtime, through map_set_def_max_entries(), the per-cpu
value size checks and perf_buffer setup.

The value computed here, obj->arena_percpu.nr_chunks, is first used in
bpf_object__relocate(), which runs from bpf_object_prepare():

> +		size_t percpu_sz = obj->arena_percpu.nr_chunks * obj->arena_percpu.chunk_sz;

Open-only consumers such as 'bpftool gen skeleton' and 'bpftool gen
subskeleton' call bpf_object__open_mem() and never load, so they now depend
on the build host's sysfs.  In a build chroot or sandbox without /sys, open
fails with "arena percpu: failed to get possible cpus" and skeleton
generation breaks, even though the CPU count is never used there.

With 'gen skeleton -L', open fails with this error before the intended
-EOPNOTSUPP check in bpf_object__relocate() is reached:

> +		if (obj->gen_loader && obj->arena_percpu.present) {
> +			pr_warn("map '%s': light skeletons don't support arena percpu variables\n",
> +				arena_map->name);
> +			return -EOPNOTSUPP;
> +		}

Would it work to allocate and copy the chunk at open time, and compute
nr_chunks lazily in bpf_object__relocate(), where it is first needed?  No
later commit in the series changes this.

> +
> +	obj->arena_percpu.chunk_sz = roundup(percpu_sz, sysconf(_SC_PAGE_SIZE));
> +	obj->arena_percpu.chunk = calloc(1, obj->arena_percpu.chunk_sz); /* zero padding */
> +	if (!obj->arena_percpu.chunk) {
> +		free(mask);
> +		return -ENOMEM;
> +	}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39434884362
--===============8750485772685352005==--
