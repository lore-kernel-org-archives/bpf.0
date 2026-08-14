Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83556442FC5
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 08:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695286; cv=none; b=rxOClCnqnRu64tHTclxYMHkzsDqOIcf09xKJdUE5kxw7Xh4WVfSx9nxAQvCaLqhgj41Jg56GwIGHERuBf1jRnaetxkAYVjmkMqrgEsnqq3bxqq4NFql74UjGZ66BeuRrMsUYTqqNNA1QA/KjuEUPpnr6amaoVrUMt8xUjSQqcIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695286; c=relaxed/simple;
	bh=nhh8GAFnbC3stGIWCDcWnCvr9NMiSv+vzGQckS2aorE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V8zcv5F0cfx4MruplRpb0EO2huc95UF8TfcZQglNip/tPz8PS2PC0qLfswO557ZhJxo4WN9GVoDDlVLHdQbJhG6QBPNeN6TRaUExlNmbet687RQA3L5SAFpwBvvlAjrjia/zl9p1z7fvcmlPLSW4pVanj90EvyN03KPjtpwsnr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=VsrIVY9P; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="VsrIVY9P"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c1f5208b38dso139196266b.0
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 01:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1786695277; x=1787300077; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j4oWv3Sp0enwEYapW96AvZnTioNxWZur2lOF8iRZu74=;
        b=VsrIVY9PRqrvCsSOHcsGikgFVYD2YjF2xQvcATmMbT8cNueQLnGyUPvnVr6Wbm42oD
         TwcLh+OJzpGq2k+ojhAF1UbcZF73+C0CpfXlXOYYuq8HnMtiMV9MBq85WCYJBnAVGDe/
         D0VlLN0p34I1EyraXP9Cb8ARJOG9Iqsd53U7aNWKMHymQmwRCe3fYj+yhRH+OqnJTUN2
         H/CoXHHEBGIIZuFZW187I2eknviEmy0KdzLIn/mGEi1Puq+D9WGo9qyrDUmsFsP1Y6gS
         SmmTxEc9QTCHrkhNWp3t7pRVJ1to2fYEfdLK0NoU8O2gyJmucR5ypyx14NyxoDkc+cGM
         II4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786695277; x=1787300077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j4oWv3Sp0enwEYapW96AvZnTioNxWZur2lOF8iRZu74=;
        b=EV5iKobAtG4q1AF71+k7eCXuykXtKLhNfhlxe/qbUlJdBGrvhlQDcmDQLasdeiIwiK
         o0SOmyqwijpxo7fOvSimr7I4XdWYTdeCx1+2TPnkPwogeYo8VR6CSMC8BM0slAr+thsN
         SQrIL4rKAfuts2gNWS/D45Tdl6V7uUOgUMHFhYxuXLOrLlloJoAT9GGswaLRbe1jVPQz
         qDx4c4ulLf3/lgJlLquj8HMC5EueXqXHh4L/auTr6to+wZmpHPSU/iqvMgCBaUkB7SRu
         vLfPnXH1Wa7IP3a8YXfRY9XL3dOFkM521RBWB1kpX0bV4ENnxRn3buDKadugec6X974P
         0JWQ==
X-Gm-Message-State: AOJu0YxSzE1eQE0FhFp4PjW1p5927RK0epmEypyPekX5T5ZSOdK9wn5+
	TvcPQ3hExBUqP58N1nEiLMfNKHtYGG57tHrFA1voPY4E/Mc4iUJBw6ftUaJI2DYkUQY=
X-Gm-Gg: AR+sD12N+XGs+c/cw+B6ffIxSCrMml27RRCE7UrOMEqRP6yPWfrP4H1Gv5rsouqNtUM
	W3lA43AwRdzU2o8Aqm0v0Z4oeO1EZQD1bFgTOoVy6GFtfeuYpfQtLL0zn6eNBNSG2OLYYEC52Gg
	BFTch/7jbWD0kXqnxuvMUxGr+z/cO7w2w4W7NtNpEK/MhTv2EeFS72Ke4gaam6nJdVKoUJ7/XTo
	WQzoTaJiZR0eprtCZPa4fFx2LcxY1UaC7o6XaYl2I5CSh3sR0pUMREJhMDi0QuxYpt4BkVTUn4h
	uliXjF+DzJXI4ypLZmUUyizPLKiqZtJbEQ37kky0yQFGMT42BNsUzRDlZqHd1HlIAySg0NeyVsi
	aDwMKEldwrsoySvTl6jDRaj6daWn27bbabyVhgjeALVd63MZgwQUrESgi6D98it5AVmw830ltyq
	QLN/t97KTjq5G2mcKvh1gcl+U0EYLfatHZZEBca5miNAcpRj/Yc6xghc6jF+JIdM8TC5p/2VuOH
	TPHWr6Abj2MQ5wcfm5VPU+c0G11QxaHFyIH5g==
