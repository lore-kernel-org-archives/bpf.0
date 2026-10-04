Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D90341A919
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121125; cv=none; b=h5GYXuSOjTCT2/ikwVj0QzT2/WW9JuNtnFKBDFUPxP7n1VuuqKJG3bWIZdwGGarLj7wWz1OJC/JvHhXUWkvKO/bUrxeWKpUNbC7dhFfgqLFMFtedYKGVLf8seq85nCGs5M/KhAAkxJCGkgT8LgmBjro/hnveFPQYoWu9ND6+eCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121125; c=relaxed/simple;
	bh=fbh1+8yHCftZCxdURLzMxLNS9PlHpOoq9hBXII5X0YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ju3SAuN3H0V3+QQilpte0aAxoI6GYLQYz62W3JhyMWhVQBijSyqDWzV5cP4OeXO7JjftZeS0cjCpGrb7rlQzIKNkVPsinerf763smX0XsRO0vE0c3I52LoEURyxQdTtftvrKE68yP+xo1Rbzffwln+Po9pjUa6KMW1s6WDkXdtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1i/0zSk; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1i/0zSk"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-88c72646f03so388670b3a.2
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121123; x=1791725923; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mY2Ropo8TxLCzwGVr6QQNgzo8wEWXHzxfKH8vvG+Emc=;
        b=N1i/0zSkRhqJqDZgBoOJDVInOHtYDM2BNvb2qzZs8cAC9h5gMlUYrb808z89/7WrC8
         pQ0q+crQymj+WBEXbGQyY64nEOi3RzbA1A91DJF8OEGOOgHMkih9VPxOLnJTYVqGnKes
         egf0OrUUlmHei17WIzfdmkHI8Y00TYOrOZTsHEaJPfdGkR1+Uv7FJ91+kWH+JgKW1aCQ
         efTPXLB7m490sagGEhBA7cBhVbJLRy4OZZbMTNIb4c170FJI6QtuBMZnWNtjkrxh8HiZ
         OCeAeO6CrG7C6/m1iSd+sn2Ns6hf+2sRgeNvYrlTJMv0QHK6XNOPdOa2HU9MrSGuu5jK
         OGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121123; x=1791725923;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mY2Ropo8TxLCzwGVr6QQNgzo8wEWXHzxfKH8vvG+Emc=;
        b=eYIy1826KxGrulIU76aLP1MKP5dDxY3bXMEeQMCuNCJge6UTqqMf+FgVaKwrdEf65K
         l8TcgfkvN8BXZ0qD81U14BvF6qleqsrAB4bA14iy6ZD1Mw1I+KVSxKVYs535XUhGSVdM
         rY9KavDnWePhjJdzG0C8qCMh45KqDWfpRYx8WmfNzoMpAmtOlHfhgnkyso97zjCP92wk
         GMNoiav+htHiOXB1H3tyjNHiyQ8DTq1Do1AYIlsMEpI+IAfMtbXpqOtOrgVveizbJ4Ex
         ZFNdjzTf9SJXGD4+YBlbhD/4juEdjlfX833e0aC+W4H5Ci5oPaW3LWbpKluYcmn3/up7
         1pRQ==
X-Gm-Message-State: AFuF++kHbQkOPufMLy9g23Cfr0Od3vGJqCPISGGswWhB+Hn4EJBEdY12
	wBwTjMnCuVGqgA0Tgev4r4XBcOpGHciLRoDSid8CQ0Ci963WGYcJ0dSE7LeVMg==
X-Gm-Gg: AYBFou3AgSZVaiJqyfWNUPXq6FQbX5hDFeahHCnr8OStWoRUQsW5CKPE+oyYKSJG2+m
	mE5oYcqEhhtoCnLIgb8vtqu5gHuexovSjYDgEg7zl04B6YrMOvMTXG3y1wgQlMJZc3p13ntvpJ7
	aaHOk/NUiYCXkWpo36BU0lSNHfu4xEs61nrFCzolya9Z8lW4SJGuDgKfd6MxA4fjiIwGOR5aJCD
	6f63F8BONq5+X3fZBaUc+AzqVRTYOMqFbPCw3jRR6SHBfyxNxreYYtPYdCd7CZ+VpFcJ5jhWqhq
	doaVW2u7df0B5oSATH++BRQhWUG5evyyglFpR5F7YykmPzigV0oxgsjVWcRDPdN8MovZ6JcQAlN
	pBIbjPddztrhfe6PdRjjveFwWcLapLpirZ4rCQ+cKXS6f7hJ/vrrvgy0nrDq541uI0ohcsBpP3I
	uvN48HCjSCy9lvpJghVn1AwX7DyGeOqTkSaQPhPHAVsUp0d91O9OLr4WyN74C9bhNnEkRQzWVXw
	FNwJ12bCZ2Rncs=
X-Received: by 2002:a05:6a21:394c:b0:3de:41d9:9e41 with SMTP id adf61e73a8af0-3e0d6ba68e3mr3709706637.34.1791121123488;
        Sun, 04 Oct 2026 06:38:43 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:38:43 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 06/43] bpf: summarize live stack slots in insn_aux_data
Date: Sun,  4 Oct 2026 06:37:48 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-6-f6254e29fdf2@gmail.com>
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

SCEV needs live stack information in order to skip tracking dead
slots. Liveness tracks this per function instance, but SCEV is not
callchain-sensitive and needs a summary across calling contexts.

For each instruction, union the current-frame liveness masks from all
analyzed function instances. Represent 8-byte slots as a summary of
constituent halves. Store the summary in insn_aux_data.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/liveness.c        | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4cb36ee3b6f7..5b615083ffa9 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -667,6 +667,7 @@ struct bpf_insn_aux_data {
 	 * that this instruction may write to.
 	 */
 	DECLARE_BITMAP(may_write_mask, MAX_BPF_STACK_SLOTS);
+	DECLARE_BITMAP(live_stack_before, MAX_BPF_STACK_SLOTS);
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
 	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
 	bool nospec; /* do not execute this instruction speculatively */
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index ec9c8beef556..004c1f48a065 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -729,8 +729,9 @@ static void half_spis_to_slots(unsigned long *slots, const unsigned long *mask,
 }
 
 /*
- * Precompute, for each instruction, the OR of may_write masks over its top
- * frame across all func_instances reaching it, stash it in the insn_aux_data.
+ * Precompute, for each instruction, the OR of may_write and live_before masks
+ * over its top frame across all func_instances reaching it, stash them in the
+ * insn_aux_data.
  */
 static void compute_may_write_masks(struct bpf_verifier_env *env)
 {
@@ -746,9 +747,12 @@ static void compute_may_write_masks(struct bpf_verifier_env *env)
 		if (!fm)
 			continue;
 		nbits = frame_mask_bits(fm);
-		for (i = 0; i < instance->insn_cnt; i++)
+		for (i = 0; i < instance->insn_cnt; i++) {
 			half_spis_to_slots(aux[instance->subprog_start + i].may_write_mask,
 					   rel_mask(fm, i, FM_MAY_WRITE), nbits);
+			half_spis_to_slots(aux[instance->subprog_start + i].live_stack_before,
+					   rel_mask(fm, i, FM_LIVE_BEFORE), nbits);
+		}
 	}
 }
 

-- 
2.53.0
