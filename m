Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ACF4ADD82
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595643; cv=none; b=nPx3MMeRsjkskOG9L5df7fsY05tOmPO/10s87c4dAs52T9DclqyIbYnrGlpLFmfmS5+Hsru4KOXxn0YjogUAuvdt+AbeDF9CJEpaCg3qBgjrfgATO6+Rz0Ug+ZnQotNQkCvMDkL4LW2Ol4PSBA+1XQlbatHtMTc4GputomYaIEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595643; c=relaxed/simple;
	bh=EVONnpJhxUFz486IU4a9j6Oj3D3ZxooBSs6qgNJV6Vk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZX9Ifx934W8lQdt3OT7pznwo1gO4no8tdQCHDmgM1etckyXVj4td8xcG5Pui1MuuYYXXvkTT6EC13g5d70Ccra5GwGnekTVE1wH7fgWatSm6TPX7WP5AMczoW0iqD22BySFGouo39fE72/LI42vx50b7YsMNMKGuaUT+FzVqQRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=BHr0+FYH; arc=none smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BHr0+FYH"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ab0c3c3af6so2374772a12.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 04:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790595639; x=1791200439; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZfhY6+mAdKYE39cSXjTYZrxeOIALDeCH99hZjwvYoiE=;
        b=BHr0+FYHFzlk26vu0wq84Y+fl/ANrLI5XDBOFhcqNvQpA50SjyzljwnumBNvXmQhqG
         IMA2VcEne+HxgkX271QX4xPDQL60h52G1xB2J0TYpRLvjRW1zLSU/4WK6EftvawFmFNh
         ALyRdpTIEYlRMSUWTWgymU/ErX7UIlS2YZ45MWTDGLtqeglNFUGd5IM/SiDVsiDDDMJ+
         bKzt+3/aOKe8OjfgXxkyAeTJqWMD5CzYsrJQIbjVITV5vXW0WtejMLXl9+HamB1YDzcZ
         3kMoWSbBlpYrP7uX4TGerKczyz87gjzZY1u1IrybHo9XuySGEksoawbdY7SWHhhVpmLG
         jB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790595639; x=1791200439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZfhY6+mAdKYE39cSXjTYZrxeOIALDeCH99hZjwvYoiE=;
        b=czPYiRSE7wHeTIcq+JdFxSnjjQdu928HZBxquKsyokU7EVNa2JJiowZRBKo8RvTW9j
         tylwd9eEQyAqQZvWzXT+FMAVmntIulstfi79FdLdm55J85xgfzcIipKBuvfJ0rGJsVFs
         aQHBEp//T7p8Hw8mtPuxxuasEAwx12pfDlGu6NDIuW6UP9gzNpafTHbZqAGNzT6nBQop
         lZ/jiQhcanIQmIXBFAwpQ5K8ukoDrjJToxBTzI4jn+SYLRTgYy+YmdyKXkQ+9dV6LnH7
         zJhu1PDz5XXbyTclKUWBNklQZloA64iy7AznaXBsY8Ju95Hev4fdQU0OJaRhRbaPmLH5
         QBfg==
X-Gm-Message-State: AFq9FYKoVl2N98rIx1t/GVG+gIV+qJQAssZi5L4O3z5Aibu0qccuY4e0
	y/173XuqdArGx68cjj9hMi1rXpBeBmk5ZH9WETX6zGgIjrkvX+FiEHb5eD8Jo6AwKYg=
X-Gm-Gg: AYBFou2whuYE58ZBTv+Xz1xRcExZmoJ9md38f6iOvQKxdx2g2q73/8HnuZHjEldOKX9
	Wgu/D2PHXabMSet6ZbztfFfRoCIaHaIgjvQzu5p511l6fDpIKJTsMIlGZL/UZ8ywk/NpnyZARo4
	BZ+x5Lwyy7bgCshwcRcxuwbTmwHx7cjnH6zeq/SXzJOWLgtcPjKX9dQP0RQIkb9eBskseRFmojc
	FKKIaoOfwFSqf0nH0qPMJilPh72HYilHOVWsf/5MmUWHP+zbcJat/C7LnZWyfMbqUaaaPAMSV+L
	UnrbZy7Yysq8f3+XM3DmLP3W3CbkB19rjC3dKDr5O0tqXPxoNnccILfV8PICoL9pXS5AXWOe7O7
	U3zBDGSnVqIBJXwQL6kn+gbeO1tvsHRDDVe4/2lI0QKlF6KEZ1p3AT2InEoIcufCcfKGrD5ROqZ
	X6dVr/r1cUDbXiB11TtrC8V9C+B4l4w6epxCv+LXUPDgD6H6+iQMhBd3KRU8uFRjK35NMJsRhi4
	lYlcmk=
X-Received: by 2002:a05:6402:3806:b0:6a9:df42:8cba with SMTP id 4fb4d7f45d1cf-6aae8f3906amr7209206a12.32.1790595639254;
        Mon, 28 Sep 2026 04:40:39 -0700 (PDT)
