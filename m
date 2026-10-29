Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309208;
	b=WIsMGjmqNOB/3ehO6x8P+UzYbrfkg8pCoi09ac2ZhEhaHJTxsCUOqKm6djg1XsUsaJlW
	 efMjrc6nfEPksBKQnV7HJQVdUXnWlwuIt17mb8cjmhYPIVOifmjsS9f1ZgILs3sftWYXK
	 2KXvYYhYKMpg+VfYpdsF2a6qq/rFpDgNptoMsdAU2KQyPtMpUCJIAxBJDwlSAGtzKayVD
	 a4wH6vsSwSL4at695c03geXDttbP3gwvA+PkKqCL4fycFcmcffK6Q9bnUw/LJV3TLqK/g
	 S3cnH8iZVWm6kye8EXGdG54YKDRhzkXhkK3T2B0LRiertjoyuUhdpmlYGX5Y3q3Hl4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309208;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6GIXnWvCtigyBOTVDy1Tlr37tAPRJsMHaGhKWB8kSsg=;
	b=x+mtORxQQPYwRsTmztnr0vY+AMQKrnIKAkIkZHu/oWnWQZ+kdJhw757AzCBN0Tpuyjnq
	 imsdlLa/8D+TgYhwlGFRVg/gX6imR3lorb0KMGaUCCzLhLurbqQObCyNduqWibzOI+NjA
	 9FftI/f3MJJnq4A7/lDweVK7n5NibmlgXiVijkdKizLJnx50SfgbXlgpVuBMEX5drjsCm
	 6QYrpYci3zdm0oKWg1v3uMVSqcNY4Ta16bF9H4/EeLwGniW7csnyrrghkl85ZxOD4GSYA
	 o0PS5UVHH/bMZbJ4rlVuDeuxcliPNm1rgjNqHuHcH0mpU73LkRRDrYeQC9ulhKorKww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MI+idkzt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5453606A31A
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 21:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MI+idkzt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC391F01816;
	Thu, 29 Oct 2026 21:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793309207;
	bh=6GIXnWvCtigyBOTVDy1Tlr37tAPRJsMHaGhKWB8kSsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MI+idkztAD8H4pfTpuuHr7kX8q3fLrNvou2lanQJsS5BAm2TIJmH1noglZiCDdZIb
	 X8IHfo/FOk9qbs3vLl6ZL2wqt0X6nniSUF24yBjItZPI21Sthn27Wb/aAraZSLXudj
	 DdiSv3FgiOvXj0k01dxw+1sPSa/Xg/hco2AhAnHK1TaFGUEKeDHJBH5GsSiWcgSzwA
	 yktgJxxkpokqWrzs8brRPniAKrXCpcBznKkcpATtHss6Tv++oT4AAsYWhpwEgPA0Ex
	 v+Of/IQGHZAYW9ejHFKaZ+auZfxoU+QJ4sebJlopnOsaV0FogWlLTHG1Ag7pBO4QDI
	 28BF1LnBf5GdQ==
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
Subject: [PATCH bpf-next 5/8] selftests/bpf: Test user memory mmap kfuncs
Date: Thu, 29 Oct 2026 22:25:48 +0100
Message-ID: <20261029212551.56964-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029212551.56964-1-jolsa@kernel.org>
References: <20261029212551.56964-1-jolsa@kernel.org>
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

Add BPF selftests for bpf_user_mmap and bpf_user_munmap from a
sleepable uprobe. Check that created mappings have the requested
permissions and that unmapped addresses are no longer mapped.

Assisted-by: Codex:GPT-6
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 Documentation/bpf/kfuncs.rst                  |  17 +++
 .../selftests/bpf/prog_tests/user_mem.c       | 112 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/user_mem.c  |  43 +++++++
 3 files changed, 172 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/user_mem.c
 create mode 100644 tools/testing/selftests/bpf/progs/user_mem.c

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index d22b6bb3df2e..0c46c95d4918 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -989,3 +989,20 @@ the verifier. bpf_cgroup_ancestor() can be used as follows:
 BPF provides a set of kfuncs that can be used to query, allocate, mutate, and
 destroy struct cpumask * objects. Please refer to :ref:`cpumasks-header-label`
 for more details.
+
+4.4 User memory kfuncs
+----------------------
+
+The user memory kfuncs operate on the current process's address space.
+``bpf_copy_to_user()`` writes to this address space, including private mappings
+that are not writable. A partial copy is not rolled back if it faults.
+
+``bpf_user_mmap()`` and ``bpf_user_munmap()`` create and remove mappings by
+calling the kernel's mapping functions directly rather than issuing
+``mmap(2)`` or ``munmap(2)`` syscalls. As a result, seccomp filters do not
+mediate these mapping operations. A seccomp filter can still allow or deny the
+syscall that triggers a BPF program, but it cannot separately filter the
+mapping performed by these kfuncs.
+
+.. kernel-doc:: kernel/bpf/helpers.c
+   :identifiers: bpf_copy_to_user bpf_user_mmap bpf_user_munmap
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
index 000000000000..a6b4f922da49
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
+extern unsigned long bpf_user_mmap(unsigned long len, unsigned long prot) __ksym;
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
+		user_addr = bpf_user_mmap(map_len, map_prot);
+		break;
+	case USER_MEM_UNMAP:
+		ret = bpf_user_munmap(user_addr, map_len);
+		break;
+	}
+
+	return 0;
+}
-- 
2.54.0

