Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792623031;
	b=RBSIJfWNevyKR6etcBgpAmHQJpGPCp9hbyjl+JEwH8GH0LcoQFWYN8Ln0+0H9H6moETJ
	 6cGn6RUKQuKP/PpE3hId0v2e+Q+paKKmvPdVTbLErrj50YxsuIeaZZeUNBs9xowgLFHwU
	 yqerqBumqgHHhJHtnwHIOGYCmtGCeNhhZ+Q/WpdA+7LEs5GYTNpdNr51qXn+pfhjdWrky
	 xPF9Hyi7OypzqUPzByyJOFrRFZhQNg0gBEPi1sSo6T0Bd6fKjtEskQV47e0GUpfsI+CH3
	 Ksjy7nPU7/jFPVvV9NhBZrbsVrGklZtn8ejkuvd5rADv+WayhI4H6fPEmH/35hEEDjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623031;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=yXmnWq/gCLjc3mMk4LjW2YKmKS1CMT7ul7aIdEl3gPs=;
	b=FFIloVNLtg/FMu+2S93LsQWEbRi2x4HhlQXlJGE1KF+XPrEhRycPHNANFIilWIzbh1In
	 MbnQ1HQbUkyjH7r+fssLo+1vjAucp7kSdhsO+EuGiCOJfKPuF0gVDL8+OvbvCAZTwpjqY
	 wMygANyUwbZZqH2TQFrzu2Jk/icke8AIAKuYDxfmLKYydtpPKsGo3hRb2AvsYWlSY/m15
	 vwC5eHIrOl4adtxSe3nktd724bQsIV0NXIaa0lpee/z7BLo68G+i/KNhkt2gEJ9I8NcBh
	 FMseavP0cmt705BhJE714OKpIoRm2VKvLzOBlqS7W7gUa98PB5arafk4g5QI+yvIvlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RyY9+TMp;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B461E606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 22:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B461E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RyY9+TMp
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3282db206d3so2900533eec.0
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 15:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792623030; x=1793227830; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yXmnWq/gCLjc3mMk4LjW2YKmKS1CMT7ul7aIdEl3gPs=;
        b=RyY9+TMpDKnJ3t+u3ck+1VHaqQAkPe7TBmRYKdwmxCY0HDaqmbR5n2sNVlzOfMYPAj
         5j7LkHCVeh3zmpZizQgOU2SVmc4aX37eParM5F48pWGYcSJWizcXckIHKHI85dIsJsG+
         YlZY75nRohECN5KAusrqBlw2Hnq0AI3+eAgi6XacNjDpAHapMjk6NeWuDxWbihE1TiGX
         f1VVHK7pWqnkbv7gTKE7Ee3nH4Q8MCHEVNL0UhlNOZ+XEznnYtmpJ+TsQPd4cZd/xnrj
         319KWjpdst0WQUn/PmSDKOGam6HA3Z0krsu63set/ppRRu1VAMkLV0vQjzAYEoY2PUxz
         31DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792623030; x=1793227830;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yXmnWq/gCLjc3mMk4LjW2YKmKS1CMT7ul7aIdEl3gPs=;
        b=FjTp1UscoNRRcr6CTri5at0HCnLxS+MJoO8xBZfywRrO+ocbQlxNlqUAtQKTiDcKGS
         K5HGHYfhj8OxIa9oFCO3KRYnvK1T42W6++AEP7UqC2PesV6zzZNy1OUNpuDsS4Q63esO
         1gh/lkBbEu2vod12ajknJ1zRMP683sJGqgXTShzvynRT9wZLF+ebcyiA/fKFkLFfnHdU
         mqhb5eMDxvCKQWvszPW/FHMR7Szg5p5nnXXn5DfoJKHzFwtWBawV9zC81Pdy/eTzCLcY
         mSQ/U7pQ5VjlVZjHA6v31vO1mECTOb7aesvX2T2oJXmTvtyMw4mSHvBtxFzys5tOzM5s
         XBIQ==
X-Forwarded-Encrypted: i=1; AKwUvBw07VHDmsPnzHMva94jBfBPuEyZJd7A8mdXkpaFB1qdq9yqcrqrgtCt8C3Dc0BieTnaSso=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpGB32b6GnHckgu7IhEluHLT2g60Ht7nZ9VWwmHZCasoevqxVK
	NqrrT91xTRbL/rSXXfBvY6gxI1xgUZ0bTCdKVSU4b/5tuy76Daw+6tBp
