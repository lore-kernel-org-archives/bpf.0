Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043DB282F1F
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 01:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787189617; cv=none; b=J1M2nfK4rKxvB/Xh268MblgtKD9czuBx4UdPststBFzAh7aM5Pmsogfhhq7bh+iAHuu0JB/bevLkY4p6JcURveg2Z34Zf4xUJW7+Q6MTL2YpD51kWdqERVIjHObbuWZfjUoSEFW58Dk7wp/pWZwii0CqifwM145mFgPPJO55bRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787189617; c=relaxed/simple;
	bh=HecCHWRTRIpMgpE3/xm4LT5FKbed6+kdrrbMAArklok=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MHGhvngCDRTFKQ4Yg32Q9U6Xtp9nIkJAfFn6oeUhwvn8Z99aMsw3TT1LZQK06XcSaNfozy5Anb+XhwItSUKQ+DMJS6GueoylDSqQWIfV3nIt9gGKzTMrLOnSidpXrpgCVoEz8x4AvVDPlFtjGdOW5FVYmYOVS1yHFIKYWLihAOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-4ab7bb257bbso1726968b6e.0
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 18:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787189610; x=1787794410;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+kxloYZBBdq+m0W3SA/Re27+lBVZgsgMvtrM7lv9M/Q=;
        b=o2gSgYnQTeZlVIT1wGzSHQgmzc4w6Wyp3gdzA+M6AdEJtlzkHvLoF6lRZh5ie21ZDR
         PV1ZHAmCAEBIqR944agSTGOGQfjGVE3d/JYybyG8J3LOQAlop0AmJrOGs17nGwnDHgkR
         plgSKXCaUDEqQ2bKHEOqripueqrpbWwvWQMavcA/goSV49V+pbp/rz/by1PqT7iYh1y4
         /FbgknYjY4HGnWCcfeolpIuBaLASeSl4CY0yNv4LcO1uKnHuY7PhDQHOPhrmmji4UKVS
         4TLUC2yCIWIdqqvaJJP4RRBuwy+D3Z5R0Ib7B0q0wBglZ76aitRAx+PDyy73OaeA55y9
         dG/g==
X-Forwarded-Encrypted: i=1; AHgh+RoXzqmbMBJUcibIQ9+SO24Id8DiviYwCLkgej1h2p6gQAW3rcWO1n8Wi2WTGzvJzShyd98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzni5pJ4XunMcsSGmh3rISHFW5H6EQrV/nS/3SSlluDnDI5XFz
	tI7Z8iiGRmHqurM3qVL5cTGYbvgp8ftfrDFluxHQ6Y2ZEGoEXZ5ZgJtDxM+N3vgrHqYpGM4n3Zi
	ucxJWpHx6OypDSym6A5uZit+nM0QCkW12kSlcFtu/gFo01hULGXAK6TdY8jo=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c183:b0:496:11f1:f2b3 with SMTP id
 5614622812f47-4b2bcb6de00mr9172659b6e.20.1787189610464; Wed, 19 Aug 2026
 18:33:30 -0700 (PDT)
Date: Wed, 19 Aug 2026 18:33:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a86596a.ae6ddae5.3da009.0015.GAE@google.com>
Subject: [syzbot] [bpf?] UBSAN: array-index-out-of-bounds in print_bpf_insn (2)
From: syzbot <syzbot+3544d9b2a9206be8ba37@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, netdev@vger.kernel.org, 
	qmo@kernel.org, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c93cbdb13f99 selftests/bpf: Add ksock test for async callb..
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=104b9279580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca5f2f2c4197664
dashboard link: https://syzkaller.appspot.com/bug?extid=3544d9b2a9206be8ba37
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a1aa25580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15019a79580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1714feee6e8f/disk-c93cbdb1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/74187e85e93c/vmlinux-c93cbdb1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b18812cc3696/bzImage-c93cbdb1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3544d9b2a9206be8ba37@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in kernel/bpf/disasm.c:306:6
index 3 is out of range for type 'const char *const[3]'
CPU: 0 UID: 0 PID: 5622 Comm: syz-executor350 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
 __ubsan_handle_out_of_bounds+0xe8/0xf0 lib/ubsan.c:455
 print_bpf_insn+0x21f1/0x2910 kernel/bpf/disasm.c:306
 format_disasm_line kernel/bpf/diagnostics.c:633 [inline]
 diag_print_insn_context+0x433/0xd00 kernel/bpf/diagnostics.c:783
 bpf_diag_source+0x66a/0x1950 kernel/bpf/diagnostics.c:-1
 bpf_diag_program_structure+0x31c/0x430 kernel/bpf/diagnostics.c:1211
 check_subprogs+0x66b/0x740 kernel/bpf/verifier.c:3049
 bpf_check+0x17ba/0x2e10 kernel/bpf/verifier.c:21099
 bpf_prog_load+0x14d6/0x1c20 kernel/bpf/syscall.c:3133
 __sys_bpf+0xd0d/0xd90 kernel/bpf/syscall.c:6367
 __do_sys_bpf kernel/bpf/syscall.c:6486 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6483 [inline]
 __x64_sys_bpf+0xba/0xd0 kernel/bpf/syscall.c:6483
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe861ccec79
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe8118b7b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffe8118b8f8 RCX: 00007fe861ccec79
RDX: 0000000000000094 RSI: 0000200000000180 RDI: 0000000000000005
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe8118b8e8
R13: 0000000000000002 R14: 00007fe861d5fca0 R15: 0000000000000002
 </TASK>
---[ end trace ]---


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
