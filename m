Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD753B892B;
	Thu, 30 Jul 2026 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785395995; cv=none; b=NrQ/IxKHSmesDXtB7lqMk4tpaK/gDNWw6PXNzOd2uCdgo5MJeRFfifZRoPDhvf13h9kU3uk5bJ21JB/c1qhegXjxFnI7ScUL46cclZ6jGwmex9aBpcxFNAF97K4gKQkq/AtjZuwivJt2Dslz9S3OWM0AA9aCtDCWkhvtQokaRUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785395995; c=relaxed/simple;
	bh=nntABl9HxcokGbiOZ0rzn48NCzRtA7Jgd6HvtE8ujrI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=u1jILyJQ2ls1mCJFrRkrBG8GuJnpPnHVmIURSHgC9JMyAtBz+wBlVdUwA3htJCyRObiWWg9wgOHN27b43fJr9mpmn4PZm947RCe3CS5f6TPprVrl2r177XBwwyJMA7/NPLaY5hWAOOcyT7Axg7EwkL2gotPMJaeCFDyzePNWbgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huME+nnJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huME+nnJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C201F000E9;
	Thu, 30 Jul 2026 07:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785395994;
	bh=mH6S13FRzwx8GnWA9qTW6NNxG7x2zZw72ygEiyYcWTw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=huME+nnJYWz+4ytDe2oXg8e48z3sWq03k2PnRVPPKHrVHSz2pIMOZnhLh4TRe0MRM
	 qn4uQS1PsbjUZNFd4TQJpqOqUh0YNa+2i0CkIKowbRWPp6BCcLf1a5Z4ceXu6qkzup
	 zEuwOlGuKHGk7brQWv5XdtIMqRq0X3Ca2jYw4STuaIw47K184vkfK8QP7pGX6z+YOw
	 R/t76q6Yf1B8i5SD1f0geiiqlL+5MePtR0N6HGB1yKNXmVvQ8+QBZFL6H28+0GvRmj
	 0/7AJy3hLvDBtKezcOdERNDJRXvT6whSJLfR1GqDG+XNruDRLCpjiZ3VXciDIIi/9Q
	 CInlMB0nm5PpA==
Content-Type: multipart/mixed; boundary="===============0897556388450427335=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fefb2d538392e771c5b8fe874c789272101b3bcd084909dde7a08ca6620dfa9a@mail.kernel.org>
In-Reply-To: <20260730054858.209807-2-sanghyun.park.cnu@gmail.com>
References: <20260730054858.209807-2-sanghyun.park.cnu@gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Fix mmap_lock leak in irq_work path
From: bot+bpf-ci@kernel.org
To: sanghyun.park.cnu@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com
Cc: sanghyun.park.cnu@gmail.com,sun.jian.kdev@gmail.com,puranjay@kernel.org,ihor.solodrai@linux.dev,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,syzbot+cdd6c0925e12b0af60cc@syzkaller.appspotmail.com,sashiko-bot@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 30 Jul 2026 07:19:52 +0000 (UTC)

--===============0897556388450427335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 1be4c688511464bfec8b05e78fe8b3867a39f159
> Author: Sanghyun Park <sanghyun.park.cnu@gmail.com>
>
>     bpf: Fix mmap_lock leak in irq_work path
>
>     stack_map_get_build_id_offset() introduced a per-CPU irq_work to defer
>     mmap_read_unlock() from NMI context, and bpf_find_vma() later reused the
>     same mmap_unlock_work. Both callers only check whether the work is busy
>     before taking mmap_lock, so a nested caller can reuse the slot before the
>     first caller queues it. Two read locks may then be acquired while only one
>     deferred unlock runs, leaking a read lock and blocking exit_mmap().
>
>     Reserve the per-CPU slot before mmap_read_trylock(). Use the same wrapper
>     in stackmap and bpf_find_vma() so both callers release the reservation on
>     trylock failure. Release it after the irq_work callback unlocks the mm.
>
>     Fixes: bae77c5eb5b2 ("bpf: enable stackmap with build_id in nmi context")

