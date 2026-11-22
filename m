Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795309284;
	b=HJuJZbQZ9jmuh3ZmkhYnM/VaJkUp96nywMeATg7u+fgjyvee+K47QqmP6ctsKX6NQbiK
	 N5Bw2zpO4IeWEGhN7qLSYLd5X+zGqD7JYhVW3IvEvKQQLxBnvHaDSmLoZGModHo4W7E3+
	 nGDBF59iFjlbNYma3HW5KizKYp7UN7pGzpD38Z39l6+qFPEw5XrvMnTUgvWKZWN++sgW0
	 qqVJ74QtnIy8+Ush/g0Rbo8p2nZz94rsvmoH2CJBgCBC6ftK7g29Sp09bGVZpaIyPJgrI
	 O8LS5DBNWpKOHRzsYFztCQEOHzTRhcJ6dz8TK2bJJI5hjIxB/ne+DZY7PYMoX+CRLnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795309284;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sKHnDldX+2zYoolKt0RTm41HQFQ3YlDVqdmdody4eKQ=;
	b=H9gT1IbCnEqEUY6umi4jxR0f5PJKEVXwM0Sjfl5a9QcbE3i3MM6aeNB3phqEOqrPnIWD
	 HY+nTgj8olKypqlaYqAVLyk8VLNDSQWrlMsMbh/Nfn2boZu7mDYt6ikmvcjJTocFs3aZF
	 tTRhjqL4lXpVDR65MOnAgqyX09genz0prxDWRfNCSU0XhotLEvoshweFftCUkvzJrXoh8
	 dz4SRWaEA1CRII23LlolliK/O+VjqbY+GerHt6iU2y1bUavppoTXF1nCA5kPbKbgRNCpm
	 WjC6nP0yNmbL5oUj6SN4DXglbGlSgp022Hrqh+oBMDkRmLspOxhss8a4TInG3wlcmyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JoinETaw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7E6606A696;
	Sun, 22 Nov 2026 01:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JoinETaw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409381F000C4;
	Sun, 22 Nov 2026 01:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795309283;
	bh=sKHnDldX+2zYoolKt0RTm41HQFQ3YlDVqdmdody4eKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JoinETawO97mb8KeckoUw8c/Tzl+AhgpGT2v3MNI9CcwYA4Mx915BqQ2M1AuQcAkZ
	 7m2JT0rSF0htVmYPjgQ9oZMHZrNJtTcB23Bday3gF9F00lVrBnvYZDoZEK5EoYtUNQ
	 +cjKwYm7M8aS8lk5hze0R7sFM8Dle4L+gtO+u/8KBKcfoiHMdCsF3k0FOwiD9BlUDo
	 MNGhaAaalazyfvljQmxPbMYHrqNPB6nfkCelOCz9z+oerZw+NajZpaipnwt0uOG8Ld
	 ewM6IIAoKXkY05ouSG6ZXDw39RhOa1ummWNgrnMV7pOhJI8JqFRb8USDfFM3Kp/Ahm
	 XoQXQ4XtOye5Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	manishc@marvell.com,
	joshwash@google.com,
	hramamurthy@google.com,
	tariqt@nvidia.com,
	saeedm@nvidia.com,
	daniel@iogearbox.net,
	hawk@kernel.org,
	sdf@fomichev.me,
	willemb@google.com,
	przemyslaw.kitszel@intel.com,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Ankit Garg <nktgrg@google.com>
Subject: [PATCH net-next v2 9/9] eth: gve: drop the now-dead HW-GRO vs XDP interlock
Date: Sat, 21 Nov 2026 17:01:12 -0800
Message-ID: <20261122010112.1471146-10-kuba@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261122010112.1471146-1-kuba@kernel.org>
References: <20261122010112.1471146-1-kuba@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core clears NETIF_F_GRO_HW before ndo_bpf runs and refuses to turn
it back on while a program is attached, so neither of these can fire
any more. That holds for a program an upper device pushes down as well,
which is why this comes last - gve_verify_xdp_configuration() was the
only thing standing between a bonded gve port and XDP running with RSC
still on.

The user visible behavior changes as intended: attaching XDP to a gve
device with HW-GRO on used to fail with -EOPNOTSUPP and now succeeds
with HW-GRO turned off, which is what bnxt and qede have always done.
The header-data split refusal right below keys off
priv->header_split_enabled and stays.

Reviewed-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: no change
v1: https://lore.kernel.org/20261118232315.3593731-9-kuba@kernel.org
---
 drivers/net/ethernet/google/gve/gve_main.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 35cf0f06a0f2..59ced629dcf6 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1804,12 +1804,6 @@ static int gve_verify_xdp_configuration(struct net_device *dev,
 		return -EOPNOTSUPP;
 	}
 
-	if (dev->features & NETIF_F_GRO_HW) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "XDP is not supported when HW-GRO is on.");
-		return -EOPNOTSUPP;
-	}
-
 	if (priv->header_split_enabled) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "XDP is not supported when header-data split is enabled.");
@@ -2218,12 +2212,6 @@ static int gve_set_features(struct net_device *netdev,
 	if ((netdev->features & NETIF_F_GRO_HW) !=
 	    (features & NETIF_F_GRO_HW)) {
 		netdev->features ^= NETIF_F_GRO_HW;
-		if (priv->xdp_prog && (netdev->features & NETIF_F_GRO_HW)) {
-			netdev_warn(netdev,
-				    "HW-GRO is not supported when XDP is on.");
-			err = -EOPNOTSUPP;
-			goto revert_features;
-		}
 		if (netif_running(netdev)) {
 			err = gve_adjust_config(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 			if (err)
-- 
2.56.1

