Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793022408;
	b=y2RLi2qq0nqx9aHv3AHeBZ3JvLGvDhav7Jqg8Ray4lXV8qTJyYs+L42o3CeQfUUHqjNF
	 kKUEuFOhuI4t0v4vvWSIK0OVXrRuz3MlaGYsn+YjFMEE6uvtiR7jP/45IdWWXR22bEdGA
	 zXHYI/AXUhqq+PozbOwhrQ570dLQWFvIgtEN/WjCBYO21VzeL+3m60/4BuXcWRt8XykEa
	 ICgZjwZZP5HcTE7ss/9EohtrNdOOeQdh5X0zIx/asaWMeNk0GAt/G94KyUWh+ONMUcQPN
	 3k7EZNRrUtPuZOlW47+90NQ/+q9o+dpQLDHBuMLuW3HtuFxHZfybmzcgD+ISh0n7VdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022408;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer;
	bh=rPticPiLc3pCUn/0LDVPtmHtdlDPQ08+ktThrCe8zzA=;
	b=GKnIKvPLU8RPtuFW1SbD292+yvTSHxSJWrvLMAJWi2GqOCE+g1zOwUrE/52PKAYjz1w2
	 FVsTLEdN63DbNdmWyfgPbir6AJb9uA1oQG/JsQEWZs4X+Wm7KLTp9BGpmUwcyCu7HkKaF
	 Y20elwJq8/yTM4JF/Fq28tOX7sZ7YpZNElGQYixZjmehx/4R+iKcpHzIi+CWFanlLnn6D
	 TJe8CML3Or6yXcT+NP1B4SsVFqiZDbkW8IQVg19vs4vdSLtucjdFC9uKVOZvioWEjecvr
	 Fu1JRCVh8f6ZYVRTaXRHMxOJ/3WAW0eGLVgTp1aeYjl42As5JhBRVHtjrCaO3lvzu3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=UEuiWBP5;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3B4606A328;
	Mon, 26 Oct 2026 13:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E3B4606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=UEuiWBP5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793022408; x=1824558408;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=/KcO045JT01u3I/kXvlahPmG41Mc678leFr4DDSet04=;
  b=UEuiWBP5ApL8Ut/1I1857wQi+SD/a9yKr6/z5Mmy1c34c+glhjdQjstJ
   vXmnQNWUHe9JMTmg2o3qkwkAdWOsis9p5BNebs9M/D5MlY+t3riKh+Lv3
   PAVeTlvXzT0+LAweKRV9a/+bDeCKgp3b0TsEPP/jPJFO2GXQO7KgJIv6q
   0hZ/9eAdEO2BPWUE+sG4HA25zwGJpi+zWp8TCZBJ0fa6dbJk0INRUWP6I
   BRfSskU2214oENZuxL2WggpsMdIfH3DgyhwHK6YVGzUnygr/kWw6IvRAH
   nJTCfIq9ZCrZrgJG6zPtCcJh/azZFzESxAaegvtW4vrRXIz6+s5XgGFZB
   A==;
X-CSE-ConnectionGUID: 5CF51qDfQ+2dIdLlRmS61Q==
X-CSE-MsgGUID: jBm1vDtITHOWoDsRL38gUw==
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="232637425"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 06:46:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Mon, 26 Oct 2026 06:46:47 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 26 Oct 2026 06:46:44 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 26 Oct 2026 14:46:39 +0100
Subject: [PATCH net] net: lan966x: fix the DB dataptr of frames from
 ndo_xdp_xmit
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
Message-ID: <20261026-lan966x-xdp-xmit-dataptr-v1-1-d0dd068324de@microchip.com>
X-B4-Tracking: v=1; b=H4sIAL5Z32oC/x3MwQqEIBCA4VeJOTdgxkr1KtFhzNltoExUQojeP
 dnjd/j/GxJH4QRTc0PkS5KcvqJrG1g38j9GcdWglTad0j3u5EdjChYXsByS0VGmkCNaRcwfY1d
 nB6h5iPyV8l/P4DnD8jwv8uOvwW8AAAA=
X-Change-ID: 20261023-lan966x-xdp-xmit-dataptr-b0aee56bcdb8
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

lan966x_fdma_xmit_xdpf() transmits both XDP_TX frames and xdp_frames
from ndo_xdp_xmit, and builds the DB with
lan966x_fdma_xdp_tx_dataptr_cb(), which adds XDP_PACKET_HEADROOM to the
stored DMA address.

Before this patch, the headroom is also added for xdp_frames. For
XDP_TX the stored address is the start of the page pool page, but for an
xdp_frame it is the mapping of the IFH placed in front of the frame
data, so frames from ndo_xdp_xmit are read from XDP_PACKET_HEADROOM
bytes after their IFH.

Use the plain tx dataptr callback for xdp_frames.

Found by an AI code review agent. Reproduced on a lan9668 board with an
XDP program redirecting frames from one port to another: none of the 20
frames arrived intact on the link partner. With the fix all 20 did.

Fixes: 29cc3a66a81d ("net: lan966x: use FDMA library for adding DCB's in the tx path")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index a7940eca5df31..8ea86b800af75 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -686,7 +686,8 @@ int lan966x_fdma_xmit_xdpf(struct lan966x_port *port, void *ptr, u32 len)
 		       FDMA_DCB_STATUS_BLOCKO(0) |
 		       FDMA_DCB_STATUS_BLOCKL(next_dcb_buf->len),
 		       &fdma_nextptr_cb,
-		       &lan966x_fdma_xdp_tx_dataptr_cb);
+		       len ? &lan966x_fdma_xdp_tx_dataptr_cb :
+			     &lan966x_fdma_tx_dataptr_cb);
 
 	/* Start the transmission */
 	lan966x_fdma_tx_start(tx);

---
base-commit: 6430fb7f1cc4e329e386521b7b208df443de92f2
change-id: 20261023-lan966x-xdp-xmit-dataptr-b0aee56bcdb8

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>

