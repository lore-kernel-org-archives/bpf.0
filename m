Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9CC2765FF
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096321; cv=none; b=agO/mhVod59sAY1L9bTrpnuQrZ8g1RIHHWn9qSkF+VdWKg0Ey4g5h99c6s6EmpuzVlUW5XKFfR/BbsJlOtIHMDPsbxxNMvaEp3tg7Xop+3og2CXcfmB6s9X/WHTECYbHK05ge97m+lOIHTbnvcUcgaaOmkibcoQ2AGEsP1yEUn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096321; c=relaxed/simple;
	bh=Haav5BRpWUPbEyf+45vh440kbB7FGjCxCjc+fDbZghw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AddFU3Maj83L7oJwdXLitfJF0r9RwWToU6juDsL06BCF+U+GG7cOQu7hSDvYjdn9SA9amU/LopA7ddARJ7HClFj6xBNsbmqZ9/QhTZRT+ICt9izYwfN+AKOEWvxEalXDExfVd27cYK53Xi1y5pwJo+mo9csxPGlXio3P11UT0X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKuXJHFi; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKuXJHFi"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9c603ec2dfso604672166b.1
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 09:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776096318; x=1776701118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uFd6HadjNkshoyZxunRfMKZBOl8qSYIOTzH4Sohe50o=;
        b=OKuXJHFiis2eVuUiRxJyF29sxx3eMjrFNAoj/AfXRPjqah6WE7AZqiFyOSZWVPNzuC
         dFuaXxvoihDOh9/amP4Uynmt5aWiBrQ3nH0ISvT1QEHsEVbkWDAscvlSHcL/4BVJ68//
         DN7dckTSk8lZAJrcdpJJgAiKFNfxUIrF1KK8CGO/GsGOlziK0MFMOhzqfTswHl2jwuG6
         p9OO80ETRa1D19FrbHyyxuLy1cEqCsVIVQ6w2sa5KG7ifv5B+TBJWXTQozynqegS+4mV
         6NUUjPUiVK0o5KzOg+ttdpk8mgN7TwFVf1QrTd1UTga20Igs03Pb0JcXpGgXIeFYZRTa
         XZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776096318; x=1776701118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFd6HadjNkshoyZxunRfMKZBOl8qSYIOTzH4Sohe50o=;
        b=TI7X2JTF+oZwnoWBb2Y5k9cTFP3Ykeq6+MCEPI1BASCFSi2GWiUCWNuJNNM1Pdmffz
         ubrAee7+mS8oaaCravWbiTtxt17oJ+0Kh1gq0ogrB3qT5EGbX8Rnf75i6N+Jxg1lJWE2
         vFqK6Gn6ITeIr5k7B8rWkeQPFZzE1KpQflyfW6ps1MXwXCs56eGuUIFHh/23kpxF2U5N
         Qzs8K/bTuT0SNgcXzRT/Lt9rr0J/VvKHbwDLWA1Gbut/xTcZH1t/YDNVZ6kimagGRP/x
         HmnJAZqovjhorjWrwTMG+yUCX/12nkA3cVh6KZciG8SczH4gOG2tDglMW8TCeoZYrgW8
         bs4w==
X-Forwarded-Encrypted: i=1; AFNElJ/xi+zhUt9/wPa5xwDm9ZPCnVKMo76ahYOXSKotQELce+lDnyfipICgw4qXndDvDoK2uDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcqpS3uUbpuhDLBGX/hMHN6cN5XryJYBuIpSAKwDNNzGYpHrPO
	6mt8CcX7hfBppc8aOUjcWJC9Wm5ltw6dPMs/2elTo6ox326MERCWj7Kc
