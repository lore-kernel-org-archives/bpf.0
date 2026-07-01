Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8D32417D1
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 20:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936245; cv=pass; b=eCuBiDjO5ES0mbMPVnZ2OKzisFG18JWYmFMdaDf54dgDdo3/isR4aYKIfPEjpY4uqooBIjt7GmA1OsezjKq+OrqjNCxzvaGs6dIUwpKKftrOGKTymAOrpN3GAyGJjl5Hvb4ahgQQ9+s6gfYQmAeVYU8ZLm8XYwhAh/trftP8CCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936245; c=relaxed/simple;
	bh=1j/ObD3SfDOyWR+ofioynMmKemTgnpOaPu8Y4r+fYWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MuDf8fhAQ8RETIoMn9QBhAYMq+MCOOv7cpXjqW+LBo0+kdLN0choBTNe9t898NpHrhs97eOM5yaJKf1YRY/AldtQKPCOrr29rl7Y8ZJJrVnYD/HOswm8wK1BdAoA+JjUoTTX0/8lmBA+pOx2PISHmuhcPZyxiVZHdOAu8uxJNG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ispHq9q2; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ispHq9q2"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36b9d265355so665823a91.2
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 13:04:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782936243; cv=none;
        d=google.com; s=arc-20260327;
        b=OmquL11XiIFNQgUaZtsoVsrv6otPR1ExVxc19lYCWcWcHmD5lqOja7ARtH8lfpHKHD
         ExxVLMW5NHSfEUarXdSPzsUl93qFNbFNLZbjeBctjE7qyQfK8eqyT/itHsc9AxB7C+UD
         3RWMJ/W6/eeg6yt6Eq8ijGYv9f1fju66jbOJbX1JqxbZspvXvsExr5SQQvhbP1rW4q9Y
         5z3LfABQzFsxFBLqQUV/7esXn/USvHUVeSf2Ubp0dwHVbqyEp+yIhxe+S/GqH6oGKX/B
         IkMBt+ZA96b8C52YNis74HrwdyW4aEdIDjJdeWwn4qbmH8eAff0BUReU6qiBrx46/sre
         LJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aBoD9f4ROcb91+J5EcILQBfD70fKIKOcNBENkzEmUaU=;
        fh=eKpNNTiaGVxSuf5JEqZ4/Aoq6GFFAH3CM1kmtuggluc=;
        b=ESveQFLB1K2Vs+T6yIFiixQxVwLKdPiLt1bfaZ6dfAcHEEudNVQgGgAoeyadVKCmVj
         GUQebT41EBArAWbAHZAqVfy+T9ZPjs000nl9IJTmtiNadBo8jmMSekgD2txrpNHfPiCe
         Nh25Ur6wAMyYJ1zsy3dXSuY/AP9BiG44iJ2rSVar0NTY9HqPZpk6yt3NdnxIW5gk+yzu
         nkjSX2Zl/1uOIulOiRodwh3xjeTjyIc+FSvPL0k8WB/3R0r3QFc09zslndngnBaNkXRs
         Y0awGOTxnC7+PzYEg/yQa8ottZadEXR5Q/qBRjz9aJvyWbb/6umLKNTNYHX9QSu5nQO7
         Olfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782936243; x=1783541043; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aBoD9f4ROcb91+J5EcILQBfD70fKIKOcNBENkzEmUaU=;
        b=ispHq9q2rJpHYPOpta5Uv80PGqYV+h6jKxpruSPpb5aLNBxy9f3TEJ489pfk9BujM7
         kSKtXHsyiPbsPnbHkVW/O9Tu3x0LOXN/712k6L4mKfa54zfB11VEyyI4Cc6iBj2nr5fi
         sCn13G53gVOCCUN6/5rIOAHNpjFrz1JAk+L7CH7UAlLgO79JZiqYtPHiPtAeMsL799G5
         BwXvkhbkDMSvT2YLAPWDyFrJ6RvNGNVqFJVcZrGIN/0jOwD4FX++1HOo+zMB8x3h/Yo/
         PwJVMDZZ+k2X2HqEjhH+iTRIoO/xsqp43O79LgpZQlasT7+MMje5++Xb/u7anHhnarUd
         Zk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782936243; x=1783541043;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aBoD9f4ROcb91+J5EcILQBfD70fKIKOcNBENkzEmUaU=;
        b=E1PR/iOVExZN8+ydSIg5PwGSGqlhlHa7eZ3a7FNLbVjYpY4SddyufXLsCnS9W9isw3
         8rzPnTAMICRQOJN9jaO149rs/Pe0imZc3BTt+DXGTo27+OddFgg6/jctPe1ueG+JCnG6
         YD/bFwxOISljWOXFw4lf0Z6N23fT3yUyWMkUgzbR0Cn5XuJVYbSK/FM6xa/5O7Xhn4JS
         4cMqtYSolAx/9U4GHnASAcHwMIcv/SvXS/LZDyVSAyyvT8mn90Bcykwt4nwFvrRAHoC8
         q7VMSIq62QeL2cRbvxu4L8k5XbxFARwHVA8pCEiVOWdUoC21aBOaj18Ej2zXBrm/KaPV
         9ITA==
