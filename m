Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75AF3F6C59
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096636; cv=none; b=RT5DrAq7VBOkFHdtx63FgE/erQLztRyIs+DuxVxZVkyhj73q24ZTcxOJStjUc+T6PhQc0hAZAykQAkBjLCwRxjxkrRj2zTl1RBltPwS7FWSwAvEtjTC4PjM0jSU7db4eRAo3NTdfmhiTlzUKcILTunjRPYRZze6BS3eSIEJAhbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096636; c=relaxed/simple;
	bh=lyDZT6aRGiB+hP5IoM3X5eTzuBKBHkOFQtp3yMfAek0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e5KJoJenLHMcKI7xu9qqqBJ5WqS6GK/sRULX2jyU9MDyHM28sohz2A48mElGRnfy/440J3iQ+Bjps7ZQwFLyw1PB83kXYZTqBjVRtpXTRnugX/3sxmYqixBuM0MjkGcwXMiYnEqJBuwAXy4Pbpb/3rbeZqIILuZfcbJTcGmuH/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxzWKUay; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxzWKUay"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso2143527b3a.1
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 02:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786096634; x=1786701434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+0inr0UTTeN+oeqQYahHQXSZLma3x+0LTFbGpSSeLt4=;
        b=AxzWKUay3niUK0Vv+v4AEg12go2cvbGQ57youXt+/hCQERPWJWj5xt55hK0umXdYme
         U/p+HYE2+6drfI2lDzeZ+RiJ65MuGoeatGz1bLCsEeg92ejIRyMnp9F7S7qt8AU/xDey
         IgygG/YASkwhjc6QI3XSH46ASlww+pUbRVFGnTgjFUElIBgKIVShWsL3vI0cQ/vnYFR0
         2e3C4Rr8gf4Ta+0IW6eiFvgCwaTSt8Fyj03whGX6cqbersU+FaxEKRUJDhfzlK4o5/lK
         pEe+sVRoiGLveRXuVRrTewsHu/t7zZwVDPEqhLU23ymieRPRWEZ9ITrQbTwq1KwVmGkc
         xUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786096634; x=1786701434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+0inr0UTTeN+oeqQYahHQXSZLma3x+0LTFbGpSSeLt4=;
        b=LcvjlZqVy9OJo2HINaLwWVAA8avlOBiNSyAOXY/8uM/jzi72irrUSWzBJF4xfojC8m
         xFP9jHyJNx+15KPv4nkAWyb7AaGUpHLAyTzhv4l0hKbqG1mNOu4SRBvYPGfHfSccKljg
         hdFq/Zpz5Qj55INMiV+Q5dlXIRUCWZ/I/qVKMBgSEqyMF+nJf9rPP2ncGYN1IX+jnHhQ
         6Dx60lX8Xf007Q9tMiNkgqBVBCXFmbXlkSinzQdzEgQw7JDkZaQFZQ0sxdFfHYlzBxZA
         csvJL3aeb3H+nPqci1eXTpt1DAed7HNCHKYehj2yCjQw9DrChf/ttFRJtDI81iDFlHrw
         6kvw==
X-Forwarded-Encrypted: i=1; AHgh+RpgsREWiNRHp+R6Dj68hyAS+18Aq+qpOymIA9VYod+SmbfnJRhmgGbixGmNx3mTdEYNcJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7PKO7iFJKyJ7/8a+mB+oQ8hjUOCg1NC/jMqvEzPESOxj6h/XU
	HZYviJb3DBJNE1W/WTPJC+M8i0Y67UL9aoYVwsVKk7+br3JwuU/FUWmv
