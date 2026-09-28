Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AD64B1CE9
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595644; cv=none; b=guQ8KhPwlooUsTBxXxRpgNofrqwbSZAyARQlhdgXcroT1YmLZUjKwRRYUkqoce5pI4+ZxD7GrF3r+f5fKLSs7qTUWXtaqRPr3Z3bOl5r488n4hGj5fYTEExRllViCxuvaNbl+RXirJOs2yfZGV0H96oXgq2m7boziP9WWBpTlGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595644; c=relaxed/simple;
	bh=835jg8ZpaMjYM//s+mTk1Mi1qT6Ho0aGGnBmCmapF8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XEvHIpAtljfMDzXUrLSlpEWcHKC3ouWwsi0dC0TLinEL9+zsIHhK13DFOHS1NapyZeeEKvAyiBzkqRw3KAyx6/VBNL04DH9qarPJ20hmaMTnjSkmFX9qIKpZlyQuC4RXKsc/Ncbt527lKBoEbDckLDVIu13wxq+y4sQyrZzZNII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PWaU0zDa; arc=none smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PWaU0zDa"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aaeeacce15so4040709a12.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 04:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790595640; x=1791200440; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SPmWnptKXQkIxGyX9n6xtXhxhdar8iB2CFlfTbTBGXc=;
        b=PWaU0zDajwYSkRGKvVLJHm4mBY+19jwRgQAj8VHUzJv5Hh4jb6ql8tHHvMeetwO29Y
         rYFHPIPNEVHB/ZKPbl3mN2E7uNR4yedAAH4TYskes5AIjQcFE+EHC+FEH7jlnYY6m+0v
         emqXsoXfe+bC3MlEuU367KZMLU4O3eylsJVbZ+y3vQ/f0oj6Jksew8ZvhYPLN+tJRMeh
         HL0kd1S5DhZAymLpz01W5rYsxiMQkoNrKpwgSrPUJpI1SXjIoNzRuu37HMgluBIg6XjA
         /aqATFQ2MmbtLbkX7kEm+Cr0uwpyVYTuQlOSJJbFOJLkZuhsCZ5WgdNaiZoHUjlSdd0X
         8Xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790595640; x=1791200440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SPmWnptKXQkIxGyX9n6xtXhxhdar8iB2CFlfTbTBGXc=;
        b=bayy4OS6dQCq51aEIm3nJgiLuxjiDnoPNsgbHNR7NvbbTrZctwSa9wKm3DFNbaz8VU
         9GlFdn+8kLD8SaZrRk5PGl9oMrOBw0b4SDxasmUJAgMHqCLFYX//tdMTU6jqXF04U3pS
         SYvXdNx58bcnWRLT3v0RYjBHIavgvS0AUt2jF6B3LSTwUjGxPcJnX6dG0EJedmfSUHgd
         YcrnXDUFiIwG9RSbMjnExezjevrmMmbiGi/7zvxYnCTQSWPdEhonejv0RkM3UvbL76Wy
         BfNlzJH6gBi+rb0tEiVhMAqs3/g8eWmU1scM1nfeK4B6BMyY73IVH2WSYusiT+GJhtnH
         heSg==
X-Gm-Message-State: AFuF++nxI4Cj66Lyypi5Mf/LJD0Q3Msg2oH5W8vqTW00Gfuc54HK1+N6
	qjPIstD5zG98nQc7GmFKGFe5+wPyKXAaIkYQ/4FHQ+26gwMUF0SgA6ef5BrqY3eokUM=
