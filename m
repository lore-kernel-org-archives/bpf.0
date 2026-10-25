Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792971945;
	b=MCvgJphM1b79H+F1TmWGQhCjFIf8ZORBXQqQEwRz/SmL3V4491OSOLASgGS0ZXAmjpUv
	 JDZpMFxQP/xO7Y8+r+9b9ujffo572MUsUFw1iAFFAx6iS6LLcua7eRz0YSoYy4vB85Fif
	 kLq1wkObSH24XrcQMYcqNsVfOB3X63pQXJoc8aQSHukpIpw2GK4lIIu4k8zd5VwSspxlQ
	 Y3uXNXtS8j6KQFpuzKGLzwsmIdWT9NRioDCG1apdkGJbHjhBQ8muoYmcibAzaHtHUkmXk
	 iKhBfNdOQnWaTGl7LCP08NK0deH9Q9gLNbSrvoHb4j5bkT/LluwZ+zk9hRKAkotkjnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971945;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=nDw9i3Z2SirvRvn+BaVz+MSjkgG+3Zolh5xd3HzvrVo=;
	b=mr2Z4JKva9yfBMVuL0kVPutN1QUfWwsfEGeJ1Q797eLZudziEJhxqEDiZWjn28u6FMLo
	 qQZGgvLe3hvQYb3UW1P3O5z+UgDIsKknodR14QM1+GGLelmC8rikSNa9MU0Qhk1rNKZcM
	 l11kwRawlw0dobjGQNJdkAxmO0sCW2GzlNLAW43f+LnEUUrETyVBmjMWL3lSmdtKjKORr
	 weFMo9kKH7+d0xnBpr3tBT7+p7QBlAu1NQqn94Brs5y6ljVjU5MHq0JPuTGwY77bJp74V
	 QpPPkWeuEqqyBRvBHd5ROE+cgv2SWvnLQCzMxEliqKL5ALWhuR05TMYlqX3TgCsU/HQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ergdZ05P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1D2606A31A;
	Sun, 25 Oct 2026 23:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ergdZ05P
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792971944;
	b=K9k9lyhSXnfRapDSnG9lvMWg5wxZqez+wIiZPoos7L8/lYvq7U74PbxMVAJWB9Ci/Js5
	 WQDanfb9DhwwgatB+0Tgg4QM+IuvNXAoBuLB+twUhNoybuuZNtgKL8O9x3gWTXX8C078U
	 IvIYUZSmlh4b2Eq7l+AB58XE2b+EWgq2oIEfZ33kUznkK+KaGghsFunBWMHY7Vk9B8re7
	 vZP1yIRqSaTAjwIaFw6gWF5vPVSitXPq08ZU84XRtEV4+Ai3uhSnjDSFUHCWrk6k1apNf
	 JYlLUIfw+CTSpcbHVCYzNUBf8f6J9I8TxSMkhQq2lSZ1J62LMQdWpuk5R0aKxF+zaRQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792971944;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=nDw9i3Z2SirvRvn+BaVz+MSjkgG+3Zolh5xd3HzvrVo=;
	b=aATNW+gR4PlQ9JWNDL4lxHUIstI6uBYDIqKGrYO5PGY8iqS6LXo7j6MHjcccwMPei4b7
	 k4sGbgHIvEupCWHeDyXRl4iokUOYKIn5ZR8pavXj0awD1M7ks5TAOWoeqn+gBKqjYwB6Z
	 H+JIoQqYgOlqc71EQbD3RlE6wEKqf4TTwFLTjfenxk03SNRSSk1nqz2wYigjgWNS4wbWI
	 beSghhn2/0SM4ul2GJxS4SpZyhsqi74ioj2SjOCbcT9kUzAj2iBfgqnJm1PixynZWumCO
	 w/xMwjIVVKJaKvmHXuSnV15S/hRiv5SrhIcv2PKV/d85v5oiBQzR58RtNa6hvilQG5Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DA6E31F01825;
	Sun, 25 Oct 2026 23:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792971944;
	bh=nDw9i3Z2SirvRvn+BaVz+MSjkgG+3Zolh5xd3HzvrVo=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=ergdZ05PSlkrgvyJUE0RMjWhQ/BFYhPHbsfaJnvbF9a81FFeO2m0lkty8VHXSndL2
	 rosTagI37VyeYY/3AHK9+JrT+9iw0dFRPf3RS34iJl6EmNXdajMKgMprLHL0T3L27B
	 n3OEiMeUPpBH9U4QeKmPba9gAsUoM9/5lV28RTOEYZ50j4ehYAfaokT02WjBF/498T
	 scao/9HVjvbN67OUr9U5/9mHv+efE0pgupeoVwC/W6qig4iSddFjG3jsdMOUAtjBYP
	 uqavIS3XKZZBDNvmf0NapMFWBq9njUfJ07fua8ow5OQnWo4MxoHLYxcV8CGsbo70QC
	 Tqtis3PW9dyjw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6804F44B2D;
	Sun, 25 Oct 2026 23:45:43 +0000 (UTC)
