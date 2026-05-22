Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFC935CB6F
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470277; cv=pass; b=V36KMQxrSKV5xh8xXUh4Mv1TUhDtbMTt2AxHNHjyQRBxGhfT8ZmxkjH7wleS6fj+sG1ER9bIVcgyMGo5o5EiYWGqxuz6WtTrRpznxMQgdrS/rO90wnvhzum0vp6Xr1N+MXqLbFgnXUk85Ov8t8rxmfUjEF83olm8DtbUIAe41ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470277; c=relaxed/simple;
	bh=Np5IA5KDeH2lFuW1e5XC526o0Q+R7kgdyXZD6YFJ8xA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSPfyAAaQgUhqerIL4RFUQuFmGRlhgeb2gwJ0tfWvy3n7oXSkyGZgB9wqNzlskElHrTil4AFiOqTN8BRIF8ShCq5G2r43IWd8kSP5tXHJEGIVBuDlNI0c0mYniy/Uh9KroR9TaiV8Tm9QHRHsKUXwKUCSjeRKRflfBLQpao3jhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pK2D6taR; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pK2D6taR"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8353c9f24d2so3956784b3a.3
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 10:17:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779470274; cv=none;
        d=google.com; s=arc-20240605;
        b=ZDPXqWnjEymzAsnf1lYdalR4dCbwdZ3YzufI0tAK2z9f5xmuOpq9rEC19gqywP9u63
         6fdXV9cJvSjmriT5IG1+s6MaUhE7tSPAeBU/mfe+cXeeA9Vs8NsIm/pO/4sIfhoCaE/q
         gyAt8l0G9zfHNK4cCVjyQqww1dt5AflNsw49T+pNw72fJM5IOW/nelnY1ljxVsN1jFW3
         IZcSmLJdz+TDriVM4xCorGXrbW5X3pTTB3V0VUSnob7ejGrpInD90FXapd4Oi051iEc+
         3Kq/Hxq4phWQH31ofJA83hKoSFE5yW+hyTmQkDzWyoqQY/bZA6tyHBHl7xelgdWbz6iQ
         gvbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/5I6FIDi7VE5vcduNY8wcjk0wGTtEt3rDyHZgwG+GZ8=;
        fh=ZL0TrJdAy4yLczq1qvrYyUUzhywYiQ+NY/7kCFlS4cY=;
        b=iYDTjYrfY3D4nuuyZW/5PPQ62GRSucbGOGnpOVbqwduRn7dMEtOnqXLRB/6F/pA8lB
         yp1wrah2OXINqHt/p9Y4O3hRv4PT5mZbInlXUIQylD50AdLBZsRgT846I4OSceXGLSuN
         JnNNDW3YChtj1fOeJFH3tI0+9lz9UiJavZ55j5SkZJKO1orxWuGNubrnb9LpNYSZTJtc
         B2RPrTR3RcdHOevexK9/95u4e9dFtsDI3ntDDM/wUVE2M1dJvSuYeV1g0VW6QP3T3JJ4
         VSg2gvXXM/CZS7gjBrSlMYLoSAscrQ0ZoFucTj9QQlkwS6rKvHkJ1wjtTXO4NTLaWaAv
         Kp6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779470274; x=1780075074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5I6FIDi7VE5vcduNY8wcjk0wGTtEt3rDyHZgwG+GZ8=;
        b=pK2D6taRqt9Vw8oi2IB+JU6SrqOTWRAFJi9Z2mK8gJYc0d4b2mIdKqCtyoPGNEtRAr
         B8K5CpQBw3Pox8g8bwjMVhfIt2pcTD/Nuq9hfdqNSYhvprn0x5+uTEia/YNCZEMZ11m4
         bGRa5qLCfvNPTJFpRbpB4qXfCNn483KESYu1Y+0GZBauTIJLbmzyIUcePqmXL4gd9BwI
         0OBB5tjnvhg3CJEXqEEvGt6oTs92T6U+ABr6F8xBov2rNymmL5zTT5q3ybMPHKO4m8KB
         Ab1K8kxnCnfS90urVlqcLVZTV5WFg2HI89h7Y2zpNett/gRPZ8pKvAOet9f8211cjuBa
         /r6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779470274; x=1780075074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/5I6FIDi7VE5vcduNY8wcjk0wGTtEt3rDyHZgwG+GZ8=;
        b=FoLUv6AaApH5xdbDgH/qOV75/S140u8XFhDIMakrRd76m/GFwOriAdjZZps60RPJQ0
         RDc94/ddR8Fg7wDxyKenqe7ujdM8O61+eoTh7L4so0FCt8uJskI5x6CHs3F8fan+Mu4p
         sJyxCC1ven3AGDeFE+h5UcNz63AA7MTmoDnkmMh0jgmRpBbmlJd5diGnrfYmD5Pmu8Ow
         gFd21FjG7CPVpUp7QevWUI8FOv4VzDM2kubApuwfsnSM7yhDFRajTOkVtGu2nyQUY9BE
         wuE+5L/78wWgEMi5yX728bbfReVbAHZMwBinP7cp3QwwzgAAFJCqLFAhLg+NxBg6EOz1
         EnkQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Bn06Rs6EEJy7sFY4sD2t0Dia6uAb19/0zgQk2MVZpWnITkYSDaETEYXi8fCEsTy8vnhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbrnBtyadr3kAlWZYgi8wfkSmkiJt6b0SzsQsRXPyzsPf3Ua8Z
	ELRRcY91Y8ODY2ZuteORUSg3zF+SkNRt5R/gp27zEUWIUtIStTaSkMLP6qjHBqdbWE63y9M94Ar
	cht4PRPTaWpLd/FHfbL1L3xSHalSXx7YNiw==
