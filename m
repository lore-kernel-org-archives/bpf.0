Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A161A724C
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 03:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780717818; cv=pass; b=dPWZlf7A6nYeiYIa+H1IXULW024qs8aRxhvEqBOMcqjuGu3rYTfJ413UbuTINPIsnMdjFXNGXhliDqCl3/2Oa4Rfr9LfwiS9QZ5OQ/YR3V4CefrMrQdZbvBMIdq5xyo+O4bgZbyUM5xqm6q4HY+W8x8CfWrzTbEW8jxIHS/0vfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780717818; c=relaxed/simple;
	bh=lIw+o11/0Y0T0lOVNegkquJjAspZYJj3oFxx3bVgRe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nw/NXmqTr39lGjI1xDbaMD1EtrNtB1uAbSPHW1TSj/ulJ5XpfkeTeRgehMJeC945PiaSDZksm9RoNnOkUiyfDOlPAhFJ+KO0EsLRO79uf34f1pgH8IP69pHbJFbMqxY3lvfONIx4YlnmGC30MtcfJ7cq2uHm1r91Zs/AMqGGU8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivqo+zez; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivqo+zez"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7dc93d02916so28289107b3.3
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 20:50:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780717816; cv=none;
        d=google.com; s=arc-20240605;
        b=ZJeyUZV8rZfJobvyVKYyNDhLQsLDBiIBWrKalwkmooJtulsebuFzCohlHUCgaVliH4
         OMf3op6Jhba06PV0DTgXmpIGYKXmjrjH1K4ZKjH/hNNsZPaFgIkFHABniZuRhHOaUYmG
         JhhUholMGVYe3uw07OgbmZqF5E/PX3WeOCZAelkAkwHpGOQiCeRHno6TPwYNIJ2wnUZC
         S2pDTguyEEzKLTLdzGIdRldg/sxfz0/uiyZ+xXV0kl7jAP0UCpY7KdEYKEMWCWcHYAbW
         PBRzyvin0ievtgof5zrv7L3942rA7QSh2GfoacvK9UD6W+oz6Ij+XRLfXj9voKxEfCY2
         rHWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jg9MKZJlpAVkFYtPfyUSTFTMLnfmI/Ebtp2GHarI+GY=;
        fh=Z5WQEMxVv31e2/6rYwYX+0uquY04Z3XIWlHCqvcmIDY=;
        b=e3PjhXVCsOC3ND6bhgfbkyX8WyIr0fEqo10tin+Pxfm72btBzP0Nw5D7IQ5d5P8loP
         HhGUzkjqhzNQ6Sqm7DugifRtqZUyfRspmrr6NTd5GW1U1jhfoZBSYC6Dy3iCziwCJ2Dz
         PYRvb1bIJF2aet+1PkWIiAhonVKnlP6pio/PxGbsuGJYa/I/pXXO7spQb1uWK0c+4xPq
         /jHeYktyElgnYic6adCUjod3Bih5kqKrg+SGgZk4ivM53n7XpUSLnhkn1zzJM/TKDcLd
         C09v3dB/zTDSz28APU89RAtPEN7AXbm9Mx9i+7BkrTlXwcS8ZO+7YnxAeYYKEH6+PcJz
         AQ6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780717816; x=1781322616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jg9MKZJlpAVkFYtPfyUSTFTMLnfmI/Ebtp2GHarI+GY=;
        b=ivqo+zez2SGGZdWc0H83/TNvepcnUFXL6u+qisp7c+rpsQBZ/6rYEhX5HM5Q1l8iDw
         0TGOwpNSSHfo8nLLoAr4O3nO3xbFPe+d5hOpS/BuJojgpb9Szk5VWtiaNbdoCTl0M0S9
         Q/PFuoqq2bA1FdTWCE1FyfL5qnNcCoLjYL3oinliiyStVGUOPVLEcItibqvYaLJQiT06
         5zFIKNlKTkpN59FvueJCQ0jFltRa7UEHhkEWgXJLyhC9taQQPrKBntO7poU4F30aXJKo
         LAy/0CWmy1yDQ8l3DcrbGHTNZCbrSNXQ7R62zrL/Ye6dDwJHkKy+Rl4UHTDeI50m9Yc0
         Rogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780717816; x=1781322616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jg9MKZJlpAVkFYtPfyUSTFTMLnfmI/Ebtp2GHarI+GY=;
        b=fFKzACxzklP8aEwAa+tUKtNkFPGvK7nJv9foVoYBi1bdH9cSgZBmiBq1dNvpOSMP2a
         xCCQtQPYD1ByhwTXi0Y0NWl0h2a9sfvJZLqYYiTNKFiQ5NGBJL34Av3FamHPkW6nKZHH
         Pal040fb6hQKjKOR4Xf3YgVQqmNZ1/mL8zcD6uGViULEB38TRpbeywya8+6u1CUAs8+/
         9KfDuMjgPeoBavLQBF0lMaoJRza5nSx/rgxUq+UEiAndePUUmuMPJRh2IPWm+/CRKwCF
         5FVUal+nAomdPDx0SmVukCLWC5y10ZlOmANyhN/ewrmWfUMpsOZitDB/KYMcar9ZzORY
         FXWQ==
