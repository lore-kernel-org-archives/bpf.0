Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935DE64AB3
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800220; cv=none; b=ZKKmTE+R+MeKNN3VcfKvCImvVWcIIP2K7DqIUDezaDip8mZltK8wBt5RKlRf+4Rp2DulP9LDfYhKE55BBJZRtA/nu4T82LuwEyaKkbmrmck5RgDTVGhcA96CQ6LFXm3t3PvHNxGggdqYeDwDBhUl0Hv3E6zV71iCKIaDtPvL4S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800220; c=relaxed/simple;
	bh=0fAYZVzkNANajbEox82PcleCjcFCVD2kAiceHZsNeew=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LWkIf4yYWq7TdCCAynu1U8foP0MIG9a7r0I6ebRs8LFh8keLJk+OdBGfZDcy/Ai57f2YUslnVBiCeoQIi//9hfcwrRVEK6C91fy8A1BVpU8Es1SKRQzddZ0OdrGO07L0LKk/tFosEsdPrJCJqD/xt+6cLuIC3b/2x5HHAHP+gfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c83b5361feso66188939f.1
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 00:30:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709800218; x=1710405018;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kOU1DI7iQ5eXeV3YAuu9M3eSVDmwHwlQYz6+06CcSoM=;
        b=L+0XSfXIZAESgLjPadlqgT9tBdZRNshM40TBEddaCCdrHMQYnuFz7VkZZsKa3zRF4I
         o6V9Ea3gBPgEIf+ZMnLy9HEHmvzRKfqoa4bZCpV4LUN6O2xdMIt9hNmzssJDcnVfV3P/
         tVcVfxXq/r05G5FGLcugrkWBz7P9R5qeFEC1AFNVHn/cRULh4qj18zchi8HjNGQy+SGJ
         +NkUtl1qTp7RFWlbPD58N29zjbh4daucFoC2KJnCF8Jmu1NXYBTtHiHu+tABUaw2QkDA
         80SE6odt9ow0mG6vmL3kVSdimdejXSmPxZZkzzcCcy/LJFpdDEZuCIA8arVR8G1BudHK
         YikQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8NwMskEQDyUr3wH/kRKuKfzCLXMFcHrx68z2KoOFSd/Iaa3TeU7mLzfoQ7/mAxeKdWA0ret1BIEaBxEoMMDefAohG
X-Gm-Message-State: AOJu0Yyoy2VJ4AvQkZrVsADrJ9mr4S3RGTKwvWUINCOrJaF8UCnRYC3P
	iVxacUuDIP86ISJBOcHrMNTIqrxaAn2RNqAuNU1Wyxt7C6jhbCD+D2oD6aynhUkg2jaettFxHtC
	4A18G+98aznWuoiVvR8JCp9q3vEliSjye0AXhyS7wocKJAi9C/YvO684=
X-Google-Smtp-Source: AGHT+IGxje5CvjesTv569fcM4amnpaVbp5+6kcuhA3pdKJql1WDwPUd6qNa+669L7vRC8jMZ+dgpqeDH3mIt0EXsiXok97fTAryj
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:16ca:b0:474:c490:d051 with SMTP id
 g10-20020a05663816ca00b00474c490d051mr368161jat.3.1709800217762; Thu, 07 Mar
 2024 00:30:17 -0800 (PST)
Date: Thu, 07 Mar 2024 00:30:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e2ff406130de279@google.com>
Subject: [syzbot] [bpf?] KMSAN: uninit-value in strnchr
From: syzbot <syzbot+9b8be5e35747291236c8@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    04b8076df253 Merge tag 'firewire-fixes-6.8-rc7' of git://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10bb9306180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=80c7a82a572c0de3
dashboard link: https://syzkaller.appspot.com/bug?extid=9b8be5e35747291236c8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11093316180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a53082180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a4610b1ff2a7/disk-04b8076d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/991e9d902d39/vmlinux-04b8076d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a5b8e8e98121/bzImage-04b8076d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b8be5e35747291236c8@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in strnchr+0x90/0xd0 lib/string.c:388
 strnchr+0x90/0xd0 lib/string.c:388
 bpf_bprintf_prepare+0x1c2/0x23b0 kernel/bpf/helpers.c:829
 ____bpf_trace_printk kernel/trace/bpf_trace.c:385 [inline]
 bpf_trace_printk+0xec/0x3e0 kernel/trace/bpf_trace.c:375
 ___bpf_prog_run+0x2180/0xdb80 kernel/bpf/core.c:1986
 __bpf_prog_run32+0xb2/0xe0 kernel/bpf/core.c:2225
 bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 bpf_test_run+0x482/0xaf0 net/bpf/test_run.c:423
 bpf_prog_test_run_skb+0x14e5/0x1f20 net/bpf/test_run.c:1056
 bpf_prog_test_run+0x6af/0xac0 kernel/bpf/syscall.c:4107
 __sys_bpf+0x649/0xd60 kernel/bpf/syscall.c:5475
 __do_sys_bpf kernel/bpf/syscall.c:5561 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5559 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5559
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Local variable stack created at:
 __bpf_prog_run32+0x43/0xe0 kernel/bpf/core.c:2225
 bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 bpf_test_run+0x482/0xaf0 net/bpf/test_run.c:423

CPU: 0 PID: 5019 Comm: syz-executor938 Not tainted 6.8.0-rc6-syzkaller-00250-g04b8076df253 #0
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
