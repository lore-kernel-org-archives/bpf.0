Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E9949DBB7
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048987; cv=none; b=ec1QwRThpXoOvmv4Sc6vvD96mmRggz8020npe+Jh4tqUcyI7+1lh/qxfdKCdJEeNF65Wfb2zstfQxIoBNagV0jo2PAHmYT2iI8bewSrosi5twZDa7t1JXpc616S5Q8j6tnpB5/tdXAFHr80f9jAW8k3KDdoEYR2ek5eq7hUgiro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048987; c=relaxed/simple;
	bh=Th9fOuo593MEakXdF6e+fuy7/Sg4Fdb28BQWy6QPbuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V0MXPorZfudjmt45OtJICDW0EOGKJ1hvv7vC/+qBvTJdb2HIg+CAZYt/c+noWTjq7hP2SfgRHwQ+5L7eUFccYK1Q/VJxsq8M4/wuk+sFKrs+9xrJ6Pbm2tXRwwWHtQr19/fb8FSQVTrOgOt2sfEpHn8FI/Kz4QOpp110qXk/Buc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZfCfk0+z; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZfCfk0+z"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a8eadb2e20so4327320a12.3
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 07:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789048982; x=1789653782; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WD8KWD/r4URYpRa7t6/SWDFE46Sv7/iOlqifbsRvdqI=;
        b=ZfCfk0+z5NQPEIEXVTIbUCmORcowq9AvB9eFazW2HgBA4hkyN/f3aLzjFOTgB8h03t
         Me/ywdWiXR+WfLhF3Mc9+Exv0ErkahE3W2Q6mdOza1gAiNKio/N9Yxgio0fzYdzgjnQF
         ZljMtCiHA5Y95SlFEBYjju0dC+79I8DoP7ew/E59/ju6O20I8YtIYb/ABtgwzfsmlTKI
         hnHAUq9iwjjJCUtjsJlGfLR7GZxu2s2hSh7wbxxj6JCvI1bgwv9CqPYdDL6kbIgAlzf4
         1RgK11u95dNZwhtISXI2LPidZ3wToknhYHASiOx5XuQXG4r7GIcv0RQM8gMtV//C3gdK
         V5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789048982; x=1789653782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WD8KWD/r4URYpRa7t6/SWDFE46Sv7/iOlqifbsRvdqI=;
        b=QcyUA9iWI8kUOkG0/+/kNu94V9M8h8/0g5ayy1aYMBq1SvLaMEY4LVLAkMCVkSJqF+
         vjvJNjJfNbbGcUhxhMFHTxBNC/876V265NzzSsG4qQH/Y3+ZwmnzbWV+wehG8SsWUbqZ
         EQyYhWhbSk2WYmPJxeTAmoxdthn1TiwPKu3BJz3qkNxNgbkkgIV3HpCqLO5brg36hPpc
         fjfVyhxcFsurX1Nid3fOeqNvJFzjepg2X5fjBr5dhSqb+fEVxLWgIjjroauo9DlqV24r
         nRNCGHN9GXoGmxD4Nyzlht0HquT+nSNt+pYpdHgeo1lFZn83Rqq0VC1HOmIZ7FVJJVIH
         Pp4Q==
X-Gm-Message-State: AFuF++nHeM/6m3ixY4CEMqGe8UEjvCXb60AVBtxYaWH5idsdF+zfXekX
	cdDtOD24m0n4YDxvCcudS7WAEixmQeiq30DsMFD4vSM4Wl0xRbNJmK3/F/W/rzgqlkM=
X-Gm-Gg: AYBFou2NGJSIdmaelr+6FADvlRkdU6Yb1z7wdjZw0tN5sSSvsxPAGc2HOItifjq84E7
	PyQXhD5/fSEpWeT8LggOFgFizu8eYf6dU6a/yO7AsOx2zoeVGb2sQY7T9JjKeotZnqAcycxvZJy
	VJSh0wtrJeSeOcGsyolmGHNO+5nhnYzhnbIi8qiLX40QM9zov8IXW9TAdjRIhMEV/ve1DG2c6aF
	J73Ul8c7iZL7BubVloIlPc3smL7IgzjYZn5RYA9xGCF6Ipk9ku9eAG1HtMk0Mmj16UQ9TypIZNI
	mNC3L1Vzshb/fFUQaPGjb7cYeG/eiC4tiiDYYEvPKhbDKhZysA2q9pkK4j+m8lhWmaez+P9Vnts
	sOqJNTKdjuN+0W6uIkZ9h9KdmWGY+nyW5uIfg63+oORtK5QLepG5A0ixrEnBjjSuIYRsFk+r3hf
	hslKiYKqd5CnxAS2xr6lumNNDeD83+0S2DCHSwqepoiAhH19J2FcWo3WXydV7WSXDS2BYF2+ll/
	605hhoyDt2Yopp8mRoE8y492MLyOqD00HcL3WKX3VM75avUZ0Ca1i/jnyU=
