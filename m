Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7132F430CC0
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358402; cv=none; b=Yvlzsz/BQz4V0RMVYFHw4hrXxyFI+ovj4Ez6eupEL8iYBJSkdybWemgDf3n7inHyhVAGDNXI6MZw6IwOwqgtZYWL+Y1004TQSNLEN1+LrvdjW0n8zS1Ub3S5JeTt1xCnynHoVOvNrTk+38zTGXmtMfOpdvTq3U1Dk3QgdTjBR5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358402; c=relaxed/simple;
	bh=DRI9lTXlNY8X+aZ/TtlGehyx9dfo6ufCxum4m0pIEhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGhYCMwtMlH4ETQMy2ZQ+pGYUQDg9Az0oo66ruH8PLc59/oOYSQso7dmX+poxMuKsU6JVKMb2JhnznTzWZ71rVs7KckE4Ld328376oWHcUunAt2JXu1AkrOhpXDTq1kqUKqcu7i8lQ9WJfi09ecG4BFoFT0vmYPFv+8Of5K3wr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7LLjrD1; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7LLjrD1"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6a30bcadd96so1838724eaf.2
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 10:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358399; x=1783963199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihmVpVi5dMWw2IgjLFhZZAh/H0Js4t1Vws4EjykXpCU=;
        b=R7LLjrD1yuPaglAkYEnE9ROV3xdJ9kvduHgSHRzMYucCBLwHf0lioNfTtIsMMQ+lIC
         VnzeRU9/xBlQ/hN9Z4fJD45XBVJGmaNU7Y6p3CUKZL0FL0Z/vX2dRuJ72lGtMq/aqB6e
         QRhHb7m5IJqmRgW971MzPni3dTQHNnMZddP4mFD6A4dHZVxcp5nAtQlhMvfmXtdMrEoY
         zmEJqprzXbN8Q5tKnY37biqGx8i0JLFtg74MJagVQojOpPKf+HNtOGyl2THqDAzKi8z5
         9kBESa5JZPLd5+wHcjUGqlHJaQsn3hBp1x6AzhbEC0M7Ayh7jql3Pcp0jUiA3MhT9uF1
         IvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358399; x=1783963199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ihmVpVi5dMWw2IgjLFhZZAh/H0Js4t1Vws4EjykXpCU=;
        b=pXCcN1hSLDoEkvFgmZ1cyc3mta1VHuKgEKgE6zC717HXaTwoQ2OayEwSs64bh+AHK8
         9TOXx4WdCZUBUgAYn7AqqJ3WnepXWPk/oiXb1ssy5mm8Q9dCZH261fOJQS9761QX0VuD
         m0FrRgYggSsB635XWS8d764ft2eB0ExCGNd78BubCbCLjNyfDccNUdcDbAucT5iGdAVG
         fa8cQ5qsLKuuUNs5m45ETA9kMijDM3E8yrbp5isBlnfu1ETk8Q1i5nWiN8foT/K7HHhe
         AKQuEoAMSUy7N+imHr/aISXgvKSgwm0s6ql64AqP1pqCV++XJVMBMw7dNt/YB3D7ZQ8e
         1ChA==
X-Gm-Message-State: AOJu0YyrbPGbxahjtbH4MfGFjTsvDX8w9l6lqzU1yMHzH6SqdaErkmEo
	JzHblbcmTsyrLe+YGH2PoN10VvUuglKsNXWp8/BqalpMncvjASYUKNre2Uk95Q==
