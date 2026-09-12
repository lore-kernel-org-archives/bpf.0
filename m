Received: from mta0.migadu.com (out-46.mta0.migadu.com [91.218.175.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6CC41B8CC
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 09:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789207186; cv=none; b=SrIo0x4vh4BsMbX1CnhOLoCkjXSi9PA7dgpX+hQhIBJv2OANUSX5d4jj3Y2WpJkeM9M6xlpEdaXMgkI9pRrqS6ESCCxGvX/cK2dqB9rWY56XERRinTV20A5eIlrTjUUuokO9dqNWhgt4TujPwZeF7Fps9hh/NOGFDpvoQlG1kAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789207186; c=relaxed/simple;
	bh=tgZl06z7/4xhjayGkETWgxJojl5Inx70waXLFgymCrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6DIhQCYylUoe5jsPjOXlax2CObCxHhvTGJtj2CEkmFIp1HfQ3n5igvW2SRmXTsd08N0dcaOny002N3tTp8cQzDvSzNn3VLIug2NhYebJTdGjnxvX9etC+4R2cjVjLEGygUZUfDtETUjlVxb4mAx22XeKmLTie7MsdC9SLYjB/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qtevVlTo; arc=none smtp.client-ip=91.218.175.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qtevVlTo"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=tgZl06z7/4xhjayGkETWgxJojl5Inx70waXLFgymCrk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789207182; v=1; x=1789811982;
 b=qtevVlToj1pXTGvSyeTy3gQ9dqPswoKegU3R7bfx6ZEsTaivdQgFN3qDJjH+KMyGqQUYW92H
 BcN9ZsUuRUkCU+Z1wMD6ru4pb3EXHzQrPDqnjYOCVJH6E9FVFQri4MbbLWKfhTdwOnb98mjfSKn
 4yFW3fHBLHHrqujFG8l7sL1w=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bb9540d5f7ec6256;
	Sat, 12 Sep 2026 09:59:42 +0000
X-Mizu-Trace-ID: bb9540d5f7ec6256
X-Migadu-Flow: FLOW_OUT
From: "Florent Revest (Anthropic)" <florent.revest@linux.dev>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: "Florent Revest (Anthropic)" <florent.revest@linux.dev>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Junseo Lim <zirajs7@gmail.com>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2 2/2] selftests/bpf: Detach a trampoline prog while a task sleeps before it
Date: Sat, 12 Sep 2026 09:59:15 +0000
Message-ID: <20260912095924.866254-3-florent.revest@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912095924.866254-1-florent.revest@linux.dev>
References: <20260912095924.866254-1-florent.revest@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test for the use-after-free fixed by the previous commit. A
sleepable prog on bpf_fentry_test1() blocks a task on a userfaultfd
page, like bpf_mod_race does, while the prog that runs after it in the
same trampoline is detached and freed. The task is then released and
must not call into the freed prog. This is done once with fentry progs
and once with fexit progs, where the task is already past the jmp that
bpf_tramp_image_put() installs.

Without the fix, on a kernel with KASAN:

  BUG: KASAN: vmalloc-out-of-bounds in __bpf_prog_enter_recur+0xed/0x1e0
  Read of size 8 at addr ffa0000000144040 by task test_progs/171
  CPU: 6 UID: 0 PID: 171 Comm: test_progs Tainted: G           OE       7.2.0+ #1 PREEMPT(full)
  Call Trace:
   <TASK>
   __bpf_prog_enter_recur+0xed/0x1e0
   bpf_trampoline_6442545468+0x72/0xe3
   bpf_fentry_test1+0x9/0x20
   bpf_prog_test_run_tracing+0x183/0x3e0
   __sys_bpf+0xd3f/0x38f0
   ...

Assisted-by: Claude:unspecified
Signed-off-by: Florent Revest (Anthropic) <florent.revest@linux.dev>
---
 .../bpf/prog_tests/tramp_prog_detach.c        | 191 ++++++++++++++++++
 .../selftests/bpf/progs/tramp_prog_detach.c   |  56 +++++
 2 files changed, 247 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tramp_prog_detach.c
 create mode 100644 tools/testing/selftests/bpf/progs/tramp_prog_detach.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tramp_prog_detach.c b/tools/testing/selftests/bpf/prog_tests/tramp_prog_detach.c
new file mode 100644
index 000000000000..9a0e1fc44c74
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tramp_prog_detach.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <pthread.h>
+#include <poll.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <linux/userfaultfd.h>
+#include "tramp_prog_detach.skel.h"
+#include "testing_helpers.h"
+
+/*
+ * Detach and free a prog while a task sleeps in the prog that runs before it
+ * in the same trampoline image, then let that task continue through the
+ * image. It must not call into the freed prog.
+ *
+ * The task is held in a sleepable fentry prog with userfaultfd, like
+ * bpf_mod_race does.
+ */
+
+static int test_setup_uffd(void *fault_addr)
+{
+	struct uffdio_register uffd_register = {};
+	struct uffdio_api uffd_api = {};
+	int uffd;
+
+	uffd = syscall(__NR_userfaultfd, O_CLOEXEC);
+	if (uffd < 0)
+		return -errno;
+
+	uffd_api.api = UFFD_API;
+	uffd_api.features = 0;
+	if (ioctl(uffd, UFFDIO_API, &uffd_api)) {
+		close(uffd);
+		return -1;
+	}
+
+	uffd_register.range.start = (unsigned long)fault_addr;
+	uffd_register.range.len = getpagesize();
+	uffd_register.mode = UFFDIO_REGISTER_MODE_MISSING;
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffd_register)) {
+		close(uffd);
+		return -1;
+	}
+	return uffd;
+}
+
+static struct bpf_program *pick_prog(struct tramp_prog_detach *skel,
+				     bool fexit, bool sleepable)
+{
+	if (fexit)
+		return sleepable ? skel->progs.fexit_sleepable :
+				   skel->progs.fexit_victim;
+	return sleepable ? skel->progs.fentry_sleepable :
+			   skel->progs.fentry_victim;
+}
+
+static struct bpf_program *sleepable_prog;
+
+static void *run_sleepable(void *arg)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	/* calls bpf_fentry_test1() */
+	return (void *)(long)bpf_prog_test_run_opts(bpf_program__fd(sleepable_prog),
+						    &topts);
+}
+
+static struct tramp_prog_detach *load_one(bool fexit, bool sleepable)
+{
+	struct tramp_prog_detach *skel;
+	int err;
+
+	skel = tramp_prog_detach__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return NULL;
+
+	bpf_program__set_autoload(pick_prog(skel, fexit, sleepable), true);
+	err = tramp_prog_detach__load(skel);
+	if (!ASSERT_OK(err, "load"))
+		goto err;
+	skel->bss->pid = getpid();
+	err = tramp_prog_detach__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto err;
+	return skel;
+err:
+	tramp_prog_detach__destroy(skel);
+	return NULL;
+}
+
+static void test_detach(bool fexit)
+{
+	struct tramp_prog_detach *sleepable = NULL, *victim = NULL;
+	struct pollfd pfd = { .events = POLLIN };
+	struct uffdio_copy uffd_copy = {};
+	struct uffd_msg uffd_msg;
+	void *fault_page, *src_page = MAP_FAILED;
+	long page_size = getpagesize();
+	bool started = false;
+	void *thread_ret;
+	pthread_t thread;
+	int uffd = -1;
+
+	fault_page = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+			  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (!ASSERT_NEQ(fault_page, MAP_FAILED, "mmap fault_page"))
+		return;
+	src_page = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (!ASSERT_NEQ(src_page, MAP_FAILED, "mmap src_page"))
+		goto out;
+
+	/* The most recently attached prog runs first */
+	victim = load_one(fexit, false);
+	if (!victim)
+		goto out;
+	sleepable = load_one(fexit, true);
+	if (!sleepable)
+		goto out;
+	sleepable_prog = pick_prog(sleepable, fexit, true);
+
+	/* Not armed yet so this doesn't block, make sure sleepable runs first */
+	if (!ASSERT_OK((long)run_sleepable(NULL), "dry run"))
+		goto out;
+	if (!ASSERT_LT(sleepable->bss->ts, victim->bss->ts, "prog order"))
+		goto out;
+
+	uffd = test_setup_uffd(fault_page);
+	if (!ASSERT_GE(uffd, 0, "userfaultfd open + register address"))
+		goto out;
+	sleepable->bss->fault_addr = fault_page;
+
+	if (!ASSERT_OK(pthread_create(&thread, NULL, run_sleepable, NULL),
+		       "pthread_create"))
+		goto out;
+	started = true;
+
+	/* Wait for the thread to sleep in bpf_copy_from_user() */
+	pfd.fd = uffd;
+	if (!ASSERT_EQ(poll(&pfd, 1, 10000), 1, "poll uffd"))
+		goto out;
+	if (!ASSERT_EQ(read(uffd, &uffd_msg, sizeof(uffd_msg)), sizeof(uffd_msg),
+		       "read uffd"))
+		goto out;
+	if (!ASSERT_EQ(uffd_msg.event, UFFD_EVENT_PAGEFAULT, "uffd pagefault"))
+		goto out;
+
+	/* Detach and unload the victim prog, and make sure it is gone */
+	tramp_prog_detach__destroy(victim);
+	victim = NULL;
+	kern_sync_rcu();
+	usleep(100 * 1000);
+	kern_sync_rcu();
+
+	/*
+	 * That was enough to test the use-after-free but do it once more, so
+	 * that an older image with an already patched nop gets patched too.
+	 */
+	victim = load_one(fexit, false);
+	tramp_prog_detach__destroy(victim);
+	victim = NULL;
+
+out:
+	/* Let the thread proceed with the rest of the trampoline */
+	if (uffd >= 0) {
+		uffd_copy.dst = (unsigned long)fault_page;
+		uffd_copy.src = (unsigned long)src_page;
+		uffd_copy.len = page_size;
+		ASSERT_OK(ioctl(uffd, UFFDIO_COPY, &uffd_copy), "uffd copy");
+		close(uffd);
+	}
+	if (started &&
+	    ASSERT_OK(pthread_join(thread, &thread_ret), "pthread_join"))
+		ASSERT_NULL(thread_ret, "blocking run");
+
+	tramp_prog_detach__destroy(victim);
+	tramp_prog_detach__destroy(sleepable);
+	if (src_page != MAP_FAILED)
+		munmap(src_page, page_size);
+	munmap(fault_page, page_size);
+}
+
+void serial_test_tramp_prog_detach(void)
+{
+	/* a task sleeping before the original function is called */
+	if (test__start_subtest("fentry"))
+		test_detach(false);
+	/* a task sleeping after it returned, past the jmp that detach installs */
+	if (test__start_subtest("fexit"))
+		test_detach(true);
+}
diff --git a/tools/testing/selftests/bpf/progs/tramp_prog_detach.c b/tools/testing/selftests/bpf/progs/tramp_prog_detach.c
new file mode 100644
index 000000000000..507d372167ec
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tramp_prog_detach.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+int pid;
+void *fault_addr;
+__u64 ts;
+
+static int do_sleepable(void)
+{
+	char dst;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	ts = bpf_ktime_get_ns();
+	/* blocks for as long as user space wants when fault_addr is armed */
+	bpf_copy_from_user(&dst, sizeof(dst), fault_addr);
+	return 0;
+}
+
+static int do_victim(void)
+{
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	ts = bpf_ktime_get_ns();
+	return 0;
+}
+
+SEC("?fentry.s/bpf_fentry_test1")
+int BPF_PROG(fentry_sleepable, int a)
+{
+	return do_sleepable();
+}
+
+SEC("?fentry/bpf_fentry_test1")
+int BPF_PROG(fentry_victim, int a)
+{
+	return do_victim();
+}
+
+SEC("?fexit.s/bpf_fentry_test1")
+int BPF_PROG(fexit_sleepable, int a, int ret)
+{
+	return do_sleepable();
+}
+
+SEC("?fexit/bpf_fentry_test1")
+int BPF_PROG(fexit_victim, int a, int ret)
+{
+	return do_victim();
+}
-- 
2.55.0

