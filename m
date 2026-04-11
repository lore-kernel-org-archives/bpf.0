Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9261B4F1F
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775906490; cv=none; b=HUaAG1fwSdLv+7dee7qP7+/5A553RNsVhpGHxHURJYfQn72gc2/raFVbq/XMqpeTyid6j+4QaNCyFphEsYq69O13obIGnw5xZocuBxkRehI3I4XUurL8MSDPpTm+x+1oFeGJtH3HalEKBKGgj73e6/G+YCgf8Rrzbo0vjRx/9L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775906490; c=relaxed/simple;
	bh=VDleVhlM+AWXVtS+vsFZ+Rmbunt7uexH//AXGlq39F8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFfDfMykGI5PQ1a4jwEVTbI94OrHu22nvWyfgaggEW0ZszkfbYnv/Tgym0BYpY47MFBTCz/mFOVG4uzCNyjJtPLZe45Nw10cvKLdxrc3JUNWYp8OAfr7k2HuX/e5jDDorjUi9PDMJCtiIw2eQQLRSp2dAbMpi2SEj6FESHyHB6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuVpCa5z; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuVpCa5z"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b6b0500e06so4968971eec.1
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 04:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775906487; x=1776511287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SR6PIjf9ygKKS8EPk3SHWBc5/ngwD0asCwUuSLZOTMk=;
        b=EuVpCa5zlGCAEpwh7shWm8PhGj615I2xvqsQ2f5KZrpQbbVEsEd+haSqIpXMV8omot
         f9vpWmIyXQAPcG1h7Dsz/u7ecZAsWhiffuMJZ7M1bWz63FBLTWhViLVc7py9hWoQO8VG
         Ts+peqF7FV3lZUOZ7gIvHF745EoYEjMiiJm1J3OY8DCCz4UR7layotlOFtRjV5H6QCXw
         HrQCqx8TCRb37xZnfjCRG2ZZgSbBB9inhuvLMYnJIjJb6Kp5fvd/VdE/84XdC5MgHFZ9
         qkUOav+ACgmXth4KdK10jU2TvMjTHsmR7zdH4e8IUAmkcXBnMZjd1x0SjclIz7D8p8Hs
         wjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775906487; x=1776511287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SR6PIjf9ygKKS8EPk3SHWBc5/ngwD0asCwUuSLZOTMk=;
        b=b5x9dAFgEPZy2K1MezcdXzKo8PwZjsrrClO/OGjWL/Z+YhNZtoy695avwrNOsWQ1Ec
         F+Fk1QP+9fe6KvEy9UYu+RTRdEo4KHt00StRNTMITYsr8EJid+UgfrjS539O3x4aWWRr
         v14MTFsabCrTDYbo/kbYF/6M5NA3GRLELDXRdAymbe7lhaHSFgHBvJO4l8V22DyA9gcb
         c49xG3gTqucMdMH3mJOMglaZD9TAKMksE/bYL8qrRL5uLLzC6/3P+FMYs2N8w6bCeWOh
         5viKojJgiZyXAsKrNxviHyTxVu5tBLzfZVhDhY+BjVNTxRjanHk6xQnMFZdUq5VM/Rgt
         XEpg==
X-Forwarded-Encrypted: i=1; AJvYcCWmqnDLXzKO1tCuKsX2DmClPCu354ek6IB8Kupk738hVohGmF2+nOq44kr++D82B07ENlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpwQaY8B+OxHExThUlmedJeCJVSsnsiRf2leGE773uD7iX4soW
	+tKodwIK+45C6k0twp5gncTeUV4pcYW385cV9wXeBQthy6s2emzNgIOo
