Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522598;
	b=HF+bOFHzkQCeGoZFSMX9hqn5aF2XC6FDj7+QizOqiyNAXEk+ph5puVQZ+V6gPRilLRp1
	 4fWZSqJId6reZYuTt7lIX9JUZmZel7dXT3RPsVo+E1XHUaw7VRo91zSqzJeD6RwD2lVjV
	 l14Ytf1ioFwrPqPHaSKGWGcAVpn9SY8F/lxxLoNP80v2a+8Pvox7QTD9gDkISgRv0D0l5
	 UixCuiRzWKwkTB7kZbFeWsIr+MM7ILG53h6OzMED4eBRhsZMCSlzTuzq1mTxrLR8yBynw
	 gvXmG5Bg+k2LriJ8CZmA644m0hIOhWQBGpQwjsOMZoywBCilwv41ZQgivFlvHhJF1Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522598;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=TNcgFivRWL0H+Am/JkC7TyMU2sObzzhvnRokY6DdEiw=;
	b=NjnB0J6wqhDHTgsZEkQS/EwqlI9kHbRM9EOqeTQ0WkLsuZ0UC20AIO6pvO9abW11L3RX
	 RTIxMRz4ISnod1sciMM6fetTO6i4bIKLwHo0im/EJ+G3QXwrU5ETM5dzROVYfhsDtg7gn
	 B1pr3Nl3K+blTzS+mO6slgUDReS4egwWo7KDHbzO3JUk5kLbwWUklGpAvqLfQGNKUHRt8
	 huY7ZMfWSzDXpTg98Ev9sKqJpAkUvAqv4KsdscY9aLhUUfNS9FwuBGESWCe6rEUvT2KJl
	 LQWY0pnap/Sk/oUQ7xHCXsiw76zmSRolC/mrG94R/k7sRiNm+pux7g53yg/aForw5mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="m8ii/Zhx";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B117606A31D
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m8ii/Zhx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52CC1F000C9;
	Tue, 20 Oct 2026 18:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792522598;
	bh=TNcgFivRWL0H+Am/JkC7TyMU2sObzzhvnRokY6DdEiw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=m8ii/ZhxhIGpNBXmqjrYy7QpggWrY6Ua/zL2Q1uBL6UznQA5xfMv/YlydsmLtLcIj
	 Ks9pqkN0G3afcxQ3QW13j6mvYs44V+PHZ4UdU2fXkRtDFnYYYBOpHQ4SPRv9hrd+YL
	 5DARnFvPK0H6xuv0TUSBZmayUygbPvkzr6QxuFAKkG0Xv0FtUrDyxdfcmTpkEe6SYl
	 Gb5EcXPk+s5OyCUx3m/78/SgscFJFCaCIRoqrOuwgv4O6CZuIFWV9NxIyYjg1zT7uF
	 YcghR8PtaqHBvDoMijLrSml6oISvPqBzZUqQTVhlcew+Efat1J5Aa47mzQnwcTnjx8
	 8Nj8Dt5r2l7nw==
Content-Type: multipart/mixed; boundary="===============4330851222120562703=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <958260bd098dfc90afa3418793ece0d7dd4795107035129282c2e0148a83f788@mail.kernel.org>
In-Reply-To: <20261020181900.6755-3-emil@etsalapatis.com>
References: <20261020181900.6755-3-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v1 2/7] selftests/bpf: Add a parallel buddy allocator benchmark
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 18:56:37 +0000 (UTC)

--===============4330851222120562703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add a parallel buddy allocator benchmark

TL;DR: Commit message only: it claims worker count, allocation count and size
are varied but the script sweeps only producers, and omits the changed
malloc/calloc output. Plus a nit on unneeded (void) casts.

>     selftests/bpf: Add a parallel buddy allocator benchmark
>
>     Add a benchmark for measuring buddy allocator latency under concurrent
>     load. Each worker performs a configurable number of allocations followed
>     by the corresponding frees.
>     Vary the worker count, allocation count and allocation size to expose both
>     lock contention and cache pressure. Add the benchmark to the libarena
>     runner alongside the existing single-threaded cases.
>     Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

This isn't a bug, but the changelog says the worker count, allocation count
and allocation size are varied, while the new section of
run_bench_libarena.sh only sweeps the producer count:

  for producers in 1 2 4 8; do
	summarize_libarena "$producers producers:" \
		"$($RUN_BENCH -a -p "$producers" --alloc_size 64 --nallocs 1000 \
		libarena-malloc-free)"
  done

The changelog also doesn't mention that the output of the existing
libarena-malloc and libarena-calloc benchmarks changes.  The progress line
goes from "ns/op" to "ns/allocation", the Summary line drops the
invocations and allocations/invocation fields in favour of a total
allocation count, and the --nallocs help text changes as well.

Could the changelog say which parameters the runner actually sweeps, and
mention that the libarena-malloc/calloc output changes too (and why)?

> diff --git a/tools/testing/selftests/bpf/benchs/bench_libarena.c b/tools/testing/selftests/bpf/benchs/bench_libarena.c
> --- a/tools/testing/selftests/bpf/benchs/bench_libarena.c
> +++ b/tools/testing/selftests/bpf/benchs/bench_libarena.c

[ ... ]

> @@ -155,6 +196,15 @@ static void measure(struct bench_res *res)
>  	res->hits = atomic_swap(&ctx.skel->bss->bench_hits, 0);
>  }
>
> +static void malloc_free_measure(struct bench_res *res)
> +{
> +	(void)res;
> +
> +	if (++ctx.samples == env.warmup_sec)
> +		__atomic_store_n(&ctx.skel->bss->bench_collect, true,
> +				 __ATOMIC_RELAXED);
> +}

[ ... ]

> @@ -182,9 +232,27 @@ static void report_final(struct bench_res res[], int res_cnt)

[ ... ]

> +static void malloc_free_report_final(struct bench_res res[], int res_cnt)
> +{
> +	struct bench_res final = {};
> +
> +	(void)res;
> +	(void)res_cnt;

This isn't a bug, but are the (void)res and (void)res_cnt casts needed here
and in malloc_free_measure()?  The other bench callbacks, including
producer() in this file, leave unused parameters as they are.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39476260714
--===============4330851222120562703==--
