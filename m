Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59292433C0
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709669047; cv=none; b=fRO2nqPBwbfinwU6lgNLdnc1OdHBOTspQNE0RyZ0wbHO+itiEzjxpSxSyrVKG1Vl0X5cmu6X4BXIvK4NDqdG1TcDwt6DstNFATBXVOUdLRka56dqYbiDZrjxJ9k/4NdLZrrSAIUu1cs0OgfvVoL1NF1iGI0c4dLSv0kqPLRZcuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709669047; c=relaxed/simple;
	bh=uskHtd/Y7BoayJ4AlwAZNQlkOE8PK+G+/VsyI+WEjTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7iBIAUTmfrZklnhRh6Co0Na+tAT3+NudFUSqjW59EdnDA/6EJqUjv2BI5JC3muo+JpIwq+WTPKYp5U2Ql29mpU6WBs6eEW2tygeKaqFRw2ka9nh2CAaq2DLjmCCOzg/GGxA/HsI+02nu1XPG9W1/gBmoLhAqZeakoMilkdUBwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROgVLDLj; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROgVLDLj"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so833675a12.0
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 12:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709669045; x=1710273845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUHOQTPmGOt1JMgO4qJIfyzX7gms9e3BFKpuWKyaITY=;
        b=ROgVLDLj9Emp0ymd/05OjScax8eUFHVH1VnkOF+vYaL0FZndnYdLFsFmz2WPJ2UYX0
         nc0EB3rDullGwU9fFaN7Dco6HZyNdDRKBUjwicvOo7ewh8ny1rYBmJZLiaoNZNY7awEd
         PQafDTHL3L/Ep6FXZKxDD9OEyU6bVShSMc0/TBrdcAdSNHNI9j4IZYVKUl0tl5gZSr3R
         zYc5mZEuJgY0+BBv8oa7c+K2VEH/KcNNWzH8v0AL0Zg2EB61AGkNjtfrPo3x369r/xYS
         9q3zoLBm84qk7Do8foJ8XMjqqxghrVaRCLEX5DxNFJwyVH1AzGnHkGpF6NKmMlVf52j9
         aMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709669045; x=1710273845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUHOQTPmGOt1JMgO4qJIfyzX7gms9e3BFKpuWKyaITY=;
        b=C/Kv67K/KDaClSGgtI855cciEpu7CXNs0yeVGTesyGPU4utA4uQyPkZZdd7PZxKT2m
         jTHTVYESfCtAGnv+1BmcPtt7TgUNpiP6ulI+IR2FTvN/p+eeaL7Dt8iyf90JhRmpiRiz
         0tHRMSARQZqI+xydpa3YS009AbHvzCNFJ2kjsgNxgzCpkQv3Eqtj5Vr6v3u4C4iRGyt1
         0xHB4YD/8Wp2mUeK44P3bxNlzK5icv7ZUKMtJAktsAno4IpXN4UbZs0gcGHizCxM+d3o
         n1kSVKl1vk1kGxbHyJx3SsR+o3ZCuaI2KCVfecFDd/LV+QHNqh1UmyJC1wOxdKdNyzSI
         XHlw==
X-Gm-Message-State: AOJu0Yze0uGAK8eFh8jVrk+IZhzHy1diLZHOdtHfRhYcEFa5qrs0Z6JR
	Ssd43IFJxH05AvHsEdk/q+KGAdVcyA/8GZszmWpUNx9T2GzUZwQflTf6Uqxy0VXURAQYV21FLVd
	EgqVkmRehXU5aUD23lnBK/PQQ5Pk=
X-Google-Smtp-Source: AGHT+IG32UcLRUJ1MwKpnp2olwfUP53wezq4JRM7fK7vXPmM4g44myGm8rswzdRPsFO3LhDRbOzE2BjCLz56nXT4Q4o=
X-Received: by 2002:a17:90a:f189:b0:299:fea4:1ebf with SMTP id
 bv9-20020a17090af18900b00299fea41ebfmr10070317pjb.37.1709669045476; Tue, 05
 Mar 2024 12:04:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304225156.24765-1-eddyz87@gmail.com> <20240304225156.24765-13-eddyz87@gmail.com>
