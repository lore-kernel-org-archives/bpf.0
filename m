Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBCE330644
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643511; cv=none; b=eDjslFweY8vpzm+ViWfPHtOUnBqyUEKeFdMNj581eOtdWwm1qyay/1ZVOMTO7N5cxutqmltKEBsYifI7JpzPGCY4lcaf0BSShsSugx3UtPrM0SwpGVHDQSBmdtf8VFZ82eiZlpzHTdlWeNGGSSUvAux1EM/YZ9j+oP82VXUCIn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643511; c=relaxed/simple;
	bh=ETXIvHKrwCBVggmiDmDb5zegS9FxlQYUltJeCyUygbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tkqpx0hytlsYFfBrbQ8LtZBIT2SFmsxgudHPKynt+GVd9Bur9NfYUp761zmLJw00+3ZGGaWpO6nlyGDhTrnMLdJawkF6haNcNsuvlFEjSHpT6Lr0JvdK8cpJJKRyU5cgO8kyRRxO1JEXr1nVgzqBvrZJPAGLXl3aEdZx7LSXUHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIwN64hg; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIwN64hg"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b92ccb8e0so1555025e9.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 04:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789643502; x=1790248302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=owfl4Rbq9WmvSzarrpKs2iReyF0Uj7KPoPnI3AygyE8=;
        b=SIwN64hgpQEJlQFVIhUAx/B39j5vo+VSmJLwKlrcidlkNrNWx+0mx+yGR/1Hy2+Ifd
         jLcgnwAyYPbDbgdmjRMPcvk3Ox00YxeSqCYA8vJGwtBKc5CpsroH7B+eeDuZ9C24wSHp
         E2x6AHZJOOKgwkjPNY/8jwk65TRCRkrlHoS3RgM6GJ14MHm8A8oanxDZ7sVwqYL0b+kk
         pTpGJFCnRTXs6aSrkIx9ha0pdu8wzpEfqqO/YS+IFBdgqXG94HAeKeSfFrMD9TzHErgN
         TmD93iR0/m5I0c178EDlEfXKOHWqXFaPKFHRHbyMW2eBb3sz/1EaXrV0rTs2QgUGU9cF
         JZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789643502; x=1790248302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=owfl4Rbq9WmvSzarrpKs2iReyF0Uj7KPoPnI3AygyE8=;
        b=2kydhgTmX2ZkbuLclWk48709BZo+PwkjVhbQuNxMN6aLmYAP+LclJwohFmu3rORAF3
         QH7rgWMnc54EHHWP5d6AwIbn9Ol5KUJ5BsTkjUW+AyJGcf2YWaL2vzMKE7s2eEYE/y6c
         U/y4zsQksYRLt99ybywBfauU0KnhLhPkxuwRwKsRFN6qzjsHkOnXQWc5a8KEVB6OCcWg
         plNqPHKJny4xmnn1g810pO1QRPaPnjwPldYFxYow4WoZtHr1LXzzjcW61TLAEp5J1eCN
         16AAUjAISQIVPdd6tld5viDFwoQ5pD+Kj9hmKPR8R8W/1vRm3MSOYfU0WUaFi9wG/0u9
         3lDQ==
X-Gm-Message-State: AFuF++nceZI0NZQ0E5gNoSobtABRtfqvfrcYm9ZG5S9Kh9TEhDqT5GDP
	etaMZy3DLiUr/ZWVXgydhQxb21dz+oB5qI0St0WzaUqW9sFSa9GIm0lq1uc6lpxW
X-Gm-Gg: AYBFou09VAfLS1KFJqnGGwl0BwPD8XJK73P8KKyIHAvLdCLOIWx7ChbmQjGhF45jJVS
	76LjYFwJjFaHTDAoizNRDGO78msK7YcvUg1YXmCthokl+CZTiRvEWWte6KnR9FvVCQ+qCo/RVu4
	Wjg2QDjfKCsLryyobOQXMwadIJEN/qR/euSNj1AwLVi7Rug6DznAF8cueLDHsRfq9rzRfri9lz9
	/BAMKjSpb04YnqGykW9SZvyfXzwnst8WyWEihm+AR1jnp4g6MoHshsm20AoDBdPXgatLBagX1Eu
	5KNiYvxkJviKpn3d4lYdOI7UrQKUzwVkS4+swiYab6tOwxSEI2E7iFY6kZjlgO157mFe4bI9fRG
	24IFL5FlqbPOoHmfOvW8BV90Q0+HmkqcbEtvn9hcgjvy+QNKGC0jyDok22kqQ3dGi+rlB6ktVqc
	5Zkk4U+yckNl0anlgQaNA65mSmXhnHylYPNrB3RvSLJaR0cA7BrtwM+GbIN+tl8jtNO2poSywwR
	W4Cs1eqYAPtgqJkNrnWcd36yOgFJ3Vzkti652Ng4iBEsfv5gKOlWo+VQK5qpO3DbEAl/yh5BbRK
	fKEG50YFYK3+hXVVI+ROsEOpI+BDxhCH4CZQ3To=
