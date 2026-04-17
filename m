Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97B233FE12
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 23:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776467983; cv=none; b=aptDBPDzIqU8HU1j/+z+A0olPgIJSY5pNIyjkYDqeYMC1IYVpQ1trJ90HIKwMZ6VzyzwKI6nPdqDdoLRwmP7yXX4EoqQ2QcL0UUaKGUf4rBa5S2TfnwpMoqJWWVFUpHTO9ytbivQ8dqGrXpGON4EpzG85NQnCuxrWp3yCThMaKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776467983; c=relaxed/simple;
	bh=i43VBVnjTJdXPa+nC/jjKPKLY4J5naEvKAwwDwcQ9YM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C/NDLIoqUJjfvSDdPdmzt42SzB/Mcamduielrdnw+VObJg2JSBLuQHhh7QDUizhhvii/e5pvP+SCdNhAz7ZKgr2orPAKIHzfqbwOp0nWUibJyyT1d75g8jhGFe8t7BAdXbD8T5n1UW17eUpCDTivIpMGAQDzEfBKhVuifO8AoAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etdAtoOV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etdAtoOV"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ad617d5b80so7473845ad.1
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 16:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776467981; x=1777072781; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yQclOjtNDAkwra02Ls2AFMOt5nxyVbSYJ1LrZ0tRZrc=;
        b=etdAtoOVhT/5QT25ZAxPXYGIMWzqtwCLamQHchDvCShpH2YK3/F4Eg41ry+rzQlKME
         vVi834c6LHK0tPKD+DQ1tIjp4ni+814RGf8PsgRdeCSAjqtkDXpWM4RBBNmbAfAthc1d
         HAG6TzcBDIPMqtBkcItHHmzouyesWAgOpIbU7mmBoUW2E+zJtUr91kL1tcxJlUfUSEus
         HbviZKCJPW8Na4nW9dffL2Iff0GLEIRb7/YQo1vSMIjOCL2Hf6dUjcdoojk/oDWF1NLC
         o4MjcNB9Bms7M5mY7DwlxJwafrHGp/pb51KesrwH93iOBVkVGLWbMXlhNDb/PQxEdI3o
         QddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776467981; x=1777072781;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQclOjtNDAkwra02Ls2AFMOt5nxyVbSYJ1LrZ0tRZrc=;
        b=jH92nFEiPjxV8DUZ2QTa88zcy7mZzXdC/4zCl2tOam3f0P3zxSahiNIKJui+KBcZuv
         7m6aEKBOYccSauIEjBwgveA5vd64G48GRb1d2fLAH/pMoRrQEgzOmnE18CL+IpJ8Jhf+
         t0tSWp/GDwvWQEwnpy2auZh6aLYvBAls8xZwp/jcKo9OG3bJ+59ZXlARNw1uoD4txFv5
         ckyFOO6W3Shf7AijU9ztDs9CrhUliB7Iuf2cLhg6EJSeTW00J9o3y/FzQ3RX3+NXP0IC
         Wen+Ksk3z+uvByNK7tGVjDN0IO6B2PHucbw5ehsrbjyNpxf0nerLugw+R7Mrt7aVHvWu
         XnVw==
X-Gm-Message-State: AOJu0Yw/FmjKpmOTCxrW6bCXXNqGmf85FgISAXXkQ95HKzCtUfDBzFQQ
	qRCFYz6NmnqHj9//gz0LLVRyvtEJYIquPBXU229hLx2pUMBtPiBBoeNT
X-Gm-Gg: AeBDieui9AP7mCK8MyTlgrENC9TxkvfN+bMbQU4hVjOdhLHMUWib+BSy0aipm2Qx+I1
	29wW1dX1Sqxl8t1a1X36EDdhfZmtO9SAaNFBMYpjj13Gm8VJRJElvC40sOS0cXRAYzb0J5T/fKf
	oAcMyH52/BUwGXEpskgwMiM+y8ob7CPXuxlaqTQYowAyI5Piv2n9XpEkDHukcduaos+8KiH76tW
	DL6Uv5tDN1m01NHvq8SZU/eC0ceZjzHFpzGiF374/Rq4dgWPJsrSXmB612wr2u8/lnFCn6gZu1L
	ugNwYyHwA03MfxveFzlFhZ5Hve9FJjYFcJ6kPbbEa2yeGbIKmMw8fqJgWl7Vhf0lgnXSm24UHIW
	i8ZyYITif8gMmFXk9w4iHUUy5zMPdYOe8+XrYIH4Rn2OV+DePVJesa2yLig/ULuKGeFUYuW5+sy
	Rkyum73n4E5hmzMTovgWxGir+NewWvaEjfgVcEEmC5Bkcw4lFDn1jf7H3F6/XZIu0EPqyy6uyCB
	w==
