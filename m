Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEEB35A933
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786749628; cv=none; b=k/wj4ZEm5CLQFgM5389vzROr1Yjelx7xzGkvozWEn2+oGPEdmNmA8Qeu6EGzB4dm3m+oMW5wx1yBsRR/2yTVihiXB/fI8Q6fYXS2K0E7ktlL0dFjIfXMfP5CPNxX7DgEzPEAVHJqnnFWIHKfbJ7MnY0pmbfs4HKl8CiE1gT3S4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786749628; c=relaxed/simple;
	bh=SzC0g812Vny1sTJIlYNfl+PUAaxpqYz5WykmFIkg7ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zu+EXPUNXsHk1SwxxwpWBVbfcgxlrkPtiKqpDboQnwzqNwmyT8TF9o7cW2lDPNPYWTutHmaH2fTUTO+SCkvUIpN+B+Z0v5ENxCH8uKA6ZleBISj/NPi70bO6cnxemnRRmaXjB3eIXg3vK3vuAbSP5A+XSkm56ZmxpFKwijqDZmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyMbaU50; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyMbaU50"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F5C1F000E9;
	Fri, 14 Aug 2026 23:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786749621;
	bh=zxqtHVlS3XMcb5KPd50kKeUpjRGtXDhbolZYGcp1zEA=;
	h=From:To:Cc:Subject:Date;
	b=hyMbaU50awkVmwfj56jWorosSUhT/868QvQqx8Jk/N1G474+lZX2Le8SUV3jZTDI5
	 XvDLlnhOilbUBmGqfE0CaaERE5o2jBGVdXt546XLtqWYy0esH4g362MdlZX2iJXMak
	 IfncaOBUE8OCqhqOL6q5imm2CPiL5gRntSrTTha9PBvxdAqXFFdeSsToaVpzE9vY1v
	 ReJ9ijP2drkPuD3wQiT/QosXzf7cxd0z5cBLzr/vhe2yHuEBrMgDRu/OHt6hDGChhf
	 zcjgRerWzw9VMI3V0ej3s84aFUQH5w+QqnZLEHIi2pnDNsmd6neiY01cpsDr+1B/N8
	 1G/mzpdtCoowg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next] selftests/bpf: Retry stat generation in cgroup_iter_memcg
Date: Fri, 14 Aug 2026 16:20:17 -0700
Message-ID: <20260814232017.2839959-1-andrii@kernel.org>
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
always covered. Sleep before dropping the mapping, so that a flusher cycle
landing in the sleep observes the mapped state. nr_anon_mapped and
nr_file_mapped are rmap gauges, and unmapping first would post a matching
negative delta for the flusher to aggregate to a net zero.

test_file asserts on both nr_file_pages and nr_file_mapped, which have
different lifetimes, as page cache pages outlive the mapping. Retry
while either one is still zero.

Fixes: 6bce6ddbe634 ("bpf: selftests: selftests for memcg stat kfuncs")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/prog_tests/cgroup_iter_memcg.c        | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
index b7c18d590b99..5a1e08d39a06 100644
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
+		usleep(MEMCG_STAT_RETRY_DELAY_US);
+		munmap(map, len);
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
 
+	if ((!memcg_query->nr_file_pages || !memcg_query->nr_file_mapped) &&
+	    ++retries < MEMCG_STAT_RETRIES) {
+		usleep(MEMCG_STAT_RETRY_DELAY_US);
+		munmap(map, len);
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
+		usleep(MEMCG_STAT_RETRY_DELAY_US);
+		munmap(map, len);
+		goto retry;
+	}
+
 	ASSERT_GT(memcg_query->pgfault, 0, "final pgfault val");
 
 cleanup:
-- 
2.53.0-Meta

