Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D22EF507
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 00:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785197774; cv=pass; b=Ap0sfdPkzYyvGi7UJYXvONFYgq95PGG2iZO+3FF/vjwrlhwUdNkZxb1kPN1eMPPDZM12gQwU3M5JDziGM3dVuTLA5eIcYBmnGDFa5LdeaQMn63h9G5nUKMUoeJrshiiltLda34xJI+Vbimiv+5lD3/3/wJ97OXtzB7aqafxUmFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785197774; c=relaxed/simple;
	bh=OPu1jj4LH496RB6yNAmXtndHYPm9Xz1mG8QeRUqkG/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4v6Rgj3pGsNV5KK5OoajuHovtGpl4A/sCxG869bHEKcM2MCRy2fCyw7T/znX7mM9joYw081ISluZv6orx7ZeHH5nS9NP65s7exFb+X37CpTho4JqHdTOVJLSnTVa5kfQhTiR0nTpyFEWzDEn6KixUOv/Uyn/qyfKu0duAuyB9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rrD67ZVp; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rrD67ZVp"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84a652535dcso2010280b3a.3
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 17:16:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785197773; cv=none;
        d=google.com; s=arc-20260327;
        b=BNx+QBMJ7umzqDAAB91LwF2ArXNuFfFMQiCUXk4wj+BLZUV7wYNeIXFphv9/rGbJ5/
         n+ArDTG6vQ+XsMIRWCENxK0CNGQIhUTS5ACdaIblWgBNUaV1/B5ELkfuxFZ6srpVLQ+0
         Iew3hO+74wXUrjQWm1KuzPE/TLzbtV79IVQehMQe+uMh4HEpZe8/qjf/qUu7zrYfbSb8
         lvS7Wo5mWCCmqe0A3npvytHBuA6vv3QG4L9yprZSU2QM/oAUyuxeLYelL7Ee/EUjnF8c
         5XHFqBFm6pEsVMa0AMktuEaLK+T8kIpU4JQp72qG+bUjrU62QLwKaHXDtKB6fTxqTqXY
         2Ogw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cRCUSaQuCFO40hxAqe3Dt0s7qWWyhF8IkCY02drnYGc=;
        fh=+QC29UjC2J+GJN3V1xCqyq3vUDVqtmteUbv12xBmqXM=;
        b=YyY4eek7Hm7pwdTZ31tx3tKvYn5ooB11QyEEHmh7lkLRFY3lGkut1emYGQGlctB+A8
         KUVn6O11y4fFr+Ept80opLHjP1G06Vn/SQlWJIq6hI6q9A275jipZ8gYtuAjwKD6eIZW
         /fRJIugfLNpYRvnViZIB4eBv5Or0lo6k6pKt46QgT6gcZRLhOhT4tiXZstFM2QOci+yp
         JRb4y9DTT0yT0it77z428+2zAy+Jjif0mcNiTyXgZBgUDVIEhLEVw2s7XkqMJk2SJumu
         3FeNmV0/tEl/PmLTKudG2tWP4wUltf/zaCja92rynTLJEJqYnI0D05L8uhyaXUQpwYri
         62LQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785197773; x=1785802573; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cRCUSaQuCFO40hxAqe3Dt0s7qWWyhF8IkCY02drnYGc=;
        b=rrD67ZVpZ2u+R+kw5hX4QkFxQ8D7C2o74r9u5p1dgG3c+QsLNVOYaiajOcwt93UX5a
         9RLFLiGDB3eVd9OI1geFzJR4DaRluoQEHAJUuJ5xS4pafuUn/K+3k5tREIsNRx4duZ8X
         vDmM8E87UAVy4Ta/3b3LPsP2a4V3qlsFGcjstJWEisFOGOKqmA5YRIxi+4mQKS6yBKzZ
         kAAbjeMVDSI7YP5U6SzEhOmriyyTZafhNAjQqI8lQ/+3+fenKnI5b9wUBsI7Iaw2SEbF
         FlHlBbCBKTBIEWPF9+w/qACN2yRlx6inBzSEM/6/AQH3Y8QRyYM7ElyMpf0p8j/3oGP8
         c8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785197773; x=1785802573;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cRCUSaQuCFO40hxAqe3Dt0s7qWWyhF8IkCY02drnYGc=;
        b=Lzv+TQZ+br/zVo5FyRPxwqBdqKZESDsEQLzPxz9nNIaa9xl/FFPFrvituVvAUCTKOO
         lI03Gj2QIcdrvELZ9Cs/HC1EYW0pIAcEpC5baVLzgCJRr+nsdVIgcrZuqREfaxmdYsON
         gtut+pJsrUN8+uTdv/pY+JJGSl96jQaKHZTcziziIqpwuMsYjAfelP/4G4tQfwCii8ez
         IHVezeBG4LaWoFzOQA8bDNbvdk6mq2tQMW7FhrBd0zNPAkW4RFqmKUE2mie/4UATbKBY
         UpZmta9Od3EwXu9PI12++qqLnN+0VXdGl7rxi13RHtCvIxNCsgPkc++eXe7sWd3o88aB
         iwCg==
