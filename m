Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408634582D8
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 11:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785326179; cv=none; b=DtdYk9hslLL2g4MYKo+iAG1hoCCYhpXD51PoFiY1GgfK7mm0pwrVsEXKqh0OcZoFg7bC2LQBnDoc3AmIYdKNNnRK4ngEKywVqA006Ge1SmRZmzs0Bcrmyqk/5mB1+1kbCoVmejyqLHGxwzN4nmreGh18gNiZi+k4p2S1Q9ET13Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785326179; c=relaxed/simple;
	bh=dtkEE7sRF9pw6kru2FtkcfOc9pr2W80RbCzLfaIZzy4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVs2aMPgHlqHs8+OlR0u1j/1+hFFMb0l5xB6I7FW8OYpJhFB0iGoTK/O9u13cgfRrF6W6/0QcSs7k0A6xrSJ11h8Epacy54yt+siCjI+EVm02VWTrRFxAUljrcqxlb9enlIyi5cHt5ob/1sR5XOumviB85tz0eJac4Qiw27L61w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r6aTgR9U; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6aTgR9U"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47640541585so657247f8f.1
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 04:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785326176; x=1785930976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xxSPeR/qOCWC5IaIobtTnOVkK5MQEeMxfQBafeblzVU=;
        b=r6aTgR9UR3N8KBJq3/67IB103kjazuUHwsqfrnWjf60q0b7/B8oD80WTv6zuJfxd58
         OKaziHFS4bQshjUonHdBFnYlTr5Rv5/zS6E+gfyGnzGQyjx969c62yHvo48BIvuel3Aq
         WP1Ztda+EygDSS9SDSVkx5t6sgHiXEIMcZM9Vx8fhlJkcotNpCcDdjX7njrU0pXHr8UP
         4eHNB3//7Tpas7eTd6H0U8Ysiw2Ni/3ewzmc/egrw9jGiV7vHK8OcUebcL4ZNhFojTSQ
         lzhPCQkmOuubFNDoVBie8kHnZJ7/QosBTaJ1EJIc73Qnf9ySnXEyOX0p0hCEvgwqE9xZ
         6/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785326176; x=1785930976;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xxSPeR/qOCWC5IaIobtTnOVkK5MQEeMxfQBafeblzVU=;
        b=G44NBFDeOwwHppRFhUuM58PryRtQvb7p5ehXFmKKHszXMR2t3S+cdiqCidR/DyFMFI
         sU/jd5rGwycWxHdl+tmUgYoOIlelepq1SMrSg08LaJA+s11lxTUdMZ5l1dd0S989oENf
         1xv9NGUkAJOvYh0PjD0ngQyHp/h2ODtw+YeWQzVP9B+fqmhn44LdEEpBQ8FUkZOVC21R
         5+9vu4LMYw0/2cVPUDhcqG2qRLGwbOuDIV6sj6u387UTcR5khBN3NBb2+rIQmvAkoaCW
         ps+w63tNaJp6jLo4zW3di0jYPrrf7G82t1gTYGp+Iw38URJ0tGDtzdtOu2avSQwyRHdK
         oEyg==
X-Forwarded-Encrypted: i=1; AHgh+RrPv/CEHTNh9Ap11Rup9Vj3EkuWzWiSDa7FAIUfJeO2nmD0Q6FwVw9+FMdbRCs4cDYnlkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDIlLg+YxDKfkAxlaat8SdOH5VSez0SSefj+uJ4MMwCgiFtFyv
	TVjT5A6ShIeM11yl0VhmzOdwaFSpZg8x6b/pnyN5Lss9tHQwapcwAq5g
X-Gm-Gg: AR+sD12OSbXCHahJpm2zAj6iJNIUmWli/hQ7Qq6xAuIl+xgE49PC1NnSW6Bf6pcfOJ6
	k5z3/PwYrC5DnGGghOpZlwnAK0hT8SdKMXEAJN7EjGDLOQigNZKt4e9s4SPgCnBFhy9kGFVrH7s
	BrbPJYdXJF9Hycm2tVgsL8Cyk/tufenzLYaDelNPz1kHgEYUrR3ac03+s1zas4tCEnhAlFWp6WH
	z0UBrJClMy+9DvWyvkwC0ylFZrjw5xzmET1AQOjI+cosrfOCGxZmRcQvF/OvIRoej8Ri7zdXpYH
	TOZKmVMNvLVIFoTGynm0fnsaJCQTkzpO7AmbS5Wrane7o6Ek7YgNogK4aTRq/JMZSdFhuJdFBvu
	Px/YSy+1phfdGm9WVrVSBo4ZgIGfd/H56bG3JDgyp/aCBGprdjgAIN4WbAGLcqz/WIri3IK5qW4
	D4gFiO7joUq7osKHsf+5enUA8X04pF+dXr6FQ=
X-Received: by 2002:a5d:584c:0:b0:47f:7759:89df with SMTP id ffacd0b85a97d-47fb1ecaf73mr7057660f8f.3.1785326176317;
        Wed, 29 Jul 2026 04:56:16 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::dd7e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6aa3a94sm7531659f8f.8.2026.07.29.04.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 04:56:15 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 29 Jul 2026 13:56:13 +0200
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: ftrace: enable single ftrace_ops for direct
 calls
Message-ID: <amnqXeC6D4mjcAe_@krava>
References: <20260727142844.21212-1-leon.hwang@linux.dev>
 <20260727142844.21212-2-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727142844.21212-2-leon.hwang@linux.dev>

On Mon, Jul 27, 2026 at 10:28:43PM +0800, Leon Hwang wrote:
> The BPF tracing multi link updates several direct-call sites through one
> ftrace_ops. Its implementation is therefore gated by
> HAVE_SINGLE_FTRACE_DIRECT_OPS in addition to
> DYNAMIC_FTRACE_WITH_DIRECT_CALLS.
> 
> Select HAVE_SINGLE_FTRACE_DIRECT_OPS whenever arm64 enables dynamic ftrace
> direct calls. This enables BPF tracing multi links on arm64. Also
> generalize the unreachable-trampoline comment because the single-ops path
> does not use ops->direct_call.

hi,
iirc arm needs ops->direct_call for trampolines to work properly,
that's the reason we enabled single ftrace_ops on x86 only:

  424f6a361096 bpf,x86: Use single ftrace_ops for direct calls

I don't understand the arm usage of op->direct_call, but it looks like
(codex thinks) that the fast path won't always work without op->direct_call
being set

from arch/arm64/kernel/entry-ftrace.S:

	#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
		/*
		 * If the op has a direct call, handle it immediately without
		 * saving/restoring registers.
		 */
		ldr     x17, [x11, #FTRACE_OPS_DIRECT_CALL]             // op->direct_call
		cbnz    x17, ftrace_caller_direct
	#endif
	#endif

jirka
