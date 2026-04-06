Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9782D175A9D
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 02:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775440842; cv=none; b=TptWlgv/d21NFSXcgMBFyzg5sR5XvVgQAitOBkLkH0VZiuI0mYk+cX2sbn7SDZVQd85j5NMnML+tgZlYTg1BFwkcPA/FHuvSgs4dW60hxUXCRAI+xpQVFliZ8bZCK9L+R1cpOV95qgMWlNbce1IQj2W1Z721mc9cOlvHKs5t2kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775440842; c=relaxed/simple;
	bh=lyxCAZeV8XsRJswg+tpIQ9IXYnmGcKIEeIm6w1WgZu0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Nn5ibv0kHx9V2HQ1wN+wqruT7xR3Vugk+IQ1wfxYlvQRY9D2D6uIxJBA+cqJBZZ9sg4mKuCCs+WbKa8DibA2n4Ueif7JLM69pq/vGN7UcjLQ+HAFTPnRV8PxUDu3vtVffAM0xVs+cbzpjMOIxd7Fm4B+i7LyacGT1NVNaLSFi+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=xtlv3ZNY; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="xtlv3ZNY"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82418b0178cso1449134b3a.1
        for <bpf@vger.kernel.org>; Sun, 05 Apr 2026 19:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775440841; x=1776045641; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YthXsZGnBtxTNFBenSadaEk1DhJK7iv3JKR3u39gKfI=;
        b=xtlv3ZNYTxUC+z19ZJPumja5skV2BDHDdBtsZlBLc5gA5HtIo4bUBQ84dbFm5bO8Z1
         3nxD3F36MvLQOYNs8XRAWdg2lojdsC+iRj5mq74BtFluzHpwcUzuSPPOEsVWTyVyn95U
         /L+ddnytkuTgNflLGbedVV/89Za+/mAEZt8nwSRcpc8wl4gnkdEUcpCO23rdXlPLFReS
         nQHXlfnuT9PgDA+5nVRkSjQHU0vGL8uF90GW8RxUJMtLySMTdhxtyfJUfuIq8jKvcDAR
         V7drnLVV9WvtJ5yTaD/cAK8408YNTXD8/5C6ZjuZrxI1hQyQ3giIY+QAu4IfIBs9wjOQ
         E4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775440841; x=1776045641;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YthXsZGnBtxTNFBenSadaEk1DhJK7iv3JKR3u39gKfI=;
        b=L3VZoOiY7n01FE36Vqo2tA3mbnt+HXZBjpV/4EPxXacCkpR0SHaGrC9/jxX3aDWEvm
         bq6ccYeftR9/SveovB5tfLn65tRBjXxgVpjKf05ruKAo6S3XGeX9wp+A6HXi/t7SXE6R
         rTQ0bJBuVkFlfxqYacG5C2q9NRashNevYwcsRURpLkaXfAN6fDQUTlxzlqvX/aEloKaA
         oGqatcoRuxtIpPE7df0QV+nRh9a3SvFunRpbbW2v1l1IwQOryvEVjl8ruEC8iyrNYKag
         Sheh7qL0BjakQNu/ZfBuyv2+aMeEFVZzTzgnTCSaD0HbEvlXiHTLCIbDhdo+ECG+dvyo
         BTug==
X-Forwarded-Encrypted: i=1; AJvYcCUG3I4G+I7FpYfqdH1BIhdNNoKcd0VU/8vcKQrcytmmaudCyyxqfo5C+VissYEHgZu+IY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIfpiiSyC0WgSddgFxypT+z++YbSs+3CTHw3TBJDylRZqH0gAB
	OOtybRNhC4FmUtEgYYZeQ1n9QAX9ITCx+Dr/zoXK/DAcPv5CvZO1wEJsMSc/XroNMAE=
