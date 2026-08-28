Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49A92472A2;
	Fri, 28 Aug 2026 06:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787897320; cv=none; b=h1WzQrDI3XKNS8l29llzc3TTvC2bpYStchCG88FO2p9jCoUzkpIp4c5I/49eL67FKijRhKG/9nGBZtSMY6eTLvgVlaSieQCba2Siny3J2TKahFs+XhizBWoWYhzLUimFzgWLaDpnuKnjsychnGcQsMWjAFXQPkQUnVaslA78a78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787897320; c=relaxed/simple;
	bh=Pt8iG8FRmUsyMAl7DKYsLkgXlyGJTxab3ZqlzdP7+Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nuJ38wNqPWbCh/hZiQJWC/m5TEHx5/9xP+NEWsVvdtXfGLhj3U7LCKl6Foqo0AcSEmRYQLDR8K6W17eKxz0sA1BSQAoAMahVF4adpX9GF5xL8lF3GUAlSYGvYJ/nsiYrI2Dv7X5z3IerCYN/7FirgaUqCiwvH25SI7G9Z3kCWCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schauer.to; spf=pass smtp.mailfrom=schauer.to; dkim=pass (2048-bit key) header.d=schauer.to header.i=@schauer.to header.b=nCb7NtYU; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schauer.to
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schauer.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schauer.to header.i=@schauer.to header.b="nCb7NtYU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schauer.to;
	s=protonmail3; t=1787897306; x=1788156506;
	bh=RdmktDHYrNA4Xpiuvts8V3ojy0sMIivuhS/SjIYmfcE=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=nCb7NtYULsaqgsDNMVEbG6SioQ8t+tan/JPUIx8SQmp0QsaxDeOvh8XT8//goK12r
	 yPiENg/rsWaQT9Rk3FugYV4cop6PhBCxSW9y+UaJQnX5vdSXOdN1tte/etTQriFHo3
	 D50rKdQL4fNP2UQjx1J/SDIPGD8TTtvjoGuMr8XAh/ITOGwJ6jSmfe/Vv5zKtnIMO0
	 HB5g9D+GKQfTptxJzwzNBT7Bbc96Ftc5cVA9WGRO9NeZhJPndHgmKMo3T5W7o1DQLF
	 qzXHQDU83UQdXwOqXoIDDE3pEcQfzPewelaSe0emBgd2+pNHVZEAy/gMuUjfdTFgs3
	 Hx6Jj+ze19YRw==
X-Pm-Submission-Id: 4hWScS1FP2z2Schl
From: Florian Schauer <florian@schauer.to>
To: hawk@kernel.org,
	ilias.apalodimas@linaro.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linyunsheng@huawei.com
Subject: [PATCH net v2] page_pool: keep frag_offset aligned for odd-sized requests
Date: Fri, 28 Aug 2026 08:08:22 +0200
Message-ID: <20260828060822.2628276-1-florian@schauer.to>
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
skb_pp_cow_data() allocates its fragments with the raw packet length:

	size = min_t(u32, len, PAGE_SIZE);
	truesize = size;
	page = page_pool_dev_alloc(pool, &page_off, &truesize);

leaving frag_offset odd for whatever is carved out of that page next.  Its
own head allocation is already aligned -- SKB_HEAD_ALIGN(size) plus the
XDP_PACKET_HEADROOM its callers pass -- so it is a later user of the shared
pool that pays: page_pool_dev_alloc_va() returns a misaligned buffer,
napi_build_skb() installs it as skb->head, and skb_shinfo(skb) ==
skb->head + skb->end is misaligned with it.

skb_shinfo()->dataref is a 4-byte atomic_t at offset 0x20, so the
atomic_inc() in __skb_clone() straddles a cache line.  On x86 with split
lock detection -- fatal for kernel split locks by default -- this panics
the machine:

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

Round the fragment size up to at least the alignment struct skb_shared_info
requires, so fragments are always suitably aligned for the objects callers
build on them.  Architectures needing a larger DMA alignment keep it.

This also makes the remainder computed in page_pool_alloc_netmem(),

	*size = max_size - *offset;

aligned, since max_size is a power of two -- which fixes the matching
misalignment of skb->end.

Verified with a controlled A/B under QEMU/KVM: same tree, same config,
same compiler, same rootfs and identical traffic, differing only by this
patch.  A SEC("xdp.frags") XDP_PASS program on lo plus UDP datagrams
larger than max_head_size drives skb_pp_cow_data()'s fragment loop, which
passes raw packet lengths to the pool.  Measured at the return of
skb_pp_cow_data():

                          unpatched   patched
  skb_pp_cow_data calls       40800     40800
  misaligned skb->head         1120         0
  dataref at line offset >60     80         0

The last row counts the accesses that actually fault:
skb_shinfo()->dataref sits at head+end+0x20 and is a 4-byte atomic, so
`lock incl` splits a 64-byte cache line only when that address lands at
offset 61..63.  All 80 occurrences were at offset 61; the panic reported
above was at offset 62.  Eliminating the misalignment removes every one
of them.

Same class of bug as commit 3bed3cc4156e ("net: Do not allocate page
fragments that are not skb aligned"), which fixed the older
netdev_alloc_frag()/napi_alloc_frag() allocators.

Fixes: 53e0961da1c7 ("page_pool: add frag page recycling support in page pool")
Cc: stable@vger.kernel.org
Signed-off-by: Florian Schauer <florian@schauer.to>
---
v2:
  - express the minimum alignment as __alignof__(struct skb_shared_info)
    instead of sizeof(long), and drop the explanatory comment the previous
    version carried, since the expression now states the requirement
    directly (Eric Dumazet)
  - no functional change vs v1 on 64-bit: the emitted code is identical
  - Cc the maintainers and the blamed author that v1 missed
  - correct two statements in the commit message: dataref is at offset 0x20
    in struct skb_shared_info, not its first member, and skb_pp_cow_data()
    allocates its head before the fragment loop, so the misaligned head
    comes from an earlier user of the shared pool
v1: https://lore.kernel.org/netdev/20260826135252.3091193-1-florian@schauer.to/

 net/core/page_pool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 8f8956fb0..08d7f35cf 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1073,7 +1073,8 @@ netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
 	if (WARN_ON(size > max_size))
 		return 0;
 
-	size = ALIGN(size, dma_get_cache_alignment());
+	size = ALIGN(size, max_t(unsigned int, dma_get_cache_alignment(),
+				 __alignof__(struct skb_shared_info)));
 	*offset = pool->frag_offset;
 
 	if (netmem && *offset + size > max_size) {
-- 
2.47.3

