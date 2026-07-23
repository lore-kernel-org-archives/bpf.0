Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7C35478D
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 10:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800960; cv=none; b=iBOymAjWHNjQAZ4VOBOtPwJe4xjK602x/o7S6T6oFRC8ApPitw4x6CCB49TX5sl0bQcBeXNZR6gIa7ljSBcYr3jmh43Ycu72lMX7yAT1DIvUnHQayUp2+Avw4C5BeKgLFAkwRK2FXQ9ts+vQeQwBx5EZGPIAj890Wd2ee2BwFgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800960; c=relaxed/simple;
	bh=qVbyZLKZpDLcN7JmTtGvOknHhBQ7fwvm+0yq84cODpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I/3NgU4o6zqys/CxalBb0G/4qGUB0Ib1GoiZJKUe/eM2wmTQYY5pI6GGlep9CAe82Lcv/MBKeblhFMFrKplw0ZBTI+sGxxuhRs/6TIpcCUuLbuoiq9Rx1R04hVAp7IFfTynQikuWnomNCmwRgdoDuFMbrW1YffLNCY+NkpPf1w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auDcTj76; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auDcTj76"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8423f236418so322807b3a.1
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 03:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784800958; x=1785405758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0oZuWeCVt4jnN3f7h6BsmBoSvgZwCue7aDURumcD4Jw=;
        b=auDcTj76O0a6yv0Z6l2/r2L+BaP7a062gnp+EYXJ8Qs+TR7wQbZbJQrzdSgwGMrSKt
         tnS8IP/dXr7y43rEFciG4Cehb+uruwWsxK/JCMESrrGJIvyZttzBaTgDUKQ38JX9KWKT
         vDPSUdosqJ60YIvIvYOHPw5O9vtY5VAjTXNVORgn1Pi8XESPklBaewb/2g7LjA9LUQHW
         szZqj9k9+x3mld2ongNI7eUTfoi/nQTiRx/zVIAhlAU67VQwXS88Gt+9koUMtwMLZk1n
         S0TDpbXMQGjpAC/VrGayPfnjVEcq2Tr+RmyeXBU5LnCVZUXT214MYvsO0Cf6zEEPtIRk
         kW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784800958; x=1785405758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0oZuWeCVt4jnN3f7h6BsmBoSvgZwCue7aDURumcD4Jw=;
        b=bPEH58G9Cd+zUIo4DYmplyQ7i/cFdgkqthFXkRM9B7gvwCpF/jpnShnnhTDVHuefGX
         FXaIZEtVgClDjYAHxK8qN3dtJdwiacEJ9qF27y/RprpCVRab60RG957l1S8bDzNis9/C
         QUxoS/Wuif/32QESwfU/KYUepQkKlebSMTqO1vTjQIbUiMahIuHvcOVqtZ+eeheCl86e
         dOTml7ykAaarpl7vjEq5qmeytr1CrG8guCFcCus8WbuxdxP3ZzNW+0v0w7IubiZaY3P4
         1F6LNpc/cfCyLWKpwQi742+uT2fgSUQghoibbMwtBw5Lf2dtuV+sA7BZIQnXw50q6YRH
         /KVQ==
X-Forwarded-Encrypted: i=1; AHgh+RpQ5+deotGYreslPBA4IThCvqZjbGF2xRopFOzBkMjWaXE2NPcUEPP4cayjyrOLaM/eL0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcOzoP6Jg5lIAOWotnxpgnledlqtP/pVremIZOq6ts58stjB2e
	wODEU/PGWVqlDTTxLzLWCwCo23AVMBbo9fJudanN+oSHgvjGHpCmgGo7
