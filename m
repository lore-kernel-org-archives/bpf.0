Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F624BD795
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542921; cv=none; b=izkcvU9vN/sLtyoZWELGXPfKanGmysDWeVWEbdMA6SbXUBccTS9lg1Qrk3fyiU4NmBA5VxA3zhtS2LqCYOgiLsxT+N7+uPgdkTZmujJAxKiU7BCDidL6JDsZy3Y2a5QzvdQgLo4ZpYH2zO/G2Dak0uIN1Fn/qFjJDnwGKTPBG/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542921; c=relaxed/simple;
	bh=fbh1+8yHCftZCxdURLzMxLNS9PlHpOoq9hBXII5X0YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EltnM2j1nvVXK61YnWe95YjMchb7dIAIPtOdEdwVlnUeSOtXJJHOnKLzgu25PJWaWTupWUG9DzeAg1IKVKgBDFgzQlC77U66gV8PLeN+uTLuOASiBfB+5XQ2YRRNiA9ag4w2Tv3MgjPn176+U2tClRGLIUPyGO1TU7VNrj8xX60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rn4iJY87; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rn4iJY87"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3aacde0cc0fso844755a91.2
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542902; x=1792147702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mY2Ropo8TxLCzwGVr6QQNgzo8wEWXHzxfKH8vvG+Emc=;
        b=rn4iJY872NjKScouxOMSLBeDyH54JSXBP+ZAGw3jxCvjGPpzCk85/VCjoUMLWgIWpX
         FaSq/X5EvWbdxitc3dAp2o9ug/PsCN/fsY9sCv6VY6HsQPnn/lvRmYNoNgmph9msaUkR
         Rzyi4OSF7FlCsMu3WVniYrLyrlWPR0B8hFZ6K+Mbk+SV/hGzKrycARkLrP5+sakzSrXP
         uBYXe73qwPc7DI3qSBN23AY3GoQ8gDE01k9/A37SJxljY1lbFsdL6vn224SJmUgvZpP5
         A5jH7Uex+zFUj9eFbfOVCN1Ul65LM1X/B1hHzAoui2Pp5vKwi3s4xMgF+vBnFwXcHYI+
         xdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542902; x=1792147702;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mY2Ropo8TxLCzwGVr6QQNgzo8wEWXHzxfKH8vvG+Emc=;
        b=nsCkxOO+SX3FgpP7NShjpouXC4b8nDUkV9PMrxm2iiodZ5+12WcHl1JkPRbh+elHdO
         4vBX23vk03R09nky/gYwl/cXOQ12sd9uk88ynlYnElhKhR8MOJgjhqrODnFn4gmVY8Gu
         QO97npCFecEZe3ohHAGSwQSCqVIXFildiQ1NK/x8Wk4+YyR0OB4vTmuJpKnGQDWX+/bF
         PU7WNi3dJJhcxAU7ATijLwkrcRmTaC1/5up7xV9z4goeqeNGNAzkc1ESEQce8lKyzAsz
         S4pTmum8F5xsAJ+V3wqNIjlYsi436zs2+56trc6HO5oa/CDkzjwMJuzE2NDlM4kJxw8j
         6Jcw==
X-Gm-Message-State: AFq9FYIHRkeZkmpeo9GOOzpIJ2U4BpD5/mdfML6cH1A9sRIZ2dfCARQa
	Ck3Sudttn67o1D/X3/I8EA11Clh90vltgeuBT8nKKaDrgVBW6oEC6lu6GhJWChF4
X-Gm-Gg: AYBFou2hSF363MWxwKH8qS7uiNPPfMmfhtoEfS022q/+NZJrm/7ZpPKTlRDaXOgQpT7
	bvmuAGzOYfFOx6ZJDbJgdy9gbj55VxK0yYk8lkSbiJid1aXIGY6V3Tzrwsnck8qrVhaa4ZgtWlw
	THgsPaKo18AcKvfpZrrIhLbdK0jVyYpUUhBbE7GcIQR1Fw0y71FFpFUIsi6jyGQiEE8Jt4rcMQ1
	r18t7Nqpik64QnyzaGxkvxskO5j9JFcNtE1y6tUtg0zI3XOFLJGdOuS2zgXQZ1BKeSmJk8UcqZ3
	TREZylhk1n2Mhwm3zpe8yPM7he6CUe9M5up3U/H6TRfhDF6JccqD1XmpeA2aRncfDLp0SmpEX2a
	0V9f8gqZGbIiH4WPkBqlxWQfkgIR6ZxVIzFMO9sI3ej03EYzOp7Cc+jhq+uv7YXaqs0+oYxxCRn
	OqNzJ90/dvpxvi02W2vcdmseRfXr3iENGhAqy8IFNZmSvRHwZLYJjVkfHJ7o/vythdzoZC1NZzs
	I02N9hgT1qvU0w=
X-Received: by 2002:a17:90b:35d1:b0:3a7:971:7470 with SMTP id 98e67ed59e1d1-3ab3ab20a3dmr1242462a91.47.1791542902514;
        Fri, 09 Oct 2026 03:48:22 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:22 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 06/51] bpf: summarize live stack slots in insn_aux_data
Date: Fri,  9 Oct 2026 03:47:24 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-6-bcba9bc53ac9@gmail.com>
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
