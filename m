Received: from mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603413112BD
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 03:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786849984; cv=none; b=JbjnCOEa1j8j9lZHsLX/imglviRdQQmYgDolEw2HWeQWoEi8WX1bzrQNXXR1m4Gor+W2MIkPc8uab7q/HWyZLeUDUFcmo4uB77eI9DwFDvy0MQR5xH8munLMDh9o/Zfz0+zTRzWjWR+FR8sTFLrxas05epvOcb8wGeygy5fmhT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786849984; c=relaxed/simple;
	bh=tdSXhfKPBmr6MST1I8C/uR1Kdmcx+UL4ewFZ1ZQwFTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qkTrtvIyRWTXz/ikmHWne8PVWErQrlByqu4Abv8Xq4C8PYpKSiw83T9H900GvoTbxl1ceRL3Ww/A0HpWt/UUV5u75/5HGk4kv1t5Yzf4BlY7Gh03bvegWE1rhHnGFd7qH28rs37PdzvEMuVTH3ZxJDNTlIszMz/H21Fexue+ctA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jtPjulI0; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jtPjulI0"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=tdSXhfKPBmr6MST1I8C/uR1Kdmcx+UL4ewFZ1ZQwFTw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786849980; v=1; x=1787454780;
 b=jtPjulI0/IjXl8hUK6nw7YKLlAwhHZ/LuQ7dTq7IRdcNNiKS+q5hTzsJjpFfh6GdFbef75Cl
 Moy2Uw/DO42YYbQKjTy+Jsc0bpHiXkIAWnFEenzB5B+ZFjT0z2nHVLn3rwHv93ZnvEqezv9LPLA
 Cyzl6ziR674D4PWl3OgtXJWU=
X-Envelope-To: bpf@vger.kernel.org
Received: from localhost.localdomain (147.136.157.0)
	by smtp.migadu.com with ESMTPS id 32598bf85429cbd8;
	Sun, 16 Aug 2026 03:12:59 +0000
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	syzbot+237bbeed8dfe0699b7f5@syzkaller.appspotmail.com,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf: free page_pool frags via the page_pool path in bpf_xdp_shrink_data
Date: Sun, 16 Aug 2026 11:12:44 +0800
Message-ID: <20260816031245.268898-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a "Bad page state ... page_pool leak" when a generic XDP
program shrinks an skb into its frags on the tun write() path:

  page_frag_free
  __xdp_return
  bpf_xdp_shrink_data
  bpf_xdp_frags_shrink_tail
  bpf_xdp_adjust_tail

When a program shrinks a whole frag, bpf_xdp_shrink_data() frees it via
__xdp_return() using xdp->rxq->mem.type. For skb-backed XDP the skb is
first rebuilt into page_pool memory (skb_cow_data_for_xdp() for generic
XDP, skb_pp_cow_data() for veth), so the frag is a page_pool page. But the
rxq was registered as MEM_TYPE_PAGE_SHARED, so __xdp_return() calls
page_frag_free() on a page_pool page: its base refcount drops to 0 and the
page is freed to the buddy allocator with pp_magic still set.

The rxq mem model cannot be relied on here because the rxq is shared and
does not describe the frag's real memory. The netdev generic rxq is used
both by generic XDP (page_pool frags) and by bpf_prog_test_run_xdp(), which
borrows the loopback rxq for plain alloc_page() frags; veth uses one rxq
for cow'd (page_pool) skbs and for redirected frames of any memory type. A
single rxq->mem.type can be wrong in either direction.

The memory type is really a property of the page. Check the frag itself
with netmem_is_pp() and return page_pool frags to their pool, keeping the
rxq mem type only for non page_pool pages. The page_pool is taken from the
page (netmem_get_pp()), so no rxq registration is involved.

Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
Fixes: 0ebab78cbcbf ("net: veth: add page_pool for page recycling")
Reported-by: syzbot+237bbeed8dfe0699b7f5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=237bbeed8dfe0699b7f5
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/filter.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 3423734124a5..4536bd147c25 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -89,6 +89,7 @@
 #include <net/ip6_route.h>
 
 #include "dev.h"
+#include "netmem_priv.h"
 
 /* Keep the struct bpf_fib_lookup small so that it fits into a cacheline */
 static_assert(sizeof(struct bpf_fib_lookup) == 64, "struct bpf_fib_lookup size check");
@@ -4293,6 +4294,14 @@ static bool bpf_xdp_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
 	if (mem_type == MEM_TYPE_XSK_BUFF_POOL) {
 		netmem = 0;
 		zc_frag = bpf_xdp_shrink_data_zc(xdp, shrink, tail, release);
+	} else if (netmem_is_pp(netmem)) {
+		/* The rxq mem model does not always describe how a released
+		 * frag must be freed: the generic-XDP and veth paths run the
+		 * program on a shared rxq while the frag has been cow'd into
+		 * page_pool memory. Trust the page itself and return a
+		 * page_pool frag to its pool regardless of rxq->mem.type.
+		 */
+		mem_type = MEM_TYPE_PAGE_POOL;
 	}
 
 	if (release) {
-- 
2.43.0

