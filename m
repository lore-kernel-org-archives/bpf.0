Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395BC72618
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771615854; cv=none; b=WJRYR/q3c2ic1XFh4rAjxYxoTGj/9kyFPDMUCxKkfiGj9Ql6DtwKIfTRnK+IM8yubJuPE+Aj/JFgfa7v7+sVK1WDvJhB7B4CMIAQw7k/aV4+rqbeo3oUiDrpg0N6pops8kYKfuA2jpPxh1QLGc9DzJ5W4801iLDvCkzoSpSiXqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771615854; c=relaxed/simple;
	bh=2zlgzy8tMLgAVXnkhjww6tl7qwzbhqNbvtglCF+jBTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A0v7jMAg3OFG+WTaKlzNdZQpaK0qNRJSFWo8J5inoRvDZl+DuKP5eq9D55XljeJZhKVbN6vn4bOxzJ9cWt0c3zG0VGoKUlP+gg8QWjLMT9OW323Fqz26zWZYGsFFhYsCR9smAhECaE/7YxhS/aPYXG1GPYU7VgR7Ox64kNYg/U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=dntj9rys; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="dntj9rys"
Received: from ms-a2 (54.52.30.125.dy.iij4u.or.jp [125.30.52.54])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61KJUpva004592
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 21 Feb 2026 04:30:51 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=8g8OID58uVFy8gevFzmKG0HT71La/krGCOGvXbey9UI=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1771615851; v=1;
        b=dntj9rysRXD8nkifW7mP7edJpQr7UVzuB+6C/AnAlfrHQGQPlGt//GrSKEZO/6nt
         lkgFeufqrKY4/5fDpUKlrDQiPqy51fJMumdkIACeiumoo3HtyoTCEgHeh9PEtsEm
         GLhCtxu6z/nByhkhDMkIYC6Mf9xOxuNIr5iBOYpoXEoudU5Yy98PDFhL6Vb4AKCk
         8+z5IQlLpF6Vp8dPSWBy0OMLDvPXeSOZZcyjCIZF62ATWTUDV0OnaELvNgczc64V
         PS+oR+Y+6VFg5vQ6csCvQ+kXFgQjiBQyJR4zLu+9IO8tFvFNHcZfE3xAwGSgFpOq
         iijGeHKmFunXI6J9yF+XzA==
From: Kohei Enju <kohei@enjuk.jp>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jussi Maki <joamaki@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        kohei.enju@gmail.com, Kohei Enju <kohei@enjuk.jp>,
        syzbot+10cc7f13760b31bd2e61@syzkaller.appspotmail.com
Subject: [PATCH v2 bpf] bpf: devmap: fix stack-out-of-bounds write in get_upper_ifindexes()
Date: Fri, 20 Feb 2026 19:29:45 +0000
Message-ID: <20260220193039.7129-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_upper_ifindexes() iterates over all upper devices and writes their
indices into an array without checking bounds.

Also the callers assume that the max number of upper devices is
MAX_NEST_DEV and allocate excluded_devices[1+MAX_NEST_DEV] on the stack,
but that assumption is not correct and the number of upper devices could
be larger than MAX_NEST_DEV (e.g., many macvlans), causing a
stack-out-of-bounds write.

Add a max parameter to get_upper_ifindexes() to avoid the issue.

To reproduce, create more than MAX_NEST_DEV(8) macvlans on a device with
an XDP program attached using BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS.
Then send a packet to the device to trigger the XDP redirect path.

Reported-by: syzbot+10cc7f13760b31bd2e61@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/698c4ce3.050a0220.340abe.000b.GAE@google.com/T/
Fixes: aeea1b86f936 ("bpf, devmap: Exclude XDP broadcast to master device")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
Changes:
  v2:
    - fix formatting, accounting that max-line-length is 100
  v1: https://lore.kernel.org/bpf/20260216201428.65641-1-kohei@enjuk.jp/
---
 kernel/bpf/devmap.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 2625601de76e..c8c49d86a403 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -588,16 +588,18 @@ static inline bool is_ifindex_excluded(int *excluded, int num_excluded, int ifin
 }
 
 /* Get ifindex of each upper device. 'indexes' must be able to hold at
- * least MAX_NEST_DEV elements.
+ * least 'max' elements.
  * Returns the number of ifindexes added.
  */
-static int get_upper_ifindexes(struct net_device *dev, int *indexes)
+static int get_upper_ifindexes(struct net_device *dev, int *indexes, int max)
 {
 	struct net_device *upper;
 	struct list_head *iter;
 	int n = 0;
 
 	netdev_for_each_upper_dev_rcu(dev, upper, iter) {
+		if (n >= max)
+			break;
 		indexes[n++] = upper->ifindex;
 	}
 	return n;
@@ -615,7 +617,8 @@ int dev_map_enqueue_multi(struct xdp_frame *xdpf, struct net_device *dev_rx,
 	int err;
 
 	if (exclude_ingress) {
-		num_excluded = get_upper_ifindexes(dev_rx, excluded_devices);
+		num_excluded = get_upper_ifindexes(dev_rx, excluded_devices,
+						   ARRAY_SIZE(excluded_devices) - 1);
 		excluded_devices[num_excluded++] = dev_rx->ifindex;
 	}
 
@@ -733,7 +736,8 @@ int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
 	int err;
 
 	if (exclude_ingress) {
-		num_excluded = get_upper_ifindexes(dev, excluded_devices);
+		num_excluded = get_upper_ifindexes(dev, excluded_devices,
+						   ARRAY_SIZE(excluded_devices) - 1);
 		excluded_devices[num_excluded++] = dev->ifindex;
 	}
 
-- 
2.51.0

