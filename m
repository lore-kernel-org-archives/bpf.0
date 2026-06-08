Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B9731F9A2
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780950696; cv=none; b=nYCAJsgrMUHxG6AWOP0YFWQlxZ+IMPANAfYC8QMP8w5BVZI+CMr6OuU5swXJuMY1Or0HMSJLv4mtGA5fqgvQgrmWAy7YPu2tDiAPig2Le+St9yqGVqgeSSWYf0thNVSOMlV56sQJtc4Y8eyWNvy6TSei6gph7Y6LhCAuCJGREhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780950696; c=relaxed/simple;
	bh=g+hB/yLQ6vKKkVlN8bF6XCd8McWiw35mowG9ThCTB7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X60Wr1Udduwg2090u/BcBxuI5tPOOOVYMsam0mRAf4Eiec4swqJqEFcCGgaWnkI3/YDLHYeA+bTzhGUQLhU2t88auomQBsecFTNT5YUwOr+Cp+i1iHq9F+fV6idyL9UiSeDu+l/o3Fzj/4gKJd4ornmsrySoxf0XIv3LpquRGFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=UPhOH13r; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="UPhOH13r"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf55c39e16so22832295ad.0
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 13:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1780950694; x=1781555494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gwfi1hNRVN18tx6MvutAXdjRReqdu40MZi3rUahoZ8o=;
        b=UPhOH13r6lLqSx6YrNSgIY1lhaFxRo7ZrVw9xzxUrna1VUg0TyYdTdzG55X1doURsM
         YrWs1reysVtG0FpYGb1MRokQauO/DRlVh2ut2R7EoO4HMaeNwmG7tHQxCgW2d3pA1O8F
         GVIw7ZCuPLMKhcA4g9pplMsXljeuv6Hrc6UecfpJFBkrCcFIBo1Vz6TFGSHGbVz9lLW5
         6t4oBbzIOkq2hWE7tNJk5R0O1i60EFD0hitC3b9ikj0BhXzqjLuOHsM7woR/4n2Zi9/d
         WZFLIV1oExHYuQVYY5zuDeN4/QjI9wIxLltnD+J6IyRaj7nZyjyd+CM3dQ01GkkST81v
         UMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780950694; x=1781555494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwfi1hNRVN18tx6MvutAXdjRReqdu40MZi3rUahoZ8o=;
        b=eia6Bkiy+S5Abh613EQkZGwtiomNHVvd2mZY0pVv9r2yo2pUadFJZlEYqv3Y3c9HzA
         sqNc3NR6lHNxxSpvB78ghO9uhfefV1oYOCsCJWFoRlLpNNekgLe/PT7Up6kfvSTMQIlr
         VthGyHCev420UfZ7JipznUIoAkuajNnlFh/ZY57iJs2w44KReS/KJwHKfXpWRvBXxKRS
         +yk98VqNRep/ghnzKDrnyNHB0J7G7MqieOyBJoXbXETdfvfuQjS0WMHOKKukaRwKHVAw
         2gpI4FiqPx64uLdmHOaf3jX1alFx7aqFCzCZI4jTkxGxuXmUrDSFhzEJJ5XVA22y01fR
         Jj8g==
X-Forwarded-Encrypted: i=1; AFNElJ/UfmF8izZKQ59GU4hESq3gEc6mr2VZKVEAnVXcCZHTAkaWJHtaUo/Xt9MorTsjCyc7Ges=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnfgDBCGdRX3jBHjdQyDkyvp75kIv697dAlaVOWl/kMDMnT/vl
	e5kFxyBuxjr4zu5DcCpNKOV6xdqEibFWAmsoeADqn875gAiO+earCSrnuSvawm3tCxQ=
