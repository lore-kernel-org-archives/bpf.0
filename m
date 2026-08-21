Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610AA3876DF
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 18:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787336720; cv=none; b=hQYJqMuPbGhWfr9sGVoGTp0sTk4pNvT6ShZjORXsmSn3ls2RBRz9YESXq/pttr/b302JDv/JvV5mpyHm02FKAE8qX59ux/KEbuchyutvUXbjn0jpqITUjuoArZL91LaFs1b4ipMK1lqn+nNCzeCL1up0hX2Moza+FNcFO1hAJKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787336720; c=relaxed/simple;
	bh=XmKuM/0b01xWi9YKVoLDLMW2oWBahlMckE8zXLiEyq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mdyhs4RbiTq7WEgUhA1slGm5dVyefVYnaAj6tpUaGPcCFVeKE1QXMdOJ5/OH+5wAqN4DNNHz8pFRyUbYTspbBjD/p+yGMow3073YymffYtINPlNpP/LlsJVAyVsWpqs8JGYtv9kS/In+nNcovU/5zOZCF1SkzRybq5oxwllMG5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gh9kn9QX; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gh9kn9QX"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so1010423a91.2
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 11:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787336718; x=1787941518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BODlkzVUXjqQa90yL80vDBlFyCIYJnEhwn1aK5Y4XIs=;
        b=gh9kn9QXRC6VCpjAdXQ6hneIEFkMosprNIM7FHktLX+reWgR6XF9tL/mhK5kOh0muI
         LY8ClTHwffYcJrdh+f6H1sxXVr0v94AXql/+P4Y4d4y9xsbRYrru3JmG4wHzb/KMpRk5
         /vUZbFcikVGIXvzXnziLaKG4TMjGzc4gNwKf/raZACPWr5IfAakC7lyk83oCCE9hIZUj
         x14L7Js2g/uEF9jzXysJHTt/hz7R5qtmdwEa4uYI+KARnbNdB4QuU98EfKAeXxzQCEJK
         8YVqbgkr9YmwL2XSIq6eESRsXyNEizh7aLX4l40LO+bpJEwTN7l2qqJsVmWqqXAoBF7H
         pBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787336718; x=1787941518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BODlkzVUXjqQa90yL80vDBlFyCIYJnEhwn1aK5Y4XIs=;
        b=LaSuM7plax/73BdyBD1iReo1R6wwiOLdypdTtJfk7e2FiVZvWm0djjGz+TWBpCtVzg
         BOuJ1rYwBoFytO3+Q5kj39k0ArgziWRhQbnnspyCXiAnRO8je0Pdrn1MKBLzNO8nn4H6
         UP+nwUeYDnMxpYKlZuAnBKTduU8h5JiYORnu4shJs5gVYlzRvzoj1+Yb0QP04RkXI2X0
         UcOTIPgdfXHzg68kOHXH4vnakksHhfUAg+oJVTdEokPAerZicEt7D+ut+1kD6t4O/bs4
         6cPzNH6w1ckslzY636VH9f5f213HqBCL2c25DfeirHoTquPWfRRynPBsxhaK5bk570b2
         CS5A==
X-Forwarded-Encrypted: i=1; AHgh+RrN7V4jIzUasQeMaW8QRGIJlj1ifjyvKxzlkx4/CZbzQBNjINFTlL0TAtB4Tmv8IL4/PPE=@vger.kernel.org
X-Gm-Message-State: AFuF++lgOD/eesz43n5FcYxWPo+ddEjjYkponp3XTkNvQkR8Sznwj6sf
	UcDihBUf2lPOAoFRKHdhTuIrTjh9kUAxVL8CRoZ9CpYaBrr5YMzqHN7b
