Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7070948CCD
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 22:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749643; cv=none; b=cyjqV9eh4cSLxYIhndMlnrHMIeAqcag5DvSB0SJT5oavpwzxJQzxHJ85IIy71eA7xdxtavgscRlDHgwpTfHeVMyc7MubvG0noqJUV45hhPTlQB8US0HPp2Xw2u6kSTbjRplIFgvk2N2PwFC6rTnxmza+mXURajhsm8VWOeyNLjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749643; c=relaxed/simple;
	bh=XHeRQE1xEXFx804XnAi9BPHnSWhIjuUegR1PiXi9YIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qe38FHs2SZVbF/XF0hfQMQ8+5vHB+LpYkXmBjHz7owaIKIjwdTFtEcWemqSuBy8MmPmSmA2Y6X7TnKhMxsAh5lcvUCUey5Yhd1cyWx59nWhZ3rGpMFwxNIaM6jshsbJ+Deccu24fec1XeNzwsVX8u/cqQ/5ycm0errcTsJl++Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWipfJ8M; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWipfJ8M"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e0d82c529fso21412185ad.2
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 15:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711749641; x=1712354441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTRSLTS1bUQ820u7zdm6K1Pw0lYuBj471SKvweSnSqY=;
        b=QWipfJ8MsDgqFxawi4cjsrusaaSLaomVGPUBVUbQa5lwpJzJajRzeTPS9yPYxNH/02
         Hc2tAyqTuTjXviGu02f74oygTtzYscRXtcknJNm6xejoL6LvNoztXznd0a5l61Y3s656
         bKzRGYFS6C97+Ws5d3wSwkrNnK6+SabP59gulFciW/b8vXJ6R78pPIT7LY0Hi+OFkbh/
         G3Y9V4lfjMqoMKwClL/vmvTuPhgsYLCsufss8hb2U9Zry8SeCjFOQ6KfkXOesPpEHGSV
         XzLsVbFpiIkrgdn2yKDs7aTlkOyPRyWGb3S4ptRivI4Ns5Ix/AWjj4+hsnF5HpX+RCUb
         B4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711749641; x=1712354441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTRSLTS1bUQ820u7zdm6K1Pw0lYuBj471SKvweSnSqY=;
        b=xUe8mu7rDgrkjq+9ckdXSDryuKSqSIK88UoUsuFjpWQwDrAQlg6iWxp6GwosQQbFNz
         QRAhAJJ3mMNcqi72m4ksdl2wi1Vbafgkb0buYxdxmSOX/hRUPtukzKiCNXuKHllFRnAv
         FskNudyPrRCoG9LPpfORdQnQ34UWJAoSpSmoBobn7t+Zq1COCtE2fX/kT+lWuU4VMWDU
         BjpbYoEd8C5gGteJ8ZLPPx75lg2qvMZaHSaxbAGjIUNvh+KnOf3M90bO9oFnct8ueyA/
         vlh6mQAeAd7QIL+5IkPOYrGGAcO/iyYZv3NIt8/d8bP07E5pJyN0osaSCPuc8ZaQt/yf
         jMAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJPqCrb24gTCgTEYfJWp2EMbnximIYrvRfYqLNK68uRSxGhbq7Y89tVUxhUDUmNSH2m4hRw6DQoqz+oXELrGyxJP+q
X-Gm-Message-State: AOJu0YyGbMnldBER9aubo/EigSECnlIw/AAEmscMr83aTrqPGqnVm57t
	Nvg4QHIgrFPnxrujj4zZV4+XiaEk9INF/gDCXHTHvlnxcevPgz6zo6SAndWoOlnzsFi1bJ7t+Lm
	ra5OpufP/+JjylI5R5wzImql4hMI=
X-Google-Smtp-Source: AGHT+IFKh9dS7DQwBuJJCMxkW7ft1Q+USlOmQLA+w7Wvsrq4sOB2zSlI7Onj+zZX32BQ6hGvKB5AzfrpPfgdEUp0vN0=
X-Received: by 2002:a17:90a:fa04:b0:2a0:4ec2:f653 with SMTP id
 cm4-20020a17090afa0400b002a04ec2f653mr3134957pjb.4.1711749640633; Fri, 29 Mar
 2024 15:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322102455.98558-1-alan.maguire@oracle.com> <20240322102455.98558-4-alan.maguire@oracle.com>
In-Reply-To: <20240322102455.98558-4-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 15:00:28 -0700
Message-ID: <CAEf4BzZ-rezyjmsR2CJdZMbY0LUzp0KBOV1oVfXVDpXgyWMAYg@mail.gmail.com>
Subject: Re: [RFC bpf-next 02/13] libbpf: add btf__new_split_base_ref()
 creating split BTF with reference base BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com, 
	quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 3:25=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> To support more robust split BTF, adding supplemental context for the
> base BTF type ids that split BTF refers to is required.  Without such
> references, a simple shuffling of base BTF type ids (without any other
> significant change) invalidates the split BTF.  Here the attempt is made
> to store additional context to make split BTF more robust.
>
> This context comes in the form of "reference" base BTF - this base BTF
> constitutes the minimal BTF representation needed to disambiguate split B=
TF
> references to base BTF.  So for example if a struct is referred to from
> split -> base BTF, a forward representation of that struct is retained