X-Gm-Gg: AeBDieuVC52anF1npbOw+j+Ko/4EdvwJSY0etsp8jfuXOU35bwHbCOWK5fqQAcn9YM0
	lCKznQbH3lyeoEVmFgQz9LQFGAL60htgzJV+1gl/ncIhx9NMHKyNUHEhf/6wOXpo27j9oRWrme1
	iV9eArs3UJiIfiJ7SV6C/S1TSv+yly70CK9STvtznoDwz3/JzS/X5HxtdFAgfhPQZTQn0bqb2mG
	qqb+/us2k+MygseHZGe8K06+1W6IgP8Noy9W0cKTTHTBYBYPFiGNm3zMI8ASDY88dLNeUfytqrz
	eg/8qUoTZdzjwfjsPh26KIur1BQSekqRtWACPWSdNC00gYroTKl4A4q1HWEFxfHcNuqcN3D27Ml
	ZteUAbugGw3+a0uO9NyT+yAKm8T9PetUllGj4psCD18JrYOpvGm6R+AZe7TElLTJKFpoxggjsg8
	zCQwgJi3v5O/6wUY08UxDPLMkx9+tHbobWuN4EhtfbdNdVOal3fJHW58XQ9X3Z5ZDSARY8AhFMi
	c00HyVchQ==
X-Received: by 2002:a05:7301:1f10:b0:2b0:48f7:837d with SMTP id 5a478bee46e88-2d587a8be8bmr3797189eec.11.1775906486577;
        Sat, 11 Apr 2026 04:21:26 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d562db64c4sm8224984eec.27.2026.04.11.04.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 04:21:25 -0700 (PDT)
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH bpf 2/2] selftests/bpf: Add test for arena VMA use-after-free on fork
Date: Sat, 11 Apr 2026 04:20:51 -0700
Message-ID: <20260411112050.1454548-4-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411112050.1454548-2-bestswngs@gmail.com>
References: <20260411112050.1454548-2-bestswngs@gmail.com>
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

Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 .../selftests/bpf/prog_tests/arena_fork.c     | 86 +++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_fork.c  | 41 +++++++++
 2 files changed, 127 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_fork.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_fork.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_fork.c b/tools/testing/selftests/bpf/prog_tests/arena_fork.c
new file mode 100644
index 000000000000..445574827891
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_fork.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 */
+
+/*
+ * Test that forking a process with an arena mmap does not cause a
+ * use-after-free when the parent unmaps and the child frees arena pages.
+ *
+ * The bug: arena_vm_open() only incremented a refcount but never registered
+ * the child's VMA. After parent munmap, vml->vma pointed to a freed
+ * vm_area_struct. bpf_arena_free_pages -> zap_pages would then UAF.
+ */
+#include <test_progs.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <sys/user.h>
+#ifndef PAGE_SIZE
+#define PAGE_SIZE getpagesize()
+#endif
+
+#include "arena_fork.skel.h"
+
+void test_arena_fork(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct bpf_map_info info = {};
+	__u32 info_len = sizeof(info);
+	struct arena_fork *skel;
+	size_t arena_sz;
+	void *arena_addr;
+	int arena_fd, ret, status;
+	pid_t pid;
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
+	arena_sz = (size_t)info.max_entries * PAGE_SIZE;
+
+	/* Allocate 4 pages in the arena via BPF */
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arena_alloc),
+				     &opts);
+	if (!ASSERT_OK(ret, "alloc_run") ||
+	    !ASSERT_OK(opts.retval, "alloc_ret"))
+		goto out;
+
+	/* Fault in a page so zap_pages has work to do */
+	((char *)arena_addr)[0] = 'A';
+
+	/* Fork: child inherits the arena VMA */
+	pid = fork();
+	if (!ASSERT_GE(pid, 0, "fork"))
+		goto out;
+
+	if (pid == 0) {
+		/* Child: parent will unmap first, then we free pages.
+		 * Without the fix, this triggers UAF in zap_pages.
+		 */
+		LIBBPF_OPTS(bpf_test_run_opts, child_opts);
+		int free_fd = bpf_program__fd(skel->progs.arena_free);
+
+		usleep(200000); /* let parent munmap first */
+
+		ret = bpf_prog_test_run_opts(free_fd, &child_opts);
+		_exit(ret || child_opts.retval);
+	}
+
+	/* Parent: unmap the arena, making vml->vma stale */
+	munmap(arena_addr, arena_sz);
+
+	/* Wait for child -- if kernel UAFs, child will crash/hang */
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status), "child_exited");
+	ASSERT_EQ(WEXITSTATUS(status), 0, "child_exit_code");
+out:
+	arena_fork__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_fork.c b/tools/testing/selftests/bpf/progs/arena_fork.c
new file mode 100644
index 000000000000..b1f8435f1834
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_fork.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 */
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

