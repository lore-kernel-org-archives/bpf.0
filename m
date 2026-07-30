Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F93D415F21;
	Thu, 30 Jul 2026 11:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411053; cv=none; b=Iza5IEFhPN9HR5/NgZRKVZN3OZX872VBnAzKnZr1yMtPsSQ1gBzvSz4Wj7EEW+MovKO2GAqKLXTc6x1D1FWrm8M1bgYfU9EvtvPgDvtDinL82aL/roVVRgt8Txe8X5GXJSmB7fkSyTmYqgBBru3QohZDMHme0TbObcpljoDfZxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411053; c=relaxed/simple;
	bh=Ub6Mp2nb6DquI8IslixKa4+HcV2KmUpPPuDE5Snhbx0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ev80uItvAJ8eub9Xy7pT4TW/1o0ZxzZZ59WNBSHz9HG9Cucvx03txLhpEnZL4ulyflz1f2+/VoQNfcxeGuAqoV3Ly8bdityKYSOPZwMB222ajuwGJpF8763N32X9z12ielVNSjJ8kMkH8NeRnCgZvrb1Na4iLqtqIB1vSamqxlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=shWJFRr0; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="shWJFRr0"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785411042; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=YRdRWsgBCvBuNHbUYuL6LBfLlt13d1BCktM414j8G9g=;
	b=shWJFRr0iFHvWi9/Pe1gAz1MR99zGGuhx/1YGy2d2/r1TN/sme3K6SX8pmYnM9VTwaQcAD+St+75Q6amcXPeHqVBs2Q031HV1E/OsjlM1Xqi6ISxjcd3yv7sKWVoiDrQpJtZY39+GuPHer/GwMcT87q5YnzKkkzuadjY34V7kJs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X855Dqk_1785411040;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0X855Dqk_1785411040 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 30 Jul 2026 19:30:41 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH] selftests: net: reuseport_bpf_numa: consider cpuless numa node
Date: Thu, 30 Jul 2026 19:30:40 +0800
Message-Id: <20260730113040.75718-1-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'reuseport_bpf_numa' case failed on a platform with CXL memory:

	#./reuseport_bpf_numa
	---- IPv4 UDP ----
	send node 0, receive socket 0
	./reuseport_bpf_numa: failed to pin to node: Invalid argument

The root cause is that platform has 2 numa nodes: node 0 has both
cpu and memory, while node 1 is a CXL node which only has memory,
which caused numa_run_on_node() failure.

Add check to skip cpuless numa node for the numa binding test.

Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
 .../selftests/net/reuseport_bpf_numa.c        | 31 +++++++++++++++++--
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/reuseport_bpf_numa.c b/tools/testing/selftests/net/reuseport_bpf_numa.c
index 8ec52fc5ef41..197dbfc475f6 100644
--- a/tools/testing/selftests/net/reuseport_bpf_numa.c
+++ b/tools/testing/selftests/net/reuseport_bpf_numa.c
@@ -104,13 +104,35 @@ static void attach_bpf(int fd)
 	close(bpf_fd);
 }
 
-static void send_from_node(int node_id, int family, int proto)
+static inline bool is_cpuless_node(int node_id)
+{
+	struct bitmask *cpumask;
+	bool ret = false;
+
+	cpumask = numa_allocate_cpumask();
+
+	numa_node_to_cpus(node_id, cpumask);
+	if (!numa_bitmask_weight(cpumask))
+		ret = true;
+
+	numa_bitmask_free(cpumask);
+	return ret;
+}
+
+/*
+ * return -1 on node_id pointing to a cpuless node (like a CXL node),
+ * return 0 on successful numa setup
+ */
+static int send_from_node(int node_id, int family, int proto)
 {
 	struct sockaddr_storage saddr, daddr;
 	struct sockaddr_in  *saddr4, *daddr4;
 	struct sockaddr_in6 *saddr6, *daddr6;
 	int fd;
 
+	if (is_cpuless_node(node_id))
+		return -1;
+
 	switch (family) {
 	case AF_INET:
 		saddr4 = (struct sockaddr_in *)&saddr;
@@ -155,6 +177,7 @@ static void send_from_node(int node_id, int family, int proto)
 		error(1, errno, "failed to send message");
 
 	close(fd);
+	return 0;
 }
 
 static
@@ -213,7 +236,8 @@ static void test(int *rcv_fd, int len, int family, int proto)
 	for (node = 0; node < len; ++node) {
 		if (!numa_bitmask_isbitset(numa_nodes_ptr, node))
 			continue;
-		send_from_node(node, family, proto);
+		if (send_from_node(node, family, proto))
+			continue;
 		receive_on_node(rcv_fd, len, epfd, node, proto);
 	}
 
@@ -221,7 +245,8 @@ static void test(int *rcv_fd, int len, int family, int proto)
 	for (node = len - 1; node >= 0; --node) {
 		if (!numa_bitmask_isbitset(numa_nodes_ptr, node))
 			continue;
-		send_from_node(node, family, proto);
+		if (send_from_node(node, family, proto))
+			continue;
 		receive_on_node(rcv_fd, len, epfd, node, proto);
 	}
 
-- 
2.39.5 (Apple Git-154)

