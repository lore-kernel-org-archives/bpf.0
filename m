Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2532F3655EE
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 21:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005475; cv=pass; b=LrNOJfurUAz5yYNBty4t0oifS6DXHcz2EJl0zQLGK35jj8kJD2BYyQsMDv2wVgk2GzJcCKZ9O7pqTZxboA+2L/ps6Q/G3j9Uru1o6M+7dPOmSrdcmDWAlXeBWCK1EzgdvcOSCAs1+YHOoa0xwAaB350+0ztqg7la1GwBNiXWyY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005475; c=relaxed/simple;
	bh=55izBCS0ULu5X7EDhIAAQYMQNf5DpBvMNi50t2ZxSPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odBGvT4l+n2oByDXUFxecBLeKeGEndzAQjYyNDXGhkwPPtc2Z01SaX4RjYRjqnurhbahlbK3JF1DRJaw9Ht2nTqhCyjLDiR0dXmLOb9xHrUUs0X8uGaAQxSwrSJ+3qRXZfOB2Kg+o8tu0+/Nc9tjBoaz8JsrqaCBQ2OSkAWCt2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oyHxdE1R; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oyHxdE1R"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c8571b55c62so109438a12.2
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 14:57:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780005473; cv=none;
        d=google.com; s=arc-20240605;
        b=G7tzX4VZFRjDRqhbGS40YgwsXo8X4VxSeGX5FVsyzvl1F+Yjy88Ffm1dYo1GRwXg6z
         inmZbM0diL/5VopPPVyBVa/7lD1x61SMZQWqrqjGeAHH+zWLd78JjuhkqFUL/k2ncNwk
         2coGnfkrnGRocrRCrx7YTJ+Eifk3d4Y64G0Kn1uWmXk6TcfANYdAIt/a1+OgtMPX2/MP
         SOwzN1rs8nuNT1Qdv/DYZRM3xPOSW4xjFMqy52aSdTayQv0X4OyGj5+mkNsEOVrBvb1E
         dafh5NPQzrmomkpjPRv8yZUl6y3YM0YROePdEz6ghWhsKUrF7Zsf9M5EIkHoivYMkI7+
         dnrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uzFqyxh3L/iAvyLZ4yJ/GetZ86UQ07RZVWV8gwIxKf4=;
        fh=V4e1C3/kkZcPobk4HcaQX0HHeD5CEWUvu6TukmMGmD8=;
        b=aqadSNnfYoWJm0Azy92ISO8bFnf5a3Nvy4/C0ULJHOlZoIi67nXikXjaKZwn3dT5WM
         EI8oYPsx1AXUPrS44chmHcRInaVXqbCfFOnui76NGtfb5yKepnCYW0fDaB2gjfmK8oLf
         Cvs2+4rB6myqcWWXHbHxz+gRRTB2BSgdS2W1o+duLa0joRLUoWj5V8dU+DzE2lzEJj/1
         CjfLDS+1nvSfAEOzeq4u13leysuFoxDwf9dMW3Fuy6VM8e/J+99Peh3ZCnrCZfTlROq6
         Iz4J95M+mJQnSp/YD3Pvows4m/4fzUbkTOcTmc9wMWUmZZedpOyP0i4+9FENnDcNXtdk
         UEyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780005473; x=1780610273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzFqyxh3L/iAvyLZ4yJ/GetZ86UQ07RZVWV8gwIxKf4=;
        b=oyHxdE1RN2SkpW9mt3HciIjf+mh5qIVn84cuiMFdx/SpLqGNUTaYuLuC0wn6AUE7Zl
         TC5iBnpjjJ2/cMQytJEQh8SDcGkLH1/3QdUqnGj8U3yHdsaET4JmP9khNQwei0NhhAnd
         Xg2EJAURxPgvsHSSh40hqlOmSyUjymowd/vrMoFx0Z5/lyDLYn5ZB+FxIyO5UC0flYyx
         uOoG25qMCECi+Ib4Tf8DkPpwFpiyRxcQ3acIHI6QmriAcrmw22GewMI9RFAWy6rO8aN5
         1xBanhW8ZYc3Hb3hKNcmRIQda71EjjTGEZm7zZChYnqJyf43/t0KIsV6Z6tUg/MxG/hA
         r4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780005473; x=1780610273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uzFqyxh3L/iAvyLZ4yJ/GetZ86UQ07RZVWV8gwIxKf4=;
        b=Jd7ZzUNIaD0JuPwtEUeo7pV5drDsQ4Q6eNYNNxfS2sIRaW1uzar8OZGHegRtvpClJS
         vfSGGL9PYKx5eJXClTBkvWTITadAQs2MaCEXDb17cpvydbowoo83VNU9aY6frc17LoG4
         TyfrgrMeU3W9urvKfO+ut06eNXrj5XtQOpNvaENTjWgaEqsLjNEhFQcFnAGsSIooSeqt
         idi/IBNZuerE/Uu68a1/GuCYJsMjedPaxreraE9Ev4vyxujURTyEy3udNmRvneqLwrfX
         D3D8g4V1MggIYdNVa+UB0gnu/X+RHpwq9/i6auTbz6BiXYoYaVxSwH29hrZSJBtvSj4r
         Eq8A==
