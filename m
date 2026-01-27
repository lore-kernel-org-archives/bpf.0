Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3511FF1B4
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 01:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769476053; cv=none; b=jZgTSJZUsPbcSc3HLCuNoXFMzeXzOOcugRrjbY71O6M3YY9GgHry6yyMmIG2diJqegTHVnVDlnNWIuiJIDIDjHAFxqhbQdb2eJys8qrB8ttb3AwI88xRkfIdNA9zL5QRn/WmKzQRWuywx5Jti7TMj7How+uCI7Ui/3ZrGtTSkgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769476053; c=relaxed/simple;
	bh=yS8BMLsG/HCKSZSySlbUl4sQSa00TQyXgiSxjUua8rk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rwol5wx53ZwOx4I/fIwKfNymXTpCtXwu3midKaMre7gy9o2Vz3rf46vytvOn5I6eAUgG194HxcDjmDbjVoM1jxBfsyZYH+AUJZ1J6py1qI/UFqZ94juoXdk++5tdgbByMYY1adkZ8T32THmkVF8wvUrmDgCEnIp8gAbqyd+hEe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-662c0f7c3c0so17533724eaf.1
        for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 17:07:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769476051; x=1770080851;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rKSYZckqUpjWqoIFliWHkkvKDuE2akDced1pYzXocyU=;
        b=ml2DT69TOXeTNTSypSKDGCDMq2hnaPGmlsB577R7oiZJB+QmsNaZj94vUCJSutUVql
         ++/JXYSuPeozCqWahZTziFwa0b9STKSq6O39leTnTFuDysXuIDU0qD6xCeTngfpE4TFt
         K9kpXoHfMDF4leAs5hvb5NqKbzdRiGc5e7oIhVJDs+rxiTb5d1+vEZxdaech9ogdw2mn
         8F9iy7Tw6KaO9Y2YlxeEw7oA13x2sV5t4MHBX+1hyfAQ1diZJhk+WZJ6+WExiI+xsvrV
         pDRpcVYUGvC3s9mBoTLsaqxYW4lyLXj269YS69TX11CmHPnCiNMbLwJjE2vcfWQfJ0MB
         dBFA==
X-Forwarded-Encrypted: i=1; AJvYcCVNqYt7KWrbHlh5JZOv+vxynfsSUrtuWtREWWNKUVxJkGtyuPsHWdKFfUNEx7rOPR0hrE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPD5yNpMY1XoMEAjaCBAKGWR0Bx5N5WPYkAIG0HbxhdjtidiqD
	xCoGmiH7lpIFzg8jGdy36gn+DDTA5FClF1S3hb9hUoTxmiJxIu4+2C1bx1zIO9Ja5H8xOXtUJGG
	FcZ9U0RR7CGYofSL+d0Oc0P0t/fdX9UiOve8KfapKiO+MPMg9L8MWX/ez2CU=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c90:b0:659:9a49:8ec1 with SMTP id
 006d021491bc7-662e04a56abmr3303587eaf.69.1769476051142; Mon, 26 Jan 2026
 17:07:31 -0800 (PST)
Date: Mon, 26 Jan 2026 17:07:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69780fd3.050a0220.c9109.000b.GAE@google.com>
Subject: [syzbot] [bpf?] INFO: rcu detected stall in vma_merge_new_range (3)
From: syzbot <syzbot+316c0070a0341d2661a2@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    62085877ae65 Merge tag 'kbuild-fixes-6.19-2' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14702ffc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1fac0919970b671
dashboard link: https://syzkaller.appspot.com/bug?extid=316c0070a0341d2661a2
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ece05a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ac88c4a42b92/disk-62085877.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/65aa8ae919a4/vmlinux-62085877.xz
kernel image: https://storage.googleapis.com/syzbot-assets/07d015936518/bzImage-62085877.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+316c0070a0341d2661a2@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P6397/1:b..l
rcu: 	(detected by 0, t=10503 jiffies, g=12021, q=830 ncpus=2)
task:sed             state:R  running task     stack:25736 pid:6397  tgid:6397  ppid:6396   task_flags:0x400000 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5260 [inline]
 __schedule+0xfe4/0x5e10 kernel/sched/core.c:6867
 preempt_schedule_irq+0x50/0x90 kernel/sched/core.c:7194
 irqentry_exit+0x17b/0x670 kernel/entry/common.c:216
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:lock_release+0x19e/0x2e0 kernel/locking/lockdep.c:5893
Code: ff 65 0f c1 05 5b 5d 01 12 83 f8 01 0f 85 f7 00 00 00 9c 58 f6 c4 02 0f 85 0c 01 00 00 41 f7 c6 00 02 00 00 0f 85 99 00 00 00 <48> 8b 44 24 10 65 48 2b 05 ed 15 01 12 0f 85 0f 01 00 00 48 83 c4
RSP: 0018:ffffc9000454eec8 EFLAGS: 00000206
RAX: 0000000000000046 RBX: ffffffff8e5e3360 RCX: ffffc9000454eed4
RDX: 0000000000000001 RSI: ffffffff8dc1f455 RDI: ffffffff8bfa35a0
RBP: ffffffff821833aa R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88802ff00000
R13: ffffc9000454f028 R14: 0000000000000206 R15: 0000000000000002
 rcu_lock_release include/linux/rcupdate.h:341 [inline]
 rcu_read_unlock include/linux/rcupdate.h:897 [inline]
 is_bpf_text_address+0x8f/0x1a0 kernel/bpf/core.c:746
 kernel_text_address kernel/extable.c:125 [inline]
 kernel_text_address+0x8d/0x100 kernel/extable.c:94
 __kernel_text_address+0xd/0x30 kernel/extable.c:79
 unwind_get_return_address+0x59/0xa0 arch/x86/kernel/unwind_orc.c:385
 arch_stack_walk+0xa6/0xf0 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x8e/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4953 [inline]
 slab_alloc_node mm/slub.c:5263 [inline]
 kmem_cache_alloc_noprof+0x2ad/0x780 mm/slub.c:5270
 mt_alloc_one lib/maple_tree.c:174 [inline]
 mas_alloc_nodes+0x280/0x390 lib/maple_tree.c:1110
 mas_preallocate+0x39c/0xf10 lib/maple_tree.c:5194
 vma_iter_prealloc mm/vma.h:505 [inline]
 commit_merge+0x3e3/0xbd0 mm/vma.c:751
 vma_expand+0x7c3/0xd50 mm/vma.c:1200
 vma_merge_new_range+0x2ce/0xa30 mm/vma.c:1099
 __mmap_region+0x85d/0x2820 mm/vma.c:2747
 mmap_region+0x180/0x3e0 mm/vma.c:2830
 do_mmap+0xc63/0x12f0 mm/mmap.c:558
 vm_mmap_pgoff+0x29e/0x470 mm/util.c:581
 ksys_mmap_pgoff+0x328/0x5b0 mm/mmap.c:604
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc9/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3f299f3242
RSP: 002b:00007ffdac2ae3a8 EFLAGS: 00000206 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f3f2989b000 RCX: 00007f3f299f3242
RDX: 0000000000000001 RSI: 0000000000057000 RDI: 00007f3f2989b000
RBP: 0000000000000812 R08: 0000000000000003 R09: 0000000000176000
R10: 0000000000000812 R11: 0000000000000206 R12: 00007ffdac2ae430
R13: 00007f3f299c75f0 R14: 00007ffdac2aebe0 R15: 00000fffb5855c78
 </TASK>
