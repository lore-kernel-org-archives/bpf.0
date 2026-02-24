Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64232EDD6B
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959921; cv=none; b=SUbhXQN785Wurh/V2eoM2z35eSBAop1gvxxaXnI7slbwqZmWI1Y9mZi6SylwiMY1z02x0jQTv4uH5RCNsuxTM4grcHTkNuWbvf+pFeTsusFz4Y82dYZRwVKUcHU3Kx4td8Rg9/2cMi/+7DrdSKpkSRCBaA34A/Syq4GOpB0+c9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959921; c=relaxed/simple;
	bh=UhaOXFzvp0xRnBcWih0gAPZfwOCqaGOD/UR/J+dVFMY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uMxeYIUHNVCyGayNGM48CKRRqtf8Nh5tWgo336bf1IvqmKX88BFScFdYeQjIwhHORlPa9coOZLADQWm1ajW9nvtRjvs93h39YGGDYLncw9iIu1UJEz/vDZUVTXQXP23W+4tK8izVgaCnZK6x1WCMEEyc3IabTY2kRP0MgX+RSC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q3bGebJx; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q3bGebJx"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2adca7aba8bso482615ad.0
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 11:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771959920; x=1772564720; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cXgRQf3fIRodb+7tJB9KXiOa6/PxOLQrBdOHLY8BdvI=;
        b=Q3bGebJxIGx+Dg/csQyBvk84NQcFyT1kXo7U+q8VE5MA1m9Wk37Ry+xkZZIHLlFFNm
         yJnIT7PdP7KduM7b6+7VPjrp1YztpFYOKZuYvl+ItcYemD1muGYuYZzy/5iQqElc7tsn
         ymJLING9zDRVKQjrg5TGWHKnw7ospd8+sbS9/VfH8Mla5WfzvGqplHij92DSeLDCMxrI
         jR4zvypCrUTgvl/yfQl1Oqv/ETakSt1TNRzLF+LuF/qvIifOkI8ZKDAXQAfV3Pq3I3HP
         LLOHNZCsIb5kTzq2WIM/hVECKC/bxOgGzOxDcZDP0qTGHryogGTTlyO0DSq5oC2eLr56
         Jw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959920; x=1772564720;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cXgRQf3fIRodb+7tJB9KXiOa6/PxOLQrBdOHLY8BdvI=;
        b=cQ9hcNAcaD5dzrZWgPiBdnTvyJHp04ej3BLbzAX7btvO1QJ6qDmojw9+MW5r5VaOeZ
         OqNItWh5N5f18Hxc5OjqL7jg126ZGJPjrTWSOKw9NSH2ap9rB48e0I9lHhqyYwto6pHX
         1+1YaYIy0X3tjwBJ8y14cKQhveR4jurJ7MlPXMiMUZmGHzPga6q/HCZhS0q7M/SlOW60
         v0vu+IOTQQZnWwuCE/rD0XRhgvAUrPi17HcqdH/nvFmYm3znYf7TQNMgNCNlT1OQtCKl
         BC7MCDAzFmj8RO2kxXETM4OUd7Tw7JM985Pj/4XyFjXThXK/0nBykFY6Wwnm0QpZdWl/
         ItgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7xb0QoYcqgjQ2GwHt0Pl/91cwyTN4WsgX/IA6wB/1cFb/go5C7PU9xchCQlqyFlVeNNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGbvaYcisIP0OlFhobGsUTZV6xrKGkCipxCReo2VmvWcQxC6KY
	oyLfE78sHw1hK51fp+cxQxk5u8Jl64dGXO8dhXgZupS+moGkmZ0Pt9tolYgyfm2SkoxxMmrD9VW
	ndw==
X-Received: from pjmm7.prod.google.com ([2002:a17:90b:5807:b0:349:8a6d:dfd1])
 (user=jrife job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:124f:b0:2aa:d201:25f6
 with SMTP id d9443c01a7336-2ad7453f2a2mr130978495ad.45.1771959920084; Tue, 24
 Feb 2026 11:05:20 -0800 (PST)
Date: Tue, 24 Feb 2026 19:04:45 +0000
In-Reply-To: <20260224190516.2102048-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260224190516.2102048-1-jrife@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260224190516.2102048-2-jrife@google.com>
Subject: [PATCH net-next v1 1/2] udp: Preserve UDP socket addresses on abort
From: Jordan Rife <jrife@google.com>
To: netdev@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, bpf@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Yusuke Suzuki <yusuke.suzuki@isovalent.com>
Content-Type: text/plain; charset="UTF-8"

Currently, udp_abort() invokes __udp_disconnect() which clears out
socket fields like inet_daddr and inet_dport. This makes fields like
dst_ip4, dst_ip6, and dst_port useless inside cgroup/sock_release BPF
hooks following an abort on a connected UDP socket, since they'll always
equal zero. This differs from the behavior for TCP sockets where a
cgroup/sock_release hook will see the address and port that the socket
was connected to at the time it was aborted. This causes issues in
Cilium where a sock_release hook is used to perform map maintenance when
sockets are released, since Cilium actively destroys connected UDP
sockets in some cases.

Make the behavior consistent between TCP and UDP sockets by not clearing
out these fields in udp_abort(). Instead, just unhash the socket, mark
its state as TCP_CLOSE, and preserve the state of the other fields.

Fixes: f5836749c9c0 ("bpf: Add BPF_CGROUP_INET_SOCK_RELEASE hook")
Reported-by: Yusuke Suzuki <yusuke.suzuki@isovalent.com>
Signed-off-by: Jordan Rife <jrife@google.com>
---
 net/ipv4/udp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index b96e47f1c8a2..01a0a0fbcd56 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3247,7 +3247,9 @@ int udp_abort(struct sock *sk, int err)
 
 	sk->sk_err = err;
 	sk_error_report(sk);
-	__udp_disconnect(sk, 0);
+	sk->sk_state = TCP_CLOSE;
+	sk->sk_prot->unhash(sk);
+	sk_dst_reset(sk);
 
 out:
 	if (!has_current_bpf_ctx())
-- 
2.53.0.414.gf7e9f6c205-goog

