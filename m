Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BECD3451AB
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 04:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165524; cv=none; b=G5UHFEcFUd0bEscnoRCZsqgmIwIaTg9oVJ3iCD7vrlS7EtJkZuJAItPlK1W6psorWmf7nbQcRUs92RDKDy4k3z1yBzjSaB3tLwthBBf03iCDVGzA/U01jyYuTIOv3FmvSaVJi6FFuOlUmzCRybmnymMxr2YCRRXPXSIMBKiygFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165524; c=relaxed/simple;
	bh=BcnjrKxpwgLuu7ewpGhVR3JnuOS6hzfhVXWbwqbWw78=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gnZZkPBMN+CM1ceLiBpIw0QK/OLZ/9NJ6P/4Eey2WWABZhRDZ80K4FKYy5VUyXRJcSQaslf1Vj0IhHPl6Bg96lqfiEefl83VYXN4qaVpPxBgP0nADQZFiQtyGBCvkC1KaMm1f1l+tmdnxGPuyyWPaZI2AXPD7iSuflxmPit/XHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-679c52164f5so13375689eaf.2
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 20:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165522; x=1772770322;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YDkwpybAELSi9VTqXZw+I/iTFeLd3c/Fw2ButfNaShY=;
        b=O+4yLAXxHHnoS54vJ6ImTwCwiHDnBXpIWuqg45GUrciQ43U/13RGu9G2BJantgoccZ
         CdEIthFVJmKf8nzVl+NpSfnAnqLcC2UweJtsccs2VpDpIk3s5Dru7s8bssaAxIIK1yil
         +ZfR5eXm3rJ+GX/S8syx5gr1eGtkdkhHfWM+2cHGd/F0laEjl1Bdd5352+1HzST+SkIp
         49rkJ9uHjHjMIXQc1ODGc0n68SStMFl7yRwxSgEHqDoYx3ciAKcR3i7MOgwexLsUQNnE
         K5xprfoDViGeRzwUyrOx48at0QuYFWkNHOSkxqgEdbA5WZTD4SJO2KgaQDeP6wnXhnFr
         MVMw==
X-Forwarded-Encrypted: i=1; AJvYcCVTVzAhE4wDWwpv9noPebFS0E3KKZ/Ca7+lcsQJ5YN1KDfl9KlpE/Hbzc4zCmANk8ae/6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv6yJEWtxw6Ssw+JutYWJ/OvUvhyN2l3pE1G48tsDMvhWEsCv+
	Ktlw3GHHx1yoUT5XXaqLqJDVikJzuoGDpq8ggOAv8d1JR5VUJMcWQgiKGXa2gBhEmeYuR6Cu/LF
	hPxvrSAfc2fKvOpQ2TmpFp/6f/qGlM0IWQLu3Xu067ahSgapq1f8G9sOkBWk=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1b0f:b0:676:6570:209b with SMTP id
 006d021491bc7-679fadbf64fmr1036568eaf.6.1772165522348; Thu, 26 Feb 2026
 20:12:02 -0800 (PST)
Date: Thu, 26 Feb 2026 20:12:02 -0800
In-Reply-To: <20260227035341.1108372-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a11992.050a0220.305b49.0084.GAE@google.com>
Subject: Re: [syzbot] [bpf?] [trace?] KASAN: slab-use-after-free Read in
 bpf_trace_run3 (2)
From: syzbot <syzbot+9ea7c90be2b24e189592@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, 
	mattbobrowski@google.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	wangqing7171@gmail.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in bpf_trace_run3

==================================================================
BUG: KASAN: slab-use-after-free in __bpf_trace_run kernel/trace/bpf_trace.c:2075 [inline]
BUG: KASAN: slab-use-after-free in bpf_trace_run3+0xdd/0x850 kernel/trace/bpf_trace.c:2130
Read of size 8 at addr ffff888047c32a18 by task syz.0.2435/10835

