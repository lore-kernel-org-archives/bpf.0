Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D05441044
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774979544; cv=none; b=pFg4vXxSEW3Y9Tg75lUNNKsL7Dh4cm15VnExrQ3aMi37gbA1FkpF1sYtZeMCW6dnlWuvyLaXAnYTsNrpZ4DIXULuTbeB2ygXES/PMAHGtw42JiRIlRnVkrZe6G+A8G5JZ6LeMtW77Ivyjb9qV4zg/rPrEgSgIxDtZO5VwMOSnHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774979544; c=relaxed/simple;
	bh=xaQMpFa3Nt7FQaudGz9QuYT4Z5RCjXltyxyvqvuOYSo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CUdDSyxRdmSfaJqEDHPdJKveYumqX0jCN9B8skcy2Kiv23DqX2NVK3Y9B9YH9XMZZ6QxM+QT1Pva34ESxW8LYJY9VIOljmdPzgk4gW49V1FrECOwkfxAudVIffBuab3lpYpqvY/9uV8OXsWDzVXsHIZjRp6lS+CIRm/NjScLik0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYuZ6aRx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYuZ6aRx"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ad4d639db3so27425415ad.0
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 10:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774979541; x=1775584341; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F4JnGX7sFkkDPFCI/0u4Dfi+BtniZOdb3xrLxcDKKjI=;
        b=SYuZ6aRx/sb1YB2iRfQQ0H9aNYeB25H1Hv0zY9roMOBI/FIHulk7tZoqjDLgx/lNcv
         kPQHHtn8f1mUCY1m0183yFoNJ2TrQjouan71Klpn82x8fOA6t6e0z4WK0v9Wx/hu0+4W
         HCYMxtIjwq6xsXB7LcZ80+u4j/+fVmcN3Kncc+SzZ3B4dt/pqS7JvJKzbYfwbxp3Z7rD
         atFJHTiuKrmhwVIEZ9r2YJXouuxlcUR2qZ5Z7pPiRFaMuOSUBBJjPti/s7mf7em4AM+V
         bE82vH3rkFGkQKQKwpjotYtqIDYpedmtLZ/Lf+w5Yl6EH8MrYB9Xt4ccFMWDaGluCPHg
         mRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774979541; x=1775584341;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4JnGX7sFkkDPFCI/0u4Dfi+BtniZOdb3xrLxcDKKjI=;
        b=Fhc2YwV7vD9ihD3yznVo6Fmi6Rp2Dpeer8baMmUeF4AmGfQ6J0sjAGRQjnXctVsYOv
         +2tYx0DIv9jSbJdyjMhfk64ftc8dmnegYmMUMROkuM3vXipy5ayxDTK+MeSKOA5iOqeu
         FvcT7iFlB1EsJWhgITEyyRsxJjERGwtY+wW6Y1cBGaOV4ZyBw0PDbFwSR39SmYGjS0BD
         /D4jXaEzDoiemAmMmVi+LX6dHYg2nm7QBU9nhiT817jidh6dOJPRCXBOuK/cPWT+V8g6
         xWAx5zzuD+hs0UMAh0n7Vx2ba6YZdlhAM2xBq021gEqnLucYJupfluZafrVAGRS3jfCQ
         j5AA==
X-Forwarded-Encrypted: i=1; AJvYcCUQLiXgRlZsepi4EhvQ2fktkeOiakSsbVz9NBaFImN4atReobCtOYF+ovaWS8IQY850Ae8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwUhnUOSr5pk6BR8RGenrysCWiLZ3apBGIxoulVVIx/0jYPLgz
	KH9UevPx9avvcjsxB4XGqVvOgBtTdlsO4TPXkGfUzpnoRXIaPJHzknD1
