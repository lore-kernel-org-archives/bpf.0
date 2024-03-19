Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EAD2BAE7
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 18:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871942; cv=none; b=orQixrNGP7nDVbb0l54phxNjUuhOq1kfVzLKtAlfrve63ZmBmoVruKdQzP9vfGuwXP+We/UOTU94eHuSUK8Rsl5XRh1HY3PxI92wQzcAkzuuS+qhQxH8gSWcW5j7wxcYRoE3MIN3Ld4jtgryAHyTA3m3csNt5gEnaxWpNF43Lwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871942; c=relaxed/simple;
	bh=siI8VeFTsF4LULV55XYmK8BQojlECYFyKavt0Y88i+U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=L9BFhs54ebI9bdBdhKHUwX9yxZWJmxmQv//zHulQpclFWrkUik71cPZioUyciB18TStDJWl4zICMW81K+Y7a1mrrOzOTko78zYQBoWrbhbqWDdXUBLUdGSbFHpkTbU7chKewLBFw2THN3QtDOSpu3wywcx7UmQOBPa++iaZL8Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c9aa481ce4so519859939f.3
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 11:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710871940; x=1711476740;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Sqn0ln2THzqHfmXyaFjzD4QiULXDUL2ozzKYWDWQtk=;
        b=wwdPIrXZvtSaczhNLhuv2U03SmzM/Lf9lakwVP25zm6zNjyp4/1QhEjrWf8625IMAz
         4cF1woGN3FLeQwKFOS3BVSb92fHX8jvxWm+SgaEXJwKttNAFS3olS9buSV7QfXRb60Uh
         2X0jiEYWWf8NWYDETsqZ3MW/4jD2IsZsTLzk8A9M6zOyL7u6ydxNgwDxdJa/l3/hARuU
         rKhPuJqAImsg/Xg6uFi9BR2oDIHK1iaD9oJX3FDkuu0wyS8WGE6E6oqUHThNgS9Pn/om
         L4tr3dDSS2w0zoXHMZVVLO8cZO/Mu56rUBeK92xtkdnOg6gOpwUwwtGTCm7Jh3gcwMyX
         T5vA==
X-Forwarded-Encrypted: i=1; AJvYcCVsBaHZhGXQDm4BovWioV1RhPRXox+AD2M08GYQA8UhNYV/upd/DVKTu/0vtTIVxr/yWuriG0J/5jtPylK3ocDMTIk4
X-Gm-Message-State: AOJu0YzGjmzeZTuLFmP8l07C9SSOlCuAerHyfRidkdjmWI8iW1SRY/QS
	shBSRGsmVxy4Bz+5dx8GwVTh9UfEFPlRqiJU1ArvcUf2wX+x7d7dNeILZV2PPYnPy8KsmRltnNq
	qmyGjj+Lj6PlMoppzKcd1065RKjpj6pLjvdPnak0UfEdmFTvMkbYB6lU=
X-Google-Smtp-Source: AGHT+IHErSdRgmQ5olpFbigDrmj0p7684ktfMfinf4zKPWNBf58VW/Z3IOdNSUAovPmu0WS2PYfgf/5KOTWcoeMDmSI/V8FP7mj0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1687:b0:7cf:16d5:1820 with SMTP id
 s7-20020a056602168700b007cf16d51820mr9579iow.2.1710871940246; Tue, 19 Mar
 2024 11:12:20 -0700 (PDT)
Date: Tue, 19 Mar 2024 11:12:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004139c80614076a2c@google.com>
Subject: [syzbot] [bpf?] KMSAN: uninit-value in percpu_array_map_lookup_elem
From: syzbot <syzbot+5e23b0df3b12b8b215b7@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e5eb28f6d1af Merge tag 'mm-nonmm-stable-2024-03-14-09-36' ..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14e351c9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aa3d79b689f321c8
dashboard link: https://syzkaller.appspot.com/bug?extid=5e23b0df3b12b8b215b7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14498006180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11e4d769180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eaca555a0446/disk-e5eb28f6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4fbf90fa0d23/vmlinux-e5eb28f6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bbae0627aafd/bzImage-e5eb28f6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5e23b0df3b12b8b215b7@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in percpu_array_map_lookup_elem+0x142/0x160 kernel/bpf/arraymap.c:243
 percpu_array_map_lookup_elem+0x142/0x160 kernel/bpf/arraymap.c:243
 ____bpf_map_lookup_elem kernel/bpf/helpers.c:42 [inline]
 bpf_map_lookup_elem+0x5c/0x80 kernel/bpf/helpers.c:38
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run64+0xb5/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run3+0x132/0x320 kernel/trace/bpf_trace.c:2421
 __bpf_trace_ext4_es_insert_delayed_block+0x34/0x50 include/trace/events/ext4.h:2481
 trace_ext4_es_insert_delayed_block include/trace/events/ext4.h:2481 [inline]
 ext4_es_insert_delayed_block+0x11e1/0x1290 fs/ext4/extents_status.c:2082
 ext4_insert_delayed_block fs/ext4/inode.c:1676 [inline]
 ext4_da_map_blocks fs/ext4/inode.c:1777 [inline]
 ext4_da_get_block_prep+0x1714/0x1d30 fs/ext4/inode.c:1817
 ext4_block_write_begin+0x749/0x1df0 fs/ext4/inode.c:1055
 ext4_da_write_begin+0x889/0xec0 fs/ext4/inode.c:2894
 generic_perform_write+0x400/0xc60 mm/filemap.c:3974
 ext4_buffered_write_iter+0x564/0xaa0 fs/ext4/file.c:299
 ext4_file_write_iter+0x208/0x3450
 call_write_iter include/linux/fs.h:2108 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb63/0x1520 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Local variable stack created at:
 __bpf_prog_run64+0x45/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run3+0x132/0x320 kernel/trace/bpf_trace.c:2421

CPU: 1 PID: 5001 Comm: syz-executor118 Not tainted 6.8.0-syzkaller-09791-ge5eb28f6d1af #0
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
