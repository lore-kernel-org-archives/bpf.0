Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0158347A0C2
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719219; cv=none; b=Pwwjo0L6yHacSTIgx5Tr/249cdTV60caVvsrYgY7VENv2gq5csGEzwTSTgbRWdw0QpcVcHxducKOMsnE89zyEY2QOgZQhjtbH+out0DyKG6XAqYX1i5Dz2gUlNAEhyYaM0Rhi9laDqKdLgzbkl/ZcV9CzccImC3rjB227im3pGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719219; c=relaxed/simple;
	bh=TjbvnBK5f7971bUksjS9kEoWW1kFhd7ogKMMpyrPgas=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFjFhiqny4xn+Tw4Ga5Joh0UHAPuYhp+WziUbLl/1S2Ja3fDH/tQ8aAlqRm+NPIcJc97Nm2Ms94aIcovfUA7ynDQk7UK6ccVb/VyxyCBLOUqWTEpbx67KsgHnHCF0DZcjOeQxLiAwt6YFs0+KnKfd7vFDCFS1GiM7hOAzy8fwvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oVJBknMq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVJBknMq"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49802c418b5so11223345e9.1
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 07:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786719215; x=1787324015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h1vHNc0jdS1Bj4A1hxqFQJwlbabmW8A15yzEecGyIZ4=;
        b=oVJBknMqRnK3FPXyuCtkfiEO4awaIItN5hX0zHfSwsG/Z9BjBKDQ4eQuqncZhZpxZd
         lSmfVtlroChsGQkx6i86sh0QpJfd7UXw4oWO9AYSYPOFVVX2xfJJSbIRRBOd98zGlmOo
         JCrFy+wO6s3a9epXOvI3kCOpzlj6TAR5LTNAsnUN+8qspxgr1MLHEwByI9pvu1P9rRXY
         tevqMjJsF3TfxuFx1FgtK2KKdgngamkKp1FZxMhnOChRdY3kHQCZeBqgl6QfyADCfSBx
         JerFDu/VTpTfdsEoa4ePgdypBcrLDC08mYCT8TELap9bEKmdvR7CC3LYhgEhOd3cmqsa
         z/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786719215; x=1787324015;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h1vHNc0jdS1Bj4A1hxqFQJwlbabmW8A15yzEecGyIZ4=;
        b=Vd7ltUmc6pziWRsNLsKE24qeWxtRrvPcGWuUbvvjlKLxNBR0FMFimzLCNghSB0Z+eF
         LdAM8/QvYF6UEPHFqD0Hb1OpXppLNLF4ASnVSJGcyMv4fPCpVIOO/s4Nrt3jKLGRCRps
         LLW1nKel1A6ENCWB4JZtgpqWSSi0YSG194bBSdXRqKZPYFmxN2h/nH660A6qQAPdPeC0
         xPZi1acZUwLtZzkTUa+rf75gELWk3vmy2UCFptrUB/cDsgASXoX3o8rgayN+GtEugHRr
         Ouy6DhWIPJxcmk5G/1ulKtVNb3jkPtnXVdVjI05kzJ7Vx0rwyNQwoIQB4hywnkVoAvxi
         m0dQ==
X-Forwarded-Encrypted: i=1; AHgh+RoUCgpxvF20t4v9ymfHpDYkmyqFZvjoXNzQaceChVnsjgeVRTuuC8Y0WZTDUEbfMk6uXnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9oVO+BWI6DzoEM5HFTTz007kpwhnX5wXKiE46t2kW1OgwNgNV
	2IE8tlYINrBoMD5TmURfmryPJVpMrCOVO95xXGKwA2QQYFdeI+PL5fXB
X-Gm-Gg: AR+sD125z97e5FKuEKOWSHmt50ib7JNNB7TkSgjZaBI1vvBN9nVbQyu4OYY2QIfIIGB
	CuFJgLY6dZjDByMDJ8BnIQ6TzmQVyNOpAWN6eQ7QZvRx1xvWZ3UKKyjGGPXTYOUnsAt6J+7UmfY
	MYYMD2J064hf+9Y6oIDToV1bD4nToeHYtgFSy4vxF7M67RG4rNu2aAzrkMVeeFULcoP0n9pDH2o
	wfiUpDcvsCV/4iEAOekDzjIyNcL7lqkcKvc9wCEbyH47F8XrxcFrEyb9FQ6kZx+1YCROxZ+ISD3
	7I132RJNhW7CtQdXDAZ60WGlQ0q7+P+45E088fm77zcaSGB3Ovqh85sIUDihTO6i+RmVoZZo83j
	USffFtiC6qXd+Sjl0pirSCaKE8UV8mataHLDShK+Z7f+g5YePVusIFyj3mbJqoISMWd96YCWGoe
	hP09v4S6CSrRlAtUPNvFvIXM3Q5IkFgHQHsX8lCTdOMT/8L2A=
