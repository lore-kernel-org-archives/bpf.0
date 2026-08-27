Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715D948B38C
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787847726; cv=none; b=GkyHOD9RwBfjDb6DVsbqhnKZWbpdkBvlWEdnv716UOl9LxeSqirnASbc+4jqRZ7GJN+POBvrPQCrXc8ZuLZZGnOR75Hd8Jr4jjxK7l1aR9EOws7D0Ob33ItolmPLMrRPTAaujyd60YPeyEDlHFGjd2jb+Q3IrS3dCU0R3kMm2po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787847726; c=relaxed/simple;
	bh=CKGxt3OPdMdCnaR2HbpvM0eU0tyVBZ0f5j0Nf/sQCzI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=KrO8KyWOIsbw9tFBXmvjpdO602yQBIx3xrZfracvCPiRLQoGwXQAjJk5kMu0rX/7uYKEn7EOQEIMwqwphBrZCkm5HoXKxvcH0TdwEuOvfIIEmh1IkDFSFAvl0E1pmgrYpr8aIf0LuW5YjD3Yw6UE2RgmecnCDyGoKfCPNQBBvMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2YiRXEo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2YiRXEo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53A11F00A3A;
	Thu, 27 Aug 2026 16:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787847725;
	bh=oaILIj/zvQCXMNRvPOmQ7ivRxhAhiFB+MgTu10f1CQQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=L2YiRXEoF4vLLiIsWYdtkCKENdw/ewq3nsCm633oFblf2JrjrUCqllHm0iPoK+wQJ
	 5qY3A18dyQrVKR5yqr4Flhsdg7UdGFkUnUoF72otstxTFiXA4fQ/h/IgNZ7SnbGFEG
	 Dautr9HUSArjJ8SFuh5UNlk2e+V+wjV/yfjzAlsGgbhKoWibdrCTxqCWhd4woC3uPA
	 r70w69NKvzfK7OQ+Lr7uJ24k6NR08n9WTqmTYlyvJAHxkQlWRYKQjpK4nV9BI/bbFJ
	 tLSaxZIXt/oBSn5zTecfY71T/eNgGDbUtSfyg2Qjl/ZBPphkPilFKbkL7IkrzMlGpT
	 M/DDr/hyMOF9Q==
Content-Type: multipart/mixed; boundary="===============8788896728043931912=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d4cd665a96c2543d11722e696e0227446be409b6dcf35f258d28b338c5e44e64@mail.kernel.org>
In-Reply-To: <20260827-bpftool_cyles_per_run-v1-1-77d7bfc3c065@meta.com>
References: <20260827-bpftool_cyles_per_run-v1-1-77d7bfc3c065@meta.com>
Subject: Re: [PATCH bpf-next] bpftool: Print average cycles per program run in profiler
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com,qmo@kernel.org
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 27 Aug 2026 16:22:04 +0000 (UTC)

--===============8788896728043931912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> index 90fa2a48cc26a..2280dc4492c06 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst

[ ... ]

> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index a9f730d407a92..8935508f955b1 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -2069,9 +2069,9 @@ struct profile_metric {
>  	bool selected;
>
>  	/* calculate ratios like instructions per cycle */
> -	const int ratio_metric; /* 0 for N/A, 1 for index 0 (cycles) */
> +	const int ratio_metric; /* 0 for run_cnt, 1 for index 0 (cycles) */
>  	const char *ratio_desc;
> -	const float ratio_mul;
> +	const double ratio_mul;
>  } metrics[] = {

This isn't a bug, but could the comment also mention that a NULL
ratio_desc means no ratio is printed? The l1d_loads entry now depends on
that rather than on ratio_metric == 0.

>  	{
>  		.name = "cycles",
> @@ -2080,6 +2080,9 @@ struct profile_metric {
>  			.config = PERF_COUNT_HW_CPU_CYCLES,
>  			.exclude_user = 1,
>  		},
> +		.ratio_metric = 0,
> +		.ratio_desc = "cycles per run",
> +		.ratio_mul = 1.0,
>  	},

[ ... ]

> @@ -2256,17 +2259,18 @@ static void profile_print_readings_plain(void)
>  	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
>  		struct bpf_perf_event_value *val = &metrics[m].val;
>  		int r;
> +		__u64 ratio;
>
>  		if (!metrics[m].selected)
>  			continue;
>  		printf("%18llu %-20s", val->counter, metrics[m].name);
>
> -		r = metrics[m].ratio_metric - 1;
> -		if (r >= 0 && metrics[r].selected &&
> -		    metrics[r].val.counter > 0) {
> +		r = metrics[m].ratio_metric;
> +		/* r == 0 is a special case for run_cnt */
> +		ratio = r ? metrics[r - 1].val.counter : profile_total_count;
> +		if (metrics[m].ratio_desc && ratio) {
>  			printf("# %8.2f %-30s",
> -			       val->counter * metrics[m].ratio_mul /
> -			       metrics[r].val.counter,
> +			       val->counter * metrics[m].ratio_mul / ratio,
>  			       metrics[m].ratio_desc);

This isn't a bug, but would a name like 'divisor' or 'denom' read more
naturally here? The variable holds the denominator rather than the
computed ratio, which makes the expression 'val->counter * ... / ratio'
read as if dividing a ratio by a ratio.

The commit message explains the new cycles-per-run output but not the
encoding change that makes it work. This isn't a bug, but would it be
worth a sentence noting that ratio_metric == 0 now means run_cnt (and
that ratio_desc is what gates printing)? Currently readers have to derive
the new encoding from the diff.

The unrelated widening of ratio_mul from float to double is also
unmentioned in the changelog.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33089436017
--===============8788896728043931912==--
