Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938F121018A
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 02:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778812312; cv=none; b=tbyDLsFro2SrA6Uk3SpABZK3dqp30n1J40NJNYzLGYyHCP1kZrOHG0Md3Dyw91nJVvGhCiWRjxyGiH5N5cQwhsZg/wISCfYNLtFH3P+Q7Y9nrKbiGiHZhquKmj9X55qUxehzy2sQ7Mt4k2QlZQFMXugdLLvuMBEPPhx7uy+w6Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778812312; c=relaxed/simple;
	bh=vYBvgqhNJWuVsQNVNX1rBnTfy/lN5xcdhLnEQBXDuj8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=exB9rAN+KD6mzGuJyYTE/QFz/ze+EWqIzV1vshB9zLrx6TiXaW+I4RZOziRWASmb3q9f+FLk8cbaf74WqmmJ/O4SbX8jaNC2gHoGUJf5+1CGWshJFgwX1XlYJgjLA2jgvoJCZ2MC7YENBaUao6lVUBWzVYaWYP5feVSiSOYBTAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMPwFWtF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMPwFWtF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FD8C2BCC7;
	Fri, 15 May 2026 02:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778812312;
	bh=vYBvgqhNJWuVsQNVNX1rBnTfy/lN5xcdhLnEQBXDuj8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=PMPwFWtFZQrmTFbKj4veV5pkIpsJoKxOPb5BW4EEzVnzWO+e7ZL2ePQ7xiPcSIPa3
	 OCBLX3cpq+ubAb2TO5PAv6e4Ix7HO+PRC5pcpHeorVGJa/I0f/uAqX6Dn36hzyMjmA
	 E1c1wZhg61+Ik+5SWKmSDnJ/j8lgJk0uLMZL6EA5Bm9VU+xNuqRGO4I8JK9X6imBXE
	 Z8hdLQbeJ9oiuyGZXHwt7IKcKcHefpxosvDbjkuh47LPBhtxxS8sKtde9JwjZNHMuv
	 1PEhTkV5DfZ4hOR/B9VWiC0P8rhWT4Nj8GiePV0NJfT0X8+477whRJHL+qdgWyw5UI
	 7JrGEq2cSudeg==
Content-Type: multipart/mixed; boundary="===============6456408550383577941=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <eae0af1b3acf0a3f60cbdb86d1b43161f2241f80a07c27c3fae2e929a389e87a@mail.kernel.org>
In-Reply-To: <20260515015003.1187170-1-yonghong.song@linux.dev>
References: <20260515015003.1187170-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add test for stack arg read without caller write
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 15 May 2026 02:31:51 +0000 (UTC)

--===============6456408550383577941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_order.c b/tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_order.c
> index da34e8456b6c..99bc115f8380 100644
> --- a/tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_order.c
> +++ b/tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_order.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> index d43a9b42034c..d45339b83795 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> @@ -152,7 +152,7 @@ __naked void stack_arg_pruning_type_mismatch(void)
>  SEC("tc")
>  __description("stack_arg: release_reference invalidates stack arg slot")
>  __failure
> -__msg("R{{[0-9]}} !read_ok")
> +__msg("callee expects 6 args, stack arg1 is not initialized")
>  __naked void stack_arg_release_ref(void)

[ ... ]

>  SEC("tc")
>  __description("stack_arg: pkt pointer in stack arg slot invalidated after pull_data")
>  __failure
> -__msg("R{{[0-9]}} !read_ok")
> +__msg("callee expects 6 args, stack arg1 is not initialized")
>  __naked void stack_arg_stale_pkt_ptr(void)

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
> index 1240cf8a40d6..c9fe4857da3f 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
> @@ -112,6 +112,64 @@ __naked void stack_arg_pruning_load_after_call(void)
>  	);
>  }
>
> +/*
> + * "bad_ptr": the first arg is 'long *', which is not a recognized pointer
> + * type for static subprogs (not ctx, dynptr, or tagged).  btf_prepare_func_args()
> + * sets arg_cnt = 7 / stack_arg_cnt = 2, then fails with -EINVAL.  The subprog
> + * is marked unreliable but the call still proceeds for static subprogs.
> + */
> +__noinline __used __naked
> +static void subprog_bad_ptr_7args(long *a, int b, int c, int d, int e, int f, int g)
> +{
> +	asm volatile (
> +		"r0 = *(u64 *)(r11 + 8);"
> +		"r1 = *(u64 *)(r11 + 16);"
> +		"exit;"
> +		::: __clobber_all
> +	);
> +}
> +
> +SEC("tc")
> +__description("stack_arg: read without caller write")
> +__failure
> +__msg("callee expects 7 args, stack arg1 is not initialized")
> +__btf_func_path("btf__verifier_stack_arg_order.bpf.o")
> +__naked void stack_arg_read_without_write_1(void)
> +{
> +	asm volatile (
> +		"r1 = 0;"
> +		"r2 = 0;"
> +		"r3 = 0;"
> +		"r4 = 0;"
> +		"r5 = 0;"
> +		"call subprog_bad_ptr_7args;"
> +		"exit;"
> +		::: __clobber_all
> +	);
> +}
> +
> +SEC("tc")
> +__description("stack_arg: read with not-initialized caller write")
> +__failure
> +__msg("R0 !read_ok")

Is the expected error message correct here? Looking at
stack_arg_read_without_write_1 (the test just above), it expects the
new-style message "callee expects 7 args, stack arg1 is not
initialized" when calling subprog_bad_ptr_7args without writing to the
stack. This test (stack_arg_read_without_write_2) also calls
subprog_bad_ptr_7args without properly initializing the stack args, but
expects the old-style message "R0 !read_ok" instead.

The commit message explains that invalidated stack arg slots are now
caught by check_outgoing_stack_args() at the call site instead of at
the callee's dereference, which led to updating the expected messages
in stack_arg_release_ref and stack_arg_stale_pkt_ptr from "R0
!read_ok" to "callee expects 6 args, stack arg1 is not initialized".

This test writes to r11-8 and r11-16 (stack args for the 6th and 7th
parameters), then calls subprog_bad_ptr_7args twice without rewriting
the stack between calls. The pattern matches stack_arg_sequential_calls
in verifier_stack_arg.c which expects the new-style error message.

Should this test expect "callee expects 7 args, stack arg1 is not
initialized" to be consistent with the other tests and the commit's
stated behavior change?

> +__btf_func_path("btf__verifier_stack_arg_order.bpf.o")
> +__naked void stack_arg_read_without_write_2(void)
> +{
> +	asm volatile (
> +		"r1 = 0;"
> +		"r2 = 0;"
> +		"r3 = 0;"
> +		"r4 = 0;"
> +		"r5 = 0;"
> +		"*(u64 *)(r11 - 8) = 0;"
> +		"*(u64 *)(r11 - 16) = 0;"
> +		"call subprog_bad_ptr_7args;"
> +		"call subprog_bad_ptr_7args;"
> +		"exit;"
> +		::: __clobber_all
> +	);
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25896151874
--===============6456408550383577941==--
