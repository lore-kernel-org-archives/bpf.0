Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967C0351C02;
	Tue, 26 May 2026 21:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832003; cv=none; b=gfeaQWMCwPzDPm83OT84xcXVaxsB4em1j9uv1jvxFaXDXjmBc8Oz1R+0YXqlYc8abgGuBSFfgbvlPM7YeWKfRNQALb9dvri8mnJG2K/jiOHgv1vUIrLzix/X94oeSJIQacbtrWmg/f42v6V2FbwnbtjCMN79ak1xoDhpnF1c86A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832003; c=relaxed/simple;
	bh=3T6/+pRuSbHPM0cZTW3cNU/tdEcV3DIAVoilVq5Cb6g=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VwOmzMcWzUv2HIIAZunI1+OPs534kFBw5meyPT3nOE8PIYtOA/RmQivLurrMbDZ6ml53v3HnnBHFEDI94+9Rd7Rdkal0QZWX6zibNi0Mb9TIGWzuNkmsE+ZTxfqJRNCySqhDBDs3B68fMR+3F/AcuRG7vecvZat74ks5aqXaSTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtJKtDS6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtJKtDS6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBA41F00A3A;
	Tue, 26 May 2026 21:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779832002;
	bh=25EvkMCRaAgiydvTbH54ndIUlCilEg7ze2lkTvt8X7E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=GtJKtDS6LyTExvaIOnNes84JhDwNlm0OX0PJ4/CEO4KSwANTIYfMVAU0uVS0tLf+r
	 570xedrZysKTFURBPO/uqivUlFzOTLgJeTCoJAPjIZgogEJGPPAqyZQWcq/aNKuG0i
	 +k58CPEsn4iO9Yadmddt3Glgq79wy0POlk5E2ncg9BT473jcXPT/2bj9h8x+CfoeCH
	 lSEbH+Diwx1nIlOlsK3WTksgG/JlYI7obM0SqN+TLNyeNNmDSwoLG/+D1rxLgExuZg
	 TGim/plQio4QvZlJaNvqIhUYdfabB7X5/8jtqxcabd5GQvm7G78LyVIre5l6KmOy+a
	 J8pvIWqwZe+XA==
Content-Type: multipart/mixed; boundary="===============6852976922352865295=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <623e280bfab376da047f79dd9ef8f646c26f38fdb0348fce7f8f8108a1261ee4@mail.kernel.org>
In-Reply-To: <20260526205840.173790-13-jolsa@kernel.org>
References: <20260526205840.173790-13-jolsa@kernel.org>
Subject: Re: [PATCHv4 12/13] selftests/bpf: Add tests for uprobe nop10 red zone clobbering
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,oleg@redhat.com,peterz@infradead.org,mingo@kernel.org,mhiramat@kernel.org,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 26 May 2026 21:46:42 +0000 (UTC)

--===============6852976922352865295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index 969f4deba9fd..efff0c515184 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c

[ ... ]

> @@ -855,6 +897,37 @@ static void test_uprobe_race(void)
>  #define __NR_uprobe 336
>  #endif
>
> +static void test_uprobe_red_zone(void)
> +{
> +	struct uprobe_syscall_executed *skel;
> +	struct bpf_link *link;
> +	void *nop10_addr;
> +	size_t offset;
> +	int i;
> +
> +	nop10_addr = find_nop10(uprobe_red_zone_test);
> +	if (!ASSERT_NEQ(nop10_addr, NULL, "find_nop10"))
> +		return;
> +
> +	skel = uprobe_syscall_executed__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +
> +	offset = get_uprobe_offset(nop10_addr);
> +	link = bpf_program__attach_uprobe_opts(skel->progs.test_uprobe,
> +			0, "/proc/self/exe", offset, NULL);
> +	if (!ASSERT_OK_PTR(link, "attach_uprobe"))
> +		goto cleanup;
> +
> +	for (i = 0; i < 10; i++)
> +		ASSERT_EQ(uprobe_red_zone_test(), 0, "red_zone_intact");

Does this loop execute too quickly to guarantee the uprobe optimization has
completed?

Uprobe optimization is performed asynchronously by a worker thread. Since this
is a tight loop with no delays or blocking, the 10 iterations might finish
before the background worker patches the code.

If all hits execute on the unoptimized INT3 path, the test could falsely pass
on kernels where the CALL-based optimization bug is present.

(This concern was raised by sashiko-bot@kernel.org in v1 and remains
unaddressed:
https://lore.kernel.org/bpf/20260514212219.BF1F3C2BCB3@smtp.kernel.org/)

> +
> +	bpf_link__destroy(link);
> +
> +cleanup:
> +	uprobe_syscall_executed__destroy(skel);
> +}

[ ... ]

> diff --git a/tools/testing/selftests/bpf/usdt_2.c b/tools/testing/selftests/bpf/usdt_2.c
> index b359b389f6c0..5e38f8605b02 100644
> --- a/tools/testing/selftests/bpf/usdt_2.c
> +++ b/tools/testing/selftests/bpf/usdt_2.c
> @@ -13,4 +13,17 @@ void usdt_2(void)
>  	USDT(optimized_attach, usdt_2);
>  }
>
> +static volatile unsigned long usdt_red_zone_arg1 = 0xDEADBEEF;
> +static volatile unsigned long usdt_red_zone_arg2 = 0xCAFEBABE;
> +static volatile unsigned long usdt_red_zone_arg3 = 0xFEEDFACE;
> +
> +void __attribute__((noinline)) usdt_red_zone_trigger(void)
> +{
> +	unsigned long a1 = usdt_red_zone_arg1;
> +	unsigned long a2 = usdt_red_zone_arg2;
> +	unsigned long a3 = usdt_red_zone_arg3;
> +
> +	USDT(optimized_attach, usdt_red_zone, a1, a2, a3);
> +}

Is this test reliable across different compiler versions and optimizations?

The USDT macro uses the "nor" inline assembly constraint, which allows the
compiler to allocate these operands to CPU registers.

Because there is no register pressure in usdt_red_zone_trigger(), modern
compilers might allocate a1, a2, and a3 directly to registers rather than the
stack's red zone.

If the operands are placed in registers, the uprobe CALL optimization
clobbering [rsp-8] will not corrupt them. This could cause the test to pass
even on buggy kernels, creating a false positive.

Would it be safer to explicitly force these operands into the red zone using
inline assembly constraints, rather than depending on the compiler's register
allocator?

(This concern was raised by bot+bpf-ci@kernel.org in v1 and v3 and remains
unaddressed:
https://lore.kernel.org/bpf/e91d31e0c1378fe970db6385c7af419e97af0c2acd37b3b8775a2fac02ea2361@mail.kernel.org/)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26475828601
--===============6852976922352865295==--
