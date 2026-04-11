Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852C1342144
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775907002; cv=none; b=qHdQwMkVPi/PBVPCmULvvOeMcng1S2wRM3Ah+B9v53c5ukjPgkidr2VM0IYzAnWMo13QujoO+vq86JTLkO6Gxi5PQmHVFb0PuidqX7lxucb19IpyaLzSdJxw5+aT1Vu6bp1XpBQWEE4uUK2LKEea3wCDOrBkt0Sw5kw4gYKWESM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775907002; c=relaxed/simple;
	bh=VDleVhlM+AWXVtS+vsFZ+Rmbunt7uexH//AXGlq39F8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FmH7jVi7R1x4vMQGudN2uNQcS3v8524fGcb+CZMR3VE2zgi5HSEMdnN1kIKJ6ZgqR/93vZ/Yy5c/b3rXa3hulcbWfC/kCqkoUwfndsEbhpqUsOgsXW7jwiDjv5wiDwuL9dSdZ3B2nIhHykvxvmaqrCl2HI2muHyM3/BKt23T6k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPi4ZK9b; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPi4ZK9b"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2d5ead6a34eso1890779eec.0
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 04:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775907001; x=1776511801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SR6PIjf9ygKKS8EPk3SHWBc5/ngwD0asCwUuSLZOTMk=;
        b=dPi4ZK9bL1jsP2PQleR4JlzWn2cP+4Rq402WRoDXD6Om2g56yQoNShZyrdkFHKKGrD
         PM3aiTFlLuMXapBvXxO3+9sVarqf7fw7mEoVjTHHNT1LKTKhACbwWxFeC8Ez42iDUv8X
         Dx5RqJVe8ghH9zrl8oL5wwI7OCuZwvO8yNb1EQy5+8X7Caf1ILsEdJSowe+f8oKfYIv0
         mTLiPTSUUmP0sPjmuQQetG80plmegjYk9iIdAW1sIIV43l8nieP+1kYmfuJhTTISCuSi
         PDpz6wZ54SZlhuKhheCR5Ac/M91LjaPVWCdP8wQkWEzQG2vyU87OLVnLUU30ZX+HsnIv
         zmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775907001; x=1776511801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SR6PIjf9ygKKS8EPk3SHWBc5/ngwD0asCwUuSLZOTMk=;
        b=JcM5jBe4mnHGApbyz2UAXDT+7y+JmcH1dkQycH9XfXsHEBbLPpndqG99BQWZFMHEAx
         IMIWDhJw1qRp+ap3ZpPyrwNQ/6kQpuagE3Jj2mp4ShfmKofTAonsWHF2zk47ecnBykY8
         SefzVfOy+ioNRqSnR/GhGLNWMMHS0zKrzRibUIdcA47C7BD0gf45SgP1pdMB7drZQvbn
         HBKNAq4NN9c7faeoNsDQwmfw7y9YstLwt/KmA6AZ9DAjjlauRciUpoEHyycN6OaGuijr
         4iPE2rrTtTiw8Bl+uKMRp9G0NzC+sFr/2Gna1H1R5qvYs/WeuawAd6oJpxe1i9AyjXgG
         az+w==
X-Forwarded-Encrypted: i=1; AJvYcCVdZoNNyF9FULtWtVXQYbz991wpwKdKWA4lzdap2kQOmfAqz+zxrd9c2GLTiAcBUpFOVCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLJYbzBtyviuIKQBZCem4v7n94771QHWaFBIgkUfpYF+vf36kM
	BwQfCvkoZz03/jy6JllEvgtF8CL2AIe43Ldmv376NLz9Y9UquKjOs8FZ
X-Gm-Gg: AeBDieuZ9xyM52TyGwfUnmSCWSs634yGBUXpF+I6oK+l/cbv0dt7ZM6683z9ZVDrtPu
	9jYVUya9KNuqg9na455JyFBEGcRpy+TnvdPxOIKGMGvTtQWtt1wu1Ewlo5GDsefHMBAnryryRPZ
	BToLzn2r9IB6I+UASys2MackvxNshd2u6wd0dnzW0CxXpwOwwPcyamZkPES2BIkNH/SnXhTmbVl
	JAnMxdLcR7XDnt0aKEHaNENvUa/n8YnzYFJovIdwd0DHF1WGREhrhDA93TB5+CgZihBXd3wE9yT
	EyTIOYh9GENL6MbttjkMGx2ezMSv0LgeMEQg3x1CC/BJruat/xakedus6QizlxRc0TjsLcTkcHZ
	b13pbTRPXy/60Xq6ToRlNRQ8AGXUln8skyvkpHgTlh5xZJKl369P4EqGZL9Kj18dnFES20JHOuA
	PIW9L0VpMRWdIraI1b4A0VOT61a+Px9QqsDS6EAHlwU1kI6ycgWrRFdgzjBs78izPS77yDvh28/
	tUGRL2s5A==
X-Received: by 2002:a05:7022:ec1:b0:119:e56c:18a5 with SMTP id a92af1059eb24-12c34ea3102mr3488971c88.13.1775907000497;
        Sat, 11 Apr 2026 04:30:00 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c345b5b9dsm6379097c88.7.2026.04.11.04.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 04:29:59 -0700 (PDT)
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
Subject: [PATCH bpf v2 2/2] selftests/bpf: Add test for arena VMA use-after-free on fork
Date: Sat, 11 Apr 2026 04:29:44 -0700
Message-ID: <20260411112944.1455470-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411112944.1455470-1-bestswngs@gmail.com>
References: <20260411112944.1455470-1-bestswngs@gmail.com>
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

