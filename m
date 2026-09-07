Received: from mail-oa2-f1.google.com (mail-oa2-f1.google.com [74.125.231.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B994A0F02
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788812086; cv=none; b=Sq6dytYtrXXy+JeLsjvw7mR6ZI/Yw4oixIq/8YZEVP8LZRbZpCiUMiOW100225H6a9tDOz2j8dQVZYSIHZfRHKzapOit6QrDVyq5dvGzYnfvbuqVxOsHSwQj5r7Xosk1p1kk2fiRYCwgTUnakz6jkTXKpb8jVyZOCeYOKCLcbHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788812086; c=relaxed/simple;
	bh=7BMajE9wvPZOKedccQH9SJgeUZWmiQesI5OEOBrh9Ng=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MyOuPOeAKY/WEyAhQzvHJx4OTVCVstTo4NjlJYBF/xg9EuQtMQkUghyOl9ilLAPAYUxUm9/kJXspyg6WolMWfstwUmFD60IodRdnZIUFZcRdCS/dWCW6obUWkqPpW4QBAnbhaFOjxwRPo5/EexfNbvoWBvK7vj7Gi71jBTWafG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa2-f1.google.com with SMTP id 586e51a60fabf-4489b7aa0e7so1163384fac.1
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 13:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788812084; x=1789416884;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OWsr3XV5ouWAguKe6ZZXsnYGR5VI84BJ0rXLZL1hjhk=;
        b=NBLTDk/Y+sLD+lRhQfXEoNUcapN8lI9c004YSfuBTIIv4z610MSeD7IJHccsN27U1t
         pf2Lm+LMF2mcSVGgG+VlIpk9REdilqemzzbBdhwbX5yalTMt1wJKx71BYXEtG/oISuVA
         kysdaSvkn3oXjD0W5oWWhwQAVpE9vGgtZrY/78M2Ex82qVOVdeswgOqWpcaRuEjOxQmV
         xQH6mnLd7tNA8oqO5G+dQ2IkPpbjcyXmq+9lMSyfJRgkegBvnw0WBvO6mrtShA4Ngh1t
         hign0aLZOhtYq5hem+vZ3J/Y2s8+IMc1OPJw0A/RQLXVv3Aijgl3RzH1euQ7ctM8U0VX
         bZMg==
X-Forwarded-Encrypted: i=1; AKwUvBz5OAYUDTw/5y5s038Yn6S/x3EFmygYXvnlpi9Be99WHmwId9jqOUqGTrsZ+3J/QL1TK/c=@vger.kernel.org
X-Gm-Message-State: AFuF++nlsiliV2T4We4YA71xl0oyXhAeX4fvyJnf7bZU3LYWl9c982ZI
	KPgpHeXPiiJxosentn4wtmexoaQQI36cMKlVX2Id//PWqeKXdUhbj8yb/zwVmQbJRHCD3nxWHQw
	9ZJ9N+hK47OJr1hO/NTKD9qGV3TVN9LLsg7rjMIaFxtBh8FdHCW/Wt3Gp4FY=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:619:b0:6aa:f7ac:faf3 with SMTP id
 006d021491bc7-6b6fc9d078fmr13829893eaf.19.1788812084387; Mon, 07 Sep 2026
 13:14:44 -0700 (PDT)
Date: Mon, 07 Sep 2026 13:14:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9f1b34.2bb5a69c.24b23c.000c.GAE@google.com>
Subject: [syzbot] [bpf?] WARNING in pcpu_get_vm_areas
From: syzbot <syzbot+442828bb356b10813a47@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, john.fastabend@gmail.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8ab1afb2eb24 Merge tag 'for-7.3/dm-fixes' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=104af0f9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85bc5cc2fc7394d9
dashboard link: https://syzkaller.appspot.com/bug?extid=442828bb356b10813a47
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-8ab1afb2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4767b33b6704/vmlinux-8ab1afb2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aa0bdf390bbc/bzImage-8ab1afb2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+442828bb356b10813a47@syzkaller.appspotmail.com

------------[ cut here ]------------
unlikely(ret)
WARNING: mm/vmalloc.c:5110 at pcpu_get_vm_areas+0x12b1/0x56c0 mm/vmalloc.c:5110, CPU#0: syz.3.1809/13474
Modules linked in:
CPU: 0 UID: 0 PID: 13474 Comm: syz.3.1809 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:pcpu_get_vm_areas+0x12b1/0x56c0 mm/vmalloc.c:5110
Code: 08 48 83 84 24 c8 00 00 00 08 41 39 ef 0f 84 76 1b 00 00 89 6c 24 70 e9 58 fb ff ff 4c 8b bc 24 f0 00 00 00 e8 70 78 a0 ff 90 <0f> 0b 90 e8 67 78 a0 ff 8b 5c 24 70 31 ff 89 de 8d 6b ff e8 c7 72
RSP: 0018:ffffc90002ee75a0 EFLAGS: 00010287
RAX: 000000000006dea5 RBX: dffffc0000000000 RCX: ffffc90007131000
RDX: 0000000000080000 RSI: ffffffff826ac3c0 RDI: ffffffff8e6b7920
RBP: 0000000000000000 R08: 00000000ffffffff R09: fffffbfff1dffc3a
R10: ffffffff8effe1d3 R11: 0000000000000000 R12: ffff888060404a90
R13: ffffe8ffff000000 R14: dffffc0000000000 R15: ffffe8ffffe00000
FS:  0000000000000000(0000) GS:ffff888096967000(0063) knlGS:00000000f544db40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f542cda4 CR3: 000000006f19b000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 pcpu_create_chunk+0x275/0x750 mm/percpu-vm.c:363
 pcpu_alloc_noprof+0x1923/0x1e50 mm/percpu.c:1852
 bpf_map_alloc_percpu+0x9a/0xf0 kernel/bpf/syscall.c:583
 bpf_array_alloc_percpu kernel/bpf/arraymap.c:39 [inline]
 array_map_alloc+0x553/0x750 kernel/bpf/arraymap.c:153
 map_create_alloc kernel/bpf/syscall.c:1534 [inline]
 map_create+0x874/0x30d0 kernel/bpf/syscall.c:1644
 __sys_bpf+0x12a0/0x4a30 kernel/bpf/syscall.c:6344
 __do_sys_bpf kernel/bpf/syscall.c:6486 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6483 [inline]
 __ia32_sys_bpf+0xcc/0x170 kernel/bpf/syscall.c:6483
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
 __do_fast_syscall_32+0x13a/0x8b0 arch/x86/entry/syscall_32.c:291
 do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:316
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf705efec
Code: Unable to access opcode bytes at 0xf705efc2.
RSP: 002b:00000000f544d50c EFLAGS: 00000292 ORIG_RAX: 0000000000000165
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000080000000
RDX: 0000000000000050 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
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
