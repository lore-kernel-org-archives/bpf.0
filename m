Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDF1499F35
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048973; cv=none; b=fs81DJGdIdGKU9DmFvuHuAfRImM7u+R9STfbAXKYhmYyeLyDs9Gk2t4vRCBqmNrY1LxvuDTBf4NBFa+KclE5rl+4wylaY0vZLTymBhv+JzVuUGSHtxSuntrCGuzvqXnfSPQqAsGlvVJgj2WfDW2KAtHbzmVAYGKJSw63WWDxqa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048973; c=relaxed/simple;
	bh=idjd0XpKluSxLFQX+2XIDYxpVVBUBIHh3Ossfmv7ifY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nr5sMVbzvBjcKlNUwY/Xf6lG+U9hvQkCxKdS4/bvtm99VWRjl6cRyU0TtCq+ECVu1q0cajkLLo5002mTgu9/j/RO65vwIHYeaSzqL5PQrBDPxZl9PXo3ZJJH2SGc8gMeaq994EPTTtFcuquQ9DvUdEUbMYkjrcxmHAYoGFp3wHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=a7PBdbLk; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="a7PBdbLk"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f0b23so437707866b.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 07:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789048969; x=1789653769; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SSbzilpslCe/i/7LXye4xmbe80qorkEa/HcRS29f1+4=;
        b=a7PBdbLkSHf/x9NarjCI7gokWW168DsN+Em8G/LAjOr8wwkSVObuOsLPiqGHtTgMfZ
         z3GQUmn6HpK72V+ihmXzxoDAla4cBeBes+JJBLeA/8uLnah1+Q19beUGEueRyCmBCCGB
         tkK5ys0X20uwt3d2OwLAtyXktrd6+I6YTyAKx5jjX2Q81Y4EIL//MYnVVlTjSVK+x8xZ
         88L23MFTR4L7/BAUCCZ1EnTxJ7iMYQnBRSMGrGqYnI70g8WTTEKtschP4Z0jNpVBtxuD
         MbsT5vJ6PAvpYoMKrLYtIZrKczS4XTv7P23K8wKxfeUYE81rPlLWhj6x6mEC9yd2HqoZ
         Dwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789048969; x=1789653769;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SSbzilpslCe/i/7LXye4xmbe80qorkEa/HcRS29f1+4=;
        b=p4GerbhddAD49JEmdRf7Cr1wU+e2W3IrNbAG/Kwvd1Tr/Z2nCy6RWlutc5bPkXjYRr
         ou+2ZyDGgDYyh2hfDK6GiLK1JTdVb7tcza2B0kQ9vF6yOfm7q7T0RKJV209UztENAhPX
         Xycl4T8SHZL8SlG5Al/KJ2Tr/CPkqgZWIeLGnsFhoj1whuF7xHmIcqlMSRxCZzQv2rDA
         KsrHds/UjTJYS3u0BTcUmRJWQ47jBJH9zbGULciIdBUE55MXRA5UBk7sRFo4MK3IxmJK
         fWt0IoADcBxNbW1R9X2sZ1ACNEnosavnh3M/TSk6Si+XS5ttXT0nRpSCN7+E1Di2DMfo
         ukMQ==
X-Gm-Message-State: AFuF++nWyza+sDxNCIlA0jAG8tTslW+UvioJJPOI6qETSHHb2H8TL7bT
	ySd4v3LYX/gLC+eSzZfDOlkW0ZBUImQxIaneFYYDWMH65+aO8OsoInmG+3JHdI7nyik=
