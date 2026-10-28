Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793213840;
	b=vX81E99YdYvgZGpuWXq8pj8dBEl/bfgi7YvftryKnihx3u87dIEifTp+E0IknqLZ7XFO
	 ePP60v+HZ6jRk2ds0ou9hclM5ygTK4GWR6wwWCzuaaiTGKZSDofgojLAUA8By9wXsXZUu
	 OFqlHPVto/E3TJnig1tLlkNxjkbwiJqwa3EmA4Oz2lbZQLbuxPbRc80bg1KnbAwGRyiau
	 RywQu/HC0JB/gPX25oz1gTZmI7h5knzk7tydfgx1nVepsNm7C+WwHibYTcfou70Mt45/O
	 QFdklU8zRcR6qN/XE+4xe3/ILIQ8fgajWF24m+eMnKsXBvHHxGUlGqY9vf+biBRmnBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793213840;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=/7JOurlc6HqiL3iDH7Eo3+AO11zhMtBDqjHXfq+c0VA=;
	b=BoDwcjETSSyJBoUWWaw0J3nPo5Ebpsg5OrKUQLLpWxg5LKfSBjFfUmGCXQ86rGgTZyxs
	 z1i48Idy+3/d8ps/zDao2bd7EdJYtYRQ9JLDdr5KhThooND1Bu3eHmHj7E94oEcxrh+60
	 tCu3mzlt1fOfu/5I8DUNFWXgXSLEHLrLM20VAYPMmkv4LOLjUVFlEFaa5TroY+yYG3qmB
	 Y9yk6+RgK/RJYf25uOBD6FO1XLQX5g9T5t8ZbU8QBPoQ/lRA/HMzxLtMNyUrtDROj58dU
	 aFcWSab447mnVpyjV1LhG+vCi0q8g3N6h4h17Y/bWy7N0OAiqqjkD8dMcwATllrBLwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFBB606A321
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 18:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCFBB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4f4612a1a5cso2802921b6e.0
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 11:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793213839; x=1793818639;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/7JOurlc6HqiL3iDH7Eo3+AO11zhMtBDqjHXfq+c0VA=;
        b=NF0dnAzussF1apCG6eH2x/M7daxpsKBoG6xl/hTWALi/6UXwbFYZxtCQfV8dDw8Gw/
         XF0S1Fmsty1pm+HEQaurVulo/HOoC3GwIXXgec1JzAYwfMfGn9IM63xMplmXoTzF+zsA
         0yrXDq1GnhvLGg0sNNmaTg6QDnfy84Nh4XuKbhwHjaLdIo5mwWNaQJmUHSAEwm72ocfC
         W24vy6IpET2aTAPJXGE7V9Ru4SRPB5OCedM4QHHwipCOA5yc7OLctrinXFZIA8aq5WMr
         /HcWWqFqmGdkhipIEG8CXS1ipllL2RE+u85y8itdc7xiUbed19RJmJTvH0r7IwjehX0U
         bR2A==
X-Forwarded-Encrypted: i=1; AKwUvBxrTnY9n5jszorjr/UYqqVu/wjLPNU1LV07XxauaFgBrKs31qirgY1c2+mH1XdkLseWLV8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLYTJIxxbHmanBp8lmkLxoQagIvz/E+mhlLVQTna+YYGtavnx+D
	DuWoy1JnRUdQYqaeHzZsfvwbFHxRYxh+KLKLrUa+x8vVjYVqUO+Jp/5ym+4iHQc45yay/phlbLa
	MulfoAgPuG+BTbJGNp7gpXyY3f3DoQ/ktYHP1miSarnyu6PMPiYurxTLx0o0=
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:6f92:b0:4b8:4703:db91 with SMTP id
 5614622812f47-563ef9cd728mr252876b6e.26.1793213838900; Wed, 28 Oct 2026
 11:57:18 -0700 (PDT)
Date: Wed, 28 Oct 2026 11:57:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae2458e.5451848c.f7707.0000.GAE@google.com>
Subject: [syzbot] [bpf?] WARNING in bpf_offload_dev_destroy
From: syzbot <syzbot+88435e204734072bf39a@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, linux-kernel@vger.kernel.org, 
	memxor@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6b4b543fa187 Merge tag 'parisc-for-7.4-rc1' of git://git.k..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15152d31580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=acf3b51ed91c8a7b
dashboard link: https://syzkaller.appspot.com/bug?extid=88435e204734072bf39a
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b06469580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+88435e204734072bf39a@syzkaller.appspotmail.com

------------[ cut here ]------------
!list_empty(&offdev->netdevs)
WARNING: kernel/bpf/offload.c:817 at bpf_offload_dev_destroy+0x50/0x60 kernel/bpf/offload.c:817, CPU#1: syz-executor187/5989
Modules linked in:
CPU: 1 UID: 0 PID: 5989 Comm: syz-executor187 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/15/2026
RIP: 0010:bpf_offload_dev_destroy+0x50/0x60 kernel/bpf/offload.c:817
Code: 08 00 74 08 4c 89 f7 e8 ae 97 3c 00 49 8b 06 4c 39 f0 75 10 e8 e1 29 c6 ff 48 89 df 5b 41 5e e9 e6 84 30 00 e8 d1 29 c6 ff 90 <0f> 0b 90 eb ea 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
RSP: 0018:ffffc9000427f8e8 EFLAGS: 00010293
RAX: ffffffff8202e2df RBX: ffff888077e79380 RCX: ffff88807fb99f40
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff888077e79380
RBP: ffff88807f177068 R08: ffffffff919d22bf R09: 1ffffffff233a457
R10: dffffc0000000000 R11: fffffbfff233a458 R12: dffffc0000000000
R13: 1ffff1100fe2ee0f R14: ffff888077e79388 R15: ffff88807f175360
FS:  000055555df6c400(0000) GS:ffff88812372f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562affe20950 CR3: 0000000033214000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 nsim_drv_remove+0x60/0x170 drivers/net/netdevsim/dev.c:1727
 device_remove drivers/base/dd.c:616 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x48b/0x880 drivers/base/dd.c:1372
 bus_remove_device+0x444/0x560 drivers/base/bus.c:667
 device_del+0x524/0x8f0 drivers/base/core.c:3965
 device_unregister+0x21/0xf0 drivers/base/core.c:4006
 nsim_bus_dev_del drivers/net/netdevsim/bus.c:488 [inline]
 del_device_store+0x2b5/0x370 drivers/net/netdevsim/bus.c:243
 kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe6aee8cd77
Code: 48 89 fa 4c 89 df e8 98 1d 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffe6a26c3a0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000055555df6c400 RCX: 00007fe6aee8cd77
RDX: 0000000000000001 RSI: 00007fe6aeeca627 RDI: 0000000000000003
RBP: 0000000000000018 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007fe6aeeca627
R13: 00007ffe6a26c760 R14: 0000000000000004 R15: 00007ffe6a26c414
 </TASK>


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
