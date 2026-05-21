Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA6F211A28;
	Thu, 21 May 2026 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369970; cv=none; b=lwZkjyMWE+lrIB+lgHURS06VX40dkmWIAQ8tmbOWc2/QmgaNFMZW0boU+5Fve0eHrES6MT3Z+BegSkaxJNZeoK2K2ro1T6AJKS0RlV0NrPYjh5GGn6d3ujbEz3wKMc5gQJ0n6ZW3Pmd8vYeaCSDjMeIs4Zn7kxYE7jL08Q0axgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369970; c=relaxed/simple;
	bh=webmJm68io6Nn2Oq1SFL7N6q42A2csOnX4XC4Gacfxc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=gAPvoKxpLWS/hEFAoYH42PYfGf70DHvSck800M34XnPljcIVLoE914wrE2ihrCAffOp+uQphSadBP5S+NtCgUf9o/hbiw/6vrUzuzLMoT4b0DzAq4fVk8aJ8qa3IZKfHpP+6LlXdJ6HlBKZ7YXhjHr4Y+4i/3YoAdueKXtDvJFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEQ9BPVO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEQ9BPVO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B373B1F000E9;
	Thu, 21 May 2026 13:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779369967;
	bh=bHTZsPuX3xYlHnEqKO8VNWvK3yx/8QOCdsuQ+99TOyU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PEQ9BPVO8HntRNve39D8OxMZZw4/J2v+rKSk8OIWHnAVDZEnz4QU9VlF516lLWW33
	 1snVVQNt4dub7LzImRUiYGwzp7+bRiZ1FYNeiWoPgbhUwhtgrn3FBQBNMRDRzqYe/g
	 vivgUpk1NZuMG4rTk8VaAc+K08IMY4PlWGBgDqYfYbYX7L673NH886IpJa4qNXRPax
	 Ekcr4VQvK+Wzc35KEEpoPNEbDauY4cZJKeDT2beDvveQ4d1zjEkdKqBrECtYXKwqcA
	 qFAuz1zNST+EmOW9S16Vd25hXADyrx4ZM5Oe7/6tKTs9C8XTFn/w/gP7KtfWUU8V2M
	 3/ZO/TjZjLHEg==
Content-Type: multipart/mixed; boundary="===============6946542025357129357=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7773c27d0070aa7544a5a7596aceb8abacb4fbdb20a3aab998f05c39de4f20dc@mail.kernel.org>
In-Reply-To: <20260521124411.31133-12-jolsa@kernel.org>
References: <20260521124411.31133-12-jolsa@kernel.org>
Subject: Re: [PATCHv3 11/12] selftests/bpf: Add tests for uprobe nop10 red zone clobbering
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,oleg@redhat.com,peterz@infradead.org,mingo@kernel.org,mhiramat@kernel.org,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 21 May 2026 13:26:07 +0000 (UTC)

--===============6946542025357129357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index 969f4deba9fd..efff0c515184 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
> index fda3a298ccfc..8004c9568ffa 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/test_usdt.c b/tools/testing/selftests/bpf/progs/test_usdt.c
> index f00cb52874e0..0ee78fb050a1 100644
> --- a/tools/testing/selftests/bpf/progs/test_usdt.c
> +++ b/tools/testing/selftests/bpf/progs/test_usdt.c

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

Following up on a review comment from sashiko-bot: is this test reliable
across different compiler versions?

The x86-64 USDT macro uses the "nor" inline assembly constraint, which allows
the compiler to allocate these operands to CPU registers. Because there is no
register pressure in usdt_red_zone_trigger(), modern compilers might allocate
the local variables a1, a2, and a3 directly to registers rather than the
stack's red zone.

If the operands are placed in registers, the uprobe CALL optimization
clobbering [rsp-8] will not corrupt them. This could cause the test to pass
even on buggy kernels, creating a false positive.

The author acknowledged this concern but kept the test as-is, noting that
selftests compile with -O0 and there's also an assembly-based test.

Would it be safer to explicitly force these operands into the red zone using
inline assembly constraints, rather than depending on the compiler's register
allocator?

Reference:
https://lore.kernel.org/bpf/20260509021238.AE98FC2BCB0@smtp.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26227520868
--===============6946542025357129357==--
