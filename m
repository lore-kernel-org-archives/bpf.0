Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C85405C48
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 22:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783722727; cv=pass; b=HcLbNvaWDkLPhQFl1ELnJYFxcIvqWO3CKkiYwWt89iFrvblqeBP2KJy38Y9QXsK5LXVUrUuu/1QDFN7VrWT/UYLetFptjzx1g+qeBRB11iC5jaj+HbNl5fWiuQWjpMIfzYXDHiUuzdp7+hbcgQTYjsUphXfBScv1EAQOUHEBO/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783722727; c=relaxed/simple;
	bh=WXbjqKu+g5ONdz2wdFoLLO4mX1xfwAvvVyB7RpLnH20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dW6eEFDrywqM1mJIoBd5KqTeuUsqeb3Ir+ZpaQOGod898zvnS8TnZsxuKsi8KCqPoxfvl896NkaQjerW8m6l2g1TkyK1tMQB8tw0QriiUtk4qg3VCCsilByW+ov1wsRcThJKPMLruvcHP799pOK1+x1LwQM+jt94WbK7JTVrz/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kV+z0u6x; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kV+z0u6x"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ce9e39fccbso2242815ad.1
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 15:32:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783722726; cv=none;
        d=google.com; s=arc-20260327;
        b=OUxxR5iYdbE1EUH9tiQVEYjQSgTifX/Mmdy4x/huaciBLpB3Lav7BfLy1Ana3L6zFG
         sGPzavce9SFrV6RpxWfSNw1gibCKINcMMJhgWVXbpVMXQGbPpGDvlc9wvsc0YhcEFozl
         bsmb4VW4+XVdhyJl/h5kRXTAXWko3bna5u+xFbuEKopbjl3SIEjmQbkLph0ovN4WVFPF
         u2tiBhb+cOBrrZmV4BpBmjgA/XBrQQYC/93+xPZI1msJEXkS3g+vMg/2hstx+VIg2aCQ
         o4ZVP9n6WkFjtnlFg5Y8UeiYDJJErEhITEqHFdZ5aX7lUwAr4kiNKKWSPURKv22YsCQd
         d1iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NyhOhTcFEIPyPVjmK5oFc5WLCsPA2TzQIHNnbE+6jhk=;
        fh=zCSzYjVZ+wAlrZHTxMEgmtbOcOHVIiInm1RqIvj3hvY=;
        b=SDpbL+4KJ3H42B5PL7h1IingT2s7nbdBdKN5UtkfQtltSZUQVLBxOhAcJLsmsqIXzC
         if/Qh3eoIUHEPOZcJ3cRXqky7ghvlot1E45G5XG9B0eEiBjTIRZ92S4sa/DGEdTk2dIw
         kz2I+L/j8QVHqrppxgsIfAZugvaf+u27+my7KvuKPqN+AQfognk/oZfWvVK7hqZnTLVL
         ArgW8yrmTYXIv/GDBiqGLayjGSnmSNiplsHMeSbMLJYBlFi3CkeqIBFlMFAVSlFPE7Wt
         jMsZhDW2t3qWLATrzPPmyWWnNxEc6CNyN7zEDhlL50jRCIxjQeDAs/9cOorDjKQkWOOP
         QxlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783722726; x=1784327526; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NyhOhTcFEIPyPVjmK5oFc5WLCsPA2TzQIHNnbE+6jhk=;
        b=kV+z0u6xcQsMp/Eko6ntJfNvDdcSG2XqOLbjr/P1zKHRs72XcBeFF4IiV4bTE9zD3k
         +kJSLd3Wi9DZaofKdh9ObBTYI29v1eSPyeWco6Ct4KB/6c7fv3R4UjE4bLra3B5Gj7Gs
         w/xCabX0d359OVFFTlLowjN6Q6z+NU11iY9LO+zRcjd5w1+Hh3SjLBnl1ayVnCTSBAn4
         PfkJPQM9uUOTgwX6m0nchvmTbpMDdL4E+SKxBELjYLzmxJFftRQNSHKweigZFN+7OqHN
         xcKezrd9X8Or2xrFvVoBJLQ2299v9CBIXZN8CR7l8mA0/Cdyqxjr313n/I8WmTHUXcmk
         lYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783722726; x=1784327526;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NyhOhTcFEIPyPVjmK5oFc5WLCsPA2TzQIHNnbE+6jhk=;
        b=WYgtGpFH5GJucWgQ3J4JTEffkJbP/TMluAQkymfHrytzlvvJ6uxYADiiE1CXStpKZQ
         rW8zlRa0Aab8wIon1+jdPNy4BkHKbug7hINhwO5d8XpYEmkI+hlOHgyGNQcVOYq5mKIY
         mrhMDC49TRP57VVwNE0GchdaxclY9bZuHrYXQ62qLvOxwbZLl3oH2xN7E/37vWVwc5rT
         6xFQ2TB2vvf+Af/QniSQb9pqShZRL8xqW8X+A420hHn0zqLhVTHKrfGwZX6Qus1u/fOE
         7h9VjPsZs/atDCAnDwJ/Jeme1hjJkmhJ2gT6CF/T/sfpRsFoZ0g4iQqkJQImAKjJQ+x9
         ACIA==
