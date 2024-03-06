Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A9B1361B5
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709743259; cv=none; b=tEHtSCUaAV2LPe+x0IVJxJaCWtPlQROsf69B1Yxc5hsX1b5EIooKb0SFo0VqY7ufyQAfe+VvTNg+m3z7sOB0AR/hhkQos/20Iqlincm8wh2u5JgLKnh33bgVLFiNQ8Uxn+f/B10LEs+D0s+ZYTKwkIKnjXCDgvS8lfmTHfURdkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709743259; c=relaxed/simple;
	bh=tM494ZdgJDj6YIVRsue4sDspD3Y7gj9lcsEQguW+TPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OC/PAAG3RUsBtECiw4dMBjBChPz2Ii1WbOZVpMJvAl7fxKV020Cxeiza+PMGQ6JfsuAOF6lMdE+1A2KSP8szbBJ0x15e31klvbwd4LmPSPbKftjmbj/6g0XLNeXDBA5YT8bkHJugplfddZtP2WErvn21T8y019uJjZUhnaRSr4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=burARz7G; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="burARz7G"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-412f1fc5613so9865675e9.2
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 08:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709743256; x=1710348056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dY4079jQNLLmct4d+tvGeBX6ygXSCJgWGRux8GtnU3g=;
        b=burARz7GN18vVlaOPkhvsxGqeLPheHU1/eerIZabkSJdOcxGu8OwGRitzp7hL9MN04
         SkRZ0SUpsoF/RSNTyzctwC1FEzHQXBw+PDpasLVq6/UwhxLF/C6sohgpKVOMB4o7aV0q
         gyLzS84xv8CsqtU12m6//qsPosYk9guPS3c0ydKVeti6XeVc1LOMcMBtWu+Bq4Sas/gu
         cDwJpiJ9T4gvvy+ah47ntwBzmmiZpRQeqo0tQULlqmufjiD9HA4DLvhAi2LFATY8Db60
         6I7bDa3cZ7d/gAya32rk5LutqRcnMw4kQWvmfgxRTtn6G1I6UPBj6M41trVzh5/JDHF4
         bp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709743256; x=1710348056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dY4079jQNLLmct4d+tvGeBX6ygXSCJgWGRux8GtnU3g=;
        b=uuQbm0o4iVRrXx3irlrlemmoTgHzrepP6ZfW6chHHL2vjkeD0beImS7m0nkdhVOAf9
         edm8Z2YsH0AF9Nov5jaImhhX/0g2CLExBFElqjc25+P1E4gDDOZ3+qlBKjx7ecrTle5l
         HCaV91z+O3iVUw5kgQU1/VBLKo0i+vE7XIjDP6YFod3FkG/ZljyISBtLCRULB+7n8GGr
         v7Ob38E4GEOplotnzUTdiUQkqeYEtvBeZ7xsA2vCoCABxOkcw/lu/JjjxDtxIsg1lCxD
         +hwOopGnKGFxj29qNo4iiNw/UvM2bBCXA0fxv2EUe+t3MP3F4ctlOiG+1RWhj2E951j9
         C6NQ==
X-Gm-Message-State: AOJu0YyuwN9AhF+J5pppVaJIy8Cm9wyI4CrpnDUa6DQrO8cFf72fQh3z
	Ev/Q05jGNPVV6b9lXRhaqvUhd32rOTkw48GViqtd3mu/wHN1LFMaxgAmLBdhtwmJZVQDL5v9wek
	fgAXXSIv5IXiJmtbmifFAbCYjDb0=
X-Google-Smtp-Source: AGHT+IHUgJeBeCv9HUa+OQhVupslqv38UrN1cLCpTmKSSHwsFOZmu2qinutISUO0aa2Ub8RxozvlNruAQMPRzX+p3dU=
X-Received: by 2002:adf:e412:0:b0:33e:164d:abcf with SMTP id
 g18-20020adfe412000000b0033e164dabcfmr11991119wrm.38.1709743255287; Wed, 06
 Mar 2024 08:40:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306031929.42666-1-alexei.starovoitov@gmail.com>
 <20240306031929.42666-2-alexei.starovoitov@gmail.com> <d7b7dd3eab10ff5b57799e16b95ef1a45c90285a.camel@gmail.com>
