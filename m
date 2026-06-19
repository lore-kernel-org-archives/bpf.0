Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8E033D4FB
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781903904; cv=none; b=WcMAz8e8wrFuq3wXJqFZoDUJUA0ZPlH/tiEi1g1Y1Ek0c0tPiol9WkBQg1IYdhmi9eMZ4rsbwUg3W3yj5jEPhyDTzpPzr+bqZEygQYyPj/kX+lpf8s6EgeWay0NLazqQfk+nMVI44kLksoV+vhYmrZ0Yf2GTRCo5HG4XFIcKLOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781903904; c=relaxed/simple;
	bh=aJLPlzC41gmNfYXR5O+6qvHlMhc8yVY1uqZDrewY/3k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mMkr7ojAgmjABRlkHy3nssl8vR9m0prVtFUmszaHAhhoHZc/VyeplkIv/UR/ueR+p4a0g/Ev3o9lFpV2sdZilwtY7MKmnPaoD2PX97RvrpR0h48oWU/1cFwAY/zRgG5BRIl6WujSOliVZ19pKgQ0Wl7tqgKPujxco9q81cJ33UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDXAKfa3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDXAKfa3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257311F000E9;
	Fri, 19 Jun 2026 21:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781903903;
	bh=/fAzrzK3fCxxYaefZT8jSye8zThK1kLpABeUY3F3PkM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gDXAKfa36bh48xixzPFSiH7sgvXmG517p01CkoZ3Qq2lEiRFBVMwdEIXWaBKkpuL+
	 SRrZ266UHnEfHji3cdKCLXF0p+sXntPLBbxIz3PuLjJULPnr7/+mgX7XhVP/t6SUsP
	 2NxEHRRKws3RO2k7rYZs2ZDUb5FXGdBSydMSO1HyhTiIDYNtIaxt5BIprz3SiDyliV
	 5aKas3ZLcUcpTw8R1cxcbZXvfPuV+vQLe3qgPZATxzf2C/YLDxQcn79RbbWTiXP1aH
	 HQauK4NMvzmQLRGE/n4PshsqDuGWT0O1liGhtyGpjIT86MtYD3+rvutyMgaJfBUX1e
	 MJHt0vbo76tgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 05/17] bpf: Track verifier register
 diagnostic events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260619205934.1312876-6-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
 <20260619205934.1312876-6-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 21:18:22 +0000
Message-Id: <20260619211823.257311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Medium] Stack read origin checking evaluates the source register state a=
fter it has already been overwritten, failing for operations where source a=
nd destination are the same register.
- [Medium] The backwards lineage tracker improperly aliases helper returns,=
 kfunc returns, and memory loads as ALU operations, leading to corrupted di=
agnostic histories.
- [Medium] Unrelated register modifications are printed while tracking a va=
lue through a spilled stack slot.
- [Medium] Silent invalidation of the primary first slot of a dynptr during=
 reference release.
- [Medium] Helper and kfunc calls silently invalidate caller-saved register=
s (R1-R5) without recording diagnostic events.
--

commit fcdc417a6c906cddea98626436d412d03ec67211
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Track verifier register diagnostic events

