Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AF738D3FE
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 18:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787336736; cv=none; b=GGRWvF43IHOYXiaoX7+nG6zv3BXE67vsFUDASWzCtNv1KBhMg82CL8v21JByNKRxZ1bIK5UUQ2o2gneYSxvxWfNaeUx2DuZOwdbRogbAd+tWfnJiXZdCnZkr1A2jk8JQ2UHpKuXLJ28KQS+/KCXpCGkpLW3wQqFbrWsFJBjFfvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787336736; c=relaxed/simple;
	bh=+jEjnMMcx1Z4BgKf7iCzxIErD7+9CDxFlLEG/VspZIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VIBk69fO07pfCjKV64UYuXDUxrxx1YnDmDVU+MIi99m0gETW/PWGVfxixJkPCrTa3luEH6R/vDa+HJWam2JNDgm64SAGTtjf6jEg/1Tiya/xDDbfyGamOLwtuH1zcWB6R3e7psv0jQk9nQTxtD0C1rdq7W6E6dT/bTNirEd1aJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJk8E6Dd; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJk8E6Dd"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-383cb94f742so1422985a91.3
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 11:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787336732; x=1787941532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F9B7c0XpIh0nkrhvveEJrVj3ZjtXGrKz5tFqZu7UN7Y=;
        b=IJk8E6Ddh/4Or6soIIeUdxTnJCrNTKKr+qwGH6dyvyp61DvObHtxW47t1GbfDgNdUu
         7u53AnjEJ/2c1dFqpg3aokXEpCGu50tqoxUmSCo2zoYvidybeEkgiFzzx8EnlZurqgAW
         wDJPMML+E1gAxrDdJIW8WhykFfgc+mb4ULChucJQddaYpPdCxHy1nykEEtM5abibOblR
         JH6YXBrhm+etQul7HrXcFBP6o2wO4KPI2EjFom0ndOWsgk4juW+VobWt5wa7TaqUlDgm
         7HuMWkzaX2VcEYHiUQnGkv2CXC6V16LfgMXh77xBkRPehomjIi+CZyJKYjXCVt3xOwY1
         i2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787336732; x=1787941532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F9B7c0XpIh0nkrhvveEJrVj3ZjtXGrKz5tFqZu7UN7Y=;
        b=imumUUjPCFKPmBHJKnK+EYPeb+8TVzZhHYoISzGGecAja4490MCFoME126mk+3jrcY
         zuy8KaGwNQn202XOxWeV0cFjWO5GMXtROqiuPMVLUyiqfccHJTr0KgcG88LAdztrdtmm
         f01MAOK6FvXTtaWgaqWODvfNr9nQyfFjtYHbiFBeTJFwPY/1qu5jqO8NqLqOcm5ZLwuk
         AUQGdFynl3JN1p5DFclJCfgbHS7wTtMA/AiyHua/wojeuXvHQ8EtoD6M2KGCBZEdAGFc
         A47G/ILTs9WO8gQGppa7MkPZVpAfl9RLwWAqklQpcXwXlDIXgE3A+Cc5OQrKqPmdW/4n
         JIqw==
X-Forwarded-Encrypted: i=1; AHgh+RqkvGIzIoTJCPrJNANkmwa+Er3L4aHKcUjGsT1lPB80jSy3Ky14mFRfax3fAuNkU1afV3k=@vger.kernel.org
X-Gm-Message-State: AFuF++kXG+hHI/8ploUQanFUt5aERiVoy2ppoSQmUZvKyAz6mNP3M5HY
	pHOGxKPEpcGyUqgadnqE97BoiqxdNmGuwtQMkuUwkOnkatTL43zRpXOm
X-Gm-Gg: AR+sD13VKCUb/1uCMQQp5CwmronJOjg8fFI2HbGuGVpbwS5Gs2Cz7V6tc1IMeZwVgZi
	G+TcFPR+m/smE1ixNRzn9pzdcXAM6Ayy/9qPpiRnJcSeW+HRFmCix+20H0pc9t8gCi9lRoojc0H
	wLNLkvSgoDT672dPg/b+fVTInYzYtMKjk1xaY4jT0ygsTqzwtP9pTEgWAlo9HOrYZ4MDTc+zhy0
	THFqczIvcBISubxcDcq1qq8m/rJCQG58rewRcXTY+3EY3GRiYT0Pjvh33jwx6pKnrWVc3rCcwHV
	YEQfryXf0+6NUuI78cC6PxJ3yqj8uEN/5dMgiEDEGRgY99zc0Yt0XkV7+7HMJgmtbAmg9E8L7L4
	RbKVUza+QLSZC7jV2xO1vlXpDGVO62OkZmWMkIyd9l5cdUWhTL1RVlnIIYjeLd0XyxE1agnwBHk
	vgpZ9cQ/GcrZy1p5PBIJmmyqEcyKodxSfFzYRDNyYq5i9zRabi4p1/lhUdDZv/faNtgsZyUEjGH
	TnSlRlAVlwIPbnBf0AW63V8
X-Received: by 2002:a17:90b:3c50:b0:37c:607b:2cd9 with SMTP id 98e67ed59e1d1-395dec98ad3mr1029902a91.0.1787336732318;
        Fri, 21 Aug 2026 11:25:32 -0700 (PDT)
Received: from localhost.localdomain ([2001:4898:a800:1012:54e3:69b5:423e:871a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c45539a1sm4243013a91.3.2026.08.21.11.25.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 11:25:31 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: edumazet@google.com,
	ncardwell@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: kuniyu@google.com,
	horms@kernel.org,
	yhs@fb.com,
	kafai@fb.com,
	andriin@fb.com,
	ast@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)
Date: Fri, 21 Aug 2026 14:24:49 -0400
Message-ID: <20260821182449.79785-3-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821182449.79785-1-blbllhy@gmail.com>
References: <20260821182449.79785-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_tcp_getsockopt() reads icsk->icsk_ca_ops and dereferences the
get_info function pointer without rcu_read_lock(). With BPF struct_ops
congestion control, ca_ops can point to dynamically allocated memory
that is freed concurrently, resulting in a use-after-free when the
kernel dereferences or calls through the stale pointer.

  BUG: KASAN: slab-use-after-free in do_tcp_getsockopt+0x2037/0x23e0
  Read of size 8 at addr ffff888013701258 by task exploit/149
   do_tcp_getsockopt+0x2037/0x23e0 (net/ipv4/tcp.c:4564)
   tcp_getsockopt+0x91/0xf0
   __sys_getsockopt+0xf7/0x170

Fix this by wrapping the ca_ops load and get_info call within
rcu_read_lock()/rcu_read_unlock().

Fixes: 0baf26b0fcd7 ("bpf: tcp: Support tcp_congestion_ops in bpf")
Reported-by: AutonomousCodeSecurity@microsoft.com
Reported-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
The unsynchronized icsk_ca_ops load also constitutes a data race.
READ_ONCE()/WRITE_ONCE() annotations are intentionally left to a
separate change; related TCP annotation work is available at:
https://lore.kernel.org/all/20260416200319.3608680-1-edumazet@google.com/

 net/ipv4/tcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 7360ff718f1d..43ccd2d37f9c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4562,9 +4562,11 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
 
+		rcu_read_lock();
 		ca_ops = icsk->icsk_ca_ops;
 		if (ca_ops && ca_ops->get_info)
 			sz = ca_ops->get_info(sk, ~0U, &attr, &info);
+		rcu_read_unlock();
 
 		len = min_t(unsigned int, len, sz);
 		if (copy_to_sockptr(optlen, &len, sizeof(int)))
-- 
2.55.0
