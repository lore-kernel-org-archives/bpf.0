Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E7541D207;
	Wed, 12 Aug 2026 12:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786536194; cv=none; b=pxjI/+iNPhVnpiXwpVOfqWQ96dJPcbE8B0W35pYL5LLiq0s9ABHiTQrpKkA+2W5h/s8+jSjBdf4nG67TTX28tj3EAZQbLteDmf/qDSt6U0IkkXKpsfoSeEQhJn5YytOwIBcxj7/r/2KIGR7zWQHsiNFyXS2YljJxVjdQd6A28zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786536194; c=relaxed/simple;
	bh=rxLg+71ILbnrjLK8FXYxaq0Ey6mQT3F1VydiwIBtJCs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uYPbrv126/FgdkGw5tiz7qx+F1DKEKMlawnA0AIhbvCM47xFgPWRM0awi7p6HZ9COHQ14+7MaZjKlMMVyHppZTSku1rsQxVZeQW6zjaXl4uxY3bRWabChmEO2uu1oOwknp6y9IjfrWyIEFiiBt9Be6kIdJY34WwzY68eOeY7ngs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYZJHZAA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYZJHZAA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FB41F000E9;
	Wed, 12 Aug 2026 12:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786536192;
	bh=6xXHJa1Wu10ODBgrINvgPzFGBKsN0vS4f5IbQsSc8mk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=lYZJHZAAoDoW9UdBtVy5MxZkhseCtk9QRv5XB6BdTKbDnknG6MxDeFLiMNIl/192l
	 b3JirXWGs25gOgHIXUvsS+mJMzKo2ThqunZz9NrMojoFpovsXQKpq/YSq8BjW58Fcs
	 tSU3avpnnDHP9p62FI3Sd0WFBcZFP9sweGonaBK6ktUrzUb2JG9xuAQXe5RXyMi+7z
	 M2WFb1w1dlNRm3j8aU6j6tAr1qq8xuuyEcWo947EPJ7czIrzkzjPQuzj9+0V8/OxO4
	 rHeCMvCh+qO9BYf2dGWXVMk+prwgz0juEYvC2+Wixc6hqcMVcV0u0ZDbQ+y68odA1/
	 yaRy2HMSO85uA==
Content-Type: multipart/mixed; boundary="===============3128931104168357247=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <56a41abb674851cde452dab2c56ca3e4b629acc62a982f418ac6a4ee3b32cb56@mail.kernel.org>
In-Reply-To: <20260812111140.7762-2-tasos.papagiannnis@gmail.com>
References: <20260812111140.7762-2-tasos.papagiannnis@gmail.com>
Subject: Re: [PATCH bpf-next 1/3] mm: Add copy_remote_mm_str()
From: bot+bpf-ci@kernel.org
To: tasos.papagiannnis@gmail.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,linux-mm@kvack.org,linux-fsdevel@vger.kernel.org,viro@zeniv.linux.org.uk,brauner@kernel.org,akpm@linux-foundation.org,david@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kpsingh@kernel.org,matt@bobrowski.net,song@kernel.org,tasos.papagiannnis@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 12 Aug 2026 12:03:11 +0000 (UTC)

--===============3128931104168357247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 485df9c2dbdd..eede435bf4a3 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3222,6 +3222,8 @@ extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
>  		void *buf, int len, unsigned int gup_flags);
>
>  #ifdef CONFIG_BPF_SYSCALL
> +extern int copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
> +			      void *buf, int len, unsigned int gup_flags);
>  extern int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
>  			      void *buf, int len, unsigned int gup_flags);
>  #endif
> diff --git a/mm/memory.c b/mm/memory.c
> index 6b8280cfc1db..a70c43d9b17e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c

[ ... ]

