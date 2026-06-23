Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD1238C2D8
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237035; cv=none; b=ZEr0fl+jY/KfYW171J+x+3/uQfHVIfYBNrFGZEKBfb/WtUeY+C2eJnzAU4hKsJ6xY40kmK6FTcwxgFY/tMuUVbasyGqFJENex00hKer0MTcnYVaEoLfDEh4pjogDxSh0SoFRKyJ9chZIxrzGA+qv56YUdEhU6tg8cK7QvebWVpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237035; c=relaxed/simple;
	bh=9KXuFb5P3XiWFNtmUvJkDONVjQYpi0gwHW+J04/aNKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+WSozGuznd89LVLyqQATn5KPN7v4/dGTYrsE307YYg/44pDtGcmhCaxkUayl6Fdb/c4ApPqa4n5jxBO03oDuZun72/1T8De9PMZwAH8PinKPpt71IPwa/mDO4FG5SBR3x7etcTbQKzgeCQtp+ATDewG2C8DIyK+v20KdfD3Ivg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWiA2qmi; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWiA2qmi"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e6e41cf7aeso99932a34.0
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 10:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237031; x=1782841831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gM+oXWiAU9UYCm/NhOHqQY655mSiAGDdW0+PS18PiQ=;
        b=XWiA2qmiHJ9sJbDIK0/SMkfl7xklcob5IqhbvcjyGaTvXoq/peJEL+H+sOQH/W9IqZ
         eS3k2gpNmYxTFnLi37//z8M+QXurZ+YOADg+48I+kUWpsQl3T/FVcOPUnzWTMxhaCmAY
         twiteN+RhLDWFqwqmMKGKSqt4WyXVRGocx0imgFvEShzAFj4jbM/7xPNWEQEoYIVFTCY
         Kigich603CYoOgQJNXAeAjuY8gDt1Lz8D/NadnbrP4yAZoZYtTFxh+6aRCBmcxSg942a
         R0yiKI3vG/XhaFex+raU5oCsrR7Sk8OFIiYJCucdVzETKncPzkto4i8ETn3BcNGVjmbc
         DVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237031; x=1782841831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5gM+oXWiAU9UYCm/NhOHqQY655mSiAGDdW0+PS18PiQ=;
        b=WzYSoZkYSJSj5/nu/KZWTajOGi395Fk17W/AZxBjN0ltl/Ad+hGYgATUmQU8j1TxWR
         7H7qWd1j2E1iQpxuiW+eOtr3prMtCnj5rDxw/BS9OkcmWXCcELG3HCGkdngHo8De82px
         BfY8sutF1VtRHplum6Oz7HixxmL5bVsWMVA/UQQSkyY9tBMjh01c+G3dSlA7HtcoPDQo
         Ng/xK2MG2BXjUi3CA2H41F1pfxKAFOeQbP4Gt9i1f4lWGRgaBWimEh5iZ1lru+iAzh/3
         JgqXJaDS4Gl5uTsZJy4EvPxpj4alVBlin8dWr7sztIEh1ciOVXUtjvSh3YpddoEGX5ck
         c38Q==
X-Gm-Message-State: AOJu0YzuFtcgaB/f4LmSgbFrs3lfwrChQlnrYLuDGtnb/YLdlDP9KKeK
	cwHqRlUt2KsZFkhgO5WuYr5XlTnL8+xVO3n3Ma6z82eiVl+osxNs0eX/FoX9aA==
X-Gm-Gg: AfdE7clb3s/f51EHEkCKnJV86DsoDMKEZG9T8AMv53FAgoGLnBCwxtCcQHHmZVq9RgS
	MjHQ1TniHSgfcC4TjMf8fiV2RynH1/ss+72hgCSAy27rk1AK3oxjaCIX/wBuogiJpRauHIr7ZgX
	lhCDdfuWNS749L7VG2WJa4GxYeb9l+/ItIsvpIek9e2bH54ehGBayeEwSWUvHFmUlFkAX3hUxDM
	+L+tLDKYdCb9bXPYlYk21aEO6L9hNqPjEC8ZdHH9AuDeRLFMcke1ZU0+nt/Mk+298iyl2L2SGuj
	MrMh3ehFm30tKBBGcpmuRYQYm6IUfInUkACRviiHVlrRFojAq/Ct3M574CHTI6KDRqgae25OfgV
	RVNYlVNG21scuwh6paQHcdxBcavQrlC0cjb2ggag2luGKaQ/OmfFRGMOQfK5A0QloFAvcqVegfc
	p5my6IBpXjaftUKA==
X-Received: by 2002:a05:6808:1489:b0:489:b97d:3f52 with SMTP id 5614622812f47-48f2a2c2fabmr2831210b6e.37.1782237030650;
        Tue, 23 Jun 2026 10:50:30 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48ae8b3b1efsm7005063b6e.0.2026.06.23.10.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:50:30 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 15/15] selftests/bpf: Add test for bpf_tcp_ops header option hooks
Date: Tue, 23 Jun 2026 10:50:03 -0700
Message-ID: <20260623175006.3136053-16-ameryhung@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623175006.3136053-1-ameryhung@gmail.com>
References: <20260623175006.3136053-1-ameryhung@gmail.com>
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
 .../bpf/prog_tests/bpf_tcp_ops_hdr.c          | 97 +++++++++++++++++++
 .../selftests/bpf/progs/bpf_tcp_ops_hdr.c     | 83 ++++++++++++++++
 2 files changed, 180 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c
new file mode 100644
index 000000000000..73e34d2be9a4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c
@@ -0,0 +1,97 @@
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
+static void send_recv(void)
+{
+	char buf[64] = {};
+	int server_fd, client_fd, accept_fd;
+	ssize_t n;
+
+	server_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		return;
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_OK_FD(client_fd, "connect_to_fd"))
+		goto close_server;
+
+	accept_fd = accept(server_fd, NULL, NULL);
+	if (!ASSERT_OK_FD(accept_fd, "accept"))
+		goto close_client;
+
+	/* Exchange data both directions so option-bearing data packets
+	 * are sent and parsed on each side.
+	 */
+	n = send(client_fd, buf, sizeof(buf), 0);
+	ASSERT_EQ(n, sizeof(buf), "client_send");
+	n = recv(accept_fd, buf, sizeof(buf), 0);
+	ASSERT_EQ(n, sizeof(buf), "server_recv");
+
+	n = send(accept_fd, buf, sizeof(buf), 0);
+	ASSERT_EQ(n, sizeof(buf), "server_send");
+	n = recv(client_fd, buf, sizeof(buf), 0);
+	ASSERT_EQ(n, sizeof(buf), "client_recv");
+
+	close(accept_fd);
+close_client:
+	close(client_fd);
+close_server:
+	close(server_fd);
+}
+
+static void run_hdr_opt(void)
+{
+	struct bpf_tcp_ops_hdr *skel = NULL;
+	struct bpf_link *link = NULL;
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
+	skel = bpf_tcp_ops_hdr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto done;
+
+	link = bpf_map__attach_cgroup_opts(skel->maps.test_hdr_ops, cgroup_fd, NULL);
+	if (!ASSERT_OK_PTR(link, "attach_cgroup"))
+		goto done;
+
+	send_recv();
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
2.53.0-Meta

