Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA7D4F5E0;
	Tue, 27 Jan 2026 02:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769481569; cv=none; b=o5QwcSyZ0TjnhGYhU1qc+aNL29WDl5ly+cAq/H/DuMQ+9J4dbpxCaiMbUkkec25/CGT7Md4pQWu+SYMb3PT4a48PwFhlROr0mFj024M7aPwdEj9ctlXH5MFkoHgKP66NFXA/DEOHGau+pV0m8zIfQcXO2fn6qeiklIOertvPzOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769481569; c=relaxed/simple;
	bh=7CfqkjoWSIlMwdQDSZr22ADv0dhvJYGVyt5CTXpPOvM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A87wts0dKQVlxTgbGB9CAvE0HC4qQz8PJCZItie7wTVBpJfvRSN7TqLCZWjq9ta3IEZW1VRmaVSDnrqFXKMMQQg/ow49ipZeBvnxBf0K90kdIHAtKDtmuj+4M8bC0hnz3V8/NvKGSFKZEcmWYG3hYuEBoqcApe4ai2j5oOF3X44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id D4D3D16074F;
	Tue, 27 Jan 2026 02:39:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id A24282F;
	Tue, 27 Jan 2026 02:39:23 +0000 (UTC)
Date: Mon, 26 Jan 2026 21:39:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v6 0/3] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <20260126213922.0a91bfac@robin>
In-Reply-To: <20260126231145.728172709@kernel.org>
References: <20260126231145.728172709@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 7b1m1rfaohq6xc4srpn69zd8hofd1gb8
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: A24282F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/fvltJp8bzf64BBXmkNAqXP1jQ3xEvOLs=
X-HE-Tag: 1769481563-654622
X-HE-Meta: U2FsdGVkX1/iO+LNUz/N44ce5O9o55BWn6+LPYVCJFRLrrBowhlrfKsat41CZwymfqvVX1rvcrJqNDoKn83MCOQeidwiBoU5diExKDl2Hda3sQbES2IC7wtcSi2b++ye390TGbVXtxEfIMfWgS5gyzWGFLVeS8gNlEu8bOqeqiB/DtxRbSr+pBzW9I1HJwUFauWoEnR7a8QX3vNYAYgeF0LG/Rq0j/YTxnuhzSFy9zbiNjh9pxnEu9tFjq0USaA1NEPpzhJmHi1KwsqFa6J5DVZgUTDfJxFZwpUTgat1v4O8PvKjSmsNjZ0ka9lgeuSj++g+VLUewD8BUgSLcgoroBrMUS0fjecG

On Mon, 26 Jan 2026 18:11:45 -0500
Steven Rostedt <rostedt@kernel.org> wrote:

> The current use of guard(preempt_notrace)() within __DECLARE_TRACE()
> to protect invocation of __DO_TRACE_CALL() means that BPF programs
> attached to tracepoints are non-preemptible.  This is unhelpful in
> real-time systems, whose users apparently wish to use BPF while also
> achieving low latencies.
> 
> Change the protection of tracepoints to use fast_srcu() instead.
> This will allow the callbacks to be able to be preempted. This also
> means that the callbacks themselves need to be able to handle this
> new found preemption ability.
> 
> For perf, add a guard(preempt) inside its handler too keep the old behavior
> of perf events being called with preemption disabled.
> 
> For BPF, add a migrate_disable() to its handler. Actually, just replace
> the rcu_read_lock() with rcu_read_lock_dont_migrate() and make it
> cover more of the BPF callback handler.

My tests just triggered this, so I'm removing them from my queue for now.

-- Steve


[  204.194772] ------------[ cut here ]------------
[  204.194789] WARNING: kernel/rcu/srcutree.c:792 at __srcu_check_read_flavor+0x5c/0xb0, CPU#1: swapper/1/0
[  204.194800] Modules linked in:
[  204.194817] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.19.0-rc7-test-00018-g2c774d6ad074-dirty #32 PREEMPT(voluntary) 
[  204.194821] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
[  204.194824] RIP: 0010:__srcu_check_read_flavor+0x5c/0xb0
[  204.194829] Code: 84 c9 74 19 39 f1 74 45 0f 0b 85 c0 74 2e 39 c1 74 45 0f 0b 39 f0 75 3f c3 cc cc cc cc 85 c0 74 16 83 fe 04 75 ee 0f 0b eb ea <0f> 0b 8d 46 ff 85 f0 74 ba 0f 0b eb b6 83
 fe 04 74 3a 31 c0 f0 0f
[  204.194832] RSP: 0018:fffffe4c48325b50 EFLAGS: 00010002
[  204.194835] RAX: 0000000000000001 RBX: ffffffff8791e5a0 RCX: 0000000000000000
[  204.194836] RDX: 00000000ffffffff RSI: 0000000000000004 RDI: ffffffff879f1180
[  204.194838] RBP: ffff8e6453fd2000 R08: 0000000000000001 R09: 0000000000000000
[  204.194839] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
[  204.194840] R13: fffffe4c48325ef8 R14: ffffffff85eeae93 R15: ffff8e6453906900
[  204.194842] FS:  0000000000000000(0000) GS:ffff8e6533593000(0000) knlGS:0000000000000000
[  204.194844] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  204.194845] CR2: 000055d1e7cf8cc0 CR3: 000000010b0cc004 CR4: 0000000000172ef0
[  204.194850] Call Trace:
[  204.194866]  <NMI>
[  204.194868]  lock_release+0x215/0x320
[  204.194886]  ? arch_perf_update_userpage+0x6c/0xf0
[  204.195214]  perf_event_update_userpage+0x158/0x2e0
[  204.195538]  x86_perf_event_set_period+0xc1/0x180
[  204.195811]  handle_pmi_common+0x1ac/0x450
[  204.198605]  ? __get_next_timer_interrupt+0x185/0x370
[  204.198914]  intel_pmu_handle_irq+0x10e/0x510
[  204.199032]  ? nmi_handle.part.0+0x30/0x270
[  204.199197]  ? __get_next_timer_interrupt+0x185/0x370
[  204.199404]  perf_event_nmi_handler+0x34/0x60
[  204.199523]  nmi_handle.part.0+0xc9/0x270