X-Forwarded-Encrypted: i=1; AFNElJ+7AUyHN4FwaTbPYpQfioIBB1XFNZW5z4GU6LE4MGF0g011bJ1n2c69fOhQF4WLuwYgcHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwamLPTKg4vjOxWrzw28XCe/Dw5BJ/anVD9bYBYC5H9UGoCUMa
	uZRVfjzNEFylZ0DUmW9oXWXOPOl5au3sRqxNVSLI04x7XTu5chTrx7Hu6HmBaYFVIfUIpLPvWmA
	YMz2aGJqqmOUqXxrquDn8bDnubmDKyz4=
X-Gm-Gg: Acq92OEOiVcfoi43sXp/GYmuz0KgY1fZqNRC+SSrNM/nRZm5udF8pHV1whYn/zApG5X
	j/pGmeM1dgMj2FG6GgffyMWDmFYRfwu7QKtdwtNjvo16ldT/GZcbN2+4HNo/OIhtVJ0CVDQEy2X
	Bq5RtqB+7X6iC1Po5pMSrSFvVPARw8AGhZUofUv9nUpJJyj12VagStpW02E2JaeXwQ6BoM6FLzK
	5xlrR/C9kdFCg7nXDg+VK2Fa1ZeJnVE9fuAN2VnNiOkYx2sRlZjVGEJzBicoyMi9QcwJKMW18F+
	Ey7MyXjKMHLWFo3rvR8n93Nphy68ZQ62kw==
X-Received: by 2002:a05:6a20:3d1f:b0:398:6ea8:21f7 with SMTP id
 adf61e73a8af0-3b40e2ba0d6mr598348637.15.1780005473443; Thu, 28 May 2026
 14:57:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525223948.1920986-2-ihor.solodrai@linux.dev> <20260525231131.895201F000E9@smtp.kernel.org>
