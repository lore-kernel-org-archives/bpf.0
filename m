Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7244A3905F4
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790206625; cv=none; b=reaPkkU5OrnxiJf8aVkVnmP7YC03RrFn0gXgmlqZ/0i8dFvsxARkHi54jvwckFeIm5hdqgrqbML2BuYk9xmsc0aBVvR5pRrQbI77IF9ENPxNYHiGWt1zD7OeWkyRzQec0+m+CvNU5Tfjos5Ym/WSMtuGpy0ZSODRH3lt21vWiQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790206625; c=relaxed/simple;
	bh=yPSTXMbh37CBGmthbRsFzbNx6Xikj8IXI70+CXA9tSM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LQKi6d4kfX4zR8SeKmfrRbRc/Iyw0PtDwftJZMFFMAqrpDL7Ux9cNOKEMNP8PIGzDkgAyffU4Ld5h6VJPQMkt5Kk7klX8O8k8tYgbIwfj6ADEEVcWo+oXfix9sA7WiLKsJeFQc8Hl3S3hWxWDR0DAB01Pk4X+/JXkS0unz7RjWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrwHRiuU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrwHRiuU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4AB1F000FF;
	Wed, 23 Sep 2026 23:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790206624;
	bh=f5vKtBJskkbfb7GD3Lhcmw/W+3lkm1xAwTUSWiE4R9k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DrwHRiuUnw0M/j2jTyuHWonmJG2ysstW0wxVtCMB8Y2ZyADv2whR3K7nUPmrtEz5n
	 pF0L7M+8gH/X4SCvaPxHJsDU91NDa8YNn2IzkmaWJTkMuTGzS4zlVj8G9z/pbq6AaB
	 f9INYSPprJHcPkvvRmMSIySnWqANfXChNISSyYNZn2ZAApWcZTWwX8WdWs4aPBHoQl
	 zLnRgBaGopBDlpfihefeHGhJBoZsTIEY/0fKQVCZdaj3fkOX40Qc/n9eBHbxfxl6mj
	 ndDy4yj1uWLFa2V/aPhexwsNnOznslZFQN49I6sPIzCHpcb2sBwtdox3UBG1QhySx7
	 81dv3mdSd0cDw==
Content-Type: multipart/mixed; boundary="===============5101018974809254939=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7aaf2aca8bbbed1a2a89d5819cf5f6c5e0181a746995abf727027a07ffc238ec@mail.kernel.org>
In-Reply-To: <20260923223554.562379-3-alexei.starovoitov@gmail.com>
References: <20260923223554.562379-3-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 2/8] bpf: Mark loop heads in check_cfg()
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 23:37:02 +0000 (UTC)

