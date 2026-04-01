Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03D222ACEB
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775077640; cv=none; b=eERK8+lFtTEsRn3x7Ei+ueeaK5EcVrkzu98d2HPOioqePUxapjWjeo5tNEDBmQDTkkebdrndGpfw0Os6Y2pt3Szmtz39tQfn0aWC0ZTJtR0q/jVsewyFMsqztHAQhY53+rCiitDx08c11DkPQ12mekE5zmkEFS1pEZ1LbwEu6Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775077640; c=relaxed/simple;
	bh=meXwPDq0mKqqgGExcBdeW7KvLnlAMalQOiwnv3M3y70=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NWkCaDANvhJrI7BUeGd2JMXR+OWeuIo1h6zQkimpP4TDbiuoTxCV4NhtYXieTLHqOhwh4YmCJ06VmsgYgm4x7A8Xmzq/+qEG3S+rDCDp83aFKZ4dzjioh+/+ak10HFoFwQuLUyRJctez5GejX1vBlKpHiemoQnk2R458y+24uAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRTVzrNu; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRTVzrNu"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2c156c4a9efso281062eec.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 14:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775077638; x=1775682438; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5dqGN4a5qKPSj61VBHrqNUhOyakWSJki7xP9GbApvG8=;
        b=RRTVzrNun/L8x0sU29mZqmkEwwG0cUE6bnRGlCjZL4PmEi3PtgG4n6jDCK+Dvl3Io9
         RGLjyP751V6qzPjf274LWc3BeV/ndTpkdi+GBuXtk+SlCLd0SgswJW3BMyjH7rpEXNPr
         u8FrQNhG+Vt+0rjQDLKTQVcpq5i0KpXCDYh5G9tN3XmlWM7Hkl5CwDdljA2jl+kZZRwV
         SgUlPwrIZjJFa/Nmyd4mvMLSWuKskvd9qYO+RswgUH4hNUaBgxvLS613Qh08xH8XzeBx
         MbQVlLhP542y5xkj41b5emIVzZFXvwqVOFyKjtuy0/Qv5gaMz7nZ82JMYBISOqg3hdhn
         3RLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775077638; x=1775682438;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5dqGN4a5qKPSj61VBHrqNUhOyakWSJki7xP9GbApvG8=;
        b=NtCesjL+OPgbQ7fOhtxk3hndc0z3d32plPSB3wNx8/HhFLrMQppgkFT4bCPVopVbIi
         PZ5TG1rE0ZZzqQJ890/NSw7xrF1fFGuxz9BKf+64/LvBjKmvlroQnAyd1eLdeM6LOBe8
         eCH+qJmLOBIX4REfsTXCeeAgYGhzlfExnW0DABhIqu5fYNzYeE+qqawmLTZYQ8/QgvyJ
         lzdL1WeL9wnuBm8l07tRkpkQZi0gu5sM68yG3eYnC4FgTeiTo2I5abtl/+7wVrIzKntP
         jkB0YEfj7DKzMwUUlknvt/1HhUrQEcjEhdOh3MnVdcUY35pdKYt4+FtkMGKb1+0Vsm5S
         M4eA==
X-Forwarded-Encrypted: i=1; AJvYcCWFbG44yvC/3P6pIKc0oOAx9SDmW9ESoVUbsD0hI8oqd6Ofm2D2OPdK4zUDTQ0NLiZCJQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoNOSdInDFnZfmUarEn8QYt8+HkjmFNdgVfHDSpJV2eSjvbKQ4
	o1Ps4nL1A0mEw5E6/kaN+8psmvHOSxqqsFuar8PoEsZ9UXeWxKYOmSjE
