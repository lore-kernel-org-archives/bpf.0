Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871214;
	b=BJLT5BAYaUe1qD38VpXJAs/pSaqWNEv3Uqv7O2BR+kPRHEQHpe0XquMyYczfcpkksnCO
	 JQ9QiPrr+HxvH+5ScQFW348eQLTtOluMT4S0y6wmAk0r4OsyqEdnUoBR6ah6v7BlybBga
	 ZvKz1do4uiMBfE4IjxA8sQ5nfgG4HPEyo/+8gqhHHsr0BtTOMlqCQysSOGAlrUsG0rYGo
	 bNgGqYZAZTx/C3NX2gzPZa0uPn8HpMhRZ05q7TmjHRh+yl05PItt5mp6fv/1ranLTrz9V
	 et+TXyXIC0yzbVnGN0v7+bRzMb3pMbnOAPWFsfLc/LFPkVVzYmzwG/bpYcNXwMYQX1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871214;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=S0zVaJcsuDLt5rMmcToOrUUwizcmQnC1UO5eAX1EQyQ=;
	b=hiAdd0ibAJcgxdLEJMW8L0WLL+JA5B0xX8ZZev70Z0kDtoIqNRNwTJVh7ndz/in30tXU
	 GF58R/FtH4fIZjjgii3/rkHrhztb3MdMfqovYe83Q8Givbhp3Gk+MNvOGQYEZ//IPvjI/
	 VRZ68ZV77brV3wra3yqtfUE/4ARwm1S/nC+WpYnuZyCPXmpjfnQ2yEWrJdhpi5wgnXDjH
	 PuoLaWiHjNnJW2QX1ISeBVUoiDMyWrBmOjl9sTltIV7DVRRnkl30Gg/4TT5aW2w856wtL
	 xIYXtU2iMSgNvdZAxK6iLaVMFGf3fzEmd75DPmz1h+PXO2xN9NLyXF40CHM7n0+KC4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=VO40U5+M;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B1F606A31B;
	Thu,  5 Nov 2026 09:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70B1F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=VO40U5+M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=S0
	zVaJcsuDLt5rMmcToOrUUwizcmQnC1UO5eAX1EQyQ=; b=VO40U5+Mfje3P6BHpl
	vBy6yBMmr74pr5NRUgxG4KadHUVod/sUDEMQqpMkrqZUokNH+0VaT/jCsKT2EdF2
	l4ndD1tNoEfVLspwH8HuATrnETITW5kv2Vs2HVopJN+vD7tw+uKsoNmVZX5ueKrI
	5ckJEaOy0bIOFBymbC1O43bVI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCXnyQcTexqw6hoFQ--.43864S3;
	Thu, 05 Nov 2026 17:32:15 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: song@kernel.org,
	jolsa@kernel.org,
	ihor.solodrai@linux.dev,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	emil@etsalapatis.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Test faulting build IDs from a sleepable raw tracepoint
Date: Thu,  5 Nov 2026 17:32:12 +0800
Message-Id: <20261105093212.826479-2-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261105093212.826479-1-yangfeng59949@163.com>
References: <20261105093212.826479-1-yangfeng59949@163.com>
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
X-CM-TRANSID:_____wCXnyQcTexqw6hoFQ--.43864S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3tryrWF1kKFWrurWUCw1UAwb_yoWDCrW8pa
	s2kryYyF4fGr1Fvrn7G3yDXFWFvr4kXa47CayfJr9xZw17Jrn8KF4xKF4jqFnxJrZ3Wws0
	93s5t3y5ArW7ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jIa0PUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbCzx8wqGrsTR9a9QAA3z

From: Feng Yang <yangfeng@kylinos.cn>

Extend the build_id test with a sleepable raw tracepoint on sys_enter.
A helper process pages out the build ID page and issues a getpid()
syscall; the BPF program filters on the target tgid and syscall id,
records only the first hit, and captures the user stack with
BPF_F_USER_BUILD_ID.  The test asserts that one of the frames carries
uprobe_multi's build ID.

