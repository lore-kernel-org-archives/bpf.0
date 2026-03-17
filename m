Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447E418DF80
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 06:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773729929; cv=none; b=iMvOgGVo4RJbGraiuJZp9Zi7E+31IoKAq3dGjbS7g5Ks+n86KduuQTzLINyLJntmsZ3ItcFLgg6hWogoR/SO7m4I7Vc3uF6aBsfRDhsw+1FJMcNbx2je3swcGWJsTpCcXjgTc7GhSzETcWjwk+6M+HMfj8nSnMBmva/jl2s+2Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773729929; c=relaxed/simple;
	bh=eCltHj+sgIdcXlPYytEKIh8BC/I9WRYg9BnKr1CWv48=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=r8XTF1mpGrW+D8rwhDE9zM6dLH2idBmfhFVThZskadFnnfvrltDRN14w+7Axwb5DpktS4Tq57hmLE0ZeCcGpRcr8zW71lYdPLpmfe4igWhBwTXkNFvHwNkQFTe9uyN/5GYtKMJCV3WWeb/21Tw48wVoHc7qkPaDQ8tpIOBzi11Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-462a9191720so45408370b6e.0
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 23:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773729927; x=1774334727;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s6k5CkXKaRc4maaLtQmUxhWy3CgmnUs3ms4F8LJfuP8=;
        b=Q8mclqb1lSKfUij2KUp8I+xwFAfruqgJ0035I/c8IW89RObFqQWY7jYO4TKUJaK2ss
         iu2QCyfn1ic1ibU/5oM/O0wNRohpW1XelMDxvbQtd4EHg0ZgxErJtVbe5PqOUmUnQCbN
         wbGfesr6Wch8gz2WoZukeX6iLgOhIjpDFWvoXRwf3FkLAMWlO5wh6gaK6R4g86K6K5iu
         BM29IfQ86Idcb0H/y4ga0HD5cIyWepEjXf6hi2NQ7mYV5C3tPAM+y/LILbwqx7v5r6qR
         kt/V6L6rvzJVjBl5Bb8xJ6yqiaRM7W3SU7liZPrea3RnfE4JCqEwbxbdTDPLjiF10LGn
         jV+g==
X-Forwarded-Encrypted: i=1; AJvYcCU68oGBthnm+2YVU14tc10eIqSewPbFOVFFhi4Wq6PbhNGT1JwI5og1HFo+BWqixbD7nvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcVtf4PqMBGPRZzmMiZj7nBbaITCRNOGWnVgr4KUX/ywewmEit
	tE+3SpJORhuSkURd/mUEsCRDZaIXn7aF8UfQE1Xc7fmpN/eC3EIxzt0XN7HADGZeNGoV3sVgEf0
	OGRjdtuLCMgBVjUFXkTJpGgE/LPDmNbpSJERmiJa/k6eyQ+OZq3pI1YsPSw8=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c14c:b0:467:1880:ffb9 with SMTP id
 5614622812f47-467572d39bamr9428527b6e.40.1773729927311; Mon, 16 Mar 2026
 23:45:27 -0700 (PDT)
Date: Mon, 16 Mar 2026 23:45:27 -0700
In-Reply-To: <69343e08.a70a0220.38f243.002c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69b8f887.050a0220.248e02.0127.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in handle_bug
From: syzbot <syzbot+ba80855313e6fa65717a@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    2d1373e4246d Merge tag 'for-7.0-rc4-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=146bc4da580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=963de479f54c6dbb
dashboard link: https://syzkaller.appspot.com/bug?extid=ba80855313e6fa65717a
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b4a8da580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16773406580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bef78207d3f7/disk-2d1373e4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/35fd28ca5034/vmlinux-2d1373e4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c2b759faae9e/bzImage-2d1373e4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ba80855313e6fa65717a@syzkaller.appspotmail.com

------------[ cut here ]------------
=====================================================
BUG: KMSAN: uninit-value in vsnprintf+0x15be/0x1b00 lib/vsprintf.c:2912
 vsnprintf+0x15be/0x1b00 lib/vsprintf.c:2912
 vprintk_store+0x350/0x1550 kernel/printk/printk.c:2307
 vprintk_emit+0x2c8/0xba0 kernel/printk/printk.c:2455
 vprintk_default+0x3f/0x50 kernel/printk/printk.c:2494
 vprintk+0x36/0x50 kernel/printk/printk_safe.c:82
 __warn_printf lib/bug.c:190 [inline]
 __report_bug+0xa10/0xe00 lib/bug.c:244
 report_bug_entry+0x17c/0x220 lib/bug.c:269
 handle_bug+0xe5/0x230 arch/x86/kernel/traps.c:430
 exc_invalid_op+0x1f/0x50 arch/x86/kernel/traps.c:489
 asm_exc_invalid_op+0x1f/0x30 arch/x86/include/asm/idtentry.h:616
 reg_bounds_sanity_check+0x571/0x14e0 kernel/bpf/verifier.c:2817
 reg_set_min_max+0x34b/0x450 kernel/bpf/verifier.c:17159
 check_cond_jmp_op+0x3bf5/0x5370 kernel/bpf/verifier.c:17609
 do_check_insn kernel/bpf/verifier.c:21168 [inline]
 do_check+0xc7e8/0x1add0 kernel/bpf/verifier.c:21308
 do_check_common+0x2705/0x4270 kernel/bpf/verifier.c:24650
 do_check_main kernel/bpf/verifier.c:24733 [inline]
 bpf_check+0x1f159/0x27e90 kernel/bpf/verifier.c:26056
 bpf_prog_load+0x2b41/0x3140 kernel/bpf/syscall.c:3089
 __sys_bpf+0x8e0/0xee0 kernel/bpf/syscall.c:6228
 __do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
 __x64_sys_bpf+0xa4/0xf0 kernel/bpf/syscall.c:6339
 x64_sys_call+0x13d0/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x134/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 vsnprintf+0x15b7/0x1b00 lib/vsprintf.c:-1
 vprintk_store+0x350/0x1550 kernel/printk/printk.c:2307
 vprintk_emit+0x2c8/0xba0 kernel/printk/printk.c:2455
 vprintk_default+0x3f/0x50 kernel/printk/printk.c:2494
 vprintk+0x36/0x50 kernel/printk/printk_safe.c:82
 __warn_printf lib/bug.c:190 [inline]
 __report_bug+0xa10/0xe00 lib/bug.c:244
 report_bug_entry+0x17c/0x220 lib/bug.c:269
 handle_bug+0xe5/0x230 arch/x86/kernel/traps.c:430
 exc_invalid_op+0x1f/0x50 arch/x86/kernel/traps.c:489
 asm_exc_invalid_op+0x1f/0x30 arch/x86/include/asm/idtentry.h:616

Local variable pflags created at:
 try_charge_memcg+0x63/0x1c20 mm/memcontrol.c:2367
 obj_cgroup_charge_pages+0x69/0x330 mm/memcontrol.c:2857

CPU: 1 UID: 0 PID: 5997 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
