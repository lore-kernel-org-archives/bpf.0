Return-Path: <SRS0=wUMJ=RW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5447C43381
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 22:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35CE2175B
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 22:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fyT7hGL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfCSWT4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:19:56 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:54930 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfCSWT4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 18:19:56 -0400
Received: by mail-pf1-f201.google.com with SMTP id 134so332472pfx.21
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2019 15:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3k1tFAi4F6JIy9kaY+8H/bmQ6oZx0FQFPZrYjeWnMvE=;
        b=fyT7hGL2qRtQLUVU7idNvGqZ68+c5qNyRhIQkaQrWPcmQUKJPB/VW/99SZDsq40sje
         huV8CV2wLHzxANkBpozO1G2rbvNrb/ObVpvmGBQf1hsmLNVEmFIsImeKOqzHybwrmvc9
         fK3TUaVtUeYiqs92E8oc2qDnw3tR7LObSNdMzgK3FdCgSjptzvIXiH5u3Amej4BgcCW9
         kSDL+VNgczH5GIGeF3P1foOjY/bp6xEHfINqmEc+46V4DykJkEl7t9IMmpguFOT/Yb0z
         mknwfkxK4OBziVfc0G6wBse6Fb4wPfyqJB7cg2wZZzAPjuOGxl2oUAJYYnjUe2JycWsa
         9sWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3k1tFAi4F6JIy9kaY+8H/bmQ6oZx0FQFPZrYjeWnMvE=;
        b=NElrzhzciYzhEOKg7Oy2sU9zOE/oun8N+OFQ87hRq5K7QzQ1XbrWAmfZtdKRel9cqW
         jI0Vq63MrP0uKz1tgfa4EK2Zv4eoQ25WFqh8lCVtbHXU/9pcoHZJ5dP4p9BoWokR0rMz
         hN+B2ARJECYsWxyVzxWBc0C33bFE5BAwvluaKuI3Pmj2YMXfcnDlbquAOrRSrY8PTEcM
         FTrVOX6r9Q8z7LZ8+wRngBt8WqvgcXoO3Z8FswoZC9TzykDMJYSN7ss576F0t7qHl8Zn
         w8VrJUdsir4klcNS3CTt+sWwiI0thALrNgwMRRVhT/ptI7O0SgHQqhl+4PMhtYY0SPjO
         J7MQ==
X-Gm-Message-State: APjAAAWu7uJyeQ27wxRWEGyM+pTT08gcKDWVGFi6aCnrPU+nTEjYqjgo
        wb4EqLLeYL8bXlfVa843x3tmKBM=
X-Google-Smtp-Source: APXvYqwUDIfrlXvPl3voGBdozSz/C/vPp/469DyvzKbr5mK2tRk0IHK/QWox0bX0/zLEqta+gOTbYkA=
X-Received: by 2002:a17:902:4624:: with SMTP id o33mr7056370pld.91.1553033993938;
 Tue, 19 Mar 2019 15:19:53 -0700 (PDT)
Date:   Tue, 19 Mar 2019 15:19:40 -0700
In-Reply-To: <20190319221948.170441-1-sdf@google.com>
Message-Id: <20190319221948.170441-2-sdf@google.com>
Mime-Version: 1.0
References: <20190319221948.170441-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [RFC bpf-next v2 1/9] net: introduce __init_skb{,_data,_shinfo} helpers
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        simon.horman@netronome.com, willemb@google.com,
        peterpenkov96@gmail.com, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

__init_skb is essentially a version of __build_skb which accepts skb as
an argument (instead of doing kmem_cache_alloc to allocate it).

__init_skb_shinfo initializes shinfo.

__init_skb_data initializes skb data pointers.

No functional changes.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/skbuff.h | 14 ++++++++++
 net/core/skbuff.c      | 60 +++++++++++++++++-------------------------
 2 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 9027a8c4219f..e8c1d5b97f96 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4399,5 +4399,19 @@ static inline __wsum lco_csum(struct sk_buff *skb)
 	return csum_partial(l4_hdr, csum_start - l4_hdr, partial);
 }
 
