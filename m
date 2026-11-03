Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696710;
	b=5iCDzPPyUUuwV6A0sQi3BtsON/p5wT7m2sGClNPkaVCtNmp9nI9xGFahOxXL7SL0C15l
	 mJqgr7WA3oqaIQiMH0SsUemOVSLjlK4GHIX4g4tGVugBDOg83W8RWZ6QrrG+q+GGBtiSM
	 q/ZVsGrjrDfLOKUld8wWhhaNs6+23/62sxBqguYPTabOylxoL6F8qAjsEIgiLYNJnOKQy
	 Yw1Mae0aqmN8H8DZmSTOVWvUBbsyoOZ9KtQMGeU4rpYd9ADpt04PEAAdBlFcDAwgUSq89
	 VPemtmY5Q9MJQPu5lxuMc7SxRMWIwsQxk5pJMoH3KNay18bcep07B5e6VtvE39GLgog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696710;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=ELsL0x7qBytlZgP42ggxXZDWX3Lx3FRVsRzrdJlITNU=;
	b=gAwvouCftCTUvHaknzERjLeeEyA3ixs4T0dhjozaROo5Qfv0DwmHQb+ElPxzLJkwAp2y
	 9oQuaDyESDIFleHBDgiLRJf/3BSwcq9MoWOm7HdnNGKrTC6GUwSeL9Jy79i4dPFAjxc7c
	 9yjomGdjVwsJHyOwFPoKNzerWDMpmmon2CVF0CFrelC+PAew0x+RUUJN/0Yl+GKZClkTK
	 7tJd1XbSpKclX9LYTLFiOFhXOCVsiIVom2X/WNqPtUXtIrC8xq57OadJgSZbDF9NdWxDh
	 Wp4tNyJeDf+39mhge8CU3+KVVgQnhVhxwzblWUHFp+43QyXchR0leheqPE2dLInl6Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=D6LleYEk;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1371F606A327;
	Tue,  3 Nov 2026 09:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1371F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=D6LleYEk
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6EEDAA1643;
	Tue, 03 Nov 2026 10:04:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1793696699; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ELsL0x7qBytlZgP42ggxXZDWX3Lx3FRVsRzrdJlITNU=;
	b=D6LleYEk8UR4/zsyHkwNJxtbFKPqhLNOuZdLo+PkIcQklWkBhyWie03oIH321xLsR96e87
	XJ96XX6NwJM4FHqJNavDmgefmkiYd/eEHJ/r7gvXutlAMa/z0YsFsdaAWSHTJppSzxCigN
	jIJWiRP3AXYsb1hD7H+ZhivpPphH8TaRn/KAduQuABL+GNoqk2WzH8V40HiIm9dTJqLnYU
	UO0NIiPksUApshlc6T/YxcvAHzYBywV7j5EBAys77Ws374rlcfsfKTVvKwQVhRnyjoEaIB
	VR7Q3NrKLVcKNXtMHSkvbWqVMkS/UYzdZECstP9akU/3GhNK0EI00aRX6tLAVg==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 03 Nov 2026 10:04:49 +0100
Subject: [PATCH net v2] octeontx2-pf: fix XDP frames freed as skbs on
 interface down
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
Message-Id: <20261103-nb-otx2-xdp-cqe-cleanup-net-v2-1-5430545c9cbc@tipi-net.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Oyw6CMBBFf4XM2jHT8pC48j8MC2hHqTGltoVgC
 P9ugb3Le+fk3FkgsDcc4Jot4HkywQw2BXnKQPWtfTIanTJIkpUgWaPtcIizxFk7VB9G9ebWjg4
 tRyxrQbogFjonSAbn+WHm3X6HBEBzlGHsXqzi5t2w3oQ4+O/+wyR2+JjL6e/cJFDgRVCVl4oeJ
 RW3aJzZTmfN0Kzr+gP8/kfT3wAAAA==
X-Change-ID: 20261028-nb-otx2-xdp-cqe-cleanup-net-5810d40e1d30
To: Sunil Goutham <sgoutham@marvell.com>, 
 Geetha sowjanya <gakula@marvell.com>, 
 Ratheesh Kannoth <rkannoth@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Suman Ghosh <sumang@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Daniel Machon <daniel.machon@microchip.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

On interface down, the TX completion cleanup also runs on the XDP
queues, but treats the pending xdp_frames as skbs. Freeing them with
dev_kfree_skb_any() corrupts page pool memory. AF_XDP TX completions
in these queues were never reported to the socket either.

This happens when XDP_TX or redirected packets are still in flight on
ifdown, or when the XDP program is replaced.

Fixes: 94c80f748873 ("octeontx2-pf: use xdp_return_frame() to free xdp buffers")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Pre-existing bug, flagged by the clashiko review of my ipsec transmit
fixes for this driver [1], which seems reasonable (and fixable) to me.

The other pre-existing findings there (e.g. the SA lifetime in
cn10k_ipsec_del_state()) may be worth fixing too, but I'll leave those
to the maintainers.

Compile-tested only, I have no octeontx2 hardware.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027-nb-otx2-ipsec-tx-fixes-net-v1-0-2114c4f10c36%40tipi-net.de
---
Changes in v2:
- Report AF_XDP TX completions with xsk_tx_completed() (Daniel, sashiko)
- Link to v1: https://patch.msgid.link/20261030-nb-otx2-xdp-cqe-cleanup-net-v1-1-710635c0f504@tipi-net.de
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 90af9b9044aa0..b038bb1451949 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -1332,6 +1332,7 @@ void otx2_cleanup_tx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq)
 	struct nix_cqe_tx_s *cqe;
 	struct netdev_queue *txq;
 	int processed_cqe = 0;
+	int xsk_frames = 0;
 	struct sg_list *sg;
 	int qidx;
 
@@ -1348,6 +1349,10 @@ void otx2_cleanup_tx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq)
 
 		if (!cqe)
 			continue;
+		if (cq->cq_type == CQ_XDP) {
+			otx2_xdp_snd_pkt_handler(pfvf, sq, cqe, &xsk_frames);
+			continue;
+		}
 		sg = &sq->sg[cqe->comp.sqe_id];
 		skb = (struct sk_buff *)sg->skb;
 		if (skb) {
@@ -1359,6 +1364,9 @@ void otx2_cleanup_tx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq)
 		}
 	}
 
+	if (xsk_frames && sq->xsk_pool)
+		xsk_tx_completed(sq->xsk_pool, xsk_frames);
+
 	if (likely(tx_pkts)) {
 		if (qidx >= pfvf->hw.tx_queues)
 			qidx -= pfvf->hw.xdp_queues;

---
base-commit: c3e67bd82b9b9b1a5118f09a429ccefe2aab0741
change-id: 20261028-nb-otx2-xdp-cqe-cleanup-net-5810d40e1d30

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