X-Gm-Gg: AR+sD12YXdngfBww+1DIbGwBiz8sAqlKKPSfTHgboTyXXWmqC3yTT7GVqe/je8JA+82
	liFKp3DW7TIBv2vSBiNw2TKplvP7HJl3pF1h7LZMZ/ixV/zYFdtzjpq8htxcm9WRkmu7NbEd/9J
	OJH4uP5oPGlJPoW7iPxzZj2xDbVspgldwk75HHZ6AKKhcEoCrAr1lhV0Q4+TjRTwGdMqqQftvgC
	WFHIt+r1IVHGsvV8c39EbvUPfDhbOuGdrj8BM/p/W4IrxxU3iJl9op973H6ssBduMt+vZHX8WFN
	IuJIoCKhjNY55D/64BWtNO80QpyrggqseimBpJ0S38Yl+nZYwjoyRr/anBcH4c+7KUfH905TmIN
	AzOlRx8Yc/vix7YX1e1rEwb7AZZgdgS/kBClSBqxVKBkhD0XJ+ng0i/PdWpo5clZ16AgSVI6sGO
	yTmlMGvaawQoiEO9aDWj3jnZCUnkHGRmzonaAL1PJaeWHCox2TV06OHHQVHM773oqThA==
X-Received: by 2002:a05:6a00:8e09:b0:848:7bcf:9a9a with SMTP id d2e1a72fcca58-84f47d112demr13513686b3a.1.1786096633896;
        Fri, 07 Aug 2026 02:57:13 -0700 (PDT)
