Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EFE279DC0
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 21:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771276612; cv=none; b=rVTBo060fvZYTp+XN4e+mQ0365Ja2zcC/0uBhRdnsU2YkFshvC/hbEIIMEcuWyuR2emSRDcpIgF4EA5kVwm6IiKct7eUz9lGtD0VWUgWi+F97TyiqIN3jKm3aovE31GO+c5f2N9aN55lpWflmMHr4CfXVbc1YlPr6AgyxR5EdVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771276612; c=relaxed/simple;
	bh=yHTub/6dAaEppxaLT/BoJuX2CsZN5Kva6LgQBUw/3UY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ndMMcJqtJPjeRPQd/uayv1IxyNGzdFQ0DNjUaPCCRRpkAlGI6oovlQG/Kj/5ZOTAyYHeTEcIcEHxk4j+X+1NUDLzOdtO+v6yWH4N9dQxXXZXRsaQhiEQ0OMD4ceRlWjlx3yw9RVhR7RZqQG48Ih0/HLoqxMbLKAjYJjO37c+Lpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=giXTq+6l; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="giXTq+6l"
Received: from ms-a2 (211.4.31.150.dy.iij4u.or.jp [150.31.4.211])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61GKETWq039148
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 17 Feb 2026 05:14:29 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=W8IeNTYHbP+UZ6w1LZGRpiOEWQPTM5igsV4ZklRjJo0=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1771272870; v=1;
        b=giXTq+6lC392xS8Tuyu9eFxsSOYzlbx15Ey56klUB/S3TAZRoak29AuiwGidYwP5
         3GbE6RQPTQ/Tyh/jAXvupNtup3s+X4VjCTXGstwMwtVsoDkAzzQusnjbGd5dgWXk
         hpvZw5qZZpmaRHf8PBBHgzgypOLz7RDVzC8rabLlFsIO4R2Ib9BNjPqo0Q2cpEdU
         7mTAS/A7VUFjMNoRKc1pQjUazPpbAi3rfOFbRGaGBBbeSNuZlPpcivjioW+3E9mB
         XBQksoVntObcey5L0ZN+btyHHq7knlg5Sj7HbZ6/xaNOpgAU3Wgqph8NpKggqZ81
         eR5zA32/pFiWZR5pHXhWSQ==
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
        Jussi Maki <joamaki@gmail.com>, kohei.enju@gmail.com,
        Kohei Enju <kohei@enjuk.jp>,
        syzbot+10cc7f13760b31bd2e61@syzkaller.appspotmail.com
Subject: [PATCH v1 bpf] bpf: devmap: fix stack-out-of-bounds write in get_upper_ifindexes()
Date: Mon, 16 Feb 2026 20:13:07 +0000
Message-ID: <20260216201428.65641-1-kohei@enjuk.jp>
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
 kernel/bpf/devmap.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 2625601de76e..cdc4299a5955 100644
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
@@ -615,7 +617,9 @@ int dev_map_enqueue_multi(struct xdp_frame *xdpf, struct net_device *dev_rx,
 	int err;
 
 	if (exclude_ingress) {
-		num_excluded = get_upper_ifindexes(dev_rx, excluded_devices);
+		num_excluded =
+			get_upper_ifindexes(dev_rx, excluded_devices,
+					    ARRAY_SIZE(excluded_devices) - 1);
 		excluded_devices[num_excluded++] = dev_rx->ifindex;
 	}
 
@@ -733,7 +737,9 @@ int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
 	int err;
 
 	if (exclude_ingress) {
-		num_excluded = get_upper_ifindexes(dev, excluded_devices);
+		num_excluded =
+			get_upper_ifindexes(dev, excluded_devices,
+					    ARRAY_SIZE(excluded_devices) - 1);
 		excluded_devices[num_excluded++] = dev->ifindex;
 	}
 
-- 
2.51.0

