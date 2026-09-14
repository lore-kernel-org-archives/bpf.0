Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBB44908AA;
	Mon, 14 Sep 2026 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789403988; cv=none; b=GpWTzg+vhZpYkXEhHWeXsKUe/zOk4j6I/sgtgPWqqU8j4bIK8GJ2ZTQ0BxWPLy92RjV3FylWusu0cs1Y/D8XEw5kAhbXfe+IvhTvz/5EKLQwGqjx/2jbNlovN9AH6qDWK1mxgXsYbfrNNWn6ddHCynyAgHMwaat+w6osz6GofYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789403988; c=relaxed/simple;
	bh=p6x7VwFneW3z3B7+bPqYMeFHKnY8Zm+veA5kbSBUSTE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iv4DdCgmMYThkENZdRSN6US94TJLxCT81K8zB6oWV54Qj2e2TLG06BWkyRl6kA+uVJeZ+BlUpqV7pxcI8fim6vZ3WKd0+7b/a68lJIrj3kbLOB3xoEzsSySK61s9nH+QwlPwDFU0rqyvcIFdHUdbWpEtQI+MERGv/QnUwXUQHxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBTctPYk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBTctPYk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5B01F00898;
	Mon, 14 Sep 2026 16:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789403973;
	bh=6FSR0xq2pKNGhB8Y5pWSZa0zoR/V0dcfkLj5V8fgboU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CBTctPYkbyOWPdzw6P1U3XDsoadGm+hce7YJVfAEqDcB+IAZltOjvmFfxHJHzKtjR
	 nQRX2/CwnFctPS4bfs+/0X+CQW1CPi1EujMZldwfw8JAbne7/UkmC/mm7MSecgN4Nc
	 l6hyBpx/pOQXF7JSITmdcG4J3YEX3cqLqj4E2FmiKFeNHJK20ClmPjn+WlDTTXz+J5
	 KMMnfD6iRQ29U9ZNjlsn0jNphj73/ANrjWwqwVLgloOS3Hokr4TzAHxEBOgA3D397f
	 5G5jt93sMBXryCVK1mjIhWReO7CEDXVzFPdpPrAG06gHeREcGnGBPrFgBChVVejMTD
	 ApbA+AXr3Yl6Q==
Content-Type: multipart/mixed; boundary="===============1684484601426501042=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c4f9dcfb3827ef826df36d4ed7d12d78694989fd6a6843967c094b8e879b2574@mail.kernel.org>
In-Reply-To: <20260914153326.72498-1-leon.hwang@linux.dev>
References: <20260914153326.72498-1-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v2] bpftool: Compute map size of light skeletons at runtime
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,linux-kernel@vger.kernel.org,leon.hwang@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 14 Sep 2026 16:39:32 +0000 (UTC)

--===============1684484601426501042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
> index 1f3f332dffbe..6f23ea9410eb 100644
> --- a/tools/lib/bpf/skel_internal.h
> +++ b/tools/lib/bpf/skel_internal.h
> @@ -11,6 +11,7 @@
>  #include <linux/bpf.h>
>  #else
>  #include <unistd.h>
> +#include <sys/param.h>
>  #include <sys/syscall.h>
>  #include <sys/mman.h>
>  #include <linux/keyctl.h>

[ ... ]

> @@ -193,25 +197,34 @@ static inline void skel_free(void *p)
>  	free(p);
>  }
>
> -static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
> +static inline size_t skel_map_mmap_sz(size_t val_sz, __u32 max_entries)
>  {
> -	munmap(p, sz);
> +	return roundup(roundup(val_sz, 8) * max_entries, sysconf(_SC_PAGE_SIZE));
>  }

This isn't a bug, but would it read closer to array_map_mmap_sz() to hoist
the page size into a local here? sysconf(_SC_PAGE_SIZE) is passed straight
into roundup()'s second argument, and roundup() is a macro that expands its
second argument several times in the non-constant case. The three nearby
equivalents all hoist it: the bpf_map_mmap_sz() this patch deletes from
gen.c used 'long page_sz = sysconf(_SC_PAGE_SIZE);', and libbpf's
array_map_mmap_sz() and bpf_map_mmap_sz() both open with 'const long page_sz
= sysconf(_SC_PAGE_SIZE);'. Hoisting it here would also make the helper
independent of which roundup() definition wins, and might let the new
<sys/param.h> include be dropped.

>
> -static inline void *skel_prep_map_data(const void *val, size_t mmap_sz, size_t val_sz)
> +static inline void skel_free_map_data(void *p, __u64 addr, size_t val_sz, __u32 max_entries)
>  {
> +	munmap(p, skel_map_mmap_sz(val_sz, max_entries));
> +}
> +
> +static inline void *skel_prep_map_data(const void *val, size_t val_sz, __u32 max_entries,
> +				       size_t data_sz)
> +{
> +	size_t mmap_sz = skel_map_mmap_sz(val_sz, max_entries);
>  	void *addr;
>
>  	addr = mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE,
>  		    MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>  	if (addr == (void *) -1)
>  		return NULL;
> -	memcpy(addr, val, val_sz);
> +	memcpy(addr, val, data_sz);
>  	return addr;
>  }
>
> -static inline void *skel_finalize_map_data(__u64 *init_val, size_t mmap_sz, int flags, int fd)
> +static inline void *skel_finalize_map_data(__u64 *init_val, size_t val_sz, __u32 max_entries,
> +					   int flags, int fd)
>  {
> +	size_t mmap_sz = skel_map_mmap_sz(val_sz, max_entries);
>  	void *addr;
>
>  	addr = mmap((void *) (long) *init_val, mmap_sz, flags, MAP_SHARED | MAP_FIXED, fd, 0);
> @@ -220,11 +233,13 @@ static inline void *skel_finalize_map_data(__u64 *init_val, size_t mmap_sz, int
>  	return addr;
>  }
>
> -static inline int skel_protect_map_data(void *p, __u64 *init_val, size_t sz)
> +static inline int skel_protect_map_data(void *p, __u64 *init_val, size_t val_sz, __u32 max_entries)
>  {
> +	size_t mmap_sz = skel_map_mmap_sz(val_sz, max_entries);
> +
>  	(void)init_val;
>
> -	if (mprotect(p, sz, PROT_READ))
> +	if (mprotect(p, mmap_sz, PROT_READ))
>  		return -errno;
>  	return 0;
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34864978845
--===============1684484601426501042==--
