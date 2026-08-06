Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03FB3B8D78
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029935; cv=none; b=ihlF+G1SNONLvZADj8yuZ/UPyuqUN3/ESIzCP8ZHEXFNR65MKrUrZwcvdSUsZhOeKDDGQYw6jKWHj3v5BqH9JBaIEEwSLykdxCg0JTJr5gaCxwOKttFRJFU8APSAesK25LvyUh4HQofvdu0dUSbv9WuyA6/8QiWzvsLXLjRCtTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029935; c=relaxed/simple;
	bh=9+LCOnORD6j42znvB/KSuKtXctYbOKNZtrgMAqL1QDk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Yte36wiYGjKgJVfHp0O/t9aerDuNQlL/zL0KhYp5HAQYo/EKJKOQY7R7hVzTm5BHpvqUAb16mWAD/44BmnRISfcUz9xQI4HF18FpyZOWBrmYA+y3ZAzLaOKLNU1KKNJc3rUfg1AE+zRRAcH3bwIWPAgN4s+Zb9Y6eW4Nzs1DseA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-6a0f261aeb6so2394340eaf.3
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 08:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786029932; x=1786634732;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ie2TMnf/y4p7EjEZc1gzKIMMwmQMQX/OMF6JXBGBJGk=;
        b=aSyUuuQ6nR3RhPctxdlTsukdDi3dHLAJieOxtyZ8X7HrnT28lXIeWiUDgqMT8lHUay
         3Y0ijO6k14AwJzaTQr1CeWQTSC+dWi8Fh6MZxzZy2QPOyiZdQR3AtVoHBZXPtFnukubn
         ViCHbbvwGSCdY2m7AC93OdwYIoME5szPhq6NhoWuko0hyhGi7A4nVV4hEwKaPwoTqNCL
         p3/B/E2RbhxtyWR1FCok3e+RhE9/S6dG1/oRTwrpW5Yxberm/2J+Qa7dsLp5PQPii4Qj
         pCAv0I57J3nKXk5X7HevB5aEBOfkehzrEnMStRjANqj462r0SP0054v0C6JyXt+8WYNJ
         rulw==
X-Forwarded-Encrypted: i=1; AHgh+Rr+V/0tSnoUD0pNUUD7X/EcCeXBofK8Nzi/jsq0GGEgqNFRdgqcEu1JVswf2lWwhHXT0J4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzotsiTG4vWdZgfiO1MDi4p18eS/+/dpeorXba0Uvz/zibRHFBE
	mXUCJXhhtYL1cZ13Eoqm9php54UzSCpaJN9KZnl7VkJBOhNpFB0Az3i+ABSSBjS3AzT0Z0J85HC
	hns2MykAKyWqybvqlionVlMmC1AyPpTBrq7ETZ9rzyayRkMj/lybK7DcL2Ow=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:83c7:20b0:6b0:1ba4:dcc5 with SMTP id
 006d021491bc7-6b01ba507admr1413386eaf.20.1786029932598; Thu, 06 Aug 2026
 08:25:32 -0700 (PDT)
Date: Thu, 06 Aug 2026 08:25:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a74a76c.ec7c9571.3ac9bb.0054.GAE@google.com>
Subject: [syzbot] [net?] [bpf?] KASAN: slab-use-after-free Read in xsk_bind
From: syzbot <syzbot+c06674caba265dc61d46@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c21bb4193868 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11e1dbb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=c06674caba265dc61d46
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e1dbb9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ff93b9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dde4460fa7fd/disk-c21bb419.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e1fe13568a84/vmlinux-c21bb419.xz
kernel image: https://storage.googleapis.com/syzbot-assets/283184100427/bzImage-c21bb419.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c06674caba265dc61d46@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in xsk_bind+0x1582/0x16c0 net/xdp/xsk.c:1758
Read of size 4 at addr ffff88802a91a18c by task syz-executor236/5659

CPU: 1 UID: 0 PID: 5659 Comm: syz-executor236 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 xsk_bind+0x1582/0x16c0 net/xdp/xsk.c:1758
 __sys_bind_socket net/socket.c:1920 [inline]
 __sys_bind_socket net/socket.c:1912 [inline]
 __sys_bind+0x1a9/0x260 net/socket.c:1951
 __do_sys_bind net/socket.c:1956 [inline]
 __se_sys_bind net/socket.c:1954 [inline]
 __x64_sys_bind+0x72/0xb0 net/socket.c:1954
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa532ec49c9
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffca3bd2128 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fa532ec49c9
RDX: 0000000000000010 RSI: 00002000000003c0 RDI: 0000000000000004
RBP: 00000000000f4240 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000004 R11: 0000000000000246 R12: 00007ffca3bd2180
R13: 00007fa532f3040a R14: 0000000000000003 R15: 00007ffca3bd2160
 </TASK>

