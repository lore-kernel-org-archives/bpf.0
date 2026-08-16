Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC2B32B123
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 02:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786847461; cv=none; b=HTU3KgI/kUEm2BLGal4hiwZoO0mRbBkgLhO45hmm7sjya2quAiqNgpvDyD86m5y0QuaTWpost5kaLOD3713aJjQVrI8/hJYOVtHFw9XfgVp3GXpQuB5YLO5QfiZcVOL02h5B14Xe5SXzkVwFXO9ErYWVOIrEqqo47dBOcJ0QMic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786847461; c=relaxed/simple;
	bh=3YrusdpBHwqlA2KUnGduy0aUfvyeqaMyjFcedW30jwg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GgpZsmtfmskmNTz0dNZXDwDjPmwjx0ywAzfutW0a/XBo+oTKrPjDTiYeRM9EhB51qnAqEJ2FgQw61BatOcwUUmmvVc+4odQUjCzV/d+6fX/E3EC+0mvWwrg6BTH3FSqfqgFoh4v7TDUyaIK2gSqOhMEdSykcYD0Ny5k2o2zorLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HA6nV9BA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HA6nV9BA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD1D1F000E9;
	Sun, 16 Aug 2026 02:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786847459;
	bh=UlMR7bUsjnkPFXMbuO1u3BUKfc5LjhzPaunNtBQvTy0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HA6nV9BA8qSavFVEME+EL9NlBbLSb+Y7PxtCaLDZT579X9nk3ezJnzU5h4viNm2h3
	 dh+mFmcen1NK9r9KScajyxS8ASsmiK6o0noJfd0R9NjVnvNGSsIPQSgS3kFtRRuqrR
	 Ljrm9wa4vjgr/uV2mkTPMkQYIsVaMgF9mY/5UtYwEn5dtZgNm2fMmMrqzCbgNRhy7C
	 odPTfAdUagJxLfjXa+qA6E+Qkd1h4Bsf/BV/xEjDf5Cb9A/3i6qCYyCd4IBGu8xNwY
	 9YDXw3tkQuseSFbGyAaUut/+Q8q4f0QUz6Gy5RoBjibRmqs+2cnEUOrs0Fi1G7Uofm
	 qkeqKn/K/6mEQ==
Content-Type: multipart/mixed; boundary="===============3525562802431023028=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4f50ce2b6d7a797d977cd80a04a3012fc7dd0c7e57a8cf043f13fe88fee89cc2@mail.kernel.org>
In-Reply-To: <20260816015746.2632990-4-memxor@gmail.com>
References: <20260816015746.2632990-4-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 03/14] bpf: Preserve R0 lineage across helper calls
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: sashiko-bot@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 16 Aug 2026 02:30:59 +0000 (UTC)

--===============3525562802431023028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5d0a2d3ef594..7ef324e384f4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11024,13 +11024,13 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>
>  	/* reset caller saved regs */
>  	bpf_diag_record_caller_saved(env, regs);
> +	bpf_diag_mod_begin(env, &regs[BPF_REG_0], NULL, BPF_DIAG_MOD_WRITE);
>  	for (i = 0; i < CALLER_SAVED_REGS; i++) {
>  		bpf_mark_reg_not_init(env, &regs[caller_saved[i]]);
>  		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
>  	}
>  	invalidate_outgoing_stack_args(env, cur_func(env));
>
> -	bpf_diag_mod_begin(env, &regs[BPF_REG_0], NULL, BPF_DIAG_MOD_WRITE);
>  	/* update return register (already marked as written above) */
>  	ret_type = fn->ret_type;
>  	ret_flag = type_flag(ret_type);

Does this produce the correct diagnostic message for void helpers? The
new bpf_diag_mod_begin() is now opened unconditionally for all helpers,
including those with RET_VOID. Because the snapshot is taken before the
caller-saved clearing loop, a void helper now generates a history event
with R0's real pre-call value as old and NOT_INIT as new, with reason
BPF_DIAG_MOD_WRITE.

Looking at the return type handling:

  switch (base_type(ret_type)) {
  ...
  case RET_VOID:
      regs[BPF_REG_0].type = NOT_INIT;
      break;
  ...
  bpf_diag_mod_end(env);

And the diagnostic rendering in diag_print_mod():

  bpf_diag_source(env, event->insn_idx, label,
                  "%s changed from %s to %s", target_desc, old, new);

So a call to bpf_spin_lock(), bpf_spin_unlock(), bpf_ringbuf_submit(),
bpf_ringbuf_discard(), bpf_ringbuf_submit_dynptr(),
bpf_ringbuf_discard_dynptr() or bpf_tail_call() would now report
"update: R0 changed from <live value> to <invalid>", attributing the
loss of R0 to a value update by a helper that returns nothing, instead
of to the caller-saved clobber.

The correct rendering for caller-saved invalidation is one reason code
away: "R0: call invalidated this caller-saved register; previous value
was <live value>".

The commit message states the new ordering matches the kfunc, ld_abs,
and subprogram call paths, but check_func_call() explicitly
distinguishes the void case:

  if (returns_void)
      bpf_diag_record_scrub(env, &caller->regs[BPF_REG_0],
                            BPF_DIAG_MOD_CALLER_SAVED);
  else
      bpf_diag_mod_begin(env, &caller->regs[BPF_REG_0], NULL,
                         BPF_DIAG_MOD_WRITE);
  clear_caller_saved_regs(env, caller->regs);
  invalidate_outgoing_stack_args(env, cur_func(env));

Could check_helper_call() gate the bpf_diag_mod_begin() call the same
way using base_type(fn->ret_type) == RET_VOID? The impact is limited to
diagnostic text only - no bpf_reg_state, verifier decision, or
memory-safety behaviour changes - but the misattribution would be new.

---

>     bpf: Preserve R0 lineage across helper calls
>
>     check_helper_call() clears all caller-saved registers before taking the
>     diagnostic snapshot of R0. This records NOT_INIT as the old state for every
>     helper return and loses the lineage of the value held in R0 before the call.
>     bpf_diag_record_caller_saved() deliberately skips R0 because the paired
>     modification scope is responsible for it.
>
>     Open the R0 modification scope before clearing caller-saved registers,
>     matching the kfunc, ld_abs, and subprogram call paths.
>
>     Reported-by: Sashiko <sashiko-bot@kernel.org>
>     Link: https://lore.kernel.org/bpf/20260815073833.A93A91F000E9@smtp.kernel.org/
>     Link: https://lore.kernel.org/bpf/48e6f021b89562f68850fe21ef8c78719819b04cf9c4e4f50bc791937d37ace8@mail.kernel.org/
>     Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

This looks like a bug fix. Should this include:

  Fixes: af4ea6e20fff ("bpf: Track verifier register diagnostic events")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31921026518
--===============3525562802431023028==--
