Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0508A175A63
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 02:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773023878; cv=none; b=r5LP/YIFHc3Q2CqoYfbKK0TYEQA4UffozZnQEvOxfrdh9Rojpd0tL8+tVLDSE1GMHp2hJCEtfG6KQP1hctTPKickvFkgXUgcVNQEebmTkAUE4+pTbr6JNM7JfYMxK6sSQI528McmuDk++Ju7MMRO3LVVU+ATkirG8jnN4VrzzdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773023878; c=relaxed/simple;
	bh=XnfGttHv/gxje9hj4P1XjiN4+z21nLfieKUk4pPjf7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cOWhrb+G09zSVtcr5RH6M/di1IFrP+s+LumBE40WTayVSpO3rCoWzK5lYoBmTxuyuuJsHi70YWp4hR/XstwEd6N8yk0PvffCTC1k1lH3ixA6RBIKLMBCiaXrVcG8vqQ/Uaf5E469l7ae5+MGiI3/T0D8IdXeRNkDzjyFurKpbhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nVF8mijK; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nVF8mijK"
Message-ID: <4b3512ea-34a5-4ffd-8b73-1b2c95929b77@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773023874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tMIFXahcis/aYdQFkMBMp1gu18NPCw0bCEza3WVW0z8=;
	b=nVF8mijKm2hZwC14EwwI/i69K4O/sQ+QZm/6y0zwI4663K27aa5V1w8eNGc7OobI0H4Q3d
	WAEfMuBWWYh4mkT2cawExfPDf5gfnZx2vsc+A4Dys/hno1luwk0CNSWy3hcBhLQw1Wh6su
	i7v6ApsqyJ1strksJDN8JaHCk+78GTE=
Date: Mon, 9 Mar 2026 10:37:38 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Always allow sleepable programs on
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
References: <cover.1772804199.git.vmalik@redhat.com>
 <df4e8730627c311b18fb0634989070eaa1567c75.1772804199.git.vmalik@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <df4e8730627c311b18fb0634989070eaa1567c75.1772804199.git.vmalik@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/3/26 21:40, Viktor Malik wrote:
> Sleepable BPF programs can only be attached to selected functions. For
> convenience, the error injection list was originally used, which
> contains syscalls and several other functions.
> 
> When error injection is disabled (CONFIG_FUNCTION_ERROR_INJECTION=n),
> that list is empty and sleepable tracing programs are effectively
> unavailable. In such a case, at least enable sleepable programs on
> syscalls. For discussion why syscalls were chosen, see [1].
> 
> To detect that a function is a syscall handler, we check for
> arch-specific prefixes for the most common architectures. Unfortunately,
> the prefixes are hard-coded in arch syscall code so we need to hard-code
> them, too.
> 
> [1] https://lore.kernel.org/bpf/CAADnVQK6qP8izg+k9yV0vdcT-+=axtFQ2fKw7D-2Ei-V6WS5Dw@mail.gmail.com/
> 
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  kernel/bpf/verifier.c | 58 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 52 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d92cf2821657..458fc528ccc6 100644
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
> @@ -24951,6 +24953,55 @@ static int check_non_sleepable_error_inject(u32 btf_id)
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
> +/* Unfortunately, the arch-specific prefixes are hard-coded in arch syscall code
> + * so we need to hard-code them, too. Ftrace has arch_syscall_match_sym_name()
> + * but that just compares two concrete function names.
> + */> +static bool has_arch_syscall_prefix(const char *func_name)
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
> +	return !strncmp(func_name, "sys_", 4);

LoongArch is missing here, as LoongArch supports trampoline.

#elif defined(__loongarch__)
        return !strncmp(func_name, "sys_", 4);

After adding it,

Acked-by: Leon Hwang <leon.hwang@linux.dev>

Thanks,
Leon

> +#else
> +	return false;
> +#endif
> +}
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
> @@ -25230,12 +25281,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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

