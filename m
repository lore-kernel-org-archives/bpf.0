Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E612E7F38;
	Wed,  8 Apr 2026 01:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775610321; cv=none; b=Y+7w9FJOQiX74QgMhC1vOZwVK8uNTpTi9en3u55dDp+hFdbBsnj15MfmsXWanuxfDJ11hFehDq1qBwZwxMkZt8xyYrTMUhkRMdvuulnOK/Cl0Nr+8hV9mPKz7NPIPgrvBNIrdi5bz4LGx3fASmH4rOYlz/GxJOnhrBRetGWHeS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775610321; c=relaxed/simple;
	bh=Q4yVU68CrfxJfTfKZ/bkzfqnmsOaGFqHQQGVeNDNIJ8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=H/fDShnjiUQSU3Iv0yBB1XaMMDtfhDsHjFBNuU1uAneL376O8lgXJFuaOhJqw9rCCPmoFV2k2MFPzFIA4LnqVISiWh0kg0PhMDo3K2ZlF/Wo1A5wZK4E5BRZqwsineXR5OdsuX4g7jp7CICRJZetXJk1fRo3TYgXLSxTKe9ONAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRVqGwC1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRVqGwC1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E86C116C6;
	Wed,  8 Apr 2026 01:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775610321;
	bh=Q4yVU68CrfxJfTfKZ/bkzfqnmsOaGFqHQQGVeNDNIJ8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=rRVqGwC1XTrluxHHI2+hFZZZhlWqRALiMcg885i1qPIgFb9d4ioh21ZafMcZOCM0s
	 Cj4ejDGSEZPyAiYsr/iw/Ug0/IvKKu3XG58dsBLEAiLQil+GilSX72Nso0DfURoF/B
	 HSuuGKo1xctU2U3vesHj/oT2irgaSVkiQ/e246Fxyt2gxgRIs2xV5fOZGd9JQRsNZb
	 Zhn3AF/5qb3WxTaZeLjdaVPz+s7VwYlKYKdcTBYdFGC/hdanSXJjSA483C0Bi2nibg
	 gKzY/ufx42Z+NTyO7Np74k+H9+yRG0df6wq6+cC2dZxQsla826XNInfyRzCwMOZyfO
	 O23NiwDfbNZgw==
Content-Type: multipart/mixed; boundary="===============0020776247302409624=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e243df5b89176efe6cdf678bf9d588d619ad6d8426b1973e1beb4cf1c650c6c4@mail.kernel.org>
In-Reply-To: <20260407223003.720428-1-ihor.solodrai@linux.dev>
References: <20260407223003.720428-1-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf v1] bpf: Avoid faultable build ID reads under mm locks
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,song@kernel.org
Cc: puranjay@kernel.org,shakeel.butt@linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  8 Apr 2026 01:05:20 +0000 (UTC)

--===============0020776247302409624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index da3d328f5c15..017ecbc22c96 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c

[ ... ]

> +static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *id_offs,
> +						    u32 trace_nr)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *vma;
> +	struct file *file;
> +	u64 ip;
> +
> +	for (u32 i = 0; i < trace_nr; i++) {
> +		ip = READ_ONCE(id_offs[i].ip);
> +		vma = stack_map_lock_vma(mm, ip);
> +		if (!range_in_vma(vma, ip, ip) || !vma->vm_file) {
> +			stack_map_build_id_set_ip(&id_offs[i]);
> +			if (vma)
> +				vma_end_read(vma);
> +			continue;
> +		}
> +
> +		file = get_file(vma->vm_file);
> +		vma_end_read(vma);
> +
> +		/* build_id_parse_file() may block on filesystem reads */
> +		if (build_id_parse_file(file, id_offs[i].build_id, NULL)) {
> +			stack_map_build_id_set_ip(&id_offs[i]);
> +		} else {
> +			id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + ip - vma->vm_start;
> +			id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
> +		}

After vma_end_read(vma) drops the per-VMA read lock, can vma->vm_pgoff
and vma->vm_start still be safely accessed here? It looks like the VMA
could be split, merged, or freed by another thread while
build_id_parse_file() blocks on filesystem I/O.

The non-sleepable path in stack_map_get_build_id_offset() reads these
same fields under mmap_read_lock, which keeps the VMA stable. Here the
lock is already gone.

Saving vm_pgoff and vm_start to local variables before vma_end_read()
would close the window, similar to the approach in the procfs patch
referenced in the commit message.

> +
> +		fput(file);
> +	}
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24111574515
--===============0020776247302409624==--
