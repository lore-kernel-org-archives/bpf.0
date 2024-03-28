Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12B15338F
	for <bpf@vger.kernel.org>; Thu, 28 Mar 2024 18:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711652299; cv=none; b=gwkcNsL3+Pmw9YPcjs94V6NBEFORP8OfVX6nH6AYlBfP5Dt5611moJ3eslilRXrR0D7GTTtuzhNr6e0C9FuQR1h7P3CJqvg5xrkQDa8ikTlAImmeAy7sS1C8K373WLff9zfMN/zJK+pSHjaq18Cj1wnT/frGlu30QMTsY957wzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711652299; c=relaxed/simple;
	bh=6KBACc7iQdR8vmsr+fH4D088ePeS62u9Vkt0wcV4qKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eMULCMcnamRqYUopcImyRvA7byRuyvsP3A+ry6H2du15ruHwz3SQSsdT/1TYnBYNpMyHhJ+dM++9fIHQke7v1zd8kWLLPyvWnHl6ij/dK0bNvm6Q8Xgdm3TBlAy5mwRh8apJlQjbwRKZ0c4zh5aOAyhW7pAuvpZirS6CD6YAJdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oIhhoICj; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oIhhoICj"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711652294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4HX7L7UaGJ8M04rqspSMOrtTI+UTNg6jMnHN6nUQDu0=;
	b=oIhhoICjh9RCVHry/CnXYMPNFgc22RzUVzeuVLWtB1sP370TH9jkTcl0Zx9fo3He6iNcZu
	ur6CIcQ/Zz9TE4FpKrRKLQXKrMjQP2eFesyUO+U6hnY1YSkNJvsRIQRHMa9r07Ktw38vxs
	ASqQT+q7TDXQo4Y81hSZwWIK7N0RSyc=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com,
	syzbot+603bcd9b0bf1d94dbb9b@syzkaller.appspotmail.com,
	syzbot+eb02dc7f03dce0ef39f3@syzkaller.appspotmail.com,
	syzbot+b4e65ca24fd4d0c734c3@syzkaller.appspotmail.com,
	syzbot+d2b113dc9fea5e1d2848@syzkaller.appspotmail.com,
	syzbot+1a3cf6f08d68868f9db3@syzkaller.appspotmail.com,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next] bpf: Mark bpf prog stack with kmsan_unposion_memory in interpreter mode
Date: Thu, 28 Mar 2024 11:58:01 -0700
Message-ID: <20240328185801.1843078-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

syzbot reported uninit memory usages during map_{lookup,delete}_elem.

==========
BUG: KMSAN: uninit-value in __dev_map_lookup_elem kernel/bpf/devmap.c:441 [inline]
BUG: KMSAN: uninit-value in dev_map_lookup_elem+0xf3/0x170 kernel/bpf/devmap.c:796
__dev_map_lookup_elem kernel/bpf/devmap.c:441 [inline]
dev_map_lookup_elem+0xf3/0x170 kernel/bpf/devmap.c:796
____bpf_map_lookup_elem kernel/bpf/helpers.c:42 [inline]
bpf_map_lookup_elem+0x5c/0x80 kernel/bpf/helpers.c:38
___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
__bpf_prog_run256+0xb5/0xe0 kernel/bpf/core.c:2237
==========

The reproducer should be in the interpreter mode.

The C reproducer is trying to run the following bpf prog:

    0: (18) r0 = 0x0
    2: (18) r1 = map[id:49]
    4: (b7) r8 = 16777216
    5: (7b) *(u64 *)(r10 -8) = r8
    6: (bf) r2 = r10
    7: (07) r2 += -229
            ^^^^^^^^^^

    8: (b7) r3 = 8
    9: (b7) r4 = 0
   10: (85) call dev_map_lookup_elem#1543472
   11: (95) exit

It is due to the "void *key" (r2) passed to the helper. bpf allows uninit
stack memory access for bpf prog with the right privileges. This patch
uses kmsan_unpoison_memory() to mark the stack as initialized.

This should address different syzbot reports on the uninit "void *key"
argument during map_{lookup,delete}_elem.

Reported-by: syzbot+603bcd9b0bf1d94dbb9b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/000000000000f9ce6d061494e694@google.com/
Reported-by: syzbot+eb02dc7f03dce0ef39f3@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/000000000000a5c69c06147c2238@google.com/
Reported-by: syzbot+b4e65ca24fd4d0c734c3@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/000000000000ac56fb06143b6cfa@google.com/
Reported-by: syzbot+d2b113dc9fea5e1d2848@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/0000000000000d69b206142d1ff7@google.com/
Reported-by: syzbot+1a3cf6f08d68868f9db3@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/0000000000006f876b061478e878@google.com/
Tested-by: syzbot+1a3cf6f08d68868f9db3@syzkaller.appspotmail.com
Suggested-by: Yonghong Song <yonghong.song@linux.dev>
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 5aacb1d3c4cc..ab400cdd7d7a 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2218,6 +2218,7 @@ static unsigned int PROG_NAME(stack_size)(const void *ctx, const struct bpf_insn
 	u64 stack[stack_size / sizeof(u64)]; \
 	u64 regs[MAX_BPF_EXT_REG] = {}; \
 \
+	kmsan_unpoison_memory(stack, sizeof(stack)); \
 	FP = (u64) (unsigned long) &stack[ARRAY_SIZE(stack)]; \
 	ARG1 = (u64) (unsigned long) ctx; \
 	return ___bpf_prog_run(regs, insn); \
@@ -2231,6 +2232,7 @@ static u64 PROG_NAME_ARGS(stack_size)(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5, \
 	u64 stack[stack_size / sizeof(u64)]; \
 	u64 regs[MAX_BPF_EXT_REG]; \
 \
+	kmsan_unpoison_memory(stack, sizeof(stack)); \
 	FP = (u64) (unsigned long) &stack[ARRAY_SIZE(stack)]; \
 	BPF_R1 = r1; \
 	BPF_R2 = r2; \
-- 
2.43.0

