Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270479;
	b=pOHjQle7Yg3fTrA65mWFZrUJvecEeuW39dQ3k5LdDym8fy4WxzuAlo6/LdSyE5mdilOH
	 I0k7Cmp7Lgw2Jn2QeIbmOb6+bdm3JVC1NtYcbmVW0m60qW1KiU4ba4+6EL/NfLfU+W9HD
	 91296wfCDVMfjCieCEmNRsu1nf9XL9OnNSajNTMmRs4cYbfygHLXTCuM7fsZjmcgY9QSK
	 QQLwWgMvC0CpdcKGTbHAQqOk4Sq8DBhiaVh3HlWh+mOa8s92OIbUqPCTmW8b5tBm0LlGx
	 ISq3WKVYXa65lkQIfOvrJWpfxpf8TRuho9A4bA3PSQ9ncVQ35mzZyfAkz4gCPd7IeOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270479;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=Tqj1ZHEZ0nukWtFYWQ5e3TlVo1zAZhEe+jgePKDmKHU=;
	b=M7AjnPvt2PSWzPfyRY5+u3PoWSa0Apq1kfyunix70B39h9d0f9qVKEVZaUulBPum/tsp
	 n+9Uc3b+LkNgNd25Nc2hJxESvmKbikLTGE36fJDFuAb1a4C44V2Hp2XBfVHfP737BwIHc
	 /EWXXAyt7cgFdKz5PXAujwHE5R/w0O78ySSZAwCmcJZEyCwYUSkpgzUESDym8vdpbgcQ9
	 DXD3ECfFRnqg4BpWyb5SYOPrVpOiYCqQhvWQlYy8IUv0sCGhqIRs9duVqzLemwuTfFkJ2
	 Rw/1TwMgJvscZShpzg8+U+J9QlEXVVp6Pa9u1WR1IAcyc/VQtuOjtfMesd37LU5DEgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kywELuE1;
	arc=none smtp.remote-ip=74.125.225.134
Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC47606A31C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BC47606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kywELuE1
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-4a1d25d7d5dso5751765e9.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794270478; x=1794875278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tqj1ZHEZ0nukWtFYWQ5e3TlVo1zAZhEe+jgePKDmKHU=;
        b=kywELuE1VosZryS+WG5uf1nGg/mi7vuNOZc2tnKtK3vqkCc/JQ8rx3kRG5+4wQ8ZUV
         it7c8cHNT3infg7IymWvVR6MSy4H8b03BPqd01+bjY9w/JvfPXUch718X3vWpzom03uV
         xH37ONkn2juhCcIaF3rFw8peCvX8CZKQoIUvb6585SBmew8J3bcoWvt4FCBPtr7t7Y2M
         uRwNJsUm4yXioX48we8CArtzX0ujaGbcSzrkYzilt6Fzm3BBIroBZbcPUIOXReTs99RS
         obWoFDhcUEEKZJCkK7zn98b/gH/yWA1j4XWX5Aj4E4V4PqOB0F4zvdGXOWOal4vI4nPE
         li7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270478; x=1794875278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tqj1ZHEZ0nukWtFYWQ5e3TlVo1zAZhEe+jgePKDmKHU=;
        b=hDsqKWWaHGVx30pX98nDZSiLf8KSIfYQOpBYbyA74ubiL6+R8gAVhghGjZjhBme2PF
         aYoEt7EPSRUADHhcv53rFboGeQyyHHEyZs35N6W2XZfqDJWHNiR3KQAZeaSh1/GnEcRv
         t3GsJ5B327W4+XUkF0mQXC0ZvGn6dCMDmm80NFZTDeZyO0RLwQ8uMJAs1iDBwM+EJejd
         dCmlh441KUhLLIMgkG9g/dkQBcfYBlqW15/d9ymDr5KZuTlQQ7qDYt9ojiW6iVF/kfBE
         wRaS6ZmZ4m7gYgwkGfTgB2dvhFSCpN1CbUmeg+WbP6V5WPpyPy2Q0FZgJQIXofRxMVt5
         P8vw==
X-Gm-Message-State: APuU4Z+30+t4hhx1JHJQ202DuV9tu/okOWVQRYsT6pE3n5CfHl+kzSw3
	434OLtvNblvO4TpaVpFaiomzsqxeQCYvLGikICuxFc73hX+ySxM5d5cikFjSuZ1c
