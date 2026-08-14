Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDF83E00A5
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 08:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695288; cv=none; b=hBTE8DvIqvJ3FmEs/UinTDvPNX4SxK26E+rptTHghERXvr37EYNMoatW0fkBzmSnc9kQZTQMcLFj4ufv8W46EkNQ1InZ4J6UNPJk9TD9fyQ19HdJ0dUO/zPxDgVHgqMLiYFfpnHjHMSniJAOntO/DNFnpUIBtPdvBahqQ2QhMlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695288; c=relaxed/simple;
	bh=XYJaaV6RZ2aCIdSZZp3UOKwoSCacrsxDSSu5mwKR1/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VeEqUmvR4/6Zehp81aMobHGVe27zEnWNq7Mwfa6KvNkanpS3x5tPyG9bi7tCuvHW7jnfzEQChETsasXX6tI5ZkAa+MaQ7OXX8bkwgPrwDlfUnCdAOlz0dYRDcb8WaCbXW3y2JPzI8eXHEVaYKyQt9A3kiziCfqFCm33gU8adNmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KcD4ZaQA; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KcD4ZaQA"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c169ae1cb26so333039766b.1
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 01:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1786695281; x=1787300081; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eVWgO9L7od1ZdDLD/qLThejWQzHxo+90HVB2YhHUZDE=;
        b=KcD4ZaQAMwr3MDs/7MsxjwQI3WRHrYwXCcozcFdLipJTIHvZF3g3PyTtxEb/A95JX6
         fyb9K6B039+p+Wr91o8mW7k1QdMCB/JSmsoPne30lNrkHeCa3cnPKsqizSg27djQNhb7
         H55JKVU+K7xthrbRRZYJaRGE79yjluz0dCYNLv+P3mcPxvZfet0LBVYB1LcfKmOeP9N6
         xQa3kp5SlfwDTM0uDdhEWdQt4QXi7tmcrCED26/6jGdfUUv/b6asf2SGQFMxcj1xWE/Z
         wk3Kb/hyTihLh2AkanaFFY36VA7T8zPRQPvRAovu8zyoU7VSEabd5w9S71dHAPoTD4Qh
         xVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786695281; x=1787300081;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eVWgO9L7od1ZdDLD/qLThejWQzHxo+90HVB2YhHUZDE=;
        b=L7C99oOy5mba8QV1f0mWaQ0f5RP+6bQbOi/vV2Ktc6IJmpiLfIMjXpOAdHNedgbW0d
         UkyhSOK1Fe6p6ON3sknAk0/9PgRVP1WtNTPJ1fbLDYn/QUxmKjp43UlPMl0tZXWrfmuP
         cNIl2rgJ0cVldaSCAn2YANNvxxDCzf4/7dgX2JdS+T9JZZpaCF411WfVUy+HR9viz/0p
         otaN2GDYwJa+7Ma0EEM4jhvNTUWq4W+wUnycHEBFdFk0umy7voH7L+HfLYhnxctBeq/7
         PQgVT0jd2jA8pcO3iteIMiWgnupCWNDKfhYoz7a5EPqsclqqS9XCQDiPTdvQrg+QNl2t
         LAuw==
X-Gm-Message-State: AOJu0YzWAJXinEVB7fuBx4GzjMhK/22ftpANNKzHn+yEZRNXXFFiLL3q
	vj3UhwnsLP0vp1NRgNyewSJIZaQLpJueTgKY3lr7pswB8O8GVfMTDhT3udB+oWX29n4=
X-Gm-Gg: AR+sD11ILQJqfYjgrvB5ZzJuVyDJhmEGoQO4zUFDOE8rvOBMV9o9CshCBOG518WS/mq
	iPcuRgB346j9uzf7TffxTYy7wmaGvjblve2AVbAF+3viu+FAskchaY0bbTD4fiafFgZRSKxhDRj
	aItB15lgTcLJgf+bdGsITKaONs2Li9XpXzdUIB5JWyMZ0luTAZqBIhzrZBUBq7SP7DSK0o4zKol
	AUl40t3LeJbz8F79Ko/WzI36kbjmZ9s3PMjeXzOyLYOKVPO/iF17cYL4dEdp2difn78VBrTCYUu
	Xqx2go9j4k8AJSUrxY41oA2SKu4SsK8qQKvlVZEHyFmpEQIbL3+RX8vQB1gWbVPYPgk+P/+JItr
	oS0p6tSBOumSh9vb+oCso2fC1DP+hyfib4zHiwyhaIGQ7EulZsEoLEP7I8NwldKYyuySfl1nvOs
	Ffphe2Xu9pfjWk7AvyYsXvanIt596DNJuNHLLztx3C4hf3WvnS030tnDKK/TMZAPGnAURVm8N3K
	nfdKGEcJH3S+qKvmRJ3BuqyYCCLe+dyG1D5QA==
X-Received: by 2002:a17:907:1c88:b0:c12:3cbf:9f6d with SMTP id a640c23a62f3a-c212a22e0e4mr192756366b.1.1786695281460;
        Fri, 14 Aug 2026 01:14:41 -0700 (PDT)
