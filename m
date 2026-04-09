Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFF12472A6
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 23:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775776881; cv=none; b=QhOhQmS/SHrXBHmdeLJojaElb8adoWQAXa3bnVID8S5m/Wn774uQ/hrTppXh3N7PYrq/EUyh5x9dpcTiCH1JctIBruNaT1GaAr9jgKL2ur/sua1ctNKg6zQknwgQer6AGT+tnKRSm03aQVkDz698KOFSvd3FXuIBYp7BeCoQ6VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775776881; c=relaxed/simple;
	bh=QkW1pXcLnyWp7fQDqZ+NOCfYeHxXgvIZOJ6Bvgjxa9E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XxH7tE4uXnNmXjLvG7kGnSVBMcBCR70hVfvScmeQnVumaaQAvNqpudWZCvzHSU8iR0hZ+q8xWFDVv81aNUUV3/djiJ0tODMyTv5qZzjsuhnaaBaMdpi7wLYjT9l6IrGVOZ7ZeUPR+VuA8EIbvC7/xdPc4KhO/OO6WJ7eD4lj914=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHh9EwKV; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHh9EwKV"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c287eb77fso835313c88.1
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 16:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775776880; x=1776381680; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zEIUiTG0IWgjDuD6AFSTGRqa2JggO2YmAKWBMwTzMAU=;
        b=nHh9EwKVHJEP1elDqvuD/P0UhSwO5+5bKwg+L4jOliXkf78tKjuxl59km8fdkjb4ln
         qJgNeJRdoL238j1YFGZoF+1SgPGduM5jmkYM14xyGtm6C5ORUHy9A3cP3iV//Ju1rgvZ
         hBwkOh6tFAkF0ElyORFbT0mo5Kh9Nxq7PY1SOBdcaYSf2p0UgeCgBWtrQle3fpqorsby
         RwaOpdNZdKpSleRKa3e6kRtGVTQfIg2rYMC55SQgfaqWkJNBB7qxpRe8K1KEs1njI6Yp
         WturWjpXoQHny04HRvuA1onvJ7nJlElUyuNw/oRZ2SNJlJvbtpeRxl7B0PBdMND9W+u3
         0pQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775776880; x=1776381680;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zEIUiTG0IWgjDuD6AFSTGRqa2JggO2YmAKWBMwTzMAU=;
        b=QlEX1QKTkCvRLJX+tXlgfySa7IIIg+1HTgEejctKYzoy4Ixt+vnbWkhlWmM6h0wIFL
         3yPquuKg2ZUdKIjWd4va5/NC5Rq+zK2IdVNp/IbTz93Gf8IWNoVNsUcPLq4Kkwg+srdG
         ShMTn1Bpjo9XaffR3TktGxkOS5azahh+/af5y5sdIZty7LoXnwoCBnbqbBDUuHbaRLMG
         tAzGD8UeTAr+vj9WVqQ2f9TW1wbWY7A4SLPTw5183l2Lrlg6hGms0EAQwP+F9vXCc8AB
         O/mNpds3JcRLxeWSDzU0qIXP3PjqNBa6TI3RzrxCYK60MCNIvV/ogyJGEKFEfYaxk1bl
         kPXg==
X-Forwarded-Encrypted: i=1; AJvYcCXcZT6FPmG6Tew3Tupc3ywIJAvb/N6zmQvzVMcX4cMU5HEK4VrghSW86Vw9+HGd3bAdSc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzduwV4A7aOynKu+qgxUKFO9NZj+/jZ83xl3Holy2uuizKnk10P
	XFJt+R55R8FCcsXQaX87sFquPhxCZHvSzmSbrPpEaoPvZjlfO/p8UiaX
X-Gm-Gg: AeBDies+uhIPUHOrMMEEf8giV7X8yJB2FrAxOx1VhAZpgTMSMesVOEdZswbyUCgwDey
	GkxPiH4TCKPeNDf+rg3KdrRNltVnO0rwQrZm6QNjlskODS3FQKYvY4KCzDSq+bp/fINWjphSgrS
	ROT3Xr37qbDTjqLac2OI6nAalPHyMrw9x8eRA5bhQgeZnRM/amRZN5GSsL261N50W+7LEf9PLK0
	bZ1G3oinHaeHKXx2DdXRpRXr5so0+FgFPsUY2TJ1mqlx/JSMU5at+WOViAF4KGSNsrhWwEgEQ+u
	RkD5LEyy35jmpfH1pcywC+6BST+EIBjiEUB8Cn8soqbmchuIcK/n1T3AyGou/0Rj5jQBRF5ncL/
	nNjoOBRwV0csyKk2FruZF2USTu+pCPLV8LHvVNJEINxyV1yyR7ZC8vV9Q9e4WVH5P3TESRWKw9+
	nRZAjrMRF1xZXxSgtiQktL4Y4lpB08qP+5PcPCii+ZGpDmq5eGtaKUNxpqBON6z24tegR7QmPRh
	JtCxCKM+3wy3qhsvg==
