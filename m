Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5D8604A7
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 18:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709750312; cv=none; b=q/+L4ViRtQF7VPYT0yuVA9gZSRiI/kA5k8CibsEMRolJgD+9z3xkR5+PZutUVK5KeK9j76W6pKdo9LnVVrSQzLHUYCZI9EMFenLqxsWW4zo7FAfxbcHeD75pT3FgvyEzTOfzVZh4rQuc6ZtOl7bMbj+qWsUxYCX1xP3mM9H9/70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709750312; c=relaxed/simple;
	bh=SayPmmC4FDmN2UblnltiSAzt8HZAc5s0aP9mPMeEuug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pp+3G9IhWBAIqdbFbg5Q+S6a5gIBR/rDpghZnb5XyHxpDpPmcAtaukqimbrdsLn9Vy7T19ivbARIqt4nkkzxP9xbWO3NuFqEuA7FbCaUMjXp0NnpXDERzacoefg8jsmlt/Pcgay8k4IdfyfmoECebMYP3vJ2mDaquXp0j/GmwBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtvEgVCP; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtvEgVCP"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33d0a7f2424so1394608f8f.0
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 10:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709750309; x=1710355109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czZWIeBU0UlNdtYRTW+d6ZEGa5ttTpTpMNqTBl+BRe0=;
        b=BtvEgVCPGzifxmDfl853lEt0MMz+VgGDCPL7Rj7VQkgBAEhD9NyKAlU0LT77MJqxoA
         WY04r8hbqc8JKEP8Yw4rMAARmjmYzT6HreDKh66f7NFimqmvGh9AylVtyWjQM4sCLav4
         ccB0vzID/18KgJN3HMszyYdqHMkhYL2jTd72t6vGCGWlu7WgFJ72hAKd532zju/KNRHE
         KdQTRtGwN7xlva+0v2akZNgOEPxcECL81X9VLHM70g1YCWcJFI4mWlE8Dq5FI8NUN+LG
         hwuadseu+JIqE6qZq+sKDRDTi6peMyXXfAHJMtZkCjox8fhTFxIooieEg4wnb8t+ZLFd
         ssnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709750309; x=1710355109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czZWIeBU0UlNdtYRTW+d6ZEGa5ttTpTpMNqTBl+BRe0=;
        b=SkApCgbmtKsihniIbs/jKjUzJiIKmaNOij3V0cNNLdQbIZGOkT7Oor3jTK+j5fKAgu
         JhCchj5r1cR2MOjXjtXMdL15Rb1s2HTqCC4doZo4yqYoaELdEFqcY9HVtq8AGAa8j4MB
         a34ehcsGwdtATEj92mz2HU2GATJjkKjjF1+YEpOJpkr+2t6DNxXIMm2ZxhmdwnnqJdHn
         K94hoyEFqj136coRX3YqIG8Z30fLE6MM6i2PVDhlVgMavnKe3wTwWnkXsxmkyYiie+W2
         1vivg0eqA7UK+wKDhpwSUK9iwfgYA0NpqFgtCfdRfdz5SxY5ahLTpTisEJiZDewY+UYn
         df1A==
X-Gm-Message-State: AOJu0YwcKuHUSIIZA5OsW3PLEjbB6msju5W8T+AAHGUk4VzplXs9uQ3S
	AnBoMYtBiKlYLWjoOKnfxov28WNbFIctAINWjthNSTLZNW5m2EP3vKeC3KoUOA84PdzdjO9sgK9
	dyR3zcYchXOo6fyPV/jEApjus+vc=
X-Google-Smtp-Source: AGHT+IHiSgNWEps6HW0kzn3Em4GKxKb+OOBzkqnlU6CDfhv20BGELhPNp/aRdfZ56qz/VAWgQJ1Ufo+UwUKdisIRf4Y=
X-Received: by 2002:a5d:4047:0:b0:33d:61fe:6ca3 with SMTP id
 w7-20020a5d4047000000b0033d61fe6ca3mr10779380wrp.26.1709750308547; Wed, 06
 Mar 2024 10:38:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306031929.42666-1-alexei.starovoitov@gmail.com>
 <20240306031929.42666-2-alexei.starovoitov@gmail.com> <CAEf4BzZB_JkiO2-w-PqFGxmZpAK0C71+Jb40CkiEPKoLM=oNXQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZB_JkiO2-w-PqFGxmZpAK0C71+Jb40CkiEPKoLM=oNXQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 6 Mar 2024 10:38:17 -0800
