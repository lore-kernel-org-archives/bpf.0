Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C243BE156;
	Mon, 31 Aug 2026 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173000; cv=none; b=cXjHNIRNTz3mD0Sfc2qL+h8ZMBQIftUSvqfFr3M3Ix7jxNiL/zuA2pI1FyLgIMlUm9GzxY2Zj9EVYlH050Zp4/2Sqr2wPrWMWQTWW5qlmKH4HQ/fmqPZZtfilfp5+t/Gw5t1B3hWQx0R5s0w0LOp9R2chJFKkBBiM5Kh+5Ek/D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173000; c=relaxed/simple;
	bh=w1mGxemjrS5cDuI9gwaHNHP3ZVHXWaZfB0htiXb6u7Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fVZOg5pqlJvNcYVkHh4nJP2k9uxqxpXN/3AfSJDCUVFyv5ALzNdww2no1aVRFDXMPdNXQV+RLFoqMcjH74OehmuhjyoCEYgcaKTwLbRASpKH6Trqj5DEczgrT2pG8DHObnzwFJPVJD9lrRAzP7JSllfi1h3I9uzKBrMncKRfY/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddXNe9v/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddXNe9v/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8B41F00A3D;
	Mon, 31 Aug 2026 10:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788172998;
	bh=z3o+i8QyZcwB4nGaXCCH4eeaX+9uBcUo5T4jA/GeZG8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ddXNe9v/pVJQu9BfMUbGSqG7f2sshnJNd1QNouPehdiqz/oKbbimURu7/jlWw2WTQ
	 QkabNWO8UgU3uNAOQzZrCWVFRUjYaplPZttHhV+MrlWCal3M0r6fgL724/HrdNjEiM
	 404pep20AMIMiU3GlWbjnBoXrdEaCepD8R+Hb2XqHaUUSbCvqY0qN5as9skLam9qi7
	 uIT6F4bdxEJRkje6vh2CcUgI+xsHJ4gCpIshYZXIHb7izTOvVUtY2NqroZuQTzUT6y
	 Pp2+DW39UFhd46PrBVCuyhGpOgYm1nqBBsjyVZIwQQs24q9nEXVm4T7kEoDrZsFqA9
	 ahFGAdenjtXCg==
Content-Type: multipart/mixed; boundary="===============5383981739397646018=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0a2e3278f23e6b88eb8f7ea2b6def912e7a5486aa223c4475d9e500ae156456e@mail.kernel.org>
In-Reply-To: <20260831092305.42062-3-tasos.papagiannnis@gmail.com>
References: <20260831092305.42062-3-tasos.papagiannnis@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/7] bpf: Add user memory access kfuncs for mm_struct
From: bot+bpf-ci@kernel.org
To: tasos.papagiannnis@gmail.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,linux-mm@kvack.org,linux-fsdevel@vger.kernel.org,viro@zeniv.linux.org.uk,brauner@kernel.org,akpm@linux-foundation.org,david@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kpsingh@kernel.org,matt@bobrowski.net,song@kernel.org,utilityemal77@gmail.com,tasos.papagiannnis@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 10:43:17 +0000 (UTC)

--===============5383981739397646018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add user memory access kfuncs for mm_struct
>
> On CONFIG_MMU kernels, when security_bprm_check() runs, the argument and
> environment strings for the exec have been copied into bprm->mm. The new
> address space is not associated with a task_struct until exec_mmap(), so
> existing BPF user memory helpers can only read from the calling task's old
> address space.
>
> Add bpf_copy_from_user_mm() and bpf_copy_from_user_mm_str() kfuncs. Both
> take a struct mm_struct pointer directly, allowing callers to access
> trusted address spaces that are not associated with a task_struct.
>
> bpf_copy_from_user_mm() has similar semantics to
> bpf_copy_from_user_task(). bpf_copy_from_user_mm_str() copies one
> NUL-terminated string and returns its size including the NUL terminator.
> It accepts BPF_F_PAD_ZEROS to clear unused destination bytes on success.
>
> Register both kfuncs and mark them KF_SLEEPABLE because accessing the
> remote address space can fault.
>
> On !CONFIG_MMU, exec argument and environment strings remain in
> bprm->page[] until the binary loader transfers them to the new process
> stack. They are therefore not accessible through bprm->mm at the
> bprm_check_security hook. The linux_binprm use described above is
> CONFIG_MMU-only, although the new kfuncs remain available for other
> address spaces on !CONFIG_MMU.

