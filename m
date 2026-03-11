Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ED32C0285
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256597; cv=none; b=s958ivO6Ecpxlb9YMWzjvNKBaNch2uMZ4SRX4ghTaFDgwlDcUiYaIQRSnqtky+dagFU2Yjjb8Kc5r1HdvJimmKrUGm5yTvNyWMggMzaOwbdB5KrDUPEFn7RRaJ8dvY0a1goOB4i0n7olK20AxgyqW+/zlpPd+awC6fkZvd/zbSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256597; c=relaxed/simple;
	bh=+icc9+c3N2hlRHY58RvrKLg0Qx9AWLNZL+KqtSJkxvE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tKi8xlUjXMXkFjMe6H6MOQtDc8YNMgxIOXWKo9JjBQj69a6gL/+ikeaRdoldFih9FJhVSJ3qVT6ERD2Mq+C2qPJ2rxBh/aYjyb0IfutiXbjoXkXACyIzgnGocsLaWWIojhqEo4i2Cg6j9X7G5XGRK6ZSYS3nGGeaLH8/cXahYtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOWI4qGy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOWI4qGy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A49C4CEF7;
	Wed, 11 Mar 2026 19:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773256597;
	bh=+icc9+c3N2hlRHY58RvrKLg0Qx9AWLNZL+KqtSJkxvE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=dOWI4qGy5mB4ztCLpEknlsHwQ2Cg1YPZHDtfI/TFTrKkHuAwBWsEGkKgKLrqAtMM/
	 tj5E6e5bj3G/pXmxtU/E2tMDXEXTQzcTY3LIGwryaPFSEyX0RLySkEiRJW/tF9UXxQ
	 kKUlnWRNHuCEZ8AaK8E+e40K1lwozJplpGG+vlRD5rjqLP/iOpk7Rq11qKKtz3SNX8
	 dfF/M3zVfvfiBY5VnniSaM7deSEyekurhYJ2XujBxeLm5/gaRFKTnVMipmAODeIpqC
	 vwaZecskyOsmvkczERVqX9yvWcxYUFVpA5fgm5sjujF1MFYZz73jnki6/dJGWmP2zh
	 1WlZtHRix0kiw==
Content-Type: multipart/mixed; boundary="===============3922635577407982661=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5e8af34fe927be2c273db8459897fb1f29616b91e7b21f4430c9d414734f6a40@mail.kernel.org>
In-Reply-To: <20260311182831.91219-2-emil@etsalapatis.com>
References: <20260311182831.91219-2-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Only enforce 8 frame call stack limit for all-static stacks
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,martin.lau@kernel.org,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,emil@etsalapatis.com,yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 11 Mar 2026 19:16:37 +0000 (UTC)

--===============3922635577407982661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4fbacd2149cd..0304e4329490 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6733,9 +6733,11 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  	struct bpf_insn *insn = env->prog->insnsi;
>  	int depth = 0, frame = 0, i, subprog_end, subprog_depth;
>  	bool tail_call_reachable = false;
> -	int ret_insn[MAX_CALL_FRAMES];
> -	int ret_prog[MAX_CALL_FRAMES];
> -	int j;
> +	int total;
> +	int tmp;
> +
> +	/* no caller idx */
> +	env->dinfo[idx].caller = -1;

The function header comment above this hunk still reads:

    Since recursion is prevented by check_cfg() this algorithm
    only needs a local stack of MAX_CALL_FRAMES to remember callsites

The local stack arrays (ret_insn[] and ret_prog[]) have been removed
in favor of per-subprog dinfo fields. Should this comment be updated
to reflect the new approach?

This was also noted during the v3 and v4 reviews:
https://lore.kernel.org/bpf/ad397307a9cd76c9739ee05f4642c7b6a881b7dfb8a2facefa6b2062ffe328ea@mail.kernel.org/

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/test_global_func3.c b/tools/testing/selftests/bpf/progs/test_global_func3.c
> index 142b682d3c2f..974fd8c19561 100644
> --- a/tools/testing/selftests/bpf/progs/test_global_func3.c
> +++ b/tools/testing/selftests/bpf/progs/test_global_func3.c

[ ... ]

>  SEC("tc")
> -__failure __msg("the call stack of 8 frames")
> +__failure __msg("the call stack of 9 frames")
>  int global_func3(struct __sk_buff *skb)
>  {
>  	return f8(skb);

Should this be "the call stack of 8 frames" rather than 9?

The test has 9 subprogs total (global_func3 plus f1 through f8), but
only 8 call levels. The entry function global_func3 starts at frame 0
and is not itself counted by the frame increment. Each static call
increments frame by one:

    check_max_stack_depth_subprog() {
        ...
        frame = subprog_is_global(env, idx) ? 0 : frame + 1;
        if (frame >= MAX_CALL_FRAMES) {
            verbose(env, "the call stack of %d frames is too deep !\n",
                frame);

With 8 static calls (global_func3 -> f8 -> f7 -> ... -> f1), frame
reaches 8, which matches MAX_CALL_FRAMES. The verifier would print
"the call stack of 8 frames is too deep" and the __msg substring
check for "9 frames" would not match, causing the test to fail.

The old test with global functions also had 8 call levels and
expected "8 frames", since frame++ produced the same count of 8.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22968848938
--===============3922635577407982661==--
