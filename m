Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2BF34250D
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775812854; cv=none; b=E/ByCR3Ui/CfmQk3pFvExl07JkA/rYEjqQo3cYy6iQhxIvtusPH4bGAQhxwifEckfbz2RLfhAsGcsmQk4VPa7+YhaRVX07PeeM709mg7seXIRqMOKdXYOeDncXDR35DdKk++VdrdG+GlXQIVDbVYwKwawbcSELaOf5Y/I7xrH/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775812854; c=relaxed/simple;
	bh=V/vf16GejALlK4E9buxiC/OWuftotySClepbK8Zv2m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tsoqHVsWujgW32jPIBvvw3qnqlrBlyyvdH6quce6menN569v+PWqOCrDsaLa4FLGwD6owM5vP51xAJDINLkqV9QtJBS691IbMZz3SeylM2Tcf12M22edh72avh47Pkcaj12ZYqyQ8l4t2KPCTgxcRaLZcE70Az3AvfSfjr5oJpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MY9XOqsF; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MY9XOqsF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775812841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BGHABlTQWHWLM4iRZtcw+vpop0XeHoiwY51eRMiiHIQ=;
	b=MY9XOqsF7/XqqEDLgsS7PxbRWjf0S/C7uAZrbcwdGVgbDQFChHBPR2RNEUcDuNgbXUEbad
	NxiFrKt74hc0kVR8H9JnUc1EnuumeJQI0nJ0rjQgIhiAXw8zi/XoeFCcw8ul1LTSOXgC+m
	4AQM0LOJKhmRgJac92Dvgd+Tf12sm3E=
From: Menglong Dong <menglong.dong@linux.dev>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, mattbobrowski@google.com, jiayuan.chen@linux.dev,
 Feng Yang <yangfeng59949@163.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject:
 Re: [PATCH v2 bpf-next 1/2] bpf: Fix Null-Pointer Dereference in
 kernel_clone() via BPF fmod_ret on security_task_alloc
Date: Fri, 10 Apr 2026 17:20:28 +0800
Message-ID: <13985062.uLZWGnKmhe@7940hx>
In-Reply-To: <20260410061037.149532-2-yangfeng59949@163.com>
References:
 <20260410061037.149532-1-yangfeng59949@163.com>
 <20260410061037.149532-2-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/4/10 14:10 Feng Yang <yangfeng59949@163.com> write:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> Using the following BPF program will cause a kernel panic:
