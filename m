Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=63.250.43.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381535;
	b=bcwrz5F+eOfo8yipxZ59gfBf96OxUcmyWgr3kN7uveNksjHShwElZZ9bxYlWvUJZXhgw
	 n+YLtoBtvEKRdC0BagCIpze+nAY/D6uj8STfr4g6MuzfVkG3w2VlcZIpphShOJsB+RHBg
	 vDUc/Aa4Da3gag436/6zJcqUnA8ykcYmXhE9y80oWWn8cJWilCE1gk2sgG2rPif1gmwNH
	 /6QlwKmj8TIq5SPvQ7RcXPVJVSJFymLB4705Tgz+SN/TRLrMvaTTylyd7x6/d5kcZ1cXz
	 QTE9oSQ+UBj9iTGu8DUq8059rVDZEgIfcEgxFrUzzt2HdcdjfM+Jlf2ZgrglHEOVfZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381535;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Envelope-From;
	bh=EMmfAKLQ2BfEp4HyMuZRteUb3v2rw7IOp5ZRWVREA34=;
	b=IvDdd/ys7SdgHHAvMDHUtlG8ORai5OLxheLJBcbrai1QKLDS5uW6BfHSfvDy9hAcsIoW
	 Qxq8/9pVWFzhGnxYIJ3fNqIbFH0j59H/281fGMC57kL3zbLBYqhX8yQVg9ZzMAFjqCRY6
	 dvvhc81XmWjJDen7lU07rd871nzB3naj1xYMaqLo3eSwh9rLbPtCwgpNwD7BAYcFC3TzC
	 DPHCjO4+L2MUr0OgJlmv9K7BYBeha5E9a3aCwFLKmanbljNtjkmspb8pOKLvTsficWtHi
	 w9X49e2g+t5aZ738WB/ku2mDmFlb6eDz0Gm/TmNbG/n5m2UrWeO2SLWF8672BAlEsPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tychen.cc;
	spf=pass smtp.mailfrom=tychen.cc;
	dkim=pass header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=R65XYcpF;
	arc=none smtp.remote-ip=63.250.43.97
