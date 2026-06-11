Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEF330EF77
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181571; cv=none; b=nfSf7s5e/5gXUNvkDSrJWIdZL8oxa1vkT3ymeob7KOb+H0iwBtPKepvyz/FlgwjWwySTm/7jY9/KTCMBu4fKx+3+7MJPmR3koh8pGlENMoAJ0KpXDIfHjLOmX2OiggQexlHl0gSA5DSmKanzC1MjJ1z9RQx9VRNMP6sJfrrZw2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181571; c=relaxed/simple;
	bh=pRtqG6/YYml7TewVQ54ndwbUiRexd6hDkd4T1hgF+jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvFhgl2oh35LzNghjTDO6JrX5CWBabscyDlmw67SyTY3OGVTjHPclVgPtFVYHNTnYsMC07slS6l/Z65AeD8kju6qbUbM8aF0QoJF8dJS69ZSZKXE/C2fX7+QqG/xHLAjc/jGLNjpAoatiAwchw471+yXKA35jp81cE2KAL08aHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qmvRuGwX; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qmvRuGwX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781181567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6YFIoeIzyt0t348Z/qDx0TQhneuz7fpI7arWDgaFBqM=;
	b=qmvRuGwXY4pQaTal/zgNDUk/jzkpZ1ITd2WDeFchTT07v0hgJOVKhhGZSfXaaD3tfCvFCi
	GaFaoAz8WO2QtBuduTONyXdDm32D3urGl6NztN9vHLwFAq+U8v8qIN3J8p9EDocnBu6zm+
	jgPvvGx/kdNFhaaTcTqRjGflGBYQr/Y=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Sechang Lim <rhkrqnwk98@gmail.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
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
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Shuah Khan <shuah@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Cong Wang <cong.wang@bytedance.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 7/7] selftests/bpf: add test for bpf_msg_pop_data() overflow
Date: Thu, 11 Jun 2026 20:34:15 +0800
Message-ID: <20260611123538.156005-8-jiayuan.chen@linux.dev>
In-Reply-To: <20260611123538.156005-1-jiayuan.chen@linux.dev>
References: <20260611123538.156005-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Sechang Lim <rhkrqnwk98@gmail.com>

Add a test in sockmap_basic.c that calls bpf_msg_pop_data() with a length
close to U32_MAX, which overflows the start + len bounds check. The sk_msg
program records the return value over a sendmsg and the test checks that
the call is rejected with -EINVAL.

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 48 +++++++++++++++++++
 .../bpf/progs/test_sockmap_msg_pop_data.c     | 27 +++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_msg_pop_data.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index d2846579285f2..cb3229711f93a 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -14,6 +14,7 @@
 #include "test_sockmap_pass_prog.skel.h"
 #include "test_sockmap_drop_prog.skel.h"
 #include "test_sockmap_change_tail.skel.h"
+#include "test_sockmap_msg_pop_data.skel.h"
 #include "bpf_iter_sockmap.skel.h"
 
 #include "sockmap_helpers.h"
@@ -666,6 +667,51 @@ static void test_sockmap_skb_verdict_change_tail(void)
 	test_sockmap_change_tail__destroy(skel);
 }
 
+static void test_sockmap_msg_verdict_pop_data(void)
+{
+	struct test_sockmap_msg_pop_data *skel;
+	int err, map, verdict;
+	int c1 = -1, p1 = -1, sent;
+	int zero = 0;
+	char *buf;
+	const size_t len = 32 * 1024;
+
+	skel = test_sockmap_msg_pop_data__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	verdict = bpf_program__fd(skel->progs.prog_msg_pop_data);
+	map = bpf_map__fd(skel->maps.sock_map);
+
+	err = bpf_prog_attach(verdict, map, BPF_SK_MSG_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto out;
+
+	err = create_pair(AF_INET, SOCK_STREAM, &c1, &p1);
+	if (!ASSERT_OK(err, "create_pair"))
+		goto out;
+
+	err = bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
+		goto out_close;
+
+	buf = calloc(len, 1);
+	if (!ASSERT_OK_PTR(buf, "calloc"))
+		goto out_close;
+
+	sent = xsend(c1, buf, len, 0);
+	ASSERT_EQ(sent, (ssize_t)len, "xsend");
+	ASSERT_EQ(skel->data->pop_data_ret, -EINVAL, "pop_data_rejects overflow");
+
+	free(buf);
+
+out_close:
+	close(c1);
+	close(p1);
+out:
+	test_sockmap_msg_pop_data__destroy(skel);
+}
+
 static void test_sockmap_skb_verdict_peek_helper(int map)
 {
 	int err, c1, p1, zero = 0, sent, recvd, avail;
@@ -1373,6 +1419,8 @@ void test_sockmap_basic(void)
 		test_sockmap_skb_verdict_fionread(false);
 	if (test__start_subtest("sockmap skb_verdict change tail"))
 		test_sockmap_skb_verdict_change_tail();
+	if (test__start_subtest("sockmap msg_verdict pop_data overflow"))
+		test_sockmap_msg_verdict_pop_data();
 	if (test__start_subtest("sockmap skb_verdict msg_f_peek"))
 		test_sockmap_skb_verdict_peek();
 	if (test__start_subtest("sockmap skb_verdict msg_f_peek with link"))
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_msg_pop_data.c b/tools/testing/selftests/bpf/progs/test_sockmap_msg_pop_data.c
new file mode 100644
index 0000000000000..301e65b95256c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_msg_pop_data.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} sock_map SEC(".maps");
+
+#define POP_START 0x48a3
+#define POP_LEN   0xfffffffd
+
+long pop_data_ret = 1;
+
+SEC("sk_msg")
+int prog_msg_pop_data(struct sk_msg_md *msg)
+{
+	if (msg->size <= POP_START)
+		return SK_PASS;
+
+	pop_data_ret = bpf_msg_pop_data(msg, POP_START, POP_LEN, 0);
+	return SK_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0

