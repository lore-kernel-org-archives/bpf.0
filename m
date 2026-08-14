Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DF143E085
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695283; cv=none; b=ILB6HxNdUHXY0viAgYE6ep1Q/EkEGls2lqD+uQtPS6WyV7Xc2Za0tjhcqRNFZLLRdfZaV1krWgBALwHd7/3jMQEfY0ZW6QCX4mgPNyY6JpGPOwQw4r0JUpgh9I4sHNMQFzhSmKB5U1q/nozFUpYGCY1G38MKRPzfpD9jis86+1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695283; c=relaxed/simple;
	bh=ImEMAg08xglhxwTRkHlgdJ5hJbBLdzMEk0BUv9IF5NA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZMY+XrS4pDJfFLj5cOqJljnB3+O//dqx5uk/w6Z3GOjSHZBO06X+zJRWNEXvRsmDkB0vo1djaScqvytPZPMm5jwZeOIFO3GzhDCJlkoVB4TQfUBZT7pyChnLL/x5pUi9CvguLmElKCE/vp1ZX5vB1gPKSVypl6fQYcz7mVQJzL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=NJnd2uz7; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="NJnd2uz7"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c1c26d7e951so128274766b.0
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 01:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1786695273; x=1787300073; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kxh7WgjaXDX/penZLLTnZGb1oR++GKW11HucUTA4OG0=;
        b=NJnd2uz7Q2StMHB8mYLUNUvIoC0OzqdTTPHKskzt93K68iUKp5/X9sRb3zR8MkQ/7k
         RgSW4FCKkM7pHz5YWHDkpIrcfbuqgorSQPbV8L6heAfKsnVZ7ozPAYZfo+V5uZDxNTLA
         yLK3GLuyypNdOYd4FQaW0XVa46C7QrgOhIU2XgUsDkGSEUoo1mka+J/8PtXFYbvP1dKw
         YmqwwQSaWPkt7RV7UtL7xdOHZopynSe3Gz5D5Zb84ovZJVmmHJhqqY6UXqz4zEkFb0QN
         YVsSg+3XtMIeScmqQeliIjaUpltD5EhtSfGJ/g6LNMYssAxvn0dsEQAJxRWb0MOheGiq
         Mi+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786695273; x=1787300073;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kxh7WgjaXDX/penZLLTnZGb1oR++GKW11HucUTA4OG0=;
        b=a1NX50a+iCWrXLoAG4m0MzA8ppkpvlB8hOiK7eKlBpBykG0YUB0Hqbeqf0CSt2uqTf
         ykGzB0UolRubaXaB3yfM4ledUNajL1j/YaDbOH+t6MTiLU950iIPCK1pixBFfvyCdWGT
         Bci9wOFg3gPVI/iECy5bfDvsgxeRZ5lkwPsqPPWVlJjd13diFKhoGFe+wIZTvEBDAZHr
         VWpGSpqZmyrP3sOwBR64eKJ+hfSi21Jd1oiOT67H54zUjQJ7XTpGLSTA/XUGNnYcjivm
         cdttCou9ZHG/wlApx4djeDxJ9hobY+Mr2LJNe8iPPJvSxJfL7tMV8SGdUYlShmsN7deQ
         oG8w==
X-Gm-Message-State: AOJu0YyBJlQo2+1012omppi3SaE/eCEKUvy/mLIrz0cWflai/ajcwEHt
	mJiJBza24S9Y6PNEs2eNOlbH9Z/tW6tibOoiZPw48fftlAXCLBH+WvGJoqQyIfjc4yQ=
X-Gm-Gg: AR+sD13jioZxATzsMpWJx0dk9ZE3MNULtpVDecuAEh0A/9WGPeaoeeERndBOI85GMbT
	GJ6v5MskfeAF14blNUDifssFPO03VaVGSoH0+yEcty8R46hqoHIQNtUP72wrTwEg2iz193LO8zI
	7rv2OcrHywD4q7AaYj6JfCSXHQb9ZeZHxGQWARgaGJjlAq6JAs3so1As8WHXsY5R9/CuPKhS9Td
	Zd5FDm2fFIGW9FYpzF5yDBqvFs44oZyLwgoQTpewOq2uO4javKcSj2iwsa9srM5haqgTzPjsniO
	4NeBDUPU1JlOnLDHCLiNRAHYLQ5tVGhmYbjwI4zEOCONHK6obHHR+DL1ju4nIJK8uRJSXcZ8S3G
	zQn6pVHqL4tnenoApGLPBX9jZTTRjLHRA9Add/onRTgf7g6Q0HwY/VqDSAChLbjlnwIOPfyaNvN
	PjOe6zJflXy1MWRguIJT8OmDO5DocpinaVIySVXf2slrBQZ3BnAWXOsvL8OZMR/fH2HrR/+qQsT
	YzajcBZS2+BiRdMJ3a/MPI23PS1pu/JRnvCEQ==
X-Received: by 2002:a17:907:8b89:b0:c16:29eb:e81a with SMTP id a640c23a62f3a-c212ac25d1fmr175551166b.29.1786695273362;
        Fri, 14 Aug 2026 01:14:33 -0700 (PDT)
Received: from cloudflare.com (79.184.184.176.ipv4.supernova.orange.pl. [79.184.184.176])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c21234c4b03sm77692766b.17.2026.08.14.01.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:14:32 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 14 Aug 2026 10:14:08 +0200
Subject: [PATCH net-next 07/14] selftests/bpf: Test skb_ext read from
 cgroup_skb and sk_filter hooks
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-bpf-meta-inside-skb-ext-v1-7-767edd862656@cloudflare.com>
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

