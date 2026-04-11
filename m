Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB7178F4F
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 20:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775938143; cv=none; b=QhBVVZIhP/gEN/bPNhkJJhCZjm19at+DjTNCK9EOg9k+pDU0eYHw2ybMhB1ByPbExzxu9281j/1z+KgNa2Zj73D4ZC43MrsjoA+nAMoSrYoky0fXH1GCebkvU32vDOXfuD9AnQeH5aLZ1+x9wybKCClCdvrxTd30SRfqt6UGmpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775938143; c=relaxed/simple;
	bh=AAo390ls7O+/gBJECTw5jRwQRLXWQ3hPBdBKg6IolV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cEaELIB0kc+ob+f3t8HUwNiXaq6lrISjmI30IgiiZmSNq6zJJO+IZmpbH8513jVuDxJ/5CMvQZc2WtMjPFjZA3HZOYR118r3Eg3APJg11/KdcjhIBwswUE46Dkd2MszEg2tI5aiDT1O8H6j19wjXvdI1mQ4DgmfF0y57T5jrt0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/uJIVR0; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/uJIVR0"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-128b9b7e3edso3086575c88.0
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 13:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775938141; x=1776542941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcJawOFnHtEXmwU7Ts86h653zGkHF4K3zLulupg+ZRE=;
        b=g/uJIVR0JAAKFOdP5ZdW2XBHH/lzHXtSeQjMPqt+qCf6l+vBEm5bCsMHRm6m1syjRM
         XcGRAkpQNqizVeXTK55198ug5kZtD4D6/CzM1JKMEdBQcV4oXsm/p2VM5ycBfz6GLvDT
         IyjupQW9m8SOdoOlW4t7cG7VLfUxr7YEgwtXo4OBsGhIKk+oVApjGpLmY14wd2eKQfk0
         hv1nFlV4Yd6SuOOrgiWfoNSdxIKDDcVdLI+nbWdkENlqjDxJLgTZi4veATTOdTa2BL6M
         bje4z2ujqdN4cDAPiZ/V7KJOx7PRABbm/oMBUfL/trwld2V8M+zpLsOstINvkVSwZoNq
         QJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775938141; x=1776542941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zcJawOFnHtEXmwU7Ts86h653zGkHF4K3zLulupg+ZRE=;
        b=P9QSmZSufCT+LTiNaRid6UMVVaZAcMZNyyt80O6mn9U2WO4MkVwWIwSvTttmik2Gs3
         00UYxIzyv9yKmZ4/uZcamXcLdBuxIpnnNksk7c+k8CHPdxKLY6W/G3CRBEJ8RVLbRqe1
         Ps47LC/jdZzeNGlhN7M/b7XK+u7cdvmiV4YH1DaDg/DMNFt/xUGeJjaEGfl6XXYA1+6R
         RteMQDexg8zkca9u7S7musL3GNUuGUwGoUXYAs2znCQBurESO1OkNr23pO+zA+MkmHUo
         3xokcsdbwmv7r9hMhu70szkwv+QBY5KBgin13yOyKZ92OS6Dloz34zxsX6i2VUW/ZukC
         JeEg==
X-Forwarded-Encrypted: i=1; AJvYcCXZGCKHCImNQhWeN1i30xPiyIC6nSUmNkIChvQAmdC+TGTE+9HTgtHKJWEjrDip770bPLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbjRuZgk/rHLpuTu5diuJOwxQ3IaUezo9Pi+uAmnjEImhEguKN
	cRYSsOms5mLwexR05wdl2CD2+coed17NkJKCVvD8jnNxVFwZ+m2z6wUB
X-Gm-Gg: AeBDietBf64wOumQbPteRqNfpdIM5kVHZS9B9ucjXsFZnCLDOCUg3kqsg8Q0v83iCVw
	PlnSpIlvt1ekSEd2lH/+P0NMtHLzzdylqjPH2RGtc7zk8TuuM6CppEFPnD0ihYARA5kD5nZ0dvc
	qO+VarYM9JS3a0Jz/S6kiGZlHGWZCJka9yQrD4QNUeTM2ggLNYcJEquEYIdVreCkM9cwDzu/i9L
	lg3eKAJmN27h0QSkBrBluj6WdoFpGjhC/KmB9Ud0wM45vtkVpcVEkrZs06SdnWG2RBa5EPxLx7R
	Ls3KHVFK5gxBZggmLUBnt8XlplA0EMm9m7Q07ACjFx+2UWN0StJgNmHtLe5JPJ6Om7AHp5J6lrc
	bCFrxMe1agInSSSkcXQAjzoPVRWHBS9bfdIRBSqLdN4SbrJYlrvxc7U1V9fUA6emoddzm3hgpQ2
	zPY5HiOSEP3JjeVlRXQJ+42mULlg4QGGtYjuFXIrc3Y3Icpkn7gHPEEFt3A9FYR0t/ZJJOoM7oC
	8f2nbDURQ==
