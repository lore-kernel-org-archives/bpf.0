Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0320B4A5C33
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108367; cv=none; b=iJ8zFImyP2lVGUZo4nmaLphG884bbgpu+xWLgFpC4HwEgC7pZ3xAd9qN465DtXS09HcWVbSb5G1w6S6XiOYfH7JKj2cDdywuXMz53dgdCptHSgVOhBMs7GxHCBkZ3EOthW6WT7W2R2AHtcFMQtFJBPnJWk/hryLKxizG5Rva9/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108367; c=relaxed/simple;
	bh=O0PA2JznCsBj0EKVB2JxEwzT/pP1o6XbYOlM0sSubpE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jp8PevG6LSU6NoWCB2yMnw/meUUUAxJ1gaorZvj/6KgkXZ4+RHXtQLK8nSip38612/MkaMzjf6K2vRcK3xeKwSYfGCgxjHewfsEBJsM2yFUfi92M7H8y5xaZiyCEEy2oZZldg07Rixmqi2JGtf2SC8xSPxMrS9pqwNuikfHA/xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVgHP+6E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVgHP+6E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC821F000FF;
	Tue, 22 Sep 2026 20:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790108337;
	bh=lrC/4Z8Egx4dohsrH6PqlHYwFwx3HaCSfz9ctLNLhUA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MVgHP+6EcizzATwi6ubDLCHZxUZhGubKxnUFNhBXQfjFYfeaKsdwM3yUyixZu8SL3
	 tJpKIXfHYKpgC6zcaOrEeTzQiZNH4CrdKCb5qgNtYPdpfoNa11BoSgnKl9BO1dFHcN
	 cHCdZ3V+UYt5i19XVI4Golx3XZgHMTLXwJaR3VYzvMOckRvim+sj1ux/DuIE1sgLs0
	 7AUAZo1LSZ41VjQduySFNDgiPuYNDEtCGYdF2sqo+QUAmHmgqU/PcsVg97SmrJpVuI
	 aImjP8ZT+nV7fXcihzlyCxfbb8xhLihh8H73yv0BWdjWvFhmS90Tdj2iAX8D88wfqO
	 eZVoeZXq3LHAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] kallsyms: Add test_kallsyms_perf module to
 benchmark lookup latency
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260922-ksyms-tune-v4-1-92acea84b911@gmail.com>
References: <20260922-ksyms-tune-v4-0-92acea84b911@gmail.com>
 <20260922-ksyms-tune-v4-1-92acea84b911@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 20:18:56 +0000
Message-Id: <20260922201857.4BC821F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] test_kallsyms: infinite loop on large num_iters due to integer ove=
rflow
- [Medium] test_kallsyms: benchmark latency includes preemption sleep time
--

commit 3ac6ce68ed3764cca0a42a3e09873db349d331f2
Author: Jim Cromie <jim.cromie@gmail.com>

kallsyms: Add test_kallsyms_perf module to benchmark lookup latency

This commit adds a lightweight microbenchmark module to evaluate optimizati=
ons
and measure performance regressions across kallsyms lookups. It benchmarks
name-to-address, address-to-name, and sequential table scans.

