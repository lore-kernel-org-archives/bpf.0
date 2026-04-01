Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2563C1991
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 22:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775082789; cv=pass; b=NeLfdurhCc7gIlEbzqihPD4KjnxI8zcSbGxw3LSyirDDfSK02v0zuZ6rsIlOJrEb0F3k31aQrHnAVR03VtwtDXGT/T0itMENlvp9RukzwLGHHlqZzWH+qpt6XFYM7VcfS/TZUkHLnRftX1/+BYCD6tRESh6FiBKZnzpY0dAW7mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775082789; c=relaxed/simple;
	bh=ajaWsEgVfRfBpsXhxGQAQWHTssFj0NAei0JLYPhbRig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpcwhnbX09GH2ayooTrTP49V+xBaaJrpiBxuCK6PsXrLGo4HBCAwqhxeaQzwn9qzhJoaVXOQc3vCbK0pkvE7H5Ni23HRAYJBf0nSNgKMcN3GHIv0fmFMoa/QhEg+9Hdminb/yPLjvBck9FaRW4xrJVDsmW+ypbS1H582+VBrJyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EI/bE4dZ; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EI/bE4dZ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48541edecf9so2363385e9.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 15:32:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775082777; cv=none;
        d=google.com; s=arc-20240605;
        b=eQ15nafJ5L9s4nJGZtIxoN5CglZdh3M1MHfMgcuUMgIv+nUWAR46dlcOMiqKDZwu6h
         vqwmubX/boud0YxX2VdlzHjHJrZSq+Qfj6BpyrxFS/nS617Sh9k7p56VB76O4YWVYdrC
         +HS7p5Plfuu7VEEYzFxfE8i7IJKxMghpgNVjaNIma5KWBJ/U6IJO3fNRSXHc2/sEOWza
         T0m6JW5Go7CC7Y/faor+zAITtRLgXVdENi8EckmMj2INMud2J5U9ljj/8H1pl3e5xt/r
         6NppUjVZ1426fFwb/7e3NdF4VjXNcwhT20aSxxahzP2JU8o8tB1qAZZOUkLriMfNcRsE
         uKZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B3VfjVME7Yw+jYEXtfoUkrvbamDb8yApBSTnhoz4Zog=;
        fh=UcZqnkcPYPCJuBeofOOObWQTYZ2DVO/Q2yzEycpMUlQ=;
        b=SUm5ZqVLLJsEWVGVVaFtQqfU3YJoj1iN9MR9HLjIPIUDEYqJKTvWGrLuR2eFRRZoq7
         mPFfar+YZb2MmcdF0mWUBOpJ0t5In/E3kNSljwE0BFVrmb193dQKTs3OQzgl/d8oLclo
         Qp1FqMunvx3z7yfbwt+BEe6tz+VgqHZs4jf7JQfuxX5DmbtSPLSK+VaKkPyZgOzVJUPC
         OV4niLAt0WeGI6VL/qHzVpSUiTAK8ejjs2PAtrA6bHpe9CKeYcJW6cZdJjTit+nENn1n
         o2S5fKycuMOtojZbqnICUBWmtlNgDi38T6W2Dnt9AwJ7HJZBfIBIvHTDXrssgbj15p9A
         Fzyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775082777; x=1775687577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3VfjVME7Yw+jYEXtfoUkrvbamDb8yApBSTnhoz4Zog=;
        b=EI/bE4dZVpXjN1xKM4N9/FjThzs07+3WzQ4ZMReX8KPQQXDKQt79yg7uEjVnA/V/3F
         jkRWB7isO0MSbVmURiEkHlzeE+cAx6/Cvf0DiJwVQJMOwqPO2nJ/XxEGEu/8+LYF3/5H
         +HkUstU+snLFJ+2PGlpt/U0VZ0LcOvEkHgssit4HkrpSj4pE0g4n0QGnqn9PW8GlJy1+
         33Dyzi4Pm24mQOJIlqwT4boiNyko/iaK05N71Vx+VYm3POBA2bx3XFecktCIoXFOklCB
         z38S6JOA23lYyHtFfPrLXfprvfySfawe3t4oXNc3oGR5994eR4KvjeiJjd12nZzoIVwa
         BbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775082777; x=1775687577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B3VfjVME7Yw+jYEXtfoUkrvbamDb8yApBSTnhoz4Zog=;
        b=LDCzCRz4gSCGC1wqg4IBkEQWREcUHN7if+4Q6q5DhSpPvt9KiLMNA7SeIrjDTS692h
         oQIuhVoK0r5Wf2gwG6EhcC4IVAAAz1T+D550seiM7YbB4WRI3eQCnEBEHzSR0erloaJ5
         r1LCr9+fggKneRk76wBJ3Xiba/RTAsNO2bpoWv+iLHcXNPyJI2K+a8Xgbz+9JgAbYPtS
         tHaK1o2Avso6fXE4TT/ARpz/LTJfKy9lnRcordPwe3NJdpOxSPHdMvsG1V0tR87VtOkK
         3Mj61qos2YJvTlX9bEox3HI2h9gUn3C0wyIu8lfaSTr7mRT9TGeZw32xq768yfOFHcKy
         w9TA==
