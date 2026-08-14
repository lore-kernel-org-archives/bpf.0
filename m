Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364A843E097
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 08:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695287; cv=none; b=WsvnHmahJp1z9+72qtV5oWBoE03Itrmvu4bYr9jJ4HOtTTnkaXXX6mwEg50SV26w7XH4OWRVhOxFvSyashg8UskLX4O+dBX4OEeFeEdICpF/eHrwoeEZMIkQ1RaARhUSlQkQ9lD/nmtwd1hL9L683yCvypE/BvhRCm6W89noto4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695287; c=relaxed/simple;
	bh=TMb8X1vdWIpeu9UUp/S6+S8cFTyaPl3Cfq3fwSJcBhc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KwNHRJ9nUkD0fCohABELyxbt0rntg9hWs2VEMaGiqH3mK7VxMxe7PLiF/mUfEAz0YfwjkE15Q5h5bGfLkYa89rWKxdrX43NobzxZYFlHrOFTk81KznouYbQfyfeqg9G5aB/8yaA1JvgNYASGGNHmy250aWpL8rkpsVykcDCAy8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TJ5tj9k/; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TJ5tj9k/"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so139057166b.0
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 01:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1786695279; x=1787300079; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jn7sny1HXte6HBs3YW57QoHTHXgEeijfouy5Vk0k8QQ=;
        b=TJ5tj9k/8T7b+FEZht8pkYvbxBkH3z9Rvr5JgZXx15zHbHlQioxiwFHXlLcAY9hgpw
         pwLMnSnQXoiarHGP/lPZAOgsEoN3NFrvJBzfBl+jOZQJbvxl4CR1NAkyk3zV7bbzWlev
         aSnjS1ANKIaNU0Aww6xXlPRHFwe7bM2MFC0mu0KsoHgdcENhj0Vb/DQtFlT7n5Jcp7kk
         yyX/YV7fFGGMWCw2hvUrZQtmjeJXGPYJMQr3OUBspjLqBPeLc1V75OULmDkuTJs5OEo2
         mwdLGziA+d38LR/Wl1Ch8Kt3GkExhqrbcijg7ANYXmOwakmX/7BO7KicQlVJijn+rpDP
         /J4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786695279; x=1787300079;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jn7sny1HXte6HBs3YW57QoHTHXgEeijfouy5Vk0k8QQ=;
        b=jIv49TBqnGSLkfGV3Yv6XGdy1mPkBFf3YPPMXR9SxTg6tkbkZnR3f5V+fJUXcrkink
         8HMER/xQjKG0xk5Y8f/DZroku61kihUiGJ3DNWzq7F8yUrRYlBGyT/cj5Y7YGim6Vsgr
         ouGRDU8cfHkC8W2yXembs8KPeeu1Gy6QnJQFFihHx8jE6lRPp0UzXww/4P3rhyc2DJ/9
         WHcw2NUz91SaXnWysc1V+kExeDQTsrm8d7hxlIZktJW1OYDM85lRUfhtX+Rn/SGCqXAk
         86ThfVO4kMiwoNCFBAwMjDvTf2wo0TVcp8M7726iVjgfjPGZ/09r7YAuIM6w4R92YFap
         0jjQ==
X-Gm-Message-State: AOJu0YyCc4EdlXe51TBNnUEmuuG7OhVsAVX1UfS2cnYBMCBNf9yjZ/Ao
	QjUAAw27VEzrlqhESFH7/prTFCpK+3EGF71wWqZP3L4H0zomaJu8rcL/YSTJGf/HuZjL4W9u4xw
	ILChLUi0=
