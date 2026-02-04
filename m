Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E568221577
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 00:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770166364; cv=none; b=Yt8omwXwx0+phQSbb/wzgAfPrA8H1ooy/WoaYctgXeHx6WKmuyqzJ0YGQH4IZOSYVH/F/rkp9egBHoFWMO0bu8logDjBdWwRBARRHL1P7LLIkJxCYhgthOaB4/nbbuyIkpeux0s7rQPHYYWyG/+OMUb2OwW55detZm3z2c5iby4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770166364; c=relaxed/simple;
	bh=BDwytseUDZN2RitMqoVQscmyQnNkZLcbnzX0MbAIEEw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RCXNi2o1naSL1KqZsE7efoGbZDL5nWIGe+CrAsiR9h0/4wTcjQ3jI1czrEqkTbdQfdKsyMPT5EuEHFM8WgFBb8xeKzmChCAqDtZbMHKxk7RFzjhL7/pzV9D/R28yap2Fx5XT00WtGGdQqHqNR/+7iUlqZV8BWYGO7AR90acI7Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-462a9191720so9788018b6e.0
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 16:52:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770166362; x=1770771162;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5eU6gD2UjAk0c4GuLiweDyPRtvwSn/5AASYdK95cAdY=;
        b=sxwDvWThzMkJ2ax0K7pRgJT5nmNQcI0JU/SCAbfYfZ1LPCmDm7n5YlkFD1U4kHwgiS
         kT0F4rKHr9y06l0vHw/8mmKK5LB4fE4JocPt1BZxQX/+xGqdn1Zk3BG6OyV8AtsDzPIE
         jT3txQ8xs00wy3swL8FnuoAdscEKAWHYTpApy6w3+5ldUq3MYoTFYNLdTs/GI/0twyWe
         N0abcifZTBh4j6SfvI9sbRapLYhRxD2eADb7m5jmtNiWWaBEK4+cwz1voWKSQXPZFP3n
         I8oxdl10V/E33+HcCv93GETLw1UbvhaQsnei42QbOxhXqK4fF7G5hcNfIvEfU456nqRK
         O1pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWif3ohCt2d7ETAoqYkJeu+6SBQLjtBTZbuZZ+EGeYzwWWMba18i4XwBvzLnD6udTTo09s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0hsIW9tW5BX6IUV1qW+wUcfdcB+UK151m3ziphsJ6NSdZtW+K
	qXateYdMa8LNEAdHlkEAgr+VjIyZSB4zzaj0ZOD8VvE8bIKJADUGwW0IUjFvuY8m75+40iYMQr6
	bWikytBP0rvymB206aHKWHVYqVHXm0wWBM4zxLTlB/8mjxxf2+PEz16rhI6M=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4cca:b0:663:74a:f0ca with SMTP id
 006d021491bc7-66a22c6044dmr695206eaf.44.1770166362318; Tue, 03 Feb 2026
 16:52:42 -0800 (PST)
Date: Tue, 03 Feb 2026 16:52:42 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6982985a.a00a0220.37c87e.0018.GAE@google.com>
Subject: [syzbot] [bpf?] WARNING: refcount bug in __add_used_btf
From: syzbot <syzbot+5a0f1995634f7c1dadbf@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6b95cc562de2 ftrace: Fix direct_functions leak in update_f..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11a5fbfa580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5a1ee0109784fc2
dashboard link: https://syzkaller.appspot.com/bug?extid=5a0f1995634f7c1dadbf
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1035fc5a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a1625a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e902619c9a45/disk-6b95cc56.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c8a15c0caf9a/vmlinux-6b95cc56.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3e7c64a9dbaf/bzImage-6b95cc56.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a0f1995634f7c1dadbf@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x9f/0x110 lib/refcount.c:25, CPU#0: syz.1.44/6186
Modules linked in:
CPU: 0 UID: 0 PID: 6186 Comm: syz.1.44 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
RIP: 0010:refcount_warn_saturate+0x9f/0x110 lib/refcount.c:25
Code: eb 66 85 db 74 3e 83 fb 01 75 4c e8 2b 5b 23 fd 48 8d 3d 04 7d 58 0b 67 48 0f b9 3a eb 4a e8 18 5b 23 fd 48 8d 3d 01 7d 58 0b <67> 48 0f b9 3a eb 37 e8 05 5b 23 fd 48 8d 3d fe 7c 58 0b 67 48 0f
RSP: 0018:ffffc90003337380 EFLAGS: 00010293
RAX: ffffffff84a11b58 RBX: 0000000000000002 RCX: ffff88802f648000
RDX: 0000000000000000 RSI: ffffffff8ece7f00 RDI: ffffffff8ff99860
RBP: 0000000000000000 R08: ffff88802f648000 R09: 0000000000000005
R10: 0000000000000004 R11: 0000000000000000 R12: ffff8880762d8854
R13: 1ffff9200078f60c R14: ffff888079bc6258 R15: ffff888079bc6200
FS:  00007fb9d62266c0(0000) GS:ffff8881256f8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb9d53e8600 CR3: 00000000329a6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __add_used_btf+0x152/0x2e0 kernel/bpf/verifier.c:21107
 check_pseudo_btf_id+0x764/0xbb0 kernel/bpf/verifier.c:21238
 resolve_pseudo_ldimm64+0x3f4/0xc90 kernel/bpf/verifier.c:21489
 bpf_check+0x1d82/0x1ce00 kernel/bpf/verifier.c:25715
 bpf_prog_load+0x1484/0x1ae0 kernel/bpf/syscall.c:3081
 __sys_bpf+0x618/0x950 kernel/bpf/syscall.c:6218
 __do_sys_bpf kernel/bpf/syscall.c:6331 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6329 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6329
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb9d539aeb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb9d6226028 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fb9d5615fa0 RCX: 00007fb9d539aeb9
RDX: 0000000000000094 RSI: 0000200000000180 RDI: 0000000000000005
RBP: 00007fb9d5408c1f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fb9d5616038 R14: 00007fb9d5615fa0 R15: 00007ffda6487988
 </TASK>
----------------
Code disassembly (best guess):
   0:	eb 66                	jmp    0x68
   2:	85 db                	test   %ebx,%ebx
   4:	74 3e                	je     0x44
   6:	83 fb 01             	cmp    $0x1,%ebx
   9:	75 4c                	jne    0x57
   b:	e8 2b 5b 23 fd       	call   0xfd235b3b
  10:	48 8d 3d 04 7d 58 0b 	lea    0xb587d04(%rip),%rdi        # 0xb587d1b
  17:	67 48 0f b9 3a       	ud1    (%edx),%rdi
  1c:	eb 4a                	jmp    0x68
  1e:	e8 18 5b 23 fd       	call   0xfd235b3b
  23:	48 8d 3d 01 7d 58 0b 	lea    0xb587d01(%rip),%rdi        # 0xb587d2b
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	eb 37                	jmp    0x68
  31:	e8 05 5b 23 fd       	call   0xfd235b3b
  36:	48 8d 3d fe 7c 58 0b 	lea    0xb587cfe(%rip),%rdi        # 0xb587d3b
  3d:	67                   	addr32
  3e:	48                   	rex.W
  3f:	0f                   	.byte 0xf


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
