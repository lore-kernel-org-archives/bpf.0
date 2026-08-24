Received: from mta1.migadu.com (out-157.mta1.migadu.com [95.215.58.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A0418DB01
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 03:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787540849; cv=none; b=u+jVH0kzxvBjESoAINq3RSozLdROBfZKG0zKr5b1pT97fuaQwvdCqPtIkxCH0fCcUxUYrqbe/FJu1tr6vrsezdHSj18aQlC7+znv/pSSux64T240MrSylPO3cuO6OHR2oehfmwXxRZMeKNuO3iFpQhbIIu3+iE9PrItVWbXPqzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787540849; c=relaxed/simple;
	bh=1cOsKJfexaSQ1bTa5o538Jx1ZZDr4HG9HjxOO3xP7mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZFFvQMWAaJ78YkkAXAe465+P/+KflDAv3HmSRG6FjvJjtKbE1qlxTeVejSil1BzzMLrjMfT/uHgNi+j/byKYW5FFkDhmTWWjckDbi996H1Qld6IMKzSjupDQcef5twnzQxfm+pF8ik9wWhtOXD6lll58osr+slaBrvfI8hxLl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SeQjKbAc; arc=none smtp.client-ip=95.215.58.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SeQjKbAc"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1cOsKJfexaSQ1bTa5o538Jx1ZZDr4HG9HjxOO3xP7mU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787540844; v=1; x=1788145644;
 b=SeQjKbAcnr755KgH9gPf0bQHJzRh1u84ZkmqLd4Nxnduykxdxz7VOjeszNC+dTu1m5gTynLq
 A1zZUO3JQgkDVV+iQJ77ZZzhUm0uk88h4t7T9te2CPkWuaDhhPnbBYY/hFOFT32kz+003vBhYD7
 otnM5eyr8G0kSbZHPXud9vpg=
X-Envelope-To: bpf@vger.kernel.org
Received: from localhost.localdomain (147.136.157.3)
	by smtp.migadu.com with ESMTPS id e332054a421fe2ea;
	Mon, 24 Aug 2026 03:07:24 +0000
X-Mizu-Trace-ID: e332054a421fe2ea
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	syzbot+237bbeed8dfe0699b7f5@syzkaller.appspotmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 1/2] bpf, veth: xdp: fix page_pool page leak on skb-backed XDP
Date: Mon, 24 Aug 2026 11:06:43 +0800
Message-ID: <20260824030705.266049-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824030257.263179-1-jiayuan.chen@linux.dev>
References: <20260824030257.263179-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_xdp_shrink_data() frees a released frag via __xdp_return() using
xdp->rxq->mem.type, but that type is wrong for skb-backed XDP: the skb is
cow'd into page_pool memory while the rxq still says MEM_TYPE_PAGE_SHARED,
so the page_pool page is freed with page_frag_free() and we hit
"Bad page state ... page_pool leak".

Both generic XDP and veth are affected. A non-linear skb is cow'd into
page_pool memory (skb_cow_data_for_xdp() -> skb_pp_cow_data() for generic
XDP, veth_convert_skb_to_xdp_buff() for veth), so its frags become
page_pool pages while the rxq keeps MEM_TYPE_PAGE_SHARED.

We can't just fix rxq->mem.type in place:
- generic XDP: xdp->rxq is dev->_rx[queue].xdp_rxq (see
  bpf_prog_run_generic_xdp()), a shared rxq that other CPUs may access in
  parallel, so we must not write to it.
- veth: rq->xdp_rxq.mem is shared per-queue state that veth resets on XDP
  teardown, and with GRO that reset runs without stopping in-flight NAPI,
  so a type stashed there can be clobbered under a packet still in flight.

Adding a check in __xdp_return() or bpf_xdp_shrink_data() itself is not an
option either: without recording it somewhere, both can only guess the
frag's memory type, which quickly gets confusing.

So record it in the xdp_buff. Add a XDP_FLAGS_FRAGS_PAGE_POOL flag; the two
skb-cow sites set it, and bpf_xdp_shrink_data() frees the frag to the
page_pool when it is set, otherwise it keeps falling back to
xdp->rxq->mem.type unchanged. No other path changes behaviour.

Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
Fixes: 0ebab78cbcbf ("net: veth: add page_pool for page recycling")
Reported-by: syzbot+237bbeed8dfe0699b7f5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=237bbeed8dfe0699b7f5
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 drivers/net/veth.c |  5 +++++
 include/net/xdp.h  | 14 ++++++++++++++
 net/core/dev.c     |  5 +++++
 net/core/filter.c  |  7 +++++++
 4 files changed, 31 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 6ed3ee81153f..0afa0661ada1 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -775,6 +775,11 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 	if (skb_shinfo(skb)->nr_frags) {
 		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
 		xdp_buff_set_frags_flag(xdp);
+		/* A nonlinear skb was cow'd into rq->page_pool above, so the
+		 * frags must be freed to that pool, not via the rxq's
+		 * MEM_TYPE_PAGE_SHARED.
+		 */
+		xdp_buff_set_frag_pp(xdp);
 	} else {
 		xdp_buff_clear_frags_flag(xdp);
 	}
diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c35..b389dc527adc 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -81,6 +81,10 @@ enum xdp_buff_flags {
 	 * XDP program is not attached.
 	 */
 	XDP_FLAGS_FRAGS_UNREADABLE	= BIT(2),
+	/* frags are page_pool memory even though rxq->mem.type is not: a
+	 * skb-backed XDP buff (generic XDP, veth) is cow'd into a page_pool.
+	 */
+	XDP_FLAGS_FRAGS_PAGE_POOL	= BIT(3),
 };
 
 struct xdp_buff {
@@ -131,6 +135,16 @@ static __always_inline void xdp_buff_set_frag_unreadable(struct xdp_buff *xdp)
 	xdp->flags |= XDP_FLAGS_FRAGS_UNREADABLE;
 }
 
+static __always_inline void xdp_buff_set_frag_pp(struct xdp_buff *xdp)
+{
+	xdp->flags |= XDP_FLAGS_FRAGS_PAGE_POOL;
+}
+
+static __always_inline bool xdp_buff_is_frag_pp(const struct xdp_buff *xdp)
+{
+	return !!(xdp->flags & XDP_FLAGS_FRAGS_PAGE_POOL);
+}
+
 static __always_inline u32 xdp_buff_get_skb_flags(const struct xdp_buff *xdp)
 {
 	return xdp->flags;
diff --git a/net/core/dev.c b/net/core/dev.c
index 38336858c168..be36020484b6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5532,6 +5532,11 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	if (skb_is_nonlinear(skb)) {
 		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
 		xdp_buff_set_frags_flag(xdp);
+		/* A nonlinear skb was cow'd into page_pool memory by
+		 * skb_cow_data_for_xdp() before we got here, so the frags must
+		 * be freed to that pool, not via the rxq's MEM_TYPE_PAGE_SHARED.
+		 */
+		xdp_buff_set_frag_pp(xdp);
 	} else {
 		xdp_buff_clear_frags_flag(xdp);
 	}
diff --git a/net/core/filter.c b/net/core/filter.c
index 61940e753552..d34ba56d79d8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4378,6 +4378,13 @@ static bool bpf_xdp_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
 	if (mem_type == MEM_TYPE_XSK_BUFF_POOL) {
 		netmem = 0;
 		zc_frag = bpf_xdp_shrink_data_zc(xdp, shrink, tail, release);
+	} else if (xdp_buff_is_frag_pp(xdp)) {
+		/*
+		 * Skb-backed XDP (generic XDP, veth) cow's the frags into a
+		 * page_pool while the rxq stays MEM_TYPE_PAGE_SHARED, so free
+		 * the frag to the pool, not via page_frag_free().
+		 */
+		mem_type = MEM_TYPE_PAGE_POOL;
 	}
 
 	if (release) {
-- 
2.43.0

