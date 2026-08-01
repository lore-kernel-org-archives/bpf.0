Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7DD23392C
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 04:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785558291; cv=none; b=iRhdVHTmFtWKwRPrDG32JJf2wxdjKoWJvn7gpdLVDi0TgifkhL14bEchdHM/aPyfDpF/5Y9qVA6WHfesrWZM2xxL916yIuKB8a6OmkiIfYDa5CijXlK84twSTMawZQcQhBUrei3GIOlmez+sT+vOt0elhilpyj89GLDgKaa83Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785558291; c=relaxed/simple;
	bh=lDYUDxP/lDGSCE6hDpFV3ABq3pHahiX/aPaGe7ihCyQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yd8Sss/3FR+qsPlUfPxVdANy9NSqCbEOBIy5UdzRyHz1vObfNIgSuScpbqNl/Rcj5+6gV9JW6DSUUk6XH9edFYH0SGcOBmtGnXXvPGALcZ+WB/dBfrfiv478KleW1AEMEOKvfw3KtTxDrUubkx9pa/zuzO2zT/EFlNWMBEwwE6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDTXDLaV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDTXDLaV"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d049069377so11607915ad.0
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 21:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785558289; x=1786163089; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HtMpVhwDnG7mvnwmH5nBVScIT+ojmGeFtLmrnd9auNI=;
        b=UDTXDLaV7z5qWtkfzrWSssYrREykC5uCUEoir85ZriSqTUtg7Eauf7kOCocytsdRXm
         7u3AyK0iaJ8WVTLzv5qC9JrVSc/JLGDTgCbCXdLIp+PDBirHONZtIjoAp42LqXXpcATL
         fNyhsreGjmOYEonupMONQsUof1cFK6CoTNsPzsclEfHgmAC7BfNb5jthtPWTlkOV4/Re
         TR7tdbq9v4Q3MgWk4QuVXvgMdXCj0EucCvLYmeJi/KCe14ciX6NAUj5iEsVFVQ6/qImM
         w5UKawz1+iAEXtawzqdG3Goq4Ns3i+5/IC900kPDx4BkvpuKmZNFTvskFLTe6s6xD+9V
         rBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785558289; x=1786163089;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HtMpVhwDnG7mvnwmH5nBVScIT+ojmGeFtLmrnd9auNI=;
        b=L4lNflTlrL9/nh1GuqQoOJoYOb/APY1JOEBIlKo/jSziVpBFh6gMOLyGJtLrhzJiqO
         wYcjgys2CQjcA5qGiqsVG7nOV7z9XtBGRkcr3+ZecE34+o/8Zctdc1XfdN6zXoWpiunO
         tcMEl/HP/1xRITLFigZyVCquMnX/i4vzC8B6b9frRyCfY31fUcLwPu6oVAMQYlOhLIVw
         +sVHmOxCpIBbSReYiFnXA0lRD09cvSCF7t/dueOsDYXOUDz2JYqMoZoyDC2El7IKVw3U
         XECq97HlYNaHLXaJrB3g/6ZB0LrBB6gxMkRxNMROchJs3mQjiRWCe/7bJ8OlmXczriby
         Cyag==
X-Gm-Message-State: AOJu0YzR+p2Dotrz4cboYc9ZMwOQFDrbliz30DdnONNgDe/Mnnx93SUN
	gyszPR47LQOsz4Ncjq3co1+7kfNTAp82duB+Rw3jNo39VtVOru5UFf4jLBPC9OXm
