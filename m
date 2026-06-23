Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AF8370D71
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 22:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782254761; cv=pass; b=AmdlpkjMllWccg9Mn8jNaorj0lPWoQLMpX91ZwnmrgEaNJVTxwpVPClJ7dCacC17R/lpuzidyQhPcOTlIH9TKHIaVAFqgW5v1WE/RaAD+c2z4cVNYRsnCX7cZd3q39gYFtzFIm0G3/qYnn3FnIkd/RkIqTvHKZzLLvVXOU0AQvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782254761; c=relaxed/simple;
	bh=Z6NTdCIJZ1DmGGq9Tvl3c3bGMH1qcZhg1rY2c+290yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RpaJ9KfCSB1WYzPzbntHEA78jmv4Vtqq2sK+k/anmscoT3kh1OfSjrlQXqKqvuPCMjkbQpFl94b8koPPUrMM65CN4HkTKpV9TZmwUDxGM7spS5OA0+5q9KZZkQccuWkNBYHcSZYx3zIVZUYpaDwCzZUsPD/zPEKX66KYI4ORX2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gj34D3S3; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gj34D3S3"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c6bb8a5980so1935635ad.2
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 15:46:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782254759; cv=none;
        d=google.com; s=arc-20240605;
        b=cHRC3cDyOku0bHnQ3oj5z5dd4ZespT8g5Pjjiz89G+MCBGo63FTAgP0UItZJ+ArH64
         mvELfM46Yq6ikKF6iXsMh1NgOuAkdhj28WlHciBAAtDRY2qrS3FIABDBvxsPA4KhnvGq
         L3jr+Bnb5gKNIHOAvv5FgLnU17KC7EnTeikHdSEe8M8OUxB9zFCUWSXik5cYU6xGKFWD
         tI9stYQpPwk8fos/HTaR2HV3EKbS+boiG6aCxxUnbO5/VnwP3KsyoI/aRdcPluWr/qGG
         xZfI0sCnHw1PpNYnfR37Czp54p8+HA8YElR+7ot2lfUHqQKfp6n5D16QLAgnI+zdUl7X
         Jjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=il77AzCwLeUfUqsM2Aaw4XWs0P8wSa8dmYuURo+uFyU=;
        fh=IqI/Cp1xYGcfpyBgkhc6h3oFTMbeXOsSrhhlFByRLHg=;
        b=g2R6Mnxa4A7Hw6QbagoA4YwqTn0bslqxsHsQ/ZVgru13P4z/jr0qo7r5vAU0Sa6l6t
         OwrCOXK6DYZaJfwL1szCsx2f24iTtJqNGYvWd9VinGHlREesDMrQ/EBVuLj7FAhFBGmS
         52mdK5kLbKo1ZcZ/zrVS/CzPavqxucplY3kMIP8XX8vqwczqR9S6eEOdZAjsz4IhzdTx
         BETc34ci1+TBIcuGle7IeNu26IZq4059DbvFQpKGya12/FxxYXoTXQzAd9gGVZKrtF3B
         iNJSl72f0MBAr8qaiBtUGdprMlgw92HGW+m3i1y9a70VZfp83bq/bwu28HA/Vu03+j3T
         KG0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782254759; x=1782859559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=il77AzCwLeUfUqsM2Aaw4XWs0P8wSa8dmYuURo+uFyU=;
        b=Gj34D3S3aT4vPls4Mk54C/VsiGu4nVAjDom+l7AkWDTmp/wMUtRo0tTmQVTX4MF8q4
         9uAsAuHi3ki59sQ9JP+f7xhyyLRds1XZJwyr4C1pEFhqeCkOf6Ink+KV9Vh5Hj397QOv
         8eVuYQAKzXpVC+1BT90IgaLtmvmIyhdUvnib78ocSkaRl8TsIrrNqLCrkLhs7UVr5sK2
         lfBhJrJF6Qs5ai+hRYu0uzkZQNyZCvBK6S8EfKEl//uK7TO7ORUoK0Dzp4kla7w+K2cY
         M9CtfA2PLG1yU4orEiXAHrLdd6wSWmhtI4gNUOgkWmzZghAKfCxnV4IzZzqFqF9rfKim
         qfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782254759; x=1782859559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=il77AzCwLeUfUqsM2Aaw4XWs0P8wSa8dmYuURo+uFyU=;
        b=d2Tf+QlCVWvwoCKDFBzd+aYjFj8WMUAhGwQ1vaxQYMQ/warYxAYtJSthrWH1nuKXAL
         1B+q+xBc9A6D6xVCQU4/d6Mg800/MSO72bCRTujByCGaAx4nwZOC8bzI9Nc9ZraMwqKh
         oHXMFU0/hZtAweD5Nx96/IfLoPFPUuclVy1TFBVc6Bvb0aqWq3DVZf9E9mXSla0S0TOZ
         /LvpIsGNXBBTWhl1JL/IddyEKNxupSzYbf6UgT4ew6PPFDayrkkbkIfMzy+qmXOkSBAf
         myYDWNbYugm40ILouzJmic1lhYqVvpjRH9bP+BOlsPaOR6usFFG/NaKjFBO18NNpYuac
         hBkQ==
X-Gm-Message-State: AOJu0YyzloPXIo/V9kpIir5oTHazcFKuNCmGnR4EnX6JlUGeZzcX+Mxp
	34zxgFtf4pemPAGLiysJ7vt26oml4k7/lfLBoklM5NmHIxOclDOAnmQlip8dB0h8O8Nt1Ggn6jX
	//M2cPvPXBfazu1XuPEL8jea+JGxEIzg=
