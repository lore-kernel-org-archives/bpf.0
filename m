Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD384334B8
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786657028; cv=none; b=LJGd4iR3Yywz6DmXvGBzbXzRCgjcoBCvQa9UyJTT5OQpWBkMJRfVNnvdnw4/b5Qct9Ogpu1/1YCfX9Uf1i5LJY4WfJQS70Tw6HK0EZmgQ5CZzYurWjXMWpERA6niqHdkoK+DuE4RkymqjSwh9HDG4tnZQtfsdiNkcXV1aFj8w/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786657028; c=relaxed/simple;
	bh=Am7YEAV82DWSxnFuhWEOxepxzrGtHsdU1UUny++yNHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C1FTUuzQQ/A10UajF0FYM6VQWW7XjaUMXmL2BntIsQzPDD4rCr+E7XK0WB94YSlYmE7fUgent4epQbkqcPb12SwJhDXptbnTZF0CxEAjqb31VyMYRc4yd+l7Z5sEdFxkuzzhR/1ph5IYhPZ2yYHtDCDsn5OIXpyIIC8kZH29daU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PELbHPFb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PELbHPFb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BBF1F000E9;
	Thu, 13 Aug 2026 21:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786657023;
	bh=KWA9u+GyDPU3jZ9dHvsYui6wjahIon0r9UF+f724Yc4=;
	h=From:To:Cc:Subject:Date;
	b=PELbHPFbM7TYwS85ByGpUfhTMJaG4CjdwcYBsYxTz3T8nRncZ90FTb1F1vyBfVvtd
	 UqNY8pKoss6tGiWaNBEDtjz+kv45NQEQaM2N+zb3NFlQfYrILLX5qZm5+y/kBAAB21
	 9FQg6y3c9M6z7PIk7iliABanBejT64wgi0zJA3YqOpeqKwJY1A7M3+PuHh09nwUk46
	 Fqh7j/p7L9v58jqhXk4tL89FSO1CTNq0jHASZcuvxgNAtvc6l5oh5FInLuOCyzPqbB
	 zCfKMjp0rE8B/U9fSnUgJ9PBAjZq3k8xDr3VZ6w+A0yKNJeQe/Or45wZz1u6btVunD
	 wbfgqqLRmDoCA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] selftests/bpf: Retry stat generation in cgroup_iter_memcg
Date: Thu, 13 Aug 2026 14:37:01 -0700
Message-ID: <20260813213701.3116369-1-andrii@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each cgroup_iter_memcg subtest touches 1024 pages and expects the matching
memcg counter to be non-zero. On a host with many CPUs it reads zero
instead:

  test_anon:FAIL:final anon mapped val: actual 0 <= expected 0

memcg stats are cached per-cpu and only become visible once the periodic
flusher runs (FLUSH_TIME, 2s), or once pending updates cross
MEMCG_CHARGE_BATCH * num_online_cpus(). That threshold is 512 pages at 8
CPUs but 8192 at 128, so a single pass no longer reaches it and
bpf_mem_cgroup_flush_stats() returns without flushing anything.

Retry the stat generation, sleeping in between, so that a flusher cycle is
always covered.

Fixes: 6bce6ddbe634 ("bpf: selftests: selftests for memcg stat kfuncs")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/prog_tests/cgroup_iter_memcg.c        | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
index b7c18d590b99..37e2cf249be8 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
@@ -10,6 +10,17 @@
 #include "cgroup_iter_memcg.h"
 #include "cgroup_iter_memcg.skel.h"
 
