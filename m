Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09F633DED9
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785261446; cv=pass; b=k0GfXGXZq28OgFmzdJIWTQDI9F9AnX3BEWilwrWu59EfKUag/olfnahT+02QRC5OWYOyX/3iTqMnmK4HpnYD8Xw1VMIX8qxOSMheCEpg0zWtBs1rGTQ7Dqujqw6pJuQ1MXUMN6zk9B5oRBFXkdJT5IbdpH8A6zf6EREMR3cxyr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785261446; c=relaxed/simple;
	bh=ZbWXmvBiNFCwwNa1ghWV+ngxvzWtq9hDtFfwg7htolI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HP7eAtfqzu5MOmmT1SWLmo2H4uNAvcFcSlwJz1iEsk6H5WilC9Zxn4YHStRjxb4uh4sL/n2cDRgiFKbVZ1y6zeopEvezz2YyE7yQOIl0V5jkAntl7jd7gir49/AeIVAgmB1XgohvyHGDVjQr9vb4F75amaxm8i7NqxrlyASu9Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFSAWMKb; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFSAWMKb"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8143daf89c7so1913897b3.1
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 10:57:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785261444; cv=none;
        d=google.com; s=arc-20260327;
        b=eif6XqKJZhlFrH4ogRX7z07zUsFBsQaSJU9LGTAiuE7jGxgS16Sz11uTlA5MML92Ne
         WvNf56CaGNCW6vsyDcnPOIiJmNOQAXKRG42/pC2LcSQH4o1kUh1MG0ECFHY+ipCeKOuh
         UBNcLFX5h2yJVSDhh4km+aZfT5rXStzNuMkxrmHYr1llf1tFiU1BI9cJrNSuCte3DVUg
         mhvvS86D7xW4nlhl/YGIXL7AzsK1eRU+t65RkOEMkLLZ5hsvn/SEEnuS65u+GWwRNjzI
         7tKHfSPffIZXNBCBVbQN6QKWZ2MDDJWSsewUp0BCC3HbvOGjof7HUNospJ9EbsgmuLrF
         QoVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JwkQxWaMUU0yinFoZtbNLOYmiD3fkrnr5GNpSWEkccM=;
        fh=6Z4J3xNs+qgwS2aK097++l2x6CIWkNCmJIKZe8W3oU4=;
        b=ROXWgiGibR/YBHfth3RhCsXvYYqh55e3v5m/uHQFPPjonyx2SS+HHqidnkcdYBXC5N
         wasiuyF+MIqoZ/76guwysJlFccu0vAcezmYnp7Z9w7cQmbIRLJmKQv3HeI197bfVSIkA
         oVGKbvsZ15RSOSEYdqRhXL5l2KUM7uSw2hx/gUbfF23jUIGpQS1wUyIYax5mDX6oCjEc
         pC7sky0nq/oC1lyCh19zLpq233ZckHcq0pBDYe49RLXdEPQ2s+hkRMXyhlvjM3p5OrL4
         Qk9xQ3cvCoZfsMnjVNsEVXLjLIcU4LtDUo/BSj0z8fpXt5fIr/RoXcaF4PohRz1l9Mnw
         8FFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785261444; x=1785866244; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JwkQxWaMUU0yinFoZtbNLOYmiD3fkrnr5GNpSWEkccM=;
        b=ZFSAWMKbXGLjFSODKa0NMg/iP8ItPLI+liBCJyXnxOE019oBg74YH6FuoVWvPFNlNq
         Swa8VMgyAon/lD5wmOE5iC9AAv23AB4F5BE2pGDtZg2wMTccLYwYcejpsQXYxOEyiG4R
         Wozhqbiy++xWWWDXLVJ3JU+wz7vb367C5l60l+IeLaKP0se52KKOcxBGWrfzUZroZ9Aj
         ayaQSbhN4dH/FnYDaqWSUoXjwZpaZSXk/zuSAAUZJ2qS+FX/ewx5xGhi2+hKOsqCwOX0
         52PpGIMZ55EoawioaWdCnE6cV6QSfFt+XGHuxiBvagHer0/YSAb0ici4ob/h6o7om5Qg
         j5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785261444; x=1785866244;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JwkQxWaMUU0yinFoZtbNLOYmiD3fkrnr5GNpSWEkccM=;
        b=HPf8FRSjAKQKjSFw/7fF8TeXHgdlW1kOgerPGFqv0L++1iZDXcoufIbGN9YYmui/bW
         guyFB9N83tFhJsHycJO4rcsKvUjXrA9RPJVSWp7ZU396/QKqMJK+WIedbwAbSubwkAX7
         3ktrncEfcaIx4zRe0pYfgBjqjQAUYdU+uxXq1gEE4jNr546KYXTIjCYiCqbBd+5Fh1os
         yz6qvJScbCTSupqeUsm0dJCtXPzijPO5BEX/WY/FOeg89MwO4yO/a5018EcKIKfcKQa8
         z1PjYF3kCxgAbCVX4Va2YkAO0pGWRMnIywPt1c+ZvuDr/6INjNxP46hGe9ZTonOD/N/1
         xo6g==
