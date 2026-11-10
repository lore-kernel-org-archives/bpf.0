Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270471;
	b=MT3r+94urhtKeTYOnJFIZcDYN8Fls8249bjC9gn8Mj0F4byeuhHCs6sHIayC/IrYJt4d
	 2OxXQiEKb4UPngaAoUvBxgD9R4Lv8rctRGA+TLglEz36KDHTYPOa/VCC/hqMzDdE9agRn
	 iWZBQxy8FbdIAMGmL/VHTj1Q5trbPOMh64R7u8KYoX70cJL+tMNL3C4B8KqQk5qejb3VD
	 Ebioxbu9DfiqxMRuL4XntqVRc8ytYFwtBOQmZtvPEU9WL1lZiTi83iwSr6qd4XY49v5Mb
	 c0ANf9D7mSSzXekRwNf9D9xNKdDTjKZ9HN9SoSM0eQqhANCAzXEs+pDTRaNf9xnBGgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270471;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=CU3d0XcQLaaaWfi9UjENTKg67/NQ2TiAHdQitHJ2eYs=;
	b=X3jz9r/Z2GIepBEteRGGqqazMVTYrYP0TdJfZltZmgmhe1cLALCEs30XuT5jrF7w/3su
	 BBbAOb0T5wLKlQl+4HSMvdAV51sRzZK7E4vzmJ81W64DGiSo3m5uK1jkKEyUKxiuW1SLn
	 mHF4hca0nMo4a8o/anKoKyW2Fe6+OFe/SsVcqNJt0zcSQIRvHksWZfIo94Kw80qM2gzmY
	 kwcMNlVkUYu42ZXGJTwDhVIIuAhjDzsJxMwb2fV4f5jchSIWzsNSs9n3zo7zQSi42hLiq
	 aih3oJooAS5/xCvXuHskVBAxapn75WGwZluEHhevGR9OCqu9MAhybP2CBHKwzjsOcVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jW9N+mU9;
	arc=none smtp.remote-ip=74.125.225.71
