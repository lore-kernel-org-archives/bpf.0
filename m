Return-Path: <SRS0=tRXP=4I=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638B1C11D26
	for <bpf@archiver.kernel.org>; Thu, 20 Feb 2020 20:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3836C20679
	for <bpf@archiver.kernel.org>; Thu, 20 Feb 2020 20:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgBTU6W (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:58:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44156 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729177AbgBTU4i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Feb 2020 15:56:38 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j4srb-0007TC-JT; Thu, 20 Feb 2020 21:56:03 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 189E710408A;
        Thu, 20 Feb 2020 21:56:03 +0100 (CET)
Message-Id: <20200220204617.828122368@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 20 Feb 2020 21:45:22 +0100
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
Subject: [patch V2 05/20] bpf: Remove recursion prevention from rcu free callback
References: <20200220204517.863202864@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If an element is freed via RCU then recursion into BPF instrumentation
functions is not a concern. The element is already detached from the map
and the RCU callback does not hold any locks on which a kprobe, perf event
or tracepoint attached BPF program could deadlock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 kernel/bpf/hashtab.c |    8 --------
 1 file changed, 8 deletions(-)

--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -694,15 +694,7 @@ static void htab_elem_free_rcu(struct rc
 	struct htab_elem *l = container_of(head, struct htab_elem, rcu);
 	struct bpf_htab *htab = l->htab;
 
-	/* must increment bpf_prog_active to avoid kprobe+bpf triggering while
-	 * we're calling kfree, otherwise deadlock is possible if kprobes
-	 * are placed somewhere inside of slub
-	 */
-	preempt_disable();
-	__this_cpu_inc(bpf_prog_active);
 	htab_elem_free(htab, l);
-	__this_cpu_dec(bpf_prog_active);
-	preempt_enable();
 }
 
 static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)