In-Reply-To: <20240304225156.24765-13-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 5 Mar 2024 12:03:53 -0800
Message-ID: <CAEf4Bzaso6bnWfks2sTxyK+BTid+Aj+vq64PCMAZW6=kQT+D-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 12/15] libbpf: rewrite btf datasec names
 starting from '?'
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, void@manifault.com, sinquersw@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 2:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> Optional struct_ops maps are defined using question mark at the start
> of the section name, e.g.:
>
>     SEC("?.struct_ops")
>     struct test_ops optional_map =3D { ... };
>
> This commit teaches libbpf to detect if kernel allows '?' prefix
> in datasec names, and if it doesn't then to rewrite such names
> by removing '?' prefix and adding ".optional" suffix.
> For example:
>
>     DATASEC ?.struct_ops -> DATASEC .struct_ops.optional
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/lib/bpf/features.c        | 22 ++++++++++++++++++++++
>  tools/lib/bpf/libbpf.c          | 30 +++++++++++++++++++++++++++++-
>  tools/lib/bpf/libbpf_internal.h |  2 ++
>  3 files changed, 53 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index 6b0738ad7063..4e783cc7fc4b 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -147,6 +147,25 @@ static int probe_kern_btf_datasec(int token_fd)
>                                              strs, sizeof(strs), token_fd=
));
>  }
>
> +static int probe_kern_btf_qmark_datasec(int token_fd)
> +{
> +       static const char strs[] =3D "\0x\0?.data";
> +       /* static int a; */
> +       __u32 types[] =3D {
> +               /* int */
> +               BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
> +               /* VAR x */                                     /* [2] */
> +               BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), 1),
> +               BTF_VAR_STATIC,
> +               /* DATASEC ?.data */                            /* [3] */
> +               BTF_TYPE_ENC(3, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
> +               BTF_VAR_SECINFO_ENC(2, 0, 4),
> +       };
> +
> +       return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types)=
,
> +                                            strs, sizeof(strs), token_fd=
));
> +}
> +
>  static int probe_kern_btf_float(int token_fd)
>  {
>         static const char strs[] =3D "\0float";
> @@ -534,6 +553,9 @@ static struct kern_feature_desc {
>         [FEAT_ARG_CTX_TAG] =3D {
>                 "kernel-side __arg_ctx tag", probe_kern_arg_ctx_tag,
>         },
> +       [FEAT_BTF_QMARK_DATASEC] =3D {
> +               "BTF DATASEC names starting from '?'", probe_kern_btf_qma=
rk_datasec,
> +       },
>  };
>
>  bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_=
id feat_id)
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index c0212244bdf7..cf60291db8fd 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2874,6 +2874,11 @@ static bool section_have_execinstr(struct bpf_obje=
ct *obj, int idx)
>         return sh->sh_flags & SHF_EXECINSTR;
>  }
>
> +static bool starts_with_qmark(const char *s)
> +{
> +       return s && s[0] =3D=3D '?';
> +}
> +
>  static bool btf_needs_sanitization(struct bpf_object *obj)
>  {
>         bool has_func_global =3D kernel_supports(obj, FEAT_BTF_GLOBAL_FUN=
C);
> @@ -2883,9 +2888,10 @@ static bool btf_needs_sanitization(struct bpf_obje=
ct *obj)
>         bool has_decl_tag =3D kernel_supports(obj, FEAT_BTF_DECL_TAG);
>         bool has_type_tag =3D kernel_supports(obj, FEAT_BTF_TYPE_TAG);
>         bool has_enum64 =3D kernel_supports(obj, FEAT_BTF_ENUM64);
> +       bool has_qmark_datasec =3D kernel_supports(obj, FEAT_BTF_QMARK_DA=
TASEC);
>
>         return !has_func || !has_datasec || !has_func_global || !has_floa=
t ||
> -              !has_decl_tag || !has_type_tag || !has_enum64;
> +              !has_decl_tag || !has_type_tag || !has_enum64 || !has_qmar=
k_datasec;
>  }
>
>  static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *=
btf)
> @@ -2897,6 +2903,7 @@ static int bpf_object__sanitize_btf(struct bpf_obje=
ct *obj, struct btf *btf)
>         bool has_decl_tag =3D kernel_supports(obj, FEAT_BTF_DECL_TAG);
>         bool has_type_tag =3D kernel_supports(obj, FEAT_BTF_TYPE_TAG);
>         bool has_enum64 =3D kernel_supports(obj, FEAT_BTF_ENUM64);
> +       bool has_qmark_datasec =3D kernel_supports(obj, FEAT_BTF_QMARK_DA=
TASEC);
>         int enum64_placeholder_id =3D 0;
>         struct btf_type *t;
>         int i, j, vlen;
> @@ -2922,6 +2929,8 @@ static int bpf_object__sanitize_btf(struct bpf_obje=
ct *obj, struct btf *btf)
>                         char *name;
>
>                         name =3D (char *)btf__name_by_offset(btf, t->name=
_off);
> +                       if (*name =3D=3D '?')
> +                               *name++ =3D '_';
>                         while (*name) {
>                                 if (*name =3D=3D '.')

let's just extend this to `if (*name =3D=3D '.' || *name =3D=3D '?')` ?

>                                         *name =3D '_';
> @@ -2938,6 +2947,25 @@ static int bpf_object__sanitize_btf(struct bpf_obj=
ect *obj, struct btf *btf)
>                                 vt =3D (void *)btf__type_by_id(btf, v->ty=
pe);
>                                 m->name_off =3D vt->name_off;
>                         }
> +               } else if (!has_qmark_datasec && btf_is_datasec(t) &&
> +                          starts_with_qmark(btf__name_by_offset(btf, t->=
name_off))) {
> +                       /* remove '?' prefix and add '.optional' suffix f=
or
> +                        * DATASEC names staring from '?':
> +                        *
> +                        *   DATASEC ?.foo -> DATASEC .foo.optional
> +                        */
> +                       const char *name;
> +                       char buf[256];
> +                       int str;
> +
> +                       name =3D btf__name_by_offset(btf, t->name_off);
> +                       snprintf(buf, sizeof(buf), "%s.optional", &name[1=
] /* skip '?' */);
> +                       str =3D btf__add_str(btf, buf);
> +                       if (str < 0)
> +                               return str;
> +
> +                       t =3D (struct btf_type *)btf__type_by_id(btf, i);
> +                       t->name_off =3D str;

let's keep it simpler, just do in-place name sanitization like we did
for !has_datasec case? It's fine if "?.struct_ops" becomes
"_.struct_ops", kernel doesn't care and doesn't assign any special
meaning to DATASEC names

>                 } else if (!has_func && btf_is_func_proto(t)) {
>                         /* replace FUNC_PROTO with ENUM */
>                         vlen =3D btf_vlen(t);
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index ad936ac5e639..864b36177424 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -374,6 +374,8 @@ enum kern_feature_id {
>         FEAT_UPROBE_MULTI_LINK,
>         /* Kernel supports arg:ctx tag (__arg_ctx) for global subprogs na=
tively */
>         FEAT_ARG_CTX_TAG,
> +       /* Kernel supports '?' at the front of datasec names */
> +       FEAT_BTF_QMARK_DATASEC,
>         __FEAT_CNT,
>  };
>
> --
> 2.43.0
>
