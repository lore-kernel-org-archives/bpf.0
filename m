Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3C736921C
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 20:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297287; cv=pass; b=nUJ6fqNqGUV8E24yiLrub6NUI2mq/DXwVccdH+2wMB/15pEC+ndJgmNzkUS5W3WG9B4wNiM4v7tJFr061vauwOmtOfY2KmQW4L7J/TKvB1kE1yim4P+x9Nvhh4zO3BJISeiKv0Q50QuGDI3st33kLCAqJEwzAy//hv/Y7repdAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297287; c=relaxed/simple;
	bh=m05/ztEppUiCr+liEyOHh/dfipSc/0b2RY8Dw6WK8y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nu+UnkM/AQtn5Tv/naU/kXMPN9lwXccJ6Kj1t2AihQCuQTO1NAArbiNJh8avKkI747vKZLqfpJWvH2OvBuKrmJImzdtxEJB3L7Kx8u+Z3DEdrXoD4dQmUdBCBfJsU0srvOpokIHaMaDHxzKAE0jhVL9WVNQOP140OM/QGSOxfXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9toB8ib; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9toB8ib"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6689033d0c3so5092809a12.0
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 13:21:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774297284; cv=none;
        d=google.com; s=arc-20240605;
        b=kz+o1R82zIEAydvdpdp+ixVrnjNIhhV8hreuZp31M1CasWVHM58SXUque43i1wQ6Ob
         8iDIXmDcJ6QamlobZ6cYkKzciDBBPe8p2mhIT3UsaBe+nrPFcS2l/7LWNKHpTA+9lu7D
         4ZTB1uexDcqYohZMhEHjckPimekkzKJFQ1PEuKrxBrjidYgebahKma0zb3pGb/0Bc8U4
         YI+l5i6CJimtH2QAcFYafB+ztzA1oErQ4ARyLHydozSmEAlr4UCoxhfGojAhnQBQW8o3
         NF4bPjBS2hdtjRcWZ6PDJ6ezyX3K+uQzuZ1vDzNApsWTb0QDHNm/6Dxxn93R47ITxLgk
         O9Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m05/ztEppUiCr+liEyOHh/dfipSc/0b2RY8Dw6WK8y8=;
        fh=WzIEGNK230Qz1zhP0n3SNHD4qcLbwR5Uhx9T+ey4rvw=;
        b=jlVIk/yO8mV9dc+qWhwue/Y2vqZnnD9VxXVCvOvyJxKmM4v9wU7GtN+Uas5tZjZJ3Z
         rPyIKXYo2Yg1aGwkaFHt26JoAspW6+MMXfeF1mD3I4HLdDru+zMCk3JU4QmGkjyE6NMC
         bBVNsPi9sbQ8qwkxXDVXjYpIT6C5nA454SiMiElhMvp+b7zPOyznjNOTM8jM7AJzS6Zj
         TWuhzVNIwyB5mr2J2YSqe2CPRCjbXvvJ9jgK+GV41xkvDnTIKLvBRYXGbwc90mLSf6sA
         XT8r7uPCzjtSFoVm3SwQDAT1RYxpVECW5GGRq7TS5xIfiru68prXcByS0lQbm5seUYV0
         m9EQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774297284; x=1774902084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m05/ztEppUiCr+liEyOHh/dfipSc/0b2RY8Dw6WK8y8=;
        b=i9toB8ibDYTjUQgGMZJ4BoCG60ytHT+lx27QKW1SEpRwBK2yHUeZmxcrSLy7e9lbIm
         hIyrkgldMEcFvNYZFz5GkrUHo/raitZfyDHq5r5B2xQU/zq0bZCL3Tbzs9/jwYKOXyoI
         nUTBAWukT5XWuPR47Ksi0fwe1paX8F0m8UXFwK1Ps7AIMn6TWExsZz2loAiKcM0t2PuD
         f5dmfp9HJzlTRIwDitaas3ijjxKGO7ZOGp3C9X3jQPv5tIlUMGjxK0xEsWdLOcvPkdnz
         nsJ/g9ivE45uAwgtcPTY1XdanN515hZlDzv0d39KLtxnvu9OLwL4ib4nwLkom9tGKnpi
         1PWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774297284; x=1774902084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m05/ztEppUiCr+liEyOHh/dfipSc/0b2RY8Dw6WK8y8=;
        b=Y6LCMzLluavpFupc0uniIqxsXG5ri52tisWWuUvXTKAgfvu/3YiIN3B/X7DcwbHtHu
         hPqdFgsDeYsm7aTad3fK8m2dDqchxzf58hZdOymU0YiNpdkXrl0Cc766J8fDVKIetjXa
         wfu3gvz14rBK0mbFz71uBX3q730eM0wRepWh3CO+v62O23MHhoqrIBvPDqXgqIzvlOl5
         b80rFoby8GhSZIEFTWy/zVBZ+XG3OY708PFK9KuKhsPcVNrvtMpLiGKXO7vVtUntTHXm
         wg4JLy9Yj6KspNsgQjCEuie5FqDStY+S8oXp6fbHa46wqev221v2KSw3tjEq2eKLbwBC
         fjXA==
