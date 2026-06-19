Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06D633B6D3
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881437; cv=none; b=hQbwjMpK1xlBfLQvhVpzlGMKKJ4aHo0RDpZMTkuuL7UZ/z+UkbuGOhtPcCm0VT0UEYGAYxl7CsY4iqiKUfcrEQzQnHc2XP1OucFTI2DBuCXG4xuD74yDVPWw7FV1T78ahk3H9TmKL2L2jJc/BBEmNgySSHvNeHTFzCyCEv7nPVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881437; c=relaxed/simple;
	bh=n0TaIFU2dlUiY6Vzb+eElnBvXKO/Y+F2CeNOmOSDEpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UrEdBl/jiaR/i8kv/rypc0wSP7951wn5m9+4Yeak3OXfNFCzux8xUAzLRFLRFeij8hO3qSep1xdLaAJBBCz+erg5Owe8eXq/JtU5PVk/P6IGJmXsKmbAmPPGltZoFMlALjQZsXWDNtOrBFe1Ju/4lk0JkcbE612gAowQ/X0DjTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icaPiIDi; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icaPiIDi"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8423610ec93so1925353b3a.2
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 08:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781881436; x=1782486236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p5fF29AhKZUYQkqmksxc4GcdOoLjfu8vsoNrkddfAwM=;
        b=icaPiIDia+iWmEFhB2Z748fn+YVVv6PPRnGMgZMay8iUtTkG7gu1SsqMAw7Skq6vFo
         Aij2rIUYIY5Ft41A0gg2hN0XapAOQGCSm18cZOvew193TwvFWFpbVnPph7wBqub0Q2p4
         Scy1nT3lyVvtRb3bVrddCUwlYbM8K+sT1hdyLtpsjHi/70Ro9zaP3T4AVhhtny0DTdnC
         67LXG+zPFF4ZGoP4zz+3V3M0gFWkKlmdRfKif61AeWvLVLkpgXokbEN6zejedbmUlcoU
         wcBQKVfRezT3RJV52pp/0ptJ6lzVx8rxxSpJssrV7K+G2OpIDj6uYs4sjJPd+Mxa1Gt4
         nlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781881436; x=1782486236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5fF29AhKZUYQkqmksxc4GcdOoLjfu8vsoNrkddfAwM=;
        b=gD+3eZiWlME1UuNICU+oP/8b2GE8QUxX6kwu1gaiWhSwa2cwjCOOD24rAkMFnjxBHk
         qpoqpOq4bGGrknkzEbQSrw7zAq3Ig1TppLaur/KmhJK0e3w2X4LSsfPC1pSS4Eydfs+s
         0jhL0cJHNaH931yHqeOC2RaVAMnonRQ1sSfoYeJrgwTMF8hEeCwDww6YrxrumbbKVkbD
         Bjoap3t8vVzfliRj5U6nIyXc+KI21EOQGJ9QoiHw9BPVuVi/4jj9A7oTjU6YGrSQmW4L
         BltlBnux/7YNHuW1AmpFDfJs5lkirr4GdWjcpihtGmRJ2OvRbqc0C/f7Vt0SPr6vwnEy
         ccrQ==
X-Forwarded-Encrypted: i=1; AFNElJ9F5m8+NXRo3qy/lGqyjNdoXXWZKS+6AEpV6gjM5IbIcxOV/wxEvvhlxqHopxYwRLah0sc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvfmf5euKFXTUq+4oMFO6n6SDnc6XHiDLK6yJXBm7unM8BuBQS
	OOMgp0zMDU5JXoXq23U6DjUwZTE0KP2w62eHpS8oJK/glw5r1yX2bhLS
X-Gm-Gg: AfdE7clMZ18IQiHn/SrnDRooNBMdXTlWgfaWb+BfWPqqIfeTOFKmODYy1t5u3oZ436/
	+KLny8inomL6F5U3fYsIaXyxM3H0bSSAtCzdZY5HsVx8XU9tdZehaW1j8hESB6vWB75IN+zvbwV
	svad73QQAdDnSHiIJBnIyn6gOvn+eeJ4rWaiuYLAdQotwKAJBv0AzDqlcAF+D4jjpKUeOtvQA8y
	6+o/seWsdz7hPQlNUDo9UZYMlsX6JToxVL3QrUVbGjBkG0omFwy+Yyrp88TvU+Lfbyuyfaz8rEY
	LcaQDOznExorELVl0c3lFm8/4Jr2LdNm0YDaFqGQHl6MtxVadrIA7b6X0DiB0aapHJV7DC4zGFY
	gwQdIVbWK5fcW8Ozw6bfbso/RcqqLqI7qAEDyeQE56Ntt6wW0/puf+Nln5OEJyc1VWfPXCLKLUU
	CWBCGPJWXjfAIjUuGUDsic0KAy0rR0Jx3iDBU1T+Usx+fD5nA7gtM=
