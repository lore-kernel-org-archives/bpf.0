Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CFE3B19B2
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 22:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788647978; cv=none; b=WUomO6yR6n+1Js0MlCvf3QLmtfMSLsRuUThENywjPA4aoLoYBWOzYUNM+J2r4uyivFKRVfohPl7UYYg+pUw3nbp21en/gcaFOtBx/MsvUrJ5qnu09aH4AW2q9ogk+efjvtFYrOh1yfA1UEHfHJ/BRm5peNTvx9KnnccAckR5SnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788647978; c=relaxed/simple;
	bh=0H8U5D/PR2nl8fIgoNBuIh3GIAaZtHX2NdF5dpTl6X8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=scNFGiQx1Zh1LNRIvB2b/g8sXmUJqS0nUE+7ohRukcd2xGZssm2A42u5NSG8LS3WD6U/TaN67jg3G2Ouv8G5RkwGqmc/wzpv+utvP+UqCshSYzJrXFSpJTPx6w2RAzKdXxnexOHJZoAH8SFCrqXeNDbGtNIbvh+8W8/ipaXDwnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W18bgdbM; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W18bgdbM"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7f4e596e393so2592829a34.1
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 15:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788647975; x=1789252775; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X/f+z2nmCi/0KNOuKpqOW6wHU++XKerP0D0hide5es4=;
        b=W18bgdbMTewPOy7lR231htehgZ1beNc4hQh5KVbftdlQlwRFagHApZPXGlRiHrJj0o
         jvFU48gF8P8H4hQlt+5sFi0uLtpZgR9wLwe4DX12JcUXCAQWPokYg9cH2J+iHzTJggrH
         /b6YRcPYSYE4C1R4WMma80vWSy257v50y+aoPxiFTKlLMGWGezg07mfuW05jIYdcRvJn
         7l6uzulCLfFT9Pt5apc9sIxqmovVTTbgCtaybJMwKgBHa+65C6xHS2pfi3dRCdJDqMxf
         FpQqT+o2+TAAGv3WhiveFlbT7++RilcMWrpyyO4XazUENiRa2QCPpbJ8gkniA/rUwLMH
         +ziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788647975; x=1789252775;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X/f+z2nmCi/0KNOuKpqOW6wHU++XKerP0D0hide5es4=;
        b=CvRI4L0qZz9XKG1L0DB9tF6y5IgyNCi1FEXTIFkbfOOL9eopCWivlWc3WKGPe+JHSx
         xWOAb1ju9+Yj3V/WFOFW/rDcZt2NFbeFbqUuF7oRd8PMKCnSag2W2j8jFgm3UaNxbazM
         YaGYSbMGt2Lrs1SdpmXso5SwXlT3+3j9VuBU7LvfhTcVbPKaTczN9rxN8zwVes7A/nNz
         CUebwjZCXHRUf8EZAbVaXVVqt7iP2XYf/JWzlcFwbW0O2wVjFJZ1B81lCwPQj9Wzkxwy
         scb3Nqtp0HSxKKGyJxYlN1f6xtcqar1JNSFHsm0WTF8pybYtjUzwKVFS8GqLzg3FcPX3
         hm4w==
X-Forwarded-Encrypted: i=1; AKwUvBzhcK8YTUkcWeqxf4ZdwixhLrHyP9nlCCih2puLp5G2QWzYqt+x6VIJ+wxl3UdOc0GWGWo=@vger.kernel.org
X-Gm-Message-State: AFuF++kBEy2ayaT67Tw5k3WdR0D91K8K5M+V17BtU6CpWQCtbQ1PxQb6
	ecRbv2xJhvah5hkdp9YltqoJC2G98JkjWOdGpH3jl+XJUZkJ7DDis5+D
X-Gm-Gg: AYBFou1MApZs27ub9pwOcrYOYgbm43aWZ4JUeuJoA7yVoibl4Ue0m2c2pM78OyDLjxQ
	FT1Htj6Ri2CuLbnuFXSPDvtCuMCDuUZqbWwBRF5ZX7BLNWQUOsCzEH6qNv5qtgFKrZ8X/3jJfrh
	+lx2Kx4cl8tAs00TkKs7S74ToCuipTEAQ/EHo5auSaw28rPHN1lBpnRbUb3EQUGf5EG0DOSypUN
	TFsAghJhRtIZcgsmz2LCUQpL7cocQEgbHrXffCP+ZlPJYk8Dv/VDOCd4o3KgSW/a1l/jfxHNMVC
	EJRlNWO0x+1cKgvt5/1oxuh4c2DY+cqnyKsA53w6GyiqMnkqWifo3JiKYuvM8/UI/zEmeureDLN
	x+v+hUY4D2vfWIXr3kK2EBZFQufrd0F/nDA33fiBKfduF6Ve7ead5lN4t/HJADLcbr03cw41Wiu
	yBZhuz84eSUXSlHYHMq4xV6jz6XEiEOSj9M2POKLUptyhmje/Pf+/FFX+g1MN5twSlYcJg1Dtzo
	vbwxr+ahvzmXqbHXwcOGe0zPOswz1aqfTXPrJtVMLgdXGng7CkAxmI=
X-Received: by 2002:a05:6820:c0d4:10b0:6b7:83c5:fe03 with SMTP id 006d021491bc7-6b783c60410mr5495274eaf.68.1788647975023;
        Sat, 05 Sep 2026 15:39:35 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:14::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b6dc6aca49sm6920103eaf.6.2026.09.05.15.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 15:39:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 05 Sep 2026 15:39:32 -0700
Message-Id: <DL7QSF4BZB1E.3U5O9EBHDN2LE@gmail.com>
Cc: "Nicholas Carlini" <npc@anthropic.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Verify global subprogs in each
 sleepability context
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260905051224.2325381-1-memxor@gmail.com>
 <20260905051224.2325381-2-memxor@gmail.com>
In-Reply-To: <20260905051224.2325381-2-memxor@gmail.com>

On Fri Sep 4, 2026 at 10:12 PM PDT, Kumar Kartikeya Dwivedi wrote:
>
> Record whether each global subprogram is called with either in_sleepable
> value and verify it once for every observed value.
...

> Since a global subprogram may now be verified twice, accumulate both pass=
es
> in subprog_info[].insns_total.

Only after reading the patch carefully I realized that above is saying 'may=
'.
Just by reading commit log it sounds that all global progs are now verified=
 twice.

Please reword to make it clear that glob progs are verifier in the specific
context when it's actually reachable.

> =20
> -/* Check if we're in a sleepable context. */
> +/*
> + * This predicate is the inverse of in_rcu_cs(): non-sleepable programs =
and
> + * every condition that prevents sleeping also provide RCU protection. G=
lobal
> + * subprog verification relies on this equivalence to represent the call=
er's
> + * execution context using only the in_sleepable bit.
> + */
>  static inline bool in_sleepable_context(struct bpf_verifier_env *env)
>  {
>  	return !env->cur_state->active_rcu_locks &&

Since it is !in_rcu_cs() let's make it so in the code.

pw-bot: cr