Received: from omen-arch ([147.46.174.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a55418esm745693b3a.48.2026.08.07.02.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 02:57:13 -0700 (PDT)
From: Junseo Lim <zirajs7@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: BUG: bpf_iter_tcp can trigger inet_csk_listen_stop() WARN_ON(sock_owned_by_user(child))
Date: Fri,  7 Aug 2026 18:57:07 +0900
Message-ID: <20260807095707.224300-1-zirajs7@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

inet_csk_listen_stop() removes a request from the accept queue, locks the
child socket with bh_lock_sock(), and then checks:

	while ((req = reqsk_queue_remove(queue, sk)) != NULL) {
		...
		WARN_ON(sock_owned_by_user(child));
    ...
  }

This assumes that no process context owns the child socket at this point.
However, once a connection is completed for the listener, the child
socket is also visible from the established hash table. 

In the normal connection-completion path, tcp_v4_syn_recv_sock() inserts
the child into ehash via inet_ehash_nolisten(), and
inet_csk_reqsk_queue_add() later stores the same child in req->sk on the
listener accept queue. bpf_iter_tcp can then take the child from ehash and
lock it in bpf_iter_tcp_seq_show().

This is different from the recent bpf_iter_tcp_established_batch
request_sock refcount issue
(https://lore.kernel.org/all/20260803112218.3361213-1-dingning04@gmail.com/).
In this case the socket is already a full child socket, so the iterator
can successfully take a reference and then acquire lock_sock() before the
listener teardown path reaches the child.

If acquiring lock_sock() in the BPF iterator is valid for this socket, 
then the WARN_ON() in inet_csk_listen_stop() may simply encode an invariant
that is no longer true. In that case, removing the WARN_ON() and 
documenting this case may be the right fix.
Otherwise, bpf_iter_tcp may need to skip full child sockets that are still
queued on the listener's accept queue.

I included a C reproducer, below.
  - tested in the bpf/master at 7a3c0289c3c8eb4607dff448ae9ff9f902c813af

This was found by a custom fuzzer developed 
by Sechang Lim <rhkrqnwk98@gmail.com>

Thanks,
Junseo Lim

---

[    5.970506] ------------[ cut here ]------------
[    5.970910] WARNING: net/ipv4/inet_connection_sock.c:1474 at inet_csk_listen_stop+0x85a/0xc10, CPU#0: bpf_iter_tcp_lo/90
[    5.971656] CPU: 0 UID: 0 PID: 90 Comm: bpf_iter_tcp_lo Not tainted 7.2.0-rc4-00484-g7a3c0289c3c8 #87 PREEMPT(full) 
[    5.972340] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.17.0-2-2 04/01/2014
[    5.972955] RIP: 0010:inet_csk_listen_stop+0x85a/0xc10
[    5.973309] Code: 00 00 00 e8 b8 d5 f1 fe e9 7a f9 ff ff e8 8e 70 15 fe 48 8b 3c 24 be 02 00 00 00 e8 a0 d5 f1 fe e9 62 f9 ff ff e8 76 70 15 fe <0f> 0b e9 04 f9 ff ff e8 6a 70 15 fe e8 d5 20 04 fe 84 c0 0f 85 f2
[    5.974547] RSP: 0018:ffffc900004dfc98 EFLAGS: 00010293
[    5.976344] RAX: 0000000000000000 RBX: ffff888107f21a00 RCX: ffffffff83724aca
[    5.976918] RDX: ffff88810613c400 RSI: ffffffff84c7aae2 RDI: ffff888107f21bc0
[    5.977416] RBP: ffff8881073fb3e0 R08: 0000000000000001 R09: 0000000000000001
[    5.977960] R10: 0000000000000000 R11: fffff5200009bf87 R12: 0000000000000000
[    5.978466] R13: 0000000000000001 R14: dffffc0000000000 R15: ffff8881073b0d00
[    5.979354] FS:  00000000005cd400(0000) GS:ffff888193fda000(0000) knlGS:0000000000000000
[    5.979921] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.980685] CR2: 00007ffd196dd820 CR3: 0000000105d33000 CR4: 0000000000750ef0
[    5.981356] PKRU: 55555554
[    5.981547] Call Trace:
[    5.981723]  <TASK>
[    5.981886]  ? __pfx_sock_close+0x10/0x10
[    5.982174]  __tcp_close+0xc04/0xfd0
[    5.982457]  ? __pfx_sock_close+0x10/0x10
[    5.982743]  ? srso_alias_return_thunk+0x5/0xfbef5
[    5.983079]  ? trace_hardirqs_on+0x18/0x1a0
[    5.983390]  ? __pfx_sock_close+0x10/0x10
[    5.983675]  tcp_close+0x31/0xf0
[    5.983915]  ? srso_alias_return_thunk+0x5/0xfbef5
[    5.984244]  inet_release+0x121/0x2b0
[    5.984510]  sock_close+0x96/0x250
[    5.984756]  ? srso_alias_return_thunk+0x5/0xfbef5
[    5.985090]  ? security_file_release+0x2b/0x70
[    5.985404]  ? srso_alias_return_thunk+0x5/0xfbef5
[    5.985735]  __fput+0x39f/0xa00
[    5.985973]  fput_close_sync+0xf6/0x210
[    5.986243]  ? __pfx_fput_close_sync+0x10/0x10
[    5.986587]  ? srso_alias_return_thunk+0x5/0xfbef5
[    5.986924]  __x64_sys_close+0x96/0x110
[    5.987214]  do_syscall_64+0xae/0x5e0
[    5.987475]  ? srso_alias_return_thunk+0x5/0xfbef5
[    5.987805]  ? exc_page_fault+0x85/0xa0
[    5.988086]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    5.988433] RIP: 0033:0x4555ae
[    5.988652] Code: 4d 89 d8 e8 14 1f 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 03 ff ff ff 0f 1f 00 f3 0f 1e fa
[    5.989837] RSP: 002b:00007ffd196de830 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
[    5.990585] RAX: ffffffffffffffda RBX: 0000000000000040 RCX: 00000000004555ae
[    5.991066] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
[    5.991552] RBP: 00007ffd196de840 R08: 0000000000000000 R09: 0000000000000000
[    5.992029] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000040
[    5.992496] R13: 0000000000000005 R14: 0000000000000004 R15: 0000000000000045
[    5.992981]  </TASK>
[    5.993145] Kernel panic - not syncing: kernel: panic_on_warn set ...
[    5.993593] CPU: 0 UID: 0 PID: 90 Comm: bpf_iter_tcp_lo Not tainted 7.2.0-rc4-00484-g7a3c0289c3c8 #87 PREEMPT(full) 
[    5.994318] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.17.0-2-2 04/01/2014
[    5.994976] Call Trace:
[    5.995158]  <TASK>
[    5.995315]  dump_stack_lvl+0xb0/0x110
[    5.995591]  vpanic+0x230/0x5b0
[    5.995824]  panic+0xd0/0xd0
[    5.996045]  ? __pfx_panic+0x10/0x10
[    5.996307]  ? check_panic_on_warn.cold+0x5/0x34
[    5.996630]  ? panic_on_this_cpu+0x1a/0x30
[    5.996920]  ? inet_csk_listen_stop+0x85a/0xc10
[    5.997236]  check_panic_on_warn.cold+0x19/0x34
[    5.997554]  __warn.cold+0x294/0x2d1
[    5.997814]  ? inet_csk_listen_stop+0x85a/0xc10
[    5.998135]  __report_bug+0x2bf/0x470
[    5.998417]  ? __pfx___report_bug+0x10/0x10
[    5.998716]  ? srso_alias_return_thunk+0x5/0xfbef5
[    5.999055]  ? mark_held_locks+0x40/0x70
[    5.999330]  ? srso_alias_return_thunk+0x5/0xfbef5
[    5.999660]  ? lockdep_hardirqs_on_prepare+0xdc/0x1d0
[    6.000016]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.000346]  ? trace_hardirqs_on+0x18/0x1a0
[    6.000639]  ? inet_csk_listen_stop+0x85a/0xc10
[    6.000958]  report_bug+0xab/0x220
[    6.001199]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.001526]  ? inet_csk_listen_stop+0x85c/0xc10
[    6.001843]  handle_bug+0x273/0x2d0
[    6.002097]  ? inet_csk_listen_stop+0x85a/0xc10
[    6.002444]  exc_invalid_op+0x1d/0x60
[    6.002703]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.003048]  asm_exc_invalid_op+0x1a/0x20
[    6.003327] RIP: 0010:inet_csk_listen_stop+0x85a/0xc10
[    6.003680] Code: 00 00 00 e8 b8 d5 f1 fe e9 7a f9 ff ff e8 8e 70 15 fe 48 8b 3c 24 be 02 00 00 00 e8 a0 d5 f1 fe e9 62 f9 ff ff e8 76 70 15 fe <0f> 0b e9 04 f9 ff ff e8 6a 70 15 fe e8 d5 20 04 fe 84 c0 0f 85 f2
[    6.004883] RSP: 0018:ffffc900004dfc98 EFLAGS: 00010293
[    6.005240] RAX: 0000000000000000 RBX: ffff888107f21a00 RCX: ffffffff83724aca
[    6.005710] RDX: ffff88810613c400 RSI: ffffffff84c7aae2 RDI: ffff888107f21bc0
[    6.006181] RBP: ffff8881073fb3e0 R08: 0000000000000001 R09: 0000000000000001
[    6.006733] R10: 0000000000000000 R11: fffff5200009bf87 R12: 0000000000000000
[    6.007784] R13: 0000000000000001 R14: dffffc0000000000 R15: ffff8881073b0d00
[    6.008799]  ? inet_csk_listen_stop+0x85a/0xc10
[    6.009123]  ? inet_csk_listen_stop+0x85a/0xc10
[    6.009443]  ? __pfx_sock_close+0x10/0x10
[    6.009726]  __tcp_close+0xc04/0xfd0
[    6.009985]  ? __pfx_sock_close+0x10/0x10
[    6.010283]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.010613]  ? trace_hardirqs_on+0x18/0x1a0
[    6.010907]  ? __pfx_sock_close+0x10/0x10
[    6.011192]  tcp_close+0x31/0xf0
[    6.011431]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.011769]  inet_release+0x121/0x2b0
[    6.012043]  sock_close+0x96/0x250
[    6.012292]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.012620]  ? security_file_release+0x2b/0x70
[    6.012934]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.013263]  __fput+0x39f/0xa00
[    6.013495]  fput_close_sync+0xf6/0x210
[    6.013767]  ? __pfx_fput_close_sync+0x10/0x10
[    6.014079]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.014424]  __x64_sys_close+0x96/0x110
[    6.014698]  do_syscall_64+0xae/0x5e0
[    6.014961]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.015291]  ? exc_page_fault+0x85/0xa0
[    6.015564]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    6.015910] RIP: 0033:0x4555ae
[    6.016127] Code: 4d 89 d8 e8 14 1f 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 03 ff ff ff 0f 1f 00 f3 0f 1e fa
[    6.017315] RSP: 002b:00007ffd196de830 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
[    6.017814] RAX: ffffffffffffffda RBX: 0000000000000040 RCX: 00000000004555ae
[    6.018294] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
[    6.018758] RBP: 00007ffd196de840 R08: 0000000000000000 R09: 0000000000000000
[    6.019227] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000040
[    6.019693] R13: 0000000000000005 R14: 0000000000000004 R15: 0000000000000045
[    6.020171]  </TASK>
[    6.020459] Kernel Offset: disabled
[    6.020715] ---[ end Kernel panic - not syncing: kernel: panic_on_warn set ... ]---