Received: from out-2uec-a97.jellyfish.systems (out-2uec-a97.jellyfish.systems [63.250.43.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA910606A327
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 07:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA910606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=R65XYcpF
Received: from fedora (unknown [151.145.76.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jPZcw5L1lz6tkK;
	Wed, 11 Nov 2026 07:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1794381525;
	bh=EMmfAKLQ2BfEp4HyMuZRteUb3v2rw7IOp5ZRWVREA34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R65XYcpFN7mttIaVZueV0qINatWZBsxRT2QfM/So1T9toV6e+jtwQhIjL4s7X0qQu
	 T/11+jfkU4k6LeC29IBBdPgTRBZN6lwXu5tGy6SEiIDN70/pXtx72vkFjstpR7KsHs
	 NXNCIqPs9iL/CWMSfCijzOZFp5jsqKA4XHLqTsapEG5WYXLKLh8ReQjajuJhQsJxGD
	 W6o7JdsbEdMve2dY1a+sWeWJEe/hgKXMOG0Qy1CcP3GvzOQsu/Tdes2qAZASey0qpN
	 EpLy+vqfWgvSV2P9+D1gdQfC45UTuEFZr1VpE/DetK0/zW/Fx90B/KL0SRF0hUxxwf
	 PPzG7vi6j10Sw==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: Tianyi Chen <hi@tychen.cc>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	yatsenko@meta.com
Subject: [PATCH bpf v2 2/2] selftests/bpf: Cover RHASH batch cursor loss
Date: Wed, 11 Nov 2026 16:18:24 +0900
Message-ID: <20773cc902416620f3de0678570df832f802857e.1794379108.git.hi@tychen.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794379108.git.hi@tychen.cc>
References: <cover.1794379108.git.hi@tychen.cc>
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
X-Envelope-From: hi@tychen.cc

Check normal completion and missing input cursors for both batch lookup
operations. Exercise a concurrent delete within a lookup batch by
repeatedly removing and reinserting the first key while the other keys
remain present. Every walk that reports end-of-iteration must include
those unchanged keys; a lost cursor may instead return EAGAIN.

Pre-size the map and keep its population stable to avoid testing the
separate best-effort behavior during resizing.

Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 .../testing/selftests/bpf/prog_tests/rhash.c  | 177 ++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/rhash.c b/tools/testing/selftests/bpf/prog_tests/rhash.c
index 0641bd5b0a9e..12b18636b577 100644
--- a/tools/testing/selftests/bpf/prog_tests/rhash.c
+++ b/tools/testing/selftests/bpf/prog_tests/rhash.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
 #include <test_progs.h>
+#include <pthread.h>
 #include <string.h>
 #include <stdio.h>
 #include "rhash.skel.h"
@@ -149,6 +150,171 @@ static void rhash_iter_test(void)
 	bpf_iter_bpf_rhash_map__destroy(skel);
 }
 
+#define BATCH_ENTRIES 64
+#define BATCH_VALUE_SIZE 4000
+
+static int rhash_batch_map_create(__u32 entries)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		    .map_flags = BPF_F_NO_PREALLOC,
+		    .map_extra = entries);
+	char value[BATCH_VALUE_SIZE] = {};
+	__u64 key;
+	int fd;
+
+	fd = bpf_map_create(BPF_MAP_TYPE_RHASH, "rhash_batch", sizeof(key),
+			    sizeof(value), entries, &opts);
+	if (!ASSERT_OK_FD(fd, "map_create"))
+		return -1;
+	for (key = 0; key < entries; key++) {
+		if (!ASSERT_OK(bpf_map_update_elem(fd, &key, value, BPF_ANY), "map_update")) {
+			close(fd);
+			return -1;
+		}
+	}
+	return fd;
+}
+
+static int rhash_lookup_batch(int fd, void *in, void *out, void *keys,
+			      void *values, __u32 *count, bool delete)
+{
+	if (delete)
+		return bpf_map_lookup_and_delete_batch(fd, in, out, keys, values, count, NULL);
+	return bpf_map_lookup_batch(fd, in, out, keys, values, count, NULL);
+}
+
+static void rhash_batch_test(bool delete, bool lost_cursor)
+{
+	__u64 key, cursor, seen = 0;
+	char value[BATCH_VALUE_SIZE];
+	__u32 count;
+	int fd, err;
+	void *in = NULL;
+
+	/* Two entries fit in the minimum table, including while deleting. */
+	fd = rhash_batch_map_create(2);
+	if (fd < 0)
+		return;
+	if (lost_cursor) {
+		count = 1;
+		err = rhash_lookup_batch(fd, NULL, &cursor, &key, value, &count, delete);
+		if (!ASSERT_OK(err, "first_batch") || !ASSERT_EQ(count, 1, "first_count") ||
+		    !ASSERT_OK(bpf_map_delete_elem(fd, &cursor), "delete_cursor"))
+			goto out;
+		count = 1;
+		err = rhash_lookup_batch(fd, &cursor, &cursor, &key, value, &count, delete);
+		ASSERT_EQ(err, -EAGAIN, "lost_cursor");
+		ASSERT_EQ(count, 0, "lost_count");
+		goto out;
+	}
+	do {
+		count = 1;
+		err = rhash_lookup_batch(fd, in, &cursor, &key, value, &count, delete);
+		if (!ASSERT_TRUE(!err || err == -ENOENT, "batch_result") ||
+		    !ASSERT_EQ(count, 1, "batch_count") ||
+		    !ASSERT_LT(key, 2, "key_range") ||
+		    !ASSERT_EQ(seen & (1ULL << key), 0, "unique_key"))
+			goto out;
+		seen |= 1ULL << key;
+		in = &cursor;
+	} while (!err);
+	ASSERT_EQ(seen, 3, "all_keys");
+	if (delete) {
+		ASSERT_EQ(bpf_map_get_next_key(fd, NULL, &cursor), -ENOENT, "empty_map");
+		count = 1;
+		err = rhash_lookup_batch(fd, NULL, &cursor, &key, value, &count, true);
+		ASSERT_EQ(err, -ENOENT, "empty_batch");
+		ASSERT_EQ(count, 0, "empty_count");
+	}
+out:
+	close(fd);
+}
+
+struct batch_race_ctx {
+	int fd;
+	__u64 key;
+	bool stop;
+	int err;
+	unsigned int updates;
+};
+
+static void *rhash_batch_update_key(void *arg)
+{
+	struct batch_race_ctx *ctx = arg;
+	char value[BATCH_VALUE_SIZE] = {};
+
+	while (!__atomic_load_n(&ctx->stop, __ATOMIC_RELAXED)) {
+		ctx->err = bpf_map_delete_elem(ctx->fd, &ctx->key);
+		if (ctx->err)
+			break;
+		ctx->err = bpf_map_update_elem(ctx->fd, &ctx->key, value, BPF_ANY);
+		if (ctx->err)
+			break;
+		ctx->updates++;
+	}
+	return NULL;
+}
+
+static void rhash_batch_concurrent_delete(void)
+{
+	struct batch_race_ctx ctx = {};
+	__u64 keys[BATCH_ENTRIES], cursor, seen = 0, expected;
+	unsigned int completed = 0, attempt;
+	__u32 count, i;
+	void *in = NULL, *values;
+	pthread_t thread;
+	int err;
+
+	ctx.fd = rhash_batch_map_create(BATCH_ENTRIES);
+	if (ctx.fd < 0)
+		return;
+	values = malloc(BATCH_ENTRIES * BATCH_VALUE_SIZE);
+	if (!ASSERT_OK_PTR(values, "values"))
+		goto close;
+	if (!ASSERT_OK(bpf_map_get_next_key(ctx.fd, NULL, &ctx.key), "first_key"))
+		goto out;
+	expected = ~(1ULL << ctx.key);
+	if (!ASSERT_OK(pthread_create(&thread, NULL, rhash_batch_update_key, &ctx),
+		       "thread_create"))
+		goto out;
+	/* Only the first key changes; no resize is needed at this load. */
+	for (attempt = 0; attempt < 5000; attempt++) {
+		count = BATCH_ENTRIES;
+		err = bpf_map_lookup_batch(ctx.fd, in, &cursor, keys, values, &count, NULL);
+		if (err == -EAGAIN) {
+			in = NULL;
+			seen = 0;
+			continue;
+		}
+		if (!ASSERT_TRUE(!err || err == -ENOENT, "batch_result"))
+			break;
+		for (i = 0; i < count; i++) {
+			if (!ASSERT_LT(keys[i], BATCH_ENTRIES, "key_range"))
+				goto stop;
+			seen |= 1ULL << keys[i];
+		}
+		if (err == -ENOENT) {
+			if (!ASSERT_EQ(seen & expected, expected, "persistent_keys"))
+				break;
+			completed++;
+			in = NULL;
+			seen = 0;
+		} else {
+			in = &cursor;
+		}
+	}
+stop:
+	__atomic_store_n(&ctx.stop, true, __ATOMIC_RELAXED);
+	pthread_join(thread, NULL);
+	ASSERT_OK(ctx.err, "writer_result");
+	ASSERT_GT(ctx.updates, 0, "concurrent_updates");
+	ASSERT_GT(completed, 0, "completed_walks");
+out:
+	free(values);
+close:
+	close(ctx.fd);
+}
+
 void test_rhash(void)
 {
 	if (test__start_subtest("test_rhash_lookup_update"))
@@ -186,4 +352,15 @@ void test_rhash(void)
 
 	if (test__start_subtest("test_rhash_iter"))
 		rhash_iter_test();
+
+	if (test__start_subtest("test_rhash_batch_lookup"))
+		rhash_batch_test(false, false);
+	if (test__start_subtest("test_rhash_batch_lookup_delete"))
+		rhash_batch_test(true, false);
+	if (test__start_subtest("test_rhash_batch_lost_lookup_cursor"))
+		rhash_batch_test(false, true);
+	if (test__start_subtest("test_rhash_batch_lost_delete_cursor"))
+		rhash_batch_test(true, true);
+	if (test__start_subtest("test_rhash_batch_concurrent_delete"))
+		rhash_batch_concurrent_delete();
 }
-- 
2.56.0