X-Gm-Gg: AYBFou0is/inufyXgLqunxC5ORPuVPZ0ka+zGGrF4HVZF3BX5S4Ex9WWmk/Cqb50doG
	cvK8TLk6zsYmcd4z3LRIqaxXVGQUGj2FEjQ1bb2pcCge1jkPJHDNTQ8xoGWaIrZXSH1mTMMJt/g
	O4zfLlRarcRT5dxY5gwh1qOE25eGPyk3EM44UhkgQQfjadB4WwGfEiYsSsVK2xY15kvhsj/PufR
	VhPN+SDylb5/OXN8CPzNbyOl503v0CXEg1anZcwH/dN0meFmZU17XnSzkN7RqUfaNLpWOvYynIC
	Pl8bSvc6Oru2C+KFFGjmcTW1bA8V6b3Pi+0ZjhskMtMyWju12fv8svF5OTVhgdi17w7XV0I+XSZ
	1yYnpAheLgeRd37TlxfFxsr6FtuayeicDIgEeY15YOz+aoyc4HDm67plsv81ptyhpZZSikiW/ib
	I1PU9QV5f8g8jbwY8zc1Ej5BFdMEBOlgDqgzoQhg6/7RqQX2Ez14cSwLZ4LvsIRkHYBjErVePYh
	TIICGYyNdhJwOOzB+anhtrBFPfEBxCnFOW/TSJHoRJuX4ryWm35rE2HD8lK3EEYdPu7C1umOuun
	rk/vzuXPAvORADkVvx9Fn5t64kf/+s3y2s662Q==
X-Received: by 2002:a05:7301:18a1:b0:359:9302:a526 with SMTP id 5a478bee46e88-3674c93ba42mr4415524eec.7.1792623029766;
        Wed, 21 Oct 2026 15:50:29 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1e74:b094:f745:1e3d? ([2620:10d:c090:500::4:90ff])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367405edd7bsm10580415eec.6.2026.10.21.15.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 15:50:29 -0700 (PDT)
Message-ID: <fefe4448c7a9f9938c78f1597dd20fa96f180002.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: reject pointer operands for 32-bit
 recurrences/latches
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, 
	andrii@kernel.org
Cc: daniel@iogearbox.net, kernel-team@fb.com, yonghong.song@linux.dev, 
	memxor@gmail.com
Date: Wed, 21 Oct 2026 15:50:27 -0700
In-Reply-To: <DMAV87WUFF7M.1PU3M3CCZJDQJ@gmail.com>
References: <20261021185609.607075-1-eddyz87@gmail.com>
	 <DMAV87WUFF7M.1PU3M3CCZJDQJ@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-10-21 at 22:22 +0000, Alexei Starovoitov wrote:
> On Wed, Oct 21, 2026 at 11:56 AM Eduard Zingerman <eddyz87@gmail.com> wro=
te:
> > Fixes: df4761bd441c ("bpf: Support 32-bit linear scalar evolution")
>=20
> sorry, few commits were dropped from bpf-next.
> It's 32e962577d2d now.

Uh-oh.

> > +			/* 32-bit ALU operations on pointers convert them to scalars */
> > +			if (coefs.zext32 && reg->type !=3D SCALAR_VALUE)
> > +				goto cant_widen;
>=20
> le64 does the same without zext32.
>=20
>      r7 =3D map_value, r1 =3D 0
>   l: r7 =3D le64 r7
>      if r7 < 100 goto out
>      if r7 > 1000 goto out
>      r7 +=3D 8
>      r1 +=3D 1
>      if r1 !=3D 4 goto l
>=20
> On little endian transfer() treats le64 as a nop, so r7 at the header
> is (linear r7 8), while check_alu_op() makes it an unknown scalar.
> At the backedge r7 is a scalar 108..1008 and bpf_clamp_scev_regs()
> intersects it with 0..24, the offsets of map_value at the loop entry:
>   verifier bug: scev clamp produced empty range for r7

I'm going to drop intersection from clamping, testing it now.

> Should bpf_clamp_scev_regs() skip the reg when
> 	entry_reg->type !=3D reg->type
> ?

Not clamping would be bad, as the induction variable would get a range
outside of it's possible in-loop range on a backedge.
For this particular case, I think le64 should just stay a separate
expression, not a noop. E.g. during transfer() "r7 =3D (le64 r7)",
hence no SCEV would be computed for it.
I'll check if there are other operations that have similar effect.

My take is that this is a separate issue.
I can pack the fix with this patch as a patch-set, if you'd like that.
