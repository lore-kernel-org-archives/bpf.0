Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F09463B74;
	Thu, 24 Sep 2026 19:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790279848; cv=none; b=liya1fxX4AyPq17W/5BrSH/ZUhglaKvrXm2plX/wmNviDUd7OjvfX09DzWGNrmNt6R4+vSuBiuxKlm9FSDwLPe7w4o1oQv2B50y2yVjkgoo5i3dVoZf3oCUKi9iNf2UAT86Xkvk5mVotHGfDMlcwi+5xli4s6/T9WRHkvywgC2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790279848; c=relaxed/simple;
	bh=FF6QRWvolzsP0sTH1U6d+Yj1wY9euWyqxEoL/O8e+/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=HykDEemMpj9RDnJCJUrbCBfQF9H4Ld4B11pyg/Y/St82NaJ2+ECVkNXuyi7OlxfJKLm3dB8JRB3qyHN7p6IuUVOm4C7wbjRC8sqJLmGMw9+JthG3NJORmjkS3+uMCT4FOHcLrP/dTxqa8zet0UDeWS/pmozhY9azhtrRy9YhJZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ovA/LMK4; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ovA/LMK4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790279848; x=1821815848;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=FF6QRWvolzsP0sTH1U6d+Yj1wY9euWyqxEoL/O8e+/o=;
  b=ovA/LMK4bUA/cRAuInmLRyUKIRBLf08B9XGvqNrVNtxVVNumjAAKt8zq
   c/WUMVN9g5of1tHJ0JPlN+ORKfeqYFxbTz+KU6QViPUifgrTnxfCGxLYt
   TdqdeJP0FImW+f1X9Iv/Bhjrb60chziu3c/Gp9AI+6LPDGng3ld1bp0LF
   8aZURjmxJr5cfLI02IEzqxxtH2/a80eMaod3KXMlvTc/DpCfE3qwJi+Uj
   FFSpGhS3dnMsikGO/yxYh13x0l0Ap+mFuNVnZ8DmL8oEQMeHUHCf6UJRy
   0str30E2k2pK4aWsIPoRCwacJ232ZrhdTuwFILVdyJmnu0FBKbTy7AT9J
   A==;
X-CSE-ConnectionGUID: Eq/m5JzJQHSqE+mU6Q3qsw==
X-CSE-MsgGUID: YAAkedm5Tpy/Q2GINru/Jw==
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="74257250"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 12:57:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Thu, 24 Sep 2026 12:57:18 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 24 Sep 2026 12:57:14 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 24 Sep 2026 21:56:52 +0200
Subject: [PATCH net-next v8 04/15] net: microchip: fdma: use little-endian
 types for descriptor fields
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260924-lan966x-pci-fdma-v8-4-201c7b707d8b@microchip.com>
References: <20260924-lan966x-pci-fdma-v8-0-201c7b707d8b@microchip.com>
In-Reply-To: <20260924-lan966x-pci-fdma-v8-0-201c7b707d8b@microchip.com>
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
	<mohsin.bashr@gmail.com>, "Simon Horman" <horms@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14.3

The FDMA engine reads and writes the DCB and DB descriptors in
little-endian byte order. So far the descriptors have only been produced
by the little-endian SoC itself, so plain u64 fields were fine. With the
PCIe FDMA path, the descriptors live in host memory and are written by
the host CPU, which may be big-endian.

Change the descriptor fields to __le64 and convert at the library
boundary: in __fdma_db_add() and __fdma_dcb_add() on write, and in the
fdma_db_*() accessors on read. The dataptr and nextptr callbacks keep
their u64 signatures, so their implementations are unchanged. Add
fdma_db_dataptr_get(), and convert the lan966x sites that read the
descriptor fields directly to use the accessors.

No functional change on little-endian hosts.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/fdma/fdma_api.c      | 21 ++++++++++++++++-----
 drivers/net/ethernet/microchip/fdma/fdma_api.h      | 20 +++++++++++++-------
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c   |  9 +++++----
 3 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/microchip/fdma/fdma_api.c b/drivers/net/ethernet/microchip/fdma/fdma_api.c
index a3c9e3097c5c..f7a42348e932 100644
--- a/drivers/net/ethernet/microchip/fdma/fdma_api.c
+++ b/drivers/net/ethernet/microchip/fdma/fdma_api.c
@@ -12,10 +12,18 @@ static int __fdma_db_add(struct fdma *fdma, int dcb_idx, int db_idx, u64 status,
 				   int db_idx, u64 *dataptr))
 {
 	struct fdma_db *db = fdma_db_get(fdma, dcb_idx, db_idx);
+	u64 dataptr;
+	int err;
+
+	db->status = cpu_to_le64(status);
 
-	db->status = status;
+	err = cb(fdma, dcb_idx, db_idx, &dataptr);
+	if (unlikely(err))
+		return err;
 
-	return cb(fdma, dcb_idx, db_idx, &db->dataptr);
+	db->dataptr = cpu_to_le64(dataptr);
+
+	return 0;
 }
 
 /* Add a DB to a DCB, using the callback set in the fdma_ops struct. */
