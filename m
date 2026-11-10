Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270487;
	b=1ikUW87R2W9e5+m9j2YLgTEvyUa5cW5eBmOSqk++rrIi4VcY5hOHBTAd91jGFtoYGp1f
	 V4KDizg1/KmJicxeWLAYoKIPXC/H858P1GPMqr3pPpU+L6lFV4vY1G5FM/+hkYLCAUJPl
	 ET33bEMjGahuBuDyYIMJLsAvAo6u3K9205gd7U1/Hs7PYxzJKcOk23WdlZ6tuFmrYhAGK
	 baQGneKPXOE4vD+ueTlgrJARq5vhgyhA2uRIdVgIVMOxpJ4vySdqH0bszsKmy7kC6mr+Z
	 H9X+36vUJhLZjhAZTFC3rAnGuFFJhkeUMJ5n5lypb1cjnhi0Hom9iqDe9KaD/rlefng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=tBvyhLDb1dAeHu60k/l02e5zYbG76m73HAVRPRmGDXE=;
	b=wiOy2NvQik/+6S1icrwyK08qs/M/xBZ7O1999Lnlc+LcvYhfkuz0HFsAz0OqqMV0v4Nv
	 HxjO91MYBlht/ktVIRCv8+DgEy0mubWjHza+T68qk6ZwhRsMSpShU4XGK6dfKY4hlg+mR
	 r4UkK6Gj9XhKXHwXfHiOs7W5chUJFSjCqP6p1WOcsGv3SoE7I/SSkovovqhTgBXuYD3w2
	 CaH9lpLTBJbzPDRXL6guOske/fpMWNu1L9/29vRoWL3Lf0hSr6Wp/C7ssFVmFA6iEXgKM
	 3TkWSKqA30eBVTklrKTj8ajEXNlSiIlyi+SSPhw0GzIl1T33Cyxwt/3iRRV5prFq6Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UEWBThZQ;
	arc=none smtp.remote-ip=74.125.225.75
Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5F7606A321
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC5F7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UEWBThZQ
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-4901ac93584so746726f8f.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794270485; x=1794875285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tBvyhLDb1dAeHu60k/l02e5zYbG76m73HAVRPRmGDXE=;
        b=UEWBThZQogF3TYFJaYlmzqHC7W5akTiPnVcK1yJLhsKGuUQxf4m8h8WCkmZVdxdKXR
         XvHMnP3PvtwwjYIXg66ABZFs+OnDfzwuFQuo6/u+kIhWjRmtsz3s3fXUeAANW+ufdeVW
         InFt7qL2TiFXPdAfom0S+uXEczkZHoaiFahz1Cioffh/KjK07fvryYrpo2u6qyBBGJMH
         5phvZbJdXEc+UhVDrLnsncMad46HILKH3ticiBZQ5Gz31S8YusPwf3tLhqi8f0SFYLNB
         BXw4eLQOQoz9wh7rvvSDFHdtA7ktRBNWeQt3KrzCJCdvcVcRsu9ZTtwf2BJvkAlY8hA6
         jR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270485; x=1794875285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tBvyhLDb1dAeHu60k/l02e5zYbG76m73HAVRPRmGDXE=;
        b=bL04WWSmrFY+XnJvm8AvB7IMDP/3wBp8NzxqFuFv2LciwWCU/Xlcdn5FTjUOzd4DLy
         XDYShAokb215nEEJHaM0Hh1XcUVcDYU68V7IW9dpRGvr1EMrdcOQxdHRde5QzKlTRuBJ
         5zk/d3ZUueigshgLB7exXYCG0WpXkUaDWpOBtU7YLt/GaaxSZTkpRaKJEv9xr330RzR5
         XhkLEhkMzgwiEwd6oq9YlBKzcPyAKvxH/ZzdqhAJ/oroHjkfrRXcgLw5obL2zEd7DzBc
         I0JEpF3AmBsBLfsdbaFVPFeE9+ghAVcRc7xkXgSdVE3CEy+khjmOFRs+sOOk7tDofOpJ
         Ge/g==
X-Gm-Message-State: APuU4Z8QIjje3RYYEZEKfVkx7lTngh8e5vyu/OnZnyNKSUaPyEArgpJ7
	N/+1Rg3GdCTl2NrzJpUc3+Vu+HdKqLeLfu/HnVjOlb4JLmlJtPe7RyzX1WIjh3Uu
X-Gm-Gg: AYBFou3mTAWyZ4/Aevx9r80r0tf6AppcbviL0+I7xp/FufhvsPFAj7Kr0VLz+ioQVZc
	iMHBUPCqyOCBgDWJZrv3qPsk8qwFNxZ2Ln7XXtVTjjYy5oOPrB9gk/Aul/syNWC7u3Nn7knFRjG
	Lexx4apMQARODAvFrAD7i5NIifsUzm5vTNfmuM6aD0gZAu582BQ/x18JQ+nBoh+jEfu8farQU/6
	+9DGqbr60pPqnyC9aYB4tAsr/9bj+ova5oTGBAAgNVqEw6O/l32ra2ZYME2B0gMkLwlYHrqrRry
	JVhooVi1h4oO6xsJQJA4By8TXOJKO3gHoEBoSxfBkNzLe6TnNEk0psWNb8XaV/aAO4gw02Y35Ha
	iLll+bgIMUjnExtdGBJboopo63bNHDppm5JrJgLUqp9aMecuGyCHW+6SCy+8+1OAZ9Cdh5jkBNx
	iMbNKJWZepWdmRxtGFx4ueW5rxiXkTNDoQ0GNbeaODphPWrWnNnw4qms/Yo3aoAsJbeKPdrScFK
	uCoSdC0e2QZ6516+IBlqvpK8KDjaqpxNayvIQZgGBgm+Ra6P5jDdrDnfNPltY3VLklF7J1CaTJV
	obMs5tWgKI9UOhf3DowAM8gJgA5OjxR4M2LDQsNT7tZw9Xpiar2TBLHlmVJr1vNrkR1tnzakHtS
	he4WqbrDyP2ppIXJXluxLELmdaDkZXSu+p97WlV1NTvKBiGE9kTefaJlH5XBZLeVGwkBz
