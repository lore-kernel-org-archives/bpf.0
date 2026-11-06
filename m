Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793952555;
	b=YFQ4/ehKJh2lqazcl6Eo7UPHLHCJyzKD6Mrbu3tKtSjVCoZHuWtycI76n/NLBwOiI0K8
	 M1kQN3u2BwzWGKs2Kd5SeLDoKPi53bPK3Zq6VmZfa3A0ZtiYHk6jLjnRweEa/Ig2h81X4
	 4yJmmUteX8Tkz2bqxvt04DwgphHlzKLJupXMSJ0Bd0pl9D3zqcd5CP/evbcI9l29HiSgz
	 Hjy5JOryknIlHNO7BJ3MjePseJpesh6aXoJIBgDx2m1JKCNklhtXCBHuoLkDb/+Nccx/q
	 OPL5XPVfVvpILN0S7axDwZDjYX/kD341kUgd8hDq27zjzWvg5VnTtzY10HMwOYIDNWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793952555;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=8cQJRjuJZjfS3dtk4tvwtXg7WvZMrMz9+LDBNHLTQWc=;
	b=YwO7BTIOaQ38XWZ7yppDCd3hIEmPiKSe3+SGvZ0plvfRiHJGeWg/JcKN0WMt6ya7BeYJ
	 IHpNYYfXA/791Mlg+QlFyFbHsGJrw4iLr5gVtdoIKCBM+Kq0KSXbIv3Kuuzy1yKU6Tppf
	 aGs68hqTcOW/suG7vCY7MVtlrrZdUZ79pnwacKFysL7Vd9UWYXDcNQazvztzd9ob4uDmp
	 O7MHFRCWy7bHvxTzhVVNdCeZ3inSMPoao3kphvuskFuBDR5ad6RjSQKQ+KpLqhZGsHcZk
	 HKb93YooK0uMWwL83Dx8ISyMVmeurdPx8Sp7H2OCYiGdEdN+gGraT+8zFIie7iT0gpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1901E606A326;
	Fri,  6 Nov 2026 08:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1901E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=8c
	QJRjuJZjfS3dtk4tvwtXg7WvZMrMz9+LDBNHLTQWc=; b=dwC+YJMIOyt2PGhQBe
	UtZnTTMb6YAUXd/hYq0nRfijMhfCW5Knpg1JN9idXFULRCpW3ELNdodrXFtIEAbF
	HFIoasqQ+elQsRVWdncE/FyBNL8I42A3B2CE67cLPix5MdSnjazFYyBYgvZB4vk8
	QLncM+Mjcxq2ugFf3GIIXniXw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3v47Siu1qAmURFg--.23264S3;
	Fri, 06 Nov 2026 16:07:49 +0800 (CST)
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
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: Test faulting build IDs from a sleepable raw tracepoint
Date: Fri,  6 Nov 2026 16:07:46 +0800
Message-Id: <20261106080746.661431-2-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261106080746.661431-1-yangfeng59949@163.com>
References: <20261106080746.661431-1-yangfeng59949@163.com>
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
X-CM-TRANSID:_____wD3v47Siu1qAmURFg--.23264S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3tryxZF4DXrW3tF4kKw43GFg_yoWDurWxpa
	s2kryYyr4fJF1Fvrn7GrWDXFWFvrs5Xa47Ca4fJr9xZw1Dtrn3tF4xKFWUtFnxJrZ3Ww45
	u3s3tws8urW7ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jIa0PUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC0BbtZmrtitb3HAAA39

From: Feng Yang <yangfeng@kylinos.cn>

Extend the build_id test with a sleepable raw tracepoint on sys_enter.
A helper process pages out the build ID page and issues a getpgid()
syscall with an invalid argument; the BPF program filters on the syscall
id and that argument, records only the first hit, and captures the user
stack with BPF_F_USER_BUILD_ID.  The test asserts that one of the frames
carries uprobe_multi's build ID.

Frame 0 is libc's syscall wrapper, so reaching uprobe_multi needs user
stack unwinding; build uprobe_multi with -mbackchain on s390, where the
unwinder follows backchains.  The non-sleepable control requires at least
one BPF_STACK_BUILD_ID_IP frame. If MADV_PAGEOUT cannot evict the page,
the affected subtests are skipped rather than failing.

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 tools/testing/selftests/bpf/Makefile          |  4 +-
 tools/testing/selftests/bpf/build_id.h        | 13 +++
 .../selftests/bpf/prog_tests/build_id.c       | 88 +++++++++++++++++++
 .../selftests/bpf/progs/test_build_id.c       | 52 +++++++++++
 tools/testing/selftests/bpf/uprobe_multi.c    | 39 +++++++-
 5 files changed, 191 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/build_id.h

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
diff --git a/tools/testing/selftests/bpf/build_id.h b/tools/testing/selftests/bpf/build_id.h
new file mode 100644
index 000000000000..f5edc3670be2
--- /dev/null
+++ b/tools/testing/selftests/bpf/build_id.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BUILD_ID_H
+#define __BUILD_ID_H
+
+/*
+ * The helper issues getpgid() with this (nonexistent) pid after paging out the
+ * build ID page.  The BPF program filters on the syscall id and this argument,
+ * so getpid()/read() etc. issued before the page-out cannot be mistaken for it.
+ */
+#define TARGET_SYSCALL_ARG	0x7ffffffeUL
+
+#endif /* __BUILD_ID_H */
+
diff --git a/tools/testing/selftests/bpf/prog_tests/build_id.c b/tools/testing/selftests/bpf/prog_tests/build_id.c
index aec9c8d6bc96..e97a651b5aa7 100644
--- a/tools/testing/selftests/bpf/prog_tests/build_id.c
+++ b/tools/testing/selftests/bpf/prog_tests/build_id.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <sys/syscall.h>
 #include <test_progs.h>
 
 #include "test_build_id.skel.h"