X-Forwarded-Encrypted: i=1; AHgh+RqqlSF8NNOe5Q4TmedYnc/O7zdp+IPP9m0ycd3GT+TCQ3DlsdgUy8Z89WBqofLbTod1bmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIRi1RhH+YxJfKe4ZDl0CS2DNLDXPLUh5C0+3qzx1Ia8EIk1I7
	uQ8XxaL0xGBTPI7yi3X+yLuM+iZa1rc5ZdghP6n3YuMUsnnFUY/K3fGk/r3i0r7D+wYYeca2gVM
	6oEtu0ADL6w44CFnUkM+MG9aSxHd60LM=
X-Gm-Gg: AfdE7clbbkKPgCKFIPYLZGxsDTNqoi2dEZ92ryhWKrSnLDKwBszNM68pJd7Rt3jizzF
	4CmOo6ItK94621JOPLIF+VKz6nIjJC9ZFPiy8XH5Ik1Qt40CAS1J2r9jVuO5SJ9gw5csUhhwxtn
	GrzAFjiVGjOHeu5JxQ2qHYRmbuRddIPk8GkXPMFN0PoRQABuZhdWXkPy/hzjTSa3PIibTptHqgG
	KqhNRUB9efByXRy4Jtf2F9jZZa/7GCU8WX8s4ouj4W3SUYbgp0h4PfVPfB1EdkPDohxkY6DH6XG
	ruJUmTwODPox89XoB4eBmb99JYuWbQu/nwcrW51xLXI2NOoMx6G1hw==
X-Received: by 2002:a17:90b:3952:b0:37f:c239:10f5 with SMTP id
 98e67ed59e1d1-380ba82a068mr2431606a91.12.1782936243430; Wed, 01 Jul 2026
 13:04:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701062541.704792-1-luoliang@kylinos.cn> <283f55ab6c34b18168a028ea00bbea5d3c953696.camel@linux.dev>