X-Gm-Gg: ATEYQzyaap5SlQRG8Cw1S1uhkaBMD1bWmBuzuG+EcSB3cfP0gJjD3pIRn3E7lehCSC1
	BLQoLWZFztbQ4w5JzZqrZUVJWTz12Dr/R4g1M9Nuc/H4qt7oJNrcW3y50UIRMVTE8+EdJ6312K7
	a5epC5yb1xTII9P9hrbTeFiI2+BhIRLtID6kgS4VIr8qM3H+vBy1SMkwsVVNK6vKpmfTeHZ4aO2
	7gFLcUZZqX19IQZ00Bj9rCumyWlhiiruboUPRsr3ffObgithbUYLF5386TBjsFGpiVWmJatp8Cq
	vgzpR9ZAZM6hurfBhMUF0bgjkrG6yOx2XQTgXdAGJwnU2spD6oohsO/j4u7dzXzYnuGXoaDKc6k
	d0g46r5TqaGkkPcZIAOnBx2TPfpH4gQSCBJX5mYvhd18wrzYRSb7nS7jKL7xKG2PejCvxtv1dXQ
	L3utk3n4DGNLhUDVv9ZTHNovHWKaY/YA8gi1yXwoRcxSJ9fvb5dlPgPxxZs6WeYgN1twNasgclq
	ReQuHd8
X-Received: by 2002:a05:7300:fd0e:b0:2ba:a2fb:403f with SMTP id 5a478bee46e88-2c9329a0cc6mr3068299eec.21.1775077637707;
        Wed, 01 Apr 2026 14:07:17 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:7aba:8184:a91b:bf1f? ([2620:10d:c090:500::3:f883])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c3010e9sm1116184eec.14.2026.04.01.14.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 14:07:17 -0700 (PDT)
Message-ID: <3c091ab744676990e90469a89a4f0110d724ce19.camel@gmail.com>
Subject: Re: [PATCH bpf-next 4/6] bpf: Add compute_const_regs() and
 prune_dead_branches() passes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com
Date: Wed, 01 Apr 2026 14:07:15 -0700
In-Reply-To: <20260401021635.34636-5-alexei.starovoitov@gmail.com>
References: <20260401021635.34636-1-alexei.starovoitov@gmail.com>
	 <20260401021635.34636-5-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-31 at 19:16 -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Add two passes before the main verifier pass:
>=20
> compute_const_regs() is a forward dataflow analysis that tracks
> register values in R0-R9 across the program using fixed-point
> iteration in reverse postorder. Each register is tracked with
> a six-state lattice:
>=20
>   UNVISITED -> CONST(val) / MAP_PTR(map_index) /
>                MAP_VALUE(map_index, offset) / SUBPROG(num) -> UNKNOWN
>=20
> At merge points, if two paths produce the same state and value for
> a register, it stays; otherwise it becomes UNKNOWN.
>=20
> The analysis handles:
>  - MOV, ADD, SUB, AND with immediate or register operands
>  - LD_IMM64 for plain constants, map FDs, map values, and subprogs
>  - LDX from read-only maps: constant-folds the load by reading the
>    map value directly via bpf_map_direct_read()
>=20
> Results that fit in 32 bits are stored per-instruction in
> insn_aux_data and bitmasks.
>=20
> prune_dead_branches() uses the computed constants to evaluate
> conditional branches. When both operands of a conditional jump are
> known constants, the branch outcome is determined statically and the
> instruction is rewritten to an unconditional jump.
> The CFG postorder is then recomputed to reflect new control flow.
> This eliminates dead edges so that subsequent liveness analysis
> doesn't propagate through dead code.
>=20
> Also add runtime sanity check to validate that precomputed
> constants match the verifier's tracked state.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Besides issues found by bot this patch lgtm.

[...]

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 4f492eaad5c2..0d797de30a3a 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[...]

> @@ -1086,6 +1102,13 @@ struct bpf_iarray *bpf_insn_successors(struct bpf_=
verifier_env *env, u32 idx);
>  void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
>  bool bpf_calls_callback(struct bpf_verifier_env *env, int insn_idx);
> =20
> +int find_subprog(struct bpf_verifier_env *env, int off);
> +int compute_const_regs(struct bpf_verifier_env *env);
> +int prune_dead_branches(struct bpf_verifier_env *env);
> +int compute_postorder(struct bpf_verifier_env *env);
> +bool insn_is_cond_jump(u8 code);
> +bool is_may_goto_insn(struct bpf_insn *insn);
> +