so you decided to not bother with recording expected size? Remember we
were talking about situations where vmlinux struct can be embedded
inside the kernel module's struct. In this case *exact* struct size is
very important and can't be changed without breaking compatibility.
Shouldn't we keep track of this?

> in reference base BTF, and split BTF refers to it.  Base types are kept
> intact in reference base BTF, and reference types like pointers are store=
d
> as-is.  Avoiding struct/union/enum/enum64 expansion is important to keep
> reference base BTF representation to a minimum size; however anonymous
> struct, union and enum[64] types are represented in full since type detai=
ls
> are needed to disambiguate the reference - the name is not enough in thos=
e
> cases since there is no name.  In practice these are rare; in sample
> cases where reference base BTF was generated for in-tree kernel modules,
> only a few were needed in base reference BTF.  These represent the
> anonymous struct/unions that are used by the module but were de-duplicate=
d
> to use base vmlinux BTF ids instead.
>
> When successful, a new representation of the split BTF passed in is
> returned.  It refers to the reference BTF as its base, and both returned
> split and base BTF need to be freed by the caller.
>
> So to take a simple example, with split BTF with a type referring
> to "struct sk_buff", we will generate base reference BTF with a
> FWD struct sk_buff, and the split BTF will refer to it instead.
>
> Tools like pahole can utilize such split BTF to popuate the .BTF section

typo: populate

> (split BTF) and an additional .BTF.base_ref section (base reference BTF).
> Then when the split BTF is loaded, the base reference BTF can be used
> to reconcile split BTF and the current - and possibly changed - base BTF.
>
> So for example if "struct sk_buff" was id 502 when the split BTF was
> originally generated,  we can use the reference base BTF to see that
> id 502 refers to a "struct sk_buff" and replace instances of id 502
> with the current (reconciled) base BTF sk_buff type id.
>
> Base reference BTF is small; when building a kernel with all modules
> using base reference BTF as a test, the average size for module
> base reference BTF is 1555 bytes (standard deviation 1563).  The
> maximum base reference BTF size across ~2700 modules was 37895 bytes.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c      | 215 +++++++++++++++++++++++++++++++++++++--
>  tools/lib/bpf/btf.h      |  15 +++
>  tools/lib/bpf/libbpf.map |   1 +
>  3 files changed, 225 insertions(+), 6 deletions(-)
>

[...]

> +static int btf_add_ref_type_ids(__u32 *id, void *ctx)
> +{
> +       struct btf_ref *ref =3D ctx;
> +       struct btf_type *t =3D btf_type_by_id(ref->pipe.src, *id);
> +       int ret;
> +
> +       /* split BTF id, not needed */
> +       if (*id > ref->nr_base_types)
> +               return 0;
> +       /* already added ? */
> +       if (ref->ids[*id] <=3D BTF_MAX_NR_TYPES)
> +               return 0;
> +       ref->ids[*id] =3D *id;
> +
> +       /* struct/union members not needed, except for anonymous structs
> +        * and unions, which we need since name won't help us determine
> +        * matches; so if a named struct/union, no need to recurse
> +        * into members.
> +        */
> +       if (btf_is_eligible_named_fwd(t))
> +               return 0;

Let's be a bit more robust here. There are three cases for BTF types
(kinds) in "base reference BTF": forward-declared (non-anonymous
structs/unions/enums), copied-as-is (anonymous
struct/union/enum/func_proto, plus INT/FLOAT; maybe something else),
but also there is a third kind that shouldn't be referenced from split
BTF (datasec, funcs, vars, etc). I'd like us to be strict in checking
that we don't accidentally and silently support the latter. It should
mean a misuse of this approach and we should error out in this case.

> +
> +       /* ensure references in type are added also. */
> +       ret =3D btf_type_visit_type_ids(t, btf_add_ref_type_ids, ctx);
> +       if (ret < 0)
> +               return ret;
> +       return 0;
> +}
> +
> +/* All split BTF ids will be shifted downwards since there are less base=
 BTF
> + * in reference base BTF, and for those that refer to base BTF, we use t=
he
> + * reference map to map from original base BTF to reference base BTF id.
> + */
> +static int btf_update_ref_type_ids(__u32 *id, void *ctx)
> +{
> +       struct btf_ref *ref =3D ctx;
> +
> +       if (*id >=3D ref->nr_base_types)
> +               *id -=3D ref->diff_id;
> +       else
> +               *id =3D ref->ids[*id];
> +       return 0;
> +}
> +
> +/* Create updated split BTF with "reference" base BTF; reference base BT=
F
> + * consists of BTF information required to clarify the types that split
> + * BTF refers to, omitting unneeded details.  Specifically it will conta=
in
> + * base types and forward declarations of structs, unions and enumerated
> + * types, along with associated reference types like pointers, arrays et=
c.
> + *
> + * The only case where structs, unions or enumerated types are fully rep=
resented
> + * is when they are anonymous; in such cases, info about type content is=
 needed
> + * to clarify type references.
> + *
> + * We return newly-created split BTF where the split BTf refers to a new=
ly-created
> + * base reference BTF. Both must be freed separately by the caller.
> + *
> + * When creating the BTF representation for a module and provided with t=
he
> + * base_ref option, pahole will create split BTF using this API, and sto=
re
> + * the base reference BTF in the .BTF.base.reference section.
> + */
> +struct btf *btf__new_split_base_ref(struct btf *src_btf)