Frame 0 is libc's syscall wrapper, so reaching uprobe_multi needs user
stack unwinding; build uprobe_multi with -mbackchain on s390, where the
unwinder follows backchains.  The non-sleepable control requires at least
one BPF_STACK_BUILD_ID_IP frame, so it cannot pass just because the walk
never reached uprobe_multi.

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 tools/testing/selftests/bpf/Makefile          |   4 +-
 .../selftests/bpf/prog_tests/build_id.c       | 134 ++++++++++++++++++
 .../selftests/bpf/progs/test_build_id.c       |  46 ++++++
 tools/testing/selftests/bpf/uprobe_multi.c    |  37 ++++-
 4 files changed, 216 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 77682bf28c6e..367166383246 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -650,7 +650,9 @@ $(OUTPUT)/veristat: $(OUTPUT)/veristat.o
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
 
 # Linking uprobe_multi can fail due to relocation overflows on mips.
-$(OUTPUT)/uprobe_multi: CFLAGS += $(if $(filter mips, $(ARCH)),-mxgot)
+# s390's user unwinder follows backchains, keep them for the build_id test.
+$(OUTPUT)/uprobe_multi: CFLAGS += $(if $(filter mips, $(ARCH)),-mxgot) \
+				$(if $(filter s390 s390x, $(ARCH)),-mbackchain)
 $(OUTPUT)/uprobe_multi: uprobe_multi.c uprobe_multi.ld
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) -Wl,-T,uprobe_multi.ld -O0 $(LDFLAGS) 	\
diff --git a/tools/testing/selftests/bpf/prog_tests/build_id.c b/tools/testing/selftests/bpf/prog_tests/build_id.c
index aec9c8d6bc96..98e3d0998179 100644
--- a/tools/testing/selftests/bpf/prog_tests/build_id.c
+++ b/tools/testing/selftests/bpf/prog_tests/build_id.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <signal.h>
+#include <sys/syscall.h>
 #include <test_progs.h>
 
 #include "test_build_id.skel.h"
@@ -104,6 +106,134 @@ static void subtest_sleepable(void)
 	test_build_id__destroy(skel);
 }
 
