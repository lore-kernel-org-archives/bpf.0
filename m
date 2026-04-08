Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E70192D8A
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 02:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775614448; cv=none; b=Z/sGqK/oS+nMlpDVwQgsH6aOxiohf30t3oz+1A710of3BrM/S/WzfKmNhBrZeYnfzfsfQDWB4U94UrrmWgnWnp39smh8vFY/8MczTK6jaIXEmJWs0COUHnswcoX4+LsytdKvxCNCEUHkIZv5VNdCMPKGPMv3sUoTT49T8bKXU7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775614448; c=relaxed/simple;
	bh=SQqQfl7a+Fh2xCVzUdbmsb2DWOr17b43pgna+ZHiLpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBa94Hl3Srrsr8RxiHPgRv3qf1BF3Q1LgLkiv+TroJb1dsO1s62A/QAQ9WdVtXFTgiqUgBYi3xruBEfCaMmtOlsOv89uX/0G6qigxPPvL6WKeylSWAAgkIEmOanrv+ftXQq5+eb71gHF00qkCLP0mTXsB/Xv0OklADMxWe7oBVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDTH/FP0; arc=none smtp.client-ip=209.85.167.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDTH/FP0"
Received: by mail-oi1-f196.google.com with SMTP id 5614622812f47-4710c186d8aso951107b6e.3
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 19:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775614445; x=1776219245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oH4UJFv6/mbcT42avIP/tkhijhM1R3RTqJWFev1BEbc=;
        b=WDTH/FP0wtVQSK7O1uX8UKvY2cvR0eBgRX56MlZCyz/TrwnyolP/AAovctTG1FhzHM
         FmvJXkw8wb6kKpj6ZJHbSgN1MwQCS+F0EemRQEQRqP7fMB9TJWZgtdrsRtX26XMwSzIv
         VKPj4wjuDCzhhclxsgW/DVZunJTn1TRbWpb7vOoNunUTBo11j//QBgfi4yMB0HtYuuNY
         rCBrVVEi4rs/W0lR3VK6LlIryOInYqTosPS5UJBbG6rghQRDeNQHWiV1FZoFGI/2l72F
         z54zaFCu9YSh3MvmgeRVON9C2HPgakLkhSZt3gR1jueIujgpFR2rr4Fim2hiu5Eg+Dln
         NC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775614445; x=1776219245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oH4UJFv6/mbcT42avIP/tkhijhM1R3RTqJWFev1BEbc=;
        b=MxSBwEwOQF4GudwRb5y7qNNHq4QHIkV0sODRYSyiK0AqrQ4FzMgmTFksvY+fxK4SsB
         +wcO+A4oFvMIu8w6ttFNb92brMnI2HqG4Eu/dwsC83YRQFnvMysoJB1v+He1mQwmjvEk
         DkCSXu53ygwtZgdhK8IrWWpWj6Dad1FSm/WUC1y7ZB0BBfmfd6x8GuyFk6AbIiDITX0X
         FYox3KNknwEHZsrrzaxF/qEigygeeTcL3DyljYWHeKEG2Om0x4JY5uiZfuxNHwZqZSeT
         dY0ECfZSrlj3BDELXMbB7HrfI7N2+PzYEkVhKomUL5pE2MSXawiWUt1N2kBz5RPLntOM
         5KTA==
X-Gm-Message-State: AOJu0YwgmkdMMpIWLGtHAVB2r8Cooo1FcFHQuvvybsLdRdjRDMKF9BIf
	k/jDk4ISI2AmUpwHIdxGQQK5MtgT3yK+YYSskKXWVyGbURPdD7hBNMAxIX6Mx4igE30=
X-Gm-Gg: AeBDiesDunxIM3EaRDo3AkDN5zMDc7DnnmdNPuzwuETXjUgVQZ9lanXS8Ymz4uPBsM1
	TpCHKT3Cg0YQB5YEZub6OFx3yLGbLBsC5nI6GcLLLzGmD08v7eOswrEZjK331fs8BVWdVh2lbtD
	KK0VRBJN9ieunl6Y69jLDHyI+0pfxhGnQUufAoqYepE51q80Mj2ecfN0vOJqfR4NqzoLQqdAEZo
	b/xKddXQQ4aCReSmGt1Js5qe9rzZT2BQLVo1uNS6tM586dv1Hi8qedypXbMy40UIWyCltXxVDw+
	5+8s6/aeoC9y8dRxCS5X2x/OTSXOFVxT/NpgMbsqS5Us85F61qdK9hfRQ1SVJiYlX1nb+O9PHI9
	iNW2/HFz36xijwLnzO30Y+KBqi29nqVWnoRf9D1fkFpmXghe53qNFKMm2IrUHDRk6sRhOHec8Tl
	gfgjsa/FECODjRyc1bo/wLs1W7DTqvYHdgnn0eMGuTmCM=
