Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5361F369216
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873758; cv=pass; b=Gd+5z7ojPYZ2hplYDqX0f4jqdw9whnPbpIQlBpiO0kwMkUj+ZCFbuYE7Nrx8ugQarcwdukP67O7LrPnhibUIneWei+EsXjCrMHiBkgoIDT1/27bhwxvMwH2IsALwMwjn8yjH4IPG6ihlTbg4ZTg6ZKVAnN8jdSE4YmqWxisPGeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873758; c=relaxed/simple;
	bh=fxpcy5HjGkCgBp59Lk8srL4bOZxayDGFZnFrl/p49+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAtm0ZzNbsam0lyGWdDOFoagiC0bkO5PJ4jz1s/J+YZhwOib0xvdJ19wu2dS5MsoI/GA2UMTfN7SgX0xZlS/TD5lQ5xHKHjXGETd1gB8lvJ7Ed9A3VZQlPkRW5cv+EY/Nv55/+dx8AgckDo3bJGxOcQ4rlb5g11x27455I94L6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apYFlDj8; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apYFlDj8"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-354a7b089bbso2671597a91.2
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 11:09:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771873757; cv=none;
        d=google.com; s=arc-20240605;
        b=J0I5QuI5UDA1XhnbV/x8nt23pIDObigzHz7GO+aK3X86kiN9XzVG7p3JyPmdPXVWlo
         fhaAuruHoSTEeNsTXjGIB85OArLeOuSkmhAur6U8LGLispLCj/r24ievNTCjpmE20/nS
         HdwSl5Q59Erzb2DPDkhWbCjOIaaeMzudyZM1gzLAgJx5UrWRrnmilPeGMuLaJqRPHCYj
         pWv6QsB7+DT6fJCiYXGmQBvw10/FCKSkx3X9Scjz9bVLQIy+knHd7JaxpE7G2RWWD3bm
         rwWl1n/+N5obBzN8p4zEebUSOvj2OFxpmYzgcRvYaHV7FvGlJVXU3Oabrn9iYwQ7DS4n
         iSjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dpz5Nj2bdTxYZ6i2lVbK7UkBXuRbIPkS1oGs5djGpW0=;
        fh=AVvqo1fYp8EVDSz80YlBsFqKqvJZZCXv6poLKtqhEiI=;
        b=XL+tmV1UDwpZUgYJ4/Mo5OhTq9TN5C4w9dTuf0P3s7zRwP6JrDJY0OS91WR91Cyjm7
         HaYhEgZ3E43GXn/sXdC6bSxDLMSVPG+00V4n/0TW5s+5gNiGA9WiUL05glb8gUzkax+E
         7a010wTbXIFrC8gRlyT5POc1d9NF59vssjxQUAueWHePJHCycYw2ooM0Y0gp9nbdIGCM
         C91bTZtZXvpRfnV17DYGbsnteO1CMeHsG5EqAt4iCrjA8jbgsklDU9KLNTtfassio0b6
         /Vy7sHkiSx+JXiVofw67om/zZAY/035KzPk0cO7av++2Jfu/XAAsLOP/jPZ7KP7CEcOV
         oZeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771873757; x=1772478557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dpz5Nj2bdTxYZ6i2lVbK7UkBXuRbIPkS1oGs5djGpW0=;
        b=apYFlDj82Xu1Tm3tdx6VsrVRdJ5RqNVasWfo3YdEuGUOBqLwERgWBk+nmDOtHBNG8U
         69euYMGW6OnhFMi8t5CTroazXlYAR5X1j1lO1YUBaFUBUJPiZftgfp0iPXS3qbWeBwaO
         KhrFQaXrBHvm7FADB2/LFaglHPWYXcSKwVU69RJyi7rpeTfuSKvbdaglgdgrUjVwy1gE
         rO5rjo+SBoYqpCwW7BUprNhA0zLA1DnT80Q0W2VkfDF7LO8WyB5voBBiDjIV5ytWks/z
         g5gH5++GOZU0MAwdKJzOYVXWWyBrSH3E9FEYveE+fh5GduNJM/wmucAPi35rFrJhScQ1
         nbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771873757; x=1772478557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dpz5Nj2bdTxYZ6i2lVbK7UkBXuRbIPkS1oGs5djGpW0=;
        b=HWhCxsIuz/HqTSKGjsQGxe8mMHUE4EfOp75L/qOOQpq4i+e9Ku7hiMrzO35OwINYyK
         bUZNrdvvqt5rS9A/XkYilvw7gjumpQCV5mgPV/+i4atvrOFWMXxQbq6yNrhisFcG0v9i
         WrmyJGF3kRMxMPzt/dPYzCeoJSRNlfs+ns4MppQx9AwviaV0PFHHvLy+5dmKm/7EdT8o
         SGonCHYq+Lv0a/PKDpAcOt9ymUDCZRPaVYbmp+bQqDIm+70fR26UKiBQGpEUWWrphIxv
         p7wiHqIg0o8u7azZLqZ2Oc0s87/ZR79w2Nebyw6mlVcWYI7bz3l3UiBRYlwBEsUeYC0A
         8GYg==
