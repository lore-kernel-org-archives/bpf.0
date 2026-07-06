Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BD747ECDD
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783374223; cv=pass; b=ZQHvNsP0uc6NlFnErdiAEtWPRB453Lj3vKMN2PqEAABUDnIAY9S8McnjiR9ZflwtlCHTIdIaP39Sf8aaxnprtGTJZab1+Ys/iX6tSAZ5j3CjKWzkgRYA/TI5Vt09K/9v9s7vY52Hh9F4aJoIubKHMqB8faJEx4H6lfgTKAO9pOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783374223; c=relaxed/simple;
	bh=a/jl1rx8dOX/dC+MfPZ6CQEdkj0uDKTZ96LbQlnHLJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/xWAXFML1cnlDjrRzwecJj6ekC7zZUBmTKNQgo+d5r7BoHyuaqUcqnaxtzv9sYom+BWNzTJ3srx1wFcOkNuiRuVZ7i6Gm5pLsYUXAFFdv0+ErEG0/u4h/falDEPkfDJEu7KgZCNWSj2Hk5/S4dl9E0pe4FDyL4mUbkp2XNseug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRL7bYNT; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRL7bYNT"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66666bad8beso3819234d50.3
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 14:43:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783374221; cv=none;
        d=google.com; s=arc-20260327;
        b=J8DOwsmM0ghUGWGy612VYCD4Zae5x8p+FY1KxiZOw26wijPPLG0yWvraaqEbmBC6BL
         1lAomPbLisf7KECJj1BneEu1czjzS7YYCmXUmZvsBR5hm/K0VurgDfNp1f0Cg4BXCjIx
         GhtuwMpuC+cUxKCi/cmbGEWkZep1pWzrPrSzlAXvDqfIq5blmjc/pQKb9lusplMGIfCl
         +cY1CltS88e0s9kG4VEHrVXhWT9+o1tYrgac0u+qX+ujFf+akxi9+7AypMUwHs59zxal
         hWPniDEQ9r8Cuql57HifUP2khjhaZJZeh3r8IPvTD9uvlDN2/6eJOPwBDEbyKCdMZR+v
         3tjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YP0sLeGhPZWhSFAyWvIhO82/I9Xh3Du1fmVbsCCpN4c=;
        fh=sU6yZW4SFJwmaTjOAQ9Si84rOR+FhzNf66wPAJcVG3c=;
        b=J4oO5RnRJpFJ3ZjYghWNBIPXhy3sZx12/bcvOLbCZeI9meyUQjbZunASkvrNc9Dh1z
         NB8wichwrCfyPy9tNNbjIfqdcmtt7lxXO+ExU/5lFTHEBQJkbPannFiGI+mCwvnTJYmm
         B4PIHHLaQZ0ifi/37ADL7wc2OTijLZ3GP1vaPZ1TApYxs5JTfGRyzF9jt+eQGVdo297e
         DKiNpYFRpOxOXt9T1Al+iR7QSzp/ukj44XqN8QSNxtz30GJXhp7DJ3eFbLhe/y0Huihq
         u1Del/vCXmzU8YBEp5ola0UpMLHHQZ43+IbBvZhoUeS7dxQZpRX2q9CgnfXOdiyOBATB
         Mecg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783374221; x=1783979021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YP0sLeGhPZWhSFAyWvIhO82/I9Xh3Du1fmVbsCCpN4c=;
        b=VRL7bYNTbaYXaRXqMCqExxV57wQJ36m/o8PVpu9M+g2/W9MwZS/f3ZWwvjJb2N++Px
         vHvGbS1DNSIZ90whVbvcdrcUZvjjchWYXO3krJ8pPTq+lx4MhfuZ4Phjio5k5pIrF4m0
         DEDLrNJtUk65MCPFSgeqaM0Jdvt52tFz0P0itT157XBtkA8KEa18URtbH7n2FAxIrbyk
         d3cafosDOARjN+YhucMLRCPM2wMueZ/vsx6or68/h8F68tuKBi3WGqYy2O1OdiDwHoXv
         BMejJhcOzzq/ZzCOcjfOhxahi8sD/RMbo7558pUlSs+NYXdQWqvXG129HaubJBIf50D6
         /AXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783374221; x=1783979021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YP0sLeGhPZWhSFAyWvIhO82/I9Xh3Du1fmVbsCCpN4c=;
        b=ZJRI+lV3r7IBtKIrcO5B/0pKAb87PhuzVd97AP/greb3VT1PwgjVNDDrdi/NdapHRD
         A5/BGIt66Ipkulza5EGmgiKDHikkLsQYFCp42J4gTXzAABuyZXzfxvtw4HqlaPT2JO7x
         r2MEAN94zUD41wBS0dKu8/YawYrKZkWVTHOn3NLJ2oxA9KlE0L0h17ZphhRiik4hWYcB
         JzKcu5FhNeiAQToGlGu12QPiJBnSqqOuIwq97KG9+PT9olrCrzHY1ll3UErJr7H43PzZ
         sULwuxvYxVVIZxnhh9AR1dldBh7Z0lgNXVUQbvPTUBGOpPFBDQpewYezCXn0y2t3ZY0A
         kQew==
