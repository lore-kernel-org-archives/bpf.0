Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F46029C327
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785951097; cv=pass; b=TwyCpnMe6bO53tkmAJgroljCzuIemOSxQK2xVhH03cqfHvljcpgXW34HI685sMkJFT3RNDEJhB2zHUPSUeq897pzddGjc/blBg31l2og88tOh9XrrxbACy2uSJtkbKZ1ZQT9yEmSyReD8MOgEusY1Z+fbVuxDwDeOxAcKsZCDU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785951097; c=relaxed/simple;
	bh=hASDUeXfd37o5IYwO2VSh7sdwfPgX+j5z2MqdFplfC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1gWAsO61reSHSx+DdCJkPiEqCGsZHXhP4ZXMYO+bIl/KyP+hD/EBkuSz8ZsHXqf3rCBSGnH6cDG76JLIm7751BT/ndna7csRXfeh3s52lADd+B//vGW4EcUDzQV0A8fqDXnxew0uLUfoY3KhenHFBwXc8ADvIEueLlaa9oV04k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NraFQJ+p; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NraFQJ+p"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-821106b5b64so2087527b3.1
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 10:31:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785951094; cv=none;
        d=google.com; s=arc-20260327;
        b=GbvERicCWiHhhOz4mnDcZhbchOCAYTvszM9MfGyVWF5EcmKkhqaCxKvY7T+pb8PT1I
         60vAMZGZJyT58GiknzazhHyCsOdalggXH5OQVt2O77gASCpqUWGkeddPKl4OuVpSigxl
         dA4eDYwne8XoFQUf4G40PG35fzns4hH679qQOBgut3pO+U8wZUoqrxmec07Topu30AyB
         GRuN4vRhzjl4cTDxaHChfifm4sDoxX9e8KldKWU0BG5yNRsrJHixmWtwfrK2bzOpmHJP
         p2Ew8wmIRhM0MBe4GF/vIY+kTHCLLxb7bErNU35lh2qy9uMSmsbWdBvFxBpLdUEmTkV6
         V+5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NxiTgiaiGmF/sO2Yh4QLohePAz+vDLNlNaYAnrFoCoM=;
        fh=L2zBHJm9161IppTT6EVFhYBjEMJ19hCE8A6fEvXxY9o=;
        b=ZqEDQ+JMCyMBl8xQ66ECyJBosAodkm8ry8dwDPsi3K8q2xg3Y24DN8MYV3P2Usnz0a
         kTf5Ytd70mhALiQbc4sdivaZEXNWSV8PVDNYeQIIMnfRs2DAgttimIXzGnK8Rzo9SfDa
         Qvnzyc6eZtmjHIZWzlhI+azEFtjxiDBP2xxsUL9g9y8jp/RfuTovlOE+U88OTIabZBjp
         qR/8ZqtO7Cl4l7DS8s2sIhtEnlGaPJxLmw7nD+K6/59RipRoajMun+BDK7ob88Nr79XQ
         kS3UXK3zF6h2XQJZZLP1yqMtuR817luD3ChKjCCL1raUlNlyHf3x5EUkcHoLhNQRNIMV
         yBcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785951094; x=1786555894; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NxiTgiaiGmF/sO2Yh4QLohePAz+vDLNlNaYAnrFoCoM=;
        b=NraFQJ+p4hmsehbpxQUOyoW3GGGA09bOgZ724nxSfndQLAvIFMj3txfRncCRQvI1fr
         bRX0NhrEgwYZF7dOEsAtCr+w9bD7mOSYdaosyHjnb/2PQm/sxxfjNrwNpwa43HBnjGZp
         CbzDw71eaLKNgnYn+0lBQgJWbdXk2oOxnI+hVx4yj9dtWDwNf5hoH3nDAXZTR2cA+YfA
         n/TvwJO3ZbFqNQFYcBHtKW2orlfGN8ceNh+qQg3SjUCO7QJNzvltFJZDchkfpJ3w3apm
         L9dR5iXt4dO6wqV87XLD2ydXX/3F8f7yvdEjWTOSe9VT17wQfKY5PClgYP5zrA1cmHCG
         itYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785951094; x=1786555894;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NxiTgiaiGmF/sO2Yh4QLohePAz+vDLNlNaYAnrFoCoM=;
        b=SNgtAbmDLTYFsCOOBT/hD2MI1TnsSOVub+wuY1rwQ4ye3QMBjLu6Ou+/8xr5NwNVDC
         l4vecnqe/yhXHC3KG01bwxDPqqa8oLQLrfnEQkUslx5plXHBxuE2b9pTPd/vby253DoY
         rSqDciQcsuzL6/VwsEME6Hwuq/EF1mAlw0BpRBlBybCx5BunUcHGveQAIw4VlqmyBFsA
         EnecMJLJoMGe1+X9k6lubGZSAyV4wjz+I4to/un+DX5JkM/j8nWw4naXdCrJXWsQiwHX
         r4k04X/REVZgbBpAxXJYj1h7TQJdzlFzp0QrKq1yvkBMqGFDpUy09wq1ftrn4yN/rMOy
         I+3g==