Message-ID: <CAADnVQJ0Z2oJyqNV_+ZsaoSyHS9QAetxVQ3O4b3FkC4+uj+rCg@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 1/4] bpf: Introduce may_goto instruction
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 10:33=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Mar 5, 2024 at 7:19=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Introduce may_goto instruction that from the verifier pov is similar to
> > open coded iterators bpf_for()/bpf_repeat() and bpf_loop() helper, but =
it
> > doesn't iterate any objects.
> > In assembly 'may_goto' is a nop most of the time until bpf runtime has =
to
> > terminate the program for whatever reason. In the current implementatio=
n
> > may_goto has a hidden counter, but other mechanisms can be used.
> > For programs written in C the later patch introduces 'cond_break' macro
> > that combines 'may_goto' with 'break' statement and has similar semanti=
cs:
> > cond_break is a nop until bpf runtime has to break out of this loop.
> > It can be used in any normal "for" or "while" loop, like
> >
> >   for (i =3D zero; i < cnt; cond_break, i++) {
> >
> > The verifier recognizes that may_goto is used in the program, reserves
> > additional 8 bytes of stack, initializes them in subprog prologue, and
> > replaces may_goto instruction with:
> > aux_reg =3D *(u64 *)(fp - 40)
> > if aux_reg =3D=3D 0 goto pc+off
> > aux_reg -=3D 1
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
> > may_goto works well with arena pointers that don't need to be bounds
> > checked on access. Load/store from arena returns imprecise unbounded
> > scalar and loops with may_goto pass the verifier.
> >
> > Reserve new opcode BPF_JMP | BPF_JCOND for may_goto insn.
> > JCOND stands for conditional pseudo jump.
> > Since goto_or_nop insn was proposed, it may use the same opcode.
> > may_goto vs goto_or_nop can be distinguished by src_reg:
> > code =3D BPF_JMP | BPF_JCOND
> > src_reg =3D 0 - may_goto
> > src_reg =3D 1 - goto_or_nop
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  include/linux/bpf_verifier.h   |   2 +
> >  include/uapi/linux/bpf.h       |   5 +
> >  kernel/bpf/core.c              |   1 +
> >  kernel/bpf/disasm.c            |   4 +
> >  kernel/bpf/verifier.c          | 163 +++++++++++++++++++++++++++------
> >  tools/include/uapi/linux/bpf.h |   5 +
> >  6 files changed, 150 insertions(+), 30 deletions(-)
> >
>
> [...]
>
> > @@ -14871,11 +14882,36 @@ static int check_cond_jmp_op(struct bpf_verif=
ier_env *env,
> >         int err;
> >
> >         /* Only conditional jumps are expected to reach here. */
> > -       if (opcode =3D=3D BPF_JA || opcode > BPF_JSLE) {
> > +       if (opcode =3D=3D BPF_JA || opcode > BPF_JCOND) {
> >                 verbose(env, "invalid BPF_JMP/JMP32 opcode %x\n", opcod=
e);
> >                 return -EINVAL;
> >         }
> >
> > +       if (opcode =3D=3D BPF_JCOND) {
> > +               struct bpf_verifier_state *cur_st =3D env->cur_state, *=
queued_st, *prev_st;
> > +               int idx =3D *insn_idx;
> > +
> > +               if (insn->code !=3D (BPF_JMP | BPF_JCOND) ||
> > +                   insn->src_reg !=3D BPF_MAY_GOTO ||
> > +                   insn->dst_reg || insn->imm || insn->off =3D=3D 0) {
>
> Why rejecting insn->off =3D=3D 0? It's still a legal instruction, even if
> not super useful in practice. insn->off =3D=3D -1 is also weird, but lega=
l
> (and not rejected in this case).

Legal, but nonsensical.
s390 hits it due to macro endian issue, so it's better to
reject early instead of wasting 1m verifier steps.
