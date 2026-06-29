Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C4046AF0F
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754052; cv=none; b=dBDE33aVSB26STzo3bVCIurstAfvV/K0NmHcco9QLmtGTS1ZQmgxa2d+rcAUZoUByUrF+2B4KkkHdfu5WF6rx544xqZnTfspji31bi5ym4fMdHI8W5N3BO2MoSzzv1svKBtcbNNMqZoPbbyQKmXl1ZTz7gAG267qPCHCHzSEjpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754052; c=relaxed/simple;
	bh=BJeyjpSrE3nFrrnXnTELicRfP0xiuDtfrJZGnuaoXQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mnq7FQir/MecboZsNds1ctycqeGH1oUZuLqhPSkbifZ/12sl9JlIaDdPTX8yIGEVbzV3gdo0g1+4ZCIDXtPdZWIC+nrNWCwVaXnIWOg56uo2u8hNIG69Oax2ek1Fmd26Mi0SIYRNtcXMhwG74frft0BWq4Et11ui8h1DwyYjPCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDICKZ50; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDICKZ50"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-847968ca62fso581372b3a.2
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 10:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782754050; x=1783358850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfTqAPF2z3x4FKe96v+KSKZ7cZLPBUPyaVvC2qekN80=;
        b=HDICKZ50/BAkrs1cqwcM9agHV5LJ9XOP0MduaiNTH+CSH11Yk2YzPAjAkcv1c2zfDd
         gTFbrClZUivkNpJIRgvxGuCWdGHhLeNrEUQNIT5atUTQd1NvXm4F8UoXmZ5ntcSGY4xI
         YpRq3hNyy++bIwvPwJP0PzQNxmfsPXYj7h5oOMq1j8pN6lRfbz/+HVME97+wpQ0GGNVe
         hK5QRNOYmDmjOGNOJMk/YajAbhOMmDcSRd7xXVTnbtK56nDZK+Xv05geXoWp1lRSmxcQ
         Lw2mLMxbYARkcA5buG6+rkvVSk+YVU2JBHXj5W3w8JA+OmR9mgIsEkiK5OuBQIZM104Z
         mydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782754050; x=1783358850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SfTqAPF2z3x4FKe96v+KSKZ7cZLPBUPyaVvC2qekN80=;
        b=Iss6zbhfFlbk+kJPekRtIYMHqYw/Vt/uIq44/JCgdKdmwcIk7Crll2ihc+CXElBIkf
         yE729bgrKpZLqKuGwtdXI6YhjLNWCmkmtMWAqKVvpr5UU1dVXobrwBLDicstZ1U6v5Yt
         3HND45YBKmyVG6HVr/mxaLDEwg7F2hBU1cAmjjTwg8+788yrlahM1qouILteMk0YxOUt
         FRJWO0hvYUse6/l3HDIRq/eSAJ70sztR5afVRPpCjrs0DONAP1xvia71dqKtxAOU/d9B
         uEMa5C3b5l7OSk3ZVSDZHuWwjzd6RcR/pponcnxmKnAuOdFtSe/mlVz7/IQBT7msiBS4
         o1dg==
X-Forwarded-Encrypted: i=1; AFNElJ/8qWm0knVJAX5Wbg+IFVOfimJOisoT3hXDoS6cpAMBjvMLYShyW4hrMt9iL6x3TnQpzR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqNSBRjt6Dq9WJHHtfSxT92Rie60YJL+tnVqn8uszGRiLc8qEX
	5TbgIiJ6Nh2/YXEfGx8MSQa6h1qyu10dOXMUTYlh2qjtCzyQDpNrpLEJ
X-Gm-Gg: AfdE7ckTPNoL/QYdb/z4wDxNvg1/dKErqIZSZEt5QGZAG4Xd0hlgB9VcLhenAxfVdm6
	9ymQht3pi2CJcSGmgsmEUSZnQBGxmcqrTaYB8aahY+VP/cCfOY1xbdXv7efgh0fhdAr62kdZvlh
	/FQ/J/jjMgp8Ud13+I+VjCiG84Fq4Cl+56Ku/sD1IEX2gdq6824KT266jWizMAS+QIgVatwgzq5
	4XR0+0pbrAUVuT2zZ2k7AXMtpaDUhCV71JLa5458M6Ss+cBnfBJ3IsbkmeJB4PoocfjgldfCQyx
	X8s5nefcYSlp1B2LsHJ1RKSI/wH1YsxuOInaKnYhk91CCRes1Mkegk7FeHTxWUM5tt5a5GFo523
	9z1ejHf/R0NLEEvbqnGpYzPsGh37satg2m7GWjVTPZ2DtSc7WogJOH5SsDWasMlxGIcslSJ1r5b
	HmFuKgnB3cPdDbMiLT6nt6hd/R7UIj6ZI1Avsc1bqUQv79+JJYkJMIXkvVIzBmhw==
X-Received: by 2002:a05:6a00:368e:b0:845:4fec:3f8f with SMTP id d2e1a72fcca58-8479f27b7d6mr294845b3a.40.1782754050415;
        Mon, 29 Jun 2026 10:27:30 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a039f2afsm78542b3a.53.2026.06.29.10.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 10:27:30 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Lorenz Bauer <lmb@isovalent.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: drop tc/xdp/flow_dissector sockmap mutation tests
Date: Mon, 29 Jun 2026 17:27:01 +0000
Message-ID: <20260629172704.1302218-3-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629172704.1302218-1-rhkrqnwk98@gmail.com>
References: <20260629172704.1302218-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tc, xdp and flow_dissector programs can no longer update or delete a
sockmap. Adjust the tests:

 - verifier_sockmap_mutate: the tc, xdp and flow_dissector cases now
   expect __failure with "cannot update sockmap in this context".
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
 .../bpf/progs/verifier_sockmap_mutate.c       | 10 ++--
 5 files changed, 5 insertions(+), 152 deletions(-)
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
index fe4b123187b8..b11026123690 100644
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

