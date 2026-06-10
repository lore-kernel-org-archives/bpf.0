Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA234352030
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114376; cv=none; b=rDJ0PjKRKw7LsAo56CKFnKtn/FBuzesRnuPx1ZZ6UR8t+badPxkCIzjvX5NvX6zAdhqgnh9f1JBnVDQHssjk47Auz97cMy9zO2LsO42kZxeHuUBBgXuOz9Sm0CsGtXgPHzT+8xKPjmv2bnskbDSWhbKO4V216EQWWGAHHje8dzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114376; c=relaxed/simple;
	bh=MOH8uvDl49+FgVeTGAfgbY1LaUOs8A8UBGtliJWpA48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DTdv3yCzEdGH5vLW9wc4MTwIVz0G4Nk84NY+nGpHSutPEF7GCcZuhzRv97B9qQcBL8xyc7iQaQcjWRUSv96vz3EKm2X99ELVfxLbTdCLcMO9y0MsV2uCj2ovYcIfDSCrEFlPDl84rApPpcZ2zVh84Gmz7oNJK3pKkpACBV3EoWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOrXu8e5; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOrXu8e5"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-842848fd613so6019403b3a.3
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 10:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781114374; x=1781719174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wE+IA+8Dk7eFT8d7+2Q1/q+SA8sUoegIzrCmxHEg14k=;
        b=eOrXu8e5c6ft/upmrbjYIHBEepU/1etQL7kKI1pChoglqY/hecddzLh8UpHRdizZ0t
         a9pqrkSk66dA66z4GrmF2QUoJemnZ8lTXPgJ+Ku1BG6TXTEOWVXxGJmCDeKwU0H6BGgO
         LGDd8Dd9NcJKUf+fUG9cIt3Ud86n7ke4Y5BMrsNInWekb7jNVaj2YXj2uHUrRHn85m/T
         EjWv5K+yLTlXf9J2mi+ADNh8wbIJueUD/R2znelggZm+MVqGhIzpxgVXXaiOIkk9/psx
         Dz1Ur1g5PljuhTCZmxsWtVEqcyHwzn1oButyELiJxLhEb8i7g7J0z4SoNwPF+JGrY2hc
         ZimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781114374; x=1781719174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wE+IA+8Dk7eFT8d7+2Q1/q+SA8sUoegIzrCmxHEg14k=;
        b=HUZgk2E7qOet4NMCyzCzFE7CcMr4c5Wrp7fhpbs2DjqCG3QGRU614K4sHCTfcpQhR+
         G1gYCkOtX/aAKxWnUCAaFwoS/9Qj8gtBhg2hqhHWaWO+B1EYME00Mfa/NgH+SNNFheoq
         ETc9kG/xTcP6Jg03CeOC49aJ9Lt7poN3GDGJosQIS9vuK+Cr3kjLko0mZ4pY3iJGoKHs
         QN17nhsO15Ykpe9luehW6kCyNfzx4CaNXZTtXO7WUhnOJ7OnzaXK+Z+9w4QLRGYIyj2n
         LjoRj5+AZSlvnKT0bKpHFYTYO1IPreoQ/nL5SiFcLIbGsBqxBsZxg5k1JbCW+p1su4N7
         5RMQ==
X-Forwarded-Encrypted: i=1; AFNElJ8cloO0ViHrU9zuaZ42MNjIfdNCU/NnPhKowSplVy3tIqKreUW46E6XYGQuhpJD6+AGThQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxho9dTIyEwZEYMYxPWznNPIi38Wu6UlfRxNVGNRKZsj4lhiUqN
	oyJbvJvrweAW0SuuU8sCp7OSFHRb+Zz6axLcoiqlNGRi/BtZ4b2QwSeM
