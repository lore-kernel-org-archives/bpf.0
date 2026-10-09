Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941D64C9E08
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542931; cv=none; b=EEiY14LZDz08se9URF7bHGydQJhHCf8Qx/ebmzpkKNQ3pCQ4oiz22+y7XX5W848e8Y6f8Hgt7y0ZFhHo/BQVy1VYZUp9GwhZ679EhQ3Eu28ESh7fvPJp/OLNS9pkIVlbEECpTnghVhIc/WGtCCGhz2SUypNIfVYmoR6AKHK+diA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542931; c=relaxed/simple;
	bh=GrjUSBHubL+fHxQHtGB6/NkupfZ41fuinQ1kloL0RJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JR68nmypHeIIC5AB2MO77Av6n4KOT4bP5VkRWYQJ41cx1VrvbG/3agRm6VKxcuUJ9GGo0gJ6lKBfxXsTwsduuvjMiYk+Md9yO0q2UPn82Rhew3eGly1WwUcysz9MD88YYKda0Fkh8LVUoifHaSiAqpz05bQ24NdUPI8BKgcsbu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfYf6yu2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfYf6yu2"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e4a341d177so36522905ad.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542919; x=1792147719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T0FIArR6MyivOCYu//FSZ+NeXqYD6Z7LuPNXIyS8Hug=;
        b=GfYf6yu2dmMUbWT7+hbF1jvuaigS5d5KsDC3+7b7zw0INCVcPoLYMfd0MsWw18V/mE
         eDzBtjudpFjo8QQtYjuOoR9Rm9PlOYd+qJhb0blRNoH10r4z6hIHN7R0KfrAoXahkeY1
         lpZPYfBRGx32WeRUbSraUs3krAJt/hn0zN9v33OZ3HHuFjaQ9eQBQij1wW5tlzVdNmew
         4LomUjj9+PQtlnNETSVBtzGjUIxXJ6jBxER3rCnWtt+1EU9SIFNquAZk/OLv/ZooNB8J
         tZfDGyoU7gB8+GiWz6tJ4sn1y9zXxu/fft9Xdo4F3L7l5k/KeC/v3OzhSxFaDJWnQhV8
         Oisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542919; x=1792147719;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T0FIArR6MyivOCYu//FSZ+NeXqYD6Z7LuPNXIyS8Hug=;
        b=n21clEmHdeyLr/FniGPFP0x9YW6TG/m2b4AYTBMoHwE+LzdTnQb0vXJqPY/CM1RkUO
         wM8jCsHdhkhkofWRpCxlwYEG7GqWH1CTq1SMqtI4rJTDYkA9pSlArNIuhK7kQLSF9ZNm
         Gw60KRa8hXbqE44qxQs+Z7dl1m8ql5jo4ql9raEh9La+AeM0SxQyl5JUtAYh/AUv5khf
         YnoOu2NFTRhQb5QS7GSpnTERTRFMklqXGyd44OI/B2DSl6FePLLQOFtli3jvFnrVvoHd
         +QqiyheKJYQesFTh979KFTI7rBo4kbykjOScf9Eo26n1PVyb1xQobybm6JvG9xPoWzGH
         pXRw==
X-Gm-Message-State: AFq9FYKMYkCh8zXFwwHKtFDTb5PQEwN9sjgbwxv626+8OtMfHtdJWwmp
	Hc0Ru0OXb50jgliCpVnUAbbFaa5YQC5WXqIzecRtaAqTtBiYDgFNPv5EOgV5bNE/
X-Gm-Gg: AYBFou0ldX+EAbaeH6fGew2vvdr/Ae8Q9vym+35qkP33TDCdIPErLnWxJDrOAhckzyW
	pMAkllp7pQ70NWVEK6eEl+403FzaqtH8kcCiihq3hZFv4T1WMTlxDsHhtMKyvIdgdzNoUbO5P56
	VzMOZ6zGdebj00pHXbAwpskgo3HrNoSWlbPnEiy44f3iEiyQSg7f8BlI3IPc+sfgS9hBZWbnwAj
	aRHs1JZM54u+SUzcSf2yjqZT0bok8awDgdXOuSvLvXCas3LJXCXbtlG7Lw4U5x4MrbEP7YfPtEf
	UOpCGN2GX3NpWPZsnz25TgYIULeraqfCLgVw4SKlZyUPpu+utYax83xv58ocfWwC+VTBhEbr4ld
	aHvdtIw10mJYuwnhaY+x3n0iSY6Mn4xUruGm7l/yaCIdv2FY34+V8f8vy9HBipDcPO5gThcbjZp
	u1l/i2k+La84mLq2YIW9eg5iQYqHip4CcgRciqO2RsuXodc7IuIIeHIlkG3WMwyWbnlRxLKszU5
	UkpzrEzaWKA2O11
