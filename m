Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F20C3603D8
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 03:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593104; cv=none; b=lyEtVqVZKBUnsV2p5B6lRHn0PzpotJe8bU/9ukTHAmAb47j9wTXBmMHqSv8OB84W/iHSscw9CiX0DcdX4kh9V+8DPFeqdbGqa9CjLY4CX4XvOBZg7ZahJd82S1KbCYxKkiI7I7TGZrIlKRYsKD1VwmmjqncDosGQ1HI2XykQJ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593104; c=relaxed/simple;
	bh=JScBWDIyq3IPjP1nc3ZaCx+Z8gnodJdx4N1fTXUQfSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j5mo2+HjZpoS9eqb7witCkYDM15l9Xa3O2yfUUmG2uw5dvquagdCrfhHf7sKneI2oP+R86l6BuuHO7db1GQXJgsDBEVOtD7IfQP/B3p3F1IuYoZzNT/xUTR+kddnmbPEQspKkajJoxeojqRiwLwEXl/kyKQXMbj1ppaascodl4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5iNRhV3; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5iNRhV3"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so365371a91.3
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 20:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786593103; x=1787197903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ma6ZbShKO9rAbTtXIbG/48Oqhn/7/NpX4MIE3BGiTqI=;
        b=G5iNRhV3gaI8t2aNDNwg1kvLWVSugu+nC8Hfwb7k/8OYZVHKgqiJtHUek/397QnPdu
         tFAB7e1gknYPWPpRkF6sZE2g8pbGyF1pNcgTuiMhMBGYuYSgmuzEx7ez0tKbgJskWIT4
         emMplJsI5VQSltyv5N9sIOGMlpiSHy3kaxcJpWPJGWIi6il4OYxVXIKqI74/37AmvnO7
         xZwOJ7YQW5cjUH7Ml8fTouJrUILsCMhIXMB85aohn6HZ/n2h2DjVykHpLhQZQRaCmD3C
         2yls+j5zF2AoLWUyIU0HdP4wXtv2tzApGv0/S9pXS+U+Hkr+fwnf1yv8wL6v7AKhhYIz
         lpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786593103; x=1787197903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ma6ZbShKO9rAbTtXIbG/48Oqhn/7/NpX4MIE3BGiTqI=;
        b=pW3se/BIkAGn/Q5ty8I4oqtKETC+DvcIzDW/qfutkjk0QEGXeWS9IC7TQ/6RxRV1yt
         /TD5NTbIRYQMlVPE3cr7DaV5rQltvJm4283oNhlTvAdsI0Jsnos/Yum5KfMvvuQd8Q8Y
         7Sa7kI8Ee+xceCIHM3oRl+VC54Vlf/XKm/v+8uqEn5adrW1MdlaOI1JR6R4j14MTO1pB
         9fbgxGo9Z84hZjvdcif5WIkl9M+X9sMFOOIdqhC4lJ4Ua9Wvssis4EsVmdw/+A6Rwf1O
         DmOx/zkT9R6MhicUXqgTKHR5Sj3ukjPGpz/QDbjQAEUQ3u4Eh5UiGA8yBJWhPK1eMc1F
         qMoQ==
X-Forwarded-Encrypted: i=1; AHgh+RqeFLc/5HwWt2glmKkrjv2ugLa2+3xqB8N0gIQQkcTyplG0JcOwF0McXVzirnMJdgz9FD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq6F+Ix6s7Uonc4pjeCR9RSy07UuY06OWTrl5nrtnsc2BP139y
	EQpA/zqW5sp12Zt173YdidsqLHrsQHj/2YtR0B8O1PAvK2YYjwvdCNeD
X-Gm-Gg: AR+sD123zrFFoqDQ2JHQCh5cWIprc/yML4IdIcotm0nXPeeGfHdGM0O6SV0pzWS3DVS
	NQoQY5cKRfWAo/W51rlJmP1mR1oL74giVQC/23in/lt7RgOcEmCFVaQ5krEldG/y8CPaEL0S+co
	sEjnZkDYnz3O5Ai1NTlE10+h0DsOFqsddldqTsdF6MZ2wmYHHVutVwPD0avlQ/5k2d4HAJ7vwAm
	VvSRfPxtjC6xkck7lbKDuDBQM96ci9MoMyHAilp6kJyBOV4KD6Z6Sd6iCxR7AVYcIynxM0dGpoU
	d7P8B8dIbzaFNLYurVjH/JLZoqUxJCFxMhv5uKC8IiOHbowhZSVtbrlvq7bk9ILmBgWYf+GSO99
	YbfQYq8ZMdL8RjNUrIeW6/ZKAdz4tvYTaDct/HJfom1pDF6LlL/q1b8x+RNIozh6xoQb6Z570em
	grPDIb52Mzx21lAeStTn6Q7MlPW7VLGD4h04NUucqaa7euYp12ubrQ6mU=
