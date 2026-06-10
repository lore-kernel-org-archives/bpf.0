Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BDC3D88EF
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781107616; cv=none; b=A7B9UNudx56R4EktWQ0vqPblHuZScTsxZO9fmO0dVpWGJ6DsrAPV7tNbfazSMhEc+jp3EohvXeZzM4SkaCdJr2yVXpnRiF0euiSab3dDfcr2mPqQ2ttqNjEhZ4Z8qVRjo1ghzC3SekeClkuAi9MmdDhK2Q5NUZ/G3h/mtmu6wKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781107616; c=relaxed/simple;
	bh=x8QlCP4ZkpZ0w1JKHxMi8dQlagZU8Bs6hP6vPqjauiQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ul7Fwg6PawwCk7YZ2I8BkzGEbQrNnHgc0xpQEOeRIa/J03aPwPUtyiFZJE5lJmwIEzoP7v/xGF0ANja5Bv5DD4+41JO/xDF5uwMsE8L5pHL2Vp4wFOAjYCsl5kzIKRG7yiskgvCPS+H9T8qMEWham50c2M2ALAYtKBTV2DmUh1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gl7/jac+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gl7/jac+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394461F00893;
	Wed, 10 Jun 2026 16:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781107615;
	bh=qJJvi/ks+w6mM1jhL4snWBTL8VFkW8snnDlGL2h0iSE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gl7/jac+iAobMuerNMKmnuvhJlXlVwPa9G/UnM6tniBnMrb7qJrhcgdAl3U4rVJmF
	 pKptsmkKIhwvRCBshi7EOa+xNwQSMVPbrTVE4i/lqlfOwNeDz65yKIU30bSL8X72eS
	 RJpsODQQ6L2OOtCu+6md1fDXuyH0QZVrd5pCRZYfDvKq01d0aDo4FQeoX3ukojZ2BF
	 Zi7UmnQyvn9Z1bUYLIE93CfxHGDRlcdhxJ81jZNR0VUkMqYjbUbPPsfFnORlQYEO0y
	 FSbivUHfSGrvdllMycV0/8kcqiZ2Y0jzNWDTkOVwcCtwVZPuBnh8OdLcMkqIK6qX8Y
	 wGWDLhXifaViA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Add cgroup kptr NMI deadlock
 reproducer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260610155225.1221740-1-utilityemal77@gmail.com>
References: <20260610155225.1221740-1-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 16:06:54 +0000
Message-Id: <20260610160655.394461F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] Test fails on uniprocessor environments due to hardcoding CPU 1.
- [Medium] Unhandled `perf_event_open` errors result in silent false PASS.
- [Medium] Premature exit from `/dev/kmsg` read loop on `EPIPE` leads to fa=
lse negatives.
- [Low] Fragile test logic bypassing exported cgroup helpers.
--

commit 6fece5f542be76494e7860faa5c9a7968d90f02e
Author: Justin Suess <utilityemal77@gmail.com>

selftests/bpf: Add cgroup kptr NMI deadlock reproducer

This commit adds a BPF selftest reproducer for a cgroup kptr NMI deadlock. =
It
exercises a path where a BPF map element's destructor is invoked from an NMI
context when a map element is freed.

Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_kptr_nmi_deadl=
ock_repro.c b/tools/testing/selftests/bpf/prog_tests/cgroup_kptr_nmi_deadlo=
ck_repro.c
> new file mode 100644
> index 0000000000000..428e321865cee
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_kptr_nmi_deadlock_rep=
ro.c

[ ... ]

> +static bool kmsg_saw_splat(int fd)
> +{
> +	char buf[8192];
> +	ssize_t n;
> +	bool saw =3D false;
> +
> +	/* bpf_cgroup_release_dtor in any splat stack means NMI ran the dtor. */
> +	while ((n =3D read(fd, buf, sizeof(buf) - 1)) > 0) {

[Severity: Medium]
Will this loop terminate prematurely if the ring buffer overwrites some old=
er
messages?

For /dev/kmsg, read() returns -1 with errno set to EPIPE if messages are
overwritten. By breaking on <=3D 0, the test will stop reading the remaining
available messages in the buffer. Should this handle EPIPE and continue
reading?

> +		buf[n] =3D '\0';
> +		if (strstr(buf, "bpf_cgroup_release_dtor"))
> +			saw =3D true;
> +	}
> +	return saw;
> +}

