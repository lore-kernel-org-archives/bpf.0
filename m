Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9192B40D58B
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781037938; cv=none; b=f4kLdUwaK2I4rHO3hroYNuyFR9IayZlwPd14WZKjgs6y5uL9LbsilsUjZyt4ukU3l5CTxaLbMNeYCf1fRFtSBCE86Y18lwXkL7a8OUe0OexDKniqC4K1KSaOtXPmBsN9VcO1jIZf4BS2kuvM+qpDFwptBdpBTaqHXkZ7l76OHXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781037938; c=relaxed/simple;
	bh=S1x9x4Ghq2az/KolNp8/QcD1M4y0M34YTVMgXCocxJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dmx/Of9yysdS5pw5sH77BQpz273C+PwRdhMDwRN04cN5t1wxz9QHBPDq0wZxcm1XbKkmC6KW8Z6U4RGbAAduo8LlLE+zPwcHgL53xUqdGnm5vSlGoHJeE9ohapWA8lBHeAaF3+ichTMGEaAbyzvyxt3eeAjJU4d8n9emmutDJgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=bY3Jl71K; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="bY3Jl71K"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c0c2c7d45eso54238595ad.1
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 13:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1781037936; x=1781642736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3K1B8gwLWAzRfKm1h5Jy5RNbuV45+npcCR0eQNcT6pI=;
        b=bY3Jl71KzeiSX+qbk/Ej89CmWJtq3qZvVP6F2+KRJ+3HYsjg5uu7W1fYrduqF9650O
         IyJdME7uF2r+s0GBzutwhaMmMu0tDQGg30RzPfcuXofPdkVmSMY0izKdAMWBr3uTbkAV
         xB7/gMyuRBUDNRgNlU9kNkhFqYzLQND7LJ6XErTZxFQBWQIZwBlAioFd2x8MyETXDYPP
         XQkAcVIniyKqxg0ZKN0oiWWostJFUr/79Zn1OOBe9kcMbMYcQGgAwSVt5O9asPq6K3XU
         7pYJLh4a+ypTCaymBJ+JGc3vSUf/c6i9TFvFNEaVuGdrmjIT4as8auWZILvhCdv/IQtF
         LAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781037936; x=1781642736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3K1B8gwLWAzRfKm1h5Jy5RNbuV45+npcCR0eQNcT6pI=;
        b=ggNdbypiszqek9/FaKfxpoazprusgz6G+As7SsHubJ3BDywgPWq6AN7MFnEkIqTu6+
         9HbeEyovh2C9PjyJE3oxoQUJmYuRBHgXI6Nf/FkOmIDudP+2S5NTuryyjfRx0fYUjybX
         GQ5rLIcrzH+GIOBT1eC7yxEH3sFtrk7aeyFBSrZ3El8lqdG5vwbpcAG0z+BrMf9nnaXL
         H946wrEaCENnjgAu0vqjGo5aMar67OVV9iC6ICju7EL1PIS00P1tb8Mf0GV33BNvi6e3
         SBF7H7IwsKbvfd2WaI2JmvOwZwkxN0AOzloMMDGMxxo1aF/kijDeLTh+KIONq/aWcU4v
         MjkQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Lswz2XlDIusiBPKo7xfbieaHPTgNg9f3isOdHVC+X+Is7KAR7tolK58e0MgjNbe9Q+uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPvRrcG/ehkyW1uEqnquIZD00/kjwkde/iRCDwxLEpnNOMuY40
	GlYRTFMjvUN3HYq0ONyP4RPwgFevp+fMCTbi1+ep96jYsS6cE7FVHZa1cMDBxKgeTqs=
X-Gm-Gg: Acq92OHK1Ef99wjx9QeZ69IJNAM7jAx8VCByq3vsE2IMztM7tfOmQ8DYLwujC/T4nR+
	oMxJtZlVkcqKCZqbbaCUIpQdaiosf0vGv8tAQpmDvhnh1C+BfP2wkiEmMXzIX96ktRdaoFTdGaZ
	i6+4KZIfFxBByDoKEjN1nj+Wy3UkJgj8YS0221ji2a0Juw0N9HBw91yhZmv/NOtJJqVREyk/aCv
	g6+W7Wl0FUVulPx3UeIChj988Kcliy8rWZ26xHd0VM5DMUfyBVWancbq5lsD0/yyli0L+noeCgv
	hgnKtECK2+kKhCgvGdwtthf/QOVY1pOJFenhaKPsMYWEMuLjrS2Jj9KmpwLlP7x760iayJxvKD4
	Wtind7a0eCQbwdGjCZBkaLxVM7TrVYU2AsCpEjrSLO43amLFfaahzRza55RQWVkB4w8tiEbFnDh
	RJKvchPSPVGxs7wZM=
X-Received: by 2002:a17:903:22c4:b0:2c0:c262:b91f with SMTP id d9443c01a7336-2c1e80e431emr246254985ad.8.1781037935811;
        Tue, 09 Jun 2026 13:45:35 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d37esm292358325ad.9.2026.06.09.13.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 13:45:35 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Cc: horms@kernel.org,
	Joe Damato <joe@dama.to>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net v2] bnxt: fix head underflow on XDP head-grow
Date: Tue,  9 Jun 2026 13:44:58 -0700
Message-ID: <20260609204458.2237787-2-joe@dama.to>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xdp.py test test_xdp_native_adjst_head_grow_data crashes when run on
a bnxt machine (and also crashes in NIPA).

