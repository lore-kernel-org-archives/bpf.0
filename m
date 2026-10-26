Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986801;
	b=vVTN9a2du0L4o/fQ0CrIPtu/BC1e8OYZ6wEZDif8ohko8JLwvVvJmS4FrfVzs31BnPUF
	 NmkqojAG3FwopnuEgSH33Jr8D3WT7MXirnYChUzKHxj5OeRhywBzLJg36bSAdFG/LmDsk
	 8KhoiEhIULYEsLVNVG/Wab98AEGu443mydNaZk1pdWJJDzflyQn/hkGZBVxiiPCJg6qWR
	 nfH4I7L6W1Lvwj/2R/JzvCWry7Xk3RJouFeYwtWwjDGbuczkfFzan6oyYu+OwFZFfvW3n
	 1a9m7uUqpl1CQT7E0RhIJjD6vJ7PwNabwuRX5utr7qumraS5rPmQeM+8RiYRkKX1/lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986801;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=2aJea8XYDntle1gz9kmV5DwqLszdKJXahYXqu5f8iqQ=;
	b=Yos+pLzv1StKGlxki3Lx9lVY4LvAm6C7XXVI/rXS41aCIl75F1F8O2BoteXH6Nv/P4iS
	 StW6AvO5uPyhpKcYmFWAPm7+55DzXh/zU/EP2nRxNqbTkcMeNkTJQVRUj9gWP/LSBj3jh
	 OBVn0OqwVeWbkbb9kK6KmEO1JNG3zW8MuD1xZrgLeRr5TYxnqdukArt7WcPRJgtT378Y6
	 /towMMVsDmfcQs45+es/Zquh1ZG+AxRcMskOmaTZTQ5ce6CqICDF27XqZ4Ld9ep9siV4q
	 /VXtOzFYqxaO0mgWzw7qkKNCjEEQuFIRZwHp0bVaZdI0GQREaIBZ/pMqQrgqJO2+H8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V6Sx6p2b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8404606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V6Sx6p2b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716EF1F01825;
	Mon, 26 Oct 2026 03:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986800;
	bh=2aJea8XYDntle1gz9kmV5DwqLszdKJXahYXqu5f8iqQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=V6Sx6p2bRo6OqeLMBH3wUQ1Z888k7LuBC7dYwAFPBhngnQ2mgiQyDRNyM+jm8X6yL
	 yL/DOX50NQCLh8grhYM6zhCFInCtD0ulGlHVeePFfHTMSxukW2O4vS5Wt2PSg+b4Co
	 4Z/8qLopo87XHwwYnN65AxeZ1RvjxRJH5FYkplyD0/02LTsAu1FCsYwrGoUad41EKU
	 AdiPobhf3jBZHsUClWxM6x76RZXHctVRKtMIQjhIgXa4CcyC/UECKCLob7EDZkhdvb
	 nYGC7s1WBbUS2qMZP70zczpzjMidGt9AuUUPhf4UqZ/s5ked6gX+zPUlIuyBKe6ojK
	 XP87eEpVxdk9Q==
Content-Type: multipart/mixed; boundary="===============6846121162781710602=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <bdad3575392423d5e5540dfcdeccdf33a6ea457b654f9dfd4ba3403139857072@mail.kernel.org>
In-Reply-To: <20261026025943.404450-73-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-73-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 72/81] selftests/bpf: Adjust tests of pruning
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 03:53:20 +0000 (UTC)

--===============6846121162781710602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Adjust tests of pruning

TL;DR: Test issue: dead_spill_at_merge_enables_pruning and allocated_stack may
no longer test fp-8 liveness at the merge, since the stackless path arrives
first and stacksafe() passes trivially, so regressions could go undetected.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
> index 5f9b11a81260..f70b23abc702 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c

[ ... ]

