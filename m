Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9491369BA
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709750031; cv=none; b=RVw9E+CDnk81pzF4qNq3h+NQ/8enjEkhID27JkZU32Ja5DkrSgY1dmZ+E8+mWUbbf9OD4zcwz25c6Wg5FvtFeQdOgFoeE2FnwmdqE0akB/OsLNdWl8T+tEnqrKY6xfdZ9to8xbg49inCrq2KqCDjYKOtQQrN1Ld0tjztkHmfCR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709750031; c=relaxed/simple;
	bh=Kcy9xpbjLutzQ1xAueTefN8Qn6qZ+UhP3ck9DqXORZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7zZ/N/fSWTBx+/udh+r2ckLOkmfyU/j0bLgQ+ky485wi9sBt/QPSx9Fml6uqgNEIob/ATwdH8pKLLeeRY7I7OOMqjSADtDa5Z/Res5cNbJVX7zb8ob5GjjKtz/9HqyOeKVCwUIq7K14dgIo3hn/GWZ5Mi90IOt+jhvBdHF7xms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilySs206; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilySs206"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso1021550a12.0
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 10:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709750029; x=1710354829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7DMYjEiPme1zYDBICwsa+OT0KuJfPSCQiCYtjtWQoI=;
        b=ilySs2068ucg+D9rOssJmzD23ZFx65sxfujhkXwA0lC73vc/6CvW8+PqcGd6v52pHl
         5OEzehAxvgZjLTZsLudHTwNAqT6hseG1iz4jDUXSGGtquA/xi+n/KpGKDL8c/dzuALiM
         F5e9cfAEuyKyeuBFAqaac3kB0aOIM0w0c8NOg1qZdld9DsQQw+c3ChLDlADQVsoANIGW
         HIZuKo6xnEYXVYq5t1wdPHP9n1WwZuaTOBpVA7uGTxL+xbSTrfBSTKiwFhNis5eJrfnC
         JaFd/dI/bBmi5tbX0MY4W0R/SyZZiYVZw+WbjgTZh8FCDdoZT2h0A2vuwbYRmK6BR9aE
         XgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709750029; x=1710354829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7DMYjEiPme1zYDBICwsa+OT0KuJfPSCQiCYtjtWQoI=;
        b=P64mH8RZTz0WenumQzA81h5km2QD39tDxofkWaP8paYbOYWTurZrqlHoBfaK0RST0Y
         NYdS4FMBQkQsLdEB9Ouhk5wHKOBS9eLQEtGgy9Y+obrO1tdAg4PN/mYN5qUanUe8sM4G
         1PEvXwDOLzRPMX6ULCOSOv7u4IJaoF32KGQqvbwdQc+TyK4dVir3HZVefL1rj1Y/RfDx
         DC3IpQBcvqKMNif8IhPRUD/kWiZ6zJOufYnWnfzmb5xX4kEsUOfG2qjZP8mde1Y14GAO
         PLmNPtS1E/g+WSn7G0YUCsxxHL47eIJCpD41yQyNO84Sdytqsacz460/TLyyV6EKPCAd
         ISHA==
X-Gm-Message-State: AOJu0YyBkLKovctNkP4SB1BjDM59uLH8ogSFCX68Q5Hki4vpMxSQviIq
	JWJ6ObVZc77fXM27yHB3t7K5OETPMS5yrXA/CFElk+Mj3kOyovDY8adBy4LPSyzSPZy/qTYz1Mw
	EMoSo2j9ct/RJvLQb3J9QOUsWZzg=
X-Google-Smtp-Source: AGHT+IFgWuqmaxmJ4ky6tZtVz47D58gwaNreVUK24qLUYX0macnhdyaM8xTTAggyF6ktKJC+vVPSLutllgMLXgjsgqY=
X-Received: by 2002:a17:90a:8a0e:b0:29a:a08d:4809 with SMTP id
 w14-20020a17090a8a0e00b0029aa08d4809mr13820849pjn.2.1709750028823; Wed, 06
 Mar 2024 10:33:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306031929.42666-1-alexei.starovoitov@gmail.com> <20240306031929.42666-2-alexei.starovoitov@gmail.com>