X-Gm-Gg: Acq92OH3KnHElbrnwJzA0P3qhFQmoynGpQGlKi1HZPe1UxuNQYfmxEH8FWVg9qvGU82
	4wdzBaNsORBX5QOYSTo0gTp3LdrG2oYfFCBLhHYPdl2XH8+CiG2QqoR6MoNmXqCdICamlaDFTIS
	xtB1Ytoo9aImvA7f3rXGlNhl29b0KswMCk7D1klv/PnNVbHr06VkGpXIHIPoOiAfY3ZluiMDPgz
	dwimA21CE7oMKY+KOplHTOFpQL3ooVmWWgVXg87QD4sAsl6jCzf2e9hjFV2fGUsHG3EHRwsmFWX
	shb3tAlPfJg8MHnHL0519N96Y05Qk3dsnAXy9S8VKmdl9QEo+rNM/oUTk1oL5UKGGqW2U5p2E9c
	SPanMrfBbnUWYqTOO9NxVhnuLTfrCO1xVPvWiWNfSFArwhE++v/z3Xq+xslW5njAtOEJMz+RDJr
	+JSgJiI8lbbRcN/+uR9044Szw7
X-Received: by 2002:a17:902:e5ca:b0:2c0:fa52:1c47 with SMTP id d9443c01a7336-2c1ec906ca3mr146009545ad.25.1780950693780;
        Mon, 08 Jun 2026 13:31:33 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:e::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f8429fsm235533945ad.18.2026.06.08.13.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:31:33 -0700 (PDT)
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
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: horms@kernel.org,
	Joe Damato <joe@dama.to>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net] bnxt: fix head underflow on XDP head-grow
Date: Mon,  8 Jun 2026 13:31:28 -0700
Message-ID: <20260608203129.920104-1-joe@dama.to>
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

The problem with this expression is that in page mode rx_offset is:

  bp->rx_offset = NET_IP_ALIGN + XDP_PACKET_HEADROOM;

Which evaluates (at least on x86_64) to 258.

The test test_xdp_native_adjst_head_grow_data tests a case where the
head is adjusted by -256.

When this test runs, data_ptr is shifted to frag_start + 2 (where
frag_start = page_address(page) + offset).

Then, bnxt_rx_multi_page_skb is invoked and the napi_build_skb
expression subtracts 258, landing at an address before frag_start. This
could be either the previous fragment or the previous physical page when
the frag_offset is < 256 (e.g. if the fragment started at offset 0).

When the skb is freed, the page pool fragment reference is dropped on
either the wrong page or the wrong frag of the right page. In either
case, the corrupted reference count can lead to the page being
prematurely recycled while still in use. Once (incorrectly) recycled, it
can be handed out again and on driver teardown this would result in a
double free.

The commit under fixes updated this code to handle the case where the
native page size is >= 64k, but it unintentionally broke the head grow
case.

To fix this, we need to do a bit of math to recover the offset if this
is a page fragment since it is not passed into rx_skb_func
(bnxt_rx_multi_page_skb, in this case).

Once the offset is recovered, build the skb at the start of the fragment
and then use skb_reserve to adjust the layout.

There are two cases, the non-adjustment case and the adjustment case.

In both cases, the skb is built at page_address(page) + frag_offset to
account for the case where the native page size >= 64K and skb_reserve
is called with data_ptr - (page_address(page) + frag_offset). That
difference equals bp->rx_offset when data_ptr was not moved, or
bp->rx_offset + xdp_adjust when XDP adjusted the head.

Re-running the failing test with this commit applied causes the test to
run successfully to completion.

The other rx_skb_func implementations don't have this issue.

Fixes: f6974b4c2d8e ("bnxt_en: Fix page pool logic for page size >= 64K")
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 35e1f8f663c7..448609cc1617 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1174,7 +1174,9 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
 	unsigned int len = offset_and_len & 0xffff;
 	struct page *page = data;
 	u16 prod = rxr->rx_prod;
+	unsigned int frag_off;
 	struct sk_buff *skb;
+	void *frag_start;
 	int err;
 
 	err = bnxt_alloc_rx_data(bp, rxr, prod, GFP_ATOMIC);
@@ -1185,13 +1187,15 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
 	dma_addr -= bp->rx_dma_offset;
 	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, rxr->rx_page_size,
 				bp->rx_dir);
-	skb = napi_build_skb(data_ptr - bp->rx_offset, rxr->rx_page_size);
+	frag_off = dma_addr - page_pool_get_dma_addr(page);
+	frag_start = page_address(page) + frag_off;
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

base-commit: 9772589b57e44aedc240211c5c3f7a684a034d3a
-- 
2.53.0-Meta

