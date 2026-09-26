Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874FD43CE7C
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432450; cv=none; b=ehzUzruF/uNoSkOdsdZRY/KASJHBi4rm3/bnbRIs33o19uJFyDNmyCJay2F18waDq6/ygYHrfTSkn7rya9humSp6T63aeMEHcE+gRzfTmpbwR14BvCXU0ZLS7nGdx/IbmshJc7o9jmDE7UgX019BmPf+djiFCFysuYpcW6s0vEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432450; c=relaxed/simple;
	bh=1CDoOUplbdqfGcO3s4QqECd/E2shnq9XGntPRzf0mmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Luq8GZdBx92jz2Qfd7Ic8ofj21uD4pXUzk+5uCydNUkhVZxYgtaPxDiQTMWtxsvWN6FVbHRXKGSWMBlj864U76NIEP6sBdkStqjMaHvEGte9pI2U7VrjZ4NTlMvhqu9e4Z4PzUj9XprIssmfWh2ROjb9Q+s9kwxA16MjUpp9Ei8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNFUcH0b; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNFUcH0b"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so1154537a91.0
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432449; x=1791037249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ruIBN+XL3DyNoRYSYzO7T88j17DX902s14DtniW70p8=;
        b=aNFUcH0bDBxQSZ5yOdmyUJzeOYR0pv+xkhM/63KgAjo6b4bxRloOPe6sKcDk3JICxm
         O6a6BkrUQhZJnnoh5D6HzKvhnrW9YMwsIrGlIuNf+kByQaIlORXtD1V2YyasHJ1rUN6V
         WG/KJMZvnBfKkY7HkZUKH13e0nQpFYm9Rm1Of2GpmbWCQpYTbacc8LStpZoDTTOvnSaI
         ZiO9yZOgPNNuCPxCwkEo60xFGhAecZxDaZJaDhS5Ub8djw5fxONHf/Ft30XEO9uht7FS
         SgxNcQ16RTIJdFe3QJVDvKNC5/A8l0yHF2jBe77TLCGU3RyVCozzHGBlIQbfXb7P7yj+
         oK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432449; x=1791037249;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ruIBN+XL3DyNoRYSYzO7T88j17DX902s14DtniW70p8=;
        b=EamF+wA8uZHtJXsO5xd+NwgEhKzOEnOOdphHhyVMke7sghAme8pangETQLmbOTE2ki
         Q5AX05UiWULAFecxoNZXF+NQoDG2OIprEux9qyDM7GAN1ZozeiBXCbNsn42jfpI5L4g3
         ao/47wLt+12yWNRvBVOqEIVoO5L72OcPCB/ViFOsSA6RxXIZeq7TejMgtR/AxHnhNWZR
         VFWonEfCOz8+vb96H+DbcxTB+5ljQK4Wirjzm96n5gBS1ElkKVAFaCWJRtSKOIcWc/qW
         kPhJDVa0NMnfIYub+AxXXyGJFEsevp+F+GC/IDN9l2cn12MAdUzxo9gkk4sH0TzggB03
         INkw==
X-Gm-Message-State: AFq9FYLQ1pjsCreUAWRdU4uUltAncDAIKQCJ3Vvza2RR2xoiI60cYOoQ
	cMZ0zv0PpsRC8bPypfZNb8mUf4/yQKwTOD1T0It3oFmymAt6IYPcYZhBrn1HFjGpulM=
X-Gm-Gg: AYBFou3KkDBJr74u0Lg5jqDMJNF/fwm8jiOJxYVisWeLGhjlrmD9yfRsVzTHyLeRDOs
	Gj47AeZ4AzN2TjCqjlcT2pxlR8XdCXuEEJPprjuCX7wrP9buvBTmhcsuwOjpcMtCBVh84JejIKJ
	n4ctIg7n2GtXlqv+7AZyuSt6B4xaGrQTb3pMwKQ2PITOt3fBqadtfn3QxR3fGTDB7QPneITnNHI
	LnbcoKHWu37/wt2S1wrMoh+wFWrD9vzN5v2IVEqYDcwXSedfESBFqhgZWhrZQerLjZMwQNhnQH4
	IxJPBLxDlUXeDaBtMmOUDOI+4nI9D8AzGkqXV2OglHnULyyAaBPAC3Mgj3DWupSPB7BvbQaFRHc
	Eh1g4doi0xQPiSeJj66yvMemdWmsKDwefpk1u2mzbbrTvWlUhg9fnpWIbWZHR5um6HJJ2oEjupL
	3THRJ6yDZexIi5/MzxvNI9mq1wrV6OL+I38DUYPs64yn+gmoqQpHyRtWF43Kb2N3eCh3SCPhikG
	YmNtZVxnDCNzEtJ42JpnOH9KORZGMQ+kvhD/7cQzw==
X-Received: by 2002:a17:90a:908:b0:3a0:ace4:d2b0 with SMTP id 98e67ed59e1d1-3a0ace4d715mr3223657a91.44.1790432448663;
        Sat, 26 Sep 2026 07:20:48 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:20:48 -0700 (PDT)
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
Subject: [PATCH bpf-next 02/36] bpf: summarize may write stack slots in insn_aux_data
Date: Sat, 26 Sep 2026 07:20:00 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-2-c8e5ab5ba79f@gmail.com>
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
index c775bd757706..c6d617581e84 100644
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
@@ -1728,6 +1733,7 @@ int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env);
 int bpf_stack_liveness_init(struct bpf_verifier_env *env);
 void bpf_stack_liveness_free(struct bpf_verifier_env *env);
 int bpf_live_stack_query_init(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
+const unsigned long *bpf_may_write_mask(struct bpf_verifier_env *env, u32 insn_idx);
 bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 spi);
 int bpf_compute_live_registers(struct bpf_verifier_env *env);
 
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index cc3ad75aa1e2..c871744ca5a8 100644
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
2.55.0
