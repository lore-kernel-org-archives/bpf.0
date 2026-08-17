Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB52C368D55;
	Mon, 17 Aug 2026 21:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001870; cv=none; b=dXdbQl1P7CWfAwuxFJZJIsL2w4IA/2U6Znt9qyMNd6LqtxRWZ7Z+d/H63k6aKmd+LXH7RXxKnxrcU3Af+iSbkMtwL6j6Oi2eqiispLXZqaK7eSqT4aR5mrbIDmkZHVD1PS7Ui3jrtzspf4QCTFJ4cy1DlDRpOgWBC2J05by1iFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001870; c=relaxed/simple;
	bh=kbPccW+QV61y/fyCx4owudpniOJDfJuX2MuiNVfaQ5k=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LrjTv1ymSzydlH3J9d9naIGm1hnINF+yxnIrmeXKtoqScmnJGcdS03FOfr/GKf3o+SwATpHG9sEjBD7r19ZC5u1vgOBmefP6CDm+Ig67zAMJ65lnD9Eo4I47Qk9boqCTs84NyuLDofQrrr4wKawr7Bf5VzTVrvIsJFCjYg9Qjz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuJgv+9D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuJgv+9D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9771F000E9;
	Mon, 17 Aug 2026 21:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787001869;
	bh=JPWFiiWpWuYqUJtssk/3YG6PQ6MgjeMs26B9Kg+RJr8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kuJgv+9DjVCx51oPPrLF8/aKD5jBXzbaWZixBYQV0AwIvMk3RV7NN48sZDqaiJPea
	 sHic0fDkIx2L15xz/+P9b/N+qyQyKdXr50URnpQ6URjXppbk22SCtC3g13ITQoMbet
	 GI7VwTGxA4IGW8tMS54PBiLIYEiL1Ik8l+gmi2w3X8fSoRSioQMntjo7vsncx8HT62
	 uKnl6vnqJ+G2ZUfHS+aVWWQJ5wuonRpHgbfwimAh9aJKnXwsCik6kBu64rAX+GF8TZ
	 lA0/KWXUaEkF6LWP57e0am2aEc316VgiGMPW27Lk7mLrJ4oyHgGxZ9kkxW3LyZjNpi
	 23KMBdNvF9uqg==
Content-Type: multipart/mixed; boundary="===============8274770517646471948=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <43ebb3103b9f3c2ab8e5323a70262d80679c84389aebdf9980ec99217ead1271@mail.kernel.org>
In-Reply-To: <20260817204812.1637171-3-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260817204812.1637171-3-Jeremy.Jean@oss.cyber.gouv.fr>
Subject: Re: [PATCH v2 2/2] selftests/bpf: add callback stack-argument rejection test
From: bot+bpf-ci@kernel.org
To: Jeremy.Jean@oss.cyber.gouv.fr,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,yonghong.song@linux.dev
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,Jeremy.Jean@oss.cyber.gouv.fr,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 17 Aug 2026 21:24:28 +0000 (UTC)

--===============8274770517646471948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> index 7e0ce5db28a0..50b276fc2c3f 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> @@ -27,6 +27,13 @@ static int subprog_7args(int a, int b, int c, int d, int e, int f, int g)
>  	return a + b + c + d + e + f + g;
>  }
>
> +__noinline __used
> +static int callback_9args(__u32 index, void *ctx, long a3, long a4,
> +			  long a5, long a6, long a7, long a8, long a9)
> +{
> +	return a9;
> +}
> +
>  __noinline __used
>  static long subprog_deref_arg6(long a, long b, long c, long d, long e, long *f)
>  {
> @@ -79,6 +86,31 @@ __naked void stack_arg_two_subprogs(void)
>  	);
>  }
>
> +SEC("tc")
> +__description("stack_arg: callback with incoming stack args")
> +__failure
> +__naked void stack_arg_callback_many_args(void)
> +{
> +	asm volatile (
> +		"r6 = 0;"
> +		"*(u64 *)(r11 - 32) = 0;"
> +		"*(u64 *)(r11 - 24) = 0;"
> +		"*(u64 *)(r11 - 16) = 0;"
> +		"*(u64 *)(r11 - 8) = 0;"
> +		"r1 = 1;"
> +		"r2 = %[callback_9args];"
> +		"r3 = 0;"
> +		"r4 = 0;"
> +		"call %[bpf_loop];"
> +		"r0 = 0;"
> +		"exit;"
> +		:
> +		: __imm_ptr(callback_9args),
> +		  __imm(bpf_loop)
> +		: __clobber_common, "r6"
> +	);
> +}

A subsystem pattern flags this as potentially concerning: the test
appears to be rejected by a pre-existing verifier check even without
the kernel change it is supposed to cover (9b1ccc65b120 "bpf: reject
stack-argument callback subprograms"), so it may pass on both a fixed
and an unfixed kernel.

On a kernel WITHOUT 9b1ccc65b120:

The four `*(u64 *)(r11 - N) = 0` stores in func#0 go through
check_stack_arg_write() which records `subprog->max_out_stack_arg_cnt = 4`
for subprog 0. The only call in func#0 is the helper `bpf_loop`. Helper
callback dispatch goes through push_callback_call(), which never updates
`caller_info->stack_arg_cnt`. Only check_func_call() (pseudo-call to a
real subprog) and check_kfunc_call() do that accounting. func#0's own
arg_cnt is 1, so bpf_in_stack_arg_cnt(subprog 0) == 0 and
subprog_info[0].stack_arg_cnt stays 0.

At the end of a successful verification, bpf_check() calls
bpf_fixup_call_args(), which computes for subprog 0:

    outgoing = subprog->stack_arg_cnt - bpf_in_stack_arg_cnt(subprog) = 0 - 0 = 0;
    if (subprog->max_out_stack_arg_cnt > outgoing)   /* 4 > 0 */
            verbose(env, "func#%d writes %u stack arg slots, but calls only require %u\n", ...);
            return -EINVAL;

The program is refused with -EINVAL regardless of the new check.

The four r11 stores are not optional: they are needed to get past
check_outgoing_stack_args() which returns -EFAULT for uninitialized
incoming callback slots, and push_callback_call() propagates -EFAULT.
So any program shaped this way trips the pre-existing fixups check, and
the shape that would actually load on a pre-patch kernel (and produce
the KASAN OOB described in 9b1ccc65b120) additionally needs a
same-frame pseudo-call to a >5-arg subprog so that
subprog_info[0].stack_arg_cnt matches max_out_stack_arg_cnt.

Additionally, discrimination is impossible as written: this is the only
`__failure` case in the file with no `__msg()` (compare other failure
cases in the file), and test_loader.c only asserts that
bpf_object__load() returns any error. The new kernel check returns a
bare -EINVAL with no verbose() output, so no __msg is even available.

Could the test be strengthened to ensure it actually exercises the new
check rather than a pre-existing one? For instance, by adding a
same-frame pseudo-call to match stack_arg_cnt, or by adding a __msg()
directive once the kernel patch includes a distinctive verbose() message?

> +
>  SEC("tc")
>  __description("stack_arg: read from uninitialized stack arg slot")
>  __failure


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32068993990
--===============8274770517646471948==--
