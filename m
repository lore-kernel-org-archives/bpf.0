Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5774ACC61
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595645; cv=none; b=VqcG5nEWYEKUCopw/HNJSC5k7Q4diDiXpranuVFxffk0jF0ivl2kCHzyYaJFEhyuEoktxLeKCj6gMa6VgudyabiJaqPt4jZ4nubpa0ZbogLYpfjzqg4QGXm5nTE/lT6IewuA96gnYBDREpZFFLrqyzwxm3gWB9qIYbNK5MlydCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595645; c=relaxed/simple;
	bh=Y+ZBfxLHh4DgPknntN8vAx6A1rkzJEJr99Xo2ZK7R/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TxVWecvq2faif9yC366GJ/ixienldZPZ2rPADHgQyQhwddqJquIqqY28ZUxIRrTJi1o1tywmZ395dvN5qbSLfB6mGts66czL1S1g5T7aYioCu9wvm+rRljNDIT1HJkPPKIJfX3TS6dgU1P1svUPoNZaWUEqetA1rweHnQ36HC+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZYhCDPjI; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZYhCDPjI"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2940ff2313so187255966b.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 04:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790595642; x=1791200442; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dvQSCtRWnqVLMUcXMeypAgPSwh4TEr6Wl3FR/BXaXKw=;
        b=ZYhCDPjIdmfUf5zJI4joww2N691wn7PRGM/Aa9Ux6mBwQiGZogpBa5UTXbYwH+azsT
         3aBByMVXG+ZObqEm/pc0LJG0RHlmQu2V4ZKTz1KHrzXFcmp7uQWMZnaDfSx0CBhiH4s0
         3jsMslTbxknlLz8oNLJl2+wAEAVkf66bRpB/VMWIlyIqv7AoM4Tdaut8NO1ihyfWLLvg
         0bdRDYRN3GxzRhhwtRQCJSgnZnGh1LvARw0XjtYowinhKvHT29TpbIrJvZE4Oj/beDO+
         ZZYQmoeDaqEjraB31E+2l87b5y7lwECmhUUA8kLcWywUhjQZUJ6E5iTFGx+rqZnh70wo
         yp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790595642; x=1791200442;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dvQSCtRWnqVLMUcXMeypAgPSwh4TEr6Wl3FR/BXaXKw=;
        b=VO7OMlJ49woxqxvJiWcTx6kqBvON41OPYmmZ9jujkLH33UStVOL/ekdC8AzzRN6i2b
         c5LTTHgMs9gP+wNmFP6M1A9c0YdUs9AO1GGHxOFPa6/cZfQcqZ9ICcBKVFVXKwD56XvN
         kOLA5srdhqVQ8GkQe0/LeXvpCQYwquSrS/yvgEU+oyDGVqJ0vneUVkqPxzNgnIjilXSr
         Uj88j3p8uvL68+KYhdZM39aApRTi6svNjAeKn19iO5VvkpxqH4efEwjd4t4ckSgqTXBp
         khqpBWg+AATw1kkC5cUINP8waAMoIsTcfPCaqc/cdeiWA9ZGNGptlXnEul1euIoDESzj
         t3oA==
X-Gm-Message-State: AFuF++ktW8/PWQL5TNPAy6RuE3HuruHA9GWfD4dissUWa28+dLPly8NV
	L+jhktUyNLBLV+85DQcDNZHP73zs/jaE28dHZoSYYTYyoJz8ccO03c+3XJcRr3ZOR8c=
X-Gm-Gg: AYBFou1cobo9l9V+EZsyhBSLG5NzOV2+B9uhoqBSwKmeMFD96K4JEi83xerkY2UgmIf
	MtHURUEA0C6gEy1wEgkocimBopG8JSRo1DrDI8nQUxngiQneROcyErLWceF6HYRn2WQiSpM/evR
	AQAuFUyktlrHubE5gnElsTJlMxGCj6JgzLL6U/9QNbGj65bj/FwA7Pva0Eihqhq8td1TJf7bj6Q
	fmXoSwsDbkoSwo/C7dTyAoX86Lu7Bg8o5CfHPqwGvLCr+GD+6yDV2O3WGxBbmqGZDk4uaUM/lU9
	Q9ucO3/r1qtr91/u1p+5/aehSL1stakk7rNi8fZbTKQUmWJc8rgBR7mUHOzEMgsm8EI0Nvk2iFz
	s1npd3es4Qz+QpP6+jCRzSjas25rcl1tn/D4V09xY/2XPQkqVmDFdtSrOFlS6/r25qH7nn5GJlq
	sJl/95d/saswM2n+NJFqC5de+trA07PJVKnuhjLeWmBWxccMN/fixBWquNaVWVDQmn3bNYextmr
	w99pL7hHxq93UxDNy+TNm4IKOKeE2u3JlUUuwgKkxzO3TyLm5Sm+IK93L+uB0CaGjZ3ijzSP0iz
	GeQQn/KAyhYzDdMwGgwATUc=
