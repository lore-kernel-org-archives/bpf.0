Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E728C1427A
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774629412; cv=none; b=XpnwOxDNNu91hg8NMM3SHNJWIImXrMtqabH49X+c0DjA0xV246vGlU4ldv2+I+srmBULikixAcBWAPu3o9dk/dFHZLKgYH7IQng9pB3eDbweF7JavGnjMp2j8D+q6jLM7/TdCIJFX74WCWl45h4EeV9cQBD7R9N31FRef1EXA8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774629412; c=relaxed/simple;
	bh=ufMxz/SU8ZDO6+N9af8TS9XnnlRChocNVqqL2HLNd6Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sK64e3LYm2phSuehfVhRzY5yoKEUH3s8YijeIp5Pp31Z/Csltqbs5gnrgOuHgJXHOmAgUUlS0OvBUTXUFa3RfPxadmhukSzyh4OTtVJAzt6WnxY/w8gAG7QOmyilRNf9ZBXpx47RlHU+mWT7XVEpWROUPSj35OqyhsPDn9gQ3Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOzog4w3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOzog4w3"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso20392175e9.1
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 09:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774629409; x=1775234209; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1gmBBbZBj/pjzNJHQKw9hoKKpeL46UIWyTaXXtCbKDw=;
        b=ZOzog4w3cSgArBDo9d8LL5rWGCi6q3jpjPfGNI46zfE/rcTELWeIPcZwNQyzkdVi8h
         LA5m7uM6El173qY55aRsbnjP6g1e3RDD8tsoH2RR9Z4tLZnfb1SsS+nOTRd5g+TxK53k
         w+qO8YicH/ZC6jCPcn6iOF9r6HcnHO52q1uYT+BFdv8DBQxmMsuIiaDYde3fPg/UGOdR
         U2LClUI+gs0TZkvH3Rkg7GQOGBGz86YKFUjY6kZ7tvcsAFVy4Cv1NvGYcAhtO8uDtcQO
         synoP0wXdzipFTTBYbwV5XMF6ftiicjJGSfeuS1MPo9ODD3o7p5++HCC09wlu3I7YxqS
         FnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774629409; x=1775234209;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1gmBBbZBj/pjzNJHQKw9hoKKpeL46UIWyTaXXtCbKDw=;
        b=lr4qCAGntNemxQTgN5raREydRzTWLlD6KmBcwd47WaxPCQ33khUzF2PNkKKKVzrNQ6
         ZI6goyPmamXlRWcd/Qe8MDmPIFtlx/nlZRxSmDBvkjBJJxRE/lwZCnYbnxqiyC5ENqWU
         i1ZjowNq5ngAy5+yFfBEoVjfCb1tXWVFyEoEeyqCHqrM42Hza+eCyuR4UKqWRXPVtX5i
         nWMQkzv0dyIkZdqGfz2cg+IiV+i3YAXnvrsHj2OwNK7o6694heWaYzpmH6Dz61S7LBt/
         w3H0AUPxerDCM+PpKpxsiY2Zej2Ip8NAO7NtKlSntHIvVKSmVhupAngCgCA+HpbrFqfU
         ue4g==
X-Forwarded-Encrypted: i=1; AJvYcCUYX2matYyW3EwJgTN32nVn7fK6CPKHV8ogsvt1fRLopzV0zWTMU1hecxRn7iu3DPzeDZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu23Vl3ofcLmD9PUOitacXjkMLs93zvFDRxbKTZB6JA6ocZZjS
	PVmUqffH1gXTehIdXZorEt1O6WmV52J2XXDChL9hYsoBMGLsYS3T/6X8
X-Gm-Gg: ATEYQzw3WvbaCvUcxLU7feRBT2s6ApzkLxXRIpf9pytIrD2/LE40f5IKqDkFAMSFQ+4
	TcJT4XXDRsat3DEAhj154hr9OWfqaNYsl4QTcKmdiE8+q8CB2siFJ8TUxB3WQ9WIEGp8fq6sWUa
	vXivqKIxZwiyaG6uz7H7NC61G5GhqJCTdm8coQDM6DHTUk/EuNiSjalfsB/oklhbDAbW/b8wG1M
	Eq5ZGHNSZWm1z9CdGQXwnGmxJXmNrCEBlXPRZOrVkjnq3WagD0tjASEbQB+fdqMHjSewlftmVNJ
	/yixKbJ4gImCeeJDXD0sfPAbWeJh7oT5Qwjc4BygTOxbLK6xAxhdTglPMFWtDVnr5O48tCeH5MN
	wQMJ4ZFv4lQNwuhU1A/1imVEXdRpCwkjZlojmt34D03J7lJ/x7rB/x1UrXxHBPeaHmXABWbkXWO
	D5X+MeNsVOdH7ZGj8pudkahsXr8crC6uMBWQ==
