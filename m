Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0A91400C
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650659; cv=none; b=RDV865ZYU75Xrhrnv8RmYGUz7veuwEUsZ4avMELhrFPZML5YxgHn27LdwwnfBxN4Leoze9r3GkBYTJhMY3FERXBw/Vn2p3c0m2bvIlVWsvEWl6xKrjCGB+hNW4NcWheqztxIJiMH4TIDxoojq+XsweQeuOPkcCIrJU834m+MGx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650659; c=relaxed/simple;
	bh=Ss/Dk7HKAPBgdZ75gIt3DSVn8ZPrTTOhtC+rgEPbgzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uE/ps5J4IlbXcSl2K/Xhv3LOymAcqMKkYPHKv4CPMMk3BQMvvURpR/Ew3B4t6GhVhQBMyHVdanF4H3gdx+YzfSOEm+kYzC0M15Sj/tD5QOJwz0CbKKAYifyhiZnF0rloQSBUU8TDpxMwe/fUowXQhx+garzwOpKdoY3ATwREL5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HYv2Sorr; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HYv2Sorr"
Message-ID: <409f3694-a054-4288-acd9-7900cc8f8620@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775650646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCe6yHxvdCB9KMrSJ7+8qfyoOcjewy/DzytuzavN8EU=;
	b=HYv2Sorr07JRxjKP0O4fmZUTNBilylbcIaxchrH6e8LaSHkeKwhQqBgbdGJiMFcBn38mab
	Ged5RGse1q/di0Vbsj1FoPfmStUZumvOqi2j/TZMH6vmp9wcutEe67+aDJ+Bfss6qwWx6w
	T68mdBpovtl0Gw6f20ORP/CAqcaxJF0=
Date: Wed, 8 Apr 2026 20:16:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: Fix Null-Pointer Dereference in kernel_clone()
 via BPF fmod_ret on security_task_alloc
To: Feng Yang <yangfeng59949@163.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
 mattbobrowski@google.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260408094816.228322-1-yangfeng59949@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260408094816.228322-1-yangfeng59949@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/8/26 5:48 PM, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>


[...]

>
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> index 643809cc78c3..434ae335b188 100644
> --- a/include/linux/bpf_lsm.h
> +++ b/include/linux/bpf_lsm.h
> @@ -48,6 +48,8 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog, bpf_func_t *bpf_func)
>   
>   int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
>   			     struct bpf_retval_range *range);
> +void bpf_security_get_retval_range(const struct bpf_prog *prog,
> +				   struct bpf_retval_range *range);
>   int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
>   				const struct bpf_dynptr *value_p, int flags);
>   int bpf_remove_dentry_xattr_locked(struct dentry *dentry, const char *name__str);
> @@ -91,6 +93,12 @@ static inline int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
>   {
>   	return -EOPNOTSUPP;
>   }
> +
> +static inline void bpf_security_get_retval_range(const struct bpf_prog *prog,
> +						 struct bpf_retval_range *range)
> +{
> +}
> +
>   static inline int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
>   					      const struct bpf_dynptr *value_p, int flags)
>   {
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index c5c925f00202..537af87b3d5d 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -448,3 +448,29 @@ int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
>   	}
>   	return 0;
>   }
> +
> +/* hooks return 0 or 1 */
> +BTF_SET_START(bool_security_hooks)
> +#ifdef CONFIG_SECURITY_NETWORK_XFRM
> +BTF_ID(func, security_xfrm_state_pol_flow_match)
> +#endif
> +#ifdef CONFIG_AUDIT
> +BTF_ID(func, security_audit_rule_known)
> +#endif
> +BTF_ID(func, security_inode_xattr_skipcap)
> +BTF_SET_END(bool_security_hooks)
> +
> +/* Similar to bpf_lsm_get_retval_range,
> + * ensure that the return values of fmod_ret are valid.
> + */
> +void bpf_security_get_retval_range(const struct bpf_prog *prog,
> +				   struct bpf_retval_range *retval_range)
> +{
> +	if (btf_id_set_contains(&bool_security_hooks, prog->aux->attach_btf_id)) {
> +		retval_range->minval = 0;
> +		retval_range->maxval = 1;
> +	} else {
> +		retval_range->minval = -MAX_ERRNO;
> +		retval_range->maxval = 0;
> +	}
> +}
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 594260c1f382..3bfc67983e12 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18413,8 +18413,10 @@ static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_
>   			*range = retval_range(0, 0);
>   			break;
>   		case BPF_TRACE_RAW_TP:
> -		case BPF_MODIFY_RETURN:
>   			return false;
> +		case BPF_MODIFY_RETURN:
> +			bpf_security_get_retval_range(env->prog, range);
> +			break;

This is a breaking change. The verifier rejection log should be more 
descriptive
so users can understand why their program is being rejected.

>   		case BPF_TRACE_ITER:
>   		default:
>   			break;

Also, I think a whitelist approach would be better here.
The known danger is specifically those security hooks whose return 
values get fed into ERR_PTR() by callers, such as:
- security_task_alloc
- security_inode_readlink
- security_task_movememory
- security_inode_follow_link
- security_fs_context_submount
- security_dentry_create_files_as
- security_perf_event_alloc
- security_inode_get_acl