X-Gm-Gg: AeBDietMgA3t4eJc3/bqtvbkJOhlFJdwvxsBaoQdyp5gcb2nFAZqvKyYoS29GB41Z+G
	3XpUHsL6OeKr5rmXX5U9jlgCmACIOquOHaHp04OPsVKWyP0e2Fj/UaOIHYQAfo+aGrD3QDO333p
	5hxwPJhM6WGLNDJvvl4qsGS3Zl/VrHzkOFkb5qEauLM45GBA6NzDzt+ppehZkiPO3jiOkfNBFIl
	8p0aKglS7uiPdiWR8agd0qV2aKApFimoxBWPepkoGZhYQGYbJUiuCqokBOw/7qJS/gWtEasy5y1
	LJLtpc0v3NpaKJY7tFGLtp31liZtJZtIIxITxPfoNmk/Kz7MaAYswtFOCXYLJSfxxlFgPXhZFX3
	bpVuLmrx+2caN3lfKl90Iil7jzqEQFWDysEl2CN49b0e/30qn4ca14prTabhZxxRj080RNn9qqd
	Lr4ZZhmzpw8GmCnGsmAA==
X-Received: by 2002:a05:6a00:1705:b0:828:d9a1:c5f9 with SMTP id d2e1a72fcca58-82d0db53ec9mr10941026b3a.33.1775440840678;
        Sun, 05 Apr 2026 19:00:40 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c6ad8asm12586629b3a.40.2026.04.05.19.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2026 19:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Apr 2026 22:00:39 -0400
Message-Id: <DHLP91VDOZO9.QFQ25QR4YPXE@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin
 KaFai Lau" <martin.lau@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Tejun Heo" <tj@kernel.org>, "Dan Schatzberg" <dschatzberg@meta.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v4 6/7] selftests/bpf: Add tests for unaligned
 syscall ctx accesses
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260401122818.2240807-1-memxor@gmail.com>
 <20260401122818.2240807-7-memxor@gmail.com>
In-Reply-To: <20260401122818.2240807-7-memxor@gmail.com>

On Wed Apr 1, 2026 at 8:28 AM EDT, Kumar Kartikeya Dwivedi wrote:
> Add coverage for unaligned access with fixed offsets and variable
> offsets, and through helpers or kfuncs.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

There is some duplication with the variable offset tests, but it
makes the tests self-contianed and readily understandable so no
use trying to refactor or anything.

