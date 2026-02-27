Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB914361DBE
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772214037; cv=none; b=gTOmzJHmO71+J9GRE1owuhnNcIH6tIRDEiCTGg+E79mQfYrAH5v/JdmujgyACpES5QXOh/vYA1xT+wiDpPxmA8Lc2uRfduar1jnhu6S6KuggQf9GWp3DlJzqknHtT30zUjNzXPKIoq+mecZSDM48LHBVAGvMf7GtKigndAR0KTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772214037; c=relaxed/simple;
	bh=NEFgZvqWp6RES2vvB9bxR5juZaFLvcpL+HbbLRuHAdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZ2qfd/dBonQ2t9KM8l/KbS+44Dmi0cMBMpBGzuvA79TGdoOY4jBs4s9PyGIA3pVvVtIlVnbTrkv3kxIkUmzkx0EF5SPOL8I/GRVjcRFQlWi5dXujW9ADR4vqxhYJ5lIutvIksOEuVNDqiS+AaAY62RGNkE9xwxOznI41DsRTh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fJmlYoWH; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fJmlYoWH"
Message-ID: <1b58ffb2-92ae-433a-ba46-95294d6edea2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772214021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qEj0UeN0Umh75mD+3HQiON+KW/AiHZEsiSpDarSVYyY=;
	b=fJmlYoWHIj29qDQ11aDaHekiR0Zcw1Acev8pyfjInb5SFOHaoikP4CpRJGxbumJmfMQb7J
	Lso+iFN5x0QLRbi1FtDhvt2A2tRKxxIPJuP7Gtv5paA+X+vTK3BpApBMsxjpceFW8SObHP
	Gw/fXml4FB+/+rxk2ZcBQVYw7a1Eeiw=
Date: Fri, 27 Feb 2026 09:40:12 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv6 bpf-next 9/9] bpf,x86: Use single ftrace_ops for direct
 calls
To: Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@kernel.org>,
 Florent Revest <revest@google.com>, Mark Rutland <mark.rutland@arm.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Menglong Dong
 <menglong8.dong@gmail.com>, Song Liu <song@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20251230145010.103439-1-jolsa@kernel.org>
 <20251230145010.103439-10-jolsa@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20251230145010.103439-10-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/30/25 6:50 AM, Jiri Olsa wrote:
> Using single ftrace_ops for direct calls update instead of allocating
> ftrace_ops object for each trampoline.
> 
> With single ftrace_ops object we can use update_ftrace_direct_* api
> that allows multiple ip sites updates on single ftrace_ops object.
> 
> Adding HAVE_SINGLE_FTRACE_DIRECT_OPS config option to be enabled on
> each arch that supports this.
> 
> At the moment we can enable this only on x86 arch, because arm relies
> on ftrace_ops object representing just single trampoline image (stored
> in ftrace_ops::direct_call). Archs that do not support this will continue
> to use *_ftrace_direct api.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Hi Jiri,

Me and Kumar stumbled on kernel splats with "ftrace failed to modify",
and if running with KASAN:

  BUG: KASAN: slab-use-after-free in __get_valid_kprobe+0x224/0x2a0

Pasting a full splat example at the bottom.

I was able to create a reproducer with AI, and then used it to bisect
to this patch. You can run it with ./test_progs -t ftrace_direct_race

Below is my (human-generated, haha) summary of AI's analysis of what's
happening. It makes sense to me conceptually, but I don't know enough
details here to call bullshit. Please take a look:

    With CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS ftrace_replace_code()
    operates on all call sites in the shared ops. Then if a concurrent
    ftrace user (like kprobe) modifies a call site in between
    ftrace_replace_code's verify pass and its patch pass, then ftrace_bug
    fires and sets ftrace_disabled to 1.

    Once ftrace is disabled, direct_ops_del silently fails to unregister
    the direct call, and the call site still redirects to the stale
    trampoline. After the BPF program is freed, we'll get use-after-free
    on the next trace hit.

The reproducer is not great, because if everything is fine it just hangs.
But with the bug the kernel crashes pretty fast.
Maybe it makes sense to refine it to a proper "stress" selftest?

Reproducer patch:

From c595ef5a0ad9bc62d768080ff09502bc982c40e6 Mon Sep 17 00:00:00 2001
From: Ihor Solodrai <ihor.solodrai@linux.dev>
Date: Thu, 26 Feb 2026 17:00:39 -0800
Subject: [PATCH] reproducer

---
 .../bpf/prog_tests/ftrace_direct_race.c       | 243 ++++++++++++++++++
 1 file changed, 243 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ftrace_direct_race.c