X-Received: by 2002:a05:7022:6290:b0:123:331d:bdbb with SMTP id a92af1059eb24-12c34ecece1mr4613795c88.22.1775938141453;
        Sat, 11 Apr 2026 13:09:01 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c3459f7ffsm8078325c88.3.2026.04.11.13.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 13:09:00 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH bpf v3 2/2] selftests/bpf: Add test for arena VMA use-after-free on fork
Date: Sat, 11 Apr 2026 13:08:41 -0700
Message-ID: <20260411200840.1793567-4-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411200840.1793567-2-bestswngs@gmail.com>
References: <20260411200840.1793567-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest that reproduces the arena VMA use-after-free fixed in
the previous commit. The test creates an arena, mmaps it, allocates
pages via BPF, forks, has the parent munmap the arena, then has the
child call bpf_arena_free_pages. Without the fix this triggers a
KASAN slab-use-after-free in zap_page_range_single.

Note: the UAF occurs entirely in kernel space and is not observable
from userspace, so this test relies on KASAN to detect the bug.
Without KASAN the test passes regardless of whether the fix is
applied.

Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 .../selftests/bpf/prog_tests/arena_fork.c     | 80 +++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_fork.c  | 41 ++++++++++
 2 files changed, 121 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_fork.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_fork.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_fork.c b/tools/testing/selftests/bpf/prog_tests/arena_fork.c
new file mode 100644
index 000000000000..0235884c5906
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_fork.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+/*
+ * Test that forking a process with an arena mmap does not cause a
+ * use-after-free when the parent unmaps and the child frees arena pages.
+ */
+#include <test_progs.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "arena_fork.skel.h"
+
+void test_arena_fork(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct bpf_map_info info = {};
+	__u32 info_len = sizeof(info);
+	struct arena_fork *skel;
+	long page_size;
+	size_t arena_sz;
+	void *arena_addr;
+	int arena_fd, ret, status;
+	pid_t pid;
+
+	page_size = sysconf(_SC_PAGESIZE);
+	if (!ASSERT_GT(page_size, 0, "page_size"))
+		return;
+
+	skel = arena_fork__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	arena_fd = bpf_map__fd(skel->maps.arena);
+
+	/* libbpf mmaps the arena via initial_value */
+	arena_addr = bpf_map__initial_value(skel->maps.arena, &arena_sz);
+	if (!ASSERT_OK_PTR(arena_addr, "arena_mmap"))
+		goto out;
+
+	/* Get real arena byte size for munmap */
+	bpf_map_get_info_by_fd(arena_fd, &info, &info_len);
+	arena_sz = (size_t)info.max_entries * page_size;
+
+	/* Allocate 4 pages in the arena via BPF */
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arena_alloc),
+				     &opts);
+	if (!ASSERT_OK(ret, "alloc_run") ||
+	    !ASSERT_OK(opts.retval, "alloc_ret"))
+		goto out;
+
+	/* Fault in a page so zap_pages has work to do */
+	((volatile char *)arena_addr)[0] = 'A';
+
+	/* Fork: child inherits the arena VMA */
+	pid = fork();
+	if (!ASSERT_GE(pid, 0, "fork"))
+		goto out;
+
+	if (pid == 0) {
+		/* Child: parent will unmap first, then we free pages. */
+		LIBBPF_OPTS(bpf_test_run_opts, child_opts);
+		int free_fd = bpf_program__fd(skel->progs.arena_free);
+
+		usleep(200000); /* let parent munmap first */
+
+		ret = bpf_prog_test_run_opts(free_fd, &child_opts);
+		_exit(ret || child_opts.retval);
+	}
+
+	/* Parent: unmap the arena */
+	munmap(arena_addr, arena_sz);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status), "child_exited");
+	ASSERT_EQ(WEXITSTATUS(status), 0, "child_exit_code");
+out:
+	arena_fork__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_fork.c b/tools/testing/selftests/bpf/progs/arena_fork.c
new file mode 100644
index 000000000000..783c935a0af8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_fork.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_arena_common.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 16); /* number of pages */
+#ifdef __TARGET_ARCH_arm64
+	__ulong(map_extra, 0x1ull << 32); /* start of mmap() region */
+#else
+	__ulong(map_extra, 0x1ull << 44); /* start of mmap() region */
+#endif
+} arena SEC(".maps");
+
+void __arena *alloc_addr;
+
+SEC("syscall")
+int arena_alloc(void *ctx)
+{
+	void __arena *p;
+
+	p = bpf_arena_alloc_pages(&arena, NULL, 4, NUMA_NO_NODE, 0);
+	if (!p)
+		return 1;
+	alloc_addr = p;
+	return 0;
+}
+
+SEC("syscall")
+int arena_free(void *ctx)
+{
+	if (!alloc_addr)
+		return 1;
+	bpf_arena_free_pages(&arena, alloc_addr, 4);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0