X-Received: by 2002:a17:90b:3805:b0:381:5bd6:eb19 with SMTP id 98e67ed59e1d1-3931e2d5ad3mr3082876a91.18.1786593102550;
        Wed, 12 Aug 2026 20:51:42 -0700 (PDT)
Received: from omen-arch ([147.46.124.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931ca612e7sm1625873a91.0.2026.08.12.20.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 20:51:41 -0700 (PDT)
From: Junseo Lim <zirajs7@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Tom Herbert <tom@herbertland.com>
Subject: [PATCH net] net: kcm: Hold RCU read lock while running BPF parser
Date: Thu, 13 Aug 2026 12:51:36 +0900
Message-ID: <20260813035136.106167-1-zirajs7@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kcm_parse_func_strparser() calls bpf_prog_run_pin_on_cpu() which
prevents CPU migration, but does not establish an RCU read-side
critical section. Consequently, BPF map operations can trigger
WARN_ON_ONCE(!bpf_rcu_lock_held()) when called from the KCM strparser
program.

Hold the RCU read lock while running the program.

Fixes: 9b73896a81dc ("kcm: Use stream parser")
Reported-by: Sechang Lim <rhkrqnwk98@gmail.com>
Signed-off-by: Junseo Lim <zirajs7@gmail.com>
---
This issue was found by a custom fuzzer developed by
Sechang Lim <rhkrqnwk98@gmail.com>.

The report could not be reproduced locally.  However, the trace shows
the BPF parser being invoked from strp_work without an RCU read-side
critical section.

Below is an excerpt of the warning:

    WARNING: kernel/bpf/hashtab.c:1547 at htab_lru_map_delete_elem+0x604/0x700, CPU#0: kworker/u4:2/28
    CPU: 0 UID: 0 PID: 28 Comm: kworker/u4:2 Not tainted 7.2.0-rc4-dirty #3 PREEMPT(full)
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
    Workqueue: kstrp strp_work
    RIP: 0010:htab_lru_map_delete_elem+0x604/0x700
    Code: 8f d9 03 48 3b 44 24 30 0f 85 b0 00 00 00 4c 89 e0 48 83 c4 38 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc e8 ec a0 dd ff <0f> 0b e9 35 fa ff ff 44 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 54 fa
    RSP: 0018:ffffc900001cf678 EFLAGS: 00010293
    RAX: ffffffff8e8910f4 RBX: ffff888102bf8800 RCX: ffff888100ce8000
    RDX: 0000000000000000 RSI: ffffffff91df4082 RDI: ffffffff91597ac0
    RBP: ffffc900001cf7f8 R08: 0000000000000000 R09: 0000000000000000
    R10: ffff888106cf6180 R11: ffffffffc020540c R12: ffffc900001cf778
    R13: 1ffff1102019d07f R14: ffff888106cf6140 R15: ffffc90020a65000
    FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 0000001b34521ff8 CR3: 0000000021a28001 CR4: 0000000000370ef0
    Call Trace:
     <TASK>
     bpf_prog_5dda175565b852e0+0x140/0x153
     ? __copy_skb_header+0xba/0x480
     ? __asan_memcpy+0x40/0x70
     ? __skb_clone+0x61/0x8f0
     bpf_prog_run_pin_on_cpu+0xf4/0x330
     kcm_parse_func_strparser+0x60/0xb0
     __strp_recv+0x5d5/0x1880
     __tcp_read_sock+0x181/0x8c0
     ? __pfx_strp_recv+0x10/0x10
     ? __pfx_tcp_read_sock+0x10/0x10
     strp_work+0x20f/0x3c0
     ? __pfx_strp_work+0x10/0x10
     ? lock_acquire+0xf5/0x250
     ? process_scheduled_works+0x9ce/0x13c0
     process_scheduled_works+0xa3f/0x13c0
     ? __pfx_process_scheduled_works+0x10/0x10
     ? assign_work+0x366/0x530
     worker_thread+0x93c/0xe70
     kthread+0x34b/0x460
     ? __pfx_worker_thread+0x10/0x10
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x348/0x700
     ? __pfx_ret_from_fork+0x10/0x10
     ? native_load_tls+0xd/0x40
     ? __switch_to+0x916/0xc30
     ? __pfx_kthread+0x10/0x10
     ret_from_fork_asm+0x19/0x30
     </TASK>

 
 net/kcm/kcmsock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index d469abcd989b..71af69d442f2 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2016 Tom Herbert <tom@herbertland.com>
  */
 
+#include <linux/rcupdate.h>
 #include <linux/bpf.h>
 #include <linux/errno.h>
 #include <linux/errqueue.h>
@@ -391,7 +392,9 @@ static int kcm_parse_func_strparser(struct strparser *strp, struct sk_buff *skb)
 	struct bpf_prog *prog = psock->bpf_prog;
 	int res;
 
+	rcu_read_lock();
 	res = bpf_prog_run_pin_on_cpu(prog, skb);
+	rcu_read_unlock();
 	return res;
 }
 
-- 
2.55.0

