Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E3BA20
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571586; cv=none; b=YB+O3BpXP052aPGtgVjErz9y9tzYB2sjOucaaQj27qf8+PXQl3BVp24Ci6xd4OrcXDjLo3ffE9DQst3i9vUUSuXxST1BDkHIFQO7mSPFS5BhW8QPyKYT1PfYVOHAuTGBN4igEMRZOuDtyveKGCvBwaJuj1QgHg9zojSXfVZbqDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571586; c=relaxed/simple;
	bh=kLgf2M6nCFfvshzmhjI7IER92XhqOB7eY/bMxJgQj2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPr3vTWAoOWf4ppk3F7KnD7zf8XnrLhbdJrSFMPMnXxYo2tuPGjHIeIOtviayiV/3xvCHNQajWBbpci9XjsBrP8jNPiZ+/QA1lOoerPYZ98/rKpNRq6VibqVq9zmA0PHR2bYfILhzZTHB+WEY5L5YRI6zVCguLO1Hyd9R1yX0u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOID8jv6; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOID8jv6"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33e17fc5aceso2211376f8f.0
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 08:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709571583; x=1710176383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6J6CCP1VE5xbUKcamGbJTBhZtHY0km0aywURxVwfMEQ=;
        b=nOID8jv6365OXnF7dE8im7D7FuW1JA1WGaZOF5RkSg2o9rAae+lvgFKEoGNFRsLclx
         p/bAca5QVYwIoFFJtQaF05+2s3C1KkVFSbM8kyZgA3ppyhwniZ5/V4W++samGy0gzpJf
         0MVJH1cIUtelP7NW0lD2GfTz51GGfkZ24IZjNpK7oTzj2UK89prEqZsqapA2lSWki0Ft
         lPzyfFJp+6fv/v6805VxCD+DIkzZKTQ1/bvdEX1fB4bHpUzJAhBjLTtn/riAEw7jkAAD
         yTN0UVPIrUUWSJhuZN+umRLA78qNdhKgHITn6ZF3QYlQJXhew+/lrvY7BTn/b8q81L+n
         PMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709571583; x=1710176383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6J6CCP1VE5xbUKcamGbJTBhZtHY0km0aywURxVwfMEQ=;
        b=FxC5SBH67kucAovgNAL7OZQrmZcdapPR6BGla4ABXhScBv16+M6q6YAFucPbWZGBcT
         OPsXgtjriGrT53jSIlLSclEk7JuYRWVVvDbntY2TfLtv/8/ol4MiLLtmrzLYgjH+mB44
         rQVSFmw2toFI2wo5HJ4zicfilxUWDkwdJ8Lf6YagD8883IwQGOiawVi7w3eNgB/qUvvo
         Ml0MkcNhRNSdlyXSV9AlOubxZfXmJcXSls8wgQr0fA8abUaepgdJREuKbq3wNeRH2lHr
         BhXwVDglRY1jJtFvXuAAvegThueeBxXpZJvx35SuflRO9JaqrjfdVI/wOaDZah9S0lb8
         JjhQ==
X-Gm-Message-State: AOJu0YwB+wstEyEvF+tGIn3MEGPnASc+bPlqJYXmbHAaFkxkHwsKkCiZ
	lggTa3GQGyHOQvC1jjVBMP36wzTJyfbHmHF/PTRhDJ/ToHPh9QKDmDcgRieoKfu3Q4X+vb5gMFM
	kZLZZokmm9yxNH5OitsbPoRasymABmJm5BaM=
X-Google-Smtp-Source: AGHT+IFyIkyZkoBv+eaKMULCh82L4RxMYV+/FTdlBS8lss1bCUhBJNTmOi7AJhHUHjTEno5PfPCpU1YbvctVT6u02Uc=
X-Received: by 2002:adf:9599:0:b0:33d:c5c7:45ed with SMTP id
 p25-20020adf9599000000b0033dc5c745edmr71232wrp.3.1709571582631; Mon, 04 Mar
 2024 08:59:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302020010.95393-1-alexei.starovoitov@gmail.com>
 <20240302020010.95393-2-alexei.starovoitov@gmail.com> <6f76f6661061b091be3798c8e8b8c2f04d529e43.camel@gmail.com>
