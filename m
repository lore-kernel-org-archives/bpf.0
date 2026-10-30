Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793348188;
	b=jsbFRD2L9zxTnefg5hKFJXT52k3MxRAXMO26omS8FoCmH/gmrVVzvdPigPFXrgeolJYh
	 YOpSkeQvdcfddaYuSeu/MUaUuu6I3bM3ZeD1xaio4MQuerP6ncDpZXzP6L9KPdtKr/Kwy
	 lgZhIbY9V1B25b4gi1+9PGRQKf986z9bCxVoFQxSux2h0bIfRps4a8KI1W4e/L331WztQ
	 sVsIKXa1xX4uvCcFu+ReXvQGGmOCzhTBbe+IkQV8Y6bDURME0VOCMODiSy9zRjrm0quHL
	 peviFzFEdpyXAcQnz5ittT4F5co1WiB2T2GOBxzaqJ/TosWjvwymRgwrFWbtUd8W79Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348188;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=nxb4ICs48/EH3I4EV/LG2u9tIdfwalBWWFtzW7PUfTc=;
	b=Swnjc2QiyaCkuDFEknWkd/Vpz14d6L5B0AuRBpKknVamFmHSMQ0oqIkCVaTpQSZcEYcg
	 HlRhK2fhYULTHcHYRhYnaMa5ATXVOoar/vExPwRQtCxE1Albnve/yibKzgo6kwXEu0BWR
	 Lz2psDuqoyqe9J4JPIuiY0p5ubX1y9yCdk8x9wgAWFdGHG6HVy5sn5l7WXpDAPa3fGWlL
	 rpXLH1D42gg0gOIk/JWqRkMeuExTZ3Y593XzcDc/r9mhh9qmuPMzO2wK0P2UKPt2PNqBb
	 3qmXkC1b+JjAWnA/xb69ep2vfj2SupFpWkx3J+1c/TctjXW4ooVIcGV8l3NNvSukChg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GxCTz2HF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFB8606A31A;
	Fri, 30 Oct 2026 08:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GxCTz2HF
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793348187;
	b=ktgjPCVtkgx+UJUxOWm6fSy6sX3RrxFJqMZE1nZmdkMVHoOKvMtT/fZkM/atRLz+VOeM
	 jYNXNQJmHRoYsnwTC3OvvLJuDwyv6JayAbhhIpLiwZYOogSboQz/r2/dKaLGGs5hvQixA
	 4fDBPiquQBDGqAFDOWf00c+JrQVxTF40insE9uUgNKFMI1u5jWqM2SjF6rfY5RvhszEH+
	 7r+sYHd+EqRon/VDoMmrn3GrBPyk7A+c7iW8Yw9LFJ1hQdFIIC5gYxoodUW0Nm7dk33SC
	 ZbRBOtAYXrXitiD1B/4j6aHHEY7cqX50PGyQwTbWk6YFfvoPR3HbcIdCTsCMFmVDeYw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793348187;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=nxb4ICs48/EH3I4EV/LG2u9tIdfwalBWWFtzW7PUfTc=;
	b=B1tHP2rBHe5NGFezdb3tSeKSbH0EsyztrQ2o9cPc4x1exAxRx0IoV/8tUq/5/hDkr+KU
	 YPu/SSPQ43qHvLU5/prTdswYDgMHjvFzODd/mNdKj33KTaH0beZKUrVEm9Tr5Wd5W7mIt
	 d8tT4zhSeLHZUc5SBVc0T7GRjdpBc+jTQlkExIrnYLbXDhY/ezXDdIIe71+ePT1Q9xXG7
	 wpBt3fTzhg7aLJ9l7a2oCDq6dtD3TR/vk0CH6t9wUledN417jMN2/BBzo4BsOcIfDfIiU
	 xbkbiFLNycEzifPI7A4wSAYinXElJBGLxeyUhGrTZ2rVbokraVDOJjSlh3RYaChYCzg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C674D1F000C1;
	Fri, 30 Oct 2026 08:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793348187;
	bh=nxb4ICs48/EH3I4EV/LG2u9tIdfwalBWWFtzW7PUfTc=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=GxCTz2HFnhjMHn9BaJehym9NHJiHfz70aN+nvDttXwy94/7hTA7D8x/w8zjwLjiSn
	 vjVJazyvgt7Y71gqXT2DNKmGgpjBgtspTs1azQE6unS5yKF8rUtwipuJwwMZ3BuJLy
	 AwFY3Iif4KI+CtwVGAGH1RtezmkkHNd3/fNho1W/7/Fd5SN1DbXekB6gyYcu6M/RQB
	 hXp5vrWg2UJkDbdRXIqBG2+LtsXx4yy8UVY/dWxPONJa5TRSGSobKQ7vjnkjyHdVbH
	 Y0FDS9Ii9DmmEd6uxXXNEirmem5/HqmfHq6p6d1rYR8Q3pejEvRLwvqZjlgQU/gJfM
	 LUuZHtUg/Nd5g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 25F3D436CC;
	Fri, 30 Oct 2026 08:16:26 +0000 (UTC)
