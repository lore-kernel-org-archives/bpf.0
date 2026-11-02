Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604078;
	b=a14zZBr29s8JYfXbylRwZk1n5RL6+4XizkATCWX7UcOCk7WdmnyjHCl17k8WOr+NYRiY
	 e/S1Oz96leTalcs34OoTGs4gu8L9FqUSw6sQOq7nWUln6xZDzzjyfMZHb6uKgySDCsXAy
	 A4DVTKy6SzHwBVO8gV+Zle78tm6pakx26elxej9MaiBty1yyjhVPh1Itn9D9jklzjQh7D
	 gt0O6iTlnct6jFnY/RjmDRiAXS4uh3Y2dCVuMSLjDUI+Pye0JT5zZ7h7P60WzYPbrhI2R
	 qipg/Ba30Wd8z61InH6FOmCfyL424pR7wwjBf0ddo3epGM86UVh/54oDoY4o6GNXEcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=bK+b/qrfSwKnSjxBPgQ7rRNYPJMfbkszlGWmScXGZ8I=;
	b=XpJvJ+yBeLGZcc0y3FwB+Y+vnLIp7SSe0nrgUlaq5+NNMUVBLNdQ/OTiEyoGNamgHu4+
	 H2E3r+UFGL7Abayoq7I8xr/naJeVO9JmdOQdyKbg0J93ph+IIOxbL69D0zVXPW6XrHzYL
	 16Rzarzub2qCuEQC1ytPJbSWnNCUs92LJ8A1p4A6/ja+Tm1aDoyX7S0qnthUEfDtyeKv5
	 laLsWq0pBayuJRFlPBtGOYHhhKAeUJ8moz8zw8q1XkoJ7hwQ+AHajn3zfIWQkBPYlfTt/
	 7H9L2cd+LikOafzb1oulmg16gdmvzuw4vijRRb4YHvx0EqffpnuxUn0fvF1CKCfcQyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qLs7ggxf;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0205B606A327
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 07:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0205B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qLs7ggxf
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cd6a7b62ce8so821214a12.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 23:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604077; x=1794208877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bK+b/qrfSwKnSjxBPgQ7rRNYPJMfbkszlGWmScXGZ8I=;
        b=qLs7ggxfy98u/p78nRhn4s/E8LVCyu42Kx2L9Q5AGrh4igdHOevn9dBtbVo7RYq2GI
         vMtn8X9O50+RYyoZb/GBt+rivC9aM9ttHNPVNz8c08aKdo7UX2/bD/qwHrf+ALBCLh3e
         zPGkhbuUKjxYWUHd/w5sTRIfZlGKusu85N+uEJQkCMypkIFaNeeNJoYUWJYM7jv3w15z
         0as3PN8KFwnAJ74ykaR3rse/MP8WA0vq6tTz8v9Id/cjJhZl1dVzU/+3qeQF9SliQiFm
         F6rALkgjPPnhIpIw6+cPz3bSpQSn1gDYXQXeGJqkvyjesJzb9po9hnPKQKjYUehXGYVu
         LiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604077; x=1794208877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bK+b/qrfSwKnSjxBPgQ7rRNYPJMfbkszlGWmScXGZ8I=;
        b=0m3nQHCG8DxAkIGLzVxnW6UjJwkMXFzTEB8ROu4odLEWY5mXO5fPD89TSvcr3UwPwb
         AKjr/XuLtE31Yx4wx3BgJSebODZXfz9SiBJRJUtcu0t40aX/jni04rmB/9zYVto7XPRv
         XftCKb2lTqLjOPhZR4RYAGR3rh83/70JeRhzvpVwXb4zc08odB94UNEG/O69PYbAwf9Z
         khN3GDlTRAo3x5kJzJ3xg57O5NBiECJQAIlgE1FsLNwCSAoE8eICNid/uCthHVIKYCRG
         TEddxnPXhAdSBinCrP7Ix78tDdhDiZEuaYqTAV5U6KVUJthWVBdu65P6ZeOeCd6kiVhk
         AYZQ==
X-Gm-Message-State: APuU4Z9/FQCTtzETU6smGtL0b6aI+uw/M+R5BhXhkrRUS4N39lRlJGdX
	SH8gNQ03yhCmDDHK2UQ5sLcaLWXsH9Yj03sJ3mhh9QmfXad04/mJ9agpfu3XGQ==
