Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4603E0088
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921803; cv=none; b=ll2ka85Ocb5E4Ak6qlUzysTTl1t1W5j2tfo3wUouNNstrhj2e5K3X/5fGW7PUQmMxsyonP0MHNjPk0DabYzxS7aDfqBb3ylx+7lVGazZSyVT5iG4g1WOBo3Jwdzc8IN7wgID7vwjiFR9qMutgtxhlq/VKLKqUVVo1Ot0bIxba/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921803; c=relaxed/simple;
	bh=CD99I44k1GGeXTmJLBIEMb8WvA3Q6H/njKMEavvkURw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vb+64It5S0qo1irHIIydXlcEQ/UYegODtloefXy2VDGWU2ye9aEZNDJssWKoZD+OpeXmgbwA8sQM+UrzflqStX5XHqX8FDfg7aKrbr9H0yCDapAzIShMx3CUhuMLqIb7fS+qhc+rSUL4Ay5C2h/ZYwLsWHCMXdFgsZtE05UyoX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i30xM6Ol; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i30xM6Ol"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e58034d05so676753a91.2
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 02:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785921801; x=1786526601; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CD99I44k1GGeXTmJLBIEMb8WvA3Q6H/njKMEavvkURw=;
        b=i30xM6OlGsMLp2wOhS6tUJMacHWnSrlfOp9qLAUZeUBPtFZxQmsNfczZaYX0xFsQny
         KBgq6Jd3xWaPTJ3iDufFIZWFWdChhKj8rs3aNRASDnRqaap9uxPoSaxnn0Wl16i2UaoU
         mnhPDjOxBuSng7ObZZw2lBjHJp/FiZMgCPIH7P3yn22U6XYcLkNMiPuhbNRYOmOPFBTZ
         0qQORIO68TYvAvLEYgo4sKZ/HA60QUu4SaVTVWJe/nVVwCeFP73J2Nmw40jB4pfszRou
         Fr0ExgVkMeTn6NPoWGCKbtj+1r0qxphfk+Tx0YOq4J346ngY5PySsSqBwRZ5M8HJtbBD
         mmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785921801; x=1786526601;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CD99I44k1GGeXTmJLBIEMb8WvA3Q6H/njKMEavvkURw=;
        b=LTdc8v568GoZR68IHPnihdvLkR9LHSTXAUW2jAG+rFBpxOQm1MtCnlZsC7wQSUZ/Jy
         3Rgyj0RZy74aAyhsJuUSTPI8AWCID/AiniHqg9yr7h6M5W8ncS9egM2tqAFnWjEhq2oI
         Y5l5RgEFX465pMGLrkx5RHq0UPxb54heT0/GYw217F8xxEuX7PyAWCJdbaPI/XfdJDQK
         Ran3lv5pDMTucERJtcAY3g/awsvpSX6hwIHi0ZznccMMum0uZLil/emvv2RfmM0etLz4
         4aFLOElZhCdf5CtDXmC2B9Q5415jmS/YhOLAFYNeV6iHunqXCO04ZOS1XO3QjVl5C+6p
         psgQ==
X-Forwarded-Encrypted: i=1; AHgh+RqbHADSwl7BmFROrJt9Gqb05YhLpAVc7R5DuAdfd9vWCFJpZMwvI5NHb2M1LlxNY+tm79M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkvlO5lzh1znRm9/Eeriwx0PhQsmR11L19ja6cIRDsTr0qPdYz
	wmj8qEJ2HtDhefHuDgl2GEnjtm4qlNS50m9ZHxdcrMbZL+3L2OQdpqUM
X-Gm-Gg: AR+sD13ppxoRB61YPLgVJLC4M8FeIZf2ihaYIya4+CeXct8igt19ZhUHtubLMU+ZSWr
	QjO1A0eEo4mjDWLYjIwDRXjiu8yUS7rlKYuAIZshCa3xorly8kg+ax2SuP839ou/1/wA3RGAf0e
	Pcv7jxbM2jxCtMfSSrfvW476k6ysJ3gYYpFqQl++gqsFZxdHplF+i53Rz3QjofAsUg2PcDJXpUe
	Buz9zzv/+5wT0Y72FcQUk4kzSLJw0ZcMwb+qK32P6yXP4pFnjrHpwcCZuho01mXzHjzDK9vqKP2
	cD3ubG1h8UAHlEw9YZiVhOzF6d6I+0o3mbQ18JlU9ZLILPRX99INRzwJkv7npcLC8pM6neejHBf
	mY9yaiG84xxVh8HFPtDappUSzsY1HEHG0fUBhypWpFlB3oVzmGHpVAng40QLRiMbQs/E/o8mrO1
	79kghWEl+BL2hbfIEdRy/PpH8Z/4vn1NeZ6rO9CwMJoNY64CPnl3RrvlAoZ13MLolakNffKaGKe
	k0IwLPj5T94Nl3q
