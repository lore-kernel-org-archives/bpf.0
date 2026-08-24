Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA2043F4BD
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585329; cv=none; b=ouMwQ7TmXgjjmDYAgMmubBDaFSXO2QfqtYi9fmy4PnTA+pQUfrjeXEhqJha9gDHMl/SVvUmWTOtHQXg8Uur9s4gq3EWusxuBV3ukptpl9V6HyBBaVgWMHiEkixTgmqrwX4gnGnB0WWpDh+96HVrwIDrESXI8x67IN8TfqXs/5Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585329; c=relaxed/simple;
	bh=HZA/AjISZ1q7luIeEvWMMaCO240uQNgGCKd70tgKhmI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fNaWW/lEVEq0Ge+ShqxHNV7MZe5XsgjUgX0gkgnoEAW5hP0fCf0AVLZh0UmfdJofLQPJ95RRzD+51NGBsRxpNhNA1SJiiaXofx/eSw+ro/yHL7N0tV7nK52TbXMnQ7DzYp7y1lIEqb0zWTJd5oyicKYyK1gi6qBt2YLcF7ScPWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTwBjQ3E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTwBjQ3E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301C51F00A3D;
	Mon, 24 Aug 2026 15:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787585322;
	bh=irthaFuMjSRHCfK4X/ylSlqch/10VLbWDurcU9gEY/8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UTwBjQ3EvEsCHwSpv/64VducD8O4bViqdPq34uvnuYXAbnca4RICF/0EMo1APAK9b
	 9iBBDP7MHov7QpLjDZa1yvSqi8VknXZmNojKrnXZcywD1eeqJZ1dLGt4KvR176Afle
	 3VO2+I0Cb7ZmqA4Mg/tErErhecCXEJ5xSwv9yDaNWQjfhQcA6E6ONqpkrOgF+DfwLH
	 mlP9fJkTSZknqgW+o43M/2n04EApKoOk+XcrQaG5zBZ+oaye7yVQ9+3KG4hIqORsAG
	 XzNLLkO6q2ExJ0nrGnibLeka5afl19WmVK+FzkZMVkfbOScLGTAq7advvMNLs/50mC
	 +LP+lifdGpc9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] selftests/bpf: Test rhtab kptr recycle from NMI
 context
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260824143621.2098856-4-chenyuan_fl@163.com>
References: <DKM6K95EN9OF.3O9XNYWVLYHDE@gmail.com>
 <20260824143621.2098856-1-chenyuan_fl@163.com>
 <20260824143621.2098856-4-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 15:28:41 +0000
Message-Id: <20260824152842.301C51F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Userspace stack out-of-bounds read in `bpf_map_update_elem()` du=
e to mismatched value size.
- [Medium] Double close of the perf_event file descriptor (pmu_fd).
- [Low] Multi-line comments do not follow the mandatory BPF subsystem comme=
nt style.
--

--- Patch [3]: [PATCH 3/4] selftests/bpf: Test rhtab kptr recycle from NMI =
context ---
commit ce5b7999a24e0290b526f254441d70dcbf59a6cf
Author: Yuan Chen <chenyuan@kylinos.cn>

selftests/bpf: Test rhtab kptr recycle from NMI context

This patch introduces a test to verify that the rhtab update and delete
recycle paths do not eagerly destroy referenced kptrs from NMI context.

> diff --git a/tools/testing/selftests/bpf/prog_tests/rhtab_kptr.c b/tools/=
testing/selftests/bpf/prog_tests/rhtab_kptr.c
> index 0000000000000..13158d74cbc1b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/rhtab_kptr.c

[ ... ]

> +void test_rhtab_kptr(void)
> +{
> +	struct perf_event_attr attr =3D {
> +		.type =3D PERF_TYPE_HARDWARE,
> +		.config =3D PERF_COUNT_HW_CPU_CYCLES,
> +		.freq =3D 1,
> +		.sample_freq =3D read_perf_max_sample_freq(),
> +		.size =3D sizeof(struct perf_event_attr),
> +	};
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	struct rhtab_kptr *skel;
> +	__u32 key =3D 0;
> +	__u64 zero =3D 0;
> +	__u64 nonnull_before;
> +	int pmu_fd, i, err;
> +
> +	skel =3D rhtab_kptr__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +
> +	/* Create the element and stash a referenced task kptr in it. */
> +	if (!ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.rhtab),
> +					   &key, &zero, BPF_ANY), "create_elem"))

