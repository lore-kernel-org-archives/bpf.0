Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795786203;
	b=kjPHxn24Qdw6Buuwztako+YvfhK7rGVf3/6evJmzurnqg69jVZSBKjqWxCMLRmLmCHYd
	 /B8sXC6J0MF1+tKuLBNbfytXBqHK2F9l3DAhjoFGO+db7RFVRltzSEpHokUwpDfIIHwFV
	 AEKvj71ven2cv99NdYRJP+YrUZWUgjJq1dFKc2fJUlv4heGwFStlkMezUtG4gw7BLmCOP
	 9O/MI/VIhEajdLMM29tOplD4NN0fxKSFOhA9ZOvjvIceiU5YChHYXUzK/MF2JywKFHvRc
	 LdQKbPAi+9iQ+vFznSPJOXdu0LqnRL1lleYtPu9jIB+C2K+GmdzDf4EeoVEVeNQ7MzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795786203;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:MIME-Version:Content-Transfer-Encoding:X-CMS-MailID:
	 X-Msg-Generator:Content-Type:CMS-TYPE:X-CPGSPASS:cpgsPolicy:
	 X-CFilter-Loop:X-CMS-RootMailID:References;
	bh=bEv+hQm3eXyw3BvNSKGemgO4AzU5CIYlzvjVm8xOefA=;
	b=lCzY2PghKI/84Zvn52gv+WwXmk4up3tyzkCocRzZmVWy8XqaG5Ka5jWWFUgguX8s3kTz
	 XpLJKx7XcalQpkglsJr0IcNDJ94fnlncrOBJkCBGBLTXznHCG2A44FL7XPJdcs97rXbXN
	 wkIdQJW9YvNKO+UL3590mcSMj28NPH24+72mAZ7TbPuzQpEi42k78tqymRD8q36ZsiwmO
	 if8FGloUsvp8dYSzcbXDWR0HC3BIcBWwj6mZ0O63ziuhO53uAp9rmgwPvaZH8onDkg/iQ
	 Mua39IThlfCCYdORkS9dZiyi+RQEN71jIUzVn74MRxYkvl3gDT8x9BT3CXcrFs4B2Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=nO833aR+;
	arc=none smtp.remote-ip=203.254.224.34
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724BF606A326
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 13:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 724BF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=nO833aR+
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20261127133000epoutp04788e306a13b6034907d9d9ba462fd3db~r6gjq3fT22985929859epoutp04V
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 13:30:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20261127133000epoutp04788e306a13b6034907d9d9ba462fd3db~r6gjq3fT22985929859epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795786200;
	bh=bEv+hQm3eXyw3BvNSKGemgO4AzU5CIYlzvjVm8xOefA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nO833aR+gbEcTgvJwE0mi9yV7J8+O+UMw77hvmEg41yNFwqmtmoelK9u4HL49Kqhz
	 XScA9OBDdhpmeb4JXa1BblDl6n4En+Xt5eh4ySImFNDmx7fwUqPzNSipbNkKrmBIUG
	 +8vZin8W7Hevtf9Z6msmJuHUIvPwnVlJnHUfZaeY=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20261127132959epcas5p45b577a42def93e663ccc0e0e2766e909~r6gjE7xGl2919529195epcas5p4w;
	Fri, 27 Nov 2026 13:29:59 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.93]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4jbZ5y447lz3hhT4; Fri, 27 Nov
	2026 13:29:58 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20261127132957epcas5p4248d663f22ade00f0c45e349365bb3e8~r6ghXNje22027720277epcas5p4W;
	Fri, 27 Nov 2026 13:29:57 +0000 (GMT)
