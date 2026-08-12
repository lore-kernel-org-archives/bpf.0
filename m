Received: from out-186.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720DF394E93;
	Wed, 12 Aug 2026 06:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786516623; cv=none; b=ILHx2eN7hxUUEDTiNw4XHoWVDCoB5xsl4bkn0zkQoHTySaI7Vtrm/29LnskB15RooC/h2EAuIVTmlN41Hk2oxj/3LPnEI+BJbAPgPmWFMQcnUY4LeoUe5hwXxM50Gy9Ivr/qn2BfoY8bnMmvdnT0osCnIM6u6YMncwumbbxBtE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786516623; c=relaxed/simple;
	bh=S/ogqjfH9HkhtyosQmf4eBX/uyaoq7fUtJXIrZet7KI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kw5HDWhIunb6bgQOjgghZBziaRkzbuDLwUDWW32dLGZ3DTm4XkbsE7az6xBSlwdqapi6LvmDTQ1UHvYG0kcE+my0MW7HBwJRpRsobGXqYZZ5IrP6WZa9LgQ+LH8UY1pu9gu5aJi9OihnMkTVYxAkFrW6aS/1VTdp9iV2kP+yftY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BySwdubc; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BySwdubc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786516619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XORy7Jxpl+KLfcRHZ/pgPte3W64H0FUxLIs7h+b7rRQ=;
	b=BySwdubc7h3YY9TvXzHifOX+2JjhFZKNaiS2J++FYbI5/Vlp2Zvl6y/NpcGFLIwE26V+HL
	T/xYX1olAOgRb7daq+7YW8xzaY/dm5w9MzTOdzNNMcLCdUQkIoxHFV9Dkn75kYLudRQhxm
	Yo08o17rCEvU5IMKj7v+M1UBa6RRLzI=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Andrii Nakryiko <andriin@fb.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] bpf, xdp: move offload check into dev_xdp_install()
Date: Wed, 12 Aug 2026 14:36:11 +0800
Message-ID: <20260812063616.364817-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

bpf_xdp_link_update() calls dev_xdp_install() directly and skips
dev_xdp_attach(), so the checks in dev_xdp_attach() do not run. A user can
make an XDP link with a normal program and then swap in an offloaded or
device-bound program with BPF_LINK_UPDATE, which puts it on the software
path.

dev_xdp_install() is the one place all three paths go through:
"ip link set xdp" and BPF_LINK_CREATE reach it via dev_xdp_attach(), and
BPF_LINK_UPDATE calls it directly. So move the program checks (offloaded,
bound to another device, device-bound in generic mode, native vs generic,
DEVMAP and CPUMAP) there, and keep only the netlink-flag check
(XDP_FLAGS_UPDATE_IF_NOEXIST) in dev_xdp_attach().

Fixes: 026a4c28e1db3 ("bpf, xdp: Implement LINK_UPDATE for BPF XDP link")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
1. Previous topic: https://lore.kernel.org/netdev/20260811171047.4e6a409c@kernel.org/
2. Tested with tools/testing/selftests/net/bpf_offload.py and the BPF CI; both pass.
---
 net/core/dev.c | 59 ++++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index fd0b445f5d38..b390c2edfb33 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10360,6 +10360,37 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 
 	netdev_assert_locked_ops_compat(dev);
 
+	if (prog) {
+		enum bpf_xdp_mode other_mode = mode == XDP_MODE_SKB
+					       ? XDP_MODE_DRV : XDP_MODE_SKB;
+		bool offload = mode == XDP_MODE_HW;
+
+		if (!offload && dev_xdp_prog(dev, other_mode)) {
+			NL_SET_ERR_MSG(extack, "Native and generic XDP can't be active at the same time");
+			return -EEXIST;
+		}
+		if (!offload && bpf_prog_is_offloaded(prog->aux)) {
+			NL_SET_ERR_MSG(extack, "Using offloaded program without HW_MODE flag is not supported");
+			return -EINVAL;
+		}
+		if (bpf_prog_is_dev_bound(prog->aux) && !bpf_offload_dev_match(prog, dev)) {
+			NL_SET_ERR_MSG(extack, "Program bound to different device");
+			return -EINVAL;
+		}
+		if (bpf_prog_is_dev_bound(prog->aux) && mode == XDP_MODE_SKB) {
+			NL_SET_ERR_MSG(extack, "Can't attach device-bound programs in generic mode");
+			return -EINVAL;
+		}
+		if (prog->expected_attach_type == BPF_XDP_DEVMAP) {
+			NL_SET_ERR_MSG(extack, "BPF_XDP_DEVMAP programs can not be attached to a device");
+			return -EINVAL;
+		}
+		if (prog->expected_attach_type == BPF_XDP_CPUMAP) {
+			NL_SET_ERR_MSG(extack, "BPF_XDP_CPUMAP programs can not be attached to a device");
+			return -EINVAL;
+		}
+	}
+
 	if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
 	    prog && !prog->aux->xdp_has_frags) {
 		NL_SET_ERR_MSG(extack, "unable to install XDP to device using tcp-data-split");
@@ -10499,38 +10530,10 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
 		new_prog = link->link.prog;
 
 	if (new_prog) {
-		bool offload = mode == XDP_MODE_HW;
-		enum bpf_xdp_mode other_mode = mode == XDP_MODE_SKB
-					       ? XDP_MODE_DRV : XDP_MODE_SKB;
-
 		if ((flags & XDP_FLAGS_UPDATE_IF_NOEXIST) && cur_prog) {
 			NL_SET_ERR_MSG(extack, "XDP program already attached");
 			return -EBUSY;
 		}
-		if (!offload && dev_xdp_prog(dev, other_mode)) {
-			NL_SET_ERR_MSG(extack, "Native and generic XDP can't be active at the same time");
-			return -EEXIST;
-		}
-		if (!offload && bpf_prog_is_offloaded(new_prog->aux)) {
-			NL_SET_ERR_MSG(extack, "Using offloaded program without HW_MODE flag is not supported");
-			return -EINVAL;
-		}
-		if (bpf_prog_is_dev_bound(new_prog->aux) && !bpf_offload_dev_match(new_prog, dev)) {
-			NL_SET_ERR_MSG(extack, "Program bound to different device");
-			return -EINVAL;
-		}
-		if (bpf_prog_is_dev_bound(new_prog->aux) && mode == XDP_MODE_SKB) {
-			NL_SET_ERR_MSG(extack, "Can't attach device-bound programs in generic mode");
-			return -EINVAL;
-		}
-		if (new_prog->expected_attach_type == BPF_XDP_DEVMAP) {
-			NL_SET_ERR_MSG(extack, "BPF_XDP_DEVMAP programs can not be attached to a device");
-			return -EINVAL;
-		}
-		if (new_prog->expected_attach_type == BPF_XDP_CPUMAP) {
-			NL_SET_ERR_MSG(extack, "BPF_XDP_CPUMAP programs can not be attached to a device");
-			return -EINVAL;
-		}
 	}
 
 	/* don't call drivers if the effective program didn't change */
-- 
2.43.0