In-Reply-To: <d7b7dd3eab10ff5b57799e16b95ef1a45c90285a.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 6 Mar 2024 08:40:43 -0800
Message-ID: <CAADnVQJB8EDUyeX+0hqCYg9uM5gVV0zjsc5Z5wRsLpR5jjzgVQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 1/4] bpf: Introduce may_goto instruction
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, John Fastabend <john.fastabend@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 5:12=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2024-03-05 at 19:19 -0800, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
>
> [...]
>
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
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > @@ -14871,11 +14882,36 @@ static int check_cond_jmp_op(struct bpf_verif=
ier_env *env,
> >       int err;
> >
> >       /* Only conditional jumps are expected to reach here. */
> > -     if (opcode =3D=3D BPF_JA || opcode > BPF_JSLE) {
> > +     if (opcode =3D=3D BPF_JA || opcode > BPF_JCOND) {
> >               verbose(env, "invalid BPF_JMP/JMP32 opcode %x\n", opcode)=
;
> >               return -EINVAL;
> >       }
> >
> > +     if (opcode =3D=3D BPF_JCOND) {
> > +             struct bpf_verifier_state *cur_st =3D env->cur_state, *qu=
eued_st, *prev_st;
> > +             int idx =3D *insn_idx;
> > +
> > +             if (insn->code !=3D (BPF_JMP | BPF_JCOND) ||
> > +                 insn->src_reg !=3D BPF_MAY_GOTO ||
> > +                 insn->dst_reg || insn->imm || insn->off =3D=3D 0) {
> > +                     verbose(env, "invalid may_goto off %d imm %d\n",
> > +                             insn->off, insn->imm);
> > +                     return -EINVAL;
> > +             }
> > +             prev_st =3D find_prev_entry(env, cur_st->parent, idx);
> > +
> > +             /* branch out 'fallthrough' insn as a new state to explor=
e */
> > +             queued_st =3D push_stack(env, idx + 1, idx, false);
> > +             if (!queued_st)
> > +                     return -ENOMEM;
> > +
> > +             queued_st->may_goto_depth++;
> > +             if (prev_st)
> > +                     widen_imprecise_scalars(env, prev_st, queued_st);
> > +             *insn_idx +=3D insn->off;
> > +             return 0;
> > +     }
>
> Nit: for other conditional jumps the fallthrough branch is explored first=
,
>      I tried the following and the tests keep passing:
>
> @@ -14901,14 +14901,13 @@ static int check_cond_jmp_op(struct bpf_verifie=
r_env *env,
>                 prev_st =3D find_prev_entry(env, cur_st->parent, idx);
>
>                 /* branch out 'fallthrough' insn as a new state to explor=
e */
> -               queued_st =3D push_stack(env, idx + 1, idx, false);
> +               queued_st =3D push_stack(env, idx + insn->off + 1, idx, f=
alse);
>                 if (!queued_st)
>                         return -ENOMEM;
>
> -               queued_st->may_goto_depth++;
> +               cur_st->may_goto_depth++;
>                 if (prev_st)
> -                       widen_imprecise_scalars(env, prev_st, queued_st);
> -               *insn_idx +=3D insn->off;
> +                       widen_imprecise_scalars(env, prev_st, cur_st);
>                 return 0;
>         }
>
> Maybe this is a property worth preserving, wdyt?

My gut feel that may_goto should do what bpf_loop and open coded iters
are doing by exploring the "zero loops" path first.
But I will explore your idea to explore looping states first
in the follow up. It feels like a major change.
If it works for may_goto it should work for bpf_loop too.
Normal conditional jumps are different.
The way compilers layout basic blocks it's beneficial to explore
fall through, since it has a higher chance of state pruning earlier.
For may_goto the "explore zero loop first" feels more critical
for safety.

Thanks for the reviews.
