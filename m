Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDAA35C69F
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 04:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786509464; cv=none; b=hMz4pUBL1FBBDt2hcfB3WrY9pfCO0VK1Tf7NV1EURFM8LzrsiQBygkHlgyyHzkRYdjLthw5GQ7KWzKLn6HruAPZJAT0BvwTBonsOi5ybnZFFo0tOElZ8lN+mU1L/1I1cV+TYW3KJ7U5aguYZ73avtiCdBbdWp/agDoqbU7XfzU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786509464; c=relaxed/simple;
	bh=+LeK+Sb5hpt9BCdOmJCflcJBcqaImuXJzbcebuHodlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mYKmnfJtqzBmgKMda+H9wCRxv92Lf6MokrLBAJ+dmrlU4AVsfTy4yj9gAXaLAkN5Y0F9j24DkcYAIFMMNEbOrat2cKJAl8SZcyMoi5YfNpwhZXqHV6LThaHljU+Fui/nU1i18Jc8XNv6bOCApMqfEaA6zmIQoaD4PG43dyY23IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=QvSzxQ3r; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="QvSzxQ3r"
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-380fbfae1a2so93004a91.1
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 21:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1786509458; x=1787114258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JwvDcao6gG2PF3yHhAsBqq1VEg1k2fh3ndJmGYkJADw=;
        b=QvSzxQ3r4mbb5erqGTw/xw7TBYnTFWzHPslywrSCoyjt+/kkrg5clJ/kL5VBfHj0Qf
         nVWZdA7avdWxFPo5uhmQpntq5cjzK7jLTCMbIbwqRXQoZrv8IRmvCZ7Qokg+41FQ0uya
         8ORWMw7Kz23l3+lcOdjr98PkOTg4BJYrMPdDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786509458; x=1787114258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JwvDcao6gG2PF3yHhAsBqq1VEg1k2fh3ndJmGYkJADw=;
        b=o0O9RQvVOO1N8r7+yyOgvHLIjSKAGhTuhqzJo9ak/M3USjK2rFuPtg4LahIagcA2Ep
         iRlk0xlwPm7i7LLmvJO8FO/qy1reATUn/MLS6EhnN3huD/g9Lxa0C/Ikgw0fqmQkiCMf
         1lYjl5LvoBZHZH+aCesYs80B2tXb0HClrZkKG2nOW2eCKlZixpJTVVWpZfpUR0IyRpTF
         g5dwrEh2/iuOCSdJ9Z9nAbA3yCV/0utSudP8p3RFkpsl1KcWGwzF7DAcxrTm2K3O3uiS
         yvHNr1LrnqZ5E75e1M6litYhGDj5Qz9I8D9jRYSq8gI8+Vzt16DQ+c71/bOh9NYRkwOo
         5/Ww==
X-Gm-Message-State: AOJu0Yy6vdFNm0bSszi+DITdCvnegssVRK7/5jgiWEklV7EiCNpxItHF
	Ptc+Io9zwa/90NvcEYjWK6jUPeAfZC8zGaAnvLbDmdNumvSJkO2XSmZAvYpEuNyCF8hZFBCbo0y
	hkENbhyCTDmq7
X-Gm-Gg: AR+sD132/aLCsoL1fGNfGVMRUHDoNY8dIpYROOa+JNUsMoaucVY3mo8sxQSz6piLkDP
	O+9wRMg1Z2MqcwM9wc9B8ZiNWHjNBEg4NZPti9B90olwm1v/fXLM2umkdgOS4+YihgUUtXU0j7q
	XlfatEx0TXiwns8dRGzH734kqr7mxgWV5RwFBNIklymIvhhZEb5WZYKyIzT99Z7lB19cbYpElnX
	bytp7EFCZAvOG8NV9BtI/rxdM+AhXRdMfWdIkH9LlVcWtnjoORZsfKThq+HnaYQxt7+PfkG8CaE
	UVwSwMGR+9mpw0fB6k/11SnrMszNQrQ4SudaLGFio2rv78t1AJKg4dJe/LaQrhcfVP2v0GqZh0n
	ZAKhWb26MhZeXsTzMJ6Dsv3r6yXg0w0acc4Iv58w10nKUUw/dyntZpOb+HTe/PLFKLoaObzRY8d
	q3Y7AfQVa/YRLbHSCCTroehZ2kePd9+bU7pXqvr4zGP3/E8TMPzwQhwO+EmG4=
X-Received: by 2002:a05:6a21:6711:b0:3c3:7226:d5a6 with SMTP id adf61e73a8af0-3cc3f9ae582mr2394881637.18.1786509458037;
        Tue, 11 Aug 2026 21:37:38 -0700 (PDT)
