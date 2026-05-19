Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E59E3AF64D
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 19:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779218770; cv=pass; b=E44iNT1M88Ba6ifzCzqMj6+lDlVT02dH45jLwJL/N7YIObKP+PrHPoEOIbZ2n4IaWRF0bgeqWFW9ReYGJ0PpRQUMLGs0P/ZByDr5beSL997OprzxK9CBI0ObnNURDseMvzH4CMbSbv1H94vxkuJjgJxd4jlPrXHbziiaNs9DOuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779218770; c=relaxed/simple;
	bh=QclfnEqh/VIwuNT9i0Z3itwmL+j1eN7npybBQI2aCj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YEC6izr7FYzDqdQFbjlOPP+u2xydjmX5j9gkT23Zu4ZkL8S1mdU7jHQFyne4QWSZD1nAWxmtuI6ltaDEtOBYrVfCvUkWnD1BRkcJGzqger3GaOIYkA8IL1qXDbajanu38x6RxZbuggnNs7BrDoqGgxk433ZBBmaH7Uf8raW5T/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrUcNBhI; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrUcNBhI"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6870f904c6bso131878a12.0
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 12:26:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779218768; cv=none;
        d=google.com; s=arc-20240605;
        b=bATHL6yGIPSSvYXTkXP2EXopws8r44VQvhiPrSf01vkyvQ23DQ+Mof4gM6cE6h2cR3
         Cf//+x7skE3TEfRoxXYpzJfudrerA/VvgjIuESpodKOX8PJEZJop8wVJ9967kr/fikis
         5ZsGRGOPplDQ6/uqnT8vQthJmEc03b9mV0qhFCHkhwrJzDoY3k9lLeGo8dUP8wMsGarQ
         l+WYCKZzeOGJc8PxeIvgRRVhlgccqMUGQpH/GlI8dZHIXmEhUoLkxqW9QusN14hjbw06
         X0vIUbbvbmrdmPHxcruhvvJ7oVLkCh7Jjx/VkmJ2bW0i3K9RUno9gBIjzqr8sgr8AcNf
         MG1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YOWC4ZoHpBzpNoY7DEQ9YEtLXbInI0dz9Gi/levCCSY=;
        fh=PnmYwwIEyGc3uGnzLellVUyTXAaSujwRtCwQxVQ5pwc=;
        b=QXztLEIB84X55sKBpMvB7tnz262IqLkXXafiZW/HdjamDsNG70D7Lrgyrt3vdvtIsW
         UVzvUwhwRkgDWjzsm95xyKycpEFoPPjyuWf/8WDcUAEvnR/sjeC50ykyoe58D22a0s+3
         WnHX5tAYTkn/F3grc7+KMaDOH5yU1diRIic/BJIuODR5Z20SbxCH6uQvPyOqByriIw6n
         dUseigdWS4EoAwhgQNWbln7Xxd/pAE8FxbPJ3YXri7DJmlFCurr2Dy2BGnfdXc3vFdpO
         8VnDU2jVrz0GGpBsTrzWYlNTkRAKB9nI1KJ15lejVcn7spsh2EbgNUuhUoA3BwFGhIV+
         TOYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779218768; x=1779823568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOWC4ZoHpBzpNoY7DEQ9YEtLXbInI0dz9Gi/levCCSY=;
        b=RrUcNBhIn5PAUqtCvMKnaIqXAVxg11nbxRW0NTpRjaATmmv8s+F/cx5HqsdsrWMcsm
         4o96drUZE/9dazl21v/lxfwFdhJ6oZtNMSUScAXz0Jdx5o51Bpgn+0bq5ugd2t09ZHB7
         OL8+bbiYJVKfKKKWriqnqYw0uhGeuXEc5zkQAKKXU8gJYgix5Yxyru57Zrk2zyJqQeCT
         5KgFIbwjxZ99m9Zb17ctG0URquEb/f5Lcr4wL23+sLorzGfL9SIgq7WY1FKRoC8RfWCQ
         Nkx3uRA14QsP8Q5Bzh30/TJhRNOdtsUA/dz6AaJ3rso1bOTtanRPfRvBM6ATKAIjrS0f
         1feA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779218768; x=1779823568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YOWC4ZoHpBzpNoY7DEQ9YEtLXbInI0dz9Gi/levCCSY=;
        b=cJ4O4zl5upd+FQ1/eSW45PtYJzZ6ZSz7KklrjU2xVXR1ZxhjMJrSjuvgo1hBk/fVck
         AmLf18uhZ2ZydOdHaANUjjqBlDWs6pejuzVwUMDsrpgnOEuu8NQhyYLgJDPHbxrhHmx+
         gPdkf1PJaKF3hr5TYyBR1NJTPsMqWv5VvVIIlxbavC2CE12BwXfKa7+Vy+mJXrSZ94+U
         p2lCBZlDIi4GJEewxoQnD3SjpMTBz7/8kecqf3eqAu0IV0lFvt4UmDuv0OZVtB49dvlP
         W+7H5O6rRDF11dd4jb1Jk8qY4CxZBRK9JpJY1lRkFhyduqb3sTJkRs2yhAxwPU4UhXhB
         wl6g==
