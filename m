Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793274483;
	b=HC762M/pNEHvBdriG+oHdvyF/UnR278fioTJ6xvx3jMPy7fpB1TnwOcagDG8BAtZGqss
	 C/mLn8jNgUu3cL+FQ2yKHB6SC9O9O3maF27ZeckyHFwNnXASAZ1WCYj0MfsZurf/ELDeT
	 1S+7GDS3kL+x46/6HUhM/DfPRmU3RuKj8W+jNTN1Ni3LyhhgbQEUtRLIoKIiyo7m1Wc6M
	 3KhLfJdFizaYgHPVtt4JOHdJetZHLYQVTRTpoQUktG/1OiITr/nPfAMV+w5FuvgCEkJLq
	 MQaDDC7ogfOLZCou+bJW6E3aJwVYmJ2wYIQCuxlDSBJDl+7UXJWF7/5ZCZWtgX93T5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793274483;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer;
	bh=8WIvmGqTPvXreaFe6W/vbeDDH/omFOsI/edvs3rYRbI=;
	b=clHUmvkYnQJkwcKRo4m7Z+oJLkTqGWAOGOYJfghyzi4oyTLgyeRSpH9Oe39U2csMwyov
	 5lTFhrBuaWH3bkiBUTvlhX0hMNqLABvrmPdOMuwrLWlOAKGP7QQ/RUJcqQfWFc9KIqtzN
	 7cLDNpNiOBlauDTAyI6ojRDcQCif/bylF32a+zSrJqr/VSeGyBR0deJKuKJ/wNTjn/dq9
	 OcPHbHFm+wQQYUEqJj2d+oqqqSfFcOeNBl+sofQGrx8plhFSSqdGgLZduzvnWtTqI1RQa
	 Z7e9akuaZ4hKreDJA5wEW7Aha55eIQWVJg/p9WNl85b2jIOk1kzVpvNeFmj9VvnGBXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=u03CH9Y+;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D7D606A31A;
	Thu, 29 Oct 2026 11:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08D7D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=u03CH9Y+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793274484; x=1824810484;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=OkcEfyAxMzYgj1tah1rk3PFLgewubHZQCw5aaRuDbp0=;
  b=u03CH9Y+xA10Hl39Vf7zVjZ7H5MT/CxNJ00t8BrGWwMC6eLY5aw54g+8
   Av4F6WZQAzFRG3OF4eU1FRS9qiTLXyW6qYv64RZQqtnFYQ+hogyo3KaH5
   XX3JSZwTMbfkTYZ7LXyb7wA2JrIZ/u/dz3BoMtKx3FLRR0FU//zCzd7Ij
   aUi5mLaywWRDaP4KAG4uFgwaKy8Ogj70854CEAdyuKh9c2icfaPfvQOuU
   qp574FszdKhgIC5gWYvbqHTkJscznC8ejFK9GdB+LnI2Kjhf76MaL1GGi
   HiOcKR7Hfhae0A1Vu0tU6wJBvVWo8exXrGpxvlxXZMhpc5yBYqPc48eyn
   Q==;
X-CSE-ConnectionGUID: VISypm3DT5GtS/pqlebFdA==
X-CSE-MsgGUID: Njsw9srHQZyxWkZ+PCj9BQ==
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="297149636"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 04:48:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 29 Oct 2026 04:48:01 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 29 Oct 2026 04:47:59 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 29 Oct 2026 12:47:47 +0100
Subject: [PATCH net] net: lan966x: don't free XDP buffers in fdma tx clear
 with budget 0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261029-lan966x-fdma-tx-clear-budget-v1-1-38c52d7aab8c@microchip.com>
X-B4-Tracking: v=1; b=H4sIAGIy42oC/x3MwQqFIBBA0V+JWTeQQlLvV6LFmFMNlC/UQoj+P
 Wl54HJviByEI/yqGwJfEuXvC1RdwbSSXxjFFYNutFGN7nAj3xuTcXY7Yco4bUwB7ekWTth2LZG
 zJbAKyuIIPEv+9gN4TjA+zwt2edJxcwAAAA==
X-Change-ID: 20261028-lan966x-fdma-tx-clear-budget-585aadb966b1
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
X-Mailer: b4 0.14.3

lan966x_fdma_tx_clear_buf() runs from the NAPI poll and frees the
buffers of completed tx DCBs with napi_consume_skb(),
page_pool_recycle_direct() and xdp_return_frame_bulk().

netpoll calls the NAPI poll with a budget of 0 and hardirqs disabled.
With a budget of 0, a driver cannot call any XDP or page pool API.

Before this patch, the XDP_TX pages and ndo_xdp_xmit frames are freed
regardless of the budget. With netconsole on the port that owns the
FDMA NAPI, such a buffer is freed with hardirqs disabled, and
__page_pool_put_page() warns via lockdep_assert_no_hardirq().

Leave the XDP buffers of completed DCBs in place when the budget is 0,
and free them in the next NAPI poll. napi_consume_skb() already handles
a budget of 0, so skbs are still freed.

Found by an AI code review agent. Reproduced on a lan9668 board with a
modified kernel that runs the NAPI poll with a budget of 0 and hardirqs
disabled. With the fix the warning is gone.

Fixes: 19c6f534f636 ("net: lan966x: Add support for XDP_TX")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 21668bbcc9063..1fbe910c5ec38 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -353,6 +353,12 @@ static void lan966x_fdma_tx_clear_buf(struct lan966x *lan966x, int weight)
 		if (!fdma_db_is_done(db))
 			continue;
 
+		/* XDP and page pool APIs can't be used with a budget of 0.
+		 * Leave these buffers for the next NAPI poll.
+		 */
+		if (!weight && !dcb_buf->use_skb)
+			continue;
+
 		dcb_buf->dev->stats.tx_packets++;
 		dcb_buf->dev->stats.tx_bytes += dcb_buf->len;
 

---
base-commit: 829a09df899dcce860dcf5f70e09c1b2d7d425ab
change-id: 20261028-lan966x-fdma-tx-clear-budget-585aadb966b1

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>