Received: from desktop ([147.46.174.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbee7d150d8sm136409a12.18.2026.08.11.21.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 21:37:37 -0700 (PDT)
From: Kenneth Lee <kennethbwlee@snu.ac.kr>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	sdf@fomichev.me,
	yonghong.song@linux.dev,
	rhkrqnwk98@gmail.com
Subject: BUG: bpf: WARNING in skb_vlan_push from TC BPF action
Date: Wed, 12 Aug 2026 13:36:43 +0900
Message-ID: <20260812043643.808295-1-kennethbwlee@snu.ac.kr>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

While fuzzing, the following warning has been found by a custom fuzzer
developed by Sechang Lim <rhkrqnwk98@gmail.com>:

  skb_vlan_push got skb with skb->data not at mac header (offset 14)

Unfortunately, we haven't found a reproducer for the warning yet. We'll
inform you if we have any update on the warning.

Detailed crash information is attached below.

Thanks,
Kenneth Lee

---
- Kernel version:
7.1

- Crash Report:
skb_vlan_push got skb with skb->data not at mac header (offset 14)
WARNING: net/core/skbuff.c:6474 at skb_vlan_push+0x5ec/0x8a0 net/core/skbuff.c:6472, CPU#0: syz.1.575/5422
Modules linked in:
CPU: 0 UID: 0 PID: 5422 Comm: syz.1.575 Not tainted 7.1.0-dirty #61 PREEMPT(full) 
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
RIP: 0010:skb_vlan_push+0x5ef/0x8a0 net/core/skbuff.c:6472
Code: 41 5c 41 5d 41 5e 41 5f 5d e9 7d 9b 3c 01 cc e8 17 3b 18 fd b8 f4 ff ff ff eb e0 e8 0b 3b 18 fd 48 8d 3d 94 38 29 04 44 89 fe <67> 48 0f b9 3a b8 ea ff ff ff eb c5 e8 f0 3a 18 fd 4c 8b b4 24 80
RSP: 0018:ffffc90000007518 EFLAGS: 00010286
RAX: ffffffff846ddff5 RBX: ffff88811184d780 RCX: 0000000011000000
RDX: ffffc90000c01000 RSI: 000000000000000e RDI: ffffffff99971890
RBP: 0000000004f24680 R08: 0000000000000003 R09: 0000000000000001
R10: 0000000000000180 R11: ffffffffc0082a90 R12: 1ffff11022309b03
R13: dffffc0000000000 R14: ffff888104f24580 R15: 000000000000000e
FS:  00007fe15c24d6c0(0000) GS:ffff88817f705000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f759e13c000 CR3: 0000000113066002 CR4: 0000000000370ef0
Call Trace:
 <IRQ>
 ____bpf_skb_vlan_push net/core/filter.c:3239 [inline]
 bpf_skb_vlan_push+0x216/0x8b0 net/core/filter.c:3229
 bpf_prog_6ca1f7866034bffb+0x268/0x27c
 bpf_prog_run_data_pointers+0x17c/0x240 include/linux/filter.h:917
 tcf_bpf_act+0x31c/0x940 net/sched/act_bpf.c:50
 tc_act include/net/tc_wrapper.h:79 [inline]
 tcf_action_exec+0x2c1/0x720 net/sched/act_api.c:1147
 tc_classify include/net/tc_wrapper.h:178 [inline]
 __tcf_classify net/sched/cls_api.c:1764 [inline]
 tcf_classify+0x6e4/0x1080 net/sched/cls_api.c:1860
 tc_run+0x31c/0x5d0 net/core/dev.c:4411
 sch_handle_ingress net/core/dev.c:4486 [inline]
 __netif_receive_skb_core+0x141b/0x2ec0 net/core/dev.c:6054
0: reclassify loop, rule prio 0, protocol 03
 __netif_receive_skb_one_core+0xf2/0x210 net/core/dev.c:6214
 __netif_receive_skb net/core/dev.c:6331 [inline]
 process_backlog+0x631/0x1480 net/core/dev.c:6682
 __napi_poll+0xb3/0x320 net/core/dev.c:7749
 napi_poll net/core/dev.c:7812 [inline]
 net_rx_action+0x613/0xed0 net/core/dev.c:7969
 handle_softirqs+0x236/0x800 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xb2/0x1d0 kernel/softirq.c:735
 irq_exit_rcu+0xe/0x20 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1061 [inline]
 sysvec_apic_timer_interrupt+0x6e/0x80 arch/x86/kernel/apic/apic.c:1061
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:__sanitizer_cov_trace_pc+0x67/0x70 kernel/kcov.c:235
Code: 8b 91 48 17 00 00 48 8b 32 48 8d 7e 01 8b 89 44 17 00 00 48 39 cf 73 12 48 c7 c1 00 00 00 11 48 29 c8 48 89 3a 48 89 44 f2 08 <c3> cc cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90010fdfcf8 EFLAGS: 00000286
RAX: ffffffff817c5990 RBX: ffffffff927c5885 RCX: 0000000011000000
RDX: ffffc90003a40000 RSI: 0000000000000128 RDI: 0000000000000129
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff927c5885 R11: ffffed100124c6d4 R12: dffffc0000000000
R13: ffff888105c8d888 R14: 0000000000000001 R15: 0000607e8051c568
 rcu_read_unlock include/linux/rcupdate.h:867 [inline]
 percpu_ref_tryget_many include/linux/percpu-refcount.h:250 [inline]
 percpu_ref_tryget include/linux/percpu-refcount.h:266 [inline]
 css_tryget include/linux/cgroup_refcnt.h:45 [inline]
 cgroup_tryget+0x160/0x2a0 include/linux/cgroup.h:446
 cgroup_sk_alloc+0x26f/0x3f0 kernel/cgroup/cgroup.c:7369
 sk_alloc+0x2e3/0x430 net/core/sock.c:2337
 inet_create+0x773/0x1020 net/ipv4/af_inet.c:333
 __sock_create+0x4b2/0x930 net/socket.c:1665
 sock_create net/socket.c:1723 [inline]
 __sys_socket_create net/socket.c:1760 [inline]
 __sys_socket+0xdc/0x1b0 net/socket.c:1807
 __do_sys_socket net/socket.c:1821 [inline]
 __se_sys_socket net/socket.c:1819 [inline]
 __x64_sys_socket+0x7f/0x90 net/socket.c:1819
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14c/0x480 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe15ab274d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe15c24bc98 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe15ab274d9
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000200000010
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe15c24bce0
R13: 000020000000c000 R14: 0000000000000001 R15: 00007fff200a9f88
 </TASK>
irq event stamp: 1706
hardirqs last  enabled at (1716): [<ffffffff92647651>] __up_console_sem kernel/printk/printk.c:347 [inline]
hardirqs last  enabled at (1716): [<ffffffff92647651>] __console_unlock+0x81/0x90 kernel/printk/printk.c:2932
hardirqs last disabled at (1725): [<ffffffff92647636>] __up_console_sem kernel/printk/printk.c:345 [inline]
hardirqs last disabled at (1725): [<ffffffff92647636>] __console_unlock+0x66/0x90 kernel/printk/printk.c:2932
softirqs last  enabled at (690): [<ffffffff9568e719>] sk_setsockopt+0xa19/0x2ed0 net/core/sock.c:-1
softirqs last disabled at (745): [<ffffffff92463692>] __do_softirq kernel/softirq.c:656 [inline]
softirqs last disabled at (745): [<ffffffff92463692>] invoke_softirq kernel/softirq.c:496 [inline]
softirqs last disabled at (745): [<ffffffff92463692>] __irq_exit_rcu+0xb2/0x1d0 kernel/softirq.c:735
---[ end trace 0000000000000000 ]---
0: reclassify loop, rule prio 0, protocol 03
----------------
Code disassembly (best guess):
   0:	41 5c                	pop    %r12
   2:	41 5d                	pop    %r13
   4:	41 5e                	pop    %r14
   6:	41 5f                	pop    %r15
   8:	5d                   	pop    %rbp
   9:	e9 7d 9b 3c 01       	jmp    0x13c9b8b
   e:	cc                   	int3
   f:	e8 17 3b 18 fd       	call   0xfd183b2b
  14:	b8 f4 ff ff ff       	mov    $0xfffffff4,%eax
  19:	eb e0                	jmp    0xfffffffb
  1b:	e8 0b 3b 18 fd       	call   0xfd183b2b
  20:	48 8d 3d 94 38 29 04 	lea    0x4293894(%rip),%rdi        # 0x42938bb
  27:	44 89 fe             	mov    %r15d,%esi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	b8 ea ff ff ff       	mov    $0xffffffea,%eax
  34:	eb c5                	jmp    0xfffffffb
  36:	e8 f0 3a 18 fd       	call   0xfd183b2b
  3b:	4c                   	rex.WR
  3c:	8b                   	.byte 0x8b
  3d:	b4 24                	mov    $0x24,%ah
  3f:	80                   	.byte 0x80
