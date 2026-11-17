Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794913348;
	b=Sbca9pmDprwKbhcxwEG7YQvxc2lxnjhHB1IrnT5pORFcftuQuJTiO5weY6ysU5wbN4+1
	 zIgkMIIEVLpCY9IDdWGbKho3ttd8GOwsJSMWcubvYBtNeku40eSje48ggEqt8UahvoD+L
	 Jn7dcQ4PzjXgE07WYwmvvvPW6OzelBOPLlqiGCGpMJoPGmtSZv/QH9bYau65Ogb0hWZOq
	 qWJTrvAOHlVGqXArXNyBt47rUDn1Zzzix/jaecAmcpUBuwAssiGLYYjSaU2HEGHkGUg2L
	 n/2mHXPTLMxcqr12/XGMfLwYG554qcxnspSS6TVN6kT7Pd5VrNKmj00nBU2cLxQ7DNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794913348;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=N5sxGVFeVAGuxm/pXRnwfOqfgMH816WuDeBFHMyVy4A=;
	b=GehBUMKepTKVw9E3slv9tLm0MORGWL/6h9KcGtue3FwP9A5IR3PWfppokN+z0BkSWGg+
	 oFR9yZBVKF5rH16d0wfmpbImsgz/suGnFqrSQTq85aWh7AH7QktjNvRnqC70sQeRVGDOS
	 n8Sz8wfnqdTc48tbmRFycw56F0kUyvHEma3U/9wIHch0SD0HL2gUZZ8J7YgSLKkU9KYMJ
	 kwPrvsa3SSk32WAtHo8WE79KJVanp/Y2YQNpKh3sEtjy9J0X7GgON8ymCxLZJQFJxpANF
	 z1SlzYP+FMFfJhQVc7NnurkuL57YwdoEvR8+TGCxiDtJ5UAn2x1xwobeL+mm4zqMqdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VXviWfPs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3260606A31C;
	Tue, 17 Nov 2026 11:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VXviWfPs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923AD1F000C4;
	Tue, 17 Nov 2026 11:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794913348;
	bh=N5sxGVFeVAGuxm/pXRnwfOqfgMH816WuDeBFHMyVy4A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VXviWfPsapXpHiX51cNBX0pMOtZm2H9VfY0Pf6fl6lQOWwi8M6w8S1L0FuAZpz1YP
	 R9HmiVW1ehQdR9VqLaJxvW41LhePNgDXvUlKk3dlFb4sz+a1JUGqMM2+DYdmx25lOp
	 qNtxfSqzLUp7geoPJv0nXheT3C9Co18bYivTWVekN5+5up0HNVFPwTrggzM6MESfVq
	 I5wKDyNGM9HXWRCGbh8p5b+dwrpjVd3Gj7bL2vAkiG9zFkDGwMjh5VBgZ1j6ePLOs1
	 RZemf5d009JbYcKgcaN6mGXFS/wsDe+Jnfn+hNFlZpVV2qwv36XgYk6ol2N6VZLS5z
	 AX65fgVZpu5nQ==
Content-Type: multipart/mixed; boundary="===============1861414329617790077=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <0e602faa04ade005445a5dba3c1cebb690e5daefa30f24b07a12a3bbcff6ab61@mail.kernel.org>
In-Reply-To: <20261117103028.4105609-3-arighi@nvidia.com>
References: <20261117103028.4105609-3-arighi@nvidia.com>
Subject: Re: [PATCH 2/3] bpf: Allow importing device-dax pages into an arena
From: bot+bpf-ci@kernel.org
To: arighi@nvidia.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,tj@kernel.org,void@manifault.com,changwoo@igalia.com,joshdon@google.com,vineethrp@google.com,yepeilin@google.com,zhiw@nvidia.com,ltrager@nvidia.com,balbirs@nvidia.com,skolothumtho@nvidia.com,himadrics@protonmail.com,royfru44@gmail.com,bpf@vger.kernel.org,sched-ext@lists.linux.dev,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 17 Nov 2026 11:02:25 +0000 (UTC)

--===============1861414329617790077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Allow importing device-dax pages into an arena

TL;DR:
- Possible ABBA deadlock: get_online_mems() then mmap_read_lock() inverts the
  order nouveau/dmirror use, so a hang looks possible
- Minor: tagged user pointers are not untagged before vma_lookup()

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> +static int arena_import_dax(struct bpf_arena *arena, long uaddr, u32 page_cnt, u64 src)
> +{

[ ... ]

> +	/* A sleepable callback, like a bpf_wq one, may run without an address space */
> +	if (!mm || (src & ~PAGE_MASK))
> +		return -EINVAL;

[ ... ]

> +	/*
> +	 * A pin doesn't keep the memmap of device pages: an unbind can free it
> +	 * until a dev_pagemap reference is held, but only under mem_hotplug_lock,
> +	 * which nests outside of mmap_lock
> +	 */
> +	get_online_mems();
> +	mmap_read_lock(mm);

Is the lock order stated in this comment correct?  The tree also has paths
that take mem_hotplug_lock for write while holding a user mmap_read_lock:

  nouveau_svmm_bind()            mmap_read_lock(mm)
    nouveau_dmem_migrate_vma() -> nouveau_dmem_migrate_chunk() ->
    nouveau_dmem_migrate_copy_one() -> nouveau_dmem_page_alloc_locked() ->
    nouveau_dmem_chunk_alloc() -> memremap_pages() -> pagemap_range() ->
    mem_hotplug_begin() -> percpu_down_write(&mem_hotplug_lock)

  dmirror_migrate_to_device()    mmap_read_lock(mm)
    dmirror_migrate_alloc_and_copy() -> dmirror_devmem_alloc_page() ->
    dmirror_allocate_chunk() -> memremap_pages()

That is the opposite order from get_online_mems() followed by
mmap_read_lock(mm) here, so lockdep should report an ABBA cycle once both
chains are seen.

A hang with a single mm looks possible with three threads.  T1 holds
mmap_read_lock and waits in percpu_down_write() for T2.  T2, in this kfunc,
holds mem_hotplug_lock for read and calls mmap_read_lock(mm).  T3 waits in
mmap_write_lock() on T1's read hold, and once it sets the rwsem handoff flag
T2 can no longer take the read lock and queues behind T3.  No thread can
make progress.

The x86 ptdump debugfs path already uses the same order as this patch, so
the inversion is not new, but this kfunc makes it reachable from a much more
common path.

Could the dev_pagemap reference be taken without holding mem_hotplug_lock
across mmap_lock, for example by taking the dev_dax pgmap from the VMA's
file before pinning?

> +	vma = vma_lookup(mm, src);

A subsystem pattern flags this as potentially concerning: src is a
user-supplied u64 that goes to vma_lookup() and to the vma->vm_end - src
range check without untagged_addr(), and the only earlier test is
(src & ~PAGE_MASK).  A tagged pointer (arm64 TBI/MTE, x86 LAM) is above every
VMA, so vma_lookup() returns NULL and the import fails with -EINVAL, while
pin_user_pages() would have accepted the same address because
__get_user_pages() untags it.

This fails closed, so the checked VMA and the pinned range cannot diverge,
and addresses returned by mmap() of /dev/daxX.Y are untagged.  Should this
use untagged_addr(src) on a copy before vma_lookup() and the range check, or
should the kdoc say that @src must be untagged?

> +	if (!vma || !vma_is_devdax(vma) ||
> +	    ((unsigned long)page_cnt << PAGE_SHIFT) > vma->vm_end - src)
> +		goto out_unlock;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44067070819
--===============1861414329617790077==--
