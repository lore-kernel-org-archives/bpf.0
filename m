Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1412B46E00C;
	Mon, 24 Aug 2026 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590949; cv=none; b=Y0IA9J8EPVsUy74Fnwi49ULr1vT8DrOXxiAkqzhHDhwnsam/kz0hfZZpBAu87waPrdDteDw6h9avE+/h+UuzaZLFNsNFcvnpWEpjl5EjQKIwFIJ/tdj2BMOcv6Gjscf+c574ak4wiXcxUwJfRFh9ebQKjnanUcZnA33jaBSRE9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590949; c=relaxed/simple;
	bh=3CbLUHra6CausCdcRNTK5PpHcI0YK/uVwKTvCs1IkFw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ioOucGzMZNX93+8P8wllNRnF2PuR6B25oFkRE7BvV4eoTnMmgvDm6vZY1sp4HE5fv/dP0n+YP8nPYN6PrvMFs16hLDHpGZsZJt9TP/zd5RQCByXJJdSiJOoc6x3FOQJ4cag73p2VfP5J6rWe01iWwsj3mtfXFmfUGiFsKxQ1onQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUNCpKEx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUNCpKEx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F8E1F000E9;
	Mon, 24 Aug 2026 17:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590948;
	bh=jHNNIPLQoNO7IhBE1S2+bWd4n9+KcXQrEB8ySVE5EPM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iUNCpKEx0Krsz1T+zlwFX9PCj9X/VmjsAwUeIQxSUgaTET4GJWoFMZWRCJnCLL7f+
	 DPBFTk6CbLrghm6f/4GsYKjvyZO/bBItjz/VfS6Sx5Vz9nwVmy3SzLT7VXO+f80gTK
	 uf0nairvLEYAJTBlNeSCnXCybWOqcKU7kDDPuitkg6ZvO+isQBFWnktOK3aHN8GQzv
	 mvlZajbpQHbWnFsSnE1P6o6pjCioF9yzEJepr2JPaNmCLqJZtpIB2NVCXU6r8zCaxf
	 45ZBwMPVBoIFs340wEIo3iIjEDlZtGXNUKp9wi0iKSYI9TVHhrf+GtwrStE7iwKHuy
	 33w9Ssflcm52g==
Content-Type: multipart/mixed; boundary="===============1703117813336268665=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <828c12c509a1bd8805e32459146390e05510cc4e897ee83dcb6cd94ebbb06fb1@mail.kernel.org>
In-Reply-To: <20260824160523.3907021-5-usama.anjum@arm.com>
References: <20260824160523.3907021-5-usama.anjum@arm.com>
Subject: Re: [PATCH 4/7] maccess: Use a scoped guard for page faults
From: bot+bpf-ci@kernel.org
To: usama.anjum@arm.com,catalin.marinas@arm.com,will@kernel.org,mark.rutland@arm.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,akpm@linux-foundation.org,david@kernel.org,ljs@kernel.org,liam@infradead.org,vbabka@kernel.org,rppt@kernel.org,surenb@google.com,mhocko@suse.com,linux-arm-kernel@lists.infradead.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-mm@kvack.org
Cc: usama.anjum@arm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 17:02:27 +0000 (UTC)

--===============1703117813336268665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/mm/maccess.c b/mm/maccess.c
> index c59a0e092d24..f695ceefe6fc 100644
> --- a/mm/maccess.c
> +++ b/mm/maccess.c
> @@ -38,18 +38,17 @@ long copy_from_kernel_nofault(void *dst, const void *src, size_t size)
>  	if (!size)
>  		return 0;
>
> -	pagefault_disable();
> -	if (!(align & 7))
> -		copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
> -	if (!(align & 3))
> -		copy_from_kernel_nofault_loop(dst, src, size, u32, Efault);
> -	if (!(align & 1))
> -		copy_from_kernel_nofault_loop(dst, src, size, u16, Efault);
> -	copy_from_kernel_nofault_loop(dst, src, size, u8, Efault);
> -	pagefault_enable();
> +	scoped_guard(pagefault) {
> +		if (!(align & 7))
> +			copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
> +		if (!(align & 3))
> +			copy_from_kernel_nofault_loop(dst, src, size, u32, Efault);
> +		if (!(align & 1))
> +			copy_from_kernel_nofault_loop(dst, src, size, u16, Efault);
> +		copy_from_kernel_nofault_loop(dst, src, size, u8, Efault);
> +	}
>  	return 0;
>  Efault:
> -	pagefault_enable();
>  	return -EFAULT;
>  }

