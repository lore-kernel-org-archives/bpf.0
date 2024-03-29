Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0901348CCD
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 22:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749734; cv=none; b=d949WRqyZtyuu7tLjSExoPaqq8e/I+Y3f//YH/3Z3IzPUX6vG+RJiGTVYrELeyQo+Wb/d6KQT+LSrG/y1TxxfBRAVmZrRah3yjdAslxKMu3BboHUCtcRfXVuvYIZ2mbsXKmlZJT/vH90YbVF+0mB8A6YRPHJO01sc/x0QlQ8USU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749734; c=relaxed/simple;
	bh=l5bICBFhHCe4Miz89b95VTUbIAstut3Q/LdoezCMcw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXy3ysHX9oocQDPr0KFAhePLIUFqpKDV0RGfJ2WNiufA8bjTD7SlPYcydg2I2nuJAdpLL1HCPPaWj2AU2FlJrP9pDS5hEvOIu3LbWhs0rlsYGW4VxII5qHTA3VGfe4VXfyFeeWa2GedzaMwW0r2mE87PhK1nmhNaTShk4ZhPt3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aN1+AX92; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aN1+AX92"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a4e40fad4fdso67784266b.2
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 15:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711749731; x=1712354531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/kiCz5C/5y7WuxOsGyfmHaWYz8xdc9M7S9WO1K67iY=;
        b=aN1+AX92R4fUp8VheG/pcudysGeogz0QGwmKAbMwWbRj4h1VIIaTDBEaIfrm/zF3+8
         GR648EWn4QAHgTSrJPDTKITiQ8c3/arNCsZqEtQ3rehrXvSkfoRuFMOT4+/q5aYgRkTK
         C5IHowOgBhHtaV88sdsd8zTlaWApWRRyC2sEKDzyd8z4T98ThhWrhROWvM7K3XGANtgz
         O6gv6F/+cOkuBIe02VoJNTBZMNTWRzTistBophJbiCobKTbtXeiAcgx2vx2SZYjZRWpm
         TlwYIZPgcajiOqyzMLZTiuIzHRfr0opGl8/GQoqstCI3M4QZDrcFIt9m9tkRhKyJcHV9
         +1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711749731; x=1712354531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/kiCz5C/5y7WuxOsGyfmHaWYz8xdc9M7S9WO1K67iY=;
        b=famcmHdAShz6S7vgB3mkjPmTUXkJDH8PFZ5JIVefis0seVHO6+xQtvoM0mGYLLHoa0
         aPFNOc9kRHGzahl2LvIco6uUXBTnJSY+bndqGx9E+sos4F8c81YKO8R1BJJrSn0x8SbE
         2U95ms6oIpCNU6Jkd70d59RLGCQwGZPcyLpDgDeuQNcJ22u11vM42BzM4dkZpoZd/tGX
         hTP2U+VGMUMNRd0y8HQ6Q/3593X1h7oPKmRoxwblnzHGauuRMFfthtM5sJeusdEyDiC/
         p/uK4Gkhabsh8Ho/x74tQxgnR4dQPlW56dfFFejuc/cGwOw7y+zJn6I3AyI4qcXCoaVT
         qjHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhl+IkdVit8ZnJZ2FkCmf7hVGlCtjNXHPzAe4LMAh6JFVgGDssCI0pahO+y3GzKvvBoVqppKwccIMkJt7PwmaViSeN
X-Gm-Message-State: AOJu0YwNQgqJ0f78NWswd/UynqpL7yXDw2X9Mm4MXWlxf9sO8n/i3QHD
	9tK3DUxPCsJ+Sm7/XVENhF9/awByXl9syF9ecxKnlXa7/LsbYE3W+4OAAOV8BZOEt/5UYdUzPH9
	9i9p4xUOxNsQmqi4qLdAaPbWpS1s=
X-Google-Smtp-Source: AGHT+IEcm8XwX629pj7adY2CzM3nWQbd3Zn7oKVxLRnIu8tldbkVOUQk2Czc3cHqyNOOh+mMwZrNO/KwqsgjWNdIhuA=
X-Received: by 2002:a17:906:f202:b0:a4e:70f:dd11 with SMTP id
 gt2-20020a170906f20200b00a4e070fdd11mr2183544ejb.25.1711749731420; Fri, 29
 Mar 2024 15:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322102455.98558-1-alan.maguire@oracle.com> <20240322102455.98558-11-alan.maguire@oracle.com>
