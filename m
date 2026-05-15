Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984491DE8BE;
	Fri, 15 May 2026 01:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778808096; cv=none; b=O/OnLe2EdgWsY5r0Yqk145/4ZnMoR3KhzvrucV4iEgcUiC/5YL0LHJkz5Gbw6IGFDWwbezPLr/PcSJ5zvCqjK3r6n3ciqPpMHh7eyGy0OxD27l3UYQ4kEnpOXPzJwpVGcF32RC5X61197TmVfq5csi1EbPKdgGNLTu2sSnQKCg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778808096; c=relaxed/simple;
	bh=va1MmJzB9jpatPfd8b15nV/hHqGDz5GZkl1l3/PKEcQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NLMxIbtG2fPNUZjdy/43FBcBBuRl2CAIZiLkZsAd6D4d7ZlQQ8gn/wsTNY8NKd7rNzcybEVI7J4aDULzZCS7E+vX0/FHYzqiWPMeorVVCkmrSjnncGGDGRj6erIVqiK3Gyvo2HCPMeCvNCq0+2xih8MhWENhJK/eO6YHsldIyKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y17mkK++; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y17mkK++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BB9C2BCB3;
	Fri, 15 May 2026 01:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778808096;
	bh=va1MmJzB9jpatPfd8b15nV/hHqGDz5GZkl1l3/PKEcQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Y17mkK++jYluLWCdEOwl12OfnLVZrlYLtvy3Mo9SUbzNw1fgJzeyOGzfsOXAbdFK0
	 /67ZrtoYBbDnrSZhmPkGVzCdRJlHdB5sP4Xi1Xu7YeaAVEMTq1LfxRe7WB4XV7XK6h
	 zcj2nA40Fh9SAjsuiqgrxr6FKhGGdxZG0J/HlEWG2DpcYg6aFCIuFhTmXPEEnQl51u
	 3iwW+D2TcHaHtYYnioOWiz2KvPTvQaiXfi/AUp63knpC/G+tStR+QM9eHapGp3yCC5
	 mknc0biR/3KsM1kOHyVQPpDLeVX2Cjss4pCwbxIVqC3bs2zgWy+0G1uC0FRQp0/UjH
	 fKMy7gqIFZF+A==
Content-Type: multipart/mixed; boundary="===============2215204945178447425=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cb33af271c4b87a01e8bcc5e90f6b354028085b255eff6b44c295e4573a78bc5@mail.kernel.org>
In-Reply-To: <20260515005244.1333013-4-ihor.solodrai@linux.dev>
References: <20260515005244.1333013-4-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v5 3/3] bpf: Cache build IDs in sleepable stackmap path
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com
Cc: puranjay@kernel.org,shakeel.butt@linux.dev,mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 15 May 2026 01:21:36 +0000 (UTC)

--===============2215204945178447425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 08f7659505d1..7336fd55c856 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -230,13 +230,33 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
>  		.vma = NULL,
>  		.mm = mm,
>  	};
> -	unsigned long vm_pgoff, vm_start;
> +	struct {
> +		struct file *file;
> +		const unsigned char *build_id;
> +		unsigned long vm_start;
> +		unsigned long vm_end;
> +		unsigned long vm_pgoff;
> +	} cache = {};
> +	unsigned long vm_pgoff, vm_start, vm_end;
>  	struct vm_area_struct *vma;
>  	struct file *file;
>  	u64 ip;
>
>  	for (u32 i = 0; i < trace_nr; i++) {
>  		ip = READ_ONCE(id_offs[i].ip);
> +
> +		/*
> +		 * Range cache fast path: if ip falls within the previously
> +		 * resolved VMA range, reuse the cache build_id without
> +		 * re-acquiring the VMA lock.
> +		 */
> +		if (cache.build_id && ip >= cache.vm_start && ip < cache.vm_end) {
> +			vm_start = cache.vm_start;
> +			vm_end = cache.vm_end;
> +			vm_pgoff = cache.vm_pgoff;
> +			goto build_id_valid;
> +		}
> +
>  		vma = stack_map_lock_vma(&lock, ip);
>  		if (!vma || !vma->vm_file) {
>  			stack_map_build_id_set_ip(&id_offs[i]);

In v3 and v4, sashiko-bot@kernel.org and bot+bpf-ci@kernel.org raised
a concern about VMA classification here. The code uses !vma->vm_file to
determine if a VMA is file-backed, but this could cause issues with
anonymous VMAs that still have a backing file.

Private mappings of /dev/zero or driver memory can have a non-NULL
vma->vm_file but are still considered anonymous. If the stackmap path
proceeds to parse the ELF build ID from these files, could it trigger
unintended side effects, such as consuming FIFO data or altering
hardware state when reading from character devices?

Would it be safer to check vma_is_anonymous(vma) here to properly
classify the VMA?

Original comment from sashiko-bot@kernel.org (v3):
https://lore.kernel.org/bpf/20260513043154.24483C2BCB7@smtp.kernel.org/

> @@ -244,9 +264,21 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
>  			continue;
>  		}
>
> -		file = get_file(vma->vm_file);
> +		file = vma->vm_file;
>  		vm_pgoff = vma->vm_pgoff;
>  		vm_start = vma->vm_start;
> +		vm_end = vma->vm_end;
> +
> +		if (file == cache.file) {
> +			/*
> +			 * Same backing file as previous (e.g. different VMAs
> +			 * of the same ELF binary). Reuse the cache build_id.
> +			 */
> +			stack_map_unlock_vma(&lock);
> +			goto build_id_valid;
> +		}
> +
> +		file = get_file(file);
>  		stack_map_unlock_vma(&lock);
>
>  		/* build_id_parse_file() may block on filesystem reads */
> @@ -255,11 +287,29 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
>  			fput(file);
>  			continue;
>  		}
> -		fput(file);
>
> +		if (cache.file)
> +			fput(cache.file);
> +		cache.file = file;
> +		cache.build_id = id_offs[i].build_id;
> +
> +build_id_valid:
> +		/*
> +		 * In the slow path cache.build_id points to id_offs[i].build_id.
> +		 * Cache hits leave cache.build_id pointing at a prior slot,
> +		 * triggering the memcpy here.
> +		 */
> +		if (cache.build_id != id_offs[i].build_id)
> +			memcpy(id_offs[i].build_id, cache.build_id, BUILD_ID_SIZE_MAX);
> +		cache.vm_start = vm_start;
> +		cache.vm_end = vm_end;
> +		cache.vm_pgoff = vm_pgoff;
>  		id_offs[i].offset = (vm_pgoff << PAGE_SHIFT) + ip - vm_start;
>  		id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
>  	}
> +
> +	if (cache.file)
> +		fput(cache.file);
>  }
>
>  /*

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25894427199
--===============2215204945178447425==--
