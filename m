Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD875336ECF;
	Wed, 15 Jul 2026 22:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154747; cv=none; b=gWWQXUeGehwHi9vwc51jQ53V8EwbgecmVSxqbJ86MOpt2KLa6UnIzYvnaZSthtl77hHuxCpMIJek71KbIZc1icAO7hwuSgCZ92zQ2Ui1UGhF/HCgHmj28ia07NXEOFz7kvTWCu1bA5pN5j0Na4qEgOpASLCSpDOJlWoxo87Qqvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154747; c=relaxed/simple;
	bh=v6UnbEl6wtevm0YwMl33mQf41hlrKhET7+So+dgKTtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dIwhdo/OBqzLibUbAyATy3wnwhU6JGnpD1kJ0+6YTZsj0MeRH7cN8yYHc8/k7QaeUvFbNyPkOKD2x6al84EE6ygeaXmesavo9WMwFpp2Qm2UGw+C9ktRbG5/vE16V7Lji9RBSP0rpIfXPp1hVeJOiZt6q6Y1Xayl4AFUwhmH2KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tEjbGCM8; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tEjbGCM8"
Message-ID: <f81c714b-7e2a-4939-ba12-694cc7393672@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784154743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xGUzmJJCNBdhajb8ciTEO3mxU7nSLorCv6Xhr0b2els=;
	b=tEjbGCM86yYGK2U6LFeb+Sjg8SpVzs/ZopKBG0Cdf+HwTlgbZfLnYcZGwldxDhBEBrJZ5b
	kDDO/szK9UnUl+62Q33ieel0hHLYWI8z6zJi69z+BFjOM4Cv9JStWoXAgrZ1exBwZcqCAd
	lljCLjtXRUBdKmM9nAy5SSdNmdEFMKU=
Date: Wed, 15 Jul 2026 15:32:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 08/10] selftests/bpf: add helpers for KASAN in
 JIT testing
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
 <20260709-kasan-v5-8-1c64af8e4e1e@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260709-kasan-v5-8-1c64af8e4e1e@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/9/26 3:01 AM, Alexis LothorÃ© (eBPF Foundation) wrote:
> Add two simple helpers to allow checking whether KASAN for eBPF tests
> should be executed:
> - one helper to check if BPF_JIT_KASAN is enabled in kernel
>   configuration
> - one helper to check if the kernel is running with kasan_multi_shot
>   (otherwise only the first test will be able to trigger a report)
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
> Changes in v5:
> - add kasan_multi_shot helper
> 
> Changes in v2:
> - fix condition
> ---
>  tools/testing/selftests/bpf/unpriv_helpers.c | 10 ++++++++++
>  tools/testing/selftests/bpf/unpriv_helpers.h |  2 ++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/unpriv_helpers.c b/tools/testing/selftests/bpf/unpriv_helpers.c
> index f997d7ec8fd0..95be83937883 100644
> --- a/tools/testing/selftests/bpf/unpriv_helpers.c
> +++ b/tools/testing/selftests/bpf/unpriv_helpers.c
> @@ -142,3 +142,13 @@ bool get_unpriv_disabled(void)
>  	}
>  	return mitigations_off;
>  }
> +
> +bool get_kasan_jit_enabled(void)
> +{
> +	return config_contains("CONFIG_BPF_JIT_KASAN=y") == 1;
> +}
> +
> +bool get_kasan_multi_shot_enabled(void)
> +{
> +	return cmdline_contains("kasan_multi_shot");
> +}

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

> diff --git a/tools/testing/selftests/bpf/unpriv_helpers.h b/tools/testing/selftests/bpf/unpriv_helpers.h
> index 151f67329665..a7ceb51577cd 100644
> --- a/tools/testing/selftests/bpf/unpriv_helpers.h
> +++ b/tools/testing/selftests/bpf/unpriv_helpers.h
> @@ -5,3 +5,5 @@
>  #define UNPRIV_SYSCTL "kernel/unprivileged_bpf_disabled"
>  
>  bool get_unpriv_disabled(void);
> +bool get_kasan_jit_enabled(void);
> +bool get_kasan_multi_shot_enabled(void);
> 

