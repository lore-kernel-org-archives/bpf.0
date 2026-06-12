Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CD6367291
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 22:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303827; cv=none; b=q5h4Ze54FBYKYvmUgIihnByYOZkb/1RsnQ7e+tV8DEPtSl/2K1qTrtR3NVDq7W1oEB2gYix7Ce2O8BBTcZl7SJ/fxMemnbTSpxMnr4aiZ4f92BgRjDMg3WumwdwP5eq7BtxF81+HefX9CeWs/UdjMaW9+mj7L1lIVIgvViR374k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303827; c=relaxed/simple;
	bh=4PJ01UDdspMcH2A835EkNvIyr24rXQ21CsjuihaN/lM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VMFgdgKpM8kolkqmrOS27IcbCNuEnVjWxeiKPZ0uh8gW1PwkYjH0zFoG0QU571dhiefL2Iy29/n1k5b+fIIq9V0kaY+f/2wpQSz3sIq+dpOCcfHSDYU0+i/zn1rnhQH4J6yYxbltKysucAXt+9wUxHH1rDozTaEoptKKbyGG65M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7JXpa4t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7JXpa4t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801BD1F000E9;
	Fri, 12 Jun 2026 22:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781303826;
	bh=RwzIle1ZJcqoO4jUAijV7KOIqLVsc8UvM3luLxIddqs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=V7JXpa4trfX2XCdbW+672QkdTxND9SYEplEiziOa0XyIjeOi4JJ/EWSMXtQk27Q2n
	 dlfQDtvtysooxMCHMOOemgBq/gJ3JVpjIxYfxh6+WBRK1s1i4QGSnXMcMHTTIFPFjI
	 r5erEmvnjtlT/ZeU+2glBf+Ti48NXNOzjlgBuEHgoZz3iVwu56nY6SRCGvCaNEnQVZ
	 HJhgMXwWdTdcq1aEYPOhp1PlZewzqCPHRmxqaZwx85u6LvDw5U8WrRUwiX/LfbJIuo
	 n+EIKAMO9XFWto3h6G+Ng6ZWctBTVrnYj4aXE2VrowmUNt3AXWykHY7rU6voS3IJNq
	 2pA01AirUDCZg==
Content-Type: multipart/mixed; boundary="===============4534556307114987586=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f9a5887f90f678d4fbbb021bd603652762132041a16f93a84a99f3607195ebb1@mail.kernel.org>
In-Reply-To: <20260612220651.2507843-1-ihor.solodrai@linux.dev>
References: <20260612220651.2507843-1-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v2] bpf: Better build_id caching in stack_map_get_build_id_offset()
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org
Cc: bpf@vger.kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 12 Jun 2026 22:37:05 +0000 (UTC)

--===============4534556307114987586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 77ba03216c09..822b5cb188ea 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c

[ ... ]

> @@ -343,8 +410,8 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>  	struct mmap_unlock_irq_work *work = NULL;
>  	bool irq_work_busy = bpf_mmap_unlock_get_irq_work(&work);
>  	bool has_user_ctx = user && current && current->mm;
> -	struct vm_area_struct *vma, *prev_vma = NULL;
> -	const unsigned char *prev_build_id = NULL;
> +	struct stack_map_build_id_cache cache = {};
> +	struct vm_area_struct *vma;
>  	int i;
>
>  	if (may_fault && has_user_ctx) {

[ ... ]

> @@ -365,27 +432,29 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>
>  	for (i = 0; i < trace_nr; i++) {
>  		u64 ip = READ_ONCE(id_offs[i].ip);
> -		u64 offset;
>
> -		if (prev_build_id && range_in_vma(prev_vma, ip, ip)) {
> -			vma = prev_vma;
> -			offset = stack_map_build_id_offset(vma->vm_pgoff, vma->vm_start, ip);
> -			stack_map_build_id_set_valid(&id_offs[i], offset, prev_build_id);
> +		if (!stack_map_build_id_set_from_cache(&cache, &id_offs[i], ip))
>  			continue;
> -		}
> +
>  		vma = find_vma(current->mm, ip);
>  		if (!vma || vma_is_anonymous(vma) ||
>  		    fetch_build_id(vma, id_offs[i].build_id, may_fault)) {
> -			/* per entry fall back to ips */
> +			/* per entry fall back to ips; cache build-ID-less range */
>  			stack_map_build_id_set_ip(&id_offs[i]);
> -			prev_vma = vma;
> -			prev_build_id = NULL;
> +			if (vma)
> +				stack_map_build_id_cache_set_unresolved(&cache,
> +						vma->vm_start, vma->vm_end);
>  			continue;
>  		}
> -		offset = stack_map_build_id_offset(vma->vm_pgoff, vma->vm_start, ip);
> -		stack_map_build_id_set_valid(&id_offs[i], offset, id_offs[i].build_id);
> -		prev_vma = vma;
> -		prev_build_id = id_offs[i].build_id;
> +		/* mmap_lock is held for the whole loop, so the cached VMA
> +		 * fields stay valid; no file pinning is needed here.
> +		 */
                ^^^^

This isn't a bug, but should the comment text start on the line after the
opening /* to match the BPF multi-line comment style?

The other multi-line comments added in this patch follow that convention,
such as in the new stack_map_build_id_cache structure and the helper
functions.

> +		stack_map_build_id_set_valid(&id_offs[i],
> +			stack_map_build_id_offset(vma->vm_pgoff, vma->vm_start, ip),
> +			id_offs[i].build_id);
> +		stack_map_build_id_cache_set_resolved(&cache, NULL, id_offs[i].build_id,
> +						      vma->vm_start, vma->vm_end,
> +						      vma->vm_pgoff);
>  	}
>  	bpf_mmap_unlock_mm(work, current->mm);
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27446103592
--===============4534556307114987586==--
