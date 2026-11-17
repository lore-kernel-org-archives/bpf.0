Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794934069;
	b=V+jJdjaUZPiCj/WK5f9VkH8lgMbY3PJYe/fUIrY+sJxek5YUOqqrfBk6AV8P8TMVG0wL
	 Fm9R3Sn6HfWncGhOpirQWHTmQNuoITSxNBdRFt/rLtVSk8RJVHnMGKuzJ6mmHQ1JvSTVI
	 IF79FLqhQGIATOFlhYNiQXpXZLilICJz+HruJptY6ziAec3Flq5w5Mr9F7y/oqJw1UXNb
	 PJkUp0KyAvnUrgrjAo3ZAzH4WE8h82Qpd+UOlFYlSkrjVtryV1NjRJaV/DkSNpaXf8Tkn
	 6XeLRqUrIqlo7+3GxTUsZM73nYC5tOGH56RPMi9rPzyGXb3uNX54AXlfhkfkvmRf7kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794934069;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1khiZZjBHzBppzrHl4yMbJ8OMpTERWke5/22g0Tto2Y=;
	b=G2Jwus+qkFZ1qF7S/n7ZarivoPkTfop7TthAgex5M24QkeDw2J7sEvWfv+549J3AJa8O
	 QC9joLXRWmGyPC6JyL1LVAYzP3jpJyz2ofsxj8KVv/TiZvfxIxmOuG5GE8LIW1lhJv6RK
	 xYr0wFB3+4aOBSdFMEK7rW6Dj/smAkl0whTZq/2ppmT+0X5HJLur3RR/0EpekQhUzCXPB
	 IATKe1zMVfQi5WXEy7LPPSaYCe0khCHsOubvWfPvs4hetV9QScX9/6k19xVJH2aGrDwuy
	 01+TwW8Oimsab89McXx3XNwl9ehW/90yFDS/YF15TaUQtkWeWkLR7YsQomfcs4Mtw6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QGPuHQD4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A92F606A31C;
	Tue, 17 Nov 2026 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QGPuHQD4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7915A1F000C8;
	Tue, 17 Nov 2026 16:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794934069;
	bh=1khiZZjBHzBppzrHl4yMbJ8OMpTERWke5/22g0Tto2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QGPuHQD4JxZIoU587hPkekEou9Hb9GJKY3uPiPNwyziUqS8K+uJzynupWjYLiH98p
	 e+JPq13roehpKhdknAXnusBH+GFlOFrNpqI+FQAtYiV1JTpRq0Io1l1tBVcXQEcQfO
	 dvHjGBXbWQG4gajOlRWKS1TisK4LcR1eRK1PnqAUNuX20nWKF80z7Zdbqkvh3GPlg5
	 xDQ6RBI7/gu71ZCnRUTVfqq7nkZhzeNASZU2/xEqU7PyQOF6qJhZtbd3XQliSmUtjn
	 jLPQIijSvss7kmW5Wbg8t18Kp8FFo3XrCgVHSG/IPxk2NRb/BhKgs6/zHsXHW/7tFT
	 8V/ykCbmNfc9w==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	kernel-team@meta.com,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Weiming Shi <bestswngs@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Wei <dw@davidwei.uk>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	io-uring@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next 4/7] eth: fbnic: Run XDP on provider queues
Date: Tue, 17 Nov 2026 17:46:55 +0100
Message-ID: <20261117164700.2157816-5-bjorn@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117164700.2157816-1-bjorn@kernel.org>
References: <20261117164700.2157816-1-bjorn@kernel.org>
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

fbnic keeps headers in normal pages and attaches provider payload as
XDP fragments. The payload is mapped only for receive and must not be
sent with XDP_TX.

Drop XDP_TX while unreadable fragments remain and declare native XDP
support on provider queues. Normal page-backed packets keep their
existing behavior.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 07d4b2e92362..52f461bdc62a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1130,7 +1130,8 @@ static long fbnic_pkt_tx(struct fbnic_napi_vector *nv,
 		frag = &shinfo->frags[0];
 	}
 
-	if (fbnic_desc_unused(ring) < nsegs) {
+	if (unlikely(xdp_buff_is_frag_unreadable(&pkt->buff)) ||
+	    fbnic_desc_unused(ring) < nsegs) {
 		u64_stats_update_begin(&ring->stats.syncp);
 		ring->stats.dropped++;
 		u64_stats_update_end(&ring->stats.syncp);
@@ -3124,4 +3125,5 @@ const struct netdev_queue_mgmt_ops fbnic_queue_mgmt_ops = {
 	.ndo_default_qcfg	= fbnic_default_qcfg,
 	.ndo_validate_qcfg	= fbnic_validate_qcfg,
 	.supported_params	= QCFG_RX_PAGE_SIZE,
+	.xdp_unreadable		= true,
 };
-- 
2.56.1