X-Gm-Gg: AYBFou0nmOlbqB4sxG/HctZ3ck8XsRIjTXaAypiUj8Ggi09IktncAfRaHJpq1iFu+7N
	zpDRfCWScY7/HxnyrNRu/qA8NNnAS5yEYm7KuEybhKub+NXLYrgYQE1AqDecWU8gW98ReyhwLUn
	6nRbRwj13wB0nfpUYzx3gRADZeF9UGvKhjnoBd+b+7QKaPUfXLZCYUqBCJNOlkGteQck0UI7BXI
	KIig4TRfEQheHTNQ6GN1+fswEyklK+tEEFtlblovTK1vUqnVSpiy0s4l7A7k5ZmaFAMivjRLMH8
	uqGQDRNBKFtA347+CRBpKcxfy0Gbb/xIgw7IrJvrouESC/oXhYIqQXLwKd2Ulvikml39j6+nTNj
	wCjFLMstNcOq09dOL6U8eUzJJenKRnMdWoWbzUaw0Ua0Qzt+n5bsMej7vv11LZq5ml7DKfN2+9R
	D1+EsTex2GKJwl2fuoWuo8BvOd1xSVzrcnF6+t8iSLqUS/DVHp5XgxnaXFu08gsan5zjlV4bNzH
	vW87f8GI95iCqFGBy5JOf1SDPLUmqkuf2Ntbuynes2k5btKCG6VBc8A3n4eK7RREP4H2uzsXfrh
	IhWdjM9AuzaoaziDitNLN57F3Co5l505+sfmcpfMVNIR7fwfmKJbZeYPSzH/0YHOzXfe3SMUEwX
	RIJ7xWtWcffoTXmTCBvb9LJeTKG78W0EyM/zLEaMcxM5UsXm9BbaElb5gbLyYmQH6fBDQXQgP1n
	Tv9Q+rmG83J0Jypg==
X-Received: by 2002:a05:600c:198f:b0:4b4:49d7:bc25 with SMTP id 5b1f17b1804b1-4ba0234a940mr12340935e9.21.1794270477648;
        Mon, 09 Nov 2026 16:27:57 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fef1d0sm23881055e9.13.2026.11.09.16.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:27:57 -0800 (PST)
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
Subject: [PATCH bpf-next v1 06/20] bpf: Defer bpf_task_wake() to irq_work when IRQs are disabled
Date: Tue, 10 Nov 2026 01:27:28 +0100
Message-ID: <e405280f8db39c5e378b6c42077c8b8f1f2c6d0d.1794269506.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10067; i=memxor@gmail.com; h=from:subject:message-id; bh=fqjhOAkrJawV7eZaPQPcmCL4WJ5ZrUj8bIaWqasvIxE=; b=kA0DAAoWRy03e2NUL4MByyZiAGryYUWhBJE75SLav3Lq02v1dZl5BRjNbSrEFBceGjLnwSkfD oh1BAAWCgAdFiEEdP++AjPIeftRPaYLRy03e2NUL4MFAmryYUUACgkQRy03e2NUL4MqqwD9HyMS oR5n8jnmV67jy8XMFl0iAAVkmEq5f1SUiKCSl7wBAJ9rLwdx9T4/6AGeI2Sf8yC+sNV7SSlY3lF b/epiO2sC
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

bpf_task_wake() ends a park with try_to_wake_up(), which takes the
task's pi_lock and a runqueue lock. The wake is meant for tracing
programs as much as for the program that parked: the kernel event that
makes a parked task worth waking is usually one a tracing program sees.
Those programs run where try_to_wake_up() may not:

 - the scheduler's own tracepoints fire with IRQs disabled, sched_waking
   under the woken task's pi_lock and sched_switch under the runqueue
   lock;
 - a kprobe often runs in an interrupts-off region of the function it
   probes;
 - a perf event program on a hardware event runs in NMI context.

Queue a wake that is asked for with IRQs disabled for irq_work on the
calling CPU, which issues it as soon as IRQs are enabled again. One test
covers both reasons to defer: a caller with IRQs enabled holds no
scheduler lock, since every one of them is taken with IRQs disabled, and
NMI context has IRQs disabled on every architecture. The usual case
keeps its direct wake and pays one read of the IRQ flag. A program that
wakes inside a bpf_local_irq_save() section holds no scheduler lock and
could wake directly, but the kfunc cannot tell it from a caller that
does, so its wake is deferred as well.

