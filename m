Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FE335F8D1;
	Thu, 21 May 2026 23:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406417; cv=none; b=QYUxLwb9gmtjssxVegO04o/20T2duiCbvGfdn7JRWIuGP7QxkK16yP1SndNnvX7+Uyb7ppoVCRg8bb29ri7Qjs/VzLV5FztywuxMLfRsgmSdgXz95Jhe0Mz5r+BfDUgFSERbhp6QMr44VB7UitoJjdXl0PRHIWZGWlOeCA2pT1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406417; c=relaxed/simple;
	bh=1Lu3JaCJ8DZOkGazIvCtxJABfEBxv+B0qL47yUHKzY8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=q2GYJyH1NBmi88vKCa3NK+MIC428W+Z1O51WCmgkH2jlXo5grdRihUJT7x2iao64oOT8C217ItXh4rMGovvpbuYi89+wX7DP2apoTq8dkRTGsCjaKO2RFwtEu5yu+eqq5IYHoTrkoeAuZST0KY4oMta9aE20yLkMCRvr8YNZuZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWARJBcO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWARJBcO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3C61F00A3B;
	Thu, 21 May 2026 23:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779406415;
	bh=mvIQNCtFQBUYRf613I/JdmATsMN+FnR5gdEuCLKs3Vg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IWARJBcOdEjLxfmzOp7Q+RWYHjBuJbF+ceVqAUJrIAc8Too+icb4JyeP/HdY2Af1X
	 vqdVvIC/nJQxwqSg+9LMSxh0RHRezTdHecogSrXYZW4cxthKt+xNNZo0OpXaBjlnBm
	 w6Q1oj37OWHgsEz2sIx9vE6o59sD9tYk//h+a85oPQbokU+USD+fcxtpAp0nHHicKz
	 keUHfdrq2uAuxliQtQUWBnI6iVT5d/EvPRXncOHdFnHEZ530Cc52Dd9HQc5ogCN3+v
	 6Nvtsz9DyJpS2ZVapF17lb18pjy3jx+QLFmXUh4ARf9m2SwJW48kAhtetlMjzLG8bn
	 lCSfqrBsJQWRQ==
Content-Type: multipart/mixed; boundary="===============6549390519885862936=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <226398c1ff3f2b686c0aeb010408d85fb15df13f9ff60a045bee31e79b9e41e9@mail.kernel.org>
In-Reply-To: <20260521225022.2695755-3-ihor.solodrai@linux.dev>
References: <20260521225022.2695755-3-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v6 2/3] bpf: Avoid faultable build ID reads under mm locks
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com
Cc: puranjay@kernel.org,shakeel.butt@linux.dev,mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 21 May 2026 23:33:35 +0000 (UTC)

--===============6549390519885862936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 4c753e02c415..95336c0e8b56 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c

[ ... ]