X-Gm-Gg: AR+sD10eZR68TXCenfm/Vy/GoyBRSO939Q4OFJVY0lF4wXcfJlZLUM2NHE0+Bf8F4GM
	M4otjMFvR+/HgJLJu8FXEu6Qc8Shi4z0NwRwzgx2hJbnCmQBZKBPomIhpfx5AlFfFCU9KnlO6kt
	84eK8m8wcVchB6RTvQiVpeqtNUym4Y2R6SjoT+jv522Fi7RXezB4GFh5qHwoz1WAMCzkZAYVNme
	TucbAG6/rTSxRtUEjEvRBkTv+w1ZMtT89YumLZhY/V5GHLgwUpXVTrcW9MeIwUQOYKuMQNb8XLR
	ypQaQgKsnJn8W6gWZk7ywEcOS1THjCi622TmC4woaV6ZiOooVuJeWLm87r/3SMebGJF7QRaheok
	RPQ6o3BP8j1tXzWdiqklYV5teJf5P+f2cs6myveueKXwvOVw1mQlKFrPnj2fDCugfqOjqQEs25Z
	r6qo/sdzySsJ1RbvxpZ+UPLtWGncWjTsEadV+PShGxuPx7s5Xhpf+CTKqGMqIaJyjet24vgGrSD
	PngoV9Yq8Nf6zauIvZX8cPwdw+jSeHyXDlwAQ==
X-Received: by 2002:a17:907:5cd:b0:c20:7cb1:9046 with SMTP id a640c23a62f3a-c212a0ed9e9mr168226866b.8.1786695278844;
        Fri, 14 Aug 2026 01:14:38 -0700 (PDT)
Received: from cloudflare.com (79.184.184.176.ipv4.supernova.orange.pl. [79.184.184.176])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c21231f1903sm81232366b.0.2026.08.14.01.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:14:38 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 14 Aug 2026 10:14:12 +0200
Subject: [PATCH net-next 11/14] selftests/bpf: Test skb_ext from LWT in,
 out, and xmit hooks
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-bpf-meta-inside-skb-ext-v1-11-767edd862656@cloudflare.com>
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

Add cross-hook tests for bpf_dynptr_from_skb_ext() covering all
generic LWT program types. For lwt_in, a TC ingress program writes
skb_ext on loopback and the LWT program reads it back. For lwt_out
and lwt_xmit, the LWT programs write skb_ext on the output path and a
TC ingress program reads it back after loopback.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 98 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 45 ++++++++++
 2 files changed, 143 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 82c57ea3957e..7a7537ef80e7 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -1303,6 +1303,95 @@ static void test_skb_ext_nf(struct test_xdp_meta *skel, const char *name)
 	netns_free(ns);
 }
 
