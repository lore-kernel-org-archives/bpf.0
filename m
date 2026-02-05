Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424453EFD26
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770309329; cv=pass; b=gTUIHHwexIDtJA/EHmfIc1mzyX/wMpS7ndHt0aNIKIwJGRFALl1teMtmK82isHuv3On/MuLsBXizBsGMlLqiD+0VufET5tBsgr6XTTC7ldVEKJOAAOPhoE13Q+T+DAtlMEPsFLLdeey1B5Uitm/fFh7ZQs1eGe8vV/iWy8XjTjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770309329; c=relaxed/simple;
	bh=ueN27qbbJ2GHyVlXohzZWqgqwO0vQQDHafCV1D91N5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OD5y6yjCD95zMJ2Y2uII+dRi3VauCoYx+PIAvLtHFw5rTyrqsPUSwlQzRsP7SdN6QtkLe8xi/mm44BolJ9H0p2+tNBvpL1jc/tLoKEDALuhkkSknp1Lcd/BlvvBdJQUXANuEQzAg0oUCQvWmBRedFmNgh9pJrcHedVS4wyiHf1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPyPXWE3; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPyPXWE3"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43626796202so559221f8f.3
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 08:35:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770309327; cv=none;
        d=google.com; s=arc-20240605;
        b=Vym5T6SVdQn2maI+FK5SXnFOxe2mstLdSEqidEtT/7Qu1UHfIytudqBSgnSRl7qLK4
         ZbFtE+fWlUWJhrKzkZ2jv4AC/XQ2PKc8GuP4rgvqyBkizQFDQ9nol5tjCnCD2ci/5GIc
         armJRtw/ca9T4EAnyUmz3SZFaRhqHwZivbccKnD1czd+qOW4x41f5/bbdX/pSQwx2gEn
         x2mwKsTu/hIpgjTn3pJ5TBeXuh5vljk/h/q+LU/K94X3m8Yyf8lM2Dk1tWyUWPLdLHAt
         KzKyQTisFgGjS0pamhSkYcYnt5viB1QcoToMzgFjKomFd5p0+TlJ3H59HE36ROiwcDmJ
         TeQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yUnRlAsf5rP8Fmzl7rkJuGGNEbe62J8yyHXC0d25aAs=;
        fh=hPJet5dpRIHBk0Y5w6NZpMWnkmiM6vn3irkUo22e6W4=;
        b=Cf6qq6eAOmvt8QN0dzW3mc1wiVakXZSaqA+RDCEL5nTkzO4CaGs8BdkYQO0iv5qdb5
         ppLDqQoSoC+j3WF/vDMJBrLEIHJBYeOzEgh3mrfLFhegQR6AyK1kKT2MLOr7uuOEWnxA
         hsVlkutSvmfPQFJGeBCFQ6UJJ+/YW8cTEWlj+COJPHvOS8hJ/AeL7QQJuJuMi1c0H1fk
         kYYakoe1oQa7HmaYiM+Zgf0WIMwaNyK94FOS2w5yhZtwTt5oLz+fte3ObBS8n3RYXsWf
         OFsvenXaB4LfoSdQVQZXbFhTqvmISxp6s7nT4iQUjJauk7EVmZ+WiJNC2ZSZsnMLtUJj
         HD7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770309327; x=1770914127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUnRlAsf5rP8Fmzl7rkJuGGNEbe62J8yyHXC0d25aAs=;
        b=dPyPXWE3ORK8Fs61ETTlcbMn3EIUKOx7c6O5wPnWKUO5sAUQoRi21X7KfZPPJSVZpv
         n2sI1OWJFhBUoqBKwjvCt8pQrlGnCfHdl0pC7/Sjn8JdAq/2vH94pApwohx+Qax+lr5P
         2ub0RhpCeWRGi5jwFfq365HCl9v2naG0HCMTVrH7hp2QRxsWe4w53phN/QR/IUdn9UeC
         W4APwK25SsoyJ3YTRLSJwDh1a8bXg59v3Ju/nH5wuXf4Q354+CI6gxVBC3nqUgYA3yzl
         EdszOiPRYa0NZEn+R27LZ036Y1IDd1kxevl83/MLyL0Fb9ZfScJ+MlWWvD6HWooMNvu7
         pcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770309327; x=1770914127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yUnRlAsf5rP8Fmzl7rkJuGGNEbe62J8yyHXC0d25aAs=;
        b=f5EoDHAbMcUbRNwGxL1/jkIFBMnTSv5XI53F87Th/Q4DqSdPVLFB4RA3oL02mwjdLV
         xBQ8dJ+VMcNaBnZeSonJ5k7F86lSynOwThjtv86jPeiHuk6MsQBEDDbTYMx+Ac8Wulx5
         ORieJStnr7CS+byWSJe6CJyU5X+vD+aJAPrPYXfPGcrI0B18k1PSxLac69zTDaWGq2CT
         EmH7xNHUnZPdt9jspdI2GYZn8XEMCtwP6bsTH2EsG6MHLAD7uMoS0Fs+53LNC3gZjZhH
         MTjMD10/57O9LvLtCc7uB+NrE/ko2HgEFZ0GPbAl/i8cLslUZ3eDcQOSy1JQM+IhhjB7
         ySQg==
