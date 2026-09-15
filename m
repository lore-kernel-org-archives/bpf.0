Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E263AA9F4;
	Tue, 15 Sep 2026 09:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462906; cv=none; b=GbNr1B8hfB0ZEG71HEdzvsCzOmwHisoDjmvfIXxqA6/Dxuh7Nf3/JhXH7tlj0KxAojLQ7OKKZ7wErnFk1xtN54bLtBMqCtYWyaFCmuJe+Bkh9Wy3Nsv/MbfhItjT5qlKPMNHFDR0gdqlU/6ikyP7Sr1giXJgOiK0dvC9GYBRE2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462906; c=relaxed/simple;
	bh=BdB/7ghHFrGbaVFHN+Hqhcby9TJE3K7duQr/idBMo6g=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GCdRYQ/KekdATfCtsuvQbJU59xVkwLKGGjuk57N3NDmhJafKa0sFwQdXIzIhsW8aHAAafU6IZS/ZCUFAy5aCW8TNYJ4t0fSaUwcY+rKRFKaqDhHtWj6j8JmqSXzHAlVWTqX+oI3h4C71GWS13RnceibWTFltfOERFWe7hRAlYTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHD62V57; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHD62V57"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D5B1F000FF;
	Tue, 15 Sep 2026 09:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789462905;
	bh=xJ8CbAqVK2aEgiqfWN4NFXkmv4VYk8DZM71F2uwFagc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NHD62V572xPJ/b/UFoosJzqQZDLqRIj7lYKIwbmiidi3PShI4GU5dw1eZ/fPw/E1w
	 dxOluJN3f5MdHNtsU9guU18PH3jkdDOAUK6im4SFyEoBal3FyClbCXMEDCUMK1w+js
	 kkrE2rlEqZpuaf1hxP7uMo5IcfleTm3+9BDk/pbsnxBbDvEQ0cBdhoRRVcG6j0ATDB
	 I0QcViQB0xgY/DEkvc35yPFUILp1223U6DXOhcrK4NojzL82ZZE1UA79sqGsD5EuRx
	 X3r2YohU6WP7Kz9DSBzyQlTcG5xAxr2DIesZhaHtu3kdkptRpThd5/0qWIkEuQpftK
	 QgNHCGSmBD14g==
Content-Type: multipart/mixed; boundary="===============3452030992566982035=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <18aa34104b455963bb39e0b34a5c5285543cec411c701b59d803dce126d8c40e@mail.kernel.org>
In-Reply-To: <20260915080255.48929-2-tasos.papagiannnis@gmail.com>
References: <20260915080255.48929-2-tasos.papagiannnis@gmail.com>
Subject: Re: [PATCH bpf-next v7 1/5] mm: Add copy_remote_mm_str()
From: bot+bpf-ci@kernel.org
To: tasos.papagiannnis@gmail.com,bpf@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,linux-kernel@vger.kernel.org,linux-mm@kvack.org,david@kernel.org,akpm@linux-foundation.org,andrii@kernel.org,ast@kernel.org,brauner@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kpsingh@kernel.org,ljs@kernel.org,matt@bobrowski.net,memxor@gmail.com,song@kernel.org,sun.jian.kdev@gmail.com,utilityemal77@gmail.com,viro@zeniv.linux.org.uk,tasos.papagiannnis@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 15 Sep 2026 09:01:43 +0000 (UTC)