> @@ -174,6 +175,107 @@ static inline void stack_map_build_id_set_valid(struct bpf_stack_build_id *id,
>  		memcpy(id->build_id, build_id, BUILD_ID_SIZE_MAX);
>  }
>
> +struct stack_map_vma_lock {
> +	bool vma_locked;
> +	struct vm_area_struct *vma;
> +	struct mm_struct *mm;
> +};
> +
> +static struct vm_area_struct *stack_map_lock_vma(struct stack_map_vma_lock *lock, unsigned long ip)
> +{
> +	struct mm_struct *mm = lock->mm;
> +	struct vm_area_struct *vma;
> +
> +	if (WARN_ON_ONCE(!mm))
> +		return NULL;
> +
> +	vma = lock_vma_under_rcu(mm, ip);
> +	if (vma)
> +		goto vma_locked;
> +
> +	/*
> +	 * Taking mmap_read_lock() is unsafe here, because the caller
> +	 * BPF program might already hold it, causing a deadlock.
> +	 */
> +	if (!mmap_read_trylock(mm))
> +		return NULL;
> +
> +	vma = vma_lookup(mm, ip);
> +	if (!vma) {
> +		mmap_read_unlock(mm);
> +		return NULL;
> +	}
> +
> +#ifdef CONFIG_PER_VMA_LOCK
> +	if (!vma_start_read_locked(vma)) {
> +		mmap_read_unlock(mm);
> +		return NULL;
> +	}
> +	mmap_read_unlock(mm);
> +#else
> +	mmap_read_unlock(mm);
> +	return NULL;
> +#endif

Does the fallback for kernels built without CONFIG_PER_VMA_LOCK completely
disable build ID parsing?

Looking at the #else branch, it unconditionally drops mmap_read_lock and
returns NULL. This causes the caller to receive a NULL VMA for every IP,
which skips parsing and falls back to returning IP-only traces.

Could this instead keep mmap_read_lock held, return the VMA, and allow the
caller to extract the file reference, vm_pgoff, and vm_start before safely
dropping the lock?

This was raised by sashiko-bot@kernel.org in v4 and v5 at:
https://lore.kernel.org/bpf/20260515012547.EFF40C2BCB3@smtp.kernel.org/

> +vma_locked:
> +	lock->vma_locked = true;
> +	lock->vma = vma;
> +	return vma;
> +}
> +
> +static void stack_map_unlock_vma(struct stack_map_vma_lock *lock)
> +{
> +	struct vm_area_struct *vma = lock->vma;
> +
> +	if (lock->vma_locked) {
> +		if (WARN_ON_ONCE(!vma))
> +			goto out;
> +		vma_end_read(vma);
> +	}
> +out:
> +	lock->vma_locked = false;
> +	lock->vma = NULL;
> +}
> +
> +static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *id_offs,
> +						    u32 trace_nr)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct stack_map_vma_lock lock = {
> +		.vma_locked = false,
> +		.vma = NULL,
> +		.mm = mm,
> +	};
> +	struct vm_area_struct *vma;
> +	struct file *file;
> +	u64 offset;
> +	u64 ip;
> +
> +	for (u32 i = 0; i < trace_nr; i++) {
> +		ip = READ_ONCE(id_offs[i].ip);
> +
> +		vma = stack_map_lock_vma(&lock, ip);
> +		if (!vma || !vma->vm_file) {
> +			stack_map_build_id_set_ip(&id_offs[i]);
> +			stack_map_unlock_vma(&lock);
> +			continue;
> +		}

Is using !vma->vm_file to classify anonymous VMAs fully correct?

Per mm-vma.md's VMA classification rules, the canonical test for anonymous
VMAs is vma_is_anonymous() (i.e. !vma->vm_ops). Some anonymous VMAs carry a
vm_file reference. For example, private mappings of /dev/zero set via
vma_set_anonymous() leave vm_file populated while clearing vm_ops.

While this won't cause a crash (build_id_parse_file would fail gracefully),
it causes unnecessary sleepable read attempts on pseudo-files.

This was raised by bot+bpf-ci@kernel.org and sashiko-bot@kernel.org across
v3, v4, and v5 at:
https://lore.kernel.org/bpf/0e2084173f17252ff227aba064e534682b52a7a451280c0df4041825ebae30b6@mail.kernel.org/

> +
> +		file = get_file(vma->vm_file);
> +		offset = stack_map_build_id_offset(vma->vm_pgoff, vma->vm_start, ip);
> +		stack_map_unlock_vma(&lock);
> +
> +		/* build_id_parse_file() may block on filesystem reads */
> +		if (build_id_parse_file(file, id_offs[i].build_id, NULL)) {
> +			stack_map_build_id_set_ip(&id_offs[i]);
> +			fput(file);
> +			continue;
> +		}
> +		fput(file);
> +
> +		stack_map_build_id_set_valid(&id_offs[i], offset, id_offs[i].build_id);
> +	}
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26258400944
--===============6549390519885862936==--
