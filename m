Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86D6382F12
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772562288; cv=none; b=IFOikiZRlQTiYznxU3XUxG94OUKi/r1adVSu3XaGdzCPH6ZVr0qmzWmDy7dubBSn1LP+ShvJXj8I57l6qRw03LeKlmYLdh1MWzeSNFPQ8PPsnuVz7BcMEgYNXPwuQs4camP82B6NtRs0WKG7LKDiTeSFaGr7EhqfRtwtC6eJxyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772562288; c=relaxed/simple;
	bh=Bk+EFBOiK5cN7R8c+5YaGrnXfC55w11L03MP6kMt704=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=C/JDSTpoUHeV0ylBAgGsXAW1VF8jKouTOCKuQDtLLBwLTjoFYjbI4VpUfoMeSWKiwYcHOlBHr3au19nPJxkX4+EWMX4qQJOKfxwJQ4dC1EOwrSnf33/1nlEBJOIRcDyviI5dtXkf3Z8oI/F5F5v2bCaneRVlj8tiqo0b5Im+W34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-66b612efb4aso82546596eaf.0
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 10:24:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772562283; x=1773167083;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G3vJXOD9+xni157J6YAf4uty8XGc/q45kc+n8BtomcA=;
        b=xSXCnqt8IJuZ5fYt97gIZoTx/55jFAWqxE6GTSGSxI0aKfRuY1igLKptLkIVqsmjzG
         l0PrR8THXW21mXJaAJXooAFSk+Xnken3Ws997Zg/DZetEpTHxy29z43uBnRvU8CVp+w6
         kvjhz5x1ezPqNcM19vcLpLG/q2n/mHumsOqX1EL+63irvunb+Qu9am3cOYmRQdbdBWaL
         u14i43VTnEdDiToGoBIFWsRfSamCqvktVgpnmBVe4dMY2Jvr7iq6j31PDLque5xff6G1
         3o9Ber/Df59WxCt3WSl82uFvk7OFk7PvQSohh9tHO1K6oH3MHLGdlWMs4oNRYqibyhPp
         NslA==
X-Forwarded-Encrypted: i=1; AJvYcCV/rqi9FwAXHQIiFS/y/KHU2L8PvSSGV3mlwGuFqmzpbkSBD20Kf6W5y1lfHOnv3KlvEsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywna45MPqEUntXxF/RywPTLZAc2Un9LKafYbgDIkyabLYvLshv5
	gScPDIdBisOmn/GBNb2+kR9L02s4/91xx3rSMyAMFxX8Gg7AggsAWaoI1TE9yCR1jI8w+6EMGq0
	uRtVYj2YIXxrkLcVVaFnZOocPJVI5yZ1jmM9EP4daQrLOld/rD1NV1GCFIAs=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:83c2:20b0:679:88d0:3e20 with SMTP id
 006d021491bc7-67a1da0f01emr1311446eaf.9.1772562282672; Tue, 03 Mar 2026
 10:24:42 -0800 (PST)
Date: Tue, 03 Mar 2026 10:24:42 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a7276a.a70a0220.b118c.0011.GAE@google.com>
Subject: [syzbot] [bpf?] [trace?] KASAN: slab-use-after-free Read in bpf_trace_run9
From: syzbot <syzbot+b4c5ad098c821bf8d8bc@syzkaller.appspotmail.com>
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

HEAD commit:    a75cb869a8cc Merge tag 'v7.0-rc1-ksmbd-server-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17cb50ba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=56150637ffd942dd
dashboard link: https://syzkaller.appspot.com/bug?extid=b4c5ad098c821bf8d8bc
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122c6006580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1429cd5a580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-a75cb869.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dadc7741a2af/vmlinux-a75cb869.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7d84dbd51e35/bzImage-a75cb869.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b4c5ad098c821bf8d8bc@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __bpf_trace_run kernel/trace/bpf_trace.c:2075 [inline]
BUG: KASAN: slab-use-after-free in bpf_trace_run9+0x13b/0x8c0 kernel/trace/bpf_trace.c:2136
Read of size 8 at addr ffff888039269618 by task syz.5.56/5665