X-Received: by 2002:a17:907:c208:b0:c2d:d4dd:8b5 with SMTP id a640c23a62f3a-c2dd4dd8b27mr269740766b.19.1790595641692;
        Mon, 28 Sep 2026 04:40:41 -0700 (PDT)
Received: from cloudflare.com (2a01-110f-491b-1300-c0dd-2af4-566b-b23f.aa.ipv6.supernova.orange.pl. [2a01:110f:491b:1300:c0dd:2af4:566b:b23f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae77ab08csm455897866b.44.2026.09.28.04.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:40:41 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 28 Sep 2026 13:40:31 +0200
Subject: [PATCH net-next 14/15] selftests/bpf: Test passing metadata to
 sk_skb stream verdict hook
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-bpf-meta-gated-tracepoints-v1-14-844dbf3e1edf@cloudflare.com>
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

Tag the packet with bpf_trace_skb() from TC on loopback and stash metadata
in a BPF map keyed by the skb address; the verdict program reads the entry
on skb delivery to a socket in the sockmap.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../selftests/bpf/prog_tests/socket_helpers.h      |  1 +
 .../bpf/prog_tests/xdp_context_test_run.c          | 99 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 16 ++++
 3 files changed, 116 insertions(+)

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
index ae89eccffd2d..0aafdb1b8feb 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -4,6 +4,7 @@
 #include <linux/ipv6.h>
 #include <linux/netfilter.h>
 #include <arpa/inet.h>
+#include "socket_helpers.h"
 #include "test_xdp_context_test_run.skel.h"
 #include "test_xdp_meta.skel.h"
 
@@ -1937,6 +1938,102 @@ static void test_skb_trace__seg6local(struct test_xdp_meta *skel)
 	bpf_link__destroy(put_link);
 }
 
+/*
+ * Test metadata passing across TC ingress -> sk_skb verdict hook.  TC ingress
+ * tags the skb on loopback; the verdict program reads the metadata stashed
+ * for it on skb delivery to a socket in the sockmap.
+ */
+static void test_skb_trace__sk_skb(struct test_xdp_meta *skel)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook,
+		    .ifindex = 1 /* IFINDEX_LO */,
+		    .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct bpf_link *verdict_link = NULL;
+	struct bpf_link *put_link = NULL;
+	struct sockaddr_in addr;
+	socklen_t addr_len = sizeof(addr);
+	struct netns_obj *ns = NULL;
+	char buf[TEST_PAYLOAD_LEN];
+	int c1 = -1, p1 = -1;
+	int map = -1, zero = 0;
+	ssize_t n;
+	int ret;
+	int i;
+
+	ns = netns_new("tc_to_sk_skb", true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		return;
+
+	skel->bss->test_pass = false;
+	skel->bss->free_count = 0;
+
+	put_link = bpf_program__attach(skel->progs.skb_free);
+	if (!ASSERT_OK_PTR(put_link, "put_attach"))
+		goto cleanup;
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
+	map = bpf_map_create(BPF_MAP_TYPE_SOCKMAP, NULL, sizeof(int),
+			     sizeof(int), 1, NULL);
+	if (!ASSERT_GE(map, 0, "bpf_map_create"))
+		goto cleanup;
+
+	verdict_link = bpf_program__attach_sockmap(skel->progs.sk_skb_meta_read,
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
+	n = recv_timeout(c1, buf, sizeof(buf), MSG_DONTWAIT, IO_TIMEOUT_SEC);
+	ASSERT_EQ(n, TEST_PAYLOAD_LEN, "recv");
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
+	if (c1 >= 0)
+		close(c1);
+	if (p1 >= 0)
+		close(p1);
+	bpf_link__destroy(verdict_link);
+	bpf_link__destroy(put_link);
+	if (map >= 0)
+		close(map);
+	bpf_tc_hook_destroy(&tc_hook);
+	netns_free(ns);
+}
+
 void test_skb_trace_cross_hook(void)
 {
 	struct test_xdp_meta *skel = NULL;
@@ -1972,6 +2069,8 @@ void test_skb_trace_cross_hook(void)
 				    skel->progs.lwt_xmit_meta_write, "xmit", true);
 	if (test__start_subtest("tc_to_seg6local"))
 		test_skb_trace__seg6local(skel);
+	if (test__start_subtest("tc_to_sk_skb"))
+		test_skb_trace__sk_skb(skel);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 3e323bb7eb96..913caff5a35c 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -1060,4 +1060,20 @@ int seg6local_meta_read(struct __sk_buff *ctx)
 	return BPF_OK;
 }
 
+/* Read stashed metadata from sk_skb stream verdict hook */
+SEC("sk_skb/stream_verdict")
+int sk_skb_meta_read(struct __sk_buff *ctx)
+{
+	__u8 *meta_have;
+
+	meta_have = bpf_map_lookup_elem(&meta_map, &ctx);
+	if (!meta_have)
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