X-Gm-Gg: AR+sD13RWF5+0+cDkk2BC13Kl+9ulqNOQbJPJqoBECCo4l2G9aERHpvpUxEPkJFIK7O
	hz5AIg+fHypBdFEupe90ZZY1gCmzDioV1LmoT5LFiJnRFPruguOBD9362VL9Acud49vhez2Wbz4
	eVLc2ZpxMyXpF8L6PaxNdbhWa9Qta8IQfIYlO15ovFWyKFve1H07WXqpffZxpz06J7V6v8UacgN
	+75+oYYW9LN8y1a6zY2RvdBRPaijvWlKtYi8ontO8iPFDbJKBFUn9x4Qxna7Pfc7gjzIVHwF75X
	KUEpxPeF87bp2bpK1zmq++1bckofPJV9Ih/UUwYJGvMMxaQ7VubLVJJDbkEuDDLVxpCyTxBnkre
	DeZWH7bEXsG0B5uWSDwtr/2f1EuQlKzt6EvUQ5aEfV+QrNfHKaQzXoKqwnBNAakiMxdZV+StY26
	kAmY5hzpM=
X-Received: by 2002:a05:6a21:4cca:b0:39b:d5f1:4ff with SMTP id adf61e73a8af0-3c44b013508mr2403267637.20.1784800957528;
        Thu, 23 Jul 2026 03:02:37 -0700 (PDT)
Received: from omen-arch ([147.46.174.207])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f1a8a1fsm2503729a12.26.2026.07.23.03.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 03:02:36 -0700 (PDT)
From: Junseo Lim <zirajs7@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Junseo Lim <zirajs7@gmail.com>
Subject: [BUG] bpf, net: skb_try_coalesce WARN after bpf_skb_adjust_room on loopback
Date: Thu, 23 Jul 2026 19:02:21 +0900
Message-ID: <20260723100221.475785-1-zirajs7@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

We found an skb coalescing warning in net/core/skbuff.c that is 
reproducible on loopback with a TCX egress BPF program.

The reproducer attaches a TCX egress sched_cls BPF program to lo. The
program calls bpf_skb_adjust_room() with a positive len_diff. Userspace
then sends two small TCPv6 messages over loopback, and the receive path
hits WARN_ON_ONCE(delta < len) in skb_try_coalesce().

Our current understanding of the sequence is:

---
TCX egress:
skb->sk points to the sending socket
bpf_skb_adjust_room() calls bpf_skb_net_grow()
skb_cow_head() expands the skb head
the corresponding socket memory accounting is not updated

RX ingress:
loopback_xmit() calls skb_orphan()
skb->truesize is smaller than the actual skb head allocation
TCP receive-side coalescing computes a too-small delta
skb_try_coalesce() triggers WARN_ON_ONCE(delta < len)
---

bpf_skb_net_grow() currently calls:

	ret = skb_cow_head(skb, meta_len + len_diff);

but does not appear to account for the additional head allocation when
the skb is socket-owned.

We also noticed that skb_cow_head() is called before the encapsulation
flags are fully validated. In particular, the invalid combination

	BPF_F_ADJ_ROOM_ENCAP_L3_IPV4 |
	BPF_F_ADJ_ROOM_ENCAP_L3_IPV6

can still cause the skb layout to change before bpf_skb_adjust_room()
returns an error. This is not necessarily the root cause of the accounting
issue, but it makes the warning easier to trigger. We mention it separately
because invalid input can modify the skb before bpf_skb_adjust_room()
returns an error.

Kernel tested:
Tree: bpf/master
Commit: 94515f3a7d4256a5062176b7d6ed0471938cd51a
Architecture: x86_64
Environment: QEMU x86_64
Command line: console=ttyS0 net.ifnames=0 biosdevname=0 selinux=0 nokaslr panic=0 panic_on_warn=1 oops=panic rdinit=/init

Relevant config options:
CONFIG_BPF=y
CONFIG_BPF_SYSCALL=y
CONFIG_KASAN=y
CONFIG_IPV6=y
CONFIG_NET_SCHED=y
CONFIG_NET_CLS_ACT=y
CONFIG_NET_CLS_BPF=y

Reproducer:
C reproducer: https://gist.github.com/ZirAjs/57176fa32bd4153107e8dc53ba863186

Build:
	gcc -O2 -Wall -static -o skb_try_coalesce_tcx_repro \
		skb_try_coalesce_tcx_repro.c

Run as root inside the QEMU guest:
	./skb_try_coalesce_tcx_repro 100000

Warning log (first WARN only):

