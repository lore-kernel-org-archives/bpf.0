Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A03C10F14
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 15:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CF42083E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 15:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfDLPHx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:07:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbfDLPHv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 11:07:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6396530718CE;
        Fri, 12 Apr 2019 15:07:51 +0000 (UTC)
Received: from firesoul.localdomain (ovpn-200-48.brq.redhat.com [10.40.200.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F370519747;
        Fri, 12 Apr 2019 15:07:48 +0000 (UTC)
Received: from [10.10.10.1] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 2154E31256FC7;
        Fri, 12 Apr 2019 17:07:48 +0200 (CEST)
Subject: [PATCH bpf-next V2 4/4] bpf: cpumap memory prefetchw optimizations
 for struct page
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     netdev@vger.kernel.org, Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     songliubraving@fb.com,
        Toke =?utf-8?q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        ecree@solarflare.com, bpf@vger.kernel.org
Date:   Fri, 12 Apr 2019 17:07:48 +0200
Message-ID: <155508166807.23650.1698718263344400653.stgit@firesoul>
In-Reply-To: <155508158877.23650.13330504000013024259.stgit@firesoul>
References: <155508158877.23650.13330504000013024259.stgit@firesoul>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 12 Apr 2019 15:07:51 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A lot of the performance gain comes from this patch.

While analysing performance overhead it was found that the largest CPU
stalls were caused when touching the struct page area. It is first read with
a READ_ONCE from build_skb_around via page_is_pfmemalloc(), and when freed
written by page_frag_free() call.

Measurements show that the prefetchw (W) variant operation is needed to
achieve the performance gain. We believe this optimization it two fold,
first the W-variant saves one step in the cache-coherency protocol, and
second it helps us to avoid the non-temporal prefetch HW optimizations and
bring this into all cache-levels. It might be worth investigating if
prefetch into L2 will have the same benefit.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Acked-by: Song Liu <songliubraving@fb.com>
---
 kernel/bpf/cpumap.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 732d6ced3987..cf727d77c6c6 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -280,6 +280,18 @@ static int cpu_map_kthread_run(void *data)
 		 * consume side valid as no-resize allowed of queue.
 		 */
 		n = ptr_ring_consume_batched(rcpu->queue, frames, CPUMAP_BATCH);
+
+		for (i = 0; i < n; i++) {
+			void *f = frames[i];
+			struct page *page = virt_to_page(f);
+
+			/* Bring struct page memory area to curr CPU. Read by
+			 * build_skb_around via page_is_pfmemalloc(), and when
+			 * freed written by page_frag_free call.
+			 */
+			prefetchw(page);
+		}
+
 		m = kmem_cache_alloc_bulk(skbuff_head_cache, gfp, n, skbs);
 		if (unlikely(m == 0)) {
 			for (i = 0; i < n; i++)

