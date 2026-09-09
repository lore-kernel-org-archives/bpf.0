Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE9D367F25
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788977584; cv=none; b=hXecbXMDKv3fzJx9TkXa46x2qAGSUnLLV0KCAFYuzYc2iiGPGyG4i7S/LIU67NcZt1v/XRjrpxcgiSbQgPN3amtHsZWPHj3Q2BAvHsrPXMgo4K4YQ/Wc9JHd6sUKAG7q+yGYOGgKoYnS55DrURWe7tVWhmrVupQlFVDnrtKGP4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788977584; c=relaxed/simple;
	bh=4CKO9hNlHuv5iZ/0oVc8Vi3340GmpRnhBvy1964bOwI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UR23m4E7AQvwfZ7z5pTw+p3sHHHm2DFXUEm2kjV6scr6vuWfX2OWCY3sy24zCsP6+SIoLirK18YeTdEHroE2T9QzbtvjL6aLhqrF+azM29ndWJcMPf7AkQodE4BT/3vI0hWOAntEdmq2zSk1kCGZhjzXjez/IpfihfZlvZb/Cfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8JhgGGK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8JhgGGK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A711F000FF;
	Wed,  9 Sep 2026 18:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788977583;
	bh=GnLtL0sujNPeulHdtPxkFtFk05F2qKY7r3wX1IY8FbM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c8JhgGGK/pJ9evb98ZJFVKYaWXvnsA2CtzwG3+M+nNMa/gaM27SpHGcQZzjK7zr17
	 DzcHFC7IflhxYPMMkDEsMPjWcgGWQBCjmGSMo4rYAejHPNNwRJeHf9VdSsOyEQ8a0b
	 /vUD3xGHmJl9H3ouz6eRbT7ifcGKYxTQYpCxAe114f1D1pfrVK2FBNLIj1pn3GrSfs
	 KOu4DOdRA0Xbs0rNKpmR/4snod1pwKQNY/3/Ulj15OoAU5by4YxoMnfRbme4e2Jh3H
	 6Mic+5a4Qbjo4RJCK1vwQxttHTBQT9pNGDtdnATZ2hV32OWbuf5YAmh/IWt9cm6z0a
	 UPJLxgPQdZ8kQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] writeback: report a Tasks-RCU quiescent state per cgwb
 drain pass
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260909-cgwb-tasks-rcu-qs-v1-1-967a7754771f@toxicpanda.com>
References: <20260909-cgwb-tasks-rcu-qs-v1-1-967a7754771f@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 18:13:02 +0000
Message-Id: <20260909181302.C6A711F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbounded iteration under a spinlock in a list filtering loop.
- [High] O(N^2) list traversal and spinlock acquisitions when draining cgwb=
s.
- [High] Unbounded queueing of work items ignoring WB_FRN_MAX_IN_FLIGHT lim=
it.
--

commit 6a4c1184ed4e555add5aa8d7af747c8f54a2713f
Author: Josef Bacik <josef@toxicpanda.com>

writeback: report a Tasks-RCU quiescent state per cgwb drain pass

This commit addresses an issue where draining a dying cgwb with many attach=
ed
inodes can run for minutes without reporting a Tasks-RCU quiescent state,
causing RCU stalls and watchdog panics. It fixes this by replacing a plain
cond_resched() with cond_resched_tasks_rcu_qs() in a loop as long as
cleanup_offline_cgwb() returns true.

Link: https://lore.kernel.org/bpf/9d444098-7c03-4163-af12-bd0a79a51443@paul=
mck-laptop/

> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index cecbcf9060a65..18e999053bae0 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -910,8 +910,9 @@ static void cleanup_offline_cgwbs_workfn(struct work_=
struct *work)
>  			continue;

[Severity: High]
This isn't a bug introduced by this patch, but doesn't this continue bypass
the lock-drop at the bottom of the loop?

If a user creates and destroys many cgroups, the offline_cgwbs list can grow
arbitrarily. Iterating over all of them under spin_lock_irq(&cgwb_lock) and
hitting this continue creates an unbounded IRQ-disabled critical section,
which could cause latency spikes and trigger the hard lockup watchdog.

> =20
>  		spin_unlock_irq(&cgwb_lock);
> -		while (cleanup_offline_cgwb(wb))
> -			cond_resched();
> +		do {
> +			cond_resched_tasks_rcu_qs();
> +		} while (cleanup_offline_cgwb(wb));

[Severity: High]
This is a pre-existing issue, but does cleanup_offline_cgwb() suffer from an
algorithmic regression that causes the CPU livelocks this patch observes?

When cleanup_offline_cgwb() calls isw_prepare_wbs_switch():

fs/fs-writeback.c:isw_prepare_wbs_switch() {
	...
	list_for_each_entry(inode, list, i_io_list) {
		if (!inode_prepare_wbs_switch(inode, new_wb))
			continue;
	...
}

It processes inodes, sets I_WB_SWITCH, and queues them, but they are not
removed from the list synchronously. They are removed by an async worker
after a slow synchronize_rcu(). Because this worker is slow and we
tightly loop here, the next iteration traverses the same list from the
head, encountering all previously processed inodes again.

For each one, inode_prepare_wbs_switch() does this:

fs/fs-writeback.c:inode_prepare_wbs_switch() {
	spin_lock(&inode->i_lock);
	if (!(inode->i_sb->s_flags & SB_ACTIVE) ||
	    inode_state_read(inode) & (I_WB_SWITCH | I_FREEING | I_WILL_FREE) ||
	    inode_to_wb(inode) =3D=3D new_wb) {
		spin_unlock(&inode->i_lock);
		goto out_unpin;
	}
	...
}

For N inodes, doesn't this result in an O(N^2) list traversal and O(N^2)
lock acquisitions, wasting CPU time during the drain?


[Severity: High]
This is also a pre-existing issue, but does this loop queue work items
without enforcing concurrency limits?

Inside cleanup_offline_cgwb():

fs/fs-writeback.c:cleanup_offline_cgwb() {
	...
	atomic_inc(&isw_nr_in_flight);
	...
	wb_queue_isw(new_wb, isw);
	...
}

This queues a new isw work item for every 125 inodes without checking if
isw_nr_in_flight exceeds WB_FRN_MAX_IN_FLIGHT (1024). For a large cgroup
with millions of inodes, doesn't this unconditionally queue thousands of
work items concurrently, bypassing the limit and potentially flooding the
workqueue?

>  		spin_lock_irq(&cgwb_lock);
> =20
>  		wb_put(wb);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-cgwb-tasks=
-rcu-qs-v1-1-967a7754771f@toxicpanda.com?part=3D1
