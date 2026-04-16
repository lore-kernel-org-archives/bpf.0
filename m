Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7795238C36
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 23:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776382390; cv=none; b=ass35VFBQXKxh7GtabCNZsr4c5OcmjwYWUmReNes8XdE1Zs3XPUd9ExSekduzz44lDu8mmGqUCxp7/TADEbe4MKYNGk/fXh7a0cKW0q7MNO8FRD55807mYKv8bHNtcXNS21Xu9E0cr8brTKflBWJVetI1qVjagrgYVe45ruJ7ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776382390; c=relaxed/simple;
	bh=8trtVicYzjHwb+9Ou8kPj9n6BtA4f2K6a2frDt3eX9k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nc/zyhvafgqTkiTnOTiM+eMiF94yveRA/AMIIG6Os3gJx/mP3YP+zNsSjmPMd6tRqfXSX0xE/EPiZ9YrRF5XBVGUq4xb1q2UB9uyD6xJ2RDHM20CQDu7KcigjnunsH/ogI0EdVVbpXQfkjPBWt9NThz24v5JsEt6DYLb0EzmWbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClwaGu0V; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClwaGu0V"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c42a23c8eso91630c88.1
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 16:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776382388; x=1776987188; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8trtVicYzjHwb+9Ou8kPj9n6BtA4f2K6a2frDt3eX9k=;
        b=ClwaGu0Vi/SakaSpiaf8C430Wa2MZBsDTScca3bbq2M2Wssre0jm3RFAKiNQDKisHc
         KmlaBhoXRChvY/dONcEiTmhX+n5BDpNhV20OKG5m5+bPP2dAUPBk49dZ2bZdQdZqrW3w
         cGy8jYRCnUkJFK9HmLpwBVQ/VHfSTXb96+F8cEQDZuHV6iuDiBh7xmLk9Yjt1utIZOIn
         lIXxZ+Lq7UiG0m+0YlNxharCXcRsnh8MZQfjJnEsu7CG9RGmmSs8DymCawr8TUu8w499
         8EZ5+XO8iOlpehHbtYvDIaIKJTzHEeH4uHU01lIQk+c+zYJkQLofGax2shJhxEZpLLcE
         RXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776382388; x=1776987188;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8trtVicYzjHwb+9Ou8kPj9n6BtA4f2K6a2frDt3eX9k=;
        b=LsAq9c64LG3uZxCdQu49VFmoKKnLtZE4g+W3826kGa9co0Avp3vxXd5TkVZOtZQAqy
         +ubNCs5tQtrY8o8VdRHt7P1/kdPu4fAASmOiT5Ix57RhEgcLm2DAgJgFBff3BZ2ejIHg
         g0m8pbWKCMtGOMeVI1+da0/4kbnfi9hSUqvzldBQSi4+hRZK0DAhY0tlS+6T4b8Kdib+
         jZfQGGDAPSC+4ljdzZZzQJECatwwoyESp8z/8kDMjIqGtlAjKY+p8DRz1QIpgePCoCa1
         e8JHUXuQsYFkMdF18Sba6ocaf/Qt8VqaBHeGX8vsTNaLEANFi3XqZtuo0dVZ39bLgE+7
         xBkg==
X-Gm-Message-State: AOJu0Yx2oF3Ir2d+GBFmgoxSgW8Co0LpDeG+UjIb3n9CuLylEwIOVPWN
	kuozoPZw7hGYFCWB95Fb0GCrB/XS/qsWLT7pARMIfmGHh7ULRkH6T7nl
X-Gm-Gg: AeBDietNXL2+UzHvOO74KEYRqDHQKuz2M2YavpEO0kLRD5Pny9nPkWwJ3zJx2IomnF3
	IW4Kqw0ss9X7NIDBbXRsFeduzVBcCSzaDv+Y2H7evfRAFv8G4xn9dWnqNkjr7AJwN6iO34gAFAw
	hVhbcNJtb+xzQp3mJbzk92KpefJNVzLx2cZ0a4BXhQs8vnpJbdzHzsYmmOYY2AOajzguIksVvsp
	M4E1nR30th5tcFwuCP+c1BmwOFjKEBDZHvd9CObSeMFHU2gUQpoPCXL8LBY+MZ/F4beVOsXadWC
	C8kANWRoigp4gi23NK1BA2OMBIArPY5URRd5rz3iHIRhXpb5ZMMacusrvivy9arQ4LmwuGFTa9R
	sXLFhgTWh7gewLyXXbQYE9vYkC2H2xC76z58htbpuUNe7rJ2TKkZL/B/nekDAnu65X97L2aNcWA
	7QdgmmEIcUx1XxdH9UKsBWlHBjrU9vE726HWezEOXiGTCdT6QO1T2NrBYmFXOgVw8VO3X8H1QMu
	5JKotm3EzjwJ2tRT7U=
