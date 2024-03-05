Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B0124215
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 19:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709666380; cv=none; b=bBtSrVcHIMrrlsbZkgbq4F1kT2x2n+yWuY0D4nR9ArxzFp78/fC76XpqgCX7K9/kRDjtneCuiVX/h/bMqIjKOcPV7F/JoJ6rb8hXSvtQGJYUSwgT7PTBT1OMWtOSjQ11manzhmNXE7uE0sH++yhJrnoy/MxxX9R9+3whUf7fIJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709666380; c=relaxed/simple;
	bh=q152hSngeIBc94sIfaZsNQh8YQEfMH1WkpH6iWJeg50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZcAIeQfBK+WVxMhjrFxZ02W0VwFtWnQ+ZHdSM2p3e5Wv4PoODNIXYzuAmt9XFkX2RfBuO8U+ESQyl3ckn7PEn+tuwli+5cceYSitJTlpxcszmU8oYreeg0gdubMOBg0H3y9+K1j1vlCzlPAK4bwG0xaiMd67dNgzkEG2BIErhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8dzEgLN; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8dzEgLN"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so5470185a12.1
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 11:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709666378; x=1710271178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMQzYiNe2n/AJdd1akQfkRvuFpH3E7A1+juU6kiWxNU=;
        b=j8dzEgLNg48dP1NSQ7X4taVuY/ctqMJENHMEuNPKy39pMCxZ9HTPI+QEmUckeWJwqx
         l73N9mCHOb/fz1Yjxj+JnD4JxqlFgYQc5R6lYTOTBFxcJ+DhXoLUGzSECrfD3O3NIWVe
         IrEO+PWb524ParMX77rd9gz//tDznG2swATf+QWnFLj1uNYffQn+wGbPWHDGySgR5CZ+
         zUmdm6DR7Bal8a+vtE4YF/QGdAkLHEsNTeT3Vj6kPZ681voJZgLkOlxxSjIXpvG99ZiZ
         um5HknCt3OEG2ozBbBWeP0S9i1wCuu+xkygoW+DCbjevsPZHchA+pCiIw+7l/UqB0oxH
         0L4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709666378; x=1710271178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMQzYiNe2n/AJdd1akQfkRvuFpH3E7A1+juU6kiWxNU=;
        b=AuiyhmiVUW0MOTcX6lJZTofeE1zYg/Jm2/zO7X9+0UDYJCqkOHrNnSd8N+yb84FsMF
         pymHzNbkYuQddnFBlr3fyB3mAqxcVVW/rwCuLMzWNDtxyEuUOhHoaeYHeGmf8h77yPWP
         eiKQ5ib546BWA3aucwEHQk/XbUPVi35x/vMInO/caSuZzb1c2NywNWIOuZxShet2mSG6
         pgXF7m7IXvhNX+++UhWDxcPMH/S4+hWLa9Hoqnqk4m3uZuYs1y8TmULBQRw7gnB7QeEB
         J0lOb750jowh6D406QajTO6L2XM9TSJj+L3PeW0vNTeAG9bHfp0sXWbu9zi3tvyOlhpY
         TI0g==
X-Gm-Message-State: AOJu0YyQVUWHd+9iir8gQEKeXhOb2Va6vwOAoOi+5wErDeGFNIBN9wAB
	JXrwH7XQsrSJdpP34ui0uRynG4ZNQTiTvFZwlp1dYLxmAgsCXmwassYHi3P+zKYukXCrLz4Hp0t
	Sp0w9MEunmDZ9oI//l6Mny/Fvreg=
X-Google-Smtp-Source: AGHT+IFGF501tgFV7YiMjzjyz8ttYeBnUeFCXppTWavpJzXjMy+wZAvMyRLhX2gZ1ZwHx/eKyj5+uyz/VnG/gk+IsQU=
X-Received: by 2002:a17:90a:bf01:b0:29a:a1c7:fc28 with SMTP id
 c1-20020a17090abf0100b0029aa1c7fc28mr9953620pjs.10.1709666378098; Tue, 05 Mar
 2024 11:19:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304225156.24765-1-eddyz87@gmail.com> <20240304225156.24765-4-eddyz87@gmail.com>
In-Reply-To: <20240304225156.24765-4-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 5 Mar 2024 11:19:26 -0800
Message-ID: <CAEf4BzZp0PHxkJtLBnVeiwBK6Uqr8RZ2=5Q0iy7eRgCuK5ecLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 03/15] libbpf: honor autocreate flag for
 struct_ops maps
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, void@manifault.com, sinquersw@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 2:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> Skip load steps for struct_ops maps not marked for automatic creation.
> This should allow to load bpf object in situations like below:
>
>     SEC("struct_ops/foo") int BPF_PROG(foo) { ... }
>     SEC("struct_ops/bar") int BPF_PROG(bar) { ... }
>
>     struct test_ops___v1 {
>         int (*foo)(void);
>     };
>
>     struct test_ops___v2 {
>         int (*foo)(void);
>         int (*does_not_exist)(void);
>     };
>
>     SEC(".struct_ops.link")
>     struct test_ops___v1 map_for_old =3D {
>         .test_1 =3D (void *)foo
>     };
>
>     SEC(".struct_ops.link")
>     struct test_ops___v2 map_for_new =3D {
>         .test_1 =3D (void *)foo,
>         .does_not_exist =3D (void *)bar
>     };
>
> Suppose program is loaded on old kernel that does not have definition
> for 'does_not_exist' struct_ops member. After this commit it would be
> possible to load such object file after the following tweaks:
>
>     bpf_program__set_autoload(skel->progs.bar, false);
>     bpf_map__set_autocreate(skel->maps.map_for_new, false);
>
> Acked-by: David Vernet <void@manifault.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 2c0cb72bc7a4..25c452c20d7d 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1209,7 +1209,7 @@ static int bpf_object__init_kern_struct_ops_maps(st=
ruct bpf_object *obj)
>         for (i =3D 0; i < obj->nr_maps; i++) {
>                 map =3D &obj->maps[i];
>
> -               if (!bpf_map__is_struct_ops(map))
> +               if (!bpf_map__is_struct_ops(map) || !map->autocreate)

tbh, I'd keep them as separate checks (they check very different
aspects, so feels appropriate to not combine them in one check)

>                         continue;
>
>                 err =3D bpf_map__init_kern_struct_ops(map);
> @@ -8136,7 +8136,7 @@ static int bpf_object_prepare_struct_ops(struct bpf=
_object *obj)
>         int i;
>
>         for (i =3D 0; i < obj->nr_maps; i++)
> -               if (bpf_map__is_struct_ops(&obj->maps[i]))
> +               if (bpf_map__is_struct_ops(&obj->maps[i]) && obj->maps[i]=
.autocreate)

especially here, this becomes a bit convoluted

how about we make it a bit more verbose, but also straightforward

map =3D &obj->maps[i];
if (!bpf_map__is_struct_ops(map))
    continue;
if (!map->autocreate)
    continue;
bpf_map_prepare_vdata(...)


It will also mirror the structure in bpf_object__init_kern_struct_ops_maps(=
)

>                         bpf_map_prepare_vdata(&obj->maps[i]);
>
>         return 0;
> --
> 2.43.0
>
