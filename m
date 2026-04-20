Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD348333727
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701226; cv=pass; b=ebMT7gjlbDKl4CrXeAnS4IXbzpSgB/1KMvka3tQJaQV+lhwdbC+UNFpXeEQ3dTg+4pXtZF0d0PJ7Gvbckq+TKilMzfJHXApU9FoSD/5cgdpFpWH8ojuEX64MYpMK1+MWdSg09AMs9VmCAjssdblmSM1vM78X/tbINVWj1oyozY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701226; c=relaxed/simple;
	bh=EvewgLWxQ5joxTZgw+FsTbo3yR35VqMpfy3ReYqvn2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tibTnjOgcoO2hWlaLUzEJ6U3VrJh8u1KhP+Q8e4G8u3XphZWZRe6TrAtgfZhCSVJL+OxEqGZtCp4hBTVDKRkwWIf++wRxNvsfomnciWiyt+miYZM34Nn2NmxNAVAD0ZxRozI0eDatAbUwdQiUuY5M3tmuMZvaUZUlJpvMn3YIow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deT/u5ao; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deT/u5ao"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cff5dafc3so2735031f8f.1
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 09:07:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776701223; cv=none;
        d=google.com; s=arc-20240605;
        b=fGI3rut5Tgk58rIhWO6TFUJR3BuoQhbTBxNtYZIrnJf3H3G3+cGNLEUHojnCnfq9CD
         BjiQYyF+7OaV5AXWj9Iu+1WyRn8+BgK5UnOcDzBDps/Ux4IurNQgb/JVspu+Agdv/STc
         nmv3LIO0NLpJB6logLy17sDZQ6PefCQJeJwb79T1KwrQe2BsS9dcaDmpYkAOHAdInrgK
         wRaPTaBedr007si+hHnfvJ03G4d5YuG9pqfxAind2RugjOAsMxM8e571OPLTd0aEh3tX
         8XouKVcqeUC9NFmZesA5WxsoRpxLwYAtvrb/b/b5Q+R/iRyVkyZVBzf3K6CC6rlovwM3
         +Unw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EvewgLWxQ5joxTZgw+FsTbo3yR35VqMpfy3ReYqvn2M=;
        fh=2oxK+3DPFdU6ybQo5nC18fduLn0olzyqTH42M+3ZzIA=;
        b=KfVP6kd6P8vtLKQZ1PiOCVZMygdG4VZAjjAtv+KLPJeA8vvHRZwQeygfcRuS+BKgVp
         fYLogZiA6KbNkLlVswaiZIMDYIuArkDeU0IPIF0mQgAWganCDEF1XC6mP2DkYNMCsFiv
         3h7Xkvt9yXGHa4udlw7LCtGsWV4MO5+vwiMoNgGIvp79yRhRC2Zd0DbPEhlCylyMQrKC
         yglYNYa6jyssv0FGZEh9oTG79tBj2hmp7W0aNzomkG24VTDALhBfF8jD2GnqG7r0EhUY
         xLuSMpZqTwy5NCp7hCrEMpthkYwkBviZF+ebd5foSYRBgBYGiSVDxqIHzsvhziC8+KoE
         Oa6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776701223; x=1777306023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvewgLWxQ5joxTZgw+FsTbo3yR35VqMpfy3ReYqvn2M=;
        b=deT/u5aoIJbcIQdabU4dqmaRI0iTdPX24iC0mksZNldYP6Ha6dVwpESPWGSwqalLyZ
         Pwb5QZFP9ApwWSJWHfo55qX/qP09PCCH2gkKMTIlYz5z33xv1jNFa5fhizwTt5f9++UZ
         TOUJo5lscGCaIoxlBbKAOlV9BcjHO3+U0qz8R7cfd9t9ydy+bB4GKr1Iem/hc5UOJQ0h
         /dAyGXBlY3Kb7+5xdwf52GJ+iCs5dLFAxPinhQ7/+4QZc/U8IXbhY0AD0XjJWvo8Uodt
         8048sWJ/bOVUqU+T7ePsgcZXBITlR3L02AFkE6O8XB+5wnsgATgu+HUg958YDPxWSdMC
         JZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776701223; x=1777306023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EvewgLWxQ5joxTZgw+FsTbo3yR35VqMpfy3ReYqvn2M=;
        b=HQRBZgmFS/gv2/6VwM0Yq52tRgw2yL1TJgLiTkLj/hpz8EB+RUNHmba+kppkm6jQwR
         exMnXWthH0UPZDtD35yRvQAscQ+DEzfybYKibYkYsCSBNmpsnmYwv5np/ylXzA7oeX6g
         /k+69/mkDIKgWbruwim/PNuE3ncjsuvPABHYFECRLMfxLy9EvpDddYljzlWi1d2n/LfB
         siN16OrkkwUZHE0iwkEMu/H/4I+hepTHdg3OTj2N0jeNtOjAczCAoYfCgPOL3DzQAfcq
         OI76Zvs6yJR4jDn4S65fBKFYtp6dEnnWp7wTXFiY1gX5XHAzB6vA+vW5DxzyTIm6DYU1
         zInQ==