X-Gm-Gg: AYBFou3jyUyfLqGNUV8DNbdsVBprwyH8YoYl4gdKa4ZPOwQuHoYNAqHR3tQeFads9Qe
	TO/kgkYN5+4NYp63gIv+PGI9ETPJBF35DH4cHcKgbIOaOwHj3k3gAQhuaTmNcUiGOEU28oak6pj
	G++IKa85RNcxeaE1SMi9IpyfOKGbCQy3KlrmbSkPYFyBh9+Wb/5RthqtjHcGamG/C3P1R904H5c
	VmEIwpVCfdkD9cr9RHockEWFkHPUEfGzgSFoGuiRpPBWnTqNCIUkTcjbA5PFjuvfhXgTXXEnXeW
	4+KlL9XTJmZm/PfaKo+D7HTxiAk2T35ISwq6xSB+w7s35RVnGPFug6u31q1x3Ox0TPAj6JElr/n
	U7Vw+nPjfLR8ICZFI/pd7phkhPXKQDfSpm4KRTfa+dznsswwjfu8a6EVQ/zWerWodtiLHK1qE1N
	Bq9Agl639NJwu2ryajjcY9lrC3kQVKhKEXw3xBzaQup3Cd8F+s9mHRW5N9jD8NpI4rh6PieuI2d
	Y9mOphRlyQmkG492N7wjVnRaa5qKgAGwZfdByC8RolLpXWz
X-Received: by 2002:a17:907:1c21:b0:c26:3107:71bb with SMTP id a640c23a62f3a-c292b1f3691mr1092866666b.24.1789048969258;
        Thu, 10 Sep 2026 07:02:49 -0700 (PDT)
