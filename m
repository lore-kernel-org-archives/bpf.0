Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138944E3258
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790718376; cv=none; b=ltqx022YZuGtFCbPHDiiyo90Z5bqv8P4oRDXQZpgypVshC0kBmV4uukxhPH3V42LKiStViXTuZi2LYKp3Sho83QMS0FHuABJiQPKcJnEfBF/c0vkvQytliJzU92nFD78DLwP17mnub6OiA+LX196ofR0qYKt84ACOFq/MCniXSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790718376; c=relaxed/simple;
	bh=c60XZr6gjgTXxTb8TD6mSviBn7hGFt9Ur2eTffcnqXw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KeCOz8HcXHkpydUCrflBmkpA/4SNNxHa62UeZtvAjt3Pv+K1HLJapiQjQjjz3opzaORqtD/SrV+KuEJp+/Iqqb12GVQzGT9JUJNO3qVU4c33gBxSTy4HVv5JpAj9odez6SnI59W6OkY/3gvOYlQme9J62i5RnkEsQAYkw5JpA48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dG9povtw; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG9povtw"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c11ef641aso4945733eec.1
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 14:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790718363; x=1791323163; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gtOvtANTNZsbuqRv+rrjZ79D7N3AuJOn+HMwiY7MqVE=;
        b=dG9povtwQMJsOvt0KhJk0eKuPSO00sLgOVlk76zhnYzNs1dmo3W3/1w6eOop4W0PpF
         Y3yW1+j58WnoUPQOnO2hHxAe6TFfFI78aB7SYjPtK7+XoAvb89CKbcXq6rW4VuUZZ57U
         FGaolP/QjDtdiIfXbj7HDEggS1eeFOPOV8gdFTc7ieD6hwNkKYkLf76F5mZ5vpjOaJVZ
         2Ze7vsqeFe5O24T2TEGdD7Q667QzbLmpMMmEL7HuAQYyLp3LokhEkGUe3eCjg+Oifz5Y
         blNaOdXl6gBbvXXA0LLnkxBGxR7QpHne/6+EGrsj1XtOz9j+ipV0aodgQ7ST4ImSEC6P
         LJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790718363; x=1791323163;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gtOvtANTNZsbuqRv+rrjZ79D7N3AuJOn+HMwiY7MqVE=;
        b=nU486yRZ6Wy6wit+DeMzlY1nxZ6WMCaCELL4mpVfdbDr39owZZHRk0O1BWDNRT5K0W
         I/YiajkJeFWaw8u/rgIZMnuIsSWDWi4UGdlxssSNjypxtRTnEl9fDv9xgXmdomvaLISJ
         MUkZo9+u7Ij5JIMmLO5+mexkIJf3fjWB9G2OqQLMqzVf6W7485Q9P5KQbqcQ0kXacOzy
         7uz7OS1MXjLJF4/iWywPD5X/nsAt1RRG1hO6NQghtYdTngWjiLII/DE3Z2DjxGBzQIHk
         ww2OcdaBRFsUe/OirmZq90Xvo4TsV8l4hzTvx0M5ou002yzrIiot8sYcncUXkEdpGj6n
         N7vw==
X-Gm-Message-State: AFuF++k6zE+QUM1wjMkgbC6K1u4qOLPkh7asL+uDX3PzImWq38YTXXLb
	X69nGyOZYpDPe+7k+1VCr1cT1H3qh9isFBvZVYlTymfusP94cXiRBduxeVmr30jb
X-Gm-Gg: AYBFou1zxO+E3gTNATLyA2pWeqh5M0fX6YXjUAeARzt16eQYQdc3ysMPAOrrJkd2d2N
	4haoNAd6sNHsniBohAFGrpCprzf3uM2InttS/jB2/G0c6ki6gq3c/0asrIXATX/Don2nzcBfM7r
	ndLJG+Q2e2utSB/zYbDVMIs253UOZRDT8pkDn1rgWZK4YSCIYvqrZZ2zqzNg3abh/8zSc9O/m0T
	puELGh0gsFC4ktwR8/z5b4MRMh3j7N3AHcrDKuUdM80h3wcpwRK/mJ+667yRxBNsyBK7uV8AzXE
	k3TouwjbCyCy6NCfmZNw5TxST0F6aI3KpiqyAGRhmm9MBlfbJVaJAMKcG3J2d2Sl4dxdCm/d5R1
	A9Hj+/ZYIbD9ZFkF53BsUVcNBcLZN7p81a2rCBOZZO/nUrnJxwNOcE4EuHPGKKfICPrFMn5/cMx
	E50by9UQRJqIaDgUw4IJMshdhy+lwmzulCajolZknrD/ceT02KaeNtq2p2b0hz1rvcTm+6+h0gS
	gWho0NbIk+o5PGGN6svmBRWZCJNOY0xANcw/zbJZQVnfwViw+ZYh3x/
