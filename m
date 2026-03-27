Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08A2373C0E
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642700; cv=none; b=lqfRmsC0xrFKtY1LV3KKwO/4kWHrD65YodoDvBiKYrXBiWOK3Zo0M2sq5Db1p+UgnCUAdaTnyPSmpsSvuTCC7L9VGXRvENP1A+fbPIQ78V4HhAjewvmsVmgm0bHYPxg4xpVpkI/4sInNU6NDSagSXafddpR9Gr5x0CeauAsAQZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642700; c=relaxed/simple;
	bh=bU1xS9SrAC3n2aBJYclyPAjsNv/9raIQmaVdArbmRXM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UO9V9eGp7AOlMY7gEAgJOgO0UNb+C78038iDyzFgisbAzTs4NZHU823+kkcUZlLb/xWiDXSP+tSnaNRpgOtufnxn8PIWgEPWetMsnphVmiy559SeUDIsv3MGX5uCdMK+SW1JL6vo1mXMYRrYxSfBwLBXM8HlE/XfyJqTYlRRXB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3R7UWum; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3R7UWum"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c742d7c8acfso1198015a12.1
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 13:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774642698; x=1775247498; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niMWqr7V5XBvo8jyHfEjvFFw5BshpUxE9LTUBYu+xWU=;
        b=K3R7UWumFhbHHnjYhlpZ4v0ZsMTAZOooW0gy3Ru0ZAjGzPXTmrz9u55VScRFwfAQki
         K3kmesrViza/g7SB07fyc49gt0ycPNJqWIJtoEVq1BdsvcwtnXfy0l3Otq+0879vFgsJ
         TXWUsziSOManDBpgVgZg91RweR0H0eIIEbzNCXcesM7+SgADewkRbBX6ZK3Nj8h/Mptj
         thnsd0lt9HDVGQ6JqQKvr0fvwjncY9LjKEyX+u9iI12ojNzfrGuqxGZjP9/gEfOWQYlX
         1WjbRKLKTg1PxD9TCkV/HMzaboNHtiJ+aNQORD0xBFcKKdLyhQ4n/Zevg+0DItPgmGh0
         JHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774642698; x=1775247498;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=niMWqr7V5XBvo8jyHfEjvFFw5BshpUxE9LTUBYu+xWU=;
        b=mYipIvjeOF4K0iM6kBLkJeYR6cmS1zirKm47CDEzAxsXqmID387DRUgMIVwQqRwZqX
         sYD5/nvzVqAm3VpqhNJ4BBRnldjwjaDLQGYoqKSSHP3G9DFENu/lMbvUsn4FHmmMwS3K
         5sCkLJyB32qKsnKRFCaaLycL0s1Eou7qoNJKuj0zkCZze6hPwNMPSNlh8vT19MoqseB6
         EMu+vuzIVqp0LRl5QQUI9qxtvv0/Y7lpvjEKtjxiL+tpJ5BcoJiybm7A0hDYHJRdoC8W
         YauWVNyV0wDiGOC/QtwpQL7RvbOdRcIPOM5B5FmWcCwN/9CUfWXoQwid2gtvt6mYq1eY
         l6xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiEIBFMWkjiMGb1ZWkArjlAimWrXR9SnZkZgcxJDuLSoOyybhyFIepjJPi6X1jffBG3GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOOmQuq5ms+3XNiCOdswFBU/DTyCxeoyRXNV66hJRLJdoQX3B9
	i//MtC+0ppsNl8diyDhoOHsPcLXFw5pHtQYT8ThzSwo8MH94/nNZ+0QiO0i1H3oW
