Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55D3421F00
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 20:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084946; cv=none; b=NLFWhHxwKu61gfIJTuC3S9Uqg2Se99WtvWzQcwfVNRL7a0B+k2BRPimbUgPAhvtf+t8pFIRK5OtlsDI7m2GEnVUzv6UNKcMpaCjYXbky7UjL9LUc8xAOi2deR5riJObNYrZC6JXF0tCiS+9oML4QUqu89fm2BphxKlefqiPhJ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084946; c=relaxed/simple;
	bh=36pvJI2EdJhkTQBy4qCd3lBM+ogk4wlWt5gfbl9NROo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=k92BPgAYytDl56K8tj7IkleQ0PdnZR20jIJkRgxNjMH2/UMunvFIrRMStN7f7wIOHrL+4oNws0z8bbJtUgnMOwucqumc3k4aWZiFG47ke/wJWA2hbgiHFBabgiJ/IBbqzjvph3pVUsbFUlMwtSKhL60YOtbFp/icYoyHja06LY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-69da2d033c9so4698846eaf.0
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 13:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084941; x=1780689741;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Re8Ao6xRktM8Jt8hhQFwSTQo2GqEds4059tntsAG90=;
        b=VFGJZwUo1InPtwnztImUFVm/JsCkhOnKg/4VqI6vBblEolz5zRhMyrlTQ6Id6G/Iw8
         XwGr38jV/uVTPvlid+6z7mJWrgGwveTBLwRSbvC/0/0q7kLqx5BEBEDNCdsC/rYFlB6u
         ziAg1dgDJz495eGa9yjvxtpU9lsMB6ynrjO99E+TkDgXPepjI2kipprb+dNRp8zu5Q2E
         y1+8L5wjBFHiw8ERSfloBxExrLsIOqOHTTy80gH52ol1XX5wQ7f4SXn88ndciSeE074s
         rzcb2sXfIzuTZxnELaQ5bplPO01sBLv/Nl5geM344ev4Vf/asomKPWcedqTLTmqrcDf0
         d6pQ==
X-Forwarded-Encrypted: i=1; AFNElJ8fRw2mG5qRbWDsqB5+LYNYXYAQZqv5rqxYSP9CY4qGw5pvJo96sNROMmA2dRyScOtm/Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDjNt752xRfxQ21ZHA0PkT7lqQJYZ3fwGA/FXpPS0dZQo1rhqO
	tKu0nvOLck4PcWlFvLsN6NZiVZOWQrPxiBJFKI0zqu3LcBYxdZqM4yPR5+VVKUXqejIgq0sUcde
	IAmL78a0NYk63qeQszNQ6vlnPGKHrC6WrX6py4oJO4DioMPcXP4ffHulvqBo=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1792:b0:69b:5f97:de79 with SMTP id
 006d021491bc7-69e102e7ccdmr450510eaf.19.1780084941593; Fri, 29 May 2026
 13:02:21 -0700 (PDT)
Date: Fri, 29 May 2026 13:02:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a19f0cd.5099cdd9.8e407.0002.GAE@google.com>
Subject: [syzbot] [bpf?] KMSAN: uninit-value in __arg_track_join
From: syzbot <syzbot+0098eed2cc898cdd672f@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d60ec36cab33 Merge tag 'mm-hotfixes-stable-2026-05-25-16-2..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=116ac6ec580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=334b75e012487335
dashboard link: https://syzkaller.appspot.com/bug?extid=0098eed2cc898cdd672f
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7e228ea8db12/disk-d60ec36c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/83407360a5fe/vmlinux-d60ec36c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9e10d0866b6f/bzImage-d60ec36c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0098eed2cc898cdd672f@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __arg_track_join+0x15a/0x810 kernel/bpf/liveness.c:743
 __arg_track_join+0x15a/0x810 kernel/bpf/liveness.c:743
 arg_track_join+0x186/0x870 kernel/bpf/liveness.c:784
 compute_subprog_args kernel/bpf/liveness.c:1623 [inline]
 analyze_subprog+0x3eb0/0xff30 kernel/bpf/liveness.c:1799
 bpf_compute_subprog_arg_access+0x3ee/0x2370 kernel/bpf/liveness.c:1937
 bpf_compute_live_registers+0xfdb/0x3090 kernel/bpf/liveness.c:2149
 bpf_check+0x5bcb/0x9360 kernel/bpf/verifier.c:20065
 bpf_prog_load+0x28d2/0x2d00 kernel/bpf/syscall.c:3082
 __sys_bpf+0x8e0/0xee0 kernel/bpf/syscall.c:6274
 __do_sys_bpf kernel/bpf/syscall.c:6387 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6385 [inline]
 __ia32_sys_bpf+0xa4/0xf0 kernel/bpf/syscall.c:6385
 ia32_sys_call+0x33e7/0x4360 arch/x86/include/generated/asm/syscalls_32.h:358
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0x195/0x470 arch/x86/entry/syscall_32.c:307
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/syscall_32.c:332
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:370
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Local variable old created at:
 arg_track_join+0x86/0x870 kernel/bpf/liveness.c:783
 compute_subprog_args kernel/bpf/liveness.c:1623 [inline]
 analyze_subprog+0x3eb0/0xff30 kernel/bpf/liveness.c:1799

CPU: 0 UID: 0 PID: 18676 Comm: syz.0.5880 Tainted: G        W           syzkaller #0 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
=====================================================


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
