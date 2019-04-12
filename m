Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43312C10F0E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 15:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7302171F
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 15:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfDLPHm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:07:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfDLPHm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 11:07:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D3BACC7E84;
        Fri, 12 Apr 2019 15:07:36 +0000 (UTC)
Received: from firesoul.localdomain (ovpn-200-48.brq.redhat.com [10.40.200.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0EB35D6A9;
        Fri, 12 Apr 2019 15:07:33 +0000 (UTC)
Received: from [10.10.10.1] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id E132B31256FC7;
        Fri, 12 Apr 2019 17:07:32 +0200 (CEST)
Subject: [PATCH bpf-next V2 1/4] bpf: cpumap use ptr_ring_consume_batched
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     netdev@vger.kernel.org, Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     songliubraving@fb.com,
        Toke =?utf-8?q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        ecree@solarflare.com, bpf@vger.kernel.org
Date:   Fri, 12 Apr 2019 17:07:32 +0200
Message-ID: <155508165286.23650.14511612928077972085.stgit@firesoul>
In-Reply-To: <155508158877.23650.13330504000013024259.stgit@firesoul>
References: <155508158877.23650.13330504000013024259.stgit@firesoul>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 12 Apr 2019 15:07:42 +0000 (UTC)
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
Acked-by: Song Liu <songliubraving@fb.com>
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