Record material register and outgoing stack argument changes so diagnostics
can explain how a value reached its current type, bounds, or unreadable
state. Store old and new register types, scalar ranges, tnum value and mask,
map and BTF type identity in the diagnostic event stream.

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index fa5a25b314a0a..f51b2860c11dc 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c
[ ... ]
> +static bool bpf_diag_reg_event_keeps_lineage(const struct bpf_diag_histo=
ry_event *event)
> +{
> +	if (event->reg.reason !=3D BPF_DIAG_REG_MOD_WRITE)
> +		return false;
> +
> +	switch (event->reg.opcode) {
> +	case BPF_ADD:
> +	case BPF_SUB:
> +	case BPF_MUL:
> +	case BPF_OR:
> +	case BPF_AND:
> +	case BPF_LSH:
> +	case BPF_RSH:

[Severity: Medium]
Is it possible for memory loads or helper returns to inadvertently match th=
ese
ALU opcodes? For example, check_load_mem() passes BPF_OP(insn->code), which
strips the class and could result in 0x60 (BPF_LSH) or 0x70 (BPF_RSH). Also,
helper or kfunc returns pass 0, matching BPF_ADD. Could this cause independ=
ent
assignments to be incorrectly treated as lineage-preserving operations?

[ ... ]
> +static bool
> +bpf_diag_history_event_visible(const struct bpf_diag_history_event *even=
t,
> +			       u32 idx,
> +			       const struct bpf_diag_history_filter *filter)
> +{
> +	const struct bpf_diag_history_opts *opts =3D filter->opts;
> +
> +	if (!opts || opts->scope =3D=3D BPF_DIAG_HISTORY_SCOPE_ALL)
> +		return true;
> +
> +	switch (event->kind) {
> +	case BPF_DIAG_HISTORY_BRANCH:
> +		return true;
> +	case BPF_DIAG_HISTORY_REG_MOD:
> +		return opts->scope =3D=3D BPF_DIAG_HISTORY_SCOPE_REG &&
> +		       event->reg.dst_reg =3D=3D opts->regno &&
> +		       event->reg.frameno =3D=3D opts->frameno;

[Severity: Medium]
Does this miss checking if the event index is bounded by stack_until_idx?
If we are tracking a value through a spilled stack slot, wouldn't this
unconditionally print any unrelated modifications to the register that
occurred between the stack spill and the stack fill?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ca4bba1634186..fedabb6bb515f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -6385,9 +6481,32 @@ static int check_load_mem(struct bpf_verifier_env =
*env, struct bpf_insn *insn,
>  	err =3D check_mem_access(env, env->insn_idx, regs + insn->src_reg, argn=
o_from_reg(insn->src_reg), insn->off,
>  			       BPF_SIZE(insn->code), BPF_READ, insn->dst_reg,
>  			       strict_alignment_once, is_ldsx);
> +	size =3D bpf_size_to_bytes(BPF_SIZE(insn->code));
> +	stack_origin =3D !err &&
> +		       bpf_diag_stack_read_origin(env, regs + insn->src_reg,
> +						  insn->off, size,
> +						  &stack_frameno, &stack_spi);

[Severity: Medium]
Will this correctly track stack reads if the source and destination registe=
rs
are the same (e.g., LDX r1, [r1+0])? The call to check_mem_access() updates
regs[insn->dst_reg] with the loaded value's type. If src_reg and dst_reg are
the same, evaluating the source register afterwards in
bpf_diag_stack_read_origin() would see the new state instead of PTR_TO_STAC=
K,
potentially missing the stack fill event.

[ ... ]
> @@ -8986,6 +9159,11 @@ static int release_reference(struct bpf_verifier_e=
nv *env, int id)
[ ... ]
>  			if (!stack || stack->slot_type[BPF_REG_SIZE - 1] =3D=3D STACK_SPILL)
>  				mark_reg_invalid(env, reg);
>  			else if (stack->slot_type[BPF_REG_SIZE - 1] =3D=3D STACK_DYNPTR)
>  				invalidate_dynptr(env, stack);
> +			if (regno >=3D 0)
> +				bpf_diag_record_reg_invalidate(env,

[Severity: Medium]
When a dynptr is invalidated here, does the first slot silently miss its
diagnostic event? The loop processes slots upward. For a dynptr, the second
slot is encountered first, and invalidate_dynptr() scrubs both slots. When
the iteration reaches the primary first slot, its state has already been
overwritten, so the ID check might fail and it gets skipped, leaving
users without a REF_RELEASE event for the primary dynptr pointer.

[ ... ]
> @@ -10603,6 +10829,10 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
>  	if (err)
>  		return err;
> =20
> +	bpf_diag_record_reg_mod(env, insn_idx, env->cur_state->curframe,
> +				BPF_REG_0, false, 0, 0, &old_r0,
> +				&regs[BPF_REG_0]);
> +
>  	err =3D check_map_func_compatibility(env, meta.map.ptr, func_id);

[Severity: Medium]
What happens to the caller-saved registers (R1-R5) that were scrubbed to
NOT_INIT during this helper call? It looks like we only record a diagnostic
event for the return value (R0). If a program later tries to read one of the
scrubbed registers, will the backwards trace miss this invalidation point a=
nd
show an unrelated history?

[ ... ]
> @@ -13282,6 +13514,10 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>  			return err;
>  	}
> =20
> +	bpf_diag_record_reg_mod(env, insn_idx, env->cur_state->curframe,
> +				BPF_REG_0, false, 0, 0, &old_r0,
> +				&regs[BPF_REG_0]);
> +
>  	if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_session_cookie])

[Severity: Medium]
Similar to the helper call above, does this miss recording diagnostic events
for the caller-saved registers (R1-R5) that are invalidated by the kfunc?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619205934.1312=
876-1-memxor@gmail.com?part=3D5