> @@ -1372,13 +1370,12 @@ __naked void half_spi_clean_preserves_stack_zero(void)
>   *
>   * Static liveness marks fp-8 dead at merge. clean_verifier_state()
>   * converts path A's STACK_SPILL to STACK_INVALID. Path B has
> - * STACK_INVALID. stacksafe() matches -> path B pruned -> "6: safe".
> + * STACK_INVALID. stacksafe() matches -> one state stands for both paths.
>   */
>  SEC("socket")
> -__flag(BPF_F_TEST_STATE_FREQ)
>  __success
>  __log_level(2)
> -__msg("6: safe")
> +__msg("from 5 to 6: within")
>  __naked void dead_spill_at_merge_enables_pruning(void)
>  {
>  	asm volatile (

Does this test still check that fp-8 is dead at the merge?

When the jump state of "if r0 != 0 goto l_skip" reaches insn 6 first, path B
is the old state and path A (the one with the spill) is the state being
compared.  Path B never touches the stack, so its allocated_stack is 0 and
the loop in stacksafe() has nothing to walk:

    for (i = 0; i < old->allocated_stack; i++) {

stacksafe() then returns true whatever fp-8 holds in path A.  r6 is the
constant 7 on both paths and r0 is dead, so "from 5 to 6: within" is
printed even if liveness reports fp-8 as live and bpf_clean_verifier_state()
leaves the STACK_SPILL of path A in place.

Before this patch the fallthrough path with the spill was explored first,
and path B's empty stack matched it only if fp-8 was dead ("6: safe").  The
comments updated here still give that reasoning:

    clean_verifier_state() converts path A's STACK_SPILL to STACK_INVALID.
    Path B has STACK_INVALID. stacksafe() matches

A regression that keeps fp-8 live at the merge (the scx_lavd state growth
this test models) would no longer fail it.

Could the spilling path be the one that arrives first, for example by
putting the spill block on the jump-target side the way
step_prune_hit_const_on_line does?  Another option is to have path B store
a different kind of value to fp-8 as well.

I did not see a later patch in the series that changes this file.

> @@ -1390,7 +1387,7 @@ __naked void dead_spill_at_merge_enables_pruning(void)
>  	"call %[bpf_get_prandom_u32];"
>  	"r6 = *(u64 *)(r10 - 8);"
>  "l_skip%=:"
> -	/* fp-8 dead. Path B pruned here -> "6: safe" */
> +	/* fp-8 dead. The states of both paths are the same here */
>  	"r0 = r6;"
>  	"exit;"
>  	:

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_search_pruning.c b/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
> index f40e57251e94..f13ff9380947 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_search_pruning.c

[ ... ]

> @@ -272,7 +264,8 @@ l2_%=:	r0 = 0;						\
>
>  SEC("socket")
>  __description("allocated_stack")
> -__success __msg("processed 15 insns")
> +/* every insn once: what is written to the stack on one path is dead where the paths meet */
> +__success __msg("processed 14 insns")
>  __success_unpriv __msg_unpriv("") __log_level(1) __retval(0)
>  __naked void allocated_stack(void)
>  {

Does "processed 14 insns" still depend on the stack written by one path
being dead where the paths meet?

The new comment explains the count by the dead stack, but the order in
which the states arrive decides the result.  At "if r0 == 0 goto l0_%=" the
jump state reaches l0 before the block that spills to fp-8 and fp-9 has
run.  That jump state has written no stack, so allocated_stack is 0.

The state that did the spills then arrives and is the one being compared.
stacksafe() loops over old->allocated_stack, which is 0, and returns true.
The registers that differ (r6, r7) are dead at l0 and r0 is 0 on both
paths, so the second state is "within" and every insn is processed once.
This holds even if fp-8 and fp-9 were treated as live, and even if
stacksafe() went back to rejecting the case where
old->allocated_stack > cur->allocated_stack.

That means the test no longer covers what 19e2dbb7dd97 ("bpf: improve
stacksafe state comparison") added it for, an old state with more allocated
stack than the current one where the extra slots are not live.  Before this
patch the fallthrough path with the stack was the explored state, and the
count of 15 depended on those slots being dead.

Could the stack writes be put on the jump-target side of the branch so the
state that wrote the stack reaches l0 first?

I did not see a later patch in the series that changes this file.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============6846121162781710602==--
