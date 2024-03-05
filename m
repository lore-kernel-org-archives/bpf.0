Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206E68F7A
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 18:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709663888; cv=none; b=kmRyZYAKHOseAv4xOJu5FhercivaDRhuec2T32hUV8YuwcwpWc/vvhsA1JCEcGaaI4qbq8Npad9/rxyUmCN85dpEj2kLGRoXIO4RUw6EcOqQUO9dF7ydSi1pyifhnbt3aa5F0jhZiCjIGKnuljznx7hIyDMdiBbW6MNLRb9Q3J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709663888; c=relaxed/simple;
	bh=su+dqEHL4ukojrM/mA8ZkUb1Fdl/D/8GgkKAfgTiygw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpMGk2Vcc4yc858yXl+FnjOw+toPLRkWN9pLGS38vJVRv/PluRXQPsaND5+19i6q4Xk9B9/F0S3Q9zhzcopOSO5RqTgqRG1jmM6z/PYeY4ssIwlz11IBBeuiWrHnNXtDMLpW6p+BdPRFPbqHcknnwWmWKaCr5CToSyoS1yq8LPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvDxCLk/; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvDxCLk/"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e56787e691so49612b3a.0
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 10:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709663886; x=1710268686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTpb2oejm4rOPX+ibWhoG7G8lY6/cE7Rr2RclLR69/Y=;
        b=KvDxCLk/cBlkfO1+LcRu+5D/I8jzLOW7d222P/mf64uXSgG+38xLIhertVkU2G0H+q
         9FoCWMViQHLB9+2O0Yz5ZhLueDxL7bxwx/je6EYcvGr+IXggxQk55HLlsIatL98LXRCN
         qiyr98QmsZQTKDB9IaRcMUhCht+HHp4KUnfU7DdBKTtWCjLxHkITHQeBHmTiMAgXD+kL
         cNSPwbaoSM6mhStPh6a9Ma21ZVa2PwhcKqUWyH3iPiGiWNEgtxDfpauM1ut47FnYK+Q2
         DFzY4uOfSte3DG742imO4ZBw33BDl9FkCnoDkZKyDlmwYCC2WxTR/LN0S3ajBJ6f13OH
         HPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709663886; x=1710268686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTpb2oejm4rOPX+ibWhoG7G8lY6/cE7Rr2RclLR69/Y=;
        b=Pc/moK6VJ2pXQC90p2/wPNOE3v3EJNwpzNq9qoJ3oWiClInZl+74UdrUOblRmwnNIm
         1FSQFhrN3D0LZa2bJL2T0vV/sfOVrWFWsWMDnY0L4+yq5ytSUPqP0hlJSrP+aI1TQo7b
         GLHtWhw90/9QdJaQv8fbgLptx2DAYVLA7IPReXalcZ1kDFdnA2I7bvwbFR2dcXyWzBNb
         tO3Ios0YXJyXJLNOwWI1rbapXGD4YU6a2pNUxZ6GmbRrjICpORWMRE/4FLRFBRHjkbon
         puI32KsZH8eIsRndbtE7ydrXYdm/60qkjuaXXO+xO/hQfUbvNpHmwWAtVrUdtX/Fyu2d
         MnmA==
X-Gm-Message-State: AOJu0YxIBnfFej4/mOkAj4G655t71Yd7vWnwX4BaRy/Q6XPx4blI4s8p
	4gxUSNOl/CN5SXPRqsS62hzjTkYV21O5sHPssvHjn9YSSaNTx13b35zaLi0jDA2t3yzk2DodsZA
	1bb1GU9tRuhXlreSWgi2KYyG1lLA=
X-Google-Smtp-Source: AGHT+IGdzxnJzORjkWCiLZaXYox0xnb/cxDKt18ASC+3ZSPoeq/U229zljv6ibkLdCrBC/o7EFEXfttGxtpxS8klaI8=
X-Received: by 2002:a05:6a20:734b:b0:1a1:2f23:58b3 with SMTP id
 v11-20020a056a20734b00b001a12f2358b3mr3224610pzc.23.1709663886219; Tue, 05
 Mar 2024 10:38:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305045219.66142-1-alexei.starovoitov@gmail.com> <20240305045219.66142-2-alexei.starovoitov@gmail.com>
In-Reply-To: <20240305045219.66142-2-alexei.starovoitov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 5 Mar 2024 10:37:54 -0800
Message-ID: <CAEf4BzbiP9kMq+sELSW3sxzhGn=Or7fqwXZN5RTPC+_QQNMBsA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/4] bpf: Introduce may_goto instruction
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com, 
	john.fastabend@gmail.com, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 8:52=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Introduce may_goto instruction that acts on a hidden bpf_iter_num, so tha=
t
> bpf_iter_num_new(), bpf_iter_num_destroy() don't need to be called explic=
itly.

bpf_iter_num was probably an inspiration, but I think by now the
analogy is pretty weak. bpf_iter_num_next() returns NULL or pointer to
int (i.e., it returns some usable value), while may_goto jumps or not.
So it's not just implicit new/destroy. The above doesn't confuse me,
but I wonder if someone less familiar with iterators would be confused
by the above?