From: Marcin Knap via B4 Relay <devnull+marcin.knap.vecima.com@kernel.org>
Date: Fri, 30 Oct 2026 09:14:17 +0100
Subject: [PATCH bpf v2] xsk: Do not free ZC Rx buffer when the Rx ring is
 full
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
Message-Id: <20261030-xsk-zc-rx-double-free-v2-1-cf01d4a9f3f7@vecima.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0Jm7RimKhFX3sOwaMtUqkJJC02Vc
 HcBD+Dy/7z//gSBveUAl2wCz9EG67oliF0GupHdndHWSwaRi4JyKjGFJ340+oS1G9WL0XhmJHl
 Q+anU9ZEMLNves7Fp895A9QaqXxlG9WA9rMYVa2wYnH9v75E2+M9RJCQUUlJpikKcjbpG1raVe
 +1aqOZ5/gLbBU1M0gAAAA==
X-Change-ID: 20261019-xsk-zc-rx-double-free-1a3b059cd41f
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, jtollet@cisco.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Marcin Knap <marcin.knap@vecima.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, 
 Ratheesh Kannoth <rkannoth@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793348185; l=7209;
 i=marcin.knap@vecima.com; s=20261019; h=from:subject:message-id;
 bh=zjCC53eamxy9uMwrekd/GVBEJYRREa6qEen7NhdsQgY=;
 b=JMsIQYe1NE5OYniKA2lvB97Xsdw88oJQPtAmSCDaKi15sBjcyt+WyWBhB9YeXee+577TW/01w
 /fa+Lx6zDrDB5c+neYFJxGKWLQW+14dC7+7u0rC92WOgK05a3sJFBL1
X-Developer-Key: i=marcin.knap@vecima.com; a=ed25519;
 pk=rCvVOuopf4s4BHtLE+FRnv0x83PoFHgBPo9mtNlvzLk=
X-Endpoint-Received: by B4 Relay for marcin.knap@vecima.com/20261019 with
 auth_id=1237
X-Original-From: Marcin Knap <marcin.knap@vecima.com>
Reply-To: marcin.knap@vecima.com
Content-Transfer-Encoding: 8bit

From: Marcin Knap <marcin.knap@vecima.com>

When an XDP program redirects a zero-copy buffer to an XSK and the
socket's Rx ring is full, xsk_rcv_zc() frees the buffer and returns
-ENOBUFS to xdp_do_redirect().

A failed xdp_do_redirect() leaves the buffer owned by the caller, and
most drivers rely on that: mlx5e treats the failure as XDP_DROP and
releases the buffer when the Rx WQE is refilled, while i40e, ice,
ixgbe, igb, igc, stmmac, idpf and others free it themselves. The
buffer is therefore freed twice. It gets reused for another Rx
descriptor, the second free puts an in-use buffer back on the pool
free list, and the same UMEM frame is later handed to user space
twice. ixgbe and igb keep the buffer in the ring on their need_wakeup
-ENOBUFS (XDP_EXIT) path and run it through XDP again on the next poll,
after the core has freed it.

Leave the buffer with the caller on both the single-buffer and the
multi-buffer -ENOBUFS paths, as xsk_rcv() and xsk_rcv_check() already
do. A few drivers relied on the core freeing the buffer, so make them
free it:

- i40e and ice consume the descriptor on XDP_EXIT without freeing it.
- gve DQO counts the redirect error without freeing the buffer.
- octeontx2 returns false on a failed redirect, so the caller goes on
  to build an skb from the already freed buffer. Free the buffer and
  report it as consumed instead.