X-Received: by 2002:a05:600c:3b8f:b0:485:3b00:f93b with SMTP id 5b1f17b1804b1-48727f17f7bmr59912105e9.31.1774629408855;
        Fri, 27 Mar 2026 09:36:48 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48727189cd1sm18514625e9.29.2026.03.27.09.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 09:36:48 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, memxor@gmail.com, ameryhung@gmail.com,
 kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 2/3] selftests/bpf: Simplify task_local_data
 memory allocation
In-Reply-To: <20260326052437.590158-3-ameryhung@gmail.com>
References: <20260326052437.590158-1-ameryhung@gmail.com>
 <20260326052437.590158-3-ameryhung@gmail.com>
Date: Fri, 27 Mar 2026 16:36:47 +0000
Message-ID: <877bqxi600.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Amery Hung <ameryhung@gmail.com> writes:

> Simplify data allocation by always using aligned_alloc() and passing
> size_pot, size rounded up to the closest power of two to alignment.
>
> Currently, aligned_alloc(page_size, size) is only intended to be used
> with memory allocators that can fulfill the request without rounding
> size up to page_size to conserve memory. This is enabled by defining
> TLD_DATA_USE_ALIGNED_ALLOC. The reason to align to page_size is due to
> the limitation of UPTR where only a page can be pinned to the kernel.
> Otherwise, malloc(size * 2) is used to allocate memory for data.
>
> However, we don't need to call aligned_alloc(page_size, size) to get
> a contiguous memory of size bytes within a page. aligned_alloc(size_pot,
> ...) will also do the trick. Therefore, just use aligned_alloc(size_pot,
> ...) universally.
>
> As for the size argument, create a new option,
> TLD_DONT_ROUND_UP_DATA_SIZE, to specify not rounding up the size.
> This preserves the current TLD_DATA_USE_ALIGNED_ALLOC behavior, allowing
> memory allocators with low overhead aligned_alloc() to not waste memory.
> To enable this, users need to make sure it is not an undefined behavior
> for the memory allocator to have size not being an integral multiple of
> alignment.
Why not simplify this further and just mmap() a page?

  data = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
              MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

That gives you a page-aligned, page-sized buffer with no ambiguity
about alignment, page boundary crossings, or aligned_alloc() POSIX
compliance. munmap() on cleanup instead of free().

