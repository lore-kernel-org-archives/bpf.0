Return-Path: <SRS0=zUS/=4M=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41E4C11D2F
	for <bpf@archiver.kernel.org>; Mon, 24 Feb 2020 15:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC64820838
	for <bpf@archiver.kernel.org>; Mon, 24 Feb 2020 15:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgBXPDU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:03:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50179 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbgBXPDT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Feb 2020 10:03:19 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6FFt-0004sL-63; Mon, 24 Feb 2020 16:02:45 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id D0BC510408E;
        Mon, 24 Feb 2020 16:02:41 +0100 (CET)
Message-Id: <20200224145643.151953573@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 24 Feb 2020 15:01:38 +0100
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
Subject: [patch V3 07/22] perf/bpf: Remove preempt disable around BPF invocation
References: <20200224140131.461979697@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The BPF invocation from the perf event overflow handler does not require to
disable preemption because this is called from NMI or at least hard
interrupt context which is already non-preemptible.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/events/core.c |    2 --
 1 file changed, 2 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9206,7 +9206,6 @@ static void bpf_overflow_handler(struct
 	int ret = 0;
 
 	ctx.regs = perf_arch_bpf_user_pt_regs(regs);
-	preempt_disable();
 	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1))
 		goto out;
 	rcu_read_lock();
@@ -9214,7 +9213,6 @@ static void bpf_overflow_handler(struct
 	rcu_read_unlock();
 out:
 	__this_cpu_dec(bpf_prog_active);
-	preempt_enable();
 	if (!ret)
 		return;
 

