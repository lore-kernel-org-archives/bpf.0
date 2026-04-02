Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FB1372ECA
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 19:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775158769; cv=none; b=cVKGMjJg8+GX8iNCpS9J4/3wJUCq16Bp8iJeIx9Ikw47uuMbVZ49DHaTaFdaBECon/iC536voy7qKgdpQZPj+XMQ9d7T7Y/joC6Q+QPU1+c9iwKPOjYJvdP36r31xRFEo1/k31IC78EpVlmpmyIeAzA/mKzIkz4PK6OIxdPNFgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775158769; c=relaxed/simple;
	bh=owzoiyg5uMTi9jBSGwi2a4AWQjD/nULb9+63KUm3krM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Zi102Vte12L+IQXx04E1C2jyZ+OeyMvE2bko6mUpNvT1aSu0sL2S9lOUJmKqRMaAgjarTshHpXZ5L7ViWG9cyzjvyi0GEPkzanaCz7QxglU0T8wemj1NyzmkmrwInA6DJS0BxSQ6ktr8Ti2Qd2pqOALEigEOYNyKq3L+azJBmX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-67deac23e02so2120125eaf.2
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 12:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775158767; x=1775763567;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LmNMSticwwy68bmYI4NP8/nV4Ff79a42KYPUtfiNNJ0=;
        b=HTmgKc7VetVosQGM0pS2dl6tznlrzy/0ue/PRn4/My/Zqz8PpRdnnx7KfUKbxbxuaf
         VGlV06gibTkt3L92QFL3zCp21QmnU0zpkMzdq6B91uta9f6vdvMGgbqXmeGGwlxckli/
         ouQjzbEluktX7hlqU8P0TovsqzCegoNZasvQi7WuOLYiukWgd01C+Qtr/tEaf1+6A1Kh
         uOF3/2zF7gksA5QLn6a1OYauuc6nNHOCjBY8paeI7sJ5cYm144x3vZJ1EGHtESxB23yn
         v2CmUA7Dk6ludcynHRX0sjEJiIhO0fwEPP5w0jVP+ZLxxoW+bFssP/HXqGwPEk2RE83Y
         AGFA==
X-Forwarded-Encrypted: i=1; AJvYcCWJBWG0n+joJYqx3J40TfzWAbKlGV5nM19VH5JGMqgfOdx2OdRloTGfS+ArJnt6VjZr7aM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcZVL0c37MT/2rxhD3+PSGgZJcWbOTuHPIc3j/AA4tlic6WJk+
	Cg+ve5Apc3ZdzvQXpMw5W/n1PWHModh2f0RVeUNUZD8B5hiI34I40cgwFt+QCuzODv1ipcaTto8
	Z7OY9v3I1Wmy83XKEHWW+WUh/JtKv0vOF+4YVwtB3ZSWErEchNP/YPMj5rks=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6ac5:b0:67e:370e:d5f1 with SMTP id
 006d021491bc7-682200594e9mr271107eaf.48.1775158767131; Thu, 02 Apr 2026
 12:39:27 -0700 (PDT)
Date: Thu, 02 Apr 2026 12:39:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69cec5ef.050a0220.2dbe29.0009.GAE@google.com>
Subject: [syzbot] [net?] [bpf?] WARNING in sock_map_destroy (3)
From: syzbot <syzbot+b0842d38af58376d1fdc@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jakub@cloudflare.com, jiayuan.chen@linux.dev, 
	john.fastabend@gmail.com, kuba@kernel.org, kuniyu@amazon.com, 
	kuniyu@google.com, linux-kernel@vger.kernel.org, martin.lau@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	willemb@google.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1b237f190eb3 Linux 6.17-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13551c42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=b0842d38af58376d1fdc
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168d6ef0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f57862580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d708c97252af/disk-1b237f19.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3b964889e9fe/vmlinux-1b237f19.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2d05741e1ef1/bzImage-1b237f19.xz

The issue was bisected to:

commit 8259eb0e06d8f64c700f5fbdb28a5c18e10de291
Author: Jiayuan Chen <jiayuan.chen@linux.dev>
Date:   Fri May 16 14:17:12 2025 +0000

    bpf, sockmap: Avoid using sk_socket after free when sending

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17fbce62580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1407ce62580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1007ce62580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b0842d38af58376d1fdc@syzkaller.appspotmail.com
Fixes: 8259eb0e06d8 ("bpf, sockmap: Avoid using sk_socket after free when sending")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8459 at net/core/sock_map.c:1667 sock_map_destroy+0x28b/0x2b0 net/core/sock_map.c:1667
Modules linked in:
CPU: 1 UID: 0 PID: 8459 Comm: syz.0.1109 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:sock_map_destroy+0x28b/0x2b0 net/core/sock_map.c:1667
Code: 8b 36 49 83 c6 38 4c 89 f0 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 f7 e8 93 62 22 f9 4d 8b 3e e9 79 ff ff ff e8 a6 2b c3 f8 90 <0f> 0b 90 eb 9c e8 9b 2b c3 f8 4c 89 e7 be 03 00 00 00 e8 0e 4e bc
RSP: 0018:ffffc9000d067be8 EFLAGS: 00010293
RAX: ffffffff88fb30aa RBX: ffff888024832000 RCX: ffff888024283b80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed100862e946 R12: dffffc0000000000
R13: ffff888024832000 R14: ffffffff995b2208 R15: ffffffff88fb2e20
FS:  0000555579a7d500(0000) GS:ffff8881269c2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000000048c0 CR3: 000000003713a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 inet_csk_destroy_sock+0x166/0x3a0 net/ipv4/inet_connection_sock.c:1294
 __tcp_close+0xcc1/0xfd0 net/ipv4/tcp.c:3262
 tcp_close+0x28/0x110 net/ipv4/tcp.c:3274
 inet_release+0x144/0x190 net/ipv4/af_inet.c:435
 __sock_release net/socket.c:649 [inline]
 sock_close+0xc0/0x240 net/socket.c:1439
 __fput+0x45b/0xa80 fs/file_table.c:468
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f265847ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd158dfbd8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 000000000002ddb0 RCX: 00007f265847ebe9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f26586a7da0 R08: 0000000000000001 R09: 0000000e158dfecf
R10: 0000001b30a20000 R11: 0000000000000246 R12: 00007f26586a5fac
R13: 00007f26586a5fa0 R14: ffffffffffffffff R15: 00007ffd158dfcf0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
