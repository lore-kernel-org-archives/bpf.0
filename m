Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E423822B1
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773439100; cv=none; b=dxLZs9in1778ZCBcJzko/GAV4vXWqFaGDbDbgoUePyv1i5WXjIhiFtGy7aYbT2Sl4DCWtUBy8V7/QqnDohqGn3Q8pKpbtfhAlo5koZcGT/EuxO10vhreowQZPxqm4Al049z3FsFkMoNVYlrlLEq/NUSHkgUUJ2uJGkho0LWDHgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773439100; c=relaxed/simple;
	bh=VHPvtBZkGmGQ9e6u2L+evz6ek8dGdfP/bWfoPbRC3zs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tyJr0JWiQhgj681vV7uP02qZM4sjGHqi/v71MGU/5Z0nfAyV02otIHOJ54J0tYo2VNhmU/PqD8UofhkHFX1ifVan23qQrNi0Bz63xdfmQsHNfG42NeNjrY9Is7Ml3uRJZsJNf64aQvy47wLI1b6G9PjOwnTUyaEVZN29uavevhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qug/Hn30; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qug/Hn30"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35a08ce49dcso2475875a91.2
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 14:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773439098; x=1774043898; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VHPvtBZkGmGQ9e6u2L+evz6ek8dGdfP/bWfoPbRC3zs=;
        b=Qug/Hn30wtza9tq3xr4i0xIRicyJ3g8P+N4mFtwUtfmvT1J5+u19kpR8x9Vi+P7i/u
         XvZHGih5fcNZB++0G9KHU9xBQTtVQkI8XwWy2stlmRbiGZJBg/hyywyoBHyGS5NsG21k
         Sox77AJm/KW9rRKsEaQaXpGSrEKat05PYREf4ntQlAUtKmnriRFdNZXK78lxdJJ8ss3i
         m5Bb5r3SCqnDGq8LifPuYFmXd4e1gy9PfrHXgE9ajlYefUW1KxuNW9FVj1zsrqppZcCy
         MYwa9ybn+K2pXEbboG4DElMYXlFJXWTxIOcg+uNEuyCmYMy11rBNuB50wWmKEzZhhe2c
         yQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773439098; x=1774043898;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VHPvtBZkGmGQ9e6u2L+evz6ek8dGdfP/bWfoPbRC3zs=;
        b=RQXy4Wa2bjZX4+gP8VCoo0C1VCNmRx6bKZGPT7sFFXv1lFVTgozXxfrZ2vGuBzy6aE
         RqZm547E1LeMb9aCTptsWmmAPgdsMJidJOZR4mVCJ86/zuIw/HJ4M736OSNlAESCsRa5
         8ZNVEjvdR6lVt9McQfa6APrK1XBEtoNcy0wMRXguL49BDG7mDvjTM2z93ZMqwbjO+l91
         QBMVtdTanYNcVDRbcNfaBg1MTDmQhqUWz5YNOtJMuKdm7gPT6PhoZ1kZrSE2lf8Hup3S
         2o7kcElPqISUhMyZ6KPPvJXRqmE7D25/4sPEx9iTZgcsLGb+yrucYi1OWHt4L8rxoQ+W
         qMvA==
X-Forwarded-Encrypted: i=1; AJvYcCWEVRTVfmj0UJGcHY2aXxQis4O3wZipE9UqqYPzBazRXlD0fWJigJCzWq5AWGBuIjUS8Go=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywub52riWSK5+EwXKkfFeOQAg822NUxmKjhzPv5N4CeFD61wiDB
	6uZ5krp19JJKsnKwqRCho14iyfn09pa463oHwmYidxSicUVqnIYDarKoZ/fI2Q==
