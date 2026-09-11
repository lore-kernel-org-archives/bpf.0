Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9180145D902
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 08:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116102; cv=none; b=Y7yeDHLsO56xNkZi0t0EGYCyLRWNAeyofhrNWUrYWyhG62QOU9DaGNBLnElvSJN7RdE4GLg3007KzAqJZvB3N2EoPZkfI8Gvcj3LozDV7QD553TLmnLdb17z0DfILjw91zYOvm5wYTIjYLbiT5TSgGTw1jZdLnQ1V3Xo5K96a9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116102; c=relaxed/simple;
	bh=bAKGZZAtcB22YjUyN0E0BXvuhEg3lH7+KTKSkhyH6nI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sniOtoU59xdaEI1pmF35vt6MDELUEyulkI9D1YHHcJ1Dm4BzctYL3Mx8wh/65J9uOTFcXLA2tjisbBnwFKezxjQBkYPmKkOTrII7411dSYPgKp1p4tQQFbsPxvZlXKmfhR73fUdHmnPSv8ERYSOFe1xSKv0kG09tFd5CEFF/vZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p5jWKXFP; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5jWKXFP"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49e625d5a2fso3033105e9.1
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 01:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789116099; x=1789720899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zFqh0Z3ymXsNZ8CzwCshHZWIQRM7kqFalTjbGJDgPe8=;
        b=p5jWKXFP2TATHdgonnOuK6ujGmIHyUptXEnYU+R17xtOZ38Dw/73rFib2hQTCD6mYf
         hRFiBb2QU7KIvNNtSHAL3uKWPmqI5VeroPRaK1hzS8K8qeUJ52+myQ2yB9Wj4WRknMqi
         /Rj1HLZz0aKSHcsFRXdyoPH9L8uTk1xeEunNbO8e/GE+QrdR2TugU8zvK4CuH56GE9Q0
         84xJhtaqX4zpOnEN92tgll1B5mZXrPqam49JBZIhARl/L5zQyutuVwRncp6S6OOhzuy1
         PRErBIG8oDiX7KQrjvP8/j0lgaf1+Qc+RcKQXJg4nq6ft2TXXxH1IA+yItuQVR5F70Kw
         ljTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789116099; x=1789720899;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zFqh0Z3ymXsNZ8CzwCshHZWIQRM7kqFalTjbGJDgPe8=;
        b=T8aTU8MgLiFmQb/uZpERMARVDVnT+c4unX5JILusEYZiBRLUmERUVcq7pR7qmPQljy
         vcTMMD/o0n9SFDHJzy2QuW+r3ky0knSRy8SX8Cacbd24YYlYVXCqBcs8moJXroPPipfd
         OxNIwWrHnjqfk8LwbKxHxZe1NgHt5poveONZIRuA6u2g15s+ewoaM6qy0f1+1CJ4D+IV
         tK9Dg8ch1ZFRWIAMCOyjiDgoKqAVLSPRtb0Nt4BHV5sIBTYE5XjC9S57QFXuf7dTWWR5
         2nl94YxF/xfIu+3V9cxaoHixqE8pUMwNb1E2fWTN984wDIc7ZX88EIzaCXNdoRmXdz14
         8iVg==
X-Gm-Message-State: AFuF++nklemw0STJrWbfDj135JWXHZTUZ0hDldcwt/nST4V9uPNJQADX
	KYhv05NpQ06UPAiD1ioB4m/e8LN4PdChaBr5QOw0OElppVrQq/wubhlt
X-Gm-Gg: AYBFou06WucD+fUea+aieiZiesfzbOzPLK6vpcYfJQHtNn4qOpuBYG1VIttAWRwenYo
	h8MxWQ2sctKLXh52tX5j4UyJ9eb89ScOuIc0MxoLBeBr4WAR9KzMRCk0WWMWErFtwda6p5wE18r
	E42oWCQXOlgalFTMxttKGThR9hvgqUggq4KOLcjWP27Ad+UlbA6gTtZdiRfhr0GTbF3gX/4mse6
	EJTXZ+VHgwRtguZ7cu5BfOimBHPgVNGgYCdmZk9/KBZS8y0YdE4nkt9vu26Aoewr37a5b3fl1Kr
	kKYo0KPnmxYh8GrZZn7ZKy4zPe9+9Ok2xJI7HBh+ohv9NXtijLNuGyluUpeLZ6QdNwrQZHL2SR5
	ibOzU/s8d+Gihli7GT10Sl7JtjsoLKkiCeFa/dKLRV0Xd703UfdPVzI21lQ0rbDIVxqois9nCNP
	0pPXn9JsKafOjAlyXNnQ4BaAhbd/pYUdPmVTIP36c8GePNNwhtEfIpBv0ZZg==
