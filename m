Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02ACD529
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 03:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710474960; cv=none; b=dgkwj/lRoHOCDTv2SLKQBL75CFQ/+HZOmQncZcOdG1SNKa2ahIdmhbC/EhgKtx8NS8foVaDCeHbHYQa/lxKeT0EsZZHCB7xU+FC9djYZ0hFBaqF2QaMu8f8iNrVe984ds9HyNSrUKy6qzWCKdR5El+/KV9i48IRnVCmR2wxUe+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710474960; c=relaxed/simple;
	bh=PHAxwb3ZBfrzaHjHDpl+aWoG68qeMxqn36eMYyPPn4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBe4F5NOMuwFQhWrOcTMGKRDhXxuxCFddyASw++vy8lxFy4iT6fHg3zDPNHaAaxkwhHOE+Z6VJsHDRwJZcnffHp2aP4sj2dsaXjdywa95Y1WuW8BVcp6gFOLkPKepMO18DAySXwTIuDrKDxC6dKYbw1lPGfl0VhCnRzU5HT/AQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjW7bLDK; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjW7bLDK"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29a5f100c1aso1077157a91.0
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 20:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710474958; x=1711079758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oS9Y0JjGKaauA2RLkTASnFEMLhHjNoM/YcVX0YtE/Ko=;
        b=hjW7bLDKwzPZdjIz0mDoRjzaMXweGsaQET9uEgv2EHQjZfH4zU6s1lNf0yeq9SSM9T
         XcDjWrC5qlyoLYoehFAfKxg/7mCVicG82+ZQ2NRgeqSoX8oQ8TsdR7Ujg8IP/MVMEWnm
         Smq52SZLvxFRtqw6QOP7a5dLrBGxSK/vFXvRmFAHNtZCg3RKNSxKmtsZsTDy4zOHdKqp
         hHcdI7Mash+5DjnMqE+afJwgCkYKo8uT3HJIln/F9/hASzza9fWJ7lGgSf6Z01okbYlb
         x0deOYEmMYEXIE/bZ5n8IJKHhF8KXQKR+daH3uYYpPMc4OZeH6PiJVGzAUsxGAT7Y68j
         bERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710474958; x=1711079758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oS9Y0JjGKaauA2RLkTASnFEMLhHjNoM/YcVX0YtE/Ko=;
        b=mODFT9CE2GH0kmUPXmLMXFzoaG2n6nX3VlM2xTiS2P5RMCxh1RzOKzTBxqGuAcCLpk
         XU8hxuJMiJy6i4YY6/KICnfEgq10ua+wK0cOnPEFKa238ccKmKX5WN2HdI7f+YeG3NHX
         s9pxqfJLKgnF0hXtuOOYnx6QSQ+0ir16Q5MiZHfukKQdtEmFtEHosy4Jm9D82vr4nWan
         /eTOGIgOBpt0eDHBaBJ+ANiasb7/kF4ZA0JqZSLfSjSxgW3qiTWGoHn1C+nRN8bmy773
         VBngXaLkJV7p1Z9NpLZRU2p3sIOK4w1dLfu9rs0uSaDRh+pTUitnrWX9j9ehlK4H0GGz
         4+KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhuofrb1ep/iX++mJvGQx5bKlMGWcJkQsLp/PDjMBSQezvcgja2rxhHYbBEcgHtDDEsUUPRG+tvps4Ec8SJnBdlj6y
X-Gm-Message-State: AOJu0YyE0R3L4E/bOGtXj9PTQvy+b0gnfcBr6BWlNSbg2lIls+nxv94X
	52LbAZoubLYuLxJxx2zjyyqw27OEkrqZVlEesM73gHCrmXT958xK22juDqC0raBBAxfy3JkPLAq
	rwJLqSq4/uXUNIc9AFpBiW4Zx1JXJAsCr
X-Google-Smtp-Source: AGHT+IFDOHFlyZ3ZdWK8tw95va9xVETSDhCPWh/Mog3nKcFQCP9T7ydRAgoUHeIRzgDk6pXLInaEupAYupzU7QDRXYk=
X-Received: by 2002:a17:90b:a18:b0:29b:a59:a12d with SMTP id
 gg24-20020a17090b0a1800b0029b0a59a12dmr3565982pjb.25.1710474958175; Thu, 14
 Mar 2024 20:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312222303.2305873-1-andrii@kernel.org> <CAADnVQLBciwQ22GE1z6Sf-r+V8JRDfMjMVQWburR_pPgLj9XZA@mail.gmail.com>
In-Reply-To: <CAADnVQLBciwQ22GE1z6Sf-r+V8JRDfMjMVQWburR_pPgLj9XZA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Mar 2024 20:55:45 -0700
Message-ID: <CAEf4BzYwpFh9LTHW2s9G=mgyKcPZO9Knu_EYrgwPb1h=SByuXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: scale benchmark counting by using
 per-CPU counters
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 7:33=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Mar 12, 2024 at 3:23=E2=80=AFPM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> >
> >
> >  static void trigger_base_measure(struct bench_res *res)
> >  {
> > -       res->hits =3D atomic_swap(&base_hits.value, 0);
> > +       res->hits =3D sum_counters(base_hits);
> >  }
> >
> >  static void *trigger_producer(void *input)
> > @@ -42,7 +72,7 @@ static void *trigger_producer(void *input)
> >
> >  static void trigger_measure(struct bench_res *res)
> >  {
> > -       res->hits =3D atomic_swap(&ctx.skel->bss->hits, 0);
> > +       res->hits =3D sum_counters(ctx.skel->bss->hits);
> >  }
>
> It was zeroing counters before.
> Do you need to zero them now?
>

sum_counters() does zero them out, it does the same atomic_swap(0).

Or are you saying we should switch to having cumulative counters and
never swap? Because it should work as well, but it just requires a bit
more care in remembering old cumulative sum and reporting the
difference to `res->hits`. Probably not worth the hassle.
