Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590B51EA74
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 23:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709682650; cv=none; b=QZ8SLKUh2BX/yH135F7y0PoywOHpruFrSJJsA11ujfpa243AnBL5AtPGg1p1hDn4DbjKBvUyC+bTVmN5h/GyzEF60FxPkxYMeaHjjf2zPBr6M3SeleF/qJhDzk7z+LiznEHqswgSfd5ntUS1ULdRhN+5B4SXJCf8Gdl/YPvfMQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709682650; c=relaxed/simple;
	bh=gBMnmNu0Mo9cdUnhnenxQc4pN1E0HMlhsLIHEm3vra8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t61yAKasAfQUnANeDXhfTLCguddITvI/uN24ico3383J9ne8rj0JllhVgUwsgQ6y8+a8PXOQzZfgRWmmy+YcUuDPG2rxXlPv61f2BZJa3O6GsC74iN/rRQmh0hHgtHPUaoRpCfQ3552tyG3NHQUy+W0ijr81b8JfENNRuNyPims=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLjEccri; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLjEccri"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5672afabb86so3079301a12.3
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 15:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709682646; x=1710287446; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PBaFLGkHbaV8kw/WktE6zv0vzwujrUB5nVS7Og8h5Aw=;
        b=OLjEccrimtSFtDz4ELG8LTRP34qglWa1p+ZzcALdw+2E4+QECSrrU3zR+7uqYGMqBX
         ZiZnV/5idv3pZSnwjWpXgk1vKpBb8WAMRQxFKsc/1pZw9bD9vpQ6cAVZcRxzYP2mQ0/t
         jUJKNsQQQsk1LVB9sBxX500Rcx+WzqIhp0F7PSNv7uXR54hju3GdRCfjn+l0q41TuHnc
         c1Ds9CQnEU7y6bPgZK3/h2INupR1cKP0edzqDt4biEU1YjWYGjsZPZWXqkRzyh9alf3G
         4ZNiC8IB4wfrGfClN4sUwjDSK46sMjh9zB0BbNY3LBj8aS95lYvYFjzZVn7OsMhIqK6P
         loVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709682646; x=1710287446;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PBaFLGkHbaV8kw/WktE6zv0vzwujrUB5nVS7Og8h5Aw=;
        b=VzgBYM8Oc1NGwGEYRXgCIjHVgnujtDayh5Xsqx00WIyd9KNqv+RtTQ1hy2uYQB34BQ
         x6EQQGr4xTUxjh6HxhccdJFe8ONDPfEVYPvyp6+yoD/+IixbuJnzXVPZ8YTke4UsuGmo
         560MKvXsZcx31oJI1IUMpQuaiLAHNfDF5i7Fx+uOXkf3nUsyOeCPBSkAW7d7+qRTkgh6
         qM3h8pgUy2ljh8nC5Rt93zZVdH271SWhfWLPV0tOGszAtFeo4wGZ6PNBqcS16WxL0Kno
         DlsD8CCxjrLHsNuQew1VHTvPeAbArFHfewhS81nK2QGcifvCRRxtfj9kACh+i90t8Gmo
         jVng==
X-Gm-Message-State: AOJu0YwJneDRJbTYNS/xnqC7GfCaqe1itAJhO2dvO/m/uq+At3O6hbd8
	C9uj3WNTfNOLTQrMVvcfxq8b7yvUmWfFrPQ/VEdY2nYM9xBg/hCr
X-Google-Smtp-Source: AGHT+IEPh/wX8fo1NbMdjAQJIxRUTxD9DvF+MLOhstbuC+oOL/UGUOo5oMGMiEGRfQk8lXE24BmkAA==
X-Received: by 2002:aa7:d44b:0:b0:567:4694:159 with SMTP id q11-20020aa7d44b000000b0056746940159mr4900085edr.26.1709682646231;
        Tue, 05 Mar 2024 15:50:46 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m18-20020aa7c492000000b005662d3418dfsm6276981edq.74.2024.03.05.15.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 15:50:45 -0800 (PST)
Message-ID: <422d596d7b29e96a1d95424e425706a6525b8446.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 03/15] libbpf: honor autocreate flag for
 struct_ops maps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  void@manifault.com, sinquersw@gmail.com
Date: Wed, 06 Mar 2024 01:50:44 +0200
In-Reply-To: <CAEf4BzZp0PHxkJtLBnVeiwBK6Uqr8RZ2=5Q0iy7eRgCuK5ecLg@mail.gmail.com>
References: <20240304225156.24765-1-eddyz87@gmail.com>
	 <20240304225156.24765-4-eddyz87@gmail.com>
	 <CAEf4BzZp0PHxkJtLBnVeiwBK6Uqr8RZ2=5Q0iy7eRgCuK5ecLg@mail.gmail.com>
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

On Tue, 2024-03-05 at 11:19 -0800, Andrii Nakryiko wrote:
[...]

> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 2c0cb72bc7a4..25c452c20d7d 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -1209,7 +1209,7 @@ static int bpf_object__init_kern_struct_ops_maps(=
struct bpf_object *obj)
> >         for (i =3D 0; i < obj->nr_maps; i++) {
> >                 map =3D &obj->maps[i];
> >=20
> > -               if (!bpf_map__is_struct_ops(map))
> > +               if (!bpf_map__is_struct_ops(map) || !map->autocreate)
>=20
> tbh, I'd keep them as separate checks (they check very different
> aspects, so feels appropriate to not combine them in one check)
>=20
> >                         continue;
> >=20
> >                 err =3D bpf_map__init_kern_struct_ops(map);
> > @@ -8136,7 +8136,7 @@ static int bpf_object_prepare_struct_ops(struct b=
pf_object *obj)
> >         int i;
> >=20
> >         for (i =3D 0; i < obj->nr_maps; i++)
> > -               if (bpf_map__is_struct_ops(&obj->maps[i]))
> > +               if (bpf_map__is_struct_ops(&obj->maps[i]) && obj->maps[=
i].autocreate)
>=20
> especially here, this becomes a bit convoluted
>=20
> how about we make it a bit more verbose, but also straightforward
>=20
> map =3D &obj->maps[i];
> if (!bpf_map__is_struct_ops(map))
>     continue;
> if (!map->autocreate)
>     continue;
> bpf_map_prepare_vdata(...)

Ok, will do

[...]
