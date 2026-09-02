Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACA3384223
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788371052; cv=none; b=WRIwgBkVR3JEafmzBMYd+O2gwBiwAyJ/M2N/igC4iVU+OuQr3/e1JtEEEka0piDHizc9sJsNfof7hy8NuXZKiL1X3Gnj2rpxKT08SD+m/wp/5UO6/uLKDECgxx/t9xXzho7QxBRBKoRrpuGB6BjkK7aYnGT0M9F47cFkzbNx9Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788371052; c=relaxed/simple;
	bh=G8wMgq2nSR8Fl0JJMr4B2VdtYL8+PSHoMAC2VrivoiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIzyQlegTvQk6ETgqoAIGj0MSatHeCNWX9LoEX4O4gcF2u/96wIz5/SRW7IheDuQw95/aNgTFz1fAXCqR9fy87UIHozOUhpiECkv4XvSCErSWjrpD5n2ObuAI1lbUM9lS+YdakXjKzzC9McttomI8LWzfqcoYkhHIeApWI9tQyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VC+taTUM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VC+taTUM"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49ccfae359fso9608545e9.3
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 10:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788371048; x=1788975848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DQacv49RtMVghFLXJ51GmvUcnj1/bc8hpPJBQv3jwbw=;
        b=VC+taTUMm0PkuLwW8UF8MxIdu8gpsOA+cz4LLZCAp+Q8ES/5AeyJOUTO4TIdt/ntbl
         yUF84BsI8GnEt8wPDGv2ZEMkaV+5VAXLTWnIUtbPyOglg+CMkaw1hHU+oeKlKoWIZVgS
         P7B+ebk7+EcjCDkIXv9rd58pGy8bNhCL9SdvbbVI1ClpLN6isG3dFKHl3YvTqIUDx/Z2
         OvnFlzJlRqV31kDRTtws4VHx7WUYkT9w9KTwbaJ0wajRKDBrlGuaFxPQfl7KLdrMPtSJ
         p0UxuJd+EIZA7SrTNEuEDX8HqdTG9n9Vn0fQwkuWcJ1Vw6erQCvUi0lEGv5mws3T2CWJ
         02mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788371048; x=1788975848;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DQacv49RtMVghFLXJ51GmvUcnj1/bc8hpPJBQv3jwbw=;
        b=nl3FE/xRPLFjivgNoKKzikyCMg5aKJcaoQjrdqjGPVxZ47ghQkfsrQXtgxdbf0Py8I
         ZUfCvfCjhqzbkyBHcbqf14QVNyd87sAf59D69mB+BXSJU/1wNVz/DfQUPaMBuk3JDSGT
         Yb5FxsuWRLOxtwK4bSH+N6Qm6UAtMqQk7W36S+cuSJd7GXKSwTLDDNejNnbSsM+odz9j
         XYC3Z7TDoBxcrNjZMnWTi3BZUqNs60+KTChvSHUkMC4f4qClosXylyEcjz8NtwsY4pcB
         brYCrlGaDNwkEYJnrKzQSjbZmWRP8Q8yE0RTiDimimwz1mBHhCDK+3sYU8ghWprK0PLF
         HwaA==
X-Gm-Message-State: AFuF++kPQ5zlD9ew1u0RCM/3E81+0mupwDg1c4eMqAyRQoHmKMHUJ+os
	v7h6xaXfsh/OJ3US1nmwvsEi6ZIwvqWTWnHMWrVJbuqUgTM0niYpoY/np5dUgw==
X-Gm-Gg: AR+sD12V/uA5AvbvLp5S/75CQoX7rznn4xlf9wkP/2KyUrF6TW2BJ0ES0oaU9fsFtJd
	wgmvs/nomRI/p4elBZHa/3A6zMNNtUyEuEimgyAjaTptKpEb4ORVXDumcSd4gzInGaS/H0bYb74
	PdBsNdINp+8pBmdBW69BtIZ01eiw/kvOEzc2pWZIxlbZjes1CCVSqP/rA+W/G7HZVZxiVKBhDkx
	JyWpdDhaSX55zWPSG058dBYjsp0t6RJMUdrXyCrFE7Rg2nNWjRgcqpc5aqFRKpPVWxwTc2VsFnw
	WPdHb+/IZ9EVcfT6vq235GcXMnjhTKB9NWw99Ey1Nc3Oq44Fm6j5ohBBR78UZtwxSbHPM57m/aR
	v5YZW5K1ulFzkXSKlZKvCooHUgWnidpJOw5hGhhe8hfnUVh2tc+8kXtz9z2Hv1muMamfBKMFfoh
	7EMM9zmUUZAkHwuodSwhkY2eR4t6wZiGNQ9sBrRL/SJWbyxh8ZLN8X7V5tigLDoOBYBIXS