rcu: rcu_preempt kthread starved for 10551 jiffies! g12021 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:29112 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5260 [inline]
 __schedule+0xfe4/0x5e10 kernel/sched/core.c:6867
 __schedule_loop kernel/sched/core.c:6949 [inline]
 schedule+0xdd/0x390 kernel/sched/core.c:6964
 schedule_timeout+0x127/0x280 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x1a9/0xb00 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x21e/0x320 kernel/rcu/tree.c:2285
 kthread+0x3b3/0x730 kernel/kthread.c:463
 ret_from_fork+0x754/0xaf0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/13/2026
RIP: 0010:mac80211_hwsim_tx_frame_no_nl.isra.0+0x3e6/0x1370 drivers/net/wireless/virtual/mac80211_hwsim.c:1814
Code: fc ff df 48 89 fa 48 c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 23 0f 00 00 41 02 9d 4c 01 00 00 <88> 9c 24 e6 00 00 00 e8 ce f5 f2 fa 49 8d bc 24 b8 3e 00 00 48 b8
RSP: 0018:ffffc90000007b18 EFLAGS: 00000296
RAX: 0000000000000007 RBX: 00000000ffffffe2 RCX: ffffffff87140972
RDX: 0000000000000000 RSI: ffffffff871409ee RDI: ffff888030b16bac
RBP: ffff888032dfe500 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880333c3100
R13: ffff888030b16a60 R14: ffff8880333c3398 R15: 0000000000070000
FS:  0000000000000000(0000) GS:ffff8881245dc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f77ff200000 CR3: 0000000028289000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 mac80211_hwsim_tx_frame+0x1f6/0x2a0 drivers/net/wireless/virtual/mac80211_hwsim.c:2264
 __mac80211_hwsim_beacon_tx drivers/net/wireless/virtual/mac80211_hwsim.c:2281 [inline]
 mac80211_hwsim_beacon_tx+0x57e/0xa00 drivers/net/wireless/virtual/mac80211_hwsim.c:2365
 __iterate_interfaces+0x2e6/0x650 net/mac80211/util.c:761
 ieee80211_iterate_active_interfaces_atomic+0x71/0x1b0 net/mac80211/util.c:797
 mac80211_hwsim_beacon+0x105/0x1b0 drivers/net/wireless/virtual/mac80211_hwsim.c:2395
 __run_hrtimer kernel/time/hrtimer.c:1777 [inline]
 __hrtimer_run_queues+0x516/0x990 kernel/time/hrtimer.c:1841
 hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1858
 handle_softirqs+0x1ea/0x910 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xef/0x150 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0xa3/0xc0 arch/x86/kernel/apic/apic.c:1056
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:82
Code: 76 78 02 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 83 cc 14 00 fb f4 <e9> fc 31 03 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
RSP: 0018:ffffffff8e207e00 EFLAGS: 00000242
RAX: 000000000015e0e3 RBX: ffffffff8e297ac0 RCX: ffffffff8b76b4b5
RDX: 0000000000000000 RSI: ffffffff8dc45440 RDI: ffffffff8bfa35a0
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed101708673d
R10: ffff8880b84339eb R11: 0000000000000000 R12: fffffbfff1c52f58
R13: 0000000000000000 R14: ffffffff90b737d0 R15: 0000000000000000
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x9/0x10 arch/x86/kernel/process.c:767
 default_idle_call+0x6c/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x35b/0x4b0 kernel/sched/idle.c:332
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
 rest_init+0x251/0x260 init/main.c:757
 start_kernel+0x47a/0x480 init/main.c:1206
 x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
 x86_64_start_kernel+0x122/0x130 arch/x86/kernel/head64.c:291
 common_startup_64+0x13e/0x148
 </TASK>


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