---

// SPDX-License-Identifier: GPL-2.0
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/bpf.h>
#include <linux/types.h>
#include <netinet/in.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/resource.h>
#include <sys/socket.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#ifndef __NR_bpf
#define __NR_bpf 321
#endif

#ifndef BPF_LINK_CREATE
#define BPF_LINK_CREATE 28
#endif

#ifndef BPF_ITER_CREATE
#define BPF_ITER_CREATE 33
#endif

#ifndef BPF_PROG_TYPE_TRACING
#define BPF_PROG_TYPE_TRACING 26
#endif

#ifndef BPF_TRACE_ITER
#define BPF_TRACE_ITER 28
#endif

#ifndef BPF_OBJ_NAME_LEN
#define BPF_OBJ_NAME_LEN 16
#endif

#define DEFAULT_ROUNDS 20000
#define DEFAULT_CLIENTS 64
#define DEFAULT_WORKERS 1
#define DEFAULT_BURN_INSNS 65536
#define READ_BUF_SIZE 4096

#define BTF_MAGIC 0xeb9f
#define BTF_KIND_INT 1
#define BTF_KIND_PTR 2
#define BTF_KIND_ARRAY 3
#define BTF_KIND_STRUCT 4
#define BTF_KIND_UNION 5
#define BTF_KIND_ENUM 6
#define BTF_KIND_FWD 7
#define BTF_KIND_TYPEDEF 8
#define BTF_KIND_VOLATILE 9
#define BTF_KIND_CONST 10
#define BTF_KIND_RESTRICT 11
#define BTF_KIND_FUNC 12
#define BTF_KIND_FUNC_PROTO 13
#define BTF_KIND_VAR 14
#define BTF_KIND_DATASEC 15
#define BTF_KIND_FLOAT 16
#define BTF_KIND_DECL_TAG 17
#define BTF_KIND_TYPE_TAG 18
#define BTF_KIND_ENUM64 19

