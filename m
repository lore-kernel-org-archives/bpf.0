Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A423AFCE8;
	Wed, 20 May 2026 08:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264847; cv=none; b=VwoK2RD/aP8Ydt5RfwTzPzppvzG8KsiVmBlQSI6+pAuCyZC8r3XWz8EfSFxTSAYGy8WQYxSxHqA8E2tHkszZwnh6SHr7FjSkz/1m9EBEDcRL/1idQWuuu14Pd8caeDRPPMC4efh4d1V8Xi3Futeod2fxMg/Tr6QP2vuezUbH6dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264847; c=relaxed/simple;
	bh=EDw2BFUuUKmnY7vXM3KNgnA7TAgDYmQg1lhPInRD5kg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=H68L4p6x9LKJEhkLcyZjlldidN1HsPosvJWJQG5lwwZwa+ediybLPm34DwRQOHXDEjqdBB3x0WW/EzgDki5cRSsC6gMQHjtkVFsUu4lhIwBZaqxswts5QiGUdncjAnBnZIIUNx3nmPfZNq7S0WFj+P2yBlHl57qp4AP2RTHKFTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sCP/mtvf; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sCP/mtvf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1779264846; x=1810800846;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=EDw2BFUuUKmnY7vXM3KNgnA7TAgDYmQg1lhPInRD5kg=;
  b=sCP/mtvf2qJycw2V1zrMd28Z8Z4Gos52gHJ4vrlNCc0S4Wdz4m4ImZ99
   2Ub/2MJpfkm6bilEncjs+Ur431hbdY6TqxSAScKjnFO6fKfRRirbGXIET
   QXUGHYz0qfitWc/Oz5YFn3/hCWLqsH9gPpA+EdQ99VcRRqhYSTeNuVl43
   mjzbC0ay3XSljcX7A+DhiWRigb5CrGxIPMzZbbu6S9bfphM1Kof9TFMGX
   R3ttEKBgZ63Js6XcpWBwxf4HheoWkaB7nRNsnh1SOmW7ps7lNojcsaie8
   X/Ssfl0Mw0FvBnmYmiqapzapObFWm4PdvIQI9LQIK1/5e/nUyr98QS9Ed
   Q==;
X-CSE-ConnectionGUID: 9R2CU3g7QuOjflpN/O2Iaw==
X-CSE-MsgGUID: CVEY3i8CSIGZJVV1/4GNuA==
X-IronPort-AV: E=Sophos;i="6.23,243,1770620400"; 
   d="scan'208";a="225027567"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 01:14:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Wed, 20 May 2026 01:14:01 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 20 May 2026 01:13:57 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 20 May 2026 10:12:14 +0200
Subject: [PATCH net-next v5 02/13] net: microchip: fdma: rename contiguous
 dataptr helpers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260520-lan966x-pci-fdma-v5-2-ca56197ae05b@microchip.com>
References: <20260520-lan966x-pci-fdma-v5-0-ca56197ae05b@microchip.com>
In-Reply-To: <20260520-lan966x-pci-fdma-v5-0-ca56197ae05b@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Steen Hegelund
	<steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Herve
 Codina <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Mohsin Bashir
	<mohsin.bashr@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14.3

When the FDMA library was introduced [1], two helpers to get the DMA and
virtual address of a DCB, in contiguous memory, were added. These
helpers have had no callers until this series. I found the naming I
initially used confusing and inconsistent.

Rename fdma_dataptr_get_contiguous() and
fdma_dataptr_virt_get_contiguous() to fdma_dataptr_dma_addr_contiguous()
and fdma_dataptr_virt_addr_contiguous(). This makes the pair symmetric
and clarifies what type of address each returns.

[1]: commit 30e48a75df9c ("net: microchip: add FDMA library")

Tested-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/fdma/fdma_api.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/fdma/fdma_api.h b/drivers/net/ethernet/microchip/fdma/fdma_api.h
index d91affe8bd98..94f1a6596097 100644
--- a/drivers/net/ethernet/microchip/fdma/fdma_api.h
+++ b/drivers/net/ethernet/microchip/fdma/fdma_api.h
@@ -197,8 +197,9 @@ static inline int fdma_nextptr_cb(struct fdma *fdma, int dcb_idx, u64 *nextptr)
  * if the dataptr addresses and DCB's are in contiguous memory and the driver
  * supports XDP.
  */
-static inline u64 fdma_dataptr_get_contiguous(struct fdma *fdma, int dcb_idx,
-					      int db_idx)
+static inline u64 fdma_dataptr_dma_addr_contiguous(struct fdma *fdma,
+						   int dcb_idx,
+						   int db_idx)
 {
 	return fdma->dma + (sizeof(struct fdma_dcb) * fdma->n_dcbs) +
 	       (dcb_idx * fdma->n_dbs + db_idx) * fdma->db_size +
@@ -209,8 +210,8 @@ static inline u64 fdma_dataptr_get_contiguous(struct fdma *fdma, int dcb_idx,
  * applicable if the dataptr addresses and DCB's are in contiguous memory and
  * the driver supports XDP.
  */
-static inline void *fdma_dataptr_virt_get_contiguous(struct fdma *fdma,
-						     int dcb_idx, int db_idx)
+static inline void *fdma_dataptr_virt_addr_contiguous(struct fdma *fdma,
+						      int dcb_idx, int db_idx)
 {
 	return (u8 *)fdma->dcbs + (sizeof(struct fdma_dcb) * fdma->n_dcbs) +
 	       (dcb_idx * fdma->n_dbs + db_idx) * fdma->db_size +

-- 
2.34.1