X-Gm-Gg: AeBDiesCIUbhD8sv7prfrOxC5RssHkwnnoC4rf0EqN2TM+TILLn2eBEJr5UW6Rnn8xj
	I6DgTtE81LTQyuRnZNQcZvtWKvtJWQmjvvazFTGmlq+9CoRGkl8RbL/m/zRijLYVTW7mZNeHU92
	4N5sH1feAK5H2adBznKep1UiXRlqIm2XzUI5VnCc1+ElDq4dgNXDC3MWozx4QkDTHeSRD0rh7R4
	NoLyYZ+4KKhIYhfxE7854uuS4H2gqgnArOdUocrL3v2FfmSEd9W+m2K4WPmwov3CKoeIQT/bhA0
	XmfbchpitTKvh5jC6kTeiCD7JYs2j8f1n/y1YOGW2vU2RLG+5fn4qyGRDGrm0Zk/nwTy/lnTI7Y
	kToW8U5jjWwWt744Fnf8EOA2CrQTfWEF6panvKEDzB06JR6vw0kobjVHF2qWmEjnxyPrtcDp1nb
	aCbjbMAhQVp7WerABweu4QSRFZN/roI+Uu47h1IWuOSOz42sCe/ku+yuh81EphenTbeCJJoAJW3
	INC4s+4fC0=