X-Gm-Gg: AR+sD10EfNcr1tkY1fFshsBcJ0pjwSjzeaCBrVslnKmuvZ35Ah+UHQ8hyw/p24FZuO4
	fop8QKlcAdQrJJWM/v2MOpT3ylrvV9ebdncWxaidFuiD3qlg77Pyp6RBBOlhJqPu1dAjCT/VEBa
	ErnLHbWaDAD054lmxvGpjEAYGFZ1d3/oshjDjL+e5ULhHQ5Xpxts1exRQ+YfCqXsnBIEokTzgfP
	pgUXciQOyX5RK3127pRJndVaZapeg2JcROXugAugbg84sy5wTTBZQiyGq2HGSm60TWH5/lj2ECO
	C9SWCrrhBzILy19G7SkGWxTyXKahs+0HXy1VXJex/JrJIuGFYSNMiAXh0axx/nkCZODzfs0qVP4
	tUS9FzHt1Ef0qVeCa1gNE+ZUzIXABZMIXHYU/jfZAAm7Zz0lIJye4l+fF2B8e3orBWBa89Q5hg2
	ARGfKEXdDYJv5bKj9biNzGXrf7aUj619MGuozeKg61e2Zs+m8qayiByb7ZsqpiBKsXow2/TYr6B
	D+osHmazw/LhKBN
X-Received: by 2002:a17:903:3843:b0:2c6:a012:6241 with SMTP id d9443c01a7336-2d05219f33fmr24041995ad.6.1785558289372;
        Fri, 31 Jul 2026 21:24:49 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0eb486sm13303955ad.53.2026.07.31.21.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 21:24:49 -0700 (PDT)
Message-ID: <2f158b4b9df959e604edc14603a23782ffed9bed.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: verify zext_dst
 annotations for various instructions
From: Eduard Zingerman <eddyz87@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Date: Fri, 31 Jul 2026 21:24:44 -0700
In-Reply-To: <20260801013321.6ABC51F00AC4@smtp.kernel.org>
References: <20260731-static-zext-v2-0-da4aa161e8c5@gmail.com>
	 <20260731-static-zext-v2-5-da4aa161e8c5@gmail.com>
	 <20260801013321.6ABC51F00AC4@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-08-01 at 01:33 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Missing bpf_testmod dependency check in test_verifier_zext, ca=
using spurious test failures when the module is not loaded.
> --
>=20
> --- Patch [5]: [PATCH bpf-next v2 5/5] selftests/bpf: verify zext_dst ann=
otations for various instructions ---
> commit 9e656f5e6b04a69526327df6f70d8c362d02d3d4
> Author: Eduard Zingerman <eddyz87@gmail.com>
>=20
> selftests/bpf: verify zext_dst annotations for various instructions
>=20
> This commit adds a suite of selftests to verify the verifier's zero exten=
sion
> behavior across various instructions and state pruning scenarios. It cove=
rs
> cases like 32-bit and 64-bit operations, atomic instructions, kfunc param=
eters,
> and CFG edge cases.
>=20
> > diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/=
testing/selftests/bpf/prog_tests/verifier.c
> > index be97f6887f0e7..fba562c819691 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> [ ... ]
> > @@ -277,6 +278,7 @@ void test_irq(void)			=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 { RUN(irq); }
> > =C2=A0void test_verifier_mtu(void)		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { RU=
N(verifier_mtu); }
> > =C2=A0void test_verifier_jit_inline(void)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { RUN(verifier_jit_i=
nline); }
> > =C2=A0void test_verifier_ctx_ptr_param(void)=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 { RUN(verifier_ctx_ptr_param); }
> > +void test_verifier_zext(void)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { RUN_TESTS(verif=
ier_zext); }
>=20
> [Severity: Medium]
> Since verifier_zext.c calls bpf_kfunc_call_test4 (an extern kfunc from
> bpf_testmod), will this test fail spuriously if bpf_testmod is not loaded=
?
>=20
> Should this check env.has_testmod and call test__skip() before RUN_TESTS
> to gracefully skip the test when the module is unavailable?

Idk, bpf_kfunc_call_test4() is used by the test progs/kfunc_call_test.c
prog_tests/kfunc_call.c, which itself does not check for env.has_testmod.
I don't think we enforce this rigorously, nor that we should.