diff --git a/tools/testing/selftests/bpf/prog_tests/ftrace_direct_race.c b/tools/testing/selftests/bpf/prog_tests/ftrace_direct_race.c
new file mode 100644
index 000000000000..369c55364d05
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/ftrace_direct_race.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+/* Test to reproduce ftrace race between BPF trampoline attach/detach
+ * and kprobe attach/detach on the same function.
+ *
+ * With CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS, all BPF trampolines share
+ * a single ftrace_ops. Concurrent modifications (BPF trampoline vs kprobe)
+ * can race in ftrace_replace_code's verify-then-patch sequence, causing
+ * ftrace to become permanently disabled and leaving stale trampolines
+ * that reference freed BPF programs.
+ *
+ * Run with: ./test_progs -t ftrace_direct_race
+ */
+#include <test_progs.h>
+#include <bpf/libbpf.h>
+#include <pthread.h>
+#include <sys/ioctl.h>
+#include <linux/perf_event.h>
+#include <sys/syscall.h>
+
+#include "fentry_test.lskel.h"
+
+#define NUM_ITERATIONS	200
+
+static volatile bool stop;
+
+/* Thread 1: Rapidly attach and detach fentry BPF trampolines */
+static void *fentry_thread_fn(void *arg)
+{
+	int i;
+
+	for (i = 0; i < NUM_ITERATIONS && !stop; i++) {
+		struct fentry_test_lskel *skel;
+		int err;
+
+		skel = fentry_test_lskel__open();
+		if (!skel)
+			continue;
+
+		skel->keyring_id = KEY_SPEC_SESSION_KEYRING;
+		err = fentry_test_lskel__load(skel);
+		if (err) {
+			fentry_test_lskel__destroy(skel);
+			continue;
+		}
+
+		err = fentry_test_lskel__attach(skel);
+		if (err) {
+			fentry_test_lskel__destroy(skel);
+			continue;
+		}
+
+		/* Brief sleep to let the trampoline be live while kprobes race */
+		usleep(100 + rand() % 500);
+
+		fentry_test_lskel__detach(skel);
+		fentry_test_lskel__destroy(skel);
+	}
+
+	return NULL;
+}
+
+/* Thread 2: Rapidly create and destroy kprobes via tracefs on
+ * bpf_fentry_test* functions (the same functions the fentry thread targets).
+ * Creating/removing kprobe events goes through the ftrace code patching
+ * path that can race with BPF trampoline direct call operations.
+ */
+static void *kprobe_thread_fn(void *arg)
+{
+	const char *funcs[] = {
+		"bpf_fentry_test1",
+		"bpf_fentry_test2",
+		"bpf_fentry_test3",
+		"bpf_fentry_test4",
+		"bpf_fentry_test5",
+		"bpf_fentry_test6",
+	};
+	int i;
+
+	for (i = 0; i < NUM_ITERATIONS && !stop; i++) {
+		int j;
+
+		for (j = 0; j < 6 && !stop; j++) {
+			char cmd[256];
+
+			/* Create kprobe via tracefs */
+			snprintf(cmd, sizeof(cmd),
+				 "echo 'p:kprobe_race_%d %s' >> /sys/kernel/debug/tracing/kprobe_events 2>/dev/null",
+				 j, funcs[j]);
+			system(cmd);
+
+			/* Small delay */
+			usleep(50 + rand() % 200);
+
+			/* Remove kprobe */
+			snprintf(cmd, sizeof(cmd),
+				 "echo '-:kprobe_race_%d' >> /sys/kernel/debug/tracing/kprobe_events 2>/dev/null",
+				 j);
+			system(cmd);
+		}
+	}
+
+	return NULL;
+}
+
+/* Thread 3: Create kprobes via perf_event_open (the ftrace-based kind)
+ * which go through the arm_kprobe / disarm_kprobe ftrace path.
+ */
+static void *perf_kprobe_thread_fn(void *arg)
+{
+	const char *funcs[] = {
+		"bpf_fentry_test1",
+		"bpf_fentry_test2",
+		"bpf_fentry_test3",
+	};
+	int i;
+
+	for (i = 0; i < NUM_ITERATIONS && !stop; i++) {
+		int fds[3] = {-1, -1, -1};
+		int j;
+
+		for (j = 0; j < 3 && !stop; j++) {
+			struct perf_event_attr attr = {};
+			char path[256];
+			char buf[32];
+			char cmd[256];
+			int id_fd, id;
+
+			/* Create kprobe event */
+			snprintf(cmd, sizeof(cmd),
+				 "echo 'p:perf_race_%d %s' >> /sys/kernel/debug/tracing/kprobe_events 2>/dev/null",
+				 j, funcs[j]);
+			system(cmd);
+
+			/* Try to get the event id */
+			snprintf(path, sizeof(path),
+				 "/sys/kernel/debug/tracing/events/kprobes/perf_race_%d/id", j);
+			id_fd = open(path, O_RDONLY);
+			if (id_fd < 0)
+				continue;
+
+			memset(buf, 0, sizeof(buf));
+			if (read(id_fd, buf, sizeof(buf) - 1) > 0)
+				id = atoi(buf);
+			else
+				id = -1;
+			close(id_fd);
+
+			if (id < 0)
+				continue;
+
+			/* Open perf event to arm the kprobe via ftrace */
+			attr.type = PERF_TYPE_TRACEPOINT;
+			attr.size = sizeof(attr);
+			attr.config = id;
+			attr.sample_type = PERF_SAMPLE_RAW;
+			attr.sample_period = 1;
+			attr.wakeup_events = 1;
+
+			fds[j] = syscall(__NR_perf_event_open, &attr, -1, 0, -1, 0);
+			if (fds[j] >= 0)
+				ioctl(fds[j], PERF_EVENT_IOC_ENABLE, 0);
+		}
+
+		usleep(100 + rand() % 300);
+
+		/* Close perf events (disarms kprobes via ftrace) */
+		for (j = 0; j < 3; j++) {
+			char cmd[256];
+
+			if (fds[j] >= 0)
+				close(fds[j]);
+
+			snprintf(cmd, sizeof(cmd),
+				 "echo '-:perf_race_%d' >> /sys/kernel/debug/tracing/kprobe_events 2>/dev/null",
+				 j);
+			system(cmd);
+		}
+	}
+
+	return NULL;
+}
+
+void test_ftrace_direct_race(void)
+{
+	pthread_t fentry_tid, kprobe_tid, perf_kprobe_tid;
+	int err;
+
+	/* Check if ftrace is currently operational */
+	if (!ASSERT_OK(access("/sys/kernel/debug/tracing/kprobe_events", W_OK),
+		       "tracefs_access"))
+		return;
+
+	stop = false;
+
+	err = pthread_create(&fentry_tid, NULL, fentry_thread_fn, NULL);
+	if (!ASSERT_OK(err, "create_fentry_thread"))
+		return;
+
+	err = pthread_create(&kprobe_tid, NULL, kprobe_thread_fn, NULL);
+	if (!ASSERT_OK(err, "create_kprobe_thread")) {
+		stop = true;
+		pthread_join(fentry_tid, NULL);
+		return;
+	}
+
+	err = pthread_create(&perf_kprobe_tid, NULL, perf_kprobe_thread_fn, NULL);
+	if (!ASSERT_OK(err, "create_perf_kprobe_thread")) {
+		stop = true;
+		pthread_join(fentry_tid, NULL);
+		pthread_join(kprobe_tid, NULL);
+		return;
+	}
+
+	pthread_join(fentry_tid, NULL);
+	pthread_join(kprobe_tid, NULL);
+	pthread_join(perf_kprobe_tid, NULL);
+
+	/* If we get here without a kernel panic/oops, the test passed.
+	 * The real check is in dmesg: look for
+	 *   "WARNING: arch/x86/kernel/ftrace.c" or
+	 *   "BUG: KASAN: vmalloc-out-of-bounds in __bpf_prog_enter_recur"
+	 *
+	 * A more robust check: verify ftrace is still operational.
+	 */
+	ASSERT_OK(access("/sys/kernel/debug/tracing/kprobe_events", W_OK),
+		  "ftrace_still_operational");
+
+	/* Check that ftrace wasn't disabled */
+	{
+		char buf[64] = {};
+		int fd = open("/proc/sys/kernel/ftrace_enabled", O_RDONLY);
+
+		if (ASSERT_GE(fd, 0, "open_ftrace_enabled")) {
+			int n = read(fd, buf, sizeof(buf) - 1);
+
+			close(fd);
+			if (n > 0)
+				ASSERT_EQ(atoi(buf), 1, "ftrace_enabled");
+		}
+	}
+}
-- 
2.47.3


----

Splat:

