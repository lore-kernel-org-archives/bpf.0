Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ACB376BD9;
	Mon,  7 Sep 2026 02:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788749816; cv=none; b=EmE0Z8hfUBnieEDvlyeTnPqeBDBAP8MJkLJ9N+Lo9v8DTQUorfLXb38Hb6yHfQfs5LFYp2/TuK3jNvH53YBf0e/vXqv8Bg9CO2yjB7SpSwrQSV/TxpwXLO7j8m82VLaCV454xqniGFx4kaxXiH/hScKKOi3BteZY27eWN2UOdBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788749816; c=relaxed/simple;
	bh=6aDjopDtC9TELJP9Z/u/p2WjR0KPjRj6dj5gS1egddI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NmOlhgdA4J9PjvsJZ56SA9zEWeJLEtayb0M9CsomkC6/qEBQkCzY9AesXOmauq5qg3d3z0KzomJvON92Toeyl4IUhizVGhI/UgSZbLdKlfPbw8iCjGCV64JvcXXUhk6I7NZObgBwQaF/wUxJ+rfbxALDUIeKbc9nXOocoaJk+Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hdWWF0vgdzYQtk1;
	Mon,  7 Sep 2026 10:39:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2715640577;
	Mon,  7 Sep 2026 10:40:42 +0800 (CST)
Received: from [10.174.176.103] (unknown [10.174.176.103])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgDHrQgmJJ5q12MmBA--.51243S2;
	Mon, 07 Sep 2026 10:40:41 +0800 (CST)
Subject: Re: [PATCH bpf v4] bpf: Fix UAF due to concurrent consumption of
 ttrace lists in alloc_bulk
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Leon Hwang <leon.hwang@linux.dev>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Pu Lehui <pulehui@huawei.com>
References: <20260905021139.4116529-1-pulehui@huaweicloud.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <87f13600-6988-f407-ed3b-61b11424da52@huaweicloud.com>
Date: Mon, 7 Sep 2026 10:40:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260905021139.4116529-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgDHrQgmJJ5q12MmBA--.51243S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy8GryUZFyxAw1DXrWUArb_yoW5ArykpF
	Z5Zr98XF1kAw1aya40qr4xCrZ7ZrsrWw43GFZ7WFnakw13Kr1DKFWfKryYqr9Yyw4xua43
	tryq9r1rJw1UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 9/5/2026 10:11 AM, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
>
> Syzkaller repeatedly triggered UAF splats related to nodes in
> waiting_for_gp_ttrace within the bpf memalloc:
>
> BUG: KASAN: slab-use-after-free in llist_del_first+0x85/0x110 lib/llist.c:61
> Read of size 8 at addr ffff8881572cd080 by task syz.4.470/5112
>  ...
>  llist_del_first+0x85/0x110 lib/llist.c:61
>  alloc_bulk+0x193/0x460 kernel/bpf/memalloc.c:229
>  bpf_mem_refill+0x386/0x560 kernel/bpf/memalloc.c:436
>
> Freed by task 14:
>  ...
>  __free_rcu kernel/bpf/memalloc.c:281 [inline]
>  __free_rcu_tasks_trace+0x48/0xd0 kernel/bpf/memalloc.c:291
>  rcu_tasks_invoke_cbs+0x1ec/0x3e0 kernel/rcu/tasks.h:571
>  rcu_tasks_one_gp+0x13d/0x220 kernel/rcu/tasks.h:621
>  rcu_tasks_kthread+0xf3/0x120 kernel/rcu/tasks.h:651
>
> The reason is that the UAF occurs after the RCU Tasks Trace GP expires:
> when the __free_rcu() callback runs, there is no synchronization
> protecting llist_del_all() against concurrent alloc_bulk() operating on
> waiting_for_gp_ttrace, leading to the race condition below:
>
> CPU0                                           CPU1
>                                                __free_rcu (RCU Tasks Trace callback)
> alloc_bulk
>   llist_del_first(&c->waiting_for_gp_ttrace)
>     entry = smp_load_acquire(&head->first);
>     do {
>       if (entry == NULL)
>         return NULL;
>                                                free_all(llist_del_all(&c->waiting_for_gp_ttrace))
>                                                  llist_for_each_safe(pos, t, llnode)
>                                                    free_one(pos);
>       next = READ_ONCE(entry->next); <-- trigger UAF
>     } while (!try_cmpxchg(&head->first, &entry, next));
>
> In addition, there is also a theoretical race condition on the
> free_by_rcu_ttrace list. This race requires two preconditions: an
> in-flight Tasks Trace GP keeping c->call_rcu_ttrace_in_progress == 1,
> and concurrent cross-CPU frees repopulating c->free_by_rcu_ttrace with
> new nodes. Under these conditions, the following scenario triggers UAF:
>
> // CPU0
> // irq work is still busy (on PREEMPT_RT)
> alloc_bulk()
>   llist_del_first(&c->free_by_rcu_ttrace)
>     entry = smp_load_acquire(&head->first);
>     do {
>       if (entry == NULL)
>         return NULL;
>
>         // CPU1
>         bpf_mem_alloc_destroy()
>           WRITE_ONCE(c->draining, true)
>           // wait for CPU0
>           irq_work_sync()
>
>                 // CPU2
>                 do_call_rcu_ttrace(tgt(CPU0))
>                   if (c->draining) {
>                     llist_del_all(&c->free_by_rcu_ttrace)
>                     free_all()
>                   }
>
> // CPU0 continue
>       next = READ_ONCE(entry->next); <-- trigger UAF
>     while (!try_cmpxchg(&head->first, &entry, next));
>
> Fix this by introducing a raw spinlock to synchronize the concurrent
> consumption on waiting_for_gp_ttrace and free_by_rcu_ttrace.
>
> Fixes: 04fabf00b4d3 ("bpf: Allow reuse from waiting_for_gp_ttrace list.")
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Suggested-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Acked-by: Hou Tao <houtao1@huawei.com>