Received: from cloudflare.com (79.184.140.212.ipv4.supernova.orange.pl. [79.184.140.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2622a7c677sm820412066b.9.2026.09.10.07.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:02:48 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 10 Sep 2026 16:02:39 +0200
Subject: [PATCH net-next v2 04/14] selftests/bpf: Add tests for
 bpf_dynptr_from_skb_ext
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-bpf-meta-inside-skb-ext-v2-4-0b21e42180b0@cloudflare.com>
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

Cover the bpf_dynptr_from_skb_ext() kfunc and the dynptr interface
to skb_ext with TC-to-TC tests on a tuntap device:

- write/read via bpf_dynptr_read and bpf_dynptr_write
- write/read via bpf_dynptr_slice and bpf_dynptr_slice_rdwr
- clone read via bpf_dynptr_clone
- error paths: no allocation without F_CREATE, invalid flags, read-only
  enforcement without F_CREATE
- double allocation: data from first alloc survives second skb_ext_add

Plus, exercise the verifier check for tracing and LSM programs that rejects
bpf_dynptr_from_skb_ext(BPF_SKB_EXT_F_CREATE) in these contexts.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/config                 |   1 +
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../bpf/prog_tests/xdp_context_test_run.c          |  73 +++++++-
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 185 +++++++++++++++++++++
 .../testing/selftests/bpf/progs/verifier_skb_ext.c |  77 +++++++++
 5 files changed, 333 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index ea7044f30adc..502f4504bdba 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -7,6 +7,7 @@ CONFIG_BPF_JIT=y
 CONFIG_BPF_KPROBE_OVERRIDE=y
 CONFIG_BPF_LIRC_MODE2=y
 CONFIG_BPF_LSM=y
+CONFIG_BPF_SKB_EXT=y
 CONFIG_BPF_STREAM_PARSER=y
 CONFIG_BPF_SYSCALL=y
 # CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 64ac49ad67e6..7724e82fce66 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -94,6 +94,7 @@
 #include "verifier_scalar_ids.skel.h"
 #include "verifier_sdiv.skel.h"
 #include "verifier_search_pruning.skel.h"
+#include "verifier_skb_ext.skel.h"
 #include "verifier_sock.skel.h"
 #include "verifier_sock_addr.skel.h"
 #include "verifier_sockmap_mutate.skel.h"
@@ -256,6 +257,7 @@ void test_verifier_runtime_jit(void)          { RUN(verifier_runtime_jit); }
 void test_verifier_scalar_ids(void)           { RUN(verifier_scalar_ids); }
 void test_verifier_sdiv(void)                 { RUN(verifier_sdiv); }
 void test_verifier_search_pruning(void)       { RUN(verifier_search_pruning); }
+void test_verifier_skb_ext(void)              { RUN(verifier_skb_ext); }
 void test_verifier_sock(void)                 { RUN(verifier_sock); }
 void test_verifier_sock_addr(void)            { RUN(verifier_sock_addr); }
 void test_verifier_sockmap_mutate(void)       { RUN(verifier_sockmap_mutate); }
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 448807676176..252ac02de81b 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -16,6 +16,7 @@
 #define DUMMY_NAME "dum0"
 #define TAP_NETNS "xdp_context_tuntap"
 #define LWT_NETNS "xdp_context_lwt"
+#define SKB_EXT_NETNS "skb_ext_tuntap"
 
 #define TEST_PAYLOAD_LEN 32
 static const __u8 test_payload[TEST_PAYLOAD_LEN] = {
@@ -331,10 +332,11 @@ void test_xdp_context_veth(void)
 	netns_free(tx_ns);
 }
 
-static void test_tuntap(struct bpf_program *xdp_prog,
-			struct bpf_program *tc_prio_1_prog,
-			struct bpf_program *tc_prio_2_prog,
-			bool *test_pass)
+static void __test_tuntap(const char *nsname,
+			  struct bpf_program *xdp_prog,
+			  struct bpf_program *tc_prio_1_prog,
+			  struct bpf_program *tc_prio_2_prog,
+			  bool *test_pass)
 {
 	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
 	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
@@ -345,7 +347,7 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 
 	*test_pass = false;
 
-	ns = netns_new(TAP_NETNS, true);
+	ns = netns_new(nsname, true);
 	if (!ASSERT_OK_PTR(ns, "create and open ns"))
 		return;
 
@@ -396,6 +398,15 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 	netns_free(ns);
 }
 
+static void test_tuntap(struct bpf_program *xdp_prog,
+			struct bpf_program *tc_prio_1_prog,
+			struct bpf_program *tc_prio_2_prog,
+			bool *test_pass)
+{
+	__test_tuntap(TAP_NETNS, xdp_prog, tc_prio_1_prog, tc_prio_2_prog,
+		      test_pass);
+}
+
 /* Write a packet to a tap dev and copy it to ingress of a dummy dev */
 static void test_tuntap_mirred(struct bpf_program *xdp_prog,
 			       struct bpf_program *tc_prog,
@@ -693,3 +704,55 @@ void test_xdp_context_lwt_encap(void)
 
 	test_xdp_meta__destroy(skel);
 }
+
+static void test_skb_ext_tuntap(struct bpf_program *tc_prio_1_prog,
+				struct bpf_program *tc_prio_2_prog,
+				bool *test_pass)
+{
+	__test_tuntap(SKB_EXT_NETNS, NULL /* xdp */, tc_prio_1_prog,
+		      tc_prio_2_prog, test_pass);
+}
+
+void test_skb_ext_basic(void)
+{
+	struct test_xdp_meta *skel = NULL;
+
+	skel = test_xdp_meta__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
+		return;
+
+	if (test__start_subtest("tc_write_read"))
+		test_skb_ext_tuntap(skel->progs.tc_skb_ext_write,
+				    skel->progs.tc_skb_ext_read,
+				    &skel->bss->test_pass);
+	if (test__start_subtest("tc_write_clone_read"))
+		test_skb_ext_tuntap(skel->progs.tc_skb_ext_write,
+				    skel->progs.tc_skb_ext_clone_read,
+				    &skel->bss->test_pass);
+	if (test__start_subtest("tc_write_slice_read"))
+		test_skb_ext_tuntap(skel->progs.tc_skb_ext_write,
+				    skel->progs.tc_skb_ext_slice_read,
+				    &skel->bss->test_pass);
+	if (test__start_subtest("tc_slice_write_read"))
+		test_skb_ext_tuntap(skel->progs.tc_skb_ext_slice_write,
+				    skel->progs.tc_skb_ext_read,
+				    &skel->bss->test_pass);
+	if (test__start_subtest("tc_no_alloc"))
+		test_skb_ext_tuntap(skel->progs.tc_skb_ext_no_alloc,
+				    NULL, /* tc prio 2 */
+				    &skel->bss->test_pass);
+	if (test__start_subtest("tc_invalid_flags"))
+		test_skb_ext_tuntap(skel->progs.tc_skb_ext_invalid_flags,
+				    NULL, /* tc prio 2 */
+				    &skel->bss->test_pass);
+	if (test__start_subtest("tc_rdonly"))
+		test_skb_ext_tuntap(skel->progs.tc_skb_ext_rdonly,
+				    NULL, /* tc prio 2 */
+				    &skel->bss->test_pass);
+	if (test__start_subtest("tc_double_alloc"))
+		test_skb_ext_tuntap(skel->progs.tc_skb_ext_double_alloc,
+				    NULL, /* tc prio 2 */
+				    &skel->bss->test_pass);
+
+	test_xdp_meta__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 08b03be0b891..43840ee32d35 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -6,6 +6,7 @@
 #include <errno.h>
 
 #include "bpf_kfuncs.h"
+#include "bpf_misc.h"
 #include "bpf_tracing_net.h"
 
 #define META_SIZE 32
@@ -689,4 +690,188 @@ int helper_skb_change_proto(struct __sk_buff *ctx)
 	return TC_ACT_SHOT;
 }
 
+/* Write to skb_ext using bpf_dynptr_write helper */
+SEC("tc")
+int tc_skb_ext_write(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+
+	if (!is_test_packet_tc(ctx))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_write(&meta, 0, (void *)meta_want, ARRAY_SIZE(meta_want), 0))
+		return TC_ACT_SHOT;
+
+	return TC_ACT_UNSPEC;
+}
+
+/* Read from skb-ext metadata using bpf_dynptr_read helper */
+SEC("tc")
+int tc_skb_ext_read(struct __sk_buff *ctx)
+{
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, 0, &meta))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_read(meta_have, ARRAY_SIZE(meta_have), &meta, 0, 0))
+		return TC_ACT_SHOT;
+	if (!check_metadata(meta_have))
+		return TC_ACT_SHOT;
+
+	test_pass = true;
+	return TC_ACT_UNSPEC;
+}
+
+/* Read from a cloned skb_ext dynptr */
+SEC("tc")
+int tc_skb_ext_clone_read(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta, clone;
+	__u8 meta_have[META_SIZE];
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, 0, &meta))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_clone(&meta, &clone))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_read(meta_have, ARRAY_SIZE(meta_have), &clone, 0, 0))
+		return TC_ACT_SHOT;
+	if (!check_metadata(meta_have))
+		return TC_ACT_SHOT;
+
+	test_pass = true;
+	return TC_ACT_UNSPEC;
+}
+
+/* Read from skb_ext using bpf_dynptr_slice */
+SEC("tc")
+int tc_skb_ext_slice_read(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+	__u8 *meta_have;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, 0, &meta))
+		return TC_ACT_SHOT;
+	meta_have = bpf_dynptr_slice(&meta, 0, NULL, META_SIZE);
+	if (!meta_have)
+		return TC_ACT_SHOT;
+	if (!check_metadata(meta_have))
+		return TC_ACT_SHOT;
+
+	test_pass = true;
+	return TC_ACT_UNSPEC;
+}
+
+/* Write to skb_ext using bpf_dynptr_slice_rdwr */
+SEC("tc")
+int tc_skb_ext_slice_write(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+	__u8 *dst;
+
+	if (!is_test_packet_tc(ctx))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return TC_ACT_SHOT;
+	dst = bpf_dynptr_slice_rdwr(&meta, 0, NULL, META_SIZE);
+	if (!dst)
+		return TC_ACT_SHOT;
+	__builtin_memcpy(dst, meta_want, META_SIZE);
+
+	return TC_ACT_UNSPEC;
+}
+
+/* Opening skb_ext without F_CREATE on a fresh skb should fail */
+SEC("tc")
+int tc_skb_ext_no_alloc(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+
+	if (!is_test_packet_tc(ctx))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_from_skb_ext(ctx, 0, 0, &meta) != -ENOENT)
+		return TC_ACT_SHOT;
+
+	test_pass = true;
+	return TC_ACT_UNSPEC;
+}
+
+/* Invalid flags are rejected */
+SEC("tc")
+int tc_skb_ext_invalid_flags(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+
+	if (!is_test_packet_tc(ctx))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_from_skb_ext(ctx, 0, ~0ULL, &meta) != -EINVAL)
+		return TC_ACT_SHOT;
+
+	test_pass = true;
+	return TC_ACT_UNSPEC;
+}
+
+/* Without F_CREATE the dynptr is read-only */
+SEC("tc")
+int tc_skb_ext_rdonly(struct __sk_buff *ctx)
+{
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+
+	if (!is_test_packet_tc(ctx))
+		return TC_ACT_SHOT;
+
+	/* Create and populate the ext */
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_write(&meta, 0, (void *)meta_want, META_SIZE, 0))
+		return TC_ACT_SHOT;
+
+	/* Reopen without F_CREATE -- should be read-only */
+	if (bpf_dynptr_from_skb_ext(ctx, 0, 0, &meta))
+		return TC_ACT_SHOT;
+
+	/* Verify read-only: writes must fail, reads must work */
+	if (!bpf_dynptr_is_rdonly(&meta))
+		return TC_ACT_SHOT;
+	if (!bpf_dynptr_write(&meta, 0, (void *)meta_want, META_SIZE, 0))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0))
+		return TC_ACT_SHOT;
+	if (!check_metadata(meta_have))
+		return TC_ACT_SHOT;
+
+	test_pass = true;
+	return TC_ACT_UNSPEC;
+}
+
+/* Double alloc: data from first alloc survives second skb_ext_add */
+SEC("tc")
+int tc_skb_ext_double_alloc(struct __sk_buff *ctx)
+{
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+
+	if (!is_test_packet_tc(ctx))
+		return TC_ACT_SHOT;
+
+	/* First alloc + write */
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_write(&meta, 0, (void *)meta_want, META_SIZE, 0))
+		return TC_ACT_SHOT;
+
+	/* Second alloc -- skb_ext_add returns existing ext */
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0))
+		return TC_ACT_SHOT;
+	if (!check_metadata(meta_have))
+		return TC_ACT_SHOT;
+
+	test_pass = true;
+	return TC_ACT_UNSPEC;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_skb_ext.c b/tools/testing/selftests/bpf/progs/verifier_skb_ext.c
new file mode 100644
index 000000000000..db43f1051400
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_skb_ext.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+__u64 flags;
+
+SEC("tp_btf/kfree_skb")
+__description("F_CREATE is rejected in tracing programs")
+__failure __msg("is not allowed in lsm/tracing programs")
+int BPF_PROG(tp_skb_ext_create, struct sk_buff *skb)
+{
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext((struct __sk_buff *)skb, 0,
+				    BPF_SKB_EXT_F_CREATE, &meta))
+		return 0;
+
+	return 0;
+}
+
+SEC("tp_btf/kfree_skb")
+__description("non-constant flags are rejected in tracing programs")
+__failure __msg("must be a known constant")
+int BPF_PROG(tp_skb_ext_var_flags, struct sk_buff *skb)
+{
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext((struct __sk_buff *)skb, 0, flags, &meta))
+		return 0;
+
+	return 0;
+}
+
+SEC("tc")
+__description("non-constant flags are rejected")
+__failure __msg("must be a known constant")
+int skb_ext_var_flags(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, flags, &meta))
+		return 0;
+
+	return 0;
+}
+
+SEC("lsm/inet_conn_established")
+__description("F_CREATE is rejected in LSM programs")
+__failure __msg("is not allowed in lsm/tracing programs")
+int BPF_PROG(lsm_skb_ext_create, struct sock *sk, struct sk_buff *skb)
+{
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext((struct __sk_buff *)skb, 0,
+				    BPF_SKB_EXT_F_CREATE, &meta))
+		return 0;
+
+	return 0;
+}
+
+SEC("lsm/inet_conn_established")
+__description("non-constant flags are rejected in LSM programs")
+__failure __msg("must be a known constant")
+int BPF_PROG(lsm_skb_ext_var_flags, struct sock *sk, struct sk_buff *skb)
+{
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext((struct __sk_buff *)skb, 0, flags, &meta))
+		return 0;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.43.0

