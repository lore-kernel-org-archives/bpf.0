Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C588F3D88EC
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105684; cv=none; b=rE9w8xcWsmTFA7oUvT7U6s9syx6LFk8f+VHD4PfPtnbCanzKI5BxkQGYHkVaLtQ/i0RcDBN/DN+dngMs8AmipSjmiYPc32Fjq2QkdBk6MVyRR3L7EjoRXCAKN9G5/i3Z7iUQ6RIOpgpd8NRq1WLa18FwtzvAvucW1lxXPVD2XTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105684; c=relaxed/simple;
	bh=hEYRQSd8L24KsvxuNroVxdJqty75+npmHbQjtSRCciI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sTfVDCjc+iW01yLMKNJihGcvcw0nQPXoTppNpF+SFgIdBShTo4uNk/nRu/AicBnLSyUdNnDKeiFAyY3OBIEuI2tXFpWnaYrEfCuFTKhnqWPuKq1hF91ynadLJOUtjlWoKcxAa28icJ1EW2YbXKWk1ym0RxtON4hkKj2tPj+oSn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgGL/LHN; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgGL/LHN"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso1731874b3a.2
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 01:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784105681; x=1784710481; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hEYRQSd8L24KsvxuNroVxdJqty75+npmHbQjtSRCciI=;
        b=SgGL/LHNYYqQEwqHHCqXbG/Cy4yxAKMTttPUbQ0IV8DJh/nIP5R1mezWVWAqDgX4pT
         0nWx5vquDD0SMfn42uwkx6a3uxgjDgykmX0F6apPO0eovwnuvHWGtEYhYLyH3Jte+Eqx
         2lb6ZFVPlzxU8ofmk4pshBM4gh+U8c0o51qnxtVH8Q5uAFpALSvgUC10LPDHumTuMNr5
         B+YmftYimRJnEcXL5GlcGckbRNXXbMxcMK8Koe5ZsaeeWD3By2jueb05whJlPMaJd968
         Hh9yitOS7JfsVZIFKbaKCs/V0qg33x1r8GslfTAuW3LUVOjJMW+Pec6Jj6FKxmHckKH5
         ILqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784105681; x=1784710481;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hEYRQSd8L24KsvxuNroVxdJqty75+npmHbQjtSRCciI=;
        b=aoEenLkck0QOi+obXKAgAZNIseinjcHiJKtXhvRBHl4G8pw02NQx4JByfBIqDCgJk/
         QwIsOG5z0Q16jv5dVlt7eVuhFkOJPeh5qAgAe3IM3AoSF9q8jYfScnla8xRx+vH/2am7
         9DIC52WMgW+T4lKZ9eFvQgn50ppnaggNZUaTVMHoA1q+79O6htPjydbGPmp4DuY8f3ve
         6QlSbf1scxm8zI+0mcNVLPwxF75dkfZMYWsbjU4XSqGKcRgB1rQKn2cpj6oIo1Q6Gv0d
         1ycz/5qcKqM6DnC58iL9XNix+/c2GmgOkoa8DEBgXau/IDcsUUUBIoVG7eAY5rV6kuoy
         4Dkw==
X-Gm-Message-State: AOJu0YyjAXZyYrdVTHe+MM2AGeNliwNUHawxI8DcU8XvUGUFlpLB7hzA
	PvMm8cHncIIV2vcxL0wIE65XllYRnO8zDud6z/LOiWeHLbILd1T7aoXp
X-Gm-Gg: AfdE7cl2RnCKfe9A0x6itT8WNL2gvd9A7H+Rfq7I8CZjzcU/8F4i7mgWjwXlfknA4HY
	9UIJybQwG+MsgZ4Iiq8hSGo2rgOtadw8gzppVU9Bg7GKIcxTOa/H5i9pc3kgBxT4Zcgztkuj/k0
	Qk1D0XAIj4gmMWckAdMIpytORvxjwKo/qxw7MX67yP8t9rv380TgmlPOkhkDw4MJk2QjSK4PBWO
	0t5bhhvdIJpwO287KVT+yav6Jktdnu8wulSCR4vs1x777zfgE5zpgGNAWk6IorTlRv7Kz52kHOc
	jyjU1+cZJEcwCyDFgYnQa0+921utYTvZ4PIGJS0uBbPO+AHBcuQ5gygSCDU16Ywx1Z3pYaAJar0
	U0E0w3CQE2o9aoDnF0M4f1jjgtTp12RzeCIc21BV4rBetPrscy93SO89EhxWHN8sjr/CBZjbSb3
	HHcl7LFNpE3BOAMNd97UNh0SkbN+oGjTKy9yLXfM59
X-Received: by 2002:a05:6a00:368d:b0:848:56ff:6ced with SMTP id d2e1a72fcca58-84a6723d613mr1883067b3a.8.1784105680638;
        Wed, 15 Jul 2026 01:54:40 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f6bebcesm2787462b3a.32.2026.07.15.01.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:54:40 -0700 (PDT)
Message-ID: <488c235db713648bb2f5c90e4389c96a97ebcdde.camel@gmail.com>
Subject: Re: [PATCH bpf v5 2/2] selftests/bpf: Cover negative buffer pointer
 offsets
From: Eduard Zingerman <eddyz87@gmail.com>
To: sun jian <sun.jian.kdev@gmail.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis	 <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, John
 Fastabend	 <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  Martin KaFai Lau <martin.lau@linux.dev>, Shuah Khan
 <shuah@kernel.org>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, Matt Mullins <mmullins@mmlx.us>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org
Date: Wed, 15 Jul 2026 01:54:37 -0700
In-Reply-To: <CABFUUZFsJsF-C5Z2gb3FkZ7WD=vBavnGdZ7veScP_+dwZLsaMg@mail.gmail.com>
References: <20260714093846.18159-1-sun.jian.kdev@gmail.com>
	 <20260714093846.18159-3-sun.jian.kdev@gmail.com> <alcGgfNM94zgydlK@u94a>
	 <alcKV2MXI_5dsaez@u94a>
	 <CABFUUZFsJsF-C5Z2gb3FkZ7WD=vBavnGdZ7veScP_+dwZLsaMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-15 at 13:26 +0800, sun jian wrote:

[...]

> > Anyway, still recommend adding a regression test that test access to on=
e
> > byte before the start of writable context.
> >=20
>=20
> The new tracepoint_writable_reject_negative_const_offset verifier case
> already covers an access before the start of the writable context:
>=20
> =C2=A0=C2=A0=C2=A0 r6 =3D *(u64 *)(r1 + 0);
> =C2=A0=C2=A0=C2=A0 r6 +=3D -8;
> =C2=A0=C2=A0=C2=A0 r0 =3D *(u64 *)(r6 + 0);
>=20
> Its effective access range is [-8, 0), so it is rejected at load time.
> This is the direct regression test for the negative-start case.

The existing test seem to be sufficient, why would it matter is at
offset -8 or -1 given that the read is appropriately sized?

The added test in tools/testing/selftests/bpf/progs/verifier_raw_tp_writabl=
e.c
is redundant given the changes in raw_tp_writable_reject_bad_access.c
but I was going to apply anyway.