X-Received: by 2002:a05:600c:3f0d:b0:49c:fa21:1c86 with SMTP id 5b1f17b1804b1-49e619cee90mr30192355e9.27.1789116098711;
        Fri, 11 Sep 2026 01:41:38 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32e8d1sm4307067f8f.11.2026.09.11.01.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 01:41:38 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 11 Sep 2026 10:41:36 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next] bpf, x86: Use global buffer for trampoline
 size generation
Message-ID: <aqO-wNLX-fjdW5pM@krava>
References: <20260910094353.1256316-1-jolsa@kernel.org>
 <20260910095556.706F11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910095556.706F11F000FF@smtp.kernel.org>

On Thu, Sep 10, 2026 at 09:55:56AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Concurrent calls to arch_bpf_trampoline_size() write to the globally shared, unsynchronized `trampoline_size_image` buffer, resulting in a data race (Undefined Behavior) and cache-line contention.
> --
> 
> commit 4c6aeb9264cf2877d767fb9a021802485dd9d3a7
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> bpf, x86: Use global buffer for trampoline size generation
> 
> This commit changes the BPF trampoline size calculation to use a single,
> globally allocated executable memory buffer instead of allocating a temporary
> one per invocation. This change aims to improve attachment time during tracing
> by eliminating the overhead of repeated memory allocations and frees.
> 
> Link: https://lore.kernel.org/bpf/20260907160538.922450-1-jolsa@kernel.org/
> 
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index bba351944202c..9f9b1456dab0d 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> [ ... ]
> > @@ -35,6 +36,21 @@ void __asan_store8(void *p);
> >  
> >  static bool all_callee_regs_used[4] = {true, true, true, true};
> >  
> > +static void *trampoline_size_image;
> > +
> > +static int __init init_trampoline_size_image(void)
> > +{
> > +	/*
> > +	 * The generated trampoline contains calls and jumps with 32bit relative
> > +	 * offsets, so the scratch image must be in the execmem range.
> > +	 * On x86, module data and executable memory share the same address range,
> > +	 * so using EXECMEM_MODULE_DATA to get writable memory.
> > +	 */
> > +	trampoline_size_image = execmem_alloc(EXECMEM_MODULE_DATA, PAGE_SIZE);
> 
> [Severity: Medium]
> Is this global allocation safe against concurrent access? Multiple threads
> could compute trampoline sizes concurrently, for example when attaching BPF
> programs to kernel functions that hash to different buckets in
> trampoline_locks, or when concurrently updating different struct_ops maps.

we can have multiple instances running without the lock, the trampoline
does not depend on already generated code and we do not use the image
we need just the size

> 
> > +	return trampoline_size_image ? 0 : -ENOMEM;
> > +}
> > +late_initcall(init_trampoline_size_image);
> [ ... ]
> > @@ -4000,24 +4016,14 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
> >  			     struct bpf_tramp_nodes *tnodes, void *func_addr)
> >  {
> >  	struct bpf_tramp_image im;
> > -	void *image;
> > -	int ret;
> >  
> > -	/* Allocate a temporary buffer for __arch_prepare_bpf_trampoline().
> > -	 *
> > -	 * We cannot use kvmalloc here, because we need image to be in
> > -	 * module memory range.
> > -	 * Since it must be writable use execmem_alloc(EXECMEM_MODULE_DATA)
> > -	 * that returns writable memory in the module address space.
> > -	 */
> > -	image = execmem_alloc(EXECMEM_MODULE_DATA, PAGE_SIZE);
> > -	if (!image)
> > +	if (!trampoline_size_image)
> >  		return -ENOMEM;
> >  
> > -	ret = __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, image,
> > -					    m, flags, tnodes, func_addr);
> > -	execmem_free(image);
> > -	return ret;
> > +	return __arch_prepare_bpf_trampoline(&im, trampoline_size_image,
> > +					     trampoline_size_image + PAGE_SIZE,
> > +					     trampoline_size_image, m, flags,
> > +					     tnodes, func_addr);
> >  }
> 
> [Severity: Medium]
> When __arch_prepare_bpf_trampoline() writes to trampoline_size_image, could
> this lead to a data race if called concurrently?
> 
> Since trampoline_size_image is globally shared and no lock protects it here,
> writers in emit_code() might overwrite each other's data:
> 
> arch_bpf_trampoline_size()
>   __arch_prepare_bpf_trampoline()
>     emit_code()
>       *(u32 *)ptr = bytes;
> 
> While the memory contents aren't executed, concurrent writes will cause
> undefined behavior and cache-line ping-ponging, which could trigger KCSAN
> warnings and crash systems with panic_on_warn enabled. Should this use a
> per-CPU buffer or have explicit synchronization?

the image for arch_bpf_trampoline_size is just a scratch pad that's
never used/executed, we take just the size, so no problem here

jirka