> @@ -7218,6 +7218,29 @@ static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
>  	return buf - old_buf;
>  }
>
> +/**
> + * copy_remote_mm_str - copy a string from a remote address space.
> + * @mm:	the remote address space
> + * @addr:	start address to read from
> + * @buf:	destination buffer
> + * @len:	number of bytes to copy
> + * @gup_flags:	flags modifying lookup behaviour
> + *
> + * The caller must hold a reference on @mm.
> + *
> + * Return: number of bytes copied from @addr (source) to @buf (destination),
> + * not including the trailing NUL. Always guarantees a NUL-terminated buffer.
> + * On any error, return -EFAULT.
> + */
> +int copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
> +		       void *buf, int len, unsigned int gup_flags)
> +{
> +	if (unlikely(len == 0))
> +		return 0;
> +
> +	return __copy_remote_vm_str(mm, addr, buf, len, gup_flags);
> +}
> +

Does the kernel-doc accurately describe the len == 0 case? The contract
says "Always guarantees a NUL-terminated buffer", but when len == 0 the
function returns 0 without touching @buf, so a caller trusting the
documented guarantee would read uninitialized memory if they then treat
@buf as a C string.

Every other write path does honor this claim (__copy_remote_vm_str()
opens with `*(char *)buf = '\0';`), which makes len == 0 the sole
exception. Both current callers pre-filter len == 0 (copy_remote_vm_str
below and the forward-range bpf_copy_from_user_bprm_str), so there's no
live memory bug, but the contract is what future non-BPF callers will
read. The caveat is stated correctly elsewhere in the series:
bpf_copy_from_user_task_str says "unless buffer size is 0" and
bpf_copy_from_user_bprm_str says "unless @dst__sz is zero".

Would it make sense to mirror that caveat here, or to drop the early
return and let the callee's `*(char *)buf = '\0'` run?

>  /**
>   * copy_remote_vm_str - copy a string from another process's address space.
>   * @tsk:	the task of the target address space
> @@ -7247,7 +7270,7 @@ int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
>  		return -EFAULT;
>  	}
>
> -	ret = __copy_remote_vm_str(mm, addr, buf, len, gup_flags);
> +	ret = copy_remote_mm_str(mm, addr, buf, len, gup_flags);
>
>  	mmput(mm);
>

[ ... ]

> diff --git a/mm/nommu.c b/mm/nommu.c
> index ed3934bc2de4..8fbe6306d074 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c

[ ... ]

> @@ -1752,6 +1752,29 @@ static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
>  	return ret;
>  }
>
> +/**
> + * copy_remote_mm_str - copy a string from a remote address space.
> + * @mm:         the remote address space
> + * @addr:       start address to read from
> + * @buf:        destination buffer
> + * @len:        number of bytes to copy
> + * @gup_flags:  flags modifying lookup behaviour (unused)
> + *
> + * The caller must hold a reference on @mm.
> + *
> + * Return: number of bytes copied from @addr (source) to @buf (destination),
> + * not including the trailing NUL. Always guarantees a NUL-terminated buffer.
> + * On any error, return -EFAULT.
> + */
> +int copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
> +		       void *buf, int len, unsigned int gup_flags)
> +{
> +	if (unlikely(len == 0))
> +		return 0;
> +
> +	return __copy_remote_vm_str(mm, addr, buf, len);
> +}
> +

Same question for the NOMMU copy: the documented "Always guarantees a
NUL-terminated buffer" claim doesn't hold when len == 0 returns without
writing to @buf. The NOMMU __copy_remote_vm_str also opens with
`*(char *)buf = '\0';`, so len == 0 is again the only path that leaves
@buf unwritten. Should both copies carry the "unless @len is 0" caveat?

>  /**
>   * copy_remote_vm_str - copy a string from another process's address space.
>   * @tsk:	the task of the target address space
> @@ -1781,7 +1804,7 @@ int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
>  		return -EFAULT;
>  	}
>
> -	ret = __copy_remote_vm_str(mm, addr, buf, len);
> +	ret = copy_remote_mm_str(mm, addr, buf, len, gup_flags);
>
>  	mmput(mm);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31592551940
--===============3128931104168357247==--
