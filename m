Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33E75660
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 22:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710283647; cv=none; b=BnNoM5TmfyXS/vkC3SrqUeWNzUhz6TDTjCQfQ6X77O5RIbWrrn39nA4mYTNAihX2cF2AObRLYYd2UwaGKgi3AldGu8JFN9ux/HHZYw1LZwd7zC1c+BH2rVBODMwY8Zs0K36sSOtfcVgXB6yRALnqak6XZtiGHKQhwzLg4Ed1hOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710283647; c=relaxed/simple;
	bh=2g2+Q+L2gaRtkoCRtQH2QwlBMeT9rAwTE73WZj8Lx6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCrq/WAh6Gq87kNhi23j8EszcWGCIKedikUxqbMtVxil4IQjE+ceMblG3XPzOC3hZZs6FZlfW15qhJgXFO1Dl+x5RuiVG9qPIlMXYwUKgb8qvhnGdOhFCSUDzCR70S15uYtEpFzf22pc7td+YxEn3l0c+fqavTAdSeCV77R67lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMUmExvj; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMUmExvj"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29c07bbcd1fso243874a91.1
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 15:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710283645; x=1710888445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+68OcMSnc9wBZLvy2JtEdy0x1ISkL44PdOtC/5ACMQ=;
        b=WMUmExvj2W0zGBu4MHTVfvJsuDEv+hIUxU7H3X2O0yG8pJ5dBoos2+EbVSnSRCnGiq
         DnPvOta/5Y88adAnueJv2BsTm8zen7bYwBHuEpOW7H4lwmR1qXMOwSQZo8Wjg8ooR357
         17OmzguaAhVwPBAJ9ElUYHsn58KctNxxpV+9u3dKVqOxjkNdtLumFZWZS12GHxsdcvCP
         gz4k3G4ztRSCOpxikTmb1z3hnMwXdoZcq6FBzCybyYao/UFoDb2M3RGRdYzD/xDiqMdi
         YTHcyY6Os721U2TkM2Vx01IvP/BOV6Wc/OHl+H560NdEBI9qkRAFQPuWtvP1foBLksDZ
         7U5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710283645; x=1710888445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+68OcMSnc9wBZLvy2JtEdy0x1ISkL44PdOtC/5ACMQ=;
        b=fEXiXtqTu9FWV9Q8caGgCsAz2Kmpc3k7vq9oFDEN3OsYfjcu59GXZq9zHXkwzcSuL2
         NJOvmDbySs3ESYL3ArVOVjIbcIerJAE+eW8fRqHCPQ2dcVa3DvxoM4TT4Blh6CT5dEKJ
         kuL4rdO3jFUbq2IxdF3YZw0jYfmZ3v1BUC+aGyBu/I7rfqSR6kyLoUd7ShBw3rrXj4da
         PV4IcnVct2ehVtys8TdZsoUSiMgMZD/XEWs4v/x9tnnsLsRR4vUsWBpJcW9j7Ljo1otk
         dQNbFIuUH1hU0A1QIWh8KzzS7so3ycFDrm83dlXnOiXiY5otp13MLORIt9mwU4ryvbNa
         VWgg==
X-Gm-Message-State: AOJu0YwB3Hu0n63NcYFzRIbJomeRfNp0JSVLkuVWImQxIz8RIkb343Xy
	24FREu36mbTrtb862rbgOgWYIDWPaHdypzQz5uyYFX06byOGSd/T1rbyhTLh3yyFljUulAWy21/
	AJQj+huaC9GIe6GhswkuaN/dTsRhxbERQLt4=
X-Google-Smtp-Source: AGHT+IGgWlz+Srww51cjggQw/+9MTx2GwkY1U9JZTFvbwOxpEYCIXaYUxOxtLVIyJMkMcHua23kGwbsjncUQLHKCnvs=
X-Received: by 2002:a17:90a:1344:b0:29c:67:115a with SMTP id
 y4-20020a17090a134400b0029c0067115amr1796103pjf.42.1710283645267; Tue, 12 Mar
 2024 15:47:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312013726.1780720-1-thinker.li@gmail.com>
In-Reply-To: <20240312013726.1780720-1-thinker.li@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 12 Mar 2024 15:47:13 -0700
Message-ID: <CAEf4BzZafCA3gQVgmL1-OnpcWPXNJZ8iXgdaH82gAvu5TEOVEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: cast pointers for shadow types explicitly.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, sinquersw@gmail.com, 
	kuifeng@meta.com, yhs@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 6:38=E2=80=AFPM Kui-Feng Lee <thinker.li@gmail.com>=
 wrote:
>
> According to a report, skeletons fail to assign shadow pointers when bein=
g
> compiled with C++ programs. Unlike C doing implicit casting for void
> pointers, C++ requires an explicit casting.
>
> To support C++, we do explicit casting for each shadow pointer.
>
> Cc: yhs@meta.com
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  tools/bpf/bpftool/gen.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 4fa4ade1ce74..dedafea0c127 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -1131,7 +1131,7 @@ static void gen_st_ops_shadow_init(struct btf *btf,=
 struct bpf_object *obj)
>                         continue;
>                 codegen("\
>                         \n\
> -                               obj->struct_ops.%1$s =3D bpf_map__initial=
_value(obj->maps.%1$s, NULL);\n\
> +                               obj->struct_ops.%1$s =3D (typeof(obj->str=
uct_ops.%1$s))bpf_map__initial_value(obj->maps.%1$s, NULL);\n\

Given we have a named struct type for this and we use explicit type
names in other parts of generated skeleton code, let's maybe use
"struct %s__%s__%s" explicitly here (passing in obj_name, ident,
type_name)?

No strong preferences, but feels like a consistent approach here would be n=
ice.

>                         \n\
>                         ", ident);
>         }
> --
> 2.34.1
>