X-Gm-Message-State: AOJu0Yxt2zfclFv4Mx4SBQ1TewWsoQ6IuJhjiix0YVDZ6QsMz9VFbeZF
	YuCL/yXin/hmFDYfl9jrBjcLJVc3rV07jytUsSCKAK3oWkfgeSRXBTo2eoJ3AvXQ3ngbwvWSoyD
	CwwQzRYVg6k4Nt/vAWqXUC8yHLaCVc7s=
X-Gm-Gg: Acq92OG6ARtlTRb7LJ0KkRpXTsC3Z1weosuS9Ia/kmixbyxQk4XfYBDOzrxoPyUMldQ
	+NXHGke7GHpSvHV01B/KogOfvbtOhThk8XJ62fJVvcT7C+7CwLxzDmcgVS2fmlt2U4aim+MZW5R
	JkLybGUY6azBeKNcyLnkks1GpD949o171HN98nQN8Vv/vgIaZsgAYuVTr8Ac0+dhGeq6gDJtGyW
	KU1GTdo1dkuYLFLHj9FSGnW9bfwn7+8H5W3+0UMd+Yeb/c5PLeKUcbgkSkl02ynRYKTbkNElQS7
	mFenjAe2ONYdinkyLf7JigWWefWUZ+EnFXwbQ2ex5A==
X-Received: by 2002:aa7:c78c:0:b0:677:1ce0:c08d with SMTP id
 4fb4d7f45d1cf-683bd58a162mr7488590a12.18.1779218767682; Tue, 19 May 2026
 12:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519163632.2220753-2-puranjay@kernel.org> <2afdea40f0c5a11c2337efafe6f460899d85bc28650e04d5e0b9ceb35f3ad9fc@mail.kernel.org>
In-Reply-To: <2afdea40f0c5a11c2337efafe6f460899d85bc28650e04d5e0b9ceb35f3ad9fc@mail.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 19 May 2026 21:25:56 +0200
X-Gm-Features: AVHnY4J8tn8h65yL6YIgch0nwhS8sfz4GQygSwhu6EC5IOT--dLZ8yVJXJ41VJk
Message-ID: <CANk7y0gsU0gHRncEXhjRiDU3DRSrkfaJuCto36TkQzu-GOPDhg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] selftests/bpf: Fix cold_lru producing zero
 batch_hash in XDP LB benchmark
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, mykyta.yatsenko5@gmail.com, feichen@meta.com, 
	taragrawal@meta.com, ndixit@meta.com, tehnerd@tehnerd.com, 
	kernel-team@meta.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 6:14=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/progs/xdp_lb_bench.c b/tools/t=
esting/selftests/bpf/progs/xdp_lb_bench.c
> > index b9fd848c035d..f40e36aa183e 100644
> > --- a/tools/testing/selftests/bpf/progs/xdp_lb_bench.c
> > +++ b/tools/testing/selftests/bpf/progs/xdp_lb_bench.c
> > @@ -618,7 +618,7 @@ int xdp_lb_bench(struct xdp_md *xdp)
> >               __u32 *saddr =3D data + saddr_off;
> >
> >               batch_gen++;
> > -             batch_hash =3D (batch_gen ^ bpf_get_smp_processor_id()) *=
 KNUTH_HASH_MULT;
> > +             batch_hash =3D ((batch_gen ^ bpf_get_smp_processor_id()) =
| 1) * KNUTH_HASH_MULT;
>                                                                          =
  ^^^^
>
> Does forcing the LSB to 1 with '| 1' inadvertently destroy the lowest bit
> of entropy from the batch generator?
>
> Since batch_gen increments sequentially by 1 per batch execution, forcing
> the least significant bit to 1 maps pairs of adjacent values to the same
> number. For example, if the CPU ID evaluates to 0, both batch_gen =3D 2 a=
nd
> batch_gen =3D 3 will yield 3 before the multiplication:
>
>   batch_gen =3D 2, CPU =3D 0:  (2 ^ 0) | 1 =3D 2 | 1 =3D 3
>   batch_gen =3D 3, CPU =3D 0:  (3 ^ 0) | 1 =3D 3 | 1 =3D 3
>
> Could this cause 50% of consecutive batches to generate the exact same
> batch_hash as the previous batch, causing those iterations to hit the war=
m
> LRU cache entries that were just populated and defeating the purpose of
> the cold_lru benchmark?

Yeah, this analysis is correct, I need to fix it another way.
