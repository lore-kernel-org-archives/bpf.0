Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9B733A9F7
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772115022; cv=none; b=Jg4kqsulxZncOWDO2MHVseUE5ZhpQp6cQY36tFGv5FASLzOidL1K8gX1y2sYDF3FYQodyPFqFYEGjfWFvuoXRH9Vuwz0sJdx5ZZI2G2atxuUqXNdgWX51mcvSeFxS8bVkrD45QsOhsHkOMLGe7Xje0qzqjMfd01QK9Kf2iNlvRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772115022; c=relaxed/simple;
	bh=0Ci/NDRwL0hZFy24g11G4ACUm4juOqiwpJpDlJD36YY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=U+Q51EBTnCi6PPHOntJZOH4UFJxhaWoHvajj/93f7IcfchCWZhJS9aHGsiu2bwLZ5dCxz5oOy/ahOEWZ0oXc70+2iCG28F3Tc4oBx7GFhQZVvD2aQKPsbXXmz+lm6yFomZiaSigEcu/X1jhjNNtn0Bj/PHMWl7U5GdRxkkU1DOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-679c5fde4c7so19745263eaf.0
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 06:10:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772115020; x=1772719820;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vsRdUqfGYw4QvznuJ8XtT8YlKd3WY+H+Dk6gPnN+KAw=;
        b=sxTaKUGJ6i951R53+JG4n6xMIXaQdjCFF+zMbkssLTjZoqg5NBuSVIG2sB3cqgNrh5
         B9DxKI+zeSSQBZX2ZcsjkDmHujXZZkN/8ccpebXBDFNFclV2V2fD6Qjd64JZpUV6we+W
         xJm8cxHFrWczUybqcbqckmUwzpgl+1/d29TkdVh69HbZ/rijFISFUAkml/kQ8I/Wjp95
         5Hzqmr9iRpGayPXAJPFbfrQOOLNzWc4Or4X0oLksm8oanCWd1GbgmyhljuQkGHSj7fuC
         1HRACoLFvdoPl9NRgbgfYutSlzWZo/CNxs5nTGb2Y/lzD9neW66vOpuR772ILXLpI19u
         olHw==
X-Forwarded-Encrypted: i=1; AJvYcCV5OIU+MkVVfki/5nlTeqlOl+CZ/l5SHD9fHCmWWRVa2adYZrhG1AmPzugEV+tokCSjL0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1or3SkzVS4NO0dv0EIqm3CdW60nowNxRHfLY7TlbeXCvijRWM
	YIt/u2Zb09Aw2blajx0vjPTf26gdt32SWqdqCBt8vhB0utI7bFZ9bi5kDbLaWLROhdgr4C+Y0Be
	3GAx3x2ImIo8KAnWjAt9Hi1ug1g6ypAZZtV6wvS84+HadqQRF/w1CtegcXdQ=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2917:b0:663:bd1:3b93 with SMTP id
 006d021491bc7-679ef965193mr2169185eaf.46.1772115020224; Thu, 26 Feb 2026
 06:10:20 -0800 (PST)
Date: Thu, 26 Feb 2026 06:10:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a0544c.050a0220.3a55be.0004.GAE@google.com>
Subject: [syzbot] [bpf?] [trace?] KASAN: slab-use-after-free Read in
 bpf_trace_run3 (2)
From: syzbot <syzbot+9ea7c90be2b24e189592@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, 
	mattbobrowski@google.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    32a92f8c8932 Convert more 'alloc_obj' cases to default GFP..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10f64152580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2208a171312e89b7
dashboard link: https://syzkaller.appspot.com/bug?extid=9ea7c90be2b24e189592
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16eaa55a580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-32a92f8c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/78386dbc59f1/vmlinux-32a92f8c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b38bbd9a7831/bzImage-32a92f8c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9ea7c90be2b24e189592@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __bpf_trace_run kernel/trace/bpf_trace.c:2075 [inline]
BUG: KASAN: slab-use-after-free in bpf_trace_run3+0xdd/0x850 kernel/trace/bpf_trace.c:2130
Read of size 8 at addr ffff888054ecb718 by task syz-executor/5447

