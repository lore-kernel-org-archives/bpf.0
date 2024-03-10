Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21841F513
	for <bpf@vger.kernel.org>; Sun, 10 Mar 2024 09:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710062185; cv=none; b=McR6lqqjwRS3mgTG/CziVZib+LWCNr4k2S+xKr6tfbBezQFdPAzKQ5IcIAkCsYyS9M7xaVm52bbOAHSv4jv2vdSMfhOlzOL1ywEXqOqV8Sw0mA6m8Rg7OcXCIokEnr+4NFGyXMMnQWcQfp+83tka5w0AHmwCPBrNQ7yeuUMbn2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710062185; c=relaxed/simple;
	bh=MlagqZPBrdWvUGmaWGdhxE6Ng+8nES7zjq8PZhu+dW0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=acC9EXE7l+blkbDKGS4KA/V0dBNtq6OkvYkXgfwEnlUjFzBKpzZ9ayZNDhuVULTOiuqzBmX/2Ov54fC8uprGqefU/IkXIwt8oFF4+NUAY4qae406fiHlfjXxb3TRsk1b2mDwIh4xUcLMP01fsFRLQ/xPM1XZydzszOV5I5MsIkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c8a960bd9eso56606739f.0
        for <bpf@vger.kernel.org>; Sun, 10 Mar 2024 01:16:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710062183; x=1710666983;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5zDRQjgkhxRVicgj40VR0YIXpagwtpa9TQqkcBjGwTE=;
        b=J+FAbloLbpZHLIj+yWBz+Fq1UVVxWjfHUbdkQ62hg9uwrT2Z6BDAhkF7hEfpzyRGOg
         SCU8FnoK5E/sImJmrNodJS3UwS8qkWrxvvY+Oh46NPYDJe33VlVzmCI6BAKqzJK0lzBe
         cdtjxgJYEvnGr4U7bsIyVZx/Flc/uFj00iPKfxVQ4b73YEGJzCovu2Hb4w8m5r0lkR/g
         20nogLUiMnRdxTwN9h9Nw/OApiqRcyfxbh0EPV0+Lvze1Nhr6coufkGXK8vsv/6tgrq0
         KDHlyble98ASUTE6idHJnsY9/miDEX5TI8LcTrG/KiHF3/+dZwcP09S4WPlShHfY+U0G
         BHNw==
X-Forwarded-Encrypted: i=1; AJvYcCWdI/mlIBcNmDUI85zkeu4HPBcO9hGIZNsncaqQ2O6AJABIBIV9vQBVy1fDesJSDw2uiFBejN8xzTb5ZnDEIkoNfTpg
X-Gm-Message-State: AOJu0YxgVwJBYjd0IOODCsWdPX1LspdU6upg7xVlyNV3GqMbw1ubHyDy
	fAO3qRbIrhG1E4zcbv3zCDZigWyPGJmh1MfwH3pC7gGQYGJS3sXVG1RSrg/0GDvQMMrOXDzyVbC
	bkuwPLt/EPbXTMYY+PJ+QxMOY2VoNEaOPf1w6pj+ZtLZMSZd7OYEREow=
X-Google-Smtp-Source: AGHT+IHHKgN8BmBXtWcmcpRxGbXFfnt/P3gNEMVRNNGsEyS+NN4qwWDDqY3mLY75SrShvLCcc1t4pjRetlQ/ZgalTKy0i1RsYaYD
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:218b:b0:476:e4c4:c80e with SMTP id
 s11-20020a056638218b00b00476e4c4c80emr25604jaj.6.1710062183319; Sun, 10 Mar
 2024 01:16:23 -0800 (PST)
Date: Sun, 10 Mar 2024 01:16:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb15d306134ae036@google.com>
Subject: [syzbot] [bpf?] [net?] KMSAN: uninit-value in bpf_prog_test_run_xdp
From: syzbot <syzbot+6856926fbb5e9b794e5c@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, netdev@vger.kernel.org, pabeni@redhat.com, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3aaa8ce7a335 Merge tag 'mm-hotfixes-stable-2024-03-07-16-1..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13e5861e180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8d2f8f66e9a667a
dashboard link: https://syzkaller.appspot.com/bug?extid=6856926fbb5e9b794e5c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10ed8171180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b728ae180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2a093f1b5a72/disk-3aaa8ce7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/efa5cb929ca6/vmlinux-3aaa8ce7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2b0c044e721b/bzImage-3aaa8ce7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6856926fbb5e9b794e5c@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in bpf_prog_test_run_xdp+0x1758/0x1a30 net/bpf/test_run.c:1277
 bpf_prog_test_run_xdp+0x1758/0x1a30 net/bpf/test_run.c:1277
 bpf_prog_test_run+0x6af/0xac0 kernel/bpf/syscall.c:4107
 __sys_bpf+0x649/0xd60 kernel/bpf/syscall.c:5475
 __do_sys_bpf kernel/bpf/syscall.c:5561 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5559 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5559
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 bpf_test_run+0x515/0xaf0
 bpf_prog_test_run_xdp+0xea5/0x1a30 net/bpf/test_run.c:1267
 bpf_prog_test_run+0x6af/0xac0 kernel/bpf/syscall.c:4107
 __sys_bpf+0x649/0xd60 kernel/bpf/syscall.c:5475
 __do_sys_bpf kernel/bpf/syscall.c:5561 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5559 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5559
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 ___bpf_prog_run+0x76dd/0xdb80
 __bpf_prog_run512+0xb5/0xe0 kernel/bpf/core.c:2227
 bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_test_run+0x42d/0xaf0 net/bpf/test_run.c:421
 bpf_prog_test_run_xdp+0xea5/0x1a30 net/bpf/test_run.c:1267
 bpf_prog_test_run+0x6af/0xac0 kernel/bpf/syscall.c:4107
 __sys_bpf+0x649/0xd60 kernel/bpf/syscall.c:5475
 __do_sys_bpf kernel/bpf/syscall.c:5561 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5559 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5559
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 ___bpf_prog_run+0x8567/0xdb80
 __bpf_prog_run512+0xb5/0xe0 kernel/bpf/core.c:2227
 bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_test_run+0x42d/0xaf0 net/bpf/test_run.c:421
 bpf_prog_test_run_xdp+0xea5/0x1a30 net/bpf/test_run.c:1267
 bpf_prog_test_run+0x6af/0xac0 kernel/bpf/syscall.c:4107
 __sys_bpf+0x649/0xd60 kernel/bpf/syscall.c:5475
 __do_sys_bpf kernel/bpf/syscall.c:5561 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5559 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5559
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Local variable stack created at:
 __bpf_prog_run512+0x45/0xe0 kernel/bpf/core.c:2227
 bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_test_run+0x42d/0xaf0 net/bpf/test_run.c:421

CPU: 0 PID: 5009 Comm: syz-executor369 Not tainted 6.8.0-rc7-syzkaller-00142-g3aaa8ce7a335 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
=====================================================


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
