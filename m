Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986787;
	b=GgQ3yrp91QbkJ89lLFAcNYt2RyEKM9KG495j+U0iIvnibzB21Nf/FaLjuRYJt3kvA75J
	 jTas0LT/tSajuY9Jd+ZR92S5YSsRpXQDX4vngFLVzYq+95r86Gi1sz69Aa7kKVGljG69h
	 J3g5snJqGMUc2SDOTOL/i1NNx04/4Uu9rm3yLvsDBnJab3OYZP6xmQqtG1BJQQW8VUhq9
	 9p5U3BOyK2ScPP8sHGHb39H7m4mXHlbnB3dI0LBP9aLfPioez9J62dHEL9v99wdcnNE2C
	 ajCNJrUdPbQa4N2Mt/61C6FGf1Wmp1eKvh8wSOSx1z8mwcRyXKqPYxWuapwanTCrKlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986787;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=JVqKKyGaEOMbBLeAjQBq7tiBBPkO66xsAitbMHTNlZc=;
	b=jbGC/ZC7ZKgIEFC/nhIbZNVoIuImbOaBAnHj4kEMmsfX16yhOzpr/GvQDO04KfVrLnNJ
	 8KTNbN0iDugiklgjBG5p5b3NESGnO4oiwcrwkAFQjqMWx2RoOAzpSUorJzbDgTgXLOp2f
	 nF5w6GbgZ4AkEHYCiJUHD1TtABpmvovpHeCeD5Iu4RKElL2rr4tLxkNb1y/oNqs0lwHHj
	 KtSrK36BLf7/+KiuDNfYZhKtz/ZuR+qmrMz6yYkpAiaYQnvSFcGevdxhXv3zvR+5QJfF8
	 oiukuG4iHI4T6IuK3ljPm2LcHSr5NzL+dvwqAvgyY73CKoG4S25eSC9keYPLgVQMXdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IMNbWdvp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C56F606A31B
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IMNbWdvp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687111F01825;
	Mon, 26 Oct 2026 03:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986786;
	bh=JVqKKyGaEOMbBLeAjQBq7tiBBPkO66xsAitbMHTNlZc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IMNbWdvpqOFhySLoNbDLuzM98LUqcyw93EuTihFlNCt51c4lGK0PiCQWTipkSu7Js
	 wIej3rdt729FVIRP11ahkV4SZwzCsW75LgHNugIGlSoT8g39f0amLQd1KIaQvFqMa4
	 L9SmwuGhY6s8KtgIIuCVWvfVShyLk6sJRWnl72vE4+QONUVXaTI611Y/fRcRpq4u1Q
	 NCdCGv/vQ7rezA39kOxhVlktqfxQTEqfpHcjaMugHWwtQXSJP//+NyeH5QpsNvpM/C
	 m37MH4j61k8v+1gCPaf29quEsaMWdOIvYP4P7q3kZbBZbcdoxJaEYh6noR672n0Jw9
	 OOExLNbu/e0ww==
Content-Type: multipart/mixed; boundary="===============7759510558170164353=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <3f8bb194092b69358f64d6578900fd63ce1bb5f0a719276109d92b62fcfb0cce@mail.kernel.org>
In-Reply-To: <20261026025943.404450-66-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-66-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 65/81] bpf: Update comments about paths, pruning and explored states
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 03:53:06 +0000 (UTC)

--===============7759510558170164353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Update comments about paths, pruning and explored states

TL;DR: Comment-only patch; the new verifier.c comment may overstate that
joining makes analysis length follow program size, since flow.c keeps states
apart and enforces limits. Suggests rewording.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -62,19 +62,16 @@ static bool bpf_global_percpu_ma_set;
>
>  /* bpf_check() is a static code analyzer that walks eBPF program
>   * instruction by instruction and updates register/stack state.
> - * All paths of conditional branches are analyzed until 'bpf_exit' insn.
>   *
> - * The first pass is depth-first-search to check that the program is a DAG.
> + * The first pass is depth-first-search over the control flow graph.
>   * It rejects the following programs:
> [ ... ]
> - * The second pass is all possible path descent from the 1st insn.
> - * Since it's analyzing all paths through the program, the length of the
> - * analysis is limited to 64k insn, which may be hit even if total number of
> - * insn is less then 4K, but there are too many branches that change stack/regs.
> - * Number of 'branches to be analyzed' is limited to 1k
> + * The second pass goes from basic block to basic block, starting at the 1st
> + * insn. States that meet at the start of a block are joined, so the length of
> + * the analysis follows the size of the program and not the number of paths
> + * through it. See flow.c.
>   *
>   * On entry to each instruction, each register has a type, and the instruction
>   * changes the types of the registers depending on instruction semantics.

Is it accurate to say that states meeting at the start of a block are
joined, and that the length of the analysis therefore follows the size of
the program?

The commit message itself says the verifier drops a state that is covered,
"Otherwise it joins the two states or keeps the two", and flow_merge() in
kernel/bpf/flow.c deliberately keeps joinable states apart while there is
room:

    /*
     * States that have a join are kept apart while there is room: half of
     * every limit.  After that they are joined, which may lose what the
     * prog needs, and does not run into the limit.
     */
    if (!widen && flow_has_room(env, flow->nr_states[insn_idx]) &&
        flow_null_differs(&t->st, &s->st))
            continue;
    ...
    if (!widen && flow_has_room(env, flow->nr_states[insn_idx]) &&
        (flow_unset_differs(&t->st, &s->st) ||
         flow_join_makes_up(flow, &t->st, &s->st)))
            continue;

States of a different flow_kind() are never compared or joined, and when
bpf_states_join() finds no join (for example scalars that differ while
env->explore_alu_limits is set, which the sanitize_ptr_alu() comment in
this same patch describes as keeping states apart), the state is added to
the set with list_add_tail(&s->node, set).

bpf_flow_loop_enter() also walks some loops one iteration at a time, with
each trip a separate kind of state:

    /*
     * There is no summary of what the loop does to something that is
     * live.  Go through the iterations one by one if that is not too long.
     */
    if (err == 2 && flow_walk_factor(cur) * iters.max_header_count *
                    loop->nr_insns <= BPF_FLOW_MAX_WALK) {
            ...
            entry->apart = true;

For such a loop the work follows the trip count, up to BPF_FLOW_MAX_WALK
insns, which is not the size of the program.

What bounds the work is the set of limits in flow.c
(BPF_FLOW_TOTAL_PER_INSN / BPF_FLOW_MAX_STATES), and a program over them
fails with -E2BIG ("too many states for %d insns" or "more than %d states
that cannot be joined").  The new text drops every mention of a limit and
gives joining as the reason for the bound.

The header comment in flow.c describes the three outcomes (dropped, joined,
added) correctly.  Could this summary match it, for example:

    A state that arrives at the start of a block is dropped if a state
    there covers it, joined with one if possible, or kept; the number of
    states is bounded by the size of the program, see flow.c.

No later commit in be06e70f1a7f..51224d16c11b changes this comment.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============7759510558170164353==--
