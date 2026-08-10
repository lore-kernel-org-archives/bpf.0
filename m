Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E021B3CAA57
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370671; cv=none; b=LQz68NyKWwMFcnf2Udif47u9AiqlmNDj06B8r6PatnCQkuFHUqgN58n8MZcdP2FPY/NCjLTTPxx+XBNc5vsiW4ycmfzVQeEez5BazUKocociWCLH5fSVV1NKLDOB+i/u3PS5GD801brvcR6/8gXw1bRRdQl2eNH83XeX+8ZEYsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370671; c=relaxed/simple;
	bh=Of2VxqqmxQzCY66bQl2w3YZZlttCDamr6CM3EQD0eU0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gJ7SZtI5L9/je9J2LuhL0itljAwa1lRNWZ5Rz1mxPKxuTBfpjAhcD8qEP1QiJaXjocm5jhJhhbiENTzI+OOel8Trt4n2dDwp2T1B3Ugx26rJtgGG8ZlNMBKOJVUfxDQcT3NWOwi8PLQTjIApWHKQgUdiQ77iuQ9FgtYOiNjrXro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoOcG1vm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoOcG1vm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531211F000E9;
	Mon, 10 Aug 2026 14:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786370669;
	bh=x9hJC5Ehv1m4OyDSOoNuhYrDEPqhyH7k2wSLyX9emt4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CoOcG1vmG47CGcjqVs8BnemwCavr/91uCZRYn/Z3cobt+kNbJNuSq2QqAvLKF8ukP
	 ziZMHpVEJ7jAdI/0ETMHzyiICjkE63ZPEThWcRMJEcHAwSodWvVuSiHRanpEC60HJ/
	 25K+OTkYuYRy/ZXsbSgET5vUbCyrEpVkHjoIF3i5taQhDStYHNceu9JoyKAh0CRG+8
	 M/SLCtaNrBE+796xejHgfF/H741ojpuRt+gtLA2ks60xDuo3wQ7dtsQMLC1X9KyQEY
	 qohZGH8YWmuROe+nmSu3kXZb7tQ65eauUdW5U51XaxOC+Ch4Z/L/yJ5QTEkFzkl+Vr
	 MmD2TM5Skw1/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 1/3] bpf, arena: fix range_tree_clear
 inconsistency on kmalloc_nolock failure
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260810134800.2875487-2-chenyuan_fl@163.com>
References: <20260810134800.2875487-1-chenyuan_fl@163.com>
 <20260810134800.2875487-2-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 14:04:28 +0000
Message-Id: <20260810140429.531211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] range_tree_set() modifies the interval tree before attempting a fa=
llible allocation, leaving the tree in a corrupted state on OOM, similar to=
 the bug fixed in range_tree_clear().
- [High] Transient NOWAIT allocation failure in range_tree_clear() causes a=
rena_vm_fault() to trigger a fatal SIGSEGV.
--

--- Patch [1]: [PATCH bpf-next v3 1/3] bpf, arena: fix range_tree_clear inc=
onsistency on kmalloc_nolock failure ---
commit 944fb15c800d7e3cba4552c75753fe7038ce96ab
Author: Yuan Chen <chenyuan@kylinos.cn>

bpf, arena: fix range_tree_clear inconsistency on kmalloc_nolock failure

range_tree_clear() pre-allocates the right-half node before modifying
the tree, so an allocation failure returns -ENOMEM without altering the
range tree.

> diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
> index 2f28886f3ff75..15b588377a769 100644
> --- a/kernel/bpf/range_tree.c
> +++ b/kernel/bpf/range_tree.c
> @@ -143,16 +143,22 @@ int range_tree_clear(struct range_tree *rt, u32 sta=
rt, u32 len)
>  		if (rn->rn_start < start && rn->rn_last > last) {
>  			u32 old_last =3D rn->rn_last;
> =20
> +			/*
> +			 * Pre-allocate the right-half node before modifying
> +			 * the tree. If allocation fails we return -ENOMEM
> +			 * without altering the range tree.
> +			 */
> +			new_rn =3D kmalloc_nolock(sizeof(struct range_node),
> +						__GFP_ACCOUNT, NUMA_NO_NODE);
> +			if (!new_rn)
> +				return -ENOMEM;

[Severity: High]
This isn't a bug introduced by this patch, but does range_tree_set() suffer
from this exact same problem?

Looking at range_tree_set() in kernel/bpf/range_tree.c:

	range_tree_clear(rt, start, len);
	...
	left =3D kmalloc_nolock(sizeof(struct range_node),
			      __GFP_ACCOUNT, NUMA_NO_NODE);
	if (!left)
		return -ENOMEM;

It modifies the tree by calling range_tree_clear() first, and then can fail
its allocation. If arena_free_pages() calls range_tree_set() to return slots
and it fails here, the slots seem to be silently and permanently leaked sin=
ce
the return value is ignored.

Could we apply this same pre-allocation pattern to range_tree_set() as well?

[Severity: High]
This is another pre-existing issue, but does returning -ENOMEM from here
cause unexpected crashes in user space?

Looking at arena_vm_fault() in kernel/bpf/arena.c:

	ret =3D range_tree_clear(&arena->rt, vmf->pgoff, 1);
	if (ret)
		goto out_sigsegv_memcg;

Since arena_vm_fault() handles page faults under a raw spinlock with IRQs
disabled, this kmalloc_nolock() acts as a GFP_NOWAIT allocation. If it fails
under memory pressure, it returns -ENOMEM, which arena_vm_fault() then
translates into VM_FAULT_SIGSEGV.

This causes the faulting user application to be randomly killed with a
segmentation fault rather than retrying or returning OOM.

Could this error handling be improved to avoid crashing the task?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810134800.2875=
487-1-chenyuan_fl@163.com?part=3D1
