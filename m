Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D63F61FCE
	for <bpf@vger.kernel.org>; Sat, 27 Jun 2026 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782574298; cv=none; b=BOZvRMTeSBar0yq+1/RFQAPEMSrv3jkZ8zjGVXCDt6XLKlerk5QtVC23VLdopEbEo8t787DpYT1DbGJn0w28Rf5O6vnOqcc8OVD1UISnTXJxeFgVG6Zugt74m4Ms60DVO4GxdwfGvpCLIUJfPSfxnT1xOyKBuOydoSm6mQjxuas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782574298; c=relaxed/simple;
	bh=8e7q4e/NtNUWIXpOPl6dhkCLcIQEwXlfYcmPRhfxEI4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=I2Z9jxuGJvb2fcfBGMpM1zim0sp6kEnKmsXVnd9//BPyn3taS5lFT5pfQcPqq8baSpSV6IzDmktXIdzsA0eA76bxE0rsIBEYqin2MzSN4apOKqyA6tqLDAACZFFkZdPC6LLcPjVG4TlfwRZNWQuepnAIQI+PcI7aGFGimXr1qQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-485ebc5706cso5086326b6e.0
        for <bpf@vger.kernel.org>; Sat, 27 Jun 2026 08:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782574295; x=1783179095;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JMtDhxQqmrwXBAgJrz9o5CQ4Umwh4FbcStTxUSyG5fs=;
        b=VLT9JBAIswFOQkHB/rg6nzA7Msn71y9e6GcjBQ+a/Ffg8tQb/AOA0OiwHYhEsKGGdi
         F0cQGEgKmDt0R5iFQKSFxgIj6F5uIzpTnr08LvJ+9VtMabh4+ytb5kIH7w5j+5eAKijt
         3iSDwVMJE7EZPKdf0/NJmCd/lXdD2QOO6cdgVx904WQAdRt5ZvcVW1YAql9Ck+7FCfOy
         uULr7PvgVE5MM2HNu0osn/2k4k9iZwkQIBkeqy0HB3PvkfJ3oN5dfxPWBuJbyFYMYhVZ
         pyhHg4zcIP5xEBCzjHxCm1UMyCXKUcrbrAL97TJf04bLHUBbofjgIqtdWKLBi82qbWiV
         8Erg==
X-Forwarded-Encrypted: i=1; AFNElJ+TKJMm2j9MVwzA6v3N574d2pWRJOctSEXYCc0bjsouJoPb0oe6cho3/UXgZ5Usof80s9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsj1L1EGs4XrRql9c+5lELGJD/lVAqUF2dCxEXiv8DMxTnyRmN
	5MZP7viocNyqS1vjCefK2cS2ZTpUJJTf6ksOIi/B3daEz/Ie7J7MwHizsmI7PhjQ1hbSAWNlsEA
	/I7RrjG/F7bL7bCwlvQBnVC5q8KG35bJwsNpWil+PKaqp0NB3aathWrTmH9g=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c170:b0:491:3c9a:c486 with SMTP id
 5614622812f47-4913c9adc98mr9591183b6e.27.1782574295639; Sat, 27 Jun 2026
 08:31:35 -0700 (PDT)