X-Received: by 2002:a05:6000:2212:b0:48b:9ed:b81f with SMTP id ffacd0b85a97d-4982e641b33mr1495295f8f.10.1794270484767;
        Mon, 09 Nov 2026 16:28:04 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4982eedfb36sm1891721f8f.0.2026.11.09.16.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:28:03 -0800 (PST)
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
Subject: [PATCH bpf-next v1 10/20] bpf: Add BPF kthreads for syscall programs
Date: Tue, 10 Nov 2026 01:27:32 +0100
Message-ID: <155da1f809c1821f85d730aad44e67ed77ea8c10.1794269506.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=38345; i=memxor@gmail.com; h=from:subject:message-id; bh=vpjFdDv1Fg3tLCmguqHca1xegKBecvLsKCh3UqcVPCw=; b=kA0DAAoWRy03e2NUL4MByyZiAGryYUagdDlI3e+IQ+XT0NdUoZqVOUa3ZbB1ut8Zze8Claejq Ih1BAAWCgAdFiEEdP++AjPIeftRPaYLRy03e2NUL4MFAmryYUYACgkQRy03e2NUL4PdIQD+MWI1 dmMX09z9BxjbogmMOQk0qe6Wsak00SXwW/hTgQoBANX5DgRac+1nDHM3aSgcySjrb37ymLaC69f vG4z3xSoB
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Currently, a BPF program that wants a thread of its own, to poll a queue
or to serve events as they come, has no way to get one. It runs in the
tasks that enter the kernel, in a kworker through bpf_wq, or in a task's
return to user space through bpf_task_work, each for the length of one
invocation and none under the program's control.

Introduce BPF kthreads, kernel threads whose thread function is a
callback of the program that created them:

 - bpf_kthread_create() creates the thread without starting it. The
   callback is the body of the thread and runs once: it loops, sleeps
   and returns on its own, and its return ends the thread, with its
   return value as the thread's result.
 - bpf_kthread_start() runs the callback.
 - bpf_kthread_stop() stops the thread and waits for it to exit. A
   thread cannot stop itself and gets -EDEADLK for trying.
 - bpf_kthread_should_stop() tells the callback that a stop is pending,
   as kthread_should_stop() tells a kernel thread function.

The kernel runs the callback as it runs the body of a sleepable program,
with migration disabled under a Tasks Trace RCU read section, and adds
nothing around it. Register the kfuncs for BPF_PROG_TYPE_SYSCALL only
for now.

The thread is named bpfk/<program id>:<index>, the index counting the
threads the program has created, so that a program's controller and its
workers are told apart. The prefix is short so that both numbers fit the
fifteen characters of comm that tracepoints and perf report, as long as
they have nine digits between them; /proc would show a kernel thread's
full name anyway.

The program knows the thread by its task_struct. bpf_kthread_create()
returns it with a reference of the kind bpf_task_acquire() takes, so
that the program keeps the handle where it keeps task pointers, in a
kptr of a map value or a graph node, hands it to the other kfuncs, and
releases it with bpf_task_release(). The reference is taken before the
thread is published on the lists, since from then on any program may
stop it, and a stopped thread's exit drops the last reference the task
had of its own. The control kfuncs tell a BPF kthread from any other
task through a global list of the threads. bpf_kthread_start() takes an
RCU-protected task as well, so that a kptr read under
bpf_rcu_read_lock() will do.

A thread does not hold a reference on its program. If it did, a program
whose user closed every file descriptor would live on through its own
threads, with nothing left that could stop them, as a bpf_timer would
without the map's user reference count to cancel it. Instead:

 - The release of the program's last reference stops the threads it
   still has, and creation fails once the program has no reference
   left.
 - The threads are stopped before the release waits for a grace period.
   The release of a sleepable program waits for a Tasks Trace RCU grace
   period before it frees anything, and a thread inside its callback
   would hold that up, so the threads are stopped before it, from the
   work item the release goes through whenever the program has threads.
 - A thread whose callback has returned stays until bpf_kthread_stop()
   collects its result or the program goes, as a thread nobody joined
   does.

The one exception is a thread that bpf_kthread_stop() is stopping: the
stop holds the program for it. The stop takes the thread off the
program's list before it waits, so that the release of the program's
last reference, which stops the threads it finds on that list, does not
stop it a second time. A thread off the list and not yet exited is then
held by nobody. It may be asleep in bpf_task_park(), outside the Tasks
Trace read section that otherwise keeps the program for it, when the
program's last reference goes, for instance because the stopper is a
thread of another program and the user closing the last descriptor is
unrelated. It would wake into a freed program.

The stop therefore holds a reference on the program from the moment it
takes the thread off the list until the thread has exited. It refuses
with -ESRCH a thread whose program has no reference left, since that
program's release is stopping it. The reference is scoped to the stop
rather than to the thread's life because a thread needs no handle to
keep running, so a reference held by the thread would keep a program
alive forever once its user is gone. The same cycle is what timers and
prog_array break through a map's user count, which a program does not
have.

Stops that would wait for each other are refused. kthread_stop() waits
for the thread's exit in an uninterruptible wait that pays no attention
to the waiter's own stop bit, because in the kernel a stopper is never
itself a stop target. Here it can be. Two threads that stop each other
each set the other's stop bit and each wait for an exit that needs its
own wait to return first, with nothing that could end either, and a
longer ring of threads behaves the same.

