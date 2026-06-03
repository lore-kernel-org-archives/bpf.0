Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633C140962A
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 09:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780479876; cv=none; b=swRl3xlTbhTSE69VkgjJo595n+bTAPLJ4A6OL8vJurSfqU4rTFGWltDhL3IMJI1m4sVFk8+WCtEPFpCwgzwGDd3P7FU6FaVEtuPEljwC5HnFT+x75j8A0mTAq7INQ8hj3vpnJBcoXjkHJjkStgx2gEksqg2Uo1wWq3THr8Ypodg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780479876; c=relaxed/simple;
	bh=RoX7XxjYXSu8G3YA+ItXU+wszRHFeBknMMYIYjavia0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VQNYF80itEJ9StGmGvDOXI7kMNK+wkpq4vufZO2JG8ZR4WvopQM5swfStvcslOvmwoeSW0JI92TU3o7UaOMXs0SDEVq4MP8jCaeCZLpV2uI4uLLglk5unjpyki5fGZOjemCy/rFVVTOgMA2Zh75btDVyT0IDMJ8FJWQuTPd8foE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYArfYpr; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYArfYpr"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45efb698ef2so2220761f8f.3
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 02:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780479870; x=1781084670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HQvliPaluVt3hG4Df3aSiGvi4Xl7NzgZIMVV3aYBAsk=;
        b=WYArfYprWm1MPCkYA6GpO96UR6LtcCMbWN5mkVpuHKSXfkI9gI8Zx5NtGPwjaCcYyl
         DbzHGyr2S1MBGSdTjziE6+387tA0Aw8R5ylPwaJxZ8SjJqK4HlczdInIgSIkCiCrcMks
         gvcPEugBP6EQO2uCLib6YQCjEPhN4e+ad8erd56E/yTfLrIOxCTEsY9D+zJ2xANmIzQf
         N3y+2ivO+OyTGz4Ur0lKUUZaLrbNLNF3BZJ/nnz/PN4Tur39Hz5y5exZUiGpaBU/KX6p
         4AnNNJDb6WFhbkyPEjeQt7bEFV9Q/+qAyZ9GbRwpiDy1SyBBv2fvNFIXCLMepW8DVDNT
         t2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780479870; x=1781084670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQvliPaluVt3hG4Df3aSiGvi4Xl7NzgZIMVV3aYBAsk=;
        b=QHNMScvAkJLifo+TSwjMLkwxL8FGkMbqXKKInEas4vBDqfZbuKsFHc31Qf/yG3/dDY
         kNFvn1uv+TUyimRTAK20Gp++e3C9F856E7k80HRW9iuOqw8/RymNb7AjnexAOfIUTjZs
         pJFfC/nIH/vv0O8NwzX/WvZCsLMVNA131JpZvW+sA7FxytNqVLfoBdueBy9AJYN2AIf8
         tnOaxGpIe2SsSNFWh228CxfOBrGt4evazAvXE9+EqYemX5h75xtLH23YSW8rODgNLy7P
         gUBagIKulMyTZQduFESgaGIi4uL9cVAwlrAywcGY/UbU4e0P/Ss/Xcq9zsUe8bMH6kDS
         Nhzw==
X-Gm-Message-State: AOJu0Yz0xSgxqnhu+JYu0+rONL1ilVYAx4tHPLNW8klwTALInxFLtlmj
	IPnN1FS6RlsoquRBhqmBLU/V1KC7sGsydnGEPz8FG+lSPS70nicZ2PXfAL85n7VaoakPzw==
X-Gm-Gg: Acq92OFre37KID/Nox/uJaPUp0GnbhTm9uAMVD11gW6znVjogvAByasSR6RDH+jww9U
	pcXQ9XYMS3zW+yoOy25yBSqX90TSECMiq7oi4y/Rrh356zyw+5nHkr5gCGjGGre583GaAPrV6aC
	m/UIGvRUQkyFdz7iwZ1/2UXnnssqrHerYJoREY2xEas5VSQEqE6piAJxe25nEHUOP7j9wkjwuU4
	hxGacBfF83LuP1/t9zupQqQGOMOrTeH5Bc8TyiQRawH+uTTfPD0zUvSXXARmxg7RtJl1JnODejT
	Sjwt8LNBzgoXYyZr9xHh9QwYVYHYvCe2VWtiV9hUhr+z73V1Pue3jCxSIpL01abUJc2nkkf9lnq
	HuojmSCX51a3gTvWjCuCN5d85I3jPZQTbnmuN0QhiZ8z9Ulody27ZHonDTeZuT0eB7RF2KoqhAx
	DH/uoLZ5vGTzu0DAkAFWs9cMCASmGFBOlEOfl1ycCK2g==
