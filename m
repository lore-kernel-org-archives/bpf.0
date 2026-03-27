Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F23F126C03
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 21:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774648653; cv=none; b=D/OFcybgxX/DmH2xburM3PXCPWPztbVh60FA/B90SGa3yYdF1rRH4zbFfEkTlE1hwR4Uc4vI8/nQtVoPMhWVK5i+GO98+yyh/JKZWZVWlJHnfAeImv4OVMVgTSRqxR/IIhZt/XuZEsj4rJz4H9LeIfBA2TOJMJDTKudxMFEeXhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774648653; c=relaxed/simple;
	bh=pH4rKfO1scAFnABaKrW9PGqctIeKVPqnJPOpMPakLGM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HnmVUljjbi+p1UJnd//tC2y/5uVTt1hee794UaPGaW9Gyzx3XAC+FEW91p8oOeUshks148IYGbr5OH3GWYOS6/bCdJ0k0elG6oatwBdz00ZNFOBmhURjAPq+1Sgbyqd/6hsL8V1WN44OcRNzew/RuSeV6v/ih1S/Ca3GhsV/t2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyCcAtLB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyCcAtLB"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8296dabef74so2475494b3a.1
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 14:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774648651; x=1775253451; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XtwjHEu/Pt09vZYhQn8u+OYFOVf5xBDcNf3Hg1xOY8E=;
        b=kyCcAtLBbDk59lW3XBI7T5JLTfNBFAcwLQ1OKev4XkUjxSZ8mWNV8viHkH5e3VhxbW
         nXPkGq9DAW6zKYhluShGjf2S2ovmOwegj256XgBmXDEMqrs6QKBY559vjCqbNph9HX6X
         MUCY807hZ2+onW+aIqP188Ov+lQEPkQ29OIF6Kgq7CM9GhGZCenQNxXhuYU2cfZq78U1
         Odcg7B8qSt/KCEW4Wt5yVGVfKl44CUCHMIfV3mCLKbBdY6+DV3qmOXWmLtuYVRl0J4X8
         qk/k0bZwK8MXeqHDPY/973J1FydaibcjgzQwtZwfLX4vXM/LiymiVetbjGLVxbzz4blb
         9AXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774648651; x=1775253451;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XtwjHEu/Pt09vZYhQn8u+OYFOVf5xBDcNf3Hg1xOY8E=;
        b=cvTBX/0gSQ7ebvsC4x/Ha9wJziwCbaaSiatJ7uILGC1twUazCGC+JyX7TpUXbBAcLo
         Fhdk1Vwu/dDoMgEmOQgtTme03mo0nUcdcvPP6EF2bC0TzCHChhRwnWEtoydLTjH/ELd0
         AO/VEPQh+zxZmzCBaBHtacEgxirABGYZONFXYscPgUNqOocBVBSu1QKaKagRs9HqMlHi
         LoeipSQ32baZTeIN3euhKfVm5+S2MMW1QH02rF6QoX/WVmspVWlVDo3d4bL9Pnx6LJLl
         sPxGpcIaZ6BVmalfZqEcNL+vmHPaPKhawhqdbXQEmePne3FkkdJ0R+t6fYd/jL6bI5su
         wsiw==
X-Forwarded-Encrypted: i=1; AJvYcCVMZI2+J6yIadfE/EgXKWZ2RLqWROwVNxJ8niXHIm89QlNjEYeonGC6MgatZ/Il3Ok5CXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgYEbDD4MZOAA7f50FZgCvFJDr2GZCHK8vI7gJ777qrvoz7VbQ
	V/T+VejuIJePZbjqu1YZwd394X3ttVPpBzcTUAy18b166jlk7un1J3BfYfy7Miuo
X-Gm-Gg: ATEYQzxal/I3r7ZY+DR0Sb/stPR8szQaCm2ymSk7XylbhVbd2tT1jSbno2mJG9qK51J
	OWEiviF2hkXSBFxX6jnDtmcNrUY8hwfcVfqxtkzz8Z8+vTBNtKwsjE9rNf29ufL4TGjNuaHZMUP
	sBBRblecA1NSe5LrA8AjqPbtN9mfPil0Wxb0LlvJot5zfHpd/wbo7ypPFHrTxMegelyN7Y4lvra
	z/n2+f9FbXBidRSe5QPmzOgZDiIvSntTMoIR38WWFv7o3R/0fPqYOqVubnrCgKQ8zZQfo4xrvgA
	ZyYnBSFgUh7OrDEB954HzlY2shQc404T3tFk06htGEK5xDzeskB2EIzzN+UYz886aGHUxSk1pUg
	fezCmeiWlNOqUhRkLU3inzAgV+o7XVh9uiTQGzQFy02A3Tq1ZbFqza5u69D/GIjnQIy70pzoJzk
	eOZYZVkyI3qObtJDi/PVY7N0EfLTSblbeHMIwK47uIdKFGyP78R4I=
X-Received: by 2002:a05:6a00:ae0b:b0:82c:9c4f:da3 with SMTP id d2e1a72fcca58-82c9c4f11d2mr2622627b3a.31.1774648651547;
        Fri, 27 Mar 2026 14:57:31 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85fc72asm200543b3a.48.2026.03.27.14.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 14:57:30 -0700 (PDT)
Message-ID: <38159efff9688b50aa879659af8d6538bdd9be87.camel@gmail.com>
Subject: Re: [PATCH 2/4] selftests/bpf: make str_has_pfx return pointer past
 the prefix
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, cupertino.miranda@oracle.com
Date: Fri, 27 Mar 2026 14:57:27 -0700
In-Reply-To: <e3db8a52-e526-403f-9eaa-215e4f364bb7@linux.dev>
References: 
	<20260326-selftests-global-tags-ordering-v1-0-5dd2ced5d9ad@gmail.com>
	 <20260326-selftests-global-tags-ordering-v1-2-5dd2ced5d9ad@gmail.com>
	 <e3db8a52-e526-403f-9eaa-215e4f364bb7@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-27 at 14:54 -0700, Ihor Solodrai wrote:

[...]

> > @@ -452,8 +456,8 @@ static int parse_test_spec(struct test_loader *test=
er,
> > =C2=A0			continue;
> > =C2=A0
> > =C2=A0		s =3D btf__str_by_offset(btf, t->name_off);
> > -		if (str_has_pfx(s, TEST_TAG_DESCRIPTION_PFX)) {
> > -			description =3D s + sizeof(TEST_TAG_DESCRIPTION_PFX) - 1;
> > +		if ((val =3D str_has_pfx(s, TEST_TAG_DESCRIPTION_PFX))) {
>=20
> Personally, I don't like assignments in the if expressions.

Assignments in if-expressions are A-W-E-S-O-M-E. Long live walrus operator.

> For example, this is annoying when you are stepping in the debugger.
> But who does that in 2026, right?..

What's debugger?

> Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Thx.

[...]