Each thread therefore records, under the lock, the thread it is about to
wait for, and a stop walks that chain from its target before taking it.
A chain that reaches the caller is refused with -EDEADLK, as a thread
stopping itself is. The record and the check are one critical section,
so of two threads stopping each other exactly one is refused; its body
then sees its own stop bit and returns, and the other's wait completes.
Every object on a chain belongs to a thread that has not exited, since a
thread clears its record under the lock before it frees the object it
points to, so the walk reads live memory.

What remains is bounded only by the callback's cooperation. The kernel
cannot make a body return, so a body has to poll
bpf_kthread_should_stop() in its loops, as a kernel thread function
does, and a body that does not holds its stopper for the length of its
loop bounds. That is the limit of a cooperative stop: the kernel has no
way to end a program that does not return.

The kfuncs that wait for another task wait with migration enabled.
Creation waits for kthreadd and the stop for the thread, and so do the
placement kfuncs that follow, which wait for a running thread's next
migrate_enable(). The kernel assumes that a task which has disabled
migration enables it again soon, and several paths wait for that while
holding locks:

 - cpuset attach, under cgroup_mutex, cpus_read_lock() and the
   threadgroup rwsem;
 - a cpuset.cpus write, under cpuset_mutex;
 - CPU offline, in balance_hotplug_wait().

kthreadd's fork read-locks the threadgroup rwsem as well. A sleepable
program is migration-disabled for its whole run and a thread body for
its life outside the park, so one of these kfuncs waiting while pinned
can close a cycle. A task that creates a thread while a cgroup.procs
write moves it into a cpuset waits for kthreadd, whose fork waits for
the rwsem the writer holds while the writer waits for the task to enable
migration; nothing gives, and no kernel thread can be created anywhere
afterwards. That is the default lock mode. Under favordynmods a
cgroup.procs write holds only the moved process's own rwsem, but a
subtree_control write still takes the global one, and the other cycles
stand regardless.

The waits therefore run with migration enabled and the Tasks Trace read
section kept. Nothing the read section protects depends on the CPU: the
program, its maps and its context are held as before, per-CPU memory
stays valid memory, and neither the syscall runner nor bpf_kthread_fn()
keeps per-CPU state across the program, which the park established for
the runner. The caller may return on another CPU, the contract the park
carries too, so a per-CPU map value pointer or a CPU id obtained before
such a call names the CPU of the lookup. Unlike the park, which also
leaves the read section and so has the verifier invalidate what a grace
period could free, these waits keep the program's protection, and the
verifier has nothing to invalidate for them. They do count as kfuncs
that may migrate: a program that keeps per-CPU state of its own across
its run, a stack in arena or the time slice of may_goto, is refused the
creation and the stop as it is refused the park, and a program that
calls them stays out of prog arrays.

Two things follow from a body being code that the program wrote, running
in a task the program can name. bpf_kthread_start() is not sleepable, so
a timer callback may call it from softirq and a program may call it with
IRQs disabled; the lock that guards the lists is therefore a raw lock
taken with IRQs disabled. And a program can queue task work for its own
thread. With TWA_SIGNAL that sets TIF_NOTIFY_SIGNAL, which a kernel
thread never clears, so the thread blocks the notification for the
length of its body. The work then runs when the thread exits, after its
stopper may have freed the thread's object, so an exiting thread is no
longer treated as a BPF kthread by the stop it may call there.

The verifier checks the callback as a sleepable asynchronous callback.
Its one argument, the u64 the creator passed, is a scalar in R1, and its
int return is compared in 32 bits, since that is the width it comes back
in.

The callback is where the thread's loop goes, and what it can do while
it waits for work decides what a BPF kthread is good for. It cannot loop
without a bound, and nothing here lets it sleep: the sleep is
bpf_task_park(), which drops the migration and RCU protection of a
sleepable program for the length of the sleep, and whose verifier rules
refuse a park in every callback frame until the next patch admits this
one. Until then a kthread polls, and while it polls it keeps migration
disabled, which holds off a CPU offline and an affinity change until it
returns, as any migration-disabled task does; a thread that parks
between checks does not.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h    |   3 +
 include/linux/filter.h |  11 +-
 kernel/bpf/Makefile    |   2 +-
 kernel/bpf/core.c      |   1 +
 kernel/bpf/kthread.c   | 461 +++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c   |   9 +-
 kernel/bpf/verifier.c  |  56 ++++-
 7 files changed, 533 insertions(+), 10 deletions(-)
 create mode 100644 kernel/bpf/kthread.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5dec537fe688..7c15593cb188 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2046,6 +2046,8 @@ struct bpf_prog_aux {
 	struct bpf_stream *stream[2];
 	spinlock_t st_ops_assoc_lock; /* protects st_ops_assoc */
 	struct bpf_map __rcu *st_ops_assoc;
+	struct list_head kthreads; /* BPF kthreads of the prog, see kernel/bpf/kthread.c */
+	atomic_t kthread_seq; /* index of the prog's next BPF kthread, in its name */
 };
 
 #define BPF_NR_CONTEXTS        4       /* normal, softirq, hardirq, NMI */
@@ -2970,6 +2972,7 @@ struct bpf_prog * __must_check bpf_prog_inc_not_zero(struct bpf_prog *prog);
 void bpf_prog_put(struct bpf_prog *prog);
 
 void bpf_prog_free_id(struct bpf_prog *prog);
