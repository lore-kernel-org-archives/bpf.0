Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914806;
	b=enXEWix+ZgytUWNRv0nhDSc6O4VLTJxiJls0TQGHQvRr6QiwEpRTq4owRbW7bYi+geKx
	 zQtprGMybh9yIcnUAHOVwQhfqF1kLSfilj2THJ9Wml4hZo2qeqxSzpC7IlD7qsDeCMkm8
	 wrL1yilkh8sk7JTkjozzTvj78iw6eUF6FGn/DiupBLAh080PtMcHVPlfq1qTl8THXzStz
	 ZPGt6F4Ou9Xts0hRIzPp7XNhBU02f3x63RJum9TpebizTKVkrLeXgqAOWTtbkkauHfS36
	 uz1+N1vPKCiSbp01gqxeuhhPM3LvWcEuEVW5MC/PC9eniTtNO1jQdPNNpze9TpX6Kxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914806;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IEVA8xzeXeEh7eqhzQT8WFHbqnPjGyZ0iIwhmCRsBAs=;
	b=tWtrQngYEaVGdRckv3mFz7UHBW1Vs9QRU27QRUjrtmQq4+GNEov2sOZqXtRByESXD8Ty
	 d5V+NpM5GCtFs0tIfzWDqrvRh8pDN+GVfT36b1Iw9iFzyuYh2RoFKD/ueg0SMGy/W2E65
	 tJN5mnNjbRBJgRoFUOiPAR6zuEs2MiN6uv4vGS8izbh6KSnyS2svXJok04fBGCXZarcqg
	 /mQpk6Eq01Lyw25S882YHMkh/JxQIjt3ads/NNDAAj/xWz2s+sep7k9GhPEGGiaYjv6mL
	 OkQbHSWpS1EkAXFI+wVJaEfinl+CDFLyLoiH8Nd4p1pePKm66nPpX1o66ylOwegRBwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OzbYxF1I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231F7606A328
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 21:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OzbYxF1I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3DA1F0089F;
	Thu,  5 Nov 2026 21:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914805;
	bh=IEVA8xzeXeEh7eqhzQT8WFHbqnPjGyZ0iIwhmCRsBAs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=OzbYxF1IhQEjowXjejqhjvdKP/1lXi6NkVRInv2YEhxbk49UB1D3dO6FWpmfrYFfP
	 a0sUItm7MGFeFTOqLEaTuY5VTWM4MARPBhhEC6QrR7qPNnSf64oALlyTvAEkkUUJKc
	 NzcjdhIPdLw1qQVAz9COlMm7ciq7sQPvHSAQ4AD6DHE5el2gECIGCoFweX8J4Xbnee
	 52ERo+MMLeTkd+ltGeQK0T8XqYyJ/JJF6k11oELtlv65e7ogHh93k5W+/YcJwolSLT
	 ZLagtejU1BJ6DxOxIdPK5HjPO3LPW3kb5D/uQi0VrjcqiG3wHfYRq4dS0MN+eP1SPC
	 pzGnTgKj8mvlA==
Message-ID: <sashiko-outbox-200251@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 09/35] bpf: Find the registers that hold a
 number or a pointer to arena
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261105204513.2230344-10-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
 <20261105204513.2230344-10-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:40:05 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] bpf: misclassified 32-bit context loads in flow_loaded_kind()
- [Medium] bpf: misclassified void * special kfuncs in flow_returned_kind()
- [Medium] bpf: stack pointer spill via BPF_STORE_REL lost in flow_kinds_st=
ep()
--

commit d616e924eec822ed1af91bad97267316408cf00d
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Find the registers that hold a number or a pointer to arena

This commit adds bpf_flow_compute_kinds() in kernel/bpf/flow.c to perform a
forward dataflow pass before the main verification pass, identifying which
registers and stack slots hold plain scalars/arena pointers, scalar-only map
value pointers, or context pointers on every path reaching each instruction.

> diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
> index 0f5acdf1cb946..837d5054c2a3d 100644
> --- a/kernel/bpf/flow.c
> +++ b/kernel/bpf/flow.c
> @@ -514,3 +514,310 @@ int bpf_flow_place_guards(struct bpf_verifier_env *=
env)

[ ... ]

> +/* What holds on both ways to an insn. Returns true if that is less than=
 before. */
> +static bool flow_kinds_meet(struct flow_kinds *to, const struct flow_kin=
ds *from)
> +{
> +	unsigned long lost =3D 0;
> +	int i, j;
> +
> +	for (i =3D 0; i < FLOW_KINDS; i++) {
> +		for (j =3D 0; j < ARRAY_SIZE(to->is[i]); j++) {
> +			lost |=3D to->is[i][j] & ~from->is[i][j];
> +			to->is[i][j] &=3D from->is[i][j];
> +		}
> +	}
> +	return lost;
> +}

