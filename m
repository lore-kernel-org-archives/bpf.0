Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97DF4B0E33
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595642; cv=none; b=u8ewsf06AG/ohOI2BC422Hm3VuSo9JqkhmTKdQmsV5U92uwswiqo4J0xhjWkOMJ/lxrbpfseWch55Iz7FAjrbBZsm6SkoW02SdIXQ5G1/fI6PCcZND1yNZ2Z7JMFRti707wmLdSz7GaqoZFWGI1ZWYAy9DZJxdBwpUPt7J4EL6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595642; c=relaxed/simple;
	bh=B7Bc00WuRfwzQkHbx/wrtPAk7y8Au+RTrsFDT8CH4fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p0J3UDdbxC2Jw3yo7qoDiEPfTH5FBWrOej3j6kTDuExoGFbCqPebA8xF5ussqUMbrEhKJRpVq0LDfBDJiELAwmDLhky6jG56BxJjgE9iqmaye5I8kYaxvzGmVXYqkq6Nv+WvNFbkhU/JLlTz9usw7agi/01ko50GDdmf6vye7fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=gC19/46f; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="gC19/46f"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6056ac81fso4059632a12.2
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 04:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790595638; x=1791200438; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pVAJ1NgEXnSaT90SAJ2mbWCptUlBge8LdG03UtznJjU=;
        b=gC19/46fGxemi2idqibZ3d183UobUNPfrED7xGxGEbduX9un6IDiBKschkOgROIFri
         al2YCtXIbZxCX9nSd0oAL8mKiIrMS1H0+NEPHdhyeiHvvyDs0S/3IIkS6pNgZyDrQpnp
         waFdCu7olTUaG9MPqJtE5CwpoGeMReEN4T+ydW0zMGSN4lFinj94VqsamCP/9/Oa2+bi
         ARzJdR7gKLXY+d8xU+6+aPbErHTr2UQYT1+EkY/6LIalN3SEiGLdQMHrzXK5BQOwt/w+
         PX/Srjn3KfKegrHGhdo8w7SqQOGl0xyclwmp4hm+3Bai6HmzVCeTWKyoUL5aoazrGVA1
         yBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790595638; x=1791200438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pVAJ1NgEXnSaT90SAJ2mbWCptUlBge8LdG03UtznJjU=;
        b=eFehLc7Q0qkt2k2I+6y70B2TpyVNjGFFGnkh+notnnYFP/Wm363Or444biS3oPveun
         nCsbdwgqCpRSGKxM7agLvdnIFrHbh7ygQV9jQRed0pOIHIzfKk/4mm0KQmMHvWAQ7LQ3
         d5QoNCxQBcGMM+q3JEQCyi2TU+LgPnrD3aa+Se/nmJ08np92Z226cH4Aus3QeBUM597o
         nB7MrdreUileYfTqGQBUG8wffk6zmzTB0NFNbwJlWUUxV2tV8eDS73tdeimovgN/MUX9
         DTGZ/naUBydMmyMUh2QrCKfkFCmgZADYi4pa24ugn+9b6Y1KeTUIFEk/mdgPH0ZdUEgc
         ybiQ==
X-Gm-Message-State: AFq9FYKSVh/FavFzUivk7W4/XjVUG7o77140dIjItjz6J+O3oa94Y32P
	lL6ksQefGBAUOPQVz07YUSyNNBlEpi32bL97givRozFPJwaTbui3zc1PocX/YmwQY/U=