@@ -104,6 +105,89 @@ static void subtest_sleepable(void)
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
+static void subtest_raw_tp(bool sleepable)
+{
+	struct test_build_id *skel;
+	struct bpf_stack_build_id *stack;
+	int frame_cnt, status, res;
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
+	skel->bss->target_syscall = SYS_getpgid;
+	status = system("./uprobe_multi paged-out-syscall");
+	if (!ASSERT_NEQ(status, -1, "trigger_uprobe_multi"))
+		goto cleanup;
+	if (WIFEXITED(status) && WEXITSTATUS(status) == 2) {
+		/* could not evict the build ID page, nothing to test */
+		test__skip();
+		goto cleanup;
+	}
+	if (!ASSERT_OK(status, "trigger_uprobe_multi"))
+		goto cleanup;
+
+	if (sleepable) {
+		res = skel->bss->res_rawtp_sleepable;
+		stack = skel->bss->stack_rawtp_sleepable;
+	} else {
+		res = skel->bss->res_rawtp_nofault;
+		stack = skel->bss->stack_rawtp_nofault;
+	}
+	if (!ASSERT_GT(res, 0, "res"))
+		goto cleanup;
+
+	frame_cnt = res / sizeof(struct bpf_stack_build_id);
+	if (env.verbosity >= VERBOSE_NORMAL)
+		print_stack(stack, frame_cnt);
+
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
@@ -115,4 +199,8 @@ void serial_test_build_id(void)
 		subtest_nofault(true /* resident */);
 	if (test__start_subtest("sleepable"))
 		subtest_sleepable();
+	if (test__start_subtest("raw-tp-nofault-paged-out"))
+		subtest_raw_tp(false /* non-sleepable */);
+	if (test__start_subtest("raw-tp-sleepable-paged-out"))
+		subtest_raw_tp(true /* sleepable */);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_build_id.c b/tools/testing/selftests/bpf/progs/test_build_id.c
index 32ce59f9aa27..53e88a99d214 100644
--- a/tools/testing/selftests/bpf/progs/test_build_id.c
+++ b/tools/testing/selftests/bpf/progs/test_build_id.c
@@ -2,7 +2,11 @@
 /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
 
 #include "vmlinux.h"
+#include <bpf/bpf_core_read.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "build_id.h"
 
 struct bpf_stack_build_id stack_sleepable[128];
 int res_sleepable;
@@ -28,4 +32,52 @@ int uprobe_sleepable(struct pt_regs *ctx)
 	return 0;
 }
 
+struct bpf_stack_build_id stack_rawtp_sleepable[128];
+int res_rawtp_sleepable;
+
+struct bpf_stack_build_id stack_rawtp_nofault[128];
+int res_rawtp_nofault;
+
+int target_syscall;
+
+static __always_inline bool is_target_syscall(struct pt_regs *regs, long id)
+{
+	return id == target_syscall &&
+	       (unsigned long)PT_REGS_PARM1_CORE_SYSCALL(regs) == TARGET_SYSCALL_ARG;
+}
+
+SEC("raw_tp/sys_enter")
+int BPF_PROG(rawtp_nofault, struct pt_regs *regs, long id)
+{
+	if (!is_target_syscall(regs, id))
+		return 0;
+
+	/* Record only the first hit, a later match must not overwrite it. */
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
+	if (!is_target_syscall(regs, id))
+		return 0;
+
+	/* Record only the first hit, a later match must not overwrite it. */
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
index 0af330b6c364..c6ec45875574 100644
--- a/tools/testing/selftests/bpf/uprobe_multi.c
+++ b/tools/testing/selftests/bpf/uprobe_multi.c
@@ -5,9 +5,12 @@
 #include <stdbool.h>
 #include <stdint.h>
 #include <sys/mman.h>
+#include <sys/syscall.h>
 #include <unistd.h>
 #include <sdt.h>
 
+#include "build_id.h"
+
 #ifndef MADV_POPULATE_READ
 #define MADV_POPULATE_READ 22
 #endif
@@ -95,12 +98,12 @@ static int usdt(void)
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
@@ -123,12 +126,38 @@ int __attribute__((weak)) trigger_uprobe(bool build_id_resident)
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
+	 * The BPF program under test filters on this syscall and its argument
+	 * and records only the first hit, so no other syscall can overwrite
+	 * the captured stack.
+	 */
+	(void)syscall(SYS_getpgid, TARGET_SYSCALL_ARG);
+
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	if (argc != 2)
@@ -142,10 +171,12 @@ int main(int argc, char **argv)
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

