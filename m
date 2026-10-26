Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793003379;
	b=s2idbxP7jI7ZvJFpAwb+OnILXwVIRZtFN7tYigWqogQogVEcTc+MPOIr0FowvLau0Q87
	 E7lEaGyAv4D5xzSvAK91HxQ4EdtBY0lIZimcrM51G3Jkc9KXy19EcKm1ZZKmGh17u95gB
	 udXq6sc45/BZFBh3LuApLvTEBm118Vb6FgAU+JE9ckPKXMv0Gym8hIj6S2kKnawR/QtVn
	 X6h8AngcSPVyhIA2vviHpiNLYcpAKp9t5JmQFx2gyhb4f+LkD0ZTs1B2WBAA6P/S9648/
	 VSNPItqEXM67XpVZrPRfp3PrZCzAqbNxzVSCJbjRqa657Gzxbu7Iry9SL3JLTOrnWPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003379;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=luo5cWeAN0k7vV4vDsCxxXuFDBYxRP+eZO0mPO5W7Xk=;
	b=YaN7apqwKX7PMPOp1EDxvMHkb9CBtfwTHkachVGGkPJyRNAv/B1usYH3ChmnmL+h11kr
	 x7ipST/yGkXx3UQBlVyDBiCQc2sfcRh5VnzzwxpyRhH6OSIof/e7YZ/Wk2JUjaiSAWs+n
	 eepJrNACNs+G97ZbzmFNaVmNUg7Eax/UrUKVmoH/Uf99JbplHk+vfGMIxXn+2UMTLRlTP
	 7QiHsE5m1YARcQeJFC/LiK03FAFSoxhPxfV7Y1MnGGp3ueSqg8A82kD4mnPWo+8s9EYpV
	 muDinNIpPMzLFHY5Cs25c4oZfYXHUdB7ugF4g/htImSY4rCmYRv5+euNLSRJx76KU1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="POQ/LH8V";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3744606A329;
	Mon, 26 Oct 2026 08:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3744606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=POQ/LH8V
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A60C5201E05;
	Mon, 26 Oct 2026 09:29:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793003365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luo5cWeAN0k7vV4vDsCxxXuFDBYxRP+eZO0mPO5W7Xk=;
	b=POQ/LH8VGa0lE5o+/D6FnuhdHXkwOyy3eKJdkCdlqPX+KoxP/W98pYLDZBdYQgtAkGtZou
	ErrMUpZQjUfQEs+dr60P6pwm2FqMWCnH7ghiW7DupFml16+jo1v7nQbd0VpvOGzXmBS0JJ
	ZqqTsXx8TZy4zh2rtBrUS9mi5WmS4/N1RAudrW+aGnAi6kAYj4+xIST/3O2YdDjCKrJaMQ
	5NeHlJ63pUVeCJV0zKc29FY3rvUz+hSOfqUNVdANlsXCElpxseOIvsCwbKy4wMRL5hwYuJ
	148fX5QUe1cWnHwkN7vgPJKUrgzaxkBw1Etv1+bDZhJh/A5/jxkjfesSjWgbvA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793003365; a=rsa-sha256;
	cv=none;
	b=KE/QEkJyvw2r/tfpqd39svpxijbVVuoNTk1ZTGZb0NInQmSvL+tuQ0DtZcsPQiko5Fxkq7
	3Wf1t11pVdAkz4qiS06MHRroPBDWXY5/okmvx0JXn+p/u8K9lGZCP5e/bRQ+TcSCAzu7qe
	o+FTm9qJsaCsaaaaSVP0FBToR+EUQqmY8v2nyTZSsr3w7if+pBV2oxitJSTZHvPWXHjfEc
	Ye4ZATs42PrjdDxCNG+DfC33CHISTubTOI0KtISrymzT3JEweI0qNeVyWr9sfCKsrbF61Y
	hhjK5AvkGO+5+avkAaHlVgVsB7Q9XXno2h83SVTRBG7gO3e3FNieGTXckG3LBg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793003365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luo5cWeAN0k7vV4vDsCxxXuFDBYxRP+eZO0mPO5W7Xk=;
	b=J/3Ktcnc4kH/rLeXZcP4oMYfEoMVX/oWJ6V9A/hILc0PNJwaKPOItSxa7sOHfG3DSejzS/
	vDJj83fdf6ICsK3sB7LkSiDuGta1Ch3vxOYNii8zdhVtPnfUw+B+BwBxXWba9dbz4VVLqi
	2jxYsCp7q3hbVIey16LslFKgv+LZqeGXCX1zfIIgXQgzYk9DAUOSQzxSocKMb+jxUVphPi
	avlfr5ETkYcU1DpDDmw/QZa3E/fNBWUdKRStRsEcCVXqgd4LV4xfSm51TYj9sfwvxjr7g6
	FpIVN7qQS8Ql8zA4oRZ98FTq4vI3si62BfhpcODLdePyRVtLB0JTsudDOx9WBQ==
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Mon, 26 Oct 2026 09:29:05 +0100
Subject: [PATCH RFC v4 5/6] virtio-net: add XDP rx timestamp metadata
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
Message-Id: <20261026-v6-7-topic-virtio-net-ptp-v4-5-008af03cd43b@pengutronix.de>
References: <20261026-v6-7-topic-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de>
In-Reply-To: <20261026-v6-7-topic-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kvm@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2386;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=YTbCcS6XIdWWY5x5SWFh55/9qh3+beZ0gvegypiVem4=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9Z9/kTOuQe9V4hF7EzIZN/qx/6axXj23R9sMqyK5nFHy
 x7LzFrYUcrCIMbFICumyKKysIJP1OODZ+Q0ES6YOaxMIEMYuDgFYCJ+7xgZFhfs3J7fEj7h2odC
 /vbfB+TfHXi33TzK7OSk2PuT8iW9RRj++3zO6GBZVrrp4Wa7XT/z+WvaPGZe7vMvaWTuMTZl+Rz
 ODQA=
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

