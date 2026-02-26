Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2282D395D8A
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118364; cv=pass; b=ayqdMzHC65O1pbUlJSMJOt095IpNRsK+wjh4OHIbsXgnOfqYQfpL335gXW34M4+f8vLc633RY6vbCQ3/0sgBpHEZkFAR6HIGZjNqLGU++AQjgJYKAuv0AXcuRTAYem9ATRsR7bcqRNSHkLq9BURFUy6+gqko4TosvPlkq5Vu1M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118364; c=relaxed/simple;
	bh=twOsmDmRKl9+Dd+o555EnrSnO5ZofMO8P5bm28WR9qU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYCIdqRJ96KXKMQ7FPkgW6Nehlvhk3MH8e68XgxvpWN9P4ncJtq6M7dtOITYJiOoWAVTHEwwX8RwNfUd6VWBArBS3snsk+V/+an1p8o3NDYI5J0HSAEjE6dhbQv30Wtxifhe6EEysg4TybMEWQXoQblvC7mHHQevxYWuy3h3K4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuwXCcQY; arc=pass smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuwXCcQY"
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-3871a08189aso8969921fa.1
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 07:06:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772118361; cv=none;
        d=google.com; s=arc-20240605;
        b=Wwqo3jEV2/OKf6WZhoRoR0Zuh+hrH9CxbUg7i9mwdzpfz68sCV5ONcqon9n8JUtPXj
         adBmIiZl6qEakW6Hqum+UqEEIhk7Y0gaRHlcG/PQEeXn3pt7bgKEuPhmByFLVCGgAlAC
         2psN9cDF+ebrMnggZGOmeFGzE1zjhQzMinqfhdEE8t10QwbJzbQaAhHGA4dCdfvmWiji
         i7EmNBApKZbU0Uhs3ESbBmZ/ody5SJAZ/OU5hQU+q+N2n5LWou2L07hP+z1bXJiqtYCB
         HmSUY4PniNCd5IPz1RGXJhxu+wU3ZesalACuV+ONVHQNbtT4/yctduYaJJmmpXRt4B6s
         WKew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eOjTbqiY2SmTUe6zLl6Az/ivlsEOcYVcG5vAMfNwGNQ=;
        fh=eBq5NNlGHzbC6HIfeFKuQohs0w2wbC3qlijUqOPp5XU=;
        b=dnBES9Zw0Hjcb7nq7dkns+tOs+oDMJTUxSLhVegWa2dVKCvGp0BVoQFLslqdfj3D6t
         QHFZMYdmZCDvLDf4VOLc8ETpgBquQHiKAmXQQN3XLptpZI64n5rCWUwe2UKHt1tIfHQY
         OVlFaObCTia0K7VVEFP5bJea0xU4ijoQB+CGKoMEDYxxJrUsQgA/Cu0JRNqdN87Vw5Jm
         6uCVUihEJDBNbkvWGKzIVCNyfoJmsjh44zzw17lb09wYC5lighuFIS1yEyzIDssy6iXN
         upoH6ul2nsPJB7key0aiqSfPFtn41EmyyoTBFKupP+Dt26+Zt+PV+kA2U6Hbfun2fWuL
         43Vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772118361; x=1772723161; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eOjTbqiY2SmTUe6zLl6Az/ivlsEOcYVcG5vAMfNwGNQ=;
        b=KuwXCcQYthUMh0QyPGxjxS3l1cPWOSEXV8um7p8NV9UT9H+mnO6aq3r72cyJKVxSMM
         rv6gxDjz5llqFQzCVpyRbZjvKO/8I704kWwk1aD9dV69PS0OyPJwAf8KaMGjOlOoGqgt
         NS940fcXXTMt49LhNnxzMYEXDmEARFgjQBdxwibNqO9Ukn3aIyTuizYL8EXW5ts0nc7h
         VodHmv0QOh0VFoIeLpsdi3/4/OeAAlOAVk6h3POmDDDjUTN+IgQC4eoEQ+sLlG+I3i+2
         4BG+ReD9x5jNauZsCaqw+7g/4cSqufngIQq5kqiZF13CNKy29kxE5u/jp1OKRcJAsrq1
         WQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772118361; x=1772723161;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOjTbqiY2SmTUe6zLl6Az/ivlsEOcYVcG5vAMfNwGNQ=;
        b=HSEQ4c5RTmoiuLCfYehzS0d2Vbf7UwjWYFVv2Yp0TBWmdT6Jk220dkPsO3dtZ8uj/+
         Jc3ovRpBVQP5oSxc/rgxfggpAVwZAZyPHbusQosXfjpGBOELKiKK/83GR4bs9xva5CKE
         sWV511T/t2QstDC2wpoiGQn2Vm5acK6Xc+GT+tSr7G5BvbKz/euEtHFn0OWS1m+vFVbU
         v8F3I3n64+rwLTlnONxwlcagN8jFrarxK97aKXnjaRspyQbqFxqmZGpHccxPpueez+iH
         cchoGQeb4Y8rtslP6Slidruv+DYtGIvHXnuThTVB0BkndIjqGEHE8g8xguzAuqmuw06q
         MYBw==
