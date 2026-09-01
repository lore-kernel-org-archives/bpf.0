Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C9337EFEE
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 06:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244859; cv=none; b=QAyQfrYsM3LJsl6B+n/kseBU2p+xWsoTVJGJv/yANanVJ/ZrbZC2WjMhNMOMb/phiWrBkTj8lz8aQeD7j2qHplcy3UcToIqwD3aWmniG/TFw8Y31Ck6roN2t5WCWrsV8++AK5J9swN0z9gA9XueRlCMi6VBmVPMQjhirU8G03cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244859; c=relaxed/simple;
	bh=4azCMJcGhwf+MU5yqrV0TiAlfNHW9CgGoakxv6VVNJo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M9g4cHohi2LmjcG3iYRvYM6qxJGcopjQlCG5LA6ObbXZ90b7vdiWoSR5GzRnmV0IQFg9MOqaXphhUaZbOs2GqvaIbBZ6UYZeRb7RChCtyUEQwdpwPZ+3ph3xaRhcgWv0TIWfgasfvfwWj3FfjoqaYsWdC8/kaKuDqv6sOw3ojwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWq/qy4z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWq/qy4z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195EC1F000E9;
	Tue,  1 Sep 2026 06:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788244857;
	bh=zXUyQWrFalPi9ERREoD5YQITZi5/ClPSw0HfERorGnk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SWq/qy4zFPpi18Obc5di8Xt3Kqb+ptSNALp5bAMbDjw/Wa6zvpqbIsVr5LgLcEdHo
	 VupEOn9mcP8TFAhqdg9JV6VfBrHEH6fuV4c80PTA/WIUSWty8NGEPa7f5iPkrv1tJ2
	 84fRLkWZGHZmSqW1YPB4K76pCD0Ue5ysC/KTu9c3CjAMMhzAzmc7XyFOkSSr/kHgyB
	 2aeOLgD7KQL+HB0BVpmGaO/BiJqVq7/xzYkn7nReS6icuSUiV9+iHumH20sT28XCOK
	 O5XocIotCGnvPxAcNBO+LWpyHcWaYMzAPV9YnK8nCedBJKP5pCbK9/NYocEfKMjXVc
	 Zk1WyzpEDk7Fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 3/4] selftests/bpf: Test rhtab kptr recycle
 from NMI context
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260901062845.1379760-4-chenyuan_fl@163.com>
References: <0560a24d-2cf9-4e5b-aa61-580af1e56de1@gmail.com>
 <20260901062845.1379760-1-chenyuan_fl@163.com>
 <20260901062845.1379760-4-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 06:40:56 +0000
Message-Id: <20260901064057.195EC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] Double close of `pmu_fd` in the success path.
- [Low] Missing FD validation for manually looked up BPF program.
- [Low] Multi-line comments do not follow the mandatory BPF subsystem style.
- [Low] Calling test__skip() marks the entire test as skipped, but executio=
n continues to the recycle phase, masking its success on systems without a =
PMU.
--

commit 2b5822e0c1417c4403ffbea06426d15e411775a3
Author: Yuan Chen <chenyuan@kylinos.cn>

selftests/bpf: Test rhtab kptr recycle from NMI context

A perf_event program running in NMI context overwrites a rhtab element whose
value holds a referenced task kptr to verify it stays attached on recycle. A
second phase deletes and re-inserts the element 2000 times, requiring at
least one recycle to inherit the kptr. The NMI phase is skipped when no
hardware PMU is available.

