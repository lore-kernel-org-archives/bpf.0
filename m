Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795044273;
	b=gkYwuFRSPyRsQkppClioyTxLYSnc0g/OddgczBUStJ+5uRWgs0kxuE9hwo+0SZRM86EI
	 7dDkF/Y6UU9k2P9XRzNk0CRisdQwlliqBcrKVQf16IcooUG8IXEMd2YbYKmfox0G8heVf
	 asGcmQfvPBsoSE4q7wK1F6z5tNEFElU9UYsEDEDd0ehxEhEelY7O729MiYu/cXR7UqKi/
	 ESDGbc13/mlYJp4qyjUrnDjAIx4ntM81yO21yicSxAnz0pLYccbOR8pYoADXZ8nr6/0+J
	 uSxfDMSjpgEHO2In05iSco6x9wvDMXChQTDd+jvcjUl8/x7GWDqQdtQw4XhDMw+Wbkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795044273;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zx6OBGdvEDvh9cmjAyJHGKhXvKgD1pi9OX/jAhRPu3E=;
	b=kRNyiwWaNTI5ZgOSer0W4iInydPN4TB5qOlpeg9Uifir4MEOkQgTHw7Z1wG2CbZvvu2Z
	 aeLh/GUZPcjTJFjtNHMYtJHPP6SKUc5KbunWbV13aHayNP7mu29viKfIxgEZ7nD5YU3Eo
	 yKA26GsiR39f8ArfLZcP/BIQnzpcWC4s971uncJEBdngIC2SxJgjCBJrKAS3DNZiWTyne
	 ytChayWdUdEdgAwbMZX71ux1tnKXiFqUDHm5MtSvwU2KWV4AhTC/UtH9RflHzS0fc9S2o
	 28L1YT/DKBCDTmTcumakNq8s9NjZnOK/9funmiJ6NqRGJQBMAxPtFbG8HNyp87rjlzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ca/ABPKg";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C17606A339;
	Wed, 18 Nov 2026 23:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ca/ABPKg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142BB1F000D0;
	Wed, 18 Nov 2026 23:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795044272;
	bh=zx6OBGdvEDvh9cmjAyJHGKhXvKgD1pi9OX/jAhRPu3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ca/ABPKgBAN9TDiDdeyoNduwupBaXoomXQaq5qMUEfmsRMO5BVScj7BgivCjuxoyr
	 vhGCA/tH74uAUq9jvnsfys2N6XVW1dQ4jhZ/td5JL1knHDe0MP15jn0YOmvD8O6fH5
	 y91jUz09Guw8fPUy12VRXO5roeyJR6y7mz4SF2C7Ctcq3dbML947AUYUbg6YJ9hIRl
	 nc7dP8f0VVsFHaao7zV7FjlGCxVSZagZ/GPTgkdwwKxtI5K8I84s8I+MtuxvF929YD
	 Iop2cn0KvdBDI7H7ufjEK0yHTILea4M0hS5vN0YWecV3qcwU+6MXvSvPzck2t57zE9
	 XOMRbtRWvCjDw==
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
Subject: [PATCH net-next 6/8] eth: bnxt_en: don't clear HW-GRO and LRO for XDP in ndo_fix_features
Date: Wed, 18 Nov 2026 15:23:13 -0800
Message-ID: <20261118232315.3593731-7-kuba@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118232315.3593731-1-kuba@kernel.org>
References: <20261118232315.3593731-1-kuba@kernel.org>
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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 27c53db2c9e4..a5d22198aa11 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14089,7 +14089,7 @@ static netdev_features_t bnxt_fix_features(struct net_device *dev,
 	    bp->tx_ring_size < 2 * BNXT_SW_USO_MAX_DESCS)
 		features &= ~NETIF_F_GSO_UDP_L4;
 
-	if ((bp->flags & BNXT_FLAG_NO_AGG_RINGS) || bp->xdp_prog)
+	if (bp->flags & BNXT_FLAG_NO_AGG_RINGS)
 		features &= ~(NETIF_F_LRO | NETIF_F_GRO_HW);
 
 	if (features & NETIF_F_GRO_HW)
-- 
2.56.1