[   24.170803] ------------[ cut here ]------------                                                                                                              
[   24.171055] WARNING: kernel/trace/ftrace.c:2715 at ftrace_get_addr_curr+0x149/0x190, CPU#13: kworker/13:6/873                                                 
[   24.171315] Modules linked in: bpf_test_modorder_y(OE+) bpf_test_modorder_x(OE) bpf_testmod(OE)                                                               
[   24.171561] CPU: 13 UID: 0 PID: 873 Comm: kworker/13:6 Tainted: G           OE       7.0.0-rc1-gda78c0a81eea #83 PREEMPT(full)                                
[   24.171827] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE                                                                                                      
[   24.171941] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-5.el9 11/05/2023                                                               
[   24.172132] Workqueue: events bpf_link_put_deferred                                                                                                           
[   24.172261] RIP: 0010:ftrace_get_addr_curr+0x149/0x190                                                                                                        
[   24.172376] Code: 00 4c 89 f7 e8 88 f8 ff ff 84 c0 75 92 4d 8b 7f 08 e8 fb b3 c1 00 4d 85 ff 0f 94 c0 49 81 ff b0 1c 6e 83 0f 94 c1 08 c1 74 96 <0f> 0b c6 05 
62 e8 2b 02 01 c7 05 54 e8 2b 02 00 00 00 00 48 c7 05                                                                                                            
[   24.172745] RSP: 0018:ffa0000504cafb78 EFLAGS: 00010202                                                                                                       
[   24.172861] RAX: 0000000000000000 RBX: ff110001000e48d0 RCX: ff1100011cd3a201                                                                                 
[   24.173034] RDX: 6e21cb51d943709c RSI: 0000000000000000 RDI: ffffffff81d416d4                                                                                 
[   24.173194] RBP: 0000000000000001 R08: 0000000080000000 R09: ffffffffffffffff                                                                                 
[   24.173366] R10: ffffffff81285522 R11: 0000000000000000 R12: ff110001000e48d0                                                                                 
[   24.173530] R13: ffffffff81d416d4 R14: ffffffff81d416d4 R15: ffffffff836e1cb0                                                                                 
[   24.173691] FS:  0000000000000000(0000) GS:ff1100203becc000(0000) knlGS:0000000000000000                                                                      
[   24.173849] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033                                                                                                 
[   24.173995] CR2: 00007f615e966270 CR3: 000000010bd9d005 CR4: 0000000000771ef0                                                                                 
[   24.174155] PKRU: 55555554                                                                                                                                    
[   24.174214] Call Trace:                                                                                                                                       
[   24.174285]  <TASK>                                                                                                                                           
[   24.174348]  ftrace_replace_code+0x7e/0x210                                                                                                                   
[   24.174443]  ftrace_modify_all_code+0x59/0x110                                                                                                                
[   24.174553]  __ftrace_hash_move_and_update_ops+0x227/0x2c0                                                                                                    
[   24.174659]  ? kfree+0x1ac/0x4c0                                                                                                                              
[   24.174751]  ? srso_return_thunk+0x5/0x5f                                                                                                                     
[   24.174834]  ? kfree+0x250/0x4c0                                                                                                                              
[   24.174926]  ? kfree+0x1ac/0x4c0                                                                                                                              
[   24.175010]  ? bpf_lsm_sk_alloc_security+0x4/0x20                                                                                                             
[   24.175132]  ftrace_update_ops+0x40/0x80                                                                                                                      
[   24.175217]  update_ftrace_direct_del+0x263/0x290                                                                                                             
[   24.175341]  ? bpf_lsm_sk_alloc_security+0x4/0x20                                                                                                             
[   24.175456]  ? 0xffffffffc0006a80                                                                                                                             
[   24.175543]  bpf_trampoline_update+0x1fb/0x810                                                                                                                
[   24.175654]  bpf_trampoline_unlink_prog+0x103/0x1a0                                                                                                           
[   24.175767]  ? process_scheduled_works+0x271/0x640                                                                                                            
[   24.175886]  bpf_shim_tramp_link_release+0x20/0x40                                                                                                            
[   24.176001]  bpf_link_free+0x54/0xd0                                                                                                                          
[   24.176092]  process_scheduled_works+0x2c2/0x640                             
[   24.176222]  worker_thread+0x22a/0x340                                                                                                    21:11:27 [422/10854]
[   24.176319]  ? srso_return_thunk+0x5/0x5f
[   24.176405]  ? __pfx_worker_thread+0x10/0x10
[   24.176522]  kthread+0x10c/0x140
[   24.176611]  ? __pfx_kthread+0x10/0x10
[   24.176698]  ret_from_fork+0x148/0x290
[   24.176785]  ? __pfx_kthread+0x10/0x10
[   24.176872]  ret_from_fork_asm+0x1a/0x30
[   24.176985]  </TASK>
[   24.177043] irq event stamp: 6965
[   24.177126] hardirqs last  enabled at (6973): [<ffffffff8136008c>] __console_unlock+0x5c/0x70
[   24.177325] hardirqs last disabled at (6982): [<ffffffff81360071>] __console_unlock+0x41/0x70
[   24.177520] softirqs last  enabled at (6524): [<ffffffff812b8b97>] __irq_exit_rcu+0x47/0xc0
[   24.177675] softirqs last disabled at (6123): [<ffffffff812b8b97>] __irq_exit_rcu+0x47/0xc0
[   24.177844] ---[ end trace 0000000000000000 ]---
[   24.177963] Bad trampoline accounting at: 000000003143da54 (bpf_fentry_test3+0x4/0x20)
[   24.178134] ------------[ cut here ]------------
[   24.178261] WARNING: arch/x86/kernel/ftrace.c:105 at ftrace_replace_code+0xf7/0x210, CPU#13: kworker/13:6/873
[   24.178476] Modules linked in: bpf_test_modorder_y(OE+) bpf_test_modorder_x(OE) bpf_testmod(OE)
[   24.178680] CPU: 13 UID: 0 PID: 873 Comm: kworker/13:6 Tainted: G        W  OE       7.0.0-rc1-gda78c0a81eea #83 PREEMPT(full) 
[   24.178925] Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   24.179059] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-5.el9 11/05/2023
[   24.179258] Workqueue: events bpf_link_put_deferred
[   24.179374] RIP: 0010:ftrace_replace_code+0xf7/0x210
[   24.179485] Code: c0 0f 85 ec 00 00 00 8b 44 24 03 41 33 45 00 0f b6 4c 24 07 41 32 4d 04 0f b6 c9 09 c1 0f 84 49 ff ff ff 4c 89 2d b9 df 8b 03 <0f> 0b bf ea 
ff ff ff e9 c4 00 00 00 e8 f8 e5 19 00 48 85 c0 0f 84
[   24.179847] RSP: 0018:ffa0000504cafb98 EFLAGS: 00010202
[   24.179965] RAX: 0000000038608000 RBX: 0000000000000001 RCX: 00000000386080c1
[   24.180126] RDX: ffffffff81d41000 RSI: 0000000000000005 RDI: ffffffff81d416d4
[   24.180295] RBP: 0000000000000001 R08: 000000000000ffff R09: ffffffff82e98430
[   24.180455] R10: 000000000002fffd R11: 00000000fffeffff R12: ff110001000e48d0
[   24.180617] R13: ffffffff83ec0f2d R14: ffffffff84b43820 R15: ffa0000504cafb9b
[   24.180777] FS:  0000000000000000(0000) GS:ff1100203becc000(0000) knlGS:0000000000000000
[   24.180939] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.181077] CR2: 00007f615e966270 CR3: 000000010bd9d005 CR4: 0000000000771ef0
[   24.181247] PKRU: 55555554
[   24.181303] Call Trace:
[   24.181360]  <TASK>
[   24.181424]  ftrace_modify_all_code+0x59/0x110
[   24.181536]  __ftrace_hash_move_and_update_ops+0x227/0x2c0
[   24.181650]  ? kfree+0x1ac/0x4c0
[   24.181743]  ? srso_return_thunk+0x5/0x5f
[   24.181828]  ? kfree+0x250/0x4c0
[   24.181916]  ? kfree+0x1ac/0x4c0
[   24.182004]  ? bpf_lsm_sk_alloc_security+0x4/0x20
[   24.182123]  ftrace_update_ops+0x40/0x80
[   24.182213]  update_ftrace_direct_del+0x263/0x290
[   24.182337]  ? bpf_lsm_sk_alloc_security+0x4/0x20
[   24.182455]  ? 0xffffffffc0006a80
[   24.182543]  bpf_trampoline_update+0x1fb/0x810
[   24.182655]  bpf_trampoline_unlink_prog+0x103/0x1a0
[   24.182768]  ? process_scheduled_works+0x271/0x640
[   24.182887]  bpf_shim_tramp_link_release+0x20/0x40
[   24.183001]  bpf_link_free+0x54/0xd0
[   24.183088]  process_scheduled_works+0x2c2/0x640
[   24.183220]  worker_thread+0x22a/0x340                                                                                                    21:11:27 [367/10854]
[   24.183319]  ? srso_return_thunk+0x5/0x5f        
[   24.183405]  ? __pfx_worker_thread+0x10/0x10     
[   24.183521]  kthread+0x10c/0x140
[   24.183610]  ? __pfx_kthread+0x10/0x10
[   24.183697]  ret_from_fork+0x148/0x290
[   24.183783]  ? __pfx_kthread+0x10/0x10
[   24.183868]  ret_from_fork_asm+0x1a/0x30
[   24.183979]  </TASK>
[   24.184056] irq event stamp: 7447
[   24.184138] hardirqs last  enabled at (7455): [<ffffffff8136008c>] __console_unlock+0x5c/0x70
[   24.184339] hardirqs last disabled at (7464): [<ffffffff81360071>] __console_unlock+0x41/0x70
[   24.184522] softirqs last  enabled at (6524): [<ffffffff812b8b97>] __irq_exit_rcu+0x47/0xc0
[   24.184675] softirqs last disabled at (6123): [<ffffffff812b8b97>] __irq_exit_rcu+0x47/0xc0
[   24.184836] ---[ end trace 0000000000000000 ]---
[   24.185177] ------------[ ftrace bug ]------------
[   24.185310] ftrace failed to modify 
[   24.185312] [<ffffffff81d416d4>] bpf_fentry_test3+0x4/0x20
[   24.185544]  actual:   e8:27:29:6c:3e
[   24.185627]  expected: e8:a7:49:54:ff
[   24.185717] ftrace record flags: e8180000
[   24.185798]  (0) R   tramp: ERROR!
[   24.185798]  expected tramp: ffffffffc0404000
[   24.185975] ------------[ cut here ]------------
[   24.186086] WARNING: kernel/trace/ftrace.c:2254 at ftrace_bug+0x101/0x290, CPU#13: kworker/13:6/873
[   24.186285] Modules linked in: bpf_test_modorder_y(OE+) bpf_test_modorder_x(OE) bpf_testmod(OE)
[   24.186484] CPU: 13 UID: 0 PID: 873 Comm: kworker/13:6 Tainted: G        W  OE       7.0.0-rc1-gda78c0a81eea #83 PREEMPT(full) 
[   24.186728] Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   24.186863] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-5.el9 11/05/2023
[   24.187057] Workqueue: events bpf_link_put_deferred
[   24.187172] RIP: 0010:ftrace_bug+0x101/0x290
[   24.187294] Code: 05 72 03 83 f8 02 7f 13 83 f8 01 74 46 83 f8 02 75 13 48 c7 c7 41 a3 69 82 eb 51 83 f8 03 74 3c 83 f8 04 74 40 48 85 db 75 4c <0f> 0b c6 05 
ba eb 2b 02 01 c7 05 ac eb 2b 02 00 00 00 00 48 c7 05
[   24.187663] RSP: 0018:ffa0000504cafb70 EFLAGS: 00010246
[   24.187772] RAX: 0000000000000022 RBX: ff110001000e48d0 RCX: e5ff63967b168c00
[   24.187934] RDX: 0000000000000000 RSI: 00000000fffeffff RDI: ffffffff83018490
[   24.188096] RBP: 00000000ffffffea R08: 000000000000ffff R09: ffffffff82e98430
[   24.188267] R10: 000000000002fffd R11: 00000000fffeffff R12: ff110001000e48d0
[   24.188423] R13: ffffffff83ec0f2d R14: ffffffff81d416d4 R15: ffffffff836e1cb0
[   24.188581] FS:  0000000000000000(0000) GS:ff1100203becc000(0000) knlGS:0000000000000000
[   24.188738] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.188870] CR2: 00007f615e966270 CR3: 000000010bd9d005 CR4: 0000000000771ef0
[   24.189032] PKRU: 55555554
[   24.189088] Call Trace:
[   24.189144]  <TASK>
[   24.189204]  ftrace_replace_code+0x1d6/0x210
[   24.189335]  ftrace_modify_all_code+0x59/0x110
[   24.189443]  __ftrace_hash_move_and_update_ops+0x227/0x2c0
[   24.189554]  ? kfree+0x1ac/0x4c0
[   24.189638]  ? srso_return_thunk+0x5/0x5f
[   24.189720]  ? kfree+0x250/0x4c0
[   24.189802]  ? kfree+0x1ac/0x4c0
[   24.189889]  ? bpf_lsm_sk_alloc_security+0x4/0x20
[   24.190010]  ftrace_update_ops+0x40/0x80
[   24.190095]  update_ftrace_direct_del+0x263/0x290
[   24.190205]  ? bpf_lsm_sk_alloc_security+0x4/0x20                                                                                         21:11:28 [312/10854]
[   24.190335]  ? 0xffffffffc0006a80
[   24.190422]  bpf_trampoline_update+0x1fb/0x810
[   24.190542]  bpf_trampoline_unlink_prog+0x103/0x1a0
[   24.190651]  ? process_scheduled_works+0x271/0x640
[   24.190764]  bpf_shim_tramp_link_release+0x20/0x40
[   24.190871]  bpf_link_free+0x54/0xd0
[   24.190964]  process_scheduled_works+0x2c2/0x640
[   24.191093]  worker_thread+0x22a/0x340
[   24.191177]  ? srso_return_thunk+0x5/0x5f
[   24.191274]  ? __pfx_worker_thread+0x10/0x10
[   24.191388]  kthread+0x10c/0x140
[   24.191478]  ? __pfx_kthread+0x10/0x10
[   24.191565]  ret_from_fork+0x148/0x290
[   24.191641]  ? __pfx_kthread+0x10/0x10
[   24.191729]  ret_from_fork_asm+0x1a/0x30
[   24.191833]  </TASK>
[   24.191896] irq event stamp: 8043
[   24.191979] hardirqs last  enabled at (8051): [<ffffffff8136008c>] __console_unlock+0x5c/0x70
[   24.192167] hardirqs last disabled at (8058): [<ffffffff81360071>] __console_unlock+0x41/0x70
[   24.192368] softirqs last  enabled at (7828): [<ffffffff812b8b97>] __irq_exit_rcu+0x47/0xc0
[   24.192528] softirqs last disabled at (7817): [<ffffffff812b8b97>] __irq_exit_rcu+0x47/0xc0
[   24.192689] ---[ end trace 0000000000000000 ]---
[   24.193549] ------------[ cut here ]------------
[   24.193773] WARNING: kernel/trace/ftrace.c:2709 at ftrace_get_addr_curr+0x6c/0x190, CPU#10: test_progs/311
[   24.193973] Modules linked in: bpf_test_modorder_y(OE+) bpf_test_modorder_x(OE) bpf_testmod(OE)
[   24.194206] CPU: 10 UID: 0 PID: 311 Comm: test_progs Tainted: G        W  OE       7.0.0-rc1-gda78c0a81eea #83 PREEMPT(full) 
[   24.194461] Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   24.194594] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-5.el9 11/05/2023
[   24.194778] RIP: 0010:ftrace_get_addr_curr+0x6c/0x190
[   24.194891] Code: 48 0f 44 ce 4c 8b 3c c8 e8 e1 b4 c1 00 4d 85 ff 74 18 4d 39 77 10 74 05 4d 8b 3f eb eb 49 8b 47 18 48 85 c0 0f 85 19 01 00 00 <0f> 0b 48 8b 
43 08 a9 00 00 00 08 75 1c a9 00 00 00 20 48 c7 c1 80
[   24.195270] RSP: 0018:ffa0000000d4bb38 EFLAGS: 00010246
[   24.195381] RAX: 0000000000000001 RBX: ff11000100125710 RCX: ff1100010b28a2c0
[   24.195540] RDX: 0000000000000003 RSI: 0000000000000003 RDI: ff11000100125710
[   24.195698] RBP: 0000000000000001 R08: 0000000080000000 R09: ffffffffffffffff
[   24.195863] R10: ffffffff82046a38 R11: 0000000000000000 R12: ff11000100125710
[   24.196033] R13: ffffffff81529fc4 R14: ffffffff81529fc4 R15: 0000000000000000
[   24.196199] FS:  00007f46532a54c0(0000) GS:ff1100203be0c000(0000) knlGS:0000000000000000
[   24.196374] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.196509] CR2: 000055e885be1470 CR3: 000000010eef9003 CR4: 0000000000771ef0
[   24.196663] PKRU: 55555554
[   24.196720] Call Trace:
[   24.196778]  <TASK>
[   24.196844]  ftrace_replace_code+0x7e/0x210
[   24.196948]  ftrace_modify_all_code+0x59/0x110
[   24.197059]  __ftrace_hash_move_and_update_ops+0x227/0x2c0
[   24.197174]  ? srso_return_thunk+0x5/0x5f
[   24.197271]  ? __mutex_lock+0x22a/0xc60
[   24.197360]  ? kfree+0x1ac/0x4c0
[   24.197455]  ? srso_return_thunk+0x5/0x5f
[   24.197538]  ? kfree+0x250/0x4c0
[   24.197626]  ? bpf_fentry_test3+0x4/0x20
[   24.197712]  ftrace_set_hash+0x13c/0x3d0
[   24.197811]  ftrace_set_filter_ip+0x88/0xb0
[   24.197909]  ? bpf_fentry_test3+0x4/0x20                                                                                                  21:11:28 [257/10854]
[   24.198000]  disarm_kprobe_ftrace+0x83/0xd0
[   24.198089]  __disable_kprobe+0x129/0x160
[   24.198178]  disable_kprobe+0x27/0x60
[   24.198272]  kprobe_register+0xa2/0xe0
[   24.198362]  perf_trace_event_unreg+0x33/0xd0
[   24.198473]  perf_kprobe_destroy+0x3b/0x80
[   24.198557]  __free_event+0x119/0x290
[   24.198640]  perf_event_release_kernel+0x1ef/0x220
[   24.198758]  perf_release+0x12/0x20
[   24.198843]  __fput+0x11b/0x2a0
[   24.198946]  task_work_run+0x8b/0xc0
[   24.199035]  exit_to_user_mode_loop+0x107/0x4d0
[   24.199155]  do_syscall_64+0x25b/0x390
[   24.199249]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   24.199360]  ? trace_irq_disable+0x1d/0xc0
[   24.199451]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   24.199559] RIP: 0033:0x7f46530ff85b
[   24.199675] Code: 03 00 00 00 0f 05 48 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 e3 83 f8 ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 
ff ff 77 35 44 89 c7 89 44 24 0c e8 41 84 f8 ff 8b 44
[   24.200034] RSP: 002b:00007ffc40859770 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
[   24.200192] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f46530ff85b
[   24.200382] RDX: 0000000000000002 RSI: 0000000000000002 RDI: 0000000000000019
[   24.200552] RBP: 00007ffc408597c0 R08: 0000000000000000 R09: 00007ffc40859757
[   24.200702] R10: 0000000000000000 R11: 0000000000000293 R12: 00007ffc4085ddc8
[   24.200855] R13: 000055e8800de120 R14: 000055e88118d390 R15: 00007f46533de000
[   24.201035]  </TASK>
[   24.201091] irq event stamp: 200379
[   24.201208] hardirqs last  enabled at (200387): [<ffffffff8136008c>] __console_unlock+0x5c/0x70
[   24.201453] hardirqs last disabled at (200396): [<ffffffff81360071>] __console_unlock+0x41/0x70
[   24.201667] softirqs last  enabled at (200336): [<ffffffff812b8b97>] __irq_exit_rcu+0x47/0xc0
[   24.201890] softirqs last disabled at (200329): [<ffffffff812b8b97>] __irq_exit_rcu+0x47/0xc0
[   24.202121] ---[ end trace 0000000000000000 ]---
[   24.202398] ------------[ cut here ]------------
[   24.202534] WARNING: kernel/trace/ftrace.c:2715 at ftrace_get_addr_curr+0x149/0x190, CPU#10: test_progs/311
[   24.202753] Modules linked in: bpf_test_modorder_y(OE+) bpf_test_modorder_x(OE) bpf_testmod(OE)
[   24.202962] CPU: 10 UID: 0 PID: 311 Comm: test_progs Tainted: G        W  OE       7.0.0-rc1-gda78c0a81eea #83 PREEMPT(full) 
[   24.203203] Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   24.203344] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-5.el9 11/05/2023
[   24.203526] RIP: 0010:ftrace_get_addr_curr+0x149/0x190
[   24.203629] Code: 00 4c 89 f7 e8 88 f8 ff ff 84 c0 75 92 4d 8b 7f 08 e8 fb b3 c1 00 4d 85 ff 0f 94 c0 49 81 ff b0 1c 6e 83 0f 94 c1 08 c1 74 96 <0f> 0b c6 05 
62 e8 2b 02 01 c7 05 54 e8 2b 02 00 00 00 00 48 c7 05
[   24.203996] RSP: 0018:ffa0000000d4bb38 EFLAGS: 00010202
[   24.204110] RAX: 0000000000000000 RBX: ff11000100125710 RCX: ff1100010b28a201
[   24.204280] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff81529fc4
[   24.204437] RBP: 0000000000000001 R08: 0000000080000000 R09: ffffffffffffffff
[   24.204595] R10: ffffffff82046a38 R11: 0000000000000000 R12: ff11000100125710
[   24.204755] R13: ffffffff81529fc4 R14: ffffffff81529fc4 R15: ffffffff836e1cb0
[   24.204914] FS:  00007f46532a54c0(0000) GS:ff1100203be0c000(0000) knlGS:0000000000000000
[   24.205072] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.205204] CR2: 000055e885be1470 CR3: 000000010eef9003 CR4: 0000000000771ef0
[   24.205386] PKRU: 55555554
[   24.205443] Call Trace:
[   24.205503]  <TASK>
[   24.205565]  ftrace_replace_code+0x7e/0x210
[   24.205669]  ftrace_modify_all_code+0x59/0x110                                                                                            21:11:28 [202/10854]
[   24.205784]  __ftrace_hash_move_and_update_ops+0x227/0x2c0
[   24.205902]  ? srso_return_thunk+0x5/0x5f
[   24.205987]  ? __mutex_lock+0x22a/0xc60
[   24.206072]  ? kfree+0x1ac/0x4c0
[   24.206163]  ? srso_return_thunk+0x5/0x5f
[   24.206254]  ? kfree+0x250/0x4c0
[   24.206344]  ? bpf_fentry_test3+0x4/0x20
[   24.206428]  ftrace_set_hash+0x13c/0x3d0
[   24.206523]  ftrace_set_filter_ip+0x88/0xb0
[   24.206614]  ? bpf_fentry_test3+0x4/0x20
[   24.206703]  disarm_kprobe_ftrace+0x83/0xd0
[   24.206789]  __disable_kprobe+0x129/0x160
[   24.206880]  disable_kprobe+0x27/0x60
[   24.206972]  kprobe_register+0xa2/0xe0
[   24.207057]  perf_trace_event_unreg+0x33/0xd0
[   24.207169]  perf_kprobe_destroy+0x3b/0x80
[   24.207262]  __free_event+0x119/0x290
[   24.207348]  perf_event_release_kernel+0x1ef/0x220
[   24.207461]  perf_release+0x12/0x20
[   24.207543]  __fput+0x11b/0x2a0
[   24.207626]  task_work_run+0x8b/0xc0
[   24.207711]  exit_to_user_mode_loop+0x107/0x4d0
[   24.207827]  do_syscall_64+0x25b/0x390
[   24.207915]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   24.208021]  ? trace_irq_disable+0x1d/0xc0
[   24.208110]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   24.208215] RIP: 0033:0x7f46530ff85b
[   24.208307] Code: 03 00 00 00 0f 05 48 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 e3 83 f8 ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 
ff ff 77 35 44 89 c7 89 44 24 0c e8 41 84 f8 ff 8b 44
[   24.208657] RSP: 002b:00007ffc40859770 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
[   24.208816] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f46530ff85b
[   24.208978] RDX: 0000000000000002 RSI: 0000000000000002 RDI: 0000000000000019
[   24.209133] RBP: 00007ffc408597c0 R08: 0000000000000000 R09: 00007ffc40859757
[   24.209300] R10: 0000000000000000 R11: 0000000000000293 R12: 00007ffc4085ddc8
[   24.209457] R13: 000055e8800de120 R14: 000055e88118d390 R15: 00007f46533de000
[   24.209633]  </TASK>
[   24.209689] irq event stamp: 200963
[   24.209770] hardirqs last  enabled at (200971): [<ffffffff8136008c>] __console_unlock+0x5c/0x70
[   24.209971] hardirqs last disabled at (200978): [<ffffffff81360071>] __console_unlock+0x41/0x70
[   24.210156] softirqs last  enabled at (200568): [<ffffffff812b8b97>] __irq_exit_rcu+0x47/0xc0
[   24.210370] softirqs last disabled at (200557): [<ffffffff812b8b97>] __irq_exit_rcu+0x47/0xc0
[   24.210554] ---[ end trace 0000000000000000 ]---
[   24.210665] Bad trampoline accounting at: 00000000ab641fec (bpf_lsm_sk_alloc_security+0x4/0x20)
[   24.210866] ------------[ cut here ]------------
[   24.210993] WARNING: arch/x86/kernel/ftrace.c:105 at ftrace_replace_code+0xf7/0x210, CPU#10: test_progs/311
[   24.211182] Modules linked in: bpf_test_modorder_y(OE+) bpf_test_modorder_x(OE) bpf_testmod(OE)
[   24.211412] CPU: 10 UID: 0 PID: 311 Comm: test_progs Tainted: G        W  OE       7.0.0-rc1-gda78c0a81eea #83 PREEMPT(full) 
[   24.211656] Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   24.211788] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-5.el9 11/05/2023
[   24.211980] RIP: 0010:ftrace_replace_code+0xf7/0x210
[   24.212091] Code: c0 0f 85 ec 00 00 00 8b 44 24 03 41 33 45 00 0f b6 4c 24 07 41 32 4d 04 0f b6 c9 09 c1 0f 84 49 ff ff ff 4c 89 2d b9 df 8b 03 <0f> 0b bf ea 
ff ff ff e9 c4 00 00 00 e8 f8 e5 19 00 48 85 c0 0f 84
[   24.212503] RSP: 0018:ffa0000000d4bb58 EFLAGS: 00010202
[   24.212628] RAX: 00000000780a0001 RBX: 0000000000000001 RCX: 00000000780a00c1
[   24.212798] RDX: ffffffff81529000 RSI: 0000000000000005 RDI: ffffffff81529fc4
[   24.212970] RBP: 0000000000000001 R08: 000000000000ffff R09: ffffffff82e98430
[   24.213130] R10: 000000000002fffd R11: 00000000fffeffff R12: ff11000100125710
[   24.213317] R13: ffffffff83ec0f2d R14: ffffffff84b43820 R15: ffa0000000d4bb5b
[   24.213488] FS:  00007f46532a54c0(0000) GS:ff1100203be0c000(0000) knlGS:0000000000000000
[   24.213674] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.213813] CR2: 000055e885be1470 CR3: 000000010eef9003 CR4: 0000000000771ef0
[   24.213986] PKRU: 55555554
[   24.214044] Call Trace:
[   24.214100]  <TASK>
[   24.214167]  ftrace_modify_all_code+0x59/0x110
[   24.214301]  __ftrace_hash_move_and_update_ops+0x227/0x2c0
[   24.214415]  ? srso_return_thunk+0x5/0x5f
[   24.214502]  ? __mutex_lock+0x22a/0xc60
[   24.214588]  ? kfree+0x1ac/0x4c0
[   24.214682]  ? srso_return_thunk+0x5/0x5f
[   24.214765]  ? kfree+0x250/0x4c0
[   24.214855]  ? bpf_fentry_test3+0x4/0x20
[   24.214943]  ftrace_set_hash+0x13c/0x3d0
[   24.215041]  ftrace_set_filter_ip+0x88/0xb0
[   24.215132]  ? bpf_fentry_test3+0x4/0x20
[   24.215221]  disarm_kprobe_ftrace+0x83/0xd0
[   24.215328]  __disable_kprobe+0x129/0x160
[   24.215418]  disable_kprobe+0x27/0x60
[   24.215507]  kprobe_register+0xa2/0xe0
[   24.215594]  perf_trace_event_unreg+0x33/0xd0
[   24.215701]  perf_kprobe_destroy+0x3b/0x80
[   24.215790]  __free_event+0x119/0x290
[   24.215888]  perf_event_release_kernel+0x1ef/0x220
[   24.216007]  perf_release+0x12/0x20
[   24.216091]  __fput+0x11b/0x2a0
[   24.216183]  task_work_run+0x8b/0xc0
[   24.216293]  exit_to_user_mode_loop+0x107/0x4d0
[   24.216411]  do_syscall_64+0x25b/0x390
[   24.216497]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   24.216606]  ? trace_irq_disable+0x1d/0xc0
[   24.216699]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   24.216807] RIP: 0033:0x7f46530ff85b
[   24.216895] Code: 03 00 00 00 0f 05 48 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 e3 83 f8 ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 
ff ff 77 35 44 89 c7 89 44 24 0c e8 41 84 f8 ff 8b 44
[   24.217293] RSP: 002b:00007ffc40859770 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
[   24.217461] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f46530ff85b
[   24.217627] RDX: 0000000000000002 RSI: 0000000000000002 RDI: 0000000000000019
[   24.217785] RBP: 00007ffc408597c0 R08: 0000000000000000 R09: 00007ffc40859757
[   24.217950] R10: 0000000000000000 R11: 0000000000000293 R12: 00007ffc4085ddc8
[   24.218107] R13: 000055e8800de120 R14: 000055e88118d390 R15: 00007f46533de000
[   24.218306]  </TASK>
[   24.218363] irq event stamp: 201623
[   24.218445] hardirqs last  enabled at (201631): [<ffffffff8136008c>] __console_unlock+0x5c/0x70
[   24.218625] hardirqs last disabled at (201638): [<ffffffff81360071>] __console_unlock+0x41/0x70
[   24.218810] softirqs last  enabled at (201612): [<ffffffff812b8b97>] __irq_exit_rcu+0x47/0xc0
[   24.219012] softirqs last disabled at (201601): [<ffffffff812b8b97>] __irq_exit_rcu+0x47/0xc0
[   24.219208] ---[ end trace 0000000000000000 ]---
[   24.219693] ------------[ ftrace bug ]------------
[   24.219801] ftrace failed to modify 
[   24.219804] [<ffffffff81529fc4>] bpf_lsm_sk_alloc_security+0x4/0x20
[   24.220022]  actual:   e9:b7:ca:ad:3e
[   24.220113]  expected: e8:b7:c0:d5:ff
[   24.220203] ftrace record flags: e8980000
[   24.220307]  (0) R   tramp: ERROR!
[   24.220321] ------------[ cut here ]------------
[   24.220507] WARNING: kernel/trace/ftrace.c:2715 at ftrace_get_addr_curr+0x149/0x190, CPU#10: test_progs/311
[   24.220693] Modules linked in: bpf_test_modorder_y(OE+) bpf_test_modorder_x(OE) bpf_testmod(OE)
[   24.220895] CPU: 10 UID: 0 PID: 311 Comm: test_progs Tainted: G        W  OE       7.0.0-rc1-gda78c0a81eea #83 PREEMPT(full) 
[   24.221135] Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   24.221284] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-5.el9 11/05/2023
[   24.221467] RIP: 0010:ftrace_get_addr_curr+0x149/0x190
[   24.221577] Code: 00 4c 89 f7 e8 88 f8 ff ff 84 c0 75 92 4d 8b 7f 08 e8 fb b3 c1 00 4d 85 ff 0f 94 c0 49 81 ff b0 1c 6e 83 0f 94 c1 08 c1 74 96 <0f> 0b c6 05 
62 e8 2b 02 01 c7 05 54 e8 2b 02 00 00 00 00 48 c7 05
[   24.221938] RSP: 0018:ffa0000000d4bb10 EFLAGS: 00010202
[   24.222052] RAX: 0000000000000000 RBX: ff11000100125710 RCX: ff1100010b28a201
[   24.222205] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff81529fc4
[   24.222384] RBP: 00000000ffffffea R08: 000000000000ffff R09: ffffffff82e98430
[   24.222542] R10: 000000000002fffd R11: 00000000fffeffff R12: ff11000100125710
[   24.222708] R13: ffffffff83ec0f2d R14: ffffffff81529fc4 R15: ffffffff836e1cb0
[   24.222866] FS:  00007f46532a54c0(0000) GS:ff1100203be0c000(0000) knlGS:0000000000000000
[   24.223034] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.223171] CR2: 000055e885be1470 CR3: 000000010eef9003 CR4: 0000000000771ef0
[   24.223341] PKRU: 55555554
[   24.223397] Call Trace:
[   24.223454]  <TASK>
[   24.223511]  ? bpf_lsm_sk_alloc_security+0x4/0x20
[   24.223623]  ftrace_bug+0x1ff/0x290
[   24.223710]  ftrace_replace_code+0x1d6/0x210
[   24.223829]  ftrace_modify_all_code+0x59/0x110
[   24.223946]  __ftrace_hash_move_and_update_ops+0x227/0x2c0
[   24.224060]  ? srso_return_thunk+0x5/0x5f
[   24.224148]  ? __mutex_lock+0x22a/0xc60
[   24.224245]  ? kfree+0x1ac/0x4c0
[   24.224337]  ? srso_return_thunk+0x5/0x5f
[   24.224420]  ? kfree+0x250/0x4c0
[   24.224512]  ? bpf_fentry_test3+0x4/0x20
[   24.224597]  ftrace_set_hash+0x13c/0x3d0
[   24.224690]  ftrace_set_filter_ip+0x88/0xb0
[   24.224776]  ? bpf_fentry_test3+0x4/0x20
[   24.224869]  disarm_kprobe_ftrace+0x83/0xd0
[   24.224965]  __disable_kprobe+0x129/0x160
[   24.225051]  disable_kprobe+0x27/0x60
[   24.225136]  kprobe_register+0xa2/0xe0
[   24.225223]  perf_trace_event_unreg+0x33/0xd0
[   24.225346]  perf_kprobe_destroy+0x3b/0x80
[   24.225431]  __free_event+0x119/0x290
[   24.225518]  perf_event_release_kernel+0x1ef/0x220
[   24.225631]  perf_release+0x12/0x20
[   24.225715]  __fput+0x11b/0x2a0
[   24.225804]  task_work_run+0x8b/0xc0
[   24.225895]  exit_to_user_mode_loop+0x107/0x4d0
[   24.226016]  do_syscall_64+0x25b/0x390
[   24.226099]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   24.226207]  ? trace_irq_disable+0x1d/0xc0
[   24.226308]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   24.226415] RIP: 0033:0x7f46530ff85b
[   24.226498] Code: 03 00 00 00 0f 05 48 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 e3 83 f8 ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 
ff ff 77 35 44 89 c7 89 44 24 0c e8 41 84 f8 ff 8b 44
[   24.226851] RSP: 002b:00007ffc40859770 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
[   24.227016] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f46530ff85b
[   24.227173] RDX: 0000000000000002 RSI: 0000000000000002 RDI: 0000000000000019
[   24.227341] RBP: 00007ffc408597c0 R08: 0000000000000000 R09: 00007ffc40859757
[   24.227500] R10: 0000000000000000 R11: 0000000000000293 R12: 00007ffc4085ddc8
[   24.227652] R13: 000055e8800de120 R14: 000055e88118d390 R15: 00007f46533de000
[   24.227830]  </TASK>
[   24.227891] irq event stamp: 202299
[   24.227974] hardirqs last  enabled at (202307): [<ffffffff8136008c>] __console_unlock+0x5c/0x70
[   24.228162] hardirqs last disabled at (202314): [<ffffffff81360071>] __console_unlock+0x41/0x70
[   24.228357] softirqs last  enabled at (201682): [<ffffffff812b8b97>] __irq_exit_rcu+0x47/0xc0
[   24.228540] softirqs last disabled at (201671): [<ffffffff812b8b97>] __irq_exit_rcu+0x47/0xc0
[   24.228716] ---[ end trace 0000000000000000 ]---
[   24.228834] Bad trampoline accounting at: 00000000ab641fec (bpf_lsm_sk_alloc_security+0x4/0x20)
[   24.229029] 
[   24.229029]  expected tramp: ffffffff81286080
[   24.261301] BUG: unable to handle page fault for address: ffa00000004b9050
[   24.261436] #PF: supervisor read access in kernel mode
[   24.261528] #PF: error_code(0x0000) - not-present page
[   24.261621] PGD 100000067 P4D 100832067 PUD 100833067 PMD 100efb067 PTE 0
[   24.261745] Oops: Oops: 0000 [#1] SMP NOPTI
[   24.261821] CPU: 9 UID: 0 PID: 1338 Comm: ip Tainted: G        W  OE       7.0.0-rc1-gda78c0a81eea #83 PREEMPT(full) 
[   24.262006] Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   24.262119] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-5.el9 11/05/2023
[   24.262281] RIP: 0010:__cgroup_bpf_run_lsm_current+0xc5/0x2f0
[   24.262393] Code: a6 6f 1a 02 01 48 c7 c7 31 5b 71 82 be bf 01 00 00 48 c7 c2 d3 70 65 82 e8 d8 53 ce ff 4d 8b 7f 60 4d 85 ff 0f 84 14 02 00 00 <49> 8b 46 f0 
4c 63 b0 34 05 00 00 c7 44 24 10 00 00 00 00 41 0f b7
[   24.262693] RSP: 0018:ffa0000004dfbc98 EFLAGS: 00010282
[   24.262784] RAX: 0000000000000001 RBX: ffa0000004dfbd10 RCX: 0000000000000001
[   24.262923] RDX: 00000000d7c4159d RSI: ffffffff8359b368 RDI: ff1100011b5c50c8
[   24.263055] RBP: ffa0000004dfbd30 R08: 0000000000020000 R09: ffffffffffffffff
[   24.263187] R10: ffffffff814f76b3 R11: 0000000000000000 R12: ff1100011b5c4580
[   24.263325] R13: 0000000000000000 R14: ffa00000004b9060 R15: ffffffff835b3040
[   24.263465] FS:  00007f0007064800(0000) GS:ff1100203bdcc000(0000) knlGS:0000000000000000
[   24.263599] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.263709] CR2: ffa00000004b9050 CR3: 0000000120f4d002 CR4: 0000000000771ef0
[   24.263841] PKRU: 55555554
[   24.263890] Call Trace:
[   24.263938]  <TASK>
[   24.263992]  bpf_trampoline_6442513766+0x6a/0x10d
[   24.264088]  security_sk_alloc+0x83/0xd0
[   24.264162]  sk_prot_alloc+0xf4/0x150
[   24.264236]  sk_alloc+0x34/0x2a0
[   24.264305]  ? srso_return_thunk+0x5/0x5f
[   24.264375]  ? _raw_spin_unlock_irqrestore+0x35/0x50
[   24.264465]  ? srso_return_thunk+0x5/0x5f
[   24.264533]  ? __wake_up_common_lock+0xa8/0xd0
[   24.264625]  __netlink_create+0x2f/0xf0
[   24.264695]  netlink_create+0x1c4/0x230
[   24.264765]  ? __pfx_rtnetlink_bind+0x10/0x10
[   24.264858]  __sock_create+0x21d/0x400
[   24.264937]  __sys_socket+0x65/0x100
[   24.265007]  ? srso_return_thunk+0x5/0x5f
[   24.265077]  __x64_sys_socket+0x19/0x30
[   24.265146]  do_syscall_64+0xde/0x390
[   24.265216]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   24.265307]  ? trace_irq_disable+0x1d/0xc0
[   24.265379]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   24.265469] RIP: 0033:0x7f0006f112ab
[   24.265538] Code: 73 01 c3 48 8b 0d 6d 8b 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 29 00 00 00 0f 05 <48> 3d 01 f0 
ff ff 73 01 c3 48 8b 0d 3d 8b 0e 00 f7 d8 64 89 01 48
[   24.265822] RSP: 002b:00007ffd8ecb3be8 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
[   24.265960] RAX: ffffffffffffffda RBX: 000056212b30d040 RCX: 00007f0006f112ab
[   24.266088] RDX: 0000000000000000 RSI: 0000000000080003 RDI: 0000000000000010
[   24.266217] RBP: 0000000000000000 R08: 00007ffd8ecb3bc0 R09: 0000000000000000
[   24.266346] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[   24.266474] R13: 000056212b30d040 R14: 00007ffd8ecb3d88 R15: 0000000000000004
[   24.266617]  </TASK>
[   24.266663] Modules linked in: bpf_test_modorder_y(OE+) bpf_test_modorder_x(OE) bpf_testmod(OE)
[   24.266824] CR2: ffa00000004b9050
[   24.266897] ---[ end trace 0000000000000000 ]---
[   24.266989] RIP: 0010:__cgroup_bpf_run_lsm_current+0xc5/0x2f0
[   24.267101] Code: a6 6f 1a 02 01 48 c7 c7 31 5b 71 82 be bf 01 00 00 48 c7 c2 d3 70 65 82 e8 d8 53 ce ff 4d 8b 7f 60 4d 85 ff 0f 84 14 02 00 00 <49> 8b 46 f0 
4c 63 b0 34 05 00 00 c7 44 24 10 00 00 00 00 41 0f b7
[   24.267406] RSP: 0018:ffa0000004dfbc98 EFLAGS: 00010282
[   24.267499] RAX: 0000000000000001 RBX: ffa0000004dfbd10 RCX: 0000000000000001
[   24.267629] RDX: 00000000d7c4159d RSI: ffffffff8359b368 RDI: ff1100011b5c50c8
[   24.267758] RBP: ffa0000004dfbd30 R08: 0000000000020000 R09: ffffffffffffffff
[   24.267897] R10: ffffffff814f76b3 R11: 0000000000000000 R12: ff1100011b5c4580
[   24.268030] R13: 0000000000000000 R14: ffa00000004b9060 R15: ffffffff835b3040
[   24.268167] FS:  00007f0007064800(0000) GS:ff1100203bdcc000(0000) knlGS:0000000000000000
[   24.268311] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.268428] CR2: ffa00000004b9050 CR3: 0000000120f4d002 CR4: 0000000000771ef0
[   24.268565] PKRU: 55555554
[   24.268613] Kernel panic - not syncing: Fatal exception
[   24.268977] Kernel Offset: disabled
[   24.269046] ---[ end Kernel panic - not syncing: Fatal exception ]---



> ---
>  arch/x86/Kconfig        |   1 +
>  kernel/bpf/trampoline.c | 220 ++++++++++++++++++++++++++++++++++------
>  kernel/trace/Kconfig    |   3 +
>  kernel/trace/ftrace.c   |   7 +-
>  4 files changed, 200 insertions(+), 31 deletions(-)
> 
> [...]