X-Received: by 2002:a05:6808:1808:b0:468:9c8:791b with SMTP id 5614622812f47-46ef73079e8mr9381737b6e.33.1775614445137;
        Tue, 07 Apr 2026 19:14:05 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46f0f4e16a9sm8571553b6e.4.2026.04.07.19.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 19:14:03 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/6] bpf: Add support for verifier warning messages
Date: Wed,  8 Apr 2026 04:13:52 +0200
Message-ID: <20260408021359.3786905-2-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408021359.3786905-1-memxor@gmail.com>
References: <20260408021359.3786905-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3571; h=from:subject; bh=SQqQfl7a+Fh2xCVzUdbmsb2DWOr17b43pgna+ZHiLpo=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfPqzmNrOvnvOTqdTppSc41P8+VOF3kdqy2f5fcX1n/4dKqh pH9VRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACZiaMLwh68po3T5HXfmrW98pU2XPd seNi290OnTp5jjud8fV8e8v8LI0GaVlyr0uYF5j2tSZsWmzwXVH57YdK18+/0AU0FPYPs1ZgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Relax conditions such that we allow log_level = 0 to have an associated
log buffer. Add a warn() macro that emits messages to log buffer without
any restrictions, aggregate the warnings emitted, and then use it to
decide whether we reset the log or not.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/log.c             |  6 ++----
 kernel/bpf/verifier.c        | 17 +++++++++++++++--
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 36bfd96d4563..c7b34236a4b5 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -795,6 +795,7 @@ struct bpf_verifier_env {
 	bool bypass_spec_v4;
 	bool seen_direct_write;
 	bool seen_exception;
+	bool warnings;
 	struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
 	const struct bpf_line_info *prev_linfo;
 	struct bpf_verifier_log log;
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 37d72b052192..c67fbbbd5768 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -18,13 +18,11 @@ static bool bpf_verifier_log_attr_valid(const struct bpf_verifier_log *log)
 	/* ubuf and len_total should both be specified (or not) together */
 	if (!!log->ubuf != !!log->len_total)
 		return false;
-	/* log buf without log_level is meaningless */
-	if (log->ubuf && log->level == 0)
-		return false;
 	if (log->level & ~BPF_LOG_MASK)
 		return false;
 	if (log->len_total > UINT_MAX >> 2)
 		return false;
+	/* log->ubuf may be set for log->level = 0 to get warning messages. */
 	return true;
 }
 
@@ -229,7 +227,7 @@ int bpf_vlog_finalize(struct bpf_verifier_log *log, u32 *log_size_actual)
 	int err;
 
 	*log_size_actual = 0;
-	if (!log || log->level == 0 || log->level == BPF_LOG_KERNEL)
+	if (!log || (!log->ubuf && log->level == 0) || log->level == BPF_LOG_KERNEL)
 		return 0;
 
 	if (!log->ubuf)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 594260c1f382..86d77d5f7f83 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -47,6 +47,7 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
 enum bpf_features {
 	BPF_FEAT_RDONLY_CAST_TO_VOID = 0,
 	BPF_FEAT_STREAMS	     = 1,
+	BPF_FEAT_VERIFIER_WARNINGS   = 2,
 	__MAX_BPF_FEAT,
 };
 
@@ -368,6 +369,17 @@ __printf(2, 3) static void verbose(void *private_data, const char *fmt, ...)
 	va_end(args);
 }
 
+__printf(2, 3) static void warn(void *private_data, const char *fmt, ...)
+{
+	struct bpf_verifier_env *env = private_data;
+	va_list args;
+
+	va_start(args, fmt);
+	bpf_verifier_vlog(&env->log, fmt, args);
+	va_end(args);
+	env->warnings = true;
+}
+
 static void verbose_invalid_scalar(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *reg,
 				   struct bpf_retval_range range, const char *ctx,
@@ -2128,7 +2140,8 @@ static int pop_stack(struct bpf_verifier_env *env, int *prev_insn_idx,
 		if (err)
 			return err;
 	}
-	if (pop_log)
+	/* Preserve warning-only output across branch explorations. */
+	if (pop_log && !(env->warnings && env->log.level == 0))
 		bpf_vlog_reset(&env->log, head->log_pos);
 	if (insn_idx)
 		*insn_idx = head->insn_idx;
@@ -25211,7 +25224,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 
 	ret = do_check(env);
 out:
-	if (!ret && pop_log)
+	if (!ret && pop_log && !env->warnings)
 		bpf_vlog_reset(&env->log, 0);
 	free_states(env);
 	return ret;
-- 
2.52.0