Received: from cloudflare.com ([2a01:110f:491b:1300:c0dd:2af4:566b:b23f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aae5dc1034sm4140608a12.15.2026.09.28.04.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:40:38 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 28 Sep 2026 13:40:29 +0200
Subject: [PATCH net-next 12/15] selftests/bpf: Test passing metadata
 to/from LWT hooks
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-bpf-meta-gated-tracepoints-v1-12-844dbf3e1edf@cloudflare.com>
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

Add cross-hook tests for the metadata stash covering all generic LWT
program types. For lwt_in, a TC ingress program tags the skb on loopback
and the LWT program reads the stashed metadata. For lwt_out and lwt_xmit,
the LWT programs tag the skb on the output path and a TC ingress program
reads the metadata back after loopback.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 121 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |  35 ++++++
 2 files changed, 156 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index eb0d36e7a45d..aea7a1c8a755 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -1638,6 +1638,118 @@ static void test_skb_trace__nf(struct test_xdp_meta *skel, const char *name)
 	netns_free(ns);
 }
 
+#define LWT_EXT_PIN_PATH "/sys/fs/bpf/skb_trace_lwt"
+
+/*
+ * Test metadata passing across LWT hooks on loopback.
+ *
+ * @lwt_prog:  BPF program to pin and attach via ip route encap
+ * @encap_dir: "in", "out", or "xmit"
+ * @writer:    true if lwt_prog tags the skb (reader on TC ingress),
+ *             false if lwt_prog reads the metadata (writer on TC ingress)
+ */
+static void test_skb_trace__lwt(struct test_xdp_meta *skel, const char *name,
+				struct bpf_program *lwt_prog,
+				const char *encap_dir, bool writer)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook,
+		    .ifindex = 1 /* IFINDEX_LO */,
+		    .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct sockaddr_in addr = {
+		.sin_family = AF_INET,
+	};
+	struct bpf_program *tc_prog;
+	struct bpf_link *put_link = NULL;
+	char buf[TEST_PAYLOAD_LEN];
+	struct netns_obj *ns = NULL;
+	bool pinned = false;
+	int server_fd = -1;
+	int fd = -1;
+	int port;
+	int ret;
+	int i;
+
+	put_link = bpf_program__attach(skel->progs.skb_free);
+	if (!ASSERT_OK_PTR(put_link, "put_attach"))
+		return;
+
+	unlink(LWT_EXT_PIN_PATH);
+	ret = bpf_program__pin(lwt_prog, LWT_EXT_PIN_PATH);
+	if (!ASSERT_OK(ret, "pin lwt"))
+		goto cleanup;
+	pinned = true;
+
+	ns = netns_new(name, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto cleanup_prehook;
+
+	SYS(cleanup, "ip addr add 10.0.0.1/32 dev lo");
+	SYS(cleanup, "ip route replace table local local 10.0.0.1 "
+		     "encap bpf %s pinned " LWT_EXT_PIN_PATH " dev lo",
+		     encap_dir);
+
+	server_fd = start_server(AF_INET, SOCK_DGRAM, "10.0.0.1", 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		goto cleanup_prehook;
+
+	skel->bss->test_pass = false;
+	skel->bss->free_count = 0;
+
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
+		goto cleanup_prehook;
+
+	/* When LWT writes, TC ingress reads; when LWT reads, TC ingress writes */
+	tc_prog = writer ? skel->progs.tc_meta_read
+			 : skel->progs.tc_meta_write;
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
+	ret = sendto(fd, test_payload, TEST_PAYLOAD_LEN, 0,
+		     (void *)&addr, sizeof(addr));
+	if (!ASSERT_EQ(ret, TEST_PAYLOAD_LEN, "sendto"))
+		goto cleanup;
+	ret = recvfrom(server_fd, buf, sizeof(buf), 0, NULL, NULL);
+	ASSERT_EQ(ret, TEST_PAYLOAD_LEN, "recvfrom");
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
+	if (fd >= 0)
+		close(fd);
+	bpf_tc_hook_destroy(&tc_hook);
+cleanup_prehook:
+	bpf_link__destroy(put_link);
+	if (server_fd >= 0)
+		close(server_fd);
+	netns_free(ns);
+	if (pinned)
+		unlink(LWT_EXT_PIN_PATH);
+}
+
 void test_skb_trace_cross_hook(void)
 {
 	struct test_xdp_meta *skel = NULL;
@@ -1662,6 +1774,15 @@ void test_skb_trace_cross_hook(void)
 		test_skb_trace__tcp_retrans(skel);
 	if (test__start_subtest("tc_to_nf"))
 		test_skb_trace__nf(skel, "tc_to_nf");
+	if (test__start_subtest("tc_to_lwt_in"))
+		test_skb_trace__lwt(skel, "tc_to_lwt_in",
+				    skel->progs.lwt_in_meta_read, "in", false);
+	if (test__start_subtest("lwt_out_to_tc"))
+		test_skb_trace__lwt(skel, "lwt_out_to_tc",
+				    skel->progs.lwt_out_meta_write, "out", true);
+	if (test__start_subtest("lwt_xmit_to_tc"))
+		test_skb_trace__lwt(skel, "lwt_xmit_to_tc",
+				    skel->progs.lwt_xmit_meta_write, "xmit", true);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index d85b60c24f73..adad5433fc19 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -1009,4 +1009,39 @@ int nf_meta_read(struct bpf_nf_ctx *ctx)
 	return NF_ACCEPT;
 }
 
+SEC("lwt_in")
+int lwt_in_meta_read(struct __sk_buff *ctx)
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
+SEC("lwt_out")
+int lwt_out_meta_write(struct __sk_buff *ctx)
+{
+	if (!is_test_packet_tc(ctx))
+		return BPF_OK;
+	write_meta(ctx, &meta_map);
+
+	return BPF_OK;
+}
+
+SEC("lwt_xmit")
+int lwt_xmit_meta_write(struct __sk_buff *ctx)
+{
+	if (!is_test_packet_tc(ctx))
+		return BPF_OK;
+	write_meta(ctx, &meta_map);
+
+	return BPF_OK;
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.43.0

