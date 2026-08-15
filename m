Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216753CFF6F
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786779293; cv=none; b=l5Zb16mWhjaLxTKZVpLa5YpsCBza6VFK06wnpTc6gLMrwQPQEm8Fu0e6bdKESti2gGrpuKHbmpeN8ttAtY6fnYIVhkIh9UnPugrycLVYKDLpnpbsvHB5ao5k5ZlG1NMydxjqzYIjHL9W43scQuFxS2tq0fz4Eli/Qv9ArNcGTWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786779293; c=relaxed/simple;
	bh=owcmF2hOB2B84oK0DSSAP/ltU4Xp/hxMzy6VgTGAcU4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Q4OA9XF+NkbAtkvoIC0RN0G2eO7tO0K2FARyV62MGEYxn17N14r8zoJMYXQKdqnQIB3i33tsIlFYOchor/oXCraCJHylddAX/3yPLipLbbsg+FFDDLJcP5oXJ/zIiFiriEQxtgMp5T9Ry1fSnhm5VfGxOJVJNwHu7qMUd0U2yYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ds9VquBl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ds9VquBl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136981F000E9;
	Sat, 15 Aug 2026 07:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786779291;
	bh=tqXcMJru/zo2DGiScyfrTILR2yXDaYUrgZ4vmUT93MI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ds9VquBl9F4OZ78bjEXTYtccG0QrOeUKm9MEnzNPuZPk6RtG7gD/X4LMs932RHaij
	 drM55PHfsHRHjFJJtUU4lIzi0txPu8TAN+A7kAvpLDBWdcqLU9dttKfCwJ3Lv4b6oj
	 nUcklQ3O07zHNYUwr6sdKCln/0zWvlFQYX/Gpl24mYdiPlSS/XEfONx+rhqMbErV9G
	 tCyoWCyzysTM0ZWJbl7rqLJLPiUIHFOzU9WTaa7xxQ4vCtlzTYWmbNij2aQnPAxzjZ
	 b33I0rbyahFXwMTnKAWJcRWmimTmbUTrupMwQ4WIelJW5DdAjNJJD1bky2hLTPyzoR
	 Wd/44CrBUjaHA==
Content-Type: multipart/mixed; boundary="===============6145267046529845591=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <48e6f021b89562f68850fe21ef8c78719819b04cf9c4e4f50bc791937d37ace8@mail.kernel.org>
In-Reply-To: <20260815064612.378577-6-memxor@gmail.com>
References: <20260815064612.378577-6-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v5 05/14] bpf: Track verifier register diagnostic events
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 15 Aug 2026 07:34:51 +0000 (UTC)

--===============6145267046529845591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 8f21b46adeca..2e8e75815581 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c

[ ... ]

