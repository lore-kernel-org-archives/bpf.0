Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35C732B98D
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 02:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772762713; cv=none; b=Bx/WIbYkbmNHnwERQ64Vu0Q3lAst3Ebv33eV3E7YuvRtMxk/gFS6mFkjBcFmud2Oj9hMdkWcfJ0JRkjcOCAQsRgbujGqmF44+Y8uzifkkYfeLWsTo5V/z9o2hg0rXtD5fZre2jm4i6CbROeT9dmiVdZ1UaPwfQXER/obhAeB4d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772762713; c=relaxed/simple;
	bh=w6h9R7ZyIwAkX2baKW2aNKHVA1DLz7FkUGhMaZUH3YQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nd0MTpqAC4tOjLKRXXy9Dd2kP5yzhbelSsejzdZUsG9qphhQJCyI/Qmf3ns7yyVSBgfwUMQiUxf5yig/ieMpCGFx4+mOIk4fKFonn24LYK9Hr1qUmp+CVVbKRDEyLLXIZAPkunedgmDLeVSVLN38I56CtK/XZblWS7tjexq21Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uNoc5guE; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uNoc5guE"
Message-ID: <69b41a54-fb91-4924-999a-06ba94edf72a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772762709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ITDNBqsV9f/ZuEaE/cuD61A5ZaMAWP6wJ//bB9+bwbY=;
	b=uNoc5guEu2HgZQdvsueUH+IVfxDjU1/X7TDsSaacnfJmAmuXELEaWWQNI42+iEfAvWHuBW
	EP88R0ohuVKUxlhICOIAuulHVoX60adcJ/JeSssWZtsaFKusou6xy8w3w6M+F+VJ3D8RNI
	xCzNg9jCfPFMNBPDpJ4cEamWuUMSCpw=
Date: Fri, 6 Mar 2026 10:05:00 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] bpf: Always allow sleepable programs on
 syscalls
Content-Language: en-US
To: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Shuah Khan <shuah@kernel.org>
References: <cover.1772721009.git.vmalik@redhat.com>
 <0715e86d7461c20d318594c770b6fa4c71f299c5.1772721009.git.vmalik@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <0715e86d7461c20d318594c770b6fa4c71f299c5.1772721009.git.vmalik@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/3/26 23:25, Viktor Malik wrote:
> Sleepable BPF programs can only be attached to selected functions. For
> convenience, the error injection list was originally used, which
> contains syscalls and several other functions.
> 
> When error injection is disabled (CONFIG_FUNCTION_ERROR_INJECTION=n),
> that list is empty and sleepable tracing programs are effectively
> unavailable. In such a case, at least enable sleepable programs on
> syscalls.
> 
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  kernel/bpf/verifier.c | 54 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 48 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d92cf2821657..cb80a3ddb7a4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -24930,6 +24930,8 @@ static int check_attach_modify_return(unsigned long addr, const char *func_name)
>  	return -EINVAL;
>  }
>  
> +#ifdef CONFIG_FUNCTION_ERROR_INJECTION
> +
>  /* list of non-sleepable functions that are otherwise on
>   * ALLOW_ERROR_INJECTION list
>   */
> @@ -24951,6 +24953,51 @@ static int check_non_sleepable_error_inject(u32 btf_id)
>  	return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
>  }
>  
> +static int check_attach_sleepable(u32 btf_id, unsigned long addr, const char *func_name)
> +{
> +	/* fentry/fexit/fmod_ret progs can be sleepable if they are
> +	 * attached to ALLOW_ERROR_INJECTION and are not in denylist.
> +	 */
> +	if (!check_non_sleepable_error_inject(btf_id) &&
> +	    within_error_injection_list(addr))
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
> +#else
> +
> +static bool has_arch_syscall_prefix(const char *func_name)
> +{
> +#if defined(__x86_64__)
> +	return !strncmp(func_name, "__x64_", 6);
> +#elif defined(__i386__)
> +	return !strncmp(func_name, "__ia32_", 7);
> +#elif defined(__s390x__)
> +	return !strncmp(func_name, "__s390x_", 8);
> +#elif defined(__aarch64__)
> +	return !strncmp(func_name, "__arm64_", 8);
> +#elif defined(__riscv)
> +	return !strncmp(func_name, "__riscv_", 8);
> +#elif defined(__powerpc__) || defined(__powerpc64__)
> +	return !strncmp(func_name, "sys", 3);
> +#else
> +	return false;
> +#endif
> +}

At first glance, it is not a good taste to hard code these prefixes here.

Furthermore, the arch_syscall_match_sym_name() of ftrace does the same
thing. Consider it instead.

Thanks,
Leon

> +
> +/* Without error injection, allow sleepable progs on syscalls. */
> +
> +static int check_attach_sleepable(u32 btf_id, unsigned long addr, const char *func_name)
> +{
> +	if (has_arch_syscall_prefix(func_name))
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
> +#endif /* CONFIG_FUNCTION_ERROR_INJECTION */
> +
>  int bpf_check_attach_target(struct bpf_verifier_log *log,
>  			    const struct bpf_prog *prog,
>  			    const struct bpf_prog *tgt_prog,
> @@ -25230,12 +25277,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  			ret = -EINVAL;
>  			switch (prog->type) {
>  			case BPF_PROG_TYPE_TRACING:
> -
> -				/* fentry/fexit/fmod_ret progs can be sleepable if they are
> -				 * attached to ALLOW_ERROR_INJECTION and are not in denylist.
> -				 */
> -				if (!check_non_sleepable_error_inject(btf_id) &&
> -				    within_error_injection_list(addr))
> +				if (!check_attach_sleepable(btf_id, addr, tname))
>  					ret = 0;
>  				/* fentry/fexit/fmod_ret progs can also be sleepable if they are
>  				 * in the fmodret id set with the KF_SLEEPABLE flag.

