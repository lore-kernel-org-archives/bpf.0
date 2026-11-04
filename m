Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793829327;
	b=I/BJai/CBwE2sof5FYJRqRL97ae+kJRmnjiLJEjojwNcJSLUuRtVA39aYQkmdib6w5jx
	 lRL5pRbjpLhkCjWhpwsZO59mDjzTuVK5X2E0WFX9CFyBxJDJQM+NKEbuzVk6a98prQ+l/
	 AQ/ElWhLNDWjtW1e7Cq0gUqy2A0C+5in6i3//5LDLmo0PW45vy09j6gT1J3mQpnsHvMUc
	 abPvRT0MDPEKCPzCFDCC6ApS+9VZJiKrNxeuiDPlyo2aIZYYJzcOUedrwOi6LvPnCDps9
	 +iHffQOg7pVnPt4aUN3MW6anGy5cgU2x55qBoGZaGMdEktw2jTM2rHO7NHH4A9w0JEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793829327;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=DzoGnY7MxAdjt8Hc69qN+ZIpTt+CvEqtG5y0/jg0lVo=;
	b=NFciqXNtbE8l5+hqBLoUCuw4dYFY6aIU0bbAH1IkcK7WKGSauFH7EFqX67y9eYqZ7JJY
	 07+bYn7U0b/t2HKFfpWosrqLUutHx3IjzoWXJRcDldvXmQ5o/u0YL++HMPAWWEmKnPRua
	 h/5iDUlYTxMUAvcJBl3Uk11NMVwVPXHGSyh5NeJlFNQfKHlct4RUe380ysy9ddFsFrXVV
	 GTckoOFSO+lSp6rCMPeQBKmhgtj1WI+OR9oWOiruTv+tLNPjagSzMbMe7hfVlWQYLUr88
	 ItD2SuA6NHQ0k0qt1oeKW6u7jkEuapvyzN9IbLwcZ1PAyIh/LM4RoNVK9AzauKzLzMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dabzhJZ2;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAA96074926
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 21:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAAA96074926
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dabzhJZ2
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b08a162d4bso903365a91.3
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 13:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793829326; x=1794434126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DzoGnY7MxAdjt8Hc69qN+ZIpTt+CvEqtG5y0/jg0lVo=;
        b=dabzhJZ2zS6xmHM/UH3S5e1v2veZv9XT2rFGAsr7dg5lIgT5jOp9Z+41X6M55cDeLe
         MyEs10EWkx2fa7sTlemJndkp6GKzIcB01iHKmVygCggRnOBFSHpC0iD/TCVH9BNsKy9E
         ko2pOXGAyhw3sH9OwRsftYp6h410sE0SHsWRvE2R8nM+P5GVZoEMXmXsT7UwM17KzqHM
         +bC1ncG+Lc+s0Wq0CIt3+JH4kuK2QiIvksaHQLdZo5RoT+CQxSC9IeQ00qarNLQsC/JO
         pWOZWkNOWQp5NkBMmXzOlB8QoDATLr13nBPF8pYLp5EEMe99t4u5ZqNgcGRj2cHtBQ0r
         vjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793829326; x=1794434126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DzoGnY7MxAdjt8Hc69qN+ZIpTt+CvEqtG5y0/jg0lVo=;
        b=WI5R9s3OjzX/NGzIAice1JTb3becNEDB+AHBUvHoiZr6EASkmgxZ9cF0UfYdOjLaIW
         ickNDL9WQ+L1vTEMh/BbXA0pQXfSh9p/KiE4kS4i99PSOGaGYvU+K2uUsI87XKmhrbMT
         RyjL1p85AAFMEU11niYUSohE9nSX+5nOq6+CVv99kCWe1GTi4mE3hHJToUFhAt5YGJUF
         Kxw96SnRnRBLPb9SlbIvobKW2/sY/6WQAV5djQI7QDcJlgIEJeD5hoYxUVP0HJkGdw7J
         2T1AvKd0tdpCxvTyk9hT+HVA5Xa+8sFQA9wYtXmVuTJ9VoHWe8yRyya6UeY5WFbNO7QC
         3L7w==
X-Gm-Message-State: APuU4Z8CJlFIdxM9J0NW1tOpklb3TYh3eDIZhbRvxNuG08GTuLWfRlIf
	kQ18yhz1h+1YiukWfE/36uBwOI7ANtpDxuwLbXLhZ8bkjcyV1Qjtk0PKpHnYRw==
X-Gm-Gg: AYBFou2M7Ty9rq7Sra2ETziBK2WKoogilSem6TIv/8PINo+Cx+F1MOy8kW3nsg9x/ip
	7+s+w+4ZfEftLJnufUPkoz74mEImrdhfD2fTjtVI9pptaiP98JL8ZhwtNzqQi5AqDebE9eAuu4Y
	Padfexh64LlnY2OlpZMb1FlzC7xfuQIgYvfXZUDCmLVb2ea0uhPykVyUyussr4VaVekBjzaT2yN
	dUhXNqVniejPH1Tqa0lpQNsaOD8sXH4QGuhRqvOD/vGTvb7EPsWSSEaioKg5JjmZcaJZBKZ4EAl
	shwMSeoeIewoO8Oq8PsFuVnQc8EvvFU2lv+dpzwHoaSNm/Z6e4GKvJdBB/xyeCwyfcRYk08pUey
	FbtRdQpgwggtrkbd3tdqcv82l26lZ7nD6yNS51CHcCbMrgdVRuQ53EEK9qJcmDc/DQWxzwi8S9E
	XtYvBCreXW0MA9wsvRvQpjvs9eqUPqpayNpS+T3v2N6k3HUsSTyFyB011W7ULiKFFAayjhpRIaC
	1eFayhwjgWdY5tCS8kwM4WhGU90wA971h7s7kQ7i/8zVJcv6SAHVMv4jaWzwTPAvEzvng/2Ml5W
	xBKcOo85QjYdXNMRP8TobOTGhsBMktVikt/Wi4lcgjGBSnczn1Pc/klFbF3oTyfhJ2KkUYsKSRo
	IufDE+4iQhy8Y1c0+kltebJ1c6bWlmLwx8oxZy0Da+0ljojZyA8eWQve7Qjfbk1YCU4aL5IE6GU
	M=