X-Received: by 2002:a17:902:ce0e:b0:2b4:5c20:ec7 with SMTP id d9443c01a7336-2b5f9fddaf4mr48261715ad.41.1776467981154;
        Fri, 17 Apr 2026 16:19:41 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cc9asm30864155ad.39.2026.04.17.16.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 16:19:40 -0700 (PDT)
Message-ID: <ea37be7028d20e962816ff10631da383b5910c57.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf/verifier: Use intersection checks when
 simulating to detect dead branches
From: Eduard Zingerman <eddyz87@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Paul
 Chaignon	 <paul.chaignon@gmail.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Srinivas Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Date: Fri, 17 Apr 2026 16:19:37 -0700
In-Reply-To: <f622c0166e9c1809184673c1bffda7e43ae495ea.camel@gmail.com>
References: <20260415160728.657270-1-harishankar.vishwanathan@gmail.com>
		 <20260415160728.657270-2-harishankar.vishwanathan@gmail.com>
		 <2ec3db2d2960d9c13577d630306f16873ebb53e5.camel@gmail.com>
		 <CAM=Ch05O+m3gAAz=EW=ZPrhnTMrrMJ51ryMkwROnfkBMVVxnaw@mail.gmail.com>
		 <f79d58337ec3628a52d41a09e2c35e598ab656f4.camel@gmail.com>
		 <CAM=Ch07jcncdAA1D-uh66OuVXnROF72k8gunJy2cSMuvJNP+nw@mail.gmail.com>
	 <f622c0166e9c1809184673c1bffda7e43ae495ea.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-17 at 14:17 -0700, Eduard Zingerman wrote:
> On Fri, 2026-04-17 at 01:34 -0400, Harishankar Vishwanathan wrote:
>=20
> [...]
>=20
> > > Could you please comment about the witness idea?
> > > Suppose reg_bounds_sync() is modified to preserve the properties I
> > > described above, would it be sufficient to check two candidates:
> > > tmin and tnum_step(tmin) to identify a register in an invalid state?
> >=20
> > IIUC, your idea is, if there is a witness, it should be one
> > of tmin, tnum_step(tmin).
> >=20
> > - I don't think tmin, tnum_step(tmin) works, because you might
> > need several applications of tnum_step from tmin to reach umin.
> >=20
> > - Assuming tnum_step(umin) to reach the first intersection of umin
> > with the tnum (let's say x), x might not intersect with the s64.
> >=20
> > -  I think one of tnum_step(umin), tnum_step(smin), smin, umin works
> > to find the common intersection point among u64, s64 and tnum.
> >=20
> > - But even then that particular intersection point must also intersect
> > with the u32 and s32 (when mapped to those domains). That
> > complicates the reasoning.
> >=20
> > Also how would you ensure property 2 described above
> > in reg_bounds_sync()?
>=20
> Continuing this train of thoughts, consider the function
> find_witness_aux() from [1]:
>=20
>     /* pre-conditions:
>      * - (u32)a_min <=3D b_min
>      * - b_max <=3D (u32)a_max
>      */
>     static bool find_witness_aux(u64 a_min, u64 a_max, u32 b_min, u32 b_m=
ax,
>                                 struct tnum tnum, u64 *out)
>=20
> If there is a tnum T, a 64-bit range A and a 32-bit range B, such that
> `(u32)a_min <=3D b_min && b_max <=3D (u32)a_max`,
> it can find a value that belongs to A, B and T if such value exist.
>=20
> I believe that this function can be used as a basis for complete
> witness check including signed and unsigned ranges:
> - Each intersection between signed and unsigned ranges produces one or
>   two unsigned ranges.=20
> - If e.g. (u32)a_min <=3D b_min does not hold, further subdivision is
>   possible.
>=20
> Meaning that final witness check will need to enumerate several ranges
> and call find_witness_aux() several times.
>=20
> Wdyt?
>=20
> [1] https://github.com/eddyz87/find-witness

Pushed complete find_witness() implementation in [1].
cbmc verification passes.

    bool find_witness(struct bpf_reg_state *reg, u64 *out)

Takes a register as an input and produces a value satisfying all
domains if such value exist. Assumes that register is well-formed:
- min < max
- tnum.mask & tnum.value =3D=3D 0

Required some incantations to make cbmc understand function contracts,
I might want to switch to some more mainstream checker.

In any case, please let me know what you think.
