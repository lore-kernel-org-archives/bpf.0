Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.63
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795773713;
	b=2Ow3trSkynfDeBw/We3M0ImnwkbkRuwNvpkHEmKSXzbM9eNVCFaLvCw6zTxShJY5KfVz
	 Bh7vNsVLomfQ5wZEPDXlDha9qcLtXbVemAHh5uKn5yoaB5YSzUHq37SGeKgkwFjvCwJS9
	 gmLZELILC9akUEac15tGim6hYkIpPp8PWT8hsEm9mowZMtouXrqA4CKAACuMlIlUiwBQF
	 GZ2JGxIdqUFtfMzFCkAouqHmYRuFroFHfdXay7p6IfCbZKiOO2gR9duYORzjvAfIgdRAt
	 56bIuncIfqPEvgMgSXfB/V7PG264uXIWy4D/BV0CfF5ICYWgD5jYL7fZOKBpBm2GlGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795773713;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 DKIM-Signature;
	bh=nMKkdiZF64BDuzBUvIlqX1y3Kl82ia4qMvsdvn6S/iU=;
	b=So27VZMLQ1YARpXjMKkzslq38hKVgbwuYXsPXVw/v2esBgFEURk+tdhHXKmgDZ9deoLD
	 Mx9OLgPSJCqmym1+dnsegwtvi6z7SZAU5aQqY/8pKeIsHXQKVGEJ2qGVM0YuMVwHC0TUW
	 tDXX5BMd2H4McCPRbbOefneRZlBMBkn37m251rn3oypR+mnTyxC1dX23uTkxGuqpQi9IG
	 bMB+pVgBK4g+n7PXtJoVsO/wBfksLKGYHtozuxFX6ZU7OD4JsoMOSR6Y0RTzzuhiPA/qy
	 wAuS/wrY0JsNP7ZfD6VqNEv6x1OtbsrGMsXZhG8zQqNe1FECMVzAzc2mlRwXA+JQDwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b="v/8AbKVN";
	arc=none smtp.remote-ip=217.74.67.63
Received: from smtpo63.interia.pl (smtpo63.interia.pl [217.74.67.63])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B5C606A689
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 10:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43B5C606A689
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=v/8AbKVN
Received: from localhost (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Fri, 27 Nov 2026 11:01:40 +0100 (CET)
From: Slawomir Stepien <sst@poczta.fm>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Dudu Lu <phx0fer@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tianyi Gao <tianyi@cloudflare.com>,
	Octavian Purdila <tavip@google.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Slawomir Stepien <sst@poczta.fm>,
	syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com,
	syzbot+237bbeed8dfe0699b7f5@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH net v9 1/6] xdp: run generic XDP on frags with a copy of the rxq info
Date: Fri, 27 Nov 2026 11:01:27 +0100
Message-ID: <20261127100132.1977890-2-sst@poczta.fm>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127100132.1977890-1-sst@poczta.fm>
References: <20261127100132.1977890-1-sst@poczta.fm>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1795773704; bh=nMKkdiZF64BDuzBUvIlqX1y3Kl82ia4qMvsdvn6S/iU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=v/8AbKVNkjyXEj5WFPskbma/LS0YcpIOfpaO3dvr3GtIH8fG5OIgcJ0r7PihLrf2r
	 PjMbZwxgsJJ2DTw2gsdEWlmaT99z6pp3CkgnOplNAOre555XCacHSsLQNBoQdSfR2M
	 KxEz4oquPC4X+8PyR84MkdYCW6RpQY+AoqU8KXIc=

Since commit e6d5dbdd20aa ("xdp: add multi-buff support for xdp running
in generic mode") generic XDP copies a non-linear skb into page_pool
memory with skb_pp_cow_data() and gives the program its frags. The
program still runs with the rxq info of the device queue,
dev->_rx[i].xdp_rxq, which never has a memory model, so its mem type is
MEM_TYPE_PAGE_SHARED. When the program shrinks a frag away with
bpf_xdp_adjust_tail(), bpf_xdp_shrink_data() frees the page_pool page
with page_frag_free():

  BUG: Bad page state in process ping  pfn:1f3ae
  page dumped because: page_pool leak

and a later free of the same page can hit VM_BUG_ON_PAGE() in
page_frag_free().

The mem type cannot be set in dev->_rx[i].xdp_rxq: it is shared by all
CPUs that receive on that queue and by BPF_PROG_TEST_RUN, which borrows
the rxq info of lo's queue 0. For a non-linear skb, run the program with
a copy of the rxq info on the stack that says MEM_TYPE_PAGE_POOL. The
frags of such an skb always come from skb_pp_cow_data(): when the copy
is not possible, the skb is linearized instead. The program cannot free
the head, so its memory does not matter here. The copy goes out of scope
when the function returns, so point xdp->rxq back to the device rxq info
after the program ran.

Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
Reported-by: syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ff145014d6b0ce64a173
Reported-by: syzbot+237bbeed8dfe0699b7f5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=237bbeed8dfe0699b7f5
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/all/DN3QVHST3PUQ.3NINFUW0FL9IW@gmail.com/
Cc: <stable@vger.kernel.org>
Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 net/core/dev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index cd0796a1dbfd..8f2e8c90951b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5686,6 +5686,7 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	void *orig_data, *orig_data_end, *hard_start;
 	struct netdev_rx_queue *rxqueue;
 	bool orig_bcast, orig_host;
+	struct xdp_rxq_info rxq;
 	u32 mac_len, frame_sz;
 	__be16 orig_eth_type;
 	struct ethhdr *eth;
@@ -5709,6 +5710,13 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	if (skb_is_nonlinear(skb)) {
 		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
 		xdp_buff_set_frags_flag(xdp);
+		/*
+		 * The frags came from skb_pp_cow_data(). xdp_rxq is shared
+		 * with other CPUs and with BPF_PROG_TEST_RUN, so use a copy.
+		 */
+		rxq = rxqueue->xdp_rxq;
+		rxq.mem.type = MEM_TYPE_PAGE_POOL;
+		xdp->rxq = &rxq;
 	} else {
 		xdp_buff_clear_frags_flag(xdp);
 	}
@@ -5721,6 +5729,7 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	orig_eth_type = eth->h_proto;
 
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
+	xdp->rxq = &rxqueue->xdp_rxq;
 
 	/* check if bpf_xdp_adjust_head was used */
 	off = xdp->data - orig_data;

base-commit: e9e45fcb6d39bee9325e6a7dca72bd14e82760f3
-- 
2.56.0

