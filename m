Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5215943C07E
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782831278; cv=none; b=B29cvV2QTSoLq5Irg7qy2ydiRdSU7DQ9ab+DPak/MI87svZIgkPioS+AxwnEYeVZV/J+qzXFMgSw3f3JqJSqQU7hZEOp/SKedy3tKicwQaMgb96vqetNKcsgL8n6hEYJMAl93sWauuop12RGPk/qZj7iNROkiXCsQhrSsBHeZoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782831278; c=relaxed/simple;
	bh=6fpn34AYa5a4NP99AEz19Q2ZqyMidgD7TtSO++tV3ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWOtrcgQum+bDDlSdcxag6VLJxg3U0Il8bPhYTzAgwTZBYGTCBNud/urrJYG6n1OgTK4spX/AV4LlP+MV//KojHJdrLbtoaXjlE5YsA0DxrXb1sONcIqmZzg57NaX7jxAOEcWVkIRxmXT4SLiuvZ7fPBHKA9nr8nYSrnbmvBVh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oDp6Krr/; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDp6Krr/"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-37dedd62b90so498427a91.1
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 07:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782831276; x=1783436076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZ8Fq141v51trmI2n1AyrBm7+0CWWqtlV8J+t5ivkWw=;
        b=oDp6Krr/zu0QGqyCQyDqG6h2gEBw0tbDrt7RTbJ+367iKPPfUCZVbqgSX4iwCjJzuU
         yT1h3nygJ0/mrmK4bR9WnggBIty8xC21xEx3fQFjGq2KLW8R3OrIksCQ+5Qex5rnQh5I
         QzMYyFX3pkJSees9bMy9i2AXzi9uT0M00GvmIcaw3YICyp6wPV/hsrbHLtSNzDYZVHmc
         VTAZsGPFj1GIbGjm+rh3vohMIRIs9u1dG+SehPOTUOpGyhphf3I9j9q2qQMSMBBxfYTS
         onxKnkiStt7CEGWQwxZZF2ikwO8zsUiFmmAPQ3M2T++PfqEdKjrlJHR48StFTrx6D+dx
         vv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782831276; x=1783436076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yZ8Fq141v51trmI2n1AyrBm7+0CWWqtlV8J+t5ivkWw=;
        b=TxFI6TI6GozYCT8+CWyZtdPwpVlQlGGz5loU+hFy0w4tMkejxEughhv2asbzpJD7qL
         HlVNpWTH86DYW+V6nf08nvSixUXCyyApA2b/Ie/V0Y2fhTBRfObf2HgyB1xNm8bCXRWr
         2hTbTEm5Kv2J0wepZlfApZLKld9x10I6cRxhTldZhMkLhLQUnXH6zMYj5yHJemxGTPfx
         ICPajeyPLKkwZ3h8u2VX+o9Kb9rYAm3GGWDqScgm/4rPWRK395S89YUy8T1fq7s4cXOG
         9qgBPnHerq7MblIdiKvfAS1SyBQgFahHBAkwPWNu1ek517T6bqdrXOs31gnEyODySqMd
         m0wQ==
X-Forwarded-Encrypted: i=1; AHgh+RrOAZtetQ3I9WbCaFqFf3EWxAkYAJu27pJA5GD2MhrbqqeLOO951cv1st4yKgSrdl7H4NI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDjXLn8MitcDAeF1+DeYbubVnNXuYKHcMOmuq0dv6qGJfyAwyV
	K92s7VQhrkN1yw66QwkqAWF63fOn4pK+c3C4011Gj63ikhJ69+B7gCNA
