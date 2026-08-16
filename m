Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198D13B27F3
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 20:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786911188; cv=none; b=f2oOXWx9x8YzYzvsO+oJc3uO6P4Garpzaw+E7RiecQW4eunJDjOZPwjRJnJ2qvuMYVBLl7Qf6GR19skhqA7iCwzFTfq0hXG+Zo/aKGhMjWccoeyQOKvIV1LfVd6Qy4rX3n8fSJ+jLQnIstmci+RY1Fy7XRER60za6sb9Ul/tVPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786911188; c=relaxed/simple;
	bh=eX+GUuAWrqVl6moqpAs1zEAHEY8Ip4ntN01n+ji+fII=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFWbth8vDtpjk7RcwITC4zScNFX5gu/WViNm5YT028LYBukmpSkubd3HpoUnhevfvuC9Ep5/Pvg2DjS1O80At13ByW7npB9U9AuG6hfc7ZxgcFv4K+v2f8mHWvpMN43ahOIwpPBHjcweYrs8rJGInDluEoqz53kNwaFu9r5mEk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hd5D4nEW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hd5D4nEW"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so21769465e9.0
        for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 13:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786911185; x=1787515985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nBTP7IvvyCuNS8293JpE8Ca2O7HvcIrZxpqclQA3eAI=;
        b=Hd5D4nEWq5tdjvl6s6fbCEDtuu/Cspvp0xiTCb59SCZS89Wm6Vc3MFWE6YCZ+CuPaW
         xKkIreudzHkrbPc3DiWvHifsprXMk8sur6T0xZMX8Odyo8r0o3NbbodXCaepyvBOB9Do
         tuTBV6lTEq9cDY5IYE13tk23DfQcvfkUspduziDRcSdsmrbQ5iA5irgJhrEJEm+xXBhx
         8DT/3juhwDHO1pBfjsTpJZ/DI81mvhaMTwKO8MqNvCrKQkcr6ykidP3j/5XJ3EHIGhSa
         iey+YFKNGpQ8e8gxP/iOjUIJDaivnHcOVfGBGCfCCwjaPsMhZgoaZLryu0kRYlN7J5xw
         ntPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786911185; x=1787515985;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nBTP7IvvyCuNS8293JpE8Ca2O7HvcIrZxpqclQA3eAI=;
        b=rYlwVcC2HVKZNL5JlN8s1dJkGWp5OSrTq+8YBJ2VqNqe1qK4/I5WrSF/kb3Yx4MINP
         5+Sx3VVC5FcUSmoj3Le/mvHNjxmybOH6jys0uouVwPvcGmjE84NggeW9w45Y8XIrXDAl
         pYdjSyke4T+JBK4eh3VYQOUsdBcFadBVMM/7uPCdWOY+XMtTFP413rZq0mSmbzdOfopu
         1ls08ef4DbHq3GT87jPcpKwAMMeG60btIkUouqDtIrcifhBikaLY9P+JU8rx6CXyZE7W
         dixFj1ptqDH9VTgDZCNuouiAi7G3srocshlyaoFmKoxdHiTsT+M3AAlECmG0x7eAf0u0
         zyqw==
X-Forwarded-Encrypted: i=1; AHgh+RrwbmdtuFuGEvWl0dUcXcMCu5oBtYVKGsO7g249kDhmU5GPr2tAfYido/7xOgDhazZ7QjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+llYccgRiAG3QH9XxL6lIm7rm5iuUsK+94U4agVlSZyQo61Qb
	7abX5wnBUIVXHZ40pxEXDcT2a8BcPudsAbMhBq0q1BTQMkL/UFtJGpkz
X-Gm-Gg: AR+sD13g2h4KnoAhcyc6nC60ueOqnlwulOlm/gdSrarO70jeAclW1zIeHkgCiiDzjUE
	JU4yulxwv4WxQhpwdSmi7NC7ZStYXVMVBfScwUTh9BtsKxxIIa1Wey9RPBXLgnxyJB5Tf3XAo7h
	9ooYbVXwz6kWcQ/Y3vsH322loJFcG//U3eh5+oAk4GV5J25DBmCUxqMeCiqKcY7WD4gPWIrhcK9
	VUVXEmUPxUBfXFYYIpcCSvjA5lYVEcKBSxDaypXcAHXSrIC/qHsUyaOiPG7bifPGfhpDpogpLVR
	6tVQlY4RFItXNQOWFg0/KMlEhLE8hwM5La91BjKlbFP0KlWGR3RUUjtMZhMIvB8f5KBVXXjKl2C
	7Vtu64ukrQ/3rXE833v4n7DXQnyr81lT42AGfg/Kq/BUHkcDQWtQ8K6DXBMeRQILnYZuvgpBjHX
	MXWUrkn2bLYn5Kvm4ESwOZaQi1EhsoxKQLt5HutDRwgUbYal8=
X-Received: by 2002:a05:600c:4e45:b0:499:8fa7:dc52 with SMTP id 5b1f17b1804b1-4998fa7dde2mr193380695e9.16.1786911185055;
        Sun, 16 Aug 2026 13:13:05 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f15b946sm27429947f8f.0.2026.08.16.13.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 13:13:04 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 16 Aug 2026 22:13:02 +0200
To: Mike Rapoport <rppt@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v3 4/5] bpf, x86: make sure allocation in
 arch_bpf_trampoline_size() is writable
Message-ID: <aoIZztIXgtbs7iaW@krava>
References: <20260716-execmem-x86-rox-bpf-v0-v3-0-4e76158c01c5@kernel.org>
 <20260716-execmem-x86-rox-bpf-v0-v3-4-4e76158c01c5@kernel.org>
 <an8r7EODLIL-bZM3@krava>
 <aoF7f3lH_rz7mxSR@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoF7f3lH_rz7mxSR@kernel.org>

On Sun, Aug 16, 2026 at 11:57:35AM +0300, Mike Rapoport wrote:

SNIP

> From 14dff78529a9204408a5c14036954df5f2f76431 Mon Sep 17 00:00:00 2001
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> Date: Sun, 16 Aug 2026 11:27:32 +0300
> Subject: [PATCH] x86/bpf: make arch_bpf_trampoline_size allocate from
>  EXECMEM_MODULE_DATA
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

looks good, thanks

serial_test_tracing_multi_bench_attach: found 55077 functions
serial_test_tracing_multi_bench_attach: attached in   1.470s
serial_test_tracing_multi_bench_attach: detached in   0.249s

Tested-by: Jiri Olsa <jolsa@kernel.org>

jirka


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
> -- 
> 2.53.0
> 
>  
> > thanks,
> > jirka
> 
> -- 
> Sincerely yours,
> Mike.
