Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCED3D6662
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 21:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593700; cv=none; b=Iv1jCblGJOJ3LOW+7k4+H9/UXR1HirU0EHZPB3zMFptkv2VD64dCy97emP0gzUdnqEEVy2UZRdOSSPYOavNJezAq7GtlurZc2GMMS3qzGwGxw6E2I08m8Rz7gIdoQeBLz2KIz0A7A4XG70Scmw2VAaoNiveCBkDeWkCrR3Yh1pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593700; c=relaxed/simple;
	bh=llv/7inFiHp16fZYtF/quWa8OVHQ2pYFrVX+tQkNS4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EeZuGDwAKE30G0cylz60WM6SAQD4gFhgUt1Sq8VVW9YyklksHnWacuL4ivZkT/7t/SeQRAF8z3Llb+JGdf+W2JTcMZry0TmJp+QcdDUpOjVBilerbVPFwhMb6Ex3ZkHcw//8krrJS3fyykAoZM18t5ay4n79LZ69OiDYPIlAJoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sR+Xi806; arc=none smtp.client-ip=74.125.225.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sR+Xi806"
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e667e3c45so292775e9.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 14:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789593677; x=1790198477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nw0KLSPYVu3W18NkiMPo6bB5ntzQGjyK8nb/ii68tOc=;
        b=sR+Xi80676ESH91EgJvPyxRMomx71x8Dpn5FgYUTs3CmVwSio5F7sASLs83NJFNLOO
         dB4mxA8tniYT4RehQK4kObpo5Zbk++siwlWN4tP86p5+erohlLBW7IdhJhjnNZuV9cEI
         aZ5a1aH+8Qn96ZGII9WhhmJZfbHlO1+45Z/+juFrQ7Trty7STBHTQQw3LV8iDSZUXeGq
         TadyZ6I5mh19nYmM6Hy8PXi3ilomkhzk/H86lECmF+BS5wwlV7eQfv6OAjoqK41fQmQ7
         vuoN/o1NzhhoWfUxVS0wLOQBr+SgO1VhBvSqUDehEugPkqVer9ch0K8eVZvkRJKSWy7Y
         4aqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789593677; x=1790198477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nw0KLSPYVu3W18NkiMPo6bB5ntzQGjyK8nb/ii68tOc=;
        b=dz3VEUhHAPmgrRLqLLArGLt065MT1NWujWom+V4+EBI4kd6TCIxFDMlAq2Qws8D3Qu
         T/rfU7V8zaRnzQrJzlEDMd0U0iVpQ6xrROYpOgQv7KkaahuJXom4+D9fehdRsdb5Gn7r
         aK9GKIRYrBErDIP+U7P4tYSbIhLiHpOUyxVUGA76tx4tOhpOlNf5zqAnvm/9cpPrJ0P+
         /sqZN0G6NgR0Pcf904Jx6Jt+zfX60DpO9/ih6yHQoVdBsrdKNDvqDCbqDuoSBQOJSwt1
         xg7LGoUDz/kpcwtC7Qo97208xbWIMRgceSjfSlRHkGKdTGvDlVUakzABw03jJHqRNuet
         MICA==
X-Gm-Message-State: AFuF++lBNYTwmI3Bcy+bjVAqEj6nSu1vRmnUln4/ev8wpBbIlnfdyirD
	AlPO6piWgsTDrnX+gCN+Nc8LM5lx+ioOvOxuB2eqRrTgmGMTnpirYwADbx6NvDd8
X-Gm-Gg: AYBFou0AgYYm6t+n0rg+/ItU2bTK2ZLbC3VTiLYexKGWP9nW4bdHhUNNMwKniXSPjlm
	3SK3am2/hzAIt9ubTb0HrCQfv88u+9tYIBBZzA8nHeIRPwZyJbg6qla60RGERUUBWKECztO3rjB
	LqN/5fAUAO15NatvuyUzUthkvJG0O5HlYU9a5BxBKV2VVm7mxgk9jTw+xBAr3F1NVPJ4g/0PGJ6
	YSeBIu5pGV+se9W1kmJJ80uI6HDTsuX4cZjoBb7RoqZ9qfLirnGiHc17Zgre+VhrV7JAyO6Pr9W
	Lu7cPJ0FL1mLtnd+ULDu7HEGSvyMe3MvPdfYMSVYOgXoPidOxgyIFX5WUYAdATecyNMvsrhf7dR
	D60l2nAm2LRM263Md8vnFKz5OMbCpkFg5J6OXnZfIa9zlIMxrS8Y8bjlx6iM/RGAkSHJoSKBLJN
	+/hGHVYM3wVj4C4XQK1vQ1cJkKN2aeEfm79R/3ZEIXKji1MOVQukPtcmBw+/Abe7lcpn0IaTVKu
	m9Xdcdbcja2dBC6kBv5BqYQsAm4LLJ3fPfdwxSxrFuR3YFmlUNmxovAOVnvXmLQH6cIV6nF0wfL
	kOxQ0pYsSB1qTUe7hasC4ieGXtZnZLzCmSMjqg==
X-Received: by 2002:a05:600c:8b71:b0:49c:fa20:cc06 with SMTP id 5b1f17b1804b1-49eb732fc92mr42808015e9.29.1789593677301;
        Wed, 16 Sep 2026 14:21:17 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd2160c2sm20308235e9.6.2026.09.16.14.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:21:16 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 08/10] bpf: Assign lock identity to callback map values
Date: Wed, 16 Sep 2026 23:20:55 +0200
Message-ID: <20260916212102.597335-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916212102.597335-1-memxor@gmail.com>
References: <20260916212102.597335-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7334; i=memxor@gmail.com; h=from:subject; bh=llv/7inFiHp16fZYtF/quWa8OVHQ2pYFrVX+tQkNS4Q=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWs1hzyrREl+RKrFbNNn7p3HJjI6dE169El4/dKJs1vFL rPnpyzqKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwEWmMDIcLs/NZP9Zc2fizkff q4rmrbh8cSdzy/T3lhqzjzi6PNFPYGR496e2/33pI77Yp0FcCqfmrL6hp9RRdPGyOMuSWVuebWj nBQA=
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
index 2005a145e403..d3c090c68245 100644
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