+#define LWT_EXT_PIN_PATH "/sys/fs/bpf/skb_ext_lwt"
+
+/* Test skb_ext across LWT hooks on loopback.
+ *
+ * @lwt_prog:  BPF program to pin and attach via ip route encap
+ * @encap_dir: "in", "out", or "xmit"
+ * @writer:    true if lwt_prog writes skb_ext (reader on TC ingress),
+ *             false if lwt_prog reads skb_ext (writer on TC ingress)
+ */
+static void test_skb_ext_lwt(struct test_xdp_meta *skel, const char *name,
+			     struct bpf_program *lwt_prog,
+			     const char *encap_dir, bool writer)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook,
+		    .ifindex = 1 /* IFINDEX_LO */,
+		    .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct sockaddr_in addr = {
+		.sin_family = AF_INET,
+	};
+	struct bpf_program *tc_prog;
+	char buf[TEST_PAYLOAD_LEN];
+	struct netns_obj *ns = NULL;
+	bool pinned = false;
+	int server_fd = -1;
+	int fd = -1;
+	__be16 port;
+	int ret;
+
+	unlink(LWT_EXT_PIN_PATH);
+	ret = bpf_program__pin(lwt_prog, LWT_EXT_PIN_PATH);
+	if (!ASSERT_OK(ret, "pin lwt"))
+		return;
+	pinned = true;
+
+	ns = netns_new(name, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto cleanup;
+
+	SYS(cleanup, "ip addr add 10.0.0.1/32 dev lo");
+	SYS(cleanup, "ip route replace table local local 10.0.0.1 "
+		     "encap bpf %s pinned " LWT_EXT_PIN_PATH " dev lo",
+		     encap_dir);
+
+	server_fd = start_server(AF_INET, SOCK_DGRAM, "10.0.0.1", 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		goto cleanup;
+
+	skel->bss->test_pass = false;
+
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
+		goto cleanup;
+
+	/* When LWT writes, TC ingress reads; when LWT reads, TC ingress writes */
+	tc_prog = writer ? skel->progs.tc_skb_ext_read
+			 : skel->progs.tc_skb_ext_write;
+	tc_opts.prog_fd = bpf_program__fd(tc_prog);
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach"))
+		goto cleanup;
+
+	port = get_socket_local_port(server_fd);
+	if (!ASSERT_GE(port, 0, "get_port"))
+		goto cleanup;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (!ASSERT_GE(fd, 0, "socket"))
+		goto cleanup;
+
+	inet_pton(AF_INET, "10.0.0.1", &addr.sin_addr);
+	addr.sin_port = port;
+	sendto(fd, test_payload, TEST_PAYLOAD_LEN, 0,
+	       (void *)&addr, sizeof(addr));
+	recvfrom(server_fd, buf, sizeof(buf), 0, NULL, NULL);
+
+	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
+
+cleanup:
+	if (fd >= 0)
+		close(fd);
+	bpf_tc_hook_destroy(&tc_hook);
+	if (server_fd >= 0)
+		close(server_fd);
+	netns_free(ns);
+	if (pinned)
+		unlink(LWT_EXT_PIN_PATH);
+}
+
 void test_skb_ext_cross_hook(void)
 {
 	struct test_xdp_meta *skel = NULL;
@@ -1323,6 +1412,15 @@ void test_skb_ext_cross_hook(void)
 		test_cgrp_egress_to_kfree_skb(skel);
 	if (test__start_subtest("tc_to_nf"))
 		test_skb_ext_nf(skel, "tc_to_nf");
+	if (test__start_subtest("tc_to_lwt_in"))
+		test_skb_ext_lwt(skel, "tc_to_lwt_in",
+				 skel->progs.lwt_in_skb_ext_read, "in", false);
+	if (test__start_subtest("lwt_out_to_tc"))
+		test_skb_ext_lwt(skel, "lwt_out_to_tc",
+				 skel->progs.lwt_out_skb_ext_write, "out", true);
+	if (test__start_subtest("lwt_xmit_to_tc"))
+		test_skb_ext_lwt(skel, "lwt_xmit_to_tc",
+				 skel->progs.lwt_xmit_skb_ext_write, "xmit", true);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 0688120f3d40..97c1760fbd6d 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -1089,4 +1089,49 @@ int nf_skb_ext_read(struct bpf_nf_ctx *ctx)
 	return NF_ACCEPT;
 }
 
+SEC("lwt_in")
+int lwt_in_skb_ext_read(struct __sk_buff *ctx)
+{
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, 0, &meta))
+		return BPF_OK;
+	if (bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0))
+		return BPF_OK;
+	if (!check_metadata(meta_have))
+		return BPF_OK;
+
+	test_pass = true;
+	return BPF_OK;
+}
+
+SEC("lwt_out")
+int lwt_out_skb_ext_write(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+
+	if (!is_test_packet_tc(ctx))
+		return BPF_OK;
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return BPF_OK;
+	bpf_dynptr_write(&meta, 0, (void *)meta_want, ARRAY_SIZE(meta_want), 0);
+
+	return BPF_OK;
+}
+
+SEC("lwt_xmit")
+int lwt_xmit_skb_ext_write(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+
+	if (!is_test_packet_tc(ctx))
+		return BPF_OK;
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return BPF_OK;
+	bpf_dynptr_write(&meta, 0, (void *)meta_want, ARRAY_SIZE(meta_want), 0);
+
+	return BPF_OK;
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.43.0

