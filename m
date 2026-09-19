Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CA7265621
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 00:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778614; cv=none; b=tHBysZk9G04mnaNkI5BD9w/EAlLBjnzFNNGzzbNZKvKxAt6wxKJ+yebiy3NbZdv24gRz0eDbaN91471bkF0qKXp+cwZf9NTGpdswxEWDBOOB98gbsqkcDNnl+OdBHbWH/P1r4kYpWCkdArVRGS0Q92+qOPO3kdAy89YZD7ZWdxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778614; c=relaxed/simple;
	bh=M4UZLm/8AYLBFUAsD/CcABBOjGoTN5hLO90O/t9RDQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYxMnx31UHkzp9hhcOzak/oZc/YTIZJG87M4BJVKlZX411ylSKIp/TK9XseaKwC482ez+xqG4RHW3M475flkBUbN/8SmLKpO2fbECah5sds3YKZ32sCSnE4zv63eFjDbddt4TP4gnnnvG0Fvj6dWDel/jD2VD3MsGTNyKjVGwko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r5syz7LQ; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5syz7LQ"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6eb11e9cso4865585e9.1
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 17:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789778610; x=1790383410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pmf1E+eA6aEfssNILOtyEr9UV9rYhMFsPo9NnCsW6Kg=;
        b=r5syz7LQpTZ4re7fRA/kAs/7IrX8QT7tn3viBwB4/gqeiI5Vj2Wo3XSXkxQiEfnKrL
         u6kMYiLLwrdTgJ3Hv7mlY+TmXfzkQB/0fUK0gikMdBgg1ZjmZgk3o/NqAYoiYZbBgN+j
         MSWd7XGEcyqHJLInqr5+dfinBkV4FTGiJdmOmFH+7SG5EAvTCn8uADItspwkZv83r0f3
         ji+ZQ6Zl7hoGi0vVUL9J033fab9Y4L7hCfu4EkCU0u5xGFC3QjqgTaTYR1mOiZjw2PfT
         B8AijpTZKGnR3Eqqq1daSA3NKcdJwWL0xvzrfyxSpN0pZEa+UhjKv6nokjjF9Z8QxSbw
         aAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789778610; x=1790383410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pmf1E+eA6aEfssNILOtyEr9UV9rYhMFsPo9NnCsW6Kg=;
        b=VzhWUDjSrawT/v4p5r+pvH1WqYQ8HSw76PggUA44bQdNF3NGSueUHs3GakJigvhiR6
         rxinDlW1ZeFiZObwjkS4fGAR/wdBuklUs6WxjSSmG7e/cTVX0x8UjNEet2Tvx9zgpBAK
         UIREFCrSMcaNwGt4oergbL6xXNaicxDs/KBeKpQpyUxF9buYLpK+obFkUeMRYoQqqgsA
         HJ33RftswY9t71AVMPo0A8gk09q4uUDzgA5pFw8bmyIpW/rV2zTrmbsOPEmCZtqPf9Gm
         OdDhE9hk/mXYWQEhVQb/mBGYT3dakvgJ7YZWldbhUJ86tJw2NZMMpQXgY4Ex2hOMGKe2
         y1DQ==
X-Gm-Message-State: AFuF++knwV6TD6fXCwer5Mhi/Rj7z2DxKKMNKRSuF7wWb9iJhZiSBK7u
	2u/sMxBYbEYud9anIzy+rKHztF9TApeBoS2hWIYFFXRBCRk61yTknCR/s+CWlU58
X-Gm-Gg: AYBFou3gl79C7hTEeQkHjw1RZ9rcqXbheMUtIi8JW1uTIhJYlntjIsWdFpKvh4nB7JF
	09pGunJeNt+UsrLfPMB+fRtgXMzqcbdu6kknjMeQSThmItHxBkI+OQ61lVp9MSnWSQYeOz76LNC
	zYGLHGOWeYe/ZWe+MZgO2z1cQc+3QBiR8NNmkGPuKkbpZ44bcD9vCHHuZUSjkE7M756D/Hj1t/+
	IjW3q44dWck6aLzGL5IKb8FMb0eK8j0r6CoX1IbVV6yxDJQzBV/6/YeanPr56+eNozAfy6eTPa0
	uFzNxGqqLC2k/Ec4MI+dW3UBBnlIwbARPG7/lyfEt/xh8FSFeFgSKmX/zzovIDfCiMH1ddRSbGX
	BJSbHLI/YTiVspweOGcqi5igb1OQGYHK27XEq/T2eeUd8XizGsxmPfyyJdvLCi0VYu5MBbOkSzB
	tkImypZ407K3mbc2nH9S8RTdo/rVSR9SX3xnt+L+WWqpASinWbZEooUR17rBA30AZF+kD4+GTLc
	dghV0dU6/nhpfIr0eZkry1/jv0SaIhvEaNxysMqZjC7797Bc+QJFDaWbNZxPFt9/lMD7ZWTTLn+
	/BSiwYrPLMtqzUczU0bREE8WQXlkV+owmcPbEg==
X-Received: by 2002:a05:600c:820e:b0:49e:7423:687c with SMTP id 5b1f17b1804b1-49fc5671666mr52113375e9.1.1789778610429;
        Fri, 18 Sep 2026 17:43:30 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd8bf159sm16951185e9.10.2026.09.18.17.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 17:43:29 -0700 (PDT)
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
Subject: [PATCH bpf v3 1/2] bpf: Compare stack frames in regs_exact()
Date: Sat, 19 Sep 2026 02:43:24 +0200
Message-ID: <20260919004327.1403382-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260919004327.1403382-1-memxor@gmail.com>
References: <20260919004327.1403382-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4457; i=memxor@gmail.com; h=from:subject; bh=M4UZLm/8AYLBFUAsD/CcABBOjGoTN5hLO90O/t9RDQ8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvtzQ+lXhzXAi8rX5nY9yf86aQEMx3PlT9uPUmISDTZl DdnytHbHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZjImQaG/0XtKTl3ft1s2v5w 2V6hpdKrZ75W0rz10mTztkcfD639yBTP8M+sdnKRw0Yf++Krd9aZ8SR83iXhObPR/hSH61IWie5 ONRYA
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
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

