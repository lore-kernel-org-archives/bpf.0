Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794935239;
	b=szb+ZgqdzVDNYJoW2RypYp1aZ+8STELr0RJqiUakvxBKV/XPtzgpAujW4xolGYAvtE06
	 tf2jXAfePvhUv7FlmyJzRYOG7eFdg5jpi7v5LN8+nUODelb4uNYNKcF8m1GPNNlTxzBS3
	 Q7M6PjO/JDkaeZW+MPMdln99j2vkQ4hSdRfu6D6QjPyzQGGPRqmUyKvV84Lk7x+S8rurq
	 4GpJGdWEK13tjY5VS4eNxWLs8ljsz6eTvL2eG+4mSDR2O8JCzEmojMdo5QY+WbeVH+9EU
	 VTJXAfox712CbUxvR+XhRphlGsq5/eKwMZ0pQZCF9/RQlE12tWlgNG5+Hjer/gxULmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794935239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HDIw7LkPraP3MsfSq3lN0iboBUNVAlrEnjCuPbmeHg0=;
	b=Tbc2fKr2GJOKd26X/WKP9+gudeu1y7nZ7Ngs2KxXtP8DKdPHtu77WmRA2/yZxrMiF0tZ
	 SC9vrcXdH/JLgrGVlTPNU0W83G1pj2pnqDPLK0gk+knEmxkivndAsaP/Hca8VvtXUUYUY
	 0IZ/UXHd8zmuKxOM8DJONfT63VQ/1PfSvb3nRjhmklhsQZ+Q3mf8kJVpGy3WdF/mHYlxT
	 lNI6+V/hBWbPMdH9usjzOQkdd05NXR0uXGyYnQLrf+DJZDLqMkteJtyzymDEnDfkdd5jU
	 hvh5SFmJpTl0x9bODCbMzdNluUwlzJauyzUOFzEzgpd9HMxLs1zrNV2GxGchvnXH4GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yt84R+mR;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C15606A31C
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 17:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2C15606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yt84R+mR
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b3be948e60so410165a91.3
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 09:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794935238; x=1795540038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HDIw7LkPraP3MsfSq3lN0iboBUNVAlrEnjCuPbmeHg0=;
        b=Yt84R+mRj17Vuxy9vCcizubVYtzU50MDSATSlafYcv7qpRjQv/rCvbTdhu91t/HI2h
         umhUvo9sssSp2MbJK19YfIJfbaHHJY793yfi/5vfcYZCpijnrzBZ1XmEjVRAcUerMLzf
         puasXqREteE0r2y4rj8AMYR2YDwugW+rXLnvQyRTebMFwG1OruPLFjvQevFTFaRmv0DG
         /QuskO9gLF/qlsR5iXhZGJon0c3FY2WjmcLAL7CeuJxfsn6w2VkdqIhaXPzGyA3o8BFZ
         EK/ey1U1xs3Y4MmN8l1h06vXq6qzLM23hpoWH/kwbmMzC8W0dZzMrXKXfTFkn7U/ERZj
         G/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794935238; x=1795540038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HDIw7LkPraP3MsfSq3lN0iboBUNVAlrEnjCuPbmeHg0=;
        b=uPxAQPsrgFFsx9Hxa89PXbwCN5gbYkeec8TLYlNI4n66D2XNqwxhYpnEfPqBgLeCla
         cblzrSy6iSeKIWJt2G1a9Ntkmm6cj/RP8ysxhPMZc6TIa0WM0FWOMh5P5j7gWyfnhzbv
         ZSQ0jmV8EicjvKQYf+xrRHdhCJ7ENEoGjqwF7+vKFQdwoIB7zRJi6kEWuJP4IaNiuSV3
         /9Ymk02rvo5i+Vboq4JhJMjzavLAIKQYGXGBpT5zxvaWYnAyBHpm4TywnAa+KI5deNWF
         LFM1XW9QeYdq8v5EMFlr34PHEzFwsZ8gEsJiukP58W2u4tMKWXD1mRPrhSeB/mJPlVT9
         I9nA==
X-Forwarded-Encrypted: i=1; AL+hErFq6HvX5vWdfgGPtxM4d08x61DAYf3YUUtOEbDQc5khR0cJmETLfoq8sU80U1EUizMMov8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9r6q1eqcqSNRAkFG5IugDw2kOh1FcLxd7b2XZi9BEeD3Azb/JW
	sBuvowGgvAKkzqR9bYSDs/BChLs764phN0E23h2CfDPrTttn7VzDkUJ7