#define BPF_ALU64_IMM(OP, DST, IMM) \
	((struct bpf_insn){ .code = BPF_ALU64 | BPF_OP(OP) | BPF_K, \
			    .dst_reg = DST, .imm = IMM })
#define BPF_EXIT_INSN() \
	((struct bpf_insn){ .code = BPF_JMP | BPF_EXIT })

union bpf_attr_local {
	struct {
		uint32_t prog_type;
		uint32_t insn_cnt;
		uint64_t insns;
		uint64_t license;
		uint32_t log_level;
		uint32_t log_size;
		uint64_t log_buf;
		uint32_t kern_version;
		uint32_t prog_flags;
		char prog_name[BPF_OBJ_NAME_LEN];
		uint32_t prog_ifindex;
		uint32_t expected_attach_type;
		uint32_t prog_btf_fd;
		uint32_t func_info_rec_size;
		uint64_t func_info;
		uint32_t func_info_cnt;
		uint32_t line_info_rec_size;
		uint64_t line_info;
		uint32_t line_info_cnt;
		uint32_t attach_btf_id;
	} prog_load;
	struct {
		uint32_t prog_fd;
		uint32_t target_fd;
		uint32_t attach_type;
		uint32_t flags;
		uint64_t iter_info;
		uint32_t iter_info_len;
	} link_create;
	struct {
		uint32_t link_fd;
		uint32_t flags;
	} iter_create;
	uint8_t pad[256];
};

struct btf_header {
	uint16_t magic;
	uint8_t version;
	uint8_t flags;
	uint32_t hdr_len;
	uint32_t type_off;
	uint32_t type_len;
	uint32_t str_off;
	uint32_t str_len;
};

