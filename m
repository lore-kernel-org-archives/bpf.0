Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB773D6480
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661063; cv=none; b=dc9ifB3ljhpdM5AjeTX75Lm78Sl1K73eK9sfjQz/AoQsfZVmuZPAV4YQSJrMropEhMQCaClU41OFV3YItvlcBOIq7YLR0vpqA+Ji7hP8xI9aCSgI/J7lgo0+n7w2oshiettA6npm9S/J/VgUM/WDSax6NUWziJKITVa0MuAwfs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661063; c=relaxed/simple;
	bh=adRJiHwOqP/ltVDAy9gbinAYl1/6i3PBju1rI60ghLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oOuM/HunWF9SZ4k7M/cYi6Se2G6PCP1tM883b+B3M2fpl6PyfaKjLiP9N0prpQ51l6P/k0vhtpk2QxbegERwEYZGq1iuepWwFzOaDg+TVwW1S/n0O1/4Or59WVuBH6bkVkVyF7sbkplmIfpYbc4VrIRbabfZvnjv5gGvnLgcrPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYTLZ4Iv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYTLZ4Iv"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-483487335c2so66342425e9.2
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 08:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775661060; x=1776265860; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o6mZoVKcqsIAGEBEx6a745+5udMmEH6W//yGpnobMCM=;
        b=MYTLZ4IvMe33c1BeFJLND+4nwaG7THOUJHa6odikNW6412TcV7diVX17JSC5ms0RAi
         p7La6JwAXndFChjL3ensMKN50TnL64IvpPlObGhDnUpBJhwL41Kcc7k+p7+KsBdNEXgY
         De9aKvySYUK3eMHMd2AHIULPV3WLdxjF2YrFs8VjajQk61upD/THJHIZeJWMmOLYk49x
         c1cVqwEYMQ3rD1RwxEsRcm38bE33s9a0prh7+Q+XK59ojjZ3lUcOfbU4EyCHphtTaN9k
         r4RzDeDHDDsbAHPstkV6Low1saYlFHBej7sNGlvGYr7KucjSynsWIoyIh159/ycULVVF
         jJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661060; x=1776265860;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o6mZoVKcqsIAGEBEx6a745+5udMmEH6W//yGpnobMCM=;
        b=MF97+nzf7xXGLY7QuG0stcHmWjpIYocufA399+pu5XsIqHmI/BE5lC/YAZedfmuxAY
         o376ReNUR8Jfknroy60o3G9G0/Mp+AtiAJkhR1oTzN6Rh6L0MJ3Rk4sBbnR4lChlbUN6
         TWk1YpNyydxZWv3jdr8WHKGEtLpxsdbsgmUi/amb4Er+ZVkVvptxDMRJVc0QZ7ZBB6cW
         YPtZeu+nivR7mPCTPiErHuw+rMPiRG5gOAJhQSSHRm7mpTSZAGQvVkWpNax85rNBMwFl
         S4QVGpYRG7sHF9shP8qq27oRJsz+iUbxUDdt9GeXzzKVqItXOPoAL4ujGp0M5Nu96FBr
         j3fg==
X-Gm-Message-State: AOJu0YwYY2Ikp/zfOv0jHOW5idoKGXz4vh3BzxE2uoypjqewCixKm72t
	OrGta9/nv/2lK8uV0paAlI3PFWPTAmHxEPjNhHQDgXYmadwY3o82fwSL
X-Gm-Gg: AeBDietfZtsDTjYvOlyfPmqC1ag4pQSySPZFqFonVpd4LNfstqrMn0C7vUOLw3SIUHw
	jcv+1Qgf4zEJDoSBZQzsoSrE880Vj41IymLN8QjOlvXGhGRPjf4GyC5yTCwmXGecIEqZaNUATjQ
	T4xttEuU9+UcmS77+AmIbOUvPVH0L4/e5YlGh6ldp3quy+TXP2UGHP5iZ/bCIEKUBfmydf6GlKd
	s5k6o6E6Temz+J8Es1hx28nGTgdxPXIBiwaoaTGffcspiG//kpvOkdvxmlAt877N8L0Rgu5vXOu
	G8erYFwJW1xp1HAJKKem6ILkmTzwsAhWW1XAA3rA+BJhFEZd9P3L7VY4iOFj5Tbu7FNi69GDh1F
	p5lb8eocT9ItsHPnQ3jUG7ErnFa5uvKp09SXNLtKjXLhWHN2jQLwNqDA/CopWDS56SFqaa5PSlO
	p48zq9STkBif9o
X-Received: by 2002:a05:600c:154b:b0:488:af14:f1de with SMTP id 5b1f17b1804b1-488af14f35fmr178553045e9.4.1775661060246;
        Wed, 08 Apr 2026 08:11:00 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c5dc7153sm29657915e9.8.2026.04.08.08.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:10:59 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 08 Apr 2026 08:10:21 -0700
