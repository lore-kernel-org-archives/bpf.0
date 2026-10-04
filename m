Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D4F17B425
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121124; cv=none; b=BW+704572SSkrckk48YfGtStcLq1Zuh79ZwU6EOnxJFaB8279UWIp/cAgCmE0sPr5dgQmQ3R6QJv/aB2K7Qzc2+eNsXgmR4kGnIR1cZ+3kqDbkBRs7RbHlOu4S92y+AYR8IzONfN4Qf/kbZjHpIUKn/RCKCjVeiePiyFLwhELE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121124; c=relaxed/simple;
	bh=iqmehQKlLVBGKWn6F6QRxA/TrXyJZ3OUt3YIGM0qR5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnVYpaWYL+LkqTKnsdV1SL4fBNYJkMmWgDkn0/OVzCXlRVf/uLbFeq17QDAmPnrTHYeMD0Dar6zYS5Vjpyl0ma4aVpW6+F0yDPO/fVqr4IYlAJCCC+cdmLQjZuzf2mBb08AGCydXDt1kqRGhz1K07aGwrQUbQApqCMWKoiSQ/4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aza7+3Pg; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aza7+3Pg"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3a7cfe8f761so71391a91.1
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121122; x=1791725922; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o9dE2kwaJ+nDLD8FESjFzVFLFMIYXqiE+l8EiYwgpPI=;
        b=Aza7+3Pgqtgw1cNMDluciMYPQ0hsM36IGsQShlEAnsdSZX+SADeEeXNqscumo1wCQd
         zzDieH0FDmzyzU2Q/cOdCq6tT6XZEFDM7cBeWuEKpCE2TC3KcZdF/3eIn3/TmHFB2XOw
         4CIjsRfrD37zi59oyDBaa2NDYAvaEyw4zrkDUlQ3dgzOgww4XP368W93u9PepRDEO9gP
         wcooRWnLF+omQql9Q8G0ILVtMuZuMWLrjEx53eOsfEqJQQ0ObUK4zdhwlTUnzgiOAFmo
         qZEb0NzMgZT69OsaZgESOIbAhfgQ24zLy4ytt/DD0K+2zgZEQ+/tHVv1R13olvgYeGyz
         tA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121122; x=1791725922;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o9dE2kwaJ+nDLD8FESjFzVFLFMIYXqiE+l8EiYwgpPI=;
        b=ntqjrgpbkIcNCYFNT3fPuev0W2biG6NBSG64cRDUlofA0G5dX5maopRcvSAVJ18ZB3
         Tml4sHA0urzAlkowTySRP9NFcirWldFMar9NW0yiiDiGQ6nCEnGSRq9+C1mi/EGgfge2
         T24Ocom/F/vzQoViAN4FBXWOEr7u5VuBSbtmC8SZOj3PZKq52nZ+ldeNb7dFFQXe2MfC
         CZzCTkOJmzqP0B/VZz1XmWTCwTVKuWwj9ZY6q2YctyefjUzMo1VRoMJPCA9AGN+SG3Pl
         SwL0RCO3vP28uWq6qQ+0vK4u4W54fwE8U7HTO8jMXTHt0QjW0JQ+b8YPvM9UZoUp49Jd
         n5og==
X-Gm-Message-State: AFuF++lyBu+hvqXM/cDD+5ncQPd2Cpakawqn2YOu/EOaFPHrt2+w38xI
	1JSyqComsnU3o1269T0raPu0miG/NW/yM0Ura2b6yNfTa2dYaUyl+PE/AsAkqg==
X-Gm-Gg: AYBFou30g//tTm1omKT3gXrLyniEWvCCSHDfr/GDOHnaK0ZYm22XMgm5Np5oSX02GsC
	huIRS3SzotA4joUuN/GXXLY9R4qpvOuxVc3PA6nuQlmzVJ0wXRh70q8yEfFuBguIZUB2PQz+mdQ
	8pTRC5BruDIyBJcBMxP4zrbCsWzFrB3phSTYSvdRhNFRui9+CfcIlF4sv6esGC4JSqZZk0fp1VZ
	8GzcNdFyzFJxtPAPwBwEplR46I9L74/Po278BfhX3G+5JfLUo4xfdlR8jjnw5yIdqy2pXlxvY3D
	lDJbzkmOZFaa+DqIdvZxhwhjlMnqC1K5g9WnufEtuMEJD9JEut5ob2NWf64zLu3vnWQpqYjtigr
	oaWAbW2hX+K4NG1UO2733su/51qSNZ0xLAnCMdzspykPrnLT6t9w0aaGm8Y6+3N3QPMkQGmgros
	fhz653VrDc0GmtOk0trQBwioyy9IzxWFuqxW/XH5vr42eBMRbtXFbYovsZcXPBSPcylBBGOmfii
	6lWkqvnaAgg1O50s7G3xdY8GA==