> ---
>  .../selftests/bpf/progs/verifier_ctx.c        | 133 ++++++++++++++++++
>  1 file changed, 133 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx.c b/tools/tes=
ting/selftests/bpf/progs/verifier_ctx.c
> index 6e683dd8002a..887cd07ed885 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_ctx.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_ctx.c
> @@ -320,6 +320,30 @@ int syscall_ctx_fixed_off_read(void *ctx)
>  	return 0;
>  }
> =20
> +SEC("?syscall")
> +__description("syscall: unaligned read ctx with fixed offset")
> +__success
> +int syscall_ctx_unaligned_fixed_off_read(void *ctx)
> +{
> +	char *p =3D ctx;
> +	volatile __u32 val;
> +
> +	val =3D *(__u32 *)(p + 2);
> +	(void)val;
> +	return 0;
> +}
> +
> +SEC("?syscall")
> +__description("syscall: unaligned write ctx with fixed offset")
> +__success
> +int syscall_ctx_unaligned_fixed_off_write(void *ctx)
> +{
> +	char *p =3D ctx;
> +
> +	*(__u32 *)(p + 2) =3D 0;
> +	return 0;
> +}
> +
>  SEC("?syscall")
>  __description("syscall: read ctx with variable offset")
>  __success
> @@ -350,6 +374,38 @@ int syscall_ctx_var_off_write(void *ctx)
>  	return 0;
>  }
> =20
> +SEC("?syscall")
> +__description("syscall: unaligned read ctx with variable offset")
> +__success
> +int syscall_ctx_unaligned_var_off_read(void *ctx)
> +{
> +	__u64 off =3D bpf_get_prandom_u32();
> +	char *p =3D ctx;
> +	volatile __u32 val;
> +
> +	off &=3D 0xfc;
> +	off +=3D 2;
> +	p +=3D off;
> +	val =3D *(__u32 *)p;
> +	(void)val;
> +	return 0;
> +}
> +
> +SEC("?syscall")
> +__description("syscall: unaligned write ctx with variable offset")
> +__success
> +int syscall_ctx_unaligned_var_off_write(void *ctx)
> +{
> +	__u64 off =3D bpf_get_prandom_u32();
> +	char *p =3D ctx;
> +
> +	off &=3D 0xfc;
> +	off +=3D 2;
> +	p +=3D off;
> +	*(__u32 *)p =3D 0;
> +	return 0;
> +}
> +
>  SEC("?syscall")
>  __description("syscall: reject negative variable offset ctx access")
>  __failure __msg("min value is negative")
> @@ -398,6 +454,28 @@ int syscall_ctx_helper_fixed_off_write(void *ctx)
>  	return bpf_probe_read_kernel(p, 4, 0);
>  }
> =20
> +SEC("?syscall")
> +__description("syscall: helper unaligned read ctx with fixed offset")
> +__success
> +int syscall_ctx_helper_unaligned_fixed_off_read(void *ctx)
> +{
> +	char *p =3D ctx;
> +
> +	p +=3D 2;
> +	return bpf_strncmp(p, 4, ctx_strncmp_target);
> +}
> +
> +SEC("?syscall")
> +__description("syscall: helper unaligned write ctx with fixed offset")
> +__success
> +int syscall_ctx_helper_unaligned_fixed_off_write(void *ctx)
> +{
> +	char *p =3D ctx;
> +
> +	p +=3D 2;
> +	return bpf_probe_read_kernel(p, 4, 0);
> +}
> +
>  SEC("?syscall")
>  __description("syscall: helper read ctx with variable offset")
>  __success
> @@ -424,6 +502,34 @@ int syscall_ctx_helper_var_off_write(void *ctx)
>  	return bpf_probe_read_kernel(p, 4, 0);
>  }
> =20
> +SEC("?syscall")
> +__description("syscall: helper unaligned read ctx with variable offset")
> +__success
> +int syscall_ctx_helper_unaligned_var_off_read(void *ctx)
> +{
> +	__u64 off =3D bpf_get_prandom_u32();
> +	char *p =3D ctx;
> +
> +	off &=3D 0xfc;
> +	off +=3D 2;
> +	p +=3D off;
> +	return bpf_strncmp(p, 4, ctx_strncmp_target);
> +}
> +
> +SEC("?syscall")
> +__description("syscall: helper unaligned write ctx with variable offset"=
)
> +__success
> +int syscall_ctx_helper_unaligned_var_off_write(void *ctx)
> +{
> +	__u64 off =3D bpf_get_prandom_u32();
> +	char *p =3D ctx;
> +
> +	off &=3D 0xfc;
> +	off +=3D 2;
> +	p +=3D off;
> +	return bpf_probe_read_kernel(p, 4, 0);
> +}
> +
>  SEC("?syscall")
>  __description("syscall: helper read zero-sized ctx access")
>  __success
> @@ -466,6 +572,33 @@ int syscall_ctx_kfunc_var_off(void *ctx)
>  	return 0;
>  }
> =20
> +SEC("?syscall")
> +__description("syscall: kfunc unaligned access ctx with fixed offset")
> +__success
> +int syscall_ctx_kfunc_unaligned_fixed_off(void *ctx)
> +{
> +	char *p =3D ctx;
> +
> +	p +=3D 2;
> +	bpf_kfunc_call_test_mem_len_pass1(p, 4);
> +	return 0;
> +}
> +
> +SEC("?syscall")
> +__description("syscall: kfunc unaligned access ctx with variable offset"=
)
> +__success
> +int syscall_ctx_kfunc_unaligned_var_off(void *ctx)
> +{
> +	__u64 off =3D bpf_get_prandom_u32();
> +	char *p =3D ctx;
> +
> +	off &=3D 0xfc;
> +	off +=3D 2;
> +	p +=3D off;
> +	bpf_kfunc_call_test_mem_len_pass1(p, 4);
> +	return 0;
> +}
> +
>  SEC("?syscall")
>  __description("syscall: kfunc access zero-sized ctx")
>  __success