CPU: 0 UID: 0 PID: 5447 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 __bpf_trace_run kernel/trace/bpf_trace.c:2075 [inline]
 bpf_trace_run3+0xdd/0x850 kernel/trace/bpf_trace.c:2130
 __bpf_trace_mmap_lock_acquire_returned+0x17e/0x1d0 include/trace/events/mmap_lock.h:47
 __traceiter_mmap_lock_acquire_returned+0x87/0xe0 include/trace/events/mmap_lock.h:47
 __do_trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:47 [inline]
 trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:47 [inline]
 __mmap_lock_do_trace_acquire_returned+0x1a1/0x210 mm/mmap_lock.c:35
 __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:42 [inline]
 mmap_write_lock_killable include/linux/mmap_lock.h:557 [inline]
 dup_mmap+0x23d/0x1d90 mm/mmap.c:1740
 dup_mm kernel/fork.c:1530 [inline]
 copy_mm+0x13b/0x4b0 kernel/fork.c:1582
 copy_process+0x18b6/0x3cf0 kernel/fork.c:2223
 kernel_clone+0x248/0x8e0 kernel/fork.c:2654
 __do_sys_clone kernel/fork.c:2795 [inline]
 __se_sys_clone kernel/fork.c:2779 [inline]
 __x64_sys_clone+0x1b6/0x230 kernel/fork.c:2779
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f392a1c50d2
Code: 89 e7 e8 b1 8b f7 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 66 89 c5 85 c0 75 3b 64 48 8b 04 25 10 00 00
RSP: 002b:00007fffdffb7f00 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007fffdffb7f00 RCX: 00007f392a1c50d2
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007fffdffb808c R08: 0000000000000000 R09: 0000000000000000
R10: 0000555578a147d0 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000000927c0 R14: 000000000002f577 R15: 00007fffdffb80e0
 </TASK>

Allocated by task 5916:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x31c/0x660 mm/slub.c:5339
 kmalloc_noprof include/linux/slab.h:962 [inline]
 kzalloc_noprof include/linux/slab.h:1200 [inline]
 bpf_raw_tp_link_attach+0x278/0x700 kernel/bpf/syscall.c:4264
 bpf_raw_tracepoint_open+0x1b2/0x220 kernel/bpf/syscall.c:4312
 __sys_bpf+0x846/0x950 kernel/bpf/syscall.c:6270
 __do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6339
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5447:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2687 [inline]
 slab_free mm/slub.c:6124 [inline]
 kfree+0x1c1/0x630 mm/slub.c:6442
 rcu_do_batch kernel/rcu/tree.c:2617 [inline]
 rcu_core+0x7cd/0x1070 kernel/rcu/tree.c:2869
 handle_softirqs+0x22a/0x870 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x5f/0x150 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1056
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 __call_rcu_common kernel/rcu/tree.c:3131 [inline]
 call_rcu+0xee/0x890 kernel/rcu/tree.c:3251
 bpf_link_put_direct kernel/bpf/syscall.c:3323 [inline]
 bpf_link_release+0x6b/0x80 kernel/bpf/syscall.c:3330
 __fput+0x44f/0xa70 fs/file_table.c:469
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0xed/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888054ecb700
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 24 bytes inside of
 freed 192-byte region [ffff888054ecb700, ffff888054ecb7c0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888054ecbd00 pfn:0x54ecb
flags: 0x4fff00000000200(workingset|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000200 ffff88801a8413c0 ffffea0001629850 ffff888030400288
raw: ffff888054ecbd00 000000000010000d 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x1d2cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5909, tgid 5909 (syz.4.241), ts 194010998968, free_ts 194010573612
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x24dc/0x2580 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5250
 alloc_slab_page mm/slub.c:3255 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3444
 new_slab mm/slub.c:3502 [inline]
 refill_objects+0x331/0x3c0 mm/slub.c:7134
 refill_sheaf mm/slub.c:2804 [inline]
 __pcs_replace_empty_main+0x2b9/0x620 mm/slub.c:4578
 alloc_from_pcs mm/slub.c:4681 [inline]
 slab_alloc_node mm/slub.c:4815 [inline]
 __kmalloc_cache_noprof+0x392/0x660 mm/slub.c:5334
 kmalloc_noprof include/linux/slab.h:962 [inline]
 kzalloc_noprof include/linux/slab.h:1200 [inline]
 bpf_raw_tp_link_attach+0x278/0x700 kernel/bpf/syscall.c:4264
 bpf_raw_tracepoint_open+0x1b2/0x220 kernel/bpf/syscall.c:4312
 __sys_bpf+0x846/0x950 kernel/bpf/syscall.c:6270
 __do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6339
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5913 tgid 5913 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xc2b/0xdb0 mm/page_alloc.c:2978
 vfree+0x25a/0x400 mm/vmalloc.c:3479
 bpf_prog_calc_tag+0x315/0x370 kernel/bpf/core.c:335
 resolve_pseudo_ldimm64+0xbd/0xc90 kernel/bpf/verifier.c:21701
 bpf_check+0x1d83/0x1ce00 kernel/bpf/verifier.c:25958
 bpf_prog_load+0x1484/0x1ae0 kernel/bpf/syscall.c:3089
 __sys_bpf+0x618/0x950 kernel/bpf/syscall.c:6228
 __do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6339
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888054ecb600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888054ecb680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888054ecb700: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888054ecb780: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888054ecb800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
