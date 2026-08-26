Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D623F58C4
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787752399; cv=none; b=TaFWxHcDRN7MHghcyxHgISRJVZliFSycmhMV68aau8wxOGskqy3NegwVNaHeD+e3TWOquBgqIfw6oXf0zjgicS2GQ0MPDvwVYlNwItnYLyDt51WLqv74ylgLM+60EiWPl50pmc829eWQ28qdyhowKK1Ip6m+QAj7HO8k1Gbo/80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787752399; c=relaxed/simple;
	bh=lNykVtBr70fzkeERsXQk1l6K0eufJXwIgpUWXSM3lQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oA2pD/HKcexpv7EsaWD05tFE+MtSzRH51M9c1FWVBccf89p7dQAQb0w7kc6RuXymjlUDf8kY7dpfcrvbo7nN1kkFBCQo8Kaf45/mq0T3C8w+Qp52vSG8G4lFg1d1T67GLFKDCa12jZ2CjWjtb2yQxtnI3e+uufyLgLReKDxB3AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schauer.to; spf=pass smtp.mailfrom=schauer.to; dkim=pass (2048-bit key) header.d=schauer.to header.i=@schauer.to header.b=DQsv7KOx; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schauer.to
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schauer.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schauer.to header.i=@schauer.to header.b="DQsv7KOx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schauer.to;
	s=protonmail3; t=1787752378; x=1788011578;
	bh=gm76vh44kc3/5xg8wAarw1jy2itgUbQ73PLoetVFkzE=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=DQsv7KOxzBHg5BKCYeQXZauo5KWLtXP0FMJKi5mjQ0ehqp+FIZIE/1ExysYee0wdZ
	 c7cK4gfgiiubvt9lWP1KsozVoGqvMNsmKP+SzgKA9zyfTmEN+HDTnDXfElrctJPzqe
	 TjhdOnVbBddwwsMot+K+9JLXoQL7pwTDEx3sfuwvS4j4ydE1J75wZ1FbqM06NFc4Pr
	 aF1Ms8MSKnRQfkzHwPiNkJQurjwDHIaEGu5viZaj5T9jFwrjUlTcf+1wCkguQWM2Y9
	 diBCZqKvgseGtJeYR0YdvY+q2M5TD3CJgVrtP00FQvcf0bPkx+TGB6jo5045Mn1IKX
	 vVKfjaM1Z0Jgw==
X-Pm-Submission-Id: 4hVR1K4714z2Schk
From: Florian Schauer <florian@schauer.to>
To: hawk@kernel.org,
	ilias.apalodimas@linaro.org
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net] page_pool: keep frag_offset aligned for odd-sized requests
Date: Wed, 26 Aug 2026 15:52:52 +0200
Message-ID: <20260826135252.3091193-1-florian@schauer.to>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

page_pool_alloc_frag_netmem() rounds the requested fragment size with

	size = ALIGN(size, dma_get_cache_alignment());

dma_get_cache_alignment() returns 1 unless the architecture defines
ARCH_DMA_MINALIGN, which DMA-coherent architectures such as x86 do not.
There the ALIGN() is a no-op and pool->frag_offset advances by the raw,
unrounded size.

A single caller asking for an odd size then leaves frag_offset misaligned
for every fragment carved out of that page afterwards.  The pool is shared,
so the damage is not confined to the caller that caused it.

The per-cpu system_page_pool used by generic XDP hits this.
skb_pp_cow_data() allocates data fragments with the raw packet length:

	size = min_t(u32, len, PAGE_SIZE);
	truesize = size;
	page = page_pool_dev_alloc(pool, &page_off, &truesize);

and later calls page_pool_dev_alloc_va() for a new skb head, which
napi_build_skb() installs as skb->head.  Once frag_offset is odd that head
is misaligned, and so is skb_shinfo(skb) == skb->head + skb->end.