X-Received: by 2002:a05:693c:3114:b0:2b8:c1b4:9cb7 with SMTP id 5a478bee46e88-2d5888a057dmr672085eec.22.1775776879356;
        Thu, 09 Apr 2026 16:21:19 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:7da6:9d9:d70c:7407? ([2620:10d:c090:500::2:f3a8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5632a2a06sm1730614eec.30.2026.04.09.16.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 16:21:18 -0700 (PDT)
Message-ID: <57e38e3296bcfb8ef909f4180ff8e17c9120ab1a.camel@gmail.com>
Subject: Re: [PATCH bpf-next 04/14] bpf: make liveness.c track stack with
 4-byte granularity
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Date: Thu, 09 Apr 2026 16:21:17 -0700
In-Reply-To: <ebe2561af12fef3888da2ac17b7da0735be644338ab28369a4f162a117db3b80@mail.kernel.org>
References: <20260408-patch-set-v1-4-1a666e860d42@gmail.com>
	 <ebe2561af12fef3888da2ac17b7da0735be644338ab28369a4f162a117db3b80@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-04-09 at 02:26 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> > index 998986853c61..9e36ea5f2eec 100644
> > --- a/kernel/bpf/liveness.c
> > +++ b/kernel/bpf/liveness.c
>=20
> [ ... ]
>=20
> > +/*
> > + * When both halves of an 8-byte SPI are set, print as "-8","-16",...
> > + * When only one half is set, print as "-4h","-8h",...
> > + */
> > +static void bpf_fmt_spis_mask(char *buf, ssize_t buf_sz, spis_t spis)
> > +{
> > +	bool first =3D true;
> > +	int spi, n;
> > +
> > +	buf[0] =3D '\0';
> > +
> > +	for (spi =3D 0; spi < STACK_SLOTS / 2 && buf_sz > 0; spi++) {
> > +		bool lo =3D spis_test_bit(spis, spi * 2);
> > +		bool hi =3D spis_test_bit(spis, spi * 2 + 1);
> > +
> > +		if (!lo && !hi)
> > +			continue;
> > +		n =3D snprintf(buf, buf_sz, "%s%d%s",
> > +			     first ? "" : ",",
> > +			     -(spi + 1) * BPF_REG_SIZE + (lo && !hi ? BPF_HALF_REG_SIZE : 0=
),
> > +			     lo && hi ? "" : "h");
>=20
> Is the ternary condition here inverted? The lo bit (spi*2) represents
> the LSB / lower-addressed half of the 8-byte slot, which starts at
> offset -(spi + 1) * 8 (e.g. fp-8 for spi 0). The hi bit (spi*2+1)
> represents the MSB / higher-addressed half, which starts 4 bytes
> higher (e.g. fp-4 for spi 0).
>=20
> With the current expression, when only lo is set (lower half at fp-8),
> the +4 adjustment fires and produces "-4h". When only hi is set
> (upper half at fp-4), no adjustment fires and it produces "-8h".
> This swaps the two half-slot offsets in the verbose log output.
>=20
> For example, a 4-byte write at fp-8 marks the lo bit via
> spis_lsb_half_slot() in check_stack_write_fixed_off(), but
> bpf_fmt_spis_mask() would then print it as "-4h" instead of "-8h".
>=20
> Should the condition be (hi && !lo) rather than (lo && !hi)?
>=20
> Note: this function is removed in cc55f39c101d ("bpf: change logging
> scheme for live stack analysis") later in this series.

Valid point, I got this inverted.
Funnily enough, it was inverted one more time with patch
"bpf: simplify liveness to use (callsite, depth) keyed func_instances",
the logging is fine after full patch-set is applied.

> > +		first =3D false;
> > +		buf +=3D n;
> > +		buf_sz -=3D n;
> > +	}
> > +}
>=20
>=20
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>=20
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/241682=
98083
