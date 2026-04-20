Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BB537E31E
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776694412; cv=none; b=kddngaYIQFbXdAYAj+VF7icyuvw3YYTgYObhHB1qOOp0ENSeHn91LEV1lJ5QcUr4f2yUiMJDZ6sZCYvt46kwoGJwoWYsNfDFq2ufEkcwWnGuDBvCWqyPhHJ7VqhKk4K0DI0xgd27XUothwAwfy27O2s77wzdU5/KewA87Dp3+2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776694412; c=relaxed/simple;
	bh=4P7tjYeFwzDriQN7839r2lcY7V+saoSEVnCBR8gEMj0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WALTjRte2Jn1gIqH79ysTfVjMZAAgI5223KcAjQXFWjwybNEmGqhhJaUFWsKE/RO8BtRKVGqO0GUp2NRhF2r5TM8jz5wqUmHC+VkIUooElBYLvR52m8mhb3iJdP0rNAU/rO6RJJvdPyqvK04I9HesqfLB6ItNF5265cSd0fIjHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-409037c3f0bso2167537fac.1
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 07:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776694410; x=1777299210;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pz5IG1ReLdvDb8TqqFXwRlQy6RDGxX98ZSQADPiXJ2I=;
        b=MsrprG1DSckHaHLV+k1uWzrx/RLElUjrXU6AEEuzIrON7DoXmA5qKtO889HFvH+igH
         gcyqksP8OixtCnKvbScMwPfab2d9W9gMrFfOihHpPdDk4OamG6rK3iGnzGk0b/s7t9dX
         JrWfC2CWAzSkv1DSMb2swOYMCC8aX1anmhGYeBbyVgefRE5QLMUtjyqDskKmQ3mtjfbY
         aDyFdTWoE/Wbo+WMZ4ZpS143ORpIhVcKbeiNshceugrKRPwcg1tsRXOZWxLpqLM3TOwi
         /XEYp5XWwpVF0vTxAQrxi/aDcHjZjd+NmbWaFAsYi6tbtcblERcjTP3xy+K9a2zrWKSZ
         ryTw==
X-Forwarded-Encrypted: i=1; AFNElJ8px4iWOGidddl456Sy6PQsnI1kwLZpDChr7dRCOgFz4b1W0ZiNge15dmUCQ9S/vyoylts=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKHs3Do1KtO6scKxDrmoH29o9n1fSmAmUPq9gkn7v2rzvTdD95
	qHetZdGgVOazyvAJzUT3OWx2cs8A8Qc9l4NAXHXP8MdfW/RvyqnH/5/t85gJHoeFykANJyZuXZO
	uEikDzskmYeb/cYkoqA9J5pTlm/CdeM8lzfCt1tVgWWLp5EL8zs+iWleJL6E=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2083:b0:67b:bd89:90ed with SMTP id
 006d021491bc7-69462f0f2c2mr7857438eaf.41.1776694409738; Mon, 20 Apr 2026
 07:13:29 -0700 (PDT)
Date: Mon, 20 Apr 2026 07:13:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e63489.a00a0220.17a17.0005.GAE@google.com>
Subject: [syzbot] [bpf?] KCSAN: data-race in bpf_obj_memcpy / bpf_obj_memcpy
From: syzbot <syzbot+44044637ef892e79ca2b@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c1f49dea2b8f Merge tag 'mm-hotfixes-stable-2026-04-19-00-1..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10ec34ce580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d3740f7f69b18f59
dashboard link: https://syzkaller.appspot.com/bug?extid=44044637ef892e79ca2b
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4ed91de40e47/disk-c1f49dea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7353bf53627b/vmlinux-c1f49dea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab6db1fcd59d/bzImage-c1f49dea.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+44044637ef892e79ca2b@syzkaller.appspotmail.com

netlink: 676 bytes leftover after parsing attributes in process `syz.4.735'.
==================================================================
BUG: KCSAN: data-race in bpf_obj_memcpy / bpf_obj_memcpy

write to 0xffffe8ffffa24c00 of 1404 bytes by task 6603 on cpu 0:
 bpf_obj_memcpy+0x13c/0x1a0 include/linux/bpf.h:-1
 copy_map_value include/linux/bpf.h:557 [inline]
 bpf_percpu_array_update+0x1e1/0x2d0 kernel/bpf/arraymap.c:443
 bpf_map_update_value+0x260/0x570 kernel/bpf/syscall.c:275
 generic_map_update_batch+0x52d/0x680 kernel/bpf/syscall.c:2025
 bpf_map_do_batch+0x25c/0x380 kernel/bpf/syscall.c:5689
 __sys_bpf+0x6a2/0x7e0 kernel/bpf/syscall.c:-1
 __do_sys_bpf kernel/bpf/syscall.c:6361 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6359 [inline]
 __x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6359
 x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

write to 0xffffe8ffffa24c00 of 1404 bytes by task 6604 on cpu 1:
 bpf_obj_memcpy+0x13c/0x1a0 include/linux/bpf.h:-1
 copy_map_value include/linux/bpf.h:557 [inline]
 bpf_percpu_array_update+0x1e1/0x2d0 kernel/bpf/arraymap.c:443
 bpf_map_update_value+0x260/0x570 kernel/bpf/syscall.c:275
 generic_map_update_batch+0x52d/0x680 kernel/bpf/syscall.c:2025
 bpf_map_do_batch+0x25c/0x380 kernel/bpf/syscall.c:5689
 __sys_bpf+0x6a2/0x7e0 kernel/bpf/syscall.c:-1
 __do_sys_bpf kernel/bpf/syscall.c:6361 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6359 [inline]
 __x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6359
 x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 6604 Comm: syz.4.735 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
==================================================================


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