X-Forwarded-Encrypted: i=1; AHgh+RpHu6H/gx7/495zvW503ds12nnvpimdxJt7rHaF5wEKnbHctBhytrPNpaHMk1U0xATM4Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDy5ApCy23mliId0mbnsuCvSrdMWhGhAHIm6vQ3lEv7Qb4aiZz
	rshrRNZEePgoCe7HhLs0VdHk0+g0KUx6FhcQqxr4G6n7LJ6ioSmbm/GaBoJwA/PrnPVIwBxbRSg
	F944bSqss6k45chNuhbmmDzJqg/VWIhY=
X-Gm-Gg: AfdE7clzw/DbVxwWJMkJbxPWZlBFEsGSvUwxrlj73J6TwCBkJHZR3B7o83CKIcWsiP3
	ip5MptyzkpxKQxZUKi/BakZm2sYYOijODG/BEKTQ1yO+99X39PY7LToRDf8m65yfE9jMZKD/xys
	qSXjQl/jYzjDDEE7d9UMdJEESNcQPt7wqyEtc6yPLT8eQHsXZHmvZIbUWbgRT+fmvHeSTFTo2XV
	k5H5HrtlwgHHuCuQzJZEHtXvtXBWIclRBAcy4m4ayaq/E/67guouwsV6jBf56MgkRYvXgTq
X-Received: by 2002:a05:690e:4083:b0:65d:dca1:ff89 with SMTP id
 956f58d0204a3-6677fa0c67fmr1983136d50.12.1783374220502; Mon, 06 Jul 2026
 14:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782807039.git.chenyy23@mails.tsinghua.edu.cn> <4b8c8a81102ba4b595011434c881194f264ddc59.1782807039.git.chenyy23@mails.tsinghua.edu.cn>