For the skb, the timestamp is read from the header before the XDP
program runs, so XDP_PASS keeps it even if the program changes the
packet. XDP therefore works with rx timestamping enabled.

Add xmo_rx_timestamp so XDP programs can read the timestamp with
bpf_xdp_metadata_rx_timestamp(). It returns -ENODATA if timestamping
is not enabled or the device did not timestamp the packet. Install the
metadata ops also if only VIRTIO_NET_F_RX_TSTAMP is negotiated;
rx_hash returns -ENODATA then.

Like virtnet_xdp_rx_hash(), the callback finds the header relative to
xdp->data, so it has to be called before bpf_xdp_adjust_head().

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Assisted-by: Claude:claude-opus-5-5
---
 drivers/net/virtio_net.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 23af10c613b48..e79b65653fad7 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6848,8 +6848,30 @@ static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
 	return 0;
 }
 
+static int virtnet_xdp_rx_timestamp(const struct xdp_md *_ctx, u64 *timestamp)
+{
+	const struct xdp_buff *xdp = (void *)_ctx;
+	const struct virtio_net_common_hdr *hdr;
+	struct virtnet_info *vi;
+	u64 tstamp;
+
+	vi = netdev_priv(xdp->rxq->dev);
+	if (!READ_ONCE(vi->hwts_rx_en))
+		return -ENODATA;
+
+	hdr = (const struct virtio_net_common_hdr *)(xdp->data - vi->hdr_len);
+	tstamp = get_unaligned_le64(hdr->tstamp);
+	/* 0: the device did not timestamp this packet */
+	if (!tstamp)
+		return -ENODATA;
+
+	*timestamp = tstamp;
+	return 0;
+}
+
 static const struct xdp_metadata_ops virtnet_xdp_metadata_ops = {
 	.xmo_rx_hash			= virtnet_xdp_rx_hash,
+	.xmo_rx_timestamp		= virtnet_xdp_rx_timestamp,
 };
 
 static int virtnet_probe(struct virtio_device *vdev)
@@ -7014,6 +7036,10 @@ static int virtnet_probe(struct virtio_device *vdev)
 		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
 	}
 
+	/* rx_hash returns -ENODATA without NETIF_F_RXHASH */
+	if (vi->has_rx_tstamp)
+		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
+
 	if (vi->has_rx_tstamp)
 		vi->hdr_len = offsetofend(struct virtio_net_common_hdr, tstamp);
 	else if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) ||

-- 
2.52.0