This isn't a bug, but the changelog describes the patch as adding two
new kfuncs, without noting that it also rewrites two existing entry
points. BPF_CALL_5(bpf_copy_from_user_task) becomes a get_task_mm()
wrapper around bpf_copy_from_user_mm() instead of calling
access_process_vm() directly, and bpf_copy_from_user_task_str()
becomes a wrapper around bpf_copy_from_user_mm_str() instead of
calling copy_remote_vm_str().

Could the changelog note that bpf_copy_from_user_task() and
bpf_copy_from_user_task_str() are refactored into wrappers with no
intended behaviour change?

Also, the closing paragraph describes !CONFIG_MMU bprm->page[]
behaviour that this patch does not implement or depend on. Would that
paragraph sit better in the selftest patch that acts on it?

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b3cc5c8fc8756..19c01aa734ae1 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -30,10 +30,17 @@
>  #include <linux/irq_work.h>
>  #include <linux/buildid.h>
>
>  #include "../../lib/kstrtox.h"
>
> +int bpf_copy_from_user_mm(void *dst, u32 dst__sz,
> +			  const void __user *unsafe_ptr__ign,
> +			  struct mm_struct *mm, u64 flags);
> +int bpf_copy_from_user_mm_str(void *dst, u32 dst__sz,
> +			      const void __user *unsafe_ptr__ign,
> +			      struct mm_struct *mm, u64 flags);
> +

This isn't a bug, but these are the only function forward declarations
in kernel/bpf/helpers.c. The first is unavoidable: bpf_copy_from_user_mm()
is called from BPF_CALL_5(bpf_copy_from_user_task) about 650 lines above
its definition. The second is not: bpf_copy_from_user_mm_str() has exactly
one in-file caller, bpf_copy_from_user_task_str(), and the new code defines
the wrapper before the function it wraps.

Could bpf_copy_from_user_task_str() move below bpf_copy_from_user_mm_str()
so only one forward declaration is needed?

Also, both prototypes omit __bpf_kfunc and sit outside the
__bpf_kfunc_start_defs()/__bpf_kfunc_end_defs() region, while the
definitions add __used/__retain/noinline through the macro. Every other
kfunc in the tree is declared and defined with __bpf_kfunc.

Should the remaining prototype carry __bpf_kfunc to match the definition?

>  /* If kernel subsystem is allowing eBPF programs to call this function,
>   * inside its own verifier_ops->get_func_proto() callback it should return
>   * bpf_map_lookup_elem_proto, so that verifier can properly check the arguments

[ ... ]

> @@ -680,26 +687,19 @@ const struct bpf_func_proto bpf_copy_from_user_proto = {
>  };
>
>  BPF_CALL_5(bpf_copy_from_user_task, void *, dst, u32, size,
>  	   const void __user *, user_ptr, struct task_struct *, tsk, u64, flags)
>  {
> +	struct mm_struct *mm;
>  	int ret;
>
> -	/* flags is not used yet */
> -	if (unlikely(flags))
> -		return -EINVAL;
> -
> -	if (unlikely(!size))
> -		return 0;
> -
> -	ret = access_process_vm(tsk, (unsigned long)user_ptr, dst, size, 0);
> -	if (ret == size)
> -		return 0;
> +	mm = get_task_mm(tsk);
> +	ret = bpf_copy_from_user_mm(dst, size, user_ptr, mm, flags);
> +	if (mm)
> +		mmput(mm);
>
> -	memset(dst, 0, size);
> -	/* Return -EFAULT for partial read */
> -	return ret < 0 ? ret : -EFAULT;
> +	return ret;
>  }

[ ... ]