X-Received: by 2002:a05:6402:3885:b0:6a9:a33b:bb8f with SMTP id 4fb4d7f45d1cf-6a9a33bc700mr2138258a12.41.1789048982382;
        Thu, 10 Sep 2026 07:03:02 -0700 (PDT)
Received: from cloudflare.com (79.184.140.212.ipv4.supernova.orange.pl. [79.184.140.212])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e6bf3032sm8272971a12.24.2026.09.10.07.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:03:01 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 10 Sep 2026 16:02:47 +0200
Subject: [PATCH net-next v2 12/14] selftests/bpf: Test skb_ext read from
 seg6local End.BPF hook
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-bpf-meta-inside-skb-ext-v2-12-0b21e42180b0@cloudflare.com>
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
In-Reply-To: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
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
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Florian Westphal <fw@strlen.de>, Jack Wang <163wangjack@gmail.com>
X-Mailer: b4 0.16.0

Test bpf_dynptr_from_skb_ext() from lwt_seg6local context:
- TC writes skb_ext on the encapped packet leaving NS1,
- NS2 runs End.BPF for fd01::1 which reads it back,
- NS3 receives the packet and decapsulates it.

Note that End.BPF cannot deliver locally since seg6_lookup_nexthop rejects
loopback routes, hence a three netns setup is necessary.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 170 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |  18 +++
 2 files changed, 188 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index cb38a221a278..2814bfa0d6b5 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -1510,6 +1510,174 @@ static void test_skb_ext_lwt(struct test_xdp_meta *skel, const char *name,
 		unlink(LWT_EXT_PIN_PATH);
 }
 
+#define SEG6_PIN_PATH "/sys/fs/bpf/skb_ext_seg6local"
+
+/*
+ * Test skb_ext survival across TC egress -> seg6local End.BPF hook.
+ *
+ * Topology:
+ *
+ *     NS1           NS2            NS3
+ *   lo veth1 <-> veth2 veth3 <-> veth4 lo
+ *
+ * NS1 encaps fb01::2 with SRH (segments fd01::1,fd01::2) on output and
+ * writes skb_ext at TC egress on veth1. NS2 runs End.BPF for fd01::1,
+ * which reads skb_ext, then forwards to NS3 (seg6_lookup_nexthop
+ * rejects loopback routes with local_delivery=false, so End.BPF
+ * cannot deliver locally). NS3 has fd01::2 local, decapsulates, and
+ * delivers the inner UDP (dst=fb01::2) to a local socket for test
+ * synchronization.
+ *
+ * The TC program drops non-test packets, so NDP is bypassed with a
+ * static neighbor entry on the NS1->NS2 hop.
+ */
+static void test_skb_ext_seg6local(struct test_xdp_meta *skel)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_EGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct nstoken *nstoken = NULL;
+	struct sockaddr_in6 dst = {};
+	char buf[TEST_PAYLOAD_LEN];
+	bool pinned = false;
+	int client_fd = -1;
+	int server_fd = -1;
+	ssize_t bytes;
+	int ret;
+
+	unlink(SEG6_PIN_PATH);
+	ret = bpf_program__pin(skel->progs.seg6local_skb_ext_read,
+			       SEG6_PIN_PATH);
+	if (!ASSERT_OK(ret, "pin seg6local"))
+		return;
+	pinned = true;
+
+	skel->bss->test_pass = false;
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
+	tc_opts.prog_fd = bpf_program__fd(skel->progs.tc_skb_ext_write);
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
+	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
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
+}
+
 void test_skb_ext_cross_hook(void)
 {
 	struct test_xdp_meta *skel = NULL;
@@ -1539,6 +1707,8 @@ void test_skb_ext_cross_hook(void)
 	if (test__start_subtest("lwt_xmit_to_tc"))
 		test_skb_ext_lwt(skel, "lwt_xmit_to_tc",
 				 skel->progs.lwt_xmit_skb_ext_write, "xmit", true);
+	if (test__start_subtest("tc_to_seg6local"))
+		test_skb_ext_seg6local(skel);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 8ec0ffd98da3..00312a549ea9 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -1214,4 +1214,22 @@ int lwt_xmit_skb_ext_write(struct __sk_buff *ctx)
 	return BPF_OK;
 }
 
+/* Read skb_ext from seg6local End.BPF -- tests TC -> seg6local path */
+SEC("lwt_seg6local")
+int seg6local_skb_ext_read(struct __sk_buff *ctx)
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
 char _license[] SEC("license") = "GPL";

-- 
2.43.0