X-Gm-Gg: AfdE7clOY2MMlbSsGFrRndCf9rOFTpU3wiNZYa1Gjt49zHoYnG7KE3RmpxIalC83CVL
	xW1zXfTW2aYe8IL8oyR0M1d8qK9G2Ipb58h+U5e6U107pT2mN2dyld7/PXqKZHdMQQqU9S3Or7c
	fueK12Tqf4t78+DjCkpFPZf7SpTFo7stsLOL0roxUsBrT1tHKrzxno44ll7o5r/uFozXe1bZRkh
	TFtf0Qhwp+374m3vUPH7ky05B/kmNhQN3sPI/+At0E9rrT4EA9Y8KeRDXA+i5CAj2d3zNGPrg1U
	YTFYfDoDOOk6Skjcsm7peeEgmI96/CUYlzlXSqZTZDNnAp50Sjz8PZd9Aap7ZEQNIn0rvtzJQb0
	XyksLMgukG22+D1cWOS3bXz4Qo2ynjv812pW+4+sjy4pEMRYMukNUnXk5sckaJ0VImk3biIH4uA
	adFlHbix55lFfaJBSh0tXCQ/zkJYHlX6rWQncrh7iuuCvI3TJ0ZDQ=
X-Received: by 2002:a17:90b:520d:b0:36d:c138:e0a0 with SMTP id 98e67ed59e1d1-38067336c32mr1690613a91.2.1782831276383;
        Tue, 30 Jun 2026 07:54:36 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38095b684basm20122a91.1.2026.06.30.07.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 07:54:35 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Varun R Mallya <varunrmallya@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: drop tc/xdp/flow_dissector/socket_filter sockmap mutation tests
Date: Tue, 30 Jun 2026 14:54:06 +0000
Message-ID: <20260630145410.3648099-3-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630145410.3648099-1-rhkrqnwk98@gmail.com>
References: <20260630145410.3648099-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tc, xdp, socket_filter and flow_dissector programs can no longer update
or delete a sockmap. Adjust the tests:

 - verifier_sockmap_mutate: the tc, xdp, socket_filter and
   flow_dissector cases now expect __failure with "cannot update sockmap
   in this context".
 - sockmap_basic: drop "sockmap update" / "sockhash update", which load
   a SEC("tc") program that copies a sock between maps.
 - fexit_bpf2bpf: drop "func_sockmap_update", whose freplace program
   updates a sockmap in the tc cls_redirect context.

Remove the now-unused test_sockmap_update.c and freplace_cls_redirect.c.

Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 13 -----
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 52 -------------------
 .../bpf/progs/freplace_cls_redirect.c         | 34 ------------
 .../selftests/bpf/progs/test_sockmap_update.c | 48 -----------------
 .../bpf/progs/verifier_sockmap_mutate.c       | 12 ++---
 5 files changed, 6 insertions(+), 153 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/progs/freplace_cls_redirect.c
 delete mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_update.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index 92c20803ea76..d3a954158c33 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -336,17 +336,6 @@ static void test_fmod_ret_freplace(void)
 }
 
 
