Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794074303;
	b=WbQu1XLk6jo587Xofw8X/uvnnvq7pwDUuzgh4mx+xtzIScxKMai4GN3gK9y1QINzVCyV
	 0wqXrpebO5d4W7tlydXlR0eijNOC9UQnLkktBwUKsA7N6e2infx7t8pNzvCi+n7Z4qMP3
	 IURai7z21q4LJZAXOSyqh135mdZ2DNG94iWbxVgidrccE6VFZ5/BHW0AvbXLvjkp7pQrk
	 7C5e574OjLCEcl/20NhCDVhLMsSPUBit1D5IRckFjViSeteBsipBcpuFMkoDGXV1vH1R+
	 dpUX22P8C5KLxleqN1jHR1PVa6LWshPEcpZ3Q2LmtkcGT/rb5+19v/PUq8FGCIL1anA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794074303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=kzlgeXobqqMdio3cFqxdeY+diTghMM9m+bQTqmAb2ZU=;
	b=gLcoeQw9+MbNPD+GyHKQICrPQpBkhjVfXZWRyDzXNtgNYtp0LPPRduFS/z60cwLcwoKh
	 Yv+bIg/OaW4FHlTefMJlUIt7DpxlR9KWFzIG2PWnXj2Cn80aVi0U82XssQlNaxOAsdyRh
	 FFt+4pfZVAYSD3PzoDhV1tmHGyl+3n0j7bUV2qGNrCegs8qrRniJ+Tt1AOeKg5Q7GdDKM
	 vQEZwX7AX889PnAxm6wP3xtJk9B3v0mJLf/k3F2byvkSqldG+gvHsIBg/BeHUoXDPX0IR
	 rZYE3Lj4hx+HN46e67WHskm4Jf5/1uikGJvbPUNCgfNnLUHTi7KuvHoVONg1N8mg6gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FZD5ZJxa;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F58E606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 17:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F58E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FZD5ZJxa
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b0e0e65adbso823231a91.3
        for <bpf@vger.kernel.org>; Sat, 07 Nov 2026 09:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794074302; x=1794679102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kzlgeXobqqMdio3cFqxdeY+diTghMM9m+bQTqmAb2ZU=;
        b=FZD5ZJxaQKfIzSzrbBDMKhBrrV5L8vEP/BgYkYAJpYN7W3FPB6nCd8qL8Svh7kpPLO
         p9nE7ctYxzDfhg/A3EayGrkRUGbRfWbm3jG9SNPR9d6hc/uBqfT2qkp11c3jp9mLLVo1
         IbrfpHtIAGxgy28AeE+24uaCiXwsbvd3e7pWOl50vN7Z54RIo5FbwLQxVYLA6Da3BTbI
         iMMEg0PjfqqXi8BF9Yw2KFhuUtPD0sPkalvlslzT+Vi706GkFc/EyHxVk9YD+G4pHwbP
         Hu96yxqp/pzIm4o/u9ZRAiTak7NlKHqiohlvYEIc6LU4VyJUq7qhMX3u4GBS3d4hwm0U
         l4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794074302; x=1794679102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kzlgeXobqqMdio3cFqxdeY+diTghMM9m+bQTqmAb2ZU=;
        b=RNMaI2FzokbAmlb7H8ToHQLH80gbAs59fi6enzgnwYWpYDoVmUm0Hq+ue3uHRO34yO
         sWDkwo8+pcJgzPhX3ACgxntmRZS1Y7dEy5nZXtm2dF25kEKAeiO0rSPBH+5sbEkdQ+eP
         QuM4WGsYi77jO+fAm2uMJ+txNSHlKZOEYj14n3Fyh8mDc7J1cZ0ZSVU8BnqktCQ2potg
         Lio8cAwFeJXQGYdMzv/g6Ju//QVneXnyefkQTrXQHjziflE9YQql/ek6xr212cgeWREU
         GRrtHov4HBlznopWYst9qdunikF4tkVn9hzM/XhlqH7ioKPyDpdqUGoxKmxexBc/+A2J
         6uPg==
X-Gm-Message-State: APuU4Z/KqB9fLLTM8kCXUeZUZNRYe7hED7WxSg/GNFIBxBXoiXi/w/7u
	qPCBOT4YSSCSbIrZ4/hxe1WwCb+aon6hBRn+QMfbY0gZEI/NzOBVWL2jtPQpBA==
