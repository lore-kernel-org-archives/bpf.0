Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0234446FC
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241201; cv=none; b=WUfGqcrE+eiWxkoCaQhVIgJ1IgyQsMkknDqdJzVQ8+wcnfbkPrIZudHqPYZC+H0o8LGXcrZ5QLL5WUUlj+E+/GUFiPutxF8xcKCK/X1Y0+q/X0QJ9+9z7SEN4FYbqXH5g47e4zWntA/+bFXWMW/osvqwYklJBr3oylOvV8o8j2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241201; c=relaxed/simple;
	bh=n5nbVeHLLSDit+gvU3HiGLIHWuue7XL0x5A9DT7NCHo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=m8nR2aETZpPCehpu5eHGa3SgEU9PwGbq22oMaSrLjmMgGZ3A/otkVpsCd/gVQTts6nrKXKqA8blOTlSgCGTnRegCJcbHC86kzmDbuV+Aob4kRmelFKCDqIdnsAepfM31qDLcfyTRXvEGSh80NqY3QfrUetlASylBwCNAaPYVpmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOuVsIjK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOuVsIjK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7E91F000FF;
	Thu, 24 Sep 2026 09:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790241199;
	bh=S06OmuchfimLN6mDMQEzeKpQ8aLW+0vWWkCMPxWABdw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YOuVsIjKq9Ul6Ih7KUXvwDnUFJY3K+mZFm9qrBKwJc3H5N/FoDHKuHEz+ldzY0xeg
	 dqjO9YqiGQgKQ04C0ex7Gs5Tp0Q4cgoGs0e5F/OZ4WPV3rs4G/HJJ7pxbvReJV/k7u
	 D23LZJSUYwSv9u79SSunIcPUUY7BK6hQ3xcNsFCfZWuHXKnXxHEZZ67nQhE6RvH7kl
	 QrIxjqdjYIrK35XdXtljY/RgBfBQfbzMJOiwg79pwotZVRNOAuas8R+akwmXf1tttR
	 7QA0MDpZ78lEl1mwf0Av07uZZgWhuXJ7VASThK/AkiW3ncE0KhU66CivuL8NBjU9Zx
	 7Mu93Yu77bBgQ==
Content-Type: multipart/mixed; boundary="===============7745826872664727352=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <24dfe7fd22d578517f54fb854f4d76ebfa4414ec48b2fcc751b2045f88a624ae@mail.kernel.org>
In-Reply-To: <20260924082607.2695649-16-memxor@gmail.com>
References: <20260924082607.2695649-16-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 15/18] selftests/bpf: Give the 512-byte stack boundary tests a 2 KiB twin
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 09:13:18 +0000 (UTC)

--===============7745826872664727352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
> index af1f9305da37..e39202902be4 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c

[ ... ]

> @@ -589,13 +589,58 @@ static unsigned long use_stack_304(void)
>  	);
>  }
>
> +
> +/* Four 480-byte frames, deeper than any budget together with their caller */
> +__naked __noinline __used
> +static unsigned long use_stack_480_0(void)
> +{
> +	asm volatile (
> +		"r0 = 0;"
> +		"*(u64 *)(r10 - 480) = r0;"
> +		"exit;"
> +	);
> +}
> +
> +__naked __noinline __used
> +static unsigned long use_stack_480_1(void)
> +{
> +	asm volatile (
> +		"r0 = 0;"
> +		"*(u64 *)(r10 - 480) = r0;"
> +		"call use_stack_480_0;"
> +		"exit;"
> +	);
> +}
> +
> +__naked __noinline __used
> +static unsigned long use_stack_480_2(void)
> +{
> +	asm volatile (
> +		"r0 = 0;"
> +		"*(u64 *)(r10 - 480) = r0;"
> +		"call use_stack_480_1;"
> +		"exit;"
> +	);
> +}
> +
> +__naked __noinline __used
> +static unsigned long use_stack_480_3(void)
> +{
> +	asm volatile (
> +		"r0 = 0;"
> +		"*(u64 *)(r10 - 480) = r0;"
> +		"call use_stack_480_2;"
> +		"exit;"
> +	);
> +}
> +
>  /* stack of all possible callees is accounted */
>  SEC("socket")
> -__failure __msg("combined stack size of 2 calls is")
> +__failure __msg("combined stack size of {{[0-9]+}} calls is")
>  __naked void callx_rodata_stack_depth(void)
>  {
>  	asm volatile (
> -		FUNC_TABLE2(tbl, ret0, use_stack_304)
> +		FUNC_TABLE2(tbl, ret0, use_stack_480_3)
>  		"r0 = 0;"
>  		"*(u64 *)(r10 - 304) = r0;"
>  		"call %[bpf_get_prandom_u32];"
> @@ -613,11 +658,11 @@ __naked void callx_rodata_stack_depth(void)
>
>  /* stack of a callback that is read from the data is accounted too */
>  SEC("socket")
> -__failure __msg("combined stack size of 2 calls is")
> +__failure __msg("combined stack size of {{[0-9]+}} calls is")
>  __naked void callx_rodata_callback_stack_depth(void)
>  {
>  	asm volatile (
> -		FUNC_TABLE2(tbl, use_stack_304, ret0)
> +		FUNC_TABLE2(tbl, use_stack_480_3, ret0)
>  		"r0 = 0;"
>  		"*(u64 *)(r10 - 304) = r0;"
>  		"r6 = tbl_%= ll;"

This isn't a bug, but now that callx_rodata_stack_depth() and
callx_rodata_callback_stack_depth() both use the use_stack_480_*
chain, is use_stack_304() still needed in this file?

In verifier_callx.c the function is still used by callx_stack_depth_ok(),
but in verifier_callx_rodata.c nothing references it anymore. Could it be
removed along with the extra blank line after it?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35976322553
--===============7745826872664727352==--
