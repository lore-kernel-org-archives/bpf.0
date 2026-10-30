Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793369702;
	b=ofaZlnrX8cOYw2jtIEbPXgdSqF39mIonRn1XuRifhiQdHtfujgH+PGIl3gV4d//M4RUs
	 7rkHxuKaHUN4bdtYKmMJPaTUgQLr1o1U5XZhemvb6ZFrGan2GRpEbLBQyIZZPrYxLAv/K
	 PjgBuWIclnpxkgDLG1iZbfTDZWLxs3rzFM1OxXImXBojFjNBfdfsL+G8DDDlVGHZX7FLZ
	 ebq7nuzFma8xuq8/ZZDD/T5cs97cuEp5qp0h4P7ttzV0KToW+kjBXWc/qkR5X5RTx+/ec
	 ELVItyqQ0VvLXWTnSjQlopJ0NK1/z/T3XAqQ15MvnG0Z4r8l/and3CRXMIfl3RnI11g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793369702;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3eew9hrd+oVNmH/bkvMrKCwA/OfNP3uRETS3XUKS9BU=;
	b=OjUZYi+mBZ7s3/LBYUaFA7DLi2KJ2GccvWwgJzjgymUxfHCJPthbi8kCnycK0CrQgYAr
	 iNodWfjUFLKQU9LP6eYpa+4qPkpsKM7ZsOjdiLtJ/kF8QhAopwWJ61OjNkf2acTrsI5cS
	 fZ9MQHyXSHyZNmmdgut/QKDzsY+7j3qWjDM1f3GY39unrXGi2Vi96lBTQDDF0Nze1DB+t
	 sOtLUDMvNld8jdEhQXR8RtB5p986KQ8FrA/ZLyHKRT69AvcOCpxfPmIMPtokpmH1adm2/
	 sbDdeNf0zAnSGaJ374j/RDlC95VwTG0Ai77Qp1S7qT/MxXPnDY5G9HoSRzkr7tuyT2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gD37m2ZO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5D8606A321;
	Fri, 30 Oct 2026 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gD37m2ZO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0020A1F000C1;
	Fri, 30 Oct 2026 14:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793369701;
	bh=3eew9hrd+oVNmH/bkvMrKCwA/OfNP3uRETS3XUKS9BU=;
	h=From:To:Cc:Subject:Date;
	b=gD37m2ZO1kc8314Qi3kocejmmT6/rmqkvForZZNSjqa1BOxCedRclNIDhkKWHnwHi
	 k/qDejczEyc3g7uuzgzUVm70NrksyE21qx4ON+gVWdbmBb1ZmgdsRyiLDUUUoJ8eBN
	 1Ug0IVJREIbO0oUWd+Eq3Q/HOG4ehC6rV9W6VAzYw5qhGqrZGxfdZxmavPjaxFvlkk
	 l6LefuPv+zIU5ZMjP0VyxMy+mbjuLeTMQOeUDzR2aibzt8Gx8DTuyahov8xIAsMsIQ
	 CaGgSzwCKeOrcKNdX4jWjuWSTnXUB5Yrsc+FULwq2HfTuG4ZTDoJiQC2d1cA6R+rRp
	 63tQYEymReR2A==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net] eth: fbnic: Report the logical RX queue to XDP
Date: Fri, 30 Oct 2026 15:14:50 +0100
Message-ID: <20261030141452.1173282-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fbnic reports queue 0 to XDP on all RX queues. The XDP RX queue is
registered with the header buffer queue index, which is always 0,
instead of the completion queue index, which is the netdev queue id.

Any XDP program that reads rx_queue_index gets 0 on every queue, so a
program that uses the queue id uses the wrong queue. AF_XDP has the
same problem: XSKMAP finds the wrong socket, and redirect to a socket
on another queue fails.

Triggered on fbnic hardware (50G, firmware 25.08.05-004) with AF_XDP
zero-copy: sockets on queues other than 0 got no packets. With this
fix, a socket on queue 43, and sockets on four queues at once, get
their packets. On the QEMU model with two queues, a kprobe shows 0 and
0 before the fix, and 0 and 1 after it.

Fixes: 894d4a4ea6cb ("eth: fbnic: move xdp_rxq_info_reg() to resource alloc")
Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index c572a0062e77..0bcee152d47c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -2072,7 +2072,7 @@ static int fbnic_alloc_rx_qt_resources(struct fbnic_net *fbn,
 
 	fbnic_bdq_set_page_size(&qt->sub1, rx_page_size);
 
-	err = xdp_rxq_info_reg(&qt->xdp_rxq, fbn->netdev, qt->sub0.q_idx,
+	err = xdp_rxq_info_reg(&qt->xdp_rxq, fbn->netdev, qt->cmpl.q_idx,
 			       nv->napi.napi_id);
 	if (err)
 		goto free_page_pools;

base-commit: d8a4f4c59da52b7c31ae337243b8473a19a3f819
-- 
2.56.0

