Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79C23043C9
	for <bpf@vger.kernel.org>; Sun, 15 Feb 2026 20:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771188238; cv=none; b=VFiz+ezpqiF3vVhQN6KkOpwaU+PPUTQUe8d3VSDSi/i0eQYTlgSrDPmjcLmB9bIF75oh9Vz7EduNDs9q8bdxI2V6GiWLl1e4CvxwLphh5rhL7uQG8u8f1MHZ/kbpCuKjQ3NiQUVV45eKMoHBSrtl++3/CzX1OA5S3sVLMKdOlFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771188238; c=relaxed/simple;
	bh=o+yVCiY78QhoLCqpwKO3FNueFAZmzLearb9gcg4AbIE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qBUvcYIa4TvC8NdCbb1vjdJa3fjzWur/KxCsArjQu9OLsLVtP81sBuyc6ZoshvAKgYjE758xPf+bHPTOLdnLvptbgNwZJMs98zhOhychd6ZD3HUlCu/wmnlRI6XdkT73tqXXt6kyCZviAiRVIDciY+Z/rEFppYznD64lwrnb7ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mLGCj3oU; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mLGCj3oU"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35626b11c51so1929157a91.1
        for <bpf@vger.kernel.org>; Sun, 15 Feb 2026 12:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771188236; x=1771793036; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JDzLkkwQ2zndYGmIa0T9VkXy0vnxohQ08L3DQyRoTBk=;
        b=mLGCj3oUOkA8KWyszuP2lPRDxZg1TRuOwmSXQYwOHakRMe0q5KzBsBs5d9xqLLzm/a
         BPjlXXltnr6EVDurivo6rNvetO+ttukVmfAHG1lhwhgM1AfAu9jPnrHjFnSSy+oJaEQk
         Bjl6YvC7IZ2ajA95Qz/akdFJeHzsblPkCom9ncxufRzkp5tsUdFAeeu+qbNft19lzDHK
         9vWTyg4kNPDu8asG49imJbJxLLlFpiA1KjmWhmdnhpTA6zCJqlRIpuucVZ7K2tj7ETKn
         FYf7sIWXQ2SYquiTsguu6stVqx88kSqfP/J8xvqY7lETdaM2oV3IvH9qyNC0Lgto2vVW
         sJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771188236; x=1771793036;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JDzLkkwQ2zndYGmIa0T9VkXy0vnxohQ08L3DQyRoTBk=;
        b=WNGUf4ySmCIAtTZTb8GfXaTfLY82056Nst+OZQVNuyvtMulGK19R3LDbwj2Cw0jOG3
         TiD0Huhcg8Ded2i33+DbD9yK1mz6lgPXU4jOuHiNMWK9tk6oGIizYmiqqE7VwDunXpVL
         9Gx9lm0KZ6L+W0fwkiJUaQiOaSeHoBNpW7TpZK4y9MyE677ZCYGtI2gOyNW1Dz7VxdK0
         GyeR11MNuFf7o9HBuobjQlPSc20Ayegv5X+jwkgG5pgVqIX/5SwWnPwvYAysQ8i9fxTd
         l6euUIaWSQxEsCHBazCz8YTjEsTyLf6JqaoxhVnWGWZZnExRWwqZMV3EpiFMNBSSRBlJ
         fj/w==
X-Forwarded-Encrypted: i=1; AJvYcCXsNbz8XkU25fcN92WIknHSTbg5G1XVez81o4/uK74C84eMX7KFmOwxAzQQ1Sed2tdfuO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSigA9DYEHq3ho8hPo4omU5cz3Bb5www4aS1Ofi8FVqxzB6RNF
	LSPd4AmLHpnLRb0UBKhj+HyVbTL63ckf8/fpKBxOg2+CTkKSqDbK6H8WGweAg8JV9D15eK7BNZi
	fDPVQKw==
X-Received: from pjbkk11.prod.google.com ([2002:a17:90b:4a0b:b0:354:e865:5165])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:586f:b0:34c:a29d:992a
 with SMTP id 98e67ed59e1d1-356aada821dmr8183369a91.34.1771188236118; Sun, 15
 Feb 2026 12:43:56 -0800 (PST)
Date: Sun, 15 Feb 2026 20:41:35 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260215204353.3645744-1-kuniyu@google.com>
Subject: [PATCH v1 bpf/net 0/6] sockmap: Fix UAF and broken memory accounting
 for UDP.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Cong Wang <cong.wang@bytedance.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot reported 3 issues in SOCKMAP for UDP.

Patch 1 - 2 fix lockless accesses to sk->sk_data_ready()
and sk->sk_write_space().

Patch 3 fixes UAF in sk_msg_recvmsg().

Patch 4 - 5 consolidate sk_psock_skb_ingress_self() into
sk_psock_skb_ingress() as prep for patch 6.

Patch 6 fixes broken memory accounting.


Kuniyuki Iwashima (6):
  sockmap: Annotate sk->sk_data_ready() for UDP.
  sockmap: Annotate sk->sk_write_space() for UDP.
  sockmap: Fix use-after-free in udp_bpf_recvmsg().
  sockmap: Pass gfp_t flag to sk_psock_skb_ingress().
  sockmap: Consolidate sk_psock_skb_ingress_self().
  sockmap: Fix broken memory accounting for UDP.

 include/net/udp.h  |  2 ++
 net/core/skmsg.c   | 90 ++++++++++++++++++----------------------------
 net/core/sock.c    |  2 +-
 net/ipv4/udp.c     | 11 +++++-
 net/ipv4/udp_bpf.c |  9 +++++
 5 files changed, 57 insertions(+), 57 deletions(-)

-- 
2.53.0.310.g728cabbaf7-goog