X-Gm-Gg: AfdE7ckaiYAUgg7c19cXttx8wKEi3Yb3AZx/rD2hYQ5P6CGmvBoFfvJ4RNsqr2UZ+dE
	SX5Nj3K1nxwSh9U6fSuF8ODslqBYIRXM8d+iWjK6osx1aLlZD/nnCDeVec36uDxLmlzksC7Z97Z
	6WcRnudE1B0yZUmcAQWbfcWcKi9Aycj7C/T89kM0RMS2ODnTeJPhzdL9xvTEmsJyY1SjpSYhD09
	zr8a7nYBgZm6UUUwWc5Jr2V9ku1hB4kd0+jQXVwDFJ5Kpl1bIRD4ML3BoAFVm216Nji4+077E4B
	5GznKlu7HrJ7LUfvUWCtxsZmIkamBGYnyzdXIXBhkvdqvqjEJduTBD1xfpQxqXl9in/B8O0oAJO
	MlnasNYnCb4VXzCfHu8NqJOGoR+lC+qEq2GFKbeZ8FRUN07rosaS3c6+HCMTCPAzGUMWkSqFedN
	ilpCI=
X-Received: by 2002:a05:6820:a0e:b0:6a3:10fc:766d with SMTP id 006d021491bc7-6a35538cd00mr888205eaf.47.1783358399391;
        Mon, 06 Jul 2026 10:19:59 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4d::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a32132dae4sm7233935eaf.1.2026.07.06.10.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:19:58 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 15/15] selftests/bpf: Add test for bpf_tcp_ops header option hooks
Date: Mon,  6 Jul 2026 10:19:17 -0700
Message-ID: <20260706171918.317102-16-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260706171918.317102-1-ameryhung@gmail.com>
References: <20260706171918.317102-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test exercising the bpf_tcp_ops parse_hdr, hdr_opt_len and
write_hdr_opt members together with the header option helpers.

The struct_ops program (progs/bpf_tcp_ops_hdr.c) reserves space in
hdr_opt_len via bpf_reserve_hdr_opt(), writes an experimental option in
write_hdr_opt via bpf_store_hdr_opt(), and recovers it in parse_hdr via
bpf_load_hdr_opt() on the incoming skb. Each hook bumps a counter and the
parse hook records the option payload, so the three callbacks and all
three overloaded helpers are covered.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/bpf_tcp_ops_hdr.c          | 77 +++++++++++++++++
 .../selftests/bpf/progs/bpf_tcp_ops_hdr.c     | 83 +++++++++++++++++++
 2 files changed, 160 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c
