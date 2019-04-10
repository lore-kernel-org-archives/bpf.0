Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9853C10F14
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 11:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C141D20820
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 11:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfDJLnl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:43:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731312AbfDJLnl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 07:43:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F1D06301988C;
        Wed, 10 Apr 2019 11:43:40 +0000 (UTC)
Received: from firesoul.localdomain (ovpn-200-48.brq.redhat.com [10.40.200.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A836E61994;
        Wed, 10 Apr 2019 11:43:38 +0000 (UTC)
Received: from [10.10.10.1] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id CE17431256FC5;
        Wed, 10 Apr 2019 13:43:37 +0200 (CEST)
Subject: [PATCH bpf-next 1/5] bpf: cpumap use ptr_ring_consume_batched
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     netdev@vger.kernel.org, Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        bpf@vger.kernel.org,
        Toke =?utf-8?q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Date:   Wed, 10 Apr 2019 13:43:37 +0200
Message-ID: <155489661778.20826.7424374812567038804.stgit@firesoul>
In-Reply-To: <155489659290.20826.1108770347511292618.stgit@firesoul>
References: <155489659290.20826.1108770347511292618.stgit@firesoul>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 10 Apr 2019 11:43:41 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move ptr_ring dequeue outside loop, that allocate SKBs and calls network
stack, as these operations that can take some time. The ptr_ring is a
communication channel between CPUs, where we want to reduce/limit any
cacheline bouncing.

Do a concentrated bulk dequeue via ptr_ring_consume_batched, to shorten the
period and times the remote cacheline in ptr_ring is read

Batch size 8 is both to (1) limit BH-disable period, and (2) consume one
cacheline on 64-bit archs. After reducing the BH-disable section further
then we can consider changing this, while still thinking about L1 cacheline
size being active.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 kernel/bpf/cpumap.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 3c18260403dd..430103e182a0 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -240,6 +240,8 @@ static void put_cpu_map_entry(struct bpf_cpu_map_entry *rcpu)
 	}
 }
 
+#define CPUMAP_BATCH 8
+
 static int cpu_map_kthread_run(void *data)
 {
 	struct bpf_cpu_map_entry *rcpu = data;
@@ -252,8 +254,9 @@ static int cpu_map_kthread_run(void *data)
 	 * kthread_stop signal until queue is empty.
 	 */
 	while (!kthread_should_stop() || !__ptr_ring_empty(rcpu->queue)) {
-		unsigned int processed = 0, drops = 0, sched = 0;
-		struct xdp_frame *xdpf;
+		unsigned int drops = 0, sched = 0;
+		void *frames[CPUMAP_BATCH];
+		int i, n;
 
 		/* Release CPU reschedule checks */
 		if (__ptr_ring_empty(rcpu->queue)) {
@@ -269,14 +272,16 @@ static int cpu_map_kthread_run(void *data)
 			sched = cond_resched();
 		}
 
-		/* Process packets in rcpu->queue */
-		local_bh_disable();
 		/*
 		 * The bpf_cpu_map_entry is single consumer, with this
 		 * kthread CPU pinned. Lockless access to ptr_ring
 		 * consume side valid as no-resize allowed of queue.
 		 */
-		while ((xdpf = __ptr_ring_consume(rcpu->queue))) {
+		n = ptr_ring_consume_batched(rcpu->queue, frames, CPUMAP_BATCH);
+
+		local_bh_disable();
+		for (i = 0; i < n; i++) {
+			struct xdp_frame *xdpf = frames[i];
 			struct sk_buff *skb;
 			int ret;
 
@@ -290,13 +295,9 @@ static int cpu_map_kthread_run(void *data)
 			ret = netif_receive_skb_core(skb);
 			if (ret == NET_RX_DROP)
 				drops++;
-
-			/* Limit BH-disable period */
-			if (++processed == 8)
-				break;
 		}
 		/* Feedback loop via tracepoint */
-		trace_xdp_cpumap_kthread(rcpu->map_id, processed, drops, sched);
+		trace_xdp_cpumap_kthread(rcpu->map_id, n, drops, sched);
 
 		local_bh_enable(); /* resched point, may call do_softirq() */
 	}