[ ... ]

> +/* What @insn loads through the register @base */
> +static enum flow_kind flow_loaded_kind(struct bpf_verifier_env *env, con=
st struct flow_kinds *k,
> +				       const struct bpf_insn *insn, u8 base)
> +{
> +	struct bpf_insn_access_aux info =3D { .reg_type =3D SCALAR_VALUE };
> +	int size =3D bpf_size_to_bytes(BPF_SIZE(insn->code));
> +	bool tstamp =3D env->prog->tstamp_type_access, valid;
> +
> +	/* a number that is good for a load is an address in arena */
> +	if (test_bit(base, k->is[FLOW_IS_VALUE]))
> +		return FLOW_IS_PLAIN;
> +	/* only the context has pointers that are shorter than a register */
> +	if (!test_bit(base, k->is[FLOW_IS_CTX]))
> +		return size < BPF_REG_SIZE ? FLOW_IS_PLAIN : FLOW_IS_OTHER;

[Severity: Medium]
Can flow_loaded_kind() in kernel/bpf/flow.c misclassify 32-bit context
pointer loads (such as skb->data or xdp_md->data) as FLOW_IS_PLAIN when a
register holds the context pointer on one incoming path and a non-context
value on another?

In bpf_flow_compute_kinds(), all bits in struct flow_kinds start as 1 and a=
re
intersected across predecessors in flow_kinds_meet() via bitwise AND:

	to->is[i][j] &=3D from->is[i][j];

As a result, test_bit(base, k->is[FLOW_IS_CTX]) is a must-analysis bit that
is 1 only when base holds the unmodified context pointer on every path
reaching the instruction, and becomes 0 whenever base may hold a non-context
value on at least one path (for example, after a branch or across static
subprogram callsites).

However, flow_loaded_kind() checks !test_bit(base, k->is[FLOW_IS_CTX]) and
returns FLOW_IS_PLAIN for size < BPF_REG_SIZE, treating a cleared bit in
FLOW_IS_CTX as meaning that base cannot be a context pointer on any path.
When a 32-bit context pointer field is loaded through such a register,
flow_loaded_kind() marks the resulting packet pointer as FLOW_IS_PLAIN,
allowing the main pass to join states with distinct packet offsets and reje=
ct
valid programs. In addition, when k->is[FLOW_IS_CTX] drops from 1 to 0 duri=
ng
the fixpoint loop, flow_loaded_kind() transitions its result for sub-8-byte
non-scalar context loads from FLOW_IS_OTHER (0) back up to FLOW_IS_PLAIN (1=
),
making the transfer function non-monotone.

> +	valid =3D env->ops->is_valid_access &&
> +		env->ops->is_valid_access(insn->off, size, BPF_READ, env->prog, &info);
> +	/* it notes what the prog reads, and this is a question */
> +	env->prog->tstamp_type_access =3D tstamp;
> +	return valid && info.reg_type =3D=3D SCALAR_VALUE ? FLOW_IS_PLAIN : FLO=
W_IS_OTHER;
> +}
> +
> +/* What a helper or a kfunc returns */
> +static enum flow_kind flow_returned_kind(struct bpf_verifier_env *env, i=
nt idx)
> +{
> +	struct bpf_insn_aux_data *aux =3D &env->insn_aux_data[idx];
> +	struct bpf_insn *insn =3D &env->prog->insnsi[idx];
> +	const struct bpf_func_proto *fn;
> +	struct bpf_call_arg_meta meta;
> +	const struct btf_type *t;
> +
> +	if (bpf_pseudo_kfunc_call(insn)) {
> +		if (bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta) < 0)
> +			return FLOW_IS_OTHER;
> +		t =3D btf_type_skip_modifiers(meta.btf, meta.func_proto->type, NULL);
> +		if (!btf_type_is_ptr(t))
> +			return FLOW_IS_PLAIN;
> +		/* void * is a number, unless the verifier knows the kfunc. Such kfunc=
 may fail. */
> +		t =3D btf_type_skip_modifiers(meta.btf, t->type, NULL);
> +		return btf_type_is_void(t) && !(meta.kfunc_flags & KF_RET_NULL) ? FLOW=
_IS_PLAIN :
> +										  FLOW_IS_OTHER;

[Severity: Medium]
Does flow_returned_kind() in kernel/bpf/flow.c misclassify the return value
of bpf_cast_to_kern_ctx() and bpf_rdonly_cast() as FLOW_IS_PLAIN?

Both kfuncs have a void * return type in BTF, but neither has KF_RET_NULL s=
et
in common_btf_ids in kernel/bpf/helpers.c:

	BTF_ID_FLAGS(func, bpf_cast_to_kern_ctx, KF_FASTCALL)
	BTF_ID_FLAGS(func, bpf_rdonly_cast, KF_FASTCALL | KF_PERFMON)

In kernel/bpf/verifier.c, check_special_kfunc() sets R0 for these calls to
PTR_TO_BTF_ID (or PTR_TO_MEM):

	} else if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_cast_to_kern_ctx]=
)) {
		mark_reg_known_zero(env, regs, BPF_REG_0);
		regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | PTR_TRUSTED;
		regs[BPF_REG_0].btf =3D desc_btf;
		regs[BPF_REG_0].btf_id =3D meta->ret_btf_id;
	} else if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_rdonly_cast])) {

Because KF_RET_NULL is not set on either kfunc, flow_returned_kind() returns
FLOW_IS_PLAIN, which sets both FLOW_IS_PLAIN and FLOW_IS_VALUE on R0 and
causes the returned pointer and any pointers loaded through it (via
flow_loaded_kind() checking FLOW_IS_VALUE) to be treated as FLOW_IS_PLAIN,
allowing states with different constant offsets to be joined.

> +	}

