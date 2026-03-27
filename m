Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368A432B9A9
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 20:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774644367; cv=none; b=dn4mfLUuwS/oweEm4V4CRMTQX+WoziTUqQN3hVFmEoGJcDMtLSjrsNUc+TYlq6KSxQzQr9aWAOTEfy8sqC60gGQOqq5mXq4yerjxAhyKcwPcwbtH3iFbyjvYCMlgVKdU36lRFIwiRMJbdBSsv1TUCNzAsFbv8RKLHqWzRksiTzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774644367; c=relaxed/simple;
	bh=fDzymumxhmPVi0kqJDnPX1S5XLdUlqA4PsrkwxXRf2w=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P/yTN/9UFwDOIR9L9h9Jc2cXM+DPRu5wXtq9iAc+wPUGSbUy0O7beNGRUcyrzW1p41gSqnRVQWJ0oQV+fw1/0KlLJgyVSI2/8bY6S9o8HpC0geglhdFRIkHmFCKrVGi0Dd4hO2jolsRJtu7KDsaBbrpUCjmOUKX9Q9sec/m6c88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsXkG43/; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsXkG43/"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35a1f549e7eso1598522a91.0
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 13:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774644365; x=1775249165; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhhPmZv6jB3Nj9KqY4gAaqQdksQx9LQaFKMP0x84xAw=;
        b=KsXkG43/UbUB9mxfhuHxI0mNmTDWkcPEqvdXEKafuZKpkY/BdRz7+xPxK3sJt+f9+C
         i0RmfucnqS2/40kx3l8xOT5Poq6a3xhs9G0kWY3eA0j06HGLAwzMRD2kgdik90Wea3Gh
         8mBI3z0UJgT/Vg9bDxsUjdT3VXBtSstgNgfU0SIkWGAOvTwNusUegf7rJTik9V3XBPW1
         bRWUAWFcHYBlKdZeDjuAz47VOiBfodNrMsO0K7d/zmt4OQgyOJwlTVYne5R7QjS79aUb
         rxLMaJuslseCPbzbssgsFTxhkkeF3w0pm+Ej1jv8gE2h+a818xO36OPwXVW1vuNPTMCT
         wk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774644365; x=1775249165;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dhhPmZv6jB3Nj9KqY4gAaqQdksQx9LQaFKMP0x84xAw=;
        b=MuFzdl+cZPV8wYHNgwY4jS2Cp3lEHmR8hf45BYNUZDuw6QnVwy3Z6H6GByvgXOTL5x
         WEFeAIYhSg3fA8LDa/QReWuJ9KQXR03L9e3gVDZVlRK010+/uuGZNRYb9QXMVZLHSaAS
         IL3LhUwbKreaA8I/vaacTp2UJ7Up/0VUBqNgB8cJlA6XpUVT0/Dky8hWnb8MF/8wP3Nr
         E6wkpAsxwvpF7oXiZfgxhreTc0kzyxXnj9agbKtEtWg3Y5fzyhBEFi8YXti2x1eyX91K
         NsKHdRBY8j6zIgu1zJscszwgvm/Ee81uq86uNRrkAU4J3udvSp6/QTHPinsJBv0g0r0u
         EjOw==
X-Forwarded-Encrypted: i=1; AJvYcCWqOovglUJRs9ePe5vF7UscPXFPs8ElTq8hGXVxSeKcvo8wR+p3P93bWCilez6DdHsUZMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIgbdE3lm5sp8ocJHnUlKxm0NSs08FeNTdhPuFDdB/WmTVP74g
	2j6JW5ieo+y80skrpvF+squKgjhIgdlRBLCGjUdnxovt8ciLqvDJR4pK
X-Gm-Gg: ATEYQzwfL0J71uMWaOAW1jTX9D/CuVpGLNmwYdhBSRVXihDUo+A4FoUSI8DsDy/z6ux
	t6vgm0QWUm57MhtrJRxCXSvP6ePF0Qw+klUTx9EwaiCIwZDnH6hCdLnP1cNbiQ49s+Vq9BrGx2Y
	Y7683mTufJL3pJbm4+YrO7/6t66e6RdjJCt/ZAw/YXr/+hrTpgiBm6KCRwxRKdnrXaHJMVX9Haj
	u66KZDV+0rECzhEXNb5Ucx46h/uYrYs8up+rAKDlREcgUqlYvjv2WvwQTrZxyAa/EHh5u2Sfi4c
	/J75I1RSeNvAmGcHut65qgsLeYqBHcZIUWDsKUJJ2wYOzUueOtwg2BAXTfZp5Bi8LuUAmCIW3nr
	rHL9MpOviHt6nkAb+j9Py1v23Ib3/ihGJxeB9aLUWtfMCD201WQcDZC4/DQkbfd/KbF8j1CoTYn
	6JPENxK+cHudXJD6aswiwApcdJ3/VzDFZz6UWyqz/AZWSv1Z1hUwWFEGIoNN845A==
X-Received: by 2002:a17:902:e850:b0:2b0:6895:5535 with SMTP id d9443c01a7336-2b0cdcb0cf6mr42563145ad.33.1774644365245;
        Fri, 27 Mar 2026 13:46:05 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427afa57sm1816175ad.71.2026.03.27.13.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 13:46:04 -0700 (PDT)
Message-ID: <74e65b463d1f992bc0e4846085394a440796f563.camel@gmail.com>
Subject: Re: [PATCH] bpf: fix umin/umax when lower bits fall outside u32
 range
From: Eduard Zingerman <eddyz87@gmail.com>
To: Helen Koike <koike@igalia.com>, andrii@kernel.org,
 shung-hsi.yu@suse.com, 	yonghong.song@linux.dev, ast@kernel.org,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Date: Fri, 27 Mar 2026 13:46:02 -0700
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

What would happen if there is no next or previous 32-bit block?
E.g. if (reg->umin_value & ~0xffffffffULL) + (1ULL << 32) wraps around.
I guess the argument is that if this happens, there is an invariant
violation already, will the final register still bin in invariant
violation state?

Useful picture:

 N*2^32                   (N+1)*2^32                (N+2)*2^32             =
   (N+3)*2^32
 ||----|=3D=3D=3D=3D=3D|--|----------||----|=3D=3D=3D=3D=3D|-------------||=
--|-|=3D=3D=3D=3D=3D|-------------||
       |< b >|  |                |< b >|                 | |< b >|
                |                |     |                 |
                |<---------------+- a -+---------------->|
                                 |     |
                                 |< t >| refined r0 range

Also, as this is based solely on unsigned ranges, the following case
is not covered, right?

 N*2^32                   (N+1)*2^32                (N+2)*2^32             =
   (N+3)*2^32
 ||=3D=3D=3D|---------|------|=3D=3D=3D||=3D=3D=3D|----------------|=3D=3D=
=3D||=3D=3D=3D|---------|------|=3D=3D=3D||
  |b >|         |      |< b||b >|                |< b||b >|         |      =
|< b|
                |      |                                  |         |
                |<-----+----------------- a --------------+-------->|
                       |                                  |
                       |<---------------- t ------------->| refined r0 rang=
e

Would it be hard to implementing something in the same line as [2] to cover=
 it?

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

I think we can move forward with this, as the fate of my RFC is
uncertain. Please add some selftests, e.g. from [1].

[1] https://lore.kernel.org/bpf/20260318-cnum-sync-bounds-v1-4-1f2e455ea711=
@gmail.com/
[2] https://github.com/eddyz87/cnum-verif/blob/master/cnum.c#L242
