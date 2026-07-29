Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F1541F34A
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 21:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785361053; cv=none; b=CgWoQs0aXYW31e5l2/9mWqezIMmJ/eFoZFOdy5ccUHANUzlYC10iwMn5Ad8OYaP4bl2fKXvVU1a8pDN6dH2NAPieCmQkXs3Yt+IWKQCNlbCHRMXS9MgfZPkzMT+oNy+h5mkAn5NsNZ7jLxkWd6jMDNbhOIa+wMjQzBm3QQ0MPrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785361053; c=relaxed/simple;
	bh=xrvw8RNuMhKMyaa7bF1F7eG2Yu1e/tw7R2QNWcvRBiQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GinG5NTKRl+ktiQY8/rnULblzau936AN2hZaaK9XsszDRS+mielOGHqukC31QyN2HEbN2e1io3SH2Y9AODiST65oTB3QpxEVOgVkTFMyv5Z+M6+VR8lLny00C4p1eS9jZeogYQpmsnKkfeL/d3MiprX19YH8AhklW8PoxfAYhO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-49ab6a82cd5so1782134b6e.2
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 14:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785361050; x=1785965850;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m5+1Yy2yedX4mfkqX7zx9AnuGVQXmZ2Y0pWwMKpzQOU=;
        b=QvQHrPakRrgr2BqflBNbaiftdDqCVm2WeL30p7UJW3dQaO5zxjQZhw8i42hpLIkn9j
         bRrLGmeM90eXlbxWw8wJ1OPV80reFFO6YS6yhgEJVCuZtj9f1QK3NRbJEaf//ZZHhFbt
         7KmxWSeGl+JJGyKob9VU8p5P16phAydde7NQRM8n2Tu769XVUG1u/jOqQGR1SgIAL2o8
         wTNBCRWQPxGPAEwdss75xDSkHPIozBkV/so1T8oezl1gTc3qQ0EBqTNYYID4Lq6etcpb
         F2+uRkSnZTIzzGHUFQGEnP6g9bUnbQuyvcnhxwFdkbnmxoJvi6D3KWORy3rwqdZA/fDV
         JFXg==
X-Forwarded-Encrypted: i=1; AHgh+RqL1QophAgyaZv+Jwsn05FOxNMZbAq1rYxHOcc+rc8ssirHkUhl5EHLa6wHKluOQ5QI7Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGRz2iJ5epxWeqQL/BXSDHU9egE38PlGMq/bJEVwAht+IjwQqi
	X+a0BZXNMDbXMtD2vpI2hdGtODztt6o+mpgQs/OiyFOG3ZU2cwin279F5YlMzyjUCjDK9Mh0jd7
	5RDE2vHSRBq4xD2UnGiUPwJfWlVduxcbzlDeG9jxoVCR8PGm1DOwU9UC7gXk=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:5143:b0:497:e7e2:757a with SMTP id
 5614622812f47-4ad879ad34cmr106563b6e.31.1785361050048; Wed, 29 Jul 2026
 14:37:30 -0700 (PDT)
Date: Wed, 29 Jul 2026 14:37:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6a729a.57649fcc.360844.0007.GAE@google.com>
Subject: [syzbot] [bpf?] [trace?] KCSAN: data-race in __perf_event_overflow / perf_event_detach_bpf_prog
From: syzbot <syzbot+651d2774bd1d8395595f@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev, 
	mathieu.desnoyers@efficios.com, memxor@gmail.com, mhiramat@kernel.org, 
	rostedt@goodmis.org, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fc02acf6ac0c Merge tag 'platform-drivers-x86-v7.2-4' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ad92a9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84b3039e8461eef5
dashboard link: https://syzkaller.appspot.com/bug?extid=651d2774bd1d8395595f
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5213866cd074/disk-fc02acf6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e75f2151b444/vmlinux-fc02acf6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ea07b016de6c/bzImage-fc02acf6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+651d2774bd1d8395595f@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __perf_event_overflow / perf_event_detach_bpf_prog

read-write to 0xffff88811afaeb68 of 8 bytes by task 22274 on cpu 0:
 perf_event_detach_bpf_prog+0x115/0x180 kernel/trace/bpf_trace.c:2021
 perf_event_free_bpf_prog+0x81/0x90 kernel/events/core.c:11766
 bpf_perf_link_release+0x33/0x50 kernel/bpf/syscall.c:3997
 bpf_link_free+0x9d/0x370 kernel/bpf/syscall.c:3395
 bpf_link_put_direct kernel/bpf/syscall.c:3448 [inline]
 bpf_link_release+0x45/0x60 kernel/bpf/syscall.c:3455
 __fput+0x29e/0x630 fs/file_table.c:512
 ____fput+0x1c/0x30 fs/file_table.c:540
 task_work_run+0x130/0x1a0 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x1e4/0x8c0 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x23c/0x3c0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88811afaeb68 of 8 bytes by task 22278 on cpu 1:
 __perf_event_overflow+0x230/0x940 kernel/events/core.c:10769
 perf_swevent_overflow kernel/events/core.c:10911 [inline]
 perf_swevent_event+0x3f3/0x4d0 kernel/events/core.c:10972
 perf_tp_event+0x32f/0x1650 kernel/events/core.c:11484
 perf_trace_run_bpf_submit+0xac/0x110 kernel/events/core.c:11403
 do_perf_trace_sched_switch include/trace/events/sched.h:220 [inline]
 perf_trace_sched_switch+0x186/0x1d0 include/trace/events/sched.h:220
 __traceiter_sched_switch+0x3f/0x60 include/trace/events/sched.h:220
 __do_trace_sched_switch include/trace/events/sched.h:220 [inline]
 trace_sched_switch include/trace/events/sched.h:220 [inline]
 __schedule+0xc23/0xd10 kernel/sched/core.c:7231
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0x5a/0xa0 kernel/sched/core.c:7326
 schedule_timeout+0x53/0x180 kernel/time/sleep_timeout.c:75
 unix_wait_for_peer+0x135/0x1a0 net/unix/af_unix.c:1620
 unix_dgram_sendmsg+0x8c2/0x1030 net/unix/af_unix.c:2256
 sock_sendmsg_nosec net/socket.c:775 [inline]
 __sock_sendmsg net/socket.c:790 [inline]
 ____sys_sendmsg+0x532/0x580 net/socket.c:2684
 ___sys_sendmsg+0x195/0x1e0 net/socket.c:2738
 __sys_sendmmsg+0x185/0x320 net/socket.c:2827
 __do_sys_sendmmsg net/socket.c:2854 [inline]
 __se_sys_sendmmsg net/socket.c:2851 [inline]
 __x64_sys_sendmmsg+0x57/0x70 net/socket.c:2851
 x64_sys_call+0x27aa/0x3020 arch/x86/include/generated/asm/syscalls_64.h:308
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x136/0x3c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0xffffc90002cb9000 -> 0x0000000000000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 22278 Comm: syz.0.4075 Tainted: G        W           syzkaller #0 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
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