X-Received: by 2002:a05:600c:3486:b0:499:8704:242c with SMTP id 5b1f17b1804b1-49ce5591a08mr133530575e9.0.1788371047966;
        Wed, 02 Sep 2026 10:44:07 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed3840sm8090720f8f.17.2026.09.02.10.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 10:44:07 -0700 (PDT)
Date: Wed, 2 Sep 2026 17:54:42 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>, rlmenge@gmail.com,
	hargar@linux.microsoft.com, apais@microsoft.com
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Test terminal gotox
 instructions
Message-ID: <aphi4iQuJjowULO9@mail.gmail.com>
References: <20260902171414.96165-1-sidchintamaneni@gmail.com>
 <20260902171414.96165-2-sidchintamaneni@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902171414.96165-2-sidchintamaneni@gmail.com>

On 26/09/02 05:14PM, Siddharth Chintamaneni wrote:
> Add tests that place gotox at the end of the main program and a
> subprogram, with each jump-table target preceding the gotox instruction.
> This tests gotox as a valid non-fallthrough terminal instruction.
> 
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> ---
>  .../selftests/bpf/progs/verifier_gotox.c      | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
> index 5b18c9a27717..0e27c2c79c57 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
> @@ -47,6 +47,54 @@ DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_src_reg,      BPF_REG_1, 0, 0, __fa
>  DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_non_zero_off, BPF_REG_0, 1, 0, __failure __msg("BPF_JA|BPF_X uses reserved fields"))
>  DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_non_zero_imm, BPF_REG_0, 0, 1, __failure __msg("BPF_JA|BPF_X uses reserved fields"))
>  
> +#define DEFINE_TERMINAL_GOTOX_PROG(NAME, BASE)			\
> +	__naked void NAME(void)					\
> +	{							\
> +	asm volatile ("						\
> +	.pushsection .jumptables,\"\",@progbits;		\
> +jt0_%=:							\
> +	.quad ret0_%= - " BASE ";				\
> +	.size jt0_%=, 8;					\
> +	.global jt0_%=;						\
> +	.popsection;						\
> +								\
> +	r0 = jt0_%= ll;						\
> +	r0 = *(u64 *)(r0 + 0);					\
> +	goto end_%=;						\
> +ret0_%=:							\
> +	r0 = 0;							\
> +	exit;							\
> +end_%=:							\
> +	.8byte %[gotox_r0];					\
> +"	:							\
> +	: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X,	\
> +					    BPF_REG_0, 0, 0, 0))	\
> +	: __clobber_all);					\
> +	}
> +
> +SEC("socket")
> +__success __retval(0)
> +DEFINE_TERMINAL_GOTOX_PROG(jump_table_terminal_gotox, "socket")
> +
> +static __noinline __used
> +DEFINE_TERMINAL_GOTOX_PROG(terminal_gotox_subprog1, ".text")
> +
> +static __noinline __used int terminal_gotox_subprog2(void)
> +{
> +	return 0;
> +}

TBH, I was thinking about

  DEFINE_TERMINAL_GOTOX_PROG(terminal_gotox_subprog1, ".text")
  DEFINE_TERMINAL_GOTOX_PROG(terminal_gotox_subprog2, ".text")

such that one shouldn't think in which order subprogs are added.
But your variant should work.

Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>

> +SEC("socket")
> +__success __retval(0)
> +__naked void jump_table_terminal_gotox_subprog(void)
> +{
> +	asm volatile ("						\
> +	call terminal_gotox_subprog1;				\
> +	call terminal_gotox_subprog2;				\
> +	exit;							\
> +"	::: __clobber_all);
> +}
> +
>  /*
>   * Gotox is forbidden when there is no jump table loaded
>   * which points to the sub-function where the gotox is used
> -- 
> 2.43.0
> 
