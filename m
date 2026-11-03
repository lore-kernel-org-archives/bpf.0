Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692811;
	b=r+V7zbjgmCJdQgEES2zPSAvnPFwTq9+pBVLgx//ABV7rNgAMU6DVLFvzybv3SN7QaJgv
	 y+uTHAH6YfY0f7ysLcmpU3K5ngK/hYI7fvJCoh7sFfb6xfemHyNuApHj7fqMHGzjEuixz
	 Ldkbe/mLczZsQ+G4O/oImZXEdrfRWmS+dNyDKnUompIElp0AM6eyBe75xnjnrmz5m5rbH
	 zW39rhD6I2x9SkmJk25N6CSk85x7SrucrbLpIE3DXNfQvW2OQoeAdr4zndzZ2T2THihwH
	 m5by6gVlaG+iIZnZ5WE54BFdSXHUfFf4YBi3NsMU/P4oZzacQoCT0h+6nFSVB3gUgIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692811;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8if4QJZvxjPV619vIg7F/lLYGJyfqGFl5e4WbtOI0UU=;
	b=laQ7qkI8yDT7BTuRt+cbzh/r+0iPM3u59q4rC6OD+MR437DWlLxFvPwWqOFPi4xY5sVL
	 yncH2J/o6NOuRhKwdOYZs1V8/q0r871/n9YxCzEyWasQ3LstcLO3zG1lLtJgBHAqhvcLA
	 /+1s5SK0KmzNL7iHuD98kLUnfIr5l6mcq4boV+Uy3EltOswiLpBDc2459TKStqzL2Dqan
	 9r7gUciZTHTgykuepWEn06QtWSVaXSV7i088u5BnbZVbn7/Vqj/BxazurCQd0zCoZIRsH
	 zjBmpUwRpH9XAm62AHohgO3fRnnnfF6P1Rnoh02LshYa3JpzDisEBbHMQO0f0H4hW9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VfXU4KFI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE18606A32D
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VfXU4KFI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE121F000C1;
	Tue,  3 Nov 2026 08:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793692811;
	bh=8if4QJZvxjPV619vIg7F/lLYGJyfqGFl5e4WbtOI0UU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VfXU4KFIl0lOichLHprGgkUwtJ+/9IZbOr81/K4P8W8ab/jzVMV1aWn+KRyP22PHj
	 GtXwy5zhidog3MszJdvWEwFyWtE2phsVqskQHKkYzJcw2NUXj1qdWODa77v6O5EN68
	 tfhwFiAsv3L4/16Ccs8w7f/wKcK75Tmm3TDxH89Ut/CQ/rLJ6DB/c0K8McfcVSzERv
	 f2d7r6d214bpoLHiBuxzkxn9t8gHyJ/AzZBo8NDeluJXR8ccqzo51ZS42xOHe/csjU
	 A0AjoqQATR/nPWNXz+CflrIsmHwjTPqPZ8U/6DZm9Zn873JfnfTRnUR/FyJUgSLamG
	 FnSKoZGSNH1Yg==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Federico Di Pierro <nierro92@gmail.com>
Subject: [PATCHv2 bpf-next 5/8] selftests/bpf: Test user memory mmap kfuncs
Date: Tue,  3 Nov 2026 08:59:12 +0100
Message-ID: <20261103075916.100050-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103075916.100050-1-jolsa@kernel.org>
References: <20261103075916.100050-1-jolsa@kernel.org>
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

Add BPF selftests for bpf_user_anon_mmap and bpf_user_munmap from
a sleepable uprobe. Check that created mappings have the requested
permissions and that unmapped addresses are no longer mapped.

Assisted-by: Codex:GPT-6
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/user_mem.c       | 112 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/user_mem.c  |  43 +++++++
 2 files changed, 155 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/user_mem.c
 create mode 100644 tools/testing/selftests/bpf/progs/user_mem.c