X-Gm-Message-State: AOJu0YzpUkO44LkNZy7LBwzUlkPFe8S1Eoj3P7DHktkLQcbZiMEOGOJ9
	Gj3quJtYCDMKyAd9zeeNeYgyLoNVlyC76J0QgWuzVyLagTq47bmu+0r6KJfvpEGByUnMNSBjBSC
	+p8kvLD3gyrzlqaU9VpZVoS/Fe6e9wEPIKw==
X-Gm-Gg: ATEYQzzqQHMPfMtWXWq9ru94wvb8/GFPq3b6Ttxt4HsHkRYZ2HFN3/PwfkFPHJ+6fzN
	marfsvn8nVPRCCQu25N91CED4yFaabc/kdXM/YxGRDfOyL6ckNn1qsKf517ITns6h8ySzw8QRBS
	Dsy+XeJ7+yKMgeDOSbWzT8tVcw+KSlVcH8KbTCtEpQKV4/yXUtMlwMVVg5vgaPWulHa6QY6PknW
	AXBJ7eF/sMZBmkS8VYcgTtbe9qn7AoyxUHNtGyDf9TLev0jy4QTNpEx6KjShVBhA7xIX7lj2LpL
	S3k8LOoV3hVDfPw9bqCbE88r/szKlq9Ya4pOiMxaytUn2cA9bmSFC+VL/c51ys0+8AQgPQZ6lbi
	imkwYgsNxCTBBKTda6dew/KhVPw==
X-Received: by 2002:a05:600c:1f11:b0:485:4278:2558 with SMTP id
 5b1f17b1804b1-48883569dcamr89140845e9.6.1775082776386; Wed, 01 Apr 2026
 15:32:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401021635.34636-1-alexei.starovoitov@gmail.com>
 <20260401021635.34636-5-alexei.starovoitov@gmail.com> <3c091ab744676990e90469a89a4f0110d724ce19.camel@gmail.com>