X-Gm-Gg: ATEYQzxuW1OJ1BO4R0v2cG6lmrtXd4WHHb/moLhlJFNUSSDqiinF3ptI3pZqQOTu6KZ
	xLA35eRvwMxfuijQd0orELIfyyYsHA+dSSuNXcZHEq6Dhbmq6IXAXSfV0pkj/75TaX2jlf3bE/M
	UrexZxJtdcsDW7EB0BtQfsV5sCUnrfsXRtenedQwt/U1ff158lFhk1lUxjtuGN3Q/4oYpQouwqi
	LwLUltaO7AkyUAUruwLaQlwCgoS7xmgWkXhBOZwVYx96mvY8cjuj654sKSPp1FfnP3l0d7NXp5e
	1DkTkmmOUAQ83FpHUu1UrdmqI44V6uSrigVvYWcFVcwJW3jv2snPztL3mbl4bL6JV94Ab131U6V
	dGAk8vGE32zy2YvJDp0r4uOF9QRguz7KFYorKjGBApHa0CU1ntDRg4FUN1xZ5tdT1xW7eolwWSG
	vMsVIR+OexFSGKd21bN6C5DfY3CoH2KkukKTe6tmrfHGdCeFXSNlQ=
X-Received: by 2002:a17:903:3905:b0:2ae:593c:48fe with SMTP id d9443c01a7336-2aeca9f8ddcmr51487065ad.13.1773439097817;
        Fri, 13 Mar 2026 14:58:17 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece809586sm29065585ad.63.2026.03.13.14.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 14:58:17 -0700 (PDT)
Message-ID: <c6d46d55d29d7b164e621040a3c80f1aae8180ea.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: Test case for refinement
 improvement using 64b bounds
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>
Date: Fri, 13 Mar 2026 14:58:14 -0700
In-Reply-To: <622dc51c581cd4d652fff362188b2a5f73c1fe99.1773401138.git.paul.chaignon@gmail.com>
References: <cover.1773401138.git.paul.chaignon@gmail.com>
	 <622dc51c581cd4d652fff362188b2a5f73c1fe99.1773401138.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-13 at 12:43 +0100, Paul Chaignon wrote:
> This new selftest demonstrates the improvement of bounds refinement from
> the previous patch. It is inspired from a set of reg_bounds_sync inputs
> generated using CBMC [1] by Shung-Hsi:
>=20
> =C2=A0 reg.smin_value=3D0x8000000000000002
> =C2=A0 reg.smax_value=3D2
> =C2=A0 reg.umin_value=3D2
> =C2=A0 reg.umax_value=3D19
> =C2=A0 reg.s32_min_value=3D2
> =C2=A0 reg.s32_max_value=3D3
> =C2=A0 reg.u32_min_value=3D2
> =C2=A0 reg.u32_max_value=3D3
>=20
> reg_bounds_sync returns R=3D[2; 3] without the previous patch, and R=3D2
> with it. __reg64_deduce_bounds is able to derive that u64=3D2, but before
> the previous patch, those bounds are overwritten in
> __reg_deduce_mixed_bounds using the 32bits bounds.
>=20
> To arrive to these reg_bounds_sync inputs, we bound the 32bits value
> first to [2; 3]. We can then upper-bound s64 without impacting u64. At
> that point, the refinement to u64=3D2 doesn't happen because the ranges
> still overlap in two points:
>=20
> =C2=A0 0=C2=A0 umin=3D2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 umax=3D0xff..ff00..03=C2=A0=
=C2=A0 U64_MAX
> =C2=A0 |=C2=A0 [xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx]=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |
> =C2=A0 |----------------------------|------------------------------|
> =C2=A0 |xx]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 [xxxxxxxxxxxxxxxxxxxxxxxxxxxx|
> =C2=A0 0=C2=A0 smax=3D2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 smin=3D0x800..02=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -1
>=20
> With an upper-bound check at value 19, we can reach the above inputs for
> reg_bounds_sync. At that point, the refinement to u64=3D2 happens and
> because it isn't overwritten by __reg_deduce_mixed_bounds anymore,
> reg_bounds_sync returns with reg=3D2.
>=20
> The test validates this result by including an illegal instruction in
> the (dead) branch reg !=3D 2.
>=20
> Link: https://github.com/shunghsiyu/reg_bounds_sync-review/=C2=A0[1]
> Co-developed-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

Can confirm, this test case fails on current master.

Tested-by: Eduard Zingerman <eddyz87@gmail.com>
