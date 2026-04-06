Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D633B29CE1
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 01:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775438451; cv=none; b=HX1qHSpg85sxsKbz1+QU3UTjzai0NDhKNDlcmF5lJC8DR7cYQk8KSSUy6yUorOW0VuoPM48ppZP//32/fqOH6Q+dCRf7oP5WoQrDSdXzyWPDuVLLvb317OPrr3t9HtTyhkFyAqSAa5GslvgLN+7DUOW/Z6sQB7pVr5fmZZJTtcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775438451; c=relaxed/simple;
	bh=TIKZs1etRbTQHncFoBNaW1AxYUUWA0lkudbuqGBGOvk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=a4LAxX8tkpiZzGvXU+VDAnbRjD3F/ZUWyd78nA/PK0PthsL5RJ+orAgOdIcchAY5qx/gJKqYQscsIgpLRa8QpXJTAVNNRCmPLnBFmKwr7fcZivcGF0eTtxiRGGgnknzudPv0dKnhji4A4jOV+3sGtbSVEWMZIzqTpoPh794R4lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=u/+cuKop; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="u/+cuKop"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-823c56765fdso1650874b3a.1
        for <bpf@vger.kernel.org>; Sun, 05 Apr 2026 18:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775438449; x=1776043249; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FniGr/JRpR5yNQ70QlQIYgF5Sl5TCr0C+6nCVvymtWo=;
        b=u/+cuKopjYo4LeZMJleKmtxXmyCwXlTHBqXS7iR8HjwQEIUQLW2Zwa1wwzVViDaBuk
         AE7xGPl11XGeLJyr7jqZF5qJOz/xrO7mQZF+gMgd+Ake7dGLmnF8ZsVWzUV00+kqlXqG
         TEmQI/GoOobHuflnAnn799lvUFFRVaOv9GIc7u9yWA3slfgqw6HJMHw+Yz6E30R9cWqP
         700VQ9v8k3Mm1/QoUPf8/ghysOUXnEni8PYpun23usXcBGfP5w9cxt1Z96ZfxBeLnxc5
         rHpRW764AYGEAp2Nz+GYkvLsHrg8MRGQtFmbjmwyCG0sZ94nBy8mEjQRpRut9Enlh7tS
         iKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775438449; x=1776043249;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FniGr/JRpR5yNQ70QlQIYgF5Sl5TCr0C+6nCVvymtWo=;
        b=nDCdoI8QWWoAdJN+cKB0B7s3UcEtw/xsXcxqjTEjQAfqswcuEI7BQrszxHY+8zomzT
         Vkz2jkAw1lbBnh6c8O9S8MpjPWugC7H2AQ0SXqzgH1ZidD7q09W10c0mB+LM/Tt97ifi
         RRnn+kpFLT++GAcyi6BzIoPhhdzbWejmZhw9nJPptUBiRO2zsffUin8WLiVwXVRG0ERf
         IAoeiSm6Dir97i2R7cLhPSaq5+nbqIASIJ211EEWPFBuCTll4FRADb+aEyKvS/WDZyGe
         NpygGvh7M79J9vcovFkgXsVsbq1y3RtkqPIsx0m8jSVK26h+QGUdncamjAR9RLB4fkiO
         56uA==
X-Forwarded-Encrypted: i=1; AJvYcCW1b6Oe59EyN2SZrTnP0cSDdKrNl2V1z/JfWL0cU7QQhrnDE0SVaa/aSH//piOR99F6C90=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFmpua1XEF6TCp0y66+Yeld4pY2cGNSv6Tuf5JGAKkVZnQsR/N
	QYAPZLl+csYJ/NQeoWr27YxkSmOU4LXBuxqTF/lsyruRTY2V6y2j3q6/n77OQQgjfk8=