In-Reply-To: <20240322102455.98558-11-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 15:01:55 -0700
Message-ID: <CAEf4BzbQEYgiJ=Xc7qaf0Tm_geTd40Ld+623Gk0TaBjPtTsnKg@mail.gmail.com>
Subject: Re: [RFC bpf-next 09/13] libbpf: split BTF reconciliation
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com, 
	quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 3:26=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Map base reference BTF type ids referenced in split BTF and their
> references to the base BTF passed in, and if the mapping succeeds,
> reparent the split BTF to the base BTF.
>
> Reconciliation rules are
>
> - base types must match exactly
> - enum[64] types should match all value name/value pairs, but the
>   to-be-reconciled enum[64] can also define additional name/value pairs
> - named fwds match to the correspondingly-named struct/union/enum/enum64

yeah, but what about their size if they are embedded? Using FWD was a
nice trick, but it's not flexible enough for recording (optionally)
size... Probably emitting an empty (but named) struct/union/enum would
be a bit better (and actually make split BTF using base ref more valid
even without pre-processing).

> - anon struct/unions must have field names/offsets specified in base
>   reference BTF matched by those in base BTF we are matching with
>
> Reconciliation can not recurse, since it will be used in-kernel also and
> we do not want to blow up the kernel stack when carrying out type
> compatibility checks.  Hence we use a stack for reference type
> reconciliation rather then recursive function calls.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/Build             |   2 +-
>  tools/lib/bpf/btf.c             |  58 ++++
>  tools/lib/bpf/btf.h             |   8 +
>  tools/lib/bpf/btf_reconcile.c   | 590 ++++++++++++++++++++++++++++++++

how wrong would it be to call this process "relocate" rather than "reconcil=
e"?

>  tools/lib/bpf/libbpf.map        |   1 +
>  tools/lib/bpf/libbpf_internal.h |   2 +
>  6 files changed, 660 insertions(+), 1 deletion(-)
>  create mode 100644 tools/lib/bpf/btf_reconcile.c
>

[...]

> +/* Find next type after *id in base BTF that matches kind of type t pass=
ed in
> + * and name (if it is specified).  Match fwd kinds to appropriate kind a=
lso.
> + */
> +static int btf_reconcile_find_next(struct btf_reconcile *r, const struct=
 btf_type *t,
> +                                  __u32 *id, const struct btf_type **tp)

I haven't grokked the whole patch logic just yet, doing a first pass,
so I might be asking stupid questions, sorry.

But it looks like we have these linear searches here to find matching
types, is that right? Wouldn't it be better to build an index first to
speed up search?

