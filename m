Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91105C10F0E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 15:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FEA2171F
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 15:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfDLPHu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:07:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbfDLPHu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 11:07:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB519308ED6E;
        Fri, 12 Apr 2019 15:07:48 +0000 (UTC)
Received: from firesoul.localdomain (ovpn-200-48.brq.redhat.com [10.40.200.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DDBC35C219;
        Fri, 12 Apr 2019 15:07:43 +0000 (UTC)
Received: from [10.10.10.1] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 10507306665E6;
        Fri, 12 Apr 2019 17:07:43 +0200 (CEST)
Subject: [PATCH bpf-next V2 3/4] bpf: cpumap do bulk allocation of SKBs
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     netdev@vger.kernel.org, Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     songliubraving@fb.com,
        Toke =?utf-8?q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        ecree@solarflare.com, bpf@vger.kernel.org
Date:   Fri, 12 Apr 2019 17:07:43 +0200
Message-ID: <155508166300.23650.17848112882333883560.stgit@firesoul>
In-Reply-To: <155508158877.23650.13330504000013024259.stgit@firesoul>
References: <155508158877.23650.13330504000013024259.stgit@firesoul>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 12 Apr 2019 15:07:49 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As cpumap now batch consume xdp_frame's from the ptr_ring, it knows how many
SKBs it need to allocate. Thus, lets bulk allocate these SKBs via
kmem_cache_alloc_bulk() API, and use the previously introduced function
build_skb_around().

Notice that the flag __GFP_ZERO asks the slab/slub allocator to clear the
memory for us. This does clear a larger area than needed, but my micro
benchmarks on Intel CPUs show that this is slightly faster due to being a
cacheline aligned area is cleared for the SKBs. (For SLUB allocator, there
is a future optimization potential, because SKBs will with high probability
originate from same page. If we can find/identify continuous memory areas
then the Intel CPU memset rep stos will have a real performance gain.)

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 kernel/bpf/cpumap.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 430103e182a0..732d6ced3987 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -160,12 +160,12 @@ static void cpu_map_kthread_stop(struct work_struct *work)
 }
 
 static struct sk_buff *cpu_map_build_skb(struct bpf_cpu_map_entry *rcpu,
-					 struct xdp_frame *xdpf)
+					 struct xdp_frame *xdpf,
+					 struct sk_buff *skb)
 {
 	unsigned int hard_start_headroom;
 	unsigned int frame_size;
 	void *pkt_data_start;
-	struct sk_buff *skb;
 
 	/* Part of headroom was reserved to xdpf */
 	hard_start_headroom = sizeof(struct xdp_frame) +  xdpf->headroom;
@@ -191,8 +191,8 @@ static struct sk_buff *cpu_map_build_skb(struct bpf_cpu_map_entry *rcpu,
 		SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
 	pkt_data_start = xdpf->data - hard_start_headroom;
-	skb = build_skb(pkt_data_start, frame_size);
-	if (!skb)
+	skb = build_skb_around(skb, pkt_data_start, frame_size);
+	if (unlikely(!skb))
 		return NULL;
 
 	skb_reserve(skb, hard_start_headroom);
@@ -256,7 +256,9 @@ static int cpu_map_kthread_run(void *data)
 	while (!kthread_should_stop() || !__ptr_ring_empty(rcpu->queue)) {
 		unsigned int drops = 0, sched = 0;
 		void *frames[CPUMAP_BATCH];
-		int i, n;
+		void *skbs[CPUMAP_BATCH];
+		gfp_t gfp = __GFP_ZERO | GFP_ATOMIC;
+		int i, n, m;
 
 		/* Release CPU reschedule checks */
 		if (__ptr_ring_empty(rcpu->queue)) {
@@ -278,14 +280,20 @@ static int cpu_map_kthread_run(void *data)
 		 * consume side valid as no-resize allowed of queue.
 		 */
 		n = ptr_ring_consume_batched(rcpu->queue, frames, CPUMAP_BATCH);
+		m = kmem_cache_alloc_bulk(skbuff_head_cache, gfp, n, skbs);
+		if (unlikely(m == 0)) {
+			for (i = 0; i < n; i++)
+				skbs[i] = NULL; /* effect: xdp_return_frame */
+			drops = n;
+		}
 
 		local_bh_disable();
 		for (i = 0; i < n; i++) {
 			struct xdp_frame *xdpf = frames[i];
-			struct sk_buff *skb;
+			struct sk_buff *skb = skbs[i];
 			int ret;
 
-			skb = cpu_map_build_skb(rcpu, xdpf);
+			skb = cpu_map_build_skb(rcpu, xdpf, skb);
 			if (!skb) {
 				xdp_return_frame(xdpf);
 				continue;

