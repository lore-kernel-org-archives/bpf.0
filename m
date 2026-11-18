Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012025;
	b=NiaWeW5a1+Ih6rt5dxcfwszFTB/g63whG7rtzb0QzSp1HlLYAU++IRu0e7HHpMFJIzx1
	 rwIt6otSo2C/lRpKRS/0G5CddJUvg5+xHcYZ0AHko9Yk7NniXl6DnSbeZWYgZeR/nHtrm
	 c9QvxhmL00TC2SX1ICYlxYR9e5cG0SObNq/VDJ7HRHFlab7sJPFzCNJx+Omq8S8mD2HTL
	 pgFtRRHc5+P9VOL+/7SaAbxj2FJxFr3FJ+5xiD9XFS1q0OxSxJ7wWj+cQjFym8IjpFIEJ
	 udmkWjfi3whToA8nDB4ZKve3QhuEa8MqJTTo4GRpWOU/tHdDSOnC9rgzwGe6ayU/G8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012025;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1caUQuDAo9B4D1sZWQgRiYxVWIU2K0f+Qt+bmgwUoAU=;
	b=ldjidhPecC7BUnLSV+evQEFHjp96OidZq89p+EdVINrwG8mmWBzXZS8FusUYByvEB8CQ
	 +1UEUzWnH9vFyObJzRDnIBgMyDcLlnxAIkobEeI8TDKDsJjmuQoq1OIwCA5RYsBaxyRBI
	 NmElsdrnpQHJJgkrWmYMMUH+3NnRf542Z52HXvxn80HRdQYN0WeuPEbymGHUub1Ky9YYG
	 oUFAskAq2MSBXiwTLbZJgjfUn8tNXlqHoyafPRlYbpkLGvERJ2I5OQZFeJh2kOX4VpbIS
	 HN5xjTP+BND10pML9NkqZasEzhh/Wbr6UaaTSHOCJsAje+LBs5CUplwmgKjPVBvqJ7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fajvUbTQ;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565A860A2609
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 14:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 565A860A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fajvUbTQ
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-862aca1ed4dso388119a34.0
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 06:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795012024; x=1795616824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1caUQuDAo9B4D1sZWQgRiYxVWIU2K0f+Qt+bmgwUoAU=;
        b=fajvUbTQYt2JvgHLNzQe42oxgkdL9v/Po1xKgNM/5oV1jCJbQv/qCOHYu27C2Sou06
         j+cG1tQczT3clXQez9cUPm9wyf0DEvYJLRxJ+r60YU4fr28v3JV6yGr6a1EmJU8zxxIP
         Z4HGRx/tOCbob/4MiwN+fGl3Eq57QZXHqLPZRBp3mFBfRHtntvCF4V/5HR82z0shxxH8
         yHsBkOJJHkDdELhqM+jlltpm6S6A2PlOpRZNZwottLeu3OrWRIPisCA/tiZA/wdg6bIy
         eVxakUMW2YydBqArn5cAlLGTPAShUtpMVSqqrydi/coaKhez0ixDLvpUwBpLbO3xnygS
         tcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795012024; x=1795616824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1caUQuDAo9B4D1sZWQgRiYxVWIU2K0f+Qt+bmgwUoAU=;
        b=e/Xs/cCIhWcSTE5RKiR9bl7uuqlIu0KXpzoUp8SkkAutLbC52vujaa9+tMrvZcLdqk
         cGFKg36883jFSBdl86ckSB3o7rYDuzQglOtZvMemH1pAJps3GmXwPABUjKDbEJdtIriU
         a9p8bIxVKWJD5n/Urmw2kxxsBnWGBP/3vno+4sq1yH0AA+nSglmk13gkCTmYVz8/coeI
         tZmcOS8lK4nkGgIYcMp/zZUgR0OV6f3Vniu5dZZ89zo5YfuaEgSu33U6/7e9SPpbp6f0
         BHN+mbHIt6ExZL2vl8jFLZ3ERtTbPSQ7xeJqwpA1ts1Q3rzI9uYndIq+F+eOc1CQdLVC
         jIPA==
X-Forwarded-Encrypted: i=1; AL+hErEHjKZ+11yl1gG17616rZ2SYZGOL3sgjIouq5OWvo/ePL4LmhxbJRMsAQLeh7sXWhTpKV8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9n5QQSv2rZW76ZCgDgI24S9iEhU+ebSUZcYlEE8kcrH3Rb327P
	A9FLkJr0H4E4uTd1px+jBTfMUGTCSGMN5SE6JtDQ12symIwfk2ZORijRtltOMUi9tYI=
