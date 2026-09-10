Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F92A49DBA3
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048984; cv=none; b=Iu5spbunEWb2rq4QoAtcpuLQmkCKntmU5aEMYoU7XrLL94BBliR40UB2giWNH7zXgNnJYSJ/hpEuYgyFU5cQCF7w5vBjsEeCJQXlwcRJ6g2ZOZiVVr/4m+p5jDBD112UuG1BeaVyeS4yyQYAeEN9P7IVM9MYZhuuoFxlKeutA40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048984; c=relaxed/simple;
	bh=iNdMjWrSLmoDqGXXaKcK202M5/08k+vu9lK5uuKoNZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PhqRRj4svH074deFCnubEi1sSD3X+Szc1h2f95q+ZxZzm9BFlCO8ZCD3j7UWLocT2AxiifahMaFslppMqbYL0jl0E6wueXU3LeJ0agnMYxhIAUPM/fs+HXNfFUnNb81461zQrOfAYdIej/hIbz9TtqGg719I4IKYNdK1tJHQGoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CndDu3Dj; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CndDu3Dj"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c250a2bc3b3so895697166b.2
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 07:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789048979; x=1789653779; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g+Ed9iMsPg2bKuHCFAFiCmWW+jc2xc98e3S/3vWsOxE=;
        b=CndDu3DjH6awZHr95Fwl57wuow+LxP8zCluXe+SWyvsZPI/wAhgRTvGG+ph9NTqLVz
         qf59PnuydZocd01vjD/tnwcDP9bmIuhylS7vKIyOkW6BBJBLJu7BdeBEZLNxyJ5WvCmE
         rjWtTLJFDSJStrDIJwMSVG7+nPgYJ/hhdNQ3Q/lVRViNoE/GBQdJD5iNHwLP7xopQA8y
         Mwn/q2O3fWww/0itGI9vR+5NrQUktlNBDqXuhsZGd1HxPrk8uvnm6IqtMfUQ6vf0EGuD
         xmvh2+vq8sgfJhXAVNbGMYkrYf8i7vrKgj12Za2nAQPRdnaogiodv4eExpOG9zdMovLq
         5bMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789048979; x=1789653779;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g+Ed9iMsPg2bKuHCFAFiCmWW+jc2xc98e3S/3vWsOxE=;
        b=Ukwe1uj1LhYgBuR24JIoRlPOMH0X9UMV/w+Yq0PkrSOHOIsmtAOMAl6KsILqbrZ9Jb
         cAtantmazlRWK2f1YNbiAShKUj96tTg+cI34ZBbJC3/R5uxRujEQ5n6Jy2s1AkFnO0IS
         cD8MvDoWIWf84om9Fm8ZB9FNCsmmuOU+jHeaF8ZEmOVDrmH+uG/kGx8MlyX8XplGC62h
         cRmAh4HOhEzhQVSb/OAgm2gGonAmVz0UkpaZMNuqVxW0MyyVX5bPuO/Vwp/v3kVbCfvt
         mCN4b7oXR1a7NnC/CWmoLiJbbHhLAoIcwn9scbWlfKI256PEhwfTp/dxZU7dhxltAEqf
         nmIA==
X-Gm-Message-State: AFuF++mtRS1D4qDC94A2YWprHznJFxBpDeCK4EbQbuKWduXtTwIYGZRf
	1eoTZh1KBh14wm5PSd9lJeVv8uKmwFiPgy+omZVaSBrA8JwBY9HlXKFlOiE1ylq/GAc=
X-Gm-Gg: AYBFou3DtoeAdcYC6aSrw2QcU00RG6OYlgdXVEDdCGf6jSL793ary00cfLgP2p2ibr/
	de4EGfual6K/eOiUDECrlofag1c3KI8g4tVu2cjKY59gduPDbykqNEEMlZHxCTYbt8e7ZNuswcQ
	1VnTXM0SNuatNlaGOTgbT8jGmEs30N8MiTvPVv9iqjlcVR59NcKmlnN4XIbAsdljto7kEnjlvQd
	oNtFivKtlOsZQl2P4sjtsFJrRH4UZd8RMXNUWES1JUvrq+8Zhfbk/gReB98NAXdtUZt9UtH6HRU
	X2PONpkTYw8rrstGnrJ50L15Tw3Cl/h5XaYTH4FRJ14jCKhuq99TqaesmrXXNXZwnlawo+WPp2e
	7muCL8KNhaza4ld/3MZyJkX6ySlkArJUN/rkBYjJB7ur7LDQ9MQN8Iwawd42PunlW/e5dnQ5pCI
	KnT7X56kLUAWlCSR3P3l+0Sj40rqqStuYQos4Q/7Pg6aNKnTBWjCB8LClA1+2022H8PeineTN0u
	hjKMcboXOXhxFQZITjC6mgRKK8UceXqW3zJpnJU2soM/zXv+g==
X-Received: by 2002:a17:907:d649:b0:c26:19e3:e982 with SMTP id a640c23a62f3a-c2619e3eee5mr1497484066b.34.1789048978851;
        Thu, 10 Sep 2026 07:02:58 -0700 (PDT)
Received: from cloudflare.com (79.184.140.212.ipv4.supernova.orange.pl. [79.184.140.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d4a8ba1sm903187766b.22.2026.09.10.07.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:02:58 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 10 Sep 2026 16:02:45 +0200
Subject: [PATCH net-next v2 10/14] selftests/bpf: Test skb_ext read from
 netfilter hook
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-bpf-meta-inside-skb-ext-v2-10-0b21e42180b0@cloudflare.com>
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

Add a TC -> netfilter cross-hook test for bpf_dynptr_from_skb_ext(). A TC
ingress program writes skb_ext on loopback, and a netfilter program at
NF_INET_LOCAL_IN reads it back.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 56 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 23 +++++++++
 2 files changed, 79 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 632b2ae6935c..b42e74aaca88 100644
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
@@ -1362,6 +1363,59 @@ static void test_cgrp_egress_to_kfree_skb(struct test_xdp_meta *skel)
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
@@ -1380,6 +1434,8 @@ void test_skb_ext_cross_hook(void)
 		test_skb_ext_tcp(skel, "tc_to_skops", READER_SKOPS);
 	if (test__start_subtest("cgrp_egress_to_kfree_skb"))
 		test_cgrp_egress_to_kfree_skb(skel);
+	if (test__start_subtest("tc_to_nf"))
+		test_skb_ext_nf(skel, "tc_to_nf");
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index e162683a6534..98d06ab340bf 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -1146,4 +1146,27 @@ int BPF_PROG(tp_kfree_skb_ext_read, struct sk_buff *skb)
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

