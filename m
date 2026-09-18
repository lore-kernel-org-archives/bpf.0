Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E383031352B
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 01:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789694000; cv=none; b=USG1pEkifbSNOqr3sX37i9rtdRZQgNcT8tef/pQYGTnJJiXEq3J8nFh9qadS8KFXfFml1e8pq+dwJZOYxxiqxjsfqCrw4owK4W8jV0NOpFX2wQ8xDxc7Ij38lQfY9q6VjIJxjMpq/f+NhgoRd0PE2aYQ1a6ikzFtu9nnX2DNdXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789694000; c=relaxed/simple;
	bh=4g5wBIMU6bwB1cZVayOQfPmSKX0GW19hTB08ElCsZd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yd13mUQwGcyC87bqHMy99xkZQgy4TFNCITXW2qe2ywD20oBAjfJcjwCUs1vcj0MRsL+BWuOVA0V5hMxv8hgKnvrIv7esHY4OrYyYewI2eUIgS/1bHr+qjaTTUMCHRtnZMZG7PXfYFMjmFgveqCYDtfLpQ4NgQqyBbFiJXbTUUto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlMOPDuL; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlMOPDuL"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-485850cf4deso68786f8f.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 18:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789693996; x=1790298796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6N/JvuGQMCDMH3otKdlAdD6sQptHqRMSxILmq0T1afA=;
        b=AlMOPDuLEUJMYx13p1bd2uRrUP9QIKwmYzSFdBv1RxNvgSYBA+DQw57QUIEpfTb+CM
         7sBdpnWKbaljFuj4Y0vpZH1utd5e+q9WHBSOjHOhq+gh+RRjzZJYXYXrhouDA6o4w9Nf
         5rGzyclNY+NOM9Jj1Cj5Zqo7FjI8dFoOS6eiM7x+hnXn5hVHKi5RhkokylVaUdz0WZPn
         AV6+y3ejft2xUXMgu8FBdEt+bDr79iAGmXwKcX0C7QutVT76zV+LsYD3jhjH3YTdlF3C
         i6eD7v3ysdEaxl9gzYCbPw8YsswoGNcE29cS9t3cpUTn1g2Mm0eweztqYzJ2VpdRwsYJ
         PMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789693996; x=1790298796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6N/JvuGQMCDMH3otKdlAdD6sQptHqRMSxILmq0T1afA=;
        b=tCS+ON2pxj1+Y0AYm7D3O2c+gBBOgrsmi340uFw6KlTZBlr3eUcmlZcLqDHFJt+HPF
         tPfqo+nF41enmAoKQfKokDH6FVLdtK01xnPyFvFpknoNykCKgcpxXshEgW9zEUh6mvaC
         35IvH2wzLCbnOXGm4Y7q3Iz7fxP8IRbys7sSzsZ1/rA4IEV2folW7NkC/BCeW04YeuQO
         Iw+jEmAJRK08GCIpbLEKdl77k9sjAPkTetekr5dZ/3hIptUDqGvx7lORQhjcIatpewJ/
         adVh+0Esamk3w5Apm2ldePR++85Ot0nGRgweyYsfQVccRMVzp1rYygnYezjODGLVap1X
         R72w==
X-Gm-Message-State: AFuF++mkhRqX1Tks/qpR0UT+jZDISwmpxNsbe1vwVaX+D9pz3ixc87lf
	XinziQLFAg60e1F3CKQrP8ry8kfSDdbNDsRdzAhgMiQA7MfkTWI8O1l4U6NwSGEI
X-Gm-Gg: AYBFou2gqFu0gy92zOMByutYIoklqBLtx4Ratw+A1bpr0JpRGg4vw3z+dN6zmyu07+N
	7fOuzQhdFa/F+UfoL0JCMmk9cyX+TdNJU49UdrnuzujiQl0JKqq4Lczb4hzfH3oyddTa77be+/7
	CkMGVx+11F25b/ToDBVFO3NcD4pxTWusnhu3CDWdJ4jwMa++B8E/Bz1xP/iAZW8oah9kLChWNHr
	jyU77hPHkCKmTk3GI1DcKq0ZMOxuQUK9d85Scl4KZXU6879Qy8gak80p9vgMF4joFjoghPMX1kh
	F0aVPGOXxgmP85Cj8foa1MnG/3bGmPePu9aWB7BGpHnSlHilSPZzkeAqw+PB/cTSWqpvhSATd6q
	gINAk2NkkvC71smul3UTRpkPjKuxKPQNgkAnwhS8J+pSA7VqEcaoum/pPTmo7nl2nA+tp0+A+DH
	tlqJ3aC14/ePq/LrGGK6dsDBlb37/fsmdavT2loVxV1/Dua58nXLKSvga+ZuGpC7Jny72kH/c+z
	IDVcQ77bLE7WC2GV4jTA/9zovHafm+UaoTp6kUBZXd7dfODJ8jrR9EkbhNtiLlFddgZxJAFUUre
	dFeKSWDcHWY+WRIo1fFX58GXKOAEAPBt2XocR5OF47TcRdKz