struct btf_type {
	uint32_t name_off;
	uint32_t info;
	union {
		uint32_t size;
		uint32_t type;
	};
};

static volatile int stop_workers;

static uint64_t ptr_to_u64(const void *ptr)
{
	return (uint64_t)(uintptr_t)ptr;
}

static long sys_bpf(int cmd, union bpf_attr_local *attr)
{
	return syscall(__NR_bpf, cmd, attr, sizeof(*attr));
}

static void *read_file(const char *path, size_t *size_out)
{
	size_t done = 0;
	off_t size;
	char *buf;
	int fd;

	fd = open(path, O_RDONLY);
	if (fd < 0) {
		perror(path);
		return NULL;
	}

	size = lseek(fd, 0, SEEK_END);
	if (size <= 0 || lseek(fd, 0, SEEK_SET) < 0) {
		perror("lseek");
		close(fd);
		return NULL;
	}

	buf = malloc((size_t)size);
	if (!buf) {
		perror("malloc");
		close(fd);
		return NULL;
	}

	while (done < (size_t)size) {
		ssize_t n = read(fd, buf + done, (size_t)size - done);

		if (n < 0) {
			if (errno == EINTR)
				continue;
			perror("read");
			free(buf);
			close(fd);
			return NULL;
		}
		if (n == 0)
			break;
		done += (size_t)n;
	}

	close(fd);
	*size_out = done;
	return buf;
}

static uint32_t btf_kind(uint32_t info)
{
	return (info >> 24) & 0x1f;
}

static uint32_t btf_vlen(uint32_t info)
{
	return info & 0xffff;
}

static size_t btf_extra_size(const struct btf_type *t)
{
	uint32_t kind = btf_kind(t->info);
	uint32_t vlen = btf_vlen(t->info);

	switch (kind) {
	case BTF_KIND_INT:
	case BTF_KIND_VAR:
	case BTF_KIND_DECL_TAG:
		return 4;
	case BTF_KIND_ARRAY:
		return 12;
	case BTF_KIND_STRUCT:
	case BTF_KIND_UNION:
		return (size_t)vlen * 12;
	case BTF_KIND_ENUM:
	case BTF_KIND_FUNC_PROTO:
		return (size_t)vlen * 8;
	case BTF_KIND_DATASEC:
	case BTF_KIND_ENUM64:
		return (size_t)vlen * 12;
	case BTF_KIND_PTR:
	case BTF_KIND_FWD:
	case BTF_KIND_TYPEDEF:
	case BTF_KIND_VOLATILE:
	case BTF_KIND_CONST:
	case BTF_KIND_RESTRICT:
	case BTF_KIND_FUNC:
	case BTF_KIND_FLOAT:
	case BTF_KIND_TYPE_TAG:
		return 0;
	default:
		fprintf(stderr, "unknown BTF kind %u\n", kind);
		exit(1);
	}
}

static int find_btf_func_id(const char *name)
{
	const struct btf_header *hdr;
	const uint8_t *types, *types_end;
	const char *strs;
	size_t btf_size;
	void *btf;
	uint32_t id = 1;

	btf = read_file("/sys/kernel/btf/vmlinux", &btf_size);
	if (!btf)
		return -1;
	if (btf_size < sizeof(*hdr)) {
		fprintf(stderr, "short BTF header\n");
		free(btf);
		return -1;
	}

	hdr = btf;
	if (hdr->magic != BTF_MAGIC) {
		fprintf(stderr, "unexpected BTF magic 0x%x\n", hdr->magic);
		free(btf);
		return -1;
	}
	if ((size_t)hdr->hdr_len + hdr->type_off + hdr->type_len > btf_size ||
	    (size_t)hdr->hdr_len + hdr->str_off + hdr->str_len > btf_size) {
		fprintf(stderr, "invalid BTF section bounds\n");
		free(btf);
		return -1;
	}

	types = (const uint8_t *)btf + hdr->hdr_len + hdr->type_off;
	types_end = types + hdr->type_len;
	strs = (const char *)btf + hdr->hdr_len + hdr->str_off;

	while (types + sizeof(struct btf_type) <= types_end) {
		const struct btf_type *t = (const struct btf_type *)types;
		size_t rec_size = sizeof(*t) + btf_extra_size(t);

		if (types + rec_size > types_end) {
			fprintf(stderr, "truncated BTF type section\n");
			free(btf);
			return -1;
		}

		if (btf_kind(t->info) == BTF_KIND_FUNC &&
		    t->name_off < hdr->str_len &&
		    strcmp(strs + t->name_off, name) == 0) {
			free(btf);
			return (int)id;
		}

		types += rec_size;
		id++;
	}

	fprintf(stderr, "BTF FUNC %s not found\n", name);
	free(btf);
	return -1;
}

