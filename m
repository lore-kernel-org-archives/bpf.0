Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD50F2848A0
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 19:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777231031; cv=none; b=s4XPGPvxktBlZJRgT2TVGy8imAwY3hYcfqBSrDvaUG3RyIr0DUC12524R10HnOtnP3sqoSfvauHbYqw/yRQRk7u7Whvl91q+E7svmYNWypH+C2o904sJWHHc8V/twM7Nr3EkWNY4MKiGdzCIdN4NyibUrgKV/bJz77PTAlDW6iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777231031; c=relaxed/simple;
	bh=hx4muqT329gvnq8emb2sJIUT4hEB8hYF9W8WijtuD5A=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=IkuKo+uC+c4qLJc5wWEp075JXSdFZnUbMFFVSMwci+tBrDmxHw3Fvqe7RxvrrTIhG9O06wTf+bMUk64M15m3qHM35oXuNFOUmjonOTLq7fdHFbVeYXGwvOX/Ptko1rLOgMgutJcGxY8oNB995JDNt2EAZhcDzS1kfPcXez3jWXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=RMMLJEf4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="RMMLJEf4"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a871daa98fso62018235ad.1
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 12:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1777231029; x=1777835829; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSblK11nZsAuu6dBblEvTDaeDGn9LCh73TEkAHVfyjE=;
        b=RMMLJEf4590MoUilHmvsjowveElP5vUUM7ThmkzaQNIPnFGb6xRRFUB7XIdrze1eqd
         e3b8zBD+NYV4BavwzAGXfABrjopDPloRb55Ilp7Ovwcw4EaVoSCQX4YsK+qRO5J8Q48i
         gXDEEW+pnp8ajEndqzlIwCVf+3HRgWiIk+wX5GvavmVeHySC2g4ugY7zt/wMkfAajOqF
         imPS4GU/iHJApRfWVxFRjLeI2FasFVJQ1DpGjNuFCnhFgE7sT//RAoa4nftamOFz5UuS
         Qhyxm7AQpPdazbnEGBCDXbX845AMievO/W40Wb8jymSan3rfxwFncrTgfyduo8Cfw9Je
         SiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777231029; x=1777835829;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TSblK11nZsAuu6dBblEvTDaeDGn9LCh73TEkAHVfyjE=;
        b=ep8RTBL/QJeRpkbLGCYhvjqpFTLKiFvwIWzfNG17F6PP7g+Y1Y0xCYTOcGjbPnLGlJ
         blTL4aeo4n4WV38h4pzbZaiIYyjWzTDMkFSRdVQfh8/0KvB1mFQ7u387X+SnDUUNz1qy
         A352jP5Qw3sgi4so8I5vGp4g2RZs+j0gHvlXXu3uA/Khu+NKLiE3Lykj+kdCMVe46pWM
         NVAB5f9JZtCwRBLPgm8Tt65yN3WXmkoBi9JVsp0wFiCTaJzi9+qCUdLYSd5wUfWjD9yu
         AZzG9awWyJAJa8wwycD/ZP1vB8CYbyucFK0QywVR3xPcqsnvTRUbbviTgWIMZAWp5kaa
         rLIg==
X-Forwarded-Encrypted: i=1; AFNElJ+r9mkBhBZljPJfJZbuTfAqKytnAmVbIS7Wed7uguLCdTJ3vjbQ5TFf/EFpYEJAP1ZrgqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVEyy4HR/wyHszopw4tAdTzYyQhJgbVb0jZ0WsoTx+HQJiEkmi
	Rj7bSI0CUU/krzlOwVc9T4HSvOZyMOuwCYID1mtKO3XyORPZnpBtdehaIrNIegvW1zM=
X-Gm-Gg: AeBDiev7HNhcTMbvRUmE6rJwjTanxzBTIBHsQjw7YgkZBSiht40w/Xj8m7yhFvF9Z8z
	u5TPG8AbgQ/dO2LLrBIT8b1MO6Y+JbUFah9Kf1aa+YVDJJ2haUiEXMm8A9x3MpuLRWWKrdFmfHV
	7PxM1qePl+A/Jxe9EiKktfbT5VILq3ykCwi1XBWfo2arG/N2XRNxCd/qsKZg9J6Wkuycp+enOtf
	Et7Dh2hPFWMAs294iLDtgt2DDkD3STu7Romy4+17CcCvUsq2+3KMY1qMsQXP5u8yg0sGDyFrFn1
	Oe6r8G1lIQgTOaJSbO7J/KAEFMTE/fsBKV3mwHiVoJXcphFuIMXzmU45yZ9gtY0UHBG/RdngoG4
	c/a1tJgS/gj9XgUlfbIp+bXIHtjPt/x6ku+LC/o890EyvAsQ2pVZiYB8z+3xxvgBBy6DnmbJqmE
	ImrtvYsm3myZ86vq7hpW5yP2CiODLo
X-Received: by 2002:a17:903:2acb:b0:2b4:6398:6aa2 with SMTP id d9443c01a7336-2b5f9f3a802mr459892015ad.27.1777231029189;
        Sun, 26 Apr 2026 12:17:09 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::2af6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab2114bsm270988425ad.60.2026.04.26.12.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2026 12:17:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 26 Apr 2026 15:17:08 -0400
Message-Id: <DI3BTJ61RUDC.8DB0IJ6YME4J@etsalapatis.com>
To: "Junyoung Jang" <graypanda.inzag@gmail.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>
Cc: <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <greg@kroah.com>, <security@kernel.org>
Subject: Re: [PATCH bpf v2] bpf: Fix off-by-one boundary validation in arena
 direct-value access
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <2026042614-scowling-hankie-f84b@gregkh>
 <20260426172505.1947915-1-graypanda.inzag@gmail.com>
In-Reply-To: <20260426172505.1947915-1-graypanda.inzag@gmail.com>

On Sun Apr 26, 2026 at 1:25 PM EDT, Junyoung Jang wrote:
> BPF_MAP_TYPE_ARENA accepts BPF_PSEUDO_MAP_VALUE offsets at exactly
> the end of the arena mapping (off =3D=3D arena_size). The boundary check
> in arena_map_direct_value_addr() uses `>` instead of `>=3D`, which
> incorrectly allows a one-past-end pointer to be accepted.
>
> Change the condition to `>=3D` to correctly reject offsets that fall
> outside the valid arena user_vm range.
>
> Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
> Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  kernel/bpf/arena.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 802656c6fd3c..49a8f7b1beef 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -511,7 +511,7 @@ static int arena_map_direct_value_addr(const struct b=
pf_map *map, u64 *imm, u32
>  {
>  	struct bpf_arena *arena =3D container_of(map, struct bpf_arena, map);
> =20
> -	if ((u64)off > arena->user_vm_end - arena->user_vm_start)
> +	if ((u64)off >=3D arena->user_vm_end - arena->user_vm_start)
>  		return -ERANGE;
>  	*imm =3D (unsigned long)arena->user_vm_start;
>  	return 0;

