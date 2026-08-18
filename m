Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6FF3603C7
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 20:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787086290; cv=none; b=Ml9oUf9djswEWXvFQAngIqPa1fk82dA1duppSJTm9dl1ZeYDFRckDH3t1JsS3k/0eMpQ9Feb4hpUBZCFJVZLMerQizRoNNMJfSSUQsS+2OtJ96b/Sn1JFeJ9Qk13gVubRVdlFQ4591qRaGmah/dgLEng8+ITmYVtenyMz/crAvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787086290; c=relaxed/simple;
	bh=JKuQcVGNjW0cuTSNBq9vhohu2cO3rx0iEZOmkcrHMLc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUSWB1c3HG4W2SqvKYMgdRzAgjsKmAzkERy+RJL8/arb6qjpxKHpoNF9/5rK51ULdggZKF9ES1AwKqFEtAZgaqyHkLrgM26E6PhB+ZoWbVqiRHZ9kaApvBh1mADiAJTC48bsB8p8YFRcFAwd25qnDVRxYN7Nye3L8cA6IN4F0gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imXOR2Mt; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imXOR2Mt"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4998e0916faso2280535e9.2
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 13:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787086286; x=1787691086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dVpYOgo/c1ZhnFeYSDI9ttwce7VHO/ZgOUtefW2QhaM=;
        b=imXOR2MtYSLSBGJstFu2OPXZDBA6kmBlc+dojQ00Zk7Cn4+qLSXMkLlC/NrjQMl4WC
         dj85GxbtuOfrQlW1bWFLbRIN4xo+9NU2JACqnN2wuiM8rDN90115jLV9/u00D1tIwz1R
         8ojFkMIm6yXehLNR+7wUSkCpoWIDbhr112evc8piTLMOd5y/28SOuoeAZt9ZAoSzJNRu
         QIlrRtjYufsNGPgziAY0mM1Hsvdulcyq+11zw15vO54w5KZhLmQ7M9qOwummsbmCJCjx
         Qvygu31XJo3ijhELo/2X1tmOBROJ1q0bwzfgl7guetsZlpvvKYxnC0iOQPQyx6SCvvWV
         MYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787086286; x=1787691086;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dVpYOgo/c1ZhnFeYSDI9ttwce7VHO/ZgOUtefW2QhaM=;
        b=KAKKVZmSD2B83TMj5AFp4H8kk0A0Aa+GrArmrq0fK1ALBg9XWFOWBuwzYloCg3b0PL
         izkNwHtmnrCsvX9HA/7n1xwACGenBhn4WEyd3DiNh/m51V2zCprg3siYMZskQ2OGaNDO
         OIROVkYAG6oOmlwPbQ+Jn8zklpSvHPuoz9SH0rxDlPQzKXMI6x2W45m/IuMf9YMoSFUZ
         TmUcBRC5VQOylzQXaWcr/JDAzzR0GV0yhP7QlsC2z/1Lcewy41Tq2KMmhzR6guGPa6ik
         GTDh7+XbMrO57m0zxHau+cS1cYd9VcDQMAb3L0+DFoPm2cFqBDjRlqYwMGmMlFSwrQyA
         mRvQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq30ynDfG5qQtsHVbFKQeCZ61feJ/79Ydgb1uR3JgJH3MIlGD8pXwDnArDTkm7hwzXwQm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLJcl95o1lK2e29sNVipqxnams33ejs615VdglneotUmrkQ4tM
	Yf1enmnR+qB8szXD2ZUvpsraWJR797k8ovZE6ppLIJGwWYFyMd4ZrADR
X-Gm-Gg: AR+sD100ANgme3WfK2GwOA0RdryvaRyZ6xt37bYOPAvHvBo4FbFlrqckxPrRV53ifMP
	XMH714V68tc08d23LR9cotG7EczlVyhSC/fRobq7sQBB1Vf0LdstF+BiIj+GrKw986T+gaz0SHe
	uHb1MKXckc/qjICrYNxd/sU+KDynxrtIjWG17qaAc756O+C+t0h1gy0rAsIhEQe/eHqDTQfgDkL
	EXLmIju45nA5hvMBET6EF7JrZs3mrnZPGuW+iu17u1zBr0XmZNxa43MlIgVoncr690WEXFUKgUc
	lG8LcJPcWZ1X/buwD3ZdANvjMO9Tyr9jyp5XJGLqAVG2wSwhg3q4EHKai7SkbH5ZFvUS14N4eCY
	usgfTs17AQVh0qZcCp1gAdrTMas9hk6lQtJmk+0vHwKlaSoNz/XE/rZ/vblRUTnSwoJ8oIKbANm
	nCwoXpkR1iUkGhwuB7MS58pYurP2NdTGHBjC5vp2tt2bKZB0UUQDzbtDHSOl1soBQ+ED0Nug84H
	ANqy1BDUQ==
