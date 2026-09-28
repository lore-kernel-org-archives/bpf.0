Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED8A4AD7F2
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595638; cv=none; b=XgKcdbvV2CUAgJmCueDBsqvEzXjYnW48/6pAcb9A4oy0pMgSN2L71Ncmkp0lsnKe27RGzmR3Zbi5WcFG/1buB46MltnJSirZGQAls7p9nq8FRc5ul1m+2+5nsrIrgfvxpNsQgN5ssYDd3rBlTtc15kc/ZxhivyfpP0D4xh93NUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595638; c=relaxed/simple;
	bh=KJViGcjqCJ6yKWHKbu+URdi2n8eZvO50BW3nGS6SXgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RVyrGTcCITEHE7ccxZnUDS1gtlECHxijNshmFK+4zGh/629vpsC2VKmoTFJ1/5h2QQPEaXYeuHpForI1BqkvylHAs4zc4JvtbNCSSC6dKaAfBqd9g5/VUjMB4kkn5qtBiK6NgK6c6T1RmZLLk80b/PSwqHlEf4b7xVpG9VQHFEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XCZyyKE4; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XCZyyKE4"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c264788fd58so417405766b.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 04:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790595634; x=1791200434; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9PcsxsNzi+UBd8Ouihl+G1MJtyinMbnzl78z4xMdrVA=;
        b=XCZyyKE4uiX6nIfndiH6rIfFaNh9BXuOfuafLt599RJYlMpUm9UUcJRtOKTjIAyKG0
         A2mFugZLT2ExLwf+fsx4fPypbVRe05DZ4PaP4/LPn1FvoWx/ZrvGdsyitgeje0MTk9TP
         9jOZhwT0UoltncAaZbb+OaserDomL4lPS78HWCclHhdQNKg9cra6g1hurh+HT5OU/oM8
         JqFHUIzkwKBqlyXjSzYcSG2lyOd++WZiuY7EkD6WWKgvTQ/ZvoG2dWdZGHIKAivXp4OJ
         eRo5mH4QOtX0ZFQNrsdGVoh+ON1oI8IkDDK9+CSyjSbWuRtYlzcIY2SmjgBksyQ6CriG
         sicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790595634; x=1791200434;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9PcsxsNzi+UBd8Ouihl+G1MJtyinMbnzl78z4xMdrVA=;
        b=DELHBnaI3GxeNdk9ZpaaZ3Dl/vkrgJGZ9FQgkpl8bU9pxl5ZGvqSJo5rITEpGCFDcd
         zhRM+WUueHoX5w+jZVxxn1kTXKiPB7sG9HrPcmp8VmmG5EmXRQDtEfFZhpGztMWGdmSv
         wg/YtmTLWpLu5vvI3GU3/jYThqqRuXYZblm15foOa0fowDaLM8PlXELt1Qul8L9WElEm
         FyuA1voxtKsG1nS8MHgz/onqpZutrOnDjKaQKwl3zy9J+lCyo6aT25449hu/sCezQTyW
         W/B/otzolOTC8ELYE3Wy7c/a/jLooh8WmOypUnrevWw5VckiZ/7majkFljtf7glqtSEG
         hVSg==
X-Gm-Message-State: AFuF++nfEPeismG+jaj4HwikgcgWAunc8zdWCvKGCaVTWPtC5WQmYuF4
	F0t8s3Jn2SDgtRVK7Gn6FD2zu/vcshMf+QmknEVXkgPerPXSENdBHTybB2Qn26Wot0g=
X-Gm-Gg: AYBFou0SQ1aSQ6jB9bsAFNz6uYkZnJTZeGuLurdbx/Y6oM6UdHvoEqNDZdH3Uefi2gf
	S6MIsfl/jgl8wTbOJzzs6iTfYPZGUph9kAzYBx5X66oD4KYf5ndoGv9qGMoT5Wy4WJAJdbN/bmK
	xmWbRRfXXI5yEmB1aI/da84bco6XxSaXVrd6UVtAmz41l3uje1XI/zXexgihpDhLRchuLbRasH2
	ql6lhWEb5jzflH3tcmIzmdqyFjWQlrxdvB0P5WgMbISRe6uMDXZ8Cxy+Qr6l+aScBlDHuPGeKJ+
	QxLZ7epzIHbc2BsLU3mMYjBDc2tTemzFqlVpUsiCU/Zl+uVUHYSDc9kr0JjrzNrBEiROBdeG31x
	oe5YV/Ox1u7HLFq94uoGWnpvJmfVenGbMnlsaEuuULMNYeDSWVfFKIywRV9ClFZWcytx6o7rZc5
	TSdba0Oed785fgia8q1LP3oWglfKfoXVNqwA/JvNH6D8jHZtc9ffMJJwitXobi4U4OqvZ4m3hJa
	JQXrgEEW/sDKe9LGVgWL0J7DB9faeAyhr9SlgXzuN0mB+FzPS6HIrPjeoKWSdVMjsHzigJBm3K6
	UrqINyJCSQjF