X-Forwarded-Encrypted: i=1; AFNElJ+PREu0wdPyZjyQPSZ2qR/89BUU61GsW3FxS6xxY2NWw4eooxtRjvDWxdKk278nt8wkYE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcoYq0ik92K0lueT664Qm9pzeUZ20wMvjhu26Z5cjf7ieAxxuA
	niZ9fYeVfXg6eRGaInnF0NmdYjHX6D6REr2evpIgXALZap5hn0h0NOkudNaI8c+1A3T9C32rBO9
	fjs96Jss2rK4BBifsnIq1O2lLUywNYHo=
X-Gm-Gg: Acq92OEatU2x0+4CCBFvUFzM0oj1TaLb1DvHFYrVfLxL3koiVMJTh+qb2HWFrmGiLG3
	3p39qr127iHRC/fPIiheOkE3a2Wbv2y0NWgTzheqvdtYvYNKt66OQNuvwvMR1j3wWkofAWwnNEQ
	8iZLEzMO0s6ehlLiL565L3YXmJ2KblA1hYXhT/lnNRqe6T5YUTZ0LDwMioK5YEWk5y3ilD0qtBR
	yjkdDNLkb2Tr/XZRrOoTDcNlhA24HAhkxd3wHbkVeFr/03lIVesQ8ALiKjdQQ6iImNFQeFiu7G6
	InDVSwRpXKaISUcA9YfGOO1CPm1NHKSucA==
X-Received: by 2002:a05:690c:260d:b0:7c0:56f:5b59 with SMTP id
 00721157ae682-7ed0aad0211mr66610437b3.15.1780717816081; Fri, 05 Jun 2026
 20:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606024540.47362-1-ethantidmore06@gmail.com>
 <86b976f32a179141dbeb3eed5fa106f18f2e46b5c6849ca2c800484847d1deb7@mail.kernel.org>
 <DJ1NDNGUKCZR.3CRKEWPZ3OOMN@gmail.com>
In-Reply-To: <DJ1NDNGUKCZR.3CRKEWPZ3OOMN@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 5 Jun 2026 20:50:05 -0700
X-Gm-Features: AVHnY4LgMuk7Lewq_tlZFb20dXjzoprl00PC7dlfaeyjk2nweYknssxPdgF8O_c
Message-ID: <CAMB2axNfrP8HXQ4WimBv9HWex0x-Y1A5+Uas6XNcUgvhgQgV5Q@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix signedness bug
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 8:31=E2=80=AFPM Ethan Tidmore <ethantidmore06@gmail.=
com> wrote:
>
> On Fri Jun 5, 2026 at 10:25 PM CDT, bot+bpf-ci wrote:
> >> commit cc27f12c12ff54b8eace339c3e130317bf205277
> >> Author:     Ethan Tidmore <ethantidmore06@gmail.com>
> >>
> >>     bpf: Fix signedness bug
> >>
> >>     The function acquire_reference() returns negative error codes and =
'id'
> >>     is an unsigned integer, so the check (id < 0) is always impossible=
.
> >
> > Is this commit message accurate? Looking at check_kfunc_call() in
> > kernel/bpf/verifier.c, the variable 'id' is declared as a signed int:
> >
> >     const struct btf_param *args;
> >     u32 i, nargs, ptr_type_id;
> >     struct btf *desc_btf;
> >     int id;
>
> No, 'id' is assigned as a u32:

You might want to pull bpf-next and check again then.

>
>         u32 i, nargs, ptr_type_id, id;
>
> --
> Thanks,
> ET
> https://github.com/sponsors/ethantidmore