X-Gm-Gg: AYBFou3ObTkAZtC6fbuzmJysTIgYb+FBheQMr7/Szg3OqEesrCUDTwfrAJ7xY9TVSxL
	LTrSRLxzVllNte067J/T/P9QUT8AV3PXzJ4+WOPuLsWawiS/LVeufjcnVrkWkHbFA95bxXGF38C
	fEtWa0P3/lA2nT4pQmU4W+nZYJRkVCY7u2kBmTLJpgOB5/uBIw/dRowVO5+jt0jOgpUfiAMeEmN
	IuJZfN3obIDSi7Py1q3wjkIAK3tMeCxInlSJY6N3CcL4KWAPfnucrwrdggh/PQ6Y/nQbPf5/yaP
	KB4mjCe2RdwRyNOVAbXghUqAcJkP0x0HPC/0Rkl1QeYpuuW4JPtvRgvo5djCTCl5ph+SE5s/VUe
	k3vhWKsQlEZLJdVzNgrKwX9HQ6dfyeOJxOurrgdRljgrC9v6vQvpq5sBQsG7buw4fGdo/d4IqQI
	rAHHp+lPd+dOcJQhVV5RFYeernkzDgqYllp+F3H2vqMM1DRjmkGrK8yluwKkMEm2xkzajXotdyM
	us0AfQsx1Jtz7Lbg7VOJeZ+klNyg0dPL6SlKQxc9l58xKrUhMryK9NS5KdZpQYlULlPb6TCua6X
	VOf31W8OzbFmvnqw4Cvxb6QxHYgfMG3arFB3Y2tnCNS6wjw1VqpKYSZQt321gJCJMjfibnDn/cE
	A9/ANGlpB6agEpw987Qn9y1UV0mTXAzNp6P+DPVGoRI3baMouUBduM2gAjJr2EDJhOFt4/KUmW/
	U=
X-Received: by 2002:a17:90b:3148:b0:3a8:13d6:f740 with SMTP id 98e67ed59e1d1-3ae897364c0mr7170464a91.22.1793604077199;
        Sun, 01 Nov 2026 23:21:17 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e944ba9sm17483813a91.8.2026.11.01.23.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:21:16 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	mason@kernel.org,
	josef@toxicpanda.com
Subject: [PATCH bpf v2 00/15] bpf, sockmap: Fixes for verdicts, redirects, corks and recvmsg()
Date: Mon,  2 Nov 2026 07:20:57 +0000
Message-ID: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

These patches fix bugs in sockmap:

  patches  area
  -------  ----------------------------------------------------------------
  01       recvmsg() after a fault
  02-04    the verdict of an sk_msg prog and the return value of sendmsg()
  05       the backlog of a stopped psock
  06       TCP listeners
  07-08    the target of an egress redirect
  09       the TCP state in recvmsg()
  10-14    corks and the redirect target
  15       bpf_msg_push_data() and bpf_msg_pop_data()

8 of the patches are from Chris Mason and Josef Bacik.

Patch 08 changes net/core/stream.c. Patch 09 moves tcp_can_send_ack() from
net/mptcp/protocol.c to include/net/tcp.h. Patches 10 and 15 change the
sk_msg helpers in net/core/filter.c.

v1 -> v2:
- Patch 03: end the verdict after a failed push too if apply_bytes is 0.
  Another sender can use up apply_bytes during the push (CI bot)
- Patch 04: correct the Fixes tag (CI bot)
- Rebase on the bpf tree

v1: https://lore.kernel.org/bpf/20261101192057.2296489-1-alexei.starovoitov@gmail.com/

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (7):
  bpf, sockmap: Don't let an SK_PASS verdict cover the next message
  bpf, sockmap: Subtract all dropped bytes from the return value
  net: Leave sk_stream_wait_memory() once the socket is dead
  bpf, sockmap: Clear the redirect target before the sk_msg prog runs
  bpf, sockmap: Check that the redirected message is the cork
  bpf, sockmap: Keep the rest of the cork after a redirect
  bpf, sockmap: Clear the end mark of elements added by push and pop

Chris Mason (5):
  bpf, sockmap: Give no progs to a TCP listener
  bpf, sockmap: Check the target of an egress redirect before each send
  bpf, sockmap: Check the TCP state in recvmsg()
  bpf, sockmap: Reset the copy position when corking
  bpf, sockmap: Don't copy 0 bytes into a full cork

Josef Bacik (3):
  bpf, sockmap: Write sg.start when recvmsg() faults
  bpf, sockmap: Don't let an SK_DROP verdict stick
  bpf, sockmap: Clear the resume state of a stopped psock

 Documentation/bpf/map_sockmap.rst |  4 +-
 include/linux/skmsg.h             | 19 +++++++
 include/net/tcp.h                 |  6 ++
 net/core/filter.c                 | 17 +-----
 net/core/skmsg.c                  | 13 ++++-
 net/core/sock_map.c               |  9 +++
 net/core/stream.c                 |  6 +-
 net/ipv4/tcp_bpf.c                | 93 ++++++++++++++++++++++++++++---
 net/mptcp/protocol.c              |  6 --
 9 files changed, 141 insertions(+), 32 deletions(-)


base-commit: 5e96760b25fdedbbf9312827f1f237d6b18b03e8
-- 
2.55.0

