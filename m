Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEE53E00A5
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 08:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695278; cv=none; b=QLawQzuhhWcG3ue8keUuxZAoxodlAFH6LTwRfW/SfW+4sJM51FzrVbFJ5cgBiRa6iT15ohlCNrvWUDN/am23uiUnnfoEwqR4OW0yHCVxQCrXrHF64sXQO6hQTg3fez/WU77I7RQKBUBdqZF4ISYT4iN+XiVdJqjHXDlRyQn6uAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695278; c=relaxed/simple;
	bh=/J332EeJYLuC9m8B8o04gA91qv92JqziFFssOEhFIug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oaGsQElo7rMJ1v7nuQqmEZ+yBFrU+654F6hrm7BshL52Zl1IqNr7XDwwb7j3OOkv9Bvjpheuw9//AWcvLjWJk1ZqOvJMee2CVuJt6oekdSbxJCTPdYvaOdISlCSdtRP17UZ9vYqJNzeVzNakew59Fmb3npq0+MSo+hVAuOnir0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TzB035KB; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TzB035KB"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69fab5a852cso1013105a12.0
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 01:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1786695269; x=1787300069; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kVVKaypj61/518TezP7ZXszMm8uMqourNLQ+zMwhym0=;
        b=TzB035KBZ8eFR3RFrL3CgxIC+WJUoZvutxq9l53sVxQME0I8/hfAK30h+Xi1UyVuob
         sqLFAUzquaz6wrWXrj0W0gHNKEnxk0v0wPsGBmMGJnO7VPqyT/Yc5hrodqIJ/Qg7iAjL
         wNFHrVBsoHZDa6Gr1wKpzbsF08P4i2xWOFxdrozV9K6qihVGlx58ZYY7tESEW3hNV2cz
         IInfs9PVXTGUVY/i2nsUuMoXu7cuZkTyc40shR9I7bUL4wfMHBXq79UGLmUXT3/lMjhj
         KgbX1qoFTkDCWi0clBAg+trKlu8ebe/8CFIZwMt6b0n2iqW4806IAt92++hTGTKk0hKt
         gnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786695269; x=1787300069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kVVKaypj61/518TezP7ZXszMm8uMqourNLQ+zMwhym0=;
        b=hsHu4bWYTic+1LRvBZjH8rBNDKCuCNe5KBRxriBGmphiWo+cVLMzxJKxDh8MtnlF5N
         HeTerb/pe2moyL8w3k3aoh1dZ8X6H942taDhxNVTWXlXR24ArqqciUxHcVxzYzKt1D6H
         hisjaD4T4VIEY0Ikm+1ONIA8sWA/D5b4Or6Y5+kYEFa3ltOxLP6bk4dbiEtTwZnLaC1k
         v8nMDr2iOvMO7Njl6dh6Vn5H/J3plXkpnabazBY2OnJOc0/TTGHokz4403kagxYZrDw4
         iiG6a76Ci/QxkPUtIg3RK/COzpHqvojlMr6V62Z3yZk3DUCEtOo9yXBF7ikCa7UxtekV
         Lx6g==
X-Gm-Message-State: AOJu0Yyh9VJ5eHrFaLPCQ7DBQpIDamRxCF6c53c2pVnug8lP7vcQ79tQ
	03nXRpcg500V3HCJFR7uOs1u3hrcny50Oree6IuQ/imMiZpm85TwV2q9JZ96V/AaVLk=
X-Gm-Gg: AR+sD13Rmd+SpgDkHWKFYRwaKp1KISlDRUDAlYx6Wf1/0VpgZp2jTtBGNRzPFhlLHm5
	VD9SjQOj6mousJpGKW9CNTMtymM3Buke0C3tYJJjd60ko6SrWBRpOCFGRoCFM0ZDy6glvPARSuL
	eQ+FF1fChIGX0CBBl73fKCX/+rT9xAWNgOxENidDhdrXXRcq24cImT2AJirDUMXh+pfEQL07wN4
	w+TCOjBiGlH/haiuwwqqN8hWsFFfs6fHhqJJajrzcuFkqrJ9hKDwZ/OkRb6fhRHEZ6aV5SSy4wD
	ModaFvwIc2Ct0NDiRukGgSdKrkkmHjJcBGApkQy576XTwA1wQaNckRQ7ejlL5R45diYRqEEge/+
	u5lLq8UU4uvQPr0RK48q6ivxsbh4Sk3bSmP9R3DDTIOANaZdE4ymcBvaZXG0tzzcL+u/XD0c+82
	eM69WWZGQQqh3WY0K5vvITYoQNjyu6yCTTK26ZTyCz1VqptvVgUNKrE9pXD5YyrcAODtDdQi3pt
	BrJImLeSv2q3AGSR6yGeQn1e4TmqYuQZRTcUA==
