Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE593B7B7D
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191531; cv=none; b=cQhRdu1S6NYnaVVqzMaBoEC2ufesuvz6Lfhruco+B07F9Zc3dErfL8uh7MTiFuOZxeyZOXfa4s50AELTUHZTfgtSgMaFEbISchWdbR+ndFO3v6Kh+ytIBfblGxCwsEKECsXaPF37Q4Q/MeWmhxxfd+KPJkxdmd5oCjieYLbIjNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191531; c=relaxed/simple;
	bh=Y8NPifQ7JbrVkPJWhowuJfDS8NZGUp5xOwDXAZgLKS8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UsXs/WWzq4HEUy3lmOrcHCEU2WIJwOIh2XTQ6Hbwek6OaAcJ23GDIHA2vLamCERD/teA/+Ey0JRtqMpeCifCsynylBGyPowWy3EqfVFlUvoF5fZTyd/l6H7wpmv34W+LiffDnxYZJnyG9howjmlMItB7rYbGzrO4krpb4y368uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7uaG8kl; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7uaG8kl"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-3346e75082eso631425eec.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790191529; x=1790796329; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CiWQsjMXoi0YRiE65MHqNy06/bnskB/rrX1YQSVJRbA=;
        b=P7uaG8klmEG63+ayNo9oCk5mtqJC+VLaxVmFncYyPRIR4bhliSOg7j9ygFkXfJUbaE
         nUBYHpqgooIIcv9lhJv5ubvThLJYDJUIXMtyf55e+AKj4tD7/jen7o31DVBBxitr5dFL
         lJrywrG83XP6eETy1dNpwElja4PX3YtsftQH/hyDtvicQu+eLlGltFn9AUKEKwQvZHr5
         1PaiYwudbiouWpz6Jju6vM1tBqrszSdSbdkK5Kxk1LATbkJB9NfbHSYayEHDlE21Yym5
         iq6YY9SADJiiHfYyytdEwtiSm31f9uzcrFn6kInumUg041ycMzhY4oAx52iTsML6eXat
         SEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790191529; x=1790796329;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CiWQsjMXoi0YRiE65MHqNy06/bnskB/rrX1YQSVJRbA=;
        b=QWliKhQfB/+0M7xbg4A36IqJ+/J1eR4fqY2Cdrk6NA+0lpCuXSQ2cHjJc4s3DSm2Yt
         eXw2/PHZpeWrqxk3mXk4Y/ypLovLFEiUxh5RtEZSUlvGcJADzD5pJU5C6dsRv53/4Kon
         Nhjq05SUUlrUFxjdrF/Ax9bfniDFURJ2yrwkONQOYiF9cLzmaPMWwOf2sVpAy/2/JsSt
         1ynAScXwzJkCTU9Wz87yoCGEXJviUNZPRD7a5+QgLIyPMRH0zYB7JEM2WE4P9CbRWFrQ
         A6njKf8arpuk22C+Q/z4801tAHRJunpTChZzSP9fzu7JlHxTIBX4BOsdrFTSYcXcwiuc
         LDvQ==
X-Forwarded-Encrypted: i=1; AKwUvBzSf8q9pY+hwBEOeHSXxw4XTMTeEN6BUAh38UzYkxHes0X7YdiafnC5Tpe16imFiXlul5w=@vger.kernel.org
X-Gm-Message-State: AFuF++mMpW9+lk9KkMArE16ZnoFCdfI8WqGYzh9l3IXGe6ZSh3Mrbm/r
	cVxjx9tfoWMukdNFXLnqmTmUsvRz06TxFO13/ctgfgsYhnXJKRP9CGS7
X-Gm-Gg: AYBFou1tcMUQ8vVCrShqV4ziNj7dD7V7xsK5/Y1H89yZkcyaVYoag86oyb20085ZEaw
	CgBZmtvAR9e3sy56Q4iubJ4ipmNsR9jvrQ1SZ57jNV0N5gZBkJgxWlOCFwO5Hxm8QTmLkBnF9KC
	BS3VepzWYUoHzoXh/hBGocmdo9I82n/q58KtgiSUJJtAyd/eg54p9i4t/xzzOjL2SC7gyjXN2Wm
	i37LQRghfoN2IXc26M2vKrItcvEe+YCmGLYIKNZ0+XZVLj2N8c/dQ67zLr6aFk+2RuP/rgekwuE
	nVLzNEuOidvG73rxaD6M4smlm7NeJE4BP5EfClK0TnOsGknwl9phvTKdHr+7/1X8fXurPwZvTYn
	OAXnfp/f03ZSkcazY7RZtyLJq6yervkBvkA+i64xP0cTgEx8Xuy8PDDRN+rvKaA/vFGHYf3MRLU
	4krAvmwRtJhONs+pxGkNgPuDKQQgMgnvd14m3DJCTtwZJ7A4nY2Bb+SWvnDa4tFLA/EygGSTWio
	dHmv3mbZkZPilppcHHiJE4K3nrEFrJ+EK/IRU5xsIrJMqJ2qynA8VBxGQ==
X-Received: by 2002:a05:7301:dcd:b0:33a:f8c8:1d47 with SMTP id 5a478bee46e88-34000d307bdmr120348eec.28.1790191528874;
        Wed, 23 Sep 2026 12:25:28 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:179a:a128:9d0d:40be? ([2620:10d:c090:500::5:48f8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdd91sm8262785eec.4.2026.09.23.12.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:25:28 -0700 (PDT)
Message-ID: <bf3b8f47ed3f5ce92e4c80f0830c4f3fa07c48db.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 06/21] bpf: Make exception landing pads
 reachable in the CFG
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Wed, 23 Sep 2026 12:25:27 -0700
In-Reply-To: <20260923045917.2417421-1-yonghong.song@linux.dev>
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
	 <20260923045917.2417421-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-22 at 21:59 -0700, Yonghong Song wrote:

...

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 44ecdc5b4ec2..9d44a7dafe5f 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

...

> @@ -397,6 +406,13 @@ bool bpf_stack_slot_alive(struct bpf_verifier_env *e=
nv, u32 frameno, u32 half_sp
>  		alive =3D bpf_calls_callback(env, callsite)
>  			? is_live_before(instance, callsite, rel, half_spi)
>  			: is_live_before(instance, callsite + 1, rel, half_spi);
> +
> +		if (!alive && unlikely(env->cleanup_info_cnt)) {
> +			int pad =3D bpf_exc_pad_of_call(env, callsite);
> +
> +			if (pad >=3D 0)
> +				alive =3D is_live_before(instance, pad, rel, half_spi);
> +		}

Why is this hunk necessary?
If bpf_insn_succ correctly traverses call successors including the
landing pad the information should already be accounted for by the
is_live_before(instance, callsite, rel, half_spi).

>  		if (alive)
>  			return true;
>  	}