In-Reply-To: <3c091ab744676990e90469a89a4f0110d724ce19.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Apr 2026 15:32:45 -0700
X-Gm-Features: AQROBzAIlkirjROntXtIfKqGcsElMiLx5NHI8abCaC4f9VFC0JtU2JDUz6vmf4w
Message-ID: <CAADnVQJtw5A4GbknXoA-BtobOVMiBc+pC8nUQZ+1zX5wbj3ipg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/6] bpf: Add compute_const_regs() and
 prune_dead_branches() passes
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 2:07=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2026-03-31 at 19:16 -0700, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Add two passes before the main verifier pass:
> >
> > compute_const_regs() is a forward dataflow analysis that tracks
> > register values in R0-R9 across the program using fixed-point
> > iteration in reverse postorder. Each register is tracked with
> > a six-state lattice:
> >
> >   UNVISITED -> CONST(val) / MAP_PTR(map_index) /
> >                MAP_VALUE(map_index, offset) / SUBPROG(num) -> UNKNOWN
> >
> > At merge points, if two paths produce the same state and value for
> > a register, it stays; otherwise it becomes UNKNOWN.
> >
> > The analysis handles:
> >  - MOV, ADD, SUB, AND with immediate or register operands
> >  - LD_IMM64 for plain constants, map FDs, map values, and subprogs
> >  - LDX from read-only maps: constant-folds the load by reading the
> >    map value directly via bpf_map_direct_read()
> >
> > Results that fit in 32 bits are stored per-instruction in
> > insn_aux_data and bitmasks.
> >
> > prune_dead_branches() uses the computed constants to evaluate
> > conditional branches. When both operands of a conditional jump are
> > known constants, the branch outcome is determined statically and the
> > instruction is rewritten to an unconditional jump.
> > The CFG postorder is then recomputed to reflect new control flow.
> > This eliminates dead edges so that subsequent liveness analysis
> > doesn't propagate through dead code.
> >
> > Also add runtime sanity check to validate that precomputed
> > constants match the verifier's tracked state.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
>
> Besides issues found by bot this patch lgtm.
>
> [...]
>
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 4f492eaad5c2..0d797de30a3a 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
>
> [...]
>
> > @@ -1086,6 +1102,13 @@ struct bpf_iarray *bpf_insn_successors(struct bp=
f_verifier_env *env, u32 idx);
> >  void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
> >  bool bpf_calls_callback(struct bpf_verifier_env *env, int insn_idx);
> >
> > +int find_subprog(struct bpf_verifier_env *env, int off);
> > +int compute_const_regs(struct bpf_verifier_env *env);
> > +int prune_dead_branches(struct bpf_verifier_env *env);
> > +int compute_postorder(struct bpf_verifier_env *env);
> > +bool insn_is_cond_jump(u8 code);
> > +bool is_may_goto_insn(struct bpf_insn *insn);
> > +
>
> Q: What is the policy regarding naming exported functions?
>    So far I always used "bpf_..." prefix assuming that this
>    is a requirement, was I wrong?

It's nice to have but not mandatory.
imo the names are unique enough, so unlikely to clash.

> >  int bpf_stack_liveness_init(struct bpf_verifier_env *env);
> >  void bpf_stack_liveness_free(struct bpf_verifier_env *env);
> >  int bpf_update_live_stack(struct bpf_verifier_env *env);
>
> [...]
>
> > diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
> > new file mode 100644
> > index 000000000000..9e5abc6ab46a
> > --- /dev/null
> > +++ b/kernel/bpf/const_fold.c
>
> [...]
>
> > +/* Transfer function: compute output register state from instruction. =
*/
> > +static void const_reg_xfer(struct bpf_verifier_env *env, struct const_=
arg_info *ci_out,
> > +                        struct bpf_insn *insn, struct bpf_insn *insns,=
 int idx)