Date: Sat, 27 Jun 2026 08:31:35 -0700
In-Reply-To: <68089c01.050a0220.36a438.0010.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a3fecd7.ac7367b4.6675.000b.GAE@google.com>
Subject: Re: [syzbot] [net?] BUG: soft lockup in hsr_announce (3)
From: syzbot <syzbot+6c68a0400c33951a023c@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, haoluo@google.com, horms@kernel.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    5a66900afbd6 Merge tag 'drm-fixes-2026-06-27' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d729fe580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c3d59be33cf7e9a
dashboard link: https://syzkaller.appspot.com/bug?extid=6c68a0400c33951a023c
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176df861580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-5a66900a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/73461c39cbcb/vmlinux-5a66900a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b8ca145674f8/bzImage-5a66900a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6c68a0400c33951a023c@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 143s! [syz.1.18:5749]
Modules linked in:
irq event stamp: 5276037
hardirqs last  enabled at (5276036): [<ffffffff8bb6be38>] irqentry_exit_to_kernel_mode_after_preempt include/linux/irq-entry-common.h:507 [inline]
hardirqs last  enabled at (5276036): [<ffffffff8bb6be38>] irqentry_exit_to_kernel_mode include/linux/irq-entry-common.h:542 [inline]
hardirqs last  enabled at (5276036): [<ffffffff8bb6be38>] irqentry_exit+0x218/0x8f0 kernel/entry/common.c:167
hardirqs last disabled at (5276037): [<ffffffff8bb6abce>] sysvec_apic_timer_interrupt+0xe/0xc0 arch/x86/kernel/apic/apic.c:1062
softirqs last  enabled at (7948): [<ffffffff8187eb4a>] __do_softirq kernel/softirq.c:656 [inline]
softirqs last  enabled at (7948): [<ffffffff8187eb4a>] invoke_softirq kernel/softirq.c:496 [inline]
softirqs last  enabled at (7948): [<ffffffff8187eb4a>] __irq_exit_rcu+0xca/0x220 kernel/softirq.c:735
softirqs last disabled at (7951): [<ffffffff8187eb4a>] __do_softirq kernel/softirq.c:656 [inline]
softirqs last disabled at (7951): [<ffffffff8187eb4a>] invoke_softirq kernel/softirq.c:496 [inline]
softirqs last disabled at (7951): [<ffffffff8187eb4a>] __irq_exit_rcu+0xca/0x220 kernel/softirq.c:735
CPU: 0 UID: 0 PID: 5749 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:unwind_next_frame+0x48e/0x2550 arch/x86/kernel/unwind_orc.c:520
Code: d8 48 c1 e8 03 42 0f b6 04 20 84 c0 0f 85 b4 19 00 00 4c 89 e8 48 c1 e8 03 42 0f b6 04 20 84 c0 0f 85 bf 19 00 00 0f b6 43 01 <83> e0 07 0f 84 7c 16 00 00 83 f8 01 4c 8b 6c 24 50 49 bc 00 00 00
RSP: 0018:ffffc90000007480 EFLAGS: 00000246
RAX: 000000000000000b RBX: ffffffff90bf84c6 RCX: ffffffff90462a44
RDX: ffffffff90bf84c2 RSI: ffffffff90bf84c2 RDI: ffffffff8c2ac720
RBP: ffffffff8100012f R08: 0000000000000022 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff8e959c20 R12: dffffc0000000000
R13: ffffffff90bf84c7 R14: ffffc90000007528 R15: ffffffff90462a44
FS:  00007f111b0f96c0(0000) GS:ffff88808c815000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f111a1ea540 CR3: 000000003fc5d000 CR4: 0000000000352ef0
Call Trace:
 <IRQ>
 arch_stack_walk+0x11b/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0xa9/0x100 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4612 [inline]
 slab_alloc_node mm/slub.c:4945 [inline]
 kmem_cache_alloc_noprof+0x2a0/0x5f0 mm/slub.c:4959
 skb_clone+0x212/0x3a0 net/core/skbuff.c:2110
 hsr_forward_do net/hsr/hsr_forward.c:-1 [inline]
 hsr_forward_skb+0xfbe/0x28c0 net/hsr/hsr_forward.c:743
 send_hsr_supervision_frame+0x733/0xcf0 net/hsr/hsr_device.c:364
 hsr_announce+0x1db/0x370 net/hsr/hsr_device.c:421
 call_timer_fn+0x192/0x5e0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
 handle_softirqs+0x225/0x840 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xca/0x220 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:finish_task_switch+0x417/0xc60 kernel/sched/core.c:5361
Code: 04 00 00 41 c7 84 24 20 0e 00 00 00 00 00 00 0f 1f 44 00 00 49 83 c4 48 4c 89 e7 e8 43 7b 24 0a e8 ae bc 39 00 fb 4c 8b 65 c8 <49> 8d bc 24 f8 16 00 00 48 89 f8 48 c1 e8 03 42 0f b6 04 30 84 c0
RSP: 0018:ffffc9000377f7c0 EFLAGS: 00000202
RAX: 0000000000000161 RBX: ffff88801fc3bf20 RCX: 0000000080000001
RDX: 0000000000000006 RSI: ffffffff8dfe8e81 RDI: ffffffff8c2ac780
RBP: ffffc9000377f810 R08: ffffffff90331df7 R09: 1ffffffff20663be
R10: dffffc0000000000 R11: fffffbfff20663bf R12: ffff888039a5a540
R13: ffff88801fc3bee8 R14: dffffc0000000000 R15: 1ffff11003f877e4
 context_switch kernel/sched/core.c:5513 [inline]
 __schedule+0x17e1/0x56c0 kernel/sched/core.c:7234
 preempt_schedule_common+0x82/0xd0 kernel/sched/core.c:7413
 preempt_schedule_thunk+0x16/0x40 arch/x86/entry/thunk.S:12
 smp_call_function_single+0x46e/0x5a0 kernel/smp.c:704
 task_function_call kernel/events/core.c:124 [inline]
 perf_install_in_context+0x5bd/0x900 kernel/events/core.c:3203
 __do_sys_perf_event_open kernel/events/core.c:14239 [inline]
 __se_sys_perf_event_open+0x1906/0x1d40 kernel/events/core.c:13881
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f111a19ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f111b0f9028 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 00007f111a415fa0 RCX: 00007f111a19ce59
RDX: bfffffffffffffff RSI: 0000000000000000 RDI: 0000200000000180
RBP: 00007f111a232e6f R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000000
R13: 00007f111a416038 R14: 00007f111a415fa0 R15: 00007ffe2b7b0cb8
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