X-Received: by 2002:a05:600c:19d1:b0:495:4e89:3f30 with SMTP id 5b1f17b1804b1-499879ae4f4mr84266115e9.15.1786719215001;
        Fri, 14 Aug 2026 07:53:35 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49988aa2273sm54308535e9.0.2026.08.14.07.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 07:53:34 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 14 Aug 2026 16:53:32 +0200
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <an8r7EODLIL-bZM3@krava>
References: <20260716-execmem-x86-rox-bpf-v0-v3-0-4e76158c01c5@kernel.org>
 <20260716-execmem-x86-rox-bpf-v0-v3-4-4e76158c01c5@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716-execmem-x86-rox-bpf-v0-v3-4-4e76158c01c5@kernel.org>

On Thu, Jul 16, 2026 at 10:51:38AM +0300, Mike Rapoport (Microsoft) wrote:
> arch_bpf_trampoline_size() allocates a buffer to get actual size required
> for a trampoline.
> 
> This buffer must be in the module address space because
> __arch_prepare_bpf_trampoline() calculates  rel32 offsets relatively to
> that buffer.
> 
> In preparation for enabling ROX mode for EXECMEM_BPF make sure that the
> allocated memory is writable.
> 
> Add bpf_jit_alloc_exec_rw() wrapper for execmem_alloc_rw() and use it for > buffer allocation in arch_bpf_trampoline_size().
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/x86/net/bpf_jit_comp.c | 5 ++---
>  include/linux/filter.h      | 1 +
>  kernel/bpf/core.c           | 5 +++++
>  3 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index de7515ea1bea..b2feec81e231 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3703,13 +3703,12 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
>  	int ret;
>  
>  	/* Allocate a temporary buffer for __arch_prepare_bpf_trampoline().
> -	 * This will NOT cause fragmentation in direct map, as we do not
> -	 * call set_memory_*() on this buffer.
>  	 *
>  	 * We cannot use kvmalloc here, because we need image to be in
>  	 * module memory range.
> +	 * Since it must be writable use bpf_jit_alloc_exec_rw().
>  	 */
> -	image = bpf_jit_alloc_exec(PAGE_SIZE);
> +	image = bpf_jit_alloc_exec_rw(PAGE_SIZE);

hi,
this change (this particular patch plus possibly others in this set) is
causing tracing_multi attachment bench slowdown

the benchmark allocates huge number of trampolines and I'm seeing extra
arch_bpf_trampoline_size code paths in the attached perf profile 

I'm not that familiar with the allocator, but following hack makes the
benchmark ok again:

	diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
	index 6a94370a2448..bbff3c9c6681 100644
	--- a/kernel/bpf/core.c
	+++ b/kernel/bpf/core.c
	@@ -1130,7 +1130,7 @@ void *bpf_jit_alloc_exec(unsigned long size)
	 
	 void *bpf_jit_alloc_exec_rw(unsigned long size)
	 {
	-	return execmem_alloc_rw(EXECMEM_BPF, size);
	+	return execmem_alloc(EXECMEM_MODULE_DATA, size);
	 }
	 
	 void bpf_jit_free_exec(void *addr)


I still need to do more checks, but I'm wondering if we could actually fix
this by not allocating image data in arch_bpf_trampoline_size at all..
and just teach __arch_prepare_bpf_trampoline to survive NULL image data
and just return the size in such case

thanks,
jirka


