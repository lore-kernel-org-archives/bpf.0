Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A880F2BAEA
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 18:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871889; cv=none; b=OnEwN738jt8IWZposhKz3PsTa+iDThz7FLE5+qzEfvXy1BjVrJJTAbH9YSI7O0oKlp88ci3LusakY3p1s1A8dYCS1sA9+56GI+1/s/UlvWgcyK4zlSeKrvrw1nwxp0W4p5wNhaMHZNtrVR+O0y626NcCLjE3Q7c9p4PSQslgBxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871889; c=relaxed/simple;
	bh=tiGL1NHxk39qgpzX58WM7MKSdnmnH6vTVN+JwmMZD6g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GbM07rAY4SBjs2//8xjvLVo5zUwZ0ywgkM0D6E7XtsS2F6F+h51CwtYtv0WugPGEXEL8MjjkeKrlehnb+kPEuwlmOYvwicJq6FiCEXHQQfqt8hses1XcrTXdafstEWxQTHZDyk4ty4hBbX3FGBprUMY96uv7DoUY2Hsk5cZu3Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-366ada2afc6so28793715ab.0
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 11:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710871887; x=1711476687;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4FGA3Q/Jsb5iylMpt4gm0U57kMlr8EgSfuZyJGPJfJk=;
        b=vSoFq9hcsAC/TqHNgKBAo2XSWkx6nQftfGHEnNX0vQP+UbCWBijYSXCQZ7PjiJtz28
         t3DjOBJcs+eVhxr9qBsy1pgL2cLdqch/ODYGP0CumDfvsbBV39C5YYyvDCk0riKgQjbi
         mRay4dRJTLSNLfXPFXHt2zW2lg+fugcF9F1F8sthSmBCQRsl+DfB4Otc1BLE7rXUkuLX
         Uc+cn9pxarEXXikEG8uDB6ug9XmDrUyGAA0ubg3XmnXddwdWQiO+ZupqPCuiKYVZRoXQ
         8PBgO7r3TrleDXFPjigdGmy/BFlxK0kb+jwWlBAV+kT957KHJtmKZfR73QiaMdNY0RjJ
         EMCw==
X-Forwarded-Encrypted: i=1; AJvYcCVxuQwkELnOj9l7kA2Z6luvdYslNfomgY9jBbZnEx7MyKaZQty1XztzTlkcW+DG4ShoMq7O330HfppVwNtkBEBRpAYw
X-Gm-Message-State: AOJu0YxZv1kagfQMBwpqDUvMLgB523zlMg7Kl+m2/bk1W/E6pp5juT1+
	FzfTTYozftffOkvVRqfB1oZq3M/oVmTbbP4qYvInoD6YtGDXiRjjod3Xzk9fdBpj+p/Trpsdp8e
	DQT9d6uwlalji2ZDIUqLTYWqN4N3UlVXz5heerOrv/xG7hpDa2HCVTE0=
X-Google-Smtp-Source: AGHT+IFmFGl290mOUiju8BeiMLuWxemiwm3OHI1KQCej6a3+CV9O/BljYHG38jI0cLAM186qzncQTYeAY5huH5cRFpHkhyemTZ+b
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:360a:0:b0:366:9ead:645b with SMTP id
 d10-20020a92360a000000b003669ead645bmr343659ila.1.1710871886800; Tue, 19 Mar
 2024 11:11:26 -0700 (PDT)
Date: Tue, 19 Mar 2024 11:11:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011b2f00614076749@google.com>
Subject: [syzbot] [bpf?] KMSAN: uninit-value in __bpf_strtoull
From: syzbot <syzbot+8ac8b7b2292ea867a162@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    741e9d668aa5 Merge tag 'scsi-misc' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=113721f1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48bb382b96e7eda7
dashboard link: https://syzkaller.appspot.com/bug?extid=8ac8b7b2292ea867a162
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7e1776e6e382/disk-741e9d66.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/69580881d554/vmlinux-741e9d66.xz
kernel image: https://storage.googleapis.com/syzbot-assets/65e4047a1117/bzImage-741e9d66.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8ac8b7b2292ea867a162@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __bpf_strtoull+0x245/0x5b0 kernel/bpf/helpers.c:465
 __bpf_strtoull+0x245/0x5b0 kernel/bpf/helpers.c:465
 __bpf_strtoll kernel/bpf/helpers.c:504 [inline]
 ____bpf_strtol kernel/bpf/helpers.c:525 [inline]
 bpf_strtol+0x7c/0x270 kernel/bpf/helpers.c:519
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run96+0xb5/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_test_run+0x43e/0xc30 net/bpf/test_run.c:423
 bpf_prog_test_run_xdp+0xeaa/0x1a40 net/bpf/test_run.c:1269
 bpf_prog_test_run+0x6b7/0xad0 kernel/bpf/syscall.c:4240
 __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5649
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __ia32_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5736
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xba/0x120 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:346
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:384
 entry_SYSENTER_compat_after_hwframe+0x7a/0x84

Local variable stack created at:
 __bpf_prog_run96+0x45/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_test_run+0x43e/0xc30 net/bpf/test_run.c:423

CPU: 0 PID: 11097 Comm: syz-executor.0 Not tainted 6.8.0-syzkaller-11339-g741e9d668aa5 #0
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
