Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF9FC10F11
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 11:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829D420820
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 11:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbfDJLnw (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:43:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40538 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729949AbfDJLnw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 07:43:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 65180306D321;
        Wed, 10 Apr 2019 11:43:51 +0000 (UTC)
Received: from firesoul.localdomain (ovpn-200-48.brq.redhat.com [10.40.200.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF39110694E8;
        Wed, 10 Apr 2019 11:43:48 +0000 (UTC)
Received: from [10.10.10.1] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id F393831256FC5;
        Wed, 10 Apr 2019 13:43:47 +0200 (CEST)
Subject: [PATCH bpf-next 3/5] net: core: introduce build_skb_around
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     netdev@vger.kernel.org, Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        bpf@vger.kernel.org,
        Toke =?utf-8?q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Date:   Wed, 10 Apr 2019 13:43:47 +0200
Message-ID: <155489662793.20826.5533583763088193882.stgit@firesoul>
In-Reply-To: <155489659290.20826.1108770347511292618.stgit@firesoul>
References: <155489659290.20826.1108770347511292618.stgit@firesoul>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 10 Apr 2019 11:43:51 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The function build_skb() also have the responsibility to allocate and clear
the SKB structure. Introduce a new function build_skb_around(), that moves
the responsibility of allocation and clearing to the caller. This allows
caller to use kmem_cache (slab/slub) bulk allocation API.

Next patch use this function combined with kmem_cache_alloc_bulk.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 include/linux/skbuff.h |    2 +
 net/core/skbuff.c      |   71 +++++++++++++++++++++++++++++++++++-------------
 2 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 9027a8c4219f..c40ffab8a9b0 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1044,6 +1044,8 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t priority, int flags,
 			    int node);
 struct sk_buff *__build_skb(void *data, unsigned int frag_size);
 struct sk_buff *build_skb(void *data, unsigned int frag_size);
+struct sk_buff *build_skb_around(struct sk_buff *skb,
+				 void *data, unsigned int frag_size);
 
 /**
  * alloc_skb - allocate a network buffer
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4782f9354dd1..d904b6e5fe08 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -258,6 +258,33 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 }
 EXPORT_SYMBOL(__alloc_skb);
 
+/* Caller must provide SKB that is memset cleared */
+static struct sk_buff *__build_skb_around(struct sk_buff *skb,
+					  void *data, unsigned int frag_size)
+{
+	struct skb_shared_info *shinfo;
+	unsigned int size = frag_size ? : ksize(data);
+
+	size -= SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+
+	/* Assumes caller memset cleared SKB */
+	skb->truesize = SKB_TRUESIZE(size);
+	refcount_set(&skb->users, 1);
+	skb->head = data;
+	skb->data = data;
+	skb_reset_tail_pointer(skb);
+	skb->end = skb->tail + size;
+	skb->mac_header = (typeof(skb->mac_header))~0U;
+	skb->transport_header = (typeof(skb->transport_header))~0U;
+
+	/* make sure we initialize shinfo sequentially */
+	shinfo = skb_shinfo(skb);
+	memset(shinfo, 0, offsetof(struct skb_shared_info, dataref));
+	atomic_set(&shinfo->dataref, 1);
+
+	return skb;
+}
+
 /**
  * __build_skb - build a network buffer
  * @data: data buffer provided by caller
@@ -279,32 +306,15 @@ EXPORT_SYMBOL(__alloc_skb);
  */
 struct sk_buff *__build_skb(void *data, unsigned int frag_size)
 {
-	struct skb_shared_info *shinfo;
 	struct sk_buff *skb;
-	unsigned int size = frag_size ? : ksize(data);
 
 	skb = kmem_cache_alloc(skbuff_head_cache, GFP_ATOMIC);
-	if (!skb)
+	if (unlikely(!skb))
 		return NULL;
 
-	size -= SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-
 	memset(skb, 0, offsetof(struct sk_buff, tail));
-	skb->truesize = SKB_TRUESIZE(size);
-	refcount_set(&skb->users, 1);
-	skb->head = data;
-	skb->data = data;
-	skb_reset_tail_pointer(skb);
-	skb->end = skb->tail + size;
-	skb->mac_header = (typeof(skb->mac_header))~0U;
-	skb->transport_header = (typeof(skb->transport_header))~0U;
 
-	/* make sure we initialize shinfo sequentially */
-	shinfo = skb_shinfo(skb);
-	memset(shinfo, 0, offsetof(struct skb_shared_info, dataref));
-	atomic_set(&shinfo->dataref, 1);
-
-	return skb;
+	return __build_skb_around(skb, data, frag_size);
 }
 
 /* build_skb() is wrapper over __build_skb(), that specifically
@@ -325,6 +335,29 @@ struct sk_buff *build_skb(void *data, unsigned int frag_size)
 }
 EXPORT_SYMBOL(build_skb);
 
+/**
+ * build_skb_around - build a network buffer around provided skb
+ * @skb: sk_buff provide by caller, must be memset cleared
+ * @data: data buffer provided by caller
+ * @frag_size: size of data, or 0 if head was kmalloced
+ */
+struct sk_buff *build_skb_around(struct sk_buff *skb,
+				 void *data, unsigned int frag_size)
+{
+	if (unlikely(!skb))
+		return NULL;
+
+	skb = __build_skb_around(skb, data, frag_size);
+
+	if (skb && frag_size) {
+		skb->head_frag = 1;
+		if (page_is_pfmemalloc(virt_to_head_page(data)))
+			skb->pfmemalloc = 1;
+	}
+	return skb;
+}
+EXPORT_SYMBOL(build_skb_around);
+
 #define NAPI_SKB_CACHE_SIZE	64
 
 struct napi_alloc_cache {

