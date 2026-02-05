Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96A232C316
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 20:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770323240; cv=none; b=dAQFN3wqQmkDxlQoE9u0VN+42cpfHOZ1H8GkkJNl0kjqHk/vAsJR37DkqClFxnI6E9Z7q7YXQBRnXsl+myTFECbZEu+C64M+VS/pgcmNbJeoR3ojXg27akHjIsg8CGw8WA+BQ7JbWC1o/nShA7W7KiTnC2maWDt2o8Q0fj1AxPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770323240; c=relaxed/simple;
	bh=EawU7E85hyQKnDsSsnAlVae/EIZGOBjtAsn3UT3imPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kQlp51z3ctMM1oeLDkLCfPKUgEHxL3kF6zHYvJ15TxxT8FJnvIgu3XNc6OaNipjYwn8ogUNO0FfmeiJpzROjmsWDkSGhqBkiIu2wSajSelqD04kN9pZTE6tSzQY5PF+GoCUXcLaTy9TTJ5nds7/0ITSZcY/4B2ZILfL//1miFHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KD0ew9M8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KD0ew9M8"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-482f2599980so15934295e9.0
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 12:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770323238; x=1770928038; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NhtMWfffRJqUdF6LokCsrkYymnt1gXV5MfKG8KtoDhY=;
        b=KD0ew9M84EMQNzJ7rzjsevMFeg76SKekGA+L+X9dJih0qDql0yt/9CK5tkg7ICa2gV
         hE8GxGsrZkfGi+KGKlYxWyvv0zc+HLTJ55U6VuA8h3/1ZcxiBdpFKpLRVQURtwZvTvpO
         Kec+NNoe5LXwBpb1jDeB4ybe9Yr+k2ZVdEPwZv58fa2RtMzRtJ3neCTQQd/UJM2+wty/
         QdpHlEeNuZcKZKmIHp1b2/sddqZFRvlJT0A/hWPh8JNEozCxRV8zm9Zo59CQ8MaqB/Nh
         V6Awes2Oa5xtbm02+Cfy9v2SPeoCFWPOA3Y4GD4h/twEcLqcl1dB4LrEyMpJ/5iMiqhf
         4Qhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770323238; x=1770928038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NhtMWfffRJqUdF6LokCsrkYymnt1gXV5MfKG8KtoDhY=;
        b=cXOeMxK00vwAiJXC/vGY2nXMvvpCClKi8ZrneYloL0a8HIqyVc6yaHUN1I/8oDtv07
         dYNza3yuKyfoHjepGVjYT4HAGIwh34YJR7tqOlB/RcbWKGfu8XRu1O7W3XquHlQnfVQU
         m8wf0DpaeHHdZ4c99C4x2drNGYizJ0dmSqIsS42uPBncowWH3VbcEztAQfVS93bPe3+n
         jGAyYGM2ZBrFjQ+uHLfserrjCkdhxMFK1kpkfJpreP7mCKSE1HVG1i6/n2CLFXTFiWhQ
         64iKaRZAYqTJmMXT17Vfmazg3g37y+oDbPIXb6TDz+RghUWVmJ6Q+O7z5m+9nAtaatlI
         QezQ==
X-Gm-Message-State: AOJu0Yy6iZd6VGF5SZ1msohDHm4UKA90cHD6jGLqE4wxm7cyPeJAXnDe
	3+tqyv1fHni4b3DhN4Cv5blzZsAW6Qrcii7cfMBc1H0hGYJ4PPzr9iHF
X-Gm-Gg: AZuq6aJZWjMBuT/fx2jyPlPOHTYv8UID6bZJ44sWvxyomQb+Ex496lnWjuP5j2IR7ub
	peOuVyVcpvxKar2mO/9vxNyHvCvXf/soUxdKKa6erF+F1uXZoaGdZJbLh9oxGvfg6nivs9SKvlq
	qoBScetUBLn+FzJE5Uiw68P5VcqtyahKHdaAXp2Y1kveVCrvm1HIq/3PFxY6eIt5n47PNeIxUKH
	ZZQfuKzCgxrGQwdNQMDkXuVsimGJVrHxSSo3QZNcoSkDstIUN6sAbbdDouNAWyZ59cOPj+uG6a0
	2S3J/bZKUgORSnovyb1IW3pWfGX+6DmAw/xYKcALPQfoRPBfKxBozCRdgYEe3it/prqTeFZbbdK
	t7YHQbmSG7esyOUWAuH3+W4p75zJW2Trwh/DzN7XvFUshVD60SH+zTVbj0MlPjdSNXk7XnuY=
X-Received: by 2002:a05:600c:8719:b0:482:eec4:76d with SMTP id 5b1f17b1804b1-4832021b461mr9492395e9.17.1770323238173;
        Thu, 05 Feb 2026 12:27:18 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::6:1325])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483203e37f9sm4235255e9.3.2026.02.05.12.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 12:27:16 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 05 Feb 2026 20:24:40 +0000
