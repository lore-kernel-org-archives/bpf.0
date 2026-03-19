Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF523EDAD9
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 17:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941247; cv=none; b=b3hO+gUb4tMmLmwintWIdRO/L/zY8pREbrCWric7JPmEOpI3cx9kRiRzTUZJvHxlwJ56Hk4yjP6eTjl339h0YpB0iDswFUqlWORMzdpjiomz24USKyex/5Mxci/uz1bntuvX8Xp1dnsQkIQe/zmtiFLkX7IriLtre6SjG1cWmHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941247; c=relaxed/simple;
	bh=Ds5fowKxusoVZ881S4ea3LZnL395zPO+K6XJGETEnRY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UDnvpxX0QBTrC7EX0ImFk5egAiD4frXjF53L0OqYApBz4vbtA4x99rcANc3v4UBn3iHnqaphkyBO/4a5GG/4RpnQbu/2gMfO/4AyFX2+zL0lvb62eLQo3kwaTosJPBT4892Qr2Fhlr3GNP99zx5Yjmg2c06vFTDKruTv7IXiZOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-67bb57af478so19924660eaf.1
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 10:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773941240; x=1774546040;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HRkEc4XliWZIb+ZbjM5vjMJz0ZRaz8Ne4UApCAxF2qQ=;
        b=Z0GQq1BnSMaQrPYHypNzKNRLo+OAbVHS7siMDnt2RUjyRldstBmUMaJKNRMD3zaXxv
         y8c7IpjpPrMPoawLp9qz3174N6k1jF2jsi8/QiMt66mVYlxsp4aJNPjShg+qTl7u1RVF
         N4+iEpymx8tbRulxV6DZvFlwhO7xSuj35jntXjdp56zCHq1J8scdKY6/ee3qdZGojIVX
         nKhVTPf8QPfPf8Ct9yBSKQR+75lU2mb3xycAilD2CRzAslmZECoFn7BMm4w0JapETqQZ
         pttYRcyTY+gpeLfreV3Bb//LRYWR/0UKX6YuyazovS1aM3ywUTGyzVkyTHFMS8jCJOaZ
         uFVg==
X-Forwarded-Encrypted: i=1; AJvYcCX3xbqWt1Cf8r7nnRtps6YKdEjqys+PK/4nk6JuOA6o/fpzdDh1T6TcIY4KiOSFt6BBZYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvdTzHt4EjO3ox06jG8jO7TYqSLecPZLdWpGG1seFxkwt4644n
	/hQsItHf9XyG0mByjdkPtYpy9SA2j9FNP94JDP+J+2ZuhJYveReCn+LQY1iwGXANjWu0RsS4P5j
	vUD/zfdBPjxb96A1NXVgZobbnljDVXG+BpUYqMNdq4P94LoLMigWaMN+cdUU=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:620:b0:67c:2204:945c with SMTP id
 006d021491bc7-67c22f95bb2mr214636eaf.54.1773941240261; Thu, 19 Mar 2026
 10:27:20 -0700 (PDT)
Date: Thu, 19 Mar 2026 10:27:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69bc31f8.050a0220.18f14c.0051.GAE@google.com>
Subject: [syzbot] [bpf?] [trace?] KASAN: slab-use-after-free Read in
 bpf_trace_run4 (2)
From: syzbot <syzbot+ca51b6e7e751edd6bbfd@syzkaller.appspotmail.com>
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

HEAD commit:    b29fb8829bff Merge tag 'v7.0-rc3-ksmbd-server-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ab575a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c5c49ee0942d1cdb
dashboard link: https://syzkaller.appspot.com/bug?extid=ca51b6e7e751edd6bbfd
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-b29fb882.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4fd392c86ab5/vmlinux-b29fb882.xz
kernel image: https://storage.googleapis.com/syzbot-assets/32f95fb6f35f/bzImage-b29fb882.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ca51b6e7e751edd6bbfd@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __bpf_trace_run kernel/trace/bpf_trace.c:2075 [inline]
BUG: KASAN: slab-use-after-free in bpf_trace_run4+0xe6/0x850 kernel/trace/bpf_trace.c:2131
Read of size 8 at addr ffff8880361a0318 by task udevd/5299

