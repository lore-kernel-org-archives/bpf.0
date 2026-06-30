Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C511B330B01
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 06:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800422; cv=none; b=LJ6252/jFnFCnPSHRfaBX6Nh0opsF4DoYk9QifzkPC/sThOXpDnBpEFMcUUoxXqXNlK9vYhsxSpw6bXGxurIxPJTysBejpSzfwi63EHy+yGVDZgJMDKDaCSU869pG9WlRlVRdaBtdVpTXvpbJsCGHZeR/h0IcP5JIu7kJsMMH3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800422; c=relaxed/simple;
	bh=cEsCrGj+9F9IQFWnuctbba8n0jEKZ3TqDH7l5Qt7IFY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IqpGYg3clykkk4loOsy1D+2pTxin3lupHIw1aDcQXFGAWg8eDog9e1rTed6SAuPpmk3v7z9D7DoeX7Oni8VDo/dvEfvqyTCNSARz3V9d/JuyjrZrMz2ZzPVURcY90cQ/y1gwVXBhzyCZ/XsytHfEl2qsuysi6KUdMYkTTaILII8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-48f0c5d20c6so7081299b6e.2
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 23:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782800420; x=1783405220;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DnbMFUM7qZ+D+NV7cL8jZmwUgpg+omKmeavLOl+0ZQ8=;
        b=OE23s0zLYxQGlm8D5pGOLbGlfBxo+I17eyH/ZLx3PrvJKWwhoj1ZThe9kR/n5uNvQ0
         YnUtR38kvaNbJkpA0uNJunIj+cqK63RpfWlzxJSq8BhtwtZCS6yoNAa+47igOP8dinmp
         G0o5SWnq8uLKbc2Zkm11ktBXgbvVML+wkgwX167eRECq5gD5ArW4E1kgwwwJWgFkCLWA
         u9aG3eSq5jeYs2EpGpBjByjXZniH5NtycgSDvzU0ZeX21i8kKgz2ZTWqMEo1AENiQpIB
         twb2rvwp5tay3HOhwv4Xld5av0eEJQglLQQ328zeysHhjJ2FDLiSgyRqHj3zzIXpBT6S
         Watg==
X-Forwarded-Encrypted: i=1; AFNElJ/JA/pOPfx4LrdlPRCAvLSCpvKjXOSzgbxflGppOV/EisgLLDiHYkz5T3K6YElItQnQqEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXPUxf+QttKcFnv11P+1Hi3UsgM9lmqHcYYwOUl00NZ3l9xyx/
	ibjlfJxDHK7eZd5N/q99URm+n2k7C6omuKSevixf2RhrA3JCKHDU4QaC8PBytpWgi+OEhNO5W/N
	KK4iAW9+4dvWlQjZRNuCR6ESAs9BXQrcmPooBAJYx7Gqb/sFZi64kuO0KCkc=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4c84:b0:495:f25f:f333 with SMTP id
 5614622812f47-495f2600e1emr670746b6e.22.1782800419888; Mon, 29 Jun 2026
 23:20:19 -0700 (PDT)
Date: Mon, 29 Jun 2026 23:20:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a436023.b42ede87.8e801.0003.GAE@google.com>
Subject: [syzbot] [bpf?] BUG: using smp_processor_id() in preemptible code in bpf_mem_cache_free_rcu
From: syzbot <syzbot+fd7e415d891073b83e1f@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	memxor@gmail.com, netdev@vger.kernel.org, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e771677c937d Merge tag 'for-linus-iommufd' of git://git.ke..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=144f8aae580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ce9592ed82f8125
dashboard link: https://syzkaller.appspot.com/bug?extid=fd7e415d891073b83e1f
compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124c12ae580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b89986580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5c69b301ec25/disk-e771677c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8267811b5065/vmlinux-e771677c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bcc54586e6c4/bzImage-e771677c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fd7e415d891073b83e1f@syzkaller.appspotmail.com

BUG: using smp_processor_id() in preemptible [00000000] code: syz.0.17/5820
caller is bpf_mem_cache_free_rcu+0x48/0xc0 kernel/bpf/memalloc.c:954
CPU: 1 UID: 0 PID: 5820 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 check_preemption_disabled+0xd3/0xe0 lib/smp_processor_id.c:47
 bpf_mem_cache_free_rcu+0x48/0xc0 kernel/bpf/memalloc.c:954
 rhtab_delete_elem+0x185a/0x1b30 kernel/bpf/hashtab.c:2969
 __rhtab_map_lookup_and_delete_batch+0x935/0xcb0 kernel/bpf/hashtab.c:3349
 bpf_map_do_batch+0x445/0x630 kernel/bpf/syscall.c:-1
 __sys_bpf+0x906/0xd90 kernel/bpf/syscall.c:-1
 __do_sys_bpf kernel/bpf/syscall.c:6537 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6534 [inline]
 __x64_sys_bpf+0xba/0xd0 kernel/bpf/syscall.c:6534
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fce2819ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcea2ad4b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fce28415fa0 RCX: 00007fce2819ce59
RDX: 0000000000000038 RSI: 00002000000018c0 RDI: 0000000000000019
RBP: 00007fce28232d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fce28415fac R14: 00007fce28415fa0 R15: 00007fce28415fa0
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