X-Gm-Gg: AYBFou3SL3IDpAZJ+FCzPYdd77Op50oMOanIrLj3sboRX9133g+iRvFD8O5QdqQgrl3
	p6+iiJYQcHp/im80iAT/bW/6NM782ObGWRs7Z1mO2d11MCrQNmyRWb/cfL2kfD093nreQEVgGRc
	DMYttbKn1TmeBsNFjw9tB/QUGSCGPx6n+grOd7QlnWtZ+QForrvPwfqC+THaPLeq9dI//Z+/IV2
	rqxm2N2YU1nYV7Vh/u/SMLVZ94zo1z/fbv+6k8Q93Z6/atc6EEfBet9X+1FFfb5mEtVYCygk820
	+KOaQSNCO5QZe0rdVtX/7JuWEXX6pV5MGruOQnY8ygb04rolwarm+QQokLBrXDT/KpkpxaZjJ/Q
	WHpkSzF6UqGfPrx29yu3ohGooVKjVyhdBCUHIvcsW2bYk2MyqtYfBbevDs9Tktwr8d5b5daM5FQ
	GDxJjh/QpqCAv1wZn6gLUyXl13RxEj9bSczC9BQ/Zmz5BrY4I57J+N6aVNb1VIgVnsyw7jKGHIT
	9lRGC6gVteMHYYEodKhouARE0KX5A4hFIMh9+zIckyn1l4eq7P4olDpgWW3mEtYpThsBiANhMBG
	KM1gqwZ7+n77gwhNkq0EKZE3BReva0UNGnf3Xur/D5okx4QJUN1UuoGxt+oH5np/3MMe/sITy+x
	M70KL2SQmBA==
X-Received: by 2002:a05:6830:2692:b0:862:f05c:2fd with SMTP id 46e09a7af769-862f084c214mr2539116a34.3.1795012023649;
        Wed, 18 Nov 2026 06:27:03 -0800 (PST)
Received: from localhost ([216.128.135.139])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f024e434sm1999241a34.24.2026.11.18.06.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:27:03 -0800 (PST)
From: asatsuyu.liu@gmail.com
To: gregkh@linuxfoundation.org
Cc: asatsuyu.liu@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	puranjay@kernel.org,
	stable@vger.kernel.org,
	vadim.fedorenko@linux.dev
Subject: [PATCH 6.18.y 2/2] selftests: bpf: Fix test_bpf_nf for trusted args becoming default
Date: Wed, 18 Nov 2026 14:26:54 +0000
Message-Id: <20261118142654.3098395-3-asatsuyu.liu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118142654.3098395-1-asatsuyu.liu@gmail.com>
References: <2026111850-shiftless-popcorn-a566@gregkh>
 <20261118142654.3098395-1-asatsuyu.liu@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Puranjay Mohan <puranjay@kernel.org>

With trusted args now being the default, passing NULL to kfunc
parameters that are pointers causes verifier rejection rather than a
runtime error. The test_bpf_nf test was failing because it attempted to
pass NULL to bpf_xdp_ct_lookup() to verify runtime error handling.

Since the NULL check now happens at verification time, remove the
runtime test case that passed NULL to the bpf_tuple parameter and
instead add verification-time tests to ensure the verifier correctly
rejects programs that pass NULL to trusted arguments.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Link: https://lore.kernel.org/r/20260102180038.2708325-11-puranjay@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>

(cherry picked from commit cf503eb2c6c38bf449063f33790a96218a067718)
Signed-off-by: Yi Liu <asatsuyu.liu@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/bpf_nf.c |  5 +-
 .../testing/selftests/bpf/progs/test_bpf_nf.c |  7 ---
 .../selftests/bpf/progs/test_bpf_nf_fail.c    | 57 +++++++++++++++++++
 3 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
