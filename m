Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205A841D10A
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736946; cv=none; b=h6OSs5vM2YXXP4ZfuBQQ8fbCGsYR0hBIGy/AtM9vBawyle7S71ZJYZJ7skv2g7/VjkOF+WkzQ4e4z1XbpLhPKKA3eoQLWv5TbDQdouMVwUPgGjqu9iZu8Q/eUZabByf0xY5x3J77aVSNZg6L4AL81HVDZ/B8FVaOWVBgO81L/qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736946; c=relaxed/simple;
	bh=1IoInKMtTcNSLUaNWkb/T8Ke1sRGwPsNpUo6zRC1wvY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=cXzP9PVLDnF1VDn+kQU2UjQLfGXuPNXmbykXrToBHAaGQ62g8piCMgsCUTNarglcICv5YaRxERcIELwDuX2qLKz4kIS25Xuku8j4aDZcSitOIrynBlE/PDBkiufRijZglOCST8qYnPMSqfEwutV6EZiQC9VzPaWhtA2HbqsojDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=06tvMb1a; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="06tvMb1a"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so13006810b3a.3
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 09:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784736944; x=1785341744; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HMzhLup4kjBXbK6v7v+gTHnOK3sPPpgIkSbzcafyu3k=;
        b=06tvMb1aHz2/ONXPigSaBafsRPvZcM0/9XpD1jP2k8obmyL2ujaOboxWtjlAUs+869
         +dHJuODBq/lrlShdItzRGio3eW9Q0OlAhWgAh8s+95HzPG/s4uxYG3e8qeuyVycGOQq2
         ietsbuHZOgv1UmorFMEmOkWwUuXdjmlXWgOi9pIOIDaLnQlHw4AHD/LgSzApp0V5pTwV
         2AF2Emcis6Lvfoe5mOre6kc8d4UFGNwQk9vgL8lSqMa4HaqlF6PXAEohyC1xnA6sYR9n
         R9G2LyZyUAqECZeq+9Az6Vw/VqIVJmgATNBbOG8dJi747KkRGu1paQHuUFrQAPnfkM6X
         tHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784736944; x=1785341744;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HMzhLup4kjBXbK6v7v+gTHnOK3sPPpgIkSbzcafyu3k=;
        b=lhNY4je1kC2OmtgdZIPQc75Otet8iTQnjJ8yELuWPFqg4Hz4YR7wuaes4E5K1k+jQ5
         GN51w9fsbpdlaNmTihKCQa4C97xNWcQYetVzliu+QyZBnDicFlZ1X7Ob7xtt6lI+wg2G
         YQ4sYdaOYbnp7Tcn/1Q3M3QPGZ8mb3OaqX3P6o1miGxT6uLFvqxarhx6NzwjgguDiovp
         ZhO6lafqKnJFgEP8gQ2svA9VxECXuiAuBLIYz4RXovfW0d+CiTWHCKfN7ooY+C/nthz0
         /7dsiDnx5431+sSm5ylc+vgPpqrHEVufX1ZCt57Dz8w6F0QblMxpUiWiPkPHioz7/LG3
         Ct+w==
X-Forwarded-Encrypted: i=1; AHgh+Rp8tralxzpX7ynmpBVBj/fM4gk/L6Jo5sSiL3hICOfODBSNMqFsFfugit4F8JmDs7tXLww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcJ0LZTTDr7taxxuflreCfJ5MF4DwyGr6sfCb4/RXKyZ2T0WNk
	reKHrxmScWXlDBru2TOp7pyoxs1P49ujGeUFAuzYEe8D7+dYPCEIZ/6dsX/WoHiMW2vPmqli7o+
	UPOC6v0aWCw==
X-Gm-Gg: AR+sD130w/zj7DZ05y/Thpnn5KovYS0itUV+GBZLh60Jt+jf0ON/rPujPvWKu4GwAXj
	2CHlsTbuypZK7cWGntmfCZORV1mmjHC3raT0Jg15Fm5D/twPeYFokcR5YkVCzAnGKhRSwClW3tZ
	7YLROSrRcQFKChqMzm7gHQmHcijfdiwjbqi7JC+4BVizMCUt++fouQKB1aMb/5fg9sRft5s9MeG
	6xb56HZHf2ErvQ3pM3024cTgwCLPvUyegv3hXTcjS0AQr9mwOCRgGz/DkEAoooCc0xhrENmE6Sx
	J7fG/bUTT124WooQVpbyfjtKgV9vpdvz9M9F+HKfQZ691JLG03tuMI4wPDL5JDrig8uabRji24N
	1TVLFMc5x6pMio3A+dIsIsk8cyxwjWT6lviW8hF0yFlIL7eQW5OfIAy3J6GHTkB27PxCIhsvi6x
	p8mFilm6CI4nMxlJTJjE4R045UTgME8H3LPGomhOQ1YQ==