Subject: [PATCH RFC bpf-next 10/12] selftests/bpf: Add BPF iterator tests
 for resizable hash map
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-rhash-v1-10-30dd6d63c462@meta.com>
References: <20260205-rhash-v1-0-30dd6d63c462@meta.com>
In-Reply-To: <20260205-rhash-v1-0-30dd6d63c462@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com, memxor@gmail.com, 
 puranjay@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770323224; l=8242;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=ejinDW8MMgmtgwwOzAdrh2BwNdAQa3UKBa+36mpFm40=;
 b=jM22hC3mLwsoLGx/mnCVN8xdaWSMb8RsargYE/SlmYBRJ06R7mO95O2RtREpqtopUJqzbmOIu
 Y9TsWCd/vZJCskWWQsPBWtHCPIGnSGiNBAtZtplOXtID7DuTn8aFrLk
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Test BPF iterator functionality for BPF_MAP_TYPE_RHASH:
 * Basic iteration verifying all elements are visited
 * Overflow test triggering seq_file restart, validating correct
resume behavior via skip_elems tracking

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/prog_tests/rhash.c     | 168 +++++++++++++++++++++
 .../selftests/bpf/progs/bpf_iter_bpf_rhash_map.c   |  75 +++++++++
 2 files changed, 243 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/rhash.c b/tools/testing/selftests/bpf/prog_tests/rhash.c
index 689ba6d73a724e94c3845acaeca3c0a7b45a8c6d..ee8f4181d501df8d31223bff72d4e551a903de4d 100644
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
@@ -282,6 +283,167 @@ static void rhash_get_next_key_resize_test(void)
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
+static void rhash_iter_overflow_test(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	struct bpf_iter_bpf_rhash_map *skel;
+	u32 total_read_len, expected_read_len, write_len, num_elems = 64;
+	u64 seen_values = 0;
+	int err, i, j, len, map_fd, iter_fd;
+	union bpf_iter_link_info linfo;
+	struct bpf_link *link;
+	char *buf;
+
+	skel = bpf_iter_bpf_rhash_map__open();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_rhash_map__open"))
+		return;
+
+	/*
+	 * Configure print_count so that output for each element almost fills
+	 * the seq_file buffer (8 pages). With multiple elements, this will
+	 * trigger buffer overflow and restart.
+	 */
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
+	/* Populate map with test data */
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
+	/* Read all data - this should trigger multiple overflows/restarts */
+	total_read_len = 0;
+	while ((len = read(iter_fd, buf + total_read_len, expected_read_len - total_read_len)) > 0)
+		total_read_len += len;
+
+	ASSERT_OK(err, "err");
+	ASSERT_EQ(total_read_len, expected_read_len, "total_read_len");
+	ASSERT_EQ(skel->bss->unique_elem_count, num_elems, "unique_elem_count");
+
+	/*
+	 * Verify overflow actually happened: if total_visits > unique_elem_count,
+	 * some elements were visited multiple times due to seq_file restart.
+	 */
+	ASSERT_GT(skel->bss->total_visits, skel->bss->unique_elem_count, "overflow_occurred");
+
+	/*
+	 * Verify:
+	 * 1. Each chunk of print_count size has same values
+	 * 2. All values 0 to num_elems-1 appear exactly once
+	 */
+	for (i = 0; i < num_elems; i++) {
+		__u64 *val = ((__u64 *)buf) + i * skel->bss->print_count;
+
+		ASSERT_GE(val[0], 0, "value_greater_or_eq_zero");
+		ASSERT_LT(val[0], num_elems, "value_in_range");
+
+		/* Verify all copies in this chunk are consistent */
+		for (j = 1; j < skel->bss->print_count; j++)
+			ASSERT_EQ(val[0], val[j], "consistent_value");
+
+		/* Track which values we've seen */
+		seen_values |= (1ULL << val[0]);
+	}
+
+	/* Verify all values 0 to num_elems-1 were present */
+	ASSERT_EQ(seen_values, ~0ULL, "all_values_seen");
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
@@ -313,5 +475,11 @@ void test_rhash(void)
 
 	if (test__start_subtest("test_rhash_get_next_key_stress"))
 		rhash_get_next_key_stress_test();
+
+	if (test__start_subtest("test_rhash_iter"))
+		rhash_iter_test();
+
+	if (test__start_subtest("test_rhash_iter_overflow"))
+		rhash_iter_overflow_test();
 }
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_rhash_map.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_rhash_map.c
new file mode 100644
index 0000000000000000000000000000000000000000..2de69f983a1bd04993339c2a565b9d940043c37c
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
+	if (*key != *val || *key < 0 || *key > 64) {
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
+			return 1;
+	}
+
+	return 0;
+}

-- 
2.53.0