X-Received: by 2002:a17:90b:5346:b0:3a0:d7e4:c4bd with SMTP id 98e67ed59e1d1-3ab3aca2629mr1519079a91.60.1791542918817;
        Fri, 09 Oct 2026 03:48:38 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:38 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 27/51] bpf: add bpf_reg_union() and bpf_reg_union_compatible()
Date: Fri,  9 Oct 2026 03:47:45 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-27-bcba9bc53ac9@gmail.com>
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

Utility functions to take a union of two registers' scalar values:
merge the circular 32-bit and 64-bit bounds, tnums and base/step
of two registers, then synchronize and validate the result.
Leave id invalidation and type validation to the caller.
Caller should use bpf_reg_union_compatible() to ensure
that final union result is sensible.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  3 +++
 kernel/bpf/verifier.c        | 46 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c7b7c8148205..1d0a0b64b1f3 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1823,6 +1823,9 @@ bpf_global_subprog_stack_access_bytes(struct bpf_verifier_env *env,
 int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env);
 int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		      struct cnum64 range, u16 base, u16 step);
+bool bpf_reg_union_compatible(const struct bpf_reg_state *a, const struct bpf_reg_state *b);
+int bpf_reg_union(struct bpf_verifier_env *env, struct bpf_reg_state *acc,
+		  const struct bpf_reg_state *src);
 
 int bpf_stack_liveness_init(struct bpf_verifier_env *env);
 void bpf_stack_liveness_free(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 743fc2f3c24b..f8e6b40c2121 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -31,6 +31,7 @@
 #include <linux/module.h>
 #include <linux/cpumask.h>
 #include <linux/cnum.h>
+#include <linux/gcd.h>
 #include <linux/bpf_mem_alloc.h>
 #include <net/xdp.h>
 #include <linux/trace_events.h>
@@ -17291,6 +17292,51 @@ int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 	return reg_bounds_sanity_check(env, reg, "bpf_set_reg_range");
 }
 
+/*
+ * Checks if pointer and packet metadata matches between two registers.
+ * For use with bpf_reg_union().
+ */
+bool bpf_reg_union_compatible(const struct bpf_reg_state *a, const struct bpf_reg_state *b)
+{
+	if (a->type != b->type)
+		return false;
+	if (a->type == SCALAR_VALUE)
+		return true;
+	return !memcmp(a, b, offsetof(struct bpf_reg_state, var_off)) &&
+	       a->id == b->id && a->parent_id == b->parent_id && a->map_uid == b->map_uid;
+}
+
+/*
+ * Extends acc's scalar range to include src's scalar range.
+ * Caller must ensure that other kinds of metadata is compatible.
+ * Caller must clear acc's scalar ID.
+ */
+int bpf_reg_union(struct bpf_verifier_env *env, struct bpf_reg_state *acc,
+		  const struct bpf_reg_state *src)
+{
+	u16 base, step;
+
+	if (!bpf_reg_union_compatible(acc, src)) {
+		verifier_bug(env, "union of incompatible registers");
+		return -EFAULT;
+	}
+	acc->r64 = cnum64_union(acc->r64, src->r64);
+	acc->r32 = cnum32_union(acc->r32, src->r32);
+	acc->var_off = tnum_union(acc->var_off, src->var_off);
+
+	/* Retain a common congruence if the bases agree modulo the gcd. */
+	step = gcd(acc->step, src->step);
+	base = acc->base % step;
+	if (base != src->base % step) {
+		reg_step_reset(acc);
+	} else {
+		acc->base = base;
+		acc->step = step;
+	}
+	reg_bounds_sync(acc);
+	return reg_bounds_sanity_check(env, acc, "bpf_reg_union");
+}
+
 /* check validity of 32-bit and 64-bit arithmetic operations */
 static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {

-- 
2.53.0
