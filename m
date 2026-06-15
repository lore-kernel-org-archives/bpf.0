Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0FDDDCD
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 02:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781490047; cv=none; b=Q6LTqmHfdi5sHXzYHrnL6IkxtaiycP8mGChQchuT6ztk29V8b1w/ru841XfoC5oenxxsyq0GFuYJ8+3Lr+5clXsxqCDy+SMnx8FJ0FV/3h/ZOr7WiJ02H83taKG3jeBR2T4I/AaELm+uWY5nFd5Q6Srlzj07nIsZUMh4oNz+3hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781490047; c=relaxed/simple;
	bh=7/wOjaP/HXk4qKHNkHCaKxaSsx7Exu/RhIKB0hzFehw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwNM2U58g/Z+VtSAfAO+QCdTfObhZCOKnaKq/7XBesjfgNWew459sDnxUmq5MUWo7X+EZ98FDijhbR+zMfAlDYKrdmkpecRWKeXQlJWi+bYr4PtnduuOAgnfBWg2FVzDsa8AARFfh5NJwgwha1tg/H1KYDnR4YZwXTN/US5dfOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pkFtUyl+; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pkFtUyl+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781490040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g1+mEynbeaM9pHRTwpnGblex4USrPr1s33iItmx0AzY=;
	b=pkFtUyl+j/sFnet0M8lrSh2MV2zs3aVE5LRWLeVkqtZlPKhpGBySaJqP62C//IgRd7y1O0
	LC1cZyvFrwGHqcHS47Y3PhUsc/2A8ZQCkh+H/Zj7IviSuiWDNF1tj9NLHUAKysBbeAb6/V
	z3DiIhHQPnIdMTlukZjqG+XfMRyU2B4=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev
Subject: [PATCH bpf-next v4 5/6] bpf, sockmap: fix integer overflow in bpf_msg_pop_data() bounds check
Date: Mon, 15 Jun 2026 10:19:58 +0800
Message-ID: <20260615021959.140010-6-jiayuan.chen@linux.dev>
In-Reply-To: <20260615021959.140010-1-jiayuan.chen@linux.dev>
References: <20260615021959.140010-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Sechang Lim <rhkrqnwk98@gmail.com>

start and len are u32, so

	u64 last = start + len;

evaluates start + len in 32-bit and wraps before storing it in last.
The bounds check

	if (start >= offset + l || last > msg->sg.size)
		return -EINVAL;

can then be passed with an out-of-range start/len, after which the pop
loop runs off the end of the scatterlist and sk_msg_shift_left() calls
put_page() on the empty msg->sg.end slot:

  Oops: general protection fault, probably for non-canonical address
  0xdffffc0000000001: 0000 [#1] SMP KASAN PTI
  KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
  RIP: 0010:sk_msg_shift_left net/core/filter.c:2957 [inline]
  RIP: 0010:____bpf_msg_pop_data net/core/filter.c:3103 [inline]
  RIP: 0010:bpf_msg_pop_data+0x753/0x1a10 net/core/filter.c:2984
  Call Trace:
   <TASK>
   bpf_prog_4cc92c278f4d5d56+0x1b1/0x1e8
   bpf_prog_run_pin_on_cpu+0x107/0x320 include/linux/filter.h:746
   sk_psock_msg_verdict+0x357/0x7f0 net/core/skmsg.c:934
   tcp_bpf_send_verdict net/ipv4/tcp_bpf.c:420 [inline]
   tcp_bpf_sendmsg+0x766/0x1ae0 net/ipv4/tcp_bpf.c:583
   __sock_sendmsg+0x153/0x1c0 net/socket.c:802
   __sys_sendto+0x326/0x430 net/socket.c:2265
   __x64_sys_sendto+0xe3/0x100 net/socket.c:2268
   do_syscall_64+0x14c/0x480
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

Widen the addition with a (u64) cast so the bound is evaluated in
64-bit and a len near U32_MAX no longer wraps below msg->sg.size.

While here, change pop from int to u32. It counts bytes against the
unsigned scatterlist lengths and can never be negative, so the signed
type only invites sign-confusion in the pop loop.

Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index f605ab528b1af..73f05907839d7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3048,8 +3048,8 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 	   u32, len, u64, flags)
 {
 	u32 i = 0, l = 0, space, offset = 0;
-	u64 last = start + len;
-	int pop;
+	u64 last = (u64)start + len;
+	u32 pop;
 
 	if (unlikely(flags))
 		return -EINVAL;
-- 
2.43.0