X-Received: by 2002:a05:600c:3e15:b0:499:a5fc:2087 with SMTP id 5b1f17b1804b1-499a8f41991mr12761365e9.6.1787086285696;
        Tue, 18 Aug 2026 13:51:25 -0700 (PDT)
Received: from krava (37-188-219-233.red.o2.cz. [37.188.219.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa09b199sm179205e9.0.2026.08.18.13.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 13:51:25 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 18 Aug 2026 22:51:16 +0200
To: Mike Rapoport <rppt@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [PATCH] x86/bpf: make arch_bpf_trampoline_size allocate from
 EXECMEM_MODULE_DATA
Message-ID: <aoTFxA28p1_RVNo2@krava>
References: <20260818130510.3110054-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818130510.3110054-1-rppt@kernel.org>

On Tue, Aug 18, 2026 at 04:05:10PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Jiri Olsa reports slowdown of tracing_multi benchmark that allocates huge
> number of trampolines [1].
> 
> The slowdown caused by extra protection changes in execmem_alloc_rw() and
> execmem_free().
> 
> With ROX caches enabled, all execmem allocations except EXECMEM_MODULE_DATA
> are ROX after the allocation. execmem_alloc_rw() temporarily sets them to
> W+NX and execmem_free() resets them back to ROX.
> 
> The only user of bpf_jit_alloc_exec_rw() is x86::arch_bpf_trampoline_size()
> that only needs a temporary writable buffer in the modules address space.
> 
> On x86 executable memory and module data are constrained to the same
> address range, so x86::arch_bpf_trampoline_size() can directly use
> execmem_alloc(EXECMEM_MODULE_DATA)
> 
> Replace the call to bpf_jit_alloc_exec_rw() with a call to
> execmem_alloc(EXECMEM_MODULE_DATA) in x86::arch_bpf_trampoline_size() and
> drop bpf_jit_alloc_exec_rw() helper.
> 
> Reported-by: Jiri Olsa <olsajiri@gmail.com>
> Link: https://lore.kernel.org/all/an8r7EODLIL-bZM3@krava
> Fixes: f0334294a428 ("bpf, x86: make sure allocation in arch_bpf_trampoline_size() is writable")
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Tested-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirak

> ---
>  arch/x86/net/bpf_jit_comp.c | 8 +++++---
>  include/linux/filter.h      | 1 -
>  kernel/bpf/core.c           | 5 -----
>  3 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index b2feec81e231..7d064d3e2788 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -13,6 +13,7 @@
>  #include <linux/bpf_verifier.h>
>  #include <linux/memory.h>
>  #include <linux/sort.h>
> +#include <linux/execmem.h>
>  #include <asm/extable.h>
>  #include <asm/ftrace.h>
>  #include <asm/set_memory.h>
> @@ -3706,15 +3707,16 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
>  	 *
>  	 * We cannot use kvmalloc here, because we need image to be in
>  	 * module memory range.
> -	 * Since it must be writable use bpf_jit_alloc_exec_rw().
> +	 * Since it must be writable use execmem_alloc(EXECMEM_MODULE_DATA)
> +	 * that returns writable memory in the module address space.
>  	 */
> -	image = bpf_jit_alloc_exec_rw(PAGE_SIZE);
> +	image = execmem_alloc(EXECMEM_MODULE_DATA, PAGE_SIZE);
>  	if (!image)
>  		return -ENOMEM;
>  
>  	ret = __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, image,
>  					    m, flags, tnodes, func_addr);
> -	bpf_jit_free_exec(image);
> +	execmem_free(image);
>  	return ret;
>  }
>  
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 32d5297c557e..14acb2455746 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1333,7 +1333,6 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
>  void bpf_jit_binary_free(struct bpf_binary_header *hdr);
>  u64 bpf_jit_alloc_exec_limit(void);
>  void *bpf_jit_alloc_exec(unsigned long size);
> -void *bpf_jit_alloc_exec_rw(unsigned long size);
>  void bpf_jit_free_exec(void *addr);
>  void bpf_jit_free(struct bpf_prog *fp);
>  struct bpf_binary_header *
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index e2076667b245..1b89c18cf246 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1128,11 +1128,6 @@ void *bpf_jit_alloc_exec(unsigned long size)
>  	return execmem_alloc(EXECMEM_BPF, size);
>  }
>  
> -void *bpf_jit_alloc_exec_rw(unsigned long size)
> -{
> -	return execmem_alloc_rw(EXECMEM_BPF, size);
> -}
> -
>  void bpf_jit_free_exec(void *addr)
>  {
>  	execmem_free(addr);
> 
> base-commit: 07edbd8fe6416f45e9ba6b0edcd3e40770601ebc
> -- 
> 2.53.0
> 