X-Gm-Gg: AYBFou3zEe9seK0004fzpVLb/PnmjFOYuc1wUA/QwtsvaGjomSc/3lJxFopCAYttQb0
	OfT5qnX8yOOlYlbQ0DE8Avj1SG665gUyyUoZmSqth2lAJQvFdY2cjt2M6HVaehVZWPcpan+VEwL
	FY9EU0CdbXblqBt4/zjgMoFkKm/+6J1KDa/foRlgdBzrJ3Br7ggnal2JeTno0AOkpi1HLI/ET48
	mUzdI7I5NRKRTcQWuOLRjGkWMddvgCG6ERtHBNBMGszoFQDgZ8moK7mnZ+lqKvHqw5xEC3fGo1V
	6NkDW730oe3J7toeiQ1UpVmwuAhkSDDHQDt5PsC05/e8Gs7891M5F3uoEoUdnIH3pPtZY5xzmM8
	IDKkCROYz/Fcph1l93o9jLiYC3sOZX7EV+pEmROwicjvVMhPzc53io0Vm00LDtB0Sa9ZLt1/wNP
	77k3ZKmSJ4NrG2+F9n15xe3Ayo332Hg25vTCd4F+b1F+XSMKVmCdQYDm1e9K3HkfrJnegroG8I+
	ekRj5JJAOmIOjs15oj2eCATxOqI7EMlAH06FwFQDPn/gMkoQm0zerKWgt3bJkTuenGSY7Q+2Fni
	Xj7T7/L6Tmy0e3gh+nSsZq7iR1l0fkjax8fr34/W1aL90k/GbH3kk+S07e56ELkew1VF/jqxInI
	p5lZ7HdNzWXAlmwj2yY9qwyJoG14tYdMTTpkoilFuHMxnTmnc1D7mirBFnhSyjoYc4r+bTE6+LA
	==
X-Received: by 2002:a17:90b:3b52:b0:3ab:33b6:2c27 with SMTP id 98e67ed59e1d1-3b0db6d6f67mr5882157a91.23.1794074302331;
        Sat, 07 Nov 2026 09:58:22 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1057ef145sm3970765a91.6.2026.11.07.09.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 09:58:21 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 1/2] bpf: Walk a short loop for what it loads if something looks at it
Date: Sat,  7 Nov 2026 17:58:18 +0000
Message-ID: <20261107175819.3707050-1-alexei.starovoitov@gmail.com>
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

  for (i = 0; i < 64; i++) {
          if (have)
                  sum += t->pid;
          t = v->task;                  /* __kptr: a task or NULL */
          have = t && t->prio > 100;
  }

t is loaded anew in each iteration. The first iteration of such a loop is
verified on its own, and the states that return to the loop head stand for
the other iterations. There have becomes [0, 1], also next to t == NULL:

  R2 invalid mem access 'scalar'

  for (i = 0; i < 64; i++) {
          sum += a[cur];                /* u8 a[16] */
          cur = order[i];               /* static const u8 order[64] */
  }

cur is order[0] after the first iteration and a byte after the next one:

  R4 unbounded memory access, make sure to bounds check any such access

Both load if the verifier goes through the iterations one by one: have goes
with t, each order[i] is a constant. It did so before the first iteration
was kept apart, and it still does for what a call returns.

Do the same for what is loaded and then looked at: t is the base of a load,
cur is an offset. A stack slot that the loop fills and that is only copied
later is no reason for a walk. test_rbtree_remove_many_noalloc() of
libarena is walked again: 22060 -> 27699 insns.

Fixes: df9b13a441c9 ("bpf: Keep the first iteration of a counted loop apart")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c     | 9 +++++----
 kernel/bpf/verifier.c | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 5415fcf9df2f..2a7d0c59f73b 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -3749,13 +3749,14 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 		}
 		/*
 		 * What is loaded from memory or returned by a call in every iteration is the same
-		 * kind of thing in all of them. One iteration tells what. There is nothing more
-		 * to find out when iterations are looked at one by one. But for what goes with it:
-		 * a call returns NULL and a flag is set. So a walk comes first for a call.
+		 * kind of thing in all of them. One iteration tells what. A walk through the
+		 * iterations tells more: what goes with it, like a flag that is set if it's not
+		 * NULL, and each number of a table in .rodata. So a walk comes first. What is
+		 * loaded is often a leftover in a stack slot: not if nothing looks at it.
 		 */
 		if (expr_is_fresh(env, header_env->reg2expr[r], &call)) {
 			__set_bit(r, iters->fresh_regs);
-			if (!call)
+			if (!call && !bpf_flow_is_needed(env, insn_idx, r))
 				continue;
 		} else {
 			__set_bit(r, iters->forget_regs);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 09a44723bb2e..479c52cc2f56 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21636,7 +21636,7 @@ int bpf_flow_loop_enter(struct bpf_verifier_env *env, bool *backedge, bool *drop
 	entry->entry_state = entry_state;
 	entry->terminates = true;
 	/*
-	 *	idx = 0; for (i = 0; i < 100; i++) idx = table[idx];
+	 *	idx = 0; for (i = 0; i < 100000; i++) idx = table[idx];
 	 * What the loop makes of idx is not known before its body is looked at, and what idx is
 	 * at the entry goes with i == 0 only. So the state goes through the first iteration as
 	 * it is. The state that comes back to the head has idx in 0..255.
-- 
2.55.0