static int load_tcp_iter_prog(uint32_t attach_btf_id, int burn_insns)
{
	static char log_buf[1 << 20];
	static char license[] = "GPL";
	union bpf_attr_local attr;
	struct bpf_insn *insns;
	int insn_cnt;
	int saved_errno;
	int fd;
	int i;

	if (burn_insns < 0)
		burn_insns = 0;

	insn_cnt = burn_insns + 3;
	insns = calloc((size_t)insn_cnt, sizeof(*insns));
	if (!insns) {
		perror("calloc(insns)");
		return -1;
	}

	insns[0] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0);
	for (i = 1; i <= burn_insns; i++)
		insns[i] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1);
	insns[insn_cnt - 2] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0);
	insns[insn_cnt - 1] = BPF_EXIT_INSN();

	memset(&attr, 0, sizeof(attr));
	attr.prog_load.prog_type = BPF_PROG_TYPE_TRACING;
	attr.prog_load.insn_cnt = (uint32_t)insn_cnt;
	attr.prog_load.insns = ptr_to_u64(insns);
	attr.prog_load.license = ptr_to_u64(license);
	attr.prog_load.expected_attach_type = BPF_TRACE_ITER;
	attr.prog_load.attach_btf_id = attach_btf_id;
	memcpy(attr.prog_load.prog_name, "tcpit_burn", sizeof("tcpit_burn"));

	fd = (int)sys_bpf(BPF_PROG_LOAD, &attr);
	if (fd >= 0) {
		free(insns);
		return fd;
	}

	saved_errno = errno;
	if (saved_errno == ENOSPC) {
		fprintf(stderr,
			"BPF_PROG_LOAD without verifier log failed with ENOSPC; "
			"try a smaller burn_insns value\n");
		free(insns);
		errno = saved_errno;
		return -1;
	}

	attr.prog_load.log_level = 1;
	attr.prog_load.log_size = sizeof(log_buf);
	attr.prog_load.log_buf = ptr_to_u64(log_buf);

	fd = (int)sys_bpf(BPF_PROG_LOAD, &attr);
	if (fd < 0) {
		perror("BPF_PROG_LOAD(iter/tcp)");
		if (log_buf[0])
			fprintf(stderr, "verifier log:\n%s\n", log_buf);
	}

	free(insns);
	return fd;
}

static int create_iter_link(int prog_fd)
{
	union bpf_attr_local attr;
	int link_fd;

	memset(&attr, 0, sizeof(attr));
	attr.link_create.prog_fd = (uint32_t)prog_fd;
	attr.link_create.target_fd = 0;
	attr.link_create.attach_type = BPF_TRACE_ITER;
	attr.link_create.flags = 0;
	attr.link_create.iter_info = 0;
	attr.link_create.iter_info_len = 0;

	link_fd = (int)sys_bpf(BPF_LINK_CREATE, &attr);
	if (link_fd < 0)
		perror("BPF_LINK_CREATE(iter/tcp)");
	return link_fd;
}

static int create_iter_fd(int link_fd)
{
	union bpf_attr_local attr;
	int iter_fd;

	memset(&attr, 0, sizeof(attr));
	attr.iter_create.link_fd = (uint32_t)link_fd;
	attr.iter_create.flags = 0;

	iter_fd = (int)sys_bpf(BPF_ITER_CREATE, &attr);
	return iter_fd;
}