> diff --git a/lib/test_kallsyms_perf.c b/lib/test_kallsyms_perf.c
> new file mode 100644
> index 0000000000000..03ff5f1d51c5d
> --- /dev/null
> +++ b/lib/test_kallsyms_perf.c
[ ... ]
> +static void run_name_lookup_bench(unsigned int iters)
> +{
[ ... ]
> +	/* 1. Name search: Existing symbols (Hits) */
> +	for (i =3D 0; i < iters; i +=3D BENCH_CHUNK_SIZE) {

[Severity: High]
Does this unconditionally add BENCH_CHUNK_SIZE to i in a way that can wrap
around?

If a user sets num_iters via sysfs to a value approaching UINT_MAX
(for example, UINT_MAX - 100), could i wrap around to a small number?

If so, will the termination condition i < iters never be met, causing an
infinite loop that permanently holds bench_lock?

> +		unsigned int chunk =3D min_t(unsigned int, BENCH_CHUNK_SIZE, iters - i=
);
> +		unsigned int j;
> +
> +		cond_resched();
> +		t0 =3D ktime_get_ns();
> +		for (j =3D 0; j < chunk; j++) {
> +			const char *sym =3D hit_symbols[(i + j) % nr_hits];
> +
> +			kallsyms_on_each_match_symbol(match_cb, sym, &addr);

[Severity: Medium]
Do these kallsyms traversal APIs inherently invoke cond_resched() within th=
eir
internal iteration loops?

If so, does calling them inside the timing bracket (between t0 and t1) defe=
at
the chunking mitigation? Could this include preemption sleep time in the
measured benchmark latency?

> +			OPTIMIZER_HIDE_VAR(addr);
> +		}
> +		t1 =3D ktime_get_ns();
> +		dt_hit +=3D t1 - t0;
> +	}
> +
> +	/* 2. Name search: Non-existent symbols (Misses - 17 bsearch probes) */
> +	for (i =3D 0; i < iters; i +=3D BENCH_CHUNK_SIZE) {

[Severity: High]
Can this loop also suffer from the same integer overflow if num_iters is ve=
ry
large?

> +		unsigned int chunk =3D min_t(unsigned int, BENCH_CHUNK_SIZE, iters - i=
);
> +		unsigned int j;
> +
> +		cond_resched();
> +		t0 =3D ktime_get_ns();
> +		for (j =3D 0; j < chunk; j++) {
> +			const char *sym =3D miss_symbols[(i + j) % nr_misses];
> +
> +			kallsyms_on_each_match_symbol(match_cb, sym, &addr);
> +			OPTIMIZER_HIDE_VAR(addr);
> +		}
> +		t1 =3D ktime_get_ns();
> +		dt_miss +=3D t1 - t0;
> +	}
[ ... ]
> +static void run_address_lookup_bench(unsigned int iters)
> +{
[ ... ]
> +	/* 1. Address-to-name resolution (sprint_symbol) */
> +	for (i =3D 0; i < iters; i +=3D BENCH_CHUNK_SIZE) {

[Severity: High]
Is there a similar risk of wrap-around in this loop when num_iters approach=
es
UINT_MAX?

> +		unsigned int chunk =3D min_t(unsigned int, BENCH_CHUNK_SIZE, iters - i=
);
> +		unsigned int j;
> +
> +		cond_resched();
> +		t0 =3D ktime_get_ns();
> +		for (j =3D 0; j < chunk; j++) {
> +			unsigned long addr =3D addrs[(i + j) % nr_addrs];
> +
> +			sprint_symbol(symname, addr);
> +			barrier_data(symname);
> +		}
> +		t1 =3D ktime_get_ns();
> +		dt_sprint +=3D t1 - t0;
> +	}
> +
> +	/* 2. Address without offset (sprint_symbol_no_offset) */
> +	for (i =3D 0; i < iters; i +=3D BENCH_CHUNK_SIZE) {

[Severity: High]
Could this loop also become infinite due to the same integer overflow
condition?

> +		unsigned int chunk =3D min_t(unsigned int, BENCH_CHUNK_SIZE, iters - i=
);
> +		unsigned int j;
> +
> +		cond_resched();
> +		t0 =3D ktime_get_ns();
> +		for (j =3D 0; j < chunk; j++) {
> +			unsigned long addr =3D addrs[(i + j) % nr_addrs];
> +
> +			sprint_symbol_no_offset(symname, addr);
> +			barrier_data(symname);
> +		}
> +		t1 =3D ktime_get_ns();
> +		dt_bldid +=3D t1 - t0;
> +	}
[ ... ]
> +static void run_table_walk_bench(void)
> +{
[ ... ]
> +	for (i =3D 0; i < iter; i++) {
> +		total_symbols =3D 0;
> +		cond_resched();
> +		t0 =3D ktime_get_ns();
> +		kallsyms_on_each_symbol(count_cb, &total_symbols);

[Severity: Medium]
Does kallsyms_on_each_symbol() also natively invoke cond_resched() inside i=
ts
iteration loop?

If so, could placing this call inside the timing bracket include preemption
sleep time and inflate the measured walk latency?

> +		t1 =3D ktime_get_ns();
> +		dt_walk +=3D t1 - t0;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-ksyms-tune=
-v4-0-92acea84b911@gmail.com?part=3D1