> It can be used in any normal "for" or "while" loop, like
>
>   for (i =3D zero; i < cnt; cond_break, i++) {
>
> The verifier recognizes that may_goto is used in the program,
> reserves additional 8 bytes of stack, initializes them in subprog
> prologue, and replaces may_goto instruction with:
> aux_reg =3D *(u64 *)(fp - 40)
> if aux_reg =3D=3D 0 goto pc+off
> aux_reg +=3D 1

`aux_reg -=3D 1`?

> *(u64 *)(fp - 40) =3D aux_reg
>
> may_goto instruction can be used by LLVM to implement __builtin_memcpy,
> __builtin_strcmp.
>
> may_goto is not a full substitute for bpf_for() macro.
> bpf_for() doesn't have induction variable that verifiers sees,
> so 'i' in bpf_for(i, 0, 100) is seen as imprecise and bounded.
>
> But when the code is written as:
> for (i =3D 0; i < 100; cond_break, i++)
> the verifier see 'i' as precise constant zero,
> hence cond_break (aka may_goto) doesn't help to converge the loop.
> A static or global variable can be used as a workaround:
> static int zero =3D 0;
> for (i =3D zero; i < 100; cond_break, i++) // works!
>
> may_goto works well with arena pointers that don't need to be bounds-chec=
ked
> on every iteration. Load/store from arena returns imprecise unbounded sca=
lars.
>
> Reserve new opcode BPF_JMP | BPF_JMA for may_goto insn.
> JMA stands for "jump maybe", and "jump multipurpose", and "jump multi alw=
ays".
> Since goto_or_nop insn was proposed, it may use the same opcode.
> may_goto vs goto_or_nop can be distinguished by src_reg:
> code =3D BPF_JMP | BPF_JMA:
> src_reg =3D 0 - may_goto
> src_reg =3D 1 - goto_or_nop
> We could have reused BPF_JMP | BPF_JA like:
> src_reg =3D 0 - normal goto
> src_reg =3D 1 - may_goto
> src_reg =3D 2 - goto_or_nop
> but JA is a real insn and it's unconditional, while may_goto and goto_or_=
nop
> are pseudo instructions, and both are conditional. Hence it's better to
> have a different opcode for them. Hence BPF_JMA.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/bpf_verifier.h   |   2 +
>  include/uapi/linux/bpf.h       |   1 +
>  kernel/bpf/core.c              |   1 +
>  kernel/bpf/disasm.c            |   3 +
>  kernel/bpf/verifier.c          | 156 ++++++++++++++++++++++++++-------
>  tools/include/uapi/linux/bpf.h |   1 +
>  6 files changed, 134 insertions(+), 30 deletions(-)
>

Not a huge fan of BPF_JMA, but there is no clear naming winner.
BPF_JAUX, BPF_JPSEUDO, BPF_JMAYBE, would be a bit more
greppable/recognizable, but it's not a big deal.

Left few nits below, but overall LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 84365e6dd85d..917ca603059b 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -449,6 +449,7 @@ struct bpf_verifier_state {
>         u32 jmp_history_cnt;
>         u32 dfs_depth;
>         u32 callback_unroll_depth;
> +       u32 may_goto_cnt;

naming nit: seems like we consistently use "depth" terminology for
bpf_loop and open-coded iters, any reason to deviate with "cnt"
terminology here?

>  };
>
>  #define bpf_get_spilled_reg(slot, frame, mask)                         \

[...]

>
> +static bool is_may_goto_insn(struct bpf_verifier_env *env, int insn_idx)
> +{
> +       return env->prog->insnsi[insn_idx].code =3D=3D (BPF_JMP | BPF_JMA=
);
> +}
> +
>  /* process_iter_next_call() is called when verifier gets to iterator's n=
ext
>   * "method" (e.g., bpf_iter_num_next() for numbers iterator) call. We'll=
 refer
>   * to it as just "iter_next()" in comments below.
> @@ -14871,11 +14877,35 @@ static int check_cond_jmp_op(struct bpf_verifie=
r_env *env,
>         int err;
>
>         /* Only conditional jumps are expected to reach here. */
> -       if (opcode =3D=3D BPF_JA || opcode > BPF_JSLE) {
> +       if (opcode =3D=3D BPF_JA || opcode > BPF_JMA) {
>                 verbose(env, "invalid BPF_JMP/JMP32 opcode %x\n", opcode)=
;
>                 return -EINVAL;
>         }
>
> +       if (opcode =3D=3D BPF_JMA) {
> +               struct bpf_verifier_state *cur_st =3D env->cur_state, *qu=
eued_st, *prev_st;
> +               int idx =3D *insn_idx;
> +
> +               if (insn->code !=3D (BPF_JMP | BPF_JMA) ||
> +                   insn->src_reg || insn->dst_reg || insn->imm || insn->=
off =3D=3D 0) {
> +                       verbose(env, "invalid may_goto off %d imm %d\n",
> +                               insn->off, insn->imm);
> +                       return -EINVAL;
> +               }
> +               prev_st =3D find_prev_entry(env, cur_st->parent, idx);
> +
> +               /* branch out 'fallthrough' insn as a new state to explor=
e */
> +               queued_st =3D push_stack(env, idx + 1, idx, false);
> +               if (!queued_st)
> +                       return -ENOMEM;
> +
> +               queued_st->may_goto_cnt++;
> +               if (prev_st)
> +                       widen_imprecise_scalars(env, prev_st, queued_st);
> +               *insn_idx +=3D insn->off;
> +               return 0;
> +       }
> +
>         /* check src2 operand */
>         err =3D check_reg_arg(env, insn->dst_reg, SRC_OP);
>         if (err)
> @@ -15659,6 +15689,8 @@ static int visit_insn(int t, struct bpf_verifier_=
env *env)
>         default:
>                 /* conditional jump with two edges */
>                 mark_prune_point(env, t);
> +               if (insn->code =3D=3D (BPF_JMP | BPF_JMA))

maybe use is_may_goto_insn() here for consistency?

> +                       mark_force_checkpoint(env, t);
>
>                 ret =3D push_insn(t, t + 1, FALLTHROUGH, env);
>                 if (ret)

[...]

>  patch_call_imm:
>                 fn =3D env->ops->get_func_proto(insn->imm, env->prog);
> @@ -19952,6 +20015,39 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
>                         return -EFAULT;
>                 }
>                 insn->imm =3D fn->func - __bpf_call_base;
> +next_insn:
> +               if (subprogs[cur_subprog + 1].start =3D=3D i + delta + 1)=
 {
> +                       subprogs[cur_subprog].stack_depth +=3D stack_dept=
h_extra;
> +                       subprogs[cur_subprog].stack_extra =3D stack_depth=
_extra;
> +                       cur_subprog++;
> +                       stack_depth =3D subprogs[cur_subprog].stack_depth=
;
> +                       stack_depth_extra =3D 0;
> +               }
> +               i++; insn++;

Is there a code path where we don't do i++, insn++? From cursory look
at this loop, I think we always do this, so not sure why `i++, insn++`
had to be moved from for() clause?

But if I missed it and we have to do these increments here, these are
two separate statements, so let's put them on separate lines?

> +       }
> +
> +       env->prog->aux->stack_depth =3D subprogs[0].stack_depth;
> +       for (i =3D 0; i < env->subprog_cnt; i++) {
> +               int subprog_start =3D subprogs[i].start, j;
> +               int stack_slots =3D subprogs[i].stack_extra / 8;
> +
> +               if (stack_slots >=3D ARRAY_SIZE(insn_buf)) {
> +                       verbose(env, "verifier bug: stack_extra is too la=
rge\n");
> +                       return -EFAULT;
> +               }
> +
> +               /* Add insns to subprog prologue to init extra stack */
> +               for (j =3D 0; j < stack_slots; j++)
> +                       insn_buf[j] =3D BPF_ST_MEM(BPF_DW, BPF_REG_FP,
> +                                                -subprogs[i].stack_depth=
 + j * 8, BPF_MAX_LOOPS);
> +               if (j) {
> +                       insn_buf[j] =3D env->prog->insnsi[subprog_start];
> +
> +                       new_prog =3D bpf_patch_insn_data(env, subprog_sta=
rt, insn_buf, j + 1);
> +                       if (!new_prog)
> +                               return -ENOMEM;
> +                       env->prog =3D prog =3D new_prog;
> +               }

this code is sort of generic (you don't assume just 0 or 1 extra
slots), but then it initializes each extra slot with BPF_MAX_LOOPS,
which doesn't look generic at all. So it's neither as simple as it
could be nor generic, really...

Maybe let's add WARN_ON if stack_extra>1 (so we catch it if we ever
extend this), but otherwise just have a simple and easier to follow

if (stack_slots) {
    insn_buf[0] =3D BPF_ST_MEM(..., BPF_MAX_LOOPS);
    /* bpf_patch_insn_data() replaces instruction,
     * so we need to copy first actual insn to preserve it (it's not
that obvious)
     */
    insn_buf[1] =3D env->prog->insnsi[subprog_start];
    ... patch ...
}

It's pretty minor, overall, but definitely caused some pause for me.

>         }
>
>         /* Since poke tab is now finalized, publish aux to tracker. */
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index a241f407c234..932ffef0dc88 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -42,6 +42,7 @@
>  #define BPF_JSGE       0x70    /* SGE is signed '>=3D', GE in x86 */
>  #define BPF_JSLT       0xc0    /* SLT is signed, '<' */
>  #define BPF_JSLE       0xd0    /* SLE is signed, '<=3D' */
> +#define BPF_JMA                0xe0    /* may_goto */
>  #define BPF_CALL       0x80    /* function call */
>  #define BPF_EXIT       0x90    /* function return */
>
> --
> 2.43.0
>
