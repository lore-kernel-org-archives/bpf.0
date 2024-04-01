Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A35481D7
	for <bpf@vger.kernel.org>; Mon,  1 Apr 2024 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990282; cv=none; b=ImU7mho93aghlKFGUUf1kwl5fF+bjVfg79CjknxHXjynDIVrTEAYW0KkT82d4GAfEC8LZeYQ8Squ+a9x0W9ArvnpI0sF1sW7G77bw9Yy5EAzc5i3AJ6uxiE4ZLdBA3xPzj1/n938WCbfwMAlMhVIMVS1ZGixTIClt5ryVfgvxNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990282; c=relaxed/simple;
	bh=+YpLD+4LiDllvY8qBsgrDSTA9AJ0+xQFee1/kxIpYlc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LdRJr9kMTxTd91SyKRJIWMEVoVS8IJ7PUBs+Bf+OuzDNbXw/JPTVZCXFQPBPNLi9hg9JlrQvhqouNpwG2y97XnoPI+rn0VhGiJmLoEyi+1+02HLGcz3MZ5mMt4+59tXQL+l4WA2oltoHxO+SvzOQqW1Zd7DsBYWHnxMWpJrm2RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cf179c3da4so475398139f.2
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 09:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711990280; x=1712595080;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mdk8hs5YwRs0MgKKaMSnooSWizCujgZiOxORDfdAX/0=;
        b=eQ7fmT6J10jt2azeDEw39u9azUKznjQfQw6bneV4hmLoyrGzmd0lDIYHifNuUe5Ebc
         XtbbekGXRIM8NyHmbn+dcTKJxUHMcU/gzv7JNu/GY+LiqcYsxoWZpA2ZDWAAg5iGWqmY
         kqRiKS2HnMRJP3tnbVsU7f7cV2fOtkiZ7l1LZqCTgSoCJ3rPmvgYmIWzkzt2N9r9qmm9
         aRBVF7X/IcyyGNOc5SerGwgvmH8MZnTXj4E+PYY1EtxoM4suQWwIhNmKs4/3tRL3kpdy
         tRIoR1rM8xTkcXp9zAbohAYCmcLNgbVp4Fwb6JSfhz8zRRdi+n3KH0r5eM7xLs2teuKg
         Ed6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWW5BYjiqGBqt1YOYo3rpwvGCv8+oNFMhjJDek777vSB3UQ6UMQ5mDrhMpfLOd9Vux2qg8VfcOxtBL5S0DIoBDezLxh
X-Gm-Message-State: AOJu0Yx9kIWk0fw95I0+Qw2uLz86htEHRTvP7YZAiIoT24+uA63WXC2P
	kSdTtWyuS0vnirgNzJMoAYX0R3faTKZQofEtR63ZFU74uGtkKzmEx1g8XSROt1E/2apjtOZnbQB
	BGtV/y705tv4pKyRbThxc9al515KwQp5RlF+rKb68jz6LKBoUljQm3bk=
X-Google-Smtp-Source: AGHT+IGvh+h9Q7ZKk4dzQgcg/ciJVMmq/GBMv8Wtyz3R29FKzahTPJgHxJnFFV/WhUXFq7csn3ZGP0Txvp4nKR+njrehwDhRFGim
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:150c:b0:7d0:ad03:af10 with SMTP id
 g12-20020a056602150c00b007d0ad03af10mr179166iow.1.1711990280083; Mon, 01 Apr
 2024 09:51:20 -0700 (PDT)
Date: Mon, 01 Apr 2024 09:51:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081146c06150bcc2a@google.com>
Subject: [syzbot] [bpf?] WARNING in __mark_chain_precision (4)
From: syzbot <syzbot+148110ee7cf72f39f33e@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14024776180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=148110ee7cf72f39f33e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10c51c1d180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127285b1180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f6c04726a2ae/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/09c26ce901ea/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/134acf7f5322/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+148110ee7cf72f39f33e@syzkaller.appspotmail.com

------------[ cut here ]------------
verifier backtracking bug
WARNING: CPU: 0 PID: 5066 at kernel/bpf/verifier.c:3714 backtrack_insn kernel/bpf/verifier.c:3714 [inline]
WARNING: CPU: 0 PID: 5066 at kernel/bpf/verifier.c:3714 __mark_chain_precision+0x7027/0x7520 kernel/bpf/verifier.c:4255
Modules linked in:
CPU: 0 PID: 5066 Comm: syz-executor296 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:backtrack_insn kernel/bpf/verifier.c:3714 [inline]
RIP: 0010:__mark_chain_precision+0x7027/0x7520 kernel/bpf/verifier.c:4255
Code: 8b e8 ed df b0 ff 90 0f 0b 90 90 e9 7d f2 ff ff e8 9e 0b ee ff c6 05 41 c2 c9 0d 01 90 48 c7 c7 c0 af b0 8b e8 ca df b0 ff 90 <0f> 0b 90 90 e9 5a f2 ff ff e8 7b 0b ee ff c6 05 1f c2 c9 0d 01 90
RSP: 0018:ffffc900043f6ac0 EFLAGS: 00010246
RAX: 3bf0d782b73e5400 RBX: ffff8880236c5600 RCX: ffff88802a9dbc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900043f6d10 R08: ffffffff8157cb22 R09: 1ffff110172851a2
R10: dffffc0000000000 R11: ffffed10172851a3 R12: 0000000080000000
R13: 0000000000000010 R14: 0000000000000001 R15: ffff8880236c0000
FS:  000055557d2fe380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000082 CR3: 00000000231d4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mark_chain_precision kernel/bpf/verifier.c:4358 [inline]
 check_return_code+0xbe0/0x11e0 kernel/bpf/verifier.c:15500
 do_check+0xb91f/0x10500 kernel/bpf/verifier.c:17867
 do_check_common+0x14bd/0x1dd0 kernel/bpf/verifier.c:20492
 do_check_main kernel/bpf/verifier.c:20583 [inline]
 bpf_check+0x136ab/0x19010 kernel/bpf/verifier.c:21253
 bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2895
 __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5631
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f6484f2a469
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc85bd0a08 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffc85bd0be8 RCX: 00007f6484f2a469
RDX: 0000000000000090 RSI: 0000000020000600 RDI: 0000000000000005
RBP: 00007f6484f9d610 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc85bd0bd8 R14: 0000000000000001 R15: 0000000000000001
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
