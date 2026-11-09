Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794222081;
	b=tCo+H7usTkLqc1hUeSE4ahSKZeqMcafOMU/pmtOCJrwXD4w8nNXE8g7faDloPTym8YWt
	 r79IX2DFk17yJ6Z/TM7HwSVmTQDy9VZbzLRMdybSDs0ah4+LIf8oDpUw1SLhdrXa6S9Tw
	 pj9LgtgECYaK4PkE6Gx/4pKpWOycVn3Wf8kXGLRnGkd15jNKuqCAeM47E2rHDOpw2HjtV
	 jnM1whTS6IOvBAe8YR3PSifo6sJIEULmWYM9futZkGOBBJYiPaEAGWLU09TvG1B7V/xCW
	 QFFnD1qg2RBGOFCozRVX9Cq2Rec+aOXHuWtnrwQp8DvwR01TfWbS9zZ2FRMkhMLWtpg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794222081;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=j59bKxnEEF9AqLvCRLqOAvbsI14ObR0asK1bIpFEbPQ=;
	b=CwRtE4l1XAVIWWH7O0v0jAS+bRnMqHQgymwtAEQkpZUzJbpkYqq2QQCZ8k9cUcUV78RJ
	 pohi9U0fl0lIl6nGToZsBJFd5RF12YMYNgXiIoMoN7QDwWxIafPF0D1VKmBt6Ol/9vBYh
	 ULK6YnCJy1QQFTQahQxvtbW/TNAGy5Rx3A2WUfgQB3Jc+RLyRsSvnYt6+mGmvJaE12gla
	 HJ5Q+k6iVvL0SfvyydVdg8I6VFWpZqJdH3k9UWyLYG2fKHmLR+eNbhlNI8muVJ3iUKS2l
	 lgo1sjKEfGyYi+2MuBCEiH13j+1m93I9QaWQBNz1tjjhEkAyrTx96V6gqD85bwxlK9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ON7DgfT1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E0D606A331;
	Mon,  9 Nov 2026 11:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ON7DgfT1
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794222080;
	b=z1QqAmHFCAedgHNFuChubO8ifwELwBVOKjNaKoz3bzDcdS+YLxUebDiKvfiW4sVZpVz+
	 /d2qos+IQh+nxby/XcY0X90i6br35urRwwlC5rYPwk5HI0ILw4t+lw2fS/0nnaQr1KI4N
	 7QXmM8FXKohnw1uhUP9a+oN/+ev4i+OUWbJTsUqSFdROz0l5V7Og8B87ARGT2dIgYn8tp
	 V3p2/fksO9FW0dZJJiC3yjxvxpyLABr8olq49NbaLtvg7C9jkq+5VlTC3jI3YQpFCIXT3
	 cQA1BTKjhlD8uW8QSsMmzVjofhsJg6Eq1PkY+rGwOpu7zfnJU0cCe8raIJ9VmRoLfog==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794222080;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=j59bKxnEEF9AqLvCRLqOAvbsI14ObR0asK1bIpFEbPQ=;
	b=qzQACefQ8tm43JDIWHvbXigr8373YAbSkVM2ZFUFrhPRgH7RvyTyOo2MGTCWh3oqzuWY
	 JR3fUE0venuad3uEX1jdPapW9Ujkk1Ch5Clad9ixw4Qjl9YrEyaESxqIMF72R2rrvr05+
	 0v8lx7mVuYpjux120Z4dFWcoII5FQTLOdNqVueI898sYAGaQcWAJDSsSRBcMw6z3odwh3
	 JEu4K0efkB+Cv9lC75OU0RTHpg0IJqkIjd3wlFXXQqsBfJYLry4ezqkVsb96ib/qyqsea
	 8DGHSu+TBISS3Elt3KhiK/40G6xzLEbkko1QfO0uElRyi55QOQ88LY1ghFGEDzOM54Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BAD051F0089F;
	Mon,  9 Nov 2026 11:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794222080;
	bh=j59bKxnEEF9AqLvCRLqOAvbsI14ObR0asK1bIpFEbPQ=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=ON7DgfT1swf5JmTCIHZjb/eBe7Tn8G6XIIovme7wxv4Vk6T3AVHbzj7PWD/1fuURR
	 sWJ34FjrQUlEnHPfe/KQyXsLT9cMXhX7IAvQg5L3zVV8u2O0d0AvLqwGi6hY+ZKvnq
	 aYeUY84ikED3xsR+JleBoi7CqyrGqhdyahSYOR74xsVGzzOfj5BqMB4c2rnIwjWmA9
	 U5LRTNvECu8/fq3JU4y6g5e5AOWjBb6zfW8WHpZ7rGiyw+R2sPy3FJW2sUXN7dQ8EQ
	 8ioOM6KOm4Cy8UzlU6/Phg6KFUjnC9UGhwMqSK8K6zhA+cIE1+9WQzINpYOkkymjdf
	 vEVL68hhjp63g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 446A3483DE;
	Mon,  9 Nov 2026 11:01:19 +0000 (UTC)
