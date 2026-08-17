Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739D7367F31
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 19:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786995096; cv=none; b=UplnEJiH9+mphWzzZ1PQauy8u/JS4jPdvf1uil0qfmRAnwfvkZSq4folMG1MsTo2e+UddScIU6K+ZfFE4bsA7KtUL7bfov+uuGOvJqG2trn6v9pOnj/3F6fGnKlHnTtzbPM/gC5VodLpl2WxYez5JO5luw2c9tq2+5Az2Qse5ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786995096; c=relaxed/simple;
	bh=d+4ilJJ8vBM+F4geL1ACLpwCGOWdPD3Kx2bi/rFVI/M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PER9x4BHSdy0uFvmoKDMM8vrNXEjexl29/JAhMwQ3x0fQo7/y6G3zIh0ggRDdsqYmw2wJfb/fzuJx5ahvf06//i4B/Qs7cGxwNac5u7voCsFDjMh1PG7SfGjyMlZFQ1QJlMZ1GKx3xFivyht+IUQCDVpNEtZWGjQoO7IAhJeYdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZczLUJC+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZczLUJC+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78D91F000E9;
	Mon, 17 Aug 2026 19:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786995095;
	bh=rd2mCGTAjHR1Jb4FF3aoV2trLHYFkvTtQa4AlbaWkSU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZczLUJC+wX0X6V+EYHi11rDnOx/qX+UgfQZMdogjbN2UL8p3ndGAQFBdTsAHTaYZL
	 UJOsYQlE/p3LVeUsK4UkTu3QW+LbuCowSusAqu2gTw+45YsVGkgORAwLm3O6o7hixk
	 OpJWAhquzAxOFX+BQX1CZN2eQdJn/YMu3j2U56UyZUUwA+0R7ahM8rFSd8A/mWhnWH
	 YeicLL6F6f6/hcTKvbC0m1rXKCEUiee4AVGRGLR7QHx17OWMedfFHw+6/wnmSv9pLw
	 HRiqv9f1iaL52oYKjsyavZUvVlEJ++IAyBPpnrPEV/n2rTOpKsMO5MecotZRiylm16
	 5mVFmp1otNcXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] selftests/bpf: libarena: Add a benchmark for
 malloc()/calloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260817191616.11071-6-emil@etsalapatis.com>
References: <20260817191616.11071-1-emil@etsalapatis.com>
 <20260817191616.11071-6-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 19:31:34 +0000
Message-Id: <20260817193134.D78D91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The benchmark incorrectly reports the 'allocations per second' m=
etric as 'invocations', and includes an unmatched closing parenthesis.
- [Medium] Missing bounds check causes silent 32-bit integer truncation for=
 the `--nallocs` argument.
- [Low] An unsigned validation value is formatted with a signed `%ld` speci=
fier, causing it to print negative numbers on error.
--

--- Patch [5]: [PATCH 5/6] selftests/bpf: libarena: Add a benchmark for mal=
loc()/calloc() ---
commit cfe60c8125bcfe8399db973cf6b5a739e50079d3
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: libarena: Add a benchmark for malloc()/calloc()
   =20
Add a benchmark for measuring the performance of the malloc()/calloc()
arena allocator calls. This is useful as a basic allocator performance
check that we can easily expand later. As with the regular arena
allocator, focus on sub-page allocations that cannot be satisfied
efficiently with the BPF arena page allocation code.

> diff --git a/tools/testing/selftests/bpf/benchs/bench_libarena.c b/tools/=
testing/selftests/bpf/benchs/bench_libarena.c
> new file mode 100644
> index 0000000000000..24e432244bf5d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/bench_libarena.c
> @@ -0,0 +1,210 @@

[ ... ]

> +static error_t parse_arg(int key, char *arg, struct argp_state *state)
> +{
> +	unsigned long value;
> +
> +	switch (key) {
> +	case ARG_LIBARENA_ALLOC_SIZE:
> +		value =3D strtoull(arg, NULL, 10);
> +		if (!value || value >=3D UINT_MAX) {
> +			fprintf(stderr, "invalid alloc_size: %ld", value);

[Severity: Low]
Does this print a negative number on overflow since value is an unsigned lo=
ng
and the format specifier is %ld instead of %lu?

> +			argp_usage(state);
> +		}
> +		args.alloc_size =3D value;
> +		break;
> +	case ARG_LIBARENA_NALLOCS:
> +		args.nallocs =3D strtoull(arg, NULL, 10);

[Severity: Medium]
Since args.nallocs is parsed as a 64-bit value without upper bounds validat=
ion,
and ctx.skel->bss->bench_nallocs is a 32-bit u32, does this result in silent
32-bit integer truncation when copying it later in setup_common()?

> +		break;
> +	default:
> +		return ARGP_ERR_UNKNOWN;
> +	}
> +
> +	return 0;
> +}

[ ... ]

> +static void report_final(struct bench_res res[], int res_cnt)
> +{
> +	unsigned long duration_ns =3D 0;
> +	long hits =3D 0;
> +	int i;
> +
> +	for (i =3D 0; i < res_cnt; i++) {
> +		duration_ns +=3D res[i].duration_ns;
> +		hits +=3D res[i].hits;
> +	}
> +
> +	if (!hits || !res_cnt) {
> +		printf("Summary: no runs measured\n");
> +		return;
> +	}
> +
> +	printf("Summary: %.3lf ns/op, %.0lf invocations for %u allocations/invo=
cation)\n",
> +	       duration_ns / (double)hits, hits / (double)res_cnt,
> +	       ctx.skel->bss->bench_nallocs);

[Severity: Medium]
Since hits tracks the total number of allocations, does hits / res_cnt
incorrectly report the allocations metric as invocations?

Also, there is an unmatched closing parenthesis at the end of the format
string.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817191616.1107=
1-1-emil@etsalapatis.com?part=3D5
