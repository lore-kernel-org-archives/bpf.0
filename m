Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016E63FBB5E
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 08:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695284; cv=none; b=OudgQwg+9IBXGNqWmePlfrxPJvSyzD2cNv3HKc1cxl2/GykppPbkiDU6FzC6AEo6M3vJNSdRr8JO6jV7Uc5Ypv5G70vmzaqvDmmdZ9fW8v26x/GGn11k2B+smvcug1Cxuy2JnJAWE2oPydcbemh1UgBgB4mFSobvPtZMyXgr+8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695284; c=relaxed/simple;
	bh=SVvPMc29WAN+NIidfSYlQv5iUQ8R5mroi+KpeLX4JZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f5NqDecXP7eGGsidTUjyM+oPtjJHe5hmNY8DQqmodwSLqNS441Ik0/I7rv1nnP52XEvgLX0kuYrVkiWOSREpwlKsWc+8S0euxdmtMR20xIz18GFenaEJmjP4kJmHftuIiGlC0wiWWRPhJEC0c3yy5/8sXxLOKqZbowZfu38ENX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=EPz4Es9n; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="EPz4Es9n"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a38098734bso1048960a12.1
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 01:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1786695276; x=1787300076; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=11EqZsuxCQDeLazE4TEyA8aDK/6ifCmJ+0XW6+YCD3I=;
        b=EPz4Es9nYK/Spy5yQGIlYhqkxfdsEanSoz4F4UCG0aeicMbnR0RbajXPWF11oeWVCu
         u+CvmY774YHMujgI6A6wR1XOaqVaDcFCQTtWeOGVHzUfqjry3mRJkahOY9xUxlAro+9d
         DCZ7MzK46x3SaKbBlwDNwxLbujB6v2XCxGrnme5vgCcobY4MIpQW6B/4YT/m5cfJBztA
         aalQ9oXK2SNdEMButXVEFEaQzm2g+Y4CmhKQOQRzD6cR8ublptiR2uQZkdVjTm98D8tA
         4t49ZpHl2WB+pXe2F7tDafdQndNhbhf8JpKIJ59YkoaY4rIWxP8C4YLlL+v4PiaIub8U
         EfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786695276; x=1787300076;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=11EqZsuxCQDeLazE4TEyA8aDK/6ifCmJ+0XW6+YCD3I=;
        b=lGNZjkx60vdMKOqCxiOrapbfhyxCFHgeQqFHD5l2OMZb7S9bmtI/6gnH1FuIOlZUwl
         9/MJQd/fsBR+RqGEt/1204HZiuP8XrpMHye3W0aTe0Dj95qT/zWtSMK8yeLyg4bah7Wb
         sKV4mTXMcuzvXF3sp+7jQyrkuHNIMIbCcWlEnEwP0xJT4twYQs5qmh+aIGCH5V2352yo
         BvryPGhNpqtYW2jM7z1VmCjNeOfI1+U4NEF8deU9hLuxiILbVSjtYLWc0s1Thfz3oXeW
         d4x/c3UHMF8FCSEbw2/pJCjA7nV4wxfYdpfTDT3A5V+VlofeJ6Whmp7r0No3ozRsU0aL
         yzZw==
X-Gm-Message-State: AOJu0Yw1KU4sXUk69chqyRUy7hYUhfAR964Cc/Ob3b/C32gETMRgIrQp
	8tlI7vqtOvoc8Alea+/W/Q5K0zlqg794Mtz5GSxwzxJOChFPN7EJ2PI+pC+7dBzVO/w=
X-Gm-Gg: AR+sD10qQ0ypKEAg3ueo1dsCkbtI3gbMLISFXSYEgE/3FO9ZGiYQydKdDwAUwC0YTkf
	r1abNXsD9zKXw8+70XnNKpWTbYCQUinm5cNqfR1DXW0WEno5BH52+IU1oDzDPY1sBtpFdxNZ8Ht
	+hUlg1UAOjWA/ndcpanGozqja2AarZpPavVIb7bNSXTWTOxrL2fcFQ+T0porMu8sNNIRDSs876W
	PNiEHa4tULZKgS4cTCZUeh1owrk7vrDwHBm1lL5QbyiANIRUvSy1EeVkJKkqnvHVHHpHfWIGvMy
	A4QdDCty9GiOgbYlFzi5hZ//Kpm7gdbNv0+QWV+vnpGYIxjit0q14peqN8/4E2y6TSf8xe8HXU9
	9m+FiyK4863OcWgHZJujNM+SZsQ+g7WRaxe/R953AaoYQa0D6ok/5tf2aSU/BBOpYxE3CMDEmj1
	uwa1pY/Naprob+H36WVTLkUM1CK2llXf4WjedbQ2xASF6hu+elhUJ4A+ApbxweJyzO7u14qIV2M
	8EhsikwSc/9MFoEAkRwHZXZTTb0y46A6WTUKzgGX1ycdsD+
