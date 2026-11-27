Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.63
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795773709;
	b=rxfQjnPQ9z3kSqzXfoATxvH3UJna6kOhGQLYBP56iXQsijjIu8Gu4Gi/vcAw+vP+zbEE
	 g6SmadlMz4EVaAqUZR0Bsnr+HIEls/P0dtQaCiQ4cZxeSxxintQeWBCFihlYdgG+PG9gR
	 SGCdt/L6KOiIPkCqOX5yh05A+7mvJc76eelvt0ySQtC74PIlGbVnVeiDS+6yNQNuOEgbl
	 dZPV9RVSR1UOO1tl9wqZU+X+CICJYAMG1f3yuEVAhokdwq669962vuyc6WtqEG3UpqDdN
	 Rqu4URmL9e3R76ppj0+McqWLKLIGDpLXq4mtdXifR8+wuWErjUIXpFLuYJ0k2S8dzrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795773709;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 DKIM-Signature;
	bh=6LuUG7F3kfFmRHIylqR3PfTCOEnYN6Az7QPeQQLrxUc=;
	b=Ftyvh5YK+nVeHqKi1xrINZq29cB6zb5jATlFwhybdEAM9WOcqqM98bn4lSXX6idq6iOC
	 7ccxm9bAD9HgPDMAWJ/BJ5bdRjcCo6Z0gOEG9lwWcng2TuKNwbrCX+HSRY5bRM2bXVCEv
	 lgJtlt546H8Oe78W//V/xmFTPa4SGF7Pw2uT6pxbkvis9unUmRYwp9bL370me5DzhxSdd
	 4l3tc1FBVexm5XB8SQ0uxis/c7Z0DrD1ILIRMUdgPDU5GwWVROP8CYr09XbEC38/WtZhJ
	 WXv8ho3yZY1R6mlZ7GKZ4rlwb1Gv5lkcRuQBOvPsxn85eSDm8OGVR3aZMDh4u52BLog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=Tp7kirp7;
	arc=none smtp.remote-ip=217.74.67.63
Received: from smtpo63.interia.pl (smtpo63.interia.pl [217.74.67.63])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADCC606A31C
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 10:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CADCC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=Tp7kirp7
Received: from localhost (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Fri, 27 Nov 2026 11:01:45 +0100 (CET)
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
	stable@vger.kernel.org
Subject: [PATCH net v9 2/6] bpf: test_run: Set frag_size on a copy of the rxq info
Date: Fri, 27 Nov 2026 11:01:28 +0100
Message-ID: <20261127100132.1977890-3-sst@poczta.fm>
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
	t=1795773707; bh=6LuUG7F3kfFmRHIylqR3PfTCOEnYN6Az7QPeQQLrxUc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Tp7kirp7OWsDLIgbEILwAeUR2vkvkDHXcbwF2yPOHkOEpoKeFzcQZbxdJ2WaOLGLh
	 zMerJCAoFQEko6vkwwfa+ueY+p+MuSbu2uianuWBBd2dK8WymdXhQOTnlqbKeWPpGh
	 BMoGaEc9tb+JL6wt4BXO9gE2B3pRRH5nyOCeWCFw=

bpf_prog_test_run_xdp() runs the program with the rxq info of lo's
queue 0 and stores frag_size = PAGE_SIZE into it, because the frags it
allocates are full pages. That rxq info is shared with generic XDP on
lo, whose frags come from skb_pp_cow_data() and can be a part of a
page_pool page. After a test run, a generic XDP program on lo can grow
such a frag with bpf_xdp_adjust_tail() up to the end of the page, over
the data of the next frag in that page.

The store also comes too early when the test run picks the rxq info of
another device with ingress_ifindex: xdp_convert_md_to_buff() replaces
xdp->rxq after it, the frag_size of that rxq info is 0, and growing a
frag of the test run fails with -EOPNOTSUPP.

Keep lo's rxq info as it is. Once xdp_convert_md_to_buff() has chosen
the rxq info, run the program with a copy of it on the stack that has
frag_size = PAGE_SIZE.

Fixes: 1c1949982524 ("bpf: introduce frags support to bpf_prog_test_run_xdp()")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/all/sashiko-outbox-223211@kernel.org/
Link: https://lore.kernel.org/all/DN3QVHST3PUQ.3NINFUW0FL9IW@gmail.com/
Cc: <stable@vger.kernel.org>
Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 net/bpf/test_run.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index d6c9dc62182e..1d89b6f71a48 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1349,6 +1349,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 	struct netdev_rx_queue *rxqueue;
 	struct skb_shared_info *sinfo;
 	struct xdp_buff xdp = {};
+	struct xdp_rxq_info rxq;
 	int i, ret = -EINVAL;
 	struct xdp_md *ctx;
 	void *data;
@@ -1417,8 +1418,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 	}
 
 	rxqueue = __netif_get_rx_queue(current->nsproxy->net_ns->loopback_dev, 0);
-	rxqueue->xdp_rxq.frag_size = PAGE_SIZE;
-	xdp_init_buff(&xdp, rxqueue->xdp_rxq.frag_size, &rxqueue->xdp_rxq);
+	xdp_init_buff(&xdp, PAGE_SIZE, &rxqueue->xdp_rxq);
 	xdp_prepare_buff(&xdp, data, headroom, linear_sz, true);
 	sinfo = xdp_get_shared_info_from_buff(&xdp);
 
@@ -1426,6 +1426,11 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 	if (ret)
 		goto free_data;
 
+	/* generic XDP uses the same rxq and its frags can be smaller */
+	rxq = *xdp.rxq;
+	rxq.frag_size = PAGE_SIZE;
+	xdp.rxq = &rxq;
+
 	size = linear_sz;
 	if (unlikely(kattr->test.data_size_in > size)) {
 		void __user *data_in = u64_to_user_ptr(kattr->test.data_in);
-- 
2.56.0