> > +{
> > +     struct const_arg_info unknown =3D { .state =3D CONST_ARG_UNKNOWN,=
 .val =3D 0 };
> > +     struct const_arg_info *dst =3D &ci_out[insn->dst_reg];
> > +     struct const_arg_info *src =3D &ci_out[insn->src_reg];
> > +     u8 class =3D BPF_CLASS(insn->code);
> > +     u8 opcode =3D BPF_OP(insn->code) | BPF_SRC(insn->code);
> > +     int r;
> > +
> > +     switch (class) {
> > +     case BPF_ALU:
> > +     case BPF_ALU64:
> > +             switch (opcode) {
> > +             case BPF_MOV | BPF_K:
> > +                     dst->state =3D CONST_ARG_CONST;
> > +                     dst->val =3D (s64)insn->imm;
> > +                     break;
> > +             case BPF_MOV | BPF_X:
> > +                     *dst =3D *src;
> > +                     if (!insn->off)
> > +                             break;
> > +                     if (!ci_is_const(dst)) {
> > +                             *dst =3D unknown;
> > +                             break;
> > +                     }
> > +                     switch (insn->off) {
> > +                     case 8:  dst->val =3D (s8)dst->val; break;
> > +                     case 16: dst->val =3D (s16)dst->val; break;
> > +                     case 32: dst->val =3D (s32)dst->val; break;
> > +                     default: *dst =3D unknown; break;
> > +                     }
> > +                     break;
> > +             case BPF_ADD | BPF_K:
> > +                     if (!ci_is_const(dst) && !ci_is_map_value(dst)) {
> > +                             *dst =3D unknown;
> > +                             break;
> > +                     }
> > +                     dst->val +=3D insn->imm;
> > +                     break;
> > +             case BPF_SUB | BPF_K:
> > +                     if (!ci_is_const(dst) && !ci_is_map_value(dst)) {
> > +                             *dst =3D unknown;
> > +                             break;
> > +                     }
> > +                     dst->val -=3D insn->imm;
> > +                     break;
> > +             case BPF_AND | BPF_K:
> > +                     if (!ci_is_const(dst)) {
> > +                             if (!insn->imm) {
> > +                                     dst->state =3D CONST_ARG_CONST;
> > +                                     dst->val =3D 0;
> > +                             } else {
> > +                                     *dst =3D unknown;
> > +                             }
> > +                             break;
> > +                     }
> > +                     dst->val &=3D (s64)insn->imm;
> > +                     break;
> > +             case BPF_AND | BPF_X:
> > +                     if (ci_is_const(dst) && dst->val =3D=3D 0)
> > +                             break; /* 0 & x =3D=3D 0 */
> > +                     if (ci_is_const(src) && src->val =3D=3D 0) {
> > +                             dst->state =3D CONST_ARG_CONST;
> > +                             dst->val =3D 0;
> > +                             break;
> > +                     }
> > +                     if (!ci_is_const(dst) || !ci_is_const(src)) {
> > +                             *dst =3D unknown;
> > +                             break;
> > +                     }
> > +                     dst->val &=3D src->val;
> > +                     break;
>
> Just curious, why does this function deal with `0 & reg` cases,
> but not the e.g. `0 | reg` cases? Was it something that came up
> during testing the static analysis?

right. rx &=3D ry is real sched-ext code
where 0 in rx came from rdonly map.

> > +             default:
> > +                     *dst =3D unknown;
> > +                     break;
> > +             }
> > +             if (class =3D=3D BPF_ALU) {
> > +                     if (ci_is_const(dst))
> > +                             dst->val =3D (u32)dst->val;
> > +                     else if (!ci_is_unknown(dst))
> > +                             *dst =3D unknown;
> > +             }
> > +             break;
> > +     case BPF_LD:
> > +             if (BPF_MODE(insn->code) !=3D BPF_IMM || BPF_SIZE(insn->c=
ode) !=3D BPF_DW)
>
> Should this reset r0-r5 in case of opcode is  BPF_LD|BPF_ABS or BPF_LD|BP=
F_IND?

great catch!
codex and claude never thought of that.

>
> > +                     break;
> > +             if (insn->src_reg =3D=3D BPF_PSEUDO_FUNC) {
> > +                     int subprog =3D find_subprog(env, idx + insn->imm=
 + 1);
> > +
> > +                     if (subprog >=3D 0) {
> > +                             dst->state =3D CONST_ARG_SUBPROG;
> > +                             dst->val =3D subprog;
> > +                     } else {
> > +                             *dst =3D unknown;
> > +                     }
> > +             } else if (insn->src_reg =3D=3D BPF_PSEUDO_MAP_VALUE ||
> > +                        insn->src_reg =3D=3D BPF_PSEUDO_MAP_IDX_VALUE)=
 {
> > +                     dst->state =3D CONST_ARG_MAP_VALUE;
> > +                     dst->map_index =3D env->insn_aux_data[idx].map_in=
dex;
> > +                     dst->val =3D env->insn_aux_data[idx].map_off;
> > +             } else if (insn->src_reg =3D=3D BPF_PSEUDO_MAP_FD ||
> > +                        insn->src_reg =3D=3D BPF_PSEUDO_MAP_IDX) {
> > +                     dst->state =3D CONST_ARG_MAP_PTR;
> > +                     dst->map_index =3D env->insn_aux_data[idx].map_in=
dex;
> > +             } else if (insn->src_reg =3D=3D 0) {
> > +                     dst->state =3D CONST_ARG_CONST;
> > +                     dst->val =3D (u64)(u32)insn->imm | ((u64)(u32)ins=
ns[idx + 1].imm << 32);
> > +             } else {
> > +                     *dst =3D unknown;
> > +             }
> > +             break;
> > +     case BPF_LDX:
> > +             if (!ci_is_map_value(src)) {
> > +                     *dst =3D unknown;
> > +                     break;
> > +             }
> > +             struct bpf_map *map =3D env->used_maps[src->map_index];
> > +             int size =3D bpf_size_to_bytes(BPF_SIZE(insn->code));
> > +             bool is_ldsx =3D BPF_MODE(insn->code) =3D=3D BPF_MEMSX;
> > +             int off =3D src->val + insn->off;
> > +             u64 val =3D 0;
> > +
> > +             if (!bpf_map_is_rdonly(map) || !map->ops->map_direct_valu=
e_addr ||
> > +                 bpf_map_direct_read(map, off, size, &val, is_ldsx)) {
>
> Nit: Similar sequence in verifier.c also checks for map->map_type !=3D BP=
F_MAP_TYPE_INSN_ARRAY.

ack

>      Maybe move this to a helper function?

it's not exactly the same.
maybe later.

> > +                     *dst =3D unknown;
> > +                     break;
> > +             }
> > +             dst->state =3D CONST_ARG_CONST;
> > +             dst->val =3D val;
> > +             break;
> > +     case BPF_JMP:
> > +             if (opcode !=3D BPF_CALL)
> > +                     break;
> > +             for (r =3D BPF_REG_0; r <=3D BPF_REG_5; r++)
> > +                     ci_out[r] =3D unknown;
> > +             break;
> > +     case BPF_STX:
> > +             if (BPF_MODE(insn->code) !=3D BPF_ATOMIC)
> > +                     break;
> > +             if (insn->imm =3D=3D BPF_CMPXCHG)
> > +                     ci_out[BPF_REG_0] =3D unknown;
> > +             else if (insn->imm =3D=3D BPF_LOAD_ACQ)
> > +                     *dst =3D unknown;
> > +             else if (insn->imm & BPF_FETCH)
> > +                     *src =3D unknown;
> > +             break;
> > +     }
> > +}
>
> [...]
>
> > +static bool eval_const_branch(u8 opcode, u64 dst_val, u64 src_val)
> > +{
> > +     switch (BPF_OP(opcode)) {
> > +     case BPF_JEQ:   return dst_val =3D=3D src_val;
> > +     case BPF_JNE:   return dst_val !=3D src_val;
> > +     case BPF_JGT:   return dst_val > src_val;
> > +     case BPF_JGE:   return dst_val >=3D src_val;
> > +     case BPF_JLT:   return dst_val < src_val;
> > +     case BPF_JLE:   return dst_val <=3D src_val;
> > +     case BPF_JSGT:  return (s64)dst_val > (s64)src_val;
> > +     case BPF_JSGE:  return (s64)dst_val >=3D (s64)src_val;
> > +     case BPF_JSLT:  return (s64)dst_val < (s64)src_val;
> > +     case BPF_JSLE:  return (s64)dst_val <=3D (s64)src_val;
> > +     case BPF_JSET:  return dst_val & src_val;
> > +     default:        return false;
>
> Do we want to validate that the above are the only opcodes possible,
> e.g. in patch #1?

I felt it's too much defensive programming,
but, on a second thought..
will return -1 and deal with it in the caller.
