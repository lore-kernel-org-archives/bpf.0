Received: from out-166.mta1.migadu.com (out-166.mta1.migadu.com [95.215.58.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6833C10B9
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 02:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896842; cv=none; b=EmmxHRvZlBu1mdgPsSz+vHK+IxL2jYSFag18p2y6RlnE2YZ0Ve8VjnC3nEhsy2mVsxCuD59HE+yomFbBgyLMLk2gEuZk9oWhbQihAdVQRRsuNcNnd3JFHQGiJbq8GaYiRl1cNmWGij/tNuAh6DVHqBlbA7KhXm4nhWBSvVT1J4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896842; c=relaxed/simple;
	bh=uo4jE7jjJ6KUdc8w9tPdlbGHosV8raeOQDY1uhbLILQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D5GMsKcZbyrG9xzGB+RjGVoRdtyfCqVspLIq/btDZI0czRZgRgjoDQ7YyLUs9PnJBH10nbSr5rBGHq46AccQggl+Mx5c958Wq8RuYChAcmJuNDV4Xh6aCwq7aa/krRow3kuG6XgzSFxfJzRNyFN3951fE/dRA+GQZHH7/RrlMRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LuXYEGv0; arc=none smtp.client-ip=95.215.58.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LuXYEGv0"
Message-ID: <8c5f0b71-cf81-43f9-b437-e16132d0f02a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785896838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iQ2dtYKtv5P4Mz2awqe1Ey7y6uXb3O4MS8BAHmRjtTs=;
	b=LuXYEGv0XLQliolW/z0KzBraEu0P6Ad6zupWa4WLrmFE/fH6x94FDu91sLzOYhlOp+FqN3
	NrQ2/ogvcbiVkkdGR1hRjEeDGKngJ9w593wdmJEWmADa2oHlsthI4OdUTHhU69hoxr46+8
	jf/DTzlhC3VpyXCA3ZrPyeOxNu9U558=
Date: Wed, 5 Aug 2026 10:26:33 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [BUG?] bpf/tcx: bpf_clone_redirect() can sustain self-cloning
 transmit loops
To: Junseo Lim <zirajs7@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Martin KaFai Lau
 <martin.lau@linux.dev>, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Sechang Lim <rhkrqnwk98@gmail.com>
References: <20260804145747.354896-1-zirajs7@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260804145747.354896-1-zirajs7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 8/4/26 10:57 PM, Junseo Lim wrote:
> Hi,
>
> We found that a TCX sched_cls BPF program using bpf_clone_redirect() can
> repeatedly re-enter a virtual-device transmit path and trigger RCU stall
> reports under sustained traffic.
>
> bpf_clone_redirect() clones and redirects the skb from inside the helper,
> before the current BPF program invocation returns. If the cloned skb
> reaches a TCX hook that runs the same or another bpf_clone_redirect()
> program, the datapath can re-enter itself repeatedly.
>
> The BPF program can still return TCX_PASS. The recursion is caused by the
> helper's immediate transmit side effect, not a TCX_REDIRECT return action.
>
> We have separate reduced cases with ingress-only and ingress+egress TCX
> attachments, but the common part is the helper-driven loopback transmit.
>
> ---
> bpf_clone_redirect(skb, lo_ifindex, 0);
> return TCX_PASS;
> ---
>
> With flags == 0, bpf_clone_redirect() redirects the cloned skb to the
> egress transmit path:
>
> ---
> bpf_clone_redirect()
>    skb_clone()
>    bpf_try_make_head_writable(original skb)
>    __bpf_redirect(clone, lo, 0)
>      __bpf_tx_skb()
>        dev_queue_xmit(clone)
>          __dev_queue_xmit()
>            rcu_read_lock_bh()
>            sch_handle_egress()
>              tcx_run()
>                BPF program on lo
>                  bpf_clone_redirect(...)
>            rcu_read_unlock_bh()
> ---
>
> The included C reproducer is a standalone stress case for the same
> loopback TCX/BPF shape. The exact reduced syzkaller cases use different
> TCX attachment combinations; those can be provided separately if useful.
>
> After sustained traffic, the system reported RCU stalls:
>
> ---
> [  110.598444] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [  110.598935] rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-0): P68/1:b..l
> [  110.599529] rcu: 	(detected by 0, t=6502 jiffies, g=32705, q=438535 ncpus=1)
> [  110.599977] task:kmemleak        state:R  running task     stack:0     pid:68    tgid:68    ppid:2      task_flags:0x208040 flags:0x00080000
> [  110.600914] Call Trace:
> [  110.601087]  <TASK>
> [  110.601239]  __schedule+0xe19/0x3940
> [  110.603902]  preempt_schedule_common+0x44/0xd0
> [  110.604530]  preempt_schedule_thunk+0x16/0x40
> [  110.604820]  _raw_spin_unlock_irq+0x44/0x50
> [  110.605096]  kmemleak_scan+0x141/0x1070
> [  110.605684]  kmemleak_scan_thread+0x6e/0xb9
> [  110.606063]  kthread+0x384/0x4a0
> [  110.606776]  ret_from_fork+0x3e0/0x870
> [  110.608342]  ret_from_fork_asm+0x1a/0x30
> [  110.608702]  </TASK>
> [  110.609109] rcu: rcu_preempt kthread starved for 1984 jiffies! g32705 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
> [  110.609980] rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> [  110.610545] rcu: RCU grace-period kthread stack dump:
> [  110.610864] task:rcu_preempt     state:R  running task     stack:0     pid:15    tgid:15    ppid:2      task_flags:0x208040 flags:0x00080000
> [  110.612020] Call Trace:
> [  110.612195]  <TASK>
> [  110.612405]  __schedule+0xe19/0x3940
> ...
> [  110.626961]  </TASK>
> [  110.627112] rcu: Stack dump where RCU GP kthread last ran:
> ...
> [  110.634555]  <IRQ>
> [  110.635866]  bpf_has_frame_pointer+0x42/0x290
> [  110.637076]  unwind_next_frame+0x2a0/0x1ed0
> [  110.642242]  arch_stack_walk+0xba/0x120
> [  110.643071]  stack_trace_save+0x8e/0xc0
> [  110.645003]  kasan_save_stack+0x2f/0x50
> [  110.656111]  kasan_record_aux_stack+0x9b/0xd0
> [  110.656714]  __call_rcu_common.constprop.0+0xb7/0xe80
> [  110.658475]  kmem_cache_free+0x3b4/0x6a0
> [  110.658735]  kfree_skbmem+0x182/0x210
> [  110.659290]  sk_skb_reason_drop+0x15f/0x570
> [  110.660129]  packet_rcv+0x174/0x1640
> [  110.660673]  dev_queue_xmit_nit+0x673/0x9c0
> [  110.660956]  dev_hard_start_xmit+0x9f/0x790
> [  110.661854]  __dev_queue_xmit+0x140e/0x3d70
> [  110.666568]  __bpf_redirect+0x880/0xde0
> [  110.667420]  bpf_clone_redirect+0x350/0x5c0
> [  110.668011]  bpf_prog_05a7bf74a04af34c+0x27/0x30
> [  110.668325]  __dev_queue_xmit+0x2bb2/0x3d70
> [  110.673046]  __bpf_redirect+0x880/0xde0
> [  110.674202]  bpf_clone_redirect+0x350/0x5c0
> ...(repeated bpf_clone_redirect)
> [  110.704300]  bpf_prog_05a7bf74a04af34c+0x27/0x30
> [  110.704611]  __dev_queue_xmit+0x2bb2/0x3d70
> [  110.710549]  __bpf_redirect+0x880/0xde0
> [  110.711839]  bpf_clone_redirect+0x350/0x5c0
> [  110.713199]  bpf_prog_05a7bf74a04af34c+0x27/0x30
> [  110.713638]  __netif_receive_skb_core.constprop.0+0x26d3/0x3440
> [  110.718047]  __netif_receive_skb_one_core+0xca/0x260
> [  110.719889]  __netif_receive_skb+0x54/0x1a0
> [  110.720750]  process_backlog+0x34f/0x1380
> [  110.721306]  __napi_poll+0xba/0x620
> [  110.722173]  net_rx_action+0x550/0xe70
> [  110.723891]  handle_softirqs+0x1dc/0x940
> [  110.725670]  do_softirq+0xac/0xe0
> [  110.725899]  </IRQ>
> ---



I think what you have here is just a CPU DoS, where one packet gets 
amplified into several.

You also have kmemleak, KASAN and friends enabled, which makes the CPU 
and memory pressure much worse.

I don't see any more catastrophic consequence than that.

Think about it, a single looping packet can cause a network storm and 
pin a machine at 100% CPU too, but that's simply unavoidable.


Since we have already printed such message and machine can be 
recoverable, I think it is benign.

    bpf: recursion limit reached on datapath, buggy bpf program?
    Dead loop on virtual device lo (net 7), fix it urgently!