X-Received: by 2002:a05:600c:6290:b0:49d:1df8:156d with SMTP id 5b1f17b1804b1-49eb732cd4amr69994895e9.18.1789643502442;
        Thu, 17 Sep 2026 04:11:42 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd1d0d0bsm65844345e9.1.2026.09.17.04.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 04:11:41 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v6 08/10] bpf: Assign lock identity to callback map values
Date: Thu, 17 Sep 2026 13:11:20 +0200
Message-ID: <20260917111127.3780880-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917111127.3780880-1-memxor@gmail.com>
References: <20260917111127.3780880-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7334; i=memxor@gmail.com; h=from:subject; bh=ETXIvHKrwCBVggmiDmDb5zegS9FxlQYUltJeCyUygbk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv1qeSm4q9vJHh1Lgn+DAxZ8/BnfWbq3dVX9tcs/2T/p mKXdlVLRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACZy9DDDLyaXe1YfChV6Z0xR S7S0/R8RcstGu5Vl7YXjb155Ht9z8gQjw6pyn46PU+3OKicWWLjOztp5RWmJZi3bpqNux25PXjD 3Hh8A
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A nested bpf_for_each_map_elem() callback can unlock a different element
of the same map:

  static long inner(void *map, int *key, struct value *v,
                    struct value **outer_value)
  {
          bpf_spin_lock(&v->lock);
          bpf_spin_unlock(&(*outer_value)->lock);
          return 0;
  }

  static long outer(void *map, int *key, struct value *v, void *ctx)
  {
          bpf_for_each_map_elem(map, inner, &v, 0);
          return 0;
  }

Both callback values currently have ID zero and the same map_ptr.
process_spin_lock() compares those two fields, so it accepts the unlock
even though the two callbacks can receive different map elements.

Assign a fresh ID to every callback map value in the for-each,
timer/workqueue, and task-work constructors. Copies of one callback
argument retain its ID, so locking and unlocking through that argument
continues to work. Distinct callbacks also get distinct IDs for
single-element arrays, including inner arrays sharing inner_map_meta.

Preserve map_uid for every inner-map lookup and compare it through
check_ids() during state pruning. This preserves relationships between
maps, keys, and values while allowing equivalent states with different
lookup IDs to match. It avoids field-specific rules for when an inner map
needs an identity.

Move map_uid out of the metadata union and next to the other IDs, so
register comparisons can use the existing memcmp() ranges and remap the
IDs separately. Clear it when resetting a register or converting a map
lookup result to a socket pointer. Shrink frameno to u8, which is enough
for MAX_CALL_FRAMES, to make room without growing bpf_reg_state.

