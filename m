Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790C117D2;
	Tue, 27 Jan 2026 23:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769555886; cv=none; b=klRKJx3GlWhHe9Zckjd1y1nQfMEyNc8n/JuqIYxSaYpHyLzUhN3wE2iekz7RvbMRVo1FxjNQtBtcWT3ytjQsKh4/QgFDgcidlz6OxmFTuwpefJ1XQWzgPBc6a4lBR/SzCG+HcssGngzZ0zfI+p786Es/69+UT3EkIxyZ8Anto7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769555886; c=relaxed/simple;
	bh=zjVCWuc/S3XDADseGmAj8VaGkFgLYQAZ1KQFmlE3Ank=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZW6L+PPcTZgueQTYzN2bJbUvUGSeva4RAIUrThPlDvBiVS8jgoGH8audI871u6TqVj3SoghOhFGjFzb2PDaFJevgv1pvL0EnMLLFpYIiN1Dg8/94UTu31ha+dvTx6Lo/DDb6Sq+1CogbuX2rLVwT2y1ase3uVvNjYinTejRpp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KozR4NIh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KozR4NIh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C835C116C6;
	Tue, 27 Jan 2026 23:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769555886;
	bh=zjVCWuc/S3XDADseGmAj8VaGkFgLYQAZ1KQFmlE3Ank=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=KozR4NIh54cnwMbw+ybZ7s5pabs8QEqp4DTit/fXTHu5r3NoLByrUx5FfsrUCypgi
	 pcwaNXnX+XAOyG57ezJHsAdrse2a4RjPzADGiGjb0ZkU9gwYRnsjpH4ztfhVbgUqHA
	 +7hB1UQ7plAeR+kJddAunJmWbCFMmN3j5IlPlBELSRx7/AgmGHAi8NC8vq9hwGukOd
	 k11eQbxa25p4dukjQHiHcSSfWQJTYyIxiDYza/t2wtVOuleFV0COXpqppVMtMQhEgn
	 1w1kso1BeBUYcJ8M+PoV8jg61rRqd/m7Zo8WK95SWFGZ16wLjaIYv5dCr3cWdJ4ZqV
	 yklKqM2Jm3P8Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7B0DCCE3900; Tue, 27 Jan 2026 15:18:05 -0800 (PST)
Date: Tue, 27 Jan 2026 15:18:05 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v6 0/3] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <581f0711-9115-44e8-a616-06cd13563f8c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260126231145.728172709@kernel.org>
 <20260126213922.0a91bfac@robin>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126213922.0a91bfac@robin>

On Mon, Jan 26, 2026 at 09:39:22PM -0500, Steven Rostedt wrote:
> On Mon, 26 Jan 2026 18:11:45 -0500
> Steven Rostedt <rostedt@kernel.org> wrote:
> 
> > The current use of guard(preempt_notrace)() within __DECLARE_TRACE()
> > to protect invocation of __DO_TRACE_CALL() means that BPF programs
> > attached to tracepoints are non-preemptible.  This is unhelpful in
> > real-time systems, whose users apparently wish to use BPF while also
> > achieving low latencies.
> > 
> > Change the protection of tracepoints to use fast_srcu() instead.
> > This will allow the callbacks to be able to be preempted. This also
> > means that the callbacks themselves need to be able to handle this
> > new found preemption ability.
> > 
> > For perf, add a guard(preempt) inside its handler too keep the old behavior
> > of perf events being called with preemption disabled.
> > 
> > For BPF, add a migrate_disable() to its handler. Actually, just replace
> > the rcu_read_lock() with rcu_read_lock_dont_migrate() and make it
> > cover more of the BPF callback handler.
> 
> My tests just triggered this, so I'm removing them from my queue for now.

Huh.  "Works for me."

Ah, I get it.  I think.  NMIs, right?

In your source tree, line 792 of kernel/rcu/srcutree.c is this line of
code, correct?

	WARN_ON_ONCE((read_flavor != SRCU_READ_FLAVOR_NMI) && in_nmi());

If so, could you please try this test with the patch shown at the end
of this email?

> -- Steve
> 
> 
> [  204.194772] ------------[ cut here ]------------
> [  204.194789] WARNING: kernel/rcu/srcutree.c:792 at __srcu_check_read_flavor+0x5c/0xb0, CPU#1: swapper/1/0
> [  204.194800] Modules linked in:
> [  204.194817] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.19.0-rc7-test-00018-g2c774d6ad074-dirty #32 PREEMPT(voluntary) 
> [  204.194821] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> [  204.194824] RIP: 0010:__srcu_check_read_flavor+0x5c/0xb0
> [  204.194829] Code: 84 c9 74 19 39 f1 74 45 0f 0b 85 c0 74 2e 39 c1 74 45 0f 0b 39 f0 75 3f c3 cc cc cc cc 85 c0 74 16 83 fe 04 75 ee 0f 0b eb ea <0f> 0b 8d 46 ff 85 f0 74 ba 0f 0b eb b6 83
>  fe 04 74 3a 31 c0 f0 0f
> [  204.194832] RSP: 0018:fffffe4c48325b50 EFLAGS: 00010002
> [  204.194835] RAX: 0000000000000001 RBX: ffffffff8791e5a0 RCX: 0000000000000000
> [  204.194836] RDX: 00000000ffffffff RSI: 0000000000000004 RDI: ffffffff879f1180
> [  204.194838] RBP: ffff8e6453fd2000 R08: 0000000000000001 R09: 0000000000000000
> [  204.194839] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
> [  204.194840] R13: fffffe4c48325ef8 R14: ffffffff85eeae93 R15: ffff8e6453906900
> [  204.194842] FS:  0000000000000000(0000) GS:ffff8e6533593000(0000) knlGS:0000000000000000
> [  204.194844] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  204.194845] CR2: 000055d1e7cf8cc0 CR3: 000000010b0cc004 CR4: 0000000000172ef0
> [  204.194850] Call Trace:
> [  204.194866]  <NMI>
> [  204.194868]  lock_release+0x215/0x320
> [  204.194886]  ? arch_perf_update_userpage+0x6c/0xf0
> [  204.195214]  perf_event_update_userpage+0x158/0x2e0
> [  204.195538]  x86_perf_event_set_period+0xc1/0x180
> [  204.195811]  handle_pmi_common+0x1ac/0x450
> [  204.198605]  ? __get_next_timer_interrupt+0x185/0x370
> [  204.198914]  intel_pmu_handle_irq+0x10e/0x510
> [  204.199032]  ? nmi_handle.part.0+0x30/0x270
> [  204.199197]  ? __get_next_timer_interrupt+0x185/0x370
> [  204.199404]  perf_event_nmi_handler+0x34/0x60
> [  204.199523]  nmi_handle.part.0+0xc9/0x270

------------------------------------------------------------------------

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index c469c708fdd6a..66ba6a2f83d3a 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -789,7 +789,8 @@ void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
 	struct srcu_data *sdp;
 
 	/* NMI-unsafe use in NMI is a bad sign, as is multi-bit read_flavor values. */
-	WARN_ON_ONCE((read_flavor != SRCU_READ_FLAVOR_NMI) && in_nmi());
+	WARN_ON_ONCE(read_flavor != SRCU_READ_FLAVOR_NMI &&
+		     read_flavor != SRCU_READ_FLAVOR_FAST && in_nmi());
 	WARN_ON_ONCE(read_flavor & (read_flavor - 1));
 
 	sdp = raw_cpu_ptr(ssp->sda);
