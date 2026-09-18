Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C40B4973BE;
	Fri, 18 Sep 2026 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731264; cv=none; b=Ia4ZvXknE3Z+r8p/GgcNnYenjJAdWE7PCfOz+OtskzKmAqoFbkF5/r9smoY1RfW0PNVozlcaHeoJ8mwGom/JWQ+wBpqfjh5tXAo7X1QI4DCOeqt8tDSxNqh0A37a9zY2ykRV5uIVBtffQaVaNx8rg3uHMLbiwqLbwGNkRMY94fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731264; c=relaxed/simple;
	bh=Iy12tCl7T6s6ZRBeoiQcoNoKALMADqPH0I/xSE+s2mQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=XUmSxnpkMpeWRQS21yPyokBgo3ImgTy42ahi0O334y0dLRDYkPLL1sn8YPAa6XAra9uIeE0PonUoA/cAJ4dCBITASfRh3nJlOsrbtMYVybSqlcE1G5rpkts2HOo+IPfmNdDrnb10uLE+b0VYYCzmttSIaX65cEfQWIuVeUS5eKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Mj9HHY68; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Mj9HHY68"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789731262; x=1821267262;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Iy12tCl7T6s6ZRBeoiQcoNoKALMADqPH0I/xSE+s2mQ=;
  b=Mj9HHY68JmH2JnG7+RdMJ4PRbGptO3itmtRYztQS6v2iPAOc5/oA4cT7
   9OF3DmYd71aVyby15lJci/XwqrJE3dVnTcRskjO/NWofP+he+lZc71aSH
   XM5yJfaTu8Bio1qlB1iOwkyO4c7qd2GZ3GY7MXbl1DtlqFbKf9rYbsoQw
   XGefZu1FIcb/OKgBnw0DdruWt68AFIIuyryu5xhHICphcZsWq1xdybcgR
   9Al/Yka6Y+MetCC7lg9OfAXb0sRsjntqoMrdl1JlkNSEYTqOJDBmlM9Ry
   rTD+RRka7nxRe4YoUaDHv7J6+iC1O6mX70y4D+0zJhhzSOwEJvmpQ/q94
   Q==;
X-CSE-ConnectionGUID: 8cdT/sOBSWm5lsOZnY2FOQ==
X-CSE-MsgGUID: K7aEDpCZQ8iyJ3x6J6gLDw==
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="64120987"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2026 04:34:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 18 Sep 2026 04:34:19 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 18 Sep 2026 04:34:16 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 18 Sep 2026 13:33:54 +0200
Subject: [PATCH net-next v7 02/14] net: microchip: fdma: rename contiguous
 dataptr helpers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260918-lan966x-pci-fdma-v7-2-0ecc179c8a2c@microchip.com>
References: <20260918-lan966x-pci-fdma-v7-0-0ecc179c8a2c@microchip.com>
In-Reply-To: <20260918-lan966x-pci-fdma-v7-0-0ecc179c8a2c@microchip.com>
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
CC: Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14.3

When the FDMA library was introduced [1], two helpers to get the DMA and
virtual address of a data buffer, in contiguous memory, were added. These
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
 drivers/net/ethernet/microchip/fdma/fdma_api.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/fdma/fdma_api.h b/drivers/net/ethernet/microchip/fdma/fdma_api.h
index d91affe8bd98..dea8e3cc155a 100644
--- a/drivers/net/ethernet/microchip/fdma/fdma_api.h
+++ b/drivers/net/ethernet/microchip/fdma/fdma_api.h
@@ -197,8 +197,8 @@ static inline int fdma_nextptr_cb(struct fdma *fdma, int dcb_idx, u64 *nextptr)
  * if the dataptr addresses and DCB's are in contiguous memory and the driver
  * supports XDP.
  */
-static inline u64 fdma_dataptr_get_contiguous(struct fdma *fdma, int dcb_idx,
-					      int db_idx)
+static inline u64 fdma_dataptr_dma_addr_contiguous(struct fdma *fdma,
+						   int dcb_idx, int db_idx)
 {
 	return fdma->dma + (sizeof(struct fdma_dcb) * fdma->n_dcbs) +
 	       (dcb_idx * fdma->n_dbs + db_idx) * fdma->db_size +
@@ -209,8 +209,8 @@ static inline u64 fdma_dataptr_get_contiguous(struct fdma *fdma, int dcb_idx,
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