X-Received: by 2002:a05:6000:3111:b0:485:9cb1:e390 with SMTP id ffacd0b85a97d-4871e395f6bmr756941f8f.27.1789693995692;
        Thu, 17 Sep 2026 18:13:15 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1fa7dsm19397161f8f.8.2026.09.17.18.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 18:13:15 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 1/2] bpf: Compare stack frames in regs_exact()
Date: Fri, 18 Sep 2026 03:13:10 +0200
Message-ID: <20260918011313.3053497-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918011313.3053497-1-memxor@gmail.com>
References: <20260918011313.3053497-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4409; i=memxor@gmail.com; h=from:subject; bh=4g5wBIMU6bwB1cZVayOQfPmSKX0GW19hTB08ElCsZd4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvNBFnPU6zT7deFphreWtT622Wi7uNPKUKH3PyXzjyg9 Ihn8oWGjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzkWRojw75T8ZO3S976ZmNV 6l7cWiol4vs4J+u2YoXiGhXVH08DPzH8sz7TxsR27VFW31eBd9Xu8/79YHB9e4Vf8HzfBbvIn7F TeQE=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

regs_exact() compares the register state up to id, followed by the ID
mappings, but does not compare frameno. The PTR_TO_STACK case in regsafe()
checks frameno separately, which is bypassed when exact comparison is
requested. Consequently, infinite-loop detection can treat pointers to
different stack frames as the same pointer and reject a finite loop.

For example, initialize fp-8 to zero in the caller and to one in the
callee, then pass the caller's fp-8 to the callee as r1:

    loop:
        r0 = *(u64 *)(r1 + 0);
        if r0 != 0 goto done;
        r1 = r10;
        r1 += -8;
        goto loop;
    done:
        exit;

The loop terminates after reading the callee's slot on its second
iteration. At the loop header, however, the only relevant difference is
r1's frameno, so exact comparison incorrectly reports an infinite loop.
The same problem occurs when the pointer is spilled to the stack.

Move frameno into the type-specific metadata union, ahead of id, so the
existing prefix comparison in regs_exact() covers it. Ordinary stack
pointers do not use another union member. Iterator and IRQ stack-slot
states use their dedicated union views and do not need a frame lookup.
This also keeps bpf_reg_state at 80 bytes.

Move the states_maybe_looping() boundary from frameno to precise after the
field relocation. Its prefix comparison continues to cover the complete
value state and now includes frameno.

Continue to ignore precise. Precision marks control whether pruning may
ignore scalar ranges; they do not change the represented values, and exact
comparison already compares those ranges unconditionally. Marks can also
change through backtracking while an ancestor state is still being
explored.

Fixes: d5b892fd607a ("bpf: make infinite loop detection in is_state_visited() exact")
Reported-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 16 ++++++++--------
 kernel/bpf/states.c          |  7 ++-----
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index a7202b44ab10..17be5f7df35a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -45,6 +45,14 @@ struct bpf_reg_state {
 	union {
 		/* valid when type == PTR_TO_PACKET */
 		int range;
+		/*
+		 * Inside the callee two registers can be both PTR_TO_STACK like
+		 * R1=fp-8 and R2=fp-8, but one of them points to this function stack
+		 * while another to the caller's stack. To differentiate them 'frameno'
+		 * is used which is an index in bpf_verifier_state->frame[] array
+		 * pointing to bpf_func_state.
+		 */
+		u8 frameno;
 
 		/*
 		 * For CONST_PTR_TO_MAP, PTR_TO_MAP_KEY, PTR_TO_MAP_VALUE and
@@ -155,14 +163,6 @@ struct bpf_reg_state {
 	 * during state comparisons.
 	 */
 	u32 map_uid;
-	/*
-	 * Inside the callee two registers can be both PTR_TO_STACK like
-	 * R1=fp-8 and R2=fp-8, but one of them points to this function stack
-	 * while another to the caller's stack. To differentiate them 'frameno'
-	 * is used which is an index in bpf_verifier_state->frame[] array
-	 * pointing to bpf_func_state.
-	 */
-	u8 frameno;
 	/* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
 	bool precise;
 };
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index e4ec007f7fa6..012b82513a3b 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -644,10 +644,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		return range_within(rold, rcur) &&
 		       tnum_in(rold->var_off, rcur->var_off);
 	case PTR_TO_STACK:
-		/* two stack pointers are equal only if they're pointing to
-		 * the same stack frame, since fp-8 in foo != fp-8 in bar
-		 */
-		return regs_exact(rold, rcur, idmap) && rold->frameno == rcur->frameno;
+		return regs_exact(rold, rcur, idmap);
 	case PTR_TO_ARENA:
 		return true;
 	case PTR_TO_INSN:
@@ -1126,7 +1123,7 @@ static bool states_maybe_looping(struct bpf_verifier_state *old,
 	fcur = cur->frame[fr];
 	for (i = 0; i < MAX_BPF_REG; i++)
 		if (memcmp(&fold->regs[i], &fcur->regs[i],
-			   offsetof(struct bpf_reg_state, frameno)))
+			   offsetof(struct bpf_reg_state, precise)))
 			return false;
 	return true;
 }
-- 
2.53.0

