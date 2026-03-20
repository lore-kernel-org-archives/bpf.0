Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1197B35DA7F
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 08:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773995830; cv=none; b=q3q+nk8QMkpXNNWBbg/i1JhGjybERnKcD2MjLetqXnQ2m2NxftJCu8h9Wxgj7jjFArMdWs9yAZuZCNlwtTnZQXdb6gbn945aHY7Hk38bT5p3Dxo+VVVvVDovD8GvogD6lUcZnpAsovpLu2F1utsRAqOW8brTaVCOCvsybTXC4b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773995830; c=relaxed/simple;
	bh=aubSRWOk/G5nMShy731v1i3p/4qj70+D9lPp6TThzE0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fMBC4kaRbcv7jD1b08DhILw2LV1Jc5nPLiwI8m2upCuZ8C1zVBNe/GVV0fhub+FN2JY0OltlXdS5Bl9ez9mp1WFla8LdvXEJBWKlrN+BbqCIe4FcK+IszAwKjwuN3+WAtpsiImKHpw/QNPtwhrCwaVMlqN+uSo9jif0ddEsuD5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JLH5jDLZ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JLH5jDLZ"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso1089467f8f.1
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 01:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773995827; x=1774600627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=751vzObume+CAZzdt7A8eq8P7pep03Yg0q+zRI38A24=;
        b=JLH5jDLZ1IRjybWQaJ1FB9umfbpD6PKT4jijWjby3PjDjnJAkBHONXxgaK1oW14zsQ
         aEQbTqfI0qUijWEuPYDxTtAZCimznOW6bE5y2gZpuLnSCSkfxTdI8SJRxumhGUxdxqTv
         RDb4fULJs+URRWn1Zm7rb/HK9MWX/paD2x4k04sbrVCZcXP4gV/VwBPbNSIAnJiN5sWW
         MBTCq7EGEd/i6CWk3R7wOvB38bKtozFvrwIeljf7esY5e7tcFZu9u3OVe7+WxgmKuu9F
         EWHfJlP4siIJoCUrzKnUG7sEBool3gGpbO8sRTFo8Z/K8zsUUtRZVMqjg6qd/gVT4oEF
         Mu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773995827; x=1774600627;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=751vzObume+CAZzdt7A8eq8P7pep03Yg0q+zRI38A24=;
        b=SZ00e1YYKrqZktbwR/MwWDqvzHdPbaEe7a6tqo2fRiqHKX3IqGHvF9sI7UczeWVdo+
         W1qE7ZR9o2I5uPZUjLwqt4b7Qj82fzJV93MIOsHVspvCP1cvhELpkDDjKeq99bQ2aDia
         v/2/xjFwTO5mei1t9aVunT2kKCsMdjznuEnyrTdmVmvNownyV6t0jzy5I5LTbqhnn9DZ
         /N76/u+gbZmYKnYz1ajFHmvt50tUy95kgvPMXsNisE27VS+0UxESZ4fSnqahh9kaCVEw
         r7JXpQVqqHSVA2+FYHbGBuL8AeaKQKEQoZdhIgFqxhTppbRQjQUJBWzA8pTb/gswY3kG
         95Cg==
X-Forwarded-Encrypted: i=1; AJvYcCU1Yt6m8F3gee+ckGxSSxzKGsLaHogwH0GWCNzDHv24JdLE5nDpOTLn020S/t6PFThNh2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxZt6fHcno2L4h9MTArZ60+5JmX3Nm6KI+JGYNjuNbT4EvamoR
	DFFFaq45gw7SuV3YFz9baIH3vFzQTIdbHzD7LLa11vvk6GRIWUn6ju5TPWjwrAfA6mk=
X-Gm-Gg: ATEYQzx8Txg1fnWVd6NF78Asf1cKauslXzuXs1HAHAAllfeu/Ijb87rl8QfO7RaQ1EU
	0NkuEgLivu4xK2pNnDfOOAXIggKtiQ9t84prnPejs2kHWdrslIx7mbLkgMgvwlNruh+SenVgWRW
	OXwH7ZNVHDZLX6RvlgpEv04sflL+MCCIU1u2k1nQI3e2Qf3HtMwhG+lZZ4NAczaxO4O8LI6y0/g
	nh4pw786vk+ehJ+QAEanvxM5vb+buOXj5Hp9uMXAqrzi4YTOFtBh8hYTj5onLEjiQ7M9MADFbPK
	xfdCXAj/YtPGyRsGC/8VXihuQPzY+oAwkDYXnRv3RCZDx+H6DPHG1V5Z+qBfV5vMeIOlJDghSts
	bVATChfvlP1fZDGcRWVH95NQClm2MW/3nUQXzm/as0YKlOO9nsZ4OFrM83dVH2K+ZKkPn2cf8YA
	s635W3S67HPFyY0Lm7Rz22TKlRnBvZ
X-Received: by 2002:a5d:5f53:0:b0:439:be04:13c4 with SMTP id ffacd0b85a97d-43b6423d85bmr3740008f8f.4.1773995827294;
        Fri, 20 Mar 2026 01:37:07 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703343sm4288450f8f.19.2026.03.20.01.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 01:37:06 -0700 (PDT)
Date: Fri, 20 Mar 2026 11:37:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Support struct btf_struct_meta via
 KF_IMPLICIT_ARGS
Message-ID: <202603200410.ZnghNupo-lkp@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318223544.1789748-1-ihor.solodrai@linux.dev>

Hi Ihor,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Ihor-Solodrai/selftests-bpf-Update-kfuncs-using-btf_struct_meta-to-new-variants/20260319-070652
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20260318223544.1789748-1-ihor.solodrai%40linux.dev
patch subject: [PATCH bpf-next v2 1/2] bpf: Support struct btf_struct_meta via KF_IMPLICIT_ARGS
config: x86_64-randconfig-161-20260319 (https://download.01.org/0day-ci/archive/20260320/202603200410.ZnghNupo-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
smatch: v0.5.0-9004-gb810ac53

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202603200410.ZnghNupo-lkp@intel.com/

smatch warnings:
kernel/bpf/verifier.c:12760 is_bpf_rbtree_add_kfunc() error: buffer overflow 'special_kfunc_list' 64 <= 64

vim +/special_kfunc_list +12760 kernel/bpf/verifier.c

3700d7c829341d Ihor Solodrai   2026-03-18  12758  static bool is_bpf_rbtree_add_kfunc(u32 func_id)
3700d7c829341d Ihor Solodrai   2026-03-18  12759  {
3700d7c829341d Ihor Solodrai   2026-03-18 @12760  	return func_id == special_kfunc_list[KF_bpf_rbtree_add] ||
                                                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Out of bounds. We need to make the special_kfunc_list[] bigger if we're
going to keep adding new special_kfunc_type values.

3700d7c829341d Ihor Solodrai   2026-03-18  12761  	       func_id == special_kfunc_list[KF_bpf_rbtree_add_impl];
3700d7c829341d Ihor Solodrai   2026-03-18  12762  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