Received: from mail-wr2-f7.google.com (mail-wr2-f7.google.com [74.125.225.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9BC606A321
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E9BC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jW9N+mU9
Received: by mail-wr2-f7.google.com with SMTP id ffacd0b85a97d-48e0c9bc8f9so661364f8f.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794270469; x=1794875269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CU3d0XcQLaaaWfi9UjENTKg67/NQ2TiAHdQitHJ2eYs=;
        b=jW9N+mU9xxqq47mxDYCVPHVKKa1A4AAcu36Utz8KZGRAvGn+H3h+mvkzrl+yaJwVPv
         17tkrvuR/dPpV2km0vYUOO/Bq/qlUb0MN8+vUYXWVIB9ixPMWfrt+T/4KXqQ6LsZ+LuA
         +J8znO7PgpiY8iDNswlbCtMbLIaatI22T6HEq/nRD0sZFYLlknradpMNSRXogIfexiM/
         rtirkpUO86XOsdb6XHENNMhplC4yriIW/2UFR21gQau2AwpGJIFZ3alKj26pOcEQFWEz
         nKS3z9vtFW+NpEiquGGp4iV68p2eznSX6R3nr1idMCwtI59KEnliDkApkpLKappdpOZp
         VbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270469; x=1794875269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CU3d0XcQLaaaWfi9UjENTKg67/NQ2TiAHdQitHJ2eYs=;
        b=q95jpkfmv83+Nt5gmJ1l/8I6VhFeFSYTcB7Nm20jyqrfogwc7hNFqrah6jLlB5v41d
         vZcSmiJcGtIpj0ROr6VIfoMQhn70R8BupOxwBmENC69Ia4RCR/XKyeTxpl8f58s2HXpX
         r4oLMStyU6xdU6HziV3kjjeXAzQvza1TNYXwjidmUP+UWrkNcCXdX1TJUhuz0Gl9sfrL
         uAy4KvCgKTzRjRO4VQL5eu6OU4CFcmENafJyZwhk91gIbg9vggNRUBMCcfJa7sljhRax
         SLXKp//lsay4CQyqrNybEAr+1KTNhjtTzKttlORDdBnJEi7IVS2cDyG2h3iqc7KpbPR2
         qJUw==
X-Gm-Message-State: APuU4Z+mlxts4QfHI8QK/DZEk/obdN07jWBWpClDkzs0iDN/Ff9gnbrl
	23Kf/gQ1/sx89vcTDZO10UbZZSHyUBgjnhmhrWtgetPAIQaK6OuEkRAN8t1Ms0QJ
X-Gm-Gg: AYBFou2mXAw25CcmvfNX63b23oujnwfK4XtRwdtokQz+T94Gelowjc8TizADBurwUmt
	X39k5vfW6UYjmOUtdS+j+8y85mlZ/Rbw1nk5AtUuihCngYhnFLyOQbChxbv7PAau6qIQ1XIk5++
	Ulmh5cEOqIUrGylC2kMNjn9vTSLulf8WMhxdRsfcC89ikejvUjp3Xr78yZGucV7vTHZTzshtGTG
	g9tNeLs9xJSb0qYBszoriaC8Wa3ujMRzDcZGh2kTEBkBOWcaPjlJFbXCkLJAvbroD0Pjm5lezyk
	Rflxq1xHuWQLMU6DcGYV8AzXnEpJC5/HxeP9YxfURJLwoB3O/k3mvJyTPOoFRWjMgl76z3eSvun
	etvmCuKmKP8L2Fq3eM6x+LiMCDzWfgVbAZpPXJ3leC8oJXPDqxLV2GcU+k7wls3Dfr+1WRAeIk9
	RXs12+K+rc0Aw5jqvoUFoNTnyUdHjZF7j8WnZ2742XikZDs4GgX6nTo7WKplso27EUjvkbFiG0F
	2T9iRDDOsPQrfbtLLQUPSNhSTUUlhDaAOCImeIljZMGLZnx5qzJXzODHrJ9k2nEV6gQJKG9YVPz
	JZeJHUbhnJynLSophVG3ALxOrvPO37lzK/1lkGQVo7rG00iTrmuMc6NUUWG4Du6ItAZFqKtu/R5
	s0yUJLjQmkUMuY1zzAN5AW/wxH51UC2GMWYPWBorXZHsOs9wFngvo5tASPk+Jrg/ILlxC
X-Received: by 2002:a05:6000:4006:b0:48b:9d2:1a6a with SMTP id ffacd0b85a97d-4982b289bd0mr2121512f8f.1.1794270468465;
        Mon, 09 Nov 2026 16:27:48 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983284c990sm1752680f8f.3.2026.11.09.16.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:27:47 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 01/20] bpf: Add bpf_task_park() and bpf_task_wake()
Date: Tue, 10 Nov 2026 01:27:23 +0100
Message-ID: <1828a732fe7602f8d93fd972b3e3bb6b366a2a45.1794269506.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794269506.git.memxor@gmail.com>
References: <cover.1794269506.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17296; i=memxor@gmail.com; h=from:subject:message-id; bh=yHrK/3W+G59iK3hLAIBv7c/VrmFujAeS/7qF11NY7WY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetTonOnscKrR+dfPHpV7LDpnrh1KnP9jaitVnOWPU9vV rKeeSuzo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABOJ1Wf4Z/R0V7hid/XFS2d7 F6gxFxxQ62qdzml95ZPcB375qjbdLoZ/Knp2GXu2iy3U33TNIPli3Z7Ebxsb3jzetdh81ds1xtK /mQE=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Currently, there is no BPF primitive for a program to sleep for
arbitrary lengths of time while waiting for a wake up controlled by
another program to happen. Several BPF programs run in contexts where
such unbounded sleeping can be harmful.

Moreover, unbounded sleeps can be problematic, since a sleepable BPF
program runs with migration disabled under a Tasks Trace RCU read
section, and neither may be held across a sleep of unbounded length: the
read section would stall every Tasks Trace grace period in the system,
and a migration-disabled sleeper keeps rq->nr_pinned raised, which
blocks CPU offline in balance_hotplug_wait() and pins its wakeup to the
CPU it slept on.

Introduce low-level primitives that let BPF programs construct such
patterns. bpf_task_park() puts the current task to sleep and
bpf_task_wake() makes a task runnable. The program keeps its own queue
of waiters and its own condition for when the event has arrived, in
arena memory, in graph nodes holding a task kptr, or in a map value, and
checks the condition in a loop around the park:

	waiter				waker

	while (!cond)			cond = true;
		bpf_task_park(...);	bpf_task_wake(task, 0);

The kernel owns nothing per queue: there is no object to allocate,
initialize, tear down, or synchronize against the map value going away.
It keeps one word per task, bpf_wake_pending, which has to make that
loop work.

No wake is lost between the check and the sleep. The check is made in
the program, so something has to carry a wake across the gap between it
and the sleep, and the word does, the way the stop bit does for
kthread_should_stop(). bpf_task_wake() stores the word and calls
wake_up_state(); bpf_task_park() sets the task state, reads the word
again, and sleeps only if it is clear. The barrier in
set_current_state() pairs with the one in try_to_wake_up() that follows
the waker's store, so either the waiter sees the pending wake or the
waker sees it sleeping. A wake that finds its task running is kept until
that task's next park, which then returns at once; a stale one costs a
spurious turn of the loop.

The waiter sees the condition once the park has returned. The pairing
above covers the sleep, but it does not order the word against the
program's own condition, and the loop depends on that order: the waker
stores the condition and then wakes, the waiter returns from the park
and then reads the condition, and the read must see the store. Two
things provide it. bpf_task_wake() stores the word with xchg(), which is
fully ordered, so the condition stores before the call are visible to
whoever observes the word. bpf_task_park() consumes the word with xchg()
on every return, so the condition loads after the return cannot be
satisfied before the word was observed. On a weakly ordered architecture
a plain store and a plain load would let the waiter observe the wake,
read a stale condition, park again with the word already cleared, and
sleep with no one left to wake it.

A release is not enough for the store, because wakers race with each
other. Of two wakers' stores one overwrites the other, and the waiter
observes only the later one. A release orders a waker's condition before
its own store of the word, for whoever reads that store; nobody reads
the store that was overwritten, so nothing orders that waker's condition
before the waiter's read of it. The waiter then consumes both wakes,
misses one condition, and parks again while the waker saw it running.
The kernel memory model allows that outcome with a release and forbids
it with xchg().

The xchg() also makes the consume atomic. A wake that lands after the
park observed the word but before it cleared it is not lost: the
exchange returns the value at the instant of the reset, so the wake is
either consumed by this park or still pending for the next one.

bpf_task_park() returns:

 - 0 when it consumed a wake, or when the sleep ended for no recorded
   reason. The program tells a wake from such a spurious return by its
   own condition.
 - -ESHUTDOWN when a stop or park request for a kthread is pending.
   Nothing clears the request while the thread's function runs, so
   every later park that finds no wake pending fails the same way and
   the caller has to return, which is why it is not reported as a signal
   is.
 - -EINTR when a signal is pending. The signal and the request are both
   checked for every caller, since a kthread that called allow_signal()
   has signals too, and both before the sleep and after it.
 - -ETIMEDOUT when the timeout passed. A timeout of 0 polls and U64_MAX
   sleeps without a timer.

When more than one of these applies, a wake wins over a stop request, a
stop request over a signal, and either over the timeout. The wake wins
because the waker may have dequeued or accounted for the sleeper on the
strength of its wake having been delivered, and the sleeper's return
value should agree, the way a futex that was woken returns 0 even if its
timer also fired. The consuming xchg() is what makes it win: a wake that
arrives while the timeout expires or a signal is noticed is reported
rather than discarded with the word. A signal or a stop request wins
over a timer that fired at the same time because the request stays
pending and the timeout does not. schedule_hrtimeout() tells an expiry
from an early return but not a wake from a signal, so the flags are read
again after it and decide first.

bpf_task_wake() returns 1 when the task was asleep and 0 when it was
not.

The sleep is interruptible for every caller. A kthread normally has no
signals, so TASK_INTERRUPTIBLE is harmless there, avoids the load
average and the hung task detector, and lets bpf_task_wake() use a
TASK_INTERRUPTIBLE mask, which can never disturb an uninterruptible
sleeper elsewhere in the kernel.

The word is an int rather than a byte so that the exchange is a plain
4-byte xchg() on every architecture. dup_task_struct() clears it: a
child inherits nothing from a wake addressed to its parent.

The park drops migration and the Tasks Trace RCU section around the
sleep. That is sound only where the invocation's runner holds the
program, its maps and its context for the whole invocation, so that the
program's own memory needs no grace period, and where nothing on the run
path keeps per-CPU state across the program. The kfunc comment states
that contract, and the verifier patches that follow confine the call to
such contexts and invalidate what the sleep may free.

Both kfuncs take a flags argument that must be 0. Only the two functions
and the word they share are added here: later patches register the
kfuncs, and until then nothing can call them.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/sched.h  |   2 +
 kernel/bpf/Makefile    |   2 +-
 kernel/bpf/task_park.c | 192 +++++++++++++++++++++++++++++++++++++++++
 kernel/fork.c          |   1 +
 4 files changed, 196 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/task_park.c

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1c93da75226e..43222c34fab8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1630,6 +1630,8 @@ struct task_struct {
 	struct bpf_local_storage __rcu	*bpf_storage;
 	/* Used for BPF run context */
 	struct bpf_run_ctx		*bpf_ctx;
+	/* Set by bpf_task_wake(), consumed by bpf_task_park() */
+	int				bpf_wake_pending;
 #endif
 	/* Used by BPF for per-TASK xdp storage */
 	struct bpf_net_context		*bpf_net_context;
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index d26c62326e58..34357665c34c 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -15,7 +15,7 @@ obj-$(CONFIG_BPF_SYSCALL) += fixups.o cfg.o states.o check_btf.o flow.o join.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
-obj-$(CONFIG_BPF_SYSCALL) += btf.o memalloc.o rqspinlock.o stream.o
+obj-$(CONFIG_BPF_SYSCALL) += btf.o memalloc.o rqspinlock.o stream.o task_park.o
 ifeq ($(CONFIG_MMU)$(CONFIG_64BIT),yy)
 obj-$(CONFIG_BPF_SYSCALL) += arena.o range_tree.o
 endif
diff --git a/kernel/bpf/task_park.c b/kernel/bpf/task_park.c
new file mode 100644
index 000000000000..39c9f085f7a9
--- /dev/null
+++ b/kernel/bpf/task_park.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/hrtimer.h>
+#include <linux/kthread.h>
+#include <linux/rcupdate_trace.h>
+#include <linux/sched.h>
+#include <linux/sched/signal.h>
+
+/*
+ * A BPF program that blocks for an event keeps its own queue of waiters and
+ * its own notion of when the event has arrived. The kernel contributes two
+ * operations over the task: bpf_task_park() puts the current task to sleep
+ * and bpf_task_wake() makes a task runnable. The only shared state is one
+ * word in the task, bpf_wake_pending, which lets the program check its
+ * condition outside the kernel without losing a wake that lands between
+ * the check and the sleep: the waker sets the word before it wakes the
+ * task, and a park that finds it set returns instead of sleeping.
+ *
+ * The word also carries the ordering the program relies on. A waker
+ * publishes its condition and then calls bpf_task_wake(); a waiter reads
+ * the condition, finds it unmet, calls bpf_task_park(), and reads the
+ * condition again after the return. The second read must see the waker's
+ * condition whenever the park returned because of that wake, so the store
+ * of the word and the load that consumes it are both an xchg(): the store
+ * is fully ordered after the waker's condition stores, the load before the
+ * waiter's later condition loads. A release would not do for the store. Of
+ * two wakers' stores one overwrites the other, the waiter observes only the
+ * later one, and nothing would order the earlier waker's condition before
+ * the waiter's read of it. The xchg() also makes the consume atomic: a wake
+ * that lands between the waiter's observation of the word and its reset is
+ * not erased but stays pending for the next park.
+ */
+
+/*
+ * What ends a park besides a wake and the timeout: a stop or park request for
+ * a kthread, or a signal. Both are checked for every caller, since a kthread
+ * that allowed signals has them too, and the kthread checks are false for a
+ * user task. The request is reported apart from a signal because nothing
+ * clears it while the thread's function runs: every later park that finds no
+ * wake pending fails the same way, so the caller has to return.
+ */
+static int bpf_task_park_interrupted(void)
+{
+	if (kthread_should_stop_or_park())
+		return -ESHUTDOWN;
+	if (signal_pending(current))
+		return -EINTR;
+	return 0;
+}
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_task_park - Sleep until bpf_task_wake() is called for the current task
+ * @timeout_ns: relative timeout, or U64_MAX for none
+ * @flags: must be 0
+ *
+ * Returns at once if a wake is pending from a bpf_task_wake() that found the
+ * task running. Otherwise sleeps interruptibly until a wake, the timeout, a
+ * signal, or a stop or park request for a kthread. Every return past the
+ * argument check consumes the pending wake, and a wake takes precedence over
+ * a timeout, a signal or a stop request noticed at the same time, since the
+ * waker may already have accounted for it. Any return hands control back to
+ * the program's own check of its condition, and spurious returns are
+ * possible. A @timeout_ns of 0 polls: it reports a pending wake,
+ * then a stop or park request as -ESHUTDOWN, a pending signal as -EINTR, and
+ * otherwise -ETIMEDOUT, without sleeping.
+ *
+ * Return: 0 when a wake was consumed or the sleep ended for no recorded
+ * reason, -ETIMEDOUT when the timeout passed, -ESHUTDOWN when a stop or park
+ * request for a kthread is pending and -EINTR when a signal is, whether it
+ * was found before the sleep or ended it, even if the timeout passed
+ * meanwhile, -EINVAL when @flags is not 0. Nothing clears a stop or park
+ * request while the thread's function runs, so once a call has returned
+ * -ESHUTDOWN, every later one that finds no wake pending does too.
+ */
+__bpf_kfunc int bpf_task_park(u64 timeout_ns, u64 flags)
+{
+	ktime_t expires = min_t(u64, timeout_ns, KTIME_MAX);
+	bool expired;
+	int ret = 0;
+
+	if (flags)
+		return -EINVAL;
+	if (READ_ONCE(current->bpf_wake_pending))
+		goto out;
+
+	/*
+	 * set_current_state() is a full barrier that pairs with the one in
+	 * try_to_wake_up() after the waker's store of bpf_wake_pending:
+	 * either this task observes the pending wake below or the waker
+	 * observes it sleeping and wakes it.
+	 */
+	set_current_state(TASK_INTERRUPTIBLE);
+	if (READ_ONCE(current->bpf_wake_pending)) {
+		__set_current_state(TASK_RUNNING);
+		goto out;
+	}
+	/*
+	 * kthread_stop(), kthread_park() and signal delivery set their flag
+	 * and wake the task in the same way, so the same ordering covers
+	 * them.
+	 */
+	ret = bpf_task_park_interrupted();
+	if (ret) {
+		__set_current_state(TASK_RUNNING);
+		goto out;
+	}
+
+	/*
+	 * Sleepable programs run with migration disabled under a Tasks Trace
+	 * RCU read section. Neither may be held across a sleep of unbounded
+	 * length: the read section would stall every Tasks Trace grace period
+	 * in the system, and a migration-disabled sleeper keeps rq->nr_pinned
+	 * raised, which blocks CPU offline in balance_hotplug_wait() and pins
+	 * the wakeup to the CPU it slept on.
+	 *
+	 * Dropping both is correct only where the caller's runner holds the
+	 * program, and with it its maps and context, for the whole
+	 * invocation, so that the program's own memory needs no grace period,
+	 * and where nothing on the run path keeps per-CPU state across the
+	 * program. The verifier confines the call to such contexts: the main
+	 * body of a syscall program and the functions it calls directly, never
+	 * a callback, and never a region that pins the CPU, a lock, a saved
+	 * IRQ state or an RCU read section. It also invalidates every pointer
+	 * the program holds across the call except its stack, its context,
+	 * maps it references directly and the values of its arrays, arena
+	 * memory and verifier-tracked references. What remains is that the
+	 * program may resume on another CPU, which is part of the contract.
+	 */
+	migrate_enable();
+	rcu_read_unlock_trace();
+	/*
+	 * A NULL expiry sleeps without a timer; a zero one returns at once.
+	 * schedule_hrtimeout() tells an expiry from an early return, but not
+	 * a wake from a signal or a stop or park request, so read the flags
+	 * again, as before the sleep. They win over an expiry that fired at
+	 * the same time, since the request stays pending and the timeout
+	 * does not; a wake, consumed below, wins over both.
+	 */
+	expired = !schedule_hrtimeout(timeout_ns == U64_MAX ? NULL : &expires, HRTIMER_MODE_REL);
+	ret = bpf_task_park_interrupted();
+	if (!ret && expired)
+		ret = -ETIMEDOUT;
+	rcu_read_lock_trace();
+	migrate_disable();
+out:
+	/*
+	 * Consume the wake. xchg() is fully ordered, so the condition loads
+	 * the program makes after the return see the stores the waker made
+	 * before its bpf_task_wake(). A wake that raced with the timeout, the
+	 * signal or the stop request wins: the waker may have accounted for it.
+	 */
+	if (xchg(&current->bpf_wake_pending, 0))
+		ret = 0;
+	return ret;
+}
+
+/**
+ * bpf_task_wake - Wake a task parked in bpf_task_park()
+ * @task: task to wake
+ * @flags: must be 0
+ *
+ * Marks a wake pending for @task and wakes it if it sleeps interruptibly.
+ * A task that is not parked keeps the pending wake until its next
+ * bpf_task_park(), which then returns at once.
+ *
+ * Return: 1 when @task was asleep and is now runnable, 0 when it was not,
+ * -EINVAL when @flags is not 0.
+ */
+__bpf_kfunc int bpf_task_wake(struct task_struct *task, u64 flags)
+{
+	if (flags)
+		return -EINVAL;
+
+	/*
+	 * xchg() is a full barrier. It orders the program's stores before this
+	 * call, its condition, before the word, so a park that consumes the
+	 * word sees them, also when what it consumes is another waker's store
+	 * that overwrote this one. try_to_wake_up() then orders the store
+	 * before its load of the task state, pairing with set_current_state()
+	 * in bpf_task_park().
+	 */
+	xchg(&task->bpf_wake_pending, 1);
+	return wake_up_state(task, TASK_INTERRUPTIBLE);
+}
+
+__bpf_kfunc_end_defs();
diff --git a/kernel/fork.c b/kernel/fork.c
index 8b108ed37152..b66eb25626c9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1019,6 +1019,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 #ifdef CONFIG_BPF_SYSCALL
 	RCU_INIT_POINTER(tsk->bpf_storage, NULL);
 	tsk->bpf_ctx = NULL;
+	tsk->bpf_wake_pending = 0;
 #endif
 	return tsk;
 
-- 
2.53.0