A deferred wake returns 2. It cannot tell whether the task was asleep,
which is what the 1 and the 0 of a direct wake say, and a waker that
reads 0 as a task that was already running, and picks another to wake,
would otherwise wake every one of its candidates when it runs with IRQs
disabled. The waiter learns from its own return value whether a wake
ended its sleep.

The queue runs through a node of its own in the task, bpf_wake_node,
under the rule the scheduler's wake queues follow for theirs:

 - a task is on at most one queue;
 - the claim is a cmpxchg() of the node's next pointer from NULL;
 - whoever holds the claim wakes the task;
 - a waker that finds the task claimed leaves the wake to the claimant.

A wake that loses the claim is not lost. The pending word is stored
before the claim is tried, and the xchg() that stores it is a full
barrier between the two. A claim that fails has therefore observed the
node before the holder's reset of it, and the holder's wake, a full
barrier after that reset, orders the word before the woken task's loads.
If the task is parked, the claimant's wake ends the park, which then
consumes the word; if it is not, the word waits for its next park, as a
wake that finds the task running always has.

The task's wake_q node is not used for this, although it would save the
field. Whoever claims that node may turn away a futex, rwsem or
semaphore wakeup that then relies on the claimant, so the drain would
have to wake with TASK_NORMAL, and a program could aim a wake of an
uninterruptible sleep at any task it names. Not every such sleep
tolerates one: a new kthread sleeps once, without a loop, until its
creator wakes it. With a node of its own the drain wakes interruptible
sleeps only, as the direct wake does.

