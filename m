Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF61366556
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771611637; cv=none; b=oa8SZju6JZjdl1XCJt3Qq+OMK7dVfXioFrA1bUpMN0iWo/orjvqSYOqSdnXa9LvXEZk2N+TYngmjO5gZ7BgFZ7gDVCJo9pbL5i/Y3OqcmwDbDAqJXdQG2tEAsEC7pIPzYISXesnNIun6K7JdPNiI5NI5D3Kv/FtTZv6SDH+25Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771611637; c=relaxed/simple;
	bh=nsMuuFk/kq3cSDJMWIKeSA4aJRzWQVkozhQZWoCMUuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGwrVIi9Mwi3u06i+KHu0PgjfV2cB4ikadHy2eg+WqeRLdEpCK4PVIqBK7619jlytDApx+HXTDDc3aQ2cJlLf69Flt3F6g4wAQYvge0avkOfvhI53ypmKNRudcsKRIpIOGID3VFsBXze/OMW6GY8WflpYbpjeRuAVVD+ipEnlb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iaagtzjX; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iaagtzjX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771611632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sgmlbh6H6BmQox9aHPu1AdVnW79tgbRW8VeLWn91Isw=;
	b=iaagtzjXXE5i/ZBg1yJdlsbKVhr/xgKBp2vXg3gewSTs5WxqmqN4U32Vr/6tbmH7Z+ngS6
	+ZtOBOW1ng5itBZtpSt4j1hiPqWNc/xX6Znk4CJcorZql0viV+se+b59s8l5oYs4mwP5bg
	CFqoC9lgcACrpSY7ejftRbAwQ2VytYc=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v1 3/7] selftests/bpf: Replace strcpy() calls with strscpy()
Date: Fri, 20 Feb 2026 10:20:07 -0800
Message-ID: <20260220182011.802116-4-ihor.solodrai@linux.dev>
In-Reply-To: <20260220182011.802116-1-ihor.solodrai@linux.dev>
References: <20260220182011.802116-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() does not perform bounds checking and is considered deprecated
[1]. Replace strcpy() calls with strscpy(), passing size of the
destination buffer.

[1] https://docs.kernel.org/process/deprecated.html#strcpy

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/network_helpers.c           | 2 +-
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c     | 2 +-
 tools/testing/selftests/bpf/prog_tests/setget_sockopt.c | 2 +-
 tools/testing/selftests/bpf/prog_tests/sockopt_sk.c     | 2 +-
 tools/testing/selftests/bpf/prog_tests/test_veristat.c  | 4 ++--
 tools/testing/selftests/bpf/xdp_features.c              | 3 ++-
 6 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 0a6a5561bed3..5374b7e16d53 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -432,7 +432,7 @@ int make_sockaddr(int family, const char *addr_str, __u16 port,
 		memset(addr, 0, sizeof(*sun));
 		sun->sun_family = family;
 		sun->sun_path[0] = 0;
-		strcpy(sun->sun_path + 1, addr_str);
+		strscpy(sun->sun_path + 1, addr_str, sizeof(sun->sun_path) - 1);
 		if (len)
 			*len = offsetof(struct sockaddr_un, sun_path) + 1 + strlen(addr_str);
 		return 0;
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index b7d1b52309d0..2afedd08c037 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -281,7 +281,7 @@ static void test_dctcp_fallback(void)
 	dctcp_skel = bpf_dctcp__open();
 	if (!ASSERT_OK_PTR(dctcp_skel, "dctcp_skel"))
 		return;
-	strcpy(dctcp_skel->rodata->fallback_cc, "cubic");
+	strscpy(dctcp_skel->rodata->fallback_cc, "cubic", sizeof(dctcp_skel->rodata->fallback_cc));
 	if (!ASSERT_OK(bpf_dctcp__load(dctcp_skel), "bpf_dctcp__load"))
 		goto done;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c b/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
index e4dac529d424..7905fbe11447 100644
--- a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
@@ -212,7 +212,7 @@ void test_setget_sockopt(void)
 	if (!ASSERT_OK_PTR(skel, "open skel"))
 		goto done;
 
-	strcpy(skel->rodata->veth, "binddevtest1");
+	strscpy(skel->rodata->veth, "binddevtest1", sizeof(skel->rodata->veth));
 	skel->rodata->veth_ifindex = if_nametoindex("binddevtest1");
 	if (!ASSERT_GT(skel->rodata->veth_ifindex, 0, "if_nametoindex"))
 		goto done;
diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
index ba6b3ec1156a..fb0414292af6 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
@@ -142,7 +142,7 @@ static int getsetsockopt(void)
 
 	/* TCP_CONGESTION can extend the string */
 
-	strcpy(buf.cc, "nv");
+	strscpy(buf.cc, "nv", sizeof(buf.cc));
 	err = setsockopt(fd, SOL_TCP, TCP_CONGESTION, &buf, strlen("nv"));
 	if (err) {
 		log_err("Failed to call setsockopt(TCP_CONGESTION)");
diff --git a/tools/testing/selftests/bpf/prog_tests/test_veristat.c b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
index b38c16b4247f..de3aab986060 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_veristat.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
@@ -24,9 +24,9 @@ static struct fixture *init_fixture(void)
 
 	/* for no_alu32 and cpuv4 veristat is in parent folder */
 	if (access("./veristat", F_OK) == 0)
-		strcpy(fix->veristat, "./veristat");
+		strscpy(fix->veristat, "./veristat", sizeof(fix->veristat));
 	else if (access("../veristat", F_OK) == 0)
-		strcpy(fix->veristat, "../veristat");
+		strscpy(fix->veristat, "../veristat", sizeof(fix->veristat));
 	else
 		PRINT_FAIL("Can't find veristat binary");
 
diff --git a/tools/testing/selftests/bpf/xdp_features.c b/tools/testing/selftests/bpf/xdp_features.c
index 595c79141cf3..5649d2dda9cc 100644
--- a/tools/testing/selftests/bpf/xdp_features.c
+++ b/tools/testing/selftests/bpf/xdp_features.c
@@ -16,6 +16,7 @@
 
 #include <network_helpers.h>
 
+#include "bpf_util.h"
 #include "xdp_features.skel.h"
 #include "xdp_features.h"
 
@@ -212,7 +213,7 @@ static void set_env_default(void)
 	env.feature.drv_feature = NETDEV_XDP_ACT_NDO_XMIT;
 	env.feature.action = -EINVAL;
 	env.ifindex = -ENODEV;
-	strcpy(env.ifname, "unknown");
+	strscpy(env.ifname, "unknown", sizeof(env.ifname));
 	make_sockaddr(AF_INET6, "::ffff:127.0.0.1", DUT_CTRL_PORT,
 		      &env.dut_ctrl_addr, NULL);
 	make_sockaddr(AF_INET6, "::ffff:127.0.0.1", DUT_ECHO_PORT,
-- 
2.53.0