Is the Fixes tag accurate? The described leak requires an interruptible
non-NMI holder of the slot. At bae77c5eb5b2, the slot was taken only under
'if (in_nmi())' and the only user was stack_map_get_build_id_offset(), which
contains no callback and cannot re-enter itself. NMIs do not nest, so two
acquisitions of the slot before the first queue are impossible at that commit.

The window appears to be opened by eac9153f2b58 ('bpf/stackmap: Fix deadlock
with rq_lock in bpf_get_stack()'), which changed 'if (in_nmi())' to 'if
(irqs_disabled())', allowing an interruptible non-NMI holder of the slot.
Commit 7c7e3d31e785, which shares the slot with bpf_find_vma, widens it
further.

Should the Fixes tag reference eac9153f2b58 instead? This also affects which
stable kernels receive the backport.

>     Reported-by: syzbot+cdd6c0925e12b0af60cc@syzkaller.appspotmail.com
>     Closes: https://syzkaller.appspot.com/bug?extid=cdd6c0925e12b0af60cc

Can this syzbot report be verified? Searching the lore archive for the ID
'cdd6c0925e12b0af60cc' returns only this patch's own v1/v2 postings and their
replies. No mail from syzbot containing that ID exists in the archive.

Restricting searches to from:syzbot or from:syzkaller plus that ID returns
zero results. The archive does index syzbot mail generally, so a genuine
report would be expected to be present.

Searches for any syzbot report touching mmap_unlock_work,
do_mmap_read_unlock, stack_map_get_build_id_offset, or
mmap_read_unlock_non_owner also return nothing relevant.

The only verifiable reporter is the next Reported-by tag. Can the syzbot
Reported-by and Closes tags be substantiated, or should they be dropped?

[ ... ]

> diff --git a/kernel/bpf/mmap_unlock_work.h b/kernel/bpf/mmap_unlock_work.h
> index 5d18d7d85bef..d6e2b65f6d05 100644
> --- a/kernel/bpf/mmap_unlock_work.h
> +++ b/kernel/bpf/mmap_unlock_work.h

[ ... ]

> @@ -46,6 +48,33 @@ static inline bool bpf_mmap_unlock_get_irq_work(struct mmap_unlock_irq_work **wo
>  	return irq_work_busy;
>  }
>
> +static inline void
> +bpf_mmap_unlock_put_irq_work(struct mmap_unlock_irq_work *work)
> +{
> +	if (work)
> +		atomic_set_release(&work->active, 0);
> +}
> +
> +/*
> + * Try to take mm->mmap_lock for reading on behalf of a BPF helper that may
> + * run with IRQs disabled. On success, *work is the slot to hand to
> + * bpf_mmap_unlock_mm() (NULL when the unlock can be done inline); on failure
> + * no slot stays reserved and the caller must fall back.
> + */
> +static inline bool bpf_mmap_read_trylock(struct mm_struct *mm,
> +					 struct mmap_unlock_irq_work **work)
> +{
> +	if (bpf_mmap_unlock_get_irq_work(work))
> +		return false;
> +
> +	if (!mmap_read_trylock(mm)) {
> +		bpf_mmap_unlock_put_irq_work(*work);
> +		return false;
> +	}
> +
> +	return true;
> +}

The comment states "on failure no slot stays reserved", which is true after
bpf_mmap_unlock_put_irq_work() releases the reservation on the
mmap_read_trylock() failure path. However, *work is left non-NULL on that
path while unreserved, so a future caller following the comment's model ('*work
is the slot to hand to bpf_mmap_unlock_mm()') and passing work to
bpf_mmap_unlock_mm() would queue an unlock for a lock it does not hold.

Neither current caller does this (stackmap.c and task_iter.c both return or
goto out), but would it be safer if the code set *work = NULL on the
mmap_read_trylock() failure path, or if the comment stated that *work is
meaningful only on success?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30518165492
--===============0897556388450427335==--
