Received: from mail-oi2-f1.google.com (mail-oi2-f1.google.com [74.125.231.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA333515F8
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787600860; cv=none; b=X3sEFrjzWLhd5jGh/Gvw2wuoWOgEbsyPpGCeWk+cme7BkH2yjIJ7zPC8wuzo+wFw0WPjH8Q82NLsqScAoO3LouL20uJXb/sdrJxINxNn+rDKRqAuje6tmzDMed73xGjixxrqnwHIns4tehTroo5EuwhdXA2X0zwToXd5IRJe1IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787600860; c=relaxed/simple;
	bh=bl0OwzUa8aQ0DpD/dn50WTvFX6XCzxNIb2Z2St5B8So=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FGICRITAu95SEJuVxrv85mnzwqmLv3JAw0Ybzy4ce1Nm0K6wroe4P2Mv/wSbl/XvoGcqZHTme/Hz/2EIvyJDkFTSRdQW3eyDhuZm3i0Rf6qyH/ayDvAA3ztlmGRMxjaKX70PGhvVwmDZjFOiQwZTOcPTseDJ7L8uoL6XPaUaYxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f1.google.com with SMTP id 5614622812f47-495f936d5ecso1345183b6e.0
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 12:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787600857; x=1788205657;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eOde3qSWo3L7OAF4ky3nsQL9z4RmP+Uscn74bSTAfB8=;
        b=IO7bJ5m7TvcHMHhzQ0AdFuKcS+NbgyUqLJszYUwoqkbjaBwKC3WrQ3T7yp+uUTtzEU
         4CGQZC6YJmqZGT6IMorE2orHoDJXU6uqdqWt6eerNeYsB07eLhQig81vbxsBDiSDFb2o
         zfWtodLfhRJFcBSu9e+twWCI6Rm7pR4YCjn1WdAen3palpKdU20wG2/Q8m7zjjW6/KsM
         vjwfqDchEYtJNUUxK2vsgEbyM/nIVQgxdneZPDEYx4hQZsTX9TQjdRRgjRObbjoagiyh
         +ZmkMsyFA5gPhuWZjon1P9xZb5uY15SbarNBxQN3XcSR3A/6uRBcWtgMh4sBvl+p/sF5
         nC/w==
X-Forwarded-Encrypted: i=1; AHgh+Rp9M/RRw05GcDYwC1VUwtLZ8dAmUhJeQ0p5D1F53WIIvbssOYtd3UP/epDA/JOPaEBLUv4=@vger.kernel.org
X-Gm-Message-State: AFuF++nOUf72IGpWKx5W4HeqVgiL7ufhsOT2JWSlYcjGpICPUN+usvG3
	dWQVlhEPwPNJ74B5Bjq1X8WvtXThHrHgyJ2ZyvIds+I04TrKhC6uLZHZWgAJGi3ns7/HIdzoJhd
	1GODca+QoFxHszMT/dMVNrrrTksLeTgEA3gMHOU0BA3DJ1ZXHdUACxSnol/E=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c292:b0:4a4:9e18:607a with SMTP id
 5614622812f47-4b309c4666bmr21715315b6e.21.1787600857078; Mon, 24 Aug 2026
 12:47:37 -0700 (PDT)
Date: Mon, 24 Aug 2026 12:47:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8c9fd9.dbb3a75c.7844.000c.GAE@google.com>
Subject: [syzbot] [bpf?] [net?] possible deadlock in xsk_diag_dump (3)
From: syzbot <syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    26260251022f Merge tag 'livepatching-for-7.3' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100d4415580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5a17c415a27e42e
dashboard link: https://syzkaller.appspot.com/bug?extid=aa48b5fe7bfda62d1682
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/05f9f33a1f1f/disk-26260251.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/197f5b9a6961/vmlinux-26260251.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ad671f043000/bzImage-26260251.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.6.13158/8347 is trying to acquire lock:
ffff888063c308f0 (&xs->mutex){+.+.}-{4:4}, at: xsk_diag_fill net/xdp/xsk_diag.c:113 [inline]
ffff888063c308f0 (&xs->mutex){+.+.}-{4:4}, at: xsk_diag_dump+0x533/0x1560 net/xdp/xsk_diag.c:166

but task is already holding lock:
ffff888061732440 (&net->xdp.lock){+.+.}-{4:4}, at: xsk_diag_dump+0x184/0x1560 net/xdp/xsk_diag.c:158

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&net->xdp.lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       xsk_notifier+0x89/0x230 net/xdp/xsk.c:2106
       notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
       call_netdevice_notifiers_extack net/core/dev.c:2313 [inline]
       call_netdevice_notifiers net/core/dev.c:2327 [inline]
       unregister_netdevice_many_notify+0x17fa/0x2130 net/core/dev.c:12518
       ipvlan_device_event+0xf1f/0xfb0 drivers/net/ipvlan/ipvlan_main.c:851
       notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
       call_netdevice_notifiers_extack net/core/dev.c:2313 [inline]
       call_netdevice_notifiers net/core/dev.c:2327 [inline]
       unregister_netdevice_many_notify+0x17fa/0x2130 net/core/dev.c:12518
       rtnl_delete_link net/core/rtnetlink.c:3652 [inline]
       rtnl_dellink+0x5be/0x810 net/core/rtnetlink.c:3694
       rtnetlink_rcv_msg+0x802/0xc00 net/core/rtnetlink.c:7132
       netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
       netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
       netlink_unicast+0x7f5/0x990 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
       sock_sendmsg_nosec+0x13a/0x180 net/socket.c:800
       __sock_sendmsg net/socket.c:815 [inline]
       ____sys_sendmsg+0x565/0x870 net/socket.c:2713
       ___sys_sendmsg+0x2a5/0x360 net/socket.c:2767
       __sys_sendmsg net/socket.c:2799 [inline]
       __do_sys_sendmsg net/socket.c:2804 [inline]
       __se_sys_sendmsg net/socket.c:2802 [inline]
       __x64_sys_sendmsg+0x1b7/0x290 net/socket.c:2802
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&port->pnodes_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       ipvlan_device_event+0x489/0xfb0 drivers/net/ipvlan/ipvlan_main.c:810
       notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
       call_netdevice_notifiers_extack net/core/dev.c:2313 [inline]
       call_netdevice_notifiers net/core/dev.c:2327 [inline]
       netdev_features_change net/core/dev.c:1612 [inline]
       netdev_change_features net/core/dev.c:11182 [inline]
       netdev_compute_master_upper_features+0x944/0xb30 net/core/dev.c:13069
       bond_slave_netdev_event drivers/net/bonding/bond_main.c:4045 [inline]
       bond_netdev_event+0x7a3/0xf80 drivers/net/bonding/bond_main.c:4090
       notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
       call_netdevice_notifiers_extack net/core/dev.c:2313 [inline]
       call_netdevice_notifiers net/core/dev.c:2327 [inline]
       netdev_features_change net/core/dev.c:1612 [inline]
       netdev_sync_lower_features net/core/dev.c:10945 [inline]
       __netdev_update_features+0xde7/0x1ef0 net/core/dev.c:11107
       netdev_change_features net/core/dev.c:11181 [inline]
       netdev_compute_master_upper_features+0x90c/0xb30 net/core/dev.c:13069
       __bond_release_one+0x9db/0x11c0 drivers/net/bonding/bond_main.c:2543
       do_set_master+0x332/0x720 net/core/rtnetlink.c:3055
       do_setlink+0xe7b/0x4670 net/core/rtnetlink.c:3273
       rtnl_changelink net/core/rtnetlink.c:3905 [inline]
       __rtnl_newlink net/core/rtnetlink.c:4076 [inline]
       rtnl_newlink+0x15a3/0x1c30 net/core/rtnetlink.c:4215
       rtnetlink_rcv_msg+0x802/0xc00 net/core/rtnetlink.c:7132
       netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
       netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
       netlink_unicast+0x7f5/0x990 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
       sock_sendmsg_nosec+0x13a/0x180 net/socket.c:800
       __sock_sendmsg net/socket.c:815 [inline]
       ____sys_sendmsg+0x565/0x870 net/socket.c:2713
       ___sys_sendmsg+0x2a5/0x360 net/socket.c:2767
       __sys_sendmsg net/socket.c:2799 [inline]
       __do_sys_sendmsg net/socket.c:2804 [inline]
       __se_sys_sendmsg net/socket.c:2802 [inline]
       __x64_sys_sendmsg+0x1b7/0x290 net/socket.c:2802
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&dev_instance_lock_key#23){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       netdev_lock include/linux/netdevice.h:2861 [inline]
       netdev_lock_ops include/net/netdev_lock.h:42 [inline]
       xsk_bind+0x331/0x11d0 net/xdp/xsk.c:1627
       __sys_bind_socket net/socket.c:1945 [inline]
       __sys_bind+0x2e9/0x410 net/socket.c:1976
       __do_sys_bind net/socket.c:1981 [inline]
       __se_sys_bind net/socket.c:1979 [inline]
       __x64_sys_bind+0x7a/0x90 net/socket.c:1979
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&xs->mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3181 [inline]
       check_prevs_add kernel/locking/lockdep.c:3300 [inline]
       validate_chain kernel/locking/lockdep.c:3924 [inline]
       __lock_acquire+0x1520/0x2ce0 kernel/locking/lockdep.c:5253
       lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5886
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       xsk_diag_fill net/xdp/xsk_diag.c:113 [inline]
       xsk_diag_dump+0x533/0x1560 net/xdp/xsk_diag.c:166
       netlink_dump+0x711/0xee0 net/netlink/af_netlink.c:2331
       __netlink_dump_start+0x589/0x7b0 net/netlink/af_netlink.c:2446
       netlink_dump_start include/linux/netlink.h:341 [inline]
       xsk_diag_handler_dump+0x1a0/0x250 net/xdp/xsk_diag.c:193
       sock_diag_rcv_msg+0x4b0/0x5f0 net/core/sock_diag.c:-1
       netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
       netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
       netlink_unicast+0x7f5/0x990 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
       sock_sendmsg_nosec+0x13a/0x180 net/socket.c:800
       __sock_sendmsg net/socket.c:815 [inline]
       sock_write_iter+0x2e4/0x3f0 net/socket.c:1266
       do_iter_readv_writev+0x624/0x8d0 fs/read_write.c:-1
       vfs_writev+0x34c/0x990 fs/read_write.c:1058
       do_writev+0x15a/0x2e0 fs/read_write.c:1104
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &xs->mutex --> &port->pnodes_lock --> &net->xdp.lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&net->xdp.lock);
                               lock(&port->pnodes_lock);
                               lock(&net->xdp.lock);
  lock(&xs->mutex);

 *** DEADLOCK ***

locks held by syz.6.13158/8347: 2, last CPU#0:
 #0: ffff88803f078928 (nlk_cb_mutex-SOCK_DIAG){+.+.}-{4:4}, at: __netlink_dump_start+0xf4/0x7b0 net/netlink/af_netlink.c:2410
 #1: ffff888061732440 (&net->xdp.lock){+.+.}-{4:4}, at: xsk_diag_dump+0x184/0x1560 net/xdp/xsk_diag.c:158

stack backtrace:
CPU: 0 UID: 0 PID: 8347 Comm: syz.6.13158 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e1/0x300 kernel/locking/lockdep.c:2059
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2191
 check_prev_add kernel/locking/lockdep.c:3181 [inline]
 check_prevs_add kernel/locking/lockdep.c:3300 [inline]
 validate_chain kernel/locking/lockdep.c:3924 [inline]
 __lock_acquire+0x1520/0x2ce0 kernel/locking/lockdep.c:5253
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5886
 __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
 mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
 xsk_diag_fill net/xdp/xsk_diag.c:113 [inline]
 xsk_diag_dump+0x533/0x1560 net/xdp/xsk_diag.c:166
 netlink_dump+0x711/0xee0 net/netlink/af_netlink.c:2331
 __netlink_dump_start+0x589/0x7b0 net/netlink/af_netlink.c:2446
 netlink_dump_start include/linux/netlink.h:341 [inline]
 xsk_diag_handler_dump+0x1a0/0x250 net/xdp/xsk_diag.c:193
 sock_diag_rcv_msg+0x4b0/0x5f0 net/core/sock_diag.c:-1
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x7f5/0x990 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:800
 __sock_sendmsg net/socket.c:815 [inline]
 sock_write_iter+0x2e4/0x3f0 net/socket.c:1266
 do_iter_readv_writev+0x624/0x8d0 fs/read_write.c:-1
 vfs_writev+0x34c/0x990 fs/read_write.c:1058
 do_writev+0x15a/0x2e0 fs/read_write.c:1104
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f22bcb6e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f22badc6028 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007f22bcdf5fa0 RCX: 00007f22bcb6e0d9
RDX: 0000000000000001 RSI: 0000200000000140 RDI: 0000000000000004
RBP: 00007f22bcc05024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f22bcdf6038 R14: 00007f22bcdf5fa0 R15: 00007ffc199cb668
 </TASK>
netlink: 24 bytes leftover after parsing attributes in process `syz.6.13158'.


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