index dd6512fa652b..215878ea04de 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
@@ -19,6 +19,10 @@ struct {
 	{ "change_timeout_after_alloc", "kernel function bpf_ct_change_timeout args#0 expected pointer to STRUCT nf_conn but" },
 	{ "change_status_after_alloc", "kernel function bpf_ct_change_status args#0 expected pointer to STRUCT nf_conn but" },
 	{ "write_not_allowlisted_field", "no write support to nf_conn at off" },
+	{ "lookup_null_bpf_tuple", "Possibly NULL pointer passed to trusted arg1" },
+	{ "lookup_null_bpf_opts", "Possibly NULL pointer passed to trusted arg3" },
+	{ "xdp_lookup_null_bpf_tuple", "Possibly NULL pointer passed to trusted arg1" },
+	{ "xdp_lookup_null_bpf_opts", "Possibly NULL pointer passed to trusted arg3" },
 };
 
 enum {
@@ -111,7 +115,6 @@ static void test_bpf_nf_ct(int mode)
 	if (!ASSERT_OK(err, "bpf_prog_test_run"))
 		goto end;
 
-	ASSERT_EQ(skel->bss->test_einval_bpf_tuple, -EINVAL, "Test EINVAL for NULL bpf_tuple");
 	ASSERT_EQ(skel->bss->test_einval_reserved, -EINVAL, "Test EINVAL for reserved not set to 0");
 	ASSERT_EQ(skel->bss->test_einval_reserved_new, -EINVAL, "Test EINVAL for reserved in new struct not set to 0");
 	ASSERT_EQ(skel->bss->test_einval_netns_id, -EINVAL, "Test EINVAL for netns_id < -1");
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
index b42e6e149e26..ad03ee504cec 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
@@ -15,7 +15,6 @@
 
 extern unsigned long CONFIG_HZ __kconfig;
 
-int test_einval_bpf_tuple = 0;
 int test_einval_reserved = 0;
 int test_einval_reserved_new = 0;
 int test_einval_netns_id = 0;
@@ -99,12 +98,6 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
 
 	__builtin_memset(&bpf_tuple, 0, sizeof(bpf_tuple.ipv4));
 
-	ct = lookup_fn(ctx, NULL, 0, &opts_def, sizeof(opts_def));
-	if (ct)
-		bpf_ct_release(ct);
-	else
-		test_einval_bpf_tuple = opts_def.error;
-
 	opts_def.reserved[0] = 1;
 	ct = lookup_fn(ctx, &bpf_tuple, sizeof(bpf_tuple.ipv4), &opts_def,
 		       sizeof(opts_def));
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf_fail.c b/tools/testing/selftests/bpf/progs/test_bpf_nf_fail.c
index a586f087ffeb..2c156cd166af 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_nf_fail.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_nf_fail.c
@@ -4,6 +4,7 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
 
 struct nf_conn;
 
@@ -18,6 +19,10 @@ struct nf_conn *bpf_skb_ct_alloc(struct __sk_buff *, struct bpf_sock_tuple *, u3
 				 struct bpf_ct_opts___local *, u32) __ksym;
 struct nf_conn *bpf_skb_ct_lookup(struct __sk_buff *, struct bpf_sock_tuple *, u32,
 				  struct bpf_ct_opts___local *, u32) __ksym;
+struct nf_conn *bpf_xdp_ct_alloc(struct xdp_md *, struct bpf_sock_tuple *, u32,
+				 struct bpf_ct_opts___local *, u32) __ksym;
+struct nf_conn *bpf_xdp_ct_lookup(struct xdp_md *, struct bpf_sock_tuple *, u32,
+				  struct bpf_ct_opts___local *, u32) __ksym;
 struct nf_conn *bpf_ct_insert_entry(struct nf_conn *) __ksym;
 void bpf_ct_release(struct nf_conn *) __ksym;
 void bpf_ct_set_timeout(struct nf_conn *, u32) __ksym;
@@ -146,4 +151,56 @@ int change_status_after_alloc(struct __sk_buff *ctx)
 	return 0;
 }
 
+SEC("?tc")
+__failure __msg("Possibly NULL pointer passed to trusted arg1")
+int lookup_null_bpf_tuple(struct __sk_buff *ctx)
+{
+	struct bpf_ct_opts___local opts = {};
+	struct nf_conn *ct;
+
+	ct = bpf_skb_ct_lookup(ctx, NULL, 0, &opts, sizeof(opts));
+	if (ct)
+		bpf_ct_release(ct);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("Possibly NULL pointer passed to trusted arg3")
+int lookup_null_bpf_opts(struct __sk_buff *ctx)
+{
+	struct bpf_sock_tuple tup = {};
+	struct nf_conn *ct;
+
+	ct = bpf_skb_ct_lookup(ctx, &tup, sizeof(tup.ipv4), NULL, sizeof(struct bpf_ct_opts___local));
+	if (ct)
+		bpf_ct_release(ct);
+	return 0;
+}
+
+SEC("?xdp")
+__failure __msg("Possibly NULL pointer passed to trusted arg1")
+int xdp_lookup_null_bpf_tuple(struct xdp_md *ctx)
+{
+	struct bpf_ct_opts___local opts = {};
+	struct nf_conn *ct;
+
+	ct = bpf_xdp_ct_lookup(ctx, NULL, 0, &opts, sizeof(opts));
+	if (ct)
+		bpf_ct_release(ct);
+	return 0;
+}
+
+SEC("?xdp")
+__failure __msg("Possibly NULL pointer passed to trusted arg3")
+int xdp_lookup_null_bpf_opts(struct xdp_md *ctx)
+{
+	struct bpf_sock_tuple tup = {};
+	struct nf_conn *ct;
+
+	ct = bpf_xdp_ct_lookup(ctx, &tup, sizeof(tup.ipv4), NULL, sizeof(struct bpf_ct_opts___local));
+	if (ct)
+		bpf_ct_release(ct);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.34.1

