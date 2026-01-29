Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E40536B056;
	Thu, 29 Jan 2026 22:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769725736; cv=none; b=qYCwj0miOgCFYV7wvL4BPbCCq2LC8u17pZZr2GQ32GTjloB/XJTZkDbJXrOx3gHX0ARalY8nq1UF/yx3gqEhHNCUbkdjvzMZk5GjEXZL0dcO2qP3s6mpPcHimvaryWJpuvnbz/55rpTZnu4zM3EQLVbmxmQD2OBqX9x6szbOMj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769725736; c=relaxed/simple;
	bh=jGyDQtWtcC0cNRXWiZBwN2vxQJP2rZlpIRiaE6n2dQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwgAVDcdgXjmWYarh9orMjs7uoERqVTXxSC/kw3uVZFyXHaECuxkSuwjyqf68LAOj4sk6GBznGAtKALzJk5oE8PtfXdyvYgn91HSWTxN7rjlmB8x+vWqUFdw9JGqB6EAmrZvWUfemE0b1pLLivjVuH6RYSyHBHQ/qkHzvH4KM30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=aDUtiXMv; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="aDUtiXMv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=P3swmN9pFDPGlPd7bLV0qRVLYqCUoNxoL3L7ISSJO3o=; b=aDUtiXMvLEMb0udhYclgedbpNG
	ImDC8/yZxbsA2GXC9G1+fI7oBC1IjjNXujBusP8sNwmLQ4GCRwmhHL3RW+CBbsmZGHqD9oWH29nLY
	YG5mxIFpgBeZ/lU8Bw+Bn5GmWbGkg3iV6KdcWT5oB2wZ3VUMyghg2JwvseXJJAwRs4h4aVBtq2Fp1
	yk6FXxkI4aRu/BmNcATkn+Vh2+9+fz6tLqIwnOVYm3LXz0hSFEWQW/j6mwoNLzmy18PtoQ4hc8/eV
	oV7FtV9poUntDi2l/f5pIg5TgtOdWlU6zFDC8KneL6EJHdiVvtRs7g7vysjeJqIQ9l7BAYS6FGLF2
	+HQTyurA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vlaVF-0008pH-0U;
	Thu, 29 Jan 2026 23:28:41 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	razor@blackwall.org,
	pabeni@redhat.com,
	willemb@google.com,
	sdf@fomichev.me,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	jordan@jrife.io,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	dw@davidwei.uk,
	toke@redhat.com,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: [PATCH net-next v8 08/16] xsk: Extend xsk_rcv_check validation
Date: Thu, 29 Jan 2026 23:28:22 +0100
Message-ID: <20260129222830.439687-9-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129222830.439687-1-daniel@iogearbox.net>
References: <20260129222830.439687-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27896/Thu Jan 29 08:24:11 2026)

xsk_rcv_check tests for inbound packets to see whether they match
the bound AF_XDP socket. Refactor the test into a small helper
xsk_dev_queue_valid and move the validation against xs->dev and
xs->queue_id there.

The fast-path case stays in place and allows for quick return in
xsk_dev_queue_valid. If it fails, the validation is extended to
check whether the AF_XDP socket is bound against a leased queue,
and if the case then the test is redone.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/xdp/xsk.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 67f32a249ecb..747865f9341d 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -324,14 +324,37 @@ static bool xsk_is_bound(struct xdp_sock *xs)
 	return false;
 }
 
+static bool xsk_dev_queue_valid(const struct xdp_sock *xs,
+				const struct xdp_rxq_info *info)
+{
+	struct net_device *dev = xs->dev;
+	u32 queue_index = xs->queue_id;
+	struct netdev_rx_queue *rxq;
+
+	if (info->dev == dev &&
+	    info->queue_index == queue_index)
+		return true;
+
+	if (queue_index < dev->real_num_rx_queues) {
+		rxq = READ_ONCE(__netif_get_rx_queue(dev, queue_index)->lease);
+		if (!rxq)
+			return false;
+
+		dev = rxq->dev;
+		queue_index = get_netdev_rx_queue_index(rxq);
+
+		return info->dev == dev &&
+		       info->queue_index == queue_index;
+	}
+	return false;
+}
+
 static int xsk_rcv_check(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 {
 	if (!xsk_is_bound(xs))
 		return -ENXIO;
-
-	if (xs->dev != xdp->rxq->dev || xs->queue_id != xdp->rxq->queue_index)
+	if (!xsk_dev_queue_valid(xs, xdp->rxq))
 		return -EINVAL;
-
 	if (len > xsk_pool_get_rx_frame_size(xs->pool) && !xs->sg) {
 		xs->rx_dropped++;
 		return -ENOSPC;
-- 
2.43.0