CPU: 0 UID: 0 PID: 10835 Comm: syz.0.2435 Not tainted syzkaller #0 PREEMPT(full) 
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
 __do_trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:47 [inline]
 trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:47 [inline]
 __mmap_lock_do_trace_acquire_returned+0x1a1/0x210 mm/mmap_lock.c:35
 __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:42 [inline]
 mmap_write_lock_killable include/linux/mmap_lock.h:557 [inline]
 do_mprotect_pkey+0x389/0xcd0 mm/mprotect.c:832
 __do_sys_mprotect mm/mprotect.c:951 [inline]
 __se_sys_mprotect mm/mprotect.c:948 [inline]
 __x64_sys_mprotect+0x80/0x90 mm/mprotect.c:948
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa0dcb9c427
Code: 89 38 eb 84 0f 1f 80 00 00 00 00 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff e9 7a ff ff ff b8 0a 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff44e34e58 EFLAGS: 00000206 ORIG_RAX: 000000000000000a
RAX: ffffffffffffffda RBX: 00007fa0ddad26c0 RCX: 00007fa0dcb9c427
RDX: 0000000000000003 RSI: 0000000000020000 RDI: 00007fa0ddab3000
RBP: 0000000000000000 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000021000 R11: 0000000000000206 R12: 00007fff44e34fb0
R13: ffffffffffffffc0 R14: 0000000000001000 R15: 0000000000000000
 </TASK>

Allocated by task 10832:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x31c/0x660 mm/slub.c:5339
 kmalloc_noprof include/linux/slab.h:962 [inline]
 kzalloc_noprof include/linux/slab.h:1200 [inline]
 bpf_raw_tp_link_attach+0x278/0x700 kernel/bpf/syscall.c:4266
 bpf_raw_tracepoint_open+0x1b2/0x220 kernel/bpf/syscall.c:4314
 __sys_bpf+0x846/0x950 kernel/bpf/syscall.c:6272
 __do_sys_bpf kernel/bpf/syscall.c:6343 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6341 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6341
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5963:
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
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 update_defense_level+0x91e/0xd70 net/netfilter/ipvs/ip_vs_ctl.c:209
 defense_work_handler+0x2d/0xd0 net/netfilter/ipvs/ip_vs_ctl.c:234
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

The buggy address belongs to the object at ffff888047c32a00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 24 bytes inside of
 freed 192-byte region [ffff888047c32a00, ffff888047c32ac0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x47c32
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000000 ffff88801ac413c0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5734, tgid 5734 (syz-executor), ts 170582106129, free_ts 164219023362
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
 kset_create lib/kobject.c:965 [inline]
 kset_create_and_add+0x5a/0x170 lib/kobject.c:1008
 register_queue_kobjects net/core/net-sysfs.c:2106 [inline]
 netdev_register_kobject+0x1a2/0x310 net/core/net-sysfs.c:2362
 register_netdevice+0x12c0/0x1cf0 net/core/dev.c:11422
 nsim_init_netdevsim drivers/net/netdevsim/netdev.c:1063 [inline]
 nsim_create+0xb92/0x1100 drivers/net/netdevsim/netdev.c:1145
 __nsim_dev_port_add+0x72a/0xb50 drivers/net/netdevsim/dev.c:1493
 nsim_dev_port_add_all+0x37/0xf0 drivers/net/netdevsim/dev.c:1549
 nsim_drv_probe+0x905/0xc20 drivers/net/netdevsim/dev.c:1710
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x267/0xaf0 drivers/base/dd.c:661
 __driver_probe_device+0x18c/0x320 drivers/base/dd.c:803
page last free pid 29 tgid 29 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xc2b/0xdb0 mm/page_alloc.c:2978
 __folio_put+0x414/0x4f0 mm/swap.c:112
 folio_put include/linux/mm.h:1817 [inline]
 migrate_folio_done mm/migrate.c:1199 [inline]
 migrate_folio_move mm/migrate.c:1413 [inline]
 migrate_folios_move mm/migrate.c:1721 [inline]
 migrate_pages_batch+0x3593/0x4d80 mm/migrate.c:1977
 migrate_pages_sync mm/migrate.c:2007 [inline]
 migrate_pages+0x1c74/0x2a70 mm/migrate.c:2116
 compact_zone+0x26cd/0x4850 mm/compaction.c:2647
 compact_node+0x21a/0x320 mm/compaction.c:2916
 kcompactd+0xc20/0x1330 mm/compaction.c:3214
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888047c32900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888047c32980: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
>ffff888047c32a00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888047c32a80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888047c32b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


Tested on:

commit:         a75cb869 Merge tag 'v7.0-rc1-ksmbd-server-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1648cd5a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=56150637ffd942dd
dashboard link: https://syzkaller.appspot.com/bug?extid=9ea7c90be2b24e189592
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16640952580000

