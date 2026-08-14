Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD69434E30
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 08:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695290; cv=none; b=eivSrZ9RSVHNQj3zl9aZRZ2RYIKUHxmsKalat2LN5NG56EM7pTlS0Pt8/ouFmwBDp6AhzQ6IEpXTIJXIRiBhXyWfkBhZsSPvxIeWrL+5qeiVDLH/6NRa9id0XsSap3WiPgwVIIM/lYaQFs9yHatLLJzltz2IBLXonTWrUI+CXYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695290; c=relaxed/simple;
	bh=zmhyf82MJXM1WrVpq3c3+NeM/8/sptiWBtuwiYzOI2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lA+S/iYSLkoKlhm695Kmi6HBTC8p3jN6FN9uG2u0wnQjkdS+8NY6jHssEXsP4ncDR94/iUAEHa64KejfkzfqlubachXumTUVno983ypvoqHyGU+azYsC3avt/7ECKi/vDHktiV8WxH1Eyj6kKYrKcb40jk7UR+DN6AlUE6D+j4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eAScjUuB; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eAScjUuB"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a17211b9ecso1233396a12.2
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 01:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1786695281; x=1787300081; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x1+wa2AoPB09BaKPEYnubwUQ8wbxVoNElrVrjvIg3ZA=;
        b=eAScjUuBfdSJFgTuXnshHSYPvwotFZghkU2ALrSqMRwaUBqlORroq7D5JYXT3jdFAf
         iruVOXJ9wvWankMh/8a3RX0SUg+opPhV6Y5G1xv/henf6lcikiFvjyqfHvxqfxLngPHS
         77Jh2OGkqw9JmlCli9+v6CGva4lBQTMI/xMCNA8RduJEZzSl/Ud7w9mHOp/eggB1uxQ/
         765vfm/QnGchb6GpwsckQ+zlbgmHv1KxvPjrEva/ell/iyZi6LQj1negSUceXq4XQlns
         t5TVYqPR3jIXgARPl54zK7zwtFEqDxO598e8Fs95GHX9v31T0/cfhtXK7urfZrr2I+pZ
         SJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786695281; x=1787300081;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x1+wa2AoPB09BaKPEYnubwUQ8wbxVoNElrVrjvIg3ZA=;
        b=GjvnNRpNCXyIUy0LlnmW92shsl1kpKlwbITc+sVGnhusXDuHTYwkkY//JUUDS8U/M3
         o5Flrv1vE3Zg3cnXEENy30xlgnOyCzHeLzbuvXPVTlEbtHz7SLHIMnie9Uo8VfZKnw2Q
         eYeWaeq8roZxVQATDp1VSk11AqML1eIzhO0/Ay4SPx5rHJFeJjhll7N311nG+MiKAhJ5
         dbH6xGinaSOlXiYN49NfmTRDIIIT1j6PngVuao+OsYMF2phK8sNwsKz3/dw6u+egw3Ns
         E7x+vADOzkVLZnySw+uEcnsEPmXZyYjxGvpaIOUIghcD4Du0Z+flsHTNrOWYbutoHtw8
         oOdg==
X-Gm-Message-State: AOJu0YwDLf7Zqci6ub+cEjEukUEV6lxfXyGfCRTtlksZ/2U4iteWWsxN
	mrzRHyBIYxWHd7jP4H8GyvDyGwUXp1mg34Cg5zyKu3GEOZOhwnzvvgj1fUWozHrkpiA=
X-Gm-Gg: AR+sD13cUPba+sSHhUco1vfDwdCunn8t2z6HFFCWKmAObyBmeQbtFxLr2WRt/7ZiyxR
	JuREHP/fwB3Dd/zfiC0wCsHrO549SeJF36c7KAAcfkTxpgbcSblOST6MMdiMHIGazJQ12fK9cNe
	JeG5xPoQi6X1yykja5rnlGji9K7yzC3x4oCFoGCyJf9WeNvRTMnI4hpznv+i2jPLJWOyUnFAcOg
	7KEuPi5ZZLZfdjO9ux5DP28Z/p9bWb9W1prIvYfuDUgCNU+/sfYQL3H3RlWaC8PA/MII2c3yhTQ
	EzVMytxj9TB/KfcT2zll5Vqhdf2FfTYSBriueYsSW45geIdhjl80TWbLezN84q6yfWgjLdqUNXf
	gC/HVm3gf2FhsEQhZH6gRUb0V0nfeuCjtNB9bPU+0plvkKZPRKpXMws7Un0Sk6GCiR5Wr1qs3nY
	ud8mOOeJvXObhtAownCop7XA33bXUKf4yCvTHlOa86wDR7f1rUx4ZLCmi5C6s8ZWjjbkIR7j4LU
	aaiPxg79ejbtrbVKXryKVF38Am95Ep6L50q6Q==
X-Received: by 2002:a17:906:7953:b0:c05:b9db:68cc with SMTP id a640c23a62f3a-c2129914be2mr189074666b.0.1786695280136;
        Fri, 14 Aug 2026 01:14:40 -0700 (PDT)
Received: from cloudflare.com (79.184.184.176.ipv4.supernova.orange.pl. [79.184.184.176])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c212339f744sm77338966b.10.2026.08.14.01.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:14:39 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 14 Aug 2026 10:14:13 +0200
Subject: [PATCH net-next 12/14] selftests/bpf: Test skb_ext read from
 seg6local End.BPF hook
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-bpf-meta-inside-skb-ext-v1-12-767edd862656@cloudflare.com>
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
index 7a7537ef80e7..5f9247941aa0 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -1392,6 +1392,174 @@ static void test_skb_ext_lwt(struct test_xdp_meta *skel, const char *name,
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
+	if (!ASSERT_GE(tc_hook.ifindex, 0, "ifindex veth1"))
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
@@ -1421,6 +1589,8 @@ void test_skb_ext_cross_hook(void)
 	if (test__start_subtest("lwt_xmit_to_tc"))
 		test_skb_ext_lwt(skel, "lwt_xmit_to_tc",
 				 skel->progs.lwt_xmit_skb_ext_write, "xmit", true);
+	if (test__start_subtest("tc_to_seg6local"))
+		test_skb_ext_seg6local(skel);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 97c1760fbd6d..c4ea38d79533 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -1134,4 +1134,22 @@ int lwt_xmit_skb_ext_write(struct __sk_buff *ctx)
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

