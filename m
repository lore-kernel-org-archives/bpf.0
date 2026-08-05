Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63BB3CF212
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785951387; cv=none; b=Wj16u3Z71uri/A1u8g0mqx/nT5Zi22SjHQdwuyDEkDXu6UlnruiRPU0P5HI/KHQU9vzxfG17xwtIseuyjscwsyDXewBNb8NImf36lb+3xl1c7b3g0Xjt2KsrI2mlUMWns75DtDj+sL1Gcv3qpfb5Fs7xpUkY4zfbgGN72Y/BGzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785951387; c=relaxed/simple;
	bh=aY5qyNW9M8sNrebMR+A/BizQKEa6ouo2vxI23yPsPD0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=t7onV9igCawtNedgqbvei8wJPYMJfbkm8AxA8iIaIarPvuX2MwT+n3CO0beS0EH7ZPRa0aIPM7w9/+UFDQbTFYdgBqbGv4HdHQy+tis2mYIVuHP56VCwRTCVde72qWVg1Gym9xZnyCM5smXxXMb8XzBUqazChcN2bY4Q6qe9Nik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/Y+EdUb; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/Y+EdUb"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-4744516a312so194070f8f.1
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 10:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785951384; x=1786556184; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CoIjjQsARMKthvTabporXON3lPYUDV1wv3+gRt/J6FU=;
        b=W/Y+EdUb0K0yw70QeYmy4PLH865NjHLVxZgPgoiIq1n8TFse8Eveb7ZcvsZEJXPaFy
         +sHmw7L7FisjveWitETDgXS5k+jhdBlv+TiAQ4ZITOndr65RqN5KpcgVz/dcMNS7+k6W
         7Alyn7qLu5bIvcibsSB+UngBFMiHpR8bcOK9EN0IkOHcd/z+8Yhdk0TjSqvOFyrog5ue
         LPyZK4RbK2hDIbcgfyWCXzuRJ1PVtSl4xS8G+pqryq/h1EKDSY1SexNMsTr/dFOLY0DT
         STw7rk9X6hDfAoSmcPrFDeG8Jxskh+URpyZeOj0DRYWovRLMkiF2ckAzSDrM/rDibbit
         pxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785951384; x=1786556184;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CoIjjQsARMKthvTabporXON3lPYUDV1wv3+gRt/J6FU=;
        b=TtY611LTdy95FDLSVNlQD6jZKdks4XAnl2VzIGAycxL4diG460c9cSZZVp/VLqUGfh
         UyNmmzPsAqOoo2HkFQ4tAsx2t8mrGlzop8oO0hVZ2tHNbQ5lyuddO5kJsfDi0kwL+Usw
         EXb0nddLDoWWis8eHBzrOKwqXaRyoyQeHKrcdw7o9PLw/+4nFqueKtgYDkeqBDwa8KxT
         RJNEygN+L6nna76XOWN4e31qsjLEF4+7/i6O4+90u85tmUIvqNeUtueHC/8Vzevz8nYE
         U+0m6reCMZu/Ocyt/dzpfCv1d7SV++Skb42kxqggG2xN8aYaAccFmCU5KJec+775//HV
         R1/g==
X-Gm-Message-State: AOJu0YzPQn0pzhG9R6pCF3Z4fE3OwwE0CAjZ3m41GjIuOqS6/LhDstbg
	9TQYXxEN6b27ykMmyGZ9nODtJgaIpbOFLsXNQdkiVosKTsYpUDfIDmFHFweIwET8