X-Forwarded-Encrypted: i=1; AJvYcCXl5Knq5Ot9/T0lJv9wR6EjZ/6PNZ5u+lFXZ9k0ulzEIvpJB6r2GhRFNgmV700w+x0PffA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWO8h2U/DKD3vWz283SUTs+d4MXEdS1QnX0Jiomio3XwKdzE/3
	IqILHiQJBo4RdiAyYTScEbahkBMssq1FlKG+oMabxuAT6xe9fXTLXkZJ838xDd7p1fSDBOTdqjQ
	V3H6q/HNogc6fg2m50c+pxPLlWiDYtgA=
X-Gm-Gg: ATEYQzwFK+agXvE/DbiEJofAfRcKplXwZttlLCrlId51Wo+nPZehGLf29af6Wvn9h1O
	H3yIceD/1VQuUEFKzY2Zhs43c5MvsXNj5LpLh0q5KpMv1y/7+7sSI9hM8YONCHCIX6k9E4d5ObV
	Fsp68GDI7cXTnz9o3f1SWeeRJBeQ+0e+mOF/f5D8YIuBfCfl+B90pa0JhXv9KTtMIotPxs1+dWx
	YeD9nqJpRtKIMsccXOpGgXptBmKDtH4SEEv4HtvNTs4CGDFcPvJciSBnoeflxpMznevtvVnxOrv
	vQQGiOiRUYgEomv7fxZbOE8=
X-Received: by 2002:a17:907:c992:b0:b90:7fac:c668 with SMTP id
 a640c23a62f3a-b982f0c010bmr701167066b.11.1774297284116; Mon, 23 Mar 2026
 13:21:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312-b4-bpftool_build-v2-1-4c9d57133644@meta.com>
 <ad8a783b-7b8c-46f2-9a3c-953315aafe38@kernel.org> <ea4b6626-e435-4044-a671-35f5c18e3ce6@kernel.org>
In-Reply-To: <ea4b6626-e435-4044-a671-35f5c18e3ce6@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 23 Mar 2026 13:21:04 -0700
X-Gm-Features: AaiRm50VzVgQl06yJwldzWF1X__oKXR4J4XL_RaMPP2y-u0uZyjDm0-8vdX9iQ4
Message-ID: <CAEf4Bzb9b3aa5TmSsi4zM7zyFGOhnQWjPCMObPyaFCbfu3Ow9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpftool: Allow explicitly skip llvm, libbfd
 and libcrypto dependencies
To: Quentin Monnet <qmo@kernel.org>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 5:50=E2=80=AFPM Quentin Monnet <qmo@kernel.org> wro=
te:
>
> 2026-03-17 10:29 UTC+0000 ~ Quentin Monnet <qmo@kernel.org>
> > 2026-03-12 17:03 UTC-0700 ~ Mykyta Yatsenko <mykyta.yatsenko5@gmail.com=
>
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Introduce SKIP_LLVM, SKIP_LIBBFD, and SKIP_CRYPTO build flags that let
> >> users build bpftool without these optional dependencies.
> >>
> >> SKIP_LLVM=3D1 skips LLVM even when detected. SKIP_LIBBFD=3D1 prevents =
the
> >> libbfd JIT disassembly fallback when LLVM is absent. Together, they
> >> produce a bpftool with no disassembly support.
> >>
> >> SKIP_CRYPTO=3D1 excludes sign.c and removes the -lcrypto link dependen=
cy.
> >> Inline stubs in main.h return errors with a clear message if signing
> >> functions are called at runtime.
> >>
> >> Use BPFTOOL_WITHOUT_CRYPTO (not HAVE_LIBCRYPTO_SUPPORT) as the C
> >> define, following the BPFTOOL_WITHOUT_SKELETONS naming convention for
> >> bpftool-internal build config, leaving HAVE_LIBCRYPTO_SUPPORT free for
> >> proper feature detection in the future.
> >>
> >> All three flags are propagated through the selftests Makefile to bpfto=
ol
> >> sub-builds.
> >>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >
> >
> > Sorry I'm late for this one, I see Andrii applied it - I just wanted to
> > say thank you for this!
>
>
> Mykyta, Andrii,
>
> Apologies again for missing the review on this series. I'm realising
> only now that it goes beyond what we initially discussed: It adds a way
> to turn off the optional dependencies related to the disassemblers,
> which is what we agreed on, but it also makes libcrypto optional.
>
> There were previous discussions where I pushed back against making
> program signing optional in bpftool. It's one thing to have the JIT
> disassembler unavailable on a machine; but it's going to be a pain if a
> policy requires signed programs on a system, but the bpftool version
> available does not support signing. Are you really sure you want to make
> it optional? My preference would be to keep program signing a mandatory
> feature for bpftool going forward.

Hey Quentin,

I understand (and sympathize with) your stance that packaged bpftool
in distros should be fully featured, and I think we should push as
hard as necessary to have it be a case if it ever becomes not true.
But the truth is that bpftool is used in all sorts of limited
environments where its full functionality is a) not needed and b)
logistically a nightmare to build, so having Makefile-based opt-outs
for some parts seems like a decent tradeoff to keep bpftool relevant
(instead of forcing people to do some ad-hoc hacks or
reimplementations).

There is nothing stopping packager from doing a custom patch ripping
out crypto parts of bpftool if they really decide to. Only users and
maintainers push back, really. But apart from extreme laziness, why
would upstream packagers cripple bpftool like so?

We should stay vigilant, though, and if you notice some distro cutting
corners, please bring it up on the mailing list and we'll go from
there, ok?

>
> Best regards,
> Quentin