In-Reply-To: <283f55ab6c34b18168a028ea00bbea5d3c953696.camel@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Jul 2026 13:03:51 -0700
X-Gm-Features: AVVi8Ccbxktq0olFb9CfrJNNG5h6EV86ViCrvxRWOVH8WxTKyABGHPTghu6KANU
Message-ID: <CAEf4BzbeSK+-5L5LudgV0+fpRHK6fSVfwBnE3C3OE+c2vFGP3Q@mail.gmail.com>
Subject: Re: [PATCH] bpftool: use btf_vlen()/btf_kind()/btf_kflag() helpers consistently
To: KaFai Wan <kafai.wan@linux.dev>
Cc: luoliang@kylinos.cn, Quentin Monnet <qmo@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 8:05=E2=80=AFAM KaFai Wan <kafai.wan@linux.dev> wrot=
e:
>
> On Wed, 2026-07-01 at 14:25 +0800, luoliang@kylinos.cn wrote:
> > From: luoliang <luoliang@kylinos.cn>
> >
> > The btf_vlen(), btf_kind() and btf_kflag() inline helpers defined in
> > tools/lib/bpf/btf.h are thin wrappers around the BTF_INFO_VLEN(),
> > BTF_INFO_KIND() and BTF_INFO_KFLAG() UAPI macros - each one simply
> > returns the corresponding macro applied to t->info.
> >
> > bpftool already uses these helpers in most places, but 13 call sites
> > in btf.c and btf_dumper.c still open-code the raw macros. Use the
> > helpers consistently, matching the rest of bpftool as well as libbpf.
> >
> > No functional change.
> >
> > Signed-off-by: Liang Luo <luoliang@kylinos.cn>
> > ---
> >  tools/bpf/bpftool/btf.c        | 12 ++++++------
> >  tools/bpf/bpftool/btf_dumper.c | 14 +++++++-------
> >  2 files changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> > index 6ef908adf3a4..24e4cb600b3f 100644
> > --- a/tools/bpf/bpftool/btf.c
> > +++ b/tools/bpf/bpftool/btf.c
> > @@ -179,7 +179,7 @@ static int dump_btf_type(const struct btf *btf, __u=
32 id,
> >       case BTF_KIND_STRUCT:
> >       case BTF_KIND_UNION: {
> >               const struct btf_member *m =3D (const void *)(t + 1);
> > -             __u32 i, vlen =3D BTF_INFO_VLEN(t->info);
> > +             __u32 i, vlen =3D btf_vlen(t);
> >
> >               if (json_output) {
> >                       jsonw_uint_field(w, "size", t->size);
> > @@ -193,7 +193,7 @@ static int dump_btf_type(const struct btf *btf, __u=
32 id,
> >                       const char *name =3D btf_str(btf, m->name_off);
> >                       __u32 bit_off, bit_sz;
> >
> > -                     if (BTF_INFO_KFLAG(t->info)) {
> > +                     if (btf_kflag(t)) {
> >                               bit_off =3D BTF_MEMBER_BIT_OFFSET(m->offs=
et);
> >                               bit_sz =3D BTF_MEMBER_BITFIELD_SIZE(m->of=
fset);
> >                       } else {
> > @@ -224,7 +224,7 @@ static int dump_btf_type(const struct btf *btf, __u=
32 id,
> >       }
> >       case BTF_KIND_ENUM: {
> >               const struct btf_enum *v =3D (const void *)(t + 1);
> > -             __u32 i, vlen =3D BTF_INFO_VLEN(t->info);
> > +             __u32 i, vlen =3D btf_vlen(t);
> >               const char *encoding;
> >
> >               encoding =3D btf_kflag(t) ? "SIGNED" : "UNSIGNED";
> > @@ -300,7 +300,7 @@ static int dump_btf_type(const struct btf *btf, __u=
32 id,
> >               break;
> >       }
> >       case BTF_KIND_FWD: {
> > -             const char *fwd_kind =3D BTF_INFO_KFLAG(t->info) ? "union=
"
> > +             const char *fwd_kind =3D btf_kflag(t) ? "union"
> >                                                              : "struct"=
;
> nit: coding style, and can be one line.

this is the only line that would benefit from a tiny amount of human
touch and judgement call, and yet...

pw-bot: cr


> >
> >               if (json_output)
> > @@ -322,7 +322,7 @@ static int dump_btf_type(const struct btf *btf, __u=
32 id,
> >       }
> >       case BTF_KIND_FUNC_PROTO: {
> >               const struct btf_param *p =3D (const void *)(t + 1);
> > -             __u32 i, vlen =3D BTF_INFO_VLEN(t->info);
> > +             __u32 i, vlen =3D btf_vlen(t);
> >
> >               if (json_output) {
> >                       jsonw_uint_field(w, "ret_type_id", t->type);
> > @@ -365,7 +365,7 @@ static int dump_btf_type(const struct btf *btf, __u=
32 id,
> >       case BTF_KIND_DATASEC: {
> >               const struct btf_var_secinfo *v =3D (const void *)(t + 1)=
;
> >               const struct btf_type *vt;
> > -             __u32 i, vlen =3D BTF_INFO_VLEN(t->info);
> > +             __u32 i, vlen =3D btf_vlen(t);
> >
> >               if (json_output) {
> >                       jsonw_uint_field(w, "size", t->size);
> > diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dum=
per.c
> > index 9dc8425b1789..e4075824343f 100644
> > --- a/tools/bpf/bpftool/btf_dumper.c
> > +++ b/tools/bpf/bpftool/btf_dumper.c
> > @@ -476,8 +476,8 @@ static int btf_dumper_struct(const struct btf_dumpe=
r *d, __u32 type_id,
> >       if (!t)
> >               return -EINVAL;
> >
> > -     kind_flag =3D BTF_INFO_KFLAG(t->info);
> > -     vlen =3D BTF_INFO_VLEN(t->info);
> > +     kind_flag =3D btf_kflag(t);
> > +     vlen =3D btf_vlen(t);
> >       jsonw_start_object(d->jw);
> >       m =3D (struct btf_member *)(t + 1);
> >
> > @@ -535,7 +535,7 @@ static int btf_dumper_datasec(const struct btf_dump=
er *d, __u32 type_id,
> >       if (!t)
> >               return -EINVAL;
> >
> > -     vlen =3D BTF_INFO_VLEN(t->info);
> > +     vlen =3D btf_vlen(t);
> >       vsi =3D (struct btf_var_secinfo *)(t + 1);
> >
> >       jsonw_start_object(d->jw);
> > @@ -557,7 +557,7 @@ static int btf_dumper_do_type(const struct btf_dump=
er *d, __u32 type_id,
> >  {
> >       const struct btf_type *t =3D btf__type_by_id(d->btf, type_id);
> >
> > -     switch (BTF_INFO_KIND(t->info)) {
> > +     switch (btf_kind(t)) {
> >       case BTF_KIND_INT:
> >               return btf_dumper_int(t, bit_offset, data, d->jw,
> >                                    d->is_plain_text);
> > @@ -631,7 +631,7 @@ static int __btf_dumper_type_only(const struct btf =
*btf, __u32 type_id,
> >
> >       t =3D btf__type_by_id(btf, type_id);
> >
> > -     switch (BTF_INFO_KIND(t->info)) {
> > +     switch (btf_kind(t)) {
> >       case BTF_KIND_INT:
> >       case BTF_KIND_TYPEDEF:
> >       case BTF_KIND_FLOAT:
> > @@ -661,7 +661,7 @@ static int __btf_dumper_type_only(const struct btf =
*btf, __u32 type_id,
> >               break;
> >       case BTF_KIND_FWD:
> >               BTF_PRINT_ARG("%s %s ",
> > -                           BTF_INFO_KFLAG(t->info) ? "union" : "struct=
",
> > +                           btf_kflag(t) ? "union" : "struct",
> >                             btf__name_by_offset(btf, t->name_off));
> >               break;
> >       case BTF_KIND_VOLATILE:
> > @@ -718,7 +718,7 @@ static int btf_dump_func(const struct btf *btf, cha=
r *func_sig,
> >               BTF_PRINT_ARG("%s(", btf__name_by_offset(btf, func->name_=
off));
> >       else
> >               BTF_PRINT_ARG("(");
> > -     vlen =3D BTF_INFO_VLEN(func_proto->info);
> > +     vlen =3D btf_vlen(func_proto);
> >       for (i =3D 0; i < vlen; i++) {
> >               struct btf_param *arg =3D &((struct btf_param *)(func_pro=
to + 1))[i];
> >
>
