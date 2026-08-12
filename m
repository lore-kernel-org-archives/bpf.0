Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC03440244F
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526245; cv=none; b=kQDya1kvwf0V9PSq3RisFgVsE4eGX/VFjvkypei8IQ3VvK6APCuQdZ1P5VGi4Uq27ocBu54oMmd5/PUXzUoMWCGtymknzeGo8PBrZ8gpheekR5gISxIQ01taftBfYRasUqjq8kJ9wdXTWXBH8j/76qyhGn8u4R/ZHj0MMBN0gzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526245; c=relaxed/simple;
	bh=3pDy7ZawyB/PDbJyqWDUosIh8hYLV9i7c1SKIQGytFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q5/wXHyG7B1UWjBXSRqdPLwCVy7Axh8zCusI3eMeUhx3uX8xhL8+lPZ9vUDWFXJDWWZOz9gS5MPfKPu+VFdCHCcMUQxu+Pvc/sErBpIFwA9437W6V0CGmngacvQl0Bt2KSaFS+D9Yr9BqffkepLd/19U4mzIfiQoxXCGWoHm18k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3BADMQs; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3BADMQs"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso579119a12.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 02:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786526243; x=1787131043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xULuiWh1KrpeQHM+3Drt9WpY27igzO1L4lGjE3eeQTI=;
        b=h3BADMQsChU2gNuYoGFgsZzzwhvvUFXV01zu78D0LCZW+lD3b5taCt+UWmIM1YGD6P
         k4RT5j5ayZct/+XO9BFCwhBp3dY5OmlH12TVen/+A7cDQneSJzSmewQBGWTJnq/hthQ9
         lSeLr2Nba12R4P4TOkMES0tLxFXV9e0UTiM7WqjjUJHviytC0Ad2M5rTN7cq6ZT3hPjF
         8wkFaqZlp2IOC9vP9mESNbXL/uljbhCG+pGl2GB2XY2wGMI1k7EM/hhv8prBbOdwZIQt
         7VZAv8xA0fcxgx3lud8DV1qs4X+4LWPrSotQpSAW19NS0Wh2AHZByD7DApPa1c4UYKR6
         m3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786526243; x=1787131043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xULuiWh1KrpeQHM+3Drt9WpY27igzO1L4lGjE3eeQTI=;
        b=M0gs+KWCIS2mIVGjQwze86pxF/gqtS9kq1THdBJE45sL9LcpuMwSucASj95ERF/mGW
         nu70TeJpm67QcxKr3Pt6GYevgKBlsWupA9vPBkhpBfecucr9vYh1rkmgUdeKdrMHO8v2
         0rrDCjMTL92WevfaK0CDcRZ/YY0lPgjUFyx0d1ukz3dU3Y6XwoLFnOtvzyIK/V/Uwlh3
         JsIbzIsFgC7qxhZN5OAtzAeYc4daR8pfelj26ueMwwKH+9GnzG1dUjM+X4mJ2huebA3C
         jqyItY0iFenLG7R6KK2Xtx4Ioelg4ZI16IFWgpkuMydicVYdputLiPNO5xZn2x0nxKn8
         Yf0g==
X-Forwarded-Encrypted: i=1; AHgh+Rq/7IUGK/NqLyh6VsflXLgs2QJ4lGU8j48P6pvbXfrtOdaEy2cc2XdefIuESwdfNLv6+jc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3NaxG+mp2WqPlaJPm3GJoS2/xGXqCUEPIHgwXPJdMJRc5dubA
	yvqUDeINA6ucTRl1LiYOHcGLaBWp6lrbLO4WLS/qMPT6LvIPp0QBlMj+
X-Gm-Gg: AR+sD12DEUMOHKOMeomFLApoF0ghLAaUK5SnkHlUu/rj+4fJ/krwgU73ncTjCewrRtE
	3NitI+AjCimlgfK1Hy9FXiT0Yy0+lYhuzau7RZOXcL0rDKoQm2zO/oKTt21VuQZ5gbQdVFHJM0g
	dwWwstkE1slK3klPJjux5dd+HCO0o4ZhVPhnKfyIMzbVp8bQlu/sx7hWkMwn8PZnBjMAEhzWany
	NuROVf/OWzHLgqXL357+0/mVtNhKQ3VekqsYbBz+SAetOnKgzUPNW+kMtR7PJo7iUvhyQlhw9Dn
	ntrDzKa1K8zaV74hzWoMd8k9GVwJysaeGkpOiBsjRWiIFWs5XcHyKkZXGf4/kSNafCFfMzBrGKx
	xt1Lvl3T55pq5enzRkm8C564msmNKdSZ26bek4E+IuwREN9DSz/ItjMO3DyPMgh0z6c9+anZZq1
	bFZQ9WiT2vC4KJNvAHyLXwv73gsQ6ROKDf53ZPeYLzsnYOgXMhs3MDoA==
