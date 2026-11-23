Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795445685;
	b=VqEcOQ8vOKqEukqTYB4/tRRtri/+ZJeFlysiwkOJ+iqiXNs8CJqd7J++5/88gu1AHoza
	 6EAP1aKETyD0/Vj114M/U4gJR9gjOZWPpd2wpvtQmc3vkjYcwBZei+exthONk1Kgqx4qg
	 qfpPQKiZghSn/NhhdxPL/p4I1tZVeW8I3+ROVodJThIThomKXehHN75v5YU8NttCTV04o
	 CC31WMY4JpVHlsUJH5hOVY8EJ5kNv7RfK2Zwd2mh8xear134Z7MkkcBNM6q+r2j80EjLt
	 6yo9dhsuC/ieZVlykVDmO1sKO/56JhByPVdOQdUg3v/EbnsJHeSRswrIpeQDvw25ZgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795445685;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer;
	bh=0nEfM8+R7e/4HgQIycbOLgNGhqmmppbJ+3L3DiB3oqk=;
	b=Q75kX/IJkqskU5aEI4M7ffgwDwMXRCDljREPs9ZjTD4pRZuvB6+s71zJF0+ppKJh554T
	 WwZoys/RsjpWDOBJcr4+fFjUm/LOcuZpYmgVXExKvHwFnDqsPDZfB4vA8IxF5dya4gT/B
	 BnaR5vR7FWoAeX2xQGdOwv478uQzV7KWBd+B3UTwPwBDjJsYt3Ghz6J+Gd65aMP7sYFX8
	 PD6XMz3TrVEqACS2fDXzKODnPm8td+72M7s3tWf7c+sanii79rq0xL22JwoVkkveaHDOC
	 cruQmE4R092BJrRbFkSAxS24ytUgvsgmIuYT0i+mpTIQfvckmlwB4WSYYJejJ28tTnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=i3JlD3d6;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2793D606B436;
	Mon, 23 Nov 2026 14:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2793D606B436
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=i3JlD3d6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1795445685; x=1826981685;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=BwIwJT8osuJvaJRaDW0YhIQ8yt7vHP664rCa55wPAJw=;
  b=i3JlD3d6S7+9usTAgLrjIVH2Bn5dyWHPEKch+VKtwtc/nuz9FyEEf6pZ
   7BNXeeS+cw7Npdmj/eMBFS6MRqcugZk78d4X/G70AoI0BcyWyM8JqhiSs
   Z9lH1CxdfNwsPsU0Hl19KBf22oaX97YoCvpzj/cBjL2erwU/m0FG+NNDr
   lc2yNkTv17gr5FogaZjUn84UA/4Q+bbNIZ2QXd7K7VV0hmi7XvBzJC71h
   LUV+YMbUrUbsUy29eK2q/3r92QO77Eau5zbDbwGfjQ6sIiIFb7LZKCtsQ
   YkjpeJr4+IgtVTS0zCDOURV9Qq//0ALdCkPj9vFOXcaTsCUVpi7lQy0lz
   Q==;
X-CSE-ConnectionGUID: ccBHRNLNSoiNMgtx35Fx/w==
X-CSE-MsgGUID: y04x1CvDS4etSRviHy7STA==
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="65954576"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2026 07:54:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 23 Nov 2026 07:54:43 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 23 Nov 2026 07:54:40 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 23 Nov 2026 15:54:36 +0100
Subject: [PATCH net] net: lan966x: return an error for XDP frames that are
 not queued
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
Message-ID: <20261123-lan966x-xdp-xmit-errors-v1-1-f25b6661167d@microchip.com>
X-B4-Tracking: v=1; b=H4sIAKtTBGsC/x3MQQqEMBAF0atIr21IIkScqwwuHPPVBo3SkSEg3
 t3g8i2qLkpQQaJPdZHiL0n2WGDrisZliDNYQjE547y1ruF1iJ33mXM4OG9yMlR3TYzQmh+msTU
 BVOpDMUl+z1+KOKm/7we62SqnbgAAAA==
X-Change-ID: 20261123-lan966x-xdp-xmit-errors-ed70befc70de
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
X-Mailer: b4 0.14.3

lan966x_xdp_xmit() counts a frame as transmitted when
lan966x_fdma_xmit_xdpf() returns 0, and its caller only returns the
frames that were not counted.

Before this patch, lan966x_fdma_xmit_xdpf() returns NETDEV_TX_OK, which
is 0, when an xdp_frame has less headroom than the IFH or when its DMA
mapping fails, without queueing the frame. The frame is then counted as
transmitted and never freed. An xdp_frame can have less headroom than
the IFH when an XDP program grows the head of a frame with
bpf_xdp_adjust_head() before redirecting it to a lan966x port.

Return -EINVAL and -ENOMEM in these cases, so that lan966x_xdp_xmit()
stops and the frames that were not queued are returned to the caller.

Found by an AI code review agent. Reproduced on a lan9668 board with an
XDP program that grows the head of each frame and redirects it to
another lan966x port. With the fix the frames are returned to the
caller.

Fixes: a825b611c7c1 ("net: lan966x: Add support for XDP_REDIRECT")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 1fbe910c5ec38..f1b6638d5668d 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -636,7 +636,7 @@ int lan966x_fdma_xmit_xdpf(struct lan966x_port *port, void *ptr, u32 len)
 		xdpf = ptr;
 
 		if (xdpf->headroom < IFH_LEN_BYTES) {
-			ret = NETDEV_TX_OK;
+			ret = -EINVAL;
 			goto out;
 		}
 
@@ -650,7 +650,7 @@ int lan966x_fdma_xmit_xdpf(struct lan966x_port *port, void *ptr, u32 len)
 					  xdpf->len + IFH_LEN_BYTES,
 					  DMA_TO_DEVICE);
 		if (dma_mapping_error(lan966x->dma_dev, dma_addr)) {
-			ret = NETDEV_TX_OK;
+			ret = -ENOMEM;
 			goto out;
 		}
 

---
base-commit: af6737b9066832a2017c281159950ba92385ce00
change-id: 20261123-lan966x-xdp-xmit-errors-ed70befc70de

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>