Seen on Mellanox ConnectX-6 DX MT2892 (FW 22.47.1026) with AF_XDP
zero-copy on 7.3.0-rc6 when the user-space consumer could not keep up
with the Rx ring. With this change no duplicate frames were seen with
striding RQ on or off.

Fixes: 269009893146 ("xsk: recycle buffer in case Rx queue was full")
Signed-off-by: Marcin Knap <marcin.knap@vecima.com>
---
Tested on mlx5 (ConnectX-6 DX) in zero-copy single-buffer mode.
The i40e and ice changes and the multi-buffer path are build-tested
only, as I don't have that hardware available.
---
Changes in v2:
- Also free the buffer on zero-copy redirect failure in gve DQO and
  octeontx2, which relied on the core freeing it (AI review).
- Audited the remaining zero-copy drivers against Björn's table.
  ixgbe and igb no longer run XDP on a freed buffer after
  XDP_EXIT; making them drop and consume the descriptor (R2) is
  left for a follow-up unless you prefer it in this patch.
- Rebased on current bpf.
- Link to v1: https://patch.msgid.link/20261019-xsk-zc-rx-double-free-v1-1-2aa19f6628fb@vecima.com

To: Joshua Washington <joshwash@google.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Sunil Goutham <sgoutham@marvell.com>
To: Geetha sowjanya <gakula@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
To: Bharat Bhushan <bbhushan2@marvell.com>
To: Magnus Karlsson <magnus.karlsson@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <sdf@fomichev.me>
To: Simon Horman <horms@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Jesper Dangaard Brouer <hawk@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org
Cc: bpf@vger.kernel.org
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c           |  4 +++-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c             |  1 +
 drivers/net/ethernet/intel/ice/ice_xsk.c               |  1 +
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |  3 ++-
 net/xdp/xsk.c                                          | 15 +++------------
 5 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 82ed5e48b00a..cc544420df11 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -686,8 +686,10 @@ static void gve_xsk_done_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
 			goto err;
 		break;
 	case XDP_REDIRECT:
-		if (unlikely(xdp_do_redirect(priv->dev, xdp, xprog)))
+		if (unlikely(xdp_do_redirect(priv->dev, xdp, xprog))) {
+			xsk_buff_free(xdp);
 			goto err;
+		}
 		break;
 	}
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 51a05ce4c7ce..a11ee1f3fa38 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -360,6 +360,7 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
 		return;
 
 	if (xdp_res == I40E_XDP_EXIT) {
+		xsk_buff_free(xdp_buff);
 		*failure = true;
 		return;
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 0643017541c3..7c1dd4c87a71 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -636,6 +636,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
 		if (likely(xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR))) {
 			xdp_xmit |= xdp_res;
 		} else if (xdp_res == ICE_XDP_EXIT) {
+			xsk_buff_free(first);
 			failure = true;
 			first = NULL;
 			break;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 90af9b9044aa..6d10c132f61c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -1555,7 +1555,8 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 				*need_xdp_flush = true;
 				return true;
 			}
-			return false;
+			xsk_buff_free(xsk_buff);
+			return true;
 		}
 
 		err = xdp_do_redirect(pfvf->netdev, &xdp, prog);
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 781ba46eb152..89bac2feeff2 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -224,21 +224,15 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 	struct list_head *xskb_list;
 	u32 contd = 0;
 	u32 num_desc;
-	int err;
 
-	if (likely(!frags)) {
-		err = __xsk_rcv_zc(xs, xskb, len, contd);
-		if (err)
-			goto err;
-		return 0;
-	}
+	if (likely(!frags))
+		return __xsk_rcv_zc(xs, xskb, len, contd);
 
 	contd = XDP_PKT_CONTD;
 	num_desc = xdp_get_shared_info_from_buff(xdp)->nr_frags + 1;
 	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
 		xs->rx_queue_full++;
-		err = -ENOBUFS;
-		goto err;
+		return -ENOBUFS;
 	}
 
 	__xsk_rcv_zc_safe(xs, xskb, len, contd);
@@ -252,9 +246,6 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 	}
 
 	return 0;
-err:
-	xsk_buff_free(xdp);
-	return err;
 }
 
 static void *xsk_copy_xdp_start(struct xdp_buff *from)

---
base-commit: fb7bd3a2aad70a76232a7168a505386d0a1396af
change-id: 20261019-xsk-zc-rx-double-free-1a3b059cd41f

Best regards,
--  
Marcin Knap <marcin.knap@vecima.com>


