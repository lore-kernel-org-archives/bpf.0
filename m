Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1182B41D131
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432469; cv=none; b=qkfK9Xb8zwsztBjC5eQhCezr2Lq8wa8EWBiJfM990AOI8vwXM9QGlA4pJ5OK9aAQC7yBKXZuBanQQFtVaGqcG7UkTch5VWfn63poj+tyY8ccVMwzORCi3U1JmoMevAlO45ccImTw+vcT19vJne3+LkGlj1QcQ2a7Bsr+VV44C6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432469; c=relaxed/simple;
	bh=bwY7bi03W1xhn+6GqrKoBCusPG0eXN/sbWkoBlf/Iw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNziDFqWFgkb3oTSoK+u9tGtScQorctdyEhxXLgf9qnuHJSWNJQ5ei1/+jmi0w9NzGzhB0cfs/Ey9UBnkuyQtsaiBbbLetpiAmUdxy7h4tT0KG3Ihal427uwuURxy/YoveaQz5crcI3NaRbqDnXAy94rPhnRd2WrdqJCnl0RP7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZaYq8iK; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZaYq8iK"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso902890a91.2
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432467; x=1791037267; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OyyNQimSX8vdSRRwL9i1G5eWKgD009HbV53XyYs3QIc=;
        b=HZaYq8iKZRdNYPRwb4QhTL5F3O5Y9Az0MZA06G2R67Ip72lUi/o9BQj20FoCfM6S7j
         5ismXQ8cWmOxb6ufPqtyRjpt0ILl5d6jOOahHVdBkeNaDFBcvZLiVOH6rUBvCENeAjnA
         xO95/MwbadEJZJeIggVRNA7/2GWYrU6nZRg6DXK2RCdN2wUYJYbdih3t7uT+TbMPzyQo
         +qTH7V2QDrKMRp3Lt21pCj5okksZVRU5zPgLVMdqskDVW72fhUVDNCm39bScsoxVFxIi
         uwzulqqMv/oNr8iroMEU9IOwj/vM4OpQkqgu5nnekDdoOJJT6OWAsBVY6SWpW+1YNKbZ
         NYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432467; x=1791037267;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OyyNQimSX8vdSRRwL9i1G5eWKgD009HbV53XyYs3QIc=;
        b=UjGicFpIJD6ccCIYXRaX8DOoN3MP4gQFNGy2P+ikyDJfW3Cq1Lp4w32bOun4Pb8u5A
         buL8H8geuwmx6KWXUNxns2uUxRdvD2jMswG4ONuO5/V+u4x0Vd4y2GXZU8xuux5+eROG
         uuJHNdD5KaRycm3Ug+q9x1ppBEMrJuaNphtCjvc9zxfZuFl+K4hCFe+CpoLJHZZnPQFL
         OF9qwQCuaF3fZ0+V1i0ZKAMHyP78vfosuVlsubvh6UXMy3ncE/DmV0SG9NLv7za1xIVF
         Wij4IHUFhcv/5Slqr2HK1aqmroCIT5XP97b/NRshfow4QAX6lKscFSKOUSk3QrZu7oI3
         88Nw==
X-Gm-Message-State: AFq9FYLfY90sGlB3sTSH7uNnzhplCX+bBOH2/enbHVSxNzTgn8wVOfG3
	Pl99nH8OJinMQoW7oGjvBCpuWnJRoqZav4hFZqYGEksc//Z1Dc8o7RlzDceWuIZvr7Y=
X-Gm-Gg: AYBFou2c765ZvSDVRvQjBExWBoSIwkoWIP6BuOsjqi/MoLX4JwXTBoGQqwwgWxr3no6
	a1VuXl+G83/jzsZ2oARpep+nMv7I6QsosIa2kK1pAJU+vPmxK3zSElGRewSzslkJdi1IeKSdFuu
	65SJPsbt/ZpnS8F0PbnumCFgHc8Nmr9F6dB7u1FImj7WopCOsuEtg4hxXE1LkuqYchjEqAKm3xt
	KfCgBDzG7yVfj65k66X8mVO/9ZUMg2vq2Ty3G8omyKGKJfZf5cR/CGtsaJgxmPqlK8eSprZfMcv
	3kppDO8jF3AYhUyBWMJjR3cHUPXMLaUKaSM88ZbI9bEj5jDvn4C3kOJbQZMIUjGKiqZiF+pWX36
	v6+9gY7fiEiiqPjDa55h/d0qW8NMVHembobz2hQi30kzMznR8fct+8QwYOirs1cW/+mKJCE9jnM
	ErFl7dxYwsebGYe6jL06DOo4MA/IL1/Ou09SeUmUyi+nHNgKsefWaBe7MPRg/uinkE9aRJP22ed
	B0KEkKycr7nnhDQsm90pkFkLNEauglkXc8lOYLhSQ==
X-Received: by 2002:a17:90b:1a8d:b0:3a0:c0f0:9a97 with SMTP id 98e67ed59e1d1-3a0c0f0ab42mr3661905a91.9.1790432467192;
        Sat, 26 Sep 2026 07:21:07 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:21:06 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 23/36] bpf: allow precision backtracking between overlapping checkpoints
Date: Sat, 26 Sep 2026 07:20:21 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-23-c8e5ab5ba79f@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
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
 include/linux/bpf_verifier.h | 4 +++-
 kernel/bpf/backtrack.c       | 5 +++++
 kernel/bpf/states.c          | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 76833c2ad452..08e0b49841df 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -502,7 +502,9 @@ struct bpf_verifier_state {
 	bool speculative;
 	bool in_sleepable;
 
-	/* first and last insn idx of this verifier state */
+	/* First and last insn idx of this verifier state.
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
index d7f9f879bd87..68df27e34b60 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -1312,6 +1312,7 @@ int bpf_split_cur_state(struct bpf_verifier_env *env)
 	}
 
 	cur->parent = new;
+	cur->last_insn_idx = -1;
 	cur->first_insn_idx = insn_idx;
 	cur->dfs_depth = new->dfs_depth + 1;
 	bpf_clear_jmp_history(cur);

-- 
2.55.0
