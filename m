Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3807A477E21
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140400; cv=none; b=WwvwHAaUmiuw/U7TKSuWaAtjrzxoJH+Lp24fzzEp8Aa+lHYO4j26iLGIkv+03JZCLUXjmBt4juqJ3aqFyP2DOKHVFEchyNj8bD1cDVYcqL9DJczxFH/Tb2SyzwRM2PaBUXn9OcXopKIw36ItWfOhSYo3X8kUnzb4hfkGIXGmKTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140400; c=relaxed/simple;
	bh=OTVrss/3LRtGekr0mBxcD67LyIqn8V5WW0W6TUG4yMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uTC68zq6gfgzGcE6yKPn119TV3u7qc0npiwO/jA5imCPsic+Jryj1gESqAd2KrAYOoyu0JCzJBbvleUaEorb5DgEiQzjg1ZEhT6tfIHu3FX1tL6SUnRqTvLChhs57kyFIUJdqQk5j69x30oVIEV+bebrJDmvmxyTtA4x+7eaF8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HSbXyZrf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HSbXyZrf"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4833115090dso13633065e9.3
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 13:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772140394; x=1772745194; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iTw2TYqUyjwBZ4ECkQKNX4mXfjOM8iHHwzNAybhskVg=;
        b=HSbXyZrfJaa5wQVdaiWanIscUdCD0E+qrTCeldlUaxhaDgxLa0XagpKRjKW5i7BV3U
         X9bksb7vmkeusYJe3AhCWeatK2lZwAM3vPiMvnghpZwLx1afDkLuCxwEGtEk1DwBVc5U
         fLt3qs9R2DjArDSjtGb9SPoPn/s9C7JSJBM+tqfHEI5ind77oIY9ekO6edYLMj8ISiNP
         eUG9rffy/aSoiO5HUsQYMdQR2A5v6NeEN/CpQon2nxbfKgoBxJo0QmRkidhdkdvT3Gsc
         XAqU4TJ99sOWPNMj3MQZiGDZKIGhzeKRiMkjSoJTqK5XjfU+b3I+NWSUSH6ibYYIMMNw
         MkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772140394; x=1772745194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iTw2TYqUyjwBZ4ECkQKNX4mXfjOM8iHHwzNAybhskVg=;
        b=DGDDzSRBr/HGG6tCnsCOYRttteddQg7ZEhtvDvEkZe2ZwoEpw5qXHfbzspge6nWwtd
         /4CrdFEWsoq5Pe9SCvlVeNKLt44d8ciFW6KQD19IEBSAiDSZBT/3JyYgMVR1xd973pYF
         yqHc5qHujPMkHkSoPRE6pfJHy6xKLw6gFm0GrsPRR5yDHdpkD6+XPw87wSg4BZSyp1EG
         dQaFqboYdzUqFoYjpOB6jDcjzq8a3+8bWH+vac3m9Xk7w+v1N4/VF81UDlx3mHZ3afq1
         bJrXKffUUvXohnSnXfXnEZCQJEmEcNVhCX/x2LDGEDSUuY5TszJxcqkF4zamx2Ge+Cfn
         0tbw==
X-Gm-Message-State: AOJu0YwD6u4Rx+UXJltZXuLJX4MuIqSYZb7p6BshmIfDTFGtX5dZGQN+
	M7nyuuhuwKV2DEr4yXYBRLXy+ygayQVhVmUGlQSl2Th5lTWfOeCFmSwSk5uz+GFTKKg=
X-Gm-Gg: ATEYQzxpNvrwLpr+a9Ja8iTBjOg8zFfdqII4LyIYQp4qa8bT3HMs3/r7CkO/rUiD++u
	G3VsyG8Ekw02JOQ8RsMRsaXm6uh30X1Iy4+WsFPixDH6wz3d3h6ruik3RyiB2SsL9MmXJX9rfDX
	dApOom72C0uhC+eNBy89u/Zf1GTAKxju8E8OZp/eTvQGKeHs95NoH9J5qwT6CL8XxIluJQmAfBP
	TZzUJNa4vm1tu7x/J/jFJXXyz+OFHrtcLoFdKkkxG0uqU4IJeTGCuYu/Ie2z6z//ZHiE7ZlN/Cv
	ZWbAd7L7msQ/kgCwgsEcugLsZdawAgotjEve4Ky87YZc0521mwQ09tYm55vDOg+/FaDMUGGvlO2
	0CWEcxfh5eHQtWIvSf836qfEZTS23gmT6Ew0+wNB5Jf8aBBczTWAdDY989rJUWqbjtlbgiXDwL5
	cD1KiicG2zib71agHaQKfhQLW6Qql2zSdUxPNFqPmJx6N3fW1xFznisLdN7ZC3aghI9tD1
