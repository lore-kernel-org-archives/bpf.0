Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405876;
	b=jrD5HS0L+qPUYgB317Ne+iU2vvkGT5AWBlX8QanQdKojdynLV+BEfXsFue7upY5KGcGL
	 Bt+s24SyU8rJ4bVGxI+mTgbSNGvbXqM0s5tpYxBkFw4JYB7KWr4fJNU6UCwH3BdHsr/8i
	 ZgiPDTo6u2fQZzsi3/ymlwAVt+lmfOm0hsqobKznpzu6Z6ClSA05xSmcy0GtcsFdssTF7
	 UdT6K/ptOhg5ZvksPSaJXNomb3DDTtS+RfzXUVcTc52neGyi3KUqVcoBjRZOKzrAjUkAV
	 eSYbV68lpX14mSoNl4idk51xisF+8RENfpOQ7/XM/vHh3mgXkCOVwuPiGGnXIzcq06A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405876;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=5lQ/t/zARYjafKJoSYPIQgPZAeqOyvYOrAaTzkSG08I=;
	b=IopGnXHiDlvr30iDWp1/VeN0XHtf2wVLd6c6YwFfIZAlFyDGBfKKDZTCrDDy6j7pUyPP
	 STQrf/BkrY9YhEbf89tKWQosDwkb9RrGdFsNFGd8O65rSPZdsXNG2qLbMVrH0rF3nMq8y
	 PqxaqW5EZszSrIwK2pBIytwLgxOAykzMyxb+q7K21GM9oSjgmfSlDemV63Pr1uGomYUWj
	 ApTzEPWcUMqk+vP99roCBzJ4z73pgyDnxs2JmRySqjCa5HligAKu/4+yZDg/U8DuS1IYL
	 uiG3HfHh+1cWA9ZA8EugX3TBV8DzccFqHSaZrcAgC/Ei4SC9dX+O2uGQfzWN4wOUGOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUz5HKLd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B7D606A327
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 14:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUz5HKLd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21781F00A07;
	Wed, 11 Nov 2026 14:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794405876;
	bh=5lQ/t/zARYjafKJoSYPIQgPZAeqOyvYOrAaTzkSG08I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZUz5HKLd3HWoO9CfKnpNNs+ujhRhku5LqdI17pCDVjbTIfdbPIJQ1bt7UnY7Bhp6+
	 p8gEVI2IcIQOXtd2+nX5Ur6zc5AxzFs3+gnXAw+2NIfgf2REli8ho5FxSvsRUl6weT
	 8hclRtBNr4H9iD6DgLY3cYfR/33IDQgMQaIxDP0sC2imA8ydOjo0R6iJXCFfc3Tq5r
	 dV3asQZlOtMgqDTQI78f6xJoEh+JBp9XGsxyES3zGLVQZD+Er1ONlSrSrREAebHCQw
	 8r8X5GpTw3BY6g+Oqv943Frj83H59Ufh6CVyJ8Wt7OhY9YN0ZdCs1x805r6glDaNWl
	 TBAzjVKABk6Pg==
Content-Type: multipart/mixed; boundary="===============7858795348474572264=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <94bfc3f871d97eba10491fc8532211aea73ba38cea13a7b17c4f37579ebb2d0b@mail.kernel.org>
In-Reply-To: <9d074f026dcb520b11bb1365d7116b95e0b789c6.1794399387.git.memxor@gmail.com>
References: <9d074f026dcb520b11bb1365d7116b95e0b789c6.1794399387.git.memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 07/29] bpf: Add one allocator for hidden stack slots
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 14:04:35 +0000 (UTC)

--===============7858795348474572264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add one allocator for hidden stack slots

TL;DR:
- Stack slot allocator only caps JITed frames at 32 KiB, so later patches in
  the series may overgrow stack limits
