Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462C683A14
	for <bpf@vger.kernel.org>; Sat, 21 Feb 2026 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771678273; cv=none; b=hIQLWDPcWC1R0n+Eb9sXWva1h+rGdHz5cXci+5wEDC89DA+n5is72URDE0LhTEl53bspPyideFNWPAyP2g5GPDndU9mN3jOJKa8vTeI/DkNCoM1PKyepzJyShXaH9KX9ZXdsq9ePxp21E5P8nsFKerFh3pKv51cX3xYz7A9BuTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771678273; c=relaxed/simple;
	bh=EKERHVHJC4NJMe7ZGw3YG6p1liQYgkkEoRV8QXf/eTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lDmsG5oRZ4XG+02ui+7HmCZmjpYCTWFuj7k42Smon8vl4kMwZEyq27DiN6frttu1FcOe/KpvY04GKDBQl1CTCI49A2VOGV+G1cQh50864QK81LoOZyvKhlJXoU8N/wAcERpVflLpbpBgr4XPIN95T5n/M16VY6EkyfktEjo4BbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=icNCDIkP; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="icNCDIkP"
Message-ID: <206609d9-7bd7-4923-999a-2402388b8f64@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771678260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=br9Fo1dfeEMPffvOKFoumObqBOWwJq2Nx+QuBTPepjc=;
	b=icNCDIkPBixppTwoG2YRcxRBDOFrPHs5wl46DQZbCCKYEWDIpUUWJM7LrHCsqbdvez2lmt
	WcCr1ulB0f+kojp7ZyhjC+MKcy9vB9VrxcbDpMvUyc53mrxYFmfh27ZI2hgt1hDiDW+KSc
	uYnmHfX2R4fnoSi9mpjtw/Jhc05YLnw=
Date: Sat, 21 Feb 2026 20:50:35 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Introduce 64-bit bitops kfuncs
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
 bpf@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
 Xu Kuohai <xukuohai@huaweicloud.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Peilin Ye <yepeilin@google.com>,
 Luis Gerhorst <luis.gerhorst@fau.de>, Viktor Malik <vmalik@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <202602210241.E7Q88vvq-lkp@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <202602210241.E7Q88vvq-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/2/21 17:58, Dan Carpenter wrote:
> Hi Leon,
> 
> kernel test robot noticed the following build warnings:
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Leon-Hwang/bpf-Introduce-64-bit-bitops-kfuncs/20260219-223550
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20260219142933.13904-2-leon.hwang%40linux.dev
> patch subject: [PATCH bpf-next v2 1/6] bpf: Introduce 64-bit bitops kfuncs
> config: i386-randconfig-141-20260220 (https://download.01.org/0day-ci/archive/20260221/202602210241.E7Q88vvq-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> smatch version: v0.5.0-8994-gd50c5a4c
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202602210241.E7Q88vvq-lkp@intel.com/
> 
> smatch warnings:
> kernel/bpf/verifier.c:18245 bpf_kfunc_is_fastcall() error: buffer overflow 'special_kfunc_list' 64 <= 64
> 
> vim +/special_kfunc_list +18245 kernel/bpf/verifier.c
> 
> 966e89879bbea4 Leon Hwang       2026-02-19  18223  static bool bpf_kfunc_is_fastcall(struct bpf_verifier_env *env, u32 func_id, u32 flags)
> 966e89879bbea4 Leon Hwang       2026-02-19  18224  {
> 966e89879bbea4 Leon Hwang       2026-02-19  18225  	if (!(flags & KF_FASTCALL))
> 966e89879bbea4 Leon Hwang       2026-02-19  18226  		return false;
> 966e89879bbea4 Leon Hwang       2026-02-19  18227  
> 966e89879bbea4 Leon Hwang       2026-02-19  18228  	if (!env->prog->jit_requested)
> 966e89879bbea4 Leon Hwang       2026-02-19  18229  		return true;
> 966e89879bbea4 Leon Hwang       2026-02-19  18230  
> 966e89879bbea4 Leon Hwang       2026-02-19  18231  	if (func_id == special_kfunc_list[KF_bpf_clz64])
> 966e89879bbea4 Leon Hwang       2026-02-19  18232  		return bpf_jit_inlines_kfunc_call(bpf_clz64);
> 966e89879bbea4 Leon Hwang       2026-02-19  18233  	if (func_id == special_kfunc_list[KF_bpf_ctz64])
> 966e89879bbea4 Leon Hwang       2026-02-19  18234  		return bpf_jit_inlines_kfunc_call(bpf_ctz64);
> 966e89879bbea4 Leon Hwang       2026-02-19  18235  	if (func_id == special_kfunc_list[KF_bpf_ffs64])
> 966e89879bbea4 Leon Hwang       2026-02-19  18236  		return bpf_jit_inlines_kfunc_call(bpf_ffs64);
> 966e89879bbea4 Leon Hwang       2026-02-19  18237  	if (func_id == special_kfunc_list[KF_bpf_fls64])
> 966e89879bbea4 Leon Hwang       2026-02-19  18238  		return bpf_jit_inlines_kfunc_call(bpf_fls64);
> 966e89879bbea4 Leon Hwang       2026-02-19  18239  	if (func_id == special_kfunc_list[KF_bpf_bitrev64])
> 966e89879bbea4 Leon Hwang       2026-02-19  18240  		return bpf_jit_inlines_kfunc_call(bpf_bitrev64);
> 966e89879bbea4 Leon Hwang       2026-02-19  18241  	if (func_id == special_kfunc_list[KF_bpf_popcnt64])
> 966e89879bbea4 Leon Hwang       2026-02-19  18242  		return bpf_jit_inlines_kfunc_call(bpf_popcnt64);
> 966e89879bbea4 Leon Hwang       2026-02-19  18243  	if (func_id == special_kfunc_list[KF_bpf_rol64])
> 966e89879bbea4 Leon Hwang       2026-02-19  18244  		return bpf_jit_inlines_kfunc_call(bpf_rol64);
> 966e89879bbea4 Leon Hwang       2026-02-19 @18245  	if (func_id == special_kfunc_list[KF_bpf_ror64])
>                                                                                           ^^^^^^^^^^^^
> special_kfunc_list[] has 64 elements and KF_bpf_ror64 is 64 so
> this is out of bounds.
> 

Ack.

I'll try a new way using KF_JIT_MAY_INLINE flag in the next revision,
which will avoid adding these kfuncs to special_kfunc_list btw.

Thanks,
Leon

> 966e89879bbea4 Leon Hwang       2026-02-19  18246  		return bpf_jit_inlines_kfunc_call(bpf_ror64);
> 966e89879bbea4 Leon Hwang       2026-02-19  18247  
> 966e89879bbea4 Leon Hwang       2026-02-19  18248  	return true;
> 966e89879bbea4 Leon Hwang       2026-02-19  18249  }
> 

