Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D3D4AF69C
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595641; cv=none; b=a/W0hRtRE7KMZCTvLEmeBtSnQJyWQDbJBZXcPGy9chzahsP+2B46pndLHki0x8UZB4bUgQpp7YqrYb9NQoueip43bCMXQuydx8RGd+Pc4gfICjxx27DXfPPaaFPPqCbcfXFZXX2agBV4H6svgnd8ojx8yQCp0iYRQSjmnm7RmMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595641; c=relaxed/simple;
	bh=d6KbR59dkcbsD0M9ZUwSWvRlh6H69J/BDDfsQ/xZW3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t5Y8Wh10BBaiE4xdyjGhUs/pKnXIhk92OF4y+4MAM3Ri74BQJ73t04e7Qk9899o+EbFX3X4aX2xJ6FBmnZpmJgEHcMQyjghdpPEw+j+1+VR7/5t8Jke/hCDMZa+2YF8Iwe851eKh7yb/brkzkK7XA2tIoo/ClEasUGWrj81gWuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=D0KUDXPw; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="D0KUDXPw"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2940ef15c1so378282166b.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 04:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790595637; x=1791200437; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HIbsSqHl+MDKm5PxzterHMeikSiHm6pGuzTMdv6hXm4=;
        b=D0KUDXPwtiUn798uaHj7vwPbRXkwLWS7bymj16N3hkAUtAfxkkIy8MbP74DiHDEtS2
         Ct7rWy2yUeDKFiVRF+R1cXXu2WfU8QgcjqKOfZ5oIRDiaTfuIlui3DCA/OXER3WfAcNK
         36AYOSl7M2iukeToVDvua8HbgtRHi2MqaegNg0yWWsLcjUjLI0WLVjOSoSD7h8/A6mG4
         7+Iy9y1nhpQExYaa6wSJJEn0Nmr0umThxgYJqbvjZJvN59JL2guC/PMhntQwI/55a+Jt
         GrNaEZxP4D6WM5LJz7IEJ9lWAFfOb/9HNzl9f4U+rRn3G8vhcAS2TVIaYjxWigjYaSGg
         Ic9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790595637; x=1791200437;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HIbsSqHl+MDKm5PxzterHMeikSiHm6pGuzTMdv6hXm4=;
        b=v6zSVtLgTVNc4e2ZBgLaTRE7otQO5Mje5ygoPA0ZNZSn/cJ1TzVltrObXiFSYlUmXt
         rg/GXQCgPwY7S15WMpLYb3LW0LzUiZVLcINaQ44iC4MkOez8Z0wRCsTCULn2rADl+RKz
         Q6iVlBm1khOSoeGAQkR/g4WzugOiEyAhRZZoLY7RSR+dduOctVAMQwnkrnwfo0Wc2sqi
         0/C/mHaCeVPtaWtk91hvCs4c2pW6HWsCvSZqfimx1viu4JTVM6LmIKvJikZyA4UfgE4R
         /hJ1TAVAfttv1aaW59qyJnBouETKymmFFIifImn2jZXvIQFYSrMeG2QsfiNx1FWD349y
         jZnw==
X-Gm-Message-State: AFuF++njjs8B7Lxvz/DIF00dcsJ76dlQzHyLw1qY++EeKPA/0N3uZEyZ
	wPLxyAXzWTDsXaogSfgmHz+6LQHqitzrD7hMpBR15KCIkLmEFVfHeTuQNmppCvetS7M=
X-Gm-Gg: AYBFou3YTHFrii34eGdfE54RbcmrIlA/6C1EwRROmtJ+ijAnjT+rIKvrW7KYt8/6BIt
	TCrg5AwpkVf9IgyqvkFfEn5suJG0IrQUsi8eWxyBZqlPFbrHQJpmL/gLNYaWHqPEzzABxOPf4qd
	g/2JXutgiTtDxZqGblnQ4H0aadF4IUFIEX489K6Lxwpkts9ieHtJL7RPVpBYLNog3+k2GhyUyN5
	pWLC9I1O5g0q9qIO3pH9uhEIQEiP0CHzZwzL4bEapOJIN3dArM+CNsalDAxqCnK3wymjXmAW1Sn
	PeZJhUHi09p2k9a3yp8f51JMMVgIEKhhczSPCfHzrtHLJzg6MkWzWAzVMetFMpvPDcgrtvD6JEx
	gTfMatTMkJWW2/Nzs9oMNZrFVX4CID59JLWEIi8vv6laEyhWGYCv8Mbgtl7s0UD/WXj7XyoK3HW
	EshmO4R/xu9zCJH5UswkOROmXqrzXqcTJw3N6DZdokwv+9AeTZADI5WUD7rACajqv5ULc625WGS
	b3oCOFIX4toJM4fFNT84dh1TAqrHXIhWGtJgda1XefdJOYqaVMdgNWwMlWt5/b5OE9YUzFCL2qx
	JpUIK9Io9UPz
