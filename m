Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDAB32B10F;
	Sat,  5 Sep 2026 03:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788577217; cv=none; b=YrWiaRx4FsJS/VPQn4c87XaiwgOH5XEqRfcJ7HE5zIOkMf1tATXXFBeO42kz/3jtXKuwbYQqeDBT8ppAxbRPwVfZY2gxeN20b7L+fqBSCGI1jAbNy/c1TxMmb2J8EHzQbjGwoKrODZ5UY0B0VE9bZhRinPb3XDfHZ5kQSTnAZKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788577217; c=relaxed/simple;
	bh=U5G8wqhdv6wNsgRU+y43xN9wON7WhKariG72lGJJ1V4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WRnM0/brTxRo4J47oio0TzgiS7KTxQSGvYR/7he36qg5oupp9FeaUZnJzRUazDAFWL71sqnUlSIEC12KrWLgwbpMszg+FKcF2qCa11Et0riv+gK+8hR3cUASsMY+D0Jr/CC8Bs6S6mNn9qlWEzYclQIxJH2tMvl2E2q+O2tlg18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3235vnO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3235vnO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684D61F00A3D;
	Sat,  5 Sep 2026 03:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788577215;
	bh=VIOhOu/LgEMPFfoPkmWi2vYvFUhC/tav40+uRkNrpMM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=n3235vnOhpnpmKCYNFh5rgg7TCC0HJO+Snz1jUqfnEKpIq7aPsg9S7LZBSqcy+Trm
	 LG0khlIdXboBJn7CCRxM9M+zNGnVapadLzOht+KIRbhVJgt4ASmoABSqMa2nSow6Mh
	 YeEAmuz74Fr28lrVTEDmNLDQgovD0PMgGbzumGm2p1H6EZGhNTgOnSLUm23WNJaGkl
	 z/VLYY8ZwXbTflLeU88kLuEBq82mzUVo8zFo7GtU1CRgtQO5zCkpqWzdmtOmoZhJPF
	 t4cskTUrhZAsej2I7V7h8tn2dP53a8pe3UKYhBw3nkbaYIPmTqiu/GJDp29bkZMtPj
	 2GWOhqgdA1NFA==
Content-Type: multipart/mixed; boundary="===============0188849458020851844=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6fb6eba20f7975410960a3603614f1873fe7212e4d4f77408dcc33726dc31fde@mail.kernel.org>
In-Reply-To: <20260905021139.4116529-1-pulehui@huaweicloud.com>
References: <20260905021139.4116529-1-pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf v4] bpf: Fix UAF due to concurrent consumption of ttrace lists in alloc_bulk
From: bot+bpf-ci@kernel.org
To: pulehui@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,houtao@huaweicloud.com,leon.hwang@linux.dev
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,yonghong.song@linux.dev,song@kernel.org,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,pulehui@huawei.com,pulehui@huaweicloud.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 03:00:14 +0000 (UTC)

--===============0188849458020851844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Syzkaller repeatedly triggered UAF splats related to nodes in
> waiting_for_gp_ttrace within the bpf memalloc:
> BUG: KASAN: slab-use-after-free in llist_del_first+0x85/0x110 lib/llist.c:61
> Read of size 8 at addr ffff8881572cd080 by task syz.4.470/5112
>  ...
>  llist_del_first+0x85/0x110 lib/llist.c:61
>  alloc_bulk+0x193/0x460 kernel/bpf/memalloc.c:229
>  bpf_mem_refill+0x386/0x560 kernel/bpf/memalloc.c:436
> Freed by task 14:
>  ...
>  __free_rcu kernel/bpf/memalloc.c:281 [inline]
>  __free_rcu_tasks_trace+0x48/0xd0 kernel/bpf/memalloc.c:291
>  rcu_tasks_invoke_cbs+0x1ec/0x3e0 kernel/rcu/tasks.h:571
>  rcu_tasks_one_gp+0x13d/0x220 kernel/rcu/tasks.h:621
>  rcu_tasks_kthread+0xf3/0x120 kernel/rcu/tasks.h:651

The file and line numbers in this stack trace refer to v6.6 (the v1
posting included 'Not tainted 6.6.0+', which was dropped in later
versions). Against the current tree, these line numbers point to different
locations: alloc_bulk() line 229 is in a blank/'if (i >= cnt)' section
(the waiting_for_gp_ttrace access is now at line 231), bpf_mem_refill()
line 436 is the closing brace, and __free_rcu_tasks_trace() no longer
exists at all (removed by commit 57b23c0f612d).

Should the stack trace include the kernel version to prevent future
readers from trying to map these line numbers onto the current tree?

> In addition, there is also a theoretical race condition on the
> free_by_rcu_ttrace list. This race requires two preconditions: an
> in-flight Tasks Trace GP keeping c->call_rcu_ttrace_in_progress == 1,
> and concurrent cross-CPU frees repopulating c->free_by_rcu_ttrace with
> new nodes. Under these conditions, the following scenario triggers UAF:
> // CPU0
> // irq work is still busy (on PREEMPT_RT)
> alloc_bulk()
>   llist_del_first(&c->free_by_rcu_ttrace)
>     entry = smp_load_acquire(&head->first);
>     do {
>       if (entry == NULL)
>         return NULL;
>         // CPU1
>         bpf_mem_alloc_destroy()
>           WRITE_ONCE(c->draining, true)
>           // wait for CPU0
>           irq_work_sync()
>                 // CPU2
>                 do_call_rcu_ttrace(tgt(CPU0))
>                   if (c->draining) {
>                     llist_del_all(&c->free_by_rcu_ttrace)
>                     free_all()
>                   }
> // CPU0 continue
>       next = READ_ONCE(entry->next); <-- trigger UAF

The annotation suggests this race window exists only on PREEMPT_RT
kernels. However, on non-PREEMPT_RT configurations, alloc_bulk() runs in
hard IRQ context and irq_work_sync() from another CPU still has to wait
for it, so the same race window exists there too. The earlier comment that
commit d114dde245f9 removed also mentioned non-RT cases: 'arch_irq_work_
has_interrupt() being false and irq work is invoked in timer interrupt.'

Would '(e.g., on PREEMPT_RT)' be more accurate than '(on PREEMPT_RT)' to
indicate this is an example rather than a precondition?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33938697434
--===============0188849458020851844==--
