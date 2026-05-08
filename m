Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27728173
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 00:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778198615; cv=none; b=fVT0EykokAhs/d1T/gkDbfCRrCoe24XIinSjJXu8qtf0CdvprifQ9p3s7C0eFXC0LVifwYRjOPrDStW8EAPR6CYIJu/ZVvruFse5JrLzEwhiJJotxnf9Zv1N/RbOdLZ3g4FwNs639aUuEmXv0FSi/V9Kk048GA/rF8PYSEijcDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778198615; c=relaxed/simple;
	bh=hX+IPtT5R5yinxByvi149ilUrpypuDQn5INIvhqATxI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kXsKEPVC9OLO3WEGsvq7z/tEeWnE0MNEs1Mh92WsH/g+DzhmFKDdYURdyjESOFTRGBJnTClKXLck2KULfgpsQ8Z/MBKf8o1Vj3UhSMEDdj0sx8qiSgwwwJzYG2cXcu+dpZ8vVmch5h8mf5qy9XRIhqhrPYlefIuwKUdQVw3NXek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njHHTFDl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njHHTFDl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BE8C2BCB2;
	Fri,  8 May 2026 00:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778198614;
	bh=hX+IPtT5R5yinxByvi149ilUrpypuDQn5INIvhqATxI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=njHHTFDloQfwcGj8dn9TlVloQ0Ej9IMHmUB5bDyEwfE6TS+6hl4oqJWM3OoTG25Q4
	 8I8wTm8cX4riwxBFntNB/5ThHn/CRd+jQB8eqD+moKk+bKJt3kjoSBwRDW8uvammY+
	 MCZbdcCsqKwRzzTOdnDLzCRgVLWLGklYU2yBL8WmaW7MIACftSjT9eYh1vm010895S
	 q0JDLLHqCT9c8G8paA6XC7jkoIX9N/VOme3mb0eXyNVEOQnZYns5PLnOhBJRnWq+sL
	 z6PG1wceNrMpgdxduwzPOTNzespiwH4qM06n9CeAMpD+RmA3cp7ktVdbMED4dqZyET
	 qT9IV4jjufheQ==
From: sashiko-bot@kernel.org
Subject: Re: [bpf-next v3 2/2] selftests/bpf: Add kptr destructor NMI
 exerciser
Reply-To: sashiko@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260507175453.1140400-3-utilityemal77@gmail.com>
References: <20260507175453.1140400-3-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 00:03:33 +0000
Message-Id: <20260508000334.A1BE8C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Failure to acquire the PMU file descriptor (e.g., due to EACCES =
permissions) causes the test to silently pass rather than fail or skip.
- [Medium] The test executes the `cleanup_kptrs` BPF program but fails to v=
erify if it encountered any internal errors.
- [Medium] Concurrent NMI handlers can cause double-increments of `kptr_dto=
r_nmi_deleted` and loop aborts due to a TOCTOU race on `slot_is_live`.
--

commit f53640a66945f8f1050d74f78ad482b51aeaf343
Author: Justin Suess <utilityemal77@gmail.com>

selftests/bpf: Add kptr destructor NMI exerciser

This patch adds a BPF selftest program that populates hash and array maps
with cpumask kptrs and clears them from the NMI handler. The test verifies
that the destructor is called on all objects queued for destruction in
hardirq from NMI.