[    4.069977] ------------[ cut here ]------------
[    4.070323] WARNING: net/core/skbuff.c:6230 at skb_try_coalesce+0x12cb/0x1830, CPU#1: native-trigger/83
[    4.070945] Modules linked in:
[    4.071168] CPU: 1 UID: 0 PID: 83 Comm: native-trigger Not tainted 7.2.0-rc3-g94515f3a7d42 #4 PREEMPT(lazy) 
[    4.071798] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.17.0-2-2 04/01/2014
[    4.072405] RIP: 0010:skb_try_coalesce+0x12cb/0x1830
[    4.072740] Code: 08 02 0f 84 12 f7 ff ff e8 72 99 88 fd 80 4b 7e 40 e9 04 f7 ff ff e8 64 99 88 fd 90 0f 0b 90 e9 3c fe ff ff e8 56 99 88 fd 90 <0f> 0b 90 e9 66 f7 ff ff e8 48 99 88 fd 48 8b 44 24 18 be 04 00 00
[    4.073943] RSP: 0018:ffffc900001b84e0 EFLAGS: 00010246
[    4.074293] RAX: 0000000000000000 RBX: ffff888104b445f0 RCX: ffffffff8408487a
[    4.074754] RDX: ffff888104ab3180 RSI: 000000000000002c RDI: ffff888104b44450
[    4.075224] RBP: ffff888104b44370 R08: ffff888104b4461c R09: 1ffff11020922e80
[    4.075682] R10: ffffed1020922e81 R11: ffffed1020922e81 R12: ffffc900001b8700
[    4.076167] R13: ffff888104b443e0 R14: 0000000000000008 R15: ffff888104b443ee
[    4.076633] FS:  0000000038554400(0000) GS:ffff8881927a9000(0000) knlGS:0000000000000000
[    4.077169] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.077546] CR2: 00000000004a0034 CR3: 000000010495b000 CR4: 0000000000750ef0
[    4.077983] PKRU: 55555554
[    4.078159] Call Trace:
[    4.078312]  <IRQ>
[    4.078447]  tcp_try_coalesce+0x157/0x680
[    4.078709]  ? __pfx_tcp_try_coalesce+0x10/0x10
[    4.078995]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.079294]  ? __tcp_send_ack.part.0+0x3b8/0x690
[    4.079577]  ? __pfx_tcp_urg+0x10/0x10
[    4.079812]  tcp_queue_rcv+0x7c/0x630
[    4.080063]  tcp_rcv_established+0x1f91/0x34f0
[    4.080336]  ? __pfx_tcp_rcv_established+0x10/0x10
[    4.080627]  ? __pfx_sk_filter_trim_cap+0x10/0x10
[    4.080920]  tcp_v6_do_rcv+0x669/0x15e0
[    4.081170]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.081458]  tcp_v6_rcv+0x2167/0x3530
[    4.081698]  ? __pfx_tcp_v6_rcv+0x10/0x10
[    4.081957]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.082252]  ? raw6_local_deliver+0x2f9/0x750
[    4.082525]  ? __pfx_try_to_wake_up+0x10/0x10
[    4.082798]  ? __pfx_tcp_v6_rcv+0x10/0x10
[    4.083070]  ip6_protocol_deliver_rcu+0x32f/0x10c0
[    4.083365]  ip6_input_finish+0x1c3/0x3a0
[    4.083616]  ip6_input+0xd6/0x200
[    4.083825]  ? sched_balance_find_src_group+0xfa/0x1560
[    4.084154]  ? __pfx_ip6_input+0x10/0x10
[    4.084396]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.084686]  ? __asan_memset+0x27/0x50
[    4.084928]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.085222]  ? ip6_rcv_finish_core.isra.0+0xd4/0xe40
[    4.085521]  ? __pfx_stack_trace_save+0x10/0x10
[    4.085801]  ? __pfx_ip6_input+0x10/0x10
[    4.086071]  ipv6_rcv+0x15c/0x2d0
[    4.086282]  ? __pfx_ipv6_rcv+0x10/0x10
[    4.086519]  ? __pfx___css_rstat_updated+0x10/0x10
[    4.086823]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.087131]  ? _raw_spin_lock_irqsave+0x89/0xe0
[    4.087411]  ? __pfx_call_function_single_prep_ipi+0x10/0x10
[    4.087750]  ? __pfx_call_function_single_prep_ipi+0x10/0x10
[    4.088097]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.088384]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.088677]  __netif_receive_skb_one_core+0x15b/0x260
[    4.088994]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.089616]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
[    4.090023]  ? __pfx_sched_clock_cpu+0x10/0x10
[    4.090656]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.090963]  ? _raw_spin_lock_irq+0x84/0xe0
[    4.091316]  ? __pfx__raw_spin_lock_irq+0x10/0x10
[    4.091628]  __netif_receive_skb+0x23/0x150
[    4.091994]  process_backlog+0x20f/0x670
[    4.093076]  ? __pfx_process_backlog+0x10/0x10
[    4.093471]  __napi_poll+0xbb/0x570
[    4.093710]  net_rx_action+0x4b4/0xdc0
[    4.093954]  ? __pfx_net_rx_action+0x10/0x10
[    4.094298]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.094620]  ? cpuusage_read+0x250/0x290
[    4.094889]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.095741]  ? ktime_expiry_to_cycles+0x34/0x1c0
[    4.096040]  handle_softirqs+0x18d/0x5e0
[    4.096291]  ? __pfx_handle_softirqs+0x10/0x10
[    4.096561]  ? tick_program_event+0x7e/0x100
[    4.096824]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.097129]  do_softirq+0x42/0x60
[    4.097339]  </IRQ>
[    4.097471]  <TASK>
[    4.097609]  __local_bh_enable_ip+0x64/0x70
[    4.097863]  __dev_queue_xmit+0xc69/0x3570
[    4.098148]  ? __pfx___dev_queue_xmit+0x10/0x10
[    4.098424]  ? local_clock_noinstr+0xf/0xf0
[    4.098685]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.098993]  ? _raw_spin_lock+0x83/0xe0
[    4.099239]  ? __pfx__raw_spin_lock+0x10/0x10
[    4.099506]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.099801]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.100123]  ? kfree+0x1c7/0x500
[    4.100325]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.100616]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.100925]  ? enqueue_to_backlog+0x390/0xea0
[    4.101206]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.101500]  ? ftrace_graph_ret_addr+0x1de/0x270
[    4.101793]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.102102]  ? get_reg+0x126/0x260
[    4.102315]  ip6_finish_output2+0xcfb/0x1840
[    4.102583]  ? __pfx_ip6_finish_output2+0x10/0x10
[    4.102870]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.103177]  ? ftrace_graph_ret_addr+0x1de/0x270
[    4.103458]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.103750]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.104048]  ? unwind_next_frame+0x652/0x1db0
[    4.104319]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.104615]  ? ftrace_graph_ret_addr+0x1de/0x270
[    4.104905]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.105200]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.105487]  ? ftrace_graph_ret_addr+0x1de/0x270
[    4.105773]  ip6_finish_output+0x4e1/0xb40
[    4.106057]  ip6_output+0x22d/0x480
[    4.106276]  ? __pfx_ip6_output+0x10/0x10
[    4.106520]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    4.106834]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    4.107158]  ? __pfx_unwind_next_frame+0x10/0x10
[    4.107434]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.107724]  ? bpf_ksym_find+0xf1/0x180
[    4.107975]  ? __pfx_ip6_output+0x10/0x10
[    4.108228]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.108515]  ip6_xmit+0xb2c/0x19a0
[    4.108737]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.109033]  ? __kernel_text_address+0x12/0x40
[    4.109319]  ? __pfx_ip6_xmit+0x10/0x10
[    4.109556]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.109847]  ? stack_trace_save+0x93/0xd0
[    4.110124]  ? __pfx_stack_trace_save+0x10/0x10
[    4.110398]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.110689]  ? ip6_dst_check+0x1e1/0x580
[    4.110944]  ? __pfx_ip6_dst_check+0x10/0x10
[    4.111208]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.111496]  ? bpf_skops_write_hdr_opt.isra.0+0xcf/0x350
[    4.111816]  ? __pfx_bpf_skops_write_hdr_opt.isra.0+0x10/0x10
[    4.112173]  ? __asan_memcpy+0x3c/0x60
[    4.112405]  inet6_csk_xmit+0x295/0x470
[    4.112651]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.112948]  ? __pfx_inet6_csk_xmit+0x10/0x10
[    4.113222]  __tcp_transmit_skb+0x1cd6/0x4750
[    4.113494]  ? __pfx___tcp_transmit_skb+0x10/0x10
[    4.113786]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.114108]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.114395]  ? local_clock_noinstr+0xf/0xf0
[    4.114652]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.114950]  tcp_write_xmit+0xc80/0x6b80
[    4.115202]  ? _copy_from_iter+0x210/0x1780
[    4.115462]  __tcp_push_pending_frames+0xa0/0x310
[    4.115752]  ? skb_page_frag_refill+0x2d9/0x3e0
[    4.116033]  tcp_push+0x503/0x6c0
[    4.116250]  tcp_sendmsg_locked+0x1012/0x3f80
[    4.116519]  ? unwind_next_frame+0x620/0x1db0
[    4.116787]  ? __pfx_tcp_sendmsg_locked+0x10/0x10
[    4.117088]  ? __pfx___might_resched+0x10/0x10
[    4.117362]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.117655]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.117952]  ? __pfx_lock_sock_nested+0x10/0x10
[    4.118240]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.118529]  ? __import_iovec+0x19e/0x620
[    4.118781]  ? __pfx_inet6_sendmsg+0x10/0x10
[    4.119056]  tcp_sendmsg+0x37/0x50
[    4.119270]  inet6_sendmsg+0xb4/0x150
[    4.119494]  ____sys_sendmsg+0x58f/0x950
[    4.119743]  ? __pfx_____sys_sendmsg+0x10/0x10
[    4.120020]  ? __pfx_stack_trace_save+0x10/0x10
[    4.120308]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.120602]  ? stack_depot_save_flags+0x2d/0x970
[    4.120882]  ___sys_sendmsg+0x1ca/0x220
[    4.121134]  ? __pfx____sys_sendmsg+0x10/0x10
[    4.121396]  ? __fput+0x5fb/0xa80
[    4.121609]  ? __x64_sys_close+0x9b/0x120
[    4.121859]  ? do_syscall_64+0xe0/0x5a0
[    4.122360]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    4.122720]  ? __pfx___might_resched+0x10/0x10
[    4.123001]  ? __pfx___might_resched+0x10/0x10
[    4.124111]  __sys_sendmmsg+0x247/0x400
[    4.124395]  ? __pfx___sys_sendmmsg+0x10/0x10
[    4.124673]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.124980]  ? __call_rcu_common.constprop.0+0x433/0xa70
[    4.125466]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.125770]  ? percpu_counter_add_batch+0x8b/0x1c0
[    4.126160]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.126553]  ? fput_close_sync+0x100/0x1f0
[    4.126844]  ? __pfx_fput_close_sync+0x10/0x10
[    4.127236]  ? file_close_fd_locked+0x224/0x2d0
[    4.127632]  __x64_sys_sendmmsg+0xa1/0x110
[    4.127899]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.128242]  ? fpregs_assert_state_consistent+0xab/0x120
[    4.128616]  do_syscall_64+0xe0/0x5a0
[    4.128843]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.129149]  ? exc_page_fault+0x77/0xe0
[    4.129385]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    4.129695] RIP: 0033:0x4454ce
[    4.129893] Code: 4d 89 d8 e8 e4 1d 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 03 ff ff ff 0f 1f 00 f3 0f 1e fa
[    4.130944] RSP: 002b:00007fffdf95cab0 EFLAGS: 00000202 ORIG_RAX: 0000000000000133
[    4.131384] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00000000004454ce
[    4.131799] RDX: 0000000000000002 RSI: 00007fffdf95cb60 RDI: 0000000000000005
[    4.132227] RBP: 00007fffdf95cac0 R08: 0000000000000000 R09: 0000000000000000
[    4.132642] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000006
[    4.133066] R13: 00007fffdf95ce50 R14: 0000000000000002 R15: 00000000004b2120
[    4.133478]  </TASK>

Thanks,
Junseo Lim