X-Gm-Gg: Acq92OEavpa1ZrqgHP1iA4xwnMZqvybeLjeFSM1b8IDJKP2A0u7c6Y5r11yWZrI1wRv
	oiZi2RCx1roH2DZCRJJGNUmJO7KWolzThgc+vzCQ74Bp7pK/QVcnViWtgW58qY+Nb44ssKWO2s6
	/yyL8bIMkvD+V734ukxobTq/MaQtvuIAjrfp8mN1ppJich1dNaJq8sp03BVojjsm8RWAU+XNnRQ
	xzjJXfUT0/9meAGdF8QtvDhPAgEa4K0xcGw7d9vg6GNYYprAxkQq1oeviw0U1kJ3fyGznhzYFqw
	z4S+pMsZF3zKW+DU+m4K4mzjzuHxk75cW55Dm0vfn9Z1+C9HMlEXgSWpVDvh957i4Gx5HwxXPbw
	nKWdfb2HXNMwJMpDLRWTrda7aBYBeKon41Ee48d9dx8kmPDj3ptrQCeI+53FXllkfapJlTvaxEc
	fwkyAHgH8DAlgYU1hX8NS0L3GpdLKStDFwh9WmcW5Yy9z1wuTtNvNd4veE1+ave/woWC66+kSiQ
	V+B5qc43+s=
X-Received: by 2002:a05:6a00:10c2:b0:842:3be7:4d51 with SMTP id d2e1a72fcca58-8430a66ee10mr9635935b3a.15.1781114374097;
        Wed, 10 Jun 2026 10:59:34 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428325d9a3sm25235306b3a.34.2026.06.10.10.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 10:59:33 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Cong Wang <cong.wang@bytedance.com>,
	Alexei Starovoitov <ast@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf, sockmap: take the socket lock in udp_bpf_recvmsg()
Date: Wed, 10 Jun 2026 17:59:17 +0000
Message-ID: <20260610175922.1103871-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

udp_bpf_recvmsg() drains the psock ingress_msg queue through
sk_msg_recvmsg() without holding the socket lock. __sk_msg_recvmsg()
walks the head sk_msg's scatterlist and updates each entry in place
(sge->length -= copy, sge->offset += copy), drops the page once an entry
is consumed, and frees the sk_msg when it is drained. ingress_lock only
serializes the queue list operations, not this per-entry consume;
copy_page_to_iter() can fault, so the loop cannot hold a spinlock.

Two threads calling recvmsg() on the same UDP socket then consume the
same sk_msg at once:

  CPU0                                CPU1

  sk_msg_recvmsg                      sk_msg_recvmsg
    copy = sge->length                 copy = sge->length
    copy_page_to_iter(copy)            copy_page_to_iter(copy)
    sge->length -= copy
      /* sge->length == 0 */
                                       sge->length -= copy
                                         /* underflows to ~0U */

The next pass loads the underflowed length into a signed int, the value
is negative so the copied + copy > len clamp is skipped, and
copy_page_to_iter() is handed ~2^64 as its size_t bytes, which trips
page_copy_sane(). The same race can put_page() one page twice and free
the sk_msg while the other reader still walks it.

  WARNING: CPU: 0 PID: 5484 at lib/iov_iter.c:356 copy_page_to_iter
  WARNING: CPU: 1 PID: 5485 at lib/iov_iter.c:356 copy_page_to_iter
  CPU: 1 UID: 0 PID: 5485 Comm: syz.6.1204 Not tainted 7.1.0-rc7 #1
  RIP: 0010:copy_page_to_iter+0xa9/0x270
  Call Trace:
   <TASK>
   __sk_msg_recvmsg+0x384/0x9a0
   udp_bpf_recvmsg+0x1a0/0x6f0
   sock_recvmsg+0x124/0x150
   __sys_recvfrom+0x1c2/0x2b0
   __x64_sys_recvfrom+0x7b/0x90
   do_syscall_64+0x115/0x6d0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

tcp_bpf_recvmsg_parser() already serializes this with lock_sock() around
__sk_msg_recvmsg(); udp_bpf_recvmsg() does not. Take the socket lock
around the sk_msg_recvmsg() consume so a given ingress sk_msg is drained
by one reader at a time. The wait path is left unlocked, as
udp_msg_wait_data() sleeps without dropping the socket lock.

Fixes: 1f5be6b3b063 ("udp: Implement udp_bpf_recvmsg() for sockmap")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/ipv4/udp_bpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
index 9f33b07b1481..8dd73e9ee1ea 100644
--- a/net/ipv4/udp_bpf.c
+++ b/net/ipv4/udp_bpf.c
@@ -80,7 +80,9 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	}
 
 msg_bytes_ready:
+	lock_sock(sk);
 	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
+	release_sock(sk);
 	if (!copied) {
 		long timeo;
 		int data;
-- 
2.43.0