Subject: [PATCH RFC bpf-next v2 16/18] selftests/bpf: Add BPF iterator
 tests for resizable hash map
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-rhash-v2-16-3b3675da1f6e@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775661029; l=8060;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=lV9+JoGZzdIIo6HZypF749rqOaRa/RvNbqW72A5WP8M=;
 b=ELL7rUryZ5Tjk8Rf5PFlhSHvSoD0AWn0NnIov2okQUSnz2t7mPelCRkrTRdj4KFMcBC9nh6SO
 CkZLYHLZN55BOvl2lbo5v6I2b8+iBWWaRsMDga+Q/ZLB07f0kM0jACX
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Test BPF iterator functionality for BPF_MAP_TYPE_RHASH:
 * Basic iteration verifying all elements are visited
 * Overflow test triggering seq_file restart, validating correct
resume behavior via skip_elems tracking

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/prog_tests/rhash.c     | 160 ++++++++++++++++++++-
 .../selftests/bpf/progs/bpf_iter_bpf_rhash_map.c   |  75 ++++++++++
 2 files changed, 234 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/rhash.c b/tools/testing/selftests/bpf/prog_tests/rhash.c
index 53ccc9366b5a..f28296b16593 100644
--- a/tools/testing/selftests/bpf/prog_tests/rhash.c
+++ b/tools/testing/selftests/bpf/prog_tests/rhash.c
@@ -4,6 +4,7 @@
 #include <string.h>
 #include <stdio.h>
 #include "rhash.skel.h"
+#include "bpf_iter_bpf_rhash_map.skel.h"
 #include <linux/bpf.h>
 #include <linux/perf_event.h>
 #include <sys/syscall.h>
@@ -309,6 +310,158 @@ static void rhash_get_next_key_resize_test(void)
 	rhash__destroy(skel);
 }
 
+static void rhash_iter_test(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	struct bpf_iter_bpf_rhash_map *skel;
+	int err, i, len, map_fd, iter_fd;
+	union bpf_iter_link_info linfo;
+	u32 expected_key_sum = 0, key;
+	struct bpf_link *link;
+	u64 val = 0;
+	char buf[64];
+
+	skel = bpf_iter_bpf_rhash_map__open();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_rhash_map__open"))
+		return;
+
+	err = bpf_iter_bpf_rhash_map__load(skel);
+	if (!ASSERT_OK(err, "bpf_iter_bpf_rhash_map__load"))
+		goto out;
+
+	map_fd = bpf_map__fd(skel->maps.rhashmap);
+
+	/* Populate map with test data */
+	for (i = 0; i < 64; i++) {
+		key = i + 1;
+		expected_key_sum += key;
+
+		err = bpf_map_update_elem(map_fd, &key, &val, BPF_NOEXIST);
+		if (!ASSERT_OK(err, "map_update"))
+			goto out;
+	}
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.map.map_fd = map_fd;
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+
+	link = bpf_program__attach_iter(skel->progs.dump_bpf_rhash_map, &opts);
+	if (!ASSERT_OK_PTR(link, "attach_iter"))
+		goto out;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
+		goto free_link;
+
+	do {
+		len = read(iter_fd, buf, sizeof(buf));
+	} while (len > 0);
+
+	ASSERT_EQ(skel->bss->key_sum, expected_key_sum, "key_sum");
+	ASSERT_EQ(skel->bss->elem_count, 64, "elem_count");
+
+	close(iter_fd);
+
+free_link:
+	bpf_link__destroy(link);
+out:
+	bpf_iter_bpf_rhash_map__destroy(skel);
+}
+
+/*
+ * Test seq_file overflow handling for BPF iterator over resizable hashmap.
+ *
+ * The BPF program writes print_count * 8 bytes per element, configured so
+ * that a single element's output nearly fills the seq_file buffer (8 pages).
+ * With multiple elements, the buffer overflows mid-element, triggering
+ * seq_file's restart mechanism: it discards the partial output, enlarges or
+ * flushes the buffer, and re-invokes the BPF program starting from the
+ * element that caused the overflow.
+ *
+ * Insert few elements to avoid triggering rhashtable resize, then verify:
+ * - All elements are seen (unique_elem_count == num_elems)
+ * - Overflow occurred (total_visits > unique_elem_count)
+ * - Output is consistent (each chunk of print_count u64s has the same value)
+ */
+static void rhash_iter_overflow_test(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	struct bpf_iter_bpf_rhash_map *skel;
+	u32 total_read_len, expected_read_len, write_len, num_elems = 4;
+	int err, i, j, len, map_fd, iter_fd;
+	union bpf_iter_link_info linfo;
+	struct bpf_link *link;
+	char *buf;
+
+	skel = bpf_iter_bpf_rhash_map__open();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_rhash_map__open"))
+		return;
+
+	write_len = sysconf(_SC_PAGE_SIZE) * 8;
+	skel->bss->print_count = (write_len - 8) / 8;
+	expected_read_len = num_elems * (write_len - 8);
+
+	err = bpf_iter_bpf_rhash_map__load(skel);
+	if (!ASSERT_OK(err, "bpf_iter_bpf_rhash_map__load"))
+		goto out;
+
+	map_fd = bpf_map__fd(skel->maps.rhashmap);
+
+	for (i = 0; i < num_elems; i++) {
+		__u64 val = i;
+
+		err = bpf_map_update_elem(map_fd, &i, &val, BPF_NOEXIST);
+		if (!ASSERT_OK(err, "map_update"))
+			goto out;
+	}
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.map.map_fd = map_fd;
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+
+	link = bpf_program__attach_iter(skel->progs.dump_bpf_rhash_map_overflow, &opts);
+	if (!ASSERT_OK_PTR(link, "attach_iter"))
+		goto out;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
+		goto free_link;
+
+	buf = malloc(expected_read_len);
+	if (!ASSERT_OK_PTR(buf, "malloc"))
+		goto close_iter;
+
+	total_read_len = 0;
+	while ((len = read(iter_fd, buf + total_read_len,
+			   expected_read_len - total_read_len)) > 0)
+		total_read_len += len;
+
+	ASSERT_OK(len, "len");
+	ASSERT_EQ(total_read_len, expected_read_len, "total_read_len");
+	ASSERT_EQ(skel->bss->unique_elem_count, num_elems, "unique_elem_count");
+	ASSERT_GT(skel->bss->total_visits, skel->bss->unique_elem_count,
+		  "overflow_occurred");
+
+	/* Verify each output chunk is internally consistent */
+	for (i = 0; i < num_elems; i++) {
+		__u64 *val = ((__u64 *)buf) + i * skel->bss->print_count;
+
+		ASSERT_LT(val[0], num_elems, "value_in_range");
+		for (j = 1; j < skel->bss->print_count; j++)
+			ASSERT_EQ(val[j], val[0], "consistent_value");
+	}
+
+	free(buf);
+close_iter:
+	close(iter_fd);
+free_link:
+	bpf_link__destroy(link);
+out:
+	bpf_iter_bpf_rhash_map__destroy(skel);
+}
+
 void test_rhash(void)
 {
 	if (test__start_subtest("test_rhash_lookup_update"))
@@ -340,5 +493,10 @@ void test_rhash(void)
 
 	if (test__start_subtest("test_rhash_get_next_key_stress"))
 		rhash_get_next_key_stress_test();
-}
 
