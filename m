Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529A515A48B
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078545; cv=none; b=OMYdPnlJbacJHOldhXxYVp2zrruSUcpjDrwoS8kceBhiCRfzJ05TgtCl6F6tbN6ogjkoBbKWUjA5FYhf1ZQTv9640JI9HuI7262zYdc0fL+mx3KZQAzXBLuWc2aDSRkrC9B0UEmTNJU0LoSHBUGXNIVrrIrI2zuyQIpm8Jn2+Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078545; c=relaxed/simple;
	bh=LBktxRSJW6FqJOM/haOQ9aZlZaZ+M2+WyyYEVud4ees=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WqOwGW+kLIsmqeLwqci8YDe/8wpNuZ21PbRmDpSosqSiW6rjuJBZRVm+wjJAYy6IJVGDhVK3H0NfB9cr4IMU+13q5GZRlhzwfTlfA7zZDEifMVYGJvfrVSS+MhpDo9B+TR443qwCRKWGvH7PqRQPqAdUwvd6K+5HrNPPMm5amdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d096c4d64eso6250039f.1
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 10:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712078543; x=1712683343;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tyZ4y+RtmwUpbBCKI17zVFEJ/EY3alOUhTWMMfA+maA=;
        b=eoNAjSep9Wqti1SeBNBDE5G8mmL4xGwalykNcHUUSPlKKL+bJuVvFi/l7osgLZKL9t
         m6svOvTiHo/6bFIAlD8j+/eRjd8P9j6WDrWEIa9V48EO7AfswqteMEeSjZfq381DGSL4
         ziqIJlZVKoWr/3VRkt7fzBWk8QGa3G+cACJjFrxpOxtxfkdZpt0TWZo666jfh5q4gaIE
         /bdrJuSg/0H7NiXCYOrm9i//cJkd4ZeQuxVp1vdMxmtfBlzvMYoq8WQMjSH17lQmoh0z
         wCEBTUpN/neWsaS4HE0C3vuFmh0IZAwJSoVuaV/2aCkWlpU/2BBZyl2KILYNBFWo6cRl
         fhAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqMZTi4etQev8d7EdsR5h46iNglyovQL7/siEuXDPckTwoIRzJNlmDIeWFZKVtJzTS2iuFqBEw1E41oNs0OItnTL6U
X-Gm-Message-State: AOJu0YyAHOgbwcGkXtVSc8EMwEqQgY5aIvR6LrqzLscYEKBDc8hgzqG0
	TpRu1sz5ChRLL+P1Hq9gZ/oHMHuQ9mVOz9uBmCN07PQslxQGrXInhwGM4Mz/+ql+qh6ivwlnYHT
	D2dT32Tw5llizpRk33v4etMDaqtcud7UOGQD3XXVu/HAVuYPyP+w+4io=
X-Google-Smtp-Source: AGHT+IE5sYOEGeW0Dq9TUU6KKmEsVku0KXM5A4AszSQ+g1aN9s9OafJG5FdmlE5Z9+ghoNOKg8Q5AHV20WrkTDprfIre4KzwBvME
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c84:b0:7d0:690c:6a01 with SMTP id
 i4-20020a0566022c8400b007d0690c6a01mr5504iow.1.1712078543509; Tue, 02 Apr
 2024 10:22:23 -0700 (PDT)
Date: Tue, 02 Apr 2024 10:22:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069edc606152059d4@google.com>
Subject: [syzbot] [bpf?] KMSAN: uninit-value in percpu_array_map_lookup_percpu_elem
From: syzbot <syzbot+aca389a8a7da35c070ce@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    39cd87c4eb2b Linux 6.9-rc2
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13891cc5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5112b3f484393436
dashboard link: https://syzkaller.appspot.com/bug?extid=aca389a8a7da35c070ce
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11629a19180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=169e86e5180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dba7eac545d2/disk-39cd87c4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ddf1c8e07b17/vmlinux-39cd87c4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/808527761eab/bzImage-39cd87c4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aca389a8a7da35c070ce@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in percpu_array_map_lookup_percpu_elem+0x1cb/0x200 kernel/bpf/arraymap.c:257
 percpu_array_map_lookup_percpu_elem+0x1cb/0x200 kernel/bpf/arraymap.c:257
 ____bpf_map_lookup_percpu_elem kernel/bpf/helpers.c:133 [inline]
 bpf_map_lookup_percpu_elem+0x67/0x90 kernel/bpf/helpers.c:130
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run288+0xb5/0xe0 kernel/bpf/core.c:2237
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run8+0x1bd/0x3a0 kernel/trace/bpf_trace.c:2426
 __bpf_trace_jbd2_handle_stats+0x51/0x70 include/trace/events/jbd2.h:210
 trace_jbd2_handle_stats include/trace/events/jbd2.h:210 [inline]
 jbd2_journal_stop+0x1157/0x12c0 fs/jbd2/transaction.c:1869
 __ext4_journal_stop+0x115/0x310 fs/ext4/ext4_jbd2.c:134
 ext4_do_writepages+0x1c3c/0x62e0 fs/ext4/inode.c:2692
 ext4_writepages+0x312/0x830 fs/ext4/inode.c:2768
 do_writepages+0x427/0xc30 mm/page-writeback.c:2612
 __writeback_single_inode+0x10d/0x12c0 fs/fs-writeback.c:1650
 writeback_sb_inodes+0xb48/0x1be0 fs/fs-writeback.c:1941
 __writeback_inodes_wb+0x14c/0x440 fs/fs-writeback.c:2012
 wb_writeback+0x4da/0xdf0 fs/fs-writeback.c:2119
 wb_check_old_data_flush fs/fs-writeback.c:2223 [inline]
 wb_do_writeback fs/fs-writeback.c:2276 [inline]
 wb_workfn+0x110c/0x1940 fs/fs-writeback.c:2304
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa81/0x1bd0 kernel/workqueue.c:3335
 worker_thread+0xea5/0x1560 kernel/workqueue.c:3416
 kthread+0x3e2/0x540 kernel/kthread.c:388
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

Local variable stack created at:
 __bpf_prog_run288+0x45/0xe0 kernel/bpf/core.c:2237
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run8+0x1bd/0x3a0 kernel/trace/bpf_trace.c:2426

CPU: 1 PID: 1070 Comm: kworker/u8:7 Not tainted 6.9.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: writeback wb_workfn (flush-8:0)
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
