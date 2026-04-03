Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40DE346FBC
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 01:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775180731; cv=none; b=SIVxdXp7nAM4SkV98w5ErBw+5YRzULC1uCjpjBr+5+vPg+isHteKFUjJ8RfINSRiuDsE47mARp4w3dezvNomYWSAoeb7L2Q+8c59xVWn3sj8BxhAof5PTNx/Vzd/hMwjP3o7aFTlsyoM0BHq1Z9LISkHm2aEnSYQjV+Xlu1HPGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775180731; c=relaxed/simple;
	bh=P7suTYjdTKQFqNxGneXVP9C7pxbbBFOIaA279vTubs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ctD+//gRZb+ZouxdJRCwijtTuMWeKJ/UuCi43+TlAQMkn5sBNdlXGtcraXcbO+Wj4u+eaRuTt3NjOqb0jq2KpkAbAehokY3r2/UYHgXrzWrGqXRiujJUEoNNX8yfA1PZScGoOm24uPVW1N9rcgFxvM37yKBbZmrrDrrIKJfhsHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QxDcrfcP; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QxDcrfcP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775180726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=umW2Vm01x/TtS9j0msR8qy2xrPc+F174PwIyfAFMorQ=;
	b=QxDcrfcPnIwYZ+GkdvLAm3cr2R9PYFBnYWL2dyWoeVQZkhJiYBLYTPfsJp4ldkqO0pNq/D
	OZVqumFAqp7ZyLQ/dG6oKCHoeC8nmT0jk8EKZE8LXdaQMwJGuAiaxaq5EZLEnF+TIUWl9N
	bL6LVwwVlyUYxevFnI8fPRSJrvT+nqY=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Antonius <antonius@bluedragonsec.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Michal Luczaj <mhal@rbox.co>,
	Mina Almasry <almasrymina@google.com>,
	Eric Biggers <ebiggers@google.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net v2] net: skb: fix cross-cache free of KFENCE-allocated skb head
Date: Fri,  3 Apr 2026 09:45:12 +0800
Message-ID: <20260403014517.142550-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

SKB_SMALL_HEAD_CACHE_SIZE is intentionally set to a non-power-of-2
value (e.g. 704 on x86_64) to avoid collisions with generic kmalloc
bucket sizes. This ensures that skb_kfree_head() can reliably use
skb_end_offset to distinguish skb heads allocated from
skb_small_head_cache vs. generic kmalloc caches.

However, when KFENCE is enabled, kfence_ksize() returns the exact
requested allocation size instead of the slab bucket size. If a caller
(e.g. bpf_test_init) allocates skb head data via kzalloc() and the
requested size happens to equal SKB_SMALL_HEAD_CACHE_SIZE, then
slab_build_skb() -> ksize() returns that exact value. After subtracting
skb_shared_info overhead, skb_end_offset ends up matching
SKB_SMALL_HEAD_HEADROOM, causing skb_kfree_head() to incorrectly free
the object to skb_small_head_cache instead of back to the original
kmalloc cache, resulting in a slab cross-cache free:

  kmem_cache_free(skbuff_small_head): Wrong slab cache. Expected
  skbuff_small_head but got kmalloc-1k

Fix this by always calling kfree(head) in skb_kfree_head(). This keeps
the free path generic and avoids allocator-specific misclassification
for KFENCE objects.

Fixes: bf9f1baa279f ("net: add dedicated kmem_cache for typical/small skb->head")
Reported-by: Antonius <antonius@bluedragonsec.com>
Closes: https://lore.kernel.org/netdev/CAK8a0jxC5L5N7hq-DT2_NhUyjBxrPocoiDazzsBk4TGgT1r4-A@mail.gmail.com/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

---
v1->v2: https://lore.kernel.org/netdev/20260402033138.388574-1-jiayuan.chen@linux.dev/
        - switch skb_kfree_head() to plain kfree(head)
---
 net/core/skbuff.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 0e217041958a..43ee86dcf2ea 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1083,10 +1083,7 @@ static int skb_pp_frag_ref(struct sk_buff *skb)
 
 static void skb_kfree_head(void *head, unsigned int end_offset)
 {
-	if (end_offset == SKB_SMALL_HEAD_HEADROOM)
-		kmem_cache_free(net_hotdata.skb_small_head_cache, head);
-	else
-		kfree(head);
+	kfree(head);
 }
 
 static void skb_free_head(struct sk_buff *skb)
-- 
2.43.0

