Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3DD189B84
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 03:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771902964; cv=none; b=FjxbdTOYBtdAaHrePqJElo4/4rD0Hrw56bKpg97/mnt0Ei4it390VXUKt9UpWnx5CSj0lnXSbuWcInbF9VeAZL7pazlgGOLMnK9sWMg1BK63q8KMLQrcBbus/YcdWX0YG7/jvnaEQiFxJvupD5pHpmWTmy8zde6K9UMeh5p85dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771902964; c=relaxed/simple;
	bh=aVxx/dAl9N6K1fGMuhwduxugmraw8DCjFlLI39ECSQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pFKnXZlaySoDOZzD5U3B2QFFXhLcFE/DW8LyGqUNro6Au0IwIZsprVTb2tHkf/suE0B4hU/ERR9c2vCDjhLO8XNIRF5R5+7NsMvoXxcZQz6YEkAPY3tI/3ZFNESZRcJo7OE0N2aFxV0apigQCpkqHAPvDdkqURgA/PHiI5K2+Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=utA36q1E; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="utA36q1E"
Received: from ms-a2 (99.223.13.160.dy.iij4u.or.jp [160.13.223.99])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61O3Fxws082566
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 24 Feb 2026 12:16:00 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=o9TCtDnPs0UhX9rEgkhCpMtnSuAWHpA6U1kvGCV5OAA=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1771902960; v=1;
        b=utA36q1EgWn648+1eGjNMxbzfCmx3YwvlO8xSVbqiY8pZiBFd5CY5cLiFuyF7tcn
         t9csJn6J4KcXni3loTI6LB/C0uqmKgc/K36Oks/MR8vjSPkQDoFWioUhcufxgVSQ
         YhPc71LGeJQBbCHkUFm7860nXDQT2MF1FsEYHq+z5BGr6JCvscZAXD1qLaOqZX6P
         rE3LA+RZcSjI739GFw9kBhe7HUDmUXiW9gwu8z1JO6jWjwjEkoyHXDsbBhQ+9A9a
         f1MTlqYgiarEIQIvAee2PohOjCy69ALZ9qi6ny5YpSLjqf6ZaXkJs4jtzGO1Zg/r
         mjKWdEds1X38n57HdZkePg==
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
Subject: [PATCH v3 bpf] bpf: devmap: fix stack-out-of-bounds write in get_upper_ifindexes()
Date: Tue, 24 Feb 2026 03:15:37 +0000
Message-ID: <20260224031556.38398-1-kohei@enjuk.jp>
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
When there are too many upper devices, return -EOVERFLOW and abort the
redirect.

To reproduce, create more than MAX_NEST_DEV(8) macvlans on a device with
an XDP program attached using BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS.
Then send a packet to the device to trigger the XDP redirect path.

Reported-by: syzbot+10cc7f13760b31bd2e61@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/698c4ce3.050a0220.340abe.000b.GAE@google.com/T/
Fixes: aeea1b86f936 ("bpf, devmap: Exclude XDP broadcast to master device")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
Changes:
  v3:
    - return -EOVERFLOW when there are too many upper devices
  v2: https://lore.kernel.org/bpf/20260220193039.7129-1-kohei@enjuk.jp/
    - fix formatting, accounting that max-line-length is 100
  v1: https://lore.kernel.org/bpf/20260216201428.65641-1-kohei@enjuk.jp/
---
 kernel/bpf/devmap.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 2625601de76e..d8e926a2d0da 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -588,18 +588,22 @@ static inline bool is_ifindex_excluded(int *excluded, int num_excluded, int ifin
 }
 
 /* Get ifindex of each upper device. 'indexes' must be able to hold at
- * least MAX_NEST_DEV elements.
- * Returns the number of ifindexes added.
+ * least 'max' elements.
+ * Returns the number of ifindexes added, or -EOVERFLOW if there are too 
+ * many upper devices.
  */
-static int get_upper_ifindexes(struct net_device *dev, int *indexes)
+static int get_upper_ifindexes(struct net_device *dev, int *indexes, int max)
 {
 	struct net_device *upper;
 	struct list_head *iter;
 	int n = 0;
 
 	netdev_for_each_upper_dev_rcu(dev, upper, iter) {
+		if (n >= max)
+			return -EOVERFLOW;
 		indexes[n++] = upper->ifindex;
 	}
+
 	return n;
 }
 
@@ -615,7 +619,11 @@ int dev_map_enqueue_multi(struct xdp_frame *xdpf, struct net_device *dev_rx,
 	int err;
 
 	if (exclude_ingress) {
-		num_excluded = get_upper_ifindexes(dev_rx, excluded_devices);
+		num_excluded = get_upper_ifindexes(dev_rx, excluded_devices,
+						   ARRAY_SIZE(excluded_devices) - 1);
+		if (num_excluded < 0)
+			return num_excluded;
+
 		excluded_devices[num_excluded++] = dev_rx->ifindex;
 	}
 
@@ -733,7 +741,11 @@ int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
 	int err;
 
 	if (exclude_ingress) {
-		num_excluded = get_upper_ifindexes(dev, excluded_devices);
+		num_excluded = get_upper_ifindexes(dev, excluded_devices,
+						   ARRAY_SIZE(excluded_devices) - 1);
+		if (num_excluded < 0)
+			return num_excluded;
+
 		excluded_devices[num_excluded++] = dev->ifindex;
 	}
 
-- 
2.51.0

