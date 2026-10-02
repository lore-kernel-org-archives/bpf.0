Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D183B3C01;
	Fri,  2 Oct 2026 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967642; cv=none; b=LCl2ictEQEuBeRNlhp13h9LtqOlVDvsWtLo1LvFLOQpPeD7Zlcd7PjfGF+nvzb9vz0kjeJX7+qXOUVz7tYNBgwGg4VBYYQGrHxKX7ZnaPpfWd2IZuaA+FNIGxy+UHtsTydtVUedNFTQpA59v4Tz7Ozf7vEJmNisALszHo725HmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967642; c=relaxed/simple;
	bh=OeYP/uD/Iq/PzT3ztRoXD6qyP1Trr1CrLpnfJEb/Dzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OA1z98UJCVQ6c2/abTP6wAZCoTgZVNrcDJVHDXH1aF6pX2JrbYxNsnQ9JfRAUyWSzVZBv/MmfHTP2VBxNm4PO/q5MTjPx0z4lDHFZX3CxPch9eJymRt7kYjoH5AkcPAkRZEACz6Y46U665qOsIJLzjeOwGxS8buUlNk4d03xrqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdRZeh0y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdRZeh0y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861DA1F00893;
	Fri,  2 Oct 2026 19:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790967641;
	bh=vM8m9eHKdpCNE8+XE3FrhRD+fibfwpH+NukLDNp0ydQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PdRZeh0y16PSDWZ6frirxvX7he1dE+oGFgOrlmmQRdeFZdYMe4e3yES9otn4M8N0Z
	 kci6A9H6J+O5n5uMrha6t+60cMCSCLv39HgYvhJHuh2bZgIC7bv+YkYe24uhsyqSdz
	 sSQQeGPMUNzQVF5TbynLmNk6f0cDuGZFyRHvPFqUJcRX2T/kH+RHy2/BfsMOZagjWq
	 tqEmLEBRafTDYHcqNpj5jgjboVQ1vwmCX35GEvo25ooYidZdwUAOTSBWj2xyLMdpBi
	 5qeAgzK4GklJGfSFMScFwhqaPkXB09BE2ikzgs0+f9xH6VtFK2z51eW8v2ZFSVdyyI
	 CFu0AYOXXqAaQ==
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
Subject: [RFC net-next 01/15] xdp: Size zero-copy skb heads by their contents
Date: Fri,  2 Oct 2026 21:00:02 +0200
Message-ID: <20261002190018.696925-2-bjorn@kernel.org>
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

xdp_build_skb_from_zc() sizes the skb head by the XSK frame size,
which leaves no room for skb_shared_info. With 2 KiB chunks, a
1514 byte frame overwrites 48 bytes of it. Both copies also round
the length up to LARGEST_ALIGN, past the end of the new buffers.

Size the head from headroom plus data, copy exactly the data, and
drop frames whose head does not fit in a page.

Discovered by an AI code review agent. Reproduced on fbnic in QEMU
with AF_XDP zero-copy from the page-pool series: an XDP program that
adds metadata, grows the frame to its end and passes it gets UMEM
bytes in the skb's shared info. A new xskxceiver test,
XDP_PASS_FULL_FRAME, checks this and passes with the fix. The test
will be posted separately.

Fixes: 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 net/core/xdp.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index 1d679e8fd649..386240bd24c9 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -709,7 +709,7 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
 		}
 
 		memcpy(page_address(page) + offset, skb_frag_address(frag),
-		       LARGEST_ALIGN(len));
+		       len);
 		__skb_fill_page_desc_noacc(sinfo, i, page, offset, len);
 
 		tsize += truesize;
@@ -738,17 +738,23 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
  */
 struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
 {
+	u32 headroom = xdp->data_meta - xdp->data_hard_start;
 	const struct xdp_rxq_info *rxq = xdp->rxq;
 	u32 len = xdp->data_end - xdp->data_meta;
-	u32 truesize = xdp->frame_sz;
 	struct sk_buff *skb = NULL;
 	struct page_pool *pp;
+	u32 truesize;
 	int metalen;
 	void *data;
 
 	if (!IS_ENABLED(CONFIG_PAGE_POOL))
 		return NULL;
 
+	/* The XSK frame size leaves no room for skb_shared_info. */
+	truesize = SKB_HEAD_ALIGN(headroom + len);
+	if (unlikely(truesize > PAGE_SIZE))
+		return NULL;
+
 	local_lock_nested_bh(&system_page_pool.bh_lock);
 	pp = this_cpu_read(system_page_pool.pool);
 	data = page_pool_dev_alloc_va(pp, &truesize);
@@ -762,9 +768,9 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
 	}
 
 	skb_mark_for_recycle(skb);
-	skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
+	skb_reserve(skb, headroom);
 
-	memcpy(__skb_put(skb, len), xdp->data_meta, LARGEST_ALIGN(len));
+	memcpy(__skb_put(skb, len), xdp->data_meta, len);
 
 	metalen = xdp->data - xdp->data_meta;
 	if (metalen > 0) {
-- 
2.55.0

