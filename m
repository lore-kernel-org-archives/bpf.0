Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9506C3DB316
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211175; cv=none; b=D3a8S0wLEBp3yWhhP1uSX3f2yTl3Z+ZdvgeE7E911btpEzVoxUyGZTlNaYpxSgEweHsWGNzcSmW8X1xwmcI3Is2QWeUJi877mXNB6JpZW1UcVauPudL8gPyPM1bpzXhEn2o/fXBZxUCLoZm65yesYCl4I6sE19KFjkdmqqG32zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211175; c=relaxed/simple;
	bh=88LCbHfFAa39nMBD8cahZrF68VKoOMAuzAdTXvYRXqU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i+mH+NnHmTx0F7/HlqTwwFvGVHyuub0+hfsdXHqXWyOefefGHwHMgkLpFfBzr6biiJI4/QVKRxL1YV2ByCkCrMyH82RPree/XYFajvmL3IrKSm1T/nESy3UAEy2VfpfOjZbM7jhaXjVJfsN9uNtb/E7rZOr72dDPUAxLbTGckxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbsg8zRG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbsg8zRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8184FC2BCB3;
	Tue, 19 May 2026 17:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779211174;
	bh=88LCbHfFAa39nMBD8cahZrF68VKoOMAuzAdTXvYRXqU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=qbsg8zRGcKOHOVCLFgcyDVfBlD0he8SXrsymFrTLMMZxxfbeleQF3xzyAXBK/1R/h
	 n/hNGgHWXOmdfQS9l2fyKAQZdo3t6EMYl5DSVIaimFDpqDaNg0V/psdN2QTutaNNeo
	 dcDrbHJYdrPWFjcJE6J5tMy7lGRT7p0lRHLpwgHOhtdYzY/9rBr7Y20bNKeuqZBS7t
	 Amo4TxGS5v0U0C+RESPggXBBlfNZYKhLqEmC4Hhxi2Tq0MMcVbK9HxWBSSMfT5pv4u
	 padJsPY2zpODqZ8xN8xXyI1hTOEKQPhIbXeVOKyxKmHE4s8x1mhcA0UXJRQHEMsvnl
	 eh5xfQzDkfX4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/4] selftests/bpf: Cap batch-timing
 calibration at BPF may_goto loop limit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260519163632.2220753-4-puranjay@kernel.org>
References: <20260519163632.2220753-4-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 17:19:33 +0000
Message-Id: <20260519171934.8184FC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The new CALIBRATE_MAX_BATCH cap of 8,000,000 is mathematically i=
ncorrect and fails the patch's stated goal of keeping the benchmark within =
the BPF may_goto limit.
--

commit d9779455687fa035b58a0d4ba0d495256b32ed13
Author: Puranjay Mohan <puranjay@kernel.org>

selftests/bpf: Cap batch-timing calibration at BPF may_goto loop limit

This commit lowers CALIBRATE_MAX_BATCH from 10000000 to 8000000. This
is intended to keep the benchmark iterations within the BPF_MAX_LOOPS
limit of 8388608, avoiding early loop exits that cause underestimated
costs.

> diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_timing.c b/tool=
s/testing/selftests/bpf/benchs/bench_bpf_timing.c
> index 75a39da696552..081e2e860cb49 100644
> --- a/tools/testing/selftests/bpf/benchs/bench_bpf_timing.c
> +++ b/tools/testing/selftests/bpf/benchs/bench_bpf_timing.c
> @@ -166,7 +166,7 @@ void bpf_bench_timing_report(struct bpf_bench_timing =
*t, const char *name, const
> =20
>  #define CALIBRATE_SEED_BATCH	100
>  #define CALIBRATE_MIN_BATCH	100
> -#define CALIBRATE_MAX_BATCH	10000000
> +#define CALIBRATE_MAX_BATCH	8000000

[Severity: Medium]
Will this new cap of 8000000 still cause the benchmark to hit the BPF
may_goto limit during calibration?

Looking at bpf_bench_calibrate(), the proportionality check explicitly
requests a measurement of t->batch_iters * 2:

	time_n =3D measure_elapsed(t, run_fn, run_ctx, t->batch_iters, CALIBRATE_R=
UNS);
	time_2n =3D measure_elapsed(t, run_fn, run_ctx, t->batch_iters * 2, CALIBR=
ATE_RUNS);

With a cap of 8000000, t->batch_iters * 2 can reach up to 16000000
iterations. Since this exceeds the BPF_MAX_LOOPS limit of 8388608,
won't the BPF program's can_loop condition return false early during the
time_2n measurement?

This would cause time_2n to record the time for only ~8.38M iterations
instead of 16M. When compared to time_n (8M iterations), the ratio would
be ~1.05 instead of the expected 2.0. This completely violates the 5%
PROPORTIONALITY_TOL and triggers a bogus proportionality check warning
for fast benchmarks.

To safely avoid the limit across all phases of calibration, shouldn't the
cap be no more than BPF_MAX_LOOPS / 2 (e.g., 4000000)?

>  #define CALIBRATE_TARGET_MS	10
>  #define CALIBRATE_RUNS		5
>  #define PROPORTIONALITY_TOL	0.05	/* 5% */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519163632.2220=
753-1-puranjay@kernel.org?part=3D3
