Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE9333EAED
	for <bpf@vger.kernel.org>; Mon,  4 May 2026 21:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777928775; cv=none; b=NikVF464+AWtEnz9HBRBaIy9s/YkfdNw/cpeXPz3LT5zc1VwL44CAgx2N6mfi8aVSbUaDC7uO5itSW1OVQiqtxGQ+aPrIbovof/cr5O1OCbM8uOffF0dwYqUO0q0Gr7Q0JL8sVfbmn3Ma2/g6ThHgaAsaPhCidw5H2FwkqT79Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777928775; c=relaxed/simple;
	bh=XNnXMQyTYIsRINKZ+fuKyExOfi5B9sDWIjRfhJKWUM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S8kzQF+qFoiPUmHgbYrxeaYTPeMPCwGEBDRB0d9TflWalVPZkPQIbEZqjjfCtEky3dB5uTzQCwm6B979VTiNVqyX/L+1nkEB45YOUVIbESktlO1hhtX7zrZizoilpg3GlbJlKE1C16nPt0PBhfhHJlLRlOVlHYwJKdM34D4Q6mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MJt3wHcJ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MJt3wHcJ"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b9b8137828so41410195ad.0
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 14:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777928774; x=1778533574; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pG1PifT/WtK1zubWGWAhV6g6QgONGiju6lqkRiDLra8=;
        b=MJt3wHcJ6uQjI24ddqdwK7pom92VnLuZvXP1+hFLKPwEsVYRNnkoiCx+HBodJuIpxr
         BzEOHZgWkQiTA+CFPcwDlFfaSpUjxgZPgQvN/51wGHgDAac0CzGDyvbxWbYDEcR7faYU
         yNmGAh1FVc2jLqh+iPamRNBmrMYnbUm4x6Z4v7ukA3ql0aOnp/RN8uYgffDY54j2qIC9
         FGBxoRgclpIcWQxQ/YdF1Tpdisbb+WGUGyo+fHtFCwFedvAEqIIPLLMgt9AhuI/AiJsK
         84gMkd+WfS5Ynuv5DzJ0PBCEfw5qCE9hYIdJUIuoYtbgopLuDtdqd3hnkzoB7Qg+jAJe
         OeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777928774; x=1778533574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pG1PifT/WtK1zubWGWAhV6g6QgONGiju6lqkRiDLra8=;
        b=dWeIcNynWptuffeuAKLYAlHER9WVwTQgY0VAIivdX0wD5NJZ5THBDEBLFydoRWwgBH
         Eft1r2RJjdosk349UijjOBB7REK3YjErimipdTLxIfDewwtLm3ovAKH5kKI0Gn11598B
         Ok2gEHzuJOALTorcB7OOG8mf88nBdFYJfNuuhhlGGT07CFCwfrCrC4uhwBSX1NKMIPCa
         jUUiYbv/qg2sKsdyYMHEzosiKR+z/LsDuDFLzkdb9CgI5w+nbjGlNxogDk0TAS/fIEnW
         zytdWgNtvFBRkSeiGWpHfHd7KMeizNLTmbDVpI99d53YGbjj1YOS75tlQs7PIaN94FP1
         Hcmg==
X-Forwarded-Encrypted: i=1; AFNElJ93dDS1TgfKGevEA1qx7W+a4l70sK+810GJbI8SF8/Wke9d8ydsKk3N1LO+1bnUxf6nfeY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0GhbEXhY+btVrYgPpvpNYbG6eGrCp6nYv/bYOADIQhaM87n0O
	nhHwGwQ0VZWj38I/qY6lWrPkAKo4KoM6274YpiYTvRoZgWDWGhxS5pc8P+twF4HYr0/3dD+lp0b
	lQJt8zQ==