The per-CPU queue is a stack rather than a wake_q_head. The head of a
wake queue is two words updated without atomics, and this queue is
pushed from NMI context while the irq_work that drains it runs in hard
IRQ context on the same CPU. A push is a cmpxchg() on the one head
pointer and the drain takes the whole stack with one xchg(), so a push
that interrupts the drain lands on an empty stack and queues the work
again, which irq_work permits because it clears its pending bit before
running the callback. The work is a hard irq_work so that on PREEMPT_RT
the wake is not queued behind the irq_work thread.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/sched.h  |  2 +
 kernel/bpf/task_park.c | 86 +++++++++++++++++++++++++++++++++++++++++-
 kernel/fork.c          |  1 +
 3 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 43222c34fab8..0fdd39174436 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1632,6 +1632,8 @@ struct task_struct {
 	struct bpf_run_ctx		*bpf_ctx;
 	/* Set by bpf_task_wake(), consumed by bpf_task_park() */
 	int				bpf_wake_pending;
+	/* On a CPU's queue of deferred bpf_task_wake() calls when not NULL */
+	struct wake_q_node		bpf_wake_node;
 #endif
 	/* Used by BPF for per-TASK xdp storage */
 	struct bpf_net_context		*bpf_net_context;
diff --git a/kernel/bpf/task_park.c b/kernel/bpf/task_park.c
index 39c9f085f7a9..5a9b3124312e 100644
--- a/kernel/bpf/task_park.c
+++ b/kernel/bpf/task_park.c
@@ -5,10 +5,12 @@
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
 #include <linux/hrtimer.h>
+#include <linux/irq_work.h>
 #include <linux/kthread.h>
 #include <linux/rcupdate_trace.h>
 #include <linux/sched.h>
 #include <linux/sched/signal.h>
+#include <linux/sched/wake_q.h>
 
 /*
  * A BPF program that blocks for an event keeps its own queue of waiters and
@@ -35,6 +37,75 @@
  * not erased but stays pending for the next park.
  */
 
+/*
+ * A wake asked for with IRQs disabled cannot be issued there: the caller may
+ * have interrupted the scheduler with the task's pi_lock or a runqueue lock
+ * held, or may run in NMI context, where try_to_wake_up() may take neither.
+ * Such wakes are queued on the CPU and issued from irq_work once IRQs are
+ * enabled again.
+ *
+ * The queue goes through a node of its own in the task, under the rule the
+ * scheduler's wake queues follow for theirs: a task is on at most one queue,
+ * whoever claimed the node wakes the task, and a waker that finds it claimed
+ * leaves the wake to the claimant. The pending word is set before the claim
+ * is tried, so a wake left this way still reaches a parked task through the
+ * claimant's wake, and any other task through its next park.
+ *
+ * The task's wake_q node would save the field, but whoever claims that node
+ * may turn away a futex, rwsem or semaphore wakeup that then relies on the
+ * claimant, and so has to wake with TASK_NORMAL. A program could then aim a
+ * wake of an uninterruptible sleep at any task it names, and not every such
+ * sleep has a loop around it: a new kthread sleeps once until its creator
+ * wakes it. With its own node the drain wakes interruptible sleeps only, as
+ * the direct wake does.
+ *
+ * The queue is a stack with a per-CPU head: pushed with cmpxchg() from
+ * whatever context asks, emptied with one xchg() by the irq_work, so a push
+ * that interrupts the drain lands on an empty stack and queues the work
+ * again.
+ */
+static DEFINE_PER_CPU(struct wake_q_node *, bpf_task_wake_queue);
+
+static void bpf_task_wake_deferred(struct irq_work *work)
+{
+	struct wake_q_node *node = xchg(this_cpu_ptr(&bpf_task_wake_queue), NULL);
+
+	while (node) {
+		struct task_struct *task = container_of(node, struct task_struct, bpf_wake_node);
+
+		node = node->next == WAKE_Q_TAIL ? NULL : node->next;
+		/* The task may be queued again from here on. */
+		WRITE_ONCE(task->bpf_wake_node.next, NULL);
+		wake_up_state(task, TASK_INTERRUPTIBLE);
+		put_task_struct(task);
+	}
+}
+
+static DEFINE_PER_CPU(struct irq_work, bpf_task_wake_work) =
+	IRQ_WORK_INIT_HARD(bpf_task_wake_deferred);
+
+static void bpf_task_wake_defer(struct task_struct *task)
+{
+	struct wake_q_node *node = &task->bpf_wake_node, *head;
+
+	/*
+	 * The claim, as in __wake_q_add(): NULL is free, anything else is
+	 * queued. The xchg() that stored the pending word is a full barrier
+	 * between that store and the claim, so a claim lost to another holder
+	 * is still covered: the holder's wake follows its own reset of the
+	 * node, which this claim did not observe, so the task it wakes
+	 * observes the word.
+	 */
+	if (cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL))
+		return;
+	get_task_struct(task);
+	head = this_cpu_read(bpf_task_wake_queue);
+	do {
+		WRITE_ONCE(node->next, head ?: WAKE_Q_TAIL);
+	} while (!try_cmpxchg(this_cpu_ptr(&bpf_task_wake_queue), &head, node));
+	irq_work_queue(this_cpu_ptr(&bpf_task_wake_work));
+}
+
 /*
  * What ends a park besides a wake and the timeout: a stop or park request for
  * a kthread, or a signal. Both are checked for every caller, since a kthread
@@ -169,8 +240,15 @@ __bpf_kfunc int bpf_task_park(u64 timeout_ns, u64 flags)
  * A task that is not parked keeps the pending wake until its next
  * bpf_task_park(), which then returns at once.
  *
- * Return: 1 when @task was asleep and is now runnable, 0 when it was not,
- * -EINVAL when @flags is not 0.
+ * The wake takes the task's pi_lock and a runqueue lock, which the kernel
+ * code a program runs in or interrupts may already hold, and it may not be
+ * issued in NMI context at all. Such code and NMI context both run with IRQs
+ * disabled, so a call with IRQs disabled marks the wake pending and queues it
+ * for irq_work on the calling CPU, which issues it once IRQs are enabled
+ * again. Such a call cannot tell whether the task was asleep and returns 2.
+ *
+ * Return: 1 when @task was asleep and is now runnable, 0 when it was not, 2
+ * when the wake was deferred, -EINVAL when @flags is not 0.
  */
 __bpf_kfunc int bpf_task_wake(struct task_struct *task, u64 flags)
 {
@@ -186,6 +264,10 @@ __bpf_kfunc int bpf_task_wake(struct task_struct *task, u64 flags)
 	 * in bpf_task_park().
 	 */
 	xchg(&task->bpf_wake_pending, 1);
+	if (unlikely(irqs_disabled())) {
+		bpf_task_wake_defer(task);
+		return 2;
+	}
 	return wake_up_state(task, TASK_INTERRUPTIBLE);
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index b66eb25626c9..a272d11c6caf 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1020,6 +1020,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	RCU_INIT_POINTER(tsk->bpf_storage, NULL);
 	tsk->bpf_ctx = NULL;
 	tsk->bpf_wake_pending = 0;
+	tsk->bpf_wake_node.next = NULL;
 #endif
 	return tsk;
 
-- 
2.53.0

