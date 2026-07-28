Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DAF4749C8
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785275552; cv=none; b=sb+Ahg3KTXGedl8QKiQy5p0Av4QohjPvUt+rp6endX+NhIRiBNWFcI44jSb9G3vNcW5KplV2l8aGIi9y69yolHEkw75CqjRwD8H+HyPSPN3RCO/Ngcu52lnkaKpeAQ8rK6EIY4aK7LPfaH09Atjg3yqFDliKRzCOJmRTuzua3Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785275552; c=relaxed/simple;
	bh=inzzroBEGjrucBvNey8BYhV8ZNJqxJWxx5a/qtqgKR8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UFimXDkLj5CY2JccB+na77xcE7H0uJ5gcdl/fAkf6TVAcj8LhPsRPV2ruEQSP2N8TyrCP/SEmaeQGC4VkldlZuzAjfyux0tT8mqtM0rAjY/P6/K8RtP0UYPKW+fHUF78caTgAfzMKvEANdVeHJ9NgMddgCxohyMXg6zPowpxnUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oM5YNh+z; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oM5YNh+z"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cca0c5799eso3857495ad.0
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 14:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785275550; x=1785880350; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=x2NgkEcmtd927CewHsEFS7/kDxVOE3eb6cttD3senKw=;
        b=oM5YNh+zoSMliv0rkIDgPqk+0BS7OJe1rUDmdpOR5V0GA/UYNrqRduGYzM1b3npEJ1
         xbRpf0nQKCXkm8ektR8H77CcfvFtE+7a3rhgWo3d4z1hkVrqG6i4EtNFll9015/cr4Kl
         xdPuKJN+HSM/AkvoL5Ie/LlqdzyWZdFp2abgaD30xVXJaPW//J8k0I1wEGXOzPMADmIM
         ygMWXfx9BsXf/nRNC/qiBP3Wp+LHhkK3R86Y0vZArYrHmzOSxFIdvJo5hRfJaK4R3mhb
         rvLAYoGTkyEDei7VbmygXxq0Y2THOvqScsj5TVzDMSSbac4SLRPQJf2/Shnaa5uXf/su
         hKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785275550; x=1785880350;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x2NgkEcmtd927CewHsEFS7/kDxVOE3eb6cttD3senKw=;
        b=nDwUgfmxHmb4uSQTEDLMt8F7YEppOMaHwyIctKZswRyl3lnZW7ljkPXBH+UbLggwRp
         hon3FW08jFHns3gP3bsI36Aqp3dSUJHgYBOI8g7BCtOF6B+4TzZOvaO0j3DK3Yx9Rc+A
         Pb42gb85b6+1lUtno450svgAGAi2kCd0NPUMvBCNMzn659Sf1WCXsw+psgr2EakuI6xH
         3gSt1eDeiOzJEdiBmY87vUqVGjIAODJcm4egCDkiPWcepF7pokl3bmsoEEg2s8Td3Cf+
         wBV/N5aUmMYxm3xDnEqncnKghthSKBGBKbiNJp9ccFUkfgT5UOxMistA37Mcvp9GUPLM
         O4HA==
X-Gm-Message-State: AOJu0Yy6wT0jOHkAr2QwmnXoOuAiFlrcgVGSEDkg2Vp490T7FjpEpmKz
	EtBAYQ+MxgmSKA2X7WAb3w5lD5ScXtZ1ZVSBHaqKXs8q2WVhV9iuyPY5
X-Gm-Gg: AR+sD12J2dr1kGgzkDtvlI+1MzyrGq0CZjFicl/7W9EAANhR+GgjDXmszv7IV7Kpl9f
	CzrXfLa3KF64g3UsR34i0HqUl5yKyVQmbjFBBbKjomd9M/EnWzW8Lukgks8J8Bwn+4bb/ble9uh
	8nVmTXcmXUvIDJbRfe5rYlwl1GJBtpGjmL+ggdOd4IeAQRpNkvw9FIfYUzE+oYka7bSYgp7MdDD
	CrPSevPj9+vIYJtGGwUbC+2RDoon7PuR9YF9m+tcpVo+3Uz9dZVcGIJybLGFFeqrt+dwrJaCbX7
	sGGbRLl9s4kVGT7TB2ZcZl8gULDv9A0abI+aM67WYTYKY1p6alvgUBCpPL89PREW0sJ+KPbo+xS
	v2sNwCRpDxFu1TJn2d060zjfUo2BNGmSE+s9N9pIMx5KBpF/3HO6c5oystX7OyoAvf7jCGI4pfF
	6uynkjUqNSUMHCwWetkpoeZgUYrnzjc5TAeKD83ngHWub/MuewV/xz4swXNvgaMuIxoPRbYe95r
	TJLKh9l+UnTLRrHbUWdiRLiT7A2mXTV1xODVtXM0G/CxQ==
