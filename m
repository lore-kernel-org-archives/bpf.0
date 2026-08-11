Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EAE3B0AE6
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786481442; cv=none; b=E+mIp1B9o/tBsBEOAERLsC8B7udIs3t4NoTlGHoNDC9ka7sTpaLX+G3Ljt2fFxXMHRilBVydJJvNGG9DpH369KZOPqtOxIJkrpmSG99ilJlRRcGV6DLotJsd4YcrfzsLXiDvnJ6YX/+WPjI7EBF1v6BYZNmlkiDQOQTmcDrb1CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786481442; c=relaxed/simple;
	bh=tHcWXN7cSzuUXWbFEXEs1fAMieQg+QC0f4YsL5MveQo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C3NLxyuNHtFlj16IbSaWhn3SIyjgiGBgR3/infbk4A3Zh59UvfMZHASdTU87g1K/ZTmUF5nVVpHX16QjBogAHEOcbNTV7owHeGlSZoPrupTMw/HSoG1iOeDh4nIEuX/fTz8g/MYxPHpVcYI8bzlVqyTAouh+YKVPlH4w8+/9fy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBKNW8kp; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBKNW8kp"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ced3386430so4635855ad.1
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 13:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786481440; x=1787086240; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ooNYTPRIUw9TxLCAyYfCXQFKQJ8+xRKddxkf4tR9/m8=;
        b=IBKNW8kp+a/wXKAioDSNxjHy6CqkBsr6VES2BZiMLmRpSJWwFHdU58sskhhRpmHDqg
         k/ie4oIXj+fr5ew+2EIBjbBZGRkjrC5kg/WRdiX1OrH0OelN1qJrTS43mhI1zs7uf8pP
         y2F8VQ7SBg7IDrHJ2DF82NJvu8h15jVnRFhGSgFCMxMeT7RLZf7RLIaiAoDyPmrZNiC/
         tKnwQjnT3Xm5RKm17QaKXl4Uxd0RngaAvGKR32LmadUEPiT+Rb5J7im7gEMomwyw7VSO
         NzVSMwvZISGJ8GJSf9od4Bddj8GCbRSZm2G4G4AvpQWRtGyY/XWZjRmQ84eKEDm21dUi
         R33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786481440; x=1787086240;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ooNYTPRIUw9TxLCAyYfCXQFKQJ8+xRKddxkf4tR9/m8=;
        b=UxQBqRuxorKHvjkMRaB0U1JTpHIBMUiPONCNjO3q9pI4rX5khsxrHPtW7/IA178+w0
         L37AHl4UYVliPWLMvYcjSSObBXcEVZUdVnFZeDJnVw+3CP9yCkl/6K/BChGK9C8K1Uiy
         NyWmOSxSaBIl3mO2VZDxPdoj6p8j/Fo/y1/6UgtecjqYrzSPzWlTizGaC8N+VeyeUbUQ
         wQtd4tEtOjThDbd/ArXFUpyq6rVl5Nf1QYR2JCLxN5TRJtisUpelwEm5cup294mWJkie
         MPkTCObkynkCV02PqvkRaaa5AZvm0daiUNNvNBESA4hSHnvo31nHmW9G3iwpQhmpwl2Z
         UjBg==
X-Forwarded-Encrypted: i=1; AHgh+RoMCrQPr+rP/SOaAv0x5MJiGl9T+dnUYz3R86vbP5WB8c7mUGVkp+RcLBG02J8sYI0Gc3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvYqekxbfcQVxNVyqj3MLl4NJZUB9Tc978nADvDL0ya2bl4hV/
	wMxmYT7zM+AMrfAkVX7UVFnV6sDoQo/dD5k36PHU1GCAwZsismIDlatE
