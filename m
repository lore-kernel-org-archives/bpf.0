Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2882FDC28
	for <bpf@vger.kernel.org>; Sat, 21 Feb 2026 09:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771667889; cv=none; b=Jr73lGk3DRwQPiYFNVt6aGlXw3dc3jTDbP4NvLrhdn6QCbhzCB6dk6xtrbbGPVRQI5hx/+e5ikP1O7Ce8tC/hwAVUnGQhIk3bMyKMC/E7TCXroG2KuhpB5AXvQn8rGgBP/xlfCgriFfKmg7nlYbhH5yJADclgdUY1p/UVbvX4VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771667889; c=relaxed/simple;
	bh=yeFPaj6dVZUGfQ6mk7TVN6TVYypxiVGLknPgkecZgsE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DG1UtGPp3GsREzMp1itxFC+pBvjsBVJKfxmgkwzScVHjXuy9XxJyaU/J4vdgPZuw9MTVSiheN1HMY59VD+S0DpnEvm1J6ijGi7Jj2v1OPb/l/T1n5Eago4MViJz87fTgp2kf8YXEKockqZ3ctMWW2SbVzTNOKoBlBccUtPBrpA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ivACR9+o; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ivACR9+o"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-4375d4fb4d4so1821183f8f.0
        for <bpf@vger.kernel.org>; Sat, 21 Feb 2026 01:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771667886; x=1772272686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iG95ysl0cBzDn6owjLxKJa0jdHI3ZVF2zQtfxEizLIg=;
        b=ivACR9+od9eRUrJG63DqbiQqLAQFLtDJadN5yijOImnnyZWVVhj9j7hEkaB+q1+rvw
         cBArlN/iUZGKSO9aqO5IogD+8WuG2k7mcuru9b1TYwVhZTTK/GL+eAcTjG7Z2H8nViep
         85s3ddO0ERyZ+U5hQHGi8hVvbSQaJLPkh9g5jZEA2jnmr3L6IGULIl6xEJmCTWGv6pQv
         ftvPRH6vx5asQpyfDNhx9NGJWZhpwrquX45hoAvirJCBbOHXRFBszN1jSD2AkgqcpHyd
         AXH7MIVGwzcpbTyHbgvCgmhBVUBbf/3rC4jSMWvRfySL824yaM1DtNNSmczKnKAodYNP
         Y4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771667886; x=1772272686;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iG95ysl0cBzDn6owjLxKJa0jdHI3ZVF2zQtfxEizLIg=;
        b=t/2AnLZKtSm92geifmgSgKs5zjydCNAFKAVygayUdxoJ3N20J0Xm2aiqgeSI3iArLK
         PZAn/3kaMEUmKlw8ggargkA+P22lb1SZzZmCs7/PJIxtbuI9rVafou7JybUwgJkKFSXk
         C3UpXuS+1DzQDJwYJQxN3L7+dQWz2XY81ewj41/NGXHUEqNpY8mZdsUgNqupPrFKdX4h
         eDvCLYiLkPB0/Vn0hF3cS9sWfufjpMQLBtr24JyS/XiJv2DW2C7hti85g6gVGJCPgXg5
         p7j0wWFYBzPXTy738YMjlVoHDXHQPxKu/UIeYcwM4PCmoRDx5rVBIa/JZFgZt4CkbDre
         L6xQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/oQv8vIMWvItzp98DyEN5EFKwpgNCCJgUwwNRg5z88lASVARitUbUFL3dS+ndBbvOUU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSdN+MLoCvHDKCvHS7iwyB/k9Vp2EJXd/eBpZsnZvU7tUVj27B
	NohP0i6YKE3autzL8oHMrXttrUSGcXFWtF7CLMcWvFqEG1Sbk2M5A46Q9fbTUSuqHcXqvd4whkp
	YDQi7
X-Gm-Gg: AZuq6aKNunVBH7qrhID2gOcY5a4ztENOQGlgLwInU5eSVLyWbyRrbjEz1ohnEjK67Cr
	AxGcvTpYEncYRNQI/ACo0FSgmhosBnRFcDCD63Jwd5FiM6EUNVRvXew75Vt86PtLPdhbUctQIjT
	Y0meIKEuIorhffTjvfUUP0wgNHAEwEh8YNeHeKyLuLNFh4c9bCcXDytHrL52I1iRStd6HuL+KIM
	I/9OhvyjMHQUcaILTQksmiMOy377PRJOdLo7gRG9oOOdi+x61WxWnbosInhdCSxAHJLqSSwD3Ki
	XRXTGHlY7lc+Bf8KMABrknLqhB7ShPMv5hquuMSiIUGPcN4p6HWVnkllW0An9N2Rm+yhKWdKb3d
	mkKTn2FLBaQUxUkTufUnBAPPJRZ0bToTwGmP2OV+IoUnsP6Nq8rJl7uRnMQw0gwuKvVS1eaVk7M
	Gxwa9ZC1EaJdd/XKPfF0ijMpJKjxepSbm9zL+iV8o=
