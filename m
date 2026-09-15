Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCCD480DD5;
	Tue, 15 Sep 2026 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491228; cv=none; b=MQ5ekqN/OMUa5WMatBl6tIitrMalZnHK36qJUlRUorPn2Ji9RzxYjOPZNxPMc3Jiil3wcu4RvBSOcN2Xl3GOpuOh9M47jtXK5qL1ZrviIk7zWOs0a2PaclvSjQbYoPXCe+qyKck4msQ6P9AnFif8VhYJKsrOjGXzraNz3t8oark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491228; c=relaxed/simple;
	bh=l3ZvLuYlx/+t7ctdiTcG4avgC+vc0rEh+LzyXNpB4p8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=c5ixQg0Yxgjauxm6FIoHmDeDHnkqdw/FwRAFeIWW3hgDxCTfn1x/7YUzj/CKKG98osKT8dTwYKm55O4gHV96UQLg977aTBRGSmsy73ouaZxoohkVDTERggYQEfc7mklwKpAj03Ujue/uQjp00WVlvjFY1Gjjs/FWJWs80R/ll88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWVnpwJb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWVnpwJb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE341F000FF;
	Tue, 15 Sep 2026 16:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789491227;
	bh=vDad/MI7AmkmvEdvfkDBOgNfs9MAtrTUC2XCTt9mqIA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fWVnpwJbo7S9YhN+sHSDYsZEDcMG/kA9hlTe36gltxqI3F0fjzYCgQrCawvw8+W4k
	 +nNLnvg6yDDo/hWi97B6g3pITdMBoIpWRNausiVuN4+1NfkVPwwhZ1LLLRPwTK6EhI
	 f+IZXVaf52psSgGRUlQ+OyiDToDozOjig3yofqnulmxX9P44zOwoutBlg4gqW7kJWq
	 /rzhgXm0oruGpKnBXskBXFqje8sCjGwDfAOYtscSs20gszVz2yBfsd7d5Cf2jzSSlw
	 NwI7rXISnKKUOXSjf/xSHRqn26LZARFbFURzc5rnoEZg8TWdv9TcerEaNnNKPH7O3P
	 Sd2183WhaS4Eg==
Content-Type: multipart/mixed; boundary="===============8549227262384245125=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <10b12a0016e965f98f6789b11c4eaa5afbce2d623d6ddd80bd92105830ec2c13@mail.kernel.org>
In-Reply-To: <20260915161450.96249-1-leon.hwang@linux.dev>
References: <20260915161450.96249-1-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v3] bpftool: Compute map size of light skeletons at runtime
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,linux-kernel@vger.kernel.org,leon.hwang@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 15 Sep 2026 16:53:46 +0000 (UTC)

--===============8549227262384245125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index a50540ef6521..ee680f7c2116 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c

[ ... ]

> diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
> index 1f3f332dffbe..9e16b8e8cb7c 100644
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
> @@ -127,7 +128,7 @@ static inline void skel_free(const void *p)
>   * either bpf_probe_read_kernel() or bpf_copy_from_user() from initial_value
>   * depending on bpf_loader_ctx->flags.
>   */
> -static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
> +static inline void skel_free_map_data(void *p, __u64 addr, size_t val_sz, __u32 max_entries)
>  {
>  	if (addr != ~0ULL)
>  		kvfree(p);
> @@ -138,18 +139,20 @@ static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
>  	 */
>  }
>
> -static inline void *skel_prep_map_data(const void *val, size_t mmap_sz, size_t val_sz)
> +static inline void *skel_prep_map_data(const void *val, size_t val_sz, __u32 max_entries,
> +				       size_t data_sz)
>  {
>  	void *addr;
>
> -	addr = kvmalloc(val_sz, GFP_KERNEL);
> +	addr = kvmalloc(data_sz, GFP_KERNEL);
>  	if (!addr)
>  		return NULL;
> -	memcpy(addr, val, val_sz);
> +	memcpy(addr, val, data_sz);
>  	return addr;
>  }

This isn't a bug, but would naming these something like value_sz and
init_sz make it harder to mix up the map value size and the embedded
blob length? The two names differ by three characters and describe
different quantities, and in the __KERNEL__ variant above val_sz is not
referenced at all while data_sz drives both the kvmalloc() and the
memcpy(). A future edit that reaches for the wrong one would size an
allocation or a copy incorrectly.

>
> -static inline void *skel_finalize_map_data(__u64 *init_val, size_t mmap_sz, int flags, int fd)
> +static inline void *skel_finalize_map_data(__u64 *init_val, size_t val_sz, __u32 max_entries,
> +					   int flags, int fd)

[ ... ]

> @@ -193,25 +197,39 @@ static inline void skel_free(void *p)
>  	free(p);
>  }

[ ... ]

>
> -static inline void *skel_prep_map_data(const void *val, size_t mmap_sz, size_t val_sz)
> +static inline void *skel_prep_map_data(const void *val, size_t val_sz, __u32 max_entries,
> +				       size_t data_sz)
>  {
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

[ ... ]

commit 417792b69014155cfa0ecc10cdffc4c2e54b9e60
Author: Leon Hwang <leon.hwang@linux.dev>

>     bpftool: Compute map size of light skeletons at runtime
>
>     bpftool rounds memory-mapped data map sizes to the host page size when
>     generating a light skeleton. The generated code therefore uses a 64K
>     mapping size when bpftool runs on a 64K-page host, even if the skeleton
>     runs on a 4K-page target. The target rejects the oversized map mmap(),
>     causing failure of loading the light skeleton.
>
>     When try to run 64K-page selftests on 4K-page VM, the error message does
>     not provide the reason about page size.
>
>      test_atomics:PASS:atomics skeleton open 0 nsec
>      test_atomics:FAIL:atomics skeleton load unexpected error: -12 (errno 22)
>      #15      atomics:FAIL

This isn't a bug, but could this sentence be reworded ("When running
64K-page selftests on a 4K-page VM ...") or dropped, since the patch
does not change the error message itself? The sentence is missing a
subject and describes a diagnostics shortcoming that this patch does not
address.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34994524877
--===============8549227262384245125==--
