Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD50943DA3A
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 07:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780645227; cv=none; b=G4ql1yEnE3xyTXDq2TsKokxxBQjAd74jWG+ybRXlJ9znRK6YoL1w3cmRljzhEcbeN1jaspHupDcnlwDrBYXSLV7onXal4GOV/fs+F2SSntbpYazcDVxzc6ZntNEIhVz8ryHFDtJ8gdfb9ViFTZM3YC65AM7HmMGoDEBbpCgNwWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780645227; c=relaxed/simple;
	bh=4UEp8EnTQuvBC6uUWJl0KOvnuaj7PhSSqZ+CUP0Hji4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fMmMdVsSI0xF40OYencuikpEnW3bP/qVFVU5/0mvFiPRA9NX8yjuOHppnAeyry+e7mNLEajvafEx+eLhlW4KsqnOqQ2sAybWYfCn++FLwVszw+g5bL8NwXGkXxVIPL7ZPm9XmbSkj3JTIILYLRWbcoIgv4hZpCziBakdZdSVb8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5wLYvy4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5wLYvy4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FC11F00893;
	Fri,  5 Jun 2026 07:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780645226;
	bh=AtfAdSva0k22oIaEcBjTwJrMoSQBCAmAC52cwkHPHMM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=E5wLYvy47cnQdsS1XCRQX1pmW2zTSkk4EZo0wmfKYTtjN9VFG2uQ2q4ZPI3IFYS+Y
	 VI6kFDaSU11RXl07y7JuIRDd8xgKgs6MR1SBnvNUH/48hy3b0FHPRlVcPAwIVUXCYx
	 y0PK1abgDKD7kJOrkQGBt0cn10zQuP8T/tXsjseYIXjdLTucCHyYzmDXLtwdYmETFh
	 ZxJN8bVESCIaf9VxYK2llkhFZpW7a6RiSB8FtK31GpRMW7/NoBc/MpGRM9p8i/3P54
	 Lc6TtU/OlhLiBsVcbNwujzLvOdQQrteoGwPKW+jqnvwckzpVA1KjOPE1f1tzIl7F4d
	 HwDRf4oshbQPw==
Content-Type: multipart/mixed; boundary="===============7150221955091616804=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a3f527db5bedecd64019bd6de054e671bc5156c8cb5d4953635f386e2902483f@mail.kernel.org>
In-Reply-To: <20260605063412.974640-6-memxor@gmail.com>
References: <20260605063412.974640-6-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 05/17] bpf: Track verifier register diagnostic history
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 07:40:26 +0000 (UTC)

--===============7150221955091616804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 50cc50a394ca..1bdc7e69fbce 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c

[ ... ]

> @@ -609,11 +718,379 @@ void bpf_diag_record_branch(struct bpf_verifier_state *state, u32 insn_idx,

[ ... ]

> +static void bpf_diag_record_reg_mod_reason(struct bpf_verifier_state *state,
> +					   u32 insn_idx, u8 dst_reg,
> +					   bool src_valid, u8 src_reg,
> +					   u8 opcode,
> +					   enum bpf_diag_reg_mod_reason reason,
> +					   const struct bpf_reg_state *old_reg,
> +					   const struct bpf_reg_state *new_reg)
> +{
> +	struct bpf_diag_history_event event = {
> +		.insn_idx = insn_idx,
> +		.kind = BPF_DIAG_HISTORY_REG_MOD,
> +		.reg.dst_reg = dst_reg,
> +		.reg.src_reg = src_reg,
> +		.reg.opcode = opcode,
> +		.reg.src_valid = src_valid,
> +	};
> +
> +	if (state && state->frame[state->curframe])
> +		event.reg.frameno = state->frame[state->curframe]->frameno;

Can this record the wrong frame number for registers invalidated in caller
frames?

bpf_diag_record_reg_invalidate() ends up here, and it is called from
clear_all_pkt_pointers() and release_reference(), both of which iterate over
all active frames:

	bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
		...
		bpf_diag_record_reg_invalidate(env->cur_state, ...);
	}));

But this assignment hardcodes the currently-executing frame via
state->curframe, so a register that lives in a caller frame is recorded with
event.reg.frameno set to the current frame.

bpf_diag_history_start_idx() and bpf_diag_history_event_visible() then filter
on opts->frameno:

	event->reg.frameno == opts->frameno

so those caller-frame events would be mis-scoped.

The parallel stack-arg path takes an explicit frameno parameter and passes
state->frameno through bpf_diag_record_stack_arg(). Should the register
invalidate path accept the actual frame number of the register from the
caller in the same way?

