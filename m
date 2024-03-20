Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107F138F87
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924143; cv=none; b=Us8AEMFzfYmpxkM7yh3zeGrmPS2qArUxyOVzwK/LpaCafBO9I+QrOTvnj1ulagr/4ldCkzduz3AUOpsZmJRtMq2koMa+Uo4WMS6fvLlvcXzDMMDH++Wx8uudyZR3u5NZUTXlbYBN2tr/vrd5P+D4SjngUVF6b4+NbVk1ezdEFYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924143; c=relaxed/simple;
	bh=8R+8pHHqfT6dtAXr0gKaDFBoW2z/4w8pmg1sze2cRDE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=e80Xh6R39LJIFwJQONdEAm1u+4D6TAp94jN4YNYMCnhG9FGepNEKzLZEV1Mq1xBr4ycOLRjaqqUSvZyVNK/ZZ2L34zG/Whwt7ATx4xH/pDmYXyiDZZLfhsnjpjHZxXzUr+bLtDmwTHX8QZ8LnGW9QnKECAcr38DspQq0s690Mks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cbf1ea053cso565033239f.1
        for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 01:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710924141; x=1711528941;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NJo9BSMocNALtvqQ2QnVDTeK7qub3h9dTxH7whp8/KQ=;
        b=Bgn6dOCX7dp5HJPY7nT6dAJe1aO3wBCVmLb7gq6NfsoxRHba+wwWLcd8S5ZPX6ZYb8
         GwnuyO59WURhG5VR+zkkcsmETqGvm0q3fWk8nsi4I9W5/HBBje9QEU2wnYA7UfXpzLIm
         +8svVWotTAxN2JgglU+5RfZ6JAC2KeXlMWzLYwXcZxTBN+8cFXjO7c2aCIF9+plmelZJ
         j44eLAWHyuSeqwrlPav/CrXS/QT7T+dpL8MIg/DY8C3FdGrNC4RITXzCayaTXt8scL9w
         qjWg4kDoPpS0grxr6Ys5ebMRbAqx9fC0cnZRT5sSwY5EqTD1J73fbssh/ltPadyoirIM
         Ylpg==
X-Forwarded-Encrypted: i=1; AJvYcCXMdSZy9/SONpNEiWTJqHO90kCvCqccj99yn9fVU2BTUb2NW6qSmEL79Mt/l/QbQU3rLuqbkrm6J3ifuix9dzBgXLc3
X-Gm-Message-State: AOJu0YzueUb1ENLBuexM7E4vL3OcJQIk4p0+eDBdkXLqkcfHlHNkFGlF
	xUuaphnrk+ufalkKNCQc/gS+sBCTFl6VBGZpI/nwOe5bl/1Oqzdkv2ZZix7/XTMv/KxIKSTEONA
	pOZiKqugA6OCIA9VCPvLk55WJ8TTy33WAviyjoNELDOa13jhh1OsANxo=
X-Google-Smtp-Source: AGHT+IE8rm6ifnv6lm3IfjiUY9+6ygJXGx10rSs/4NCR1KNIV2sbKI51XbpmOF1XIjF0HS4Vh23mGFNbU5io2OjBIySQZJemnvJd
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:13c3:b0:474:fce1:3f8c with SMTP id
 i3-20020a05663813c300b00474fce13f8cmr259145jaj.6.1710924141272; Wed, 20 Mar
 2024 01:42:21 -0700 (PDT)
Date: Wed, 20 Mar 2024 01:42:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000adb08b061413919e@google.com>
Subject: [syzbot] [bpf?] possible deadlock in trie_delete_elem
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    32fa4366cc4d net: phy: fix phy_read_poll_timeout argument ..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16f5d769180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14572985180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1676fc6e180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bb05871df8fc/disk-32fa4366.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a774323fb6ec/vmlinux-32fa4366.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1742ae20d76c/bzImage-32fa4366.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.8.0-syzkaller-05242-g32fa4366cc4d #0 Not tainted
--------------------------------------------
syz-executor217/5072 is trying to acquire lock:
ffff88802a0fd9f8 (&trie->lock){....}-{2:2}, at: trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:451

but task is already holding lock:
ffff88802a0fc9f8 (&trie->lock){....}-{2:2}, at: trie_update_elem+0xcb/0xc10 kernel/bpf/lpm_trie.c:324

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&trie->lock);
  lock(&trie->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by syz-executor217/5072:
 #0: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: bpf_map_update_value+0x3c4/0x540 kernel/bpf/syscall.c:202
 #1: ffff88802a0fc9f8 (&trie->lock){....}-{2:2}, at: trie_update_elem+0xcb/0xc10 kernel/bpf/lpm_trie.c:324
 #2: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #2: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #2: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #2: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run4+0x16e/0x490 kernel/trace/bpf_trace.c:2422

stack backtrace:
CPU: 0 PID: 5072 Comm: syz-executor217 Not tainted 6.8.0-syzkaller-05242-g32fa4366cc4d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain+0x15c1/0x58e0 kernel/locking/lockdep.c:3856
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:451
 bpf_prog_2c29ac5cdc6b1842+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run4+0x25a/0x490 kernel/trace/bpf_trace.c:2422
 trace_mm_page_alloc include/trace/events/kmem.h:177 [inline]
 __alloc_pages+0x657/0x680 mm/page_alloc.c:4591
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 __kmalloc_large_node+0x91/0x1f0 mm/slub.c:3926
 __do_kmalloc_node mm/slub.c:3969 [inline]
 __kmalloc_node+0x33c/0x4e0 mm/slub.c:3988
 kmalloc_node include/linux/slab.h:610 [inline]
 bpf_map_kmalloc_node+0xd3/0x1c0 kernel/bpf/syscall.c:422
 lpm_trie_node_alloc kernel/bpf/lpm_trie.c:291 [inline]
 trie_update_elem+0x1d3/0xc10 kernel/bpf/lpm_trie.c:333
 bpf_map_update_value+0x4d3/0x540 kernel/bpf/syscall.c:203
 map_update_elem+0x53a/0x6f0 kernel/bpf/syscall.c:1641
 __sys_bpf+0x76f/0x810 kernel/bpf/syscall.c:5619
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f933485e7a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc8852b528 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 


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
