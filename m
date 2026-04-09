Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447A126FA5A
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 22:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775772330; cv=none; b=VauwyDVGyI5aJn+mvoh8R+Qh7/IGHaMsAIjBcvwTYVei0vDXaL0+HjUGOkAtHebiehfIjsX+wAVzXkhWwQhuNUgMXQ78/xheXSkkRd6xNNi6q/DYMeijig+OfHg9G2zK2PnPim+mT0j1mkkhWRkqhNo+0o+T/WCRi4y5GL3imgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775772330; c=relaxed/simple;
	bh=xcMg4gw4LJuvSxfTYlTaLHvdiVgEIOuTpoh+QBpcBhU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jzBkjoAy67WMWWYxUUTh0ybRGqK1tfds20mh4efLLRO45r7EBrL3GrDDC2gG47yypqduL9MoLKmamTDGZBCQsO7kyIWg11Q4mE6pWxggd1jsbrINN1Br4DG77GjegZj7C4TRpRF9VwlTx2/kDjf4CiGOQZYFr+YQKnhbnedwg4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i80UHobZ; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i80UHobZ"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c1fcce8f8so837103c88.1
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 15:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775772328; x=1776377128; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WNBLLqK9AfCWXJ2m2hkd3Q7rDlwxtDSJvDVAr+v8ZPA=;
        b=i80UHobZVXxGZQJyS5i9tGvhXXSC2Npf2Zfpp1vCYcMO5oSQHK8dq2PUT2/w4PKWsd
         vEyxeY6crjRktdXesCcbuLpIgnQR+ohdPO8PnFNjyGNqnqDC0lgxCbxJidniCYVteFsd
         y3MaxtSVgr24xRGAimDr7Uh8PVjM52Xsdl7Rka6wm5dCyzFR+tTcggO1rO7swizCN2QU
         vVFZh4WWP/MgSXpxgGYRhZYC8UYskPoqwVq+1jXSIdYS5CdshEdkgbfWIIYfGxhWjvt2
         yGG9PfUPufRTWMKM8p5BK++/+EBJ4JG7bv1H433HLtLJQm+yVvK3Z59UyWM2DZjwlNVd
         Q14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775772328; x=1776377128;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNBLLqK9AfCWXJ2m2hkd3Q7rDlwxtDSJvDVAr+v8ZPA=;
        b=b8YDEMfsupdL38ZNn7IM9QTUq5jB4aIcYr4IFvcz1+SHW2fTgMF7fo3Z5B4+7LQqWi
         ZXURKW4pEqWU+5R2bBeMXve7jt76uIyYcW6kfpeZvE97wzC26YHldjOvUJmV7425CcnO
         3+5hqxgVQ3mbyOeT+kItU/c6d0gHUr10yrTcW7Qyth34zhmiOwHNQv9QTkU03X00PDMy
         UWWUyux0TtZ6gj00pJPaCP3YfoICDkYLxdgowm+zGzR76BVGtSzpkb2r9/IGLX9L6A6H
         Ug+QGCB6gwLiE/Hze8p4s+T4/T9WHWZuo58e6mtnm8ZBbWBXmuoS+oyNmCYR5+s/zyiP
         aOaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCj2urpnat16Yvh5/oh2jyifCmhm0QedaVouH5/eisVi7R/9FKlk30dUpMrCMbKeSAHPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6E/5sMNemCpnOyWhhfGLg+qBA2GDHFK+4FTXPDMNZJeH02T84
	Xo2SCgcp7vlVJYuSSA3lz5q+bWGZLnorrpvNSVgdjnnsajkTj0KUWUc9