In-Reply-To: <20260525231131.895201F000E9@smtp.kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 28 May 2026 14:57:37 -0700
X-Gm-Features: AVHnY4K_aSygySixQkU72_cESDqzjmlN--ZwQHl-ns6g3Krx5XdVGyj4R5PUexE
Message-ID: <CAEf4Bza2fRDGhLQoPE-EzM7F34xaEJfi5Exmxb-iWVUN3F06=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 1/3] bpf: Factor out stack_map build ID helpers
To: sashiko-reviews@lists.linux.dev
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 4:11=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The refactored VMA caching logic bypasses the cache for fallba=
ck cases and evicts valid VMAs, directly contradicting the patch's stated g=
oal.
> --
>
> commit e38559ed451d61a994765f3bfb260cc14edd3569
> Author: Ihor Solodrai <ihor.solodrai@linux.dev>
>
> bpf: Factor out stack_map build ID helpers
>
> This patch refactors stack_map_get_build_id_offset() to use helpers and
> continue-driven control flow. It also attempts to optimize VMA caching
> by updating the cached VMA on the fallback-to-IP branch to prevent
> redundant parsing attempts for anonymous or failing VMAs.
>
> Link: https://lore.kernel.org/bpf/CAEf4Bzac9uWWqBvzH0iFzKvJcq3vxscZ3pKm0s=
UHmN-F-z9wVQ@mail.gmail.com/
> Link: https://lore.kernel.org/bpf/226398c1ff3f2b686c0aeb010408d85fb15df13=
f9ff60a045bee31e79b9e41e9@mail.kernel.org/
>
> > diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> > index da3d328f5c15a..e23be7d445038 100644
> > --- a/kernel/bpf/stackmap.c
> > +++ b/kernel/bpf/stackmap.c
>
> [ ... ]
>
> > @@ -165,44 +187,45 @@ static int fetch_build_id(struct vm_area_struct *=
vma, unsigned char *build_id, b
> >  static void stack_map_get_build_id_offset(struct bpf_stack_build_id *i=
d_offs,
> >                                         u32 trace_nr, bool user, bool m=
ay_fault)
> >  {
>
> [ ... ]
>
> >       for (i =3D 0; i < trace_nr; i++) {
> >               u64 ip =3D READ_ONCE(id_offs[i].ip);
> > +             u64 offset;
> >
> > -             if (range_in_vma(prev_vma, ip, ip)) {
> > +             if (prev_build_id && range_in_vma(prev_vma, ip, ip)) {
> >                       vma =3D prev_vma;
> > -                     memcpy(id_offs[i].build_id, prev_build_id, BUILD_=
ID_SIZE_MAX);
> > -                     goto build_id_valid;
> > +                     offset =3D stack_map_build_id_offset(vma->vm_pgof=
f, vma->vm_start, ip);
> > +                     stack_map_build_id_set_valid(&id_offs[i], offset,=
 prev_build_id);
> > +                     continue;
> >               }
> >               vma =3D find_vma(current->mm, ip);
> > -             if (!vma || fetch_build_id(vma, id_offs[i].build_id, may_=
fault)) {
> > +             if (!vma || vma_is_anonymous(vma) ||
> > +                 fetch_build_id(vma, id_offs[i].build_id, may_fault)) =
{
> >                       /* per entry fall back to ips */
> > -                     id_offs[i].status =3D BPF_STACK_BUILD_ID_IP;
> > -                     memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX)=
;
> > +                     stack_map_build_id_set_ip(&id_offs[i]);
> > +                     prev_vma =3D vma;
> > +                     prev_build_id =3D NULL;
>
> [Severity: Medium]
> Does setting prev_build_id to NULL here inadvertently defeat the VMA cach=
ing
> optimization mentioned in the commit message?
>
> The commit message states the intent is to update prev_vma and prev_build=
_id
> on this fallback branch so the cache reflects the actual VMA seen. Howeve=
r,
> the cache check at the top of the loop now requires prev_build_id to be
> non-NULL:
>
>     if (prev_build_id && range_in_vma(prev_vma, ip, ip)) {
>
> Since prev_build_id is set to NULL on failure, won't consecutive IPs fall=
ing
> into the same anonymous or failing VMA bypass the cache completely and tr=
igger
> redundant find_vma() lookups?

yeah, it seems so to me... we have prev_build_id and prev_vma, we
should set prev_build_id to NULL if build ID fetching failed, but we
should preserve prev_vma always to avoid unnecessary find_vma() calls.
And if it so happens that we have matching prev_vma, then depending of
prev_build_id being NULL or not we either set absolute ip or
build_id+offset, respectively

Let's do a follow up to improve this, nothing is really broken, I
think, so applying.


>
> Also, does overwriting prev_vma with the failing VMA while disabling the
> cache hit (via NULL prev_build_id) evict the last successful VMA from the
> cache, potentially degrading performance if stack frames interleave?
>
> > +                     continue;
> >               }
> > -build_id_valid:
> > -             id_offs[i].offset =3D (vma->vm_pgoff << PAGE_SHIFT) + ip =
- vma->vm_start;
> > -             id_offs[i].status =3D BPF_STACK_BUILD_ID_VALID;
> > +             offset =3D stack_map_build_id_offset(vma->vm_pgoff, vma->=
vm_start, ip);
> > +             stack_map_build_id_set_valid(&id_offs[i], offset, id_offs=
[i].build_id);
> >               prev_vma =3D vma;
> >               prev_build_id =3D id_offs[i].build_id;
> >       }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525223948.19=
20986-1-ihor.solodrai@linux.dev?part=3D1
>