X-Received: by 2002:a17:907:940e:b0:c26:19de:9acf with SMTP id a640c23a62f3a-c2aea062612mr798224266b.39.1790595634164;
        Mon, 28 Sep 2026 04:40:34 -0700 (PDT)
Received: from cloudflare.com (2a01-110f-491b-1300-c0dd-2af4-566b-b23f.aa.ipv6.supernova.orange.pl. [2a01:110f:491b:1300:c0dd:2af4:566b:b23f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dd68786a1sm151616466b.62.2026.09.28.04.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:40:33 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 28 Sep 2026 13:40:25 +0200
Subject: [PATCH net-next 08/15] selftests/bpf: Test passing metadata to
 sock_ops and LSM hooks
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-bpf-meta-gated-tracepoints-v1-8-844dbf3e1edf@cloudflare.com>
References: <20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com>
In-Reply-To: <20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com>
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

Extend metadata cross-hook coverage to the TCP ingress path: attach a TC
ingress program on loopback that tags the skb with bpf_trace_skb(), and
read the stashed metadata back from a sock_ops program
(BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB, reaching the skb via
bpf_sock_ops_kern->skb) and from the LSM inet_conn_established hook.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 113 ++++++++++++++++++++-
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |  68 +++++++++++++
 2 files changed, 178 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 25a16daf5fdf..b90ae0a6156d 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -1162,6 +1162,112 @@ static void test_skb_trace__udp(struct test_xdp_meta *skel, const char *name,
 	netns_free(ns);
 }
 
+enum tcp_reader_type {
+	READER_SKOPS,
+	READER_LSM,
+};
+
+/* Test metadata passing across TC ingress -> TCP reader hook */
+static void test_skb_trace__tcp_ingress(struct test_xdp_meta *skel, const char *name,
+					enum tcp_reader_type reader)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook,
+		    .ifindex = 1 /* IFINDEX_LO */,
+		    .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct bpf_link *reader_link = NULL;
+	struct bpf_link *put_link = NULL;
+	struct netns_obj *ns = NULL;
+	int server_fd = -1;
+	int cgroup_fd = -1;
+	int client_fd = -1;
+	int conn_fd = -1;
+	int port;
+	int ret;
+	int i;
+
+	put_link = bpf_program__attach(skel->progs.skb_free);
+	if (!ASSERT_OK_PTR(put_link, "put_attach"))
+		return;
+
+	ns = netns_new(name, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto cleanup;
+
+	cgroup_fd = test__join_cgroup("/skb_ext_tcp");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		goto cleanup;
+
+	server_fd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		goto cleanup;
+
+	port = get_socket_local_port(server_fd);
+	if (!ASSERT_GE(port, 0, "get_port"))
+		goto cleanup;
+
+	skel->bss->target_port = port;
+	skel->bss->test_pass = false;
+	skel->bss->free_count = 0;
+
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
+		goto cleanup;
+
+	tc_opts.prog_fd = bpf_program__fd(skel->progs.tc_meta_write_port);
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach"))
+		goto cleanup;
+
+	switch (reader) {
+	case READER_SKOPS:
+		reader_link = bpf_program__attach_cgroup(skel->progs.skops_meta_read,
+							 cgroup_fd);
+		if (!ASSERT_OK_PTR(reader_link, "attach_skops"))
+			goto cleanup;
+		break;
+	case READER_LSM:
+		reader_link = bpf_program__attach_lsm(skel->progs.lsm_meta_read);
+		if (!ASSERT_OK_PTR(reader_link, "attach_lsm"))
+			goto cleanup;
+		break;
+	}
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect"))
+		goto cleanup;
+
+	conn_fd = accept(server_fd, NULL, NULL);
+	if (!ASSERT_GE(conn_fd, 0, "accept"))
+		goto cleanup;
+
+	/* Poll every 10 msec up to 1 sec */
+	for (i = 0; i < 100 && !skel->bss->test_pass; i++)
+		usleep(10000);
+	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
+
+	/* Skb is freed after RX delivery; wait for free tp */
+	for (i = 0; i < 100 && !skel->bss->free_count; i++)
+		usleep(10000);
+	ASSERT_GE(skel->bss->free_count, 1, "free_count");
+
+	assert_meta_stash_empty(skel->maps.meta_map);
+
+cleanup:
+	if (conn_fd >= 0)
+		close(conn_fd);
+	if (client_fd >= 0)
+		close(client_fd);
+	bpf_link__destroy(reader_link);
+	bpf_link__destroy(put_link);
+	bpf_tc_hook_destroy(&tc_hook);
+	if (server_fd >= 0)
+		close(server_fd);
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
+	netns_free(ns);
+}
+
 void test_skb_trace_cross_hook(void)
 {
 	struct test_xdp_meta *skel = NULL;
@@ -1174,6 +1280,7 @@ void test_skb_trace_cross_hook(void)
 		test_skb_trace__udp(skel, "tc_to_cgrp_ingress", READER_CGRP_SKB);
 	if (test__start_subtest("tc_to_sk_filter"))
 		test_skb_trace__udp(skel, "tc_to_sk_filter", READER_SK_FILTER);
-
-	test_xdp_meta__destroy(skel);
-}
+	if (test__start_subtest("tc_to_lsm"))
+		test_skb_trace__tcp_ingress(skel, "tc_to_lsm", READER_LSM);
+	if (test__start_subtest("tc_to_skops"))
+		test_skb_trace__tcp_ingress(skel, "tc_to_skops", READER_SKOPS);
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 32c39c264cd7..4da50c848beb 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -788,6 +788,74 @@ int cgrp_meta_read(struct __sk_buff *ctx)
 	return 1;
 }
 
+__be16 target_port;
+
+#define TCPV4_HDR_OFF	(sizeof(struct ethhdr) + sizeof(struct iphdr))
+#define TCPV4_SPORT_OFF	(TCPV4_HDR_OFF + offsetof(struct tcphdr, source))
+#define TCPV4_DPORT_OFF	(TCPV4_HDR_OFF + offsetof(struct tcphdr, dest))
+
+/* Write metadata on TCP packets to/from target_port */
+SEC("tc")
+int tc_meta_write_port(struct __sk_buff *ctx)
+{
+	__be16 sport, dport;
+
+	if (ctx->protocol != __bpf_constant_htons(ETH_P_IP))
+		return TC_ACT_UNSPEC;
+	if (bpf_skb_load_bytes(ctx, TCPV4_SPORT_OFF, &sport, sizeof(sport)))
+		return TC_ACT_UNSPEC;
+	if (bpf_skb_load_bytes(ctx, TCPV4_DPORT_OFF, &dport, sizeof(dport)))
+		return TC_ACT_UNSPEC;
+	if (sport != target_port && dport != target_port)
+		return TC_ACT_UNSPEC;
+
+	write_meta(ctx, &meta_map);
+
+	return TC_ACT_UNSPEC;
+}
+
+/* Read stashed metadata from sock_ops passive established hook */
+SEC("sockops")
+int skops_meta_read(struct bpf_sock_ops *ctx)
+{
+	struct bpf_sock_ops_kern *kctx;
+	struct sk_buff *skb;
+	__u8 *meta_have;
+
+	if (ctx->op != BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB)
+		return 1;
+
+	kctx = bpf_cast_to_kern_ctx(ctx);
+	skb = kctx->skb;
+	if (!skb)
+		return 1;
+
+	meta_have = bpf_map_lookup_elem(&meta_map, &skb);
+	if (!meta_have)
+		return 1;
+	if (!check_metadata(meta_have))
+		return 1;
+
+	test_pass = true;
+	return 1;
+}
+
+/* Read stashed metadata from LSM inet_conn_established hook */
+SEC("lsm/inet_conn_established")
+int BPF_PROG(lsm_meta_read, struct sock *sk, struct sk_buff *skb)
+{
+	__u8 *meta_have;
+
+	meta_have = bpf_map_lookup_elem(&meta_map, &skb);
+	if (!meta_have)
+		return 0;
+	if (!check_metadata(meta_have))
+		return 0;
+
+	test_pass = true;
+	return 0;
+}
+
 /* Read skb_ext from socket filter -- tests TC -> sk_filter path */
 SEC("socket")
 int sk_filter_meta_read(struct __sk_buff *ctx)

-- 
2.43.0