X-Forwarded-Encrypted: i=1; AJvYcCV6PuAYHCvPZNaaA4/Xh3s6grxAw36NkKnoABjHhdi8bdhPaJBgrpxp4+Rfbg0flN/TTYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZnSwB8jZ+VOStzgHP3Rwgn5YEquUi2usCTL9iLRvf3B3kNNlu
	zhXnBNyTG+NWqV8vcamvvEcKmnrc9/m8svbc0lkP0W9Ht4zwvgcRois10KZrcdL5bFiB5+sh6wV
	0Vcr0Am0Hwii1zNzsoTWKmxNtV6Z+7JI=
X-Gm-Gg: ATEYQzyKFM2CacObIyARD9oTV0oUu30DJxmvWzaP4SiUoe5LeLJSKqIW/eL4GII6pQP
	Yvs9f3vuWV2xTaD5FKKoE2rcA+q8insdQl24A5r7fr1p/kEclFjz1PYkQiIbld03EOI0zkDcG+W
	V5XJYpzcuayN59wryU17DI0HAm3l1GIh0y8DIVeDLAItLKo/F/MQSgFKulQ9yRw5zv3tbvTF/to
	cd5SHo2E8SEU86hRWrE/3A5lwDNEhyE5bAQKLsjVD2DecVKItZ/c+1H6vu4mEOzSN2Sm17fApj2
	nrEIGGllKB8WSPh+OubmpE4=
X-Received: by 2002:a17:90b:4fc8:b0:356:2c88:1e7a with SMTP id
 98e67ed59e1d1-358ae8c309fmr7124852a91.29.1771873756564; Mon, 23 Feb 2026
 11:09:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211125737.1315848-1-dongml2@chinatelecom.cn>
 <CAEf4Bzb6ay+gLD0gqZ8j8-=9onZE396YQmyGX-ZLELqF73iDGA@mail.gmail.com> <5968554.DvuYhMxLoT@7950hx>
