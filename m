Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202974C67F8
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 19:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276504; cv=none; b=T1/ATJC1KItfIrZvjvcgT61pBTAAfnDWKCZaZM4F4FeNoNGujIrWYHMhfeqq85WB1a/kgkDIg8/Uwmme4I084HyuO09bGdiDn4Qdww5aMngCD5ZWh2W3p5Nq0dSuV8B5WCWMKBfGPLIqUIjJSmOFseMLqxZZGB8J9kX0ObantCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276504; c=relaxed/simple;
	bh=tAvgi0HAATZd8/8/yYsCqfM4mXZMJwL6Ee4kwQzQnwc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TaiYCWVDVtpGu381qksmdaTRF2q4akFmKF3JdyfG19/mPo9c1Pjj4di1AO6xWS8vexfGh0klJoGDwrlPJImubM3c0ednEjcxcFv3pfDk/BgCs2lk7fhF+DOlwnbrogXOxCMqOmpF/UXqSl+MtruZSnqL1ZG72iHEGaTHtCoLe7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GD/FvSiZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GD/FvSiZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528C81F000FF;
	Thu, 24 Sep 2026 19:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790276484;
	bh=8FNyruTr2i8OPiywipvG3IlmWI0HGknLhes9h3Hsch0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GD/FvSiZ6TP7O68TvUklDBXZcHXQ8N3J8+++v/jSymDiH7b9xEbTq+dHzQ47V36sV
	 4cn3mjYxVS9szob4jSTRL8iIi5wNCfUpJ0RzCvIa355GudPUaXYcwyJpDvJLe5qUQ1
	 KRo6hyejJLDkgYUwUgFe4zYp3ZhgykQVa6WiLeKJ/9AYKO1IzjJQosVEMY7Y7y0mVk
	 /Ncp0b9Ib7Osz+eeAROlrFsGSFyRf0VpZQhQg6zj4D8mJuGzDkebkYzjTOzCA6TCii
	 wHDtl1aFBLibt5C6yQm/E4SICFk0l+XSnUC6Jr0a0F/LPJPqrd0GIwXhB2wx5feNST
	 zwZtOsvTphzNA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 7/7] selftests: cgroup: check that high_work reclaim
 is charged to the memcg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shakeel Butt" <shakeel.butt@linux.dev>
Cc: hannes@cmpxchg.org, tj@kernel.org, bpf@vger.kernel.org, mkoutny@suse.com
In-Reply-To: <20260924184714.912181-8-shakeel.butt@linux.dev>
References: <20260924184714.912181-1-shakeel.butt@linux.dev>
 <20260924184714.912181-8-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 19:01:23 +0000
Message-Id: <20260924190124.528C81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests: integer overflow in CPU time calculations on 32-bit s=
ystems
--

commit 07220f623c10651bfa63c3489314840c8641decc
Author: Shakeel Butt <shakeel.butt@linux.dev>

selftests: cgroup: check that high_work reclaim is charged to the memcg

Fills a memcg's TCP receive buffers from softirq while its only task
sleeps, so the memcg goes over memory.high and high_work reclaims.
Checks that the memcg's cpu.stat and memory.pressure grow, which
only happens if that reclaim is charged to the memcg.

> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/tes=
ting/selftests/cgroup/test_memcontrol.c
> index 0ed82347044ed..00802804c0d98 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
[ ... ]
> +static long now_usec(void)
> +{
> +	struct timespec ts;
> +
> +	clock_gettime(CLOCK_MONOTONIC, &ts);
> +	return ts.tv_sec * 1000000L + ts.tv_nsec / 1000;

[Severity: Medium]
Does this calculation overflow a 32-bit signed long? On 32-bit architecture=
s,
multiplying tv_sec by 1000000L truncates to a 32-bit signed long, which
overflows after approximately 35 minutes of system uptime. Could this corru=
pt
time differences due to signed overflow?

> +}
[ ... ]
> +static int test_memcg_high_work_cpu_max(const char *root)
> +{
> +	int ret =3D KSFT_FAIL, pid =3D -1, hog =3D -1, i, sk[HIGH_WORK_NCONN];
> +	long current, h0, h1, h2, t0, t1, t2, u1, u2, reclaim, lost;
[ ... ]
> +	/* The receiver sleeps, so the rest of the memcg's time is high_work. */
> +	reclaim =3D (u2 - u1) - (h2 - h1);
> +	lost =3D (h1 - h0) * (t2 - t1) / (t1 - t0) - (h2 - h1);

[Severity: Medium]
Can this multiplication overflow a 32-bit long? The time differences
(t2 - t1) and (h1 - h0) appear to be microsecond deltas of several seconds.
On 32-bit systems, their product can unconditionally overflow the 32-bit
signed long maximum, resulting in a bogus negative value that might cause
spurious test failures.

> +	if (reclaim < 30000) {
> +		ksft_print_msg("high_work used only %ld us, too little to test\n",
> +			       reclaim);
> +		ret =3D KSFT_SKIP;
> +		goto cleanup;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924184714.9121=
81-1-shakeel.butt@linux.dev?part=3D7