X-Gm-Gg: AeBDiesFjTy8dsALU/Scn9U+0wU3evjNB5Hwr8ulfpISqkzhaJHMbepVAY66VMbU3ee
	T8AJBTkZSBS0ZT+8r6D5PCtcj8XsdTz/2Q+G0V2eKskNQLB+XYXA0w7Gu6iVPEDx6kR8Li4iBRd
	hY2/R/gKEuJyWAVof1Wt2omaHyW6//tqxUu2j78OJBTK8+cbuB+KjaflP3yYTpd9hIq43kHNF42
	cwNQ7Fz0171clHfuPsK6Aqi2k/Xot1UPJ/puDQ5lYV6NvIop3q2T2JRMUHd3hBaiCt4F4ySC5IK
	y5DB8gmQhNIOhnjbXz2wIELNboZF6RU4OmOXsUBhhaME8k/juqUQVHxFcHaLNW4K+reLAvBLK7Y
	r6Hkr9GIJLewVZPn36c+Jwn4OHQimnygS33wsmJGnYrn12KyTqoklX1+wO4ImIYU2OpS5Wih614
	g/iagmmiu29Wt0q8iTeACDFbi9RegD1tvWtDgJUFPfcjvTbEzDRpRC+dVv5vY3Zhp0cVZ2lF2nv
	NnWWIE=
X-Received: by 2002:a05:7022:128e:b0:119:e56b:957c with SMTP id a92af1059eb24-12c34e3f26dmr533339c88.1.1775772328103;
        Thu, 09 Apr 2026 15:05:28 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:7da6:9d9:d70c:7407? ([2620:10d:c090:500::2:f3a8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c345b6208sm1327517c88.8.2026.04.09.15.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 15:05:27 -0700 (PDT)
Message-ID: <7dd54c3cfab9996661699a10710e24cccc79fef4.camel@gmail.com>
Subject: Re: [PATCH bpf-next 03/14] bpf: Add spis_*() helpers for 4-byte
 stack slot bitmasks
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Date: Thu, 09 Apr 2026 15:05:25 -0700
In-Reply-To: <bebd6ee70784d72f6b6d36e1cf6cec12bada144fb5b15f0acf5a234be1fc0616@mail.kernel.org>
References: <20260408-patch-set-v1-3-1a666e860d42@gmail.com>
	 <bebd6ee70784d72f6b6d36e1cf6cec12bada144fb5b15f0acf5a234be1fc0616@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-04-09 at 03:12 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 410939d7b325..64361cb49073 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
>=20
> [ ... ]
>=20
> > +static inline spis_t spis_xor(spis_t a, spis_t b)
> > +{
> > +	return (spis_t){{ a.v[0] ^ b.v[0], a.v[1] ^ b.v[1] }};
> > +}
>=20
> spis_xor() does not appear to have any callers in this series.
> The same applies to spis_set_bit(), spis_single_slot(),
> spis_msb_half_slot(), and spis_lsb_half_slot() -- none of them
> are used by any commit in the series up through "bpf: poison
> dead stack slots".  Could these be dropped, or are they intended
> for use beyond this series?

All of these are used in:
"bpf: make liveness.c track stack with 4-byte granularity"
Does the bot check out correct repository state when checking for this?

>=20
> [ ... ]
>=20
> > +/*
> > + * Return a mask with only the MSB (higher-addressed) 4-byte half
> > + * of an 8-byte SPI set. This is sub-slot spi*2+1.
> > + */
> > +static inline spis_t spis_msb_half_slot(u32 spi)
>=20
> > +/*
> > + * Return a mask with only the LSB (lower-addressed) 4-byte half
> > + * of an 8-byte SPI set. This is sub-slot spi*2.
> > + */
> > +static inline spis_t spis_lsb_half_slot(u32 spi)
>=20
> If these helpers are kept, the comments appear to have the
> address direction inverted.  Later in the series,
> clean_verifier_state() documents the sub-slot mapping as:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0half_spi 2*i   -> slot_type[0..3] (closer to FP)
> =C2=A0=C2=A0=C2=A0=C2=A0half_spi 2*i+1 -> slot_type[4..7] (farther from F=
P)
>=20
> Since the BPF stack grows downward, closer to FP means higher
> addresses.  So spi*2 is the higher-addressed half and spi*2+1
> is the lower-addressed half, which is the opposite of what
> these comments say.

Comments are fine, LSB and MSB are not mixed in __clean_func_state()
and here.

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