X-Gm-Gg: AYBFou2lngOrITwDOoYl7w0bGDXbgtflub75yBbbO6E6wXQgxkGv8mJnTMrWZBNA05m
	io3O6xIYxsRKnsXKKAyXL834WoacL3UcGSxVqQySyHOLES50ubg/7xPgNGoPPJPGzyYS074NWjF
	yZh7NLePTzxrOtPpFxtdp9I1rRL1zwl0dp0Zvot1k35RCG1lNxOgSBtdmyEcg3MHNF/jXomNL2e
	JKcFXXcACsCexZZFkdFLkOS5J/vf/+pSTC94UknQg3U+TQG/KdMGYNxGbcXvX/QbuorLio/8n22
	VnSD0PIza3VUFaG9EdmCUFv5WeOYhqps14d5i5/jswTagwDWc1uilrMmKG7XneOHuc0Il9rZnuD
	bOjqwt3/oZ8LNmWw+5VZBpcRZza/lu0S+uCpKuQL7ptT1rwcO6vuMTB41mTJpCIbrO1CFURGIiq
	wmPaSOJVKZQ9hBcionXqoh/IQJqIO2sF2H5xgWchtAborMwgx1Bb6XhqXFKI9n4u/yHBH/SzVUp
	7NVpOWcF7lIek72AmT7ItmejO/6MHiu/yvDL5F8EowsbTawjNakIl9upwOM2dt9M/8LmIA1Nm/o
	4VqXGT4RP/Kv
X-Received: by 2002:a17:906:9f8f:b0:c26:1648:a076 with SMTP id a640c23a62f3a-c2ac25c9ad8mr1060539766b.49.1790595640445;
        Mon, 28 Sep 2026 04:40:40 -0700 (PDT)