+void bpf_prog_free_kthreads(struct bpf_prog_aux *aux);
 void bpf_map_free_id(struct bpf_map *map);
 
 struct btf_field *btf_record_find(const struct btf_record *rec,
diff --git a/include/linux/filter.h b/include/linux/filter.h
index c30d05a5c26e..8a99b9aacfb0 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -884,11 +884,12 @@ static __always_inline u32 bpf_prog_run(const struct bpf_prog *prog, const void
  * invocation of a BPF program does not require reentrancy protection
  * against a BPF program which is invoked from a preempting task.
  *
- * A syscall program may call bpf_task_park(), which lifts the pin for the
- * duration of its sleep and restores it before returning to the program,
- * so such a program may resume on another CPU. Nothing on this path keeps
- * per-CPU state across the program: __bpf_prog_run() samples its stats
- * only after the program returns.
+ * A syscall program may call bpf_task_park(), or a BPF kthread kfunc that
+ * waits for another task, which lift the pin for the duration of the sleep
+ * or wait and restore it before returning to the program, so such a program
+ * may resume on another CPU. Nothing on this path keeps per-CPU state
+ * across the program: __bpf_prog_run() samples its stats only after the
+ * program returns.
  */
 static inline u32 bpf_prog_run_pin_on_cpu(const struct bpf_prog *prog,
 					  const void *ctx)
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 34357665c34c..a754fbefae39 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -15,7 +15,7 @@ obj-$(CONFIG_BPF_SYSCALL) += fixups.o cfg.o states.o check_btf.o flow.o join.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
-obj-$(CONFIG_BPF_SYSCALL) += btf.o memalloc.o rqspinlock.o stream.o task_park.o
+obj-$(CONFIG_BPF_SYSCALL) += btf.o memalloc.o rqspinlock.o stream.o task_park.o kthread.o
 ifeq ($(CONFIG_MMU)$(CONFIG_64BIT),yy)
 obj-$(CONFIG_BPF_SYSCALL) += arena.o range_tree.o
 endif
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index f88a1c041a7a..95f4be8ed405 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -138,6 +138,7 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 #ifdef CONFIG_FINEIBT
 	INIT_LIST_HEAD_RCU(&fp->aux->ksym_prefix.lnode);
 #endif
+	INIT_LIST_HEAD(&fp->aux->kthreads);
 	mutex_init(&fp->aux->used_maps_mutex);
 	mutex_init(&fp->aux->ext_mutex);
 	mutex_init(&fp->aux->dst_mutex);
diff --git a/kernel/bpf/kthread.c b/kernel/bpf/kthread.c
new file mode 100644
index 000000000000..3055e427fe76
--- /dev/null
+++ b/kernel/bpf/kthread.c
@@ -0,0 +1,461 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/kthread.h>
+#include <linux/rcupdate_trace.h>
+#include <linux/sched.h>
+#include <linux/sched/signal.h>
+#include <linux/sched/task.h>
+
+/*
+ * A BPF kthread is a kernel thread whose thread function is one callback of
+ * the program that created it, run once. The callback is the body of the
+ * thread: it loops, sleeps and returns on its own, and its return ends the
+ * thread. The kernel adds nothing in between.
+ *
+ * The thread is known to the program by its task_struct. bpf_kthread_create()
+ * returns it as a referenced pointer, and the control kfuncs take it back, so
+ * the program keeps it wherever it keeps task pointers: a kptr in a map value,
+ * a graph node, or a register until
+ * bpf_task_release(). Nothing else is handed out, and nothing else needs a
+ * lifetime of its own.
+ *
+ * Every thread is on one global list, which is how a control kfunc tells a
+ * BPF kthread from any other task it is given, and how the thread's object is
+ * found without reading through a task that may have exited. Whoever takes a
+ * thread off the list under the lock owns its teardown.
+ *
+ * A thread does not hold a reference on its program. If it did, a program
+ * whose user dropped every file descriptor would live on through its own
+ * threads, with nothing left that could stop them. Instead the release of the
+ * program's last reference stops the threads it still has, before anything
+ * their callback could be using is released, and creation fails once the
+ * program has no reference left. A program's threads thus end with its last
+ * user, the way a timer or a work item ends with the last user of its map.
+ * The one exception is a thread that bpf_kthread_stop() has taken off the
+ * lists but that has not exited yet: its stopper holds the program for it.
+ *
+ * Four of the kfuncs wait for another task. Creation waits for kthreadd,
+ * bpf_kthread_stop() for the thread's exit, and bpf_kthread_bind() and
+ * bpf_kthread_attach_cgroup() for a running thread's next migrate_enable(),
+ * which is what set_cpus_allowed_ptr() waits for on any migration-disabled
+ * task. The kernel assumes that a task which has disabled migration enables
+ * it again soon, and waits for that while holding locks: cpuset attach under
+ * cgroup_mutex, cpus_read_lock() and the threadgroup rwsem, a cpuset.cpus
+ * write under cpuset_mutex, CPU offline in balance_hotplug_wait(). kthreadd's
+ * fork read-locks the global threadgroup rwsem as well, which a cgroup move
+ * holds in the default lock mode; under favordynmods the move holds the moved
+ * process's own, but a subtree_control write still takes the global one. A
+ * sleepable program is migration-disabled for its whole run and a thread body
+ * for its life outside the park, so a wait made while pinned can close a cycle
+ * through any of those: a task moved into a cpuset while it creates a thread,
+ * a thread blocked in a stop being bound by the thread it waits for, a thread
+ * on a CPU going offline taking cpus_read_lock(). Each of the four waits
+ * therefore runs with migration enabled and the Tasks Trace read section kept.
+ * Nothing the read section protects depends on the CPU: the program, its maps
+ * and its context are held as before, per-CPU memory stays valid memory, and
+ * neither runner keeps per-CPU state across the program. A program that keeps
+ * such state of its own, a stack in arena or the time slice of may_goto, is
+ * refused these kfuncs as it is refused the park. The caller may return on
+ * another CPU, the contract bpf_task_park() already carries, so a per-CPU map
+ * value pointer or a CPU id obtained before such a call names the CPU of the
+ * lookup. Unlike the park, the waits keep the program's protection, so the
+ * verifier has nothing to invalidate across them.
+ */
+
+struct bpf_kthread {
+	struct list_head node;		/* on bpf_kthreads */
+	struct list_head prog_node;	/* on aux->kthreads */
+	struct task_struct *task;	/* holds one reference for this object */
+	struct bpf_prog_aux *aux;	/* the program whose callback this is */
+	struct bpf_kthread *waits_for;	/* the thread this one is stopping, under the lock */
+	void *callback_fn;
+	u64 arg;
+};
+
+/*
+ * Both lists, and every object on them, are under this lock. It is a raw lock
+ * taken with IRQs disabled because bpf_kthread_start() is not sleepable: a
+ * timer callback calls it from softirq, and a program may call it with IRQs
+ * or preemption disabled.
+ */
+static LIST_HEAD(bpf_kthreads);
+static DEFINE_RAW_SPINLOCK(bpf_kthreads_lock);
+
+static int bpf_kthread_fn(void *data)
+{
+	struct bpf_kthread *kthread = data;
+	bpf_callback_t callback_fn = kthread->callback_fn;
+	unsigned int pflags;
+	int ret;
+
+	/* Stopped before it was started: the callback does not run. */
+	if (kthread_should_stop())
+		return -EINTR;
+
+	/*
+	 * The callback runs as the body of a sleepable program does, with
+	 * migration disabled under a Tasks Trace RCU read section, except
+	 * while it waits in one of the kfuncs the comment at the top names,
+	 * which drop migration disable alone. The verifier checks it as a
+	 * sleepable callback.
+	 */
+	/*
+	 * A task work queued for this thread with TWA_SIGNAL sets
+	 * TIF_NOTIFY_SIGNAL, which a kernel thread never gets to clear, since
+	 * the work runs on the return to user mode or at exit. Left alone it
+	 * would end every sleep of the body at once from then on.
+	 */
+	pflags = no_notify_signal_save();
+	rcu_read_lock_trace();
+	migrate_disable();
+	ret = callback_fn(kthread->arg, 0, 0, 0, 0);
+	migrate_enable();
+	rcu_read_unlock_trace();
+	no_notify_signal_restore(pflags);
+	return ret;
+}
+
+/* The BPF kthread whose task is @task, if any. Call with bpf_kthreads_lock held. */
+static struct bpf_kthread *bpf_kthread_find(struct task_struct *task)
+{
+	struct bpf_kthread *kthread;
+
+	lockdep_assert_held(&bpf_kthreads_lock);
+	list_for_each_entry(kthread, &bpf_kthreads, node)
+		if (kthread->task == task)
+			return kthread;
+	return NULL;
+}
+
+/* Take a thread off both lists. Call with bpf_kthreads_lock held. */
+static void bpf_kthread_unlink(struct bpf_kthread *kthread)
+{
+	lockdep_assert_held(&bpf_kthreads_lock);
+	list_del(&kthread->node);
+	list_del(&kthread->prog_node);
+}
+
+/*
+ * The object of the calling thread, if it is a BPF kthread that has not begun
+ * to exit. An exiting thread still runs its task work, which may be a program's
+ * callback, and its object is freed as soon as whoever stops it has seen it
+ * exit, which is before that. Nothing waits for such a thread any more, so it
+ * needs no record of what it waits for.
+ */
+static struct bpf_kthread *bpf_kthread_self(void)
+{
+	if (kthread_func(current) != bpf_kthread_fn || (current->flags & PF_EXITING))
+		return NULL;
+	return kthread_data(current);
+}
+
+/*
+ * Whether a stop of @kthread would wait, through the chain of threads each of
+ * them is stopping, for the calling thread. Call with bpf_kthreads_lock held.
+ * Every object on the chain is alive: a thread clears waits_for under the lock
+ * before it frees the object it points to.
+ */
+static bool bpf_kthread_waits_for_current(struct bpf_kthread *kthread)
+{
+	lockdep_assert_held(&bpf_kthreads_lock);
+	for (; kthread; kthread = kthread->waits_for)
+		if (kthread->task == current)
+			return true;
+	return false;
+}
+
+/*
+ * Stop a thread that has been taken off the lists and free its object. Waits
+ * for the thread to exit, and returns what its callback returned, or -EINTR if
+ * the callback never ran. Returns at once for a thread that has exited.
+ */
+static int bpf_kthread_stop_and_free(struct bpf_kthread *kthread)
+{
+	int ret;
+
+	ret = kthread_stop_put(kthread->task);
+	kfree(kthread);
+	return ret;
+}
+
+/*
+ * Stop every thread of @aux. Called when the program's last reference goes,
+ * before its code, maps and BTF are released, and before the Tasks Trace RCU
+ * grace period that release waits for, which a thread still inside its
+ * callback would hold up. May block.
+ */
+void bpf_prog_free_kthreads(struct bpf_prog_aux *aux)
+{
+	struct bpf_kthread *kthread, *tmp;
+	unsigned long irqflags;
+	LIST_HEAD(kthreads);
+
+	/*
+	 * Nothing joins a program's list once its last reference is gone, so
+	 * an empty list stays empty. The release path takes the lock only for
+	 * a program with threads, from a work item, never from the direct
+	 * path it may take in softirq context for a program without.
+	 */
+	if (list_empty(&aux->kthreads))
+		return;
+
+	raw_spin_lock_irqsave(&bpf_kthreads_lock, irqflags);
+	list_for_each_entry_safe(kthread, tmp, &aux->kthreads, prog_node) {
+		list_del(&kthread->node);
+		list_move_tail(&kthread->prog_node, &kthreads);
+	}
+	raw_spin_unlock_irqrestore(&bpf_kthreads_lock, irqflags);
+
+	list_for_each_entry_safe(kthread, tmp, &kthreads, prog_node)
+		bpf_kthread_stop_and_free(kthread);
+}
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_kthread_create - Create a kernel thread that runs a BPF callback
+ * @callback_fn: the thread's body, run once; its return ends the thread
+ * @arg: passed to @callback_fn as its only argument
+ * @flags: must be 0
+ * @aux: the calling program, set by the verifier
+ *
+ * Creates a kernel thread named bpfk/<program id>:<index> without starting it,
+ * the index counting the program's creations so that its threads are told
+ * apart in ps, top and traces; the prefix is short so that both numbers fit
+ * the comm that tracepoints and perf report as long as they have nine digits
+ * between them, where /proc shows the full name in any case. bpf_kthread_start()
+ * runs @callback_fn on it with @arg. The thread ends when the callback returns,
+ * when bpf_kthread_stop() stops it, or with the last reference on the program
+ * that created it. A thread whose callback has returned keeps its return value
+ * until bpf_kthread_stop() collects it.
+ *
+ * The creation waits for kthreadd with migration enabled, so the caller may
+ * return on another CPU.
+ *
+ * Return: the thread's task with a reference the program must release, or NULL
+ * if @flags is not 0, the thread could not be created, or the program is being
+ * freed.
+ */
+__bpf_kfunc struct task_struct *bpf_kthread_create(int (callback_fn)(u64 arg), u64 arg,
+						   u64 flags, struct bpf_prog_aux *aux)
+{
+	struct bpf_kthread *kthread;
+	unsigned long irqflags;
+	struct task_struct *task;
+	struct bpf_prog *prog;
+
+	if (flags)
+		return NULL;
+
+	kthread = kzalloc_obj(*kthread, GFP_KERNEL_ACCOUNT);
+	if (!kthread)
+		return NULL;
+	kthread->aux = aux;
+	kthread->callback_fn = callback_fn;
+	kthread->arg = arg;
+
+	/*
+	 * The creation waits for kthreadd, and kthreadd's fork takes the
+	 * threadgroup rwsem that a cgroup move of this task holds while it
+	 * waits for this task to enable migration: see the comment at the top.
+	 */
+	migrate_enable();
+	task = kthread_create(bpf_kthread_fn, kthread, "bpfk/%u:%u", aux->id,
+			      atomic_fetch_inc(&aux->kthread_seq));
+	if (IS_ERR(task)) {
+		migrate_disable();
+		kfree(kthread);
+		return NULL;
+	}
+	kthread->task = get_task_struct(task);
+	/*
+	 * The program's reference is the kind bpf_task_acquire() takes and
+	 * bpf_task_release() drops; the object's own, above, is the kind
+	 * kthread_stop_put() drops. Take it before the thread is published:
+	 * from then on any program may stop it, and a stopped thread's exit
+	 * drops the last reference the task had of its own.
+	 */
+	refcount_inc(&task->rcu_users);
+
+	/*
+	 * Run the thread up to its park. The generic kthread prologue, which
+	 * runs first, resets the affinity to the default for the thread's
+	 * node, so that an affinity set from now on sticks.
+	 */
+	kthread_park(task);
+	migrate_disable();
+
+	/*
+	 * Publish the thread while the program has a reference left to take.
+	 * Once it has none, the release of its last reference is pending or
+	 * under way, and a thread published after that release looked would
+	 * survive the program. The reference taken here is dropped again at
+	 * once: the release cannot start before it is, and the thread is on
+	 * the lists by then.
+	 */
+	raw_spin_lock_irqsave(&bpf_kthreads_lock, irqflags);
+	prog = bpf_prog_inc_not_zero(aux->prog);
+	if (IS_ERR(prog)) {
+		raw_spin_unlock_irqrestore(&bpf_kthreads_lock, irqflags);
+		migrate_enable();
+		bpf_kthread_stop_and_free(kthread);
+		migrate_disable();
+		put_task_struct_rcu_user(task);
+		return NULL;
+	}
+	list_add_tail(&kthread->node, &bpf_kthreads);
+	list_add_tail(&kthread->prog_node, &aux->kthreads);
+	raw_spin_unlock_irqrestore(&bpf_kthreads_lock, irqflags);
+	bpf_prog_put(prog);
+	return task;
+}
+
+/**
+ * bpf_kthread_start - Run the callback of a BPF kthread
+ * @task: a thread created by bpf_kthread_create()
+ * @flags: must be 0
+ *
+ * Starts the thread, which then runs its callback. Does nothing for a thread
+ * that has been started already.
+ *
+ * Return: 0 on success, -EINVAL if @flags is not 0, -ESRCH if @task is not a
+ * BPF kthread or has been stopped.
+ */
+__bpf_kfunc int bpf_kthread_start(struct task_struct *task, u64 flags)
+{
+	unsigned long irqflags;
+	bool found;
+
+	if (flags)
+		return -EINVAL;
+
+	raw_spin_lock_irqsave(&bpf_kthreads_lock, irqflags);
+	found = !!bpf_kthread_find(task);
+	raw_spin_unlock_irqrestore(&bpf_kthreads_lock, irqflags);
+	if (!found)
+		return -ESRCH;
+
+	kthread_unpark(task);
+	return 0;
+}
+
+/**
+ * bpf_kthread_stop - Stop a BPF kthread and wait for it to exit
+ * @task: a thread created by bpf_kthread_create()
+ * @flags: must be 0
+ *
+ * Makes bpf_kthread_should_stop() return true in the thread, ends the sleep it
+ * is in, and waits for its callback to return. A thread that has not been
+ * started exits without running its callback. The thread is gone afterwards;
+ * the reference the program holds on @task stays its own to release.
+ *
+ * The wait ends when the callback returns, which the callback decides by
+ * polling bpf_kthread_should_stop(); the kernel cannot end it sooner. It is
+ * made with migration enabled, so the caller may return on another CPU, but
+ * under the Tasks Trace read section, which every Tasks Trace grace period
+ * then waits for, so a thread should stop threads that return promptly, as
+ * one that sleeps in bpf_task_park() does. Two threads stopping each other, or
+ * a longer ring of them, would wait forever; the stop that would close such a
+ * ring is refused instead.
+ *
+ * Return: what the thread's callback returned, or -EINTR if it never ran.
+ * -EINVAL if @flags is not 0, -EDEADLK if @task is the calling thread or is,
+ * through the threads it is itself stopping, waiting for the calling thread,
+ * -ESRCH if @task is not a BPF kthread, has been stopped already, or is being
+ * stopped by the release of its program.
+ */
+__bpf_kfunc int bpf_kthread_stop(struct task_struct *task, u64 flags)
+{
+	struct bpf_kthread *kthread, *self;
+	unsigned long irqflags;
+	struct bpf_prog *prog;
+	int ret;
+
+	if (flags)
+		return -EINVAL;
+	if (task == current)
+		return -EDEADLK;
+
+	raw_spin_lock_irqsave(&bpf_kthreads_lock, irqflags);
+	kthread = bpf_kthread_find(task);
+	if (!kthread) {
+		raw_spin_unlock_irqrestore(&bpf_kthreads_lock, irqflags);
+		return -ESRCH;
+	}
+	if (bpf_kthread_waits_for_current(kthread)) {
+		raw_spin_unlock_irqrestore(&bpf_kthreads_lock, irqflags);
+		return -EDEADLK;
+	}
+	/*
+	 * Hold the program while the thread is off the lists and not yet
+	 * gone. The release of the program's last reference stops only the
+	 * threads it finds on its list, and this one may be asleep in
+	 * bpf_task_park(), outside the read section that otherwise keeps the
+	 * program for it, so without the reference it could wake into a freed
+	 * program. A program with no reference left is being released, and
+	 * that release is stopping the thread.
+	 */
+	prog = bpf_prog_inc_not_zero(kthread->aux->prog);
+	if (IS_ERR(prog)) {
+		raw_spin_unlock_irqrestore(&bpf_kthreads_lock, irqflags);
+		return -ESRCH;
+	}
+	bpf_kthread_unlink(kthread);
+	self = bpf_kthread_self();
+	if (self)
+		self->waits_for = kthread;
+	raw_spin_unlock_irqrestore(&bpf_kthreads_lock, irqflags);
+
+	/* The wait for the exit: see the comment at the top. */
+	migrate_enable();
+	ret = kthread_stop_put(kthread->task);
+	migrate_disable();
+
+	if (self) {
+		raw_spin_lock_irqsave(&bpf_kthreads_lock, irqflags);
+		self->waits_for = NULL;
+		raw_spin_unlock_irqrestore(&bpf_kthreads_lock, irqflags);
+	}
+	kfree(kthread);
+	bpf_prog_put(prog);
+	return ret;
+}
+
+/**
+ * bpf_kthread_should_stop - Whether the calling BPF kthread was asked to stop
+ *
+ * The callback of a BPF kthread checks this in its loop and returns when it is
+ * set, as a kernel thread function does; bpf_kthread_stop() waits for that.
+ *
+ * Return: true in a kernel thread that was asked to stop, by bpf_kthread_stop()
+ * or by the release of its program, false otherwise, including for every
+ * thread of a user process.
+ */
+__bpf_kfunc bool bpf_kthread_should_stop(void)
+{
+	return (current->flags & PF_KTHREAD) && kthread_should_stop();
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_kthread_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_kthread_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE | KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, bpf_kthread_start, KF_RCU)
+BTF_ID_FLAGS(func, bpf_kthread_stop, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_kthread_should_stop)
+BTF_KFUNCS_END(bpf_kthread_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_kthread_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &bpf_kthread_kfunc_ids,
+};
+
+static int __init bpf_kthread_kfunc_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_kthread_kfunc_set);
+}
+late_initcall(bpf_kthread_kfunc_init);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3f9728686d05..9ea8c755651e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2512,6 +2512,12 @@ static void bpf_prog_put_deferred(struct work_struct *work)
 
 	aux = container_of(work, struct bpf_prog_aux, work);
 	prog = aux->prog;
