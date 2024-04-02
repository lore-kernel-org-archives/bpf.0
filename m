Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4AE2581
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 04:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712032905; cv=none; b=SYDJSWIbid/ZITU2Aghx2Q7AM/bKCpMl6nW3Db4eCwa0LiO+WHs5ECX//USHUvLlZN4SjGZH+PAXaQQkJ2XNDNQPuVtDL9jTnGDy69cGmqsZ6eO5nB6pj2fHSz7ITgsMn7+F4oHLOknnkHxz9mEYGAe1z+9SiwVWAi+BP98rf7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712032905; c=relaxed/simple;
	bh=rIak6zYrw4Id+aP9gIkUhm0e4bwdvpZqh+Mu/Oc9i74=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CuNoOTnFqCrSSUv/XiwtzmP+A42jXm3I9PfqbFLTtuQh8IPxRl74lSsVxHrTiMm1NTlpYtlKJXeQPdo5nCTsOPOq/tBvl12zAC8NLvq8h1tyxtuBNIS4D+hU51ttk+PiDop8E3mM2xFjnR8Q7H0ov/9nDGhfc+IVSxIUPcRfjhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctn2oXmo; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctn2oXmo"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so3281978a12.1
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 21:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712032903; x=1712637703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75NFK63v/HA7la/o9BnR/bO9wWDIVb5qK4vGe9xDFNI=;
        b=ctn2oXmo8yf3CJljQ7yffsLzg1XF65fBj67+yzr8Kp+sNIQ5znGw8yI/4zFVmI5ztp
         BIIrb7+LngDUw/VjVUKDJXT2+esNgNF7Y0FIgsXKH2UBwr+5bQTJ0yx0V4u3UoKq+HD8
         v1CD4H/jjwkHqLRxDduVgZZCmC5qCkqRyZ6PJFR1XVIWquZAgf9O/MMLhk1/UfdzXPqB
         I1hD9gspBX/+DZ52cbl2SPkMC1kNMYyHwZQZdWM8iWkHEGzd98p7OZm6WrVVTxkf9Xuz
         QqkIq/iwIgirFJLYQGg2G79XqjHnUr8JPcdaNpS+S21vEO6N/aJmQ8uDk9pTM6MIsgd2
         2Zqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712032903; x=1712637703;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=75NFK63v/HA7la/o9BnR/bO9wWDIVb5qK4vGe9xDFNI=;
        b=SWeoem5nJ0Jq+9rZuQGBpKN1nUgp3m7P16k9zbMoRwG6xS5RktfRr3ZAozx26pv7ay
         pQJMdu0NLbm0RIWETOn/Z5sAmn9BkSDLgNnHS2kAx9eb94Df+lHONJ8DPvuejVhhbyME
         ffAuzhkh30Yol67YzpnC9MrqFgM/cfqhwH3BJnH2xefS1NtG3UPXBgJe+c08AMpGqUpI
         J7Ik883uEb6NZ26LR6nsTcDN3wp4HyB6qzVXVLQH1KPZjNe3ubyrdHbNNPG8XUSXalWA
         64I/4Ml1QGPw+yf6gQMt4kOJLqsSR4/lQQO8eCzc3sL2dsGLitNWuLoIcDwPn8dUG8wD
         6qdw==
X-Forwarded-Encrypted: i=1; AJvYcCXomCRyfYIXWxcGNlCx9l8yAg/7xzK3ufU0HPJA+s/Xi6Cat/AVPVLpadLVg0m13+1TOXSqNH74QMxmblWpbVHN+8b5
X-Gm-Message-State: AOJu0Ywc6QpdAi7j0UGCkp1xR26JGlTxV/WwPBgWpEhzVSWaU5qa7syY
	j862spGr7l8nz/HTOQ4bTA4U9U6M8cbDpyvnJE8tg51cAzVQhX1D
X-Google-Smtp-Source: AGHT+IH839f1/iAyT/nCm+mWULClAduLCto9Hq60SseEXDFGoQPsrcSxpm4uy9YRVM0Gjvx9sV5PLA==
X-Received: by 2002:a17:903:238e:b0:1e0:1174:6360 with SMTP id v14-20020a170903238e00b001e011746360mr13846182plh.14.1712032903119;
        Mon, 01 Apr 2024 21:41:43 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b001e0937a77e8sm9834731plr.200.2024.04.01.21.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 21:41:42 -0700 (PDT)
Date: Mon, 01 Apr 2024 21:41:41 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 bpf@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 martin.lau@kernel.org
Cc: andrii@kernel.org, 
 kernel-team@meta.com
Message-ID: <660b8c85c237a_1a1402084c@john.notmuch>
In-Reply-To: <20240402021307.1012571-3-andrii@kernel.org>
References: <20240402021307.1012571-1-andrii@kernel.org>
 <20240402021307.1012571-3-andrii@kernel.org>
Subject: RE: [PATCH v2 bpf-next 2/4] bpf: inline bpf_get_smp_processor_id()
 helper
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Andrii Nakryiko wrote:
> If BPF JIT supports per-CPU MOV instruction, inline bpf_get_smp_processor_id()
> to eliminate unnecessary function calls.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/verifier.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index edb650667f44..af0274b090bb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20072,6 +20072,30 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>  			goto next_insn;
>  		}
>  
> +#ifdef CONFIG_X86_64
> +		/* Implement bpf_get_smp_processor_id() inline. */
> +		if (insn->imm == BPF_FUNC_get_smp_processor_id &&
> +		    prog->jit_requested && bpf_jit_supports_percpu_insn()) {
> +			/* BPF_FUNC_get_smp_processor_id inlining is an
> +			 * optimization, so if pcpu_hot.cpu_number is ever
> +			 * changed in some incompatible and hard to support
> +			 * way, it's fine to back out this inlining logic
> +			 */
> +			insn_buf[0] = BPF_MOV32_IMM(BPF_REG_0, (u32)(unsigned long)&pcpu_hot.cpu_number);
> +			insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
> +			insn_buf[2] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0);
> +			cnt = 3;
> +
> +			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> +			if (!new_prog)
> +				return -ENOMEM;
> +
> +			delta    += cnt - 1;
> +			env->prog = prog = new_prog;
> +			insn      = new_prog->insnsi + i + delta;
> +			goto next_insn;
> +		}
> +#endif
>  		/* Implement bpf_get_func_arg inline. */
>  		if (prog_type == BPF_PROG_TYPE_TRACING &&
>  		    insn->imm == BPF_FUNC_get_func_arg) {
> -- 
> 2.43.0
> 
> 

Acked-by: John Fastabend <john.fastabend@gmail.com>
