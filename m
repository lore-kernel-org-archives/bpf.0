Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983249;
	b=ejGiljLld8Zddnbzsm42cX4KvooPE63XlT4EJ9RGDZAbc0nP70DF3+pqos4VNMieQZxf
	 8D8KgfJi4siq4MrtgV3mgR8nQjOMpv4/CEPtAJo+9cypBe+oaC+DFkP8PXBm0u3Jnx66k
	 0yp1X7B2YwT68Xvvathilxv7FZ8wnNez/BUHe1u/29fhps+11DKFZl+HLx4ckf0hRhGfD
	 52xuYcxwjyk5UxYOKYpTcXKQ2ZsUBSre+KPfGLQWw/FAagkH1SgPgwMQZNplvYpDfrDn5
	 yBi/8+IZkVsrp9hcFmP2XK3sjoN3iR1X8IiEzRf/A5ZwGEiiAJ+V5f3ntvqDM7YTmwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983249;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jdUDizQKTDCa3Qjtv9mCwryFOohmeoK7V56vVKZZs0c=;
	b=bdQOtQf6sCzs8QaMVgveRtIhkiiM5kBfNqMrYLLeMhKGt7fboB7wLnJk1JCxKZH0z28/
	 zeBM/zfeL7mWm6sAEfT6fhy12wbtnH557uTGCKg9tbk3HLZHzU+reM5v7SQXwNsI8Zyjp
	 jVq8ek+KyyzHMx9Ae5syTDHRaqwyumitxbcte4ZpT13iAnSnnqLo2uAFBva3cphCq2AGw
	 JqZbII+qhC0D+Td+EyXjY0zs6RPcX85P0wUoQ99oVGhmwRQuCE8L4pUCTo6LqpSM8fy6j
	 ZnhPjuzNB/q/RIxClkDIRZHlGKLulAGR7kCkCzKzZpQdG4P+k+r30c1uWiJwxNTUAhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nvza7tyF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911C3606A32F
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nvza7tyF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457781F008A3;
	Fri,  6 Nov 2026 16:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793983249;
	bh=jdUDizQKTDCa3Qjtv9mCwryFOohmeoK7V56vVKZZs0c=;
	h=From:To:Cc:Subject:Date;
	b=nvza7tyFLU+w3wnTkOyggEkxpzrV/x58muYx/tYacCuI0RIqyAvoSzeMk7zXhJQYR
	 4nis5qqjZNc2GCyj+mM1wbv2tPh73lLCGLWSYjyfz7TDfRFoJyZ1kZO2Pm0BKq9Cae
	 4PvCwapjJ9KbqIEgDN0NLTaIHREXayxwDM04O8M4jC7UPSxNLS5II7jcvDj23AEsX7
	 UukNUW1EMW0wUROFdaYpGZQJUiyJmMpk4LK1p5M9rB69Ugyi7v7EO9rUrZUJFnS41U
	 uiYp4J2trM9sPLcJqUCSEmJfVE6ma0JUuv0bh/l33S77OSECJIYh7MbHSDABJ6aXKv
	 MvQ+ftDpVKTsQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	HyeongJun An <sammiee5311@gmail.com>,
	Christian Simon <simon@swine.de>
Subject: [PATCHv2 bpf-next 0/2] bpf: Disable private stacks for uprobe programs
Date: Fri,  6 Nov 2026 17:40:41 +0100
Message-ID: <20261106164043.546879-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
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

hi,
uprobe programs can be preempted and re-entered on the same CPU. Since
the private stack is shared per program and CPU, a nested invocation can
overwrite the preempted invocation's stack.

This patch disables private stacks for KPROBE programs except kprobe multi
and kprobe-session programs, identified by the BPF_TRACE_KPROBE_MULTI and
BPF_TRACE_KPROBE_SESSION attach types. Standard kprobes lack an attach type,
and uprobes use different attach types or none, so they run without private
stacks.

It also rejects multi and session programs through the perf-event attach
path, which lacks their required run context and could allow a uprobe to
reach a private-stack tail-call target [1].

thanks,
jirka


v1: https://lore.kernel.org/bpf/20261103093400.112178-1-jolsa@kernel.org/

v2 changes:
- drop the BPF_TRACE_UPROBE attach type and fail perf event kprobe
  attach for kprobe-multi/uprobe-multi [Alexei]


[1] https://lore.kernel.org/bpf/aus-b8Lo2oCw_cGd@krava/
---
Jiri Olsa (2):
      bpf: Reject multi kprobe programs in perf event attach
      bpf: Disable private stacks for untagged kprobe programs

 kernel/bpf/verifier.c                                      |  9 +++++++
 kernel/events/core.c                                       | 13 ++++++++--
 tools/testing/selftests/bpf/progs/verifier_large_stack.c   |  2 +-
 tools/testing/selftests/bpf/progs/verifier_private_stack.c | 38 +++++++++++++++++++++++++++--
 4 files changed, 57 insertions(+), 5 deletions(-)
