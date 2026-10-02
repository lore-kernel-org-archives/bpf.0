Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815A5332EBC;
	Fri,  2 Oct 2026 19:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967697; cv=none; b=hMtZGc2xwNY52y+TmongciyGqHnhM6BkkopgtjQRjAwp1OtUAu2XluTz2GFIS3hOJRsp4XpOQjI2ypyH87h+kSfuw0JDbnxWADqRpm0mFnNaq19jkdYohMSdjVkCQ7y1BU3Iz3FS/QJ77q/O8L3hJm0FkaNV6p7jaxOO6LVKack=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967697; c=relaxed/simple;
	bh=n8IEXdLVOwjM2Sd6CHBfxOpqStRbcdyxqFYtTY9XNxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LPRZjJbD51ph1I+ExPz0PGVnjOawczX5WRGqNAZqYGPdlHbc6Mumm/3EcLYXDRsvzLg0ouvqBvc4bjFW9izixIlEpBY/Mizk0JhySMwBId4TkxdxS6btyS1YrpCm5fZl/lH01hdBIJl60C0AlElzNguCO12coJtcMCCoY6KADtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUQKqm+q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUQKqm+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31C41F00893;
	Fri,  2 Oct 2026 19:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790967696;
	bh=vDPyKmqqls6OlM5RNXLH4F4PVsliipRxsPlZk3tQZ5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MUQKqm+q13LIQM5n5mOUREjBW86Y/wk8GIpV5BdwdjevKRRnaQMhiSiwIdguyImKq
	 Nfk2kCV+nSq1mGZiRh4mei33xDln1r+QDqRMJYlrh7f2YLpotA33anMsi5VH3RC8jU
	 Fi7VLhCKTDGMnCNhw2qggrEbqv8IkzeN7T25H6k6Hp++DyJCyZwT7eA7831pQVusQa
	 n6U8CDG7h55h8Y97WdZPPlPbMZtAT/XVmvq/oBG8wTSlHf6jUqFrA33AZTtjVt5I2c
	 vmuHlCISv9VXn7xENO7NJ9dhOARC9qep/mxQauutnoZjBtqw0SEJIm7WF5HBpJgCcq
	 yKrwmOTvNs9fQ==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Weiming Shi <bestswngs@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Wei <dw@davidwei.uk>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>
Subject: [RFC net-next 08/15] xsk: Handle a detached FILL ring in RX wakeup
Date: Fri,  2 Oct 2026 21:00:09 +0200
Message-ID: <20261002190018.696925-9-bjorn@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002190018.696925-1-bjorn@kernel.org>
References: <20261002190018.696925-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A buffer pool used as a memory provider can live longer than its
FILL ring, while an old page pool finishes a deferred destroy. The
RX need-wakeup helpers use pool->fq without a NULL check.

Read pool->fq once and return if it is NULL. A normal pool always
has a FILL ring here, so nothing changes for it.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 net/xdp/xsk.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 33475b180ea6..b68dda9c37d1 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -50,10 +50,15 @@ static struct kmem_cache *xsk_tx_generic_cache;
 
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
 {
+	struct xsk_queue *fq = READ_ONCE(pool->fq);
+
+	if (!fq)
+		return;
+
 	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
 		return;
 
-	pool->fq->ring->flags |= XDP_RING_NEED_WAKEUP;
+	fq->ring->flags |= XDP_RING_NEED_WAKEUP;
 	pool->cached_need_wakeup |= XDP_WAKEUP_RX;
 }
 EXPORT_SYMBOL(xsk_set_rx_need_wakeup);
@@ -77,10 +82,15 @@ EXPORT_SYMBOL(xsk_set_tx_need_wakeup);
 
 void xsk_clear_rx_need_wakeup(struct xsk_buff_pool *pool)
 {
+	struct xsk_queue *fq = READ_ONCE(pool->fq);
+
+	if (!fq)
+		return;
+
 	if (!(pool->cached_need_wakeup & XDP_WAKEUP_RX))
 		return;
 
-	pool->fq->ring->flags &= ~XDP_RING_NEED_WAKEUP;
+	fq->ring->flags &= ~XDP_RING_NEED_WAKEUP;
 	pool->cached_need_wakeup &= ~XDP_WAKEUP_RX;
 }
 EXPORT_SYMBOL(xsk_clear_rx_need_wakeup);
-- 
2.55.0