@@ -35,6 +43,7 @@ int __fdma_dcb_add(struct fdma *fdma, int dcb_idx, u64 info, u64 status,
 				u64 *dataptr))
 {
 	struct fdma_dcb *dcb = fdma_dcb_get(fdma, dcb_idx);
+	u64 nextptr;
 	int i, err;
 
 	for (i = 0; i < fdma->n_dbs; i++) {
@@ -43,14 +52,16 @@ int __fdma_dcb_add(struct fdma *fdma, int dcb_idx, u64 info, u64 status,
 			return err;
 	}
 
-	err = dcb_cb(fdma, dcb_idx, &fdma->last_dcb->nextptr);
+	err = dcb_cb(fdma, dcb_idx, &nextptr);
 	if (unlikely(err))
 		return err;
 
+	fdma->last_dcb->nextptr = cpu_to_le64(nextptr);
+
 	fdma->last_dcb = dcb;
 
-	dcb->nextptr = FDMA_DCB_INVALID_DATA;
-	dcb->info = info;
+	dcb->nextptr = cpu_to_le64(FDMA_DCB_INVALID_DATA);
+	dcb->info = cpu_to_le64(info);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/microchip/fdma/fdma_api.h b/drivers/net/ethernet/microchip/fdma/fdma_api.h
index ccc30d506e89..4e4f009b77cb 100644
--- a/drivers/net/ethernet/microchip/fdma/fdma_api.h
+++ b/drivers/net/ethernet/microchip/fdma/fdma_api.h
@@ -66,13 +66,13 @@
 struct fdma;
 
 struct fdma_db {
-	u64 dataptr;
-	u64 status;
+	__le64 dataptr;
+	__le64 status;
 };
 
 struct fdma_dcb {
-	u64 nextptr;
-	u64 info;
+	__le64 nextptr;
+	__le64 info;
 	struct fdma_db db[FDMA_DB_MAX];
 };
 
@@ -147,19 +147,25 @@ static inline bool fdma_dcb_is_reusable(struct fdma *fdma)
 /* Check if the FDMA has marked this DB as done. */
 static inline bool fdma_db_is_done(struct fdma_db *db)
 {
-	return db->status & FDMA_DCB_STATUS_DONE;
+	return le64_to_cpu(db->status) & FDMA_DCB_STATUS_DONE;
 }
 
 /* Get the length of a DB. */
 static inline int fdma_db_len_get(struct fdma_db *db)
 {
-	return FDMA_DCB_STATUS_BLOCKL(db->status);
+	return FDMA_DCB_STATUS_BLOCKL(le64_to_cpu(db->status));
+}
+
+/* Get the dataptr of a DB. */
+static inline u64 fdma_db_dataptr_get(struct fdma_db *db)
+{
+	return le64_to_cpu(db->dataptr);
 }
 
 /* Set the length of a DB. */
 static inline void fdma_dcb_len_set(struct fdma_dcb *dcb, u32 len)
 {
-	dcb->info = FDMA_DCB_INFO_DATAL(len);
+	dcb->info = cpu_to_le64(FDMA_DCB_INFO_DATAL(len));
 }
 
 /* Get a DB by index. */
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 41d4ec7f2f57..68fd454ebc98 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -406,8 +406,9 @@ static int lan966x_fdma_rx_check_frame(struct lan966x_rx *rx, u64 *src_port)
 		return FDMA_ERROR;
 
 	dma_sync_single_for_cpu(lan966x->dev,
-				(dma_addr_t)db->dataptr + XDP_PACKET_HEADROOM,
-				FDMA_DCB_STATUS_BLOCKL(db->status),
+				(dma_addr_t)fdma_db_dataptr_get(db) +
+				XDP_PACKET_HEADROOM,
+				fdma_db_len_get(db),
 				DMA_FROM_DEVICE);
 
 	lan966x_ifh_get_src_port(page_address(page) + XDP_PACKET_HEADROOM,
@@ -419,7 +420,7 @@ static int lan966x_fdma_rx_check_frame(struct lan966x_rx *rx, u64 *src_port)
 	if (!lan966x_xdp_port_present(port))
 		return FDMA_PASS;
 
-	return lan966x_xdp_run(port, page, FDMA_DCB_STATUS_BLOCKL(db->status));
+	return lan966x_xdp_run(port, page, fdma_db_len_get(db));
 }
 
 static struct sk_buff *lan966x_fdma_rx_get_frame(struct lan966x_rx *rx,
@@ -443,7 +444,7 @@ static struct sk_buff *lan966x_fdma_rx_get_frame(struct lan966x_rx *rx,
 	skb_mark_for_recycle(skb);
 
 	skb_reserve(skb, XDP_PACKET_HEADROOM);
-	skb_put(skb, FDMA_DCB_STATUS_BLOCKL(db->status));
+	skb_put(skb, fdma_db_len_get(db));
 
 	lan966x_ifh_get_timestamp(skb->data, &timestamp);
 

-- 
2.34.1