X-Received: by 2002:a05:6a21:4603:b0:3c3:7f50:fc3a with SMTP id adf61e73a8af0-3cc3f821173mr4351966637.33.1786526243132;
        Wed, 12 Aug 2026 02:17:23 -0700 (PDT)
Received: from omen-arch ([147.47.133.73])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbee797c623sm383086a12.3.2026.08.12.02.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 02:17:22 -0700 (PDT)
From: Junseo Lim <zirajs7@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: [PATCH bpf] bpf: Disallow bpf_{g,s}etsockopt() in cgroup UNIX getname hooks
Date: Wed, 12 Aug 2026 18:16:54 +0900
Message-ID: <20260812091654.244752-1-zirajs7@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_bpf_setsockopt() and _bpf_getsockopt() call sock_owned_by_me() for
full sockets, so these helpers expect the socket lock to be held.

BPF_CGROUP_UNIX_GETPEERNAME and BPF_CGROUP_UNIX_GETSOCKNAME run BPF
programs without acquiring the socket lock. A program attached to
either hook can therefore trigger the sock_owned_by_me() warning by
calling bpf_setsockopt() or bpf_getsockopt().

Disallow bpf_setsockopt() and bpf_getsockopt() for CGROUP_UNIX_GETPEERNAME
and CGROUP_UNIX_GETSOCKNAME.

Fixes: 859051dd165e ("bpf: Implement cgroup sockaddr hooks for unix sockets")
Reported-by: Sechang Lim <rhkrqnwk98@gmail.com>
Signed-off-by: Junseo Lim <zirajs7@gmail.com>
---
BPF_CGROUP_RUN_SA_PROG_LOCK() acquires the socket lock around the BPF
program invocation:

#define BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, uaddr, uaddrlen)		\
	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UNIX_CONNECT, NULL)

In contrast, the UNIX getname hooks use BPF_CGROUP_RUN_SA_PROG():

		if (peer)
			BPF_CGROUP_RUN_SA_PROG(sk, uaddr, &err,
					       CGROUP_UNIX_GETPEERNAME);
		else
			BPF_CGROUP_RUN_SA_PROG(sk, uaddr, &err,
					       CGROUP_UNIX_GETSOCKNAME);

So, another possible patch is to take the lock at these call sites,
but I am unsure about the locking semantics in AF_UNIX.

Below is an excerpt of the warning:

	WARNING: ./include/net/sock.h:1799 at bpf_sock_addr_setsockopt+0x12f/0x160, CPU#0: syz.5.18/253
	Call Trace:
	<TASK>
	bpf_prog_55ed9fb09f700adf+0xc0/0xd3
	__cgroup_bpf_run_filter_sock_addr+0x464/0xc80
	unix_getname+0x35e/0x510
	do_getsockname+0x122/0x1c0
	__sys_getsockname+0xc0/0x140
	__x64_sys_getsockname+0x74/0xb0
	do_syscall_64+0xae/0x5e0
	entry_SYSCALL_64_after_hwframe+0x76/0x7e

This issue was found by a custom fuzzer developed by
Sechang Lim <rhkrqnwk98@gmail.com>.

 net/core/filter.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 16845987b244..1e80a52ef86d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8350,10 +8350,8 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		case BPF_CGROUP_UNIX_SENDMSG:
 		case BPF_CGROUP_INET4_GETPEERNAME:
 		case BPF_CGROUP_INET6_GETPEERNAME:
-		case BPF_CGROUP_UNIX_GETPEERNAME:
 		case BPF_CGROUP_INET4_GETSOCKNAME:
 		case BPF_CGROUP_INET6_GETSOCKNAME:
-		case BPF_CGROUP_UNIX_GETSOCKNAME:
 			return &bpf_sock_addr_setsockopt_proto;
 		default:
 			return NULL;
@@ -8373,10 +8371,8 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		case BPF_CGROUP_UNIX_SENDMSG:
 		case BPF_CGROUP_INET4_GETPEERNAME:
 		case BPF_CGROUP_INET6_GETPEERNAME:
-		case BPF_CGROUP_UNIX_GETPEERNAME:
 		case BPF_CGROUP_INET4_GETSOCKNAME:
 		case BPF_CGROUP_INET6_GETSOCKNAME:
-		case BPF_CGROUP_UNIX_GETSOCKNAME:
 			return &bpf_sock_addr_getsockopt_proto;
 		default:
 			return NULL;
-- 
2.55.0

