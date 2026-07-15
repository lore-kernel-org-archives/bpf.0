Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD4A242D97
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 00:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784076620; cv=none; b=pxpoGXoIwkUwqOBOcaRyuDSBBC3NJRzmOhlQeMAOSOhBn9ROFpE9qSzc+AJv4oTW3cXTmh0KmnKRJYTfj/tQaIJQh87F9VSjZWenlYfgByih0A1EylDVgVbZvD0e0W4NHLqn61tDaI910cpHTWyh15bt2Ch04wZI9bQHH/kCzjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784076620; c=relaxed/simple;
	bh=8oD83Vg62iWKSoW7nAe1kNmwlMvXhCczRt0wQXGiccY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AP04FsyzwbcNjvhtWM33Q8gLuACMXOFybsZOlop2NspXtv2lTVOTpnXWHDkY61E+zGeapoa5yrfMH5sXcksJrgGV7h9nt7/iO8HZaCUk/5DIGRBTLuBL5HAzvkuvJOFdQf9rT9XoKdeWIzMD8nXWAQ9JgMnT6b0vaatElA12xSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YtdXpQ35; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YtdXpQ35"
Message-ID: <c8c698cc-4083-48e9-bab5-f542a9626f4a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784076612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9CtLT5r3vCFoSDu0jg1wqBwyY2gyOh6s+DJ3Ec/Fg24=;
	b=YtdXpQ35RG4ObUqoqKngCfES8pEIbXCZYuE9hT+HM64hIQkP/nSxamZg9xiEP1jrly+mvk
	1lw7WTiPIaRt68zVdBcjrfB4W3W/mFOLwvrbW3v+2YXAUxm9GXUe2Rx/iYc8SvrT6OP5Aq
	AbNDpu1z8AEmVtdB8CEl/hqQEwYZ0WQ=
Date: Tue, 14 Jul 2026 17:49:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 03/10] bpf: add BPF_JIT_KASAN for KASAN
 instrumentation of JITed programs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Andrey Konovalov <andreyknvl@gmail.com>
Cc: ebpf@linuxfoundation.org,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
 <20260709-kasan-v5-3-1c64af8e4e1e@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260709-kasan-v5-3-1c64af8e4e1e@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/9/26 3:01 AM, Alexis LothorÃ© (eBPF Foundation) wrote:
> Add a new Kconfig option CONFIG_BPF_JIT_KASAN that automatically enables
> generic KASAN (Kernel Address SANitizer) memory access checks for
> JIT-compiled BPF programs as well, when both KASAN (and more
> specifically, generic KASAN with KASAN_VMALLOC) and JIT compiler are
> enabled.

An auto-selected flag makes sense to me.

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Two nits below.

> ... This new Kconfig is not a user selectable one: it is either
> automatically enabled if KASAN is enabled on a compatible platform. When

nit: dangling "either"

> enabled, the JIT compiler will emit shadow memory checks before memory
> loads and stores to detect use-after-free or out-of-bounds accesses at
> runtime. The option is gated behind HAVE_EBPF_JIT_KASAN, as it needs
> proper arch-specific implementation.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
> Changes in v4:
> - reorganize dependencies (Andrey)
> - drop VMAP_STACK dependency
> 
> Changes in v2:
> - add dependency on kasan for vmalloc and vmalloc'ed stack
> ---
>  kernel/bpf/Kconfig | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> index eb3de35734f0..e1f3850d2f5a 100644
> --- a/kernel/bpf/Kconfig
> +++ b/kernel/bpf/Kconfig
> @@ -17,6 +17,10 @@ config HAVE_CBPF_JIT
>  config HAVE_EBPF_JIT
>  	bool
>  
> +# KASAN support for JIT compiler
> +config HAVE_EBPF_JIT_KASAN
> +	bool
> +
>  # Used by archs to tell that they want the BPF JIT compiler enabled by
>  # default for kernels that were compiled with BPF JIT support.
>  config ARCH_WANT_DEFAULT_BPF_JIT
> @@ -101,4 +105,17 @@ config BPF_LSM
>  
>  	  If you are unsure how to answer this question, answer N.
>  
> +config BPF_JIT_KASAN
> +	bool
> +	depends on HAVE_EBPF_JIT_KASAN
> +	depends on KASAN_GENERIC
> +	depends on KASAN_VMALLOC
> +	depends on BPF_JIT
> +	default y if KASAN

nit: KASAN_GENERIC already implies KASAN, so "if KASAN" is always true
when this symbol is visible, should be safe to drop.

> +	help
> +	  Makes JIT compiler insert generic outline KASAN checks in BPF
> +	  programs when they are inserted in the kernel. This feature is
> +	  automatically enabled if the needed set of KASAN and BPF
> +	  configuration options is enabled.
> +
>  endmenu # "BPF subsystem"
> 