> diff --git a/tools/testing/selftests/bpf/prog_tests/rhtab_kptr.c b/tools/=
testing/selftests/bpf/prog_tests/rhtab_kptr.c
> index 0000000000000..4bdcc9ce5500f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/rhtab_kptr.c
[ ... ]
> +/* Userspace mirror of the BPF-side struct val_t (progs/rhtab_kptr.c). T=
he
> + * update syscall copies map->value_size bytes from the buffer, so it mu=
st
> + * be at least that large; special fields are skipped by the value copy =
but
> + * the kernel still reads the full value_size from userspace.
> + */
> +struct val_t_user {

[Severity: Low]
This isn't a bug, but does this comment violate the BPF subsystem multi-line
comment style? The guidelines mandate that multi-line comments must have the
opening /* on its own line, with text starting on the subsequent line.

[ ... ]
> +/* Run @name via BPF_PROG_TEST_RUN, asserting both the syscall status and
> + * that the program exited 0. Returns 0 on success.
> + */
> +static int run_prog_ok(struct rhtab_kptr *skel, const char *name)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	struct bpf_program *prog;
> +	int err;
> +
> +	prog =3D bpf_object__find_program_by_name(skel->obj, name);
> +	if (!ASSERT_OK_PTR(prog, name))
> +		return -1;
> +	err =3D bpf_prog_test_run_opts(bpf_program__fd(prog), &topts);

[Severity: Low]
Is it safe to use the file descriptor returned by bpf_program__fd() here
without checking it?

The BPF Skeleton API guidelines require that file descriptors returned by
bpf_program__fd() when using manual lookup APIs like
bpf_object__find_program_by_name() must be validated (e.g., using ASSERT_GE)
before use.

[ ... ]
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
> +		 * actually ran before probing (otherwise the probe would pass
> +		 * vacuously even on an unfixed kernel).
> +		 */

[Severity: Low]
This isn't a bug, but there's another instance of the multi-line comment
style violation here.

> +		for (i =3D 0; i < 20 && read_counter(skel, 1) =3D=3D 0; i++)
> +			usleep(100000);
> +		ASSERT_GT(read_counter(skel, 1), 0, "nmi_update_ran");
> +
> +		bpf_link__destroy(skel->links.nmi_update);
> +		skel->links.nmi_update =3D NULL;
> +		close(pmu_fd);

[Severity: Medium]
Will this result in a double close of pmu_fd?

When bpf_link__destroy() is called on this link, it invokes
bpf_link_perf_detach(), which internally closes the pmu_fd. Calling
close(pmu_fd) immediately after could inadvertently close an unrelated file
descriptor opened by a concurrent test thread.

[ ... ]
> +		ASSERT_EQ(read_counter(skel, 2), 1, "xchg_non_null");
> +		ASSERT_EQ(read_counter(skel, 3), 0, "xchg_null");
> +	} else {
> +		test__skip();
> +	}

[Severity: Low]
When test__skip() is called here, execution continues to the recycle phase
below rather than returning early. Could this hide the success of the recyc=
le
phase under a SKIPPED test status on systems without a PMU?

> +
> +	/*
> +	 * Now exercise the delete/re-insert recycle path. The delete only
> +	 * cancels NMI-safe fields, so the freed element still owns the kptr.
[ ... ]
> +		if (run_prog_ok(skel, "init_elem") !=3D 0) {
> +			/* init_elem fails only if the element is missing,
> +			 * which must not happen in this single-threaded
> +			 * loop; count it so a rhtab bug cannot be absorbed
> +			 * silently.
> +			 */

[Severity: Low]
This isn't a bug, but this comment also violates the BPF subsystem multi-li=
ne
comment style.

> +			retries++;
[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/rhtab_kptr.c b/tools/testi=
ng/selftests/bpf/progs/rhtab_kptr.c
> index 0000000000000..c96cf7f2d799b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/rhtab_kptr.c
[ ... ]
> +/* 0: init ok, 1: nmi update ok, 2: probe xchg non-NULL, 3: probe xchg N=
ULL,
> + * 4: probe saw expected magic value
> + */
> +static __always_inline void bump(u32 idx)

[Severity: Low]
This isn't a bug, but this comment also violates the BPF subsystem multi-li=
ne
comment style.

[ ... ]
> +SEC("syscall")
> +int del_elem(void *ctx)
> +{
> +	u32 key =3D 0;
> +
> +	if (bpf_map_delete_elem(&rhtab, &key))
> +		return 1;
> +	/* The element must really be gone: otherwise the following upd_elem()
> +	 * is an in-place update on the surviving element and the kptr that
> +	 * probe_elem() observes never went through a recycle.
> +	 */

[Severity: Low]
This isn't a bug, but this comment also violates the BPF subsystem multi-li=
ne
comment style.

> +	if (bpf_map_lookup_elem(&rhtab, &key))
> +		return 2;
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901062845.1379=
760-1-chenyuan_fl@163.com?part=3D3