--===============3452030992566982035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index dd09c438fa23e..63f40e615754d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3325,10 +3325,10 @@ extern int access_process_vm(struct task_struct *tsk, unsigned long addr,
>  extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
>  		void *buf, int len, unsigned int gup_flags);
>
> -#ifdef CONFIG_BPF_SYSCALL
> -extern int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
> -			      void *buf, int len, unsigned int gup_flags);
> -#endif
> +int copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
> +		void *buf, int len, unsigned int gup_flags);
> +int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
> +		void *buf, int len, unsigned int gup_flags);
>
>  long get_user_pages_remote(struct mm_struct *mm,
>  			   unsigned long start, unsigned long nr_pages,

[ ... ]

> diff --git a/mm/memory.c b/mm/memory.c
> index 8b0c2c735d3de..fe2f5e988fb90 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -7331,8 +7331,8 @@ EXPORT_SYMBOL_GPL(access_process_vm);
>   * Copy a string from another process's address space as given in mm.
>   * If there is any error return -EFAULT.
>   */
> -static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
> -				void *buf, int len, unsigned int gup_flags)
> +int __copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
> +			 void *buf, int len, unsigned int gup_flags)
>  {
>  	void *old_buf = buf;
>  	int err = 0;

[ ... ]

> @@ -7407,43 +7407,6 @@ static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
>  		return err;
>  	return buf - old_buf;
>  }
> -
> -/**
> - * copy_remote_vm_str - copy a string from another process's address space.
> - * @tsk:	the task of the target address space
> - * @addr:	start address to read from
> - * @buf:	destination buffer
> - * @len:	number of bytes to copy
> - * @gup_flags:	flags modifying lookup behaviour
> - *
> - * The caller must hold a reference on @mm.
> - *
> - * Return: number of bytes copied from @addr (source) to @buf (destination);
> - * not including the trailing NUL. Always guaranteed to leave NUL-terminated
> - * buffer. On any error, return -EFAULT.
> - */
> -int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
> -		       void *buf, int len, unsigned int gup_flags)
> -{
> -	struct mm_struct *mm;
> -	int ret;
> -
> -	if (unlikely(len == 0))
> -		return 0;
> -
> -	mm = get_task_mm(tsk);
> -	if (!mm) {
> -		*(char *)buf = '\0';
> -		return -EFAULT;
> -	}
> -
> -	ret = __copy_remote_vm_str(mm, addr, buf, len, gup_flags);
> -
> -	mmput(mm);
> -
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(copy_remote_vm_str);
>  #endif /* CONFIG_BPF_SYSCALL */

[ ... ]

> diff --git a/mm/util.c b/mm/util.c
> index bf0513d1d3d08..47c2e3ae84961 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1061,6 +1061,68 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
>  	return res;
>  }
>
> +#ifdef CONFIG_BPF_SYSCALL
> +/**
> + * copy_remote_mm_str - copy a string from a remote address space.
> + * @mm:         the remote address space
> + * @addr:       start address to read from
> + * @buf:        destination buffer
> + * @len:        number of bytes to copy
> + * @gup_flags:  flags modifying lookup behaviour
> + *
> + * The caller must hold a reference on @mm.
> + *
> + * Return: number of bytes copied from @addr (source) to @buf (destination),
> + * not including the trailing NUL. If @len is zero, return 0 without accessing
> + * @buf. Otherwise, @buf is always NUL-terminated. On any error, return
> + * -EFAULT.
> + */
> +int copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
> +		void *buf, int len, unsigned int gup_flags)
> +{
> +	if (unlikely(len == 0))
> +		return 0;
> +
> +	return __copy_remote_mm_str(mm, addr, buf, len, gup_flags);
> +}
> +
> +/**
> + * copy_remote_vm_str - copy a string from another process's address space.
> + * @tsk:	the task of the target address space
> + * @addr:	start address to read from
> + * @buf:	destination buffer
> + * @len:	number of bytes to copy
> + * @gup_flags:	flags modifying lookup behaviour
> + *
> + * Return: number of bytes copied from @addr (source) to @buf (destination),
> + * not including the trailing NUL. If @len is zero, return 0 without accessing
> + * @buf. Otherwise, @buf is always NUL-terminated. On any error, return
> + * -EFAULT.
> + */
> +int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
> +		void *buf, int len, unsigned int gup_flags)
> +{
> +	struct mm_struct *mm;
> +	int ret;
> +
> +	if (unlikely(len == 0))
> +		return 0;
> +
> +	mm = get_task_mm(tsk);
> +	if (!mm) {
> +		*(char *)buf = '\0';
> +		return -EFAULT;
> +	}
> +
> +	ret = __copy_remote_mm_str(mm, addr, buf, len, gup_flags);
> +
> +	mmput(mm);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(copy_remote_vm_str);
> +#endif /* CONFIG_BPF_SYSCALL */

Does this silently drop the kernel-doc from the generated documentation?

Before this patch, copy_remote_vm_str() had both its kernel-doc block
and EXPORT_SYMBOL_GPL() in mm/memory.c. Documentation/core-api/mm-api.rst
pulls mm/memory.c wholesale for exported symbols:

    .. kernel-doc:: mm/memory.c
       :export:

so its documentation was rendered by that directive.

After this patch both copy_remote_vm_str() and the new
copy_remote_mm_str() live in mm/util.c. But mm/util.c is never pulled in
with ':export:'. Every kernel-doc directive for it uses an explicit
':functions:' allowlist:

    Documentation/core-api/mm-api.rst:46   :functions: kfree_const kvmalloc_node kvfree
    Documentation/core-api/mm-api.rst:111  :functions: folio_mapping
    Documentation/core-api/kernel-api.rst:42 :functions: kstrdup kstrdup_const ...

So after the move, the kernel-doc blocks at mm/util.c:1089-1101
(copy_remote_vm_str) and mm/util.c:1065-1079 (copy_remote_mm_str) are no
longer rendered anywhere.

As a side effect, neither block is checked by the kernel-doc build, so
future mistakes in them will go unnoticed.

None of the follow-up commits in the series touch Documentation/, so this
is not restored later. Adding the two names to one of the existing
mm/util.c ':functions:' lists would preserve the previous documentation
coverage.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34946192265
--===============3452030992566982035==--