In-Reply-To: <20240306031929.42666-2-alexei.starovoitov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Mar 2024 10:33:36 -0800
Message-ID: <CAEf4BzZB_JkiO2-w-PqFGxmZpAK0C71+Jb40CkiEPKoLM=oNXQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 1/4] bpf: Introduce may_goto instruction
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com, 
	john.fastabend@gmail.com, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 7:19=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Introduce may_goto instruction that from the verifier pov is similar to
> open coded iterators bpf_for()/bpf_repeat() and bpf_loop() helper, but it
> doesn't iterate any objects.
> In assembly 'may_goto' is a nop most of the time until bpf runtime has to
> terminate the program for whatever reason. In the current implementation
> may_goto has a hidden counter, but other mechanisms can be used.
> For programs written in C the later patch introduces 'cond_break' macro
> that combines 'may_goto' with 'break' statement and has similar semantics=
:
> cond_break is a nop until bpf runtime has to break out of this loop.
> It can be used in any normal "for" or "while" loop, like
>
>   for (i =3D zero; i < cnt; cond_break, i++) {
>
> The verifier recognizes that may_goto is used in the program, reserves
> additional 8 bytes of stack, initializes them in subprog prologue, and
> replaces may_goto instruction with:
> aux_reg =3D *(u64 *)(fp - 40)
> if aux_reg =3D=3D 0 goto pc+off
> aux_reg -=3D 1
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
> may_goto works well with arena pointers that don't need to be bounds
> checked on access. Load/store from arena returns imprecise unbounded
> scalar and loops with may_goto pass the verifier.
>
> Reserve new opcode BPF_JMP | BPF_JCOND for may_goto insn.
> JCOND stands for conditional pseudo jump.
> Since goto_or_nop insn was proposed, it may use the same opcode.
> may_goto vs goto_or_nop can be distinguished by src_reg:
> code =3D BPF_JMP | BPF_JCOND
> src_reg =3D 0 - may_goto
> src_reg =3D 1 - goto_or_nop
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/bpf_verifier.h   |   2 +
>  include/uapi/linux/bpf.h       |   5 +
>  kernel/bpf/core.c              |   1 +
>  kernel/bpf/disasm.c            |   4 +
>  kernel/bpf/verifier.c          | 163 +++++++++++++++++++++++++++------
>  tools/include/uapi/linux/bpf.h |   5 +
>  6 files changed, 150 insertions(+), 30 deletions(-)
>

[...]

> @@ -14871,11 +14882,36 @@ static int check_cond_jmp_op(struct bpf_verifie=
r_env *env,
>         int err;
>
>         /* Only conditional jumps are expected to reach here. */
> -       if (opcode =3D=3D BPF_JA || opcode > BPF_JSLE) {
> +       if (opcode =3D=3D BPF_JA || opcode > BPF_JCOND) {
>                 verbose(env, "invalid BPF_JMP/JMP32 opcode %x\n", opcode)=
;
>                 return -EINVAL;
>         }
>
> +       if (opcode =3D=3D BPF_JCOND) {
> +               struct bpf_verifier_state *cur_st =3D env->cur_state, *qu=
eued_st, *prev_st;
> +               int idx =3D *insn_idx;
> +
> +               if (insn->code !=3D (BPF_JMP | BPF_JCOND) ||
> +                   insn->src_reg !=3D BPF_MAY_GOTO ||
> +                   insn->dst_reg || insn->imm || insn->off =3D=3D 0) {

Why rejecting insn->off =3D=3D 0? It's still a legal instruction, even if
not super useful in practice. insn->off =3D=3D -1 is also weird, but legal
(and not rejected in this case).

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
> +               queued_st->may_goto_depth++;
> +               if (prev_st)
> +                       widen_imprecise_scalars(env, prev_st, queued_st);
> +               *insn_idx +=3D insn->off;
> +               return 0;
> +       }
> +
>         /* check src2 operand */
>         err =3D check_reg_arg(env, insn->dst_reg, SRC_OP);
>         if (err)

[...]
