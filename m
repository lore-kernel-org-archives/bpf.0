Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C815C5FD
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709668418; cv=none; b=uZvQNhYefO5l8l/ZR4hW3SVK5FIEpWEdPmFZSxex9t+4Q5u6vIAQPdL08OmrodVptNsu+rlyWFf9/wzQpUUbwMCQ/RcpRDJWszKIaBZZ240I/hPQFoo2c1pzPbYgKzrj7wLM5NwEPKqUgN1Ux/CTJ2uvlWScahvgFCdHxjdTjYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709668418; c=relaxed/simple;
	bh=1tdgY3NSz3jixCdqghj+LjvDTJ9qbdv0Hfnt9Lp7UmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RprYPrf9hmNLZ8MzBKmUNpOjD3dq8xYcxAXk3FADf3ogMs2PNuPJE9n0dUAd4w7rjsiY+/p5nfatSoO7Mw9o7ONkxWlUxCVNZ/Zxbil6Wssi/dZdl3RvWImsKpTQCWnQ14F5yJOoTLVCabjNJCPBdO/Qt6xBG8Xchix2uj5CuLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gh/9gmzD; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gh/9gmzD"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29b73427790so50946a91.3
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 11:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709668416; x=1710273216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85GeZxTtfplBeSI7pI584sCMsnfGiAyXre+1UV16TE8=;
        b=Gh/9gmzDMZvRCydqBsuLYxt8poCgyhF0o2u+hxiV4ZojAqbRkQdsdzKqvSGLVTH4sS
         ZWbL8MQ3uxUr377sHenojHu3rXBS0JpyF661NdXjXEvOXlwYGsYVEfyXNfiE8rkZ8ow8
         QGlIWoWykVbIHCZER84ewYNrXh4iFYRoexrdwgu32vsYIHXepyiRFrIVji7hFGvSqBx9
         8NEyUHHfheb9sBPgt+6SAH17uyVGcnULt1eAh0Devb6e5N2P2ZK8Koisqs6Q9lk7UNLM
         UJjHtYamBaZg3YXwp0ev0FyvNk1tDkjEoT47qJNXvMd9jUu3YRvHkPCLEoOyXiSLv3cU
         GKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709668416; x=1710273216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85GeZxTtfplBeSI7pI584sCMsnfGiAyXre+1UV16TE8=;
        b=IDD/YM+yEi9zdUsWgjClZXZTZpsQ+OS8N2e3a1a2URSJqAYDpKxm2wtzUZkNDIrN7V
         Sx+R0EeV/hhsIrRvbTrB4qDQWefQGidghYk9xjuZC9hXKzPDvc7rD23fQ0xnbUw5NbUO
         twmVh6ECEoS0Bxjd2hlEgLJjrjb1RwAmTWT9+N9OfQ+0vFH5kkEs0l9vP15moszI8bAk
         AMynakIr11bG7gikOCyC9tl6S9yCcrwChBZIU2T6fvXJVpEf4a3qx965iLTL7QPdogn6
         BCxgliAzIpeg4PWGVpukgsXtMddcjtWkXOQoHRPJ3PBg9PHylDGHV3OL59C5o5SU3MlZ
         Yeug==
X-Gm-Message-State: AOJu0Ywy9GomxCSdORZqB2dzY/xLOFdoB9+Pp8i9S7+0oM49yZ3RnmGh
	zz9e2mnAfe4Bu2rtdb1im7WNgsvWF/1csSwVZHAgygAGbuCVJhj7uqtPac7i2m157pwRl9PAwyB
	yJMjDFhxg+9cR/9C60dMjEr7r4gM=
X-Google-Smtp-Source: AGHT+IHyY55vAytgEwPA8Biv9MCGqDbx2n6YjckkRzsR4VkaX1YEX5aqmjitwn4MiDJM03sE31xhCVC3IngkSW5foko=
X-Received: by 2002:a17:90b:282:b0:29b:1f71:957c with SMTP id
 az2-20020a17090b028200b0029b1f71957cmr10638594pjb.14.1709668415704; Tue, 05
 Mar 2024 11:53:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304225156.24765-1-eddyz87@gmail.com> <20240304225156.24765-11-eddyz87@gmail.com>
In-Reply-To: <20240304225156.24765-11-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 5 Mar 2024 11:53:24 -0800
Message-ID: <CAEf4BzbfR8GJWDq6d1yuLK1O+3GDZV9oro=L4CK32D2dLvQnBA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 10/15] libbpf: replace elf_state->st_ops_*
 fields with SEC_ST_OPS sec_type
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, void@manifault.com, sinquersw@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 2:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> The next patch would add two new section names for struct_ops maps.
> To make working with multiple struct_ops sections more convenient:
> - remove fields like elf_state->st_ops_{shndx,link_shndx};
> - mark section descriptions hosting struct_ops as
>   elf_sec_desc->sec_type =3D=3D SEC_ST_OPS;
>
> After these changes struct_ops sections could be processed uniformly
> by iterating bpf_object->efile.secs entries.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 62 ++++++++++++++++++++++--------------------
>  1 file changed, 33 insertions(+), 29 deletions(-)
>

Makes sense and a good generalization!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

> @@ -1268,7 +1266,7 @@ static int bpf_object__init_kern_struct_ops_maps(st=
ruct bpf_object *obj)
>  }
>
>  static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_=
name,
> -                               int shndx, Elf_Data *data, __u32 map_flag=
s)
> +                               int shndx, Elf_Data *data)
>  {
>         const struct btf_type *type, *datasec;
>         const struct btf_var_secinfo *vsi;
> @@ -1330,7 +1328,8 @@ static int init_struct_ops_maps(struct bpf_object *=
obj, const char *sec_name,
>                 map->def.key_size =3D sizeof(int);
>                 map->def.value_size =3D type->size;
>                 map->def.max_entries =3D 1;
> -               map->def.map_flags =3D map_flags;
> +               map->def.map_flags =3D strcmp(sec_name, STRUCT_OPS_LINK_S=
EC) =3D=3D 0
> +                                  ? BPF_F_LINK : 0;

Does it fit in under 100 characters? if yes, please keep on a single line

>
>                 map->st_ops =3D calloc(1, sizeof(*map->st_ops));
>                 if (!map->st_ops)

[...]