X-Gm-Gg: AeBDiesPOh50NBb4UX4eNyYRVcFdnZ+fWogWFGlqU2xXo0CveJDHwSPW1a1/fLkEAiz
	cWofPiGK+oISjS1f6aA5iPmac8Jkk9ZNGXHJds/KVL/tG+w5ZZxOLeuIQAe98khgCrawnSq1bS9
	2F726agcFof00aPn9onTblDCHk9C4idyhFUYpluhVpFnZNAynGyW32qvQo0o0uOL1gp5Uri22XD
	ww2lut3bZfzKxzY/6sKDl7Gc88d6AirfnbSnDP+F5dIMqI2H8DUw3m/HyRP2WXM/JyyT0+E/peM
	LZpDb0aSbhOpCLc7bn8mnlVSAfLjpd+jdnQWl+FYARb1tJqvrjkbUV8ynhmcC5iq0/WLloZX3Jm
	uufzi9LGYMSM5sLnvK7xIN7/HfK/FzuT2n4HcSYenW1HtYZs0fS8k8Uxmzc0tu/rIaZR9aUgThH
	7llpKMT7IZePZX2hfCsQ==
X-Received: by 2002:a05:6a00:a0b:b0:827:2c79:fa84 with SMTP id d2e1a72fcca58-82d0da45d27mr9989988b3a.12.1775438448919;
        Sun, 05 Apr 2026 18:20:48 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c68273sm15282685b3a.41.2026.04.05.18.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2026 18:20:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Apr 2026 21:20:47 -0400
Message-Id: <DHLOEJ4M6LWM.FRJ0S8FB354Y@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin
 KaFai Lau" <martin.lau@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Tejun Heo" <tj@kernel.org>, "Dan Schatzberg" <dschatzberg@meta.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v4 3/7] selftests/bpf: Convert ctx tests from
 ASM to C
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260401122818.2240807-1-memxor@gmail.com>
 <20260401122818.2240807-4-memxor@gmail.com>
In-Reply-To: <20260401122818.2240807-4-memxor@gmail.com>

On Wed Apr 1, 2026 at 8:28 AM EDT, Kumar Kartikeya Dwivedi wrote:
> Convert existing tests from ASM to C, in prep for future changes to add
> more comprehensive tests.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  .../selftests/bpf/prog_tests/verifier.c       |  2 +-
>  .../selftests/bpf/progs/verifier_ctx.c        | 78 ++++++++-----------
>  2 files changed, 35 insertions(+), 45 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index bcf01cb4cfe4..0c50a4305292 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -174,7 +174,7 @@ void test_verifier_cgroup_skb(void)           { RUN(v=
erifier_cgroup_skb); }
>  void test_verifier_cgroup_storage(void)       { RUN(verifier_cgroup_stor=
age); }
>  void test_verifier_const(void)                { RUN(verifier_const); }
>  void test_verifier_const_or(void)             { RUN(verifier_const_or); =
}
> -void test_verifier_ctx(void)                  { RUN(verifier_ctx); }
> +void test_verifier_ctx(void)                  { RUN_TESTS(verifier_ctx);=
 }
