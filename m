Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795309278;
	b=0mZMkX5VVGIRYdB6KHoJ0TKeB8nvDF6VjNVh6nUBTMohqoUGwB6rM/w8/1zZWL+3NXLo
	 8rL52XZVJfZAe8l/YuFxmQ/Im9qJPTmDCXlyZEJCLpDWHgVd+nUZdJE1YpLggncZGczE5
	 93TW3igmrwtsuy4MyTIjbN23a1J58KvCRslRPfv3QNAQETyU0WLM2qQIQJM2eLc+GZTeC
	 FAlG2zCaJBCuwzviJyxxGZBXNMVO377j38EYsZ01W8woSr8j7Nty2arx8J2TxAHkbTtmw
	 Fs2t8GftjDOL7uS2fSJdKL5IsQ1CTVAQbpaTWbGI5ogv7o5YwibZPZohuhQUKyorfrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795309278;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vASR3wrtlLY2IgpFuIM8+QQ9SeBf8osyUZtzR9digaM=;
	b=Fn99WJwPb7MIRtq6zr+zxZPxI8pwYWHNUNbkfffFwmzDOZjZZm2bKy4kfKx1fpZYxOoV
	 1WsPuI64diQHPyTLKtb4wJHNhXh5fmJSOEP7mNjbP0JUsnZ/V0QBdmNUKQz7lUONw0ORU
	 X+FWjIYrPXPc2T5z/f9MKm+HSg73GGgeb/qi9V8lV54ZhItkSS+ZhZ+Ce762A02LIBUIT
	 1AH2eoJWx7KTnXE6VlQA5OyWRdAaznLXgQ2E8zGa9LedQj/nHJEZxnk3cNT4O3Mn4Yb+c
	 D68Eqgod8nUBytvSsQlsK3b/xtjWSWUtbfoKZ+yzaKsMa+bBA1RiIpeex110Qs2WZ3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R3lFPkE1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA47606A331;
	Sun, 22 Nov 2026 01:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R3lFPkE1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B511F000CF;
	Sun, 22 Nov 2026 01:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795309278;
	bh=vASR3wrtlLY2IgpFuIM8+QQ9SeBf8osyUZtzR9digaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R3lFPkE12bUWiEK2CVpFcLTAL4hEHMJn695Vf+zs6N7Op+j3ftcZhTBoNzYKzAaaj
	 ITvGRKajV93x9fYO+MsfelsGNhZSVsrI1QNVTyEyHjXxbC/oANQxCE9USLkajRbdmO
	 UPrTacIAv5lbppWvb7DiLafTCaLfOJEp5FJyc1NvOHDOJGUETqV7MQ/f3F/J9hwI9Q
	 j0iRrR757Ou4k9orY1op5gqy84n6iCsLLa12Pbcp6LFriuyh8ah6d/OvtFDKZr602M
	 ohiItWXM1TTtbasO9hIR44U/+mTwt+5g8QKefjr6I9a7NFKtpfmVEv5JAb5sPxPhSJ
	 GrFo0Punl+dzA==
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
Subject: [PATCH net-next v2 1/9] net: stop making HW-GRO depend on SW GRO
Date: Sat, 21 Nov 2026 17:01:04 -0800
Message-ID: <20261122010112.1471146-2-kuba@kernel.org>
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

bnxt, qede and bnx2x clear NETIF_F_GRO_HW whenever NETIF_F_GRO is off.
Nothing in the stack needs that. HW-GRO'd skbs arrive already coalesced
with gso_size set, exactly like LRO frames, and LRO never depended on
the software GRO bit. netif_elide_gro() only gates the software path,
and the in-driver consumers of the offload key off the feature bit
itself, not off NETIF_F_GRO.

The coupling gets in the way of exercising the offload on its own:
turning SW GRO off to isolate HW GRO takes HW GRO down with it on these
three drivers, which is why the GRO selftests carry a generic XDP hack.
The core only ever constrained GRO_HW on RXCSUM, RXFCS and LRO, and the
other HW-GRO capable drivers do not couple the two either.

User visible change: "ethtool -K $dev gro off" no longer implies
"rx-gro-hw off" on bnxt, qede and bnx2x.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: no change
v1: https://lore.kernel.org/20261118232315.3593731-2-kuba@kernel.org
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c       | 3 ---
 drivers/net/ethernet/qlogic/qede/qede_filter.c  | 3 +--
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index 6fb0619731ae..5686c4ecb944 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -4934,7 +4934,7 @@ netdev_features_t bnx2x_fix_features(struct net_device *dev,
 	if (!(features & NETIF_F_RXCSUM))
 		features &= ~NETIF_F_LRO;
 
-	if (!(features & NETIF_F_GRO) || !bnx2x_mtu_allows_gro(dev->mtu))
+	if (!bnx2x_mtu_allows_gro(dev->mtu))
 		features &= ~NETIF_F_GRO_HW;
 	if (features & NETIF_F_GRO_HW)
 		features &= ~NETIF_F_LRO;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 5c6c2219a481..ca7cb573d63c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14108,9 +14108,6 @@ static netdev_features_t bnxt_fix_features(struct net_device *dev,
 	if ((bp->flags & BNXT_FLAG_NO_AGG_RINGS) || bp->xdp_prog)
 		features &= ~(NETIF_F_LRO | NETIF_F_GRO_HW);
 
-	if (!(features & NETIF_F_GRO))
-		features &= ~NETIF_F_GRO_HW;
-
 	if (features & NETIF_F_GRO_HW)
 		features &= ~NETIF_F_LRO;
 
diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 5bf32f1034e0..d0e203167e35 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -915,8 +915,7 @@ netdev_features_t qede_fix_features(struct net_device *dev,
 {
 	struct qede_dev *edev = netdev_priv(dev);
 
-	if (edev->xdp_prog || edev->ndev->mtu > PAGE_SIZE ||
-	    !(features & NETIF_F_GRO))
+	if (edev->xdp_prog || edev->ndev->mtu > PAGE_SIZE)
 		features &= ~NETIF_F_GRO_HW;
 
 	return features;
-- 
2.56.1