X-Received: by 2002:a17:907:a890:b0:c29:8a0e:4458 with SMTP id a640c23a62f3a-c2ac231466fmr1001159266b.7.1790595636695;
        Mon, 28 Sep 2026 04:40:36 -0700 (PDT)
Received: from cloudflare.com (2a01-110f-491b-1300-c0dd-2af4-566b-b23f.aa.ipv6.supernova.orange.pl. [2a01:110f:491b:1300:c0dd:2af4:566b:b23f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2af3128c48sm385465566b.3.2026.09.28.04.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:40:36 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 28 Sep 2026 13:40:27 +0200
Subject: [PATCH net-next 10/15] selftests/bpf: Test passing metadata to TCP
 egress
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-bpf-meta-gated-tracepoints-v1-10-844dbf3e1edf@cloudflare.com>
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

Tag the skb at cgroup/skb egress and read the stashed metadata back at TC
egress: for a regular TCP transmission, and for a retransmission, where
the first transmission is dropped at TC and the write-queue original,
tagged via bpf_skb_fclone_orig, passes the metadata to the retransmitted
fast clone via the copy tracepoint.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 216 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |  72 +++++++
 2 files changed, 288 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 890a881a6a1f..ac5c0f067b3f 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -1268,6 +1268,218 @@ static void test_skb_trace__tcp_ingress(struct test_xdp_meta *skel, const char *
 	netns_free(ns);
 }
 
+/*
+ * Test metadata passing across cgroup/skb egress -> TC egress with TCP
+ * traffic.  TCP fast-clones the write-queue skb at tcp_transmit_skb();
+ * both hooks run on the transmitted clone.
+ */
+static void test_skb_trace__tcp_egress(struct test_xdp_meta *skel)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook,
+		    .ifindex = 1 /* IFINDEX_LO */,
+		    .attach_point = BPF_TC_EGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct bpf_link *put_link = NULL;
+	struct bpf_link *cg_link = NULL;
+	struct netns_obj *ns = NULL;
+	char buf[TEST_PAYLOAD_LEN];
+	int server_fd = -1;
+	int cgroup_fd = -1;
+	int client_fd = -1;
+	int conn_fd = -1;
+	int ret;
+	int i;
+
+	put_link = bpf_program__attach(skel->progs.skb_free);
+	if (!ASSERT_OK_PTR(put_link, "put_attach"))
+		return;
+
+	cgroup_fd = test__join_cgroup("/cgrp_to_tc");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		goto cleanup;
+
+	ns = netns_new("cgrp_to_tc", true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto cleanup;
+
+	skel->bss->test_pass = false;
+	skel->bss->free_count = 0;
+
+	cg_link = bpf_program__attach_cgroup(skel->progs.cgrp_meta_write,
+					     cgroup_fd);
+	if (!ASSERT_OK_PTR(cg_link, "attach_cgroup"))
+		goto cleanup;
+
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
+		goto cleanup;
+
+	tc_opts.prog_fd = bpf_program__fd(skel->progs.tc_meta_read_pass);
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach"))
+		goto cleanup;
+
+	server_fd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		goto cleanup;
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect"))
+		goto cleanup;
+
+	conn_fd = accept(server_fd, NULL, NULL);
+	if (!ASSERT_GE(conn_fd, 0, "accept"))
+		goto cleanup;
+
+	ret = send(client_fd, test_payload, TEST_PAYLOAD_LEN, 0);
+	if (!ASSERT_EQ(ret, TEST_PAYLOAD_LEN, "send"))
+		goto cleanup;
+
+	/* Receive -- synchronizes with packet delivery and free */
+	ret = recv(conn_fd, buf, sizeof(buf), 0);
+	ASSERT_EQ(ret, TEST_PAYLOAD_LEN, "recv");
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
+cleanup:
+	if (conn_fd >= 0)
+		close(conn_fd);
+	if (client_fd >= 0)
+		close(client_fd);
+	if (server_fd >= 0)
+		close(server_fd);
+	bpf_link__destroy(cg_link);
+	bpf_link__destroy(put_link);
+	bpf_tc_hook_destroy(&tc_hook);
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
+	netns_free(ns);
+}
+
+/*
+ * Test metadata passing across TCP retransmission with fast-clone
+ * support: cgroup/skb egress -> TC egress.  The cgroup writer tags the
+ * transmitted fast clone and, via bpf_skb_fclone_orig, the write-queue
+ * original.  The TC drop program kills the first transmission; the
+ * retransmit is a fresh fast clone of the tagged original, so the copy
+ * tracepoint propagates the entry to it and the TC reader sees the
+ * metadata.
+ */
+static void test_skb_trace__tcp_retrans(struct test_xdp_meta *skel)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook,
+		    .ifindex = 1 /* IFINDEX_LO */,
+		    .attach_point = BPF_TC_EGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, drop_opts, .handle = 1, .priority = 1);
+	LIBBPF_OPTS(bpf_tc_opts, read_opts, .handle = 2, .priority = 2);
+	struct bpf_link *put_link = NULL;
+	struct bpf_link *copy_link = NULL;
+	struct bpf_link *cg_link = NULL;
+	struct netns_obj *ns = NULL;
+	char buf[TEST_PAYLOAD_LEN];
+	int server_fd = -1;
+	int cgroup_fd = -1;
+	int client_fd = -1;
+	int conn_fd = -1;
+	int ret;
+	int i;
+
+	put_link = bpf_program__attach(skel->progs.skb_free);
+	if (!ASSERT_OK_PTR(put_link, "put_attach"))
+		return;
+
+	copy_link = bpf_program__attach(skel->progs.skb_copy);
+	if (!ASSERT_OK_PTR(copy_link, "copy_attach"))
+		goto cleanup;
+
+	cgroup_fd = test__join_cgroup("/cgrp_to_tc_twins");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		goto cleanup;
+
+	ns = netns_new("cgrp_to_tc_twins", true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto cleanup;
+
+	skel->bss->write_once_done = false;
+	skel->bss->drop_once_done = false;
+	skel->bss->test_pass = false;
+	skel->bss->free_count = 0;
+
+	cg_link = bpf_program__attach_cgroup(skel->progs.cgrp_meta_write_twins,
+					     cgroup_fd);
+	if (!ASSERT_OK_PTR(cg_link, "attach_cgroup"))
+		goto cleanup;
+
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
+		goto cleanup;
+
+	drop_opts.prog_fd = bpf_program__fd(skel->progs.tc_meta_drop_once);
+	ret = bpf_tc_attach(&tc_hook, &drop_opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach drop"))
+		goto cleanup;
+
+	read_opts.prog_fd = bpf_program__fd(skel->progs.tc_meta_read_pass);
+	ret = bpf_tc_attach(&tc_hook, &read_opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach read"))
+		goto cleanup;
+
+	server_fd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		goto cleanup;
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect"))
+		goto cleanup;
+
+	conn_fd = accept(server_fd, NULL, NULL);
+	if (!ASSERT_GE(conn_fd, 0, "accept"))
+		goto cleanup;
+
+	ret = send(client_fd, test_payload, TEST_PAYLOAD_LEN, 0);
+	if (!ASSERT_EQ(ret, TEST_PAYLOAD_LEN, "send"))
+		goto cleanup;
+
+	/* First transmission is dropped at TC; recv unblocks on retransmit */
+	ret = recv(conn_fd, buf, sizeof(buf), 0);
+	ASSERT_EQ(ret, TEST_PAYLOAD_LEN, "recv");
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
+cleanup:
+	if (conn_fd >= 0)
+		close(conn_fd);
+	if (client_fd >= 0)
+		close(client_fd);
+	if (server_fd >= 0)
+		close(server_fd);
+	bpf_link__destroy(cg_link);
+	bpf_link__destroy(copy_link);
+	bpf_link__destroy(put_link);
+	bpf_tc_hook_destroy(&tc_hook);
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
+	netns_free(ns);
+}
+
 /*
  * Test skb_ext survival until skb free: cgroup/skb egress -> kfree_skb.
  * Send UDP to a closed port. The packet is dropped, triggering kfree_skb.
@@ -1372,6 +1584,10 @@ void test_skb_trace_cross_hook(void)
 		test_skb_trace__tcp_ingress(skel, "tc_to_skops", READER_SKOPS);
 	if (test__start_subtest("cgrp_egress_to_kfree_skb"))
 		test_cgrp_egress_to_kfree_skb(skel);
+	if (test__start_subtest("cgrp_egress_to_tc_egress"))
+		test_skb_trace__tcp_egress(skel);
+	if (test__start_subtest("cgrp_egress_to_tc_egress_fclone"))
+		test_skb_trace__tcp_retrans(skel);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 9ff6ef4b7f3c..50aa045bcc22 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -736,6 +736,44 @@ int tc_meta_read(struct __sk_buff *ctx)
 	return TC_ACT_UNSPEC;
 }
 
+/*
+ * Read skb_ext at TC, never drop -- for cross-hook tests where untagged
+ * packets (e.g. TCP handshake) must pass through the same hook.
+ */
+SEC("tc")
+int tc_meta_read_pass(struct __sk_buff *ctx)
+{
+	__u8 *meta_have;
+
+	meta_have = bpf_map_lookup_elem(&meta_map, &ctx);
+	if (!meta_have)
+		return TC_ACT_UNSPEC;
+	if (!check_metadata(meta_have))
+		return TC_ACT_UNSPEC;
+
+	test_pass = true;
+	return TC_ACT_UNSPEC;
+}
+
+bool drop_once_done;
+
+/* Drop the first packet carrying an skb_ext entry -- force TCP retransmit */
+SEC("tc")
+int tc_meta_drop_once(struct __sk_buff *ctx)
+{
+	__u8 *meta_have;
+
+	if (drop_once_done)
+		return TC_ACT_UNSPEC;
+
+	meta_have = bpf_map_lookup_elem(&meta_map, &ctx);
+	if (!meta_have)
+		return TC_ACT_UNSPEC;
+
+	drop_once_done = true;
+	return TC_ACT_SHOT;
+}
+
 int free_count;
 
 SEC("raw_tp/skb_free")
@@ -900,6 +938,40 @@ int cgrp_meta_write_once(struct __sk_buff *ctx)
 	return 1;
 }
 
+/*
+ * Write skb_ext from cgroup/skb egress on both fast-clone twins: the
+ * transmitted packet is a fast clone of the write-queue original; tag
+ * both so the retransmit (a fresh clone of the tagged original) inherits
+ * the entry via the skb_copy tracepoint.
+ */
+SEC("cgroup_skb/egress")
+int cgrp_meta_write_twins(struct __sk_buff *ctx)
+{
+	struct sk_buff *twin;
+	__u8 *meta_have;
+
+	if (write_once_done || !is_test_packet_tc(ctx))
+		return 1;
+
+	write_meta(ctx, &meta_map);
+	write_once_done = true;
+
+	twin = bpf_skb_fclone_orig(bpf_cast_to_kern_ctx(ctx));
+	if (!twin)
+		return 1;
+
+	if (bpf_map_update_elem(&meta_map, &twin, &meta_want, BPF_NOEXIST))
+		return 1;
+	bpf_trace_skb(twin, 0);
+
+	meta_have = bpf_map_lookup_elem(&meta_map, &twin);
+	if (!meta_have)
+		return 1;
+	__builtin_memcpy(meta_have, meta_want, META_SIZE);
+
+	return 1;
+}
+
 /* Read skb_ext from tp_btf/kfree_skb -- tests survival until skb free */
 SEC("tp_btf/kfree_skb")
 int BPF_PROG(tp_kfree_meta_read, struct sk_buff *skb)

-- 
2.43.0

