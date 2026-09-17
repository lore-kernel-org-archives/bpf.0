Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11514B1D0B
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 23:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789687961; cv=none; b=NZ2vCGE5rZJKSTg5MtjdFKHYyQMr3ggT4V21qWX4wo65gaATSm1ExRkl4kxzciBET4xwJHrTkhUE3+ZZiPWhW9wwAgkpRfZ402vjS0mXp6JtVNte4Zim1ITZmvOdZj0Kq2kJ1rqg+5fb1Q75WfDJJUAMj0IZnBDwQpqfoOmGdTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789687961; c=relaxed/simple;
	bh=wMSxoVbKdZa6FldBvAlTNmGa9ahWmI26PhwAhzmojUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ronlm1v2evKoUUwXDARR9/1g6+Kn86erQzRRFPmi5UwqYDexs0kz4jANPRx3CnifUpxgZ1On/OeXt3JbR2NT1tRjmrpUxodEfzi9/iRjLeiaDvp8x3sgqCrcqcAeRxqgBPuNWIfFqh7Dufjaf5V/t3EPIF6SS4kJgKbuRExfHwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNYZ77YJ; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNYZ77YJ"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-482dd2e92ebso32779f8f.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 16:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789687957; x=1790292757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OyWXx8V/xHQJGt80Pz9KOlUNLklYvvmF/zbIsUHUMas=;
        b=CNYZ77YJ6T//3mW/xnMmgv60LhqxCHuYRh8OT+0zf5eYTmhXG21hKhGn1t2YUILuQ/
         qg+H/pGMrXb9OPJkwDQ0HCbgEmQcHmIF+g301JSeu6E0oEbvMXWTl0inuYQjuhA7Yx/w
         WukWwMH5zxAKYG+xxoBsN8DZo08+Id335lpOFJHlM7GIWtn3f0ZSnkJ2sKx1R8QT+5kO
         JGIlv3fZUX1VSnfU8CWfw9nY/CGxdTTiHGoc9lxFNCwHY80JivFP++/gjfds9G9+F4H1
         7BOJ66eGyxBc1AztnOW57/vSKdIIvks7vmdj3co4BtzbHRsmIFuSlwxfBUHKULCIR0nX
         j2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789687957; x=1790292757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OyWXx8V/xHQJGt80Pz9KOlUNLklYvvmF/zbIsUHUMas=;
        b=UZfoPdsNx3NdWgHxbiiWkkWUvVxmQMfLCuf69215GkWtExxoy2U8S17sXL27myicms
         hEID7op25hyVzXZTph/sOGGCsCFsJ0GiWddzVTETettVeDyW3bR3FhrXagTzrz08jSsD
         gxh9pv2oXpfnQvmj2juABYURLNGgacQiUCu4t2DKu01XoFYE8UXITezmyjymuBqTWtnh
         eBWSPWV4xD2tlBpkHWDT3ggTX2DY2nhRDfW+74RvM7lvM7dwxGtza3CkKWCqi60UM1fm
         koDGOpYjF2gCO9vbN52fwQoY6p1+Swn4wkmnHZi0xx1/ntvAvxIiLXpyroPLzr2+gTuz
         uf8Q==
X-Gm-Message-State: AFuF++mUi3f7z2z0Cru57VpxwJyWBxBUP48iX4vIJbsczR8Bz+RMmhAb
	NEY/HeLVXbMNvk67Z3wnFQlznFyxNFCIa4vlsKqhoYI37ELkRh8ozD1rtIorWrXN
X-Gm-Gg: AYBFou2aVed2O8OWdOt4Dw1WDwmW9uPv4rXhjP+gBMchK3K50UOe5CI1j5IdbVr76kI
	p7T7Tt4XO4H3U+LFH1e8te0WOUvKuaBs/YwaUdvm4RDaWZra60sKtf2RvG0jgnWzlFL90WHegGz
	OG758Uh7+AtcAkoToa/tL1qlSUxS5DVxq2kfyQB6ZcVKyiYNPFHK/8KuY6HIz2xaT5UWxB3DGYA
	+l2ID9h2NZTlk2H17yKI8G32N6sHzptM6W6VZNcvpdFdA53vNe+spMDhJxLh8iAjhdTkVuKwUR4
	3lT92RssmycWLGw/uFRWTXR3w8lNma0h87KS4ntvH1a3FIjGIDmz2RL1/vmQnycPsO9iiI6H0X3
	3ZrHp/+EFRQRNSosoQohi0Fvm5tAuWGjhXPi0Xa/fz9Xekqa0uKcBaoo549GuvrHiuc8xU9H+j0
	FLWY1eIaNR+tmOQ8cDPMcptQ4Kuc+fYzHyr1HKykGkUhckha6hJ5lEd+kKz7kbxLbZ4K16orgnT
	gtoT7S25z3yOH50tinb11z+qj9KjCxoqNjMRjoDuinqXVEHwYI2IpY1trGRbSOSuepxxtW8l9uM
	17Zt8HL2k1HzRiteiWQaw4JRLkzSiPVziaHZZA==
X-Received: by 2002:a05:6000:2312:b0:486:f980:2367 with SMTP id ffacd0b85a97d-4871e377f7amr549263f8f.48.1789687956822;
        Thu, 17 Sep 2026 16:32:36 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bcc7d1esm18944537f8f.0.2026.09.17.16.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 16:32:36 -0700 (PDT)
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
Subject: [PATCH bpf v7 08/10] bpf: Assign lock identity to callback map values
Date: Fri, 18 Sep 2026 01:32:16 +0200
Message-ID: <20260917233222.2542500-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917233222.2542500-1-memxor@gmail.com>
References: <20260917233222.2542500-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7355; i=memxor@gmail.com; h=from:subject; bh=wMSxoVbKdZa6FldBvAlTNmGa9ahWmI26PhwAhzmojUY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtNRZaBTelJNZ8q1ZAPs7m3/X69b5t56Ytt0QpqYjdN/ op/NgzpKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwERuzGL477Oh+Eobw+mseI2t 8u9dud1vMqzYm7ArIVlQY27n94tvvzIyzI0U6WWxeLigotx9/pYpESkWJ1QZNl5o+9BaH5f3c9k zFgA=
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
 include/linux/bpf_verifier.h | 25 +++++++++++++------------
 kernel/bpf/states.c          |  6 ++++--
 kernel/bpf/verifier.c        | 13 +++++++++----
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index bba5a727c651..a7202b44ab10 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -46,17 +46,11 @@ struct bpf_reg_state {
 		/* valid when type == PTR_TO_PACKET */
 		int range;
 
-		/* valid when type == CONST_PTR_TO_MAP | PTR_TO_MAP_VALUE |
-		 *   PTR_TO_MAP_VALUE_OR_NULL
+		/*
+		 * For CONST_PTR_TO_MAP, PTR_TO_MAP_KEY, PTR_TO_MAP_VALUE and
+		 * PTR_TO_INSN.
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
@@ -155,13 +149,20 @@ struct bpf_reg_state {
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