X-Forwarded-Encrypted: i=1; AJvYcCXDbnURK3ZN9CtM+xl3uOlSJx4iNaWixFbP8Se2Yub1cH6PM3BBC91HKRxZuE4DIFGJjxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZGVRpiD8+0Jns4UXxVhkgWstljxF4IDWukBoPdGbYJ+gXk4jd
	vFIZINAzyk/Fja0c2eZHG4ZQzW1PbfW/+sWpVg1eUY/ZOwn3ZhZSSKmb9TrBlLPlpqQFtKAvsJg
	kG5ggjWHybo5LqMI3466W7UfP/t54Nv0=
X-Gm-Gg: ATEYQzzl7lZNmo4/6AkZufwjklB4j23mB/UfOMVANcOZbviL2otxYQhmLaZMXy8rVH/
	syo6qgEsCnP5GM+syBGIplvy4keraXv4+L8kB4tTlXCqJNyvyCkqlE7E7MAFEBuXz8aQa9SfpMg
	3C/9+V/9g+Swtjmy4CsRN2cvVmlzZ35gzExicng1B3TzXBbjYuKDuxlOSGyR6NAIo9UGpxlBq8T
	l/jWIKHtpMWXG+TuQFttnVSQ6AzqEEendsaCQA/37rqrwzhmVkVi2i8nzOLJF3Fxb1iLW41Enna
	qtI2sMrc2Wb7VwFm0ZYIHqi5l4suf5l+EPVQKISkPQw/KtvBw//nAZhsl966
X-Received: by 2002:a05:651c:1583:b0:386:7dae:b568 with SMTP id
 38308e7fff4ca-389a5b40ce6mr59838541fa.15.1772118360040; Thu, 26 Feb 2026
 07:06:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225185121.2057388-1-memxor@gmail.com> <69a01309.050a0220.2fcbed.0007.GAE@google.com>