CPU: 0 UID: 0 PID: 5665 Comm: syz.5.56 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 __bpf_trace_run kernel/trace/bpf_trace.c:2075 [inline]
 bpf_trace_run9+0x13b/0x8c0 kernel/trace/bpf_trace.c:2136
 __bpf_trace_virtio_transport_alloc_pkt+0x3a5/0x410 include/trace/events/vsock_virtio_transport_common.h:39
 __traceiter_virtio_transport_alloc_pkt+0xc1/0x120 include/trace/events/vsock_virtio_transport_common.h:39
 __do_trace_virtio_transport_alloc_pkt include/trace/events/vsock_virtio_transport_common.h:39 [inline]
 trace_virtio_transport_alloc_pkt include/trace/events/vsock_virtio_transport_common.h:39 [inline]
 virtio_transport_alloc_skb+0x1108/0x1180 net/vmw_vsock/virtio_transport_common.c:312
 virtio_transport_send_pkt_info+0x570/0xff0 net/vmw_vsock/virtio_transport_common.c:391
 virtio_transport_connect+0xf5/0x150 net/vmw_vsock/virtio_transport_common.c:1080
 vsock_connect+0xaf5/0xd60 net/vmw_vsock/af_vsock.c:1716
 __sys_connect_file net/socket.c:2089 [inline]
 __sys_connect+0x312/0x450 net/socket.c:2108
 __do_sys_connect net/socket.c:2114 [inline]
 __se_sys_connect net/socket.c:2111 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2111
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd65079c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd52be1438 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007fd650a15fa0 RCX: 00007fd65079c799
RDX: 0000000000000010 RSI: 0000200000000080 RDI: 0000000000000003
RBP: 00007fd650832bd9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd650a15fac R14: 00007fd650a15fa0 R15: 00007fd650a15fa0
 </TASK>

Allocated by task 5664:
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

Freed by task 5576:
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
 __alloc_skb+0x1aa/0x7d0 net/core/skbuff.c:697
 alloc_skb include/linux/skbuff.h:1383 [inline]
 mld_newpack+0x14c/0xc90 net/ipv6/mcast.c:1775
 add_grhead+0x5a/0x2a0 net/ipv6/mcast.c:1886
 add_grec+0x1452/0x1740 net/ipv6/mcast.c:2025
 mld_send_initial_cr+0x288/0x550 net/ipv6/mcast.c:2268
 mld_dad_work+0x45/0x5b0 net/ipv6/mcast.c:2294
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

The buggy address belongs to the object at ffff888039269600
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 24 bytes inside of
 freed 192-byte region [ffff888039269600, ffff8880392696c0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888039269a00 pfn:0x39269
flags: 0x4fff00000000200(workingset|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000200 ffff88801ac413c0 ffffea0001646350 ffffea00015fe190
raw: ffff888039269a00 000000000010000b 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x1d2cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5643, tgid 5643 (syz.5.37), ts 117716289519, free_ts 117714764185
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
page last free pid 15 tgid 15 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xc2b/0xdb0 mm/page_alloc.c:2978
 __tlb_remove_table_free mm/mmu_gather.c:228 [inline]
 tlb_remove_table_rcu+0x85/0x100 mm/mmu_gather.c:291
 rcu_do_batch kernel/rcu/tree.c:2617 [inline]
 rcu_core+0x7cd/0x1070 kernel/rcu/tree.c:2869
 handle_softirqs+0x22a/0x870 kernel/softirq.c:622
 run_ksoftirqd+0x36/0x60 kernel/softirq.c:1063
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888039269500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888039269580: 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888039269600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888039269680: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888039269700: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
