Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E44F380FEC
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786639813; cv=pass; b=la4I2ar/fYojWPhJRXR1P4H5hG/Qm7M438DtZ8E3Y4GZJkh18tBOCwZjPbaiDJv2n+hDoqUOghmlw22G6h3MLqxtBmeKg4bAXTK+9hYhdWzh5R+IbVWIFE5PDb9+wAtn5ScbEYM09UlAARmrv3lJTCXW6lxlvGfkS71G4cjcsdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786639813; c=relaxed/simple;
	bh=oaN8qNDUF6Nlckse8FYwHQNkU35MZWBZmsmZoB0ZJlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gk0PDJxSYmXwSsBLKnRewB++g58ALBcO9F1PlImVTjAl8iUF6BF73aqga6IrLc/htQd8/TCF7Fl1Wwf0xm0hbEo2sVWp4aGSdsxJ0azdAsUlKpgK2szeMS3OzM73TdPZWI0MAte6MUBwpeALQnKeO+IxUdA+i4AXKR3il4Z/RTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EBnwO0M5; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EBnwO0M5"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-495509b08ebso55125e9.1
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 09:50:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786639810; cv=none;
        d=google.com; s=arc-20260327;
        b=o27NAnDBHD2tbrDepCZGDK6ryi9nrnIpWwQzv9UCNmTX18/0B4Dxyj96B6NHFV0HLo
         ISEV4cOLJqxRE556Cz5DfV9NIbHbzY4kE9CODGmZvpNGKyBvZPNUpf5TX0nH+btoMLG4
         B47QLDw1U9MK99FfkkNcRPzfReOpjnPvuEDPIx6ho8XUYR7jgGvmNPH/X/mPEwXn9Wof
         bDRk9+OksItw6bc6a9LKEjTb4D7BZ3YuZe6TLbA+fHh++2xm04a/PfJ0QsrYmtLiq5Gj
         mnSvGhPhYTE3dkRlV6o0UwBzZxrvbJyzJr1VRwgcdzUhkCHOV7lSxsp+BbkiOQJLoI7y
         XEpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=siX4jg06PuSVWSRYm7rNOXX7XdZKpaX5rlaVBPQYN1s=;
        fh=0jve080+Ut2WOEk9/h46neenJ5p8lT+1hgmfYRvUP5E=;
        b=VKyMUmbSq3l7pjixLV3j2z/5YLcOokxWX/Sy5f0XW7DsQ5OFoLWodGkrgAgvpZUCPB
         vTRREHJA4anLYzsy9eBG41i3pb7sqHcBN4gR8O7PlRZRyjHMdVcOsOT/HaUmnyV/JT8x
         8vLcZvxroORcbXbvTGCMXQF+xcDIn9J22Pq38Do9ToD0A6WphI+1yb7mDB+VBgKZIDZ/
         sKb2VVZOI859O4Wkql2lMQF2sfI9q02UB1MRG4TAk0oAzK43NLfJruFFCJp3NNs6Cv48
         ocZGwuIHjcYO/FJ/sct+gp1NbSdmfzWQ5rHATJHIkZuAuggHjX9i0+GRAeB2ssvq6ukt
         1rTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786639810; x=1787244610; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=siX4jg06PuSVWSRYm7rNOXX7XdZKpaX5rlaVBPQYN1s=;
        b=EBnwO0M5YdQ8qPV6HLxQ2IicPKt5tpSsgouSZ4krZ3cd8Va3gIwxn2K7tATg/01Pfl
         dQY4imL2r+zO7ljWdlg/VOde2yjfZErFsnnn4TJZ2VDjR8sFEgfld9tdmFVYBvNvDG5y
         VS2cS3nr5RiCJC8V5T6PJkEFJJsaKwkdrd8MICujcxPGZ6jqcZw0HQkQaNGam9dWdKHU
         AB9IiQEtt9tnCdYQWlSD7bhs7KfVxxJ5vrzuIWH8ynsW4zori1/B/DznZIjj5F+jSxDy
         C7N8ggmpGq68S1552DgK1Be9vAZd0liBvEL4OqHFYhUwzNXtadMeiKT/eLTd8FtR6u2x
         Jj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786639810; x=1787244610;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=siX4jg06PuSVWSRYm7rNOXX7XdZKpaX5rlaVBPQYN1s=;
        b=pwOZJFSTupWG4L4UkdIpcWnHIAeqivN5xXWa+BMuDCaAlfRxJay5VhXGKzpEbkGne0
         /MUjO1R7gmIntOopHbbDQgNx6OCE71GRVTALvTEcMS6PQ/kk6nyVnner0xRA1x1xg+I0
         DABOmz64k3Xb+/HPof+Epb50OP/86qDgvZqYhXcf+gIl5CCwJIIZIWmnHagq6cRLOYn9
         EsGhdhuDBZaWsercrlxEBEYxyaY3YsJO580QkgG1leddT9/gYcbSOgEVa67EUESfke2s
         4xn8Pbulc7OdGyh5J4rWcMaYUwbUE7freIfwoLdT4dX2WM5dfv9nqCGdY7z0ApJgn00J
         rAQg==
