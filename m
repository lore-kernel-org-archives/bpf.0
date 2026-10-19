Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4863644725D;
	Mon, 19 Oct 2026 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398179; cv=none; b=EHqPYHzBTsXJ0P2/dbzl2+cfSx/cQMW+oTmXXeAQ4vXvsjQvz8fhGI8pgSee7Qk05tHBLqu+Cu8U96LFcWueRh+ZH5SSLUnSxOj67FhNZEZkkOUYE+03vDTGL1MtEsROEe87o0vxUAegfuQDk89YObytUqxehNs1zhZCiOQ8UhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398179; c=relaxed/simple;
	bh=ss+Ay5ky+oMHizLDR1kIYc6Phpgh2tmXwdEs6PiiD9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NOx57GgETn+O91AuMUxHM3mt4hst99QDerP42ht3a1O9ePknXSvUESu7RB3z+5Q/NClPjiM9dko2RU9FFAZYkq4wYv2ZbyyzkhY0I5LvS3eJ2bUaXKQCrr6mtuqLWBJ9tATv7vx10CQY9E869k3FSGLdkdgujHxgfY+HnE27wWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDTqMeG9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDTqMeG9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C72A3C2BCF4;
	Mon, 19 Oct 2026 08:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792398178;
	bh=ss+Ay5ky+oMHizLDR1kIYc6Phpgh2tmXwdEs6PiiD9Q=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=XDTqMeG9J05nMX5grZXxC7LnYPRb3PsL8ZQc0AQuoTuPSv8M0QolrnBHnV6JN9RJe
	 FT1312DSw0EhdxqpqgROVo3kR4SOONZdwtJBphWxaBbPGdaornQLs7pCEfuzmrwVND
	 P0ctUfRHjNAqFy7E24AwqLkunPjFw10GHTBLQopwq/niwSz6m13H3b0xPg/ya8fTJQ
	 az245IWVOECSZ/s0Systbpl3YcSK/AlVOHTBky+LYmReTHhkPW6scKhBA/pTv5QO+w
	 6+HC1/oRF0Xsne7E2sUIdhizOkTi6+jvGYYQ85w7werIkwerg5azI/r85aQ3jHaIYN
	 nA+ghCYzDp3oA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E175CCF2DA;
	Mon, 19 Oct 2026 08:22:58 +0000 (UTC)
From: Marcin Knap via B4 Relay <devnull+marcin.knap.vecima.com@kernel.org>
Date: Mon, 19 Oct 2026 10:22:02 +0200
Subject: [PATCH bpf] xsk: Do not free ZC Rx buffer when the Rx ring is full
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-xsk-zc-rx-double-free-v1-1-2aa19f6628fb@vecima.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0Q6CMAwAf4X02SYrKgn+ivGBbR1UDZBWzCLh3
 53yeJfcrWCswgaXagXlt5hMYwE6VBCGbuwZJRaG2tUNOWox2wM/ATVjnBb/ZEzKjNQdvTu3IZ4
 oQWln5ST5/72CnxPcdmmLv3N4/Y6wbV+jyIs7fgAAAA==
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
 Marcin Knap <marcin.knap@vecima.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792398177; l=3895;
 i=marcin.knap@vecima.com; s=20261019; h=from:subject:message-id;
 bh=s6M5ShvilqT323SiSxSUh6dP4sF4L+nlpgOVCpDnEy4=;
 b=HFs2SdpG1CqBqkvoJRwEfJGWNfBJ7ooY+MScmp5JkPzPFwlIAXQjDAdi23OedaFro/Z459wVH
 WUhia9cS1xdDc452zTPEUkNgfr0sWLUaj7fqvb7FkxgW6e/kSnBincv
X-Developer-Key: i=marcin.knap@vecima.com; a=ed25519;
 pk=rCvVOuopf4s4BHtLE+FRnv0x83PoFHgBPo9mtNlvzLk=
X-Endpoint-Received: by B4 Relay for marcin.knap@vecima.com/20261019 with
 auth_id=1237
X-Original-From: Marcin Knap <marcin.knap@vecima.com>
Reply-To: marcin.knap@vecima.com

From: Marcin Knap <marcin.knap@vecima.com>

When an XDP program redirects a zero-copy buffer to an XSK and the
socket's Rx ring is full, xsk_rcv_zc() frees the buffer and returns
-ENOBUFS to xdp_do_redirect().

A failed xdp_do_redirect() leaves the buffer owned by the caller, and
drivers rely on that: mlx5e treats the failure as XDP_DROP and releases
the buffer when the Rx WQE is refilled, and i40e and ice free it on
XDP_CONSUMED. The buffer is therefore freed twice. It gets reused for
another Rx descriptor, the second free puts an in-use buffer back on
the pool free list, and the same UMEM frame is later handed to user
space twice. On mlx5 with striding RQ this also ended in a NULL pointer
dereference in mlx5e_post_rx_wqes().

Leave the buffer with the caller on both the single-buffer and the
multi-buffer -ENOBUFS paths, as xsk_rcv() and xsk_rcv_check() already
do. i40e and ice relied on the core freeing the buffer on their
need_wakeup -ENOBUFS (XDP_EXIT) path, so make them free it there.

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
 drivers/net/ethernet/intel/i40e/i40e_xsk.c |  1 +
 drivers/net/ethernet/intel/ice/ice_xsk.c   |  1 +
 net/xdp/xsk.c                              | 15 +++------------
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 9f47388eaba5..d32c7255f0b3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -358,6 +358,7 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
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
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 33475b180ea6..0edc160c660f 100644
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
base-commit: ff47652a4b66c067c765a7ad464d930b5a9367cc
change-id: 20261019-xsk-zc-rx-double-free-1a3b059cd41f

Best regards,
--  
Marcin Knap <marcin.knap@vecima.com>


