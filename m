Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753482B9D7
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 18:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871889; cv=none; b=TQ/21DdkqJHiPWESntXRNawImwkdr0hPCa20U1F49wvOrWUHsK5G27rM5Pj2bF3mnAu2Md7p93E6vw3apTBdVYRmluU4isPPkhnsuKaPbDWWlykMH/TVZUb/wq6urOK0jrO6HJKywciJrthFFg7WU5zgASs+UU/CMAFqn+eZEt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871889; c=relaxed/simple;
	bh=uYvVu5K7QwhKGbXSEeoiVsXNboYdx8Q/CM6U6r9GiVA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RCcsJ8+zbAj4ja/LYanF2mQYCxV46F7g/QDJ5ELCgfOInV3/KjnrODQtrzLjs/6MiJdgHCOq6Ef9RXpPHe17+x+OkUMEYm1rHQVgIdJL5jXT5VEVE8SDuF0uvRIuqh3V/3mU0JRfZv25yawSmHrthptIk4o9+sGub6++OqFUtxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cf179c3da4so8574639f.2
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 11:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710871886; x=1711476686;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ourJvfzE9Sqxygx+pIOlRci/YzZqikS4/H53deuGRw=;
        b=Zqsn9COnD8InnzAuGYSMx6H1O5OWekyRqEmNMShZmMySQkfSWi3kgjkHch+PcvSfkf
         +sceE3qGzGWHhYO5Hd1S39qwhjxp/rJFpTq+GZyis1NAc9WHWJmADETbnXzg3nVKLou4
         Rqsq2ciBCHJ8BRvBlL/IhNfjv1RuPh8qTmO+gb5bGABaPv8HzjcnxoG9+Sof+gwBefTm
         GzE3R+DNxUaiWSdZi97RtCUKPinBtoDGU3s0dCU/tcZdubBdKG3OxLhUVCBx7KwTHy4o
         mKEBlyqq8l3iaQ2N8fbjdCpYvnYsFJir8J4DL/uIj/IgZlddezKjMl5WXoq+HRMoN7ee
         rFrA==
X-Forwarded-Encrypted: i=1; AJvYcCVZQQu+wmSpcyZnNzftufjU6ALomYBf7F198vvvnKSQNuXQHNad9az8sLc1IGIpKvAdLnDnweUfZTHd3Jrtc5AKiICr
X-Gm-Message-State: AOJu0YwFlgvrGOWjc6GH1u3DqrwcYlHlQ5p/1JJIKS7ayxYmmSZL/9xD
	+sATthaHDLqlQqC/m7M3J89ERGw5tg+6o6nfmU12WEZASY+8lvuiBeY6WD8gtxStL+SPIVuLpcq
	GBwXY6JXJZ6O/bFK48ysaSYVR1Ej79vmulmsLwXXOja5eif1d0+e9OBM=
X-Google-Smtp-Source: AGHT+IGCNpKnwTt4DT3OQWvNfN51FK+pSxwl2xGRKFkiOCEaAW3rXW2DWbn42o68gc4+m46mkIvlq1EB0cYypTEUtC7dSmLctOXh
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:349e:b0:477:2773:11ca with SMTP id
 t30-20020a056638349e00b00477277311camr1048215jal.3.1710871886523; Tue, 19 Mar
 2024 11:11:26 -0700 (PDT)
Date: Tue, 19 Mar 2024 11:11:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d7c8f0614076733@google.com>
Subject: [syzbot] [bpf?] [net?] possible deadlock in sock_hash_delete_elem (2)
From: syzbot <syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0740b6427e90 Merge branch 'bpf-arena-followups'
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=11b90ac9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=ec941d6e24f633a59172
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c9e6e9f97566/disk-0740b642.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/78476a588b62/vmlinux-0740b642.xz
kernel image: https://storage.googleapis.com/syzbot-assets/50cd6fab9ead/bzImage-0740b642.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.8.0-syzkaller-05226-g0740b6427e90 #0 Not tainted
--------------------------------------------
syz-executor.4/13471 is trying to acquire lock:
ffff888034bc90f8 (&htab->buckets[i].lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff888034bc90f8 (&htab->buckets[i].lock){+.-.}-{2:2}, at: sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939

but task is already holding lock:
ffff888063a77968 (&htab->buckets[i].lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff888063a77968 (&htab->buckets[i].lock){+.-.}-{2:2}, at: sock_hash_update_common+0x20c/0xa30 net/core/sock_map.c:1007

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&htab->buckets[i].lock);
  lock(&htab->buckets[i].lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

5 locks held by syz-executor.4/13471:
 #0: ffff888065685258 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1671 [inline]
 #0: ffff888065685258 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: sock_map_sk_acquire net/core/sock_map.c:117 [inline]
 #0: ffff888065685258 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: sock_map_update_elem_sys+0x1cc/0x910 net/core/sock_map.c:575
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: sock_map_sk_acquire net/core/sock_map.c:118 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: sock_map_update_elem_sys+0x1d8/0x910 net/core/sock_map.c:575
 #2: ffff888063a77968 (&htab->buckets[i].lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #2: ffff888063a77968 (&htab->buckets[i].lock){+.-.}-{2:2}, at: sock_hash_update_common+0x20c/0xa30 net/core/sock_map.c:1007
 #3: ffff88803bbbc290 (&psock->link_lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #3: ffff88803bbbc290 (&psock->link_lock){+...}-{2:2}, at: sock_map_del_link net/core/sock_map.c:145 [inline]
 #3: ffff88803bbbc290 (&psock->link_lock){+...}-{2:2}, at: sock_map_unref+0xcc/0x5e0 net/core/sock_map.c:180
 #4: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #4: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #4: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #4: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420

stack backtrace:
CPU: 0 PID: 13471 Comm: syz-executor.4 Not tainted 6.8.0-syzkaller-05226-g0740b6427e90 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain+0x15c1/0x58e0 kernel/locking/lockdep.c:3856
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939
 bpf_prog_2c29ac5cdc6b1842+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
 trace_kfree include/trace/events/kmem.h:94 [inline]
 kfree+0x291/0x380 mm/slub.c:4396
 sk_psock_free_link include/linux/skmsg.h:421 [inline]
 sock_map_del_link net/core/sock_map.c:158 [inline]
 sock_map_unref+0x3ac/0x5e0 net/core/sock_map.c:180
 sock_hash_update_common+0x915/0xa30 net/core/sock_map.c:1030
 sock_map_update_elem_sys+0x5a4/0x910 net/core/sock_map.c:581
 map_update_elem+0x53a/0x6f0 kernel/bpf/syscall.c:1641
 __sys_bpf+0x76f/0x810 kernel/bpf/syscall.c:5619
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f9112c7dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9113a9f0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f9112dabf80 RCX: 00007f9112c7dda9
RDX: 0000000000000020 RSI: 0000000020000180 RDI: 0000000000000002
RBP: 00007f9112cca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f9112dabf80 R15: 00007ffdf604c018
 </TASK>


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
