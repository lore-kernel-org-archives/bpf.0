Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C50347516
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642383; cv=none; b=NRHPE+pSjJiLZMH5JC9ImQDAZ7PHACCUQWAdt8u4m9vLlgnWBuUUmc7+0M5HTLC0nSRZSj3qgkenw2QLrV++Z6DJP9nOBdj9BS8cjSa4QnwMgpSYQBsodRR+7QtZsjP+qIA9PuiAJ3NsPkZU5TB8qDB6YYAwlW30op35mwpfNPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642383; c=relaxed/simple;
	bh=mh58Ti/GrXIfvw4T7l/Aq66pfjzcwiQYnRSfdMDxLQQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jdXqkROxErFTyrqB4Oj7s5B+0hwo8bKCFpQmUULkjmIzDu7MTq8Sg82cRZzlqySEzSzaZEHt/0YaC65frlE4lXZk8zq+mtIeczenSdPxDAEiyux8NflG8Z3wJOwOp9+4im4eFzMwss1rzRLktPv4Aw58lgygtDrPMP08YOYhDW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFOpZL3S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFOpZL3S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27671F00893;
	Fri,  5 Jun 2026 06:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780642381;
	bh=lL0ec0x49Lvv6obhb7MjkS7Z7yzV9KJXjFylvIZrOyI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lFOpZL3SXr2z7gf/lw0/aSfPvATSH4cEEi0alU800dn3LazRglV7BZfb/RJ1373kJ
	 fHVIEetVq1CNwTfsuDJBNZgzb8a/vT1qqV0IihPkFRh9bodFa/JQRePKwMBXpfv/42
	 2BoHFFbZkFOLcEa72LIznCi9Ucns8nCIpd26m7F8onsGblo2ucCKELkQ3XG2D8Pr0Q
	 D+UfzpZHbbDACY5kNaBWNzIGgYM4LCeVUr5Jq5YfNmj5UkyX/XfyPviAdmz9jXeFTA
	 24hmeMDzkSicZ6x9E6vWVVlS+qiII/GodXQVqoyxpLS5WLf6rgbOtutDmzezubtjgl
	 RoV3O7KHHKe5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 05/17] bpf: Track verifier register
 diagnostic history
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605063412.974640-6-memxor@gmail.com>
References: <20260605063412.974640-6-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 06:53:01 +0000
Message-Id: <20260605065301.A27671F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Excessive stack allocation in diagnostic formatting functions can =
cause kernel stack overflows.
- [Medium] Uninitialized stack memory read in check_stack_arg_write() due t=
o uninitialized old_arg.
- [Medium] Diagnostic history records incorrect frame numbers for registers=
 invalidated in caller frames.
--

commit 9a17934339f89b801d41d6242f00c9032267ab0f
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Track verifier register diagnostic history

Record material register and outgoing stack argument changes so diagnostics=
 can
explain how a value reached its current type, bounds, or unreadable state.
Store old and new register types, scalar ranges, tnum value and mask, map a=
nd
BTF type identity, and basic operand metadata.

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 50cc50a394cae..1bdc7e69fbced 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c
[ ... ]
> +static void bpf_diag_record_reg_mod_reason(struct bpf_verifier_state *st=
ate,
> +					   u32 insn_idx, u8 dst_reg,
> +					   bool src_valid, u8 src_reg,
> +					   u8 opcode,
> +					   enum bpf_diag_reg_mod_reason reason,
> +					   const struct bpf_reg_state *old_reg,
> +					   const struct bpf_reg_state *new_reg)
> +{
> +	struct bpf_diag_history_event event =3D {
> +		.insn_idx =3D insn_idx,
> +		.kind =3D BPF_DIAG_HISTORY_REG_MOD,
> +		.reg.dst_reg =3D dst_reg,
> +		.reg.src_reg =3D src_reg,
> +		.reg.opcode =3D opcode,
> +		.reg.src_valid =3D src_valid,
> +	};
> +
> +	if (state && state->frame[state->curframe])
> +		event.reg.frameno =3D state->frame[state->curframe]->frameno;

[Severity: Medium]
Will this record the wrong frame number for registers invalidated in caller
frames?

Functions like clear_all_pkt_pointers() and release_reference() iterate over
all active frames to invalidate registers, but this assignment hardcodes the
current executing frame number via state->curframe.

Should bpf_diag_record_reg_mod_reason() accept the actual frame number of t=
he
register from the caller instead?

[ ... ]
> +static void bpf_diag_format_reg_snapshot(struct bpf_verifier_env *env, c=
har *buf,
> +					 size_t size,
> +					 const struct bpf_diag_reg_snapshot *snapshot)
> +{
> +	const char *type_name =3D reg_type_str(env, snapshot->type);
> +	char offset_desc[BPF_DIAG_REG_DESC_LEN];
> +	char btf_type[BPF_DIAG_REG_DESC_LEN];

[Severity: High]
Could this cause a kernel stack overflow?

BPF_DIAG_REG_DESC_LEN is 512 bytes. This function allocates 1KB on the stac=
k,
and is called by bpf_diag_print_reg_mod() which also allocates 1KB.

Additionally, this function calls bpf_diag_format_var_offset() which
allocates another 512 bytes. This >3KB stack usage chain might trigger
CONFIG_FRAME_WARN build failures or cause panics on architectures with 8KB
stacks.

[ ... ]
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d60e1309957a7..188201d48108c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4033,6 +4033,8 @@ static int check_stack_arg_write(struct bpf_verifie=
r_env *env, struct bpf_func_s
>  	struct bpf_subprog_info *subprog =3D &env->subprog_info[state->subprogn=
o];
>  	int spi =3D -off / BPF_REG_SIZE - 1;
>  	struct bpf_reg_state *arg;
> +	struct bpf_reg_state old_arg;
> +	bool slot_exists;
>  	int err;
> =20
>  	if (spi >=3D max_stack_arg_regs) {
> @@ -4041,6 +4043,7 @@ static int check_stack_arg_write(struct bpf_verifie=
r_env *env, struct bpf_func_s
>  		return -EINVAL;
>  	}
> =20
> +	slot_exists =3D spi < state->out_stack_arg_cnt;
>  	err =3D grow_stack_arg_slots(env, state, spi + 1);
>  	if (err)
>  		return err;
> @@ -4049,13 +4052,27 @@ static int check_stack_arg_write(struct bpf_verif=
ier_env *env, struct bpf_func_s
>  	if (spi + 1 > subprog->max_out_stack_arg_cnt)
>  		subprog->max_out_stack_arg_cnt =3D spi + 1;
> =20
> +	arg =3D &state->stack_arg_regs[spi];
> +	if (slot_exists)
> +		old_arg =3D *arg;
> +	else
> +		bpf_mark_reg_not_init(env, &old_arg);

[Severity: Medium]
Does this pass uninitialized stack memory to bpf_mark_reg_not_init()?

When slot_exists is false, old_arg is declared without initialization.
bpf_mark_reg_not_init() explicitly reads reg->subreg_def into a local
variable before clearing the struct, which could trigger a KMSAN
use-of-uninitialized-value warning.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605063412.9746=
40-1-memxor@gmail.com?part=3D5
