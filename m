Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC7A55765
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781102; cv=none; b=g//jdYVEQLlwcaO09PQxkql2Fba/HTjXHfqIPsAEpj6flehGfmuEcNUaGEauRWi72aBx6N049UgeYmzaBoefzE4n8+17PT4asCtHWj10PTfUr/yMGQ5neABpMB7wwe/Z5xVcb1zW8+pVrAuKmOPh3J1XfhSmPt9ymlt8bsqs6Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781102; c=relaxed/simple;
	bh=yQvL+Ij2soSkg+12ZYM8o5fSUJad3PfIe0NIll+8grw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ukz5aXzDAp8F32BKAshHldJgDrjEGR/gxZFPtre3SppDbllmky3q9C4y2MTJBa+KXK0oZH8cFba6YS06YNcJL9pHfQ8pC6TIM/IhQXtt7sDOXC/Ut0lJ5mUGnkH1xXlkKBEzeDC0b6/hU0+qUMtvev9irYYNeJI6YeBOC94cwiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cc7a930922so96926939f.2
        for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 09:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710781099; x=1711385899;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wcG2b2YpOfaC4aVgOXmHR6nmRANw2mgN0+tkaaaKusU=;
        b=lvOjTsgW2PTGpss6/EDenrzx5OYV3alhZVY+8y9+Bnk09vHy7mIIefg6+YV6wCJ3ED
         Bhvu5MSwZ/anGNJ/fW7kbro9Fxl8Vr6YRFE0mCajqyEY8HcXfo0eLsbTGyxotbbF5ahH
         DjIotZYmD9ahERiq7fIonrmajXoGwESFk/Zerkybj9LFMEWOGAfCaOMHwm1dsdXeg0hD
         gsAt91dxp9EDpJ50WwARbpujy8GGPOWjAFIaFkojbzBGXyF6nctpKYoDyU5QqDLAeSlG
         qCvfYmNL0cP000EEPnC6JJtOvgz5ED5c/iXJ5iHwg76v8XmR27/4mIAXsut5tYXdOHFB
         qq9g==
X-Forwarded-Encrypted: i=1; AJvYcCV2AoLPcewqvWJEjCyeJerbZ0cOvU9S89XkQ/tnZ2WFsvg2Vl9KFkvHyIvCwd5w7vd1RbPhMoCD9QvGFhMIMOEsLin2
X-Gm-Message-State: AOJu0Yz2aif3LurR2ogR0pnaUa5aBjYW8rlhIwy71SyTwWN3RRmZr5XS
	mmMKCl70Tx2p7qaOW5brzk5Gd00X61LxfM9Um7kDFuFAXygriz/IjtTFou6D0530aIyKKYaRnQC
	qrjZqMdvyvD4W5ZKK2O2ryl+rCH6l+K8PuW+qn4CbKmOlvObh1wxPxGw=
X-Google-Smtp-Source: AGHT+IHGea0GcYgHwTyfns+Gbjc96VCytK/MlWJ6eLnRI7wXhhsqJvpZXOqWU9t9P5ymLf199jCDblFoDPX/dn5t31kjaAPaAOx5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2045:b0:476:f1d6:93f4 with SMTP id
 t5-20020a056638204500b00476f1d693f4mr902259jaj.1.1710781099390; Mon, 18 Mar
 2024 09:58:19 -0700 (PDT)
Date: Mon, 18 Mar 2024 09:58:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b7c77e0613f2431f@google.com>
Subject: [syzbot] [bpf?] [net?] WARNING in sock_hash_delete_elem
From: syzbot <syzbot+1c04a1e4ae355870dc7a@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bp@alien8.de, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, hpa@zytor.com, 
	jakub@cloudflare.com, jmattson@google.com, john.fastabend@gmail.com, 
	joro@8bytes.org, kuba@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, pbonzini@redhat.com, 
	peterz@infradead.org, seanjc@google.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, vkuznets@redhat.com, wanpengli@tencent.com, 
	will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17934ffa180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=1c04a1e4ae355870dc7a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111b2e86180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e86649180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0f7abe4afac7/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/82598d09246c/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/efa23788c875/bzImage-fe46a7dd.xz

The issue was bisected to:

commit 997acaf6b4b59c6a9c259740312a69ea549cc684
Author: Mark Rutland <mark.rutland@arm.com>
Date:   Mon Jan 11 15:37:07 2021 +0000

    lockdep: report broken irq restoration

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=133d8711180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10bd8711180000
console output: https://syzkaller.appspot.com/x/log.txt?x=173d8711180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1c04a1e4ae355870dc7a@syzkaller.appspotmail.com
Fixes: 997acaf6b4b5 ("lockdep: report broken irq restoration")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5069 at kernel/softirq.c:362 __local_bh_enable_ip+0x1be/0x200 kernel/softirq.c:362
Modules linked in:
CPU: 0 PID: 5069 Comm: syz-executor295 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
RIP: 0010:__local_bh_enable_ip+0x1be/0x200 kernel/softirq.c:362
Code: 3b 44 24 60 75 52 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 b3 da 25 0a 90 0f 0b 90 e9 ca fe ff ff e8 55 00 00 00 eb 9c 90 <0f> 0b 90 e9 fa fe ff ff 48 c7 c1 9c 6d 87 8f 80 e1 07 80 c1 03 38
RSP: 0018:ffffc9000415f5a0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 1ffff9200082beb8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000201 RDI: ffffffff89642276
RBP: ffffc9000415f660 R08: ffff88807869900b R09: 1ffff1100f0d3201
R10: dffffc0000000000 R11: ffffed100f0d3202 R12: dffffc0000000000
R13: 0000000000000004 R14: ffffc9000415f5e0 R15: 0000000000000201
FS:  000055556fdeb3c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2728b8a9f0 CR3: 000000002d9ee000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 sock_hash_delete_elem+0x1a6/0x300 net/core/sock_map.c:947
 bpf_prog_2c29ac5cdc6b1842+0x42/0x4a
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x206/0x420 kernel/trace/bpf_trace.c:2420
 __traceiter_kfree+0x2d/0x50 include/trace/events/kmem.h:94
 trace_kfree include/trace/events/kmem.h:94 [inline]
 kfree+0x291/0x380 mm/slub.c:4377
 put_css_set_locked+0x6e4/0x940 kernel/cgroup/cgroup.c:951
 cgroup_migrate_finish+0x1bb/0x380 kernel/cgroup/cgroup.c:2691
 cgroup_attach_task+0x7ef/0xac0 kernel/cgroup/cgroup.c:2890
 __cgroup1_procs_write+0x2e4/0x430 kernel/cgroup/cgroup-v1.c:522
 cgroup_file_write+0x2d0/0x6d0 kernel/cgroup/cgroup.c:4092
 kernfs_fop_write_iter+0x3a6/0x500 fs/kernfs/file.c:334
 call_write_iter include/linux/fs.h:2108 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa86/0xcb0 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_64+0xfd/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f2728bca840
Code: 40 00 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d 61 a8 08 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
RSP: 002b:00007ffeba5eea08 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f2728bca840
RDX: 0000000000000001 RSI: 00007ffeba5eea30 RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000001 R09: 00007ffeba5ee837
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffeba5eea30
R13: 00007ffeba5eef70 R14: 0000000000000001 R15: 00007ffeba5eefb0
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