X-Forwarded-Encrypted: i=1; AHgh+Rp7OD+bIbusR6vu8sI4/XfeLHmlsjDdD43Xgk75tc8II6ktv2mk+OILEpJ/9/x/3a12D30=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbravmRxk3VBdt+LjpX1gycJnylsf4Ih1slxq2vkXN+bOY2k96
	wi6JUMNUWc+Nv/GYqbbYsjh+Qg4nZmi2mFVjd0dxthaUCmH+DnrxjtUX3shIjqVJiIWj/SwyxF3
	LcphoAK/OnAKt6kb566ewSMcpugmJMz6THZJtQHdM
X-Gm-Gg: AR+sD110Nko+8K3hUlM/nMI7l+6b4G8VYu4INlBKsT+EBizcQ+qAfFzuX27rob4eRsi
	F7vR2oOsm+J3btoZmfMjE9R7qy2MT4xBqmzYKxO4tlz3L7ub4OUZWdlv7r8YVfgmARWVvSF08Rw
	s4kmnGl/ejcuK6eCkKcWrlUcB7LKS2cVndYCRu0MD4eoaw5wtAU9fp58F0HU9/f3kS4gyE6/5Ut
	Huz/M/jblPH/RfseyDQROMpAH3IiuybeaPq7FmYgosm8buryjcLaS0YbrTNNcqYiMjPKqOZegrW
	AczVDA4coA+a8KWDyrionsvQT5vwTuQuVqZyf8G4+0wiJqi1uXGGET010wyjvVlUOQJ36HjGcKU
	aRZHCKnfhHSRhWJ3Qt7nGlRzzL0bCsG8=
X-Received: by 2002:a05:600c:3494:b0:499:5ea5:e493 with SMTP id
 5b1f17b1804b1-4998273ac1cmr1772695e9.6.1786639810018; Thu, 13 Aug 2026
 09:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812231905.2956588-3-tjmercier@google.com> <0694ce653e21157306a453397ed8233b81a958a1880abffbb0ad4cb5b7504e1d@mail.kernel.org>
In-Reply-To: <0694ce653e21157306a453397ed8233b81a958a1880abffbb0ad4cb5b7504e1d@mail.kernel.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 13 Aug 2026 09:49:57 -0700
X-Gm-Features: AUfX_mwg0szKdTycaOAHojHpiM6MA7kb59rdpr7NssE09M7xtXcQN_fYWchql0Q
Message-ID: <CABdmKX24rd0F_U9TkPrrbj=4buj7UbrMseTf_RaEk0bXS=VVyw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] bpf: htab: Reduce elem_size by 8 bytes
 for small key sizes
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 5:22=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index fed4b1db8b78b..720766121ea2b 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
>
> [ ... ]
>
> > diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/t=
esting/selftests/bpf/progs/map_ptr_kern.c
> > index 373c8d17ea557..6bd4cb68c20c1 100644
> > --- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> > +++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> > @@ -114,7 +114,7 @@ static inline int check_hash(void)
> >       VERIFY(check_default_noinline(&hash->map, map));
> >
> >       VERIFY(hash->n_buckets =3D=3D MAX_ENTRIES);
> > -     VERIFY(hash->elem_size =3D=3D 64);
> > +     VERIFY(hash->elem_size =3D=3D 32);
> >
> >       VERIFY(hash->count.counter =3D=3D 0);
> >       VERIFY(bpf_map_sum_elem_count(map) =3D=3D 0);
>
> Should this expectation change have been split across two commits for
> bisectability? The preceding commit 1066507e33e67 dropped the
> freelist/lru union from struct htab_elem, which moves elem_size to 40,
> but that commit leaves the selftest checking for 64. This means the
> map_ptr selftest fails at 1066507e33e67 and only passes again here
> where elem_size becomes 32.

Yes, it should be 40 in the last patch, and 32 here.