X-Gm-Gg: AR+sD13F2p21LgHG139/JJpvZJBVEoQdqJ8czZI+wEavU+V/KMpdW/HAaBUuwcvsOb5
	PDK908Jf0tzS1/5dW+fUP9bGXvaQ3xmCUCGz6JD5J34T+5FtuBppz1VUlPcqkc+htS46f9gZHPY
	9coTO76as5wZAdUqUczWBKqxpyZkhoXv3TweiJEdCtZs6ouMexqyPi/uLFowt+pcolfqZ34vSKq
	7666JW5qTO5jrM6iPhjbutTWdGVkBq1ybYA+1hBQrHmAaaPodE5k7uAsqbzmCX6CWb5knuXrrTI
	0o0hLzYIoQ6BGLJwwW2esMomqVvgmh3K0wEKYFW+kBbg451SBIdR2QD/gmXAF4kSsRk/HLOrrJP
	xQVrpjWpsB9beJlhFPr2fxF81/6L/mf4ehZmKRVMBuEKv4d2qXJmdB0lfCSZ0ZDdLddMZmt5dPa
	Q/ZeOyVj1qjDmwNpj10a//1dIx1JYmPJfO61o5m9h+qKphu9VPirm2JaGZ2Q3f2sRqjZX4bnYf3
	wQnDCnBZQPCx9PAPoWd8GIdpn9OjVd+8i+b8XrCKLSyrqvJ2diestl/w2ViguapwVQO4tHIPn/W
	Hzf8pQpkccw1ArkvzUMcPR/UPgc=
X-Received: by 2002:a05:600c:1906:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-49952d052e7mr11254315e9.0.1785951383759;
        Wed, 05 Aug 2026 10:36:23 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994dfcc84dsm99597735e9.2.2026.08.05.10.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 10:36:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Aug 2026 19:36:22 +0200
Message-Id: <DKH6XESU7740.UUEKH0WNCM29@gmail.com>
Cc: <bpf@vger.kernel.org>, "Tejun Heo" <tj@kernel.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 2/9] bpf: Support __arena and
 __arena_nullable on struct_ops arguments
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Amery Hung" <ameryhung@gmail.com>, "Eduard Zingerman"
 <eddyz87@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260803125115.2264733-1-memxor@gmail.com>
 <20260803125115.2264733-3-memxor@gmail.com>
 <018d033499f61651ec8761fe0f7ac9662ef3c096.camel@gmail.com>
 <0a7bc56a3753c9122ab421aa14d2daae08b08e30.camel@gmail.com>
 <CAMB2axP4Wjmm45r4ku=D3ZRRy1JiEBfkLr5R7NJRD0Ca3w8UpQ@mail.gmail.com>
In-Reply-To: <CAMB2axP4Wjmm45r4ku=D3ZRRy1JiEBfkLr5R7NJRD0Ca3w8UpQ@mail.gmail.com>