> @@ -3678,20 +3678,105 @@ __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void __user
>   * A negative error code on failure.
>   */
>  __bpf_kfunc int bpf_copy_from_user_task_str(void *dst, u32 dst__sz,
>  					    const void __user *unsafe_ptr__ign,
>  					    struct task_struct *tsk, u64 flags)
> +{
> +	struct mm_struct *mm;
> +	int ret;
> +
> +	mm = get_task_mm(tsk);
> +	ret = bpf_copy_from_user_mm_str(dst, dst__sz, unsafe_ptr__ign,
> +					mm, flags);
> +	if (mm)
> +		mmput(mm);
> +
> +	return ret;
> +}
> +
> +/**
> + * bpf_copy_from_user_mm() - Copy data from an address space
> + * @dst:             Destination address, in kernel space
> + * @dst__sz:         Number of bytes to copy
> + * @unsafe_ptr__ign: Source address in the address space
> + * @mm:              Address space to copy from
> + * @flags:           Reserved for future use; must be zero
> + *
> + * Copies data from the user address space associated with @mm. The destination
> + * is zeroed if an attempted copy cannot be completed in full. Unsupported
> + * flags return -EINVAL without modifying @dst.
> + *
> + * Return: 0 on success, -EINVAL if @flags is non-zero, or -EFAULT if the copy
> + * fails or is partial.
> + */
> +__bpf_kfunc int bpf_copy_from_user_mm(void *dst, u32 dst__sz,
> +				      const void __user *unsafe_ptr__ign,
> +				      struct mm_struct *mm, u64 flags)
> +{
> +	int ret;
> +
> +	if (unlikely(flags))
> +		return -EINVAL;
> +
> +	if (unlikely(!dst__sz))
> +		return 0;
> +
> +	if (unlikely(!mm)) {
> +		memset(dst, 0, dst__sz);
> +		return -EFAULT;
> +	}
> +
> +	ret = access_remote_vm(mm, (unsigned long)unsafe_ptr__ign,
> +			       dst, dst__sz, 0);
> +	if (ret == dst__sz)
> +		return 0;
> +
> +	memset(dst, 0, dst__sz);
> +	return ret < 0 ? ret : -EFAULT;
> +}
> +
> +/**
> + * bpf_copy_from_user_mm_str() - Copy a string from an address space
> + * @dst:             Destination address, in kernel space. This buffer must be
> + *                   at least @dst__sz bytes long
> + * @dst__sz:         Maximum number of bytes to copy, including the trailing NUL
> + * @unsafe_ptr__ign: Source address in the address space
> + * @mm:              Address space to copy from
> + * @flags:           The only supported flag is BPF_F_PAD_ZEROS
> + *
> + * Copies a NUL-terminated string from the user address space associated with
> + * @mm. If the string is too long, @dst is still NUL-terminated unless @dst__sz
> + * is zero.
> + *
> + * If the flags are valid and BPF_F_PAD_ZEROS is set, the unused portion of
> + * @dst is cleared on success and all of @dst is cleared on a copy failure.
> + * Unsupported flags return -EINVAL without modifying @dst.
> + *
> + * Return: The number of copied bytes including the NUL terminator on success,
> + * or a negative error code on failure.
> + */
> +__bpf_kfunc int bpf_copy_from_user_mm_str(void *dst, u32 dst__sz,
> +					  const void __user *unsafe_ptr__ign,
> +					  struct mm_struct *mm, u64 flags)
>  {
>  	int ret;
>
>  	if (unlikely(flags & ~BPF_F_PAD_ZEROS))
>  		return -EINVAL;
>
>  	if (unlikely(dst__sz == 0))
>  		return 0;
>
> -	ret = copy_remote_vm_str(tsk, (unsigned long)unsafe_ptr__ign, dst, dst__sz, 0);
> +	if (unlikely(!mm)) {
> +		if (flags & BPF_F_PAD_ZEROS)
> +			memset(dst, 0, dst__sz);
> +		else
> +			*(char *)dst = '\0';
> +		return -EFAULT;
> +	}
> +
> +	ret = copy_remote_mm_str(mm, (unsigned long)unsafe_ptr__ign, dst, dst__sz, 0);
>  	if (ret < 0) {
>  		if (flags & BPF_F_PAD_ZEROS)
>  			memset(dst, 0, dst__sz);
>  		return ret;
>  	}

[ ... ]

> @@ -4922,10 +5007,12 @@ BTF_ID_FLAGS(func, bpf_preempt_disable)
>  BTF_ID_FLAGS(func, bpf_preempt_enable)
>  BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
>  BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_copy_from_user_mm, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_copy_from_user_mm_str, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_copy_from_user_task_str, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_get_kmem_cache)
>  BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33379004067
--===============5383981739397646018==--