---
    11.11%  test_progs  [kernel.kallsyms]  [k] decay_va_pool_node
            |
            ---decay_va_pool_node
               __purge_vmap_area_lazy
               _vm_unmap_aliases
               change_page_attr_set_clr
               |          
               |--4.58%--set_memory_rw
               |          |          
               |          |--2.33%--execmem_alloc_rw
               |          |          arch_bpf_trampoline_size
               |          |          bpf_trampoline_update
               |          |          __bpf_trampoline_link_prog
               |          |          bpf_trampoline_multi_attach
               |          |          bpf_tracing_multi_attach
               |          |          __sys_bpf
               |          |          __x64_sys_bpf
               |          |          do_syscall_64
               |          |          entry_SYSCALL_64_after_hwframe
               |          |          syscall
               |          |          sys_bpf_fd
               |          |          bpf_link_create
               |          |          bpf_program__attach_tracing_multi
               |          |          serial_test_tracing_multi_bench_attach
               |          |          run_one_test
               |          |          main
               |          |          __libc_start_call_main
               |          |          __libc_start_main@@GLIBC_2.34
               |          |          _start
               |          |          
               |           --2.25%--__execmem_cache_free
               |                     execmem_free
               |                     arch_bpf_trampoline_size
               |                     bpf_trampoline_update
               |                     __bpf_trampoline_link_prog
               |                     bpf_trampoline_multi_attach
               |                     bpf_tracing_multi_attach
               |                     __sys_bpf
               |                     __x64_sys_bpf
               |                     do_syscall_64
               |                     entry_SYSCALL_64_after_hwframe
               |                     syscall
               |                     sys_bpf_fd
               |                     bpf_link_create
               |                     bpf_program__attach_tracing_multi
               |                     serial_test_tracing_multi_bench_attach
               |                     run_one_test
               |                     main
               |                     __libc_start_call_main
               |                     __libc_start_main@@GLIBC_2.34
               |                     _start
               |          
               |--4.52%--set_memory_nx
               |          |          
               |          |--2.32%--execmem_alloc_rw
               |          |          arch_bpf_trampoline_size
               |          |          bpf_trampoline_update
               |          |          __bpf_trampoline_link_prog
               |          |          bpf_trampoline_multi_attach
               |          |          bpf_tracing_multi_attach
               |          |          __sys_bpf
               |          |          __x64_sys_bpf
               |          |          do_syscall_64
               |          |          entry_SYSCALL_64_after_hwframe
               |          |          syscall
               |          |          sys_bpf_fd
               |          |          bpf_link_create
               |          |          bpf_program__attach_tracing_multi
               |          |          serial_test_tracing_multi_bench_attach
               |          |          run_one_test
               |          |          main
               |          |          __libc_start_call_main
               |          |          __libc_start_main@@GLIBC_2.34
               |          |          _start
               |          |          
               |           --2.20%--__execmem_cache_free
               |                     execmem_free
               |                     arch_bpf_trampoline_size
               |                     bpf_trampoline_update
               |                     __bpf_trampoline_link_prog
               |                     bpf_trampoline_multi_attach
               |                     bpf_tracing_multi_attach
               |                     __sys_bpf
               |                     __x64_sys_bpf
               |                     do_syscall_64
               |                     entry_SYSCALL_64_after_hwframe
               |                     syscall
               |                     sys_bpf_fd
               |                     bpf_link_create
               |                     bpf_program__attach_tracing_multi
               |                     serial_test_tracing_multi_bench_attach
               |                     run_one_test
               |                     main
               |                     __libc_start_call_main
               |                     __libc_start_main@@GLIBC_2.34
               |                     _start
               |          
                --2.01%--set_memory_rox
                          |          
                           --2.01%--__execmem_cache_free
                                     execmem_free
                                     arch_bpf_trampoline_size
                                     bpf_trampoline_update
                                     __bpf_trampoline_link_prog
                                     bpf_trampoline_multi_attach
                                     bpf_tracing_multi_attach
                                     __sys_bpf
                                     __x64_sys_bpf
                                     do_syscall_64
                                     entry_SYSCALL_64_after_hwframe
                                     syscall
                                     sys_bpf_fd
                                     bpf_link_create
                                     bpf_program__attach_tracing_multi
                                     serial_test_tracing_multi_bench_attach
                                     run_one_test
                                     main
                                     __libc_start_call_main
                                     __libc_start_main@@GLIBC_2.34
                                     _start

     6.15%  test_progs  [kernel.kallsyms]  [k] smp_call_function_many_cond
            |
            ---smp_call_function_many_cond
               on_each_cpu_cond_mask
               |          
               |--4.80%--cpa_flush
               |          change_page_attr_set_clr
               |          |          
               |          |--2.37%--set_memory_rox
               |          |          __execmem_cache_free
               |          |          execmem_free
               |          |          arch_bpf_trampoline_size
               |          |          bpf_trampoline_update
               |          |          __bpf_trampoline_link_prog
               |          |          bpf_trampoline_multi_attach
               |          |          bpf_tracing_multi_attach
               |          |          __sys_bpf
               |          |          __x64_sys_bpf
               |          |          do_syscall_64
               |          |          entry_SYSCALL_64_after_hwframe
               |          |          syscall
               |          |          sys_bpf_fd
               |          |          bpf_link_create
               |          |          bpf_program__attach_tracing_multi
               |          |          serial_test_tracing_multi_bench_attach
               |          |          run_one_test
               |          |          main
               |          |          __libc_start_call_main
               |          |          __libc_start_main@@GLIBC_2.34
               |          |          _start
               |          |          
               |          |--1.21%--set_memory_nx
               |          |          execmem_alloc_rw
               |          |          arch_bpf_trampoline_size
               |          |          bpf_trampoline_update
               |          |          __bpf_trampoline_link_prog
               |          |          bpf_trampoline_multi_attach
               |          |          bpf_tracing_multi_attach
               |          |          __sys_bpf
               |          |          __x64_sys_bpf
               |          |          do_syscall_64
               |          |          entry_SYSCALL_64_after_hwframe
               |          |          syscall
               |          |          sys_bpf_fd
               |          |          bpf_link_create
               |          |          bpf_program__attach_tracing_multi
               |          |          serial_test_tracing_multi_bench_attach
               |          |          run_one_test
               |          |          main
               |          |          __libc_start_call_main
               |          |          __libc_start_main@@GLIBC_2.34
               |          |          _start
               |          |          
               |           --1.21%--set_memory_rw
               |                     execmem_alloc_rw
               |                     |          
               |                      --1.21%--arch_bpf_trampoline_size
               |                                bpf_trampoline_update
               |                                __bpf_trampoline_link_prog
               |                                bpf_trampoline_multi_attach
               |                                bpf_tracing_multi_attach
               |                                __sys_bpf
               |                                __x64_sys_bpf
               |                                do_syscall_64
               |                                entry_SYSCALL_64_after_hwframe
               |                                syscall
               |                                sys_bpf_fd
               |                                bpf_link_create
               |                                bpf_program__attach_tracing_multi
               |                                serial_test_tracing_multi_bench_attach
               |                                run_one_test
               |                                main
               |                                __libc_start_call_main
               |                                __libc_start_main@@GLIBC_2.34
               |                                _start
               |          
                --1.21%--__change_page_attr_set_clr
                          change_page_attr_set_clr
                          set_memory_nx
                          execmem_alloc_rw
                          |          
                           --1.20%--arch_bpf_trampoline_size
                                     bpf_trampoline_update
                                     __bpf_trampoline_link_prog
                                     bpf_trampoline_multi_attach
                                     bpf_tracing_multi_attach
                                     __sys_bpf
                                     __x64_sys_bpf
                                     do_syscall_64
                                     entry_SYSCALL_64_after_hwframe
                                     syscall
                                     sys_bpf_fd
                                     bpf_link_create
                                     bpf_program__attach_tracing_multi
                                     serial_test_tracing_multi_bench_attach
                                     run_one_test
                                     main
                                     __libc_start_call_main
                                     __libc_start_main@@GLIBC_2.34
                                     _start

     5.01%  test_progs  [kernel.kallsyms]  [k] __raw_callee_save___pv_queued_spin_unlock
            |
            ---__raw_callee_save___pv_queued_spin_unlock
               do_raw_spin_unlock
               |          
               |--4.20%--_raw_spin_unlock
               |          |          
               |           --4.10%--decay_va_pool_node
               |                     __purge_vmap_area_lazy
               |                     _vm_unmap_aliases
               |                     change_page_attr_set_clr
               |                     |          
               |                     |--1.73%--set_memory_nx
               |                     |          |          
               |                     |          |--0.95%--__execmem_cache_free
               |                     |          |          execmem_free
               |                     |          |          arch_bpf_trampoline_size
               |                     |          |          bpf_trampoline_update
               |                     |          |          __bpf_trampoline_link_prog
               |                     |          |          bpf_trampoline_multi_attach
               |                     |          |          bpf_tracing_multi_attach
               |                     |          |          __sys_bpf
               |                     |          |          __x64_sys_bpf
               |                     |          |          do_syscall_64
               |                     |          |          entry_SYSCALL_64_after_hwframe
               |                     |          |          syscall
               |                     |          |          sys_bpf_fd
               |                     |          |          bpf_link_create
               |                     |          |          bpf_program__attach_tracing_multi
               |                     |          |          serial_test_tracing_multi_bench_attach
               |                     |          |          run_one_test
               |                     |          |          main
               |                     |          |          __libc_start_call_main
               |                     |          |          __libc_start_main@@GLIBC_2.34
               |                     |          |          _start
               |                     |          |          
               |                     |           --0.78%--execmem_alloc_rw
               |                     |                     arch_bpf_trampoline_size
               |                     |                     bpf_trampoline_update
               |                     |                     __bpf_trampoline_link_prog
               |                     |                     bpf_trampoline_multi_attach
               |                     |                     bpf_tracing_multi_attach
               |                     |                     __sys_bpf
               |                     |                     __x64_sys_bpf
               |                     |                     do_syscall_64
               |                     |                     entry_SYSCALL_64_after_hwframe
               |                     |                     syscall
               |                     |                     sys_bpf_fd
               |                     |                     bpf_link_create
               |                     |                     bpf_program__attach_tracing_multi
               |                     |                     serial_test_tracing_multi_bench_attach
               |                     |                     run_one_test
               |                     |                     main
               |                     |                     __libc_start_call_main
               |                     |                     __libc_start_main@@GLIBC_2.34
               |                     |                     _start
               |                     |          
               |                     |--1.51%--set_memory_rw
               |                     |          |          
               |                     |          |--0.76%--__execmem_cache_free
               |                     |          |          execmem_free
               |                     |          |          arch_bpf_trampoline_size
               |                     |          |          bpf_trampoline_update
               |                     |          |          __bpf_trampoline_link_prog
               |                     |          |          bpf_trampoline_multi_attach
               |                     |          |          bpf_tracing_multi_attach
               |                     |          |          __sys_bpf
               |                     |          |          __x64_sys_bpf
               |                     |          |          do_syscall_64
               |                     |          |          entry_SYSCALL_64_after_hwframe
               |                     |          |          syscall
               |                     |          |          sys_bpf_fd
               |                     |          |          bpf_link_create
               |                     |          |          bpf_program__attach_tracing_multi
               |                     |          |          serial_test_tracing_multi_bench_attach
               |                     |          |          run_one_test
               |                     |          |          main
               |                     |          |          __libc_start_call_main
               |                     |          |          __libc_start_main@@GLIBC_2.34
               |                     |          |          _start
               |                     |          |          
               |                     |           --0.75%--execmem_alloc_rw
               |                     |                     arch_bpf_trampoline_size
               |                     |                     bpf_trampoline_update
               |                     |                     __bpf_trampoline_link_prog
               |                     |                     bpf_trampoline_multi_attach
               |                     |                     bpf_tracing_multi_attach
               |                     |                     __sys_bpf
               |                     |                     __x64_sys_bpf
               |                     |                     do_syscall_64
               |                     |                     entry_SYSCALL_64_after_hwframe
               |                     |                     syscall
               |                     |                     sys_bpf_fd
               |                     |                     bpf_link_create
               |                     |                     bpf_program__attach_tracing_multi
               |                     |                     serial_test_tracing_multi_bench_attach
               |                     |                     run_one_test
               |                     |                     main
               |                     |                     __libc_start_call_main
               |                     |                     __libc_start_main@@GLIBC_2.34
               |                     |                     _start
               |                     |          
               |                      --0.86%--set_memory_rox
               |                                __execmem_cache_free
               |                                execmem_free
               |                                arch_bpf_trampoline_size
               |                                bpf_trampoline_update
               |                                __bpf_trampoline_link_prog
               |                                bpf_trampoline_multi_attach
               |                                bpf_tracing_multi_attach
               |                                __sys_bpf
               |                                __x64_sys_bpf
               |                                do_syscall_64
               |                                entry_SYSCALL_64_after_hwframe
               |                                syscall
               |                                sys_bpf_fd
               |                                bpf_link_create
               |                                bpf_program__attach_tracing_multi
               |                                serial_test_tracing_multi_bench_attach
               |                                run_one_test
               |                                main
               |                                __libc_start_call_main
               |                                __libc_start_main@@GLIBC_2.34
               |                                _start
               |          
                --0.80%--_raw_spin_unlock_irqrestore

     4.88%  test_progs  [kernel.kallsyms]  [k] get_symbol_offset