+	if (test__start_subtest("test_rhash_iter"))
+		rhash_iter_test();
+
+	if (test__start_subtest("test_rhash_iter_overflow"))
+		rhash_iter_overflow_test();
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_rhash_map.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_rhash_map.c
new file mode 100644
index 000000000000..30c270f12b61
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_rhash_map.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RHASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, 64);
+	__type(key, __u32);
+	__type(value, __u64);
+} rhashmap SEC(".maps");
+
+__u32 key_sum = 0;
+__u64 val_sum = 0;
+__u32 elem_count = 0;
+__u32 err = 0;
+
+SEC("iter/bpf_map_elem")
+int dump_bpf_rhash_map(struct bpf_iter__bpf_map_elem *ctx)
+{
+	__u32 *key = ctx->key;
+	__u64 *val = ctx->value;
+
+	if (!key || !val)
+		return 0;
+
+	key_sum += *key;
+	val_sum += *val;
+	elem_count++;
+	return 0;
+}
+
+/* For overflow test: configurable print count */
+__u32 print_count = 0;
+
+__u64 seen_keys = 0;
+__u32 unique_elem_count = 0;
+__u32 total_visits = 0;
+
+SEC("iter/bpf_map_elem")
+int dump_bpf_rhash_map_overflow(struct bpf_iter__bpf_map_elem *ctx)
+{
+	struct seq_file *seq = ctx->meta->seq;
+	__u32 *key = ctx->key;
+	__u64 *val = ctx->value;
+	__u64 bit;
+	__u32 i;
+
+	if (!key || !val)
+		return 0; /* The end of iteration */
+
+	total_visits++;
+
+	/* Validate key value are as expected */
+	if (*key != *val || *key > 64) {
+		err = 1;
+		return 0;
+	}
+
+	bit = 1ULL << *key;
+	if (!(seen_keys & bit))
+		unique_elem_count++;
+	seen_keys |= bit;
+
+	/* Write print_count * 8 bytes to potentially overflow buffer */
+	bpf_for(i, 0, print_count) {
+		if (bpf_seq_write(seq, val, sizeof(__u64)))
+			return 0;
+	}
+
+	return 0;
+}

-- 
2.52.0