X-Gm-Message-State: AOJu0Yw5sRSQeZzBn2CE0fmMQIiv3SXWVH2yP476EwNX5ev7daeP3PiP
	3dX4bjxEJJm8AHiD1gDwx4Kx8Jo5I7isPMU3VZEcjUDFoVM5WbyagN60G3YCxhAd42LJFfSrHf3
	AjrVRsAJiqHIeheV0TQRXDTNgvzWhsJY=
X-Gm-Gg: AR+sD13chlH+FI17ruLeyUxUSUL96d0Iv4vvUs4vQTFXrd/Od8f8O3ZROTo9zyTfOIX
	UyrwH+BAaTbwA3eqsFrSufFci/kVzHs2JQXVipmTYXsQwGCw/1DzcfyJ2kvM31wOJB1tDlWf6Ay
	ZODHYsLpCOrk5RAHNyXhQ+V8VkItCumbK4KG9NHlY7Uiy8T/SH0trTy8OWSHH96Jw5FuiTyQXr/
	p+Jqoif8ExGNrnvf/dW3lyktAj9phkk7u0MgRkHb4iYcsIOJ6RqHyWKdlt9ig==
X-Received: by 2002:a05:690c:2782:b0:81c:d07d:1761 with SMTP id
 00721157ae682-81f9941c044mr13274967b3.71.1785261443670; Tue, 28 Jul 2026
 10:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724190813.1458271-1-ameryhung@gmail.com> <20260724190813.1458271-6-ameryhung@gmail.com>
 <27739a12b7f7d5cd6e7fceeb389cff0072aefef2.camel@gmail.com>
In-Reply-To: <27739a12b7f7d5cd6e7fceeb389cff0072aefef2.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 28 Jul 2026 10:57:12 -0700
X-Gm-Features: AUfX_mzoF6-geHv6sbBDnC4N6hW31P6dBD-df4BcbO5uRaGLFaPTJkc2pjKv3dc
Message-ID: <CAMB2axPcdjVA6Pwp0TpGpMtJGiOB5khJ4HA13iJ9XT1qpyfNtw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 05/18] bpf: Check helper and kfunc mem+size
 arguments identically
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 1:51=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2026-07-24 at 12:07 -0700, Amery Hung wrote:
>
> ...
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 468702b09c50..2e56f726c12a 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -6873,7 +6873,14 @@ static int check_mem_size_reg(struct bpf_verifie=
r_env *env,
> >                             bool zero_size_allowed,
> >                             struct bpf_call_arg_meta *meta)
> >  {
> > -     int err;
> > +     bool may_be_null =3D type_may_be_null(mem_reg->type);
> > +     struct bpf_reg_state saved_reg;
> > +     int err =3D 0;
> > +
> > +     if (may_be_null) {
> > +             saved_reg =3D *mem_reg;
> > +             mark_ptr_not_null_reg(mem_reg);
> > +     }
>
> Also, this pre-existing hack with saved_reg and mark_ptr_not_null_reg()
> is quite ugly. Consider mark_ptr_not_null_reg():
>
>   static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
>   {
>         if (base_type(reg->type) =3D=3D PTR_TO_MAP_VALUE) {
>                 const struct bpf_map *map =3D reg->map_ptr;
>
>                 if (map->inner_map_meta) {
>                         reg->type =3D CONST_PTR_TO_MAP;
>                         reg->map_ptr =3D map->inner_map_meta;
>                         /* transfer reg's id which is unique for every ma=
p_lookup_elem
>                          * as UID of the inner map.
>                          */
>                         if (btf_record_has_field(map->inner_map_meta->rec=
ord,
>                                                  BPF_TIMER | BPF_WORKQUEU=
E | BPF_TASK_WORK)) {
>                                 reg->map_uid =3D reg->id;
>                         }
>                 } else if (map->map_type =3D=3D BPF_MAP_TYPE_XSKMAP) {
>                         reg->type =3D PTR_TO_XDP_SOCK;
>                 } else if (map->map_type =3D=3D BPF_MAP_TYPE_SOCKMAP ||
>                            map->map_type =3D=3D BPF_MAP_TYPE_SOCKHASH) {
>                         reg->type =3D PTR_TO_SOCKET;
>                 } else {
>                         reg->type =3D PTR_TO_MAP_VALUE;
>                 }
>                 return;
>         }
>
>         reg->type &=3D ~PTR_MAYBE_NULL;
>   }
>
> Note that the check_helper_mem_access() already calls base_type(mem_reg),
> so the '&=3D ~PTR_MAYBE_NULL' part is irrelevant, what matters are the
> following mutations:
> - PTR_TO_MAP_VALUE -> CONST_PTR_TO_MAP (plus it's uid, type, ptr)
> - BPF_MAP_TYPE_XSKMAP -> PTR_TO_XDP_SOCK
> - BPF_MAP_TYPE_SOCKMAP -> PTR_TO_SOCKET
> - BPF_MAP_TYPE_SOCKHASH -> PTR_TO_SOCKET
>
> A better design compared to current temporary fixup for a helper/kfunc
> call would be to deal with types CONST_PTR_TO_MAP | PTR_MAYBE_NULL,
> PTR_TO_XDP_SOCK | PTR_MAYBE_NULL etc, instantiated at map lookup.
> Wdyt?

I agree that this is a better approach. This can be another follow-up
considering that this is an independent refactor and the size of the
current set.

>
> ...
