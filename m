Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F534F462
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 22:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770849124; cv=none; b=l9U1q7a1dXMnJFgvkHcEJTLhmfPb8UwGr/ODM+XBVCeVIHufSawxChXNLojEViUQCN+zPo9eA385S8N3w2Mz9sYPNDlTOMDPEvUQbJZ+Eg0uBydOVzn3Qz5GcWImVWuGW4UBIVX0HWaVBJZJw0Rg4ipchSI5Pt0ah1YdUQIerwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770849124; c=relaxed/simple;
	bh=2PFZyi7InxAQcPnQHJZiTdBJzORhx1XwoHMQmCXzpbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tW/hAZmroJuZe1QtkIs+7rajNdRBj/Ng6Rhyd/rUHeUcgrwFtg7amHyCbQPalR/WpLjoBPq9Rbct34OIXZTX4HH9x2ulMpv2hhZEfjaJZvtY5LC15yoWVHNZHgHiIETf8c6hVueSxsddgvi6F3IHY6iZUCJvHP0m5Kj5YBaY3WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGk/E/Wl; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGk/E/Wl"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b82c605dbdso5181370eec.0
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 14:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770849122; x=1771453922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zuu3zoTWf52wdIAimocQ+1eOtd74hE4mgFBkYURpqAA=;
        b=kGk/E/Wl4sOSstYd4ueHL3K3rStYBs2RDIQo59ud972BfnKINunr4O5joIhJSpi4f/
         UGLxKHJL3uTGwUGc3H1KD7aFThX1l1oHTpQEDzpw/HCxa41l+sFeJQ2Z6/VRAQRzunrF
         cYRXEUvqYngrMl8CeoeY2D7b7FMXJC567UAKFwGm06KGJPjBz8h3KBt8cDtg3Ny9sDKt
         tOnG+sLnwIz0j1gH73T/7uaVZoTPqMGYJ1PDY2GMqIFQqWjLLThEnrBQN9nFbWiGiuFk
         kTTIn80l8PEoGnxWle3Szca0a0lCQFQZRKY8nPc5H2nhDP5kBEKS/lr0p23ByzmjWnpz
         1jRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770849122; x=1771453922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zuu3zoTWf52wdIAimocQ+1eOtd74hE4mgFBkYURpqAA=;
        b=nOFsOGfbyte5zpKNlbfL46x+j/yeWyQ0UF7ArAOUSx+1dLG57jp4pHhzDALASWFM+z
         AeLZ4dS2TSDIuLOteExmRoHS4il4PZGC9DLkM3ibopAqVJLpQsLrJW3OoCXYfy3ic7Z4
         qVXj5ErG7No8Q1EAiUHI1EHvqu4tWbusuHR390trdmroGMaGbOwgrW+BzLlh20MTaoiy
         JzEmkMedbisu0sq4+evPMN0IBGgOb7BYKq+Lmh1nLZReGZPXDlXrrEUpA3AlJW2TsykI
         onKw8KkALY30U3Hs8dl88Z3TQk5g/aJurUXGhUOOaRRP66Gkpac2TvtM7bh1pQMVcVB9
         md/w==
X-Gm-Message-State: AOJu0Yy1v7RCIa4VUt8k2Vq+omzLWWrvcCInar1S+bYLNYLWKrpSyHlw
	dnnhtTlmZz57eKSPMWL4dOtFaE0rJlKCg+krQIivVdogxg46/ZCQdzTNnu3w8R2B
X-Gm-Gg: AZuq6aIZuUYKATCTu6S62s1JihuVPs9+RZslAiiQ0dV+SUxuRG5WJ91Y7S6HBaR139w
	Uwon0LhuxXSXMeWSZoWWXPg3MswyRfe9bdM1fU22TAAblTU0JdJ2AJ2gWz3O5Ns5mb3RNzDVHSo
	JQxrXIkKI/f1vFl/dCwiFvGyZQWk2X5zgr1WvJiNo/uH7Th5+blaazoRIIqXlR9cdvYs1ZpTZIB
	MqS7s9Oqoxq2IY72hOKL6kseHyehSc9DvuvRe9QzXHDLrBqt2QQcdLgHg9wnW8TZWTJvyPBQCtz
	uydY2XEtCwaMoMtp7qniedAnkNH/FPTIn5plAJsoey/O+blYRaKme5F7RLU+3QvezXtOn7PN48n
	8raVXdkE+HO0sniEAEzfE4crVKvaF0D6OWyyQfZT8Fz2iIXeshs5eY+g2JLLag7wDZKWZK2NM2s
	5QKgMoy3b9VWj7+8ycep06FY7rC9ndjxt6Uo4wonQ1YDVLt/0yBVtC8Oo+6BUBg5LpO0F2j8DS2
	9QkzcU=
X-Received: by 2002:a05:7301:7c12:b0:2b8:711:ae5c with SMTP id 5a478bee46e88-2baac57c505mr146000eec.7.1770849122414;
        Wed, 11 Feb 2026 14:32:02 -0800 (PST)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::2:8141])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcd0609sm2639306eec.16.2026.02.11.14.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 14:32:02 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 3/3] bpf: rename bpf_reg_state->off to bpf_reg_state->delta
