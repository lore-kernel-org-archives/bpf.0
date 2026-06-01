Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1071D3126CA
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 22:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780353374; cv=pass; b=nRPIz87VOkHhA1p+djk0Pr8XY6dUNHfVHWV9vQWI75TwgrJNcB/K4diqMosxgRBlnsiB4YSjX3ZMGPpd+fr6xm+SNiyB6DdfEjOOia4OiqW9A9zeSORA9GGhwvS/cLhroNZi3Nvfp3+LXXkj8QHRQYVkwJQNTxA4KyDTP/7Ndxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780353374; c=relaxed/simple;
	bh=qShT15SiklauvTxBI3HDr3S2EIVD83CbuXS1PnSYHwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AoAt3RIEryWwcjMBJPVKjnUVVAJvOpSp+GIC3iuDftAc3wi3HWCcNsaaUTrDc/palmu85WbdIew8fyGZAYVoATCPzk+24eHK+1vfTlYcNbGXV3OUl2NnIk6tTmEnBOTi9/uW6XVFWpu0zdxcO7fjO5AaVo9ZxtA9FL0ns8I1bcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o4AAvY/l; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4AAvY/l"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso787565e9.1
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 15:36:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780353370; cv=none;
        d=google.com; s=arc-20240605;
        b=TR/r0BQJvy4JMDWUxPE/VDI3L7jvBCDYCHIIf3cOLBucXxcd7P3YB2pM27pGSuG3Vv
         Qsc15UAyLqB4S3JT2dT+ZYFT/S+vEYHhTrt4FUCUGg0RqBv2a5Tkn6Zx5RNM6NUWl8DV
         zAHDYQUXM+4H2FBFyXOn/UpnPk5jtEsgRVh0QpQtklTvLIkddp89FXf4v59Y54I/agSm
         7Db+LD9Rfh1nirKqeio4d3Sy/xjFQSSufZ6DyEWwbfvXf0zT8dxBqbxSIvjRNeiQVEsZ
         eL/4SNomv8uljVxvcDkQh8gJY6m4akOYHABiRbVvk3sC/LUGJyrJ+XJ00KhxtlWf8ZOv
         qSsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HLFcaG3D1qUmnaU8KnhhzIi1V2WP+UuBdpZV2zlitg4=;
        fh=EUZ2Iy4FC4BpBWQ8oLqano43TyLbHtCqZ0NHQdZDXxg=;
        b=LlWChRtkb5S7pXsF+vYmTXo6hR6Z3VVK4QU8jdtjhKKJclbmhSXjolFPDDuUEYK6vu
         njkN4MPv/sFTxE8t/twZEC1k12/z9YpUArSlDygxnNkqLFEVBGzOhEOqKaxgRCyfQh+i
         xy1nCb8+iCRD1fcQqGQ6VdYkQlHen+RlIGXyUZw/7bVkxUa0U3/ZQGMsxuIRueq5oGpu
         ARN+Wq8dBcLp1BvTgWWLkmo1bVFm1/A73TJBhsN/grC1WsioiIEfj1IWR2h4GWigBwDD
         x82y1Nl1FiohDev1oMx0BQcf7BMHI5cqtvmXSqye4pGTpl169IfG83ht/W81oVlwzBxi
         5yWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780353370; x=1780958170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLFcaG3D1qUmnaU8KnhhzIi1V2WP+UuBdpZV2zlitg4=;
        b=o4AAvY/lrmvnvbxme7HUDd35mlvBo9PaEd4M80L+JAv2k7g/ykn3kO9iATJGSxU35/
         gxSly3+7f97WQIlcePGovKpjfhev51M5YX69mAvNxsu1sgA6bGgOpj0c77bWKtKrSkvX
         hgjKsJ/NXzLbHJ/jEm6AR+C2NA8iuIgWhwhzIlW1RUOaIxGE+dQhXQvUzIEpc+QjSko4
         +kpWfGmM3dQWopmsRUU2etOhYDZg5pjlvTeYuZgvUiwBbq89KwFEHasSjCMEY63ZIaQc
         E6ykJV1dfBftylypTA43pHs4SFHbJPCZVW99U5AsM0NabSTon5fmpRPXwhvSSUeVFySI
         BK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780353370; x=1780958170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HLFcaG3D1qUmnaU8KnhhzIi1V2WP+UuBdpZV2zlitg4=;
        b=SHRCc9rJSGkfOMaO077aya7lMlJSeQDg7pUULofz7u+1k+crANez+0g7bld+lT6woT
         8EFIKBbeqZYuGfMrElQQI1eeEySlQAR+6wgkRqMBauTyOL16xYFVm2RqJcRCi9n31d+L
         B7PVBANzyAp9h9KfcDrmjYzWOsjTgFoXvVFMJDdY062ibgEkSJXLLA/SzalZ7Dzrkk3g
         +un+NjZvBaA6yAzL89ZFYsKxlBhl3XMBQfVlZ32HCnNUbi28Gg9pwN9yXZM8nGND4axY
         H1UfNNOtG/XwyEYHHAPTNRx0WMNfKznm/LRsSum5+ZB1ZEuYAhKYV3bYhOkGKYFm0RcF
         DCRw==