Extend skb_ext cross-hook coverage to UDP readers: attach a TC
ingress program on loopback that writes the extension, send a UDP
datagram over loopback, and read the extension back from a
cgroup_skb/ingress program and from a socket filter attached with
SO_ATTACH_BPF.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 121 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |  37 +++++++
 2 files changed, 158 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index de6030302536..808eb158fe0f 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -992,3 +992,124 @@ void test_skb_ext_basic(void)
 
 	test_xdp_meta__destroy(skel);
 }
+
+/* Send test_payload over loopback UDP to recv_fd */
+static int send_loopback_udp(int recv_fd)
+{
+	struct sockaddr_in addr = {
+		.sin_family = AF_INET,
+		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+	};
+	char buf[TEST_PAYLOAD_LEN];
+	int ret = -1;
+	int fd = -1;
+	__be16 port;
+
+	port = get_socket_local_port(recv_fd);
+	if (!ASSERT_GE(port, 0, "get_port"))
+		goto out;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (!ASSERT_GE(fd, 0, "socket"))
+		goto out;
+
+	addr.sin_port = port;
+	sendto(fd, test_payload, TEST_PAYLOAD_LEN, 0,
+	       (void *)&addr, sizeof(addr));
+	recvfrom(recv_fd, buf, sizeof(buf), 0, NULL, NULL);
+	ret = 0;
+out:
+	if (fd >= 0)
+		close(fd);
+	return ret;
+}
+
+enum udp_reader_type {
+	READER_CGRP_SKB,
+	READER_SK_FILTER,
+};
+
+/* Test skb_ext survival across TC ingress -> UDP reader hook */
+static void test_skb_ext_udp(struct test_xdp_meta *skel, const char *name,
+			     enum udp_reader_type reader)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook,
+		    .ifindex = 1 /* IFINDEX_LO */,
+		    .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct bpf_link *reader_link = NULL;
+	struct netns_obj *ns = NULL;
+	int server_fd = -1;
+	int cgroup_fd = -1;
+	int filter_fd;
+	int ret;
+
+	ns = netns_new(name, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		return;
+
+	cgroup_fd = test__join_cgroup(name);
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		goto cleanup;
+
+	server_fd = start_server(AF_INET, SOCK_DGRAM, "127.0.0.1", 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		goto cleanup;
+
+	skel->bss->test_pass = false;
+
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
+		goto cleanup;
+
+	tc_opts.prog_fd = bpf_program__fd(skel->progs.tc_skb_ext_write);
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach"))
+		goto cleanup;
+
+	switch (reader) {
+	case READER_CGRP_SKB:
+		reader_link = bpf_program__attach_cgroup(skel->progs.cgrp_skb_ext_read,
+							 cgroup_fd);
+		if (!ASSERT_OK_PTR(reader_link, "attach_cgroup"))
+			goto cleanup;
+		break;
+	case READER_SK_FILTER:
+		filter_fd = bpf_program__fd(skel->progs.sk_filter_skb_ext_read);
+		ret = setsockopt(server_fd, SOL_SOCKET, SO_ATTACH_BPF,
+				 &filter_fd, sizeof(filter_fd));
+		if (!ASSERT_OK(ret, "attach_socket_filter"))
+			goto cleanup;
+		break;
+	}
+
+	if (send_loopback_udp(server_fd))
+		goto cleanup;
+
+	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
+
+cleanup:
+	bpf_link__destroy(reader_link);
+	bpf_tc_hook_destroy(&tc_hook);
+	if (server_fd >= 0)
+		close(server_fd);
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
+	netns_free(ns);
+}
+
+void test_skb_ext_cross_hook(void)
+{
+	struct test_xdp_meta *skel = NULL;
+
+	skel = test_xdp_meta__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
+		return;
+
+	if (test__start_subtest("tc_to_cgrp_ingress"))
+		test_skb_ext_udp(skel, "tc_to_cgrp_ingress", READER_CGRP_SKB);
+	if (test__start_subtest("tc_to_sk_filter"))
+		test_skb_ext_udp(skel, "tc_to_sk_filter", READER_SK_FILTER);
+
+	test_xdp_meta__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 1b6bb20ee7e8..0a3afb5c3461 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -920,4 +920,41 @@ int BPF_PROG(tp_kfree_skb_cow_check, struct sk_buff *skb)
 	return 0;
 }
 
+/* Read skb_ext from cgroup/skb ingress -- tests cross-hook survival */
+SEC("cgroup_skb/ingress")
+int cgrp_skb_ext_read(struct __sk_buff *ctx)
+{
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, 0, &meta))
+		return 1;
+	if (bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0))
+		return 1;
+	if (!check_metadata(meta_have))
+		return 1;
+
+	test_pass = true;
+	return 1;
+}
+
+/* Read skb_ext from socket filter -- tests TC -> sk_filter path */
+SEC("socket")
+int sk_filter_skb_ext_read(struct __sk_buff *ctx)
+{
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, 0, &meta))
+		goto out;
+	if (bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0))
+		goto out;
+	if (!check_metadata(meta_have))
+		goto out;
+
+	test_pass = true;
+out:
+	return ctx->len;
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.43.0