X-Gm-Gg: AZFdTZe+69NNxfnOSQUpci3DKssX2tymi4o8MCNhu2x0x/N4B6t2LgSur5eLF3o7nem
	LASyggw1k5fr/56NbXCdXnZtavvIMap15Ppdk7pm2MWewKiqHM9yvZkKE2SHzaj/bSCcfa6bCqk
	SnaVxOlTOY2I03Z9U8qjhP9QTfa3apAJ6M8ImPDAvdqjuBpMPruoexnucvtKTolGwlu3trwFm+T
	qHD+yxLfkM+8Jm2XWWONOV+6eQ628dA6WlG5W1mnDfri/TrjcpaWOGkxHlX+FqFxgz7vhdWKwLx
	4p/20vAFYA7emOiwM/iBW2Lc4q2TMwF7aDCvtWXRh9eacKbvnVbwICokXUY6aeBgHZDkcxd0lfy
	zrJYDMozuXeil/MKXLlo/LCeeRExbghVJ16pvOtJeb/ENi7c9U7SjW7FB8YBY7+JRQ22JKjQmQb
	jFLK43xqOJ8TqqFa+MGs1ipjtufdY1xrpAosUbJtZGETdPxrQgAGm8qUfgOurLw2IbWs48MPtfs
	/Ot1yWwUo4HoRPbA0DWpTNkZ1fIPteZNRDOquy9qrRb+GDVbkcfb9WJDuU6DLvyqQ/f0OXNzDtW
	LtVFuTp0KTdk+e0mloUcIT5ccC2agXstAp80wvD9f5mPK1bZKu4fHHQO2qKxQ0kCCNnb7pMP1IA
	OFnhy6T0KjzyRNQnx
X-Received: by 2002:a17:90b:4cc4:b0:3b3:b5e5:3592 with SMTP id 98e67ed59e1d1-3b3d06a2559mr99784a91.9.1794935237917;
        Tue, 17 Nov 2026 09:07:17 -0800 (PST)
