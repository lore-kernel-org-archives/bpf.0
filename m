Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040A74746DD
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391838; cv=none; b=tvdEpk0l9nNwt3tLWohoA6qSLCYckwBURou58NVSNbZlc4DUUwuCim+a9KYWRQF/AhGB1tB/KTfchlJmbN3qfnceQL0Cd42EzNoXPqkKpZEVJZF5uTRIRccTSKjSNPT4EQqjbigSsw9ZWOWGcdtKGn4JgNP8xrOyq6UFoz0r1fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391838; c=relaxed/simple;
	bh=GSuwfGSAtuZPL28xtJ9IDZShk+nj3QolK02JQs+jJWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+DBUe+h+usZ5dZqlhpxBTINp65aPMpvVBuwfZv40opsEKsUmczs1r4kEBPXeFts8hd8qCwjxt/KTI4j6W352tQKNI7qwQSe+wFCvDOY+jdPF2j83huykq9Jm9fUBxTc/UWhW//zGxFEFFthGXWxkr8HAudOcewsh1IdVYZ0cpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qx+ljL6n; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qx+ljL6n"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6bd65693so11650065e9.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 06:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789391833; x=1789996633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZwakKEMSXkdJ0oIaoOIKquLuCFX7Ga+lHKiVg9ftGP8=;
        b=qx+ljL6nfl4eUGINMTGsrm90cW3Xyu2A7uJOm53INp2LiKXcB2VIQjfIp88gIjsWcL
         kBycF3EOYfqalb0E9mri/uruNYGXwiOUd1Z75lx0yi1+6z2b56NVgU47mi6aXjMYfzMn
         01u5bobl3vBE/ymcHQZiv7OOzj7dT5ZucBrusHLwYAQVQLlMJiCDNdXaWRRuXHSc3poJ
         StK7GBJ7Jayq+onz7EweOSPqsyUEqbGwN0LkzuNfzo38S4GvkUbfA988GFp8aFX5gzmV
         rTDwOkle8mZmpgQbC0eIsQ3XuqsyaCc9dta1PsLX5MXqg0BOmpZoSMiC7HU5xkePN0qR
         wOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789391833; x=1789996633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZwakKEMSXkdJ0oIaoOIKquLuCFX7Ga+lHKiVg9ftGP8=;
        b=WmKcUywVGbMmN5M6chWOMuyf6xTO0TUAwFrGdxlHpLxId0gOqqmslap0nP+j6/fxKW
         tIvI1nl0RmP/yJ4Y0KZcbHTv1CHwQgixlEC/4zDeWdmsDjbyosZCEXb987HKpt6iyomo
         eoNHGkOLhL0DR6l8ghG73DHd8BObF+N6igFBTQBOfwe0NF7Gub7u9IzeGEK0RYVrNJC5
         HQyhdVLurh35qub5hZ/AwOKzyyZRhNbULCKxrIDixXLNLM6L0u07zYKOyVvdomW0DKqb
         0aRzGOt9GYt+MbGzFjBTfHAd5cmYZeDi1BsJXObtKOXHuipdb7909uEmNbASSAKgEubd
         YsBg==
X-Gm-Message-State: AFuF++k7wWySE8GZhRBiyslStsDvBTgVRdlzy41ROaqodD1WTYD87rZD
	5OSQRuuQQEImkfQMOI9qRHCF9uyOmZs3mjLkTNpKy6K+NBEmKMi58KjAjdl0CUr1
X-Gm-Gg: AYBFou0uzBVlyPn7/dLalV8MosL1pFYZaVe11c68H4ZDLEAEJPbCQGEnTyQeqEZYb9M
	tjcodFQh6DrZZWEmcKjqTBur8DpoNX0wuPOYAzHwzRTi+K0A9pbsz9Ltne8OfTv8GS3t+4sysr+
	Uyqks4WyN7YXITGCPiimmINoIDRCDJxrhLJ9dqjeyUJTHq9IZjQiU7/ufMAWwIFu4885GRzRuMa
	uFVMNau5FE008FyqFZcrEw+1QP9BUbc56w9dze2XB1V0chL+jlV4qRGiVnHaYwYaoDksowet+hJ
	z0dCQ2+7tWc9AxwyMr8LUQLQhYJrpLT1lIhW0nRDHFZ8+xKHsCMZaYKxO7iJ/yWMwAcv25L+TZ3
	dOw0dZ946YEjJVwlPHO9DuDDe9e8JO9jgHRrRsl9ayi+t7OjBbTD/aj+VDRF5voNZ4bUpLtKjqB
	Tt8O0YG//HpHFGmaT30642NmoP7vrmch6QlhLgbooRZVcq5W+Biz6bxwvJjAY0If0MnV2ZXVuoN
	Cdmpsx7mrqix8bHV/Wx8ewA408DKvXjtG5/tmUtrJ1y6EGJLzhKWVck+1XpNleb/+AkZQGMP5AF
	bWr/21eXaCIzqCPdh5AIEknfdvrEpyLUNEnYpQ==
X-Received: by 2002:a05:600c:6217:b0:49e:6bc7:4e1b with SMTP id 5b1f17b1804b1-49e7a656ca0mr29854295e9.15.1789391833425;
        Mon, 14 Sep 2026 06:17:13 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb2ecf23sm27401046f8f.5.2026.09.14.06.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:17:12 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v3 6/7] bpf: Assign lock identity to callback map values
Date: Mon, 14 Sep 2026 15:16:56 +0200
Message-ID: <20260914131701.2529725-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914131701.2529725-1-memxor@gmail.com>
References: <20260914131701.2529725-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7355; i=memxor@gmail.com; h=from:subject; bh=GSuwfGSAtuZPL28xtJ9IDZShk+nj3QolK02JQs+jJWw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv551ks5bdfvstf9PQ4y9ayTlkpLdOtC4TOyAbfCFRR3 upsb9rfUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIk0zmL4H/57x8P3Cl/l72Zb B9bes1+w9Zu0xI/tAaJHW5gX+He82MHwP/N8/cVSHqVdn+s4jwaru9eHs606eXhj6q0zr2fHJSX /4QMA
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
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 24 ++++++++++++------------
 kernel/bpf/states.c          |  6 ++++--
 kernel/bpf/verifier.c        | 15 ++++++++++-----
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 36b65797877d..8f769ee14bd6 100644
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
index ddba53eaa333..ab4f0ea2647b 100644
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
-		 * as UID of the inner map.
+		/*
+		 * Each lookup gets a unique ID. Preserve it as the inner map's
+		 * identity, since different inner maps share inner_map_meta.
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