new file mode 100644
index 000000000000..244605e69e40
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "cgroup_helpers.h"
+#include "bpf_tcp_ops_hdr.skel.h"
+
+#define CGROUP_PATH	"/bpf_tcp_ops_hdr"
+#define TEST_NETNS	"bpf_tcp_ops_hdr"
+
+#define TEST_OPT_D0	0xAB
+#define TEST_OPT_D1	0xCD
+
+static void run_hdr_opt(void)
+{
+	struct bpf_tcp_ops_hdr *skel = NULL;
+	struct bpf_link *link = NULL;
+	struct netns_obj *ns = NULL;
+	int cgroup_fd, lfd = -1, fd = -1;
+
+	cgroup_fd = test__join_cgroup(CGROUP_PATH);
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		return;
+
+	ns = netns_new(TEST_NETNS, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto done;
+
+	skel = bpf_tcp_ops_hdr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto done;
+
+	link = bpf_map__attach_cgroup_opts(skel->maps.test_hdr_ops, cgroup_fd, NULL);
+	if (!ASSERT_OK_PTR(link, "attach_cgroup"))
+		goto done;
+
+	/*
+	 * One direction of data is enough to exercise all hooks: both peers
+	 * share the cgroup struct_ops, so the sender runs hdr_opt_len/write
+	 * and the receiver runs parse.
+	 */
+	lfd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
+	if (!ASSERT_GE(lfd, 0, "start_server"))
+		goto done;
+
+	fd = connect_to_fd(lfd, 0);
+	if (!ASSERT_OK_FD(fd, "connect_to_fd"))
+		goto done;
+
+	if (!ASSERT_OK(send_recv_data(lfd, fd, 64), "send_recv_data"))
+		goto done;
+
+	/* Reserve + write hooks ran while sending. */
+	ASSERT_GT(skel->bss->hdr_opt_len_cnt, 0, "hdr_opt_len_cnt");
+	ASSERT_GT(skel->bss->write_cnt, 0, "write_cnt");
+	/* Parse hook ran and recovered our option on the receive side. */
+	ASSERT_GT(skel->bss->parse_cnt, 0, "parse_cnt");
+	ASSERT_GT(skel->bss->found_cnt, 0, "found_cnt");
+	ASSERT_EQ(skel->bss->found_d0, TEST_OPT_D0, "found_d0");
+	ASSERT_EQ(skel->bss->found_d1, TEST_OPT_D1, "found_d1");
+
+done:
+	if (fd >= 0)
+		close(fd);
+	if (lfd >= 0)
+		close(lfd);
+	bpf_link__destroy(link);
+	bpf_tcp_ops_hdr__destroy(skel);
+	netns_free(ns);
+	close(cgroup_fd);
+}
+
+void test_bpf_tcp_ops_hdr(void)
+{
+	run_hdr_opt();
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c b/tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c
new file mode 100644
index 000000000000..46618a604d96
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+/* Experimental option kind and payload written/parsed by this test. */
+#define TEST_OPT_KIND	0xFD
+#define TEST_OPT_LEN	4
+#define TEST_OPT_D0	0xAB
+#define TEST_OPT_D1	0xCD
+
+int hdr_opt_len_cnt;
+int write_cnt;
+int parse_cnt;
+int found_cnt;
+__u8 found_d0;
+__u8 found_d1;
+
+SEC("struct_ops")
+void BPF_PROG(test_hdr_opt_len, struct sock *sk, struct sk_buff *skb,
+	      struct request_sock *req, struct sk_buff *syn_skb,
+	      enum tcp_synack_type synack_type, unsigned int *remaining)
+{
+	hdr_opt_len_cnt++;
+
+	/* Reserve TEST_OPT_LEN bytes; the helper decrements *remaining. Stacks
+	 * with other progs in the cgroup hierarchy.
+	 */
+	bpf_reserve_hdr_opt(ctx, TEST_OPT_LEN, 0);
+}
+
+SEC("struct_ops")
+void BPF_PROG(test_write_hdr_opt, struct sock *sk, struct sk_buff *skb,
+	      struct request_sock *req, struct sk_buff *syn_skb,
+	      enum tcp_synack_type synack_type, __u32 opt_off)
+{
+	__u8 opt[TEST_OPT_LEN] = {
+		TEST_OPT_KIND, TEST_OPT_LEN, TEST_OPT_D0, TEST_OPT_D1,
+	};
+
+	/* bpf_store_hdr_opt() takes the program ctx (the kernel reads the
+	 * outgoing skb from it); it appends after any options already written
+	 * in the reserved window, rejects duplicates, and confines the write to
+	 * the header option scratch. Stacks across progs in the cgroup hierarchy.
+	 */
+	if (bpf_store_hdr_opt(ctx, opt, sizeof(opt), 0))
+		return;
+
+	write_cnt++;
+}
+
+SEC("struct_ops")
+void BPF_PROG(test_parse_hdr, struct sock *sk, struct sk_buff *skb)
+{
+	__u8 opt[TEST_OPT_LEN] = {
+		TEST_OPT_KIND, TEST_OPT_LEN, TEST_OPT_D0, TEST_OPT_D1,
+	};
+
+	parse_cnt++;
+
+	/* Look up the experimental option written by test_write_hdr_opt() in
+	 * the incoming skb. For an experimental kind the search matches on the
+	 * 2-byte magic in opt[2..3]; on a match the found option is copied back
+	 * into opt[].
+	 */
+	if (bpf_load_hdr_opt(ctx, opt, sizeof(opt), 0) < 0)
+		return;
+
+	found_d0 = opt[2];
+	found_d1 = opt[3];
+	found_cnt++;
+}
+
+SEC(".struct_ops.link")
+struct bpf_tcp_ops test_hdr_ops = {
+	.hdr_opt_len	= (void *)test_hdr_opt_len,
+	.write_hdr_opt	= (void *)test_write_hdr_opt,
+	.parse_hdr	= (void *)test_parse_hdr,
+};
+
+char _license[] SEC("license") = "GPL";
-- 
2.52.0

