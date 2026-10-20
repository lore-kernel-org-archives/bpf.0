Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505835;
	b=xOQCMNJWA9sZYW5MjpuOgX9wK/Dnk8Kdt9V3NAsO5i7vjY5ywX0gDbSq/PlZ+hllIh90
	 rW57xNhMCekBTswm5JSZxozF7PgfHR/Y7r3jrmNvUYTvUPUX1SYnhlio/+0z77xidfeDs
	 GQ4vj5AMZGUkrTaZ7YhJptXODdZ6oXfIXREXyUiKLqHKdj+nC6MtVTkXwWwuvs3sK1Bg4
	 B4KCM6Z2vs/O4wh73kCxRmV+rtUHTNFdRhb2ovAIFhLoECy7rN+FjRG1ZkONfJIMYv7Ct
	 jtm2n3EElgv+iXvNjdK8xFHhL4EUPrioZfV5BpFfwKxSivA/oiNFna/lTRmKnATBN4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505835;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=LW9SqWypznNch6MsxfasV2/XAf80QtBLLlx4Yh8uaWI=;
	b=uz192alkq8FBTtkfJ5KBggbdmCrsaTM56bizmidhq3FETRbXUANEyBrE2pM4OI3ihBkd
	 C/PNzO5K0lULNIaoWnxPA/d02TO18iU3pc3TcAUpQBi8STa89heodsWiAGhtqc2AvPT7D
	 MsDXcE7ftYXVFFDAoAXsBcw5sUMggoA8YHQXUlVQh+UlL9Plmyxn0qPcJuRcXISF8jIjE
	 kc6Y4EHjAjfzOg7QTw8PnVr9QA6v6eCjoqRgAPydKHv3RwJQ5JWUa9aObkiJjPEFviQQG
	 EtFVsUZnvyu6Pg7Xa87pa750Nz0c0GqKE0aXxPugK7jyrUxVb0pmPSWTKqtCJKXr/YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZdQEQIV0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6464A606A327;
	Tue, 20 Oct 2026 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZdQEQIV0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29EA1F000C4;
	Tue, 20 Oct 2026 14:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792505835;
	bh=LW9SqWypznNch6MsxfasV2/XAf80QtBLLlx4Yh8uaWI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZdQEQIV0PMomNuziuHoTjx3T7q6jdZxZirB0kE6jfOB4ete+uu3/yVEDTlu7RL9F3
	 d3tUuykJRo4iZuuzSJbgEyylMOvedMGA0fHWdZRdBmGx6p60dDNYAv9/8gKOQFLDFZ
	 MfaWK1/FbyLQ2zv2fD1jOFafF5leVspsCdXWAdgvWe3m7UtAB6PA/IL4x3GHZBV9iu
	 jhdZr3E+uZFPOlJnYm4BSWG+ffmZn7Q7vXkRNU8Q7paUbdzhECmA8JqARQB8lZaGlf
	 hO9au3lnfSf8EYwJRyos2PcZB8MN7fDaVl0RPohlKJycrBxMir4EytkKwG/4r3/e7K
	 G7JauRFQzB6LA==
Content-Type: multipart/mixed; boundary="===============5502121670553229102=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <9e3c68360cf25fad73a6c9397f0e77d8b35d8a6cb72d129b66328ea4fe7bfe18@mail.kernel.org>
In-Reply-To: <2f1a53eb72a6fdb93346cb4e1d04a5d472177b1c.1792503001.git.xukuohai@huawei.com>
References: <2f1a53eb72a6fdb93346cb4e1d04a5d472177b1c.1792503001.git.xukuohai@huawei.com>
Subject: Re: [PATCH bpf-next 08/16] bpf: Extend syscall to accept arena percpu information
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,emil@etsalapatis.com,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 14:17:14 +0000 (UTC)

--===============5502121670553229102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Extend syscall to accept arena percpu information

TL;DR:
- BPF_MAP_CREATE may silently accept arena percpu fields for non-arena map
  types, blocking future uapi use
