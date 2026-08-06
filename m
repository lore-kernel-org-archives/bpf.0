Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE674734E4;
	Thu,  6 Aug 2026 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.149.7.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016724; cv=none; b=F5Sp05I9RVGOnk3DqfAxZqvs/ErHldp7+v6Xto6kpvzIC42XUzRpFe4U9LEU9htVGnHPnvEDW5GKzFPe0LfCTglrR9BwtdgXPQrIao5QXIPFzUvCCH+9Uag6mhTQVDPeDAsAbBrwgdOac4Ngux88KXbSPyTOMuhG3g4Wh80P53M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016724; c=relaxed/simple;
	bh=d24O6RnN4KLijxSodbjGK56n0gVrZlTvumdFgTIzCJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=dklmauvyqME7EXECXzESQ9EAMrkgeCHHUWyLtpdfYOIn8XLbcs2TkZwzA6tGEC4yKk5/es3xQV7YA8GO6dUb2MifVsCKMdNpEes7Xg3SQ35zqlDCarBeidYpn2WloY2YTuJhanijQT0SuvbB13w1b8F2Aowhjqcv/opI6Ji27Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de; spf=pass smtp.mailfrom=tu-berlin.de; dkim=pass (2048-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b=KluoRtLU; arc=none smtp.client-ip=130.149.7.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b="KluoRtLU"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
  d=tu-berlin.de; s=dkim-tub26; t=1786016720;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=EZn5BJEOXSSnGu90KCR+f2o/FUTLoUzl1UtfV8fc91I=;
  b=KluoRtLUKSGeIegv7X2dReErRKGtdZtMbhvLVoLfglYkMQxcN2ixZGt0
   LNDG3PmaZMOwnfCqcFAIptxxgnBMTs+1a1Z+wQkpjg5HuKlZcEJh1ax7H
   QD9I85QrSQ00KTK7tam0kunQfBi0RxDi/jxeMtzmz7FVwD2WM553G60Ma
   aQ/D3P5IIdRw0L5jpaQkeGOtyjRioAHMqR/t9x+Jh4TU+2gFBloZfxrVR
   qCvFg5ac0TwwCmdLFpBNgrQRT9U0f0JnS/+CAXoqQ5bxKsJ3c7T5r/g/x
   JTD5R9MhoNe8EdsKblu5SjDtyrl6jVdlmaqA8rKKO0wcCiygXuEw0vRzZ
   g==;
X-CSE-ConnectionGUID: ma1iL/cPQIufewYdPHAIIQ==
X-CSE-MsgGUID: yHfK270bTticHguczZHYdg==
X-IronPort-AV: E=Sophos;i="6.25,208,1779141600"; 
   d="scan'208";a="50834379"
Received: from bulkmail.tu-berlin.de (HELO mail.tu-berlin.de) ([141.23.12.143])
  by mailrelay.tu-berlin.de with ESMTP; 06 Aug 2026 13:44:06 +0200
From: =?utf-8?q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
Date: Thu, 6 Aug 2026 13:43:49 +0200
Subject: [PATCH net] veth: fix queue index used to wake the peer txq in
 veth_poll
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260806-veth-fix-poll-queue-idx-v1-1-c5357fb7573d@tu-berlin.de>
X-B4-Tracking: v=1; b=H4sIAHRzdGoC/4WNTQ6CMBSEr0Le2mdaEARX3sOwgPYhNaTF/gVDu
 LsFD+Dym3wzs4Ijq8jBLVvBUlROGZ2AnzIQY6efhEomhpzlFatZiZH8iINacDbThO9AYVcWbOT
 l2rCmZ0UhIbVnS8k6lh+gyUP7C13oXyT8vrlro3Le2M/xH/kh/72KHDkWVTnUZZcPXIi7D9iTn
 ZQ+S4J227YvgYqCQdgAAAA=
X-Change-ID: 20260805-veth-fix-poll-queue-idx-9d47909b033d
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Toshiaki Makita
	<toshiaki.makita1@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, =?utf-8?q?Jonas_K=C3=B6ppeler?=
	<j.koeppeler@tu-berlin.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786016645; l=2196;
 i=j.koeppeler@tu-berlin.de; s=20260716; h=from:subject:message-id;
 bh=d24O6RnN4KLijxSodbjGK56n0gVrZlTvumdFgTIzCJc=;
 b=OzIcPDkN7Gd3mVbcgjTRzQjMeu+oAhbLi42mLOeydKlGG3gLEpG4ayFiuvXDS5dYFAOgeKU5p
 BLloL0OAQW6CkTrJqqhaJXVWpmYYxMMtHzNB62+T0aAn8ca225TuA3R
X-Developer-Key: i=j.koeppeler@tu-berlin.de; a=ed25519;
 pk=gCux0rX5l27ZRzRDqTc0LtoO66uPAXTt/SX1DzcQoBk=

veth_poll() derives the index of the peer TX queue to wake from
rq->xdp_rxq.queue_index. That field is only initialized by
xdp_rxq_info_reg() in veth_enable_xdp_range(), which runs only when an
XDP program is attached. On the plain GRO/NAPI path
(veth_napi_enable_range()) xdp_rxq_info_reg() is never called, so
queue_index stays 0 for every queue, as priv->rq is zero-allocated. The
same happens once an XDP program is detached while GRO stays enabled,
since xdp_rxq_info_unreg() clears the struct again.

So in a multi-queue setup with GRO enabled and no XDP program attached,
every NAPI instance looks at the peer's TX queue 0. If veth_xmit() stops
peer TX queue 1 because the ptr_ring is full (NETDEV_TX_BUSY), nothing
ever wakes it again: the poller draining queue 1 wakes queue 0 instead.
veth implements no ndo_tx_timeout, so the netdev watchdog does not kick
in either, and the queue stays stopped indefinitely.

Derive the index from the position of the rq within priv->rq instead,
which is correct regardless of whether XDP was ever enabled.

Scripts to reproduce the stall are available at
https://github.com/netoptimizer/veth-backpressure-performance-testing

Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops")
Signed-off-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
Tested-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 drivers/net/veth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 00e34afd858e..e927ef3f47b3 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -961,7 +961,7 @@ static int veth_poll(struct napi_struct *napi, int budget)
 	struct veth_rq *rq =
 		container_of(napi, struct veth_rq, xdp_napi);
 	struct veth_priv *priv = netdev_priv(rq->dev);
-	int queue_idx = rq->xdp_rxq.queue_index;
+	int queue_idx = rq - priv->rq;
 	struct netdev_queue *peer_txq;
 	struct veth_stats stats = {};
 	struct net_device *peer_dev;

---
base-commit: 44871eadd07a7f004aa00cb87399461eea08c630
change-id: 20260805-veth-fix-poll-queue-idx-9d47909b033d

Best regards,
--  
Jonas Köppeler <j.koeppeler@tu-berlin.de>

