Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C930931D371
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 02:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775960855; cv=none; b=fiAiqzZ4H2IirYzIlSrxki0REKSawGUN6OadwSsOwqb3L4TVZMy8aZrQByuvRL+8t4KtnzEAG7m+QQVJUylTlTmX16X/z27wbUYZSTybkBEIuFU6Xp9Eg8aKlq7Hx8eYfHirPCK5Dg5uPYCpHRb2iuyZXf39fzYZnquUo+JEfk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775960855; c=relaxed/simple;
	bh=AAo390ls7O+/gBJECTw5jRwQRLXWQ3hPBdBKg6IolV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3cA0MgE1aFdgUMdOOaXzOcxAm+CK9iQiJwTweEA0NFBAU3Ot5NISI9f/gUSJzEoRYuT8JtSk0fiO6KP5wwtmCG+iRVnwRETN5PsaJWguTa+sXvDm7zEvdJ+XlRFxsjmjRb+7ldG0Yxvz4nhQQvM6zToTq6Pix6dgMunimEItFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNBjl3YW; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNBjl3YW"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1271257ae53so10742077c88.1
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 19:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775960853; x=1776565653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcJawOFnHtEXmwU7Ts86h653zGkHF4K3zLulupg+ZRE=;
        b=nNBjl3YWut/7i64zvyTFb2vp4TZv+G3AcQXHtbHl3BelwVRE4MMJqiqXerE2Xr5SNo
         icTgQ90bUbog/e3pvTPWVYvKj0whMhV0pmDTZAD6q9UUB33a2/sTE/Bn83czQPkaG5Dk
         zOPENQbnsd8bX+Cxfqu/JfXlsDtc56VHpUkfPuLLmvM2clbXFlLbCwtFJzM5rYUMnPqL
         ilDSzUQUuN8/BbU2AlcWwdrueD0qyb/hwJVUCfZtBdTG3SZagdA1JoKjtpVbyJ24gmBI
         h4nGzWA1O7ww1JY379C4p95XrVH3BFIkZ7tMgAVMm3j1+rKEXj3BX4pgZdnfu4p7TRR5
         vAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775960853; x=1776565653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zcJawOFnHtEXmwU7Ts86h653zGkHF4K3zLulupg+ZRE=;
        b=KhcZ+fLWVVrjSjPDDrJp3GLLGMGpNg6xL9ur7H6Z5k+TIM/tOErUXmkUygOEqT7iGD
         omkagPUCIcaCYUgGMoByiod8EZi81g9kM++EgpraKN5vLFGETWRSKonNMsxFcRQphEHb
         6uVa+IZcLOdMhrBu9DAczeIO9ox2ONSFcoiCJJVr3InOiGQ6pTAaE5/JPSxgOj6xV+F9
         qG9717KmV7HSR3on5iWAFuDiFVn9JgFVOsZMhAHQ7GeMZVq7VeE3nSQcMM7yXlUAx8sJ
         HgyP9CHaNB3fay078Dg7MS9ePtLHAD/78kSlR1pCQjU7Zb4AJBExJL8Jn3baOVH5JdrJ
         R7tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWkyj99hrq4vYQJXapqwaxpUZHukYhFVJbEkcxP4INDXrSoBol+ETiLmj76pjp6OcC2eU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiFlPonPrP1T8ihZONRrFNw7tglqv7lzugVvwKyOO+pYZTNcXM
	zxL37mBj3BNknKMEAezwPNjRUPdjvn4VR3IaZrl5KNkR+l8zXQxFzphO
X-Gm-Gg: AeBDieshuhgjPhKPuCEtpit+9vFzx4F4eiq/biHvnuYk68Z0gLytTYUdLuFVRgrPEZk
	JupS+5m+A618xLQqXCjGwuxblJpPMhX/f56KT4HANydzXUnSJfDD+Nn6AC7vyXKxIrWZfUsC75U
	RzA9070VuzLgkZPqcOOUxCL1WQDoZOOYqY8YeT1vQRUu3G5rpvFb994DPNm/Aw8lXDYR9666/3Y
	w8kG7NVwikMASbmbIPH9nrd0LNDholl4LyBKZH1BkfUnDQbKUZLGwAreR/6kRQ3toTrdOjNIZOU
	vzUJGgYg/QQC67ZKHFN4uemRt9WTZdzbxU8RGV0TNmNbpc3GqP7RK9yy0Rt49duNCJj+0FoQ+bD
	EcZYdK/uDuA0JgDsR/x5pVw846WA+JnYq+nMaoxIDNtmm9MWTrP3xPyr4cHl0jGaIzo+os4/Ta4
	zkekh9diJ9ewYjGm/+0EHxyci5EKAZ6FCSZ/R05uL0GdeEbFjyQRAKmDFmL0ZK+ns+iauxdbWgQ
	sPqRBeXAw==
X-Received: by 2002:a05:7022:517:b0:128:dab3:f528 with SMTP id a92af1059eb24-12c34e892c2mr4994180c88.8.1775960852898;
        Sat, 11 Apr 2026 19:27:32 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c34352490sm8757860c88.0.2026.04.11.19.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 19:27:32 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH bpf v4 2/2] selftests/bpf: Add test for arena VMA use-after-free on fork
Date: Sat, 11 Apr 2026 19:27:15 -0700
Message-ID: <20260412022714.1955495-4-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412022714.1955495-2-bestswngs@gmail.com>
References: <20260412022714.1955495-2-bestswngs@gmail.com>
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

