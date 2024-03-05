Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98825C5FD
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 20:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709671955; cv=none; b=E1ThMLEV3luib2Sdx3TUHcTKcqBmDIDXZW4klPmEeIwcttSNYrzUyqxJrrImIG89VzY+i/qdIJzgkquzRfs66yQOAZz7L60rV5RjoiThV2uQwKkaRWa158EV0wYPbKKbbymCXr4i0c5Uks0GnnsPx9W4dILcHwISNDTQiXpTJvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709671955; c=relaxed/simple;
	bh=CSLHSEicfrGjOC9yrYM+AZCt8WoYnz5Ajs/2bb428yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AeKKKPlrZ6g8NTVTHUrlAkvq8aumMBK/SKsNAOVlEZ/vvbr2wZgXuWK+i6fWyEuJJy0J7jWDXowNMqLsHFucOwer4VdFHK4ra/nOtxmAs7pyh5VTJhHh98EsWp6cE8RednbEkYi53kgvJ+6hbFdEnYStd1LaIdSzyKATr/p8Zdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3ShTs1z; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3ShTs1z"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412e68b8594so2136855e9.1
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 12:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709671952; x=1710276752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmB+CUi4CKzb4P+BL098C47ocY/pjyvFp3Cwe6qk7tE=;
        b=U3ShTs1zsy1tf8TznplsWMLbOolX5gA+55z0v1fWAIc7tzXc6EKBs0azRtCieC7MnA
         ++ArIKNFDkMBjrM0RbNcgRI8i4kwZVtCFkA9SzGBMkUuUHRnUMmOJgf6O1JUs7WzCgw3
         b19g9cW13xNXYZwVLKSmPWaIrVXLJFVCDJ7kj+vw0ig+CKl4P2DfdxoWFsoM+7WGewr5
         456+nioVyCRrLAUzmnmLxjlclgpvOL6k3ebAQOaHTOdoWPJp2oiua5HiX1bz687zkXX4
         PoZBOyEfnU1uRPUet1kUjg3zfrp0ZIvptVo4P7JaKbx5gIn7ZA+HDMGfUD5Bfew3B3v9
         xZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709671952; x=1710276752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmB+CUi4CKzb4P+BL098C47ocY/pjyvFp3Cwe6qk7tE=;
        b=Mgfa1lFHLtuFEbThuKUmg3C0gPL0papHHEL/XCkMeYTbiAeYM3iZFVeOY7EnkbjGo5
         zKroJW2iTjrmbmDF3UMXXD7vWrCcnzE21oY1JlEq6div3Jau9RAl65Apw9yBCXssvkSD
         aRWjUpjwnph3Nn5WpX0EyCXudMPE/M9tzCua/xyj3KLIX6n91OjFUSj3bsnVeSowq5ht
         23kgqO/+wSHWkwsKkiB547ZMpHSqbO7d1ihsIM2DP1ovZK71S/r0jo8D+n9sj1t0S/DN
         WaX7u4XUkBNoBtEx3AAjSPaO9zKYzA2Ou39xJ6EiwK2b8KOlwsqXmUqQ/lot8FdPU55g
         9Usw==
X-Gm-Message-State: AOJu0Ywf9GHu5SxZY/O2i7KEgnZgPZ4glUu08K8E1X+B5zHDwYwhOQlZ
	buvcKxSTEuJgTO2AQvTle/kTwN7Fl0CCEwP//B+sz2BFt0velOPyKoLZWzP5a/t1snC1iI1Kyfj
	pfHM7N/Iuh7AhHOQjifpboSaZZQvRJaILfc0=
X-Google-Smtp-Source: AGHT+IHhn/GLe6MkvLRUzf6RSJgvLZTZ6DFXdNgwgxzsRROrsa4HrDL2iKVVDmgNmQpzySG/CtnPhbSxsOWuje7LIUY=
X-Received: by 2002:a5d:6852:0:b0:33e:48db:ba65 with SMTP id
 o18-20020a5d6852000000b0033e48dbba65mr1996245wrw.21.1709671951951; Tue, 05
 Mar 2024 12:52:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305045219.66142-1-alexei.starovoitov@gmail.com>
 <20240305045219.66142-2-alexei.starovoitov@gmail.com> <CAEf4BzbiP9kMq+sELSW3sxzhGn=Or7fqwXZN5RTPC+_QQNMBsA@mail.gmail.com>