Received: from localhost (218-35-178-218.cm.dynamic.apol.com.tw. [218.35.178.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3abbad970sm4925368a91.4.2026.11.17.09.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:07:16 -0800 (PST)
From: Kurt Lin <lylin1023@gmail.com>
To: Hui Zhu <hui.zhu@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barry Song <baohua@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kurt Lin <lylin1023@gmail.com>
Subject: [PATCH bpf-next v2] selftests/bpf: Fall back when memcg_proactive_reclaim data lands in shmem
Date: Wed, 18 Nov 2026 01:07:04 +0800
Message-ID: <20261117170704.1146730-1-lylin1023@gmail.com>
X-Mailer: git-send-email 2.56.1
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

workload_dir() keeps the data file off tmpfs because shmem cannot be
reclaimed without swap. But statfs() only sees the top of a stacking
filesystem: with /tmp on overlayfs over tmpfs, as in virtme-ng guests,
the check passes and all 32 MiB are still charged as shmem. Whether the
test then passes depends on unrelated page cache in the cgroup; in a
full test_progs run it fails with:

  test_memcg_proactive_reclaim:FAIL:reclaimed unexpected reclaimed: actual 0 <= expected 0

After writing the file, check memory.stat and move on to the next
candidate directory if most of the data was charged as shmem; skip only
when none is left. Give each candidate its own cgroup so that stale
stats from a previous attempt cannot interfere, and poll memory.stat
until the write shows up, as reading it does not force a stats flush.
Fail the test if memory.stat cannot be read or never shows the write.

An AI coding assistant (Claude) was used to find and analyze the
failure and to draft the fix and this changelog.

Fixes: 0f9b1e9ef584 ("selftests/bpf: Add bpf_proactive_reclaim test")
Signed-off-by: Kurt Lin <lylin1023@gmail.com>
---

Notes:
    Changes in v2:
    - Try the next candidate directory instead of skipping right away, with
      a fresh cgroup per candidate (sashiko)
    - Poll memory.stat until the write is visible: reading it does not force
      a flush, so it can still show 0 right after the write when many CPUs
      are online (sashiko)
    - Fail the test instead of silently running on when memory.stat cannot
      be read or parsed, or never shows the write (Hui)
    - Comment on the FILE_SIZE / 2 threshold and print the measured shmem
      charge (Hui)
    - Subject was "Skip memcg_proactive_reclaim when data lands in shmem"
    
    Tested in a virtme-ng guest without swap:
    - /tmp on overlayfs over tmpfs: falls back to "." and passes
    - /tmp on tmpfs: uses "." and passes
    - both on overlayfs over tmpfs: skips
    - full test_progs run with /tmp on overlayfs over tmpfs: passes
    
    To exercise the polling, FILE_SIZE was temporarily cut to 2 MiB in a
    128-vCPU guest, which keeps the write below the flush threshold.
    memory.stat read 0 right after the write and the data showed up after
    2-6 s, once the periodic flusher had run.
    
    v1: https://lore.kernel.org/bpf/20261113180159.602033-1-lylin1023@gmail.com/

 .../bpf/prog_tests/memcg_proactive_reclaim.c  | 161 ++++++++++++++----
 1 file changed, 125 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c b/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c
index c22dcfabe856..23ca1075f260 100644
--- a/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c
+++ b/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c
@@ -19,6 +19,15 @@
 #define FILE_SIZE (32 * 1024 * 1024UL)
 #define BUF_SIZE (64 * 1024)
 
+/*
+ * memcg stats are flushed lazily: reading memory.stat only flushes once
+ * pending updates exceed MEMCG_CHARGE_BATCH * num_online_cpus(), so on a
+ * large machine the write may only show up after the periodic flusher
+ * (every 2s, later on a busy machine) has run.
+ */
+#define MEMCG_STAT_RETRIES		40
+#define MEMCG_STAT_RETRY_DELAY_US	(250 * 1000)
+
 struct reclaim_args {
 	__u64 cgroup_id;
 	__u64 size;
@@ -32,18 +41,79 @@ struct reclaim_args {
  * routinely run from a tmpfs working directory, so both candidates need the
  * check.
  */
-static const char *workload_dir(void)
+static const char * const workload_dirs[] = { "/tmp", "." };
+
+static bool usable_dir(const char *dir)
 {
-	static const char * const dirs[] = { "/tmp", "." };
 	struct statfs st;
+
+	return !statfs(dir, &st) && st.f_type != TMPFS_MAGIC &&
+	       st.f_type != RAMFS_MAGIC && !access(dir, W_OK);
+}
+
+static bool memcg_stat(const char *stat, const char *key,
+		       unsigned long long *val)
+{
+	char needle[32];
+	const char *p;
+
+	snprintf(needle, sizeof(needle), "\n%s ", key);
+	p = strstr(stat, needle);
+	return p && sscanf(p + strlen(needle), "%llu", val) == 1;
+}
+
+/*
+ * statfs() only sees the top of a stacking filesystem: when /tmp is an
+ * overlayfs over tmpfs, as in virtme-ng guests, the check above passes but
+ * the data still ends up as shmem. Wait for the write to show up in the
+ * cgroup's stats ("file" includes shmem) and report how much of it is shmem.
+ * Both keys are always present, so failing to read them is an error.
+ */
+static int read_shmem_charge(const char *cg, unsigned long long *shmem)
+{
+	static char buf[8192];
+	unsigned long long file = 0;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(dirs); i++)
-		if (!statfs(dirs[i], &st) && st.f_type != TMPFS_MAGIC &&
-		    st.f_type != RAMFS_MAGIC && !access(dirs[i], W_OK))
-			return dirs[i];
+	for (i = 0; i < MEMCG_STAT_RETRIES; i++) {
+		if (!ASSERT_OK(read_cgroup_file(cg, "memory.stat", buf,
+						sizeof(buf)), "read memory.stat") ||
+		    !ASSERT_TRUE(memcg_stat(buf, "file", &file), "parse file") ||
+		    !ASSERT_TRUE(memcg_stat(buf, "shmem", shmem), "parse shmem"))
+			return -1;
+		if (file >= FILE_SIZE / 2)
+			return 0;
+		usleep(MEMCG_STAT_RETRY_DELAY_US);
+	}
 
-	return NULL;
+	ASSERT_GE(file, FILE_SIZE / 2, "file in memory.stat");
+	return -1;
+}
+
+/* Charge FILE_SIZE of clean page cache to the current cgroup. */
+static int write_data_file(const char *dir, char *path, size_t len)
+{
+	static char buf[BUF_SIZE];
+	off_t off;
+	int fd;
+
+	snprintf(path, len, "%s/memcg_proactive_reclaim_XXXXXX", dir);
+	fd = mkstemp(path);
+	if (!ASSERT_GE(fd, 0, "mkstemp"))
+		return -1;
+
+	for (off = 0; off < (off_t)FILE_SIZE; off += sizeof(buf))
+		if (!ASSERT_EQ(write(fd, buf, sizeof(buf)),
+			       (ssize_t)sizeof(buf), "write"))
+			goto err;
+	if (!ASSERT_OK(fsync(fd), "fsync"))
+		goto err;
+
+	return fd;
+err:
+	close(fd);
+	unlink(path);
+	return -1;
 }
 
 void test_memcg_proactive_reclaim(void)
@@ -55,35 +125,62 @@ void test_memcg_proactive_reclaim(void)
 		    .ctx_in = &args,
 		    .ctx_size_in = sizeof(args));
 
-	char data_file[PATH_MAX];
-	static char buf[BUF_SIZE];
+	char data_file[PATH_MAX], cg[64];
+	unsigned long long shmem;
 	__u64 cgroup_id;
-	const char *dir;
-	off_t off;
-	int cg_fd = -1, data_fd = -1, err;
+	int cg_fd = -1, data_fd = -1, err, i;
+
+	if (!ASSERT_OK(setup_cgroup_environment(), "setup_cgroup_environment"))
+		return;
 
 	/*
-	 * Both candidate directories can be unusable: tmpfs (initramfs-based
-	 * CI, for instance) or a read-only mount. That is an environment
-	 * limitation, not a test failure.
+	 * Try each candidate in a cgroup of its own, so that the stats of one
+	 * attempt do not leak into the next.
 	 */
-	dir = workload_dir();
-	if (!dir) {
-		test__skip();
-		return;
-	}
+	for (i = 0; i < ARRAY_SIZE(workload_dirs); i++) {
+		if (!usable_dir(workload_dirs[i]))
+			continue;
 
-	snprintf(data_file, sizeof(data_file),
-		 "%s/memcg_proactive_reclaim_XXXXXX", dir);
-	data_fd = mkstemp(data_file);
-	if (!ASSERT_GE(data_fd, 0, "mkstemp"))
-		return;
+		snprintf(cg, sizeof(cg), CG_PATH "_%d", i);
+		cg_fd = create_and_get_cgroup(cg);
+		if (!ASSERT_OK_FD(cg_fd, "create_and_get_cgroup"))
+			goto out;
+		if (!ASSERT_OK(join_cgroup(cg), "join_cgroup"))
+			goto out;
+
+		data_fd = write_data_file(workload_dirs[i], data_file,
+					  sizeof(data_file));
+		if (data_fd < 0 || read_shmem_charge(cg, &shmem))
+			goto out;
 
-	cg_fd = cgroup_setup_and_join(CG_PATH);
-	if (!ASSERT_OK_FD(cg_fd, "cgroup_setup_and_join"))
+		/*
+		 * All or nothing: the file is either entirely shmem (tmpfs,
+		 * possibly under a stacking filesystem) or not shmem at all
+		 * (disk-backed), so half of FILE_SIZE is a safe midpoint.
+		 */
+		if (shmem < FILE_SIZE / 2)
+			break;
+
+		printf("%s: %s is backed by shmem (%llu MiB charged)\n",
+		       __func__, workload_dirs[i], shmem >> 20);
+		close(data_fd);
+		unlink(data_file);
+		data_fd = -1;
+		close(cg_fd);
+		cg_fd = -1;
+	}
+
+	/*
+	 * No candidate is usable: tmpfs (initramfs-based CI, for instance),
+	 * a read-only mount, or a stacking filesystem on top of tmpfs. That is
+	 * an environment limitation, not a test failure.
+	 */
+	if (data_fd < 0) {
+		test__skip();
 		goto out;
+	}
 
-	cgroup_id = get_cgroup_id(CG_PATH);
+	cgroup_id = get_cgroup_id(cg);
 	if (!ASSERT_GT(cgroup_id, 0, "get_cgroup_id"))
 		goto out;
 
@@ -91,14 +188,6 @@ void test_memcg_proactive_reclaim(void)
 	if (!ASSERT_OK_PTR(skel, "open_and_load"))
 		goto out;
 
-	/* Charge FILE_SIZE of clean page cache to the cgroup. */
-	for (off = 0; off < (off_t)FILE_SIZE; off += sizeof(buf))
-		if (!ASSERT_EQ(write(data_fd, buf, sizeof(buf)),
-			       (ssize_t)sizeof(buf), "write"))
-			goto out;
-	if (!ASSERT_OK(fsync(data_fd), "fsync"))
-		goto out;
-
 	args.cgroup_id = cgroup_id;
 	args.size = FILE_SIZE;
 	skel->bss->reclaimed = 0;

base-commit: 0021f17128de5dc0b19f1a523f448df2440d8088
-- 
2.56.1