X-Forwarded-Encrypted: i=1; AHgh+RqMKDooBu5Ac4kSW3DoZWjF/Z7O6Rvwcdq+dlNgf9pkMMWr90hD7CUzqP3xM7PDxPwIdmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKtDNkDz5YgeXK8BgoogugEjC//+fpk3ULno2mvMp3FqWeVVrC
	0x4q8z/XRNFpl1oHAL0qBDOGgyNS0GNzNDha89+/bl+o+XA2VAlGKcEDTxkP0emRyRAyte0rXfC
	TbQdXcmW+h45htZfpX3FIVU1dr6/G7+s=
X-Gm-Gg: AR+sD10K+1e5zc7vk34XWMCoGE+WSrSFt+ydwE/IQvKxwdMq8yMhi7bOoEt/rWr0uh5
	zwGhRymwEVo5VAz8SqVy5c6n16d+NMj2nROWz4t8PxYRdlOkXYsl7K90kZayzDzpVwfGXIvEB3C
	Erw7AqlT8J9r67dJhQ+aTlacl/GLrfuoRbOaiXVJyEhAdnlNZuX/MFVHDIa7XFpibS+JaZ/PGxt
	URCoebFWmSltBD4/71pyU886EJ/rNQXyf0qg0miEvdjmYG3WOhM6XLlhOQfINZXNrIBT4oSGHwR
	HM22zFvDSp3KPFgevdUC/Iwg3k6C0uhVWhcLgvuAa31u
X-Received: by 2002:a05:690c:4f89:b0:81f:ea3f:2937 with SMTP id
 00721157ae682-82111a422ebmr2456087b3.11.1785951094375; Wed, 05 Aug 2026
 10:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803125115.2264733-1-memxor@gmail.com> <20260803125115.2264733-3-memxor@gmail.com>
 <018d033499f61651ec8761fe0f7ac9662ef3c096.camel@gmail.com> <0a7bc56a3753c9122ab421aa14d2daae08b08e30.camel@gmail.com>