Received: from cloudflare.com (79.184.184.176.ipv4.supernova.orange.pl. [79.184.184.176])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c212378fffasm77941666b.36.2026.08.14.01.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:14:41 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 14 Aug 2026 10:14:14 +0200
Subject: [PATCH net-next 13/14] selftests/bpf: Test skb_ext read from
 sk_skb stream verdict hook
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-bpf-meta-inside-skb-ext-v1-13-767edd862656@cloudflare.com>
References: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
In-Reply-To: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
To: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
X-Mailer: b4 0.16.0

Test bpf_dynptr_from_skb_ext() from sk_skb context. Write to skb_ext from
TC on loopback; read from skb_ext from the sockmap verdict program.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../selftests/bpf/prog_tests/socket_helpers.h      |  1 +
 .../bpf/prog_tests/xdp_context_test_run.c          | 79 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 18 +++++
 3 files changed, 98 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
index 0d59503a0c73..eb114a6ea6f9 100644
--- a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
@@ -3,6 +3,7 @@
 #ifndef __SOCKET_HELPERS__
 #define __SOCKET_HELPERS__
 
+#include <error.h>
 #include <sys/un.h>
 #include <linux/vm_sockets.h>
 
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 5f9247941aa0..f5fbc19757e3 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -4,6 +4,7 @@
 #include <linux/ipv6.h>
 #include <linux/netfilter.h>
 #include <arpa/inet.h>
+#include "socket_helpers.h"
 #include "test_xdp_context_test_run.skel.h"
 #include "test_xdp_meta.skel.h"
 
@@ -1560,6 +1561,82 @@ static void test_skb_ext_seg6local(struct test_xdp_meta *skel)
 		unlink(SEG6_PIN_PATH);
 }
 
+/* Test skb_ext survival across TC ingress -> sk_skb verdict hook.
+ * TC ingress writes skb_ext on loopback; the verdict program reads it
+ * on skb delivery to a socket in the sockmap.
+ */
+static void test_skb_ext_sk_skb(struct test_xdp_meta *skel)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook,
+		    .ifindex = 1 /* IFINDEX_LO */,
+		    .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct bpf_link *verdict_link = NULL;
+	struct sockaddr_in addr;
+	socklen_t addr_len = sizeof(addr);
+	struct netns_obj *ns = NULL;
+	char buf[TEST_PAYLOAD_LEN];
+	int c1 = -1, p1 = -1;
+	int map = -1, zero = 0;
+	ssize_t n;
+	int ret;
+
+	ns = netns_new("tc_to_sk_skb", true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		return;
+
+	skel->bss->test_pass = false;
+
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
+		goto cleanup;
+
+	tc_opts.prog_fd = bpf_program__fd(skel->progs.tc_skb_ext_write_port);
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach"))
+		goto cleanup;
+
+	map = bpf_map_create(BPF_MAP_TYPE_SOCKMAP, NULL, sizeof(int),
+			     sizeof(int), 1, NULL);
+	if (!ASSERT_GE(map, 0, "bpf_map_create"))
+		goto cleanup;
+
+	verdict_link = bpf_program__attach_sockmap(skel->progs.sk_skb_skb_ext_read,
+						   map);
+	if (!ASSERT_OK_PTR(verdict_link, "attach_sockmap"))
+		goto cleanup;
+
+	if (!ASSERT_OK(create_pair(AF_INET, SOCK_STREAM, &c1, &p1), "create_pair"))
+		goto cleanup;
+
+	if (!ASSERT_OK(bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST), "map_update"))
+		goto cleanup;
+
+	if (!ASSERT_OK(getsockname(c1, (struct sockaddr *)&addr, &addr_len),
+		       "getsockname"))
+		goto cleanup;
+	skel->bss->target_port = addr.sin_port;
+
+	n = send(p1, test_payload, TEST_PAYLOAD_LEN, 0);
+	if (!ASSERT_EQ(n, TEST_PAYLOAD_LEN, "send"))
+		goto cleanup;
+
+	n = recv(c1, buf, sizeof(buf), 0);
+	ASSERT_EQ(n, TEST_PAYLOAD_LEN, "recv");
+	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
+
+cleanup:
+	if (c1 >= 0)
+		close(c1);
+	if (p1 >= 0)
+		close(p1);
+	bpf_link__destroy(verdict_link);
+	if (map >= 0)
+		close(map);
+	bpf_tc_hook_destroy(&tc_hook);
+	netns_free(ns);
+}
+
 void test_skb_ext_cross_hook(void)
 {
 	struct test_xdp_meta *skel = NULL;
@@ -1591,6 +1668,8 @@ void test_skb_ext_cross_hook(void)
 				 skel->progs.lwt_xmit_skb_ext_write, "xmit", true);
 	if (test__start_subtest("tc_to_seg6local"))
 		test_skb_ext_seg6local(skel);
+	if (test__start_subtest("tc_to_sk_skb"))
+		test_skb_ext_sk_skb(skel);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index c4ea38d79533..4c224d5fe1b2 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -1152,4 +1152,22 @@ int seg6local_skb_ext_read(struct __sk_buff *ctx)
 	return BPF_OK;
 }
 
+/* Read skb_ext from sk_skb stream verdict hook */
+SEC("sk_skb/stream_verdict")
+int sk_skb_skb_ext_read(struct __sk_buff *ctx)
+{
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, 0, &meta))
+		return SK_PASS;
+	if (bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0))
+		return SK_PASS;
+	if (!check_metadata(meta_have))
+		return SK_PASS;
+
+	test_pass = true;
+	return SK_PASS;
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.43.0