In-Reply-To: <5968554.DvuYhMxLoT@7950hx>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 23 Feb 2026 11:09:04 -0800
X-Gm-Features: AaiRm50hC8WNNmNtkPmOAO1vWdhBiPs91cXX-mk2CtxZT_FJfrWdZQX1IVz4mfQ
Message-ID: <CAEf4BzYJPue8VN59buLAaxL_SfbnHQQXs7nQn6_2t6=E_CppvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: skip compat check for session kfuncs
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 22, 2026 at 6:16=E2=80=AFAM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
> On 2026/2/12 01:20, Andrii Nakryiko wrote:
> > On Wed, Feb 11, 2026 at 4:57=E2=80=AFAM Menglong Dong <menglong8.dong@g=
mail.com> wrote:
> > >
> > > The function prototype of bpf_session_{cookie,is_return} is changed i=
n
> > > the commit 8fe4dc4f6456 ("bpf: change prototype of
> > > bpf_session_{cookie,is_return}"), which is not friendly to the old ke=
rnel,
> > > as the libbpf will fail on the compatible checking.
> > >
> > > Therefore, let's skip the checking of bpf_session_{cookie,is_return} =
in
> > > libbpf, and just let the kernel do the checking.
> > >
> > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > ---
> > >  tools/lib/bpf/libbpf.c | 31 ++++++++++++++++++++-----------
> > >  1 file changed, 20 insertions(+), 11 deletions(-)
> > >
> >
> > This is not the way. Use bpf_ksym_exists() check and have custom
> > legacy bpf_session_cookie___legacy() definition with old prototype.
> > You can then detect whether
> > bpf_ksym_exists(bpf_session_cookie___legacy) is true and use the
> > legacy version, otherwise use the current version.
>
> Great! I found that there are already similar usages in kernel.
> I did some tests, and it works well. Thanks!
>
> BTW, do you think that if we need do some wrapper for bpf_session_{cookie=
,is_return}
> like this in case that someone else don't know the compatible problem?
>
> extern bool bpf_session_is_return___legacy(void) __weak __ksym;
> extern __u64 *bpf_session_cookie___legacy(void) __weak __ksym;
>
>
> #define bpf_session_is_return(ctx)                                       =
                       \
>         (bpf_ksym_exists(bpf_session_is_return___legacy) ? bpf_session_is=
_return___legacy() :   \
>                                                            bpf_session_is=
_return(ctx))
> #define bpf_session_cookie(ctx)                                          =
               \
>         (bpf_ksym_exists(bpf_session_cookie___legacy) ? bpf_session_cooki=
e___legacy() : \
>                                                         bpf_session_cooki=
e(ctx))
>

I'd like to avoid carrying this in libbpf forever, tbh. One reason we
decided to break bpf_session_xxx() helpers is because almost no one is
using them in any serious capacity, so I'm thinking it's fine to just
have this workaround live in your code base as an early session
adopter.

> Thanks!
> Menglong Dong
>
> >
> > pw-bot: cr
> >
> >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index 0c8bf0b5cce4..71bdd1c1ac39 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -8557,6 +8557,12 @@ static int find_ksym_btf_id(struct bpf_object =
*obj, const char *ksym_name,
> > >         return id;
> > >  }
> > >
> > > +static bool kfunc_skip_compat_check(const char *name)
> > > +{
> > > +       return name && (strcmp(name, "bpf_session_cookie") =3D=3D 0 |=
|
> > > +                       strcmp(name, "bpf_session_is_return") =3D=3D =
0);
> > > +}
> > > +
> > >  static int bpf_object__resolve_ksym_var_btf_id(struct bpf_object *ob=
j,
> > >                                                struct extern_desc *ex=
t)
> > >  {
> > > @@ -8617,12 +8623,13 @@ static int bpf_object__resolve_ksym_func_btf_=
id(struct bpf_object *obj,
> > >         struct module_btf *mod_btf =3D NULL;
> > >         const struct btf_type *kern_func;
> > >         struct btf *kern_btf =3D NULL;
> > > +       const char *kfunc_name;
> > >         int ret;
> > >
> > >         local_func_proto_id =3D ext->ksym.type_id;
> > >
> > > -       kfunc_id =3D find_ksym_btf_id(obj, ext->essent_name ?: ext->n=
ame, BTF_KIND_FUNC, &kern_btf,
> > > -                                   &mod_btf);
> > > +       kfunc_name =3D ext->essent_name ?: ext->name;
> > > +       kfunc_id =3D find_ksym_btf_id(obj, kfunc_name, BTF_KIND_FUNC,=
 &kern_btf, &mod_btf);
> > >         if (kfunc_id < 0) {
> > >                 if (kfunc_id =3D=3D -ESRCH && ext->is_weak)
> > >                         return 0;
> > > @@ -8634,16 +8641,18 @@ static int bpf_object__resolve_ksym_func_btf_=
id(struct bpf_object *obj,
> > >         kern_func =3D btf__type_by_id(kern_btf, kfunc_id);
> > >         kfunc_proto_id =3D kern_func->type;
> > >
> > > -       ret =3D bpf_core_types_are_compat(obj->btf, local_func_proto_=
id,
> > > -                                       kern_btf, kfunc_proto_id);
> > > -       if (ret <=3D 0) {
> > > -               if (ext->is_weak)
> > > -                       return 0;
> > > +       if (!kfunc_skip_compat_check(kfunc_name)) {
> > > +               ret =3D bpf_core_types_are_compat(obj->btf, local_fun=
c_proto_id,
> > > +                                               kern_btf, kfunc_proto=
_id);
> > > +               if (ret <=3D 0) {
> > > +                       if (ext->is_weak)
> > > +                               return 0;
> > >
> > > -               pr_warn("extern (func ksym) '%s': func_proto [%d] inc=
ompatible with %s [%d]\n",
> > > -                       ext->name, local_func_proto_id,
> > > -                       mod_btf ? mod_btf->name : "vmlinux", kfunc_pr=
oto_id);
> > > -               return -EINVAL;
> > > +                       pr_warn("extern (func ksym) '%s': func_proto =
[%d] incompatible with %s [%d]\n",
> > > +                               ext->name, local_func_proto_id,
> > > +                               mod_btf ? mod_btf->name : "vmlinux", =
kfunc_proto_id);
> > > +                       return -EINVAL;
> > > +               }
> > >         }
> > >
> > >         /* set index for module BTF fd in fd_array, if unset */
> > > --
> > > 2.53.0
> > >
> >
> >
>
>
>
>