In-Reply-To: <CAEf4BzbiP9kMq+sELSW3sxzhGn=Or7fqwXZN5RTPC+_QQNMBsA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 5 Mar 2024 12:52:20 -0800
Message-ID: <CAADnVQK-=QTB7b3X97y0Fq7OCtp3eb=n00+FJftM5a0QKWFCLQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/4] bpf: Introduce may_goto instruction
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 10:38=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Mar 4, 2024 at 8:52=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Introduce may_goto instruction that acts on a hidden bpf_iter_num, so t=
hat
> > bpf_iter_num_new(), bpf_iter_num_destroy() don't need to be called expl=
icitly.
>
> bpf_iter_num was probably an inspiration, but I think by now the
> analogy is pretty weak. bpf_iter_num_next() returns NULL or pointer to
> int (i.e., it returns some usable value), while may_goto jumps or not.
> So it's not just implicit new/destroy. The above doesn't confuse me,
> but I wonder if someone less familiar with iterators would be confused
> by the above?

Agree. Will reword.

>
> > It can be used in any normal "for" or "while" loop, like
> >
> >   for (i =3D zero; i < cnt; cond_break, i++) {
> >
> > The verifier recognizes that may_goto is used in the program,
> > reserves additional 8 bytes of stack, initializes them in subprog
> > prologue, and replaces may_goto instruction with:
> > aux_reg =3D *(u64 *)(fp - 40)
> > if aux_reg =3D=3D 0 goto pc+off
> > aux_reg +=3D 1
>
> `aux_reg -=3D 1`?

+1 for -1

>
> > *(u64 *)(fp - 40) =3D aux_reg
> >
> > may_goto instruction can be used by LLVM to implement __builtin_memcpy,
> > __builtin_strcmp.
> >
> > may_goto is not a full substitute for bpf_for() macro.
> > bpf_for() doesn't have induction variable that verifiers sees,
> > so 'i' in bpf_for(i, 0, 100) is seen as imprecise and bounded.
> >
> > But when the code is written as:
> > for (i =3D 0; i < 100; cond_break, i++)
> > the verifier see 'i' as precise constant zero,
> > hence cond_break (aka may_goto) doesn't help to converge the loop.
> > A static or global variable can be used as a workaround:
> > static int zero =3D 0;
> > for (i =3D zero; i < 100; cond_break, i++) // works!
> >
> > may_goto works well with arena pointers that don't need to be bounds-ch=
ecked
> > on every iteration. Load/store from arena returns imprecise unbounded s=
calars.
> >
> > Reserve new opcode BPF_JMP | BPF_JMA for may_goto insn.
> > JMA stands for "jump maybe", and "jump multipurpose", and "jump multi a=
lways".
> > Since goto_or_nop insn was proposed, it may use the same opcode.
> > may_goto vs goto_or_nop can be distinguished by src_reg:
> > code =3D BPF_JMP | BPF_JMA:
> > src_reg =3D 0 - may_goto
> > src_reg =3D 1 - goto_or_nop
> > We could have reused BPF_JMP | BPF_JA like:
> > src_reg =3D 0 - normal goto
> > src_reg =3D 1 - may_goto
> > src_reg =3D 2 - goto_or_nop
> > but JA is a real insn and it's unconditional, while may_goto and goto_o=
r_nop
> > are pseudo instructions, and both are conditional. Hence it's better to
> > have a different opcode for them. Hence BPF_JMA.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  include/linux/bpf_verifier.h   |   2 +
> >  include/uapi/linux/bpf.h       |   1 +
> >  kernel/bpf/core.c              |   1 +
> >  kernel/bpf/disasm.c            |   3 +
> >  kernel/bpf/verifier.c          | 156 ++++++++++++++++++++++++++-------
> >  tools/include/uapi/linux/bpf.h |   1 +
> >  6 files changed, 134 insertions(+), 30 deletions(-)
> >
>
> Not a huge fan of BPF_JMA, but there is no clear naming winner.
> BPF_JAUX, BPF_JPSEUDO, BPF_JMAYBE, would be a bit more
> greppable/recognizable, but it's not a big deal.

In the next version I'm planning to go with BPF_JCOND
to describe a new class of conditional pseudo jumps.
A comment hopefully will be good enough to avoid confusion
with existing conditional jumps (all of them except BPF_JA)
I will also add
enum {
 BPF_MAY_GOTO =3D 0,
};
and check that src_reg is equal to that.
Then in the future it can be extended with:
 BPF_NOP_OR_GOTO =3D 1,

> Left few nits below, but overall LGTM
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 84365e6dd85d..917ca603059b 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -449,6 +449,7 @@ struct bpf_verifier_state {
> >         u32 jmp_history_cnt;
> >         u32 dfs_depth;
> >         u32 callback_unroll_depth;
> > +       u32 may_goto_cnt;
>
> naming nit: seems like we consistently use "depth" terminology for
> bpf_loop and open-coded iters, any reason to deviate with "cnt"
> terminology here?

sure.

> >  };
> >
> >  #define bpf_get_spilled_reg(slot, frame, mask)                        =
 \
>
> [...]
>
> >
> > +static bool is_may_goto_insn(struct bpf_verifier_env *env, int insn_id=
x)
> > +{
> > +       return env->prog->insnsi[insn_idx].code =3D=3D (BPF_JMP | BPF_J=
MA);
> > +}
> > +
> >  /* process_iter_next_call() is called when verifier gets to iterator's=
 next
> >   * "method" (e.g., bpf_iter_num_next() for numbers iterator) call. We'=
ll refer
> >   * to it as just "iter_next()" in comments below.
> > @@ -14871,11 +14877,35 @@ static int check_cond_jmp_op(struct bpf_verif=
ier_env *env,
> >         int err;
> >
> >         /* Only conditional jumps are expected to reach here. */
> > -       if (opcode =3D=3D BPF_JA || opcode > BPF_JSLE) {
> > +       if (opcode =3D=3D BPF_JA || opcode > BPF_JMA) {
> >                 verbose(env, "invalid BPF_JMP/JMP32 opcode %x\n", opcod=
e);
> >                 return -EINVAL;
> >         }
> >
> > +       if (opcode =3D=3D BPF_JMA) {
> > +               struct bpf_verifier_state *cur_st =3D env->cur_state, *=
queued_st, *prev_st;
> > +               int idx =3D *insn_idx;
> > +
> > +               if (insn->code !=3D (BPF_JMP | BPF_JMA) ||
> > +                   insn->src_reg || insn->dst_reg || insn->imm || insn=
->off =3D=3D 0) {
> > +                       verbose(env, "invalid may_goto off %d imm %d\n"=
,
> > +                               insn->off, insn->imm);
> > +                       return -EINVAL;
> > +               }
> > +               prev_st =3D find_prev_entry(env, cur_st->parent, idx);
> > +
> > +               /* branch out 'fallthrough' insn as a new state to expl=
ore */
> > +               queued_st =3D push_stack(env, idx + 1, idx, false);
> > +               if (!queued_st)
> > +                       return -ENOMEM;
> > +
> > +               queued_st->may_goto_cnt++;
> > +               if (prev_st)
> > +                       widen_imprecise_scalars(env, prev_st, queued_st=
);
> > +               *insn_idx +=3D insn->off;
> > +               return 0;
> > +       }
> > +
> >         /* check src2 operand */
> >         err =3D check_reg_arg(env, insn->dst_reg, SRC_OP);
> >         if (err)
> > @@ -15659,6 +15689,8 @@ static int visit_insn(int t, struct bpf_verifie=
r_env *env)
> >         default:
> >                 /* conditional jump with two edges */
> >                 mark_prune_point(env, t);
> > +               if (insn->code =3D=3D (BPF_JMP | BPF_JMA))
>
> maybe use is_may_goto_insn() here for consistency?

+1

> > +                       mark_force_checkpoint(env, t);
> >
> >                 ret =3D push_insn(t, t + 1, FALLTHROUGH, env);
> >                 if (ret)
>
> [...]
>
> >  patch_call_imm:
> >                 fn =3D env->ops->get_func_proto(insn->imm, env->prog);
> > @@ -19952,6 +20015,39 @@ static int do_misc_fixups(struct bpf_verifier_=
env *env)
> >                         return -EFAULT;
> >                 }
> >                 insn->imm =3D fn->func - __bpf_call_base;
> > +next_insn:
> > +               if (subprogs[cur_subprog + 1].start =3D=3D i + delta + =
1) {
> > +                       subprogs[cur_subprog].stack_depth +=3D stack_de=
pth_extra;
> > +                       subprogs[cur_subprog].stack_extra =3D stack_dep=
th_extra;
> > +                       cur_subprog++;
> > +                       stack_depth =3D subprogs[cur_subprog].stack_dep=
th;
> > +                       stack_depth_extra =3D 0;
> > +               }
> > +               i++; insn++;
>
> Is there a code path where we don't do i++, insn++? From cursory look
> at this loop, I think we always do this, so not sure why `i++, insn++`
> had to be moved from for() clause?

I was worried about missing replacing 'continue' with 'goto next_insn'.
Since 'continue' will work for all tests except may_goto tests,
and in arena patch set I have a hunk that is added to this loop too
and it is written with 'continue'.
Technically we can keep 'i++; insn++;' in the for()...
if we're going to be code reviewing any future additions carefully.
In other words 'stack_extra logic plus i and insn increments'
are part of the same logical block. It's an action that should
be done after each insn, hence better to keep them together.
Either inside for() as I did in v1/v2 or here toward the last '}'.
The latter is more canonical C.

>
> But if I missed it and we have to do these increments here, these are
> two separate statements, so let's put them on separate lines?

sure.

>
> > +       }
> > +
> > +       env->prog->aux->stack_depth =3D subprogs[0].stack_depth;
> > +       for (i =3D 0; i < env->subprog_cnt; i++) {
> > +               int subprog_start =3D subprogs[i].start, j;
> > +               int stack_slots =3D subprogs[i].stack_extra / 8;
> > +
> > +               if (stack_slots >=3D ARRAY_SIZE(insn_buf)) {
> > +                       verbose(env, "verifier bug: stack_extra is too =
large\n");
> > +                       return -EFAULT;
> > +               }
> > +
> > +               /* Add insns to subprog prologue to init extra stack */
> > +               for (j =3D 0; j < stack_slots; j++)
> > +                       insn_buf[j] =3D BPF_ST_MEM(BPF_DW, BPF_REG_FP,
> > +                                                -subprogs[i].stack_dep=
th + j * 8, BPF_MAX_LOOPS);
> > +               if (j) {
> > +                       insn_buf[j] =3D env->prog->insnsi[subprog_start=
];
> > +
> > +                       new_prog =3D bpf_patch_insn_data(env, subprog_s=
tart, insn_buf, j + 1);
> > +                       if (!new_prog)
> > +                               return -ENOMEM;
> > +                       env->prog =3D prog =3D new_prog;
> > +               }
>
> this code is sort of generic (you don't assume just 0 or 1 extra
> slots), but then it initializes each extra slot with BPF_MAX_LOOPS,
> which doesn't look generic at all. So it's neither as simple as it
> could be nor generic, really...
>
> Maybe let's add WARN_ON if stack_extra>1 (so we catch it if we ever
> extend this), but otherwise just have a simple and easier to follow
>
> if (stack_slots) {
>     insn_buf[0] =3D BPF_ST_MEM(..., BPF_MAX_LOOPS);
>     /* bpf_patch_insn_data() replaces instruction,
>      * so we need to copy first actual insn to preserve it (it's not
> that obvious)
>      */
>     insn_buf[1] =3D env->prog->insnsi[subprog_start];
>     ... patch ...
> }
>
> It's pretty minor, overall, but definitely caused some pause for me.

I had it like that in v2, but then thought that I might
try to use this to fix tail_call from subprogs issue discussed
in the separate thread, so I changed it to generic zero init in v3,
but then went with BPF_MAX_LOOPS init in v4.
Looking at this now it seems hard coding to stack_slots=3D=3D1 is better in=
deed.
