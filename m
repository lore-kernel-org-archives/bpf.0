Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A1B34CFC3
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727887; cv=none; b=ZKBqFpBm1lAA5HmEylgOo2nnl8EhoTjJgKrWQ1DNPFLWbGA4UetzlFEWDxPB2memrflYNX7Dh/SQ9R4fmH0RqmaWeWBoNeoM3deFnct1UqSSnQs7mH/QipSR5MSPhRflfpeXAzjqH5qo7rW3s5ej7gUadMg3NWBcrFNSpsXAbsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727887; c=relaxed/simple;
	bh=Nr9AFMW1F9Zfj1BjSTYs5HhdpOZuKJbvHOH7hoOoc9g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nJMoTvUr4SDiANpTjZxbYZ7UO5u6s7fPqdcKYQU0zmAeNGchBs4B/vP3EbCLmJoGMAsbpaR40msEmHG3cf1R29s8KlWxAxrzKzypPWZ+N8ERePhauyCevl+xKATHsizI1fCA+pYiu3038i18c6cBW7yzX2JeTO+/594gBIpI5ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCenV1eP; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCenV1eP"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-46e747fbf36so5317796f8f.0
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 06:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784727884; x=1785332684; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h/AqJUd334OFikdmqIsCTmouMQqxViVQz6aaf+tD2u4=;
        b=aCenV1ePKYTpPfM/elWbb9dLksUNpmYmpxRv6v9GgpikilQcFN/8Ext8iAKB9ml10q
         rvzSD5XnshRfRNDDP2sehbnvwERJHFrSLcJTncCegJOKuLthOaMLuhdImym0163tGREH
         m/UIItJbMkZASCa0grEPuUXwReqGwKFKpvFaeTT8/bae4GV0xWKT/7HQi5hzCxsQgu2f
         QG75dsQvMb8zmSnWtMFYa+8tz2d3MGXCI38In8a/E9ZoJhwqGqIRiq7tPeNJMIi2rxfN
         QvsTAqUzuQxADkWwPIOBbXt0z7O7RckD1eeWdJszDG/Yu8dCH8kGKHVCZXlzSfVZmktJ
         OjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784727884; x=1785332684;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h/AqJUd334OFikdmqIsCTmouMQqxViVQz6aaf+tD2u4=;
        b=qe4NFf2i2FfYBeZTDo2k6S5xA1/jIC+7wWwNDL3ZrqmmdH7rrtAgJRSF4c/GPKZ87M
         cDZJlSnlcFNTF7OngL1/iGDJUzsXQ9W3NlFEhwDiuWMVKyaZPqGTwRnzfbQMKybcAo8X
         OqJ+J0ywpJKtagmxm1bXvyXO2QhUAIT/4UenIUDhkGZU0jP6p1u9Tjyh5iQrQ89vT4oV
         xEvIv8n1a/Sey8XESYTA1tkodX1zoCiUCsz+zr5TsPi9jr8A6hurcGMrQGQMXQNms5DT
         qRg4MC+PrQc+Tm6NPi3Rjfx6o1ZishbxxsuzeGhzjz4nErGo8xy+kDuhc8JWENoHug5N
         DpVw==
X-Forwarded-Encrypted: i=1; AHgh+RryNQSF3MR/2Cc13ASvQA93y71T2Ce61VYdHxElFfSUkj3la4Z1/YoKJGAALbt4UGq738w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7wll63PTpjSwY0r6W95cCLZ/wVO+7yA1WKHUoBgWOMvA44EnU
	S0UR4hNy1cIqOkRZKmIdHjpu30Tb31cX0xTAyKgbp+a2DdPhtl2BDhk4
X-Gm-Gg: AR+sD13weicXptzfHZ51ai+YpxGOUyg0CKG8nr6YRrOYGxduTsVCGhqlI4UaWHK1org
	PHQuTNYBcbqopfYrT0ZxROEj7Bnw8c+Pj1hP4fE4+VnUrNzKa/isXZI4iwgXlDMJFG8G/+C4TEX
	o4XXig5idAtaXV90OTtX+44qdLoyAzAavK5Ud2Gy4zqO42e5nur/i9rCbXp9n0SktdMeHoPzayp
	CW+D27DavGWYKja7rskw+iCLVOPi97Te1zSL42O3tk/HinRncwIQgk2iUTHVqmYUJHMUOwwbiMB
	gKHF7CCrXCZHpz5pMENGWlDTEt0cpWLpE6vVmFmbWexxMofEpGhbZe6kqDdTx90C/xOd+8TRQXv
	6QcJAyUCZhXmItBzgTbEpXDXgCncnhcMK2LlbrSXJOkHrEfOsBkbmUXF1TURD0sg0W4K3IXLZ5S
	NJpl9VflSrvskeiCwwR8RXITL9+DWqEI70FhCj6HRdMLRTbfQYyryYWaBzLcLc7s4pPcwHsmgw6
	xgDcwbb9vuIWRtMyQ2zDwnolJUwozu3K5dHXet9nNxw
X-Received: by 2002:a05:600c:4714:b0:495:3f84:a792 with SMTP id 5b1f17b1804b1-4954a3ed494mr268397025e9.12.1784727883806;
        Wed, 22 Jul 2026 06:44:43 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a5d9sm6038882f8f.5.2026.07.22.06.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:44:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Jul 2026 15:44:42 +0200
Message-Id: <DK558EI3JJPH.27AUFGV91DNKV@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v2] libarena: Use compiler
 load-acquire/store-release in bpf_atomic.h
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260722130939.3991397-1-puranjay@kernel.org>
In-Reply-To: <20260722130939.3991397-1-puranjay@kernel.org>

On Wed Jul 22, 2026 at 3:09 PM CEST, Puranjay Mohan wrote:
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
> ---
>
> Changelog:
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
> index b7b2304319295..4558fa26911f6 100644
> --- a/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h
> +++ b/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h
> @@ -86,6 +86,25 @@ extern bool CONFIG_X86_64 __kconfig __weak;
>  /* Control dependency provides LOAD->STORE, provide LOAD->LOAD */
>  #define smp_acquire__after_ctrl_dep() ({ smp_rmb(); })
>
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
> +	do {										\
> +		__atomic_store_n((p), (val), __ATOMIC_RELEASE);				\
> +	} while (0)

Let's use consistent ({  }) for multi-line macros. Also, per your own sugge=
stion
(and the bot's), wouldn't you want __unqual_typeof() to stash the value for=
 the
store case as well?

pw-bot: cr

> +#else
>  #define smp_load_acquire(p)                                  \
>  	({                                                   \
>  		__unqual_typeof(*(p)) __v =3D READ_ONCE(*(p)); \
> @@ -102,6 +121,7 @@ extern bool CONFIG_X86_64 __kconfig __weak;
>  		barrier();             \
>  		WRITE_ONCE(*(p), val); \
>  	})
> +#endif
>
>  #define smp_cond_load_relaxed_label(p, cond_expr, label)                =
\
>  	({                                                              \
>
> base-commit: a23a71823352e2d792dcaae25f1ebb744acbfc0b