> +{
> +       const struct btf_type *nt;
> +       int kind, tkind =3D btf_kind(t);
> +       int tkflag =3D btf_kflag(t);
> +       __u32 i;
> +

[...]

> +static int btf_reconcile_int(struct btf_reconcile *r, const char *name,
> +                            const struct btf_type *t, const struct btf_t=
ype *bt)
> +{
> +       __u32 *info =3D (__u32 *)(t + 1);
> +       __u32 *binfo =3D (__u32 *)(bt + 1);
> +
> +       if (t->size !=3D bt->size) {
> +               pr_warn("INT types '%s' disagree on size; reference base =
BTF says %d; base BTF says %d\n",
> +                       name, t->size, bt->size);
> +               return -EINVAL;
> +       }
> +       if (BTF_INT_ENCODING(*info) !=3D BTF_INT_ENCODING(*binfo)) {
> +               pr_warn("INT types '%s' disagree on encoding; reference b=
ase BTF says '(%s/%s/%s); base BTF says '(%s/%s/%s)'\n",
> +                       name,
> +                       BTF_INT_ENCODING(*info) & BTF_INT_SIGNED ? "signe=
d" : "unsigned",
> +                       BTF_INT_ENCODING(*info) & BTF_INT_CHAR ? "char" :=
 "nonchar",
> +                       BTF_INT_ENCODING(*info) & BTF_INT_BOOL ? "bool" :=
 "nonbool",
> +                       BTF_INT_ENCODING(*binfo) & BTF_INT_SIGNED ? "sign=
ed" : "unsigned",
> +                       BTF_INT_ENCODING(*binfo) & BTF_INT_CHAR ? "char" =
: "nonchar",
> +                       BTF_INT_ENCODING(*binfo) & BTF_INT_BOOL ? "bool" =
: "nonbool");

there is btf_int_encoding() helper, please use it

> +               return -EINVAL;
> +       }
> +       if (BTF_INT_BITS(*info) !=3D BTF_INT_BITS(*binfo)) {

btf_int_bits()

> +               pr_warn("INT types '%s' disagree on bit size; reference b=
ase BTF says %d; base BTF says %d\n",
> +                       name, BTF_INT_BITS(*info), BTF_INT_BITS(*binfo));
> +               return -EINVAL;
> +       }
> +       return 0;
> +}
> +
> +static int btf_reconcile_float(struct btf_reconcile *r, const char *name=
,
> +                              const struct btf_type *t, const struct btf=
_type *bt)
> +{
> +
> +       if (t->size !=3D bt->size) {
> +               pr_warn("float types '%s' disagree on size; reference bas=
e BTF says %d; base BTF says %d\n",
> +                       name, t->size, bt->size);
> +               return -EINVAL;
> +       }
> +       return 0;
> +}
> +
> +/* Ensure each enum value in type t has equivalent in base BTF and that =
values (if any) match. */
> +static int btf_reconcile_enum(struct btf_reconcile *r, const char *name,
> +                             const struct btf_type *t, const struct btf_=
type *bt)
> +{

should we care about compatibility between ENUM and ENUM64, they can
both represent the same values of the same size?

> +       struct btf_enum *v =3D (struct btf_enum *)(t + 1);
> +       struct btf_enum *bv =3D (struct btf_enum *)(bt + 1);
> +       bool found, match;
> +       int i, j;
> +
> +       for (i =3D 0; i < btf_vlen(t); i++, v++) {
> +               found =3D match =3D false;
> +
> +               if (!v->name_off)
> +                       continue;
> +               for (j =3D 0; j < btf_vlen(bt); j++, bv++) {
> +                       if (!bv->name_off)
> +                               continue;
> +                       if (strcmp(btf__name_by_offset(r->base_ref_btf, v=
->name_off),
> +                                  btf__name_by_offset(r->base_btf, bv->n=
ame_off)) !=3D 0)

nit: please use local vars to shorten these long if conditions, it
will be easier to read and follow

> +                               continue;
> +                       found =3D true;
> +                       match =3D (v->val =3D=3D bv->val);
> +                       break;
> +               }

[...]

> +       while ((err =3D btf_reconcile_find_next(r, t, &base_id, &bt)) !=
=3D -ENOENT) {
> +               bt =3D btf_type_by_id(r->base_btf, base_id);
> +               switch (btf_kind(t)) {
> +               case BTF_KIND_INT:
> +                       err =3D btf_reconcile_int(r, name, t, bt);
> +                       break;
> +               case BTF_KIND_ENUM:
> +                       err =3D btf_reconcile_enum(r, name, t, bt);
> +                       break;
> +               case BTF_KIND_FLOAT:
> +                       err =3D btf_reconcile_float(r, name, t, bt);
> +                       break;
> +               case BTF_KIND_ENUM64:
> +                       err =3D btf_reconcile_enum64(r, name, t, bt);
> +                       break;
> +               case BTF_KIND_FWD:

well, FWD can be for enum vs struct, gotta check that

> +                       err =3D 0;
> +                       break;
> +               default:
> +                       return 0;
> +               }
> +               if (!err) {
> +                       r->map[id] =3D base_id;
> +                       return 0;
> +               }
> +       }
> +       return err;
> +}

[...]

> +                               if (err) {
> +                                       pr_warn("could not find base BTF =
type for base reference type[%u]\n",
> +                                               id);
> +                                       return err;
> +                               }
> +                       } else {
> +                               if (btf_reconcile_push(r, id) < 0 ||
> +                                   btf_reconcile_push(r, t->type) < 0)
> +                                       return -ENOSPC;

I'm missing something, please help me understand. I don't get why we
need a recursive algorithm at all.

In my mind, we have this small "base ref" set of types referenced from
module's BTF (split BTF part), right? So all we should need is to map
every type from base ref set to vmlinux BTF.

What I don't yet fully get is why CONST/VOLATILE or PTR need to
postpone reconciliation via a queue. By the time we get to types in
split BTF all base ref types should be mapped, so all you need is to
remap t->type to resolved vmlinux BTF, no?

I suspect the answer might have something to do with those anonymous
structs/unions which you copy verbatim into base ref BTF?

But on the latter topic, I wonder if we at all need this? Why not keep
all those anon struct/union/enum in module's part of BTF? If they are
unnamed, I doubt they will ever be referenced from kfuncs or anything
like that, so their BTF ID isn't that important.

If base BTF is all named types, it would simplify the reconciliation
process significantly, I think.

But again, I only skimmed the overall algorithm, sorry for my
laziness, but I figured it would be good to discuss the above first
anyways.

> +                       }
> +                       break;

[...]