[Severity: Medium]
Does this code cause an out-of-bounds stack read?

The rhtab map expects a value of type struct val_t, which is 16 bytes in si=
ze
on 64-bit systems (an 8-byte pointer plus a 4-byte u32 and padding).

However, zero is defined as an 8-byte __u64 local variable. When
bpf_map_update_elem() copies 16 bytes from this address, it will read 8 byt=
es
of uninitialized or unrelated stack memory adjacent to zero.

> +		goto out;
> +	if (!ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.init_=
elem),
> +					      &topts), "test_run_init") ||
> +	    !ASSERT_EQ(topts.retval, 0, "init_ret"))
> +		goto out;
> +
> +	pmu_fd =3D syscall(__NR_perf_event_open, &attr, -1, 0, -1, 0);
> +	if (pmu_fd >=3D 0) {
> +		skel->links.nmi_update =3D bpf_program__attach_perf_event(skel->progs.=
nmi_update,
> +									pmu_fd);
> +		if (!ASSERT_OK_PTR(skel->links.nmi_update, "attach_perf_event")) {
> +			close(pmu_fd);
> +			goto out;
> +		}
> +
> +		/* Let the NMI handler overwrite the element, and make sure it

[Severity: Low]
This isn't a bug, but does this comment violate the BPF subsystem multi-line
comment style?

The BPF subsystem requires multi-line comments to have the opening /* on its
own line.

> +		 * actually ran before probing (otherwise the probe would pass
> +		 * vacuously even on an unfixed kernel).
> +		 */
> +		for (i =3D 0; i < 20 && read_counter(skel, 1) =3D=3D 0; i++)
> +			usleep(100000);
> +		ASSERT_GT(read_counter(skel, 1), 0, "nmi_update_ran");
> +
> +		bpf_link__destroy(skel->links.nmi_update);
> +		skel->links.nmi_update =3D NULL;
> +		close(pmu_fd);

[Severity: Medium]
Does this result in a double close of pmu_fd?

The function bpf_program__attach_perf_event() takes ownership of the passed
perf_event file descriptor upon successful attachment. When bpf_link__destr=
oy()
is called, it automatically closes the file descriptor.

Calling close(pmu_fd) here explicitly could accidentally close an unrelated=
 file
descriptor opened by another thread.

> +
> +		/*
> +		 * The old kptr must still be attached to the element: the

[ ... ]

> +	for (i =3D 0; i < 2000; i++) {
> +		topts.retval =3D 0;
> +		err =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.init_elem),
> +					     &topts);
> +		if (err || topts.retval) {
> +			/* Element may be gone; recreate and retry once. */
> +			if (!ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.rhtab),
> +							   &key, &zero, BPF_ANY),

[Severity: Medium]
Can this also cause an out-of-bounds stack read?

This is the same issue as above where zero is 8 bytes but the map expects
16 bytes.

> +				       "recreate_elem"))
> +				goto out;

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/rhtab_kptr.c b/tools/testi=
ng/selftests/bpf/progs/rhtab_kptr.c
> index 0000000000000..fd6bd63cb405e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/rhtab_kptr.c

[ ... ]

> +struct {
> +	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> +	__uint(max_entries, 5);
> +	__type(key, __u32);
> +	__type(value, __u64);
> +} counters SEC(".maps");
> +
> +/* 0: init ok, 1: nmi update ok, 2: probe xchg non-NULL, 3: probe xchg N=
ULL,

[Severity: Low]
This isn't a bug, but should the opening /* be on its own line to match the=
 BPF
subsystem multi-line comment style?

> + * 4: probe saw expected magic value
> + */
> +static __always_inline void bump(u32 idx)
> +{

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824143621.2098=
856-1-chenyuan_fl@163.com?part=3D3
