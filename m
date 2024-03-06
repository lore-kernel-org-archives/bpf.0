Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD21963AC
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 01:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709687338; cv=none; b=c45cFVWPX6eJVm/5zsulrcI9DUV6M1N1gh1AHWnv1jJ5Q5kltJ/60kuXzZl6NhQJMcSIplFB4dhrsZG4/iR4eeKoz+B0XAbdz36JY9cOr62QxFOmMJ4KNZ8cKDwa7ljPPLBBJj3ZnYhDD2/c6034KxlIEQXDscEeh40GN9BDzuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709687338; c=relaxed/simple;
	bh=JhorWBp7i6pjFB/Hk0SqJkBLexTDFrlk8yiVgl89QhM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=etuqbXy6HcaT6MD4aXuSYwW2VrHOuWnf8fXzyw7O0kr4NMDwYnS5xfQtiL/A/pIk2oeGunyzKsp/l0qBvsbk/8WRipVTb6O4qOeYdn1oJd4s9XqP6ec5qsG2x1aP8I+dDvUxJtsLecrrENI9CNdg3Q3nzUD6cxfc0Ko1qVgEgng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kS5CHZy9; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kS5CHZy9"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-563c595f968so9306986a12.0
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 17:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709687335; x=1710292135; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+7qJZagoeBjnn+hMfw5QSh4rYTpAvdPbob1mjXn/NJM=;
        b=kS5CHZy9dQexYaXXJFGIvq0JsOXpTALDNYxklJ8PgdoB89YNCXvsr10TMuOVJHKuXH
         teW6x+SqAU1lNrmtpi6CQrbEnvDJ2BaBk5VY5kGYQWdPcGLGANWnCkQEuuxApEb1iJRk
         rhvyFb1oUJokibqE8RIaxvp1LUtROv7vK/pHwV/byX3Ql4ci6EaTaebGMdy7akvZo2/c
         2IJhFvElR7y/DH4ri+TmcmUf9GaI9vYKuWFVR6BXmva00HczYIlYv30+f+HDeWiZg31O
         tbXyJ0NICeY1qz65v5QXNElig0+RrnpJHA1GCOA1MTv3QqEJcvk4InmnRzVc4z9LgfiB
         aZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709687335; x=1710292135;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+7qJZagoeBjnn+hMfw5QSh4rYTpAvdPbob1mjXn/NJM=;
        b=ACsTJsLV88Fz42peKXFpOtTAT1jqpuQ3nf7WHpNRP4fUOzm0z61yfdk2fs2e/zcBBa
         59NDdXQpKrtVo78yH1qGlIf+r2x5Pwo12jwtNfa1Jud6Xs+Myg8AAxCecaiN+qcNVLQn
         9CpSMdyvtKYBxiTf3AGRFrr8ZalswdzR2YqwOI/U4ATQLEfYlvXAQOMk00alCmeXjg7O
         Qi44OhbLiFDTBV5qos252T5Qp1RPle5ASezkvFk0lZJdhmX+ilnzp5fF/LCj6NtXjXup
         sx+dLSXOpeWbusRB0UZ2Rk9imYL1sv7FOpGbYVsWWjiZqxh9No0WwHLxphsIz6QScNu0
         6c6A==
X-Gm-Message-State: AOJu0YyjlrjPbNJI3GY40mFGi2UDYXXNFTfGhMdhEBGKWHFAPcfzcRYf
	KK9qoQEWLWRpjH1guOkIaUWvE+k0vg2Exh25qy0U1NeDWMOML2Cw
X-Google-Smtp-Source: AGHT+IHj3qzxWWHqDwnggWcVGAkN2TIIdxwBD/17FE0lYraIEcs87Z8vD1tJADA/rziQ2Gp+m8QlVg==
X-Received: by 2002:a05:6402:35cc:b0:566:f851:f53b with SMTP id z12-20020a05640235cc00b00566f851f53bmr11032930edc.35.1709687334961;
        Tue, 05 Mar 2024 17:08:54 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h26-20020aa7c95a000000b005663b0d7243sm6333511edt.83.2024.03.05.17.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 17:08:54 -0800 (PST)
Message-ID: <db513702233c64faa82107997661e024a9804286.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 10/15] libbpf: replace elf_state->st_ops_*
 fields with SEC_ST_OPS sec_type
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  void@manifault.com, sinquersw@gmail.com
Date: Wed, 06 Mar 2024 03:08:48 +0200
In-Reply-To: <CAEf4BzbfR8GJWDq6d1yuLK1O+3GDZV9oro=L4CK32D2dLvQnBA@mail.gmail.com>
References: <20240304225156.24765-1-eddyz87@gmail.com>
	 <20240304225156.24765-11-eddyz87@gmail.com>
	 <CAEf4BzbfR8GJWDq6d1yuLK1O+3GDZV9oro=L4CK32D2dLvQnBA@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-05 at 11:53 -0800, Andrii Nakryiko wrote:
> On Mon, Mar 4, 2024 at 2:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > The next patch would add two new section names for struct_ops maps.
> > To make working with multiple struct_ops sections more convenient:
> > - remove fields like elf_state->st_ops_{shndx,link_shndx};
> > - mark section descriptions hosting struct_ops as
> >   elf_sec_desc->sec_type =3D=3D SEC_ST_OPS;
> >=20
> > After these changes struct_ops sections could be processed uniformly
> > by iterating bpf_object->efile.secs entries.
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 62 ++++++++++++++++++++++--------------------
> >  1 file changed, 33 insertions(+), 29 deletions(-)
> >=20
>=20
> Makes sense and a good generalization!

Thank you.

[...]

> > @@ -1330,7 +1328,8 @@ static int init_struct_ops_maps(struct bpf_object=
 *obj, const char *sec_name,
> >                 map->def.key_size =3D sizeof(int);
> >                 map->def.value_size =3D type->size;
> >                 map->def.max_entries =3D 1;
> > -               map->def.map_flags =3D map_flags;
> > +               map->def.map_flags =3D strcmp(sec_name, STRUCT_OPS_LINK=
_SEC) =3D=3D 0
> > +                                  ? BPF_F_LINK : 0;
>=20
> Does it fit in under 100 characters? if yes, please keep on a single line

Done

[...]