>  void test_verifier_ctx_sk_msg(void)           { RUN(verifier_ctx_sk_msg)=
; }
>  void test_verifier_d_path(void)               { RUN(verifier_d_path); }
>  void test_verifier_default_trusted_ptr(void)  { RUN_TESTS(verifier_defau=
lt_trusted_ptr); }
> diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx.c b/tools/tes=
ting/selftests/bpf/progs/verifier_ctx.c
> index ae756764ffba..4c285ac8fff6 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_ctx.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_ctx.c
> @@ -295,68 +295,58 @@ padding_access("sk_reuseport", sk_reuseport_md, has=
h, 4);
>  SEC("syscall")
>  __description("syscall: write to ctx with fixed offset")
>  __success
> -__naked void syscall_ctx_fixed_off_write(void)
> +int syscall_ctx_fixed_off_write(void *ctx)
>  {
> -	asm volatile ("					\
> -	r0 =3D 0;						\
> -	*(u32*)(r1 + 0) =3D r0;				\
> -	r1 +=3D 4;					\
> -	*(u32*)(r1 + 0) =3D r0;				\
> -	exit;						\
> -"	::: __clobber_all);
> +	char *p =3D ctx;
> +
> +	*(__u32 *)p =3D 0;
> +	*(__u32 *)(p + 4) =3D 0;
> +	return 0;
>  }
> =20
>  /*
> - * Test that program types without convert_ctx_access can dereference
> - * their ctx pointer after adding a fixed offset. Variable and negative
> - * offsets should still be rejected.
> + * For non-syscall program types without convert_ctx_access, direct ctx
> + * dereference is still allowed after adding a fixed offset, while varia=
ble
> + * and negative direct accesses reject.
> + *
> + * Passing ctx as a helper or kfunc memory argument is only permitted fo=
r
> + * syscall programs, so the helper and kfunc cases below validate reject=
ion
> + * for non-syscall ctx pointers at fixed, variable, and zero-sized acces=
ses.
>   */
> -#define no_rewrite_ctx_access(type, name, off, ld_op)			\
> +#define no_rewrite_ctx_access(type, name, off, load_t)			\
>  	SEC(type)							\
>  	__description(type ": read ctx at fixed offset")		\
>  	__success							\
> -	__naked void no_rewrite_##name##_fixed(void)			\
> +	int no_rewrite_##name##_fixed(void *ctx)			\
>  	{								\
> -		asm volatile ("						\
> -		r1 +=3D %[__off];						\
> -		r0 =3D *(" #ld_op " *)(r1 + 0);				\
> -		r0 =3D 0;							\
> -		exit;"							\
> -		:							\
> -		: __imm_const(__off, off)				\
> -		: __clobber_all);					\
> +		char *p =3D ctx;						\
> +		volatile load_t val;					\
> +									\
> +		val =3D *(load_t *)(p + off);				\
> +		(void)val;						\
> +		return 0;						\
>  	}								\
>  	SEC(type)							\
>  	__description(type ": reject variable offset ctx access")	\
>  	__failure __msg("variable ctx access var_off=3D")			\
> -	__naked void no_rewrite_##name##_var(void)			\
> +	int no_rewrite_##name##_var(void *ctx)			\
>  	{								\
> -		asm volatile ("						\
> -		r6 =3D r1;						\
> -		call %[bpf_get_prandom_u32];				\
> -		r1 =3D r6;						\
> -		r0 &=3D 4;						\
> -		r1 +=3D r0;						\
> -		r0 =3D *(" #ld_op " *)(r1 + 0);				\
> -		r0 =3D 0;							\
> -		exit;"							\
> -		:							\
> -		: __imm(bpf_get_prandom_u32)				\
> -		: __clobber_all);					\
> +		__u64 off_var =3D bpf_get_prandom_u32();			\
> +		char *p =3D ctx;						\
> +									\
> +		off_var &=3D 4;						\
> +		p +=3D off_var;						\
> +		return *(load_t *)p;					\
>  	}								\
>  	SEC(type)							\
>  	__description(type ": reject negative offset ctx access")	\
> -	__failure __msg("negative offset ctx ptr")			\
> -	__naked void no_rewrite_##name##_neg(void)			\
> +	__failure __msg("invalid bpf_context access")			\
> +	int no_rewrite_##name##_neg(void *ctx)			\
>  	{								\
> -		asm volatile ("						\
> -		r1 +=3D %[__neg_off];					\
> -		r0 =3D *(" #ld_op " *)(r1 + 0);				\
> -		r0 =3D 0;							\
> -		exit;"							\
> -		:							\
> -		: __imm_const(__neg_off, -(off))			\
> -		: __clobber_all);					\
> +		char *p =3D ctx;						\
> +									\
> +		p -=3D 612;						\
> +		return *(load_t *)p;					\
>  	}
> =20
>  no_rewrite_ctx_access("kprobe", kprobe, 8, u64);

