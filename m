Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910824204E
	for <bpf@vger.kernel.org>; Sat, 21 Feb 2026 04:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771649193; cv=none; b=KgPsBqUvsnNTin7ZEjGYYo1hznkE+3D8Lcppkcuca9EknZjn7T25w/2SGkJUm4pJJkaycQVHSv7jNiBn+8bUpZe9Ij99UPH+XpRFpPelQRz1Rr4np6hlVeEUBGZXYixz7ACDwJ7pX43svoDuLJjHiZm8qkgDu7FVlMmjSeaWQvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771649193; c=relaxed/simple;
	bh=ssuOyEm8kssd6zKlD3i/WG3jhaegku3w80wyEghM+Uo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rQMhUFIsnZKnIPw8YkGY56b2lTUIrN7EHuBXwMLNH+GUinaPmRz2CVMqxjNm6w+/Ye8xnvcwXNeKIUcVh+SFOxVDC+jOfr5PQRAx3y5WsYI7ZVB0AqtjSTMKChwxKae+EWdmGYhLjiN5/QunK19/yPLBDnzDoflXFcu2VjHj4lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-679c6ef156dso776020eaf.1
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 20:46:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771649190; x=1772253990;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/UwG/ZLc5IdkNTEknjM/TIZ2h8y1xCA74ycYTIjZGL0=;
        b=rkq0HxbapiPMHF/5j4gj/D2CAgdPStqlLgHZmSm2T6OigBiWkMJbtI47+cGt4cX7He
         iUepbjFbwvQJkr0/sbTokhYRWkosHBj0dRbirTdrDSrBqBPjj5IzQjt1Xh21ga0oL4C+
         vFZN1+UbxqN3JYwgvRvCaGCNy9i6lQlxRd0ttX7I+wJx22X0LaEy/OsfD1VrXnUmkRm0
         CQs8eDsIqG59x00fcbkMo13cx+3xH4RvxqJFUSN5swm/BAsZOhQNwHprWJebT1cAiysc
         T/IxLEbXNW50Kd4aMG88Wwx7U8QbDBiEWA596mKQRvVy5Tg3vNuHZKtqgLyynjRjmX1t
         BKcg==
X-Forwarded-Encrypted: i=1; AJvYcCXJzXqqDqiGimAv2gpkd/j7fMYx/teh9Ls301sLsdxHqbtaTus9mO7e/Qnmz68vgiW9AB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjgEkFjHt1F+FznftphNqRN9xKRjq8KjG4ZGcPsxJaWRm45OhQ
	w7G9BuQRwI3l5kDVLKTLsH6co1gv4WF7enXovu/kgec4lnyv/HyE7zdnd//Cui8n6skhIw1Vqjb
	YHSdRALRtrPdNeLiIGYLz0HU68fZfbowS1P/Phj2TD6/U+cN2F21u2gvJOlc=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1ca6:b0:677:18e5:e5ac with SMTP id
 006d021491bc7-679c4278b92mr1054429eaf.18.1771649190323; Fri, 20 Feb 2026
 20:46:30 -0800 (PST)
Date: Fri, 20 Feb 2026 20:46:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699938a6.a70a0220.2c38d7.0150.GAE@google.com>
Subject: [syzbot] [trace?] [bpf?] KASAN: slab-use-after-free Read in
 bpf_trace_run2 (3)
From: syzbot <syzbot+59701a78e84b0bccfe1b@syzkaller.appspotmail.com>
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

HEAD commit:    8bf22c33e7a1 Merge tag 'net-7.0-rc1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c8c73a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=65722f41f7edc17e
dashboard link: https://syzkaller.appspot.com/bug?extid=59701a78e84b0bccfe1b
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141f7ffa580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-8bf22c33.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ee3f5bf71c12/vmlinux-8bf22c33.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ef5b82c2d846/bzImage-8bf22c33.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+59701a78e84b0bccfe1b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __bpf_trace_run kernel/trace/bpf_trace.c:2075 [inline]
BUG: KASAN: slab-use-after-free in bpf_trace_run2+0xb1/0x840 kernel/trace/bpf_trace.c:2129
Read of size 8 at addr ffff888053465b18 by task syz-executor/5307