X-Received: by 2002:a05:7022:f210:b0:143:7821:e151 with SMTP id a92af1059eb24-14ca00a1a62mr735605c88.47.1790718362606;
        Tue, 29 Sep 2026 14:46:02 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:abbd:bfa5:f574:cca3? ([2620:10d:c090:500::7:dfd3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14c640bc413sm1524006c88.11.2026.09.29.14.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 14:46:01 -0700 (PDT)
Message-ID: <9176a077b5ba674b0d35cd4db36bd239f99f48a7.camel@gmail.com>
Subject: Re: [PATCH bpf-next 08/36] bpf: add cnum64_intersect_linear()
From: Eduard Zingerman <eddyz87@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Date: Tue, 29 Sep 2026 14:46:00 -0700
In-Reply-To: <20260926143403.113531F000FF@smtp.kernel.org>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
	 <20260926-scev-minimal-rebase-v1-8-c8e5ab5ba79f@gmail.com>
	 <20260926143403.113531F000FF@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-09-26 at 14:34 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] bpf: cnum64_intersect_linear over-expands intervals that wrap =
the signed boundary
> --
>=20
> commit 07e53bba30487c590757dc2ec233d2811a607b9a
> Author: Eduard Zingerman <eddyz87@gmail.com>
>=20
> bpf: add cnum64_intersect_linear()
>=20
> This commit introduces cnum64_intersect_linear() to intersect a cnum64
> interval with integers congruent to 'base' modulo 'step'. It tightens the
> interval using signed bounds to keep residues consistent. This is a build=
ing
> block for tracking scalar registers with values known to lie on a line.
>=20
> > diff --git a/kernel/bpf/cnum.c b/kernel/bpf/cnum.c
> > index 86142cb2aee5f..2bff2c7e0cdf5 100644
> > --- a/kernel/bpf/cnum.c
> > +++ b/kernel/bpf/cnum.c
> [ ... ]
> > @@ -118,3 +119,38 @@ struct cnum64 cnum64_cnum32_intersect(struct cnum6=
4 a, struct cnum32 b)
> >  	}
> >  	return t;
> >  }
> > +
> > +/* Intersect 'in' with the set of integers defined by equation 'base +=
 step * k'. */
> > +struct cnum64 cnum64_intersect_linear(struct cnum64 in, u16 base, u16 =
step)
> > +{
> > +	s64 smin =3D cnum64_smin(in);
> > +	s64 smax =3D cnum64_smax(in);
> > +	s64 lo, hi;
> > +	u16 d;
> > +
> > +	if (step <=3D 1 || cnum64_is_empty(in))
> > +		return in;
> > +	/*
> > +	 * Round smin up to the next value congruent to 'base' modulo 'step',
> > +	 * i.e. increase smin by d =3D (base - smin) mod step:
> > +	 *
> > +	 *                 |<---- d ---->|
> > +	 *     |-----------|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|...
> > +	 * base+step*k    smin       base+step*(k+1)
> > +	 */
> > +	d =3D imod(base - imod(smin, step), step);
> > +	if ((u64)smax - (u64)smin < d)
> > +		return CNUM64_EMPTY;
> > +	lo =3D smin + d;
> > +	/*
> > +	 * Round smax down to the previous value congruent to 'base' modulo '=
step',
> > +	 * i.e. decrease smax by d =3D (smax - base) mod step:
> > +	 *
> > +	 *     |<--- d --->|
> > +	 *  ...|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|-------------|
> > +	 * base+step*k    smax       base+step*(k+1)
> > +	 */
> > +	d =3D imod(imod(smax, step) - base, step);
> > +	hi =3D smax - d;
> > +	return cnum64_from_srange(lo, hi);
>=20
> [Severity: Medium]
> Does this code improperly expand intervals that wrap the signed boundary?
>=20
> For such intervals, cnum64_smin() returns S64_MIN and cnum64_smax() retur=
ns
> S64_MAX. The function then calculates 'lo' near S64_MIN and 'hi' near
> S64_MAX, returning cnum64_from_srange(lo, hi).

I'll add `|| cnum64_srange_overflow(in)` to the entry condition.

> This replaces a potentially small wrapping interval with a massive contig=
uous
> range spanning nearly the entire 64-bit space, violating the intersection
> property (A =E2=88=A9 B =E2=8A=86 A). While this over-approximation is so=
und, it could cause
> the verifier to lose precision and falsely reject valid BPF programs.

> > +}