+static bool stack_has_build_id(const struct bpf_stack_build_id *stack, int frame_cnt,
+			       const char *id, int id_sz)
+{
+	int i;
+
+	for (i = 0; i < frame_cnt; i++)
+		if (stack[i].status == BPF_STACK_BUILD_ID_VALID &&
+		    !memcmp(stack[i].build_id, id, id_sz))
+			return true;
+
+	return false;
+}
+
+static bool stack_has_ip(const struct bpf_stack_build_id *stack, int frame_cnt)
+{
+	int i;
+
+	for (i = 0; i < frame_cnt; i++)
+		if (stack[i].status == BPF_STACK_BUILD_ID_IP)
+			return true;
+
+	return false;
+}
+
+/*
+ * Fork uprobe_multi, let it page out the build ID page and issue the
+ * filtered syscall.  target_tgid/target_syscall are set before the child is
+ * released, so only its getpid() is recorded, and the BPF program records
+ * only the first hit.
+ */
+static int run_uprobe_multi_syscall(struct test_build_id *skel)
+{
+	char c = 'x';
+	int pfd[2], status, err;
+	pid_t pid;
+
+	if (pipe(pfd))
+		return -errno;
+
+	pid = fork();
+	if (pid < 0) {
+		err = -errno;
+		close(pfd[0]);
+		close(pfd[1]);
+		return err;
+	}
+	if (pid == 0) {
+		close(pfd[1]);
+		if (read(pfd[0], &c, 1) != 1)
+			_exit(127);
+		close(pfd[0]);
+		execl("./uprobe_multi", "uprobe_multi", "paged-out-syscall", NULL);
+		_exit(127);
+	}
+
+	close(pfd[0]);
+	skel->bss->target_tgid = pid;
+	skel->bss->target_syscall = SYS_getpid;
+	if (write(pfd[1], &c, 1) != 1) {
+		err = -errno;
+		close(pfd[1]);
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
+		return err;
+	}
+	close(pfd[1]);
+
+	if (waitpid(pid, &status, 0) < 0)
+		return -errno;
+	if (WIFEXITED(status))
+		return WEXITSTATUS(status);
+	return -1;
+}
+
+static void subtest_raw_tp(bool sleepable)
+{
+	struct test_build_id *skel;
+	struct bpf_stack_build_id *stack;
+	int frame_cnt, err, res;
+
+	skel = test_build_id__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	if (sleepable) {
+		skel->links.rawtp_sleepable = bpf_program__attach(skel->progs.rawtp_sleepable);
+		if (!ASSERT_OK_PTR(skel->links.rawtp_sleepable, "attach_rawtp_sleepable"))
+			goto cleanup;
+	} else {
+		skel->links.rawtp_nofault = bpf_program__attach(skel->progs.rawtp_nofault);
+		if (!ASSERT_OK_PTR(skel->links.rawtp_nofault, "attach_rawtp_nofault"))
+			goto cleanup;
+	}
+
+	err = run_uprobe_multi_syscall(skel);
+	if (err == 2) {
+		/* could not evict the build ID page, nothing to test */
+		test__skip();
+		goto cleanup;
+	}
+	if (!ASSERT_OK(err, "trigger_uprobe_multi"))
+		goto cleanup;
+
+	if (sleepable) {
+		res = skel->bss->res_rawtp_sleepable;
+		stack = skel->bss->stack_rawtp_sleepable;
+	} else {
+		res = skel->bss->res_rawtp_nofault;
+		stack = skel->bss->stack_rawtp_nofault;
+	}
+	frame_cnt = res / sizeof(struct bpf_stack_build_id);
+	if (env.verbosity >= VERBOSE_NORMAL)
+		print_stack(stack, frame_cnt);
+
+	ASSERT_GT(frame_cnt, 0, "frames");
+	if (sleepable) {
+		ASSERT_TRUE(stack_has_build_id(stack, frame_cnt, build_id, build_id_sz),
+			    "sleepable_build_id");
+	} else {
+		ASSERT_TRUE(stack_has_ip(stack, frame_cnt), "nofault_has_ip");
+		ASSERT_FALSE(stack_has_build_id(stack, frame_cnt, build_id, build_id_sz),
+			     "nofault_has_build_id");
+	}
+
+cleanup:
+	test_build_id__destroy(skel);
+}
+
 void serial_test_build_id(void)
 {
 	build_id_sz = read_build_id("uprobe_multi", build_id, sizeof(build_id));
@@ -115,4 +245,8 @@ void serial_test_build_id(void)
 		subtest_nofault(true /* resident */);
 	if (test__start_subtest("sleepable"))
 		subtest_sleepable();
+	if (test__start_subtest("raw-tp-nofault-paged-out"))
+		subtest_raw_tp(false /* non-sleepable */);
+	if (test__start_subtest("raw-tp-sleepable-paged-out"))
+		subtest_raw_tp(true /* sleepable */);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_build_id.c b/tools/testing/selftests/bpf/progs/test_build_id.c
index 32ce59f9aa27..7c44195de875 100644
--- a/tools/testing/selftests/bpf/progs/test_build_id.c
+++ b/tools/testing/selftests/bpf/progs/test_build_id.c
@@ -3,6 +3,7 @@
 
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
 
 struct bpf_stack_build_id stack_sleepable[128];
 int res_sleepable;
@@ -28,4 +29,49 @@ int uprobe_sleepable(struct pt_regs *ctx)
 	return 0;
 }
 