In-Reply-To: <69a01309.050a0220.2fcbed.0007.GAE@google.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 26 Feb 2026 16:05:22 +0100
X-Gm-Features: AaiRm53VMom1KhooHYBKgU5fD-aR4weSi8vF59Cf4YWmNVDvz79pCfMVTR5JRH8
Message-ID: <CAP01T775AXQK497uRerZrR_UJ0FrS_fcERxPn1PgG_5E932iKw@mail.gmail.com>
Subject: Re: [syzbot ci] Re: Close race in freeing special fields and map value
To: syzbot ci <syzbot+ci3826af8b4f91bf97@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, kernel-team@meta.com, kkd@meta.com, 
	martin.lau@kernel.org, paulmck@kernel.org, yatsenko@meta.com, 
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Feb 2026 at 10:31, syzbot ci
<syzbot+ci3826af8b4f91bf97@syzkaller.appspotmail.com> wrote:
>
> syzbot ci has tested the following series
>
> [v1] Close race in freeing special fields and map value
> https://lore.kernel.org/all/20260225185121.2057388-1-memxor@gmail.com
> * [PATCH bpf-next v1 1/4] bpf: Register dtor for freeing special fields
> * [PATCH bpf-next v1 2/4] bpf: Delay freeing fields in local storage
> * [PATCH bpf-next v1 3/4] bpf: Retire rcu_trace_implies_rcu_gp() from local storage
> * [PATCH bpf-next v1 4/4] selftests/bpf: Add tests for special fields races
>
> and found the following issue:
> KASAN: slab-use-after-free Read in free_all
>
> Full report is available here:
> https://ci.syzbot.org/series/ad9c7ce6-d861-4afe-821a-e8fae6120b12
>
> ***
>
> KASAN: slab-use-after-free Read in free_all
>
> tree:      bpf-next
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git
> base:      f620af11c27b8ec9994a39fe968aa778112d1566
> arch:      amd64
> compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> config:    https://ci.syzbot.org/builds/b2735b0b-963d-41a7-bb33-db10494a24e1/config
> syz repro: https://ci.syzbot.org/findings/3ee61f99-7d80-4986-a0b1-492ffb6b1c46/syz_repro
>
> ==================================================================
> BUG: KASAN: slab-use-after-free in free_all+0x84/0x140 kernel/bpf/memalloc.c:271
> Read of size 8 at addr ffff888112ee9260 by task swapper/0/0
>
> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> Call Trace:
>  <IRQ>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xba/0x230 mm/kasan/report.c:482
>  kasan_report+0x117/0x150 mm/kasan/report.c:595
>  free_all+0x84/0x140 kernel/bpf/memalloc.c:271
>  do_call_rcu_ttrace+0x385/0x400 kernel/bpf/memalloc.c:315
>  __free_by_rcu+0x23b/0x3f0 kernel/bpf/memalloc.c:381
>  rcu_do_batch kernel/rcu/tree.c:2617 [inline]
>  rcu_core+0x7cd/0x1070 kernel/rcu/tree.c:2869
>  handle_softirqs+0x22a/0x870 kernel/softirq.c:622
>  __do_softirq kernel/softirq.c:656 [inline]
>  invoke_softirq kernel/softirq.c:496 [inline]
>  __irq_exit_rcu+0x5f/0x150 kernel/softirq.c:723
>  irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
>  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1056
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
> RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:63
> Code: 8e 6d 02 c3 cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 43 3d 1c 00 fb f4 <e9> 7c ea 02 00 cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90
> RSP: 0018:ffffffff8e407dc0 EFLAGS: 00000202
> RAX: 00000000000d2297 RBX: ffffffff819a80ad RCX: 0000000080000001
> RDX: 0000000000000001 RSI: ffffffff8def22fa RDI: ffffffff8c27a800
> RBP: ffffffff8e407eb0 R08: ffff88812103395b R09: 1ffff1102420672b
> R10: dffffc0000000000 R11: ffffed102420672c R12: ffffffff90117db0
> R13: 1ffffffff1c929d8 R14: 0000000000000000 R15: 0000000000000000
>  arch_safe_halt arch/x86/kernel/process.c:766 [inline]
>  default_idle+0x9/0x20 arch/x86/kernel/process.c:767
>  default_idle_call+0x72/0xb0 kernel/sched/idle.c:122
>  cpuidle_idle_call kernel/sched/idle.c:191 [inline]
>  do_idle+0x1bd/0x500 kernel/sched/idle.c:332
>  cpu_startup_entry+0x43/0x60 kernel/sched/idle.c:430
>  rest_init+0x2de/0x300 init/main.c:760
>  start_kernel+0x385/0x3d0 init/main.c:1210
>  x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
>  x86_64_start_kernel+0x143/0x1c0 arch/x86/kernel/head64.c:291
>  common_startup_64+0x13e/0x147
>  </TASK>
>
> Allocated by task 5961:
>  kasan_save_stack mm/kasan/common.c:57 [inline]
>  kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
>  poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
>  __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
>  kasan_kmalloc include/linux/kasan.h:263 [inline]
>  __do_kmalloc_node mm/slub.c:5219 [inline]
>  __kmalloc_node_noprof+0x4e0/0x7c0 mm/slub.c:5225
>  kmalloc_node_noprof include/linux/slab.h:1093 [inline]
>  __bpf_map_area_alloc kernel/bpf/syscall.c:398 [inline]
>  bpf_map_area_alloc+0x64/0x170 kernel/bpf/syscall.c:411
>  trie_alloc+0x14f/0x340 kernel/bpf/lpm_trie.c:588
>  map_create+0xafd/0x16a0 kernel/bpf/syscall.c:1507
>  __sys_bpf+0x6e1/0x950 kernel/bpf/syscall.c:6210
>  __do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6339
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 83:
>  kasan_save_stack mm/kasan/common.c:57 [inline]
>  kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
>  kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
>  poison_slab_object mm/kasan/common.c:253 [inline]
>  __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
>  kasan_slab_free include/linux/kasan.h:235 [inline]
>  slab_free_hook mm/slub.c:2687 [inline]
>  slab_free mm/slub.c:6124 [inline]
>  kfree+0x1c1/0x630 mm/slub.c:6442
>  bpf_map_free kernel/bpf/syscall.c:892 [inline]
>  bpf_map_free_deferred+0x217/0x460 kernel/bpf/syscall.c:919
>  process_one_work kernel/workqueue.c:3275 [inline]
>  process_scheduled_works+0xb02/0x1830 kernel/workqueue.c:3358
>  worker_thread+0xa50/0xfc0 kernel/workqueue.c:3439
>  kthread+0x388/0x470 kernel/kthread.c:467
>  ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>
> Last potentially related work creation:
>  kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
>  kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
>  insert_work+0x3d/0x330 kernel/workqueue.c:2199
>  __queue_work+0xd03/0x1020 kernel/workqueue.c:2354
>  queue_work_on+0x106/0x1d0 kernel/workqueue.c:2405
>  bpf_map_put_with_uref kernel/bpf/syscall.c:975 [inline]
>  bpf_map_release+0x127/0x140 kernel/bpf/syscall.c:985
>  __fput+0x44f/0xa70 fs/file_table.c:469
>  task_work_run+0x1d9/0x270 kernel/task_work.c:233
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
>  exit_to_user_mode_loop+0xed/0x480 kernel/entry/common.c:98
>  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
>  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
>  syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
>  do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>  [...]

This is because the 'ma' is embedded in map struct, so we have an
optimization to speed up map destruction without waiting for pending
callbacks' rcu_barrier() by copying it out. Typically no callbacks are
in progress by the time map is gone, so it wasn't seen in tests, but
UAF can happen when we kmemdup() and proceed with freeing the bpf_map,
such that the 'ma' pointer becomes invalid.

Just storing dtor and dtor ctx directly is not ok either, since it
accesses the map struct and the corresponding btf_record to decide how
to free fields. It will cause the same UAF. The right way for me
appears to be to duplicate the btf_record (it's not very big anyway)
from the map and store it as the dtor ctx. To remove dependency on
ma->dtor, just store dtor directly in the bpf_mem_caches along with
dtor ctx. Then the dtor can take care of everything else.