+/*
+ * memcg stats are cached per-cpu and only become visible once the periodic
+ * flusher runs (FLUSH_TIME, 2s), or once pending updates cross
+ * MEMCG_CHARGE_BATCH * num_online_cpus(). That threshold grows with the CPU
+ * count, so on a large machine a single pass does not reach it and
+ * bpf_mem_cgroup_flush_stats() returns without flushing anything. Retry for
+ * long enough to cover a flusher cycle.
+ */
+#define MEMCG_STAT_RETRIES		16
+#define MEMCG_STAT_RETRY_DELAY_US	(250 * 1000)
+
 static int read_stats(struct bpf_link *link)
 {
 	int fd, ret = 0;
@@ -35,11 +46,13 @@ static int read_stats(struct bpf_link *link)
 
 static void test_anon(struct bpf_link *link, struct memcg_query *memcg_query)
 {
+	int retries = 0;
 	void *map;
 	size_t len;
 
 	len = sysconf(_SC_PAGESIZE) * 1024;
 
+retry:
 	/*
 	 * Increase memcg anon usage by mapping and writing
 	 * to a new anon region.
@@ -53,6 +66,12 @@ static void test_anon(struct bpf_link *link, struct memcg_query *memcg_query)
 	if (!ASSERT_OK(read_stats(link), "read stats"))
 		goto cleanup;
 
+	if (!memcg_query->nr_anon_mapped && ++retries < MEMCG_STAT_RETRIES) {
+		munmap(map, len);
+		usleep(MEMCG_STAT_RETRY_DELAY_US);
+		goto retry;
+	}
+
 	ASSERT_GT(memcg_query->nr_anon_mapped, 0, "final anon mapped val");
 
 cleanup:
@@ -61,6 +80,7 @@ static void test_anon(struct bpf_link *link, struct memcg_query *memcg_query)
 
 static void test_file(struct bpf_link *link, struct memcg_query *memcg_query)
 {
+	int retries = 0;
 	void *map;
 	size_t len;
 	char *path;
@@ -76,6 +96,7 @@ static void test_file(struct bpf_link *link, struct memcg_query *memcg_query)
 	fd = open(path, O_CREAT | O_RDWR, 0644);
 	if (!ASSERT_OK_FD(fd, "open fd"))
 		return;
+retry:
 	if (!ASSERT_OK(ftruncate(fd, len), "ftruncate"))
 		goto cleanup_fd;
 
@@ -88,6 +109,13 @@ static void test_file(struct bpf_link *link, struct memcg_query *memcg_query)
 	if (!ASSERT_OK(read_stats(link), "read stats"))
 		goto cleanup_map;
 
+	if (!memcg_query->nr_file_pages && !memcg_query->nr_file_mapped &&
+	    ++retries < MEMCG_STAT_RETRIES) {
+		munmap(map, len);
+		usleep(MEMCG_STAT_RETRY_DELAY_US);
+		goto retry;
+	}
+
 	ASSERT_GT(memcg_query->nr_file_pages, 0, "final file value");
 	ASSERT_GT(memcg_query->nr_file_mapped, 0, "final file mapped value");
 
@@ -100,6 +128,7 @@ static void test_file(struct bpf_link *link, struct memcg_query *memcg_query)
 
 static void test_shmem(struct bpf_link *link, struct memcg_query *memcg_query)
 {
+	int retries = 0;
 	size_t len;
 	int fd;
 
@@ -113,12 +142,18 @@ static void test_shmem(struct bpf_link *link, struct memcg_query *memcg_query)
 	if (!ASSERT_OK_FD(fd, "memfd_create"))
 		return;
 
+retry:
 	if (!ASSERT_OK(fallocate(fd, 0, 0, len), "fallocate"))
 		goto cleanup;
 
 	if (!ASSERT_OK(read_stats(link), "read stats"))
 		goto cleanup;
 
+	if (!memcg_query->nr_shmem && ++retries < MEMCG_STAT_RETRIES) {
+		usleep(MEMCG_STAT_RETRY_DELAY_US);
+		goto retry;
+	}
+
 	ASSERT_GT(memcg_query->nr_shmem, 0, "final shmem value");
 
 cleanup:
@@ -127,11 +162,13 @@ static void test_shmem(struct bpf_link *link, struct memcg_query *memcg_query)
 
 static void test_pgfault(struct bpf_link *link, struct memcg_query *memcg_query)
 {
+	int retries = 0;
 	void *map;
 	size_t len;
 
 	len = sysconf(_SC_PAGESIZE) * 1024;
 
+retry:
 	/* Create region to use for triggering a page fault. */
 	map = mmap(NULL, len, PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
 	if (!ASSERT_NEQ(map, MAP_FAILED, "mmap anon"))
@@ -143,6 +180,12 @@ static void test_pgfault(struct bpf_link *link, struct memcg_query *memcg_query)
 	if (!ASSERT_OK(read_stats(link), "read stats"))
 		goto cleanup;
 
+	if (!memcg_query->pgfault && ++retries < MEMCG_STAT_RETRIES) {
+		munmap(map, len);
+		usleep(MEMCG_STAT_RETRY_DELAY_US);
+		goto retry;
+	}
+
 	ASSERT_GT(memcg_query->pgfault, 0, "final pgfault val");
 
 cleanup:
-- 
2.53.0-Meta

