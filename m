Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9B2473C9A;
	Thu, 20 Aug 2026 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787234718; cv=none; b=dgULHARGy4SUFVdpdEH/UujhqMDgeVsK9rnPEIdoPY5vRxsoF988kwKpdLZGHTLBaP6ZuXqZYISwiOAxSV4SbYP64W8kUoGFjSnOhSusxXhixlCOPU6lgMYZZ9R7m/uCP2VQyrP9xA0AfdzQsB/J0xNYV/WX+WsR6fJMTi2A8aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787234718; c=relaxed/simple;
	bh=TzI26xxSPdH7fCYXyfHqU+kpeVJ83eMTA2bklbn8mi0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=V1TZ7afE6nOVf7rcOkvlDpMrCs8TNGwQNwJ44jefukxzFBo6TJ7hqVw/c9fy+OLavEfn82Pb8hkDWlnvrXcZ2r0Aopn83/ARUEjvJ7nqr9NyOqljfU+D6m0NgiGoE3D3pNJjQs7ynMJVLWUB/RrjlPey8kLQJjWolQGra7e6ZXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZW7NfD3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZW7NfD3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84571F00A3A;
	Thu, 20 Aug 2026 14:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787234717;
	bh=Ylc+u/5RasCgGgNZnJ4+DIMEi8BfrrmNY9Qtx0gvX6k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HZW7NfD3vUyrAmEEQMtgPM7Ox+7vPRIZmETPZAjvuyVGwjfWTHoX0YJFIFccaqH+j
	 GJ5/7r3axsNJJPjIs3blsLeJ2NWoTQ1BUgvz/pLYpvmU8kQRvqC7snAW7prz3VSVAL
	 KzcXXuFKEJ67CvMO3rsFSwcBGKgxE/LMArTRr6vFRbDpfv9U9/tv9GTNiC/KyFnJmV
	 UYTMBeWtDuhK7oq5U9wBHRjCHOJD44wmw/NUgcSK0Zvfwyg6zOwyYG+Gkl0C9M649w
	 R1NzYSv/zUzFJDlrUt6RnUu4XiyZG3aNyEjjUtCri9FPxhw2HkuWT6SuTJwXKoawuR
	 DWWW3BXXNmcDg==
Content-Type: multipart/mixed; boundary="===============4336261480514913956=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fa7f719852be56e25978cc87b269948179378ec6e17c5a7dd7999f20c37f48b1@mail.kernel.org>
In-Reply-To: <20260820131801.68759-2-tasos.papagiannnis@gmail.com>
References: <20260820131801.68759-2-tasos.papagiannnis@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] mm: Add copy_remote_mm_str()
From: bot+bpf-ci@kernel.org
To: tasos.papagiannnis@gmail.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,linux-mm@kvack.org,linux-fsdevel@vger.kernel.org,viro@zeniv.linux.org.uk,brauner@kernel.org,akpm@linux-foundation.org,david@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kpsingh@kernel.org,matt@bobrowski.net,song@kernel.org,utilityemal77@gmail.com,tasos.papagiannnis@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 20 Aug 2026 14:05:16 +0000 (UTC)

--===============4336261480514913956==
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

This isn't a bug, but does copy_remote_mm_str() read as expected next to
copy_remote_vm_str(tsk, ...)? In this area of mm/memory.c, the
established split is access_process_vm(struct task_struct *tsk, ...) for
the task-based entry point and access_remote_vm(struct mm_struct *mm,
...) for the mm-based one. By that convention _remote_vm already denotes
the variant that takes an mm, so having copy_remote_mm_str(mm, ...)
sitting next to copy_remote_vm_str(tsk, ...) inverts the expectation.

> diff --git a/mm/memory.c b/mm/memory.c
> index 6b8280cfc1db..da0010c4475d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -7218,6 +7218,30 @@ static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
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
> + * not including the trailing NUL. If @len is zero, return 0 without accessing
> + * @buf. Otherwise, @buf is always NUL-terminated. On any error, return
> + * -EFAULT.
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
> @@ -7247,7 +7271,7 @@ int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
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

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32375104040
--===============4336261480514913956==--
