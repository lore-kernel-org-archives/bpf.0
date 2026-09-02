Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B0534B1A6
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 07:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788333272; cv=none; b=q+e2U+wq5nYjf2RW79Z2auc+fPD76FL+WNMvQmK07DYcL7WTbkKFBBtL6+cAt4Oaq8CjmM2SjbneWpPmUqYS8uH7BCE/zAqAGM4R1sMPhriYXMyntlx4vvAlxyWJDzMgJ0OYuquT4Q09iei890DdzYmbOK2vAOuRK6wDoXTeaWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788333272; c=relaxed/simple;
	bh=l4mnzIFAemU9Hqqqdce1IZuazImCAtjQFy82kyQB3/0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L8zYSqP42lD39svTuppQSUr87JzlPR48rWWSUIgvA/MZNV5QhN4as+Q0RXzKtPnRPCGjRFducL20uTRlNNNtjneU+y8rXqvkSrrPsxQedV6OSQqwTsTC/HNLa50K464IoOcRaUOjA5ht7SfuA6BUdH70d5EJOkdxMLLK7g139kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eK5maLkw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eK5maLkw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C4B1F000E9;
	Wed,  2 Sep 2026 07:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788333270;
	bh=t07l1OymoSoEY9vh1yy4AKyTBW/vk/yXqVbIkd8Fo7E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eK5maLkwDravu1BWgtjxxB817bJE599vQndkyV0UnrAEtdW/a6WEYAR5QUgjtRLLe
	 eFXR89+EkNeDwEPpCs7TmDZSzpnZise+g/Cnb8uy4IOvtUa1BDJ8cCufIAsRhfdfqm
	 ZbmeF0R34tBTcdKjHSRiPVlskMABM4Deo9l0LVyjqrSaMaopVsqPPfhj4J5HsYVPxT
	 abBJAuQdowsCeSBlbHubV2/4shJYgYtY0OYoRCs5FRjqcIPc9Llfi4feHtTd46DhZK
	 /dNYTl0rXrDM6fFCXVffU+fg5n+NCJW26znjwAgB3/zwisNUPvUN252pSCxIEKb9gz
	 9feF9qzQfsKMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: Add arena allocation race
 tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260902070239.16968-6-emil@etsalapatis.com>
References: <20260902070239.16968-1-emil@etsalapatis.com>
 <20260902070239.16968-6-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 07:14:30 +0000
Message-Id: <20260902071430.A8C4B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The selftest fails to load on ARM64 because `flush_tlb_kernel_ra=
nge` is a static inline function.
- [Medium] Busy-waiting in an fentry BPF program for a userspace thread gua=
rantees a test timeout on UP non-preemptible kernels.
--

commit 03dd0a4c6fda5e1c4877d7ca2aff23509f39c69f
Author: Emil Tsalapatis <emil@etsalapatis.com>
Subject: selftests/bpf: Add arena allocation race tests

This commit adds selftests to handle concurrent accesses to arena
allocations, including sleepable and non-sleepable page allocation
paths, to ensure no inconsistent or lost data occurs.

> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_race.c b/tools/=
testing/selftests/bpf/prog_tests/arena_race.c
> index 0000000000000..c3a2a4397315a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_race.c
[ ... ]
> +	/* Force a reallocation during the flush. */
> +	run_prog(skel->progs.try_realloc, "realloc_before_flush");
> +	ASSERT_NULL(skel->bss->realloc_ptr, "realloc_before_flush");
> +
> +release:
> +	skel->bss->release =3D 1;

[Severity: Medium]
Will this test deterministically timeout or deadlock on uniprocessor systems
when CONFIG_PREEMPT_NONE is set?

The userspace thread needs CPU time to execute this assignment, but the BPF
program may be hogging the only CPU by spinning in wait_for_release().

[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/arena_race.c b/tools/testi=
ng/selftests/bpf/progs/arena_race.c
> index 0000000000000..df5b54ef5b4c0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/arena_race.c
[ ... ]
> +static __always_inline void wait_for_release(void)
> +{
> +	while (!*(volatile int *)&release && can_loop)
> +		;

[Severity: Medium]
Could this tight loop starve the CPU if preemption is disabled during the
fentry program?

On uniprocessor non-preemptible kernels, the userspace thread cannot be
scheduled to set the release variable while the BPF program runs. The loop
terminates only when can_loop runs out, which sets timed_out =3D 1 and caus=
es
the test to fail.

> +	if (!*(volatile int *)&release)
> +		timed_out =3D 1;
> +}
[ ... ]
> +SEC("fentry/flush_tlb_kernel_range")
> +int BPF_PROG(trace_flush, unsigned long start, unsigned long end)

[Severity: Medium]
Does this fentry program fail to load on ARM64?

On ARM64, flush_tlb_kernel_range is defined as a static inline function in
<asm/tlbflush.h>. Because inline functions do not generate BTF IDs in
vmlinux, libbpf will fail to resolve the attach target during
arena_race__load(skel), which breaks the selftest CI on ARM64.

> +{
> +	if (!pause_on_flush ||
> +	    (__u32)bpf_get_current_pid_tgid() !=3D target_tid)
> +		return 0;
> +	flush_entered =3D 1;
> +	wait_for_release();
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902070239.1696=
8-1-emil@etsalapatis.com?part=3D5