Allocated by task 5622:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x2e5/0x6c0 mm/slub.c:5489
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 nsim_queue_alloc+0x3c/0x140 drivers/net/netdevsim/netdev.c:715
 nsim_queue_init drivers/net/netdevsim/netdev.c:1012 [inline]
 nsim_init_netdevsim drivers/net/netdevsim/netdev.c:1059 [inline]
 nsim_create+0xb13/0x1420 drivers/net/netdevsim/netdev.c:1152
 __nsim_dev_port_add+0x3ba/0x8f0 drivers/net/netdevsim/dev.c:1509
 nsim_dev_port_add_all drivers/net/netdevsim/dev.c:1570 [inline]
 nsim_drv_probe+0xdbd/0x13a0 drivers/net/netdevsim/dev.c:1731
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:620
 device_add+0x121d/0x1970 drivers/base/core.c:3772
 nsim_bus_dev_new drivers/net/netdevsim/bus.c:471 [inline]
 new_device_store+0x40b/0x700 drivers/net/netdevsim/bus.c:191
 bus_attr_store+0x74/0xb0 drivers/base/bus.c:172
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5659:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2677 [inline]
 slab_free mm/slub.c:6377 [inline]
 kfree+0x22b/0x6c0 mm/slub.c:6692
 nsim_queue_mem_free+0xfe/0x190 drivers/net/netdevsim/netdev.c:796
 netdev_rx_queue_reconfig+0x405/0x630 net/core/netdev_rx_queue.c:144
 netdev_rx_queue_restart+0x8f/0xc0 net/core/netdev_rx_queue.c:183
 nsim_qreset_write+0x2e3/0x410 drivers/net/netdevsim/netdev.c:887
 full_proxy_write+0x135/0x1a0 fs/debugfs/file.c:388
 vfs_write+0x2aa/0x1050 fs/read_write.c:685
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802a91a000
 which belongs to the cache kmalloc-cg-1k of size 1024
The buggy address is located 396 bytes inside of
 freed 1024-byte region [ffff88802a91a000, ffff88802a91a400)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2a918
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88813fe2d280 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88813fe2d280 dead000000000100 dead000000000122
head: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5622, tgid 5622 (syz-executor236), ts 69567522694, free_ts 58081032970
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0xf48/0x3530 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x299/0x2dc0 mm/page_alloc.c:5304
 alloc_slab_page mm/slub.c:3266 [inline]
 allocate_slab mm/slub.c:3380 [inline]
 new_slab+0xa2/0x640 mm/slub.c:3426
 refill_objects+0xe3/0x410 mm/slub.c:7310
 refill_sheaf mm/slub.c:2804 [inline]
 __pcs_replace_empty_main+0x376/0x680 mm/slub.c:4675
 alloc_from_pcs mm/slub.c:4773 [inline]
 slab_alloc_node mm/slub.c:4905 [inline]
 __do_kmalloc_node mm/slub.c:5333 [inline]
 __kmalloc_noprof+0x66d/0x820 mm/slub.c:5359
 _kmalloc_noprof include/linux/slab.h:992 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 __register_sysctl_table+0xac/0x1650 fs/proc/proc_sysctl.c:1378
 neigh_sysctl_register+0x326/0x660 net/core/neighbour.c:3915
 devinet_sysctl_register+0xb6/0x210 net/ipv4/devinet.c:2783
 inetdev_init+0x2b8/0x570 net/ipv4/devinet.c:291
 inetdev_event+0x7fa/0x17f0 net/ipv4/devinet.c:1590
 notifier_call_chain+0x99/0x3f0 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x110 net/core/dev.c:2250
 call_netdevice_notifiers_extack net/core/dev.c:2288 [inline]
 call_netdevice_notifiers net/core/dev.c:2302 [inline]
 register_netdevice+0x1998/0x25a0 net/core/dev.c:11484
 ipvlan_link_new+0x3a4/0xc60 drivers/net/ipvlan/ipvlan_main.c:593
page last free pid 187 tgid 187 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 free_pages_prepare+0x586/0xd80 mm/page_alloc.c:1451
 __free_contig_range_common+0x14f/0x250 mm/page_alloc.c:6897
 __free_contig_range mm/page_alloc.c:6942 [inline]
 free_pages_bulk+0x12a/0x200 mm/page_alloc.c:5257
 vm_area_free_pages+0xad/0x2b0 mm/vmalloc.c:3439
 vfree mm/vmalloc.c:3488 [inline]
 vfree+0x107/0x750 mm/vmalloc.c:3462
 delayed_vfree_work+0x56/0x80 mm/vmalloc.c:3392
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff88802a91a080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802a91a100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802a91a180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88802a91a200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802a91a280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