Q: What is the policy regarding naming exported functions?
   So far I always used "bpf_..." prefix assuming that this
   is a requirement, was I wrong?

>  int bpf_stack_liveness_init(struct bpf_verifier_env *env);
>  void bpf_stack_liveness_free(struct bpf_verifier_env *env);
>  int bpf_update_live_stack(struct bpf_verifier_env *env);

[...]

> diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
> new file mode 100644
> index 000000000000..9e5abc6ab46a
> --- /dev/null
> +++ b/kernel/bpf/const_fold.c

[...]

> +/* Transfer function: compute output register state from instruction. */
> +static void const_reg_xfer(struct bpf_verifier_env *env, struct const_ar=
g_info *ci_out,
> +			   struct bpf_insn *insn, struct bpf_insn *insns, int idx)
> +{
> +	struct const_arg_info unknown =3D { .state =3D CONST_ARG_UNKNOWN, .val =
=3D 0 };
> +	struct const_arg_info *dst =3D &ci_out[insn->dst_reg];
> +	struct const_arg_info *src =3D &ci_out[insn->src_reg];
> +	u8 class =3D BPF_CLASS(insn->code);
> +	u8 opcode =3D BPF_OP(insn->code) | BPF_SRC(insn->code);
> +	int r;
> +
> +	switch (class) {
> +	case BPF_ALU:
> +	case BPF_ALU64:
> +		switch (opcode) {
> +		case BPF_MOV | BPF_K:
> +			dst->state =3D CONST_ARG_CONST;
> +			dst->val =3D (s64)insn->imm;
> +			break;
> +		case BPF_MOV | BPF_X:
> +			*dst =3D *src;
> +			if (!insn->off)
> +				break;
> +			if (!ci_is_const(dst)) {
> +				*dst =3D unknown;
> +				break;
> +			}
> +			switch (insn->off) {
> +			case 8:  dst->val =3D (s8)dst->val; break;
> +			case 16: dst->val =3D (s16)dst->val; break;
> +			case 32: dst->val =3D (s32)dst->val; break;
> +			default: *dst =3D unknown; break;
> +			}
> +			break;
> +		case BPF_ADD | BPF_K:
> +			if (!ci_is_const(dst) && !ci_is_map_value(dst)) {
> +				*dst =3D unknown;
> +				break;
> +			}
> +			dst->val +=3D insn->imm;
> +			break;
> +		case BPF_SUB | BPF_K:
> +			if (!ci_is_const(dst) && !ci_is_map_value(dst)) {
> +				*dst =3D unknown;
> +				break;
> +			}
> +			dst->val -=3D insn->imm;
> +			break;
> +		case BPF_AND | BPF_K:
> +			if (!ci_is_const(dst)) {
> +				if (!insn->imm) {
> +					dst->state =3D CONST_ARG_CONST;
> +					dst->val =3D 0;
> +				} else {
> +					*dst =3D unknown;
> +				}
> +				break;
> +			}
> +			dst->val &=3D (s64)insn->imm;
> +			break;
> +		case BPF_AND | BPF_X:
> +			if (ci_is_const(dst) && dst->val =3D=3D 0)
> +				break; /* 0 & x =3D=3D 0 */
> +			if (ci_is_const(src) && src->val =3D=3D 0) {
> +				dst->state =3D CONST_ARG_CONST;
> +				dst->val =3D 0;
> +				break;
> +			}
> +			if (!ci_is_const(dst) || !ci_is_const(src)) {
> +				*dst =3D unknown;
> +				break;
> +			}
> +			dst->val &=3D src->val;
> +			break;

Just curious, why does this function deal with `0 & reg` cases,
but not the e.g. `0 | reg` cases? Was it something that came up
during testing the static analysis?

> +		default:
> +			*dst =3D unknown;
> +			break;
> +		}
> +		if (class =3D=3D BPF_ALU) {
> +			if (ci_is_const(dst))
> +				dst->val =3D (u32)dst->val;
> +			else if (!ci_is_unknown(dst))
> +				*dst =3D unknown;
> +		}
> +		break;
> +	case BPF_LD:
> +		if (BPF_MODE(insn->code) !=3D BPF_IMM || BPF_SIZE(insn->code) !=3D BPF=
_DW)

Should this reset r0-r5 in case of opcode is  BPF_LD|BPF_ABS or BPF_LD|BPF_=
IND?

> +			break;
> +		if (insn->src_reg =3D=3D BPF_PSEUDO_FUNC) {
> +			int subprog =3D find_subprog(env, idx + insn->imm + 1);
> +
> +			if (subprog >=3D 0) {
> +				dst->state =3D CONST_ARG_SUBPROG;
> +				dst->val =3D subprog;
> +			} else {
> +				*dst =3D unknown;
> +			}
> +		} else if (insn->src_reg =3D=3D BPF_PSEUDO_MAP_VALUE ||
> +			   insn->src_reg =3D=3D BPF_PSEUDO_MAP_IDX_VALUE) {
> +			dst->state =3D CONST_ARG_MAP_VALUE;
> +			dst->map_index =3D env->insn_aux_data[idx].map_index;
> +			dst->val =3D env->insn_aux_data[idx].map_off;
> +		} else if (insn->src_reg =3D=3D BPF_PSEUDO_MAP_FD ||
> +			   insn->src_reg =3D=3D BPF_PSEUDO_MAP_IDX) {
> +			dst->state =3D CONST_ARG_MAP_PTR;
> +			dst->map_index =3D env->insn_aux_data[idx].map_index;
> +		} else if (insn->src_reg =3D=3D 0) {
> +			dst->state =3D CONST_ARG_CONST;
> +			dst->val =3D (u64)(u32)insn->imm | ((u64)(u32)insns[idx + 1].imm << 3=
2);
> +		} else {
> +			*dst =3D unknown;
> +		}
> +		break;
> +	case BPF_LDX:
> +		if (!ci_is_map_value(src)) {
> +			*dst =3D unknown;
> +			break;
> +		}
> +		struct bpf_map *map =3D env->used_maps[src->map_index];
> +		int size =3D bpf_size_to_bytes(BPF_SIZE(insn->code));
> +		bool is_ldsx =3D BPF_MODE(insn->code) =3D=3D BPF_MEMSX;
> +		int off =3D src->val + insn->off;
> +		u64 val =3D 0;
> +
> +		if (!bpf_map_is_rdonly(map) || !map->ops->map_direct_value_addr ||
> +		    bpf_map_direct_read(map, off, size, &val, is_ldsx)) {

Nit: Similar sequence in verifier.c also checks for map->map_type !=3D BPF_=
MAP_TYPE_INSN_ARRAY.
     Maybe move this to a helper function?

> +			*dst =3D unknown;
> +			break;
> +		}
> +		dst->state =3D CONST_ARG_CONST;
> +		dst->val =3D val;
> +		break;
> +	case BPF_JMP:
> +		if (opcode !=3D BPF_CALL)
> +			break;
> +		for (r =3D BPF_REG_0; r <=3D BPF_REG_5; r++)
> +			ci_out[r] =3D unknown;
> +		break;
> +	case BPF_STX:
> +		if (BPF_MODE(insn->code) !=3D BPF_ATOMIC)
> +			break;
> +		if (insn->imm =3D=3D BPF_CMPXCHG)
> +			ci_out[BPF_REG_0] =3D unknown;
> +		else if (insn->imm =3D=3D BPF_LOAD_ACQ)
> +			*dst =3D unknown;
> +		else if (insn->imm & BPF_FETCH)
> +			*src =3D unknown;
> +		break;
> +	}
> +}