X-Received: by 2002:a17:90b:264c:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-3903c59936cmr5655140a91.8.1785921796057;
        Wed, 05 Aug 2026 02:23:16 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38feda51060sm4085337a91.10.2026.08.05.02.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 02:23:15 -0700 (PDT)
Message-ID: <428d1069d408ec5ea597fd3ad610c4530f883953.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add load-acquire test for
 dst_reg == src_reg from ctx
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, memxor@gmail.com
Cc: puranjay@kernel.org, info@starlabs.sg, bpf@vger.kernel.org
Date: Wed, 05 Aug 2026 02:23:13 -0700
In-Reply-To: <20260804201917.253491-2-daniel@iogearbox.net>
References: <20260804201917.253491-1-daniel@iogearbox.net>
	 <20260804201917.253491-2-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-08-04 at 22:19 +0200, Daniel Borkmann wrote:
> Add a verifier test that a load-acquire fetching into its own source
> register (dst_reg =3D=3D src_reg) from a ctx pointer is rejected.
>=20
> =C2=A0 # LDLIBS=3D-static PKG_CONFIG=3D'pkg-config --static' ./vmtest.sh =
-- ./test_progs -t verifier_load_acquire
> =C2=A0 [...]
> =C2=A0 #614/1=C2=A0=C2=A0 verifier_load_acquire/load-acquire, 8-bit:OK
> =C2=A0 #614/2=C2=A0=C2=A0 verifier_load_acquire/load-acquire, 8-bit @unpr=
iv:OK
> =C2=A0 #614/3=C2=A0=C2=A0 verifier_load_acquire/load-acquire, 16-bit:OK
> =C2=A0 #614/4=C2=A0=C2=A0 verifier_load_acquire/load-acquire, 16-bit @unp=
riv:OK
> =C2=A0 #614/5=C2=A0=C2=A0 verifier_load_acquire/load-acquire, 32-bit:OK
> =C2=A0 #614/6=C2=A0=C2=A0 verifier_load_acquire/load-acquire, 32-bit @unp=
riv:OK
> =C2=A0 #614/7=C2=A0=C2=A0 verifier_load_acquire/load-acquire, 64-bit:OK
> =C2=A0 #614/8=C2=A0=C2=A0 verifier_load_acquire/load-acquire, 64-bit @unp=
riv:OK
> =C2=A0 #614/9=C2=A0=C2=A0 verifier_load_acquire/load-acquire with uniniti=
alized src_reg:OK
> =C2=A0 #614/10=C2=A0 verifier_load_acquire/load-acquire with uninitialize=
d src_reg @unpriv:OK
> =C2=A0 #614/11=C2=A0 verifier_load_acquire/load-acquire with non-pointer =
src_reg:OK
> =C2=A0 #614/12=C2=A0 verifier_load_acquire/load-acquire with non-pointer =
src_reg @unpriv:OK
> =C2=A0 #614/13=C2=A0 verifier_load_acquire/misaligned load-acquire:OK
> =C2=A0 #614/14=C2=A0 verifier_load_acquire/misaligned load-acquire @unpri=
v:OK
> =C2=A0 #614/15=C2=A0 verifier_load_acquire/load-acquire from ctx pointer:=
OK
> =C2=A0 #614/16=C2=A0 verifier_load_acquire/load-acquire from ctx pointer =
@unpriv:OK
> =C2=A0 #614/17=C2=A0 verifier_load_acquire/load-acquire from ctx pointer,=
 same dst and src register:OK
> =C2=A0 #614/18=C2=A0 verifier_load_acquire/load-acquire from ctx pointer,=
 same dst and src register @unpriv:OK
> =C2=A0 #614/19=C2=A0 verifier_load_acquire/load-acquire with invalid regi=
ster R15:OK
> =C2=A0 #614/20=C2=A0 verifier_load_acquire/load-acquire with invalid regi=
ster R15 @unpriv:OK
> =C2=A0 #614/21=C2=A0 verifier_load_acquire/load-acquire from pkt pointer:=
OK
> =C2=A0 #614/22=C2=A0 verifier_load_acquire/load-acquire from flow_keys po=
inter:OK
> =C2=A0 #614/23=C2=A0 verifier_load_acquire/load-acquire from sock pointer=
:OK
> =C2=A0 #614=C2=A0=C2=A0=C2=A0=C2=A0 verifier_load_acquire:OK
> =C2=A0 Summary: 1/23 PASSED, 0 SKIPPED, 0 FAILED
>=20
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