X-Received: by 2002:a05:6a00:2290:b0:848:5f4f:289a with SMTP id d2e1a72fcca58-84c294d4c4cmr24855398b3a.49.1784736944070;
        Wed, 22 Jul 2026 09:15:44 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17262d9csm1677075b3a.13.2026.07.22.09.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 09:15:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Jul 2026 12:15:41 -0400
Message-Id: <DK58G071F9ED.9JGWJNCGU6BJ@etsalapatis.com>
Subject: Re: [PATCH bpf-next v3] libarena: Use compiler
 load-acquire/store-release in bpf_atomic.h
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260722141003.2841007-1-puranjay@kernel.org>
In-Reply-To: <20260722141003.2841007-1-puranjay@kernel.org>

On Wed Jul 22, 2026 at 10:10 AM EDT, Puranjay Mohan wrote:
> Teach libarena's BPF atomic primitives to use compiler builtins for
> load-acquire and store-release when Clang advertises
> __BPF_FEATURE_LOAD_ACQ_STORE_REL. Older compilers continue to use the
> existing barrier-based fallback.
>
> Notably, as BPF programs begin running on arm64, it is better to use the
> more appropriate variants since we can no longer rely on x86 TSO ordering=
.
>
> Commit 880442305a39 ("bpf: Introduce load-acquire and store-release instr=
uctions")
> introduced support, hence kernels from 6.15 onwards are needed when
> compiling with compilers supporting these instructions. We have
> relatively recent kernel version requirements in libarena anyway, and
> have not cut first release, hence declare such a dependency.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>
> Changelog:
> v2: https://lore.kernel.org/bpf/20260722130939.3991397-1-puranjay@kernel.=
org/
> Changes in v3:
> - Use consistent ({  }) for multi-line macros
>
> v1: https://lore.kernel.org/bpf/20260721185705.1365329-1-memxor@gmail.com=
/
> Changes in v2:
> - Use __BPF_FEATURE_LOAD_ACQ_STORE_REL directly for guard.
> - Use __unqual_typeof
>
> ---
>  .../bpf/libarena/include/bpf_atomic.h         | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h b/=
tools/testing/selftests/bpf/libarena/include/bpf_atomic.h
> index b7b2304319295..43c306e17f198 100644
> --- a/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h
> +++ b/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h
> @@ -86,6 +86,25 @@ extern bool CONFIG_X86_64 __kconfig __weak;
>  /* Control dependency provides LOAD->STORE, provide LOAD->LOAD */
>  #define smp_acquire__after_ctrl_dep() ({ smp_rmb(); })
> =20
> +#if defined(__BPF_FEATURE_LOAD_ACQ_STORE_REL)
> +/*
> + * Clang advertises this feature when it can lower acquire/release atomi=
c
> + * builtins to BPF_LOAD_ACQ/BPF_STORE_REL. Older compilers keep using th=
e
> + * barrier-based fallback below. The generated instructions require kern=
el
> + * verifier/JIT support added in Linux 6.15; compile for an older BPF CP=
U to
> + * keep using the fallback when targeting older kernels.
> + */
> +#define smp_load_acquire(p)								\
> +	({										\
> +		__unqual_typeof(*(p)) ___p1 =3D __atomic_load_n((p), __ATOMIC_ACQUIRE)=
;	\
> +		(typeof(*(p)))___p1;							\
> +	})
> +
> +#define smp_store_release(p, val)							\
> +	({										\
> +		__atomic_store_n((p), (val), __ATOMIC_RELEASE);				\
> +	})
> +#else
>  #define smp_load_acquire(p)                                  \
>  	({                                                   \
>  		__unqual_typeof(*(p)) __v =3D READ_ONCE(*(p)); \
> @@ -102,6 +121,7 @@ extern bool CONFIG_X86_64 __kconfig __weak;
>  		barrier();             \
>  		WRITE_ONCE(*(p), val); \
>  	})
> +#endif
> =20
>  #define smp_cond_load_relaxed_label(p, cond_expr, label)                =
\
>  	({                                                              \
>
> base-commit: a23a71823352e2d792dcaae25f1ebb744acbfc0b