Date: Wed, 11 Feb 2026 14:31:40 -0800
Message-ID: <20260211-ptrs-off-migration-v1-3-996c2a37b063@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260211-ptrs-off-migration-v1-0-996c2a37b063@gmail.com>
References: <20260211-ptrs-off-migration-v1-0-996c2a37b063@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This field is now used only for linked scalar registers tracking.
Rename it to 'delta' to better describe it's purpose:
constant delta between "linked" scalars with the same ID.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  2 +-
 kernel/bpf/log.c             |  8 ++++----
 kernel/bpf/verifier.c        | 18 +++++++++---------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index a97bdbf3a07b63246ebf2021816e81c147989381..170a5f71b55043698e5a7f7e042f30dd5579715f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -40,7 +40,7 @@ struct bpf_reg_state {
 	/*
 	 * Constant delta between "linked" scalars with the same ID.
 	 */
-	s32 off;
+	s32 delta;
 	union {
 		/* valid when type == PTR_TO_PACKET */
 		int range;
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 39a731392d6520a1345fc3d79e86fc43f63e426a..37d72b0521920daf6f3274ad77d055c8b3aafa1b 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -694,7 +694,7 @@ static void print_reg_state(struct bpf_verifier_env *env,
 		if (state->frameno != reg->frameno)
 			verbose(env, "[%d]", reg->frameno);
 		if (tnum_is_const(reg->var_off)) {
-			verbose_snum(env, reg->var_off.value + reg->off);
+			verbose_snum(env, reg->var_off.value + reg->delta);
 			return;
 		}
 	}
@@ -704,7 +704,7 @@ static void print_reg_state(struct bpf_verifier_env *env,
 	if (reg->id)
 		verbose_a("id=%d", reg->id & ~BPF_ADD_CONST);
 	if (reg->id & BPF_ADD_CONST)
-		verbose(env, "%+d", reg->off);
+		verbose(env, "%+d", reg->delta);
 	if (reg->ref_obj_id)
 		verbose_a("ref_obj_id=%d", reg->ref_obj_id);
 	if (type_is_non_owning_ref(reg->type))
@@ -716,9 +716,9 @@ static void print_reg_state(struct bpf_verifier_env *env,
 			  reg->map_ptr->key_size,
 			  reg->map_ptr->value_size);
 	}
-	if (t != SCALAR_VALUE && reg->off) {
+	if (t != SCALAR_VALUE && reg->delta) {
 		verbose_a("off=");
-		verbose_snum(env, reg->off);
+		verbose_snum(env, reg->delta);
 	}
 	if (type_is_pkt_pointer(t)) {
 		verbose_a("r=");
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fe7598b0eef94eb0b0a4f4e7fd18e5de3209d882..8d47eb000459e363d20f8d44a2e326ccc8a1c29e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5095,7 +5095,7 @@ static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
 		 * Cleared it, since multiple rX += const are not supported.
 		 */
 		src_reg->id = 0;
-		src_reg->off = 0;
+		src_reg->delta = 0;
 	}
 
 	if (!src_reg->id && !tnum_is_const(src_reg->var_off))
@@ -16217,14 +16217,14 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 			 * we cannot accumulate another val into rx->off.
 			 */
 clear_id:
-			dst_reg->off = 0;
+			dst_reg->delta = 0;
 			dst_reg->id = 0;
 		} else {
 			if (alu32)
 				dst_reg->id |= BPF_ADD_CONST32;
 			else
 				dst_reg->id |= BPF_ADD_CONST64;
-			dst_reg->off = off;
+			dst_reg->delta = off;
 		}
 	} else {
 		/*
@@ -17292,18 +17292,18 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 		if ((reg->id & ~BPF_ADD_CONST) != (known_reg->id & ~BPF_ADD_CONST))
 			continue;
 		if ((!(reg->id & BPF_ADD_CONST) && !(known_reg->id & BPF_ADD_CONST)) ||
-		    reg->off == known_reg->off) {
+		    reg->delta == known_reg->delta) {
 			s32 saved_subreg_def = reg->subreg_def;
 
 			copy_register_state(reg, known_reg);
 			reg->subreg_def = saved_subreg_def;
 		} else {
 			s32 saved_subreg_def = reg->subreg_def;
-			s32 saved_off = reg->off;
+			s32 saved_off = reg->delta;
 			u32 saved_id = reg->id;
 
 			fake_reg.type = SCALAR_VALUE;
-			__mark_reg_known(&fake_reg, (s64)reg->off - (s64)known_reg->off);
+			__mark_reg_known(&fake_reg, (s64)reg->delta - (s64)known_reg->delta);
 
 			/* reg = known_reg; reg += delta */
 			copy_register_state(reg, known_reg);
@@ -17311,7 +17311,7 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 			 * Must preserve off, id and subreg_def flag,
 			 * otherwise another sync_linked_regs() will be incorrect.
 			 */
-			reg->off = saved_off;
+			reg->delta = saved_off;
 			reg->id = saved_id;
 			reg->subreg_def = saved_subreg_def;
 
@@ -19616,7 +19616,7 @@ static void clear_singular_ids(struct bpf_verifier_env *env,
 			continue;
 		if (idset_cnt_get(idset, reg->id & ~BPF_ADD_CONST) == 1) {
 			reg->id = 0;
-			reg->off = 0;
+			reg->delta = 0;
 		}
 	}));
 }
@@ -19753,7 +19753,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 			return false;
 
 		/* Both have offset linkage: offsets must match */
-		if ((rold->id & BPF_ADD_CONST) && rold->off != rcur->off)
+		if ((rold->id & BPF_ADD_CONST) && rold->delta != rcur->delta)
 			return false;
 
 		if (!check_scalar_ids(rold->id, rcur->id, idmap))

-- 
2.53.0