X-Gm-Gg: AfdE7ckEp1nmNFfqm1XgTTqebE83uKqx3gbU38Q/OWGaD3W3HQ8MWcCFxf/I0PJD9pF
	oylokPmKKAp20XnarsV6g3aOMlB+QyXDZBuephBHvXIehfqLQbVYZ/0YAyLtcmmG5ZtzM93xWjE
	Fbhu52RRBoqg1Tp72fOnOVhRxDVlfyVbwZK/vFUqk4fCNWQeh9a5bTnBu5SenNqIYYSQtMeKRoc
	S6lyK7yFHB3zyojSFs//gqJ9S+kAP8Hl+NUopVQriIHXtV2V9FyVplL8raChMTdp5hKvGnTI+Zn
	Zk6PWf/2/aozSKBDfuM2jpRbXAEWE1iNS3NrjcbmNlOrbR0nac9v2hyjp7gFkLJ1Kc6P/Q==
X-Received: by 2002:a17:902:e5cd:b0:2c0:baaa:db94 with SMTP id
 d9443c01a7336-2c7e1598ed7mr7885055ad.22.1782254759435; Tue, 23 Jun 2026
 15:45:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622143557.22955-1-leon.hwang@linux.dev> <20260622143557.22955-7-leon.hwang@linux.dev>
In-Reply-To: <20260622143557.22955-7-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Jun 2026 15:45:44 -0700
X-Gm-Features: AVVi8Cfz_AMiTjXuQaT2PnUupoQgQnU88wU1V3erLQ3ZDJb97JINyEDYr3KT8Go
Message-ID: <CAEf4BzZSeMSMnuYdLvEfb7-pmbthjU3J7W3QB4q9-WN_4+QrbA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 06/11] libbpf: Add support for global percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 7:37=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Add support for global percpu data in libbpf by adding a new ".percpu"
> section, similar to ".data". It enables efficient handling of percpu
> global variables in bpf programs.
>
> When generating loader for lightweight skeleton, update the percpu_array
> map used for global percpu data using BPF_F_ALL_CPUS, in order to update
> values across all CPUs using one value slot.
>
> Unlike global data, the mmaped data for global percpu data will be marked
> as read-only after populating the percpu_array map. Thereafter, users can
> read those initialized percpu data after loading prog. If they want to
> update the percpu data after loading prog, they have to update the
> percpu_array map using key=3D0 instead.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/lib/bpf/bpf_gen_internal.h |  3 +-
>  tools/lib/bpf/gen_loader.c       |  3 +-
>  tools/lib/bpf/libbpf.c           | 68 ++++++++++++++++++++++++++------
>  3 files changed, 60 insertions(+), 14 deletions(-)
>

[...]

> @@ -5353,6 +5387,13 @@ bpf_object__populate_internal_map(struct bpf_objec=
t *obj, struct bpf_map *map)
>                         return err;
>                 }
>                 map->mmaped =3D mmaped;
> +       } else if (is_percpu) {
> +               if (mprotect(map->mmaped, mmap_sz, PROT_READ)) {
> +                       err =3D -errno;
> +                       pr_warn("map '%s': failed to mprotect() contents:=
 %s\n",
> +                               bpf_map__name(map), errstr(err));
> +                       return err;
> +               }

hm... do we need to do this? what happens for LIBBPF_MAP_KCONFIG, do
we just null out the initial image? should we just do that here?
Basically what I am asking is how important it is to access initial
per-CPU image after load? What's the realistic use case for that?

>         } else if (map->mmaped) {
>                 munmap(map->mmaped, mmap_sz);
>                 map->mmaped =3D NULL;
> @@ -10806,16 +10847,19 @@ int bpf_map__fd(const struct bpf_map *map)
>
>  static bool map_uses_real_name(const struct bpf_map *map)
>  {
> -       /* Since libbpf started to support custom .data.* and .rodata.* m=
aps,
> -        * their user-visible name differs from kernel-visible name. User=
s see
> -        * such map's corresponding ELF section name as a map name.
> -        * This check distinguishes .data/.rodata from .data.* and .rodat=
a.*
> -        * maps to know which name has to be returned to the user.
> +       /*
> +        * Since libbpf started to support custom .data.*, .rodata.* and
> +        * .percpu.* maps, their user-visible name differs from
> +        * kernel-visible name. Users see such map's corresponding ELF se=
ction
> +        * name as a map name. This check distinguishes plain .data/.roda=
ta/.percpu
> +        * from .data.*, .rodata.* and .percpu.* to choose which name to =
return.
>          */
>         if (map->libbpf_type =3D=3D LIBBPF_MAP_DATA && strcmp(map->real_n=
ame, DATA_SEC) !=3D 0)
>                 return true;
>         if (map->libbpf_type =3D=3D LIBBPF_MAP_RODATA && strcmp(map->real=
_name, RODATA_SEC) !=3D 0)
>                 return true;
> +       if (map->libbpf_type =3D=3D LIBBPF_MAP_PERCPU && strcmp(map->real=
_name, PERCPU_SEC) !=3D 0)
> +               return true;

um... this is extra logic for DATA/RODATA is supposed to be backwards
compatible legacy stuff. We shouldn't need this for PERCPU_SEC. It
should actually be called just ".percpu", not "<object_name>.percpu".

>         return false;
>  }

>
> --
> 2.54.0
>
