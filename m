Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617EE466B70
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432458; cv=none; b=LkGMFpnNgK0b0ay9Yhn82OiiOms/94Yp1LmJvCmg6ced/EquBJA376cM1oJJ2/+vCYt1PAE24y1oARTHTC/PKMAKd43r2ylYn4ZAKNw5ji949J9WywesTIFq3OIJqA9oNi8wXB3GbEvKDimx+CFj0//UaxeNr+8xuSahA1+0md8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432458; c=relaxed/simple;
	bh=sh21OCSOpw/0JdxqcJkMNcyP1h4Yui7PLPRy+4kcagM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzvaPYi0Jl81qCZpROufr4vHq9cmsovPl+bcX1fIR+JU1xErIqG72Ln1igpH68tUTKATQsnJqMWPkZcSpcjilT4BuYhxnefPWyVt0IQVrAFA/onmCaYz6VvpQIkMQpFEKCvIUZtQyqO26V/1UnhgNKPENzrbklmbZkm7ztQs3Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HK5okGWC; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HK5okGWC"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0b6200eb0so1305518a91.2
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432456; x=1791037256; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mJaFEb6R9EFikkeg0iZgPvrkezv8YHql7yg4MpyWneM=;
        b=HK5okGWCh+MoEd4wNgG1oB+JUBihixNTZaj3UuBqVPIPMDB4X9b3bwf/MyTNEAa9Sq
         Tbm8EFu4StLJwDwmnvMJosiGfyO7zwcT1XC5vkb4U8RN6xFcy7yTcGkFwLXWhlD7ocC7
         cXmf6R6i3PwKlfkxcKL03YpB8/rSNhZomTMoeuTeaZ36GjO4m8KZn6o4N+GRDeJQlg8j
         qtqCgajeGPX+G5xPfhCMyAYptnLLnhczUC10Ab6wql0PsSdbDHMqZTZ1MOXxDP0MMK2J
         0gbxggy92w5abUbCOLd7tdShDjnY/MQf8k8luMB6vTRDoJjJftBCgaJa4wFbQae4gKHH
         C+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432456; x=1791037256;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mJaFEb6R9EFikkeg0iZgPvrkezv8YHql7yg4MpyWneM=;
        b=CmaLFXSeXid+KmmCHimUEcmzpfufoWmduJMyQy0j1hPHfgPFVgURs8uZJvi9ivu5TS
         3rXr4gr773RTnUxrfeDa8rgTUlFfttD1TKIdB5CCK5sWxFQgGJfTAkuaJPHH9nX6IaGo
         BqlibdojKMyuqK8okoKUvIdLWudFI6/wbsTpL2HqJOPi3kxDgxEPyUO/EUtU+Gkx7ZFs
         J7ITjUe/SLVn2xQkK5wzR0qSWwYniwuRiU0/v7S8SY6yS/14/jCkT7RblfI2lf4KnVT3
         kqIEHylEq+TEMOVAo4nKUVclkEA/oinhJPmC6ThSIySKccEoqnpGfEZOWSrOrMF356UG
         Dmyw==
X-Gm-Message-State: AFq9FYK+gUd9d5Q7RceEpi85v5Mq17dTLeyWyHTcdmqwoo6kW7ClxxTO
	ob2j/Xn2+qMbhjSPkdw4ZmjE50+I3cFPqU+F4JFfRTgXQAhgOZh0lDeOmv87JDyeGIs=
X-Gm-Gg: AYBFou1sT06jwdbDPhjj6dhyY6UjTCaAFLoMOui5VQArhNoHgGWBjFIU+RvzqbXlNho
	SpR2S6A1C7IzBdGnHy90/WpWfKuGSAY6bfiJwBZtF+iAGzdoQU3FcU9orYObDvWQknZ3Or62Fo7
	x+u9HK+zjjmTSNSEeon54+8bX8t2pW9hLnskPmAXJ8+JVE7lIwKgKi6wDGN+ZxyhFAdez+Qfr4x
	kS1tV+/2NCgyDpXDF6vvOX9mXvmWmDZK3E9C8rdKxm28nk2Knre8zvpioEBB9HD7MsKyotCLleJ
	EN3KxaEE4hFwUaWdJPsZGxsqQexmBH6631KhVXUveCWcmZ4hirlhCSb4im44wMb5nOQWBoiHcUb
	SA/JaY8vA2MRJyHPD8FcQaTrEVLOHqdsCyBT9rhzOB0g6SYYeZNdOY65F4jDfryNU0jeZLBNkAR
	1EX2RoSqjBaOKOnyQm0AtWmCoawuYssaVeYXGdXjqYM933Pi3pugBaxaqk98UMptE/ayHnly5es
	qhtWK2OCvs+DlhsB+zy5SIXII4QVkTxSI+XXvNsTA==
X-Received: by 2002:a17:90b:2682:b0:39e:6a80:b795 with SMTP id 98e67ed59e1d1-3a0bb60b2f7mr4398587a91.37.1790432456577;
        Sat, 26 Sep 2026 07:20:56 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:20:55 -0700 (PDT)
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
Subject: [PATCH bpf-next 10/36] bpf: add bpf_mark_reg_known_scalar()
Date: Sat, 26 Sep 2026 07:20:08 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-10-c8e5ab5ba79f@gmail.com>
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

Provide a helper to set a register to a known scalar value for use outside
verifier.c. To be used by SCEV widening logic.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 1 +
 kernel/bpf/verifier.c        | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 94c0dddaaaa7..719b7c7fd2f5 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1293,6 +1293,7 @@ int bpf_push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state
 void bpf_bt_sync_linked_regs(struct backtrack_state *bt, struct bpf_jmp_history_entry *hist);
 void bpf_mark_reg_not_init(const struct bpf_verifier_env *env,
 			   struct bpf_reg_state *reg);
+void bpf_mark_reg_known_scalar(struct bpf_reg_state *reg, u64 imm);
 void bpf_mark_reg_unknown_imprecise(struct bpf_reg_state *reg);
 void bpf_mark_all_scalars_precise(struct bpf_verifier_env *env,
 				  struct bpf_verifier_state *st);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f2d44e026e4b..b5f45cb46f14 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1932,6 +1932,12 @@ static void __mark_reg_known(struct bpf_reg_state *reg, u64 imm)
 	___mark_reg_known(reg, imm);
 }
 
+void bpf_mark_reg_known_scalar(struct bpf_reg_state *reg, u64 imm)
+{
+	__mark_reg_known(reg, imm);
+	reg->type = SCALAR_VALUE;
+}
+
 static void __mark_reg32_known(struct bpf_reg_state *reg, u64 imm)
 {
 	reg->var_off = tnum_const_subreg(reg->var_off, imm);

-- 
2.55.0