- A nonzero percpu chunk offset with zero size is not validated

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 868589f07330..05cd6397adae 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -298,6 +301,17 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
>  		/* user vma must not cross 32-bit boundary */
>  		return ERR_PTR(-ERANGE);
>
> +	if (attr->arena_percpu_chunk_sz) {
> +		u64 offset = attr->arena_percpu_chunk_off;
> +		u64 size = attr->arena_percpu_chunk_sz;
> +
> +		if (!IS_ALIGNED(offset, PAGE_SIZE) || !IS_ALIGNED(size, PAGE_SIZE))
> +			return ERR_PTR(-EINVAL);
> +
> +		if (offset > vm_range || size > (vm_range - offset) / nr_cpu_ids)
> +			return ERR_PTR(-E2BIG);
> +	}
> +
>  	kern_vm = get_vm_area(KERN_VM_SZ, VM_SPARSE | VM_USERMAP);
>  	if (!kern_vm)
>  		return ERR_PTR(-ENOMEM);

[ ... ]

> @@ -311,6 +325,10 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
>  	if (arena->user_vm_start)
>  		arena->user_vm_end = arena->user_vm_start + vm_range;
>
> +	arena->percpu_chunk_sz = attr->arena_percpu_chunk_sz;
> +	if (attr->arena_percpu_chunk_sz)
> +		arena->percpu_chunk_off = attr->arena_percpu_chunk_off;
> +

If userspace passes arena_percpu_chunk_off != 0 with arena_percpu_chunk_sz
== 0, is the offset ever validated?

In that case the alignment and range checks above are skipped, the offset is
ignored, and arena->percpu_chunk_off stays 0.

The commit message says "Both are checked at arena creation time", which
only holds when arena_percpu_chunk_sz is nonzero.  The excl_prog_hash
handling in map_create_alloc() already rejects the matching case of a size
without a hash:

	} else if (attr->excl_prog_hash_size) {
		...
		err = -EINVAL;

Should arena_map_alloc() return -EINVAL when arena_percpu_chunk_off is
nonzero but arena_percpu_chunk_sz is 0?

[ ... ]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 849bc9136299..240c7349284d 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1396,7 +1396,7 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
>  	return ret;
>  }
>
> -#define BPF_MAP_CREATE_LAST_FIELD excl_prog_hash_size
> +#define BPF_MAP_CREATE_LAST_FIELD arena_percpu_chunk_sz
>  /* called via syscall */
>  static int map_create_alloc(union bpf_attr *attr, bpfptr_t uattr, struct bpf_verifier_log *log,
>  			    struct bpf_map **mapp, struct bpf_token **tokenp)

Does raising BPF_MAP_CREATE_LAST_FIELD here make CHECK_ATTR accept
arena_percpu_chunk_off and arena_percpu_chunk_sz for every map type?

Only arena_map_alloc() reads them, and map_create_alloc() has no check for
these fields.  For example, BPF_MAP_CREATE with map_type =
BPF_MAP_TYPE_HASH and arena_percpu_chunk_sz = 4096 succeeds and the values
are silently dropped.

map_create_alloc() already rejects the comparable per-type field:

	if (attr->map_type != BPF_MAP_TYPE_BLOOM_FILTER &&
	    attr->map_type != BPF_MAP_TYPE_ARENA &&
	    attr->map_type != BPF_MAP_TYPE_RHASH &&
	    attr->map_extra != 0) {
		bpf_log(log, "Invalid map_extra.\n");
		return -EINVAL;
	}

Since current kernels will accept any value in these fields, they can never
later be given a meaning for other map types, or for the offset-only case
above.  Bad loader input, such as percpu info attached to the wrong map, is
also never reported.  No later commit in the series (through 08224ba2de19)
adds this check.

Should map_create_alloc() return -EINVAL when map_type is not
BPF_MAP_TYPE_ARENA and either arena_percpu_chunk_off or
arena_percpu_chunk_sz is nonzero?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39434884362
--===============5502121670553229102==--