X-Received: by 2002:a05:6300:68cf:20b0:3de:a136:6850 with SMTP id adf61e73a8af0-3deacbf00c7mr4832104637.17.1791121122451;
        Sun, 04 Oct 2026 06:38:42 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:38:41 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 05/43] bpf: summarize may write stack slots in insn_aux_data
Date: Sun,  4 Oct 2026 06:37:47 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-5-f6254e29fdf2@gmail.com>
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

SCEV needs may-write information to invalidate stack expressions after
indirect writes. Liveness tracks this per function instance,
but SCEV is not callchain-sensitive and needs a summary across
calling contexts.

For each instruction, union the current-frame may_write masks from all
analyzed instances. Represent 8-byte slots as a summary of constituent
halves. Store the summary in insn_aux_data and expose it via a helper.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  6 ++++++
 kernel/bpf/liveness.c        | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index eafe79929dfa..4cb36ee3b6f7 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -662,6 +662,11 @@ struct bpf_insn_aux_data {
 	};
 	struct btf_struct_meta *kptr_struct_meta;
 	u64 map_key_state; /* constant (32 bit) key tracking for maps */
+	/*
+	 * Per-instruction summary of stack slots in the current frame
+	 * that this instruction may write to.
+	 */
+	DECLARE_BITMAP(may_write_mask, MAX_BPF_STACK_SLOTS);
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
 	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
 	bool nospec; /* do not execute this instruction speculatively */
@@ -1742,6 +1747,7 @@ int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env);
 int bpf_stack_liveness_init(struct bpf_verifier_env *env);
 void bpf_stack_liveness_free(struct bpf_verifier_env *env);
 int bpf_live_stack_query_init(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
+const unsigned long *bpf_may_write_mask(struct bpf_verifier_env *env, u32 insn_idx);
 bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 spi);
 int bpf_compute_live_registers(struct bpf_verifier_env *env);
 
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index e18d5d86c301..ec9c8beef556 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -718,6 +718,45 @@ static int cmp_instances(const void *pa, const void *pb)
 	return 0;
 }
 
+/* OR the 8-byte slots touched by a half-slot (4-byte) mask into @slots. */
+static void half_spis_to_slots(unsigned long *slots, const unsigned long *mask, u32 nbits)
+{
+	u32 slot;
+
+	for (slot = 0; slot < MAX_BPF_STACK_SLOTS && slot * 2 + 1 < nbits; slot++)
+		if (test_bit(slot * 2, mask) || test_bit(slot * 2 + 1, mask))
+			__set_bit(slot, slots);
+}
+
+/*
+ * Precompute, for each instruction, the OR of may_write masks over its top
+ * frame across all func_instances reaching it, stash it in the insn_aux_data.
+ */
+static void compute_may_write_masks(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_liveness *liveness = env->liveness;
+	struct func_instance *instance;
+	struct frame_masks *fm;
+	u32 nbits;
+	int bkt, i;
+
+	hash_for_each(liveness->func_instances, bkt, instance, hl_node) {
+		fm = instance->frames[instance->depth];
+		if (!fm)
+			continue;
+		nbits = frame_mask_bits(fm);
+		for (i = 0; i < instance->insn_cnt; i++)
+			half_spis_to_slots(aux[instance->subprog_start + i].may_write_mask,
+					   rel_mask(fm, i, FM_MAY_WRITE), nbits);
+	}
+}
+
+const unsigned long *bpf_may_write_mask(struct bpf_verifier_env *env, u32 insn_idx)
+{
+	return env->insn_aux_data[insn_idx].may_write_mask;
+}
+
 /* print use/def slots for all instances ordered by callsite first, then by depth */
 static int print_instances(struct bpf_verifier_env *env)
 {
@@ -2352,6 +2391,8 @@ int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env)
 			goto out;
 	}
 
+	compute_may_write_masks(env);
+
 	if (env->log.level & BPF_LOG_LEVEL2)
 		err = print_instances(env);
 

-- 
2.53.0