In-Reply-To: <0a7bc56a3753c9122ab421aa14d2daae08b08e30.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 5 Aug 2026 10:31:23 -0700
X-Gm-Features: AUfX_mwIbL2hp0Jj28V6xZIzjDMtLm2fcrDBpWzI4Fli6Dcy1wg3aUvRVMLEkYw
Message-ID: <CAMB2axP4Wjmm45r4ku=D3ZRRy1JiEBfkLr5R7NJRD0Ca3w8UpQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/9] bpf: Support __arena and __arena_nullable
 on struct_ops arguments
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 10:14=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2026-08-04 at 16:55 -0700, Eduard Zingerman wrote:
> > On Mon, 2026-08-03 at 14:51 +0200, Kumar Kartikeya Dwivedi wrote:
> >
> > Lgtm except for several nits below.
> >
> > ...
> >
> > > diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.=
c
> >
> > ...
> >
> > > @@ -226,26 +229,30 @@ static int prepare_arg_info(struct btf *btf,
> > >     info =3D info_buf;
> > >     for (arg_no =3D 0; arg_no < nargs; arg_no++) {
> > >             /* Skip arguments that is not suffixed with
> > > -            * "__nullable or __ref".
> > > +            * "__nullable", "__ref", "__arena" or "__arena_nullable"=
.
> > >              */
> > >             is_nullable =3D btf_param_match_suffix(btf, &stub_args[ar=
g_no],
> > >                                                  MAYBE_NULL_SUFFIX);
> > >             is_refcounted =3D btf_param_match_suffix(btf, &stub_args[=
arg_no],
> > >                                                    REFCOUNTED_SUFFIX)=
;
> > > +           is_arena_nullable =3D btf_param_match_suffix(btf, &stub_a=
rgs[arg_no],
> > > +                                                      ARENA_MAYBE_NU=
LL_SUFFIX);
> > > +           is_arena =3D btf_param_match_suffix(btf, &stub_args[arg_n=
o], ARENA_SUFFIX);
> > >
> > >             if (is_nullable)
> > >                     suffix =3D MAYBE_NULL_SUFFIX;
> > >             else if (is_refcounted)
> > >                     suffix =3D REFCOUNTED_SUFFIX;
> > > +           else if (is_arena_nullable)
> > > +                   suffix =3D ARENA_MAYBE_NULL_SUFFIX;
> > > +           else if (is_arena)
> > > +                   suffix =3D ARENA_SUFFIX;
> >
> > As discussed already, that's unfortunate that p__arena and p__nullable
> > are valid, but p__arena__nullable is not, substituted by
> > p__arena_nullable. Same goes for global subprogs.
> >
> > >             else
> > >                     continue;
> > >
> > > -           /* Should be a pointer to struct */
> > > -           pointed_type =3D btf_type_resolve_ptr(btf,
> > > -                                               args[arg_no].type,
> > > -                                               &arg_btf_id);
> > > -           if (!pointed_type ||
> > > -               !btf_type_is_struct(pointed_type)) {
> > > +           /* Should be a pointer to struct, or any pointer for __ar=
ena/__arena_nullable */
> > > +           pointed_type =3D btf_type_resolve_ptr(btf, args[arg_no].t=
ype, &arg_btf_id);
> > > +           if (!pointed_type || (!is_arena && !is_arena_nullable && =
!btf_type_is_struct(pointed_type))) {
> > >                     pr_warn("stub function %s has %s tagging to an un=
supported type\n",
> > >                             stub_fname, suffix);
> > >                     goto err_out;
> >
> > ...
> >
> > > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > > index ed7999ad6c66..d2d7a2904345 100644
> > > --- a/kernel/bpf/trampoline.c
> > > +++ b/kernel/bpf/trampoline.c
> >
> > ...
> >
> > > @@ -695,6 +743,22 @@ static int bpf_trampoline_update(struct bpf_tram=
poline *tr, bool lock_direct_mut
> > >             goto out;
> > >     }
> > >
> > > +   /*
> > > +    * Arena ctx args are converted only by the struct_ops indirect
> > > +    * trampoline, which dispatches to a single known prog. Generic
> > > +    * trampolines can mix progs with different arenas, so no convers=
ion
> > > +    * is possible here. Not reachable today: only struct_ops progs g=
et
> > > +    * arena ctx args and they never ride generic trampolines.
> > > +    */
> > > +   for (kind =3D 0; kind < BPF_TRAMP_MAX; kind++) {
> > > +           for (i =3D 0; i < tnodes[kind].nr_nodes; i++) {
> > > +                   if (bpf_prog_has_arena_ctx_arg(tnodes[kind].nodes=
[i]->link->prog)) {
> > > +                           err =3D -ENOTSUPP;
> > > +                           goto out;
> > > +                   }
> > > +           }
> > > +   }
> >
> > Nit: should this be done in __bpf_trampoline_link_prog() or
> >      bpf_trampoline_add_prog()? To avoid doing the same check on unlink=
.
> >      Since this is an invariant violation, do we want to add WARN_ONCE?
> >
> > > +
> > >     /* clear all bits except SHARE_IPMODIFY and TAIL_CALL_CTX */
> > >     tr->flags &=3D (BPF_TRAMP_F_SHARE_IPMODIFY | BPF_TRAMP_F_TAIL_CAL=
L_CTX);
> > >
> >
> > ...
>
> Thinking a bit more about this. Since kfuncs already use flags in
> btf_func_model, I think it would be nice to use them for struct_ops as
> well. E.g. as in the patch attached (applied on top of this series).
> Wdyt?

I like that it relies on existing annotations instead of yet another
auxiliary field.

The mapping for arena args to different function models can be confusing th=
ough.

For the verfication purpose: both __arena and __arena_nullable maps to
KF_ARG_PTR_TO_ARENA | PTR_MAYBE_NULL.
For the JIT purpose: __arena maps to BTF_FMODEL_ARENA_ARG;
__arena_nullable maps to BTF_FMODEL_ARENA_ARG |
BTF_FMODEL_NULLABLE_ARG.

It might deserve a brief inline comment in get_kfunc_arg_type() saying
why both tags map to KF_ARG_PTR_TO_ARENA | PTR_MAYBE_NULL.