X-Gm-Gg: AR+sD12IcjWOrRfjJO5UNn1V29oj+Qfd00jVQ+J/l/+oXCnmVpQxeygBtozvbXMqmns
	uy2WcNCO8o45iTEOQKC8ym/DIPeRvbuLKX7z7gZFf7Ho2TljAcBC5uWD+/zM/3QPl+lp3bcyIuG
	qLKS+FScXtFRUmbhHIAV/DKlNiXmz4g9s8FYJlLRT1eZrL4jTgbSLFQkXgSmZ+9DXTbkXauqosg
	6uHtJdV6m6ZEBh5Giz/svFtpRnSPlYYwk5UGgxcwafV8tvnl7yA2lMLs6i1LMEHWinsTa1xm4Mt
	MCS37MfS5l6ZgZ2eLvHLmK4CT9CaYMV/VT0Cz/dCBdjnsrMnqWBbqRjEYIMOi8wgZKIR74ifJRB
	JprAYG7ULAxpHJ7MieTCKyVNGGYPjhFBPm40WmoEZjEnzCp0fPIuy6b5RD5notWqPmrlNDaGblk
	Eq0VaGZm7gNqOQs0eE1yPTA39d7R7rVsHTMkzP8YX3vHVqwUVwS8clnW9nMePFA/25yaniUKgrn
	34N7nXOY+Z9ZycHova9uSD9VYicJy136n7g
X-Received: by 2002:a17:90b:3149:b0:38e:ad9d:1151 with SMTP id 98e67ed59e1d1-395c33ec565mr14588270a91.4.1787336718383;
        Fri, 21 Aug 2026 11:25:18 -0700 (PDT)
Received: from localhost.localdomain ([2001:4898:a800:1012:54e3:69b5:423e:871a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c45539a1sm4243013a91.3.2026.08.21.11.25.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 11:25:17 -0700 (PDT)
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
Subject: [PATCH net 1/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)
Date: Fri, 21 Aug 2026 14:24:48 -0400
Message-ID: <20260821182449.79785-2-blbllhy@gmail.com>
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

do_tcp_getsockopt() reads icsk->icsk_ca_ops->name without holding
rcu_read_lock(). Since commit 0baf26b0fcd7 ("bpf: tcp: Support
tcp_congestion_ops in bpf"), icsk_ca_ops can point to dynamically
allocated BPF struct_ops memory that may be freed concurrently via
setsockopt(TCP_CONGESTION), leading to a use-after-free.

  BUG: KASAN: slab-use-after-free in _copy_to_user+0x37/0x60
  Read of size 16 at addr ffff888013505260 by task exploit/149
   _copy_to_user+0x37/0x60
   do_tcp_getsockopt+0x158a/0x2460 (net/ipv4/tcp.c:4585)
   tcp_getsockopt+0x91/0xf0
   __sys_getsockopt+0xf7/0x170

Fix this by holding rcu_read_lock() around the ca_ops->name access and
copying the name to a stack buffer before releasing the lock.

Fixes: 0baf26b0fcd7 ("bpf: tcp: Support tcp_congestion_ops in bpf")
Reported-by: AutonomousCodeSecurity@microsoft.com
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Reported-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
The unsynchronized icsk_ca_ops load also constitutes a data race.
READ_ONCE()/WRITE_ONCE() annotations are intentionally left to a
separate change; related TCP annotation work is available at:
https://lore.kernel.org/all/20260416200319.3608680-1-edumazet@google.com/

 net/ipv4/tcp.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b4237d0e994d..7360ff718f1d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4577,16 +4577,23 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		val = !inet_csk_in_pingpong_mode(sk);
 		break;
 
-	case TCP_CONGESTION:
+	case TCP_CONGESTION: {
+		char ca_name[TCP_CA_NAME_MAX] = {};
+
 		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
 		len = min_t(unsigned int, len, TCP_CA_NAME_MAX);
 		if (copy_to_sockptr(optlen, &len, sizeof(int)))
 			return -EFAULT;
-		if (copy_to_sockptr(optval, icsk->icsk_ca_ops->name, len))
+
+		rcu_read_lock();
+		memcpy(ca_name, icsk->icsk_ca_ops->name, sizeof(ca_name));
+		rcu_read_unlock();
+
+		if (copy_to_sockptr(optval, ca_name, len))
 			return -EFAULT;
 		return 0;
-
+	}
 	case TCP_ULP:
 		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
-- 
2.55.0