Fixes: d0d78c1df9b1 ("bpf: Allow locking bpf_spin_lock global variables")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 24 ++++++++++++------------
 kernel/bpf/states.c          |  6 ++++--
 kernel/bpf/verifier.c        | 13 +++++++++----
 3 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index bba5a727c651..1aa245faa30e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -46,17 +46,10 @@ struct bpf_reg_state {
 		/* valid when type == PTR_TO_PACKET */
 		int range;
 
-		/* valid when type == CONST_PTR_TO_MAP | PTR_TO_MAP_VALUE |
-		 *   PTR_TO_MAP_VALUE_OR_NULL
+		/*
+		 * For CONST_PTR_TO_MAP, PTR_TO_MAP_KEY and PTR_TO_MAP_VALUE.
 		 */
-		struct {
-			struct bpf_map *map_ptr;
-			/* To distinguish map lookups from outer map
-			 * the map_uid is non-zero for registers
-			 * pointing to inner maps.
-			 */
-			u32 map_uid;
-		};
+		struct bpf_map *map_ptr;
 
 		/* for PTR_TO_BTF_ID */
 		struct {
@@ -155,13 +148,20 @@ struct bpf_reg_state {
 	 * gets parent_id set to the dynptr's id.
 	 */
 	u32 parent_id;
-	/* Inside the callee two registers can be both PTR_TO_STACK like
+	/*
+	 * Distinguishes inner-map lookups and their keys and values. Zero for
+	 * other registers. Kept outside the metadata union for ID remapping
+	 * during state comparisons.
+	 */
+	u32 map_uid;
+	/*
+	 * Inside the callee two registers can be both PTR_TO_STACK like
 	 * R1=fp-8 and R2=fp-8, but one of them points to this function stack
 	 * while another to the caller's stack. To differentiate them 'frameno'
 	 * is used which is an index in bpf_verifier_state->frame[] array
 	 * pointing to bpf_func_state.
 	 */
-	u32 frameno;
+	u8 frameno;
 	/* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
 	bool precise;
 };
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 6c88ad95b63b..e4ec007f7fa6 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -491,7 +491,8 @@ static bool regs_exact(const struct bpf_reg_state *rold,
 {
 	return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
 	       check_ids(rold->id, rcur->id, idmap) &&
-	       check_ids(rold->parent_id, rcur->parent_id, idmap);
+	       check_ids(rold->parent_id, rcur->parent_id, idmap) &&
+	       check_ids(rold->map_uid, rcur->map_uid, idmap);
 }
 
 enum exact_level {
@@ -616,7 +617,8 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		       range_within(rold, rcur) &&
 		       tnum_in(rold->var_off, rcur->var_off) &&
 		       check_ids(rold->id, rcur->id, idmap) &&
-		       check_ids(rold->parent_id, rcur->parent_id, idmap);
+		       check_ids(rold->parent_id, rcur->parent_id, idmap) &&
+		       check_ids(rold->map_uid, rcur->map_uid, idmap);
 	case PTR_TO_PACKET_META:
 	case PTR_TO_PACKET:
 		/* We must have at least as much range as the old ptr
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 33161dc64568..02be326f235c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1864,6 +1864,7 @@ static void __mark_reg_known(struct bpf_reg_state *reg, u64 imm)
 	       offsetof(struct bpf_reg_state, var_off) - sizeof(reg->type));
 	reg->id = 0;
 	reg->parent_id = 0;
+	reg->map_uid = 0;
 	___mark_reg_known(reg, imm);
 }
 
@@ -1925,17 +1926,18 @@ static void refine_map_lookup_value(struct bpf_reg_state *reg)
 	if (map->inner_map_meta) {
 		reg->type = CONST_PTR_TO_MAP | maybe_null;
 		reg->map_ptr = map->inner_map_meta;
-		/* transfer reg's id which is unique for every map_lookup_elem
+		/*
+		 * transfer reg's id which is unique for every map_lookup_elem
 		 * as UID of the inner map.
 		 */
-		if (btf_record_has_field(map->inner_map_meta->record,
-					 BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK))
-			reg->map_uid = reg->id;
+		reg->map_uid = reg->id;
 	} else if (map->map_type == BPF_MAP_TYPE_XSKMAP) {
 		reg->type = PTR_TO_XDP_SOCK | maybe_null;
+		reg->map_uid = 0;
 	} else if (map->map_type == BPF_MAP_TYPE_SOCKMAP ||
 		   map->map_type == BPF_MAP_TYPE_SOCKHASH) {
 		reg->type = PTR_TO_SOCKET | maybe_null;
+		reg->map_uid = 0;
 	}
 }
 
@@ -10048,6 +10050,7 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
 	callee->regs[BPF_REG_3].map_ptr = caller->regs[BPF_REG_1].map_ptr;
 	callee->regs[BPF_REG_3].map_uid = caller->regs[BPF_REG_1].map_uid;
+	callee->regs[BPF_REG_3].id = ++env->id_gen;
 
 	/* pointer to stack or null */
 	callee->regs[BPF_REG_4] = caller->regs[BPF_REG_3];
@@ -10144,6 +10147,7 @@ static int set_timer_callback_state(struct bpf_verifier_env *env,
 	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
 	callee->regs[BPF_REG_3].map_ptr = map_ptr;
 	callee->regs[BPF_REG_3].map_uid = map_uid;
+	callee->regs[BPF_REG_3].id = ++env->id_gen;
 
 	/* unused */
 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
@@ -10262,6 +10266,7 @@ static int set_task_work_schedule_callback_state(struct bpf_verifier_env *env,
 	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
 	callee->regs[BPF_REG_3].map_ptr = map_ptr;
 	callee->regs[BPF_REG_3].map_uid = map_uid;
+	callee->regs[BPF_REG_3].id = ++env->id_gen;
 
 	/* unused */
 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
-- 
2.53.0