This was raised by Sashiko AI review on v1
(https://lore.kernel.org/bpf/20260605065301.A27671F00893@smtp.kernel.org)
and the thread has no response so far.

> +	bpf_diag_snapshot_reg(&event, reason, old_reg, new_reg);

[ ... ]

> +static void bpf_diag_format_reg_snapshot(struct bpf_verifier_env *env, char *buf,
> +					 size_t size,
> +					 const struct bpf_diag_reg_snapshot *snapshot)
> +{
> +	const char *type_name = reg_type_str(env, snapshot->type);
> +	char offset_desc[BPF_DIAG_REG_DESC_LEN];
> +	char btf_type[BPF_DIAG_REG_DESC_LEN];

Can this chain use too much kernel stack?

BPF_DIAG_REG_DESC_LEN is 512 bytes. bpf_diag_format_reg_snapshot() puts two
512-byte buffers here, plus a third 512-byte 'range' buffer in the
SCALAR_VALUE branch:

	if (snapshot->type == SCALAR_VALUE) {
		char range[BPF_DIAG_REG_DESC_LEN];

and it also calls bpf_diag_format_var_offset(), which allocates another
512-byte buffer:

	static void bpf_diag_format_var_offset(char *buf, size_t size, ...)
	{
		char range[BPF_DIAG_REG_DESC_LEN];

Its caller bpf_diag_print_reg_mod() allocates two more 512-byte buffers and
calls bpf_diag_format_reg_snapshot() twice:

	char old_buf[BPF_DIAG_REG_DESC_LEN], new_buf[BPF_DIAG_REG_DESC_LEN];

	bpf_diag_format_reg_snapshot(env, old_buf, sizeof(old_buf), ...);
	bpf_diag_format_reg_snapshot(env, new_buf, sizeof(new_buf), ...);

Could this >3KB stack-usage chain trip CONFIG_FRAME_WARN, or cause problems on
architectures with smaller kernel stacks?

This was raised by Sashiko AI review on v1
(https://lore.kernel.org/bpf/20260605065301.A27671F00893@smtp.kernel.org)
and the thread has no response so far.

> +	bpf_diag_format_var_offset(offset_desc, sizeof(offset_desc), snapshot);

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d60e1309957a..188201d48108 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4033,6 +4033,8 @@ static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_s
>  	struct bpf_subprog_info *subprog = &env->subprog_info[state->subprogno];
>  	int spi = -off / BPF_REG_SIZE - 1;
>  	struct bpf_reg_state *arg;
> +	struct bpf_reg_state old_arg;
> +	bool slot_exists;
>  	int err;

[ ... ]

> +	slot_exists = spi < state->out_stack_arg_cnt;

[ ... ]

> +	arg = &state->stack_arg_regs[spi];
> +	if (slot_exists)
> +		old_arg = *arg;
> +	else
> +		bpf_mark_reg_not_init(env, &old_arg);

Does this pass uninitialized stack memory to bpf_mark_reg_not_init()?

When slot_exists is false, old_arg is declared without initialization.
bpf_mark_reg_not_init() reaches __mark_reg_unknown() ->
bpf_mark_reg_unknown_imprecise(), which reads reg->subreg_def into a local
before it memset()s the struct:

	u32 subreg_def = reg->subreg_def;
	...
	memset(reg, 0, sizeof(*reg));

Could reading that uninitialized subreg_def trigger a KMSAN
use-of-uninitialized-value report?

This was raised by Sashiko AI review on v1
(https://lore.kernel.org/bpf/20260605065301.A27671F00893@smtp.kernel.org)
and the thread has no response so far.

> @@ -8833,14 +8867,51 @@ static int check_func_proto(const struct bpf_func_proto *fn, struct bpf_call_arg
>   * This also applies to dynptr slices belonging to skb and xdp dynptrs,
>   * since these slices point to packet data.
>   */
> +static int bpf_diag_stack_arg_slot(const struct bpf_func_state *state,
> +				   const struct bpf_reg_state *reg)
> +{
> +	if (!state->stack_arg_regs)
> +		return -1;

This isn't a bug, but the two new helpers are inserted between the packet-data
comment block and the function it describes. The comment above
('Packet data might have moved... turn them into unknown SCALAR_VALUE...
dynptr slices belonging to skb and xdp dynptrs') now sits directly over
bpf_diag_stack_arg_slot(), which just computes a register's index within
state->stack_arg_regs[] and has nothing to do with packet data. Should the new
helpers be moved below clear_all_pkt_pointers(), or the comment moved down to
stay attached to it?

> +	if (reg < state->stack_arg_regs ||
> +	    reg >= state->stack_arg_regs + state->out_stack_arg_cnt)
> +		return -1;
> +	return reg - state->stack_arg_regs;
> +}
> +
> +static int bpf_diag_func_regno(const struct bpf_func_state *state,
> +			       const struct bpf_reg_state *reg)
> +{
> +	if (reg < state->regs || reg >= state->regs + MAX_BPF_REG)
> +		return -1;
> +	return reg - state->regs;
> +}
> +
>  static void clear_all_pkt_pointers(struct bpf_verifier_env *env)
>  {

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27000182395
--===============7150221955091616804==--
