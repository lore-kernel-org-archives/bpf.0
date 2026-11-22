Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795309282;
	b=MlnKDLmyk2pT4lSeymMnVYQZwH/Blv/TKuk4RAQc7Fgjy3fYKv4WAHHat6EftbjocAkn
	 ITD07pmf8O3C9APhtAhuYq5FSA9GG2oxL0z3qXKgKIPJ6WazJDeJE6L0khJapHaR3Ywmj
	 ItYVwmG7JBblpnCCrG6+L44itIk0EEYZ+rl/FMgG44I+9ni5SEg/G2wLfVCGO0WIPe4Ez
	 /cs5NtNzihsCelsAmdFbg0ud60ahFfV7NA++EgPySSul2wmBr13Yz02C5v2QhbMfDE+W6
	 Rt4DBd4D7i6MmC+mkZQjcV9UANpZJ9NYS2flcb5DIgaMwVgtySKwgNAXYE1BxcBNjxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795309282;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6FgwCARGEpkpTwD2Bzkd8oOY3DFiHDLCOEA5k6QdlS0=;
	b=1MWLI/f273uuASANqVeDAVNsmBopgReZ779+WWheWf6gba/rzq0b/nIO8ZTa/9GNiV48
	 i0++e7yOe8HUsFg5kLCoGbH4/o5Bm8UDSHXiJ17PtFN/d9AtoqxwxiBfkiuDzJ/TNCJ5U
	 MNgwLCvdYwiRov8pU2DLHyUpjwyY7buv5xH/UQmYtOITXUGtjmtDzb52judAIsELAabdI
	 CzNDuRLy5snhsmeU//Jq9m81/sjNzlgLjDtY78zboht3TxTrbhBLqQcKWo9GmYk9+xmV8
	 htW5oEObk8a57kqdpPGq7I1pOw69jaTmFMfs5i1YCzn8fYsZd69Ri4yL1gA5eAd41HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VSx2p52i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE783606A68D;
	Sun, 22 Nov 2026 01:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VSx2p52i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07E51F000E6;
	Sun, 22 Nov 2026 01:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795309282;
	bh=6FgwCARGEpkpTwD2Bzkd8oOY3DFiHDLCOEA5k6QdlS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VSx2p52ivCu0LpuGlzcrVrhFSw+wVaEu0ozpY6QDENorpfUpqo5XdxWJzIdyKZ7Bc
	 cGL/z2yvzzTIb257cWlnbcVOoLrBufy2OMb/ji5xsB1NblHojyeUt5k65C8utyO9IC
	 YKot5LxPlpIyOWok8wA0pW+LgEv5h7S1DDdmvIn+L6gLqJNTQKJQcFMzTtwPZGD54s
	 SFp+LcCSVaqMaFy3sIvuhBFUUdgLHwlkVMPw5VUef/xuh5znRhB65saAGWBomAehEf
	 HffvjfUNzEdREj146aaMYcHJuQNV0zPXcgufPOr/0vZfx4m6Ud5v9Q1J62caZoWUr1
	 ClrC0D7Bq2cSA==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 7/9] eth: bnxt_en: don't clear HW-GRO and LRO for XDP in ndo_fix_features
Date: Sat, 21 Nov 2026 17:01:10 -0800
Message-ID: <20261122010112.1471146-8-kuba@kernel.org>
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

The core keeps HW-GRO and LRO off while a program is attached, from
before ndo_bpf is called until it's gone. The xdp_prog check in
bnxt_fix_features() never changes the outcome any more. Without agg
rings, which single-buffer XDP at a small MTU implies, neither offload
works, so that part stays.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: no change
v1: https://lore.kernel.org/20261118232315.3593731-7-kuba@kernel.org
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ca7cb573d63c..168ef8f08aed 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14105,7 +14105,7 @@ static netdev_features_t bnxt_fix_features(struct net_device *dev,
 	    bp->tx_ring_size < 2 * BNXT_SW_USO_MAX_DESCS)
 		features &= ~NETIF_F_GSO_UDP_L4;
 
-	if ((bp->flags & BNXT_FLAG_NO_AGG_RINGS) || bp->xdp_prog)
+	if (bp->flags & BNXT_FLAG_NO_AGG_RINGS)
 		features &= ~(NETIF_F_LRO | NETIF_F_GRO_HW);
 
 	if (features & NETIF_F_GRO_HW)
-- 
2.56.1