X-Forwarded-Encrypted: i=1; AFNElJ8mF2aw6cwnZcVaxzLwAoNU0MkwEtEIDEeFjQrk7h2D0EX+ZC8wnvu9/mNDFBAki13a4nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAuhSE2wxD1lKC4RrQsr+NvMkFRm7b/z+8tn9Ca/RtvUHXYy9q
	GrO+ORor/iH7gRZYIGQvTGj4DTh4WNTf1m9BRfVAOLsE5lt679jXm4BPDsi/UhJ0wi246TOodhT
	Il6NklAfZwEGdZmd4T+vdtGQOGyemBMw=
X-Gm-Gg: AeBDietREn4ZhC+D0YPzKcjuom1odv/HGDumGTiAsDTcZT2ziTACEIlMdnPV1ZgXNgR
	9x+DCFhWrxLJGGo63rtpSkmOZYgyiNZUMTtIqdsa5UdmD5Q5PLXX9g5iK51EqVmpFAml1dWQ42Y
	dER3abPr3hypA4ngizciq1dpja75+A98WHSJf10+s1SjEnVxdtnNjjOT/xJfbC+RTNoFsqImUl6
	EQBVvvB5QdBUlX3z9cpZG0QHRfpHNfPC1Tcw+M+PRmcbjR1kh/Ivgt2uDtuU7DE478o8E9m67Ym
	IGrW6QaK3gBlvKIy/2ZbS5S6sdt6RRU/L8BFbhIULIhBjkFrWypgnFGjzWzPxS2mABVMw8SNuyL
	joYIujp8h3vWbmR6R2Oc=
X-Received: by 2002:a05:6000:240e:b0:43d:714:34e5 with SMTP id
 ffacd0b85a97d-43fe3e0d2e3mr22138654f8f.24.1776701222979; Mon, 20 Apr 2026
 09:07:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com> <ad8Fr4jDKvp-oxAw@gondor.apana.org.au>
 <CAADnVQJCpJ0bTVPQ0LwoNubsK7-HsdePWgdMz8DX=v9cjgvyKQ@mail.gmail.com>
 <aeBxQn8ATaNuEF4X@gondor.apana.org.au> <DHUN1UJ0DLBC.3UC7SXBAV2FOW@gmail.com>
 <96b6f76e-1dc9-4d54-9f92-8586796ef607@gmail.com> <aeHZJUw-ZRA3ZWVE@gondor.apana.org.au>
 <4c0e73e1-43c3-48a3-ab89-239fed7e6c23@gmail.com> <aeLTlNbM1rH31D4L@gondor.apana.org.au>
 <af4b850f-ac88-4c99-8d66-00e40efbd4d7@gmail.com> <DHY3HII4WSJS.Z7A2V8PWG22W@gmail.com>
 <68e0580a-4002-4b9c-a003-7cf85560d791@gmail.com>
In-Reply-To: <68e0580a-4002-4b9c-a003-7cf85560d791@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 20 Apr 2026 09:06:49 -0700
X-Gm-Features: AQROBzCYhpQuK-SbrhP2bhii3FL0QapvURBZl_hjSEDKRUGe3I6s41yfViupFfg
Message-ID: <CAADnVQ+_gYx2AiqqtmyXhB8qgioKN3t1H-TgeMMWZzv15Jt14A@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 00/18] bpf: Introduce resizable hash map
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 8:50=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
>
>
> On 4/20/26 4:41 PM, Alexei Starovoitov wrote:
> > On Mon Apr 20, 2026 at 4:45 AM PDT, Mykyta Yatsenko wrote:
> >>
> >>
> >> On 4/18/26 1:43 AM, Herbert Xu wrote:
> >>> On Fri, Apr 17, 2026 at 04:16:34PM +0100, Mykyta Yatsenko wrote:
> >>>>
> >>>> Changing interface is practically not possible - this comes from the=
 bpf
> >>>> syscall.
> >>>> Linked list solution: we probably can't afford it performance-wise, =
it's not
> >>>> worth it to pay for the linked list maintenance in insert/delete ope=
rations,
> >>>> to make traversals work well.
> >>>
> >>> What performance penalty? The linked list is just a pair of pointers.
> >>>
> >>> Memory-wise it'll be two extra pointers per node.
> >>>
> >>> Cheers,
> >>
> >> I'm concerned about pointer chasing, when we inserting a new element t=
o
> >> the list or removing existing, we'll need to update pointers of the
> >> neighboring elements. It'll be nice to measure it, of course, let me t=
ry
> >> to prototype it.
> >
> > hold on. let's not overcomplicate things.
> > We only need to notice that resize happened, right?
> > In such case just ad generation counter and let resize increment it.
> > If it changed in our iterator -> ERESTARTSYS.
> > EAGAIN doesn't quite fit, since it implies that immediate operation can=
 be
> > retried, while here the iterator need to be destroyed and recreated.
>
> I think that won't work with get_next_key() because we don't know what
> generation previous key was read (in API we just get prev_key and return
> next key).

The first one starts with key=3D=3DNULL.