- insert_arena_stack_get() bypasses the allocator, contradicting comments
- Misplaced struct comment (nit)

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> @@ -1208,6 +1209,13 @@ void bpf_patch_image_install(struct bpf_prog *prog, const struct bpf_patch_image
>  /* single container for all structs
>   * one verifier_env per bpf_check() call
>   */
> +/* Initialization of a hidden stack slot, emitted in the subprogram's prologue. */
> +struct bpf_stack_init {
> +	u32 subprog;
> +	s16 off;
> +	s32 imm;
> +};
> +
>  struct bpf_verifier_env {

This isn't a bug, but struct bpf_stack_init now sits between the comment that
describes struct bpf_verifier_env ("single container for all structs / one
verifier_env per bpf_check() call") and the struct itself.  Two comment
blocks are stacked on struct bpf_stack_init, and struct bpf_verifier_env has
lost its comment.

Could struct bpf_stack_init go above the bpf_verifier_env comment instead?

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -918,6 +918,87 @@ int bpf_insert_recursion_checks(struct bpf_verifier_env *env)
>  	return 0;
>  }
>  
> +/*
> + * Hidden stack slots. Post-verification rewrites need stack space the program
> + * does not know about: may_goto counters, the spill area of an inlined
> + * bpf_loop(), the context pointer a generated epilogue reads back. Such slots
> + * are reserved below the stack depth verification established for a
> + * subprogram, after bpf_remove_fastcall_spills_fills() has shrunk it, so that
> + * they sit directly under the program's own frame. Slots are 8 bytes, 8-byte
> + * aligned and handed out top down: the first slot of a subprogram lies right
> + * below its verified depth rounded up to 8 bytes.
> + */
> +static s16 next_stack_slot_off(const struct bpf_subprog_info *info)

The comment and the commit message describe this as the one allocator, with
the first slot lying right below the verified depth rounded up to 8 bytes,
and say the stack size check "covers every user".

insert_arena_stack_get() still works the old way.  It runs between
bpf_optimize_bpf_loop() and bpf_do_misc_fixups() and bumps stack_depth by
hand:

    if (s) {
        spill = round_up(sub->stack_depth, BPF_REG_SIZE);
        sub->stack_depth = spill + MAX_BPF_FUNC_REG_ARGS * BPF_REG_SIZE;
        ...
    *patch++ = BPF_STX_MEM(BPF_DW, BPF_REG_FP, i, -(spill + i * BPF_REG_SIZE));

For an arena_stack_entry callback that has a may_goto, may_goto_stack_slot()
-> bpf_reserve_stack_slots() puts its slot below the arena spill area, not
right below the verified depth.  Those arena bytes are also not counted in
stack_extra, so the "stack size %d(extra %d)" message under-reports them.

Nothing functional breaks today, since the arena pass checks env->stack_limit
itself.  Should insert_arena_stack_get() reserve its area through
bpf_reserve_stack_slots(), or should the comment and commit message drop the
"right below its verified depth" and "every user" claims?

> +{
> +	return -(s32)(round_up(info->stack_depth, BPF_REG_SIZE) + BPF_REG_SIZE);
> +}
> +
> +/* Reserve @nr slots in @subprog; @off receives the offset of the topmost one. */
> +int bpf_reserve_stack_slots(struct bpf_verifier_env *env, int subprog, int nr, s16 *off)
> +{
> +	struct bpf_subprog_info *info = &env->subprog_info[subprog];
> +	u32 depth = round_up(info->stack_depth, BPF_REG_SIZE) + nr * BPF_REG_SIZE;
> +	u32 extra = depth - info->stack_depth;
> +
> +	if ((depth > MAX_BPF_STACK && !env->prog->jit_requested) || depth > S16_MAX + 1U) {

For a JITed program the only limit applied here is S16_MAX + 1, and
check_max_stack_depth() has already run by the time this is called.  It is
not compared against env->stack_limit or MAX_BPF_STACK_JIT.

In this commit that is harmless, since every caller adds a small constant per
subprog (3 slots for bpf_loop(), 1 for the epilogue, 1 for may_goto, plus at
most 7 bytes of alignment).

The commit message says the allocator is meant for later patches that need
more hidden slots.  In this series, cd4657cd0e50 ("bpf: Track held resources
in hidden stack slots") calls it once per acquiring instruction from
bpf_frame_desc_resolve():

    ret = bpf_reserve_stack_slots(env, acq_subprog(env, a, new_of), 1, &a->off);

026679e2eda5 ("bpf: Describe held resources at throw sites") narrows this to
acquisitions that need a slot, but there is still no per-subprog cap, and no
later commit in the series adds a bound.  A subprog with N slot-needing
acquisitions grows by 8*N bytes after the stack budget was checked, up to
32 KiB per frame.  The x86 JIT emits that size directly with
emit_sub_rsp(&prog, round_up(stack_depth, 8)), while
bpf_jit_supports_large_stack() documents JIT frames only up to
MAX_BPF_STACK_JIT (2048).

insert_arena_stack_get() rejects a frame that exceeds env->stack_limit.
Should the allocator also bound JITed frames, for example against
env->stack_limit plus a small fixed allowance for the constant per-subprog
users, since it is now the only place that checks?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43027088527
--===============7858795348474572264==--