-static void test_func_sockmap_update(void)
-{
-	const char *prog_name[] = {
-		"freplace/cls_redirect",
-	};
-	test_fexit_bpf2bpf_common("./freplace_cls_redirect.bpf.o",
-				  "./test_cls_redirect.bpf.o",
-				  ARRAY_SIZE(prog_name),
-				  prog_name, false, NULL);
-}
-
 static void test_func_replace_void(void)
 {
 	const char *prog_name[] = {
@@ -599,8 +588,6 @@ void serial_test_fexit_bpf2bpf(void)
 		test_func_replace();
 	if (test__start_subtest("func_replace_verify"))
 		test_func_replace_verify();
-	if (test__start_subtest("func_sockmap_update"))
-		test_func_sockmap_update();
 	if (test__start_subtest("func_replace_return_code"))
 		test_func_replace_return_code();
 	if (test__start_subtest("func_map_prog_compatibility"))
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index cb3229711f93..33f788e2786d 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -7,7 +7,6 @@
 
 #include "test_progs.h"
 #include "test_skmsg_load_helpers.skel.h"
-#include "test_sockmap_update.skel.h"
 #include "test_sockmap_invalid_update.skel.h"
 #include "test_sockmap_skb_verdict_attach.skel.h"
 #include "test_sockmap_progs_query.skel.h"
@@ -235,53 +234,6 @@ static void test_skmsg_helpers_with_link(enum bpf_map_type map_type)
 	test_skmsg_load_helpers__destroy(skel);
 }
 
-static void test_sockmap_update(enum bpf_map_type map_type)
-{
-	int err, prog, src;
-	struct test_sockmap_update *skel;
-	struct bpf_map *dst_map;
-	const __u32 zero = 0;
-	char dummy[14] = {0};
-	LIBBPF_OPTS(bpf_test_run_opts, topts,
-		.data_in = dummy,
-		.data_size_in = sizeof(dummy),
-		.repeat = 1,
-	);
-	__s64 sk;
-
-	sk = connected_socket_v4();
-	if (!ASSERT_NEQ(sk, -1, "connected_socket_v4"))
-		return;
-
-	skel = test_sockmap_update__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "open_and_load"))
-		goto close_sk;
-
-	prog = bpf_program__fd(skel->progs.copy_sock_map);
-	src = bpf_map__fd(skel->maps.src);
-	if (map_type == BPF_MAP_TYPE_SOCKMAP)
-		dst_map = skel->maps.dst_sock_map;
-	else
-		dst_map = skel->maps.dst_sock_hash;
-
-	err = bpf_map_update_elem(src, &zero, &sk, BPF_NOEXIST);
-	if (!ASSERT_OK(err, "update_elem(src)"))
-		goto out;
-
-	err = bpf_prog_test_run_opts(prog, &topts);
-	if (!ASSERT_OK(err, "test_run"))
-		goto out;
-	if (!ASSERT_NEQ(topts.retval, 0, "test_run retval"))
-		goto out;
-
-	compare_cookies(skel->maps.src, dst_map);
-
-out:
-	test_sockmap_update__destroy(skel);
-close_sk:
-	close(sk);
-}
-
 static void test_sockmap_invalid_update(void)
 {
 	struct test_sockmap_invalid_update *skel;
@@ -1385,10 +1337,6 @@ void test_sockmap_basic(void)
 		test_skmsg_helpers(BPF_MAP_TYPE_SOCKMAP);
 	if (test__start_subtest("sockhash sk_msg load helpers"))
 		test_skmsg_helpers(BPF_MAP_TYPE_SOCKHASH);
-	if (test__start_subtest("sockmap update"))
-		test_sockmap_update(BPF_MAP_TYPE_SOCKMAP);
-	if (test__start_subtest("sockhash update"))
-		test_sockmap_update(BPF_MAP_TYPE_SOCKHASH);
 	if (test__start_subtest("sockmap update in unsafe context"))
 		test_sockmap_invalid_update();
 	if (test__start_subtest("sockmap copy"))
diff --git a/tools/testing/selftests/bpf/progs/freplace_cls_redirect.c b/tools/testing/selftests/bpf/progs/freplace_cls_redirect.c
deleted file mode 100644
index 7e94412d47a5..000000000000
--- a/tools/testing/selftests/bpf/progs/freplace_cls_redirect.c
+++ /dev/null
@@ -1,34 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2020 Facebook
-
-#include <linux/stddef.h>
-#include <linux/bpf.h>
-#include <linux/pkt_cls.h>
-#include <bpf/bpf_endian.h>
-#include <bpf/bpf_helpers.h>
-
-struct {
-	__uint(type, BPF_MAP_TYPE_SOCKMAP);
-	__type(key, int);
-	__type(value, int);
-	__uint(max_entries, 2);
-} sock_map SEC(".maps");
-
-SEC("freplace/cls_redirect")
-int freplace_cls_redirect_test(struct __sk_buff *skb)
-{
-	int ret = 0;
-	const int zero = 0;
-	struct bpf_sock *sk;
-
-	sk = bpf_map_lookup_elem(&sock_map, &zero);
-	if (!sk)
-		return TC_ACT_SHOT;
-
-	ret = bpf_map_update_elem(&sock_map, &zero, sk, 0);
-	bpf_sk_release(sk);
-
-	return ret == 0 ? TC_ACT_OK : TC_ACT_SHOT;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_update.c b/tools/testing/selftests/bpf/progs/test_sockmap_update.c
deleted file mode 100644
index 6d64ea536e3d..000000000000
--- a/tools/testing/selftests/bpf/progs/test_sockmap_update.c
+++ /dev/null
@@ -1,48 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2020 Cloudflare
-#include "vmlinux.h"
-#include <bpf/bpf_helpers.h>
-
-struct {
-	__uint(type, BPF_MAP_TYPE_SOCKMAP);
-	__uint(max_entries, 1);
-	__type(key, __u32);
-	__type(value, __u64);
-} src SEC(".maps");
-
-struct {
-	__uint(type, BPF_MAP_TYPE_SOCKMAP);
-	__uint(max_entries, 1);
-	__type(key, __u32);
-	__type(value, __u64);
-} dst_sock_map SEC(".maps");
-
-struct {
-	__uint(type, BPF_MAP_TYPE_SOCKHASH);
-	__uint(max_entries, 1);
-	__type(key, __u32);
-	__type(value, __u64);
-} dst_sock_hash SEC(".maps");
-
-SEC("tc")
-int copy_sock_map(void *ctx)
-{
-	struct bpf_sock *sk;
-	bool failed = false;
-	__u32 key = 0;
-
-	sk = bpf_map_lookup_elem(&src, &key);
-	if (!sk)
-		return SK_DROP;
-
-	if (bpf_map_update_elem(&dst_sock_map, &key, sk, 0))
-		failed = true;
-
-	if (bpf_map_update_elem(&dst_sock_hash, &key, sk, 0))
-		failed = true;
-
-	bpf_sk_release(sk);
-	return failed ? SK_DROP : SK_PASS;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c b/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
index fe4b123187b8..20332a731d4e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
@@ -74,7 +74,7 @@ static __always_inline void test_sockmap_lookup_and_mutate(void)
 }
 
 SEC("action")
-__success
+__failure __msg("cannot update sockmap in this context")
 int test_sched_act(struct __sk_buff *skb)
 {
 	test_sockmap_mutate(skb->sk);
@@ -82,7 +82,7 @@ int test_sched_act(struct __sk_buff *skb)
 }
 
 SEC("classifier")
-__success
+__failure __msg("cannot update sockmap in this context")
 int test_sched_cls(struct __sk_buff *skb)
 {
 	test_sockmap_mutate(skb->sk);
@@ -90,7 +90,7 @@ int test_sched_cls(struct __sk_buff *skb)
 }
 
 SEC("flow_dissector")
-__success
+__failure __msg("cannot update sockmap in this context")
 int test_flow_dissector_delete(struct __sk_buff *skb __always_unused)
 {
 	test_sockmap_delete();
@@ -98,7 +98,7 @@ int test_flow_dissector_delete(struct __sk_buff *skb __always_unused)
 }
 
 SEC("flow_dissector")
-__failure __msg("program of this type cannot use helper bpf_sk_release")
+__failure __msg("cannot update sockmap in this context")
 int test_flow_dissector_update(struct __sk_buff *skb __always_unused)
 {
 	test_sockmap_lookup_and_update(); /* no access to skb->sk */
@@ -146,7 +146,7 @@ int test_sk_reuseport(struct sk_reuseport_md *ctx)
 }
 
 SEC("socket")
-__success
+__failure __msg("cannot update sockmap in this context")
 int test_socket_filter(struct __sk_buff *skb)
 {
 	test_sockmap_mutate(skb->sk);
@@ -179,7 +179,7 @@ int test_sockops_update_dedicated(struct bpf_sock_ops *ctx)
 }
 
 SEC("xdp")
-__success
+__failure __msg("cannot update sockmap in this context")
 int test_xdp(struct xdp_md *ctx __always_unused)
 {
 	test_sockmap_lookup_and_mutate();
-- 
2.43.0