X-Gm-Gg: AYBFou3lqy2jcf6TuFCh4Xey2SKUXsBE5bNjaNVif9Rv4APurZgaV2Tsbz7CWQigGmx
	zQlVjCgbS5IjTYCw83jRMGzPMpuAQNhZQ6WsfjrZXx5UzhostOjMh20lQNMcseSlUzJf1H3nkRZ
	UaRhMgyzcedLye1MIb6h/dOPHAG7tFOwaySmKDOP94EXR7YSeAT280la1pEBbVgmxKdepFCLah3
	8AkOvB9NcHfg78dFbEYkMAKzYHxnPWwiGw/4u9VgWx14W2wigNeH6Jch2ulBghDCa9lad4eIgnB
	9UGDKQr2rd0sTRw6efAHbUkfb8X01m6NtdB7UE043LEmOc0xdHHrHVEKcyliREl24laQSinnjeY
	zILXVzo6Rn3GUkVYSlWUhnAyfTHVQ4ToDTsmHH04Af5qS00/jXk2cK2sBF4VUASGLxDSIOqFi/d
	rAIbunpAI3wnDO+9oEvIwxPURX/J8dP0XQI95bc3lzF3hFVDt9ibyCBnFSVwbhT6weLGThvGet1
	DXfjRQ=
X-Received: by 2002:a05:6402:360a:b0:6aa:f1d2:ddbf with SMTP id 4fb4d7f45d1cf-6aaf1d2e1e7mr6600902a12.35.1790595637941;
        Mon, 28 Sep 2026 04:40:37 -0700 (PDT)
Received: from cloudflare.com ([2a01:110f:491b:1300:c0dd:2af4:566b:b23f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aae5dc0cddsm4016637a12.14.2026.09.28.04.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:40:37 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 28 Sep 2026 13:40:28 +0200
Subject: [PATCH net-next 11/15] selftests/bpf: Test passing metadata to
 netfilter hook
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-bpf-meta-gated-tracepoints-v1-11-844dbf3e1edf@cloudflare.com>
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

Add a TC -> netfilter cross-hook test for the metadata stash. A TC ingress
program tags the skb on loopback, and a netfilter program at
NF_INET_LOCAL_IN reads the stashed metadata.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 74 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 21 ++++++
 2 files changed, 95 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index ac5c0f067b3f..eb0d36e7a45d 100644
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
@@ -1566,6 +1567,77 @@ static void test_cgrp_egress_to_kfree_skb(struct test_xdp_meta *skel)
 		close(cgroup_fd);
 }
 
+/* Test metadata passing across TC ingress -> netfilter hook */
+static void test_skb_trace__nf(struct test_xdp_meta *skel, const char *name)
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
+	struct bpf_link *put_link = NULL;
+	struct netns_obj *ns = NULL;
+	int server_fd = -1;
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
+	server_fd = start_server(AF_INET, SOCK_DGRAM, "127.0.0.1", 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		goto cleanup;
+
+	skel->bss->test_pass = false;
+	skel->bss->free_count = 0;
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
+	reader_link = bpf_program__attach_netfilter(skel->progs.nf_meta_read,
+						    &nf_opts);
+	if (!ASSERT_OK_PTR(reader_link, "attach_nf"))
+		goto cleanup;
+
+	if (send_loopback_udp(server_fd))
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
+	bpf_link__destroy(reader_link);
+	bpf_link__destroy(put_link);
+	bpf_tc_hook_destroy(&tc_hook);
+	if (server_fd >= 0)
+		close(server_fd);
+	netns_free(ns);
+}
+
 void test_skb_trace_cross_hook(void)
 {
 	struct test_xdp_meta *skel = NULL;
@@ -1588,6 +1660,8 @@ void test_skb_trace_cross_hook(void)
 		test_skb_trace__tcp_egress(skel);
 	if (test__start_subtest("cgrp_egress_to_tc_egress_fclone"))
 		test_skb_trace__tcp_retrans(skel);
+	if (test__start_subtest("tc_to_nf"))
+		test_skb_trace__nf(skel, "tc_to_nf");
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 50aa045bcc22..d85b60c24f73 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -988,4 +988,25 @@ int BPF_PROG(tp_kfree_meta_read, struct sk_buff *skb)
 	return 0;
 }
 
+#define NF_ACCEPT 1
+
+SEC("netfilter")
+int nf_meta_read(struct bpf_nf_ctx *ctx)
+{
+	struct __sk_buff *skb = (struct __sk_buff *)ctx->skb;
+	__u8 *meta_have;
+
+	if (!skb)
+		return NF_ACCEPT;
+
+	meta_have = bpf_map_lookup_elem(&meta_map, &skb);
+	if (!meta_have)
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