X-Forwarded-Encrypted: i=1; AFNElJ+tBWd1clj7pv55MTsIUU52BHmnjpj9Hx+W9UOl/csly+Ei7KgTsXkDUaVbfkG311bp7B4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcfRZVROK450ss410TqNe6HI55M9Nt+13R1eLAoGjLezSqYnVQ
	6f2J7y81D8kSS94ba9mJB7GGpWAC94dMMMw6gitFxQdG5OFqQWELGVpqZp9LijBqWMVvXEiBBJG
	gI6Q9EoNBVd/Ph3JX6xou9nHvs1M7Gro=
X-Gm-Gg: Acq92OEiKAk0IjV5s850AaQLb7WwD8Doh9qc9huFQNDF++gk3zL1rnTYm/WTI73hcE1
	WdzyhLQ7CJ8kL58MOAm8vWNhZvKCjOmks5gA5O150V9GLZquHkYFjHuZNM5ml7d2lpVSNshnM4e
	zvVG2t9kcSqMToGRKvMZL/CaKuXy2OGHY7sBodcID5XVKLRqYI4C0zfUHLi7MLXKlMMaS7XTeR8
	84Ool/u92P8bz42vshts9malmdgjt/RG6txtepH6XuGOlA2yjQ0Y69cp0jn7eKkkmACCKL0OASI
	iU3xjeMxtl/BUFAWi4dVnijh9jp9TLo/PxHHFX0ralhq40Y6bohBlZQGAzj7zj5g6dINRQgeIl5
	ZgORsf81kak8j2cFNaZyyjQJq8ieyxrvoZrff
X-Received: by 2002:a05:600d:8648:20b0:490:9d5c:a3e0 with SMTP id
 5b1f17b1804b1-490a29215ebmr177131975e9.9.1780353370288; Mon, 01 Jun 2026
 15:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529014936.2811085-1-ameryhung@gmail.com> <20260529014936.2811085-6-ameryhung@gmail.com>
 <1bf1a11fa5dcb38287384833dd77c748f3a766b7.camel@gmail.com>
 <CAMB2axNK9rf12YyLjfeUHWUpGEf=UrCtdHcgd2Tq6KcFY1ergA@mail.gmail.com> <37d229e482df3367436d9475d6e9d6d69c7366a5.camel@gmail.com>
In-Reply-To: <37d229e482df3367436d9475d6e9d6d69c7366a5.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 1 Jun 2026 15:35:58 -0700
X-Gm-Features: AVHnY4KEYaxT8t9axx2zREthu8aAqw3RqhNq0eCCwFyCqA_jHNC70gOnb66EEkg
Message-ID: <CAADnVQ+K_=xz6f3Czoj6f6AeO6Bh0eyq-ambF11+hYq7DZq15w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 05/13] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 11:41=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2026-06-01 at 11:36 -0700, Amery Hung wrote:
> > On Mon, Jun 1, 2026 at 11:00=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Thu, 2026-05-28 at 18:49 -0700, Amery Hung wrote:
> > >
> > > I think refsafe() needs an update.
> > >
> > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > >
> > > [...]
> > >
> > > > diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> > > > index 877338136009..5945956a7573 100644
> > > > --- a/kernel/bpf/states.c
> > > > +++ b/kernel/bpf/states.c
> > >
> > > I think refsafe() needs an update as well.
> > > Something like:
> > >
> > >     --- a/kernel/bpf/states.c
> > >     +++ b/kernel/bpf/states.c
> > >     @@ -886,6 +886,7 @@ static bool refsafe(struct bpf_verifier_state=
 *old, struct bpf_verifier_state *c
> > >
> > >             for (i =3D 0; i < old->acquired_refs; i++) {
> > >                     if (!check_ids(old->refs[i].id, cur->refs[i].id, =
idmap) ||
> > >     +                   !check_ids(old->refs[i].parent_id, cur->refs[=
i].parent_id, idmap) ||
> > >                         old->refs[i].type !=3D cur->refs[i].type)
> > >                             return false;
> > >                     switch (old->refs[i].type) {
> > >
> > > Wdyt?
> >
> > You are right. It needs to compare parent_id, but maybe only for
> > REF_TYPE_PTR like below.
>
> check_ids() should handle the case when parent_id is zero correctly,
> so I think both variants are fine.

if that's the only thing, maybe let's do it in the follow up?

Eduard,
are you Ack-ing the whole set?
