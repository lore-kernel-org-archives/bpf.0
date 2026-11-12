Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794527435;
	b=zwh9m7siGMfEsxR5GfUtIM/gHrMaYtNMxOyTHg+blLNF5gkpncq+bnlW9QH+GNegsjGK
	 Lso7cJqAbtIH4vdkfufII4Ujq+K1z75SXxkY5gqEHKH7QrhPTEnxHemRJF4YsIu6bMV7j
	 S2c5xeHN22IQ+bUPoAvyWnZIjZBQf/tQhTcRbGQtULac2t5qDT1s15ewPx/GFQ65/8RAQ
	 fkHOI1XXLkaFTKVcp6iMO4rV+/tB2UxhrVK9xjWi5KUTrBV5bpXD6iY0xqhpfyWIt4aMX
	 XGAbcAfSqGx60Xywh7lnFOICsYe6cCC8QqzxHw7M07C4pCDNLRj+w+6AaIO+LjLRtCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794527435;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1CbFla+Cutf/4Cji2KLiN7m8jOF3JEcVex4ECBlx0NQ=;
	b=zYp8PKPge2LCBMJvVEtcNrBkRBvP0bXtV8syrQ6ziS+IscYZdZCUT47q2xfXOoDVMUUL
	 Q6VbAn7onzPxp7AStWdXMkvEsTQtWbVUZaBhpFeNmakaQ9PGfku0Xq4SErTsnUlsCuRTa
	 d8xYFq0VwspJb/FLTKMA/2dRC7XnFFFDVIaykv2jcjOtU0QG8sw7C0dOfMoSwLBmXOzUV
	 vKXMO+2bpqJFepXTCBcfST64uPhUJj2PPjbTgIskpCn5/b5HuX413UkMlmknrecEQyfam
	 zDFspbb9/o4XDOu1JG4xjtOQ0tPj+eNo+3KkpIUhe19CrE9ciiB9BtZG/Rj8mpjpK/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hTTSzx10;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7FB606A882;
	Thu, 12 Nov 2026 23:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hTTSzx10
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A791F000C4;
	Thu, 12 Nov 2026 23:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794527435;
	bh=1CbFla+Cutf/4Cji2KLiN7m8jOF3JEcVex4ECBlx0NQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hTTSzx10FdA0Cf0NyCpKCbQiagKMrCgreZNv9MbUu98iXNnt/lHEPCQkFPbfrFAXT
	 Q79UtAtGlsQbbCdMmh+HqHtthTJLfodaOBTfxnee4mTPwa7Q6a+HzH7f14iht+pdmj
	 WBt0svisOEpyB4FxManvTo6Vm83RMO6c4HA1f1cziJKf7KgeDwXXF6OlnKky/bFoHD
	 hLYBpAfVAZYHG9XrhFxqEGs58OkWJ5OP/URdOCW73+vm55mByDRWA8rnvrHvld0mGY
	 FqKeXYxKo/aX0BV8SVUTu+LSPFzLFqEmfjk6u1+OAsbg7BenQt/IihER7dK12XTDCI
	 43A0Nat5SxEIw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jv@jvosburgh.net,
	haiyangz@microsoft.com,
	ast@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/5] net: move dev_xdp_set_link() and dev_xdp_set_prog() up
Date: Thu, 12 Nov 2026 15:50:24 -0800
Message-ID: <20261112235027.4072149-3-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112235027.4072149-1-kuba@kernel.org>
References: <20261112235027.4072149-1-kuba@kernel.org>
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

netif_xdp_propagate() will need dev_xdp_set_prog() in the next patch.
Move both helpers above it, no functional change.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/dev.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index a5120da879d1..69ee4342f43e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10575,6 +10575,20 @@ u8 dev_xdp_sb_prog_count(struct net_device *dev)
 	return count;
 }
 
+static void dev_xdp_set_link(struct net_device *dev, enum bpf_xdp_mode mode,
+			     struct bpf_xdp_link *link)
+{
+	dev->xdp_state[mode].link = link;
+	dev->xdp_state[mode].prog = NULL;
+}
+
+static void dev_xdp_set_prog(struct net_device *dev, enum bpf_xdp_mode mode,
+			     struct bpf_prog *prog)
+{
+	dev->xdp_state[mode].link = NULL;
+	dev->xdp_state[mode].prog = prog;
+}
+
 int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 {
 	if (!dev->netdev_ops->ndo_bpf)
@@ -10610,20 +10624,6 @@ u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode)
 	return prog ? prog->aux->id : 0;
 }
 
-static void dev_xdp_set_link(struct net_device *dev, enum bpf_xdp_mode mode,
-			     struct bpf_xdp_link *link)
-{
-	dev->xdp_state[mode].link = link;
-	dev->xdp_state[mode].prog = NULL;
-}
-
-static void dev_xdp_set_prog(struct net_device *dev, enum bpf_xdp_mode mode,
-			     struct bpf_prog *prog)
-{
-	dev->xdp_state[mode].link = NULL;
-	dev->xdp_state[mode].prog = prog;
-}
-
 static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 			   bpf_op_t bpf_op, struct netlink_ext_ack *extack,
 			   u32 flags, struct bpf_prog *prog)
-- 
2.56.0