--===============5101018974809254939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 92f528c456052..5a08f079a4896 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -709,6 +709,9 @@ struct bpf_insn_aux_data {
>  	u32 non_stack_access:1; /* instruction can access non-stack memory */
>  	/* true if some jump or call instruction targets this instruction */
>  	u32 jump_target:1;
> +	u32 loop_head:1; /* target of a back-edge */
> +	u32 backedge_ft:1; /* the edge to the next insn is a back-edge */
> +	u32 backedge_br:1; /* the jump is a back-edge */

Do these comments accurately describe what push_insn() records? The bit
seems to be chosen by push_insn()'s e argument rather than by where the edge
actually goes.

Looking at visit_insn() in kernel/bpf/cfg.c, it walks the only edge of an
unconditional jump as FALLTHROUGH:

kernel/bpf/cfg.c:visit_insn() {
    /* unconditional jump with single edge */
    ret = push_insn(t, t + off + 1, FALLTHROUGH, env);
}

For a backward goto/gotol, wouldn't the jump back-edge set backedge_ft, with
backedge_br staying clear even though "the jump is a back-edge"?

Similarly, for ldimm64 (including the pseudo func load) the FALLTHROUGH edge
goes to t + 2, not t + 1, and for the pseudo func the BRANCH edge goes to a
callback entry which is not a jump.

This mismatch affects the series. is_backedge() in de2a4da618ff needs its
own note ("check_cfg() does not record the edge of an unconditional jump as
a jump"). It picks the bit with insn_idx == prev + 1, which means it reads
backedge_br for a back-edge that is the fall-through of an ldimm64 (do_check()
goes from t to t + 2 with prev_insn_idx == t). It does the same for the
fall-through of a call to a static subprog, where env->prev_insn_idx at
callsite + 1 is the callee's BPF_EXIT (prepare_func_exit()). In both cases
loop_head_guard() then skips the may_goto guard.

Could the comments say these are the FALLTHROUGH and BRANCH edges as
check_cfg() walks them? That would clarify the intent for later readers.

>  	/*
>  	 * CFG strongly connected component this instruction belongs to,
>  	 * zero if it is a singleton SCC.
> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> index 842c7d1eabccc..748bf544d3ba5 100644
> --- a/kernel/bpf/cfg.c
> +++ b/kernel/bpf/cfg.c
> @@ -137,8 +137,14 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
>  		insn_stack[env->cfg.cur_stack++] = w;
>  		return KEEP_EXPLORING;
>  	} else if ((insn_state[w] & 0xF0) == DISCOVERED) {
> -		if (env->bpf_capable)
> +		if (env->bpf_capable) {
> +			env->insn_aux_data[w].loop_head = true;
> +			if (e == FALLTHROUGH)
> +				env->insn_aux_data[t].backedge_ft = true;
> +			else
> +				env->insn_aux_data[t].backedge_br = true;
>  			return DONE_EXPLORING;
> +		}
>  		verbose_linfo(env, t, "%d: ", t);
>  		verbose_linfo(env, w, "%d: ", w);
>  		verbose(env, "back-edge from insn %d to %d\n", t, w);

Loop heads and back-edges are recorded here in push_insn(). But check_cfg()
also finds back-edges in visit_gotox_insn(), which still drops them without
recording:

kernel/bpf/cfg.c:415 visit_gotox_insn() {
    /* EXPLORED || DISCOVERED */
    if (insn_state[w])
        continue;
}

A DISCOVERED target at that point is a back-edge of the indirect jump. It
sets neither loop_head on w nor a backedge bit on t. So the commit message's
"check_cfg() finds back-edges ... Remember their targets as loop heads"
doesn't hold for gotox. Loops closed by a computed goto (goto *jt[i] to a
label at the loop top, as exercised in selftests/bpf/progs/bpf_gotox.c) get
no loop head. A gotox back-edge to a head marked through another edge also
looks like an entry edge.

Nothing reads the bits in this commit. But the later commits in
8f70ee36d2ef..7d6b7dd8cb91 assume every back-edge is recorded:

de2a4da618ff ("bpf: Widen scalars at loop heads"): is_backedge() returns
aux->backedge_ft || aux->backedge_br for any BPF_JA prev insn. For gotox
that is always false. The same commit changes the EXACT-repeat check in
bpf_is_state_visited() so that under widen_loops it prunes (loop = true)
instead of reporting "infinite loop detected".

3a779857709c ("bpf: Add may_goto to loops that are not walked to the end"):
loop_head_guard() returns true without a guard when !is_backedge().
bpf_mark_loop_guard() has an explicit gotox case (op == BPF_JA &&
BPF_SRC(insn->code) == BPF_X -> "not a jump" -> guard_impossible). That case
can never be reached, because the bits are never set for gotox.

Scenario at 7d6b7dd8cb91 (bpf_capable):

  head:
      v = *(volatile u32 *)map_val;
      goto *jt[v & 1];        /* jt = { &&head, &&out } */
  out:
      return 0;

push_insn() sees no back-edge, so there is no loop head. visit_gotox_insn()
makes the gotox insn a prune point. On the second trip the state there is
EXACT equal to the in-progress one, so it is pruned with widen_used. The out
target leaves the SCC, so "loop ... never exits" does not fire.
bpf_commit_loop_guards() has no guard_pending or guard_impossible to act on,
and the program is accepted with nothing bounding the loop at run time.
Before the series this was rejected with "infinite loop detected". The same
happens if head also has a conditional back-edge: that edge gets a may_goto,
but the gotox edge does not.

Should visit_gotox_insn() also mark loop_head on DISCOVERED targets and
record the back-edge on the gotox insn (for example backedge_br)? The later
bpf_mark_loop_guard() would then set guard_impossible and fall back to
walking every iteration.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35929952632
--===============5101018974809254939==--
