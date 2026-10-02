Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480313E8C56;
	Fri,  2 Oct 2026 19:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967673; cv=none; b=YI/OtO1IPYfr2iEgeDYRcTYXF9A4bplFBvDHJG0njmMVwLEq58qatXDPcw1YZZYeHCVARnXYMv+991ty4NzL1iUOcLHebLwlRvBF/D7TCo/D1FBmxWSSoxnvd7ygr0q/yFihBSY4L6dxXR3y7kx1A+dk7vfFGZ1dQL67SyJMZmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967673; c=relaxed/simple;
	bh=kwK8mZxlSaV9ixe2+KKgpc9XBaZkpxLuhKmu0aArgEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4n1UIVH4FZdCV6hu4EnvscE5swoEMPZIjqmmSPHXuuJnYUPgX3HcKumGQ04/XnbHr3X+Hsg8H2qDGetG1lwjwsCQG1gI1dBu3p6Lb10ZJgaWGMMxWpCPTtA6wh1AicUw/KYkxXsVtWfB652nhIPOy4BsjOZoIi0lurY7/EL20A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNyFw68C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNyFw68C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF651F000FF;
	Fri,  2 Oct 2026 19:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790967648;
	bh=rF//GN0WCNpAcEQ2Tg52h9xgf0Rsx1ipPoTJAH+Exjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bNyFw68CbrZbpHe4o0Up/4JZlFnhi8rmAt8KGulsjIZthe76td4digBEkd0PzgGJL
	 Zppm+5LjAgIECCQ22Od0vE29pRZYa8eG/A6Y/HgKzsVqGbTF5FvhjBBEDd9FLzQ5Rm
	 +XV4D6oSGywW85tIHsMfdeme5KCyEm2PXrmXfUb9ecre1QsGwjiM1zyu9MU6tRFe6y
	 7f5x+sZt152scZqUvOcIrnzvyxXPFUHA+GR/v5dyRUOtzoRDZIrgcGj+P9iPYJvmzH
	 6tLBbgAa046V91mOaOsFuXZAkbV6kDgvpMZqZwHKjWUzf4+DHZckaDK6sdtWrlEj2B
	 ix+F7QiBunQ7g==
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
Subject: [RFC net-next 02/15] eth: fbnic: Report the logical XDP RX queue
Date: Fri,  2 Oct 2026 21:00:03 +0200
Message-ID: <20261002190018.696925-3-bjorn@kernel.org>
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

XDP gives the RX queue to programs in ctx->rx_queue_index. fbnic
fills it from the header buffer queue index. The header and payload
buffer queues do not carry the netdev queue id, and the header queue
index is zero. So XDP programs see queue 0 for packets on every
queue.

Programs that act on the RX queue get the wrong value. For example,
the default AF_XDP program looks up its socket with
ctx->rx_queue_index, so it cannot find sockets on other queues.

Use the completion queue index. It is the netdev RX queue id, which
queue steering and AF_XDP socket binding use.

Tested on fbnic hardware (50G, firmware 25.08.05-004) with AF_XDP
zero-copy from the page-pool series: sockets on queue 43, and on four
queues at once, receive their packets.

Fixes: 894d4a4ea6cb ("eth: fbnic: move xdp_rxq_info_reg() to resource alloc")
Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index c62d885a678a..0c7b1ea002d8 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -2072,7 +2072,7 @@ static int fbnic_alloc_rx_qt_resources(struct fbnic_net *fbn,
 
 	fbnic_bdq_set_page_size(&qt->sub1, rx_page_size);
 
-	err = xdp_rxq_info_reg(&qt->xdp_rxq, fbn->netdev, qt->sub0.q_idx,
+	err = xdp_rxq_info_reg(&qt->xdp_rxq, fbn->netdev, qt->cmpl.q_idx,
 			       nv->napi.napi_id);
 	if (err)
 		goto free_page_pools;
-- 
2.55.0

