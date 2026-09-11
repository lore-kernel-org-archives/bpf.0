Received: from mta0.migadu.com (out-43.mta0.migadu.com [91.218.175.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFC5489FAE
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135076; cv=none; b=dGQz0vCFaV991B164gMH4V8XIYYLr/Uw5by/xM2KGKYE+bgUnLh6yy0a7UNC9pp96XN6VdlfjtEfDFllPJGIAShjqAy7/JLxzUD5ptJGIU0dR80koWinA+XjchWpaaFZK+BwD2/FjDjeOehVl6efgqDpBhfaCOkoGNEVbO0GEDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135076; c=relaxed/simple;
	bh=vnXi2B+daHTrr8d0jD+YCxvt2qRsjGk5xYPqsZdUD00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mcr6yAcp2YDjCjM+DDWqAJQaVeJO9uYAT7ab75PSjznfY6j97TM/cx025Abgmf2tQTbPFU/uvIyu/nCxbL+kZhEYVWp7KghWQ/W5Vzc7kY4cR0xXkaDvf87XcLqijjnqPyy4BkIpxlyrpGU8FaCyJegYpcb3Q351VbRMtWEecK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xqPzYTNZ; arc=none smtp.client-ip=91.218.175.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xqPzYTNZ"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vnXi2B+daHTrr8d0jD+YCxvt2qRsjGk5xYPqsZdUD00=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789135071; v=1; x=1789739871;
 b=xqPzYTNZuAEu5rRdHiS6DR3nsAs4wZqszkLIMSugKgQDs86jI9+/hapdMjsyGO/pCy64oEIG
 DSaEiLI/qudg+DTzo/F/Mqcee+AbW/Jfuw11JkY+S6aFtWM6gzcVYT9EejKwrOvRuP40PPWonVa
 tNElVuOp3dEOMTRW9BuOpM+Y=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 02f6325c21f55bda;
	Fri, 11 Sep 2026 13:57:51 +0000
X-Mizu-Trace-ID: 02f6325c21f55bda
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
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
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v3 1/2] bpf, veth: xdp: fix page_pool page leak on skb-backed XDP
Date: Fri, 11 Sep 2026 21:56:51 +0800
Message-ID: <20260911135711.109338-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911135711.109338-1-jiayuan.chen@linux.dev>
References: <20260911135711.109338-1-jiayuan.chen@linux.dev>
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

So record it in the xdp_buff. A dedicated mem_type field (mirroring
xdp_frame->mem_type) would read more naturally, but it grows xdp_buff, and
struct xdp_page_head embeds two of them, which shifts the layout the
xdp_do_redirect live-frames selftest hard-codes (MAX_PKT_SIZE). So use a
flag bit: add XDP_FLAGS_FRAGS_PAGE_POOL, the two skb-cow sites set it, and
bpf_xdp_shrink_data() frees the frag to the page_pool when it is set,
otherwise it keeps falling back to xdp->rxq->mem.type unchanged.

The flag describes the buff, so the buff <-> frame conversions have to keep
it consistent:
- buff -> frame: xdp_update_frame_from_buff() copies xdp->flags into the
  frame. veth XDP_TX/XDP_REDIRECT hand the frame to the peer, and cpumap
  and devmap run a second program on it, so the peer would inherit a stale
  tag; strip it, an xdp_frame describes its memory with ::mem_type.
- frame -> buff: xdp_convert_frame_to_buff() rebuilds a buff, and veth and
  devmap then run a program whose rxq says MEM_TYPE_PAGE_SHARED even for a
  page_pool frame (only cpumap copies mem_type into the rxq). A shrink
  there leaks the same way (this predates the series: bpf_xdp_adjust_tail()
  frees frags by rxq->mem.type), so re-derive the flag from the frame's
  ::mem_type.

Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
Fixes: 0ebab78cbcbf ("net: veth: add page_pool for page recycling")
Fixes: bf25146a5595 ("bpf: add frags support to the bpf_xdp_adjust_tail() API")
Reported-by: syzbot+237bbeed8dfe0699b7f5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=237bbeed8dfe0699b7f5
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 drivers/net/veth.c |  6 ++++++
 include/net/xdp.h  | 30 +++++++++++++++++++++++++++++-
 net/core/dev.c     |  6 ++++++
 net/core/filter.c  |  7 +++++++
 4 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 6ed3ee81153fb..a3fdf1959b76c 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -775,6 +775,12 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 	if (skb_shinfo(skb)->nr_frags) {
 		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
 		xdp_buff_set_frags_flag(xdp);
+		/*
+		 * A nonlinear skb was cow'd into rq->page_pool above, so the
+		 * frags must be freed to that pool, not via the rxq's
+		 * MEM_TYPE_PAGE_SHARED.
+		 */
+		xdp_buff_set_frag_pp(xdp);
 	} else {
 		xdp_buff_clear_frags_flag(xdp);
 	}
diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c358..8fd4139e9cbd3 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -81,6 +81,14 @@ enum xdp_buff_flags {
 	 * XDP program is not attached.
 	 */
 	XDP_FLAGS_FRAGS_UNREADABLE	= BIT(2),
+	/*
+	 * frags are page_pool memory even though rxq->mem.type is not: a
+	 * skb-backed XDP buff (generic XDP, veth) is cow'd into a page_pool.
+	 * xdp_buff only: an xdp_frame describes its memory with ::mem_type, so
+	 * this is stripped in xdp_update_frame_from_buff() and re-derived from
+	 * ::mem_type in xdp_convert_frame_to_buff().
+	 */
+	XDP_FLAGS_FRAGS_PAGE_POOL	= BIT(3),
 };
 
 struct xdp_buff {
@@ -131,6 +139,16 @@ static __always_inline void xdp_buff_set_frag_unreadable(struct xdp_buff *xdp)
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
@@ -394,6 +412,15 @@ void xdp_convert_frame_to_buff(const struct xdp_frame *frame,
 	xdp->data_meta = frame->data - frame->metasize;
 	xdp->frame_sz = frame->frame_sz;
 	xdp->flags = frame->flags;
+	/*
+	 * frame->flags never carries XDP_FLAGS_FRAGS_PAGE_POOL (it is stripped
+	 * in xdp_update_frame_from_buff()); re-derive it from the frame's own
+	 * memory type. veth and devmap rebuild a buff here and run a program
+	 * whose rxq says MEM_TYPE_PAGE_SHARED, so without this a shrink would
+	 * free a page_pool frag through page_frag_free().
+	 */
+	if (frame->mem_type == MEM_TYPE_PAGE_POOL)
+		xdp_buff_set_frag_pp(xdp);
 }
 
 static inline
@@ -420,7 +447,8 @@ int xdp_update_frame_from_buff(const struct xdp_buff *xdp,
 	xdp_frame->headroom = headroom - sizeof(*xdp_frame);
 	xdp_frame->metasize = metasize;
 	xdp_frame->frame_sz = xdp->frame_sz;
-	xdp_frame->flags = xdp->flags;
+	/* XDP_FLAGS_FRAGS_PAGE_POOL is xdp_buff only, don't carry it over */
+	xdp_frame->flags = xdp->flags & ~XDP_FLAGS_FRAGS_PAGE_POOL;
 
 	return 0;
 }
diff --git a/net/core/dev.c b/net/core/dev.c
index 290e0f099e6bf..94268f4d3c5f7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5532,6 +5532,12 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	if (skb_is_nonlinear(skb)) {
 		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
 		xdp_buff_set_frags_flag(xdp);
+		/*
+		 * A nonlinear skb was cow'd into page_pool memory by
+		 * skb_cow_data_for_xdp() before we got here, so the frags must
+		 * be freed to that pool, not via the rxq's MEM_TYPE_PAGE_SHARED.
+		 */
+		xdp_buff_set_frag_pp(xdp);
 	} else {
 		xdp_buff_clear_frags_flag(xdp);
 	}
diff --git a/net/core/filter.c b/net/core/filter.c
index 61940e7535523..d34ba56d79d8f 100644
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