X-Received: by 2002:a05:600c:3486:b0:480:3a72:524a with SMTP id 5b1f17b1804b1-483c9bed89emr3796995e9.19.1772140394248;
        Thu, 26 Feb 2026 13:13:14 -0800 (PST)
Received: from cloudflare.com (79.184.124.63.ipv4.supernova.orange.pl. [79.184.124.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfccff00sm46083465e9.25.2026.02.26.13.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:13:13 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 26 Feb 2026 22:12:55 +0100
Subject: [PATCH RFC bpf-next 4/5] selftests/bpf: Add verifier tests for skb
 local storage
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-skb-local-storage-v1-4-4ca44f0dd9d1@cloudflare.com>
References: <20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com>
In-Reply-To: <20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Cover verifier checks for the bpf_skb_storage_get and
bpf_skb_storage_delete kfuncs.

Negative tests verify argument validation:
- not_a_map_on_{get,delete}: a non-map pointer as the first argument is
  rejected
- wrong_map_type_on_{get,delete}: passing a BPF_MAP_TYPE_HASH map instead
  of BPF_MAP_TYPE_SKB_STORAGE is rejected

Positive tests verify the kfuncs are callable from all registered program
types: socket filter, TC classifier, TC action, cgroup skb, sock_ops,
sk_skb, LWT (in/out/xmit/seg6local), netfilter, struct_ops, LSM, and raw
tracepoint.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../selftests/bpf/progs/verifier_skb_storage.c     | 209 +++++++++++++++++++++
 2 files changed, 211 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 8cdfd74c95d7..c82e0d48ba34 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -114,6 +114,7 @@
 #include "verifier_bits_iter.skel.h"
 #include "verifier_lsm.skel.h"
 #include "verifier_jit_inline.skel.h"
+#include "verifier_skb_storage.skel.h"
 #include "irq.skel.h"
 
 #define MAX_ENTRIES 11
@@ -259,6 +260,7 @@ void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
 void test_irq(void)			      { RUN(irq); }
 void test_verifier_mtu(void)		      { RUN(verifier_mtu); }
 void test_verifier_jit_inline(void)               { RUN(verifier_jit_inline); }
+void test_verifier_skb_storage(void)	      { RUN(verifier_skb_storage); }
 
 static int init_test_val_map(struct bpf_object *obj, char *map_name)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_skb_storage.c b/tools/testing/selftests/bpf/progs/verifier_skb_storage.c
new file mode 100644
index 000000000000..cd4d817232de
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_skb_storage.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Cloudflare, Inc. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, int);
+	__type(value, int);
+	__uint(max_entries, 1);
+} hash_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SKB_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, int);
+} storage_map SEC(".maps");
+
+SEC("socket")
+__failure __msg("pointer in R1 isn't map pointer")
+int not_a_map_on_get(struct __sk_buff *ctx)
+{
+	(void)bpf_skb_storage_get((void *)ctx, (void *)&storage_map, NULL, 0, 0);
+	return 0;
+}
+
+SEC("socket")
+__failure __msg("pointer in R1 isn't map pointer")
+int not_a_map_on_delete(struct __sk_buff *ctx)
+{
+	(void)bpf_skb_storage_get((void *)ctx, (void *)&storage_map, NULL, 0, 0);
+	return 0;
+}
+
+SEC("socket")
+__failure __msg("cannot pass map_type 1 into func bpf_skb_storage_get")
+int wrong_map_type_on_get(struct __sk_buff *ctx)
+{
+	(void)bpf_skb_storage_get((struct bpf_map *)&hash_map,
+				  bpf_cast_to_kern_ctx(ctx), NULL, 0, 0);
+	return 0;
+}
+
+SEC("socket")
+__failure __msg("cannot pass map_type 1 into func bpf_skb_storage_delete")
+int wrong_map_type_on_delete(struct __sk_buff *ctx)
+{
+	(void)bpf_skb_storage_delete((struct bpf_map *)&hash_map,
+				     bpf_cast_to_kern_ctx(ctx));
+	return 0;
+}
+
+static __always_inline int call_skb_storage_kfuncs(struct sk_buff *skb)
+{
+	struct bpf_map *map = (typeof(map))&storage_map;
+
+	(void)bpf_skb_storage_get(map, skb, NULL, 0, 0);
+	(void)bpf_skb_storage_delete(map, skb);
+	return 0;
+}
+
+SEC("socket")
+__success
+int access_socket_prog(struct __sk_buff *ctx)
+{
+	return call_skb_storage_kfuncs(bpf_cast_to_kern_ctx(ctx));
+}
+
+SEC("classifier")
+__success
+int access_tc_cls_prog(struct __sk_buff *ctx)
+{
+	return call_skb_storage_kfuncs(bpf_cast_to_kern_ctx(ctx));
+}
+
+SEC("action")
+__success
+int access_tc_act_prog(struct __sk_buff *ctx)
+{
+	return call_skb_storage_kfuncs(bpf_cast_to_kern_ctx(ctx));
+}
+
+SEC("cgroup_skb/egress")
+__success
+int access_cgroup_skb_prog(struct __sk_buff *ctx)
+{
+	return call_skb_storage_kfuncs(bpf_cast_to_kern_ctx(ctx));
+}
+
+SEC("sockops")
+__success
+int access_sockops_prog(struct bpf_sock_ops *ctx)
+{
+	struct bpf_sock_ops_kern *kctx = bpf_cast_to_kern_ctx(ctx);
+	struct sk_buff *skb = kctx->skb;
+
+	return skb ? call_skb_storage_kfuncs(skb) : 0;
+}
+
+SEC("sk_skb")
+__success
+int access_sk_skb_prog(struct __sk_buff *ctx)
+{
+	return call_skb_storage_kfuncs(bpf_cast_to_kern_ctx(ctx));
+}
+
+SEC("lwt_in")
+__success
+int access_lwt_in_prog(struct __sk_buff *ctx)
+{
+	return call_skb_storage_kfuncs(bpf_cast_to_kern_ctx(ctx));
+}
+
+SEC("lwt_out")
+__success
+int access_lwt_out_prog(struct __sk_buff *ctx)
+{
+	return call_skb_storage_kfuncs(bpf_cast_to_kern_ctx(ctx));
+}
+
+SEC("lwt_seg6local")
+__success
+int access_lwt_seg6local_prog(struct __sk_buff *ctx)
+{
+	return call_skb_storage_kfuncs(bpf_cast_to_kern_ctx(ctx));
+}
+
+SEC("lwt_xmit")
+__success
+int access_lwt_xmit_prog(struct __sk_buff *ctx)
+{
+	return call_skb_storage_kfuncs(bpf_cast_to_kern_ctx(ctx));
+}
+
+SEC("netfilter")
+__success
+int access_netfilter_prog(struct bpf_nf_ctx *ctx)
+{
+	return call_skb_storage_kfuncs(ctx->skb);
+}
+
+SEC("struct_ops/bpf_fq_enqueue")
+__success
+int BPF_PROG(access_struct_ops_prog, struct sk_buff *skb, struct Qdisc *sch,
+	     struct bpf_sk_buff_ptr *to_free)
+{
+	call_skb_storage_kfuncs(skb);
+	bpf_qdisc_skb_drop(skb, to_free);
+	return 0;
+}
+
+SEC(".struct_ops")
+struct Qdisc_ops qdisc_ops = {
+	.enqueue   = (void *)access_struct_ops_prog,
+	.id        = "qdisc_ops",
+};
+
+SEC("lsm/inet_conn_established")
+__success
+int BPF_PROG(access_lsm_prog, struct sock *sk, struct sk_buff *skb)
+{
+	return call_skb_storage_kfuncs(skb);
+}
+
+SEC("tp_btf/kfree_skb")
+__success
+int BPF_PROG(access_tracing_raw_tp_prog, struct sk_buff *skb, void *location,
+	     enum skb_drop_reason reason)
+{
+	return call_skb_storage_kfuncs(skb);
+}
+
+SEC("sk_reuseport")
+__failure /* FIXME */
+int access_sk_reuseport_prog(struct sk_reuseport_md *ctx)
+{
+	struct sk_reuseport_kern *kctx = bpf_cast_to_kern_ctx(ctx);
+
+	return call_skb_storage_kfuncs(kctx->skb);
+}
+
+SEC("flow_dissector")
+__failure /* FIXME */
+int access_flow_dissector_prog(struct __sk_buff *ctx)
+{
+	return call_skb_storage_kfuncs(bpf_cast_to_kern_ctx(ctx));
+}
+
+SEC("lsm.s/inet_conn_established")
+__failure /* FIXME */
+int BPF_PROG(access_lsm_sleepable_prog, struct sock *sk, struct sk_buff *skb)
+{
+	return call_skb_storage_kfuncs(skb);
+}
+
+SEC("fentry/kfree_skb")
+__failure
+int BPF_PROG(access_tracing_fentry_prog, struct sk_buff *skb, void *location,
+	     enum skb_drop_reason reason)
+{
+	return call_skb_storage_kfuncs(skb);
+}

-- 
2.43.0