In-Reply-To: <6f76f6661061b091be3798c8e8b8c2f04d529e43.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 Mar 2024 08:59:31 -0800
Message-ID: <CAADnVQ+jeW66Y_X3KKWgvZJykX2Yy_mz26EZzWDy52DbsgmchA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/4] bpf: Introduce may_goto instruction
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, John Fastabend <john.fastabend@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 3:55=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Fri, 2024-03-01 at 18:00 -0800, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Introduce may_goto instruction that acts on a hidden bpf_iter_num, so t=
hat
> > bpf_iter_num_new(), bpf_iter_num_destroy() don't need to be called expl=
icitly.
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
> > *(u64 *)(fp - 40) =3D aux_reg
>
> [...]
>
> Modulo instruction validation issue you pointed out offlist I don't
> see any obvious issues with this patch. Two notes below.
>
> [...]
>
> > @@ -19406,7 +19466,10 @@ static int do_misc_fixups(struct bpf_verifier_=
env *env)
> >       struct bpf_insn insn_buf[16];
> >       struct bpf_prog *new_prog;
> >       struct bpf_map *map_ptr;
> > -     int i, ret, cnt, delta =3D 0;
> > +     int i, ret, cnt, delta =3D 0, cur_subprog =3D 0;
> > +     struct bpf_subprog_info *subprogs =3D env->subprog_info;
> > +     u16 stack_depth =3D subprogs[cur_subprog].stack_depth;
> > +     u16 stack_depth_extra =3D 0;
>
> Note: optimize_bpf_loop() has very similar logic,
>       but there stack_depth is rounded up:
>
>         u16 stack_depth =3D subprogs[cur_subprog].stack_depth;
>         u16 stack_depth_roundup =3D round_up(stack_depth, 8) - stack_dept=
h;
>         u16 stack_depth_extra =3D 0;
>         ...
>         stack_depth_extra =3D BPF_REG_SIZE * 3 + stack_depth_roundup;
>
> And stack base for tmp variables is computed as "-(stack_depth + stack_de=
pth_extra)".

I did a sloppy review when I landed your
commit 1ade23711971 ("bpf: Inline calls to bpf_loop when callback is known"=
)
round_up is unnecessary.
The stack is always incremented in power of 8.
See grow_stack_state().

> >
> >       if (env->seen_exception && !env->exception_callback_subprog) {
> >               struct bpf_insn patch[] =3D {
> > @@ -19426,7 +19489,7 @@ static int do_misc_fixups(struct bpf_verifier_e=
nv *env)
> >               mark_subprog_exc_cb(env, env->exception_callback_subprog)=
;
> >       }
> >
> > -     for (i =3D 0; i < insn_cnt; i++, insn++) {
> > +     for (i =3D 0; i < insn_cnt;) {
> >               /* Make divide-by-zero exceptions impossible. */
> >               if (insn->code =3D=3D (BPF_ALU64 | BPF_MOD | BPF_X) ||
> >                   insn->code =3D=3D (BPF_ALU64 | BPF_DIV | BPF_X) ||
>
> [...]
>
> > @@ -19950,6 +20033,39 @@ static int do_misc_fixups(struct bpf_verifier_=
env *env)
> >                       return -EFAULT;
> >               }
> >               insn->imm =3D fn->func - __bpf_call_base;
> > +next_insn:
> > +             if (subprogs[cur_subprog + 1].start =3D=3D i + delta + 1)=
 {
> > +                     subprogs[cur_subprog].stack_depth +=3D stack_dept=
h_extra;
> > +                     subprogs[cur_subprog].stack_extra =3D stack_depth=
_extra;
> > +                     cur_subprog++;
> > +                     stack_depth =3D subprogs[cur_subprog].stack_depth=
;
> > +                     stack_depth_extra =3D 0;
> > +             }
> > +             i++; insn++;
> > +     }
> > +
> > +     env->prog->aux->stack_depth =3D subprogs[0].stack_depth;
> > +     for (i =3D 0; i < env->subprog_cnt; i++) {
> > +             int subprog_start =3D subprogs[i].start, j;
> > +             int stack_slots =3D subprogs[i].stack_extra / 8;
> > +
> > +             if (stack_slots >=3D ARRAY_SIZE(insn_buf)) {
> > +                     verbose(env, "verifier bug: stack_extra is too la=
rge\n");
> > +                     return -EFAULT;
> > +             }
> > +
> > +             /* Add insns to subprog prologue to zero init extra stack=
 */
> > +             for (j =3D 0; j < stack_slots; j++)
> > +                     insn_buf[j] =3D BPF_ST_MEM(BPF_DW, BPF_REG_FP,
> > +                                              -subprogs[i].stack_depth=
 + j * 8, BPF_MAX_LOOPS);
>
> Nit: the comment says that stack is zero initialized,
>      while it is actually set to BPF_MAX_LOOPS.

Good catch. Will fix.