X-Received: by 2002:a05:6402:e9b:b0:6a1:28d8:2306 with SMTP id 4fb4d7f45d1cf-6a38a91250cmr1848589a12.1.1786695269347;
        Fri, 14 Aug 2026 01:14:29 -0700 (PDT)
Received: from cloudflare.com (79.184.184.176.ipv4.supernova.orange.pl. [79.184.184.176])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a38d78bf12sm439695a12.25.2026.08.14.01.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:14:28 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 14 Aug 2026 10:14:05 +0200
Subject: [PATCH net-next 04/14] selftests/bpf: Add tests for
 bpf_dynptr_from_skb_ext
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-bpf-meta-inside-skb-ext-v1-4-767edd862656@cloudflare.com>
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

Cover the bpf_dynptr_from_skb_ext() kfunc and the dynptr interface
to skb_ext with TC-to-TC tests on a tuntap device:

- write/read via bpf_dynptr_read and bpf_dynptr_write
- write/read via bpf_dynptr_slice and bpf_dynptr_slice_rdwr
- clone read via bpf_dynptr_clone
- error paths: no allocation without F_CREATE, invalid flags, read-only
  enforcement without F_CREATE
- double allocation: data from first alloc survives second skb_ext_add

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/config                 |   1 +
 .../bpf/prog_tests/xdp_context_test_run.c          |  52 ++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 185 +++++++++++++++++++++
 3 files changed, 238 insertions(+)

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
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 448807676176..fd340e5538a3 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -693,3 +693,55 @@ void test_xdp_context_lwt_encap(void)
 
 	test_xdp_meta__destroy(skel);
 }
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
+		test_tuntap(NULL, /* xdp */
+			    skel->progs.tc_skb_ext_write,
+			    skel->progs.tc_skb_ext_read,
+			    &skel->bss->test_pass);
+	if (test__start_subtest("tc_write_clone_read"))
+		test_tuntap(NULL, /* xdp */
+			    skel->progs.tc_skb_ext_write,
+			    skel->progs.tc_skb_ext_clone_read,
+			    &skel->bss->test_pass);
+	if (test__start_subtest("tc_write_slice_read"))
+		test_tuntap(NULL, /* xdp */
+			    skel->progs.tc_skb_ext_write,
+			    skel->progs.tc_skb_ext_slice_read,
+			    &skel->bss->test_pass);
+	if (test__start_subtest("tc_slice_write_read"))
+		test_tuntap(NULL, /* xdp */
+			    skel->progs.tc_skb_ext_slice_write,
+			    skel->progs.tc_skb_ext_read,
+			    &skel->bss->test_pass);
+	if (test__start_subtest("tc_no_alloc"))
+		test_tuntap(NULL, /* xdp */
+			    skel->progs.tc_skb_ext_no_alloc,
+			    NULL, /* tc prio 2 */
+			    &skel->bss->test_pass);
+	if (test__start_subtest("tc_invalid_flags"))
+		test_tuntap(NULL, /* xdp */
+			    skel->progs.tc_skb_ext_invalid_flags,
+			    NULL, /* tc prio 2 */
+			    &skel->bss->test_pass);
+	if (test__start_subtest("tc_rdonly"))
+		test_tuntap(NULL, /* xdp */
+			    skel->progs.tc_skb_ext_rdonly,
+			    NULL, /* tc prio 2 */
+			    &skel->bss->test_pass);
+	if (test__start_subtest("tc_double_alloc"))
+		test_tuntap(NULL, /* xdp */
+			    skel->progs.tc_skb_ext_double_alloc,
+			    NULL, /* tc prio 2 */
+			    &skel->bss->test_pass);
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

-- 
2.43.0