+static inline void __init_skb_data(struct sk_buff *skb, u8 *data,
+				   unsigned int size)
+{
+	/* Account for allocated memory : skb + skb->head */
+	skb->truesize = SKB_TRUESIZE(size);
+	refcount_set(&skb->users, 1);
+	skb->head = data;
+	skb->data = data;
+	skb_reset_tail_pointer(skb);
+	skb->end = skb->tail + size;
+	skb->mac_header = (typeof(skb->mac_header))~0U;
+	skb->transport_header = (typeof(skb->transport_header))~0U;
+}
+
 #endif	/* __KERNEL__ */
 #endif	/* _LINUX_SKBUFF_H */
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 2415d9cb9b89..b413354ee709 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -160,6 +160,26 @@ static void *__kmalloc_reserve(size_t size, gfp_t flags, int node,
  *
  */
 
+static inline void __init_skb(struct sk_buff *skb, u8 *data, unsigned int size)
+{
+	/* Only clear those fields we need to clear, not those that we will
+	 * actually initialize below. Hence, don't put any more fields after
+	 * the tail pointer in struct sk_buff!
+	 */
+	memset(skb, 0, offsetof(struct sk_buff, tail));
+	__init_skb_data(skb, data, size);
+}
+
+static inline void __init_skb_shinfo(struct sk_buff *skb)
+{
+	struct skb_shared_info *shinfo;
+
+	/* make sure we initialize shinfo sequentially */
+	shinfo = skb_shinfo(skb);
+	memset(shinfo, 0, offsetof(struct skb_shared_info, dataref));
+	atomic_set(&shinfo->dataref, 1);
+}
+
 /**
  *	__alloc_skb	-	allocate a network buffer
  *	@size: size to allocate
@@ -181,7 +201,6 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 			    int flags, int node)
 {
 	struct kmem_cache *cache;
-	struct skb_shared_info *shinfo;
 	struct sk_buff *skb;
 	u8 *data;
 	bool pfmemalloc;
@@ -215,27 +234,9 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 	size = SKB_WITH_OVERHEAD(ksize(data));
 	prefetchw(data + size);
 
-	/*
-	 * Only clear those fields we need to clear, not those that we will
-	 * actually initialise below. Hence, don't put any more fields after
-	 * the tail pointer in struct sk_buff!
-	 */
-	memset(skb, 0, offsetof(struct sk_buff, tail));
-	/* Account for allocated memory : skb + skb->head */
-	skb->truesize = SKB_TRUESIZE(size);
+	__init_skb(skb, data, size);
+	__init_skb_shinfo(skb);
 	skb->pfmemalloc = pfmemalloc;
-	refcount_set(&skb->users, 1);
-	skb->head = data;
-	skb->data = data;
-	skb_reset_tail_pointer(skb);
-	skb->end = skb->tail + size;
-	skb->mac_header = (typeof(skb->mac_header))~0U;
-	skb->transport_header = (typeof(skb->transport_header))~0U;
-
-	/* make sure we initialize shinfo sequentially */
-	shinfo = skb_shinfo(skb);
-	memset(shinfo, 0, offsetof(struct skb_shared_info, dataref));
-	atomic_set(&shinfo->dataref, 1);
 
 	if (flags & SKB_ALLOC_FCLONE) {
 		struct sk_buff_fclones *fclones;
@@ -277,7 +278,6 @@ EXPORT_SYMBOL(__alloc_skb);
  */
 struct sk_buff *__build_skb(void *data, unsigned int frag_size)
 {
-	struct skb_shared_info *shinfo;
 	struct sk_buff *skb;
 	unsigned int size = frag_size ? : ksize(data);
 
@@ -287,20 +287,8 @@ struct sk_buff *__build_skb(void *data, unsigned int frag_size)
 
 	size -= SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-	memset(skb, 0, offsetof(struct sk_buff, tail));
-	skb->truesize = SKB_TRUESIZE(size);
-	refcount_set(&skb->users, 1);
-	skb->head = data;
-	skb->data = data;
-	skb_reset_tail_pointer(skb);
-	skb->end = skb->tail + size;
-	skb->mac_header = (typeof(skb->mac_header))~0U;
-	skb->transport_header = (typeof(skb->transport_header))~0U;
-
-	/* make sure we initialize shinfo sequentially */
-	shinfo = skb_shinfo(skb);
-	memset(shinfo, 0, offsetof(struct skb_shared_info, dataref));
-	atomic_set(&shinfo->dataref, 1);
+	__init_skb(skb, data, size);
+	__init_skb_shinfo(skb);
 
 	return skb;
 }
-- 
2.21.0.225.g810b269d1ac-goog

