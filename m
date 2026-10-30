Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793391154;
	b=jPQ3Zko/NBIJioeQBWjfGGbMRbvKE+K2d8xdZc2QNaHpcfpxvxD9i16Wq/hB7D1u4vTQ
	 s/LEmzIkinYxTBOw54+ONkic+KyDgtWlrwCHnA9VyyLr0b7pqZyj6VoiL9t0OUD+SXu3V
	 GoZkM/epbDoXOeLrM/v1u82ON4mScppFLpMJss0+pu5Xoi/V89XdUzqdm8161godAgPHK
	 Tx/Wy3EYcHTMC6e4+B5b0CUgv2Fqd+EOAyV70zCMf0FGA47YqzVEsXJ/1rWzf6e1bqcFc
	 gvRK/zsSB6z95R5KfA6eS4DprUSqVKbZxSpUJkLo+P/TMMaIutiqwm2+1pSj2FWxcdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793391154;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=f/EQ4RTL5ZaofeX+YVVBXEXZZ41Q19YQIBhtCHASxOM=;
	b=PrchOWu6P8KJNtS7Fc5uKJoUkBWcm3jJfBrYeRthNHZASPWC3LBwR9HuNlyqDEPM/IIN
	 mt53cFp7BKTlYCjeV6gy5kB41ewenk2JQjkjqI5ce+FeJG78joAV8gmidkpaF/R/S6rqW
	 x4IZCU4OHff078ghv48dDS3uqfPNy3lg95VFIHDnMcsksepePjeS4/FCJCrU4FrCiZ2Xq
	 XPuxOEV7qBOO8G+0ytZNgkolk8JLzRGVrdt6zqAS56btTwiijBI0L067gKju7+fJPYQev
	 iiioby3G32Aid0Lx/FlJ1N/3aAyYS/Y4f/Z2p9BA8R+MKbXl1cCR9NbtxZlCJBpHbkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=Z8OPLDjq;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C44606A326;
	Fri, 30 Oct 2026 20:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15C44606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=Z8OPLDjq
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CDAE9A1579;
	Fri, 30 Oct 2026 21:12:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1793391150; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=f/EQ4RTL5ZaofeX+YVVBXEXZZ41Q19YQIBhtCHASxOM=;
	b=Z8OPLDjqD4THolW8m69iOqwWZ10KH3uaPNX5f4GJ2JzC3e9G2tqC0kYky2SW8OQDQZQreS
	Uc2NfypAXgRpmsnT2cec7Z1g+wZ1xSWRIjdd34LUeEusNAwIKbdV4/Jf/cpdE2nTycicrA
	U/4CovaMqVddZ+8QRVnB0xUtK5xkv02y49QfD60Gcb8e0Mjbmqrh/FcKkiE59+yBHKw4wE
	a2lH81G/RddNm9YlCtbKRj1PjbR1sOmZMFa7DMWKr/yMR7x1qrZyGn6L9gwTzCwMXDlZdx
	e/fKMwL71qDezNCBoxcyF3zbGEr6Kpe2NFN+Zx/qt4ZURlYCgg0k6vjcordkoA==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Fri, 30 Oct 2026 21:12:03 +0100
Subject: [PATCH net] octeontx2-pf: fix XDP frames freed as skbs on
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
Message-Id: <20261030-nb-otx2-xdp-cqe-cleanup-net-v1-1-710635c0f504@tipi-net.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM2wrCMBCE4Vcpe+1CEg8UX0W8aJNRV2Qbk7QES
 t/dqJf/MHwrZSRBpnO3UsIiWSZtYXcd+cegd7CE1uSMO1njetaRp1Id1xDZv8H+hUHnyIrCx96
 acDCwYW+oCTHhJvWnX6gd6Pof8zw+4cvXpW37AKG1UmyEAAAA
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
 bpf@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

On interface down, the TX completion cleanup also runs on the XDP
queues, but treats the pending xdp_frames as skbs. Freeing them with
dev_kfree_skb_any() corrupts page pool memory.

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
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 90af9b9044aa0..e3b07e5335fb8 100644
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

---
base-commit: d8a4f4c59da52b7c31ae337243b8473a19a3f819
change-id: 20261028-nb-otx2-xdp-cqe-cleanup-net-5810d40e1d30

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

