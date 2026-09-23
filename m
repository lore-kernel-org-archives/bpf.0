Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF2D3D810F
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191701; cv=none; b=CuREqHtoXZUeO0am38TpkFfToo1SwqEITqQD0dLGdMyf+gJ4lNhR7Ronj1kinvaI3Zv8sC7xFJwer+ekZcGW683FeAq3DWGjBiGNfbV2BVl1hWM3b+eFzU78d1x1CJz9F+xsNl2U78xnCRxK+4TyGoB0uQGq1B7QYkEMz52cMRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191701; c=relaxed/simple;
	bh=T8aaX97K3vOUq1veCKMzjTkLsDgXC4akS1yAQB/+eLQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AU0n/2XsqOMHsOkjbGpAVpuQkkI+AEf+fZJuUzszQrZmuJBNApSx9HjzWGERNU2WA56Ia0jKiRhj4HXOFXLBoMVdkAMgxQXxpTAyq4dKxsoUHTOa0pAuqRZsaNi//oNpx6A71TSW9jwvwju9efmqlZtvnmrnuJVd3um+cnw2X8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEt6X5Q2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEt6X5Q2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F4D1F000FF;
	Wed, 23 Sep 2026 19:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790191699;
	bh=bcJBOzwQED6qLYIz4RWgdA3+pFnmB+2r2w3K2az31aE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iEt6X5Q23btuzhgv5MBng/ufdrIe1O1SFyGGbvVrgKjF0ePp2uMXNS0C0KUlxVNAh
	 +qIs+vZ9vUg6E6vw8ov4uMEPsKKxRO83QWrH1PdCE754DARYaemk5HQqRB2GLN5RTf
	 xdcr3+iBaHw2H2N3enbLxEl1vkVvhdV8SH3/I6DcT+wLg1+kdJrp0C6rFu5+YwjJxW
	 TQrXTh11cZI/jtX+qUVNs2rv4LS1UGJR19WLRhCPSKdt8e1AqCrTBsbQhE58Zxw5yN
	 nneVr6oyZ+ACUjlgblAVgfJzFmOarns2MHjc20lLPj6awt85gHeQVENvpdVi6OB58M
	 24uP/dTIJdHmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 5/6] bpf: Atomically update PTE and range
 tree in arena VM fault handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260923191125.5311-6-emil@etsalapatis.com>
References: <20260923191125.5311-1-emil@etsalapatis.com>
 <20260923191125.5311-6-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 19:28:19 +0000
Message-Id: <20260923192819.B4F4D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] bpf: memory isolation breach on arena spinlock -EDEADLK
- [Medium] bpf: spurious VM_FAULT_SIGBUS on concurrent arena page faults
--

commit a5d5ccfbb2dd50c63d33c5a9de680c3dad099509
Author: Emil Tsalapatis <emil@etsalapatis.com>

bpf: Atomically update PTE and range tree in arena VM fault handler

This commit modifies the arena VM fault handler to atomically adjust the
range tree and insert PTEs, avoiding deadlocks with the range tree spinlock
under PREEMPT_RT. It does this by marking the range as unavailable, dropping
the lock to insert the PTE, then re-acquiring the lock to fully remove the
range.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 69c8924f4c306..5438b68d269a8 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -562,7 +565,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>  	/* If a range is unavailable, try again. */
>  	if (ret =3D=3D -EAGAIN) {
>  		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> -		goto retry;
> +		goto retry_memcg;
>  	} else if (ret) {
[ ... ]
> @@ -583,12 +586,40 @@ static vm_fault_t arena_vm_fault(struct vm_fault *v=
mf)
[ ... ]
> +	fault_ret =3D vmf_insert_page(vmf->vma, vmf->address, page);
> +	while ((ret =3D raw_res_spin_lock_irqsave(&arena->spinlock, flags))) {
> +		/* If we somehow deadlocked stop trying to take the lock. */
> +		if (ret =3D=3D -EDEADLK) {
> +			range_node_mark_available(unavail_node);
> +			return VM_FAULT_SIGBUS;
> +		}

[Severity: Critical]
Does this error path leave memory isolation broken? By calling
range_node_mark_available(), it marks the range as free in the arena's range
tree allocator.=20

However, the page was already mapped into the kernel vmap via
apply_to_page_range() and the user page tables via vmf_insert_page().

If the lock returns -EDEADLK, subsequent allocations might hand out this sa=
me
page to other BPF programs or userspace, potentially causing two independent
users to share and corrupt the same memory. Should this path unmap the page
before returning?

> +
> +		cond_resched();
> +	}
[ ... ]
> @@ -598,8 +629,9 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
[ ... ]
> -retry:
> +retry_memcg:
>  	bpf_map_memcg_exit(old_memcg, new_memcg);
> +retry:
>  	if (new_page)
>  		free_pages_nolock(new_page, 0);
> =20
>  	if (!(vmf->flags & FAULT_FLAG_ALLOW_RETRY))
>  		return VM_FAULT_SIGBUS;

[Severity: Medium]
Will this lead to spurious process crashes for concurrent faults? When two
threads concurrently page-fault on the same arena page, the first thread ma=
rks
the range as unavailable and drops the spinlock to call vmf_insert_page().

The second thread sees the unavailable range via range_tree_clear(), which
returns -EAGAIN. This sends the second thread to retry_memcg and it returns
VM_FAULT_RETRY.=20

When the kernel fault handler drops the mmap lock and retries the fault, it
clears FAULT_FLAG_ALLOW_RETRY. If the first thread hasn't removed the
unavailable node yet, the second thread hits -EAGAIN again, fails this flag
check, and returns VM_FAULT_SIGBUS instead of waiting.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923191125.5311=
-1-emil@etsalapatis.com?part=3D5
