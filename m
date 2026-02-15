Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A5226E6FA
	for <bpf@vger.kernel.org>; Sun, 15 Feb 2026 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771186892; cv=none; b=DT8wnDizT5M3gCxTQkmXFdZ8lYYvXKGbVRyFu8pMDzYICNAXHEzblWB1aeuSadzm0BR4OwJ/y3Gi95L7ov1UVWHCTnRkVqSfKEWcUdoZDlQx4cWL+M9FInSIKqJxtkUZO16saDZUZ+d2bHmD0oCEU2Oj80/eHHOg+SnMt+qF0c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771186892; c=relaxed/simple;
	bh=CofmEt8q/5frkrtZGnHaQtZE9zS/6n9OZ58W+nN80HM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rBihKMdijqcktk2oRkxXwh3r9QmMhFo/CGvK7TsNz85MpkkOy06CEmuuNPLTuKQM1iSCdmoo3aNdld6VdNbLEZvX1Ce9+pNQ5UTfW5DWm4s2hBrp5bDm//zQSJqIIDnPIc5nUhnbWor5z9RYojADmobo81TysyKhLre/svB+/04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6798921f07bso10210256eaf.3
        for <bpf@vger.kernel.org>; Sun, 15 Feb 2026 12:21:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771186889; x=1771791689;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vnwwPM63bdZZQrWw12YMopRYMAGjwcle7eQHit5r2hg=;
        b=U4ENz9XvR2a+VTq0aqhmMnSN4mZ45BMVMRFmyxY2fFIOU9Xji2PrnGmzPMv7TDqgI1
         f1ewBKU2Lx9HhGMAzqhqNMkuK4liU4XcTwFHH7Yl/+BiN9I82FizA0moDKSbkne2j75k
         5MdUVdlqzAxQ5G+PctIA5OcNwxEvvt48ucXKeZoP1l5hcIau+ZL2E4OcI2Vu+fZE4obE
         2+0RRH68oxDlISK9ACROSk2qSfmN4g0hDAqdrO00dEK2YpxMu4nnY4mFtLhTzBChRY0/
         atufEwLrXZgdRqsikzvyAPU44QC4yukayc13dd3Yc9Y2F3Ub7lqT3Z1PGF0SB+YTNnR/
         tyhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJQoLoTzxn26ph8DxEdGD4/jTRXAs3jEy4iLYgZK4HBAwK/Q5igA84U9j3DrRhKLcjPfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUKkiCx8H7lNpgy3Yiw3Ug9vef2zkNqZ84HZpNZC4qN7Ptpb1G
	Jb9n51K0AMebgiWK8HA7NGyACdg+bvZahBWXgL1+VvxRts1xR+CxH9T3UMEiyrVUkNAybDPJUnu
	ApZ+MEhYjl4MzeMNfZLla65PzYHjvlGHi9zbOWjg3cgXaxRS8DA7m7OaWG2k=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4a11:b0:672:668b:6c23 with SMTP id
 006d021491bc7-677691b5afdmr3460701eaf.58.1771186889211; Sun, 15 Feb 2026
 12:21:29 -0800 (PST)
Date: Sun, 15 Feb 2026 12:21:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69922ac9.a70a0220.2c38d7.00e0.GAE@google.com>
Subject: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in sk_msg_recvmsg
From: syzbot <syzbot+9307c991a6d07ce6e6d8@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jakub@cloudflare.com, john.fastabend@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a040afa3bca4 gve: fix probe failure if clock read fails
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=165bf05a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3161cabe5a361ff
dashboard link: https://syzkaller.appspot.com/bug?extid=9307c991a6d07ce6e6d8
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13dd245a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ecdb2a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ff453661cfef/disk-a040afa3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c65fb54cea84/vmlinux-a040afa3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/94868c75f7e1/bzImage-a040afa3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9307c991a6d07ce6e6d8@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in sk_msg_recvmsg+0xb54/0xc30 net/core/skmsg.c:428
Read of size 4 at addr ffff88814cdcf000 by task syz.0.24/6020

CPU: 1 UID: 0 PID: 6020 Comm: syz.0.24 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/13/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 sk_msg_recvmsg+0xb54/0xc30 net/core/skmsg.c:428
 udp_bpf_recvmsg+0x4bd/0xe00 net/ipv4/udp_bpf.c:84
 inet_recvmsg+0x260/0x270 net/ipv4/af_inet.c:891
 sock_recvmsg_nosec net/socket.c:1078 [inline]
 sock_recvmsg+0x1a8/0x270 net/socket.c:1100
 ____sys_recvmsg+0x1e6/0x4a0 net/socket.c:2812
 ___sys_recvmsg+0x215/0x590 net/socket.c:2854
 do_recvmmsg+0x334/0x800 net/socket.c:2949
 __sys_recvmmsg net/socket.c:3023 [inline]
 __do_sys_recvmmsg net/socket.c:3046 [inline]
 __se_sys_recvmmsg net/socket.c:3039 [inline]
 __x64_sys_recvmmsg+0x198/0x250 net/socket.c:3039
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb319f9aeb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb31ad97028 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00007fb31a216090 RCX: 00007fb319f9aeb9
RDX: 0000000000000001 RSI: 0000200000000400 RDI: 0000000000000004
RBP: 00007fb31a008c1f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000040000021 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fb31a216128 R14: 00007fb31a216090 R15: 00007ffe21dd0a98
 </TASK>