A subsystem pattern flags this as potentially concerning: include/linux/
cleanup.h states "the expectation is that usage of 'goto' and cleanup
helpers is never mixed in the same function. I.e. for a given routine,
convert all resources that need a 'goto' cleanup to scope-based cleanup,
or convert none of them."

After this change, copy_from_kernel_nofault() declares scoped_guard(
pagefault) while still using the goto-based Efault: label. Each
copy_from_kernel_nofault_loop() expands to __get_kernel_nofault(...,
Efault), which does 'goto Efault' from inside the guard scope to a label
outside it.

The concern is whether jumping out of the guard scope with goto is the
pattern cleanup.h discourages. Is this mixing safe in practice, or should
the function be fully converted to scope-based cleanup without the goto
label?

> @@ -73,18 +72,17 @@ long copy_to_kernel_nofault(void *dst, const void *src, size_t size)
>  	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
>  		align = (unsigned long)dst | (unsigned long)src;
>
> -	pagefault_disable();
> -	if (!(align & 7))
> -		copy_to_kernel_nofault_loop(dst, src, size, u64, Efault);
> -	if (!(align & 3))
> -		copy_to_kernel_nofault_loop(dst, src, size, u32, Efault);
> -	if (!(align & 1))
> -		copy_to_kernel_nofault_loop(dst, src, size, u16, Efault);
> -	copy_to_kernel_nofault_loop(dst, src, size, u8, Efault);
> -	pagefault_enable();
> +	scoped_guard(pagefault) {
> +		if (!(align & 7))
> +			copy_to_kernel_nofault_loop(dst, src, size, u64, Efault);
> +		if (!(align & 3))
> +			copy_to_kernel_nofault_loop(dst, src, size, u32, Efault);
> +		if (!(align & 1))
> +			copy_to_kernel_nofault_loop(dst, src, size, u16, Efault);
> +		copy_to_kernel_nofault_loop(dst, src, size, u8, Efault);
> +	}
>  	return 0;
>  Efault:
> -	pagefault_enable();
>  	return -EFAULT;
>  }

Same pattern here: copy_to_kernel_nofault() now has scoped_guard(pagefault)
with copy_to_kernel_nofault_loop() calls that 'goto Efault' out of the
guard scope.

> @@ -97,18 +95,17 @@ long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr, long count)
>  	if (!copy_from_kernel_nofault_allowed(unsafe_addr, count))
>  		return -ERANGE;
>
> -	pagefault_disable();
> -	do {
> -		__get_kernel_nofault(dst, src, u8, Efault);
> -		dst++;
> -		src++;
> -	} while (dst[-1] && src - unsafe_addr < count);
> -	pagefault_enable();
> +	scoped_guard(pagefault) {
> +		do {
> +			__get_kernel_nofault(dst, src, u8, Efault);
> +			dst++;
> +			src++;
> +		} while (dst[-1] && src - unsafe_addr < count);
> +	}
>
>  	dst[-1] = '\0';
>  	return src - unsafe_addr;
>  Efault:
> -	pagefault_enable();
>  	dst[0] = '\0';
>  	return -EFAULT;
>  }

And again in strncpy_from_kernel_nofault(): scoped_guard(pagefault) with
__get_kernel_nofault(dst, src, u8, Efault) jumping out of the guard scope.

Does this refactoring align with the guidance in cleanup.h about not mixing
goto and cleanup helpers, or is there precedent for this pattern in uaccess
code?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32751368606
--===============1703117813336268665==--