[ ... ]

> +static bool flow_kinds_step(struct bpf_verifier_env *env, struct flow_ki=
nds *kinds, u16 *ret,
> +			    struct flow_kinds *k, int idx)
> +{
> +	struct bpf_subprog_info *sub =3D env->subprog_info;
> +	struct bpf_insn *insn =3D &env->prog->insnsi[idx];
> +	u8 class =3D BPF_CLASS(insn->code), op =3D BPF_OP(insn->code);
> +	u8 dst =3D insn->dst_reg, src =3D insn->src_reg;
> +	bool wide =3D BPF_SIZE(insn->code) =3D=3D BPF_DW && BPF_MODE(insn->code=
) =3D=3D BPF_MEM &&
> +		    !(insn->off % BPF_REG_SIZE);
> +	bool lost =3D false;
> +	u16 regs =3D U16_MAX;
> +	int i, s;

[ ... ]

> +	} else if (class =3D=3D BPF_LDX) {
> +		s =3D flow_mem_place(insn, src);
> +		if (wide && s >=3D 0)
> +			flow_kind_copy(k, dst, k, s);
> +		else
> +			flow_kind_set(k, dst, flow_loaded_kind(env, k, insn, src));
> +	} else if (class =3D=3D BPF_STX || class =3D=3D BPF_ST) {
> +		i =3D bpf_atomic_load_reg(insn);
> +		if (i >=3D 0)
> +			flow_kind_set(k, i, flow_loaded_kind(env, k, insn,
> +						insn->imm =3D=3D BPF_LOAD_ACQ ? src : dst));
> +		s =3D flow_mem_place(insn, dst);
> +		if (class =3D=3D BPF_STX && wide && s >=3D 0)
> +			flow_kind_copy(k, s, k, src);
> +		else if (s >=3D 0)
> +			flow_kind_set(k, s, FLOW_IS_PLAIN);

[Severity: Medium]
What happens in flow_kinds_step() in kernel/bpf/flow.c if a 64-bit pointer =
is
spilled to a stack slot using a store-release instruction (BPF_STX |
BPF_ATOMIC | BPF_DW with imm =3D=3D BPF_STORE_REL)?

In kernel/bpf/verifier.c, check_atomic_store() handles BPF_STORE_REL by
calling check_store_reg(env, insn, true), which spills a pointer register to
the stack on an aligned 8-byte write.

In flow_kinds_step(), wide requires BPF_MODE(insn->code) =3D=3D BPF_MEM, wh=
ich is
false for BPF_ATOMIC instructions. When a 64-bit BPF_STORE_REL writes a
non-arena pointer to a tracked stack slot (s >=3D 0), wide is false, so
flow_kinds_step() takes the else branch and sets slot s to FLOW_IS_PLAIN
instead of copying the kind from src. A subsequent 64-bit fill from that
stack slot will then classify the reloaded pointer register as FLOW_IS_PLAIN
(and similarly a 64-bit BPF_LOAD_ACQ from a stack slot will not copy the
stack slot kind).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105204513.2230=
344-1-alexei.starovoitov@gmail.com?part=3D9
