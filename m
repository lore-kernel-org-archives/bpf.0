Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC33C10F11
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 11:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9208920820
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 11:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbfDJLn5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:43:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729949AbfDJLn5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 07:43:57 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D48CB306D32B;
        Wed, 10 Apr 2019 11:43:56 +0000 (UTC)
Received: from firesoul.localdomain (ovpn-200-48.brq.redhat.com [10.40.200.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF86569183;
        Wed, 10 Apr 2019 11:43:53 +0000 (UTC)
Received: from [10.10.10.1] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 0F73131256FC5;
        Wed, 10 Apr 2019 13:43:53 +0200 (CEST)
Subject: [PATCH bpf-next 4/5] bpf: cpumap do bulk allocation of SKBs
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     netdev@vger.kernel.org, Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        bpf@vger.kernel.org,
        Toke =?utf-8?q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Date:   Wed, 10 Apr 2019 13:43:53 +0200
Message-ID: <155489663300.20826.4588027365135744445.stgit@firesoul>
In-Reply-To: <155489659290.20826.1108770347511292618.stgit@firesoul>
References: <155489659290.20826.1108770347511292618.stgit@firesoul>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 10 Apr 2019 11:43:56 +0000 (UTC)
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
index cb93df200cd0..b82a11556ad5 100644
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
@@ -256,8 +256,10 @@ static int cpu_map_kthread_run(void *data)
 	while (!kthread_should_stop() || !__ptr_ring_empty(rcpu->queue)) {
 		unsigned int drops = 0, sched = 0;
 		void *frames[CPUMAP_BATCH];
+		void *skbs[CPUMAP_BATCH];
 		struct list_head skb_list;
-		int i, n;
+		gfp_t gfp = __GFP_ZERO | GFP_ATOMIC;
+		int i, n, m;
 
 		/* Release CPU reschedule checks */
 		if (__ptr_ring_empty(rcpu->queue)) {
@@ -279,14 +281,20 @@ static int cpu_map_kthread_run(void *data)
 		 * consume side valid as no-resize allowed of queue.
 		 */
 		n = ptr_ring_consume_batched(rcpu->queue, frames, CPUMAP_BATCH);
+		m = kmem_cache_alloc_bulk(skbuff_head_cache, gfp, n, skbs);
+		if (unlikely(m == 0)) {
+			for (i = 0; i < n; i++)
+				skbs[i] = NULL; /* effect: xdp_return_frame */
+			drops = n;
+		}
 
 		INIT_LIST_HEAD(&skb_list);
 
 		for (i = 0; i < n; i++) {
 			struct xdp_frame *xdpf = frames[i];
-			struct sk_buff *skb;
+			struct sk_buff *skb = skbs[i];
 
-			skb = cpu_map_build_skb(rcpu, xdpf);
+			skb = cpu_map_build_skb(rcpu, xdpf, skb);
 			if (!skb) {
 				xdp_return_frame(xdpf);
 				continue;