X-Received: by 2002:aa7:8882:0:b0:842:7e7f:2914 with SMTP id d2e1a72fcca58-8455078a5a4mr4177673b3a.4.1781881435832;
        Fri, 19 Jun 2026 08:03:55 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8455366ec53sm2844747b3a.13.2026.06.19.08.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 08:03:55 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: "D . Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Simon Horman <horms@kernel.org>,
	Ursula Braun <ubraun@linux.ibm.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Guvenc Gulce <guvenc@linux.ibm.com>,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net v2] net/smc: fix out-of-bounds read when sk_user_data holds a sk_psock
Date: Fri, 19 Jun 2026 15:03:41 +0000
Message-ID: <20260619150342.3626224-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SMC stores its smc_sock in the clcsock's sk_user_data tagged
SK_USER_DATA_NOCOPY and reads it back with smc_clcsock_user_data(), which
only strips that flag. sockmap stores a sk_psock in the same field tagged
SK_USER_DATA_NOCOPY | SK_USER_DATA_PSOCK. Nothing keeps both off one
socket, and SMC then casts the sk_psock to an smc_sock.

A passive-open child hits this. It inherits the listener's
smc_clcsock_data_ready(), but sk_clone_lock() clears its NOCOPY
sk_user_data, and a BPF sock_ops program then adds the child to a sockmap,
installing a sk_psock in that field. The inherited callback reads it as an
smc_sock and dereferences a clcsk_* pointer past the end of the sk_psock:

  BUG: KASAN: slab-out-of-bounds in smc_clcsock_data_ready+0x84/0x200 net/smc/af_smc.c:2637
  Read of size 8 at addr ffff8880013b8674 by task syz.6.12484/67930
   <IRQ>
   smc_clcsock_data_ready+0x84/0x200 net/smc/af_smc.c:2637
   tcp_urg+0x24d/0x360 net/ipv4/tcp_input.c:6264
   tcp_rcv_state_process+0x280d/0x4940 net/ipv4/tcp_input.c:7336
   tcp_child_process+0x371/0xa50 net/ipv4/tcp_minisocks.c:1002
   tcp_v4_rcv+0x1eaa/0x2a00 net/ipv4/tcp_ipv4.c:2186
   [...]
   </IRQ>

  Allocated by task 67930:
   sk_psock_init+0x142/0x740 net/core/skmsg.c:766
   sock_hash_update_common+0xd3/0x990 net/core/sock_map.c:1010
   bpf_sock_hash_update+0x114/0x170 net/core/sock_map.c:1229
   __cgroup_bpf_run_filter_sock_ops+0x74/0xa0 kernel/bpf/cgroup.c:1727
   tcp_init_transfer+0x1085/0x1100 net/ipv4/tcp_input.c:6693
   [...]

sk_psock() already guards the other side, returning NULL unless
SK_USER_DATA_PSOCK is set. Make smc_clcsock_user_data() and its RCU
variant return the smc_sock only when sk_user_data carries SMC's tag
alone. A sk_psock then reads back as NULL, which the data_ready and
fallback callbacks already handle.

Fixes: a60a2b1e0af1 ("net/smc: reduce active tcp_listen workers")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/smc/smc.h | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 52145df83f6e..88dfb459b7cc 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -342,13 +342,25 @@ static inline void smc_init_saved_callbacks(struct smc_sock *smc)
 
 static inline struct smc_sock *smc_clcsock_user_data(const struct sock *clcsk)
 {
-	return (struct smc_sock *)
-	       ((uintptr_t)clcsk->sk_user_data & ~SK_USER_DATA_NOCOPY);
+	uintptr_t data = (uintptr_t)clcsk->sk_user_data;
+
+	/*
+	 * Return the smc_sock only if the slot carries SMC's tag alone.
+	 * sockmap stores a sk_psock here tagged SK_USER_DATA_PSOCK; it is
+	 * not an smc_sock and must not be dereferenced as one.
+	 */
+	if ((data & ~SK_USER_DATA_PTRMASK) != SK_USER_DATA_NOCOPY)
+		return NULL;
+	return (struct smc_sock *)(data & SK_USER_DATA_PTRMASK);
 }
 
 static inline struct smc_sock *smc_clcsock_user_data_rcu(const struct sock *clcsk)
 {
-	return (struct smc_sock *)rcu_dereference_sk_user_data(clcsk);
+	uintptr_t data = (uintptr_t)rcu_dereference(__sk_user_data(clcsk));
+
+	if ((data & ~SK_USER_DATA_PTRMASK) != SK_USER_DATA_NOCOPY)
+		return NULL;
+	return (struct smc_sock *)(data & SK_USER_DATA_PTRMASK);
 }
 
 /* save target_cb in saved_cb, and replace target_cb with new_cb */
-- 
2.43.0