CPU: 0 UID: 0 PID: 5299 Comm: udevd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 __bpf_trace_run kernel/trace/bpf_trace.c:2075 [inline]
 bpf_trace_run4+0xe6/0x850 kernel/trace/bpf_trace.c:2131
 __traceiter_mm_page_alloc+0x3d/0x60 include/trace/events/kmem.h:180
 __do_trace_mm_page_alloc include/trace/events/kmem.h:180 [inline]
 trace_mm_page_alloc+0x149/0x180 include/trace/events/kmem.h:180
 __alloc_frozen_pages_noprof+0x1de/0x380 mm/page_alloc.c:5272
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2484
 folio_alloc_mpol_noprof+0x39/0x70 mm/mempolicy.c:2503
 swap_cache_alloc_folio+0xd5/0x240 mm/swap_state.c:571
 swap_cluster_readahead+0x369/0x690 mm/swap_state.c:749
 swapin_readahead+0x196/0xc50 mm/swap_state.c:924
 do_swap_page+0x56f/0x5a20 mm/memory.c:4802
 handle_pte_fault mm/memory.c:6320 [inline]
 __handle_mm_fault mm/memory.c:6455 [inline]
 handle_mm_fault+0x12d2/0x3310 mm/memory.c:6624
 do_user_addr_fault+0xa73/0x1340 arch/x86/mm/fault.c:1334
 handle_page_fault arch/x86/mm/fault.c:1474 [inline]
 exc_page_fault+0x6a/0xc0 arch/x86/mm/fault.c:1527
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
RIP: 0033:0x55f04dab55f0
Code: c0 0f 85 0e 19 00 00 4c 8b 73 18 c7 44 24 28 00 00 00 00 49 89 dc 4c 8d 3d e9 95 02 00 4c 89 34 24 66 0f 1f 84 00 00 00 00 00 <41> 0f b6 1e 80 fb 35 0f 87 e3 01 00 00 0f b6 c3 49 63 04 87 4c 01
RSP: 002b:00007fff48a349c0 EFLAGS: 00010206
RAX: 000055f051ea3770 RBX: 0000000000000034 RCX: 0000000000000063
RDX: 0000000000000381 RSI: 000055f051eb5b50 RDI: 000055f051ecfdae
RBP: 000055f052096b80 R08: 000055f04daf2100 R09: 000055f04daf2140
R10: 0000000000000000 R11: 0000000000000000 R12: 000055f051eb5270
R13: 000055f051eb02c0 R14: 000055f051ea4574 R15: 000055f04dadebcc
 </TASK>

Allocated by task 5326:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x31c/0x660 mm/slub.c:5383
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 bpf_raw_tp_link_attach+0x278/0x700 kernel/bpf/syscall.c:4264
 bpf_raw_tracepoint_open+0x1b2/0x220 kernel/bpf/syscall.c:4312
 __sys_bpf+0x846/0x950 kernel/bpf/syscall.c:6270
 __do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6339
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 15:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2692 [inline]
 slab_free mm/slub.c:6168 [inline]
 kfree+0x1c1/0x630 mm/slub.c:6486
 rcu_do_batch kernel/rcu/tree.c:2617 [inline]
 rcu_core+0x7cd/0x1070 kernel/rcu/tree.c:2869
 handle_softirqs+0x22a/0x870 kernel/softirq.c:622
 run_ksoftirqd+0x36/0x60 kernel/softirq.c:1063
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 __call_rcu_common kernel/rcu/tree.c:3131 [inline]
 call_rcu+0xee/0x890 kernel/rcu/tree.c:3251
 bpf_link_put_direct kernel/bpf/syscall.c:3323 [inline]
 bpf_link_release+0x6b/0x80 kernel/bpf/syscall.c:3330
 __fput+0x44f/0xa70 fs/file_table.c:469
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x70f/0x23c0 kernel/exit.c:976
 do_group_exit+0x21b/0x2d0 kernel/exit.c:1118
 get_signal+0x1284/0x1330 kernel/signal.c:3034
 arch_do_signal_or_restart+0xbc/0x830 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:98 [inline]
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 irqentry_exit_to_user_mode_prepare include/linux/irq-entry-common.h:270 [inline]
 irqentry_exit_to_user_mode include/linux/irq-entry-common.h:339 [inline]
 irqentry_exit+0x176/0x620 kernel/entry/common.c:219
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618