X-Received: by 2002:a05:7022:e1f:b0:128:d7a7:526f with SMTP id a92af1059eb24-12c73f69304mr162972c88.4.1776382387641;
        Thu, 16 Apr 2026 16:33:07 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:5ad5:c590:c35b:1723? ([2620:10d:c090:500::2:51ca])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c5e6b5627sm7647638c88.13.2026.04.16.16.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 16:33:07 -0700 (PDT)
Message-ID: <f79d58337ec3628a52d41a09e2c35e598ab656f4.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf/verifier: Use intersection checks when
 simulating to detect dead branches
From: Eduard Zingerman <eddyz87@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Paul
 Chaignon	 <paul.chaignon@gmail.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Srinivas Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Date: Thu, 16 Apr 2026 16:33:05 -0700
In-Reply-To: <CAM=Ch05O+m3gAAz=EW=ZPrhnTMrrMJ51ryMkwROnfkBMVVxnaw@mail.gmail.com>
References: <20260415160728.657270-1-harishankar.vishwanathan@gmail.com>
	 <20260415160728.657270-2-harishankar.vishwanathan@gmail.com>
	 <2ec3db2d2960d9c13577d630306f16873ebb53e5.camel@gmail.com>
	 <CAM=Ch05O+m3gAAz=EW=ZPrhnTMrrMJ51ryMkwROnfkBMVVxnaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-04-16 at 19:13 -0400, Harishankar Vishwanathan wrote:
> On Wed, Apr 15, 2026 at 9:10=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Wed, 2026-04-15 at 12:07 -0400, Harishankar Vishwanathan wrote:
> [...]
> >=20
> > For example, given the current implementations for
> > is_scalar_branch_taken(), regs_refine_cond_op(),
> > deduce_bounds_64_from_64() is it ever possible for u64 range not to
> > intersect with s64 range?
>=20
> > After spending some time with pen and paper for BPF_JLE operation I
> > suspect that it is not possible. I also encoded this as a small cbmc
> > test: https://github.com/eddyz87/intersection-check.
> > I suspect that same reasoning applies for other operations.
>=20
> Hi Eduard,
>=20
> First to confirm if I am reading the CBMC code
> correctly, the precondition for the verification is that the inputs to th=
e
> BPF_JLE code are
> 1) register states are valid initial states (at least one concrete
> value satisfying both its u64 and s64 bounds)
> 2) the input register states have been passed through
> deduce_bounds_64_from_64()

Yes, that's what I tried to check.

> Without the 2), the verification fails.
> I am assuming the rationale is that any inputs to the BPF_JLE code in
> actual verifier will have passed through reg_bounds_sync()
> in a previous instruction.
>=20
> If the understanding is correct, then, I had the following questions:
>=20
> 1) Other reg_bounds_sync() functions.
> What if the other reg_bounds_sync() functions update the
> abstract register values in a way that makes the jump operators
> produce no intersection between u64 and s64 (when reg_bound_offset
> and update_reg_bounds are run at the end)? Is this not possible?
>=20
> 2) Other jump operators.
> The CBMC code currently doesn't check for, i.e. JEQ, JNE, JSLE,
> JSLT, JSGE, JSGT, JSET. Could they produce an u64-s64 empty
> intersection?

To answer both your questions: this needs additional investigation.
In general, I think it would be nice for the parts of reg_bounds_sync()
to have the following properties:
- valid register remains valid
- invalid register remains invalid

This would need some modifications and proofing to work.

>=20
> > I'd suggest to drop the u32/s32 and u64/s64 checks, unless a counter
> > example can be found. I'm not sure about 64/32-bit checks.
> > Wdyt?
>=20
> Given Paul's tests [1] on the Cilium suite revealed almost no performance
> impact of these checks, should we keep them all to stay on the safe side?

What I don't like is that we go through all the trouble to intersect
the ranges and still have an incomplete result, because we still don't
know if all ranges intersect at some common point (that's true for 5
arbitrary sets, here we have connected domains, so maybe there are
some additional constraints that make pairwise comparison guarantee
common intersection, but that requires additional reasoning).

Could you please comment about the witness idea?
Suppose reg_bounds_sync() is modified to preserve the properties I
described above, would it be sufficient to check two candidates:
tmin and tnum_step(tmin) to identify a register in an invalid state?
