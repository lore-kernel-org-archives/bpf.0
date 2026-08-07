Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9981F63D9;
	Fri,  7 Aug 2026 00:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786062291; cv=none; b=ZGK3MsPA4r4O1pVPmruf6KZuVXZzPtc+9XAMf9+KaQq+OMCbaZBFiDpG3Lxu22Q7lE6ywZI6SPZgIafQLXku4IZapM6aIB9xUisNtGDUF6b6x/uOwdCinluRUdWfvLsVhUVETXTxyeq6KMCDOYmmNO7ptoW6z79gQ1vMXhIR3Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786062291; c=relaxed/simple;
	bh=boS94ZSlKZKREDR+sAeqr4EGsykk7ip4fw7bc15aHNw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SShlNY1Twjo2KjMmVChoq+3Wmc5B4mBClkAuj/TR9ZRZ8Hv5XJt/X+MWK168tEGtHVDHsI5Lqs3CCfrf5GHbjl/QVoc3EfVZ8PESXL5McYANw4oNPbW4ZXvCO7CVoXzB672IF9BL41bCmKs3JUw9CImCpVaI2JUF4VoHvwtoJ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dRj6MU7z; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dRj6MU7z"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786062278; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Ja0xHUy1uLe/iPUk1mrxNeEqzUToXVTj7trH39SP5fg=;
	b=dRj6MU7zulj8RJR63XzbE3onnozpKcF6Eo7KolIRdbHecK9uswzRbXGern0OZ7RSxVFJkEjOCjAVdnMeFQW6A6NUbfXM6Ar7oqeTP5aTCMtfgkn6YuxsoURX7zOm0wKNEG2ODulkc43sMOlZ4E8wb4EIA3G0yXl4FZWlKzMFlY8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X8V4iI0_1786062277;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0X8V4iI0_1786062277 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Aug 2026 08:24:38 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Andi Kleen <ak@linux.intel.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH net-next v3] selftests: net: reuseport_bpf_numa: consider cpuless numa node
Date: Fri,  7 Aug 2026 08:24:36 +0800
Message-Id: <20260807002436.43991-1-feng.tang@linux.alibaba.com>
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
Changelog:
  since v2:
    * fix spelling issue (Jakub, Sashiko)
	* remove unnecessary 'inline' for is_cpuless_node() (Jakub)

  since v1:
    * address comments from Sashiko bot
      https://lore.kernel.org/all/20260730113738.41C901F000E9@smtp.kernel.org/
    * lift the cpuless node check out of send_from_node() 

 .../selftests/net/reuseport_bpf_numa.c        | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/net/reuseport_bpf_numa.c b/tools/testing/selftests/net/reuseport_bpf_numa.c
index 8ec52fc5ef41..6e4817ef57c5 100644
--- a/tools/testing/selftests/net/reuseport_bpf_numa.c
+++ b/tools/testing/selftests/net/reuseport_bpf_numa.c
@@ -104,6 +104,26 @@ static void attach_bpf(int fd)
 	close(bpf_fd);
 }
 
+/*
+ * Return true if it is a cpuless node. Return false if it isn't or any
+ * error (very unlikely) happens during the libnuma calls.
+ */
+static bool is_cpuless_node(int node_id)
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
2.43.5