X-Gm-Message-State: AOJu0YyiAakHJnGoh4DXHZe4RG+QRottRS8tMjlpT+oSGYBhsUc10hXP
	PBm23Ay3MB+3zeJhxzIRhtS17W6QPd7ePumW0+UYhjKDEHRWZ4XP0S9f3aVmTrzEsv19ynH2O+y
	fWZKqs3BrthY7w2mNmBSh5JiEDD5HvKQ=
X-Gm-Gg: AZuq6aJOpRcT+QO8IWtAOrjB4TgDdAXPXtQbsYUECZBWaapuXhRAXutG40DI9qVyhm1
	0ixxl2vOxEoRidL/Xp6zFyViKVvpQ2AuqXr00vafym2mzA5Yz5Ku55z0E0mNoBOnoazAGKaQ1d4
	sBaI5tSXqF/ttO0hizLVtlU07J2ur7Cr80vifMkKgaWgikOfeUypOOM7+qTLDYYXa9BfCsXdQRD
	6wD12CqxunDGmLOupElnkPSPyvQ+sTXXkZRcBj1N9arScb0TG3NtMn0zLJM1Kv5BiTl+bosXdA3
	CLZZLjEyo3nNaMRWTBEXWtHrVOon3a+XtRj/+cbZqN4OjCU/jeRJPps9+p5jnozFBbmf6YXS
X-Received: by 2002:a05:6000:2c04:b0:432:b951:ea00 with SMTP id
 ffacd0b85a97d-4361805bbe1mr10551339f8f.51.1770309327455; Thu, 05 Feb 2026
 08:35:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205063807.690823-1-kpsingh@kernel.org>
In-Reply-To: <20260205063807.690823-1-kpsingh@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Feb 2026 08:35:16 -0800
X-Gm-Features: AZwV_QhXCh3hEJGPNMHiCLyGoGAj7Irz7xWk6xoq8pJGyQ6dJ1MRLp301hKMRVY
Message-ID: <CAADnVQKgHv4eD6xZpu0GJVTM4q5=zB831r84Z2T1tyWEbCYP7Q@mail.gmail.com>
Subject: Re: [PATCH bpf v3] bpf: Limit signature size to KMALLOC_MAX_CACHE_SIZE
To: KP Singh <kpsingh@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 10:38=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> Practical BPF signatures are significantly smaller than
> KMALLOC_MAX_CACHE_SIZE
>
> Allowing larger sizes opens the door for abuse by passing excessive
> size values and forcing the kernel into expensive allocation paths (via
> kmalloc_large or vmalloc).
>
> Fixes: 349271568303 ("bpf: Implement signature verification for BPF progr=
ams")
> Reported-by: Chris Mason <clm@meta.com>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  kernel/bpf/syscall.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 4ff82144f885..15e87f507991 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2820,6 +2820,12 @@ static int bpf_prog_verify_signature(struct bpf_pr=
og *prog, union bpf_attr *attr
>         void *sig;
>         int err =3D 0;
>
> +       /* Don't attempt to use kmalloc_large or vmalloc for signatures.
> +        * Practical signature for BPF program should be below this limit=
.
> +        */

Applied and adjusted comment to be in proper kernel style.
We don't use networking style in new code any more.