In-Reply-To: <4b8c8a81102ba4b595011434c881194f264ddc59.1782807039.git.chenyy23@mails.tsinghua.edu.cn>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 6 Jul 2026 14:43:29 -0700
X-Gm-Features: AVVi8CfOQNFAb1sxakwFijfWdiCRi0fgYTYhaLAZZkqxxVqfdB86GvTgG1Ozw6E
Message-ID: <CAMB2axOJ7hAb+gtgNFFwL8uT5+KqWsRkPQkJfLL_rPQaS23oRg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Reject MEM_ALLOC BTF accesses past
 object bounds
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 1:45=E2=80=AFAM Yiyang Chen
<chenyy23@mails.tsinghua.edu.cn> wrote:
>
> BTF struct walks relax the struct-size check for accesses through a
> trailing flexible array. That is valid for ordinary BTF type walking, but
> PTR_TO_BTF_ID | MEM_ALLOC values point to objects allocated with the stat=
ic
> BTF type size.
>
> When walking a MEM_ALLOC object, reject the access before applying the
> flexible-array relaxation if the access range extends past the struct siz=
e.
> Apply the same policy to struct ID matching so kfunc and kptr type checks
> do not walk past the allocated object bounds either.
>
> Fixes: 958cf2e273f0 ("bpf: Introduce bpf_obj_new")
> Fixes: 36d8bdf75a93 ("bpf: Add alloc/xchg/direct_access support for local=
 percpu kptr")
> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

Reviewed-by: Amery Hung <ameryhung@gmail.com>

> ---
>  include/linux/bpf.h   |  2 +-
>  kernel/bpf/btf.c      | 17 +++++++++++------
>  kernel/bpf/verifier.c | 11 +++++++----
>  3 files changed, 19 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7719f6528..314d606dc 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3146,7 +3146,7 @@ int btf_struct_access(struct bpf_verifier_log *log,
>  bool btf_struct_ids_match(struct bpf_verifier_log *log,
>                           const struct btf *btf, u32 id, int off,
>                           const struct btf *need_btf, u32 need_type_id,
> -                         bool strict);
> +                         bool strict, bool walk_flex_arrays);
>
>  int btf_distill_func_proto(struct bpf_verifier_log *log,
>                            struct btf *btf,
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 64572f85e..dff5c0d91 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7108,7 +7108,7 @@ enum bpf_struct_walk_result {
>  static int btf_struct_walk(struct bpf_verifier_log *log, const struct bt=
f *btf,
>                            const struct btf_type *t, int off, int size,
>                            u32 *next_btf_id, enum bpf_type_flag *flag,
> -                          const char **field_name)
> +                          const char **field_name, bool walk_flex_arrays=
)
>  {
>         u32 i, moff, mtrue_end, msize =3D 0, total_nelems =3D 0;
>         const struct btf_type *mtype, *elem_type =3D NULL;
> @@ -7135,11 +7135,14 @@ static int btf_struct_walk(struct bpf_verifier_lo=
g *log, const struct btf *btf,
>                 *flag |=3D PTR_UNTRUSTED;
>
>         if (off + size > t->size) {
> +               struct btf_array *array_elem;
> +
> +               if (!walk_flex_arrays)
> +                       goto error;
> +
>                 /* If the last element is a variable size array, we may
>                  * need to relax the rule.
>                  */
> -               struct btf_array *array_elem;
> -
>                 if (vlen =3D=3D 0)
>                         goto error;
>
> @@ -7404,7 +7407,8 @@ int btf_struct_access(struct bpf_verifier_log *log,
>
>         t =3D btf_type_by_id(btf, id);
>         do {
> -               err =3D btf_struct_walk(log, btf, t, off, size, &id, &tmp=
_flag, field_name);
> +               err =3D btf_struct_walk(log, btf, t, off, size, &id, &tmp=
_flag,
> +                                     field_name, !type_is_alloc(reg->typ=
e));
>
>                 switch (err) {
>                 case WALK_PTR:
> @@ -7463,7 +7467,7 @@ bool btf_types_are_same(const struct btf *btf1, u32=
 id1,
>  bool btf_struct_ids_match(struct bpf_verifier_log *log,
>                           const struct btf *btf, u32 id, int off,
>                           const struct btf *need_btf, u32 need_type_id,
> -                         bool strict)
> +                         bool strict, bool walk_flex_arrays)
>  {
>         const struct btf_type *type;
>         enum bpf_type_flag flag =3D 0;
> @@ -7482,7 +7486,8 @@ bool btf_struct_ids_match(struct bpf_verifier_log *=
log,
>         type =3D btf_type_by_id(btf, id);
>         if (!type)
>                 return false;
> -       err =3D btf_struct_walk(log, btf, type, off, 1, &id, &flag, NULL)=
;
> +       err =3D btf_struct_walk(log, btf, type, off, 1, &id, &flag, NULL,
> +                             walk_flex_arrays);
>         if (err !=3D WALK_STRUCT)
>                 return false;
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 25aea4271..4d3bb7156 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4379,7 +4379,8 @@ static int map_kptr_match_type(struct bpf_verifier_=
env *env,
>          */
>         if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->=
var_off.value,
>                                   kptr_field->kptr.btf, kptr_field->kptr.=
btf_id,
> -                                 kptr_field->type !=3D BPF_KPTR_UNREF))
> +                                 kptr_field->type !=3D BPF_KPTR_UNREF,
> +                                 !type_is_alloc(reg->type)))
>                 goto bad_type;
>         return 0;
>  bad_type:
> @@ -7970,7 +7971,7 @@ static int check_reg_type(struct bpf_verifier_env *=
env, struct bpf_reg_state *re
>
>                         if (!btf_struct_ids_match(&env->log, reg->btf, re=
g->btf_id,
>                                                   reg->var_off.value, btf=
_vmlinux, *arg_btf_id,
> -                                                 strict_type_match)) {
> +                                                 strict_type_match, !typ=
e_is_alloc(reg->type))) {
>                                 verbose(env, "%s is of type %s but %s is =
expected\n",
>                                         reg_arg_name(env, argno),
>                                         btf_type_name(reg->btf, reg->btf_=
id),
> @@ -11429,7 +11430,8 @@ static int process_kf_arg_ptr_to_btf_id(struct bp=
f_verifier_env *env,
>         reg_ref_t =3D btf_type_skip_modifiers(reg_btf, reg_ref_id, &reg_r=
ef_id);
>         reg_ref_tname =3D btf_name_by_offset(reg_btf, reg_ref_t->name_off=
);
>         struct_same =3D btf_struct_ids_match(&env->log, reg_btf, reg_ref_=
id, reg->var_off.value,
> -                                          meta->btf, ref_id, strict_type=
_match);
> +                                          meta->btf, ref_id, strict_type=
_match,
> +                                          !type_is_alloc(reg->type));
>         /* If kfunc is accepting a projection type (ie. __sk_buff), it ca=
nnot
>          * actually use it -- it must cast to the underlying type. So we =
allow
>          * caller to pass in the underlying type.
> @@ -11876,7 +11878,8 @@ __process_kf_arg_ptr_to_graph_node(struct bpf_ver=
ifier_env *env,
>         et =3D btf_type_by_id(field->graph_root.btf, field->graph_root.va=
lue_btf_id);
>         t =3D btf_type_by_id(reg->btf, reg->btf_id);
>         if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, 0, fi=
eld->graph_root.btf,
> -                                 field->graph_root.value_btf_id, true)) =
{
> +                                 field->graph_root.value_btf_id, true,
> +                                 !type_is_alloc(reg->type))) {
>                 verbose(env, "operation on %s expects arg#1 %s at offset=
=3D%d "
>                         "in struct %s, but arg is at offset=3D%d in struc=
t %s\n",
>                         btf_field_type_name(head_field_type),
> --
> 2.34.1
>
>
