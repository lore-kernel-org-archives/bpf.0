Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B927F3C4B9A;
	Wed,  1 Jul 2026 23:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782948554; cv=none; b=R20d+HphAIFg5zW9mhjOeeJzGkQX9MpK3JVjk770EwPvsTBvPKOCYzoAk53D4QO4LaUJt764iFzZ0ykSrJ9ymwSfahE/ABO/7EwmCsjHH+tmva5l3OdzG7LajOQaGMTveRp3miSJm2KdKweIm02f/7Nzl97Fjds9t1HcHBY3N/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782948554; c=relaxed/simple;
	bh=/Bi0RxhQ7AixCREoa/o7g9Lz5Ypox2vmDCyc7BGwRdo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r/siQo3O3qDI3PzObGdWElItZuK2RQDDiYD1x4qrSh1w9bZiQx9OLi3kmRzAR6tbdWtKf/ZOrfqdw3yRla2FuSmCWzqgtbN3UiPoaz/6adH168H16Ke7flJNQBxrxgv22z2tGmHC/jiDXDGwklnjh3sqifzU4mJxrrD6v9IcUM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Fs+6g3x6; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Fs+6g3x6"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wf4MY-007jwR-Pb; Thu, 02 Jul 2026 01:29:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=vlJvqb+i6X5xUcFUQzy2WzJVR7z5eeis+FCiQT96SGE=
	; b=Fs+6g3x6ap5j9yUmv3UzXciRE04PVmiYiLBSTVygrAuyTgxl6O3d1CFTJN2/myLi1ZyLF6t7A
	Y9wRS/u7CLHn0pLsB6Ux0SO7kMR1wu9OZdWYAdGKXLBBWuA5/nZR1hob4YllFjqetTUFiLTL0OCOu
	3mO4lBrIdo+9zs+s0ci1+wpwayHL9y/ao/UGS4PAankZ9yLq4WQlwQpuEQx56NO64hv7zrujy4Dah
	YrCRBs/oqzLfgYKh8zvytbKEsyyjbgHFHS64u3WJqxVvGmL82fPrHDDFqMYktJbvkbvszYjFNpQ6d
	JGH5WVf2RRnJmxwtqXFRFhgs8HdUad7Y7HDtlA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wf4MX-0005G7-Uo; Thu, 02 Jul 2026 01:29:02 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wf4MM-00467f-K6;
	Thu, 02 Jul 2026 01:28:50 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf v3 0/4] bpf, sockmap: Fix sockmap leaking UDP socks
Date: Thu, 02 Jul 2026 01:28:18 +0200
Message-Id: <20260702-sockmap-lookup-udp-leak-v3-0-ff8de8782468@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBBFf4XM2pq2UB6u/A/jAsogFaWkhQZD+
 HdLWeiG3dzJvecsYNEotHCJFjDolFW69yE+RSDbsn8gUbXPwClPacoyYrXs3uVAXlp300Cm2p9
 YdqSSCQopkpzVGfj1YLBRcyDfoBoauO9PO1VPlOPG3GqtsqM2n+B3LJR3FY8PVY4RSqjIadIUM
 c0xuZpKz2epg8Pxf0p6TOGekmGGnDJZCFb+KOu6fgHvlyQvGQEAAA==
X-Change-ID: 20260617-sockmap-lookup-udp-leak-bc4e5c5481d7
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Cong Wang <cong.wang@bytedance.com>
Cc: Michal Luczaj <mhal@rbox.co>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.15.2

Fix for UDP sockets getting leaked during sockmap lookup/release.
Accompanied by selftests updates.

Two Sashiko's concerns to be addressed separately:
https://lore.kernel.org/bpf/20260626205814.BAC3C1F000E9@smtp.kernel.org/

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v3:
- selftest: better error handling, ASSERT_*() macros [Sashiko]
- selftest: fix grammar, reorder patches [Kuniyuki]
- Link to v2: https://patch.msgid.link/20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co

Changes in v2:
- selftest: drop the original, adapt old tests
- fix: change approach to rejecting unbound UDP [Kuniyuki]
- Link to v1: https://patch.msgid.link/20260623-sockmap-lookup-udp-leak-v1-0-05804f9308e4@rbox.co

To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Andrii Nakryiko <andrii@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
To: Song Liu <song@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
To: Jiri Olsa <jolsa@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
To: Shuah Khan <shuah@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
To: Eric Dumazet <edumazet@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
To: Paolo Abeni <pabeni@redhat.com>
To: Willem de Bruijn <willemb@google.com>
To: "David S. Miller" <davem@davemloft.net>
To: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
To: Cong Wang <cong.wang@bytedance.com>
Cc: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org

---
Michal Luczaj (4):
      selftests/bpf: Ensure UDP sockets are bound
      bpf, sockmap: Reject unhashed UDP sockets on sockmap update
      selftests/bpf: Adapt sockmap update error handling
      selftests/bpf: Fail unbound UDP on sockmap update

 net/core/sock_map.c                                 |  2 ++
 .../selftests/bpf/prog_tests/sockmap_basic.c        |  6 +++---
 .../selftests/bpf/prog_tests/sockmap_listen.c       | 21 +++++++++++----------
 tools/testing/selftests/bpf/test_maps.c             | 13 ++++++-------
 4 files changed, 22 insertions(+), 20 deletions(-)
---
base-commit: c341792c9c7272cf91c8b17eae929caed7c2a732
change-id: 20260617-sockmap-lookup-udp-leak-bc4e5c5481d7

Best regards,
--  
Michal Luczaj <mhal@rbox.co>

