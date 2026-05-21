Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D522D611E
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371587; cv=none; b=nwPwoxlo/6nfSjsoSpMZTkN6jiFnwUoqoeQNICgNc1eQ1h4n1OP/+bct8l4Eear18txey3fqSrh/ER5JGXlF77gPH0hEm2PceIUAGe8HfGJ46CGlYCAg7Imdy3FNTdCwruzd3u8+oAd52QhzSc3Y/AQ+COXG7JWjddiOAyRyjKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371587; c=relaxed/simple;
	bh=flOQwo6EthhGJKrTIzWxVqgufMZk42XG9Rnl/m4cozM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yrc+/k2ywshnWTkabBo+5tKNLIVb1izSshATb0x0RWRqx7pzbfEGNFbzEKg/c6dQKVjopHDxj6PYuq7fY4bGXOwuf+W2WNBgMjgnlMWgB+G929Xmb1WvcJfWY+6R7MkVnVFJCvFuEYJqnYYzWlzTFsL/qUKxE5kG1n1YnBKKsJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2YmLf3G; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2YmLf3G"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36622412e97so4392758a91.2
        for <bpf@vger.kernel.org>; Thu, 21 May 2026 06:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779371585; x=1779976385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9scMsI1aLsfr1bm8JnebjnjIPyM0AlPvA53k1dCeHGc=;
        b=D2YmLf3GfWcJQDPXAPg9dQWYIa++kCoqha2XzdsXMU18T7PskUB5FWIfEWZNYW3srk
         YjWL8LQT0lTYgGnfejh0XUCB5MUtA3LDB2IAspr2veLtriq4b9eq+MtzCN6v2q2rvQcS
         3Vk3CpMpR7+A0f9qWclyJYduxbAF8yUfRCSlRa5ngweAhnTQDZgXlKZU/16Jomb6+o3W
         9jucCTwKxxoUPbXkdrQqUn4fqyWh0QsvAOzTYsAIJ2bLlJUd06CsQ4gO1HSlfMmyk+f0
         k/QIOJpv8MdGdMYeYlzHPZuHrDVgMxypMCXXbGn8L1ILj8xONBAZEWpxNb9QZjizDn+U
         q3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779371585; x=1779976385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9scMsI1aLsfr1bm8JnebjnjIPyM0AlPvA53k1dCeHGc=;
        b=MZzDibND1THiTxf4OgXebYQRcNqFnc49JTvEsji3xD+wXO3zYBLMLbHq+WRdF/Q9PW
         Tp07GERo8OaMpg7R1QcYd+syXu2jcC/IwIZJ6CB2QV4KtBgk8v4ujv0k2/k7h5rNFXlR
         BAFpg8bWTaYvTsu7AiBYAp+xsW/JQX3hyi/yKk1YN1xzUAexIPolIxEyvyECiBKbfvom
         TGptIaMfvTyLi80FJb35y7S2J8fopEzTl19DblyB+6OIr1RAro/wbHtSnCdU8kAU8eIs
         q0CQDRULSX2rQ2O7I6G0KpTPx50/4aNPq3jlXG5m1cN4NVoLCwiIhjEt4TWw/mR75Js9
         uIIA==
X-Forwarded-Encrypted: i=1; AFNElJ8Be9f2n3cJF85SGSEa8+KNvB1CVxsbgin8R1QYJvrIKu+KiyyIAyuaWKwELPKKSG2xSx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXYFCTl22dVCx8v+XZAfnLV4wVLAKPYWW6Bu5/Bu+yVR5H7FWg
	TBgzrz35egsJBsoUy3OuKhovxmxBUUb20LWNQhCyoSDV7ukA7QmPx+EN
X-Gm-Gg: Acq92OHqPGubhi+nPzNlxlhi1bsqI+A6Sd4RxfvRmSSkR9KQXrKLDoqyWbCrzCZlQSI
	Gd6Uq6Y3haEbiC1HZcGvgYo1XasYANI88XHXwkN0Ed3lu8E2Goquk6t7Yw7tVRDPYcZy63EeiGp
	HI4N3SBSkdYyLv3pkaFdJWGSAwIuFL7LP4AuuIwnz+QbjyYHORm7s2XJCczap/F9IGdigWuTSQf
	Fgll1UhYAJzhVf8sonVH1h5Tr7r29r4OdSstdwN7YW/9LmZSmMrujsrQYMF1OT/Vvbp3jj9lQG1
	7hg8D9GeXdzSETJQSh+evXYNlYZgHESK6j2UnghZ9tLFQHZuLzu7i4fatsGKzHQE8zUXnA98cD5
	KmCEy8pHxWu7qZKh3Qqllw9c/nUrC3AhECMkfBG4VP0L/FQnrM8lNz/n6FE2DEIULpYejZ3CgAw
	uxtPJ9Hxjo/6DRQCayjCgsE5lquLNUG10kvB4uo0O3+U5mn7XWdtZOaHS0o+ve8d3iIUKqeU4RF
	u8n0wDf3lVvPPU3ttNnwL/G6Aun4TY=
X-Received: by 2002:a17:902:f70a:b0:2b2:81aa:f6c3 with SMTP id d9443c01a7336-2bea3385eaemr31636605ad.29.1779371585209;
        Thu, 21 May 2026 06:53:05 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:2035:4b1f:d540:7ffb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea98fcb09sm12957365ad.56.2026.05.21.06.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:53:04 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 0/6] bpf-timestamp: support rx side
Date: Thu, 21 May 2026 21:52:38 +0800
Message-Id: <20260521135244.40869-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Previously the series[1] has already supported tx side for BPF
timestamping, now it's time to support rx side.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=68b92ac494eb

---
v2
Link: https://lore.kernel.org/all/20260518082344.96647-1-kerneljasonxing@gmail.com/
1. support tcp rx zc case (Stan)
2. add if-statements for ASSERT_TRUE (sashiko)


Jason Xing (6):
  bpf: Add bpf_ktime_get_real_ns() kfunc
  net: export sock_disable_timestamp() declaration
  bpf: support bpf_setsockopt for bpf timestamping rx feature
  bpf: add BPF_SOCK_OPS_TSTAMP_RCV_CB callback
  bpf: enable bpf timestamping rx in TCP layer
  selftests/bpf: Add RX latency tests for bpf timestamping

 include/net/sock.h                            | 12 +++-
 include/uapi/linux/bpf.h                      | 10 ++-
 kernel/bpf/helpers.c                          |  6 ++
 net/core/filter.c                             |  8 +++
 net/core/sock.c                               | 20 +++++-
 net/ipv4/tcp.c                                | 10 +++
 tools/include/uapi/linux/bpf.h                |  5 ++
 .../bpf/prog_tests/net_timestamping.c         | 71 ++++++++++++++++++-
 .../selftests/bpf/progs/net_timestamping.c    | 35 +++++++++
 9 files changed, 172 insertions(+), 5 deletions(-)

-- 
2.43.7

