Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F2719DF55;
	Mon,  3 Aug 2026 01:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785721350; cv=none; b=pOENnUE7bLQNzyK4nvEubrfHWE+2u7snsh9vtDnu0AIV3YIczdb3Jje+CSDuQf1sW4yXT4Yo14+Er1LPhW1BbXr+KQ/1BAP1wQ9Xgs9UPCGKpbtADkqQTrfTsmdH21iaEmrQJjLfi7Xeon17SNEEwsTm93gkwHxquvSMtD9Gegk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785721350; c=relaxed/simple;
	bh=2zA5i7MuKD9bnhGW52MxyxFk+AdIcJjIvDvP95LM5fo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tCA9yy91IBaANLP1oTxLS6+7fo0MYJQAlc9ew1y8hjxSCDOd2zC5m/+PfJo6rOEvY+3Zw7ZKEjsU4brr7rNJMywpv3PtF0bYAVM5JXuGFW2OTE6AHKYUCovHs89TseClqZdvF24/uyriVIYhgM5KWcvORdFbg6VZN0Br01h/BeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vbEowzXq; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vbEowzXq"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785721337; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=7lmLiwAaZBx93q0uvTC0zp3Cej9HL9TMEv8yeN3RgsY=;
	b=vbEowzXq9OYLn4nLI2zz+9wE1Mna8mohSCWNyoJ5bbLTpwFcrhS7G3DJefZLAIyeljeahY0iTRf37eYMcCveou3ZoqHRfW0jhlqZTkN97lZXsLNPDm7BupzOa9AkWJJ7oH5xGlRHiDNSaZMp7VpiWIzM6F2DiW5gfKC8rAf24Jg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X8D.sL3_1785721336;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0X8D.sL3_1785721336 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 03 Aug 2026 09:42:16 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Andi Kleen <ak@linux.intel.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH net v2] selftests: net: reuseport_bpf_numa: consider cpuless numa node
Date: Mon,  3 Aug 2026 09:42:14 +0800
Message-Id: <20260803014214.80748-1-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reuseport_bpf_numa case failed when testing on a platform with CXL
memory:

    #./reuseport_bpf_numa
    ---- IPv4 UDP ----
    send node 0, receive socket 0
    ./reuseport_bpf_numa: failed to pin to node: Invalid argument

The root cause is that the platform has 2 numa nodes: node 0 has
both cpu and memory, while node 1 is a CXL node which only has
memory, and caused numa_run_on_node() to fail.

Add sanity check to skip cpuless numa node for the numa binding test.

Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
Changlog:

  since v1:
    * address comments from Sashiko bot
      https://lore.kernel.org/all/20260730113738.41C901F000E9@smtp.kernel.org/
	* lift the cpuless node out of send_from_node() 

 .../selftests/net/reuseport_bpf_numa.c        | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/net/reuseport_bpf_numa.c b/tools/testing/selftests/net/reuseport_bpf_numa.c
index 8ec52fc5ef41..b5fb576fa61a 100644
--- a/tools/testing/selftests/net/reuseport_bpf_numa.c
+++ b/tools/testing/selftests/net/reuseport_bpf_numa.c
@@ -104,6 +104,26 @@ static void attach_bpf(int fd)
 	close(bpf_fd);
 }
 
+/*
+ * Return true if it is a cpuless node. Return false if it isn't or any
+ * error (very unlikeyly) happens during the libnuma calls.
+ */
+static inline bool is_cpuless_node(int node_id)
+{
+	struct bitmask *cpumask;
+	bool ret = false;
+
+	cpumask = numa_allocate_cpumask();
+	if (!cpumask)
+		return ret;
+
+	if (!numa_node_to_cpus(node_id, cpumask) && !numa_bitmask_weight(cpumask))
+		ret = true;
+
+	numa_bitmask_free(cpumask);
+	return ret;
+}
+
 static void send_from_node(int node_id, int family, int proto)
 {
 	struct sockaddr_storage saddr, daddr;
@@ -213,6 +233,8 @@ static void test(int *rcv_fd, int len, int family, int proto)
 	for (node = 0; node < len; ++node) {
 		if (!numa_bitmask_isbitset(numa_nodes_ptr, node))
 			continue;
+		if (is_cpuless_node(node))
+			continue;
 		send_from_node(node, family, proto);
 		receive_on_node(rcv_fd, len, epfd, node, proto);
 	}
@@ -221,6 +243,8 @@ static void test(int *rcv_fd, int len, int family, int proto)
 	for (node = len - 1; node >= 0; --node) {
 		if (!numa_bitmask_isbitset(numa_nodes_ptr, node))
 			continue;
+		if (is_cpuless_node(node))
+			continue;
 		send_from_node(node, family, proto);
 		receive_on_node(rcv_fd, len, epfd, node, proto);
 	}
-- 
2.39.5 (Apple Git-154)