X-Received: by 2002:a05:6000:2601:b0:437:81b0:6638 with SMTP id ffacd0b85a97d-4396f188767mr4885393f8f.59.1771667886111;
        Sat, 21 Feb 2026 01:58:06 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bfa015sm4427011f8f.8.2026.02.21.01.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 01:58:05 -0800 (PST)
Date: Sat, 21 Feb 2026 12:58:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Leon Hwang <leon.hwang@linux.dev>,
	bpf@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Leon Hwang <leon.hwang@linux.dev>, Peilin Ye <yepeilin@google.com>,
	Luis Gerhorst <luis.gerhorst@fau.de>,
	Viktor Malik <vmalik@redhat.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Introduce 64-bit bitops kfuncs
Message-ID: <202602210241.E7Q88vvq-lkp@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219142933.13904-2-leon.hwang@linux.dev>

Hi Leon,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Leon-Hwang/bpf-Introduce-64-bit-bitops-kfuncs/20260219-223550
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20260219142933.13904-2-leon.hwang%40linux.dev
patch subject: [PATCH bpf-next v2 1/6] bpf: Introduce 64-bit bitops kfuncs
config: i386-randconfig-141-20260220 (https://download.01.org/0day-ci/archive/20260221/202602210241.E7Q88vvq-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch version: v0.5.0-8994-gd50c5a4c

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202602210241.E7Q88vvq-lkp@intel.com/

smatch warnings:
kernel/bpf/verifier.c:18245 bpf_kfunc_is_fastcall() error: buffer overflow 'special_kfunc_list' 64 <= 64

vim +/special_kfunc_list +18245 kernel/bpf/verifier.c

966e89879bbea4 Leon Hwang       2026-02-19  18223  static bool bpf_kfunc_is_fastcall(struct bpf_verifier_env *env, u32 func_id, u32 flags)
966e89879bbea4 Leon Hwang       2026-02-19  18224  {
966e89879bbea4 Leon Hwang       2026-02-19  18225  	if (!(flags & KF_FASTCALL))
966e89879bbea4 Leon Hwang       2026-02-19  18226  		return false;
966e89879bbea4 Leon Hwang       2026-02-19  18227  
966e89879bbea4 Leon Hwang       2026-02-19  18228  	if (!env->prog->jit_requested)
966e89879bbea4 Leon Hwang       2026-02-19  18229  		return true;
966e89879bbea4 Leon Hwang       2026-02-19  18230  
966e89879bbea4 Leon Hwang       2026-02-19  18231  	if (func_id == special_kfunc_list[KF_bpf_clz64])
966e89879bbea4 Leon Hwang       2026-02-19  18232  		return bpf_jit_inlines_kfunc_call(bpf_clz64);
966e89879bbea4 Leon Hwang       2026-02-19  18233  	if (func_id == special_kfunc_list[KF_bpf_ctz64])
966e89879bbea4 Leon Hwang       2026-02-19  18234  		return bpf_jit_inlines_kfunc_call(bpf_ctz64);
966e89879bbea4 Leon Hwang       2026-02-19  18235  	if (func_id == special_kfunc_list[KF_bpf_ffs64])
966e89879bbea4 Leon Hwang       2026-02-19  18236  		return bpf_jit_inlines_kfunc_call(bpf_ffs64);
966e89879bbea4 Leon Hwang       2026-02-19  18237  	if (func_id == special_kfunc_list[KF_bpf_fls64])
966e89879bbea4 Leon Hwang       2026-02-19  18238  		return bpf_jit_inlines_kfunc_call(bpf_fls64);
966e89879bbea4 Leon Hwang       2026-02-19  18239  	if (func_id == special_kfunc_list[KF_bpf_bitrev64])
966e89879bbea4 Leon Hwang       2026-02-19  18240  		return bpf_jit_inlines_kfunc_call(bpf_bitrev64);
966e89879bbea4 Leon Hwang       2026-02-19  18241  	if (func_id == special_kfunc_list[KF_bpf_popcnt64])
966e89879bbea4 Leon Hwang       2026-02-19  18242  		return bpf_jit_inlines_kfunc_call(bpf_popcnt64);
966e89879bbea4 Leon Hwang       2026-02-19  18243  	if (func_id == special_kfunc_list[KF_bpf_rol64])
966e89879bbea4 Leon Hwang       2026-02-19  18244  		return bpf_jit_inlines_kfunc_call(bpf_rol64);
966e89879bbea4 Leon Hwang       2026-02-19 @18245  	if (func_id == special_kfunc_list[KF_bpf_ror64])
                                                                                          ^^^^^^^^^^^^
special_kfunc_list[] has 64 elements and KF_bpf_ror64 is 64 so
this is out of bounds.

966e89879bbea4 Leon Hwang       2026-02-19  18246  		return bpf_jit_inlines_kfunc_call(bpf_ror64);
966e89879bbea4 Leon Hwang       2026-02-19  18247  
966e89879bbea4 Leon Hwang       2026-02-19  18248  	return true;
966e89879bbea4 Leon Hwang       2026-02-19  18249  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

