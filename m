Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029A528686;
	Tue, 11 Aug 2026 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786452011; cv=none; b=DGDywLR9R1soG/pclzmQPhwOPp1zU+35gBVeLUswvFFPrqmm0UuR5GXBC3zGC9d3Fz8oI+c77oVKXECDr32QbdSnprXZVIqXPJPL84hCfO9C9GPZc+Omo5b+3q5zIZWY5fqMBhH2tJQD+5zkDn1vuKbPz20p5swgSZr3A9OvCPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786452011; c=relaxed/simple;
	bh=ZJ+RNpgdkSShQPjRyv9yNHv84N8EzVn75gVwnDMHNn8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=d5IxrwZAJS+LF8Oux+WC1HIaDNWZnK+Cm80QasF0Gz49XAb04rUDXiyJGzUJiHiES+YWIV/22mcEkU0fiDxH1MRBX/qYwgeVI5iMt1a4cIayXqurwFHVmWW6ATtqekawVaXWVqUrviQoxu87mdPFTGLW017TqtBztLdkJo2LTpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9N8+DZv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9N8+DZv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE181F000E9;
	Tue, 11 Aug 2026 12:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786452009;
	bh=XxrOVr5HxDqaoiC9WxtikIvK4xWnONmhDLyUEnlmH2o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=g9N8+DZvbLkOsMZrOVrA/iDVvSGk3BAWNF3H/vcBxvOI8bw+qBquB+D++W1n+56tc
	 g2btHK/nuktiHGAO6A7X5t1mobFhhRQqlpAIYNsBUcd5GtEpeStOiMmA1DI7uX0pbC
	 bWSOvFaNWKaONlr3fwRi9Qw7knPiJ5HqFuSv4faho5J7y5fPTCBukM85Xtea41znYy
	 QMQ3qLmEuY39BVP7VFVjRktEg6xFxbuF/4dn8vLuadRzOQZi5KqUwcYQnyaWV/LBPD
	 Doqf8y7kmb+Gy3fwNm8uYqK1M9kgKHwzvMcua9UeqUh2hzEzMv+85luGww3TDChk4z
	 nakxeo2Gmry0A==
Content-Type: multipart/mixed; boundary="===============0710016926348867863=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <299058c99d38b45741b08ee0e3a85006536716ae7d54de805c7873d32690cf62@mail.kernel.org>
In-Reply-To: <20260811112154.94053-2-tasos.papagiannnis@gmail.com>
References: <20260811112154.94053-2-tasos.papagiannnis@gmail.com>
Subject: Re: [PATCH bpf-next 1/5] mm: Add copy_remote_mm_str()
From: bot+bpf-ci@kernel.org
To: tasos.papagiannnis@gmail.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,linux-mm@kvack.org,akpm@linux-foundation.org,david@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kpsingh@kernel.org,matt@bobrowski.net,song@kernel.org,tasos.papagiannnis@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 11 Aug 2026 12:40:08 +0000 (UTC)

--===============0710016926348867863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> mm: Add copy_remote_mm_str()
>
> copy_remote_vm_str() gets the target address space from a struct
> task_struct. This does not work for an address space that exists but is
> not yet associated with a task_struct, such as the mm held by struct
> linux_binprm during exec.
>
> This patch adds copy_remote_mm_str(), which operates directly on a struct
> mm_struct.

This isn't a bug, but could this last paragraph be reworded in the
imperative, e.g. "Add copy_remote_mm_str(), which operates directly on a
struct mm_struct", to match the changelog style asked for in
submitting-patches.rst?

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 485df9c2dbddb..eede435bf4a3f 100644
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
> index 6b8280cfc1dbe..03cbd3b02befb 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -7218,6 +7218,29 @@ static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
>  	return buf - old_buf;
>  }
>
> +/**
> + * copy_remote_mm_str - copy a string from a remote address space.
> + * @mm:         the remote address space
> + * @addr:       start address to read from
> + * @buf:        destination buffer
> + * @len:        number of bytes to copy
> + * @gup_flags:  flags modifying lookup behaviour

This isn't a bug, but would it be worth using a tab after the parameter
colons here, to match the copy_remote_vm_str and access_remote_vm
kernel-doc blocks in the same files? This is the only kernel-doc block in
mm/memory.c that aligns parameter descriptions with spaces rather than a
tab.

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


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31488001112
--===============0710016926348867863==--