Received: from ws2030076956.sa.corp.samsungelectronics.net (unknown
	[107.99.235.31]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261127132954epsmtip205472b8d23c7fef3ab60ea87c36f3f18~r6gd10t621688316883epsmtip2O;
	Fri, 27 Nov 2026 13:29:54 +0000 (GMT)
From: Irlanki Sandeep <irlanki.s@samsung.com>
To: kuniyu@google.com
Cc: alexei.starovoitov@gmail.com, ameryhung@gmail.com, andrii@kernel.org,
	ast@kernel.org, bpf@vger.kernel.org, corbet@lwn.net, cpgs@samsung.com,
	daeil2.hwang@samsung.com, daniel@iogearbox.net, davem@davemloft.net,
	edumazet@google.com, g.pokhra@samsung.com, irlanki.s@samsung.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org, lorenzo@google.com,
	madhan.raj@samsung.com, maze@google.com, motomuman@google.com,
	ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com,
	r.kumawat@samsung.com, raj.kumars@samsung.com, ramyashree.s@samsung.com,
	sharmasagarika@google.com, sporeba@google.com, srihari.k@samsung.com,
	ts413.lee@samsung.com
Subject: [PATCH bpf-next v10 2/2] selftests/bpf: add selftests for
 bpf_tcp_ops ecn_init
Date: Fri, 27 Nov 2026 19:00:51 +0530
Message-Id: <20261127133051.2540069-2-irlanki.s@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127133051.2540069-1-irlanki.s@samsung.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261127132957epcas5p4248d663f22ade00f0c45e349365bb3e8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-065,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261127132957epcas5p4248d663f22ade00f0c45e349365bb3e8
References: <20261127132411.2523201-1-irlanki.s@samsung.com>
	<20261127133051.2540069-1-irlanki.s@samsung.com>
	<CGME20261127132957epcas5p4248d663f22ade00f0c45e349365bb3e8@epcas5p4.samsung.com>

Add a bpf_tcp_ops struct_ops selftest for the new ecn_init callback. It
runs over IPv4 and IPv6 loopback connections. For each case the test sets
net.ipv4.tcp_ecn, and the BPF program returns the ECN mode for the active
and the passive side. The seven cases are:

- BPF enables classic RFC3168 ECN while the sysctl disables ECN.
- BPF enables AccECN while the sysctl disables ECN.
- Client requests AccECN, server accepts only classic ECN: negotiation
  ends at RFC3168.
- Server BPF refuses ECN while the sysctl allows it.
- Client BPF returns no ECN while the sysctl allows it.
- Out-of-range return value (6) falls back to the sysctl.
- Negative return value falls back to the sysctl.

For each case the test checks that ecn_init() runs once on the
active side. On the passive side it runs once when the SYN requests
ECN (AccECN or ECE+CWR). If the client's SYN requests neither, the
kernel skips the call and the test expects no passive invocation.
When the program runs, bpf_get_retval() must be seeded with the
sysctl value on that side. The negotiated ECN mode on the client
and accepted sockets must match the expected value.

Signed-off-by: Irlanki Sandeep <irlanki.s@samsung.com>
---
v9 -> v10:
 - Split the selftests into a separate patch

 .../bpf/prog_tests/bpf_tcp_ops_ecn.c          | 224 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_tcp_ops_ecn.c     |  57 +++++
 2 files changed, 281 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_ecn.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_tcp_ops_ecn.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_ecn.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_ecn.c
new file mode 100644
index 000000000000..f74791676585
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_ecn.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Samsung Electronics Co., Ltd. */
+
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "cgroup_helpers.h"
+#include "bpf_tcp_ops_ecn.skel.h"
+
+#define CGROUP_PATH	"/bpf_tcp_ops_ecn"
+#define TEST_NETNS	"bpf_tcp_ops_ecn"
+
+/* Must match progs/bpf_tcp_ops_ecn.c */
+#define TCP_ECN_MODE_DISABLED	0x00
+#define TCP_ECN_MODE_RFC3168	0x01
+#define TCP_ECN_MODE_ACCECN	0x10
+
+struct ecn_case {
+	const char *name;
+	int sysctl_ecn;		/* net.ipv4.tcp_ecn in the test netns */
+	int retval_active;	/* ecn_init() return value, active open */
+	int retval_passive;	/* ecn_init() return value, passive open */
+	__u32 mode_client;	/* expected ECN mode on the client socket */
+	__u32 mode_server;	/* expected ECN mode on the accepted socket */
+	bool passive_runs;	/* ecn_init() runs on passive side: SYN requests ECN */
+};
+
+/*
+ * net.ipv4.tcp_ecn / ecn_init() values (enum tcp_ecn_mode): 0 == no ECN,
+ * 1 == accept + request RFC3168 ECN, 3 == accept + request AccECN.
+ */
+static const struct ecn_case ecn_cases[] = {
+	{
+		/* The sysctl disables ECN; BPF negotiates RFC3168 ECN. */
+		.name = "bpf_enables_classic",
+		.passive_runs = true,
+		.sysctl_ecn = 0,
+		.retval_active = 1,
+		.retval_passive = 1,
+		.mode_client = TCP_ECN_MODE_RFC3168,
+		.mode_server = TCP_ECN_MODE_RFC3168,
+	},
+	{
+		/* The sysctl disables ECN; BPF negotiates AccECN. */
+		.name = "bpf_enables_accecn",
+		.passive_runs = true,
+		.sysctl_ecn = 0,
+		.retval_active = 3,
+		.retval_passive = 3,
+		.mode_client = TCP_ECN_MODE_ACCECN,
+		.mode_server = TCP_ECN_MODE_ACCECN,
+	},
+	{
+		/*
+		 * The client requests AccECN but the server only accepts
+		 * RFC3168 ECN (< 3): negotiation degrades to RFC3168.
+		 */
+		.name = "passive_clamps_accecn",
+		.passive_runs = true,
+		.sysctl_ecn = 0,
+		.retval_active = 3,
+		.retval_passive = 1,
+		.mode_client = TCP_ECN_MODE_RFC3168,
+		.mode_server = TCP_ECN_MODE_RFC3168,
+	},
+	{
+		/* The server refuses ECN although the sysctl allows it. */
+		.name = "passive_refuses_ecn",
+		.passive_runs = true,
+		.sysctl_ecn = 1,
+		.retval_active = 3,
+		.retval_passive = 0,
+		.mode_client = TCP_ECN_MODE_DISABLED,
+		.mode_server = TCP_ECN_MODE_DISABLED,
+	},
+	{
+		/*
+		 * The client does not request ECN although the sysctl
+		 * allows it, so there is nothing for the server to accept.
+		 */
+		.name = "active_disables_ecn",
+		.passive_runs = false,
+		.sysctl_ecn = 1,
+		.retval_active = 0,
+		.retval_passive = 3,
+		.mode_client = TCP_ECN_MODE_DISABLED,
+		.mode_server = TCP_ECN_MODE_DISABLED,
+	},
+	{
+		/*
+		 * Return values above TCP_ECN_IN_ACCECN_OUT_NOECN fall back
+		 * to the sysctl on both sides.
+		 */
+		.name = "fallback_above_range",
+		.passive_runs = true,
+		.sysctl_ecn = 1,
+		.retval_active = 6,
+		.retval_passive = 6,
+		.mode_client = TCP_ECN_MODE_RFC3168,
+		.mode_server = TCP_ECN_MODE_RFC3168,
+	},
+	{
+		/* Negative return values fall back to the sysctl too. */
+		.name = "fallback_negative",
+		.passive_runs = true,
+		.sysctl_ecn = 1,
+		.retval_active = -1,
+		.retval_passive = -1,
+		.mode_client = TCP_ECN_MODE_RFC3168,
+		.mode_server = TCP_ECN_MODE_RFC3168,
+	},
+};
+
+/*
+ * Connect over loopback and accept() the child socket, so that
+ * passive_established is guaranteed to have run: the listener is woken
+ * up only after tcp_rcv_state_process() moved the child to established.
+ */
+static void do_ecn_connect(int family)
+{
+	const char *addr = family == AF_INET ? "127.0.0.1" : "::1";
+	int server_fd, client_fd, accepted_fd;
+
+	server_fd = start_server(family, SOCK_STREAM, addr, 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		return;
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (ASSERT_OK_FD(client_fd, "connect_to_fd")) {
+		accepted_fd = accept(server_fd, NULL, NULL);
+		if (ASSERT_OK_FD(accepted_fd, "accept"))
+			close(accepted_fd);
+		close(client_fd);
+	}
+
+	close(server_fd);
+}
+
+static void test_ecn(int cgroup_fd, struct bpf_tcp_ops_ecn *skel, int family)
+{
+	struct bpf_link *link;
+	char buf[128];
+	int i;
+
+	link = bpf_map__attach_cgroup_opts(skel->maps.ecn_ops, cgroup_fd, NULL);
+	if (!ASSERT_OK_PTR(link, "attach_ecn_ops"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(ecn_cases); i++) {
+		const struct ecn_case *c = &ecn_cases[i];
+
+		snprintf(buf, sizeof(buf), "%d", c->sysctl_ecn);
+		if (!ASSERT_OK(write_sysctl("/proc/sys/net/ipv4/tcp_ecn", buf),
+			       "write_sysctl_tcp_ecn"))
+			break;
+
+		skel->bss->ecn_retval_active = c->retval_active;
+		skel->bss->ecn_retval_passive = c->retval_passive;
+		skel->bss->ecn_seed_active = -1;
+		skel->bss->ecn_seed_passive = -1;
+		skel->bss->ecn_active_cnt = 0;
+		skel->bss->ecn_passive_cnt = 0;
+		skel->bss->ecn_mode_client = 0xdead;
+		skel->bss->ecn_mode_server = 0xdead;
+
+		do_ecn_connect(family);
+
+		/*
+		 * ecn_init() runs once on the active side. On the passive side it
+		 * runs only if the SYN requested ECN (tcp_ecn_create_request()).
+		 */
+		snprintf(buf, sizeof(buf), "%s: active_cnt", c->name);
+		ASSERT_EQ(skel->bss->ecn_active_cnt, 1, buf);
+		snprintf(buf, sizeof(buf), "%s: passive_cnt", c->name);
+		ASSERT_EQ(skel->bss->ecn_passive_cnt, c->passive_runs ? 1 : 0, buf);
+
+		/* bpf_get_retval() must be seeded with the sysctl value. */
+		snprintf(buf, sizeof(buf), "%s: seed_active", c->name);
+		ASSERT_EQ(skel->bss->ecn_seed_active, c->sysctl_ecn, buf);
+		snprintf(buf, sizeof(buf), "%s: seed_passive", c->name);
+		ASSERT_EQ(skel->bss->ecn_seed_passive,
+			  c->passive_runs ? c->sysctl_ecn : -1, buf);
+
+		snprintf(buf, sizeof(buf), "%s: mode_client", c->name);
+		ASSERT_EQ(skel->bss->ecn_mode_client, c->mode_client, buf);
+		snprintf(buf, sizeof(buf), "%s: mode_server", c->name);
+		ASSERT_EQ(skel->bss->ecn_mode_server, c->mode_server, buf);
+	}
+
+	bpf_link__destroy(link);
+}
+
+static void run_ecn_subtest(int family)
+{
+	struct bpf_tcp_ops_ecn *skel = NULL;
+	struct netns_obj *ns = NULL;
+	int cgroup_fd;
+
+	cgroup_fd = test__join_cgroup(CGROUP_PATH);
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		return;
+
+	ns = netns_new(TEST_NETNS, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto done;
+
+	skel = bpf_tcp_ops_ecn__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto done;
+
+	test_ecn(cgroup_fd, skel, family);
+
+done:
+	bpf_tcp_ops_ecn__destroy(skel);
+	netns_free(ns);
+	close(cgroup_fd);
+}
+
+void test_bpf_tcp_ops_ecn(void)
+{
+	if (test__start_subtest("ipv4"))
+		run_ecn_subtest(AF_INET);
+	if (test__start_subtest("ipv6"))
+		run_ecn_subtest(AF_INET6);
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_tcp_ops_ecn.c b/tools/testing/selftests/bpf/progs/bpf_tcp_ops_ecn.c
new file mode 100644
index 000000000000..596566148858
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_tcp_ops_ecn.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Samsung Electronics Co., Ltd. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+/* TCP_ECN_MODE_* bits of tcp_sock::ecn_flags, from include/net/tcp.h */
+#define TCP_ECN_MODE_RFC3168	0x01
+#define TCP_ECN_MODE_ACCECN	0x10
+#define TCP_ECN_MODE_ANY	(TCP_ECN_MODE_RFC3168 | TCP_ECN_MODE_ACCECN)
+
+int ecn_retval_active;		/* ecn_init() return value, active open */
+int ecn_retval_passive;		/* ecn_init() return value, passive open */
+int ecn_seed_active;		/* bpf_get_retval() seen on active open */
+int ecn_seed_passive;		/* bpf_get_retval() seen on passive open */
+__u32 ecn_active_cnt;
+__u32 ecn_passive_cnt;
+__u32 ecn_mode_client;		/* negotiated ECN mode, client socket */
+__u32 ecn_mode_server;		/* negotiated ECN mode, accepted socket */
+
+SEC("struct_ops")
+int BPF_PROG(ecn_ops_ecn_init, struct sock *sk, struct request_sock *req)
+{
+	if (req) {
+		ecn_passive_cnt++;
+		ecn_seed_passive = bpf_get_retval();
+		return ecn_retval_passive;
+	}
+
+	ecn_active_cnt++;
+	ecn_seed_active = bpf_get_retval();
+	return ecn_retval_active;
+}
+
+SEC("struct_ops")
+void BPF_PROG(ecn_ops_active_established, struct sock *sk,
+	      struct sk_buff *skb)
+{
+	ecn_mode_client = ((struct tcp_sock *)sk)->ecn_flags & TCP_ECN_MODE_ANY;
+}
+
+SEC("struct_ops")
+void BPF_PROG(ecn_ops_passive_established, struct sock *sk,
+	      struct sk_buff *skb)
+{
+	ecn_mode_server = ((struct tcp_sock *)sk)->ecn_flags & TCP_ECN_MODE_ANY;
+}
+
+SEC(".struct_ops.link")
+struct bpf_tcp_ops ecn_ops = {
+	.ecn_init = (void *)ecn_ops_ecn_init,
+	.active_established = (void *)ecn_ops_active_established,
+	.passive_established = (void *)ecn_ops_passive_established,
+};
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1