The whole power-of-two rounding and TLD_DONT_ROUND_UP_DATA_SIZE
option adds complexity that's hard to justify for selftest
infrastructure. How does a user decide when to define/undefine
TLD_DONT_ROUND_UP? This is a selftest library -- the common case
should just work with the simplest possible approach
>
> Compared to the current implementation, !TLD_DATA_USE_ALIGNED_ALLOC
> used to always waste size-byte of memory due to malloc(size * 2).
> Now the worst case becomes size - 1 and the best case is 0 when the size
> is already a power of two.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  .../bpf/prog_tests/task_local_data.h          | 60 +++++++------------
>  1 file changed, 22 insertions(+), 38 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> index a52d8b549425..366a6739c086 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> @@ -50,16 +50,13 @@
>   *   TLD_MAX_DATA_CNT.
>   *
>   *
> - *   TLD_DATA_USE_ALIGNED_ALLOC - Always use aligned_alloc() instead of malloc()
> + *   TLD_DONT_ROUND_UP_DATA_SIZE - Don't round up memory size allocated for data if
> + *   the memory allocator has low overhead aligned_alloc() implementation.
>   *
> - *   When allocating the memory for storing TLDs, we need to make sure there is a memory
> - *   region of the X bytes within a page. This is due to the limit posed by UPTR: memory
> - *   pinned to the kernel cannot exceed a page nor can it cross the page boundary. The
> - *   library normally calls malloc(2*X) given X bytes of total TLDs, and only uses
> - *   aligned_alloc(PAGE_SIZE, X) when X >= PAGE_SIZE / 2. This is to reduce memory wastage
> - *   as not all memory allocator can use the exact amount of memory requested to fulfill
> - *   aligned_alloc(). For example, some may round the size up to the alignment. Enable the
> - *   option to always use aligned_alloc() if the implementation has low memory overhead.
> + *   For some memory allocators, when calling aligned_alloc(alignment, size), size
> + *   does not need to be an integral multiple of alignment and it can be fulfilled
> + *   without using round_up(size, alignment) bytes of memory. Enable this option to
> + *   reduce memory usage.
>   */
>  
>  #define TLD_PAGE_SIZE getpagesize()
> @@ -68,6 +65,8 @@
>  #define TLD_ROUND_MASK(x, y) ((__typeof__(x))((y) - 1))
>  #define TLD_ROUND_UP(x, y) ((((x) - 1) | TLD_ROUND_MASK(x, y)) + 1)
>  
> +#define TLD_ROUND_UP_POWER_OF_TWO(x) (1UL << (sizeof(x) * 8 - __builtin_clzl(x - 1)))
> +
>  #define TLD_READ_ONCE(x) (*(volatile typeof(x) *)&(x))
>  
>  #ifndef TLD_DYN_DATA_SIZE
> @@ -111,7 +110,6 @@ struct tld_map_value {
>  
>  struct tld_meta_u * _Atomic tld_meta_p __attribute__((weak));
>  __thread struct tld_data_u *tld_data_p __attribute__((weak));
> -__thread void *tld_data_alloc_p __attribute__((weak));
>  
>  #ifdef TLD_FREE_DATA_ON_THREAD_EXIT
>  pthread_key_t tld_pthread_key __attribute__((weak));
> @@ -153,12 +151,10 @@ static int __tld_init_meta_p(void)
>  
>  static int __tld_init_data_p(int map_fd)
>  {
> -	bool use_aligned_alloc = false;
>  	struct tld_map_value map_val;
>  	struct tld_data_u *data;
> -	void *data_alloc = NULL;
>  	int err, tid_fd = -1;
> -	size_t size;
> +	size_t size, size_pot;
>  
>  	tid_fd = syscall(SYS_pidfd_open, sys_gettid(), O_EXCL);
>  	if (tid_fd < 0) {
> @@ -166,48 +162,37 @@ static int __tld_init_data_p(int map_fd)
>  		goto out;
>  	}
>  
> -#ifdef TLD_DATA_USE_ALIGNED_ALLOC
> -	use_aligned_alloc = true;
> -#endif
> -
>  	/*
>  	 * tld_meta_p->size = TLD_DYN_DATA_SIZE +
>  	 *          total size of TLDs defined via TLD_DEFINE_KEY()
>  	 */
>  	size = tld_meta_p->size + sizeof(struct tld_data_u);
> -	data_alloc = (use_aligned_alloc || size * 2 >= TLD_PAGE_SIZE) ?
> -		aligned_alloc(TLD_PAGE_SIZE, size) :
> -		malloc(size * 2);
> -	if (!data_alloc) {
> +	size_pot = TLD_ROUND_UP_POWER_OF_TWO(size);
> +#ifdef TLD_DONT_ROUND_UP_DATA_SIZE
> +	data = (struct tld_data_u *)aligned_alloc(size_pot, size);
> +#else
> +	data = (struct tld_data_u *)aligned_alloc(size_pot, size_pot);
> +#endif
> +	if (!data) {
>  		err = -ENOMEM;
>  		goto out;
>  	}
>  
>  	/*
>  	 * Always pass a page-aligned address to UPTR since the size of tld_map_value::data
> -	 * is a page in BTF. If data_alloc spans across two pages, use the page that contains large
> -	 * enough memory.
> +	 * is a page in BTF.
>  	 */
> -	if (TLD_PAGE_SIZE - (~TLD_PAGE_MASK & (intptr_t)data_alloc) >= tld_meta_p->size) {
> -		map_val.data = (void *)(TLD_PAGE_MASK & (intptr_t)data_alloc);
> -		data = data_alloc;
> -		data->start = (~TLD_PAGE_MASK & (intptr_t)data_alloc) +
> -			      offsetof(struct tld_data_u, data);
> -	} else {
> -		map_val.data = (void *)(TLD_ROUND_UP((intptr_t)data_alloc, TLD_PAGE_SIZE));
> -		data = (void *)(TLD_ROUND_UP((intptr_t)data_alloc, TLD_PAGE_SIZE));
> -		data->start = offsetof(struct tld_data_u, data);
> -	}
> +	map_val.data = (void *)(TLD_PAGE_MASK & (intptr_t)data);
> +	data->start = (~TLD_PAGE_MASK & (intptr_t)data) + sizeof(struct tld_data_u);
>  	map_val.meta = TLD_READ_ONCE(tld_meta_p);
>  
>  	err = bpf_map_update_elem(map_fd, &tid_fd, &map_val, 0);
>  	if (err) {
> -		free(data_alloc);
> +		free(data);
>  		goto out;
>  	}
>  
>  	tld_data_p = data;
> -	tld_data_alloc_p = data_alloc;
>  #ifdef TLD_FREE_DATA_ON_THREAD_EXIT
>  	pthread_setspecific(tld_pthread_key, (void *)1);
>  #endif
> @@ -375,9 +360,8 @@ static void *tld_get_data(int map_fd, tld_key_t key)
>  __attribute__((unused))
>  static void tld_free(void)
>  {
> -	if (tld_data_alloc_p) {
> -		free(tld_data_alloc_p);
> -		tld_data_alloc_p = NULL;
> +	if (tld_data_p) {
> +		free(tld_data_p);
>  		tld_data_p = NULL;
>  	}
>  }
> -- 
> 2.52.0