I find this name very confusing, for some reason. btf__new*/btf__parse
is generally used to either create a new empty instance, or just
parse/index pre-existing BTF information. In this case I feel like
it's actually a different operation, where we create a derived BTF, so
I'd name it distinctively. How do you feel about something with
"distill" terminology as an action performed here. E.g.,
btf__distill_base() or something like that?

The API contract is also suboptimal, given back split BTF where base
BTF is owned (and has to be freed). Let's keep it a bit more explicit,
something like:

int btf__distill_base(struct btf *new_base_btf, struct btf *new_split_btf);

WDYT?

> +{
> +       unsigned int n =3D btf__type_cnt(src_btf);
> +       const struct btf_type *t;
> +       struct btf_ref ref =3D {};
> +       struct btf *base_btf =3D NULL, *split_btf =3D NULL;
> +       __u32 i, id =3D 0;
> +       int ret =3D 0;
> +
> +       /* src BTF must be split BTF. */
> +       if (!btf__base_btf(src_btf)) {
> +               errno =3D -EINVAL;
> +               return NULL;
> +       }
> +       base_btf =3D btf__new_empty();

I was confused, it's baseref_btf or something, we already have
"base_btf", which is coming from btf__base_btf(src_btf), so let's
distinguish all those "base" BTFs?

> +       if (!base_btf)
> +               return NULL;
> +       ref.ids =3D calloc(n, sizeof(*ref.ids));
> +       if (!ref.ids) {
> +               ret =3D -ENOMEM;
> +               goto err_out;
> +       }
> +       for (i =3D 1; i < n; i++)
> +               ref.ids[i] =3D BTF_UNPROCESSED_ID;

by now we generally expect BTF IDs to be a positive integer, so I'd
use int for ids and just use explicit -1, and then a bit more natural
check for >=3D 0 in btf_add_ref_type_ids

> +       ref.pipe.src =3D src_btf;
> +       ref.pipe.dst =3D base_btf;
> +       ref.pipe.str_off_map =3D hashmap__new(btf_dedup_identity_hash_fn,=
 btf_dedup_equal_fn, NULL);
> +       if (IS_ERR(ref.pipe.str_off_map)) {
> +               ret =3D -ENOMEM;
> +               goto err_out;
> +       }

[...]

> +                       default:
> +                               pr_warn("unexpected kind [%u] when creati=
ng base reference BTF.\n",
> +                                       btf_kind(t));
> +                               goto err_out;
> +                       }
> +                       ret =3D btf__add_fwd(base_btf, btf__name_by_offse=
t(src_btf, t->name_off),
> +                                          fwd_kind);
> +               } else {
> +                       ret =3D btf_add_type(&ref.pipe, t);

see comment above, we should detect erroneous uses of referencing
"non-relocatable" kinds like VAR/DATASEC

> +               }
> +               if (ret < 0)
> +                       goto err_out;
> +               ref.ids[i] =3D ++id;
> +       }
> +       /* now create new split BTF with reference base BTF as its base; =
we end up with
> +        * split BTF that has base BTF that represents enough about its b=
ase references
> +        * to allow it to be reconciled with the base BTF available.
> +        */
> +       split_btf =3D btf__new_empty_split(base_btf);
> +       if (!split_btf)
> +               goto err_out;
> +
> +       ref.pipe.dst =3D split_btf;
> +       /* all split BTF ids will be shifted downwards since there are le=
ss base BTF ids
> +        * in reference base BTF.
> +        */
> +       ref.diff_id =3D ref.nr_base_types - btf__type_cnt(base_btf);
> +
> +       /* First add all split types */
> +       for (i =3D src_btf->start_id; i < n; i++) {
> +               t =3D btf_type_by_id(src_btf, i);
> +               ret =3D btf_add_type(&ref.pipe, t);
> +               if (ret < 0)
> +                       goto err_out;
> +       }
> +       /* Now update base/split BTF ids. */
> +       for (i =3D 1; i < btf__type_cnt(split_btf); i++) {

nit: cache this btf__type_cnt() result, no need to keep calling it all the =
time

> +               t =3D btf_type_by_id(split_btf, i);
> +
> +               ret =3D btf_type_visit_type_ids((struct btf_type *)t,  bt=
f_update_ref_type_ids, &ref);

nit: it's a bit annoying to cast t here, given btf_type_by_id()
returns non-const type as you need it. Just mark t as non-const and
use btf_type_by_id() everywhere?



> +               if (ret < 0)
> +                       goto err_out;
> +       }
> +       free(ref.ids);
> +       hashmap__free(ref.pipe.str_off_map);
> +       return split_btf;

[...]
