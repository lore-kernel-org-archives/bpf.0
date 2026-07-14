Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EDD1A38F9
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016183; cv=none; b=Tu91q/2mR2/28gVz59p+u63vTRbctM7Qarbw4rVyNVJi00goUtWizzbUKQN9jWC9PfQqDY+tpFlenYHrRpKkjm8HN2HmgtVrEUmTBUqkK8AHGCLWxsM/n3wAtelth9/uRFuSzZUbzxkKTbmU8gM1C4TasAgK3/rBH7Xm9qspIXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016183; c=relaxed/simple;
	bh=H+QgGXldo6xMh/4lZJ66hHbgPRP66rqfzKnDG823tzs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GF4imw+/wKUpsjCfVhhHdEmM3weBaJOwF6yolJdKGpaU7E+5FaCfnUKEM02BCKZP7GqVqwUncaCfSXRDT6Uhi+s/6ymfVzLKLXfIsjN6cMZ5WjZ7ho7ngcMScqJwgMvjJULP/C8R7bWBjMvMoXzxCOY4N95UEIk8sdeiZccKqIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhRMxoCG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhRMxoCG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9651F000E9;
	Tue, 14 Jul 2026 08:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784016182;
	bh=8oGsxIHGi8BoCL7x7VLZsZ5hl7CVggrqMadnWJUVQDo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BhRMxoCGqyUQZzrsnX6cM8VqT3jESWUYaYJWf8p97etOYZPzFwX5aVNJV7MiW7O/j
	 tGkMXOku6thvXVq++9G+vMZusF2x1nd9+ULC6okvEf7O/ys1yWIMqyWajFKTm4D4a3
	 PYbcz7/DgLlFQSebyJCJe6XYLUMI5UtZH5rXgm7la2HbbyoF3GezGIVVfWDehCRs87
	 QNNvoFXybg6HnOQTSRBHVN0FTSGNPp1mIfJnTAoHGIjbkvkIlFeJ6s0S5P72928ZOf
	 nFxjd94x7UnN0a5LZ3/GSsDJS4ENTUQAM31MMw3L2FH8w68MPShEUGbgNfodPmOIZK
	 LLSReJS3jhwrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 15/15] barrier: add clock tests for
 smp_cond_load_relaxed_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260714073041.40250-16-ankur.a.arora@oracle.com>
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
 <20260714073041.40250-16-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 08:03:01 +0000
Message-Id: <20260714080301.DB9651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] smp_cond_load_relaxed_timeout() effectively doubles the intended t=
imeout on architectures with a waiting cpu_poll_relax() (e.g., ARM64).
- [High] Passing U64_MAX or S64_MAX to smp_cond_load_relaxed_timeout() caus=
es an immediate timeout instead of an infinite wait.
--

--- Patch [15]: [PATCH v14 15/15] barrier: add clock tests for smp_cond_loa=
d_relaxed_timeout() ---
commit 9919abc9f7cd30b282ef4aefe31726e940d7bd0d
Author: Ankur Arora <ankur.a.arora@oracle.com>

barrier: add clock tests for smp_cond_load_relaxed_timeout()

Add a few clock tests for smp_cond_load_relaxed_timeout(). These ensure that
the implementation doesn't do anything funny stuff with the clock (like
multiple accesses per iteration).

>     Also ensure that we handle edge cases sanely. Note that two edge cases
>     fail: S64_MAX and U64_MAX. However, both of those are quite far out
>     and if needed, can be addressed in the implementation of the interfac=
e.

[Severity: High]
This isn't a bug introduced by this patch, but passing U64_MAX or S64_MAX to
smp_cond_load_relaxed_timeout() causes an immediate timeout instead of an
infinite wait.

A caller passing ~0ULL (a common idiom for 'no timeout') will silently have=
 it
cast to s64, turning it into -1. After the first spurious wake, the conditi=
on
if (__timeout <=3D 0) triggers and it returns immediately. For S64_MAX, the
addition __time_now + __timeout overflows into a negative number, resulting
in the same immediate failure:

include/asm-generic/barrier.h:smp_cond_load_relaxed_timeout() {
    ...
    s64 __timeout =3D (s64)timeout_ns;
    ...
    if (__time_now <=3D 0 || __timeout <=3D 0) {
        VAL =3D READ_ONCE(*__PTR);
        break;
    ...
}

Should we fix the interface to correctly handle standard infinite values ra=
ther
than leaving this API trap?

> diff --git a/lib/tests/barrier-timeout-test.c b/lib/tests/barrier-timeout=
-test.c
> index 4226fb6456b35..ec78f85330062 100644
> --- a/lib/tests/barrier-timeout-test.c
> +++ b/lib/tests/barrier-timeout-test.c

[ ... ]

> +static void test_smp_cond_expiry(struct kunit *test)
> +{
> +	const struct smp_cond_expiry_params *p =3D test->param_value;
> +	struct clock_state clk =3D {
> +		.start_time =3D 0,
> +		.end_time =3D 0,
> +		.extra =3D p->clk_inc,
> +		.niters =3D 0,
> +	};
> +	s64 runtime;
> +
> +	flag =3D 0;
> +	smp_cond_load_relaxed_timeout(&flag,
> +				      0,
> +				      synthetic_clock(&clk),
> +				      p->timeout);
> +
> +	runtime =3D (u64)clk.end_time - (u64)clk.start_time;
> +	KUNIT_EXPECT_EQ(test, clk.niters, p->niters);
> +	KUNIT_EXPECT_GE(test, runtime, p->timeout);

[Severity: High]
This is a pre-existing issue, but smp_cond_load_relaxed_timeout() effective=
ly
doubles the intended timeout on architectures with a waiting cpu_poll_relax=
()
(e.g., ARM64).

The KUnit tests added here only verify the minimum runtime, which passes
despite the runtime being double. On ARM64, the late initialization of
__time_end using __time_now after cpu_poll_relax() erroneously adds the
physical sleep duration to the timeout deadline:

include/asm-generic/barrier.h:smp_cond_load_relaxed_timeout() {
    ...
    for (;;) {
        ...
        cpu_poll_relax(__PTR, VAL, (u64)__timeout);
        ...
        __time_now =3D (s64)(time_expr_ns);
        if (unlikely(__time_end =3D=3D 0))
            __time_end =3D __time_now + __timeout;
    ...
}

Because __time_now is already Start + timeout_ns when WFET wakes, the new
deadline becomes Start + 2 * timeout_ns, causing the loop to sleep a second
time.

Could the tests be updated to also enforce an upper bound on the runtime to
catch these latency issues, or could we fix the macro itself to initialize
__time_end before polling?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714073041.4025=
0-1-ankur.a.arora@oracle.com?part=3D15
