Return-Path: <SRS0=zUS/=4M=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A762C11D35
	for <bpf@archiver.kernel.org>; Mon, 24 Feb 2020 15:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EAB52072D
	for <bpf@archiver.kernel.org>; Mon, 24 Feb 2020 15:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgBXPDX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:03:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50210 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgBXPDX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Feb 2020 10:03:23 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6FFp-0004sE-F5; Mon, 24 Feb 2020 16:02:41 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 2F32710408E;
        Mon, 24 Feb 2020 16:02:41 +0100 (CET)
Message-Id: <20200224145642.847220186@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 24 Feb 2020 15:01:35 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     David Miller <davem@davemloft.net>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Clark Williams <williams@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [patch V3 04/22] bpf/tracing: Remove redundant preempt_disable() in __bpf_trace_run()
References: <20200224140131.461979697@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

__bpf_trace_run() disables preemption around the BPF_PROG_RUN() invocation.

This is redundant because __bpf_trace_run() is invoked from a trace point
via __DO_TRACE() which already disables preemption _before_ invoking any of
the functions which are attached to a trace point.

Remove it and add a cant_sleep() check.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Add a cant_sleep() check. 
---
 kernel/trace/bpf_trace.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1516,10 +1516,9 @@ void bpf_put_raw_tracepoint(struct bpf_r
 static __always_inline
 void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
 {
+	cant_sleep();
 	rcu_read_lock();
-	preempt_disable();
 	(void) BPF_PROG_RUN(prog, args);
-	preempt_enable();
 	rcu_read_unlock();
 }
 

