Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4108922332E;
	Thu, 21 May 2026 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369967; cv=none; b=KFdyqooOTVdl50Z/rwuv6y8pLASOo44MoS9KyD7WlMilbzkk0QrnBBoEhWvHx2tnIjNgaSLimz2k7xllKSNUwHBjc0lx+r5XwMktL2rdGmQOV/vwpdTOTWKt8V7CebYOGNPZRIgVdHB0S/+epEzN5lqSxHRpfGrpzq3EE3ztThE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369967; c=relaxed/simple;
	bh=+nskVXn8YLsgST26DpsnpviZUK32fjLrbIjZaq9dKAI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Y9KMMF6sk78lZauIPsykwFmgJutocCVK4FnQoDIdrJEu6JK3BVv4hjiLagKuZ4ZfqoHK4Cw1xYIP5VPAtwiURHUwZ1sTABk+EYBtvdEr7WtfTRPJYHGY7iSdEZiY6QN5Lbu+1uSvNf2WsklylQYuihAGa+BpwlZdEf+MetFIsbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkxOPmTW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkxOPmTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87CE1F000E9;
	Thu, 21 May 2026 13:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779369965;
	bh=udnhbms2AZ6NF1KnnCgVQc1JF3BU+KgaJGAulBs6Bsc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gkxOPmTW+0/4X+RsxEICBCj7J7Zc62fDhxdp2yzX/Hs/Y0kPygY1EwqCKu25QFr9F
	 R8/60yIxOjiGRmz3ZaHb9davlK6RLCHCdneGRlqLUDRSRC+sz3jAwcTd3CtWpCyROo
	 CtNJ7pta7iGVgdykd2J3SmRKZxk+LvGBdKw4rXUHd53ti8DKZ8+SEFgGq9OVY2QVXo
	 kDWad06HIu/5E+sE6B/mRlIZq8XW0ZtmSR/BRj8ufKd9mVn38e1y1NVkoB0yIrut39
	 fmojIT/RFRk7WY8m4mhOki5ckypWc7YyEp57R9E+V6jeFfzPXwOPPyh+RvO3OEmuOe
	 8u/TWb1kcYIpQ==
Content-Type: multipart/mixed; boundary="===============2532556505416087578=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <09bc3983509b9b4f7c115d5ad6369831e76ecc130950221e497fe5dc4686de5b@mail.kernel.org>
In-Reply-To: <20260521124411.31133-9-jolsa@kernel.org>
References: <20260521124411.31133-9-jolsa@kernel.org>
Subject: Re: [PATCHv3 08/12] selftests/bpf: Change uprobe syscall tests to use nop10
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,oleg@redhat.com,peterz@infradead.org,mingo@kernel.org,mhiramat@kernel.org,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 21 May 2026 13:26:05 +0000 (UTC)

--===============2532556505416087578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index c944136252c6..9653fb5608f2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c

[ ... ]

> @@ -388,14 +388,15 @@ static int find_uprobes_trampoline(void *tramp_addr)
>  	return ret;
>  }
>
> -static unsigned char nop5[5] = { 0x0f, 0x1f, 0x44, 0x00, 0x00 };
> +static unsigned char nop10[10]  = { 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 };
> +static unsigned char lea_rsp[5] = { 0x48, 0x8d, 0x64, 0x24, 0x80 };
>
> -static void *find_nop5(void *fn)
> +static void *find_nop10(void *fn)
>  {
>  	int i;
>
> -	for (i = 0; i < 10; i++) {
> -		if (!memcmp(nop5, fn + i, 5))
> +	for (i = 0; i < 128; i++) {
> +		if (!memcmp(nop10, fn + i, 10))
>  			return fn + i;
>  	}
>  	return NULL;

[ ... ]

> @@ -432,7 +434,7 @@ static void check_detach(void *addr, void *tramp)
>  {
>  	/* [uprobes_trampoline] stays after detach */
>  	ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
> -	ASSERT_OK(memcmp(addr, nop5, 5), "nop5");
> +	ASSERT_OK(memcmp(addr, jmp2B, 2), "jmp2B");
>  }

Is jmp2B declared somewhere? The identifier is used in memcmp() but does
not appear to be defined anywhere in the file or included headers. A
subsequent commit later in the series replaces this with a properly
declared nop10_prefix array, confirming this is likely a missing
definition.

The pre-patch code referenced the defined static array nop5, but the new
code references an undeclared symbol that will cause a compilation error.

> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
> index 69759b27794d..fda3a298ccfc 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> @@ -252,7 +252,7 @@ extern void usdt_1(void);
>  extern void usdt_2(void);
>
>  static unsigned char nop1[1] = { 0x90 };
> -static unsigned char nop1_nop5_combo[6] = { 0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 };
> +static unsigned char nop1_nop10_combo[11] = { 0x90, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 };
>
>  static void *find_instr(void *fn, unsigned char *instr, size_t cnt)
>  {
>  	int i;
>
>  	for (i = 0; i < 10; i++) {
>  		if (!memcmp(instr, fn + i, cnt))
>  			return fn + i;
>  	}
>  	return NULL;
>  }

Is the loop in find_instr() adequate to find this instruction sequence?

In uprobe_syscall.c, find_nop10() was updated to search up to 128 bytes
to account for compiler-generated prologues:

tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c:find_nop10() {
	for (i = 0; i < 128; i++) {
		if (!memcmp(nop10, fn + i, 10))
			return fn + i;
	}
}

If a modern compiler generates a prologue longer than 9 bytes for
usdt_2(), find_instr() will prematurely terminate and cause the
subtest_optimized_attach() test to fail. This was acknowledged in v2
review with "yea find_instr needs same update, will fix" but remains
unchanged.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26227520868
--===============2532556505416087578==--