X-Received: by 2002:a17:907:7b93:b0:c20:ff26:336e with SMTP id a640c23a62f3a-c212a25389bmr178444166b.14.1786695276148;
        Fri, 14 Aug 2026 01:14:36 -0700 (PDT)
Received: from cloudflare.com (79.184.184.176.ipv4.supernova.orange.pl. [79.184.184.176])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c212378da3esm78633366b.37.2026.08.14.01.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:14:35 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 14 Aug 2026 10:14:10 +0200
Subject: [PATCH net-next 09/14] selftests/bpf: Test skb_ext read from
 kfree_skb tracepoint
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-bpf-meta-inside-skb-ext-v1-9-767edd862656@cloudflare.com>
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

Write skb_ext at cgroup/skb egress, send UDP to a closed loopback port so
the packet is dropped, and read the extension back from a tp_btf/kfree_skb
program.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 65 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 34 +++++++++++
 2 files changed, 99 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index e0ab0fccf9d7..1e4e12d2b041 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -1186,6 +1186,69 @@ static void test_skb_ext_tcp(struct test_xdp_meta *skel, const char *name,
 	netns_free(ns);
 }
 
+/* Test skb_ext survival until skb free: cgroup/skb egress -> kfree_skb.
+ * Send UDP to a closed port. The packet is dropped, triggering kfree_skb.
+ */
+static void test_cgrp_egress_to_kfree_skb(struct test_xdp_meta *skel)
+{
+	struct sockaddr_in addr = {
+		.sin_family = AF_INET,
+		.sin_port = htons(4321),
+		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+	};
+	struct bpf_link *cg_link = NULL;
+	struct bpf_link *tp_link = NULL;
+	struct netns_obj *ns = NULL;
+	int cgroup_fd = -1;
+	char buf[1];
+	int fd = -1;
+	int ret;
+
+	cgroup_fd = test__join_cgroup("/cgrp_to_kfree");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		return;
+
+	ns = netns_new("cgrp_to_kfree", true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto cleanup;
+
+	skel->bss->test_pass = false;
+
+	cg_link = bpf_program__attach_cgroup(skel->progs.cgrp_skb_ext_write,
+					     cgroup_fd);
+	if (!ASSERT_OK_PTR(cg_link, "attach_cgroup"))
+		goto cleanup;
+
+	tp_link = bpf_program__attach_trace(skel->progs.tp_kfree_skb_ext_read);
+	if (!ASSERT_OK_PTR(tp_link, "attach_tp"))
+		goto cleanup;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (!ASSERT_GE(fd, 0, "socket"))
+		goto cleanup;
+
+	ret = connect(fd, (void *)&addr, sizeof(addr));
+	if (!ASSERT_OK(ret, "connect"))
+		goto cleanup;
+
+	send(fd, test_payload, TEST_PAYLOAD_LEN, 0);
+
+	/* Wait for ICMP error -- confirms the packet was freed */
+	ret = recv(fd, buf, sizeof(buf), 0);
+	ASSERT_EQ(errno, ECONNREFUSED, "recv_econnrefused");
+
+	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
+
+cleanup:
+	if (fd >= 0)
+		close(fd);
+	bpf_link__destroy(tp_link);
+	bpf_link__destroy(cg_link);
+	netns_free(ns);
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
+}
+
 void test_skb_ext_cross_hook(void)
 {
 	struct test_xdp_meta *skel = NULL;
@@ -1202,6 +1265,8 @@ void test_skb_ext_cross_hook(void)
 		test_skb_ext_tcp(skel, "tc_to_lsm", READER_LSM);
 	if (test__start_subtest("tc_to_skops"))
 		test_skb_ext_tcp(skel, "tc_to_skops", READER_SKOPS);
+	if (test__start_subtest("cgrp_egress_to_kfree_skb"))
+		test_cgrp_egress_to_kfree_skb(skel);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 8f0a0fea5d84..415b33b32ef5 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -1032,4 +1032,38 @@ int sk_filter_skb_ext_read(struct __sk_buff *ctx)
 	return ctx->len;
 }
 
+/* Write skb_ext from cgroup/skb egress */
+SEC("cgroup_skb/egress")
+int cgrp_skb_ext_write(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+
+	if (!is_test_packet_tc(ctx))
+		return 1;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return 1;
+	bpf_dynptr_write(&meta, 0, (void *)meta_want, META_SIZE, 0);
+
+	return 1;
+}
+
+/* Read skb_ext from tp_btf/kfree_skb -- tests survival until skb free */
+SEC("tp_btf/kfree_skb")
+int BPF_PROG(tp_kfree_skb_ext_read, struct sk_buff *skb)
+{
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext((struct __sk_buff *)skb, 0, 0, &meta))
+		return 0;
+	if (bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0))
+		return 0;
+	if (!check_metadata(meta_have))
+		return 0;
+
+	test_pass = true;
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.43.0