The buggy address belongs to the object at ffff8880361a0300
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 24 bytes inside of
 freed 192-byte region [ffff8880361a0300, ffff8880361a03c0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8880361a0400 pfn:0x361a0
flags: 0x4fff00000000200(workingset|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000200 ffff88801ac413c0 ffffea0000d7ce90 ffffea0000e14e90
raw: ffff8880361a0400 000000080010000f 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 922, tgid 922 (kworker/0:3), ts 22003490640, free_ts 22003061349
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x24dc/0x2580 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5250
 alloc_slab_page mm/slub.c:3296 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3485
 new_slab mm/slub.c:3543 [inline]
 refill_objects+0x331/0x3c0 mm/slub.c:7178
 __pcs_replace_empty_main+0x2f9/0x5e0 mm/slub.c:-1
 alloc_from_pcs mm/slub.c:4720 [inline]
 slab_alloc_node mm/slub.c:4854 [inline]
 __do_kmalloc_node mm/slub.c:5262 [inline]
 __kmalloc_noprof+0x474/0x760 mm/slub.c:5275
 kmalloc_noprof include/linux/slab.h:954 [inline]
 virtio_gpu_array_alloc+0x26/0xc0 drivers/gpu/drm/virtio/virtgpu_gem.c:170
 virtio_gpu_update_dumb_bo drivers/gpu/drm/virtio/virtgpu_plane.c:171 [inline]
 virtio_gpu_primary_plane_update+0x38d/0x13a0 drivers/gpu/drm/virtio/virtgpu_plane.c:265
 drm_atomic_helper_commit_planes+0x60f/0xec0 drivers/gpu/drm/drm_atomic_helper.c:3038
 drm_atomic_helper_commit_tail+0x5f/0x500 drivers/gpu/drm/drm_atomic_helper.c:1989
 commit_tail+0x29a/0x3a0 drivers/gpu/drm/drm_atomic_helper.c:2074
 drm_atomic_helper_commit+0xa6e/0xb10 drivers/gpu/drm/drm_atomic_helper.c:2312
 drm_atomic_commit+0x246/0x2b0 drivers/gpu/drm/drm_atomic.c:1775
 drm_atomic_helper_dirtyfb+0xdec/0xf80 drivers/gpu/drm/drm_damage_helper.c:183
 drm_fbdev_shmem_helper_fb_dirty+0x160/0x2d0 drivers/gpu/drm/drm_fbdev_shmem.c:117
page last free pid 70 tgid 70 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xc2b/0xdb0 mm/page_alloc.c:2978
 ___free_pages_bulk mm/kasan/shadow.c:333 [inline]
 __kasan_populate_vmalloc_do mm/kasan/shadow.c:385 [inline]
 __kasan_populate_vmalloc+0x137/0x1d0 mm/kasan/shadow.c:424
 kasan_populate_vmalloc include/linux/kasan.h:580 [inline]
 alloc_vmap_area+0xd73/0x14b0 mm/vmalloc.c:2129
 __get_vm_area_node+0x1f8/0x300 mm/vmalloc.c:3232
 __vmalloc_node_range_noprof+0x372/0x1730 mm/vmalloc.c:4024
 __vmalloc_node_noprof+0xc2/0x100 mm/vmalloc.c:4124
 alloc_thread_stack_node kernel/fork.c:355 [inline]
 dup_task_struct+0x228/0x9a0 kernel/fork.c:924
 copy_process+0x508/0x3cf0 kernel/fork.c:2050
 kernel_clone+0x248/0x8e0 kernel/fork.c:2654
 user_mode_thread+0x110/0x180 kernel/fork.c:2730
 call_usermodehelper_exec_work+0x5c/0x230 kernel/umh.c:171
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0xb02/0x1830 kernel/workqueue.c:3358
 worker_thread+0xa50/0xfc0 kernel/workqueue.c:3439
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff8880361a0200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880361a0280: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff8880361a0300: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff8880361a0380: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8880361a0400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