diff --git a/tools/testing/selftests/bpf/prog_tests/user_mem.c b/tools/testing/selftests/bpf/prog_tests/user_mem.c
new file mode 100644
index 000000000000..f301a1843706
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/user_mem.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <sys/mman.h>
+#include <sys/personality.h>
+#include <unistd.h>
+
+#include "user_mem.skel.h"
+#include "trace_helpers.h"
+
+enum {
+	USER_MEM_MMAP = 1,
+	USER_MEM_UNMAP,
+};
+
+static noinline void user_mem_trigger(void)
+{
+	asm volatile ("" ::: "memory");
+}
+
+static bool check_user_mem_vma(void *addr, unsigned long size, const char *perms)
+{
+	size_t start, end;
+	char vma_perms[5];
+	int err;
+
+	err = get_procmap_info(addr, &start, &end, vma_perms);
+	if (!ASSERT_OK(err, "user_mem_vma"))
+		return false;
+
+	/* VMA can be merged, so ensure it covers at least the requested range. */
+	if (!ASSERT_GE(end - (size_t)addr, size, "vma_size"))
+		return false;
+
+	return !perms || ASSERT_STREQ(vma_perms, perms, "vma_perms");
+}
+
+static bool check_user_mem_unmapped(void *addr)
+{
+	size_t start, end;
+	int err;
+
+	err = get_procmap_info(addr, &start, &end, NULL);
+	return ASSERT_EQ(err, -ESRCH, "user_mem_unmapped");
+}
+
+static bool user_mem_mmap(struct user_mem *skel, unsigned long len,
+			   unsigned long prot, unsigned long *addr)
+{
+	skel->bss->map_len = len;
+	skel->bss->map_prot = prot;
+	skel->bss->action = USER_MEM_MMAP;
+	user_mem_trigger();
+
+	/* vm_mmap encodes errors in the top MAX_ERRNO unsigned-long values. */
+	if (!ASSERT_LT(skel->bss->user_addr, -4095UL, "user_addr"))
+		return false;
+
+	*addr = skel->bss->user_addr;
+	return true;
+}
+
+static bool user_mem_munmap(struct user_mem *skel, unsigned long addr,
+			   unsigned long len)
+{
+	skel->bss->user_addr = addr;
+	skel->bss->map_len = len;
+	skel->bss->action = USER_MEM_UNMAP;
+	user_mem_trigger();
+
+	return ASSERT_OK(skel->bss->ret, "user_munmap");
+}
+
+static void test_mapping(struct user_mem *skel)
+{
+	long page_size = sysconf(_SC_PAGESIZE);
+	const unsigned long len = page_size * 3;
+	unsigned long addr = ~0UL;
+
+	if (!user_mem_mmap(skel, len, PROT_READ | PROT_WRITE, &addr))
+		goto out;
+	if (!check_user_mem_vma((void *)addr, len, "rw-p"))
+		goto out;
+	if (!user_mem_munmap(skel, addr, len))
+		goto out;
+	if (!check_user_mem_unmapped((void *)addr))
+		goto out;
+	addr = ~0UL;
+
+out:
+	if (addr != ~0UL)
+		munmap((void *)addr, len);
+}
+
+void test_user_mem(void)
+{
+	struct user_mem *skel;
+
+	skel = user_mem__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	skel->bss->monitored_pid = getpid();
+	if (!ASSERT_OK(user_mem__attach(skel), "attach"))
+		goto out;
+
+	if (test__start_subtest("mapping"))
+		test_mapping(skel);
+
+out:
+	user_mem__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/user_mem.c b/tools/testing/selftests/bpf/progs/user_mem.c
new file mode 100644
index 000000000000..e3b0689f5f2a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/user_mem.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+extern unsigned long bpf_user_anon_mmap(unsigned long len, unsigned long prot) __ksym;
+extern int bpf_user_munmap(unsigned long addr, unsigned long len) __ksym;
+
+enum {
+	USER_MEM_MMAP = 1,
+	USER_MEM_UNMAP,
+};
+
+int monitored_pid;
+int action;
+int ret;
+
+unsigned long user_addr;
+unsigned long map_len;
+unsigned long map_prot;
+
+SEC("uprobe.s//proc/self/exe:user_mem_trigger")
+int user_mem_test(struct pt_regs *ctx)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != monitored_pid)
+		return 0;
+
+	switch (action) {
+	case USER_MEM_MMAP:
+		user_addr = bpf_user_anon_mmap(map_len, map_prot);
+		break;
+	case USER_MEM_UNMAP:
+		ret = bpf_user_munmap(user_addr, map_len);
+		break;
+	}
+
+	return 0;
+}
-- 
2.43.0