+struct bpf_stack_build_id stack_rawtp_sleepable[128];
+int res_rawtp_sleepable;
+
+struct bpf_stack_build_id stack_rawtp_nofault[128];
+int res_rawtp_nofault;
+
+int target_tgid;
+int target_syscall;
+
+SEC("raw_tp/sys_enter")
+int BPF_PROG(rawtp_nofault, struct pt_regs *regs, long id)
+{
+	if ((u32)(bpf_get_current_pid_tgid() >> 32) != (u32)target_tgid ||
+	    id != target_syscall)
+		return 0;
+
+	/* Record only the first hit, a later getpid() must not overwrite it. */
+	if (res_rawtp_nofault)
+		return 0;
+
+	res_rawtp_nofault = bpf_get_stack(ctx, stack_rawtp_nofault,
+					  sizeof(stack_rawtp_nofault),
+					  BPF_F_USER_STACK | BPF_F_USER_BUILD_ID);
+
+	return 0;
+}
+
+SEC("raw_tp.s/sys_enter")
+int BPF_PROG(rawtp_sleepable, struct pt_regs *regs, long id)
+{
+	if ((u32)(bpf_get_current_pid_tgid() >> 32) != (u32)target_tgid ||
+	    id != target_syscall)
+		return 0;
+
+	/* Record only the first hit, a later getpid() must not overwrite it. */
+	if (res_rawtp_sleepable)
+		return 0;
+
+	res_rawtp_sleepable = bpf_get_stack(ctx, stack_rawtp_sleepable,
+					    sizeof(stack_rawtp_sleepable),
+					    BPF_F_USER_STACK | BPF_F_USER_BUILD_ID);
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/uprobe_multi.c b/tools/testing/selftests/bpf/uprobe_multi.c
index 0af330b6c364..6e37ba757157 100644
--- a/tools/testing/selftests/bpf/uprobe_multi.c
+++ b/tools/testing/selftests/bpf/uprobe_multi.c
@@ -5,6 +5,7 @@
 #include <stdbool.h>
 #include <stdint.h>
 #include <sys/mman.h>
+#include <sys/syscall.h>
 #include <unistd.h>
 #include <sdt.h>
 
@@ -95,12 +96,12 @@ static int usdt(void)
 extern char build_id_start[];
 extern char build_id_end[];
 
-int __attribute__((weak)) trigger_uprobe(bool build_id_resident)
+/* Returns 2 if the build ID page could not be evicted. */
+static int prep_build_id_page(bool build_id_resident)
 {
 	int page_sz = sysconf(_SC_PAGESIZE);
-	void *addr;
-
 	unsigned char vec[1];
+	void *addr;
 	int poll = 0;
 
 	/* page-align build ID start */
@@ -123,12 +124,38 @@ int __attribute__((weak)) trigger_uprobe(bool build_id_resident)
 			poll++;
 			usleep(100);
 		} while (poll < 500);
+		if (vec[0] & 1)
+			return 2;
 	}
+	return 0;
+}
+
+int __attribute__((weak)) trigger_uprobe(bool build_id_resident)
+{
+	(void)prep_build_id_page(build_id_resident);
+
 	(void)uprobe();
 
 	return 0;
 }
 
+int __attribute__((weak)) trigger_syscall(void)
+{
+	int err = prep_build_id_page(false /* page-out build ID */);
+
+	if (err)
+		return err;
+
+	/*
+	 * The BPF program under test filters on this syscall and records only
+	 * its first hit, so later getpid() calls (e.g. from exit paths) cannot
+	 * overwrite the captured stack.
+	 */
+	(void)syscall(SYS_getpid);
+
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	if (argc != 2)
@@ -142,10 +169,12 @@ int main(int argc, char **argv)
 		return trigger_uprobe(false /* page-out build ID */);
 	if (!strcmp("uprobe-paged-in", argv[1]))
 		return trigger_uprobe(true /* page-in build ID */);
+	if (!strcmp("paged-out-syscall", argv[1]))
+		return trigger_syscall();
 
 error:
 	fprintf(stderr,
-		"usage: %s <bench|usdt|uprobe-paged-out|uprobe-paged-in>\n",
+		"usage: %s <bench|usdt|uprobe-paged-{in,out}|paged-out-syscall>\n",
 		argv[0]);
 	return -1;
 }
-- 
2.25.1

