Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45601917FB
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 04:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775793930; cv=none; b=NY1ybDJ4rt8tZG6z3peOtjbEu+fEkC0CRcYMUCO413AkzGKrXC7z9bze45Hm9LFmYnksAUZkMoXkJ+/xs6K3n9w5KffE5O8dV6jDop75ZmKiOpPOEQd2UQXn7xjRJkUJXsb6MXdwoSWxcdnH6G1fQmOcRIODadP9GzvEBVFmRns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775793930; c=relaxed/simple;
	bh=orwaler7LYPzcnlYM1b64MHFz+kRiFrC7nmXo7jdkcU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PSDaUBkHwNeu+aml8HxRR5mtpbx8Kh0HsVm99PJf/s0UszgTUM4WuDYPCpleqlnuiv93Isb60ikyCg9ttryIjvmJA7Xi2PLahBQI+P1n2BlBdJORBHZbnTjItsZoM2D2f8C6AAWLKQ1RpbbQyXlR+8yRVrvrSh8dWATq9Mj4nwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgA2SBa5; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgA2SBa5"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c6e2355739dso755626a12.2
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 21:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775793928; x=1776398728; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A+3Cv3YOyr99RcnXrA7MXh2Rtu73qnee6TQygCJd6D0=;
        b=EgA2SBa5+5LX/RxLSJObLZVsaNzdkE+T63w03DZvA4LCJhtRhs4e2/8RJ9zPDZkY87
         jliRdlgcQhKppejbuKIrW5fLz31sGZiRFnKI1k82lkdNuHGJGsWR4wz+dW6j7+alXfsG
         2EsxEvR7lOqZc4rju7wsHz9NdiK7YQyL+T3OVoqh35FOiigj891tqk1aX/yaAugznRv6
         hgk9otkiZOKicwm1p1N8nm0XJxWj9eCpgPuKX4yBKFXp7cYvOhPoPRMV/VD/uj6HEVdJ
         N5djO7XQnMQiTUqcvvugPLfMs88YiEt3ZWJhuvihNmdzwXu9mrIR3cWdYr0Ik1RPnp27
         Nb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775793928; x=1776398728;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+3Cv3YOyr99RcnXrA7MXh2Rtu73qnee6TQygCJd6D0=;
        b=P2JdNRHosw7V2NCdDFLO8BoHk/nyle2WRGtzh6KwE6/2mRcyvYSzBHg3yw5a4zDc56
         eB+XtmBpzWPkofuO5N1nPtDGZlPTDNeSCiDW1qX2tAsLPjbXyIFkRRbSDkEIre6SryVG
         Sg0j50rYbdaba4lSS2eaBL2lNYSgEDQv1AVX0RS6cOtsMMA/wjIc9jE0/g8BRv2/GVsR
         juGOSOei4OQOTNFdnKSjnXcnU5oiyv0iGdcNdny8SD5GtOVEf8L0bL+Xz8SDZNiEuF4F
         RbOTWPb13QXzssKh9RZ3IwUpUFipW1F96gGd1RGcwBh+s8AqjNxAMcxN8FMsMq+Ttlb0
         XV1g==
X-Forwarded-Encrypted: i=1; AJvYcCWF3zqo80qsfz6vkRyT5382DlqW/XsQ3z5QElydbqX80/gAD+8/7m0Z/posh446aNXRZXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqsgbyFkdLPIPIjZ3nqImd+1RmkIkJ3qJYlkkalljEkeITi8bT
	/FLDWVF3wcRxwdheORKy0JWfiw0C3xqdvQMZxvRPa4GipL+GVHuk9ca4dyyMvaS3
X-Gm-Gg: AeBDieupqCxdELebSz3sIHFciZMW/fTZXnG2DeuPiKMuXFD32a8ce8U7qaqPp5+/f3R
	A6Ypc/GvxBDOid+my9kSoH99221b2PWrkfNP2tW6uO7roaH7P/l3kSU8F/Kug4QK8PLIMYDupwU
	9ywMIK5Y1oNelJTBbwzuSkc6INK8bHcjmh/S3MHwK1GKiy8LCYyM3xr3qbHfM8t+dVN9ebWKKYC
	dNb8TLZS9q9FTFalH0Vxg6/lZC8Zg9qO1yqaUVjxatRlP6BbEOx2OJL4va2jKvHuV3eL/59j7SX
	O+tF+1Ff33n0ppI0nTyQngcHrR83T9bMAB7qcEX8PwG6D01G1biXLFTesvy0wMBv8WYzcsyzzUU
	0JNgDXw3gl8I1JLLVFbJmylqM6n8r31+f2D+us4xLe9i+86FeeKBx8DxYcExlDdJYiGiiPaglwl
	1FUpe33hYeFfA752iGrTH0njPdoK/KQ48jn3SusuCOKmAaFjX0DRwA
X-Received: by 2002:a17:90b:4c8e:b0:35b:9ab6:1d4a with SMTP id 98e67ed59e1d1-35e4280ebc7mr1729459a91.18.1775793928146;
        Thu, 09 Apr 2026 21:05:28 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e35178460sm4937955a91.16.2026.04.09.21.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 21:05:27 -0700 (PDT)
Message-ID: <cfa3994154463af1732cdc47a3c86b1eeb8ea2d0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 03/13] bpf: Add spis_*() helpers for 4-byte
 stack slot bitmasks
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Date: Thu, 09 Apr 2026 21:05:24 -0700
In-Reply-To: <7d7f8f5857c7ba5ca8b5cbf34e001d1ff7afda61513f35e14edb441c5eee1d9f@mail.kernel.org>
References: <20260409-patch-set-v2-3-651804512349@gmail.com>
	 <7d7f8f5857c7ba5ca8b5cbf34e001d1ff7afda61513f35e14edb441c5eee1d9f@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-10 at 01:50 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 410939d7b325..124828c9a916 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
>=20
> [ ... ]
>=20
> > +static inline bool spis_test_bit(spis_t s, u32 slot)
> > +{
> > +	return s.v[slot / 64] & BIT_ULL(slot % 64);
> > +}
> > +
> > +static inline void spis_or_range(spis_t *mask, u32 lo, u32 hi)
> > +{
> > +	u32 w;
> > +
> > +	for (w =3D lo; w <=3D hi && w < STACK_SLOTS; w++)
> > +		mask->v[w / 64] |=3D BIT_ULL(w % 64);
> > +}
> > +
> > +static inline spis_t spis_one_bit(u32 slot)
> > +{
> > +	if (slot < 64)
> > +		return (spis_t){{ BIT(slot), 0 }};
> > +	else
> > +		return (spis_t){{ 0, BIT(slot - 64) }};
> > +}
>=20
> Should BIT() here be BIT_ULL() to match spis_test_bit() and
> spis_or_range() above?
>=20
> The bitmask is stored in u64 v[2], and BIT() expands to
> (1UL << (nr)) which is 32-bit wide on 32-bit architectures.
> For slot values >=3D 32, this would be undefined behavior.
>=20
> spis_single_slot() passes values up to 127 through here via
> spis_one_bit(spi * 2 + 1), so on a 32-bit build both branches
> would hit shifts >=3D 32.
>=20
> Note: this function is removed later in the series by commit
> 6314c1b64c52 ("bpf: simplify liveness to use (callsite, depth)
> keyed func_instances"), but it is used in the intermediate commit
> 3199040a2cb9 ("bpf: make liveness.c track stack with 4-byte
> granularity") via spis_single_slot().

Yeap, BIT_ULL is needed

>=20
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>=20
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/242217=
79050