X-Gm-Message-State: AOJu0YzV/EyyOJg4oTiO+LV328AEpViKxziynUskehmdiknuD5euym1X
	URPIEemD6u9BSunyjj02D4WtkB4JA8HKT8uOBrRzdlzBoD5bSIc8ZHNPWImZScN/JfXJmfDc57O
	poIiKUxV0K6BVU5Ye9BU+HxH7Hby0+l493H2H0Q8=
X-Gm-Gg: AR+sD12pB2nVfxgxUkhDf5WwebtnBJTNrgSjUfqfGFtlcjpZyPENr4mgksMO35kkgKE
	Ou355DixGePwV+wlzbt4mV8IOQw4brjNnwonOFNkAaU21YJ9+qP25DoOR4rzLPSKr9sszEyJgPh
	DBs6euZritp5iQcTOgzqFbbpNlzsDkPDhE84rroHSIVWrTnWU3ma0NE/asXIbhh8tIpuusaOqvn
	XHjxiq4PPEb4GBIt88Wzp4Aq38Dtic2mhGvcVRi2iZLA+2M+/V0oM6lDWilKPO9y7pTjjaQsKkz
	sOj2zNYi2PmVYWtN1mNAVmNc856LSF63zuf5K26L+2DiiVUrm+P0TSMcsg==
X-Received: by 2002:a05:6a00:ace:b0:847:86b0:888c with SMTP id
 d2e1a72fcca58-84e932eb87bmr78649b3a.48.1785197772833; Mon, 27 Jul 2026
 17:16:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178478913040.2.14225985431891987705@digiscrypt.com>
In-Reply-To: <178478913040.2.14225985431891987705@digiscrypt.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Jul 2026 17:15:58 -0700
X-Gm-Features: AUfX_mzTyzilfuSXShWJIHugLuRSBwgEnUJ_XMwXagN1X9AA1d8lZBtmHGE6jF4
Message-ID: <CAEf4BzZAebRDpruMitXanyavq+kJs_nG-2Bypg0eJgSP3q12EA@mail.gmail.com>
Subject: Re: [PATCH] libbpf: bounds-check struct_ops member offset before
 writing shadow pointer
To: Naveed Khan <naveed@digiscrypt.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 11:49=E2=80=AFPM Naveed Khan <naveed@digiscrypt.com=
> wrote:
>
> bpf_object__collect_st_ops_relos() replaces each function pointer in a
> struct_ops value with a pointer to the corresponding struct bpf_program
> in the map's shadow data:
>
>         *((struct bpf_program **)(st_ops->data + moff)) =3D prog;
>
> st_ops->data is allocated with malloc(type->size), so it is exactly
> map->def.value_size bytes long, and moff is the byte offset of the
> member being relocated. The only bound placed on moff comes from
> find_struct_ops_map_by_offset():
>
>         offset - map->sec_offset < map->def.value_size
>
> so moff can be as large as value_size - 1. The store above is
> sizeof(struct bpf_program *) bytes wide, and nothing checks that
> moff + sizeof(struct bpf_program *) stays within value_size.
>
> libbpf's BTF sanity check does not validate that a struct member's
> offset plus its size fits within the struct's declared size (see
> btf_validate_type()), and this relocation runs at bpf_object__open()
> time, before the kernel validates the struct_ops type. A crafted object
> with a struct_ops struct whose declared size is small (e.g. 1) but which
> contains a function-pointer member near the end of (or beyond) that size
> therefore makes libbpf write up to sizeof(void *) - 1 bytes past the heap
> allocation - a controlled heap out-of-bounds write reachable purely from
> opening an untrusted object file.
>
> Reject such relocations by requiring the whole pointer store to fit
> within the map value.
>
> Signed-off-by: Naveed Khan <naveed@digiscrypt.com>
> ---
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 1368752aa1..1aa2a1d098 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10529,6 +10529,17 @@ static int bpf_object__collect_st_ops_relos(stru=
ct bpf_object *obj,
>                         return -EINVAL;
>                 }
>
> +               /* the shadow pointer stored below is sizeof(struct bpf_p=
rogram *)
> +                * bytes wide, so the whole write must fit within st_ops-=
>data,
> +                * which is only map->def.value_size bytes long. A malfor=
med BTF
> +                * can place a member near the end of the value and overf=
low it.
> +                */
> +               if (moff + sizeof(struct bpf_program *) > map->def.value_=
size) {
> +                       pr_warn("struct_ops reloc %s: member %s at moff %=
u overflows map value size %u\n",
> +                               map->name, name, moff, map->def.value_siz=
e);
> +                       return -EINVAL;
> +               }
> +

libbpf doesn't not protect against maliciously crafted ELF, BTF, etc.
If you don't trust the source of the BPF object file and/or can't
tolerate process crashing, don't open an untrusted object file.

pw-bot: cr


>                 prog =3D find_prog_by_sec_insn(obj, shdr_idx, insn_idx);
>                 if (!prog) {
>                         pr_warn("struct_ops reloc %s: cannot find prog at=
 shdr_idx %u to relocate func ptr %s\n",
> --
> 2.52.0
>