X-Received: by 2002:a05:6000:180c:b0:452:c9f:4b91 with SMTP id ffacd0b85a97d-46021781e28mr2648257f8f.4.1780479870353;
        Wed, 03 Jun 2026 02:44:30 -0700 (PDT)
Received: from x1.tail0e71db.ts.net ([46.140.7.198])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351ac0sm9989650f8f.27.2026.06.03.02.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 02:44:30 -0700 (PDT)
From: Ruslan Valiyev <linuxoid@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	memxor@gmail.com
Cc: song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org
Subject: [PATCH bpf-next] selftests/bpf: add test for arena vma split and fork rejection
Date: Wed,  3 Jun 2026 11:44:28 +0200
Message-ID: <20260603094428.2597058-1-linuxoid@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify that an arena map's mmap()ed VMA cannot be split with a partial
munmap() or inherited across fork().

Before commit 4fddde2a732d ("bpf: Fix use-after-free in arena_vm_close
on fork") the arena VMA had no .may_split callback and was not marked
VM_DONTCOPY, so a splitting munmap() and a fork() both succeeded.  The
fork() case left the child with a VMA whose vml->vma still pointed at
the parent, dangling after the parent unmapped and leading to a
use-after-free if the child freed arena pages.

The test creates an arena map, mmap()s it, and asserts that a splitting
munmap() fails with -EINVAL and that the child of a fork() does not
inherit the arena VMA.

Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>
---
 .../selftests/bpf/prog_tests/arena_fork.c     | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_fork.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_fork.c b/tools/testing/selftests/bpf/prog_tests/arena_fork.c
new file mode 100644
index 0000000000000..f3d5218c9e071
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_fork.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <errno.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+
+/* Regression test for commit 4fddde2a732d ("bpf: Fix use-after-free in
+ * arena_vm_close on fork"): an arena VMA must reject a splitting munmap()
+ * (.may_split) and must not be inherited across fork() (VM_DONTCOPY). On
+ * an unfixed kernel both operations succeed.
+ */
+
+#define NR_PAGES 3
+
+void test_arena_fork(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_MMAPABLE);
+	long ps = sysconf(_SC_PAGESIZE);
+	size_t sz = (size_t)NR_PAGES * ps;
+	int fd, ret, status, err;
+	void *area;
+	pid_t pid;
+
+	fd = bpf_map_create(BPF_MAP_TYPE_ARENA, "arena_fork", 0, 0, NR_PAGES, &opts);
+	if (!ASSERT_OK_FD(fd, "arena map create"))
+		return;
+
+	area = mmap(NULL, sz, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (!ASSERT_NEQ(area, MAP_FAILED, "mmap arena"))
+		goto close_fd;
+
+	/* A split of the arena VMA must be rejected (.may_split). */
+	ret = munmap((char *)area + ps, ps);
+	err = errno;
+	ASSERT_ERR(ret, "split munmap rejected");
+	ASSERT_EQ(err, EINVAL, "split munmap errno");
+
+	/* The child of a fork() must not inherit the arena VMA (VM_DONTCOPY);
+	 * mincore() returns ENOMEM for the unmapped range.
+	 */
+	pid = fork();
+	if (ASSERT_GE(pid, 0, "fork")) {
+		if (pid == 0) {
+			unsigned char vec;
+
+			_exit(mincore(area, ps, &vec) < 0 && errno == ENOMEM ? 0 : 1);
+		}
+		while ((ret = waitpid(pid, &status, 0)) < 0 && errno == EINTR)
+			;
+		if (ASSERT_EQ(ret, pid, "waitpid"))
+			ASSERT_TRUE(WIFEXITED(status) && WEXITSTATUS(status) == 0,
+				    "child must not inherit arena vma");
+	}
+
+	munmap(area, sz);
+close_fd:
+	close(fd);
+}

base-commit: 174914ea551314c52a61713b9c4bde9e42d48073
-- 
2.43.0