On Wed Aug 5, 2026 at 7:31 PM CEST, Amery Hung wrote:
> On Tue, Aug 4, 2026 at 10:14=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
>>
>> On Tue, 2026-08-04 at 16:55 -0700, Eduard Zingerman wrote:
>> > On Mon, 2026-08-03 at 14:51 +0200, Kumar Kartikeya Dwivedi wrote:
>> >
>> > Lgtm except for several nits below.
>> >
>> > ...
>> >
>> > > diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops=
.c
>> >
>> > ...
>> >
>> > > @@ -226,26 +229,30 @@ static int prepare_arg_info(struct btf *btf,
>> > >     info =3D info_buf;
>> > >     for (arg_no =3D 0; arg_no < nargs; arg_no++) {
>> > >             /* Skip arguments that is not suffixed with
>> > > -            * "__nullable or __ref".
>> > > +            * "__nullable", "__ref", "__arena" or "__arena_nullable=
".
>> > >              */
>> > >             is_nullable =3D btf_param_match_suffix(btf, &stub_args[a=
rg_no],
>> > >                                                  MAYBE_NULL_SUFFIX);
>> > >             is_refcounted =3D btf_param_match_suffix(btf, &stub_args=
[arg_no],
>> > >                                                    REFCOUNTED_SUFFIX=
);
>> > > +           is_arena_nullable =3D btf_param_match_suffix(btf, &stub_=
args[arg_no],
>> > > +                                                      ARENA_MAYBE_N=
ULL_SUFFIX);
>> > > +           is_arena =3D btf_param_match_suffix(btf, &stub_args[arg_=
no], ARENA_SUFFIX);
>> > >
>> > >             if (is_nullable)
>> > >                     suffix =3D MAYBE_NULL_SUFFIX;
>> > >             else if (is_refcounted)
>> > >                     suffix =3D REFCOUNTED_SUFFIX;
>> > > +           else if (is_arena_nullable)
>> > > +                   suffix =3D ARENA_MAYBE_NULL_SUFFIX;
>> > > +           else if (is_arena)
>> > > +                   suffix =3D ARENA_SUFFIX;
>> >
>> > As discussed already, that's unfortunate that p__arena and p__nullable
>> > are valid, but p__arena__nullable is not, substituted by
>> > p__arena_nullable. Same goes for global subprogs.
>> >
>> > >             else
>> > >                     continue;
>> > >
>> > > -           /* Should be a pointer to struct */
>> > > -           pointed_type =3D btf_type_resolve_ptr(btf,
>> > > -                                               args[arg_no].type,
>> > > -                                               &arg_btf_id);
>> > > -           if (!pointed_type ||
>> > > -               !btf_type_is_struct(pointed_type)) {
>> > > +           /* Should be a pointer to struct, or any pointer for __a=
rena/__arena_nullable */
>> > > +           pointed_type =3D btf_type_resolve_ptr(btf, args[arg_no].=
type, &arg_btf_id);
>> > > +           if (!pointed_type || (!is_arena && !is_arena_nullable &&=
 !btf_type_is_struct(pointed_type))) {
>> > >                     pr_warn("stub function %s has %s tagging to an u=
nsupported type\n",
>> > >                             stub_fname, suffix);
>> > >                     goto err_out;
>> >
>> > ...
>> >
>> > > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
>> > > index ed7999ad6c66..d2d7a2904345 100644
>> > > --- a/kernel/bpf/trampoline.c
>> > > +++ b/kernel/bpf/trampoline.c
>> >
>> > ...
>> >
>> > > @@ -695,6 +743,22 @@ static int bpf_trampoline_update(struct bpf_tra=
mpoline *tr, bool lock_direct_mut
>> > >             goto out;
>> > >     }
>> > >
>> > > +   /*
>> > > +    * Arena ctx args are converted only by the struct_ops indirect
>> > > +    * trampoline, which dispatches to a single known prog. Generic
>> > > +    * trampolines can mix progs with different arenas, so no conver=
sion
>> > > +    * is possible here. Not reachable today: only struct_ops progs =
get
>> > > +    * arena ctx args and they never ride generic trampolines.
>> > > +    */
>> > > +   for (kind =3D 0; kind < BPF_TRAMP_MAX; kind++) {
>> > > +           for (i =3D 0; i < tnodes[kind].nr_nodes; i++) {
>> > > +                   if (bpf_prog_has_arena_ctx_arg(tnodes[kind].node=
s[i]->link->prog)) {
>> > > +                           err =3D -ENOTSUPP;
>> > > +                           goto out;
>> > > +                   }
>> > > +           }
>> > > +   }
>> >
>> > Nit: should this be done in __bpf_trampoline_link_prog() or
>> >      bpf_trampoline_add_prog()? To avoid doing the same check on unlin=
k.
>> >      Since this is an invariant violation, do we want to add WARN_ONCE=
?
>> >
>> > > +
>> > >     /* clear all bits except SHARE_IPMODIFY and TAIL_CALL_CTX */
>> > >     tr->flags &=3D (BPF_TRAMP_F_SHARE_IPMODIFY | BPF_TRAMP_F_TAIL_CA=
LL_CTX);
>> > >
>> >
>> > ...
>>
>> Thinking a bit more about this. Since kfuncs already use flags in
>> btf_func_model, I think it would be nice to use them for struct_ops as
>> well. E.g. as in the patch attached (applied on top of this series).
>> Wdyt?
>
> I like that it relies on existing annotations instead of yet another
> auxiliary field.
>
> The mapping for arena args to different function models can be confusing =
though.
>
> For the verfication purpose: both __arena and __arena_nullable maps to
> KF_ARG_PTR_TO_ARENA | PTR_MAYBE_NULL.
> For the JIT purpose: __arena maps to BTF_FMODEL_ARENA_ARG;
> __arena_nullable maps to BTF_FMODEL_ARENA_ARG |
> BTF_FMODEL_NULLABLE_ARG.
>
> It might deserve a brief inline comment in get_kfunc_arg_type() saying
> why both tags map to KF_ARG_PTR_TO_ARENA | PTR_MAYBE_NULL.

Yeah I will add comments for this. I adopted Eduard's diff (w/ his SoB) on =
top
of the stack.