X-Received: by 2002:a17:903:37c3:b0:2ca:6514:9201 with SMTP id d9443c01a7336-2d015b07cbcmr46481865ad.15.1785275550035;
        Tue, 28 Jul 2026 14:52:30 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:a358:4bd1:35cd:2e45? ([2620:10d:c090:500::5:ff91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b125bbsm2467209eec.5.2026.07.28.14.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:52:29 -0700 (PDT)
Message-ID: <576e832218b67cde91ffaf456752ea32984286b0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 07/18] bpf: Check fixed-size mem args of
 helpers and kfuncs the same way
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, kernel-team@meta.com
Date: Tue, 28 Jul 2026 14:52:28 -0700
In-Reply-To: <CAMB2axPD=BYzQ1O9thnHHE+TqfVTE_YgMRRTpeSkg0-O3C0zcw@mail.gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
	 <20260724190813.1458271-8-ameryhung@gmail.com>
	 <4b93853207b6b02761af2fc75222ab8b349d7157.camel@gmail.com>
	 <CAMB2axPD=BYzQ1O9thnHHE+TqfVTE_YgMRRTpeSkg0-O3C0zcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-07-28 at 12:08 -0700, Amery Hung wrote:
> On Mon, Jul 27, 2026 at 2:17=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Fri, 2026-07-24 at 12:08 -0700, Amery Hung wrote:
> >=20
> > ...
> >=20
> > > @@ -6965,10 +6968,12 @@ static int check_mem_reg(struct bpf_verifier_=
env *env, struct bpf_reg_state *reg
> > >               mark_ptr_not_null_reg(reg);
> > >       }
> > >=20
> > > -     int size =3D base_type(reg->type) =3D=3D PTR_TO_STACK ? -(int)m=
em_size : mem_size;
> > > +     size =3D (!helper && base_type(reg->type) =3D=3D PTR_TO_STACK) =
? -(int)mem_size : mem_size;
> >                                                    ^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^
> > When is this negation necessary?
>=20
> This was introduced recently in 2cb27158adb3 ("bpf: poison dead stack slo=
ts")
>=20
> The negative size signals check_stack_range_initialized() to accept
> STACK_POISON slots (allow_poison). That is only safe for global
> subprogs since a finer-grain stack slot liveness analysis proves the
> callee body doesn't read those slots.

I see, thank you, while changing this line, could you please drop a
one-line comment here?

>=20
> > Is there a way to get rid of it?
>=20
> I think this is needed. However, after reading the commit again, I
> think this should only apply to global subprogs. Current code allows
> kfunc by mistake. The line should be fixed:
>=20
> size =3D (!meta && base_type(reg->type) =3D=3D PTR_TO_STACK) ?
> -(int)mem_size : mem_size;

Yes, makes sense.

> >=20
> > >=20
> > > -     err =3D check_helper_mem_access(env, reg, argno, size, BPF_READ=
, true, meta);
> > > -     err =3D err ?: check_helper_mem_access(env, reg, argno, size, B=
PF_WRITE, true, meta);
> > > +     if (access_type & BPF_READ)
> > > +             err =3D check_helper_mem_access(env, reg, argno, size, =
BPF_READ, true, meta);
> > > +     if (!err && (access_type & BPF_WRITE))
> > > +             err =3D check_helper_mem_access(env, reg, argno, size, =
BPF_WRITE, true, meta);
> > >=20
> > >       if (may_be_null)
> > >               *reg =3D saved_reg;
> >=20
> > ...