+	/*
+	 * The threads of the prog still run its code, each inside a Tasks
+	 * Trace RCU read section that the grace period below would wait for.
+	 * Stop them first; this waits for each of them to exit.
+	 */
+	bpf_prog_free_kthreads(aux);
 	perf_event_bpf_event(prog, PERF_BPF_EVENT_PROG_UNLOAD, 0);
 	bpf_audit_prog(prog, BPF_AUDIT_UNLOAD);
 	bpf_prog_free_id(prog);
@@ -2523,7 +2529,8 @@ static void __bpf_prog_put(struct bpf_prog *prog)
 	struct bpf_prog_aux *aux = prog->aux;
 
 	if (atomic64_dec_and_test(&aux->refcnt)) {
-		if (in_hardirq() || irqs_disabled()) {
+		/* Stopping the prog's threads blocks, which the direct path may not. */
+		if (in_hardirq() || irqs_disabled() || !list_empty(&aux->kthreads)) {
 			INIT_WORK(&aux->work, bpf_prog_put_deferred);
 			schedule_work(&aux->work);
 		} else {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a1b3ae59a68c..0cf0d3a85b35 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -537,6 +537,7 @@ static bool is_call_rcu_kfunc(u32 btf_id);
 static bool is_callback_calling_kfunc(u32 btf_id);
 
 static bool is_bpf_wq_set_callback_kfunc(u32 btf_id);
+static bool is_bpf_kthread_create_kfunc(u32 btf_id);
 static bool is_task_work_add_kfunc(u32 func_id);
 
 static bool is_sync_callback_calling_function(enum bpf_func_id func_id)
@@ -580,9 +581,10 @@ static bool is_async_cb_sleepable(struct bpf_verifier_env *env, struct bpf_insn
 	if (bpf_pseudo_kfunc_call(insn) && insn->off == 0 && is_call_rcu_kfunc(insn->imm))
 		return false;
 
-	/* bpf_wq and bpf_task_work callbacks are always sleepable. */
+	/* bpf_wq, bpf_task_work and bpf_kthread callbacks are always sleepable. */
 	if (bpf_pseudo_kfunc_call(insn) && insn->off == 0 &&
-	    (is_bpf_wq_set_callback_kfunc(insn->imm) || is_task_work_add_kfunc(insn->imm)))
+	    (is_bpf_wq_set_callback_kfunc(insn->imm) || is_task_work_add_kfunc(insn->imm) ||
+	     is_bpf_kthread_create_kfunc(insn->imm)))
 		return true;
 
 	verifier_bug(env, "unhandled async callback in is_async_cb_sleepable");
@@ -12642,6 +12644,32 @@ static int set_task_work_schedule_callback_state(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int set_kthread_callback_state(struct bpf_verifier_env *env,
+				      struct bpf_func_state *caller,
+				      struct bpf_func_state *callee,
+				      int insn_idx)
+{
+	/*
+	 * bpf_kthread_create(int (callback_fn)(u64 arg), u64 arg, u64 flags);
+	 * callback_fn(u64 arg);
+	 */
+	bpf_mark_reg_unknown(&callee->regs[BPF_REG_1]);
+
+	/* unused */
+	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_2]);
+	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
+	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
+	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
+	callee->in_async_callback_fn = true;
+	/*
+	 * The callback returns an int, which comes back in the low 32 bits of
+	 * R0: compare those, as for a global function.
+	 */
+	callee->callback_ret_range = retval_range(S32_MIN, S32_MAX);
+	callee->callback_ret_range.return_32bit = true;
+	return 0;
+}
+
 static int set_rcu_callback_state(struct bpf_verifier_env *env,
 				  struct bpf_func_state *caller,
 				  struct bpf_func_state *callee,
@@ -14325,6 +14353,8 @@ enum special_kfunc_type {
 	KF_bpf_task_work_schedule_resume,
 	KF_bpf_call_rcu,
 	KF_bpf_call_rcu_tasks_trace,
+	KF_bpf_kthread_create,
+	KF_bpf_kthread_stop,
 	KF_bpf_arena_alloc_pages,
 	KF_bpf_arena_free_pages,
 	KF_bpf_session_is_return,
@@ -14418,6 +14448,8 @@ BTF_ID(func, bpf_task_work_schedule_signal)
 BTF_ID(func, bpf_task_work_schedule_resume)
 BTF_ID(func, bpf_call_rcu)
 BTF_ID(func, bpf_call_rcu_tasks_trace)
+BTF_ID(func, bpf_kthread_create)
+BTF_ID(func, bpf_kthread_stop)
 #if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
 BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
@@ -14462,7 +14494,9 @@ static bool is_bpf_task_park_kfunc(u32 btf_id)
 /* The kfuncs that sleep or wait with migration enabled. */
 static bool is_migrating_kfunc(u32 btf_id)
 {
-	return btf_id == special_kfunc_list[KF_bpf_task_park];
+	return btf_id == special_kfunc_list[KF_bpf_task_park] ||
+	       btf_id == special_kfunc_list[KF_bpf_kthread_create] ||
+	       btf_id == special_kfunc_list[KF_bpf_kthread_stop];
 }
 
 static bool is_bpf_obj_new_kfunc(u32 func_id)
@@ -15313,6 +15347,7 @@ static bool is_sync_callback_calling_kfunc(u32 btf_id)
 static bool is_async_callback_calling_kfunc(u32 btf_id)
 {
 	return is_bpf_wq_set_callback_kfunc(btf_id) ||
+	       is_bpf_kthread_create_kfunc(btf_id) ||
 	       is_task_work_add_kfunc(btf_id) ||
 	       is_call_rcu_kfunc(btf_id);
 }
@@ -15328,6 +15363,11 @@ static bool is_bpf_wq_set_callback_kfunc(u32 btf_id)
 	return btf_id == special_kfunc_list[KF_bpf_wq_set_callback];
 }
 
+static bool is_bpf_kthread_create_kfunc(u32 btf_id)
+{
+	return btf_id == special_kfunc_list[KF_bpf_kthread_create];
+}
+
 static bool is_callback_calling_kfunc(u32 btf_id)
 {
 	return is_sync_callback_calling_kfunc(btf_id) ||
@@ -16350,6 +16390,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+	if (is_bpf_kthread_create_kfunc(meta.func_id)) {
+		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
+					 set_kthread_callback_state);
+		if (err) {
+			verbose(env, "kfunc %s#%d failed callback verification\n",
+				func_name, meta.func_id);
+			return err;
+		}
+	}
+
 	rcu_lock = is_kfunc_bpf_rcu_read_lock(&meta);
 	rcu_unlock = is_kfunc_bpf_rcu_read_unlock(&meta);
 
-- 
2.53.0

