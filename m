Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CA0439F73
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121143; cv=none; b=sPjKhF+22uPE6Wn3gJ9upVd59ZQZx4yFaev7SbWriFNzH84nV/avH52XKzGD31mXscMTSTdxvEw2Dl6WeCZjcP5slbGEKJnXoFlAfYmYomV9as8WfIhhzp/X3Kaean2pL/n9rz1GF5PIQJ4VKMg/ldYl9LCirOyftgllnjUQTyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121143; c=relaxed/simple;
	bh=0+4v2cO3iYh1+AVC3ISqMDwElhzQGyriI+Hg0NAXA4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxqf85tStd2WP97lyK46UIUelFWpGOeK2evtJ057AU5+quMSR0jEr4dg9tXlHXLc6g4XvU5gXdCANFeEz11rBT7Ihd2ZJL0xKNIu3KI/PHZUPqRh6ojuWGiaI5kpUDa3wZzlhJyKQMN7wFwJ4qAJmhZBJT90O/hwD9vRTC0Ah44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsEb8CYp; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsEb8CYp"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4bdf8abaaso461980a12.2
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121141; x=1791725941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dUnCX0gX+2UmtIKPTDfOAk5VNXM2KfGeYglpzmcapsU=;
        b=GsEb8CYpss6tjXZGhHVePfj0SAj7GcMPmZNwtRvRMA8EoKIOgDZLHKGVDRCocVDGNx
         lKyraZGVmq+90AqfxKoV2IOggybGAuwXzVNG63WOmg8KLTj1QLTZ1vR8w9yzE7TJnyXA
         u30cmc75cJzrdcsVOq1jrDx+8rMfmEKfW8VrU3zbJHv030jihTYUUAHEeAN8zmzgZnfP
         JIfRI3amxL+d/FGmk7eBuxmfkpZnMcwdPXq77Q76XR8+2ZpnoWNDnu6L9lf3OUXx33uO
         0B9x24xqf+nfqyDvBuRJvs0oShuPsiofP7eQx4jCGy5ajcUSXV6jlQRUlHGA7wZ2iq9Q
         Wf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121141; x=1791725941;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dUnCX0gX+2UmtIKPTDfOAk5VNXM2KfGeYglpzmcapsU=;
        b=bKk7uggYplfCgB64IiyWv7pwALIL9eiehOrUB1nt7uK2MqZcj11LLwwLG/w1KtaTlY
         8eQMPeKOuJKESqHje/gwK1QTuJdnHXfBdSuM7NAMyDrxY2evpA2oH7QSdt5so2OD7K3q
         saVrkp10ka+ZMkjozJrQsW9mB08ucWPYNV/Ty09txJQARdnQtS53Ko7N8D7eHUkwwbGZ
         G1CHJCneK6jWk7F7c5VOEG8pPPmc6SU4Pn2ZECkb4JcMWOYxbkouni2C/DycUCEvn/oo
         fwzZQCEHwb7pvoUDx5r1/PDqYMc88aMcELpM47tDw5J6OQMxXbaN4jQBPY95tNUWYyK7
         29Yg==
X-Gm-Message-State: AFuF++lrz59cgRPlB4KlzGv6pi7qmAuwWIfZN6nI1G5VgX0+jwieiUo/
	mIXEJYJ740XYGvyLfM4EGn062B4IY/W/wb53mHtRrr1Mc+PALBTt4wdJhm+Zvw==
X-Gm-Gg: AYBFou36ESjp82NjGTEpFOHWSO4X0DHqCPRnayddlxyKrxei2794zqaQ0M4ibEf53uL
	HN1wAXdBq1ul5gdVZyzzMCYjJPsmrp1v8JBIj9OYa0V/L/SDffveuZBLmTj6M7TclPmt4vbUoCT
	l6t+pCAroR1GcXTvTyGIK0zVMtr8PnBWRLzde/1qDgmSWKUI7g33GHvjdTYRXvwjQUG8UD/uRuk
	xU8MZwnZ1epPwYpqQdmpAEvuGaB16QNRAoANd5IUPwqr8n48/ZEI7UyZ26kahqu415fVOX+r0Zj
	5BYRX5h8+t16Enaeq/zms2w3h1PjRSrNPMdRjO0fQE5HcZXWWkrq9j0SuaC+KlJymyFOOLvhvwk
	fEmrRliisJ+8IPhWlbI3/F9tuVZhL76OmNQkhb30Jhgr8WoPX5jruc7+4sRsIj8MboewT4P2vbD
	vZ0L45C/onFr3E1QRxfaRwgJD7aryrgiOf/1UM/G549ftzCjXrTuEIXpzlJ2LbREjXtJtwUpdkX
	+sxGWwLWUPTN8FQ
X-Received: by 2002:a05:6a21:328b:b0:3e0:f6be:1998 with SMTP id adf61e73a8af0-3e0f6be1dd4mr1216548637.57.1791121141220;
        Sun, 04 Oct 2026 06:39:01 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:39:00 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 27/43] bpf: allow precision backtracking between overlapping checkpoints
Date: Sun,  4 Oct 2026 06:38:09 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-27-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
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
index 7e858bb05dd1..c0ed92a632d1 100644
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