static void iter_worker(int link_fd)
{
	char buf[READ_BUF_SIZE];

	while (!stop_workers) {
		int iter_fd = create_iter_fd(link_fd);

		if (iter_fd < 0)
			continue;

		for (;;) {
			ssize_t n = read(iter_fd, buf, sizeof(buf));

			if (n <= 0)
				break;
		}
		close(iter_fd);
	}
	_exit(0);
}

static int make_listener(uint16_t *port_out)
{
	struct sockaddr_in addr;
	socklen_t len = sizeof(addr);
	int one = 1;
	int fd;

	fd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
	if (fd < 0)
		return -1;

	setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));
	setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &one, sizeof(one));

	memset(&addr, 0, sizeof(addr));
	addr.sin_family = AF_INET;
	addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
	addr.sin_port = 0;

	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
		goto fail;
	if (listen(fd, 256) < 0)
		goto fail;
	if (getsockname(fd, (struct sockaddr *)&addr, &len) < 0)
		goto fail;

	*port_out = ntohs(addr.sin_port);
	return fd;

fail:
	close(fd);
	return -1;
}

static int connect_client(uint16_t port)
{
	struct sockaddr_in addr;
	int fd;

	fd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
	if (fd < 0)
		return -1;

	memset(&addr, 0, sizeof(addr));
	addr.sin_family = AF_INET;
	addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
	addr.sin_port = htons(port);

	if (connect(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
		close(fd);
		return -1;
	}

	return fd;
}

static int fill_accept_queue(uint16_t port, int *clients, int max_clients)
{
	int i, n = 0;

	for (i = 0; i < max_clients; i++) {
		int fd = connect_client(port);

		if (fd < 0)
			break;
		clients[n++] = fd;
	}

	return n;
}

static void close_clients(int *clients, int n)
{
	int i;

	for (i = 0; i < n; i++)
		if (clients[i] >= 0)
			close(clients[i]);
}

static int run_round(int clients_per_round)
{
	int *clients;
	uint16_t port;
	int listener;
	int n;

	clients = calloc((size_t)clients_per_round, sizeof(*clients));
	if (!clients)
		return -1;

	listener = make_listener(&port);
	if (listener < 0) {
		free(clients);
		return -1;
	}

	n = fill_accept_queue(port, clients, clients_per_round);
	usleep(100);
	close(listener);
	close_clients(clients, n);
	free(clients);
	return n > 0 ? 0 : -1;
}

int main(int argc, char **argv)
{
	int rounds = DEFAULT_ROUNDS;
	int clients = DEFAULT_CLIENTS;
	int workers = DEFAULT_WORKERS;
	int burn_insns = DEFAULT_BURN_INSNS;
	pid_t *pids;
	int attach_btf_id;
	int prog_fd;
	int link_fd;
	int i;

	printf("[repro] rounds=%d clients=%d workers=%d burn_insns=%d\n",
	       rounds, clients, workers, burn_insns);
	
    attach_btf_id = find_btf_func_id("bpf_iter_tcp");
	if (attach_btf_id < 0)
		return 1;
	printf("[repro] bpf_iter_tcp attach_btf_id=%d\n", attach_btf_id);

	prog_fd = load_tcp_iter_prog((uint32_t)attach_btf_id, burn_insns);
	if (prog_fd < 0)
		return 1;

	link_fd = create_iter_link(prog_fd);
	if (link_fd < 0)
		return 1;

	pids = calloc((size_t)workers, sizeof(*pids));
	if (!pids)
		return 1;

	for (i = 0; i < workers; i++) {
		pids[i] = fork();
		if (pids[i] == 0)
			iter_worker(link_fd);
	}

	for (i = 0; i < rounds; i++) {
		run_round(clients);
		if ((i & 0xff) == 0)
			fprintf(stderr, "[repro] round %d/%d\n", i, rounds);
	}

	stop_workers = 1;
	for (i = 0; i < workers; i++) {
		if (pids[i] > 0) {
			kill(pids[i], SIGTERM);
			waitpid(pids[i], NULL, 0);
		}
	}

	free(pids);
	close(link_fd);
	close(prog_fd);
	return 0;
}