struct skb_shared_info begins with an atomic_t dataref, so the increment in
__skb_clone() straddles a cache line.  On x86 with split lock detection --
fatal for kernel split locks by default -- this panics the machine:

  Oops: Split lock detected
  RIP: 0010:skb_clone+0x154/0x1e0
  Call Trace:
   <IRQ>
   raw_local_deliver+0x1ed/0x2c0
   ip_protocol_deliver_rcu+0x54/0x1c0
   ip_local_deliver_finish+0x85/0x100
   ip_local_deliver+0x67/0x100
   __netif_receive_skb_one_core+0x85/0xa0
   process_backlog+0x87/0x130

Reproduced by attaching any generic-mode XDP program to loopback and
opening a RAW IPPROTO_UDP socket, which makes raw_local_deliver() clone
every locally delivered UDP packet; ordinary DNS traffic then triggers it,
roughly once per 2500 clones.  Observed on 6.12.101 and 7.1.8.

Tracing page_pool_alloc_frag_netmem() over one such run shows the
amplification -- two odd-sized requests, nine misaligned offsets:

  requested size & 7:   0: 17035    5: 1    7: 1
  frag_offset & 7:      0: 17028    3: 1    4: 1    5: 1    6: 1    7: 5

and skb_pp_cow_data() returning heads that were aligned on entry:

  head 0xffff8f4c86aeac00 -> 0xffff8f4c53a9a9c4 (&7=4)
  head 0xffff8f4d6a8a42c0 -> 0xffff8f4c4f7b7a45 (&7=5)

Round the fragment size up to at least the natural word size so fragments
are always suitably aligned for the objects callers build on them.
Architectures needing a larger DMA alignment keep it.

This also makes the remainder computed in page_pool_alloc_netmem(),

	*size = max_size - *offset;

aligned, since max_size is a power of two -- which fixes the matching
misalignment of skb->end.

Verified with a controlled A/B under QEMU/KVM: same tree, same config, same
compiler, same rootfs and identical traffic, differing only by this patch.  A
SEC("xdp.frags") XDP_PASS program on lo plus UDP datagrams larger than
max_head_size drives skb_pp_cow_data()'s fragment loop, which passes raw packet
lengths to the pool.  Measured at the return of skb_pp_cow_data():

                          unpatched   patched
  skb_pp_cow_data calls       40800     40800
  misaligned skb->head         1120         0
  dataref at line offset >60     80         0

The last row counts the accesses that actually fault: skb_shinfo()->dataref
sits at head+end+0x20 and is a 4-byte atomic, so `lock incl` splits a 64-byte
cache line only when that address lands at offset 61..63.  All 80 occurrences
were at offset 61; the panic reported above was at offset 62.  Eliminating the
misalignment removes every one of them.

Same class of bug as commit 3bed3cc4156e ("net: Do not allocate page
fragments that are not skb aligned"), which fixed the older
netdev_alloc_frag()/napi_alloc_frag() allocators.

Fixes: 53e0961da1c7 ("page_pool: add frag page recycling support in page pool")
Signed-off-by: Florian Schauer <florian@schauer.to>
---
 net/core/page_pool.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 1234567..89abcde 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1065,7 +1065,14 @@ netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
 	if (WARN_ON(size > max_size))
 		return 0;
 
-	size = ALIGN(size, dma_get_cache_alignment());
+	/* dma_get_cache_alignment() is 1 on DMA-coherent architectures, so on
+	 * its own it cannot keep frag_offset aligned.  Callers build objects
+	 * on these fragments -- skb_pp_cow_data() turns one into skb->head,
+	 * where skb_shinfo() must be aligned -- and the pool is shared, so an
+	 * odd-sized request must not skew every fragment that follows it.
+	 */
+	size = ALIGN(size, max_t(unsigned int, dma_get_cache_alignment(),
+				 sizeof(long)));
 	*offset = pool->frag_offset;
 
 	if (netmem && *offset + size > max_size) {