> diff --git a/tools/testing/selftests/bpf/prog_tests/kptr_dtor_nmi.c b/too=
ls/testing/selftests/bpf/prog_tests/kptr_dtor_nmi.c
> new file mode 100644
> index 0000000000000..21452b3cf9eb8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/kptr_dtor_nmi.c
> @@ -0,0 +1,258 @@
[ ... ]
> +__maybe_unused
> +static int open_nmi_pmu_event_on_cpu(int cpu)
> +{
> +	struct perf_event_attr attr =3D {
> +		.size =3D sizeof(attr),
> +		.type =3D PERF_TYPE_HARDWARE,
> +		.config =3D PERF_COUNT_HW_CPU_CYCLES,
> +		.freq =3D 1,
> +		.sample_freq =3D 1000,
> +	};
> +	int pmu_fd;
> +
> +	pmu_fd =3D syscall(__NR_perf_event_open, &attr, -1, cpu, -1,
> +			 PERF_FLAG_FD_CLOEXEC);
> +	if (pmu_fd =3D=3D -1) {
> +		if (errno =3D=3D ENOENT || errno =3D=3D EOPNOTSUPP) {
> +			printf("SKIP:no PERF_COUNT_HW_CPU_CYCLES\n");
> +			test__skip();
> +		}
> +		return -1;
> +	}

If the syscall fails with an error other than ENOENT or EOPNOTSUPP (like
EACCES), this returns -1 without calling test__skip().

In run_kptr_dtor_nmi_case():

	pmu_fd =3D open_nmi_pmu_event_on_cpu(cpu);
	if (pmu_fd < 0)
		goto cleanup;

Since no assertions are triggered and the test isn't explicitly skipped,
will the selftest framework register this as a PASS, masking the resource
acquisition failure?

[ ... ]
> +static void run_kptr_dtor_nmi_case(const struct kptr_dtor_nmi_case *test)
> +{
[ ... ]
> +	if (!run_syscall_prog(skel->progs.cleanup_kptrs, "cleanup_kptrs"))
> +		goto cleanup;
> +	/*
> +	 * The grace period for rcu cannot complete until the CPU that ran the
> +	 * hard irq_work has passed through a quiescent state after running
> +	 * our dtor work. This effectively flushes our pending work and allows
> +	 * the test to verify the dtor was called the expected number of times.
> +	 */
> +	kern_sync_rcu();
> +	ASSERT_EQ(skel->bss->kptr_dtor_nmi_cleanup_deleted, 0,
> +		  "kptr_dtor_nmi_cleanup_deleted");

Does this test need to assert that skel->bss->kptr_dtor_nmi_cleanup_err
is 0?

The cleanup_kptrs BPF program sets kptr_dtor_nmi_cleanup_err if an error
occurs, but it looks like only kptr_dtor_nmi_cleanup_deleted is verified
here. If an internal error happens but no masks were exchanged out,
cleanup_deleted will be 0 and the test might silently pass.

> +cleanup:
> +	if (pmu_fd >=3D 0)
> +		close(pmu_fd);
[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/kptr_dtor_nmi.c b/tools/te=
sting/selftests/bpf/progs/kptr_dtor_nmi.c
> new file mode 100644
> index 0000000000000..693b07215006b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/kptr_dtor_nmi.c
[ ... ]
> +static bool clear_array_slot_from_nmi(__u32 slot)
> +{
> +	struct kptr_dtor_nmi_value init =3D {};
> +	int err;
> +
> +	if (!slot_is_live(slot))
> +		return true;
> +
> +	err =3D bpf_map_update_elem(&kptr_dtor_nmi_array, &slot, &init, BPF_EXI=
ST);
> +	if (err) {
> +		set_err(&kptr_dtor_nmi_nmi_err,
> +				&kptr_dtor_nmi_nmi_errno,
> +				KPTR_DTOR_NMI_DELETE_ERR, err);
> +		return false;
> +	}
> +
> +	clear_slot_live(slot);
> +	__sync_fetch_and_add(&kptr_dtor_nmi_deleted, 1);

Could concurrent NMI handlers cause a double-increment of kptr_dtor_nmi_del=
eted
due to a TOCTOU race on slot_is_live()?

Because clear_kptrs_from_nmi is attached to the global tp_btf/nmi_handler
tracepoint, it executes on NMIs across all CPUs. If two NMIs fire concurren=
tly
on different CPUs, both could read slot_is_live(slot) as true and successfu=
lly
execute bpf_map_update_elem(..., BPF_EXIST) on the array map.=20

Both would then call clear_slot_live() and increment kptr_dtor_nmi_deleted.
This double-increment could cause wait_for_nmi_drain() to return prematurely
before all slots are truly drained. The next round's populate_kptrs syscall
would then encounter uncleared kptrs, causing stash_mask() to fail with -EE=
XIST.

Would it be better to use an atomic test-and-clear operation here?

> +	return true;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507175453.1140=
400-1-utilityemal77@gmail.com?part=3D2