From: Eli Skeggs via B4 Relay <devnull+kernel.eliskeggs.com@kernel.org>
Subject: [PATCH bpf 0/2] bpf, sockmap: Fix dropped data and EPIPE on empty
 skb redirect
Date: Sun, 25 Oct 2026 16:41:56 -0700
Message-Id: <20261025-sockmap-bare-fin-v1-0-bb8feae7c4a7@eliskeggs.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQrCMBAFf6W8swtJhCr+inhI1o2uYhqyVYTSf
 zfqcQZmFpg0FcNhWNDkpaZT6eA3A/gay0VIz50RXBi9C45s4vsjVkqxCWUtJD7v/eh4y7uEntU
 mWd+/5RGpZpz+0p7pJjx/Z1jXDweIJxJ5AAAA
X-Change-ID: 20261020-sockmap-bare-fin-e1f8160c3c7b
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Cong Wang <cong.wang@bytedance.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Eli Skeggs <kernel@eliskeggs.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792971941; l=1845;
 i=kernel@eliskeggs.com; s=20261021; h=from:subject:message-id;
 bh=Wlyiie0CKDzxYgDQSpvxa4sS+tMNMfU2M/Qk54ENhjw=;
 b=tbyYi/j3qg52YiRw/uGwHTvdc1MwNPTaY4YyjbYq3J6a31YmybW5d/zOUFmKzo8P67EOjxD7h
 kZuWm2tJq1YBrVWeIvDgbj0Jp5hebWFSYVm5EGihK9IZk/NKBTSYo5y
X-Developer-Key: i=kernel@eliskeggs.com; a=ed25519;
 pk=38k+FqQ3STTnr2H4HZ7IEseBOHWRDYVhvyMmQlB51gc=
X-Endpoint-Received: by B4 Relay for kernel@eliskeggs.com/20261021 with
 auth_id=1252
X-Original-From: Eli Skeggs <kernel@eliskeggs.com>
Reply-To: kernel@eliskeggs.com

When a socket receives a bare FIN, tcp_read_skb() hands an empty skb to
the attached BPF stream_verdict program. The program may redirect that
skb to another socket. Doing so causes the target socket to report EPIPE
and stop transmitting redirected data. A proxy may see the erroneous
EPIPE and truncate a half-closed connection. Instead of treating a
redirected empty skb as an error, treat a 0 return as an error only when
there is more data to send.

Patch 2 adds a selftest that fails without patch 1.

Tested on x86_64 with virtme-ng, under QEMU without KVM. The new subtest
fails on bpf/master without patch 1, and passes with it. The full
test_progs -t sockmap passes all seven tests and 802 subtests with patch
1.

The bug dates from v6.0 (965b57b469a5), so please consider queueing
patch 1 for stable.

Found while building a sockmap proxy between TCP and MPTCP sockets,
running out-of-tree MPTCP sockmap patches, where the EPIPE caused
half-closed connections to prematurely abort. An LLM helped locate and
reproduce the issue, and proposed an initial fix. I traced the code
path, reviewed and verified the LLM-written test, and simplified its
proposal to a one-line fix.

Signed-off-by: Eli Skeggs <kernel@eliskeggs.com>
---
Eli Skeggs (2):
      bpf, sockmap: Stop reporting EPIPE on zero-length skb redirect
      selftests/bpf: Redirect a bare FIN to another socket's egress

 net/core/skmsg.c                                   |  2 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c       | 74 ++++++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_pass_prog.c   |  8 +++
 3 files changed, 83 insertions(+), 1 deletion(-)
---
base-commit: f909e534f5e34feb2ea2701d54df63e21aa506fc
change-id: 20261020-sockmap-bare-fin-e1f8160c3c7b

Best regards,
--  
Eli Skeggs <kernel@eliskeggs.com>


