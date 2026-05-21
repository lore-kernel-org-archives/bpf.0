Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3085365A12
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779354705; cv=none; b=k938whOddSqjETUY5NMHg1IlDAE2AxqAgtvL+505VwoZb9kc8gT3b/NyWK4zde53EQyjsimMJJgfE6Vaxn+on4nahr9d8OtWeaSnuOU3qLmH8P1TRxYPgZxbFKrpvP+27VJBp+jGSEBKyJCPGmrT2FwWZ/EvnqfdkbsptWxp+TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779354705; c=relaxed/simple;
	bh=W8rDggaKXdRUp4+lPi4hboH+fd1RemsKtokupl0yPoc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gOwZX5IDKu0xalnQm2V38adyS91SL70dbt+5rU/ihy2YR2SSeL4krhz3x3r5oI0hWYkVaSFIetdUT08CfAfLTLnVluLiAyYBlxwCspR4a08mCdv/sEp4B7u1uh6yzUHARo3GW012gBRMmDLCNM+FaD7TQOuiY867Nc7pBmd/XA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aze6HNo+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aze6HNo+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA3B1F000E9;
	Thu, 21 May 2026 09:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779354704;
	bh=Igh+cBasYNUY0RUDdPKNcH3XD/Jx0aeLYnjaihwwYqg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aze6HNo+x+p2Hg6Ca17ns8kIDkpH/5/H/8JV9F/7O3X6MN6QzSSxpdmwZUBFtb7gG
	 4UWTEabvT5p78YViT/1QmhpQ5gRD463JxJC0mc7InDEI/IMHVXeRyOSuJ48SgH5geW
	 2Ozc/vaRe1TpzsevF3rIxFgeWEfbv77nIrSyaKiiaGF68BlX58eaMwuZBm8D4JY/QU
	 WWB1SLzYXr2CnIL4uoJyzo/v1X7Xpvonainsukp4jdSnwGQD71PVcSsrAEqgq1Kzba
	 lS0+ErEaBEtnld1PoSTWlB7GDAen6T9DfY73s7U5r0ei4s9wtywLz9qliTcddRTCJY
	 LVA5MUcCdhiiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/2] kunit: add tests for smp_cond_load_*_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521083038.134260-1-ankur.a.arora@oracle.com>
References: <20260521083038.134260-1-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 09:11:43 +0000
Message-Id: <20260521091144.4FA3B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The test updates the wait condition synchronously instead of usi=
ng a kthread, contradicting the commit message and failing to test SMP sema=
ntics.
- [Medium] The synchronous flag update in `mocked_clock()` introduces a TOC=
TOU race that can cause spurious test failures if the thread is delayed.
- [Low] The KUnit tests invoke undefined macros `smp_cond_load_acquire_time=
out` and `smp_cond_load_relaxed_timeout`, causing a build failure.
--

commit 600f0cbd609baeed72bc0b49cf63dc08bf77ea18
Author: Ankur Arora <ankur.a.arora@oracle.com>

kunit: add tests for smp_cond_load_*_timeout()

This commit adds KUnit tests for smp_cond_load_*_timeout(), verifying
both success and failure paths. The tests use basic and mocked clocks to
simulate time passing and conditionally set the test flag.

> All of the test cases wait on some state in smp_cond_load_*_timeout().
> In the success case we spawn a kthread that pokes the bit.

[Severity: Medium]
The commit message states that a kthread is spawned, but looking at the test
implementation, the flag is updated synchronously via the mocked_clock()
callback evaluated within the spin-loop.

Could this test be missing the concurrent kthread needed to verify cross-CPU
SMP semantics?

Without a concurrent update, on architectures using hardware sleep instruct=
ions
(like ARM64 WFE or x86 MWAIT), won't the CPU block waiting for a cache-line
invalidation that never arrives?

> diff --git a/lib/tests/barrier-timeout-test.c b/lib/tests/barrier-timeout=
-test.c
> new file mode 100644
> index 0000000000000..2160844b27b85
> --- /dev/null
> +++ b/lib/tests/barrier-timeout-test.c

[ ... ]

> +static s64 mocked_clock(struct clock_state *clk)
> +{
> +	s64 clk_mid =3D clk->start_time + (TIMEOUT_MSEC * NSEC_PER_MSEC)/2;
> +
> +	clk->end_time =3D local_clock();
> +	if (clk->end_time >=3D clk_mid)
> +		update_flags();
> +	return clk->end_time;
> +}

[Severity: Medium]
Is there a potential race condition here if the executing thread is delayed?

In typical smp_cond_load_*_timeout implementations, the condition is evalua=
ted
before the time expression. If local_clock() jumps from before clk_mid to p=
ast
timeout_ns in a single iteration due to preemption, mocked_clock() will
simultaneously set the flag and trigger the timeout.

Since the loop evaluates the condition first, could it terminate due to the
timeout and return the stale flag value, causing KUNIT_EXPECT_EQ to fail
spuriously?

[ ... ]

> +	if (p->acquire) {
> +		result =3D smp_cond_load_acquire_timeout(&flag,
> +						       (VAL & TEST_FLAG_VAL),
> +						       p->clock(&clk),
> +						       timeout_ns);
> +	} else {
> +		result =3D smp_cond_load_relaxed_timeout(&flag,
> +						       (VAL & TEST_FLAG_VAL),
> +						       p->clock(&clk),
> +						       timeout_ns);
> +	}

[Severity: Low]
Are the macros smp_cond_load_acquire_timeout and smp_cond_load_relaxed_time=
out
defined anywhere?

It appears they are not present in the current upstream kernel source tree =
nor
introduced in this patch, which would cause a build failure when
CONFIG_BARRIER_TIMEOUT_TEST is enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521083038.1342=
60-1-ankur.a.arora@oracle.com?part=3D1
