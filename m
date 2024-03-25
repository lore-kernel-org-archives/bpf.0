Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628EC158A13
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 09:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711359391; cv=none; b=TKj6yJqtIqOWjuLzADa64Zi9lS7V1aPXrXG4URJLJcNqBNBkxKmcLB+X3/obDsYaAPgXk3wuqTBNvWWPvA2+qi2AkEUB7S+vxh0rEMroYDMwflW0Eh1EroXeqPzJwQrTLH3QxmAI80PekH8IOXhpyKszdSXBkYSP1+6oTGM8/7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711359391; c=relaxed/simple;
	bh=/9PRyWcMS3WKQZX2HiQSGZ3VL3BgBc0ZRFWdSaJQ9OE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ywj2aBwFUvYCMQ5eA4hzm3YxdU+TFnaY0tfmETvc15ZNYV7p6eVaH22uVjT9i48IU1B/Touefe4beD2L7/oOzdU1ad8souQ7hQf/QJkC/sKrT3e/66dTs68grWwoniEitND2ICMfiEwxpLYsqOFsupEFYcjF5U6/q8wPK6IZSIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cbf2ff0e33so431116139f.1
        for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 02:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711359388; x=1711964188;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TSNIqPkYvxd6e8DwhHfzguzBJvUVKgTbV1cel72QDnY=;
        b=tYxNk3/ROsRx4+wBqHMlQfNB1NY96F6yaQbqEvwxVD5+G25nSVdd0aMPP4lG+trjDA
         TCMsB7RTcSDF8G8QnTjkP3aSiDR/w7ViLiQehLvaeHJkXZU5q1TG6p5qc9H4y2BopnSU
         B3uERZNlaVd6mRaNDIxTJhdeZ2C5d85IiK9elK9ndIZHtbyZjLYCjDBNble9FUb8YJjx
         woCsNSEwaOpy3slkMf7z6rci93S+2B9XndpaNTaMlMDwZWDvqFFn4TjiOpCT8SCLChMs
         F4jgQX09MXaKyzlKjF6S+nnsoFUHR7IlqUMI3E36hWPmJeekmmDVV5f6VVId5tna8P6n
         k9Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVXJoyqmOfd8E9bze1Cy8xoqScdfKSSpQh+1uS6ajlg4Obh/nlcKWv6Xmt2ZDjO1CHPRduWjRgkgzecgWnBKbB7zE5Y
X-Gm-Message-State: AOJu0YyuGS//3I4LHx9hPeQf2sO1l13f32byCw0w5jLxPPkeCRMfpR0+
	RNdAfKb/tjEMiwLV6R6VinyhalmIa1CZeTMy367yZIWInmZoU2i+c+so0KwZfIGDIPv0+SgnJ7s
	dCFH+ZP7AvQl0rkLREWwASO72GlUJfwQQ1fD6/rIVmZRY+GRVtBTox1o=
X-Google-Smtp-Source: AGHT+IGiIKnVaS9EAxan7TjPfAECQrMpgHAmzVJpMvbAAz/7F1Mr6mxydWeOSeapLyDPc2FK+Y9HmSfltI1MhkQBPegpGkybcZ/H
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:218e:b0:47c:203f:8e68 with SMTP id
 s14-20020a056638218e00b0047c203f8e68mr151665jaj.3.1711359388512; Mon, 25 Mar
 2024 02:36:28 -0700 (PDT)
Date: Mon, 25 Mar 2024 02:36:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f876b061478e878@google.com>
Subject: [syzbot] [bpf?] [net?] KMSAN: uninit-value in dev_map_lookup_elem
From: syzbot <syzbot+1a3cf6f08d68868f9db3@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5e74df2f8f15 Merge tag 'x86-urgent-2024-03-24' of git://gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=148872a5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e6bd769cb793b98a
dashboard link: https://syzkaller.appspot.com/bug?extid=1a3cf6f08d68868f9db3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15921a6e180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e081f1180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1a82880723a7/disk-5e74df2f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fd3046ac43b9/vmlinux-5e74df2f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2097be59cbc1/bzImage-5e74df2f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1a3cf6f08d68868f9db3@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __dev_map_lookup_elem kernel/bpf/devmap.c:441 [inline]
BUG: KMSAN: uninit-value in dev_map_lookup_elem+0xf3/0x170 kernel/bpf/devmap.c:796
 __dev_map_lookup_elem kernel/bpf/devmap.c:441 [inline]
 dev_map_lookup_elem+0xf3/0x170 kernel/bpf/devmap.c:796
 ____bpf_map_lookup_elem kernel/bpf/helpers.c:42 [inline]
 bpf_map_lookup_elem+0x5c/0x80 kernel/bpf/helpers.c:38
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run256+0xb5/0xe0 kernel/bpf/core.c:2237
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run5+0x16f/0x350 kernel/trace/bpf_trace.c:2423
 __bpf_trace_ext4_remove_blocks+0x45/0x60 include/trace/events/ext4.h:1984
 __traceiter_ext4_remove_blocks+0xb5/0x170 include/trace/events/ext4.h:1984
 trace_ext4_remove_blocks include/trace/events/ext4.h:1984 [inline]
 ext4_remove_blocks fs/ext4/extents.c:2463 [inline]
 ext4_ext_rm_leaf fs/ext4/extents.c:2686 [inline]
 ext4_ext_remove_space+0x4e30/0x7e00 fs/ext4/extents.c:2934
 ext4_ext_truncate+0x1e3/0x390 fs/ext4/extents.c:4440
 ext4_truncate+0x14c6/0x1e10 fs/ext4/inode.c:4146
 ext4_evict_inode+0x1886/0x24d0 fs/ext4/inode.c:258
 evict+0x3ae/0xa60 fs/inode.c:667
 iput_final fs/inode.c:1741 [inline]
 iput+0x9ca/0xe10 fs/inode.c:1767
 d_delete_notify include/linux/fsnotify.h:307 [inline]
 vfs_rmdir+0x53c/0x790 fs/namei.c:4222
 do_rmdir+0x630/0x8b0 fs/namei.c:4268
 __do_sys_rmdir fs/namei.c:4287 [inline]
 __se_sys_rmdir fs/namei.c:4285 [inline]
 __x64_sys_rmdir+0x78/0xb0 fs/namei.c:4285
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Local variable stack created at:
 __bpf_prog_run256+0x45/0xe0 kernel/bpf/core.c:2237
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run5+0x16f/0x350 kernel/trace/bpf_trace.c:2423

CPU: 0 PID: 5017 Comm: syz-executor365 Not tainted 6.8.0-syzkaller-13236-g5e74df2f8f15 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
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