From: Marcin Knap via B4 Relay <devnull+marcin.knap.vecima.com@kernel.org>
Date: Mon, 09 Nov 2026 12:01:14 +0100
Subject: [PATCH net v4] xsk: Do not free ZC Rx buffer when the Rx ring is
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
Message-Id: <20261109-xsk-zc-rx-double-free-v4-1-24e00ac221a0@vecima.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNQW7CMBAF0Ksgr5nKY6cJZtV7VCwcZwZcSILsY
 AVQ7o5JFwUh1OUf/Xn/KiIFT1GsF1cRKPno+y6HYrkQbme7LYFvchZKqhIlGhjjHi4OwghNf6o
 PBByIAK2u5adxTYEs8u8xEPtxdr9FR4PY/B7jqf4hN9zFe23n49CH87yecC7/M5QQEJS1aLgs1
 Yrrr0TOt/bD9e08ktQDo+U7RmXGscSmsIY1Vy+M/mNQFu8YnRlEK11FjKbST8w0TTc334M/YAE
 AAA==
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
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Nitin Shetty J <nshettyj@marvell.com>, Marcin Knap <marcin.knap@vecima.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, 
 Ratheesh Kannoth <rkannoth@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794222078; l=8729;
 i=marcin.knap@vecima.com; s=20261019; h=from:subject:message-id;
 bh=f4AE9rCSB5DYOzqmGsjuYY3jbTNQXDTKL8I59vacBXQ=;
 b=RUuTaJmeis/t/die75p315sTUI3y7bcJHgTnDq2uHLijqv/5i/6UXfaTJAZ/jBWIR88HWv9ge
 1zqgNN2RakuBmlSzM2ET/qAN9+j386aIY+WenM+NryspVyQShv4+ujy
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

A failed xdp_do_redirect() leaves the buffer owned by the caller, so
the driver releases it as well. That is harmless when the driver frees
it right away, as i40e, ice, igc, stmmac, idpf and most others do:
xp_free() ignores a buffer that is already on the pool free list. It
breaks when the driver releases or uses the buffer later, after it may
have been reallocated:

- mlx5e treats the failure as XDP_DROP and releases the buffer when
  the Rx WQE is refilled. By then the buffer can be in use for another
  Rx descriptor, so an in-use buffer goes back on the free list and the
  same UMEM frame is later handed to user space twice. With striding
  RQ this also ended in a NULL pointer dereference in
  mlx5e_post_rx_wqes().
- ixgbe keeps the buffer in the ring on its need_wakeup -ENOBUFS
  (XDP_EXIT) path and runs XDP on it again on the next poll.
- dpaa2 hands the buffer back to its hardware pool while it is also on
  the pool free list.
- octeontx2 returns false on a failed redirect, so the caller goes on
  to build an skb from the freed buffer.

Leave the buffer with the caller on both the single-buffer and the
multi-buffer -ENOBUFS paths, as xsk_rcv() and xsk_rcv_check() already
do. Make the drivers that relied on the core freeing the buffer free
it themselves:

- i40e and ice consume the descriptor on XDP_EXIT without freeing it.
- gve DQO counts the redirect error without freeing the buffer.
- octeontx2 now frees the buffer and reports it as consumed.

This covers redirects to an XSKMAP. A zero-copy buffer redirected to
a devmap or cpumap is copied by xdp_convert_zc_to_xdp_frame(), which
frees it before the enqueue can still fail. That path is not changed
here.

Seen on Mellanox ConnectX-6 DX MT2892 (FW 22.47.1026) with AF_XDP
zero-copy on 7.3.0-rc6 when the user-space consumer could not keep up
with the Rx ring. With this change no duplicate frames were seen with
striding RQ on or off.

Fixes: 269009893146 ("xsk: recycle buffer in case Rx queue was full")
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Björn Töpel <bjorn@kernel.org>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Nitin Shetty J <nshettyj@marvell.com>
Tested-by: Jerome Tollet <jtollet@cisco.com>
Signed-off-by: Marcin Knap <marcin.knap@vecima.com>
---
Tested on mlx5 (ConnectX-6 DX) in zero-copy single-buffer mode.
The i40e and ice changes and the multi-buffer path are build-tested
only, as I don't have that hardware available.
---
Changes in v4:
- Commit message only, no code changes (AI review):
  - Drop igb from the drivers that rerun XDP after XDP_EXIT;
    igb_run_xdp_zc() turns IGB_XDP_EXIT into IGB_XDP_CONSUMED.
  - State that the fix covers XSKMAP redirects.
- Link to v3: https://patch.msgid.link/20261104-xsk-zc-rx-double-free-v3-1-11a0c7ef1973@vecima.com

Changes in v3:
- Target net instead of bpf (Maciej).
- Reword the changelog only: drivers that free the buffer right away
  are not affected; name the ones with a deferred release or reuse
  after free (AI review). No code changes.
- Collect Reviewed-by tags.
- Link to v2: https://patch.msgid.link/20261030-xsk-zc-rx-double-free-v2-1-cf01d4a9f3f7@vecima.com

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