X-Forwarded-Encrypted: i=1; AHgh+RqH51CbOMlJKs4VES6euwP+MsJBnz+AEeTz6z83TA/QtP47o8A15uTjQHoLSZFIsoNN1EI=@vger.kernel.org
X-Gm-Message-State: AOJu0YygQdXYl+kXitatZwZGFpovyld01obTVdL+KBl+EPV3JPDvKPxo
	4zabBH20e8JPWSarzSImuFP05cy/muACtExSN43ls43pL/ACqEz75s0Xu79qhUfSiZa7dBFGeiw
	3a3Sw4w/OfuWIj+kJayoPDqMN05Qcb0g=
X-Gm-Gg: AfdE7ckUVLuOsKasb6aEnnXwiXeCqxzQk7xl50X6DLVdN0y/4kSH7FxmOpUW8n7mzva
	G8IY1yTc19b31LHyVLaGssaUFmB5rqJdtvLQX296NumViTQQHXRtr2Zcno6HxBeqDBmRPNwarsn
	LzuVGhamDeNOtVen8P++I8xu+JJMkr9QBw+bYlgbE6AOUJEYWHqFbiQQRoMQ5S0K5uIt65zsEoi
	ddlo7t654h6OTLOSzhrqUuB+oNI4SRJdFhJqbAW9A4XSc8blB3TOdIXt4fc7/LcTR4CozWZzAFX
	iicgQSNyUFMhKJpi7IHU7dxejOzevdE/0CEEzBiy0ruawUEajm6+4w==
X-Received: by 2002:a05:6a20:3d0c:b0:3a8:800:bdf4 with SMTP id
 adf61e73a8af0-3c0f0beee64mr6387057637.33.1783722725648; Fri, 10 Jul 2026
 15:32:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708193239.5063-1-emil@etsalapatis.com> <CAEf4Bzarum7QXKT+BuvBa9kSrjMX=BzknWFKQBQuROKOWFeuZQ@mail.gmail.com>
 <cbee8f83f6e11ac58afa366317d52e64473b2736.camel@gmail.com>
In-Reply-To: <cbee8f83f6e11ac58afa366317d52e64473b2736.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Jul 2026 15:31:51 -0700
X-Gm-Features: AVVi8Cek6HCZx8SraJqjeiIqLYRBxL3CVi3Cj5oiM64DJj6tLvkViVaIAORy6c4
Message-ID: <CAEf4Bza300gZu8PxspoF1VF8uNG4ihsANOMOhzZSxJHrGQUqww@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: veristat: Minimize map size
 during verification
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, memxor@gmail.com, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 2:50=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2026-07-10 at 14:44 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > > @@ -1248,6 +1248,29 @@ static void fixup_obj_maps(struct bpf_object *=
obj)
> > >
> > >                 /* fix up map size, if necessary */
> > >                 switch (bpf_map__type(map)) {
> > > +               /*
> > > +                * if the verifier doesn't use max_entries
> > > +                * then set to 1 to avoid -ENOMEM
> > > +                */
> > > +               case BPF_MAP_TYPE_HASH:
> >
> >
> > I'm wondering if we should add ARRAY here as that one is actually with
> > high likelihood will be large, though there are some corner cases
> > where size might matter (e.g., existing code omits error checking
> > knowing that verifier will prove it can never fail; resizing to 1
> > might pessimize such check, probably, if index is larger than 1). Can
> > you actually try the latter scenario with some small program, I'm
> > curious how the verifier will behave?
>
> For array maps there are several complications: first is the constant
> maps handling and second is null check elision. The latter is somewhat
> nasty, see check_helper_call():
>

yeah, I was thinking about that bit. Worst case, (valid) BPF code can
have, say, 8-element array and have all the keys within [0, 7] range,
by *decreasing* map to less than 8 elements we actually force NULL
check.

Anyways, ARRAY, I believe, is one of the maps that caused this
feature, so I think maybe we should still do a dirt-but-practical
approach, and just cap ARRAY size if it exceeds some modest size
(e.g., 128K, or something).

Oh well, capping non-ARRAYs is useful anyways, so let's keep it as is for n=
ow.

>          case RET_PTR_TO_MAP_VALUE:
>                  ...
>                  if (func_id =3D=3D BPF_FUNC_map_lookup_elem &&
>                      can_elide_value_nullness(meta.map.ptr) && <-------- =
true for array maps
>                      meta.const_map_key >=3D 0 &&
>                      meta.const_map_key < meta.map.ptr->max_entries) <-- =
checks max_entries
>                          ret_flag &=3D ~PTR_MAYBE_NULL;
>
> [...]