Allocated by task 6019:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x3d1/0x6e0 mm/slub.c:5780
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 alloc_sk_msg net/core/skmsg.c:510 [inline]
 sk_psock_skb_ingress_self+0x60/0x350 net/core/skmsg.c:612
 sk_psock_verdict_apply net/core/skmsg.c:1038 [inline]
 sk_psock_verdict_recv+0x7d9/0x8d0 net/core/skmsg.c:1236
 udp_read_skb+0x73e/0x7e0 net/ipv4/udp.c:2045
 sk_psock_verdict_data_ready+0x12d/0x550 net/core/skmsg.c:1257
 __udp_enqueue_schedule_skb+0xc54/0x10b0 net/ipv4/udp.c:1789
 __udp_queue_rcv_skb net/ipv4/udp.c:2346 [inline]
 udp_queue_rcv_one_skb+0xac5/0x19c0 net/ipv4/udp.c:2475
 __udp4_lib_mcast_deliver+0xc06/0xcf0 net/ipv4/udp.c:2585
 __udp4_lib_rcv+0x10f6/0x2620 net/ipv4/udp.c:2724
 ip_protocol_deliver_rcu+0x282/0x440 net/ipv4/ip_input.c:207
 ip_local_deliver_finish+0x3bb/0x6f0 net/ipv4/ip_input.c:241
 NF_HOOK+0x336/0x3c0 include/linux/netfilter.h:318
 dst_input include/net/dst.h:474 [inline]
 ip_sublist_rcv_finish+0x221/0x2a0 net/ipv4/ip_input.c:584
 ip_list_rcv_finish net/ipv4/ip_input.c:628 [inline]
 ip_sublist_rcv+0x5c6/0xa70 net/ipv4/ip_input.c:644
 ip_list_rcv+0x3f1/0x450 net/ipv4/ip_input.c:678
 __netif_receive_skb_list_ptype net/core/dev.c:6195 [inline]
 __netif_receive_skb_list_core+0x7e5/0x810 net/core/dev.c:6242
 __netif_receive_skb_list net/core/dev.c:6294 [inline]
 netif_receive_skb_list_internal+0x995/0xcf0 net/core/dev.c:6385
 netif_receive_skb_list+0x54/0x410 net/core/dev.c:6437
 xdp_recv_frames net/bpf/test_run.c:269 [inline]
 xdp_test_run_batch net/bpf/test_run.c:350 [inline]
 bpf_test_run_xdp_live+0x1946/0x1cf0 net/bpf/test_run.c:379
 bpf_prog_test_run_xdp+0x81c/0x1160 net/bpf/test_run.c:1396
 bpf_prog_test_run+0x2c7/0x340 kernel/bpf/syscall.c:4703
 __sys_bpf+0x5cb/0x920 kernel/bpf/syscall.c:6182
 __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6272
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6021:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free mm/slub.c:6674 [inline]
 kfree+0x1be/0x650 mm/slub.c:6882
 kfree_sk_msg include/linux/skmsg.h:385 [inline]
 sk_msg_recvmsg+0xaa8/0xc30 net/core/skmsg.c:483
 udp_bpf_recvmsg+0x4bd/0xe00 net/ipv4/udp_bpf.c:84
 inet_recvmsg+0x260/0x270 net/ipv4/af_inet.c:891
 sock_recvmsg_nosec net/socket.c:1078 [inline]
 sock_recvmsg+0x1a8/0x270 net/socket.c:1100
 ____sys_recvmsg+0x1e6/0x4a0 net/socket.c:2812
 ___sys_recvmsg+0x215/0x590 net/socket.c:2854
 do_recvmmsg+0x334/0x800 net/socket.c:2949
 __sys_recvmmsg net/socket.c:3023 [inline]
 __do_sys_recvmmsg net/socket.c:3046 [inline]
 __se_sys_recvmmsg net/socket.c:3039 [inline]
 __x64_sys_recvmmsg+0x198/0x250 net/socket.c:3039
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88814cdcf000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 0 bytes inside of
 freed 1024-byte region [ffff88814cdcf000, ffff88814cdcf400)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x14cdc8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x57ff00000000040(head|node=1|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 057ff00000000040 ffff88813fe26dc0 ffffea000509f800 dead000000000002
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 057ff00000000040 ffff88813fe26dc0 ffffea000509f800 dead000000000002
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 057ff00000000003 ffffea0005337201 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 17135672743, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x228/0x280 mm/page_alloc.c:1884
 prep_new_page mm/page_alloc.c:1892 [inline]
 get_page_from_freelist+0x24dc/0x2580 mm/page_alloc.c:3945
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5240
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2486
 alloc_slab_page mm/slub.c:3075 [inline]
 allocate_slab+0x86/0x3a0 mm/slub.c:3248
 new_slab mm/slub.c:3302 [inline]
 ___slab_alloc+0xd82/0x1760 mm/slub.c:4656
 __slab_alloc+0x65/0x100 mm/slub.c:4779
 __slab_alloc_node mm/slub.c:4855 [inline]
 slab_alloc_node mm/slub.c:5251 [inline]
 __kmalloc_cache_noprof+0x40d/0x6e0 mm/slub.c:5775
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 init_srcu_struct_fields+0x7f/0xa20 kernel/rcu/srcutree.c:240
 rtnl_link_register+0x141/0x2f0 net/core/rtnetlink.c:615
 ipgre_init+0x64/0x110 net/ipv4/ip_gre.c:1819
 do_one_initcall+0x250/0x840 init/main.c:1378
 do_initcall_level+0x104/0x190 init/main.c:1440
 do_initcalls+0x59/0xa0 init/main.c:1456
 kernel_init_freeable+0x2a6/0x3d0 init/main.c:1688
 kernel_init+0x1d/0x1d0 init/main.c:1578
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88814cdcef00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88814cdcef80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88814cdcf000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88814cdcf080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88814cdcf100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
