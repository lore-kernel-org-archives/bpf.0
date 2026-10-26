Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986790;
	b=5tR9PhpZLXzBKnvSQDCULkFGlbmlru1zvZDOUisjHEUF7BrJOuJHe6ugP636Kj7P/0hW
	 hjC2St8tBUgyVluobqb5ZyEsAfR9g4Ct3tCNsmPZ11rOBlbmXImyILFWpsp1+0u7lHd5N
	 PDpXS8vushZI1MBE+E93Qwc7zn02ezn3Bm1vxoefdOPrGHYa484POfLaDigKYpCh07L3E
	 amq+eB6PmlSDdv3hLrVMTnkQe1IuVjbAIYIalk3itNaWYOHOsLTyBt37wI1g8UvbV6Gmv
	 w2YurVoTopC+bldqGZ52RI1CzK3robdmo+AQJeo0ypH88ahEUBqBDScfCPdBjgG5K/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986790;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=13SwEaoje2bLqsfU6uiuZ5svQXW3xxnCgGbuuvzT5S8=;
	b=Jiat9QlZHYFMyuZU6tuofhFfIptUaxj13VbziUZsIWQWSHVMjQeDH86fLUcuOvLf42d5
	 7jO/XVmj8JqpidxamEicMMKQSm9VG1S9s8jO5jNNuvCw3Yj5EcIY0GGzuno+WJiBTvGrd
	 bNXflVW/S9j/nXaYQ+Z6JiRsvN14KxY9Igs8Sa2qJ4ojqOCmaNwbMl0gPXqX4NbuGbzOV
	 20NLpq4Ac74cNHicpB4/QH8RSEQQpm4J9pJuyijkPHZNrReCBx7p74bZl0rawhk2gcFpZ
	 1KCEpQNH1lSaPWkIDVSAy3M9nPFO6Qoxo3/8g9XixL9WZEaD3YYkGjwa7VamIUD/s+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eDOUXI2t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7256C606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eDOUXI2t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212701F01825;
	Mon, 26 Oct 2026 03:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986790;
	bh=13SwEaoje2bLqsfU6uiuZ5svQXW3xxnCgGbuuvzT5S8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eDOUXI2tux9JXBwWZtf5eZYi6thwDfq9rl0FVSgaUAibrXmexO0kmiIxGkJQbhQfI
	 PxF2lsm/UUiEq5khZndzQqHPQEReJwpXp16LsWgvjT6WnlA2ibAl72WRy3+VW3B2D5
	 Jz6/APwRdbfOg/yYNqKpW9HpA99VdPljxc5pLhDl5aqlTvlimziRYr5wIXixVbsAIh
	 iQYfz8+SVLrXZKaJ4w8GR/VZ9Rn7A23IIzoIQWrHpKRSZklAavyPyKwJ+7J8reEJ7L
	 K2+KjFQ91HaS10OyTtd0oQFgogpenTUCDRyntJvsKbjRFAt/3AC5zwjFKkKyzsgu/T
	 sHNia+oWZB1CQ==
Content-Type: multipart/mixed; boundary="===============4755173098738928709=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <a33e3b2265ff09d164b355836217b24a89b32a48bde6ae6302b4e9e4b262a858@mail.kernel.org>
In-Reply-To: <20261026025943.404450-82-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-82-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 81/81] selftests/bpf: Test callx of one of a set of functions
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 03:53:10 +0000 (UTC)

--===============4755173098738928709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test callx of one of a set of functions

TL;DR: Test nit only: callx_rodata_one_of_two() duplicates
callx_rodata_var_index(); could the log-level and R2=func(one_of=2) message
checks go on the existing test instead?

> diff --git a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
> index 85141cd73298..2575313a977a 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c

[ ... ]

> @@ -173,6 +173,226 @@ __naked void callx_rodata_array_of_structs(void)
>  		: __clobber_all);
>  }
>
> +/* one state with one of two functions, and not two states */
> +SEC("socket")
> +__success __retval(11)
> +__log_level(2)
> +__msg("r2 = *(u64 *)(r2 +0)          ; R2=func(one_of=2)")
> +__naked void callx_rodata_one_of_two(void)
> +{
> +	asm volatile (
> +		FUNC_TABLE2(tbl, add1, add2)
> +		"call %[bpf_get_prandom_u32];"
> +		"r6 = r0;"
> +		"r6 &= 1;"
> +		"r3 = r6;"
> +		"r3 <<= 3;"
> +		"r2 = tbl_%= ll;"
> +		"r2 += r3;"
> +		"r2 = *(u64 *)(r2 + 0);"
> +		"r1 = 10;"
> +		"callx r2;"
> +		"r0 -= r6;"
> +		"exit;"
> +		:
> +		: __imm(bpf_get_prandom_u32)
> +		: __clobber_all);
> +}

This isn't a bug, but callx_rodata_one_of_two() has the same body as the
existing callx_rodata_var_index() in this file: the same
FUNC_TABLE2(tbl, add1, add2) table, the same instructions, and the same
__retval(11).

The only addition is the __log_level(2) and __msg("... R2=func(one_of=2)")
check, so the file now contains two copies of one program.

Could the __log_level(2) and __msg() annotations go on
callx_rodata_var_index() instead of adding a copy?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============4755173098738928709==--