X-Gm-Gg: Acq92OGBNBdlmpqE3c3UliLyqr5yTGipqaq0Zqa4oTepEfuUiNwKQvHc8tezE5WjCge
	80Pp7Wj9UcdYxZp3I5rSK66nCTI9Wfkye0noCG2BndVfQbT5PQUpV3JtLOJ9idvXko0dZrKr6W1
	9w33C5hT7v97P5gHEpbhmVArjPWA7zfEgRZm7NLT5aGuCQ4wIM1yjGKGdmR6vFs0cC7jl2OhggB
	8cC/vQJd0c8sPacb+4BD0V7jkzn10C7pp6NNHstlcIaEsNqkW3slPZK0y/z3K6zZxCA0p8KiPfY
	c/Swoc8V67TH5ePJMwYyHEQ=
X-Received: by 2002:a05:6a00:908b:b0:83d:446c:2a8c with SMTP id
 d2e1a72fcca58-8415f406c9amr4569522b3a.25.1779470274180; Fri, 22 May 2026
 10:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521225022.2695755-2-ihor.solodrai@linux.dev>
 <20260521231600.E14FD1F000E9@smtp.kernel.org> <8818c106-1e8e-488e-8da4-98c6b079f8b9@linux.dev>
In-Reply-To: <8818c106-1e8e-488e-8da4-98c6b079f8b9@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 May 2026 10:17:39 -0700
X-Gm-Features: AVHnY4J0Pqsv-bFnIsqJvEAa7VmXyLd62vpDQYDKfSDNypd5i5bA5EI3wU1FMA4
Message-ID: <CAEf4BzbdxNG4ST4sv6BLT5BuE108ziYhNj58m0O8UTtsKTjRtg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/3] bpf: Factor out stack_map build ID helpers
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 4:33=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 2026-05-21 4:16 p.m., sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [Medium] Data race and incorrect ordering in stack_map_build_id_set_v=
alid causing stale reads
> > --
> >
> > commit 4eb2cc8713ca7f31dcbc75f5166e94dd60761e7c
> > Author: Ihor Solodrai <ihor.solodrai@linux.dev>
> >
> > bpf: Factor out stack_map build ID helpers
> >
> > This commit factors out helpers from stack_map_get_build_id_offset() to
> > prepare for adding a sleepable build ID resolution path. The commit
> > message states there are no functional changes.
> >
> >> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> >> index da3d328f5c15a..4c753e02c4159 100644
> >> --- a/kernel/bpf/stackmap.c
> >> +++ b/kernel/bpf/stackmap.c
> > [ ... ]
> >> @@ -152,6 +152,28 @@ static int fetch_build_id(struct vm_area_struct *=
vma, unsigned char *build_id, b
> > [ ... ]
> >> +static inline void stack_map_build_id_set_valid(struct bpf_stack_buil=
d_id *id,
> >> +                                            u64 offset,
> >> +                                            const unsigned char *buil=
d_id)
> >> +{
> >> +    id->status =3D BPF_STACK_BUILD_ID_VALID;
> >
> > [Severity: Medium]
> > In bpf_get_stack(), the destination buffer can be a BPF map value that =
is
> > concurrently readable locklessly by user-space. Since the buffer initia=
lly
> > contains the raw instruction pointer (ip), does setting status to VALID
> > before writing the offset create a data race?
>
> This is a good point. Will fix in the next version.

I honestly wouldn't bother, this is a misuse of the API to
concurrently write to the same buffer from two independent
bpf_get_stack() calls. We shouldn't guarantee any sane behavior in
this case anyways.

>
> >
> > A concurrent lockless reader polling the status field might observe the
> > VALID status while the union still holds the raw ip instead of the corr=
ect
> > file offset, and before the build_id string is fully copied.
> >
> > Prior to this patch, the offset was written before the status. Could th=
is
> > reordering of assignments cause concurrent readers to observe stale dat=
a?
> >
> >> +    id->offset =3D offset;
> >> +    if (id->build_id !=3D build_id)
> >> +            memcpy(id->build_id, build_id, BUILD_ID_SIZE_MAX);
> >> +}
> >
>
>
