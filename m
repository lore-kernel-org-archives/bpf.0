Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792664737;
	b=F8N+0plVdoAkFXzKZjm6QnPValtQ3M5VS9V8IVywGyBeGC0UM4hN1tRXPUtsgYnkI44g
	 6CNnRTAG0d9za2vqLfAqPQ2HZ73E/eMAra51R+OzsTb13YoqFnz/u1vgEbtm6T5VwHyVO
	 vxEZiFnuQtH2OaGfMFYJUCR5xGtJmAaET69dbrWYU7J3oVA0K1+UkyCrOlU6ZR0BkbpRG
	 X6yk6oAlJFGrYZ4fuLos2R/Vv1jmCAT8/keAypJdQPwLPo8lS1rf9jD0T+PffNfyZj6PZ
	 i4SU+OpI8dYk+xeSMWJStf3uKviIbqM4Ya4z/9ekeGlKe+CASiN8uGYVP6RbFE2fiiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664737;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NDsI0V/DrB0oah071lr270oK5k2KUhctBjE7DETfs40=;
	b=va3ltC9pRP/U0rrrH0anq9ci/sGfQ+YYJoQiZSWYyuHeYVt5Ga+CFYJSfVGnObkIRCRN
	 7RNjAL9WJBFHahtqDHjFaxKpUjDlg57hQ2tvm2/8pfpsHSZvXXCvtCfj1PFt+Ud8NrIpx
	 MLTgPSHx3qgCmWyrdh1/9I6YP78PdXBcrqZzfN1JT2i2QKT8wu5qphgx77wCoAxDQolVQ
	 FWQFhcjGpOXYRm5gq5I4i4tSiyOOG0mJKIlYLIzh+Y0k6iOoOc0A5VxoILMtXLrPhNTLc
	 Nkxb/PlDh3RLkyx0sPHRlWlCbD1rFMQ7P7WRl8i8UlBPPbFAfDZTsqjpamcwTG5QaWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQeZti5A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE1A606A319;
	Thu, 22 Oct 2026 10:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQeZti5A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BF01F000C1;
	Thu, 22 Oct 2026 10:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792664736;
	bh=NDsI0V/DrB0oah071lr270oK5k2KUhctBjE7DETfs40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iQeZti5A3LdIdAWPvUzMpxpmbMHI195SAFMfniFpmwTfM2Tdf2f2a5+3uRRnsMJco
	 21chjCodtp6w6WFflNdaWUHSjRqg96YHecPIoDkSM+OnpdRdPn4Ea89ucr+YeihBTQ
	 ZgXq0WLhbXPux6BGXVbIIWncwK702hzgm5s6kr2Qz3BTKhzx09DuWBkcb3lLKLtfBE
	 COoHsjMoWDcUV8Gs4XXuGiBSXTRbXOhdrLW4ONiWs4DMdqE2sULTv67HyUaPY8+Rhg
	 U90V0/SmTUz2sZdXd2QQ2e3PwIGLe/F3GIE/0SaWwa5uQojXaMZnode5rwkyC5EnOJ
	 thTp8OZXHHKWA==
Date: Thu, 22 Oct 2026 11:25:31 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [RFC bpf-next 3/9] mm: Expose locked mprotect operation
Message-ID: <atnjEc2-6CuKjFzH@gremlin>
References: <20261021195759.119421-1-jolsa@kernel.org>
 <20261021195759.119421-4-jolsa@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021195759.119421-4-jolsa@kernel.org>

On Wed, Oct 21, 2026 at 09:57:52PM +0200, Jiri Olsa wrote:
> The bpf_user_page_exec() in following patch needs to change page
> protections while holding current->mm's mmap write lock.
>
> Exposing the do_mprotect_pkey_locked helper for that.

Err, we'll need some more justification than this for exposing internal mm
logic to the rest of the kernel please.

Note that you're already allowing any caller to bypass
CONFIG_ARCH_HAS_PKEYS here which is immediately a broken thing.

>
> Assisted-by: Codex:GPT-6
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

It's a no to this in its current form.

> ---
>  include/linux/mm.h |  3 +++
>  mm/mprotect.c      | 20 +++++++++++++++-----
>  2 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 63f40e615754..47e853093601 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3435,6 +3435,9 @@ extern long change_protection(struct mmu_gather *tlb,
>  extern int mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
>  	  struct vm_area_struct *vma, struct vm_area_struct **pprev,
>  	  unsigned long start, unsigned long end, vm_flags_t newflags);
> +/* Caller must hold current->mm's mmap write lock. */
> +int do_mprotect_pkey_locked(unsigned long start, size_t len,
> +			    unsigned long prot, int pkey);
>
>  /*
>   * doesn't attempt to fault and will return short.
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 2888ee638d87..8d800830d3e1 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -868,8 +868,8 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
>  /*
>   * pkey==-1 when doing a legacy mprotect()
>   */
> -static int do_mprotect_pkey(unsigned long start, size_t len,
> -		unsigned long prot, int pkey)
> +int do_mprotect_pkey_locked(unsigned long start, size_t len,
> +			    unsigned long prot, int pkey)
>  {
>  	unsigned long nstart, end, tmp, reqprot;
>  	struct vm_area_struct *vma, *prev;
> @@ -899,8 +899,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
>
>  	reqprot = prot;
>
> -	if (mmap_write_lock_killable(current->mm))
> -		return -EINTR;
> +	mmap_assert_write_locked(current->mm);
>
>  	/*
>  	 * If userspace did not allocate the pkey, do not let
> @@ -1013,10 +1012,21 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
>  		error = -ENOMEM;
>
>  out:
> -	mmap_write_unlock(current->mm);
>  	return error;
>  }
>
> +static int do_mprotect_pkey(unsigned long start, size_t len,
> +			    unsigned long prot, int pkey)
> +{
> +	int ret;
> +
> +	if (mmap_write_lock_killable(current->mm))
> +		return -EINTR;
> +	ret = do_mprotect_pkey_locked(start, len, prot, pkey);
> +	mmap_write_unlock(current->mm);
> +	return ret;
> +}
> +
>  SYSCALL_DEFINE3(mprotect, unsigned long, start, size_t, len,
>  		unsigned long, prot)
>  {
> --
> 2.54.0
>

--
Cheers, Lorenzo