> SEC("fmod_ret/security_task_alloc")
> int fmod_task_alloc(void *ctx)
> {
>         return 1;
> }
> 
[...]
> +
> +static int check_attach_modify_return(unsigned long addr, const char *func_name)
> +{
> +	if (within_error_injection_list(addr) ||
> +	    !strncmp(SECURITY_PREFIX, func_name, sizeof(SECURITY_PREFIX) - 1))
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
> +static int modify_return_get_retval_range(const struct bpf_prog *prog,
> +					  struct bpf_retval_range *retval_range)
> +{
> +	unsigned long addr = (unsigned long)prog->aux->dst_trampoline->func.addr;
> +
> +	if (within_error_injection_list(addr)) {
> +		switch (get_injectable_error_type(addr)) {
> +		case EI_ETYPE_NULL:
> +			retval_range->minval = 0;
> +			retval_range->maxval = 0;
> +			break;
> +		case EI_ETYPE_ERRNO:
> +			retval_range->minval = -MAX_ERRNO;
> +			retval_range->maxval = -1;
> +			break;
> +		case EI_ETYPE_ERRNO_NULL:
> +			retval_range->minval = -MAX_ERRNO;
> +			retval_range->maxval = 0;
> +			break;
> +		case EI_ETYPE_TRUE:
> +			retval_range->minval = 1;
> +			retval_range->maxval = 1;
> +			break;
> +		}

MODIFY_RETURN should always be able to return 0. 0 means
that "not modify the return and call the target function". So
the return value here should not restrict it.

I think it's a limitation of the MODIFY_RETURN, as it can't modify
the return value to 0/false. Maybe we can introduce a kfunc, such
as bpf_set_return_zero(), but it will be complex, as we need do
some adjustment to the trampoline, which I suspect Alexei won't
like it.

However, it's another problem. So, for this patch, I think we need
to make retval_range always cover "0".

BTW, I see you've moved some code upwards, which is not very
friendly for review and will also make the patch relatively large.
I suggest you declare modify_return_get_retval_range and
bpf_security_get_retval_range at the beginning of the file instead.

Thanks!
Menglong Dong

> +		retval_range->return_32bit = true;
> +
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +#else
> +
> +/* Unfortunately, the arch-specific prefixes are hard-coded in arch syscall code
> + * so we need to hard-code them, too. Ftrace has arch_syscall_match_sym_name()
> + * but that just compares two concrete function names.
> + */
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
> +	return !strncmp(func_name, "sys_", 4);
> +#elif defined(__loongarch__)
> +	return !strncmp(func_name, "sys_", 4);
> +#else
> +	return false;
> +#endif
> +}
> +
> +/* Without error injection, allow sleepable and fmod_ret progs on syscalls. */
> +
> +static int check_attach_sleepable(u32 btf_id, unsigned long addr, const char *func_name)
> +{
> +	if (has_arch_syscall_prefix(func_name))
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
> +static int check_attach_modify_return(unsigned long addr, const char *func_name)
> +{
> +	if (has_arch_syscall_prefix(func_name) ||
> +	    !strncmp(SECURITY_PREFIX, func_name, sizeof(SECURITY_PREFIX) - 1))
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
> +/* The system call return value is allowed to be an arbitrary value. */
> +static int modify_return_get_retval_range(const struct bpf_prog *prog,
> +					  struct bpf_retval_range *retval_range)
> +{
> +	return -EINVAL;
> +}
> +
> +#endif /* CONFIG_FUNCTION_ERROR_INJECTION */
> +
> +/* hooks return 0 or 1 */
> +BTF_SET_START(bool_security_hooks)
> +BTF_ID(func, security_xfrm_state_pol_flow_match)
> +BTF_ID(func, security_audit_rule_known)
> +BTF_ID(func, security_inode_xattr_skipcap)
> +BTF_SET_END(bool_security_hooks)
> +
> +/* Similar to bpf_lsm_get_retval_range,
> + * ensure that the return values of fmod_ret are valid.
> + */
> +static int bpf_security_get_retval_range(const struct bpf_prog *prog,
> +					 struct bpf_retval_range *retval_range)
> +{
> +	if (strncmp(SECURITY_PREFIX, prog->aux->attach_func_name,
> +		    sizeof(SECURITY_PREFIX) - 1))
> +		return -EINVAL;
> +
> +	if (btf_id_set_contains(&bool_security_hooks, prog->aux->attach_btf_id)) {
> +		retval_range->minval = 0;
> +		retval_range->maxval = 1;
> +	} else {
> +		retval_range->minval = -MAX_ERRNO;
> +		retval_range->maxval = 0;
> +	}
> +	retval_range->return_32bit = true;
> +
> +	return 0;
> +}
>  
>  static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_range *range)
>  {
> @@ -18444,8 +18605,13 @@ static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_
>  			*range = retval_range(0, 0);
>  			break;
>  		case BPF_TRACE_RAW_TP:
> -		case BPF_MODIFY_RETURN:
>  			return false;
> +		case BPF_MODIFY_RETURN:
> +			if (!bpf_security_get_retval_range(env->prog, range))
> +				break;
> +			if (modify_return_get_retval_range(env->prog, range))
> +				return false;
> +			break;
>  		case BPF_TRACE_ITER:
>  		default:
>  			break;
> @@ -25487,99 +25653,6 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
>  	return bpf_prog_ctx_arg_info_init(prog, st_ops_desc->arg_info[member_idx].info,
>  					  st_ops_desc->arg_info[member_idx].cnt);
>  }
> -#define SECURITY_PREFIX "security_"
> -
> -#ifdef CONFIG_FUNCTION_ERROR_INJECTION
> -
> -/* list of non-sleepable functions that are otherwise on
> - * ALLOW_ERROR_INJECTION list
> - */
> -BTF_SET_START(btf_non_sleepable_error_inject)
> -/* Three functions below can be called from sleepable and non-sleepable context.
> - * Assume non-sleepable from bpf safety point of view.
> - */
> -BTF_ID(func, __filemap_add_folio)
> -#ifdef CONFIG_FAIL_PAGE_ALLOC
> -BTF_ID(func, should_fail_alloc_page)
> -#endif
> -#ifdef CONFIG_FAILSLAB
> -BTF_ID(func, should_failslab)
> -#endif
> -BTF_SET_END(btf_non_sleepable_error_inject)
> -
> -static int check_non_sleepable_error_inject(u32 btf_id)
> -{
> -	return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
> -}
> -
> -static int check_attach_sleepable(u32 btf_id, unsigned long addr, const char *func_name)
> -{
> -	/* fentry/fexit/fmod_ret progs can be sleepable if they are
> -	 * attached to ALLOW_ERROR_INJECTION and are not in denylist.
> -	 */
> -	if (!check_non_sleepable_error_inject(btf_id) &&
> -	    within_error_injection_list(addr))
> -		return 0;
> -
> -	return -EINVAL;
> -}
> -
> -static int check_attach_modify_return(unsigned long addr, const char *func_name)
> -{
> -	if (within_error_injection_list(addr) ||
> -	    !strncmp(SECURITY_PREFIX, func_name, sizeof(SECURITY_PREFIX) - 1))
> -		return 0;
> -
> -	return -EINVAL;
> -}
> -
> -#else
> -
> -/* Unfortunately, the arch-specific prefixes are hard-coded in arch syscall code
> - * so we need to hard-code them, too. Ftrace has arch_syscall_match_sym_name()
> - * but that just compares two concrete function names.
> - */
> -static bool has_arch_syscall_prefix(const char *func_name)
> -{
> -#if defined(__x86_64__)
> -	return !strncmp(func_name, "__x64_", 6);
> -#elif defined(__i386__)
> -	return !strncmp(func_name, "__ia32_", 7);
> -#elif defined(__s390x__)
> -	return !strncmp(func_name, "__s390x_", 8);
> -#elif defined(__aarch64__)
> -	return !strncmp(func_name, "__arm64_", 8);
> -#elif defined(__riscv)
> -	return !strncmp(func_name, "__riscv_", 8);
> -#elif defined(__powerpc__) || defined(__powerpc64__)
> -	return !strncmp(func_name, "sys_", 4);
> -#elif defined(__loongarch__)
> -	return !strncmp(func_name, "sys_", 4);
> -#else
> -	return false;
> -#endif
> -}
> -
> -/* Without error injection, allow sleepable and fmod_ret progs on syscalls. */
> -
> -static int check_attach_sleepable(u32 btf_id, unsigned long addr, const char *func_name)
> -{
> -	if (has_arch_syscall_prefix(func_name))
> -		return 0;
> -
> -	return -EINVAL;
> -}
> -
> -static int check_attach_modify_return(unsigned long addr, const char *func_name)
> -{
> -	if (has_arch_syscall_prefix(func_name) ||
> -	    !strncmp(SECURITY_PREFIX, func_name, sizeof(SECURITY_PREFIX) - 1))
> -		return 0;
> -
> -	return -EINVAL;
> -}
> -
> -#endif /* CONFIG_FUNCTION_ERROR_INJECTION */
>  
>  int bpf_check_attach_target(struct bpf_verifier_log *log,
>  			    const struct bpf_prog *prog,
> -- 
> 2.43.0
> 
> 
> 




