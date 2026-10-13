Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47D251AEFB;
	Tue, 13 Oct 2026 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791915604; cv=none; b=STSPWDdwS6LXjzCGc8Lv57YOziLj0bw/5VKw+Mxav3J1TdjMgc86L4veVuG06Be813y2GF3WihjX/eq/9ovyYVl2dpYW2dHByKtzOEFCSZYwbRJ0lSa+hNFfwWewcKWZKV9IUWn7su+1pAT5KmkmqN2yz6RmcLYdUVCfbTA65m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791915604; c=relaxed/simple;
	bh=QthxAvg3vp71zztJoboNuaajbqVgRe+8X4cXQhEWJGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIbDKn7DzUVwfcxlY/ysMHD6Zsfz23DWoThEEg5YubaAxjxpyF5A/rCxDe7peE4dOCLphG87TrUnNo8K7gnv3icMHGe8XEuJBggj5I6ATdmWkghuVugDr7YUPUWdN5/uPTmU8zh2ykis/meYXMZREtdpJ7ChNBkOWkxUR3/z1Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4j42gL0tgdzMlW4;
	Tue, 13 Oct 2026 20:19:58 +0200 (CEST)
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=listout@listout.xyz
From: listout@listout.xyz
To: bpf@vger.kernel.org
Cc: bdas@suse.de,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <jp.kobryn@linux.dev>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 1/2] selftests/bpf: Move alloc_pagecache() to cgroup_helpers
Date: Tue, 13 Oct 2026 23:49:31 +0530
Message-ID: <20261013181932.1739238-2-listout@listout.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261013181932.1739238-1-listout@listout.xyz>
References: <20261013181932.1739238-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4j42gL0tgdzMlW4

From: Brahmajit Das <bdas@suse.de>

arena_memcg has a static alloc_pagecache() that fills the page cache
with clean, reclaimable pages by reading a sparse O_TMPFILE. The next
patch needs the same helper for the memcg kfunc tests.

Move it to cgroup_helpers.c, which test_progs already links, so both
tests share one copy and fixes to the reclaimability detection only
have to be made once.

No functional change.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Brahmajit Das <bdas@suse.de>
---
 tools/testing/selftests/bpf/cgroup_helpers.c  | 34 +++++++++++++++++++
 tools/testing/selftests/bpf/cgroup_helpers.h  |  1 +
 .../selftests/bpf/prog_tests/arena_memcg.c    | 34 -------------------
 3 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 4183ff6150c2..ace15b9cd2e4 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -5,6 +5,8 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/xattr.h>
+#include <sys/vfs.h>
+#include <linux/magic.h>
 #include <linux/limits.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -613,6 +615,38 @@ int cgroup_setup_and_join(const char *path) {
 	return cg_fd;
 }
 
+/*
+ * Fill the page cache with @size bytes of clean, reclaimable pages by
+ * reading a sparse temp file, the way the cgroup selftests do. Returns the
+ * fd, which must stay open: closing it drops the cache. Returns -EOPNOTSUPP
+ * if the working directory cannot back such a file, -1 on error.
+ */
+int alloc_pagecache(size_t size)
+{
+	struct statfs stfs;
+	char buf[4096];
+	size_t off;
+	int fd;
+
+	fd = open(".", O_TMPFILE | O_RDWR | O_EXCL, 0600);
+	if (fd < 0)
+		return errno == EOPNOTSUPP ? -EOPNOTSUPP : -1;
+	/* tmpfs hands out shmem pages, which are not reclaimable without swap */
+	if (fstatfs(fd, &stfs) || stfs.f_type == TMPFS_MAGIC) {
+		close(fd);
+		return -EOPNOTSUPP;
+	}
+	if (ftruncate(fd, size))
+		goto err;
+	for (off = 0; off < size; off += sizeof(buf))
+		if (read(fd, buf, sizeof(buf)) < 0)
+			goto err;
+	return fd;
+err:
+	close(fd);
+	return -1;
+}
+
 /**
  * setup_classid_environment() - Setup the cgroupv1 net_cls environment
  *
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing/selftests/bpf/cgroup_helpers.h
index d42d2e13044e..6cc5ccb63fc2 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -20,6 +20,7 @@ int read_cgroup_file(const char *relative_path, const char *file,
 int read_cgroup_file_parent(const char *relative_path, const char *file,
 			    char *buf, size_t len);
 int cgroup_setup_and_join(const char *relative_path);
+int alloc_pagecache(size_t size);
 int get_root_cgroup(void);
 int create_and_get_cgroup(const char *relative_path);
 void remove_cgroup(const char *relative_path);
diff --git a/tools/testing/selftests/bpf/prog_tests/arena_memcg.c b/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
index c76a7eb2f01d..55c8db956ff3 100644
--- a/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
+++ b/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
@@ -2,8 +2,6 @@
 #define _GNU_SOURCE
 #include <test_progs.h>
 #include <fcntl.h>
-#include <linux/magic.h>
-#include <sys/vfs.h>
 #include <sys/wait.h>
 #include <unistd.h>
 #include <sys/user.h>
@@ -37,38 +35,6 @@ static void dump_memcg(void)
 		fprintf(stderr, "memory.events:\n%s", buf);
 }
 
-/*
- * Fill the page cache with @size bytes of clean, reclaimable pages by
- * reading a sparse temp file, the way the cgroup selftests do. Returns the
- * fd, which must stay open: closing it drops the cache. Returns -EOPNOTSUPP
- * if the working directory cannot back such a file, -1 on error.
- */
-static int alloc_pagecache(size_t size)
-{
-	struct statfs stfs;
-	char buf[4096];
-	size_t off;
-	int fd;
-
-	fd = open(".", O_TMPFILE | O_RDWR | O_EXCL, 0600);
-	if (fd < 0)
-		return errno == EOPNOTSUPP ? -EOPNOTSUPP : -1;
-	/* tmpfs hands out shmem pages, which are not reclaimable without swap */
-	if (fstatfs(fd, &stfs) || stfs.f_type == TMPFS_MAGIC) {
-		close(fd);
-		return -EOPNOTSUPP;
-	}
-	if (ftruncate(fd, size))
-		goto err;
-	for (off = 0; off < size; off += sizeof(buf))
-		if (read(fd, buf, sizeof(buf)) < 0)
-			goto err;
-	return fd;
-err:
-	close(fd);
-	return -1;
-}
-
 void serial_test_arena_memcg(void)
 {
 	int cgroup_fd = -1, status, err;
-- 
2.56.0