X-Gm-Gg: AR+sD12qlWwKRws7DoTiHg0BOIb9oGzhiU+oy1caiJxGyIljhN52MEonSILlASMq9au
	Hm/mc5OcV/LcXX2msqjAbKnD7glVng3cMkueSMBNOnsx/oSwDmaWiMdsQ/Sq42eUJ0fJBXzNouA
	TZiP0fNnZAthgwfIExau1y159Qq3baGxDc/GCXCLGucP71N1HCOlxVzdtHQzYzM2UoFeonlSz9t
	YPBdThy9a5/4lZxdtruu6drZdbmF2B/UGpREwsQgeYun3fJRedwXOjBFmaCUDf7/2EpRTZDwFpZ
	koUdSjE0JIpWhHRevcoRtyUOIYpKQ/QtlAFhKCWsjelJz2578HkhEZ21J19rE2NHCGbX9tsAnUM
	W2IM4BEAhLG0nARn4t5f/3cPUUWoAEQ2EE8qyj7lIQJxdcwuYcYuzMOPjNjGx3s4oiExGErosrq
	/tYWUJ663Q1laCsj0FEWPlDPCu0ZlprdUFFlrFmoYnL5DhEVyU20M7iaMi8lmWWSaqsBPgzNxYp
	DhaIyP2FwyP3F7+wminZNK+a+X3NzL+rJQCLq79Qg94kQ==
X-Received: by 2002:a05:6a20:918e:b0:3c3:88a5:83e4 with SMTP id adf61e73a8af0-3cc2b7ee8edmr7629697637.10.1786481440267;
        Tue, 11 Aug 2026 13:50:40 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:cd18:dfe8:e39c:4123? ([2620:10d:c090:500::4:f345])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf67912dbsm2565083eec.22.2026.08.11.13.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 13:50:39 -0700 (PDT)
Message-ID: <0c899eaef2ffeb53c37c75207775e8fce8cd6f47.camel@gmail.com>
Subject: Re: [PATCH bpf-next v7 4/6] selftests/bpf: Adjust veristat stack
 depth parsing
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Tue, 11 Aug 2026 13:50:37 -0700
In-Reply-To: <20260808062601.1070988-5-memxor@gmail.com>
References: <20260808062601.1070988-1-memxor@gmail.com>
	 <20260808062601.1070988-5-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-08-08 at 08:25 +0200, Kumar Kartikeya Dwivedi wrote:
> The verifier now reports instruction and stack depth statistics using
> uniform "subprog <id> (<name>) <kind>" records. Subprogram 0 is classifie=
d
> as main, while other records are global or static. Each record carries
> insns_self, insns_total, and stack depth.
>=20
> Teach veristat to parse the new records while retaining support for the
> legacy one-line stack depth format used by older kernels. Skip both
> instruction counts and match only through the stack value so fields can
> still be appended without breaking parsing.
>=20
> Increase the bounded backward scan so it can include all 256 per-subprogr=
am
> records.
>=20
> Zero-initialize the legacy stack buffer because logs using the new format=
 do
> not populate it before the trailing tokenizer loop. This makes the loop s=
ee
> an empty string instead of reading uninitialized data.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> @@ -1025,11 +1027,17 @@ static int parse_verif_log(char * const buf, size=
_t buf_sz, struct verif_stats *
>  				&s->stats[MARK_READ_MAX_LEN]))
>  			continue;
> =20
> +		if (sscanf(cur, "stack depth max %ld", &s->stats[MAX_STACK]) =3D=3D 1)
> +			continue;
> +		if (sscanf(cur, "subprog %*d %*s %*s insns_self %*d insns_total %*d st=
ack %ld", &sub_stack) =3D=3D 1) {
> +			s->stats[STACK] +=3D sub_stack;
> +			continue;
> +		}

Nit: a comment about why two different formats are matched would be helpful=
.

>  		if (2 =3D=3D sscanf(cur, "stack depth %511s max %ld", stack, &s->stats=
[MAX_STACK]))
>  			continue;
>  	}
>  	while ((token =3D strtok_r(cnt++ ? NULL : stack, "+", &state))) {
> -		if (sscanf(token, "%d", &sub_stack) =3D=3D 0)
> +		if (sscanf(token, "%ld", &sub_stack) =3D=3D 0)
>  			break;
>  		s->stats[STACK] +=3D sub_stack;
>  	}