X-Received: from plty2.prod.google.com ([2002:a17:902:8642:b0:2b5:f921:9e3a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:248:b0:2ba:bfc:76b5
 with SMTP id d9443c01a7336-2ba0bfc88a3mr79496205ad.4.1777928773753; Mon, 04
 May 2026 14:06:13 -0700 (PDT)
Date: Mon,  4 May 2026 21:04:48 +0000
In-Reply-To: <20260504210610.180150-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504210610.180150-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504210610.180150-2-kuniyu@google.com>
Subject: [PATCH v2 bpf 1/6] bpf: tcp: Fix type confusion in bpf_tcp_sock().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Damiano Melotti <melotti@google.com>
Content-Type: text/plain; charset="UTF-8"

bpf_tcp_sock() only checks if sk->sk_protocol is IPPROTO_TCP,
but RAW socket can bypass it:

  socket(AF_INET, SOCK_RAW, IPPROTO_TCP)

Calling bpf_setsockopt() in SOCKOPT prog triggers out-of-bounds
access to another slab object. [0]

Let's use sk_is_tcp().

[0]:
BUG: KASAN: slab-out-of-bounds in sol_tcp_sockopt (net/core/filter.c:5519)
Read of size 8 at addr ffff88801083d760 by task test_progs/1259

CPU: 1 UID: 0 PID: 1259 Comm: test_progs Tainted: G           OE       7.0.0-11175-gb5c111f4967b #1 PREEMPT(full)
Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
 print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
 kasan_report (mm/kasan/report.c:595)
 sol_tcp_sockopt (net/core/filter.c:5519)
 __bpf_getsockopt (net/core/filter.c:5633)
 bpf_sk_getsockopt (net/core/filter.c:5654)
 bpf_prog_629ba00a1601e9f2__setsockopt+0x86/0x22c
 __cgroup_bpf_run_filter_setsockopt (./include/linux/bpf.h:1402 ./include/linux/filter.h:722 ./include/linux/filter.h:729 kernel/bpf/cgroup.c:81 kernel/bpf/cgroup.c:2026)
 do_sock_setsockopt (net/socket.c:2363)
 __x64_sys_setsockopt (net/socket.c:2406)
 do_syscall_64 (arch/x86/entry/syscall_64.c:63)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
RIP: 0033:0x7f85f82fe7de
Code: 55 48 63 c9 48 63 ff 45 89 c9 48 89 e5 48 83 ec 08 6a 2c e8 34 69 f7 ff c9 c3 66 90 f3 0f 1e fa 49 89 ca b8 36 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 0a c3 66 0f 1f 84 00 00 00 00 00 48 8b 15 e1
RSP: 002b:00007ffe59dcecd8 EFLAGS: 00000202 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f85f82fe7de
RDX: 000000000000001c RSI: 0000000000000006 RDI: 000000000000000d
RBP: 00007ffe59dcef20 R08: 000000000000003c R09: 0000000000000000
R10: 00007ffe59dcef00 R11: 0000000000000202 R12: 00007ffe59dcf268
R13: 0000000000000003 R14: 00007f85f9da5000 R15: 000055b2f3201400
 </TASK>

The buggy address belongs to the object at ffff88801083d280
 which belongs to the cache RAW of size 1792
The buggy address is located 1248 bytes inside of
 allocated 1792-byte region [ffff88801083d280, ffff88801083d980)

Fixes: 655a51e536c0 ("bpf: Add struct bpf_tcp_sock and BPF_FUNC_tcp_sock")
Reported-by: Damiano Melotti <melotti@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index bc96c18df4e0..cd88633f8dc1 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7475,7 +7475,7 @@ u32 bpf_tcp_sock_convert_ctx_access(enum bpf_access_type type,
 
 BPF_CALL_1(bpf_tcp_sock, struct sock *, sk)
 {
-	if (sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP)
+	if (sk_fullsock(sk) && sk_is_tcp(sk))
 		return (unsigned long)sk;
 
 	return (unsigned long)NULL;
-- 
2.54.0.545.g6539524ca2-goog