X-Received: by 2002:a17:90a:5d17:b0:3ae:898e:a123 with SMTP id 98e67ed59e1d1-3ae898ea1b4mr10745432a91.14.1793829325821;
        Wed, 04 Nov 2026 13:55:25 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b3160634sm694300a91.6.2026.11.04.13.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:55:25 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 0/9] bpf: Check chains of calls over the call graph, allow 32 frames
Date: Wed,  4 Nov 2026 21:55:14 +0000
Message-ID: <20261104215523.1852636-1-alexei.starovoitov@gmail.com>
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

check_max_stack_depth() walks the chains of calls of a prog one by one:

      main          main -> A -> C -> D
      /  \          main -> A -> C -> E
     A    B         main -> B -> C -> D
      \  /          main -> B -> C -> E
       C
      / \
     D   E

The number of chains grows exponentially with the number of subprogs. The
walk was made to add up the stack. Now it also looks for recursion, finds
the subprogs that get to a tail call, that run in a callback, that use
a private stack or take a stack in arena, and counts frames.

None of it depends on a chain. It depends on who calls whom. Build the call
graph and compute the same things there. Then bump MAX_CALL_FRAMES.

  patch  what moves from the walk to the graph
  -----  -------------------------------------------------------------
      1  the graph, recursion, calls of the exception callback
      2  BPF_LD_[ABS|IND] and bpf_throw() in a callback
      3  tail_call_reachable, what cannot get to a tail call
      4  callbacks that take a stack in arena
      5  private stack or kernel stack
      6  bytes of stack and of the stack in arena, frames. No walk is left
      7  tests of these rules

      8  MAX_CALL_FRAMES 16 -> 32
      9  tests with 32 and 33 frames

What users see
==============

  load time  When each of N global functions calls the next one in both
             branches of an 'if', the prog executes N calls and has 2^N
             chains. 28 such functions load in 0.7 ms and not in 24 sec.
             Patch 6 has the table.
  limit      32 call frames for JITed progs. It is what the progs of
             https://github.com/4ast/rust-bpf need. These progs do not
             load yet: they need more changes of the verifier.
  memory     mem_peak of veristat grows by 4% for the selftests, by 3% for
             sched_ext, and by 1% for Cilium (patch 8).
  verdict    A tail call in an async callback that calls nothing is
             rejected, like in all other callbacks. It can only be dead
             code: an async callback has no ctx for bpf_tail_call().
  messages   The texts are the same. The message about recursion names the
             last call of the cycle. When several subprogs go over a limit,
             the message has the numbers of the first one in the prog and
             of its longest chain. A prog that breaks two rules can get the
             other message and errno. Too many frames in a chain of calls
             that passes a pointer to the stack had -EINVAL and no message.
             Now it has -E2BIG and a message.

What counts as a call does not change.

Veristat changes
================

A: bpf-next b3b9fd4dda09. B: A with this series. The two runs use the same
objects. The selftests are those of A.

One verdict changes: global_func3 of the selftests has 17 frames and loads
in B. Each prog of the selftests, Cilium, sched_ext and Meta that loads in
the two runs has the same insns, states, size of the xlated and of the
JITed code and stack depth.

These progs have few chains of calls. The walk takes less than 0.1% of the
verification time of Cilium and sched_ext, and so does the graph.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (9):
  bpf: Build the call graph of a prog after the main verification pass
  bpf: Use the call graph to find what runs in a callback
  bpf: Use the call graph to find what gets to a tail call
  bpf: Use the call graph to find callbacks that take a stack in arena
  bpf: Use the call graph to choose subprogs with a private stack
  bpf: Use the call graph to compute the depth of chains of calls
  selftests/bpf: Test what follows from the chains of calls
  bpf: Bump MAX_CALL_FRAMES to 32
  selftests/bpf: Test 32 call frames

 include/linux/bpf_verifier.h                  |  15 +-
 kernel/bpf/liveness.c                         |  11 +-
 kernel/bpf/verifier.c                         | 699 +++++++++++-------
 .../selftests/bpf/progs/test_global_func3.c   | 181 ++++-
 .../bpf/progs/test_global_func_deep_stack.c   |  83 +++
 .../bpf/progs/verifier_arena_stack.c          |  61 ++
 .../bpf/progs/verifier_large_stack.c          |  17 +
 .../bpf/progs/verifier_private_stack.c        |  40 +
 .../selftests/bpf/progs/verifier_tailcall.c   |  78 ++
 tools/testing/selftests/bpf/verifier/calls.c  |  97 +++
 10 files changed, 993 insertions(+), 289 deletions(-)

-- 
2.55.0