X-Received: by 2002:a17:907:cac:b0:b97:feec:5e82 with SMTP id a640c23a62f3a-b9d72991a15mr541013166b.43.1776096317158;
        Mon, 13 Apr 2026 09:05:17 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:699e:f085:b19f:def1? ([2a02:8109:a307:d900:699e:f085:b19f:def1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e7f1a3bsm314990966b.62.2026.04.13.09.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 09:05:16 -0700 (PDT)
Message-ID: <123ccf9c-a6ec-496a-872d-965e46d07d51@gmail.com>
Date: Mon, 13 Apr 2026 17:05:15 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/1] bpf: Refactor dynptr mutability tracking
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, eddyz87@gmail.com,
 yatsenko@meta.com, martin.lau@kernel.org, kernel-team@meta.com
References: <20260402065013.884228-1-ameryhung@gmail.com>
 <20260402065013.884228-2-ameryhung@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260402065013.884228-2-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/2/26 7:50 AM, Amery Hung wrote:
> Redefine dynptr mutability and fix inconsistency in the verifier and
> kfunc signatures. Dynptr mutability is at two levels. The first is
> the bpf_dynptr structure and the second is the memory the dynptr points
> to. The verifer currently tracks the mutability of the bpf_dynptr struct
> through helper and kfunc prototypes, where "const struct bpf_dynptr *"
> means the structure itself is immutable. The second level is tracked
> in upper bit of bpf_dynptr->size in runtime and is not changed in this
> patch.
> 
> There are two type of inconsistency in the verfier regarding the
> mutability of the bpf_dynptr struct. First, there are many existing
> kfuncs whose prototypes are wrong. For example, bpf_dynptr_adjust()
> mutates a dynptr's start and offset but marks the argument as a const
> pointer. At the same time many other kfuncs that does not mutate the
> dynptr but mark themselves as mutable. Second, the verifier currently
> does not honor the const qualifier in kfunc prototypes as it determines
> whether tagging the arg_type with MEM_RDONLY or not based on the register
> state.
> 
> Since all the verifier care is to prevent CONST_PTR_TO_DYNPTR from
> being destroyed in callback and global subprogram, redefine the
> mutability at the bpf_dynptr level to just bpf_dynptr_kern->data. Then,
> explicitly prohibit passing CONST_PTR_TO_DYNPTR to an argument tagged
> with MEM_UNINIT or OBJ_RELEASE. The mutability of a dynptr's view is not
> really interesting so drop MEM_RDONLY annotation for dynptr from the
> helpers and kfuncs. Plus, if the mutability of the entire bpf_dynptr
> were to be done correctly, it would kill the bpf_dynptr_adjust() usage
> in callback and global subporgram.
> 
> Implementation wise
> 
> - First, make sure all kfunc arg are correctly tagged: Tag the dynptr
>    argument of bpf_dynptr_file_discard() with OBJ_RELEASE.
> - Then, in process_dynptr_func(), make sure CONST_PTR_TO_DYNPTR cannot
>    be passed to argument tagged with MEM_UNINIT or OBJ_RELEASE. For
>    MEM_UNINIT, it is already checked by is_dynptr_reg_valid_uninit().
>    For OBJ_RELEASE, check against OBJ_RELEASE instead of MEM_RDONLY and
>    drop a now identical check in umark_stack_slots_dynptr().
> - Remove the mutual exclusive check between MEM_UNINIT and MEM_RDONLY,
>    but don't add a MEM_UNINIT and OBJ_RELEASE version as it is obviously
>    wrong.
> 
> Note that while this patch stops following the C semantic for the
> mutability of bpf_dynptr, the prototype of kfuncs are still fixed to
> maintain the correct C semantics in the helper implementation. Adding or
> removing the const qualifier does not break backward compatibility.
> 
> In test_kfunc_dynptr_param.c, initialize dynptr to 0 to avoid
> -Wuninitialized-const-pointer warning.
> 
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>   fs/verity/measure.c                           |  2 +-
>   include/linux/bpf.h                           |  8 +--
>   kernel/bpf/btf.c                              |  2 +-
>   kernel/bpf/helpers.c                          | 18 ++---
>   kernel/bpf/verifier.c                         | 68 +++++--------------
>   kernel/trace/bpf_trace.c                      | 18 ++---
>   tools/testing/selftests/bpf/bpf_kfuncs.h      |  8 +--
>   .../selftests/bpf/progs/dynptr_success.c      |  6 +-
>   .../bpf/progs/test_kfunc_dynptr_param.c       |  9 +--
>   9 files changed, 51 insertions(+), 88 deletions(-)
> 
> diff --git a/fs/verity/measure.c b/fs/verity/measure.c
> index 6a35623ebdf0..3840436e4510 100644
> --- a/fs/verity/measure.c
> +++ b/fs/verity/measure.c
> @@ -118,7 +118,7 @@ __bpf_kfunc_start_defs();
>    *
>    * Return: 0 on success, a negative value on error.
>    */
> -__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bpf_dynptr *digest_p)
> +__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, const struct bpf_dynptr *digest_p)
>   {
>   	struct bpf_dynptr_kern *digest_ptr = (struct bpf_dynptr_kern *)digest_p;

maybe we can make this digest_ptr const as well, otherwise it's a little 
bit strange to introduce const, but cast to non-const kernel struct 
immediately. I think we can apply this in other kfuncs.

>   	const struct inode *inode = file_inode(file);
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 05b34a6355b0..329b78940b79 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3621,8 +3621,8 @@ static inline int bpf_fd_reuseport_array_update_elem(struct bpf_map *map,
>   struct bpf_key *bpf_lookup_user_key(s32 serial, u64 flags);
>   struct bpf_key *bpf_lookup_system_key(u64 id);
>   void bpf_key_put(struct bpf_key *bkey);
> -int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
> -			       struct bpf_dynptr *sig_p,
> +int bpf_verify_pkcs7_signature(const struct bpf_dynptr *data_p,
> +			       const struct bpf_dynptr *sig_p,
>   			       struct bpf_key *trusted_keyring);
>   
>   #else

...

>   		err = mark_stack_slots_dynptr(env, reg, arg_type, insn_idx, clone_ref_obj_id);
> -	} else /* MEM_RDONLY and None case from above */ {
> +	} else /* OBJ_RELEASE and None case from above */ {
>   		/* For the reg->type == PTR_TO_STACK case, bpf_dynptr is never const */
> -		if (reg->type == CONST_PTR_TO_DYNPTR && !(arg_type & MEM_RDONLY)) {
> -			verbose(env, "cannot pass pointer to const bpf_dynptr, the helper mutates it\n");
> +		if (reg->type == CONST_PTR_TO_DYNPTR && (arg_type & OBJ_RELEASE)) {
> +			verbose(env, "CONST_PTR_TO_DYNPTR cannot be released");

\n is missing in the verbose.

>   			return -EINVAL;
>   		}
>   
> @@ -8958,7 +8929,7 @@ static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn
>   			return -EINVAL;
>   		}
>   
> -		/* Fold modifiers (in this case, MEM_RDONLY) when checking expected type */
> +		/* Fold modifiers (in this case, OBJ_RELEASE) when checking expected type */
>   		if (!is_dynptr_type_expected(env, reg, arg_type & ~MEM_RDONLY)) {

Do we need to update the `is_dynptr_type_expected(env, reg, arg_type & 
~MEM_RDONLY)` as MEM_RDONLY is no longer applied to the dynptr?

>   			verbose(env,
>   				"Expected a dynptr of type %s as arg #%d\n",
> @@ -10803,7 +10774,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
>   				bpf_log(log, "R%d is not a pointer to arena or scalar.\n", regno);
>   				return -EINVAL;
>   			}
> -		} else if (arg->arg_type == (ARG_PTR_TO_DYNPTR | MEM_RDONLY)) {
> +		} else if (arg->arg_type == ARG_PTR_TO_DYNPTR) {
>   			ret = check_func_arg_reg_off(env, reg, regno, ARG_PTR_TO_DYNPTR);
>   			if (ret)
>   				return ret;
> @@ -13718,9 +13689,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>   			enum bpf_arg_type dynptr_arg_type = ARG_PTR_TO_DYNPTR;
>   			int clone_ref_obj_id = 0;
>   
> -			if (reg->type == CONST_PTR_TO_DYNPTR)
> -				dynptr_arg_type |= MEM_RDONLY;
> -
>   			if (is_kfunc_arg_uninit(btf, &args[i]))
>   				dynptr_arg_type |= MEM_UNINIT;
>   
> @@ -13733,7 +13701,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>   			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_file]) {
>   				dynptr_arg_type |= DYNPTR_TYPE_FILE;
>   			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_file_discard]) {
> -				dynptr_arg_type |= DYNPTR_TYPE_FILE;
> +				dynptr_arg_type |= DYNPTR_TYPE_FILE | OBJ_RELEASE;
>   				meta->release_regno = regno;
>   			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_clone] &&
>   				   (dynptr_arg_type & MEM_UNINIT)) {
> @@ -24785,7 +24753,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
>   			} else if (arg->arg_type == ARG_ANYTHING) {
>   				reg->type = SCALAR_VALUE;
>   				mark_reg_unknown(env, regs, i);
> -			} else if (arg->arg_type == (ARG_PTR_TO_DYNPTR | MEM_RDONLY)) {
> +			} else if (arg->arg_type == ARG_PTR_TO_DYNPTR) {
>   				/* assume unspecial LOCAL dynptr type */
>   				__mark_dynptr_reg(reg, BPF_DYNPTR_TYPE_LOCAL, true, ++env->id_gen);
>   			} else if (base_type(arg->arg_type) == ARG_PTR_TO_MEM) {
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 0b040a417442..5f35ecdd5341 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3393,7 +3393,7 @@ typedef int (*copy_fn_t)(void *dst, const void *src, u32 size, struct task_struc
>    * direct calls into all the specific callback implementations
>    * (copy_user_data_sleepable, copy_user_data_nofault, and so on)
>    */
> -static __always_inline int __bpf_dynptr_copy_str(struct bpf_dynptr *dptr, u64 doff, u64 size,
> +static __always_inline int __bpf_dynptr_copy_str(const struct bpf_dynptr *dptr, u64 doff, u64 size,
>   						 const void *unsafe_src,
>   						 copy_fn_t str_copy_fn,
>   						 struct task_struct *tsk)
> @@ -3535,49 +3535,49 @@ __bpf_kfunc int bpf_send_signal_task(struct task_struct *task, int sig, enum pid
>   	return bpf_send_signal_common(sig, type, task, value);
>   }
>   
> -__bpf_kfunc int bpf_probe_read_user_dynptr(struct bpf_dynptr *dptr, u64 off,
> +__bpf_kfunc int bpf_probe_read_user_dynptr(const struct bpf_dynptr *dptr, u64 off,
>   					   u64 size, const void __user *unsafe_ptr__ign)
>   {
>   	return __bpf_dynptr_copy(dptr, off, size, (const void __force *)unsafe_ptr__ign,
>   				 copy_user_data_nofault, NULL);
>   }
>   
> -__bpf_kfunc int bpf_probe_read_kernel_dynptr(struct bpf_dynptr *dptr, u64 off,
> +__bpf_kfunc int bpf_probe_read_kernel_dynptr(const struct bpf_dynptr *dptr, u64 off,
>   					     u64 size, const void *unsafe_ptr__ign)
>   {
>   	return __bpf_dynptr_copy(dptr, off, size, unsafe_ptr__ign,
>   				 copy_kernel_data_nofault, NULL);
>   }
>   
> -__bpf_kfunc int bpf_probe_read_user_str_dynptr(struct bpf_dynptr *dptr, u64 off,
> +__bpf_kfunc int bpf_probe_read_user_str_dynptr(const struct bpf_dynptr *dptr, u64 off,
>   					       u64 size, const void __user *unsafe_ptr__ign)
>   {
>   	return __bpf_dynptr_copy_str(dptr, off, size, (const void __force *)unsafe_ptr__ign,
>   				     copy_user_str_nofault, NULL);
>   }
>   
> -__bpf_kfunc int bpf_probe_read_kernel_str_dynptr(struct bpf_dynptr *dptr, u64 off,
> +__bpf_kfunc int bpf_probe_read_kernel_str_dynptr(const struct bpf_dynptr *dptr, u64 off,
>   						 u64 size, const void *unsafe_ptr__ign)
>   {
>   	return __bpf_dynptr_copy_str(dptr, off, size, unsafe_ptr__ign,
>   				     copy_kernel_str_nofault, NULL);
>   }
>   
> -__bpf_kfunc int bpf_copy_from_user_dynptr(struct bpf_dynptr *dptr, u64 off,
> +__bpf_kfunc int bpf_copy_from_user_dynptr(const struct bpf_dynptr *dptr, u64 off,
>   					  u64 size, const void __user *unsafe_ptr__ign)
>   {
>   	return __bpf_dynptr_copy(dptr, off, size, (const void __force *)unsafe_ptr__ign,
>   				 copy_user_data_sleepable, NULL);
>   }
>   
> -__bpf_kfunc int bpf_copy_from_user_str_dynptr(struct bpf_dynptr *dptr, u64 off,
> +__bpf_kfunc int bpf_copy_from_user_str_dynptr(const struct bpf_dynptr *dptr, u64 off,
>   					      u64 size, const void __user *unsafe_ptr__ign)
>   {
>   	return __bpf_dynptr_copy_str(dptr, off, size, (const void __force *)unsafe_ptr__ign,
>   				     copy_user_str_sleepable, NULL);
>   }
>   
> -__bpf_kfunc int bpf_copy_from_user_task_dynptr(struct bpf_dynptr *dptr, u64 off,
> +__bpf_kfunc int bpf_copy_from_user_task_dynptr(const struct bpf_dynptr *dptr, u64 off,
>   					       u64 size, const void __user *unsafe_ptr__ign,
>   					       struct task_struct *tsk)
>   {
> @@ -3585,7 +3585,7 @@ __bpf_kfunc int bpf_copy_from_user_task_dynptr(struct bpf_dynptr *dptr, u64 off,
>   				 copy_user_data_sleepable, tsk);
>   }
>   
> -__bpf_kfunc int bpf_copy_from_user_task_str_dynptr(struct bpf_dynptr *dptr, u64 off,
> +__bpf_kfunc int bpf_copy_from_user_task_str_dynptr(const struct bpf_dynptr *dptr, u64 off,
>   						   u64 size, const void __user *unsafe_ptr__ign,
>   						   struct task_struct *tsk)
>   {
> diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
> index 7dad01439391..ae71e9b69051 100644
> --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> @@ -40,7 +40,7 @@ extern void *bpf_dynptr_slice(const struct bpf_dynptr *ptr, __u64 offset,
>   extern void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *ptr, __u64 offset, void *buffer,
>   				   __u64 buffer__szk) __ksym __weak;
>   
> -extern int bpf_dynptr_adjust(const struct bpf_dynptr *ptr, __u64 start, __u64 end) __ksym __weak;
> +extern int bpf_dynptr_adjust(struct bpf_dynptr *ptr, __u64 start, __u64 end) __ksym __weak;
>   extern bool bpf_dynptr_is_null(const struct bpf_dynptr *ptr) __ksym __weak;
>   extern bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *ptr) __ksym __weak;
>   extern __u64 bpf_dynptr_size(const struct bpf_dynptr *ptr) __ksym __weak;
> @@ -70,13 +70,13 @@ extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __weak;
>   
>   extern int bpf_get_file_xattr(struct file *file, const char *name,
>   			      struct bpf_dynptr *value_ptr) __ksym;
> -extern int bpf_get_fsverity_digest(struct file *file, struct bpf_dynptr *digest_ptr) __ksym;
> +extern int bpf_get_fsverity_digest(struct file *file, const struct bpf_dynptr *digest_ptr) __ksym;
>   
>   extern struct bpf_key *bpf_lookup_user_key(__s32 serial, __u64 flags) __ksym;
>   extern struct bpf_key *bpf_lookup_system_key(__u64 id) __ksym;
>   extern void bpf_key_put(struct bpf_key *key) __ksym;
> -extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
> -				      struct bpf_dynptr *sig_ptr,
> +extern int bpf_verify_pkcs7_signature(const struct bpf_dynptr *data_ptr,
> +				      const struct bpf_dynptr *sig_ptr,
>   				      struct bpf_key *trusted_keyring) __ksym;
>   
>   struct dentry;
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
> index e0d672d93adf..e0745b6e467e 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
> @@ -914,7 +914,7 @@ void *user_ptr;
>   char expected_str[384];
>   __u32 test_len[7] = {0/* placeholder */, 0, 1, 2, 255, 256, 257};
>   
> -typedef int (*bpf_read_dynptr_fn_t)(struct bpf_dynptr *dptr, u64 off,
> +typedef int (*bpf_read_dynptr_fn_t)(const struct bpf_dynptr *dptr, u64 off,
>   				    u64 size, const void *unsafe_ptr);
>   
>   /* Returns the offset just before the end of the maximum sized xdp fragment.
> @@ -1106,7 +1106,7 @@ int test_copy_from_user_str_dynptr(void *ctx)
>   	return 0;
>   }
>   
> -static int bpf_copy_data_from_user_task(struct bpf_dynptr *dptr, u64 off,
> +static int bpf_copy_data_from_user_task(const struct bpf_dynptr *dptr, u64 off,
>   					u64 size, const void *unsafe_ptr)
>   {
>   	struct task_struct *task = bpf_get_current_task_btf();
> @@ -1114,7 +1114,7 @@ static int bpf_copy_data_from_user_task(struct bpf_dynptr *dptr, u64 off,
>   	return bpf_copy_from_user_task_dynptr(dptr, off, size, unsafe_ptr, task);
>   }
>   
> -static int bpf_copy_data_from_user_task_str(struct bpf_dynptr *dptr, u64 off,
> +static int bpf_copy_data_from_user_task_str(const struct bpf_dynptr *dptr, u64 off,
>   					    u64 size, const void *unsafe_ptr)
>   {
>   	struct task_struct *task = bpf_get_current_task_btf();
> diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> index d249113ed657..1c6cfd0888ba 100644
> --- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> +++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> @@ -11,12 +11,7 @@
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_tracing.h>
>   #include "bpf_misc.h"
> -
> -extern struct bpf_key *bpf_lookup_system_key(__u64 id) __ksym;
> -extern void bpf_key_put(struct bpf_key *key) __ksym;
> -extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
> -				      struct bpf_dynptr *sig_ptr,
> -				      struct bpf_key *trusted_keyring) __ksym;
> +#include "bpf_kfuncs.h"
>   
>   struct {
>   	__uint(type, BPF_MAP_TYPE_RINGBUF);
> @@ -38,7 +33,7 @@ SEC("?lsm.s/bpf")
>   __failure __msg("cannot pass in dynptr at an offset=-8")
>   int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
>   {
> -	unsigned long val;
> +	unsigned long val = 0;
>   
>   	return bpf_verify_pkcs7_signature((struct bpf_dynptr *)&val,
>   					  (struct bpf_dynptr *)&val, NULL);