X-Gm-Gg: ATEYQzwicKCA01f4flNwiR9g4H6rYPzopbcxExeukFVBOHrf/Edt2Y8phpAHK0B4n3S
	TKhEkeEb1BGMTk/EAInRFZ000z4zTnuWu6RpkpCeUMZ3gKLSm0tjSK7vjsL2nVUXWPJI1fil1Ov
	O7FXAggDxhVlMlkdXhjZsKGV3at484MW/cGJDAu2k9nfQWBDyMzeiflAIKsOtdgPwbWe4qxth3t
	lwHz/aYUR5MQq+w0wIRrR/KIt87XIL8yosro3+Uo0tfHt9bhWLQsvtKnt+U3R+gceLfo5EiJ2Jn
	3Q2m9UTAJliHDoYCp4ekypFb1ku/8V0dsS0EVbhMfNunrakdJukZ4Mwabjdj2UqTKU4kBtWHElm
	0S8qI93AHOc/P0wy4nVXLTwoKW77ZNPl+cUi66qVEAGzj+lNfJI70ROrt1o84j9ayTfLKjWcZUQ
	5ebyeHQk7iQrqUIZI5PXS9ZLadRCAv/I74LxYqGB6fQgRmn93dWD8I
X-Received: by 2002:a17:903:2acb:b0:2b0:6ce3:8f7 with SMTP id d9443c01a7336-2b269cee743mr917175ad.43.1774979540871;
        Tue, 31 Mar 2026 10:52:20 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b25d8603b2sm48469315ad.62.2026.03.31.10.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 10:52:20 -0700 (PDT)
Message-ID: <7721a642cbd8af62fb4b15bd14af583b4f858542.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] selftests/bpf: make str_has_pfx return
 pointer past the prefix
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, Ihor Solodrai
	 <ihor.solodrai@linux.dev>
Date: Tue, 31 Mar 2026 10:52:17 -0700
In-Reply-To: <8d5d1ec4-7277-4b11-badd-f61fb1bde10a@gmail.com>
References: 
	<20260330-selftests-global-tags-ordering-v2-0-c0ac61e81098@gmail.com>
	 <20260330-selftests-global-tags-ordering-v2-2-c0ac61e81098@gmail.com>
	 <8d5d1ec4-7277-4b11-badd-f61fb1bde10a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-31 at 13:07 +0100, Mykyta Yatsenko wrote:
> On 3/31/26 1:59 AM, Eduard Zingerman wrote:
> > Change str_has_pfx() to return a pointer to the first character after
> > the prefix, thus eliminating the repetitive (s + sizeof(PFX) - 1)
> > patterns.
> >=20
> > Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >   tools/testing/selftests/bpf/test_loader.c | 51 ++++++++++++++--------=
---------
> >   1 file changed, 23 insertions(+), 28 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/=
selftests/bpf/test_loader.c
> > index 338c035c36884c02ac57cd17110122c10b4858e4..50ca1b6ec8150efe2cb2806=
67af9ac4972c28657 100644
> > --- a/tools/testing/selftests/bpf/test_loader.c
> > +++ b/tools/testing/selftests/bpf/test_loader.c
> > @@ -11,8 +11,12 @@
> >   #include "cap_helpers.h"
> >   #include "jit_disasm_helpers.h"
> >  =20
> > -#define str_has_pfx(str, pfx) \
> > -	(strncmp(str, pfx, __builtin_constant_p(pfx) ? sizeof(pfx) - 1 : strl=
en(pfx)) =3D=3D 0)
> > +static inline const char *str_has_pfx(const char *str, const char *pfx=
)
> > +{
> > +	size_t len =3D strlen(pfx);
> > +
> > +	return strncmp(str, pfx, len) =3D=3D 0 ? str + len : NULL;
> > +}
> >  =20
> >   #define TEST_LOADER_LOG_BUF_SZ 2097152
> >  =20
> > @@ -161,21 +165,21 @@ static void free_test_spec(struct test_spec *spec=
)
> >   static int compile_regex(const char *pattern, regex_t *regex)
> >   {
> >   	char err_buf[256], buf[256] =3D {}, *ptr, *buf_end;
> > -	const char *original_pattern =3D pattern;
> > +	const char *original_pattern =3D pattern, *m;
>=20
> super nit: what does m stand for? Something like `next` would do better,=
=20
> wouldn't it?

'm' for 'match' :)

> Overall refactoring looks correct, all callsites of the str_has_pfx()=20
> are modified, except one in parse_int(), but it's correct anyways.
>=20
> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

Thx
