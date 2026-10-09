Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054FD4BD7B2
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542938; cv=none; b=B6kUOE6l26Ym4XNr5bvenP+49Md/K9Ccu1QTIUEkdwxJDqMYKeI1swDh8gVSHzOyqrZ/ktd4wvZvKqv3tniB/nT1Gf/AU2a/M2o1VYAoH3Es5nSO2+ioa/eYmAkuZ/K/tKE77THOMEpcYxmQY1urfqyw3rfpphwdU73PinRJq7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542938; c=relaxed/simple;
	bh=9Lh3HBTsN/LcoYhkqrkv9K7kVsTBsNyOPKQpYj5lspc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PwIvxodjTHhWnPKvC3XEGxPLJCP9dIPlp387ta55oPJXYsYLpRPWGSDMNTu6hTSWsrXXiO1WNQQ3L4HnIu/qa0rH4EVB8ZlZKTCWYsZmtFKkXX/qeIWo7S6OJJdL+nVDe2pjtccTLMr0Z+Auz7mjriuydS1qTU2YWwNYUpAzD5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+QLz7iz; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+QLz7iz"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc4b1f7e8f4so1972197a12.1
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542922; x=1792147722; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BhCP2HZ4NVBAaIOJDduFKS+WzlfKo0JAPp3mG+a4frE=;
        b=L+QLz7izpY9+avLRp3qOjUoImD+s5/RhZn5hcZxjWkdYvFjpVj1xJUxVKwGSsQ/0ae
         QagH1SsphL6SupIW0deC++tzXiLSjF4uUxfwWes5X0pAMHLPmqvh3kCt8BRTUIAHbVJU
         sf1EcWp2dUdq6eBP/DHv7XsXYtB8qGQuT4T4XrW6JvKrTtZiohXEOeC0vIG+S+lC6H0X
         66+oyF3c7j6myN6whrDcNAGwV172sElolDSRd02UR30mjqFuXqd69Q8pP479ONKKhjFp
         KyNU0xXt4rFVgOvsXe8GUEse3UDR1ei5ucInktoaOziHX+5Y6FFWLqKn/IQU1TjXUMVn
         zWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542922; x=1792147722;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BhCP2HZ4NVBAaIOJDduFKS+WzlfKo0JAPp3mG+a4frE=;
        b=P8Yx0Ha0Q8P/EPF7eQxi8BOsoaxqjlNSz6ARF8TiBcWrKImHBoyvIxxHSlATEUMxVC
         b/9xsmK3wFohL1NVcr5Qp8YeoFzzbpNY63nMsJeFJULllX1GS5VhSXAUPcUloGF5Sz3+
         oG2lIn9nvmvzOl72pj8x9pS9SgdvVMPTvOFj/oidqWcqTUKJ4gg0bxFFbfaug09Kzetf
         p9kVNfmsV5P26RfG0Rbm1fEyFXQrVvtvughpXDjRHYHWmjfuSLN62r47LvX5kbIYhD3/
         8+ecy6jUQd/1kRkgrzi1Uq6dd7651guz2r4QGycLe2+ovfnqpdPAKI2O/aSzdj3PFRoG
         TnZA==
X-Gm-Message-State: AFq9FYINdLU5XwzAn5+V1d/hXPrUpewD4JXJzXVrjzDeLXk7KqtBsdv7
	p/qfVBCzX8SR1xA4BvlkKjCnBS8gjXuxWR2ZreWXr4HixRG8272cMw9N0jwZJSuY
X-Gm-Gg: AYBFou11yCZmeC2JP4ulA0u2m/vN7xFWo55En0TB+hkwItjR7XD9d1/nAqZXaarNCcQ
	U2n9OnBsUF098aRkd4WIZoPj8OtRhA1KbmQE128Brzx0voSSYzwZ+t3lG1fBHk7pW7I7Qxx9g6h
	xInEIU/f94xkmN6+mnrGl8CGngXsvhiWxOyiDrCrNrWhpz+260LR7xDplAdneQugaUAtT4L+dk2
	6YjM0jRMAu8rnzT2ILfooDcFBnwjY3CUFUx9yMCqtA2gDJSAQ6eVFbFwymcoa3S6KRqwrpwwP/g
	ljB6b8RARWXtspO3OSmOOipG4gcPfanS6JX5DNHGFDy99LqLhHB16tLGBNBvdWdWRRaMXnQZNle
	Xvtb00wv0CmL/jkvHGR+8GPidWjvCmEUYXQJGDJRUHUkQ3/jnql+jpfy4ZgzoD5n/FnOFuASI0Q
	k/gpScjQ84WkXsFouerRUWFsz2Q/iOAs/7t1fh1Jz3WsIM92OOykqOFDu7ZPOn/guk7aTHjo1Lv
	OVOXhVue6O2SRX2
X-Received: by 2002:a17:90b:28c7:b0:3a1:66fd:94af with SMTP id 98e67ed59e1d1-3ab3a99a3acmr1422833a91.37.1791542922202;
        Fri, 09 Oct 2026 03:48:42 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:41 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 32/51] bpf: allow precision backtracking between overlapping checkpoints
Date: Fri,  9 Oct 2026 03:47:50 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-32-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

SCEV integration logic might create two consecutive checkpoints at the
same instruction w/o processing any instructions in between.

This happens for loop-entry checkpoint -> regular checkpoint
sequences, where the loop-entry checkpoint has to remain unchanged
but the regular checkpoint is used for widening.

This commit adapts bpf_mark_chain_precision() to support this.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 5 ++++-
 kernel/bpf/backtrack.c       | 5 +++++
 kernel/bpf/states.c          | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1458e50a1ad1..963106328791 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -502,7 +502,10 @@ struct bpf_verifier_state {
 	bool speculative;
 	bool in_sleepable;
 
-	/* first and last insn idx of this verifier state */
+	/*
+	 * First and last insn idx of this verifier state.
+	 * last_insn_idx is -1 if no instructions have been executed yet.
+	 */
 	u32 first_insn_idx;
 	u32 last_insn_idx;
 	/* if this state is a backedge state then equal_state
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 0e38b9575328..43d5740034c0 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -888,6 +888,10 @@ int bpf_mark_chain_precision(struct bpf_verifier_env *env,
 		}
 
 		if (last_idx < 0) {
+			/* Consecutive checkpoints can have no instructions between them. */
+			if (st->parent)
+				goto parent;
+
 			/* we are at the entry into subprog, which
 			 * is expected for global funcs, but only if
 			 * requested precise registers are R1-R5
@@ -952,6 +956,7 @@ int bpf_mark_chain_precision(struct bpf_verifier_env *env,
 				return -EFAULT;
 			}
 		}
+parent:
 		st = st->parent;
 		if (!st)
 			break;
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index b1e2daefc264..470bff8d8dc8 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -1306,6 +1306,7 @@ int bpf_split_cur_state(struct bpf_verifier_env *env)
 	}
 
 	cur->parent = new;
+	cur->last_insn_idx = -1;
 	cur->first_insn_idx = insn_idx;
 	cur->dfs_depth = new->dfs_depth + 1;
 	bpf_clear_jmp_history(cur);

-- 
2.53.0