Received: from cloudflare.com (2a01-110f-491b-1300-c0dd-2af4-566b-b23f.aa.ipv6.supernova.orange.pl. [2a01:110f:491b:1300:c0dd:2af4:566b:b23f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dbfde3194sm257405666b.4.2026.09.28.04.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:40:40 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 28 Sep 2026 13:40:30 +0200
Subject: [PATCH net-next 13/15] selftests/bpf: Test passing metadata to
 seg6local End.BPF hook
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-bpf-meta-gated-tracepoints-v1-13-844dbf3e1edf@cloudflare.com>
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

Test accessing the metadata stash from lwt_seg6local context:
- TC tags the encapped packet leaving NS1,
- NS2 runs End.BPF for fd01::1 which reads the stashed metadata back,
- NS3 receives the packet and decapsulates it.

Note that End.BPF cannot deliver locally since seg6_lookup_nexthop rejects
loopback routes, hence a three netns setup is necessary.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 189 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |  16 ++
 2 files changed, 205 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index aea7a1c8a755..ae89eccffd2d 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -1750,6 +1750,193 @@ static void test_skb_trace__lwt(struct test_xdp_meta *skel, const char *name,
 		unlink(LWT_EXT_PIN_PATH);
 }
 
+#define SEG6_PIN_PATH "/sys/fs/bpf/skb_trace_seg6local"
+
+/*
+ * Test metadata passing across TC egress -> seg6local End.BPF hook.
+ *
+ * Topology:
+ *
+ *     NS1           NS2            NS3
+ *   lo veth1 <-> veth2 veth3 <-> veth4 lo
+ *
+ * NS1 encaps fb01::2 with SRH (segments fd01::1,fd01::2) on output and
+ * tags the skb at TC egress on veth1. NS2 runs End.BPF for fd01::1,
+ * which reads the stashed metadata, then forwards to NS3
+ * (seg6_lookup_nexthop rejects loopback routes with
+ * local_delivery=false, so End.BPF cannot deliver locally). NS3 has
+ * fd01::2 local, decapsulates, and delivers the inner UDP (dst=fb01::2)
+ * to a local socket for test synchronization.
+ *
+ * The TC program drops non-test packets, so NDP is bypassed with a
+ * static neighbor entry on the NS1->NS2 hop.
+ */
+static void test_skb_trace__seg6local(struct test_xdp_meta *skel)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_EGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct bpf_link *put_link = NULL;
+	struct nstoken *nstoken = NULL;
+	struct sockaddr_in6 dst = {};
+	char buf[TEST_PAYLOAD_LEN];
+	bool pinned = false;
+	int client_fd = -1;
+	int server_fd = -1;
+	ssize_t bytes;
+	int ret;
+	int i;
+
+	unlink(SEG6_PIN_PATH);
+	ret = bpf_program__pin(skel->progs.seg6local_meta_read,
+			       SEG6_PIN_PATH);
+	if (!ASSERT_OK(ret, "pin seg6local"))
+		return;
+	pinned = true;
+
+	skel->bss->test_pass = false;
+	skel->bss->free_count = 0;
+
+	put_link = bpf_program__attach(skel->progs.skb_free);
+	if (!ASSERT_OK_PTR(put_link, "put_attach"))
+		goto cleanup;
+
+	SYS(cleanup, "ip netns add seg6_1");
+	SYS(cleanup, "ip netns add seg6_2");
+	SYS(cleanup, "ip netns add seg6_3");
+
+	/* NS1 <-> NS2 veth pair; static NDP since TC drops NS/NA */
+	SYS(cleanup, "ip -n seg6_1 link add veth1 type veth peer name veth2 netns seg6_2");
+	SYS(cleanup, "ip -n seg6_1 link set dev veth1 up");
+	SYS(cleanup, "ip -n seg6_2 link set dev veth2 address 02:00:00:00:00:02");
+	SYS(cleanup, "ip -n seg6_2 link set dev veth2 up");
+	SYS(cleanup, "ip -n seg6_1 -6 addr add fb00::12/16 dev veth1 scope link nodad");
+	SYS(cleanup, "ip -n seg6_2 -6 addr add fb00::21/16 dev veth2 scope link nodad");
+	SYS(cleanup, "ip -n seg6_1 -6 neigh add fb00::21 lladdr 02:00:00:00:00:02 "
+		     "nud permanent dev veth1");
+
+	/* NS2 <-> NS3 veth pair */
+	SYS(cleanup, "ip -n seg6_2 link add veth3 type veth peer name veth4 netns seg6_3");
+	SYS(cleanup, "ip -n seg6_2 link set dev veth3 up");
+	SYS(cleanup, "ip -n seg6_3 link set dev veth4 up");
+	SYS(cleanup, "ip -n seg6_2 -6 addr add fb00::34/16 dev veth3 scope link nodad");
+	SYS(cleanup, "ip -n seg6_3 -6 addr add fb00::43/16 dev veth4 scope link nodad");
+
+	/* NS1: source address + SRH encap on output + route for fd01::/16 */
+	SYS(cleanup, "ip -n seg6_1 link set dev lo up");
+	SYS(cleanup, "ip -n seg6_1 -6 addr add fb01::1/128 dev lo nodad");
+	SYS(cleanup, "ip -n seg6_1 -6 route add fb01::2 encap seg6 mode encap "
+		     "segs fd01::1,fd01::2 dev veth1 via fb00::21");
+	SYS(cleanup, "ip -n seg6_1 -6 route add fd01::/16 dev veth1 via fb00::21");
+
+	/* NS2: seg6local End.BPF for fd01::1, then forward to NS3.
+	 * Use open_netns so the pinned prog on bpffs is accessible.
+	 */
+	nstoken = open_netns("seg6_2");
+	if (!ASSERT_OK_PTR(nstoken, "open seg6_2"))
+		goto cleanup;
+
+	SYS(cleanup, "ip link set dev lo up");
+	SYS(cleanup, "sysctl -wq net.ipv6.conf.all.forwarding=1");
+	SYS(cleanup, "ip -6 route add fd01::2/128 dev veth3 via fb00::43");
+	SYS(cleanup, "ip -6 route add fd01::1 encap seg6local "
+		     "action End.BPF endpoint pinned " SEG6_PIN_PATH " dev veth2");
+
+	close_netns(nstoken);
+	nstoken = NULL;
+
+	/* NS3: decap point + UDP server.
+	 * fd01::2 local triggers SRH decap (segments_left=0).
+	 * fb01::2 local delivers the inner UDP to the socket.
+	 */
+	nstoken = open_netns("seg6_3");
+	if (!ASSERT_OK_PTR(nstoken, "open seg6_3"))
+		goto cleanup;
+
+	SYS(cleanup, "ip link set dev lo up");
+	SYS(cleanup, "sysctl -wq net.ipv6.conf.all.seg6_enabled=1");
+	SYS(cleanup, "sysctl -wq net.ipv6.conf.lo.seg6_enabled=1");
+	SYS(cleanup, "sysctl -wq net.ipv6.conf.veth4.seg6_enabled=1");
+	SYS(cleanup, "ip -6 addr add fd01::2/128 dev lo nodad");
+	SYS(cleanup, "ip -6 addr add fb01::2/128 dev lo nodad");
+
+	server_fd = start_server(AF_INET6, SOCK_DGRAM, "fb01::2", 1234, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		goto cleanup;
+
+	close_netns(nstoken);
+	nstoken = NULL;
+
+	/* NS1: write skb_ext at TC egress on veth1, then send.
+	 * TC egress fires after seg6 encap, on the encapped packet.
+	 */
+	nstoken = open_netns("seg6_1");
+	if (!ASSERT_OK_PTR(nstoken, "open seg6_1"))
+		goto cleanup;
+
+	tc_hook.ifindex = if_nametoindex("veth1");
+	if (!ASSERT_GT(tc_hook.ifindex, 0, "ifindex veth1"))
+		goto cleanup;
+
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
+		goto cleanup;
+
+	tc_opts.prog_fd = bpf_program__fd(skel->progs.tc_meta_write);
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach"))
+		goto cleanup;
+
+	client_fd = socket(AF_INET6, SOCK_DGRAM, 0);
+	if (!ASSERT_GE(client_fd, 0, "socket"))
+		goto cleanup;
+
+	dst.sin6_family = AF_INET6;
+	dst.sin6_port = htons(1234);
+	inet_pton(AF_INET6, "fb01::2", &dst.sin6_addr);
+
+	bytes = sendto(client_fd, test_payload, TEST_PAYLOAD_LEN, 0,
+		       (void *)&dst, sizeof(dst));
+
+	close_netns(nstoken);
+	nstoken = NULL;
+
+	if (!ASSERT_EQ(bytes, TEST_PAYLOAD_LEN, "sendto"))
+		goto cleanup;
+
+	/* Receive decapsulated packet -- synchronizes with seg6local */
+	nstoken = open_netns("seg6_3");
+	if (!ASSERT_OK_PTR(nstoken, "open seg6_3"))
+		goto cleanup;
+
+	bytes = recvfrom(server_fd, buf, sizeof(buf), 0, NULL, NULL);
+	ASSERT_EQ(bytes, TEST_PAYLOAD_LEN, "recvfrom");
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
+	close_netns(nstoken);
+	if (server_fd >= 0)
+		close(server_fd);
+	if (client_fd >= 0)
+		close(client_fd);
+	SYS_NOFAIL("ip netns del seg6_3");
+	SYS_NOFAIL("ip netns del seg6_2");
+	SYS_NOFAIL("ip netns del seg6_1");
+	if (pinned)
+		unlink(SEG6_PIN_PATH);
+	bpf_link__destroy(put_link);
+}
+
 void test_skb_trace_cross_hook(void)
 {
 	struct test_xdp_meta *skel = NULL;
@@ -1783,6 +1970,8 @@ void test_skb_trace_cross_hook(void)
 	if (test__start_subtest("lwt_xmit_to_tc"))
 		test_skb_trace__lwt(skel, "lwt_xmit_to_tc",
 				    skel->progs.lwt_xmit_meta_write, "xmit", true);
+	if (test__start_subtest("tc_to_seg6local"))
+		test_skb_trace__seg6local(skel);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index adad5433fc19..3e323bb7eb96 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -1044,4 +1044,20 @@ int lwt_xmit_meta_write(struct __sk_buff *ctx)
 	return BPF_OK;
 }
 
+/* Read stashed metadata from seg6local End.BPF */
+SEC("lwt_seg6local")
+int seg6local_meta_read(struct __sk_buff *ctx)
+{
+	__u8 *meta_have;
+
+	meta_have = bpf_map_lookup_elem(&meta_map, &ctx);
+	if (!meta_have)
+		return BPF_OK;
+	if (!check_metadata(meta_have))
+		return BPF_OK;
+
+	test_pass = true;
+	return BPF_OK;
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.43.0