X-Received: by 2002:a17:907:3c92:b0:beb:133d:cf02 with SMTP id a640c23a62f3a-c212a213d9bmr158508866b.26.1786695277450;
        Fri, 14 Aug 2026 01:14:37 -0700 (PDT)
Received: from cloudflare.com (79.184.184.176.ipv4.supernova.orange.pl. [79.184.184.176])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c21237e7fe2sm77272266b.49.2026.08.14.01.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:14:37 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 14 Aug 2026 10:14:11 +0200
Subject: [PATCH net-next 10/14] selftests/bpf: Test skb_ext read from
 netfilter hook
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-bpf-meta-inside-skb-ext-v1-10-767edd862656@cloudflare.com>
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

Add a TC -> netfilter cross-hook test for bpf_dynptr_from_skb_ext(). A TC
ingress program writes skb_ext on loopback, and a netfilter program at
NF_INET_LOCAL_IN reads it back.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 56 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 23 +++++++++
 2 files changed, 79 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 1e4e12d2b041..82c57ea3957e 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -2,6 +2,7 @@
 #include <test_progs.h>
 #include <network_helpers.h>
 #include <linux/ipv6.h>
+#include <linux/netfilter.h>
 #include <arpa/inet.h>
 #include "test_xdp_context_test_run.skel.h"
 #include "test_xdp_meta.skel.h"
@@ -1249,6 +1250,59 @@ static void test_cgrp_egress_to_kfree_skb(struct test_xdp_meta *skel)
 		close(cgroup_fd);
 }
 
+/* Test skb_ext survival across TC ingress -> netfilter hook */
+static void test_skb_ext_nf(struct test_xdp_meta *skel, const char *name)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook,
+		    .ifindex = 1 /* IFINDEX_LO */,
+		    .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	LIBBPF_OPTS(bpf_netfilter_opts, nf_opts,
+		    .pf = NFPROTO_IPV4,
+		    .hooknum = NF_INET_LOCAL_IN,
+		    .priority = 1);
+	struct bpf_link *reader_link = NULL;
+	struct netns_obj *ns = NULL;
+	int server_fd = -1;
+	int ret;
+
+	ns = netns_new(name, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		return;
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
+	reader_link = bpf_program__attach_netfilter(skel->progs.nf_skb_ext_read,
+						    &nf_opts);
+	if (!ASSERT_OK_PTR(reader_link, "attach_nf"))
+		goto cleanup;
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
+	netns_free(ns);
+}
+
 void test_skb_ext_cross_hook(void)
 {
 	struct test_xdp_meta *skel = NULL;
@@ -1267,6 +1321,8 @@ void test_skb_ext_cross_hook(void)
 		test_skb_ext_tcp(skel, "tc_to_skops", READER_SKOPS);
 	if (test__start_subtest("cgrp_egress_to_kfree_skb"))
 		test_cgrp_egress_to_kfree_skb(skel);
+	if (test__start_subtest("tc_to_nf"))
+		test_skb_ext_nf(skel, "tc_to_nf");
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 415b33b32ef5..0688120f3d40 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -1066,4 +1066,27 @@ int BPF_PROG(tp_kfree_skb_ext_read, struct sk_buff *skb)
 	return 0;
 }
 
+#define NF_ACCEPT 1
+
+SEC("netfilter")
+int nf_skb_ext_read(struct bpf_nf_ctx *ctx)
+{
+	struct __sk_buff *skb = (struct __sk_buff *)ctx->skb;
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+
+	if (!skb)
+		return NF_ACCEPT;
+
+	if (bpf_dynptr_from_skb_ext(skb, 0, 0, &meta))
+		return NF_ACCEPT;
+	if (bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0))
+		return NF_ACCEPT;
+	if (!check_metadata(meta_have))
+		return NF_ACCEPT;
+
+	test_pass = true;
+	return NF_ACCEPT;
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.43.0

