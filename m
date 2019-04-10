Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B2FC10F11
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 11:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F1F20820
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 11:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbfDJLns (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:43:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730103AbfDJLns (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 07:43:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4592A3082E4C;
        Wed, 10 Apr 2019 11:43:47 +0000 (UTC)
Received: from firesoul.localdomain (ovpn-200-48.brq.redhat.com [10.40.200.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB89A605CF;
        Wed, 10 Apr 2019 11:43:43 +0000 (UTC)
Received: from [10.10.10.1] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id E0B7131256FC5;
        Wed, 10 Apr 2019 13:43:42 +0200 (CEST)
Subject: [PATCH bpf-next 2/5] bpf: cpumap use netif_receive_skb_list
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     netdev@vger.kernel.org, Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        bpf@vger.kernel.org,
        Toke =?utf-8?q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Date:   Wed, 10 Apr 2019 13:43:42 +0200
Message-ID: <155489662285.20826.2411693802215419579.stgit@firesoul>
In-Reply-To: <155489659290.20826.1108770347511292618.stgit@firesoul>
References: <155489659290.20826.1108770347511292618.stgit@firesoul>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 10 Apr 2019 11:43:47 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Reduce BH-disable period further by moving cpu_map_build_skb()
outside/before invoking the network stack.  And build up a
skb_list that is used for netif_receive_skb_list. This is also
an I-cache optimization.

When injecting packets into the network stack, cpumap uses a special
function named netif_receive_skb_core(), and we create a equivalent list
version  named netif_receive_skb_list_core().

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 include/linux/netdevice.h |    1 +
 kernel/bpf/cpumap.c       |   17 ++++++++++-------
 net/core/dev.c            |   18 ++++++++++++++++++
 3 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 166fdc0a78b4..37e78dc9f30a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3621,6 +3621,7 @@ int netif_rx_ni(struct sk_buff *skb);
 int netif_receive_skb(struct sk_buff *skb);
 int netif_receive_skb_core(struct sk_buff *skb);
 void netif_receive_skb_list(struct list_head *head);
+void netif_receive_skb_list_core(struct list_head *head);
 gro_result_t napi_gro_receive(struct napi_struct *napi, struct sk_buff *skb);
 void napi_gro_flush(struct napi_struct *napi, bool flush_old);
 struct sk_buff *napi_get_frags(struct napi_struct *napi);
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 430103e182a0..cb93df200cd0 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -256,6 +256,7 @@ static int cpu_map_kthread_run(void *data)
 	while (!kthread_should_stop() || !__ptr_ring_empty(rcpu->queue)) {
 		unsigned int drops = 0, sched = 0;
 		void *frames[CPUMAP_BATCH];
+		struct list_head skb_list;
 		int i, n;
 
 		/* Release CPU reschedule checks */
@@ -279,23 +280,25 @@ static int cpu_map_kthread_run(void *data)
 		 */
 		n = ptr_ring_consume_batched(rcpu->queue, frames, CPUMAP_BATCH);
 
-		local_bh_disable();
+		INIT_LIST_HEAD(&skb_list);
+
 		for (i = 0; i < n; i++) {
 			struct xdp_frame *xdpf = frames[i];
 			struct sk_buff *skb;
-			int ret;
 
 			skb = cpu_map_build_skb(rcpu, xdpf);
 			if (!skb) {
 				xdp_return_frame(xdpf);
 				continue;
 			}
-
-			/* Inject into network stack */
-			ret = netif_receive_skb_core(skb);
-			if (ret == NET_RX_DROP)
-				drops++;
+			list_add_tail(&skb->list, &skb_list);
 		}
+
+		local_bh_disable();
+
+		/* Inject into network stack */
+		netif_receive_skb_list_core(&skb_list);
+
 		/* Feedback loop via tracepoint */
 		trace_xdp_cpumap_kthread(rcpu->map_id, n, drops, sched);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 9ca2d3abfd1a..1dee7bd895a0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5297,6 +5297,24 @@ void netif_receive_skb_list(struct list_head *head)
 }
 EXPORT_SYMBOL(netif_receive_skb_list);
 
+/**
+ *	netif_receive_skb_list_core - special version of netif_receive_skb_list
+ *	@head: list of skbs to process.
+ *
+ *	More direct receive version of netif_receive_skb_list().  It should
+ *	only be used by callers that have a need to skip RPS and Generic XDP.
+ *
+ *	This function may only be called from softirq context and interrupts
+ *	should be enabled.
+ */
+void netif_receive_skb_list_core(struct list_head *head)
+{
+	rcu_read_lock();
+	__netif_receive_skb_list(head);
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL(netif_receive_skb_list_core);
+
 DEFINE_PER_CPU(struct work_struct, flush_works);
 
 /* Network device is going away, flush any packets still pending */