It seems that the bug is an underflow in bnxt_rx_multi_page_skb, which
builds the skb head:

  napi_build_skb(data_ptr - bp->rx_offset, rxr->rx_page_size);

The problem with this expression is that in page mode, rx_offset is:

  bp->rx_offset = NET_IP_ALIGN + XDP_PACKET_HEADROOM;

Which evaluates (at least on x86_64) to 258.

The test test_xdp_native_adjst_head_grow_data tests a case where the
head is adjusted by -256.

When this test runs, data_ptr is shifted to frag_start + 2 (where
frag_start = page_address(page) + offset).

Then, bnxt_rx_multi_page_skb is invoked and the napi_build_skb
expression subtracts 258, landing at an address before frag_start. This
could be either the previous fragment or the previous physical page when
the offset is < 256 (e.g. if the fragment started at offset 0).

When the skb is freed, the page pool fragment reference is dropped on
either the wrong page or the wrong frag of the right page. In either
case, the corrupted reference count can lead to the page being
prematurely recycled while still in use. Once (incorrectly) recycled, it
can be handed out again and on driver teardown this would result in a
double free.

The commit under fixes updated this code to handle the case where the
native page size is >= 64k, but it unintentionally broke the head grow
case.

To fix this, add an offset field to struct bnxt_sw_rx_bd, mirroring the
existing offset field in struct bnxt_sw_rx_agg_bd. Populate it on
allocation and preserve it on reuse.

In bnxt_rx_multi_page_skb, use the newly added offset field to compute
the fragment start and pass that to napi_build_skb. Adjust the layout
with skb_reserve.

There are two cases, the non-adjustment case and the adjustment case.

In both cases, the skb is built at page_address(page) + offset to
account for the case where the native page size >= 64K and skb_reserve
is called with data_ptr - (page_address(page) + offset). That
difference equals bp->rx_offset when data_ptr was not moved, or
bp->rx_offset + xdp_adjust when XDP adjusted the head.

Re-running the failing test with this commit applied causes the test to
run successfully to completion.

The other rx_skb_func implementations don't have this issue.

Fixes: f6974b4c2d8e ("bnxt_en: Fix page pool logic for page size >= 64K")
Signed-off-by: Joe Damato <joe@dama.to>
---
 v2:
   - Add offset to bnxt_sw_rx_bd, mirroring bnxt_sw_rx_agg_bd,
     as suggested by Michael Chan, eliminating math and simplifying code
     in bnxt_rx_multi_page_skb
   - Re-ran the xdp.py test to confirm the crash is resolved.

 v1: https://lore.kernel.org/netdev/20260608203129.920104-1-joe@dama.to/

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 10 ++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 35e1f8f663c7..12e73ffff6c3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1011,6 +1011,7 @@ int bnxt_alloc_rx_data(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 		mapping += bp->rx_dma_offset;
 		rx_buf->data = page;
 		rx_buf->data_ptr = page_address(page) + offset + bp->rx_offset;
+		rx_buf->offset = offset;
 	} else {
 		u8 *data = __bnxt_alloc_rx_frag(bp, &mapping, rxr, gfp);
 
@@ -1019,6 +1020,7 @@ int bnxt_alloc_rx_data(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 
 		rx_buf->data = data;
 		rx_buf->data_ptr = data + bp->rx_offset;
+		rx_buf->offset = 0;
 	}
 	rx_buf->mapping = mapping;
 
@@ -1040,6 +1042,7 @@ void bnxt_reuse_rx_data(struct bnxt_rx_ring_info *rxr, u16 cons, void *data)
 	prod_rx_buf->data_ptr = cons_rx_buf->data_ptr;
 
 	prod_rx_buf->mapping = cons_rx_buf->mapping;
+	prod_rx_buf->offset = cons_rx_buf->offset;
 
 	prod_bd = &rxr->rx_desc_ring[RX_RING(bp, prod)][RX_IDX(prod)];
 	cons_bd = &rxr->rx_desc_ring[RX_RING(bp, cons)][RX_IDX(cons)];
@@ -1175,8 +1178,11 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
 	struct page *page = data;
 	u16 prod = rxr->rx_prod;
 	struct sk_buff *skb;
+	void *frag_start;
 	int err;
 
+	frag_start = page_address(page) + rxr->rx_buf_ring[cons].offset;
+
 	err = bnxt_alloc_rx_data(bp, rxr, prod, GFP_ATOMIC);
 	if (unlikely(err)) {
 		bnxt_reuse_rx_data(rxr, cons, data);
@@ -1185,13 +1191,13 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
 	dma_addr -= bp->rx_dma_offset;
 	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, rxr->rx_page_size,
 				bp->rx_dir);
-	skb = napi_build_skb(data_ptr - bp->rx_offset, rxr->rx_page_size);
+	skb = napi_build_skb(frag_start, rxr->rx_page_size);
 	if (!skb) {
 		page_pool_recycle_direct(rxr->page_pool, page);
 		return NULL;
 	}
 	skb_mark_for_recycle(skb);
-	skb_reserve(skb, bp->rx_offset);
+	skb_reserve(skb, data_ptr - (u8 *)frag_start);
 	__skb_put(skb, len);
 
 	return skb;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 61c847b36b9f..a2e75cfb65ab 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -911,6 +911,7 @@ struct bnxt_sw_rx_bd {
 	void			*data;
 	u8			*data_ptr;
 	dma_addr_t		mapping;
+	unsigned int		offset;
 };
 
 struct bnxt_sw_rx_agg_bd {

base-commit: 0aa05daef7848a5ac11158949dc73cd741995dc1
-- 
2.53.0-Meta