[...]

> +static bool eval_const_branch(u8 opcode, u64 dst_val, u64 src_val)
> +{
> +	switch (BPF_OP(opcode)) {
> +	case BPF_JEQ:	return dst_val =3D=3D src_val;
> +	case BPF_JNE:	return dst_val !=3D src_val;
> +	case BPF_JGT:	return dst_val > src_val;
> +	case BPF_JGE:	return dst_val >=3D src_val;
> +	case BPF_JLT:	return dst_val < src_val;
> +	case BPF_JLE:	return dst_val <=3D src_val;
> +	case BPF_JSGT:	return (s64)dst_val > (s64)src_val;
> +	case BPF_JSGE:	return (s64)dst_val >=3D (s64)src_val;
> +	case BPF_JSLT:	return (s64)dst_val < (s64)src_val;
> +	case BPF_JSLE:	return (s64)dst_val <=3D (s64)src_val;
> +	case BPF_JSET:	return dst_val & src_val;
> +	default:	return false;

Do we want to validate that the above are the only opcodes possible,
e.g. in patch #1?

> +	}
> +}
> +
> +/*
> + * Rewrite conditional branches with constant outcomes into unconditiona=
l
> + * jumps using register values resolved by compute_const_regs() pass.
> + * This eliminates dead edges from the CFG so that compute_live_register=
s()
> + * doesn't propagate liveness through dead code.
> + */
> +int prune_dead_branches(struct bpf_verifier_env *env)
> +{
> +	struct bpf_insn_aux_data *insn_aux =3D env->insn_aux_data;
> +	struct bpf_insn *insns =3D env->prog->insnsi;
> +	int insn_cnt =3D env->prog->len;
> +	bool changed =3D false;
> +	int i;
> +
> +	for (i =3D 0; i < insn_cnt; i++) {
> +		struct bpf_insn_aux_data *aux =3D &insn_aux[i];
> +		struct bpf_insn *insn =3D &insns[i];
> +		u8 class =3D BPF_CLASS(insn->code);
> +		u64 dst_val, src_val;
> +		bool taken;
> +
> +		if (!insn_is_cond_jump(insn->code))
> +			continue;
> +		if (is_may_goto_insn(insn))
> +			continue;
> +
> +		if (!(aux->const_reg_mask & BIT(insn->dst_reg)))
> +			continue;
> +		dst_val =3D aux->const_reg_vals[insn->dst_reg];
> +
> +		if (BPF_SRC(insn->code) =3D=3D BPF_K) {
> +			src_val =3D (u32)insn->imm;
> +		} else {
> +			if (!(aux->const_reg_mask & BIT(insn->src_reg)))
> +				continue;
> +			src_val =3D aux->const_reg_vals[insn->src_reg];
> +		}
> +
> +		if (class =3D=3D BPF_JMP32) {
> +			/*
> +			 * The (s32) cast maps the 32-bit range into two u64 sub-ranges:
> +			 * [0x00000000, 0x7FFFFFFF] -> [0x0000000000000000, 0x000000007FFFFFF=
F]
> +			 * [0x80000000, 0xFFFFFFFF] -> [0xFFFFFFFF80000000, 0xFFFFFFFFFFFFFFF=
F]
> +			 * The ordering is preserved within each sub-range, and
> +			 * the second sub-range is above the first as u64.
> +			 */
> +			dst_val =3D (s32)dst_val;
> +			src_val =3D (s32)src_val;
> +		}
> +
> +		taken =3D eval_const_branch(insn->code, dst_val, src_val);
> +		*insn =3D BPF_JMP_A(taken ? insn->off : 0);
> +		changed =3D true;
> +	}
> +
> +	if (!changed)
> +		return 0;
> +	/* recompute postorder, since CFG has changed */
> +	kvfree(env->cfg.insn_postorder);
> +	return compute_postorder(env);
> +}
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 432806011d47..493f6acaa386 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -595,7 +595,7 @@ static bool is_async_cb_sleepable(struct bpf_verifier=
_env *env, struct bpf_insn
>  	return false;
>  }
> =20
> -static bool is_may_goto_insn(struct bpf_insn *insn)
> +bool is_may_goto_insn(struct bpf_insn *insn)
>  {
>  	return insn->code =3D=3D (BPF_JMP | BPF_JCOND) && insn->src_reg =3D=3D =
BPF_MAY_GOTO;
>  }
> @@ -3082,7 +3082,7 @@ struct bpf_subprog_info *bpf_find_containing_subpro=
g(struct bpf_verifier_env *en
>  }
> =20
>  /* Find subprogram that starts exactly at 'off' */
> -static int find_subprog(struct bpf_verifier_env *env, int off)
> +int find_subprog(struct bpf_verifier_env *env, int off)
>  {
>  	struct bpf_subprog_info *p;
> =20
> @@ -7287,7 +7287,7 @@ static void coerce_subreg_to_size_sx(struct bpf_reg=
_state *reg, int size)
>  	set_sext32_default_val(reg, size);
>  }
> =20
> -static bool bpf_map_is_rdonly(const struct bpf_map *map)
> +bool bpf_map_is_rdonly(const struct bpf_map *map)
>  {
>  	/* A map is considered read-only if the following condition are true:
>  	 *
> @@ -7307,8 +7307,8 @@ static bool bpf_map_is_rdonly(const struct bpf_map =
*map)
>  	       !bpf_map_write_active(map);
>  }
> =20
> -static int bpf_map_direct_read(struct bpf_map *map, int off, int size, u=
64 *val,
> -			       bool is_ldsx)
> +int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val=
,
> +			bool is_ldsx)
>  {
>  	void *ptr;
>  	u64 addr;
> @@ -19234,7 +19234,7 @@ static int check_cfg(struct bpf_verifier_env *env=
)
>   * [env->subprog_info[i].postorder_start, env->subprog_info[i+1].postord=
er_start)
>   * with indices of 'i' instructions in postorder.
>   */
> -static int compute_postorder(struct bpf_verifier_env *env)
> +int compute_postorder(struct bpf_verifier_env *env)
>  {
>  	u32 cur_postorder, i, top, stack_sz, s;
>  	int *stack =3D NULL, *postorder =3D NULL, *state =3D NULL;
> @@ -21538,6 +21538,27 @@ static int do_check(struct bpf_verifier_env *env=
)
>  		sanitize_mark_insn_seen(env);
>  		prev_insn_idx =3D env->insn_idx;
> =20
> +		/* Sanity check: precomputed constants must match verifier state */
> +		if (!state->speculative && insn_aux->const_reg_mask) {
> +			struct bpf_reg_state *regs =3D cur_regs(env);
> +			u16 mask =3D insn_aux->const_reg_mask;
> +
> +			for (int r =3D 0; r < MAX_BPF_REG; r++) {
> +				u32 cval =3D insn_aux->const_reg_vals[r];
> +
> +				if (!(mask & BIT(r)))
> +					continue;
> +				if (regs[r].type !=3D SCALAR_VALUE)
> +					continue;
> +				if (!tnum_is_const(regs[r].var_off))
> +					continue;
> +				if (verifier_bug_if((u32)regs[r].var_off.value !=3D cval,
> +						    env, "const R%d: %u !=3D %llu",
> +						    r, cval, regs[r].var_off.value))
> +					return -EFAULT;
> +			}
> +		}
> +
>  		/* Reduce verification complexity by stopping speculative path
>  		 * verification when a nospec is encountered.
>  		 */
> @@ -22527,7 +22548,7 @@ static void sanitize_dead_code(struct bpf_verifie=
r_env *env)
>  	}
>  }
> =20
> -static bool insn_is_cond_jump(u8 code)
> +bool insn_is_cond_jump(u8 code)
>  {
>  	u8 op;
> =20
> @@ -26353,6 +26374,14 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr, __u3
>  	if (ret)
>  		goto skip_full_check;
> =20
> +	ret =3D compute_const_regs(env);
> +	if (ret < 0)
> +		goto skip_full_check;
> +
> +	ret =3D prune_dead_branches(env);
> +	if (ret < 0)
> +		goto skip_full_check;
> +
>  	ret =3D sort_subprogs_topo(env);
>  	if (ret < 0)
>  		goto skip_full_check;
> diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/to=
ols/testing/selftests/bpf/progs/verifier_scalar_ids.c
> index 58c7704d61cd..0e907cad5902 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
> @@ -592,10 +592,10 @@ __naked void check_ids_in_regsafe_2(void)
>   */
>  SEC("socket")
>  __success __log_level(2)
> -__msg("11: (1d) if r3 =3D=3D r4 goto pc+0")
> +__msg("14: (1d) if r3 =3D=3D r4 goto pc+0")
>  __msg("frame 0: propagating r3,r4")
> -__msg("11: safe")
> -__msg("processed 15 insns")
> +__msg("14: safe")
> +__msg("processed 18 insns")
>  __flag(BPF_F_TEST_STATE_FREQ)
>  __naked void no_scalar_id_for_const(void)
>  {
> @@ -606,13 +606,16 @@ __naked void no_scalar_id_for_const(void)
>  	/* possibly generate same scalar ids for r3 and r4 */
>  	"r1 =3D 0;"
>  	"r1 =3D r1;"
> +	"r1 |=3D 0;" /* prevent prune_dead_branches from folding the branch */
>  	"r3 =3D r1;"
>  	"r4 =3D r1;"
>  	"goto l1_%=3D;"
>  "l0_%=3D:"
>  	/* possibly generate different scalar ids for r3 and r4 */
>  	"r1 =3D 0;"
> +	"r1 |=3D 0;"
>  	"r2 =3D 0;"
> +	"r2 |=3D 0;"
>  	"r3 =3D r1;"
>  	"r4 =3D r2;"
>  "l1_%=3D:"
> @@ -628,10 +631,10 @@ __naked void no_scalar_id_for_const(void)
>  /* Same as no_scalar_id_for_const() but for 32-bit values */
>  SEC("socket")
>  __success __log_level(2)
> -__msg("11: (1e) if w3 =3D=3D w4 goto pc+0")
> +__msg("14: (1e) if w3 =3D=3D w4 goto pc+0")
>  __msg("frame 0: propagating r3,r4")
> -__msg("11: safe")
> -__msg("processed 15 insns")
> +__msg("14: safe")
> +__msg("processed 18 insns")
>  __flag(BPF_F_TEST_STATE_FREQ)
>  __naked void no_scalar_id_for_const32(void)
>  {
> @@ -642,17 +645,20 @@ __naked void no_scalar_id_for_const32(void)
>  	/* possibly generate same scalar ids for r3 and r4 */
>  	"w1 =3D 0;"
>  	"w1 =3D w1;"
> +	"w1 |=3D 0;" /* prevent prune_dead_branches from folding the branch */
>  	"w3 =3D w1;"
>  	"w4 =3D w1;"
>  	"goto l1_%=3D;"
>  "l0_%=3D:"
>  	/* possibly generate different scalar ids for r3 and r4 */
>  	"w1 =3D 0;"
> +	"w1 |=3D 0;"
>  	"w2 =3D 0;"
> +	"w2 |=3D 0;"
>  	"w3 =3D w1;"
>  	"w4 =3D w2;"
>  "l1_%=3D:"
> -	/* predictable jump, marks r1 and r2 precise */
> +	/* predictable jump, marks r3 and r4 precise */
>  	"if w3 =3D=3D w4 goto +0;"
>  	"r0 =3D 0;"
>  	"exit;"
