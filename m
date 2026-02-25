Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19A41ADC97
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 05:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771997719; cv=none; b=P7knTNyRTOgtf/RHwl0dtCinhvl86lqpXVhV1gWlB0b9Lk0uHd4gldiUDcPjXB1XUXiD0lkTzMW9VSxEuMFOZJZ9PkWRaBvfQYw6hjFdf4MS+wCYBOHkpWuUZaPQWfw6uWV4EYRD70dAclp2Bt5w/uyMrZTca57orEDRZKjGbs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771997719; c=relaxed/simple;
	bh=raUst6EgHFSUNWOAklXy55VVIibuZJSn9kDsPeRsTWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=durLBwAWhDsLJOPa6/1hVikmqyYFmQznboevlCo9yd6Wty9WEY2VgTZOBYoPkXitp6YF/w0KsVQTSvVt2DrRSaNlyFwIEm9o2XShnqUwYojp7sIWpkuuQ6ETGmeJo+08vMY+IDD2tvWc9gmiAJTxS+T7L25Y19sGf1HRexMHwIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=V1u/M3jA; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="V1u/M3jA"
Received: from ms-a2 (99.223.13.160.dy.iij4u.or.jp [160.13.223.99])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61P5Z8ri002679
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 25 Feb 2026 14:35:08 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=SaDSSFiC282MGHpI6t74xJiwhVXmx6zG1pJopAgRDFo=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1771997709; v=1;
        b=V1u/M3jA52YPTsOvTcrFsK435p4SGDKpiCsMEczaV0IMLI6z79JCRxcwjihmJJX+
         uhBONbP0LbPHewHAbS+94aKASLNSiyyC04JLbj+9mg46y/Ab+yfMGYbW+hSEICov
         7qpnWrpgpgLq/pW3bgqbkeUrjVh6NrN0E1ULGRQTJLAUCwA6ZbD2d55BnNVo/szD
         35jl54w0nHa8tsIZwEbd/giLA1lxc/+3/l//XO6a+1dgd7pjmEfaAx8ujSq3hv2X
         EVZTiDEzHgDpPct68WT7J/AKdlecU2RWNJ7MdQ10BI0gbUw+M5sMMpLPX6b2GQrT
         +EPoeRQU7yox8j44iPEoCg==
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
        syzbot+10cc7f13760b31bd2e61@syzkaller.appspotmail.com,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH v4 bpf] bpf: devmap: fix stack-out-of-bounds write in get_upper_ifindexes()
Date: Wed, 25 Feb 2026 05:34:44 +0000
Message-ID: <20260225053506.4738-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 kernel/bpf/devmap.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 2625601de76e..2984e938f94d 100644
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