CPU: 0 UID: 0 PID: 5307 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 __bpf_trace_run kernel/trace/bpf_trace.c:2075 [inline]
 bpf_trace_run2+0xb1/0x840 kernel/trace/bpf_trace.c:2129
 __traceiter_kfree+0x2e/0x50 include/trace/events/kmem.h:97
 __do_trace_kfree include/trace/events/kmem.h:97 [inline]
 trace_kfree include/trace/events/kmem.h:97 [inline]
 kfree+0x5b2/0x630 mm/slub.c:6428
 futex_hash_free+0x65/0xb0 kernel/futex/core.c:1736
 __mmput+0x38d/0x430 kernel/fork.c:1185
 exit_mm+0x168/0x220 kernel/exit.c:581
 do_exit+0x62e/0x2320 kernel/exit.c:959
 do_group_exit+0x21b/0x2d0 kernel/exit.c:1112
 get_signal+0x1284/0x1330 kernel/signal.c:3034
 arch_do_signal_or_restart+0xbc/0x830 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
 exit_to_user_mode_loop+0x86/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc4bbd57817
Code: Unable to access opcode bytes at 0x7fc4bbd577ed.
RSP: 002b:00007ffe1f8e8350 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: 00000000000000b0 RBX: 0000555576290500 RCX: 00007fc4bbd57817
RDX: 00000000000000b0 RSI: 00007fc4b863ff50 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000000b0
R13: 00005555762a51c0 R14: 00007ffe1f8e88f0 R15: 00007fc4b863ff50
 </TASK>

Allocated by task 6102:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x31c/0x660 mm/slub.c:5339
 kmalloc_noprof include/linux/slab.h:962 [inline]
 kzalloc_noprof include/linux/slab.h:1204 [inline]
 bpf_raw_tp_link_attach+0x278/0x700 kernel/bpf/syscall.c:4264
 bpf_raw_tracepoint_open+0x1b2/0x220 kernel/bpf/syscall.c:4312
 __sys_bpf+0x846/0x950 kernel/bpf/syscall.c:6271
 __do_sys_bpf kernel/bpf/syscall.c:6342 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6340 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6340
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 1100:
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
 do_softirq+0x76/0xd0 kernel/softirq.c:523
 __local_bh_enable_ip+0xf8/0x130 kernel/softirq.c:450
 spin_unlock_bh include/linux/spinlock.h:395 [inline]
 batadv_iv_ogm_queue_add+0x73e/0xd30 net/batman-adv/bat_iv_ogm.c:668
 batadv_iv_ogm_schedule_buff net/batman-adv/bat_iv_ogm.c:841 [inline]
 batadv_iv_ogm_schedule+0x874/0xf50 net/batman-adv/bat_iv_ogm.c:873
 batadv_iv_send_outstanding_bat_ogm_packet+0x6c8/0x7e0 net/batman-adv/bat_iv_ogm.c:1709
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0xb02/0x1830 kernel/workqueue.c:3358
 worker_thread+0xa50/0xfc0 kernel/workqueue.c:3439
 kthread+0x388/0x470 kernel/kthread.c:467
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
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0xed/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888053465b00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 24 bytes inside of
 freed 192-byte region [ffff888053465b00, ffff888053465bc0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x53465
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000000 ffff88801a8413c0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5436, tgid 5436 (syz-executor), ts 104947827691, free_ts 103695571452
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
 __do_kmalloc_node mm/slub.c:5218 [inline]
 __kmalloc_node_track_caller_noprof+0x572/0x7b0 mm/slub.c:5327
 kmemdup_noprof+0x2b/0x70 mm/util.c:138
 kmemdup_noprof include/linux/fortify-string.h:763 [inline]
 neigh_parms_alloc+0x87/0x510 net/core/neighbour.c:1772
 ipv6_add_dev+0x40d/0x13a0 net/ipv6/addrconf.c:403
 addrconf_notify+0x771/0x1050 net/ipv6/addrconf.c:3655
 notifier_call_chain+0x1be/0x400 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2287 [inline]
 call_netdevice_notifiers net/core/dev.c:2301 [inline]
 register_netdevice+0x173a/0x1cf0 net/core/dev.c:11451
 ip6gre_newlink_common+0x403/0x5b0 net/ipv6/ip6_gre.c:1965
 ip6gre_newlink+0x228/0x350 net/ipv6/ip6_gre.c:1998
 rtnl_newlink_create+0x329/0xb70 net/core/rtnetlink.c:3840
page last free pid 5378 tgid 5378 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xc2b/0xdb0 mm/page_alloc.c:2978
 vfree+0x25a/0x400 mm/vmalloc.c:3479
 kcov_put kernel/kcov.c:442 [inline]
 kcov_close+0x28/0x50 kernel/kcov.c:543
 __fput+0x44f/0xa70 fs/file_table.c:469
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x69b/0x2320 kernel/exit.c:971
 do_group_exit+0x21b/0x2d0 kernel/exit.c:1112
 get_signal+0x1284/0x1330 kernel/signal.c:3034
 arch_do_signal_or_restart+0xbc/0x830 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
 exit_to_user_mode_loop+0x86/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888053465a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888053465a80: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888053465b00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888053465b80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888053465c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