> @@ -665,3 +787,237 @@ void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool con
>
>  	diag_append_history(env, &event);
>  }
> +
> +static bool diag_mod_keeps_lineage(struct bpf_verifier_env *env,
> +				   const struct bpf_diag_history_event *event)
> +{
> +	const struct bpf_insn *insn;
> +	u8 class;
> +
> +	if (event->mod.reason != BPF_DIAG_MOD_WRITE ||
> +	    event->mod.target.kind != BPF_DIAG_MOD_TARGET_REG)
> +		return false;
> +
> +	insn = &env->prog->insnsi[event->insn_idx];
> +	class = BPF_CLASS(insn->code);
> +	if (class != BPF_ALU && class != BPF_ALU64)
> +		return false;
> +
> +	switch (BPF_OP(insn->code)) {
> +	case BPF_ADD:
> +	case BPF_SUB:
> +	case BPF_MUL:
> +	case BPF_OR:
> +	case BPF_AND:
> +	case BPF_LSH:
> +	case BPF_RSH:
> +	case BPF_ARSH:
> +	case BPF_XOR:
> +	case BPF_NEG:
> +	case BPF_END:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static void diag_record_mod(struct bpf_verifier_env *env, u32 insn_idx,
> +			    struct bpf_diag_mod_target target,
> +			    enum bpf_diag_mod_reason reason,
> +			    const struct bpf_reg_state *old_reg,
> +			    const struct bpf_reg_state *new_reg,
> +			    const struct bpf_diag_mod_target *origin)
> +{
> +	struct bpf_diag_history_event event = {
> +		.insn_idx = insn_idx,
> +		.kind = BPF_DIAG_HISTORY_MOD,
> +		.mod = {
> +			.target = target,
> +			.reason = reason,
> +		},
> +	};
> +
> +	if (old_reg)
> +		diag_snapshot_reg(&event.mod.old, old_reg);
> +	if (new_reg)
> +		diag_snapshot_reg(&event.mod.new, new_reg);
> +	if (origin) {
> +		event.mod.origin = *origin;
> +		event.mod.origin_valid = true;
> +	} else if (diag_mod_insn_origin(env, insn_idx, &target, &event.mod.origin)) {
> +		event.mod.origin_valid = true;
> +	}
> +	if (old_reg && new_reg &&
> +	    (reason == BPF_DIAG_MOD_WRITE || reason == BPF_DIAG_MOD_SPILL) &&
> +	    !memcmp(&event.mod.old, &event.mod.new, sizeof(event.mod.old)) &&
> +	    !event.mod.origin_valid &&
> +	    diag_mod_keeps_lineage(env, &event))
> +		return;
> +
> +	diag_append_history(env, &event);
> +}

Can the `reason == BPF_DIAG_MOD_SPILL` disjunct ever be true here?

The test is a conjunction and its last term calls diag_mod_keeps_lineage(),
which opens with:

    if (event->mod.reason != BPF_DIAG_MOD_WRITE ||
        event->mod.target.kind != BPF_DIAG_MOD_TARGET_REG)
        return false;

So the overall condition can only be true when reason is BPF_DIAG_MOD_WRITE.
Whenever reason is BPF_DIAG_MOD_SPILL, diag_mod_keeps_lineage() returns
false on its first test.

Additionally, diag_mod_keeps_lineage() also requires target.kind ==
BPF_DIAG_MOD_TARGET_REG, but every spill event targets a stack slot (the
only producer of BPF_DIAG_MOD_SPILL is save_register_state() where
reg_to_target() resolves the stack slot address to
BPF_DIAG_MOD_TARGET_STACK_SLOT).

The two other callers of diag_record_mod() pass new_reg == NULL, failing
the leading old_reg && new_reg guard. Furthermore, save_register_state()
always passes a non-NULL origin, which sets origin_valid and also fails the
!event.mod.origin_valid term.

So the SPILL mention appears to have no effect. Either it should be dropped,
or diag_mod_keeps_lineage() needs to accept spill events if redundant no-op
spill filtering was genuinely intended.

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index db644690ac4b..a5929e40f18d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -10518,12 +10594,14 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  		return err;
>
>  	/* reset caller saved regs */
> +	bpf_diag_record_caller_saved(env, regs);
>  	for (i = 0; i < CALLER_SAVED_REGS; i++) {
>  		bpf_mark_reg_not_init(env, &regs[caller_saved[i]]);
>  		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
>  	}
>  	invalidate_outgoing_stack_args(env, cur_func(env));
>
> +	bpf_diag_mod_begin(env, &regs[BPF_REG_0], NULL, BPF_DIAG_MOD_WRITE);
>  	/* update return register (already marked as written above) */
>  	ret_type = fn->ret_type;

Looking at the call sites where check_helper_call, check_kfunc_call,
check_ld_abs, and check_func_call handle R0, the three other sites open
the modification scope before clearing caller-saved regs:

check_kfunc_call (verifier.c):

    bpf_diag_record_caller_saved(env, regs);
    bpf_diag_mod_begin(env, &regs[BPF_REG_0], NULL, BPF_DIAG_MOD_WRITE);
    for (i = 0; i < CALLER_SAVED_REGS; i++) { ... bpf_mark_reg_not_init(...); }

check_ld_abs (verifier.c):

    bpf_diag_record_caller_saved(env, regs);
    bpf_diag_mod_begin(env, &regs[BPF_REG_0], NULL, BPF_DIAG_MOD_WRITE);
    for (i = 0; i < CALLER_SAVED_REGS; i++) { bpf_mark_reg_not_init(...); ... }

check_func_call (verifier.c):

        bpf_diag_mod_begin(env, &caller->regs[BPF_REG_0], NULL, BPF_DIAG_MOD_WRITE);
        clear_caller_saved_regs(env, caller->regs);

But in check_helper_call the scope is opened after the loop, so
target_reg_snapshot captures the already-clobbered NOT_INIT value rather
than R0's real pre-call state.

This also bypasses the bpf_diag_record_caller_saved() effect on R0.
bpf_diag_record_caller_saved() deliberately starts at i = 1, skipping
caller_saved[0] == BPF_REG_0, because R0 is expected to be covered by the
paired mod scope. With the scope opened after the loop, nothing captures
R0's pre-call state.

The visible effect is that every helper call reports "R0 changed from
uninitialized value to <ret type>" instead of the actual prior value. For
RET_VOID helpers, old and new are byte-identical, producing "R0 changed
from uninitialized value to uninitialized value".

Would moving bpf_diag_mod_begin() above the CALLER_SAVED_REGS loop fix this
so it matches the other three sites?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31870608176
--===============6145267046529845591==--