[ ... ]

> +static int create_repro_cgroup(char *cgroup_path, size_t cgroup_path_sz)
> +{
> +	format_repro_cgroup_path(cgroup_path, cgroup_path_sz,
> +				 REPRO_CGROUP_REL_PATH);
> +	if (mkdir(cgroup_path, 0777))
> +		return -errno;
> +
> +	return 0;
> +}

[Severity: Low]
Is there a reason to manually reconstruct the cgroup mount paths and call
mkdir directly here?

If the BPF selftest cgroup framework changes its internal mount paths, this
might break since get_cgroup_id() will look in a different directory. Could
this use the exported create_and_get_cgroup() and remove_cgroup() helpers
instead?

[ ... ]

> +static int open_nmi_pmu_event_on_cpu(int cpu)
> +{
> +	struct perf_event_attr attr =3D {
> +		.freq =3D 1,
> +		.sample_freq =3D 1000,
> +		.type =3D PERF_TYPE_HARDWARE,
> +		.config =3D PERF_COUNT_HW_CPU_CYCLES,
> +	};
> +	int pmu_fd;
> +
> +	pmu_fd =3D syscall(__NR_perf_event_open, &attr, -1 /* pid */, cpu,
> +			 -1 /* group_fd */, 0 /* flags */);
> +	if (pmu_fd =3D=3D -1) {
> +		if (errno =3D=3D ENOENT || errno =3D=3D EOPNOTSUPP) {
> +			printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n", __func__);
> +			test__skip();
> +		}
> +		return -1;
> +	}

[Severity: Medium]
If perf_event_open fails with an error other than ENOENT or EOPNOTSUPP
(such as EACCES or ENFILE), this returns -1 without calling test__skip()
or asserting.

Later in run_cgroup_kptr_nmi_deadlock_repro(), this causes the test to bail
out and report a PASS without running. Should we add an assertion here for
unexpected errors?

> +
> +	return pmu_fd;
> +}
> +
> +static bool pin_to_cpu(int cpu, cpu_set_t *old_cpuset)
> +{
> +	cpu_set_t cpuset;
> +	int err;
> +
> +	err =3D sched_getaffinity(getpid(), sizeof(*old_cpuset), old_cpuset);
> +	if (!ASSERT_OK(err, "sched_getaffinity"))
> +		return false;
> +
> +	CPU_ZERO(&cpuset);
> +	CPU_SET(cpu, &cpuset);
> +	err =3D sched_setaffinity(getpid(), sizeof(cpuset), &cpuset);
> +	if (!ASSERT_OK(err, "sched_setaffinity"))

[Severity: Medium]
Since REPRO_CPU is hardcoded to 1, will this unconditionally fail the test
on uniprocessor environments?

Would it be better to query the available CPUs from the initial affinity ma=
sk,
or gracefully skip the test if CPU 1 is unavailable, rather than failing the
assertion?

> +		return false;
> +
> +	return true;
> +}

[ ... ]

> +static void run_cgroup_kptr_nmi_deadlock_repro(void)
> +{

[ ... ]

> +	pmu_fd =3D open_nmi_pmu_event_on_cpu(REPRO_CPU);
> +	if (pmu_fd < 0)
> +		goto destroy_skel;

[Severity: Medium]
As mentioned above, if open_nmi_pmu_event_on_cpu() encounters an unexpected
error, it returns -1. This goto destroy_skel path then exits the test
without triggering any assertions.

Does this lead to a silent false PASS if perf_event_open fails for reasons
other than lacking hardware support?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610155225.1221=
740-1-utilityemal77@gmail.com?part=3D1