X-Gm-Gg: ATEYQzw/AB5lRw+G1LXNmlcu5jgtlwQAu4Vb+KSdIuetsrs6+hPcbVPhmI3yl1R3Viv
	1A4JyfZmL/74zC8wvsqNLkJY3buv1U3z6d6DC3hOc/YUdSntpPjgS6I7DgW+iKQ81/lTGM2fV+1
	sUKqCELd3NuHKeYX++LG6nV5T/RHQb58BsnquSOag9XUOqUyu7c91PgByJxv8n7POAKDBeyOpwz
	aluAyjshnAvzYGip7+typCCNGZ6WOGrN5QNkbE2RxXY4bvtW2+Qkar5T7kVFVTXNXP0BuOIYzEv
	65S3NUf+k/HH/V7wGOwSF8arybOs8ET6Qmf1vFO1U1PkUlTlsxKU5UlxJywnydkZ2fATzvmLPtr
	sTSRS6Tqlsla5RewPfloG9hBTsdFFKoc9L42K7naPpGpW88zb+GwoW8T/XFaOgqsOPUV8rG7158
	3SPZE4O6W7HIIFcKq80p9XM2Cb1TEgmS0IFgYMcjEiB/oZ2kjEedE=
X-Received: by 2002:a17:903:2450:b0:2b0:4b3a:9b4d with SMTP id d9443c01a7336-2b0cdc5eceemr41395115ad.20.1774642698013;
        Fri, 27 Mar 2026 13:18:18 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24266b92fsm1589575ad.23.2026.03.27.13.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 13:18:17 -0700 (PDT)
Message-ID: <c213b7ac01155249d5010c785bc2e6e3e280cd69.camel@gmail.com>
Subject: Re: [PATCH] bpf: fix umin/umax when lower bits fall outside u32
 range
From: Eduard Zingerman <eddyz87@gmail.com>
To: Helen Koike <koike@igalia.com>, andrii@kernel.org,
 shung-hsi.yu@suse.com, 	yonghong.song@linux.dev, ast@kernel.org,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Date: Fri, 27 Mar 2026 13:18:15 -0700
In-Reply-To: <20260327194849.855397-1-koike@igalia.com>
References: <20260327194849.855397-1-koike@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-27 at 16:48 -0300, Helen Koike wrote:

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a965b2c45bbe..ddac09c8a9e5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2702,9 +2702,29 @@ static void __reg_deduce_mixed_bounds(struct bpf_r=
eg_state *reg)
> =C2=A0	__u64 new_umin, new_umax;
> =C2=A0	__s64 new_smin, new_smax;
> =C2=A0
> -	/* u32 -> u64 tightening, it's always well-formed */
> -	new_umin =3D (reg->umin_value & ~0xffffffffULL) | reg->u32_min_value;
> -	new_umax =3D (reg->umax_value & ~0xffffffffULL) | reg->u32_max_value;
> +	/*
> +	 * If (u32)umin > u32_max, no value in the current upper-32-bit block
> +	 * satisfies [u32_min, u32_max] while being >=3D umin; advance umin to
> +	 * the next block. Otherwise apply standard u32->u64 tightening.
> +	 */
> +	if ((u32)reg->umin_value > reg->u32_max_value)
> +		new_umin =3D (reg->umin_value & ~0xffffffffULL) + (1ULL << 32) |
> +			=C2=A0=C2=A0 reg->u32_min_value;
> +	else
> +		new_umin =3D (reg->umin_value & ~0xffffffffULL) |
> +			=C2=A0=C2=A0 reg->u32_min_value;
> +
> +	/*
> +	 * Symmetrically, if (u32)umax < u32_min, retreat umax to the
> +	 * previous block. Otherwise apply standard u32->u64 tightening.
> +	 */
> +	if ((u32)reg->umax_value < reg->u32_min_value)
> +		new_umax =3D (reg->umax_value & ~0xffffffffULL) - (1ULL << 32) |
> +			=C2=A0=C2=A0 reg->u32_max_value;
> +	else
> +		new_umax =3D (reg->umax_value & ~0xffffffffULL) |
> +			=C2=A0=C2=A0 reg->u32_max_value;
> +
> =C2=A0	reg->umin_value =3D max_t(u64, reg->umin_value, new_umin);
> =C2=A0	reg->umax_value =3D min_t(u64, reg->umax_value, new_umax);
> =C2=A0	/* u32 -> s64 tightening, u32 range embedded into s64 preserves ra=
nge validity */

Looks like it is the same case I identified in RFC [1].

[1] https://lore.kernel.org/bpf/20260318-cnum-sync-bounds-v1-4-1f2e455ea711=
@gmail.com/
