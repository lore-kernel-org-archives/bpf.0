Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5944B3AE1A9
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 22:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789424732; cv=none; b=LNulOFBhvGeKFDXbgDAnPd8Th/fQobxHcTznXZY/m9vcHJCltmsD8fErpeyE9+ow4l1SOKVRegwVDmPK1L1ofngHd++0xq+eP/v1cDqg7C73xluTixK3alFqkPC5vUfD41StWH3J0MWYOA61FYt2IT4Qk1gjPeVLggzyb1370og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789424732; c=relaxed/simple;
	bh=rI6pGX8pYWgAYSwcVLzmRb/k8bBaXE9yxJvV6/bCFW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2+Qigg9rvCiceRMJO8mZBdb7YIpayqaXwztNpl7A9gXaO/r4cybd3v6eOZs8QPT96bqoYzfTGLtVaZNSAndkogNv7io4UkbGCz02kLWlwcTLfcUIXdEmyU7ys0NkF4OJHxTbgb9zITMfAa/yytmrQOTJdVGzQrjIUCK1vyq7zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOCY59XV; arc=none smtp.client-ip=74.125.225.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOCY59XV"
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-482e1e7a4f6so1757593f8f.1
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 15:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789424728; x=1790029528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ZSDKXaWFXVYXRfOXXsc+7GtYJ27mE/1yn8wn6tKasY=;
        b=hOCY59XViUwmideCHCHuZjD4iCkUAS7jk6yUZyLw5okAv64mj5lI5PFJJfRsmmCAMl
         NQYymfZU1gW4U6qWI7XgF6+3sg7ALw4ZMu6Z+sUUDnqC/PNAtcX5FA8tWgr07oZ83Awc
         lcdgNQCXhA0KczBDgmbtWoHWqzlE2fmGwfRSrqKBMdhynmi00obpIkQ/Wy7M7dyYz5XL
         SSptf3JhlIPxGEyNAgsQh36Z5sr6H1XscrDuHrS7o9ML9C1D4eJAguIy4dsX0M0ON0PZ
         jJ715CtTpqG65PYby5KtALp9lHsywonjbdsm/k66fC0zbG5avlh7eYGSK4OlNqD6v2im
         yuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789424728; x=1790029528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1ZSDKXaWFXVYXRfOXXsc+7GtYJ27mE/1yn8wn6tKasY=;
        b=h0z39A3jmFTYdFacJEtzjjjPUEq2ce3fCv7dIqxFUUargqS1IERhUOv/dHSkctFUgj
         3nJKFZq8WDNcPawg/O/A6AlAmAEZGoFo/BGa6SWb/rIW7uUy1WdvcolrhtL6NSyrCYjl
         AvpW53j8Q3hTQk7zKUa/fdxz6LLAzdxGg3mzaNQU90s11rItZXn3+pGh+Zm8ULAU+2ZU
         fExhpIzr/Bg8jbGHrjra5u056Pok7coklIW3VJFalUEmt5ms/GHYj+LVNGJ7yxsbxsvS
         oXh9TnapQGcvmB1PLYIabEv9BcZEVmZsEyaBElzcz1WWuSsUKWOTEhEFuPedNMnlykWT
         qOuQ==
X-Gm-Message-State: AFuF++lGFZu0cSfN9azGEyC2yDzFRGedwhwiW4w6dD7LlgKLB3gJqLcp
	ee30B2CXxzzySsBUDpgrheWQz/JJ/WAQnei1tm2LKxtVX08FMrfGQwCW3qEd25ZpiLA=
X-Gm-Gg: AYBFou08NnnfJT8ynjlUvQmp4N5jLjY0fSyhxDs7wzYg4u/Z20n0zOrxh8k8ltyhL1b
	dTqxPQvJkwR47Mvbkwru8UefasJbrwPL1phMkX0krNjg/63ONuX2wIWFjnQn8JpZJDkHiH61WPL
	fw0pjYLcF4EVGLGjMerR+fDT+KUt5EuVAKJq/Iwla1MNlVEsW5v8tDLsAhwrwnWJedoUOI2wIFr
	WMp7Z5voabBMrqufsIgmZRPKx9ssfcf3uYzJbqV3liAnGid2LH7qaGHirymjsVGM+Dpy5xg2+52
	M0oBAXr/c2aIcDzkBlwDsL3wCuzp2CwgLHeAmA/v7jqAz5xCim0VIE1twngkE5Pp7fmq4BLSf7y
	UpLB8iYyUXO2lpcQIRN3+jTvH/dj2zzfreUDFIq2pKRomtHvbi2OkKuKal0e0K84yshDoeiAjlz
	izNeePneFNV66rgsOIfgkTMAydD+5GNUxzrE64hMG6Bz3lIGp1EOd78/6pkuuAsmWhaHB8Zmbq1
	v3v+E8CdlOGcaUTfeuR/DIdCFtaUYzxWlJpfaDn5mhld/AQrCkZWOBctlyTfXc4pqghHTuZGGbP
	GFBZ+uUJ9lZmOndfMavm7f7PwGXiPV5eeo60O1aiP0/ZbpqP
X-Received: by 2002:a5d:5e84:0:b0:485:c240:20f7 with SMTP id ffacd0b85a97d-48702b6bd84mr5034408f8f.53.1789424728360;
        Mon, 14 Sep 2026 15:25:28 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb2ed106sm28826857f8f.1.2026.09.14.15.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:25:27 -0700 (PDT)
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
Subject: [PATCH bpf v4 08/11] bpf: Assign lock identity to callback map values
Date: Tue, 15 Sep 2026 00:25:05 +0200
Message-ID: <20260914222514.1635018-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914222514.1635018-1-memxor@gmail.com>
References: <20260914222514.1635018-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7334; i=memxor@gmail.com; h=from:subject; bh=rI6pGX8pYWgAYSwcVLzmRb/k8bBaXE9yxJvV6/bCFW8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtFif76udu4K79dKL/5tMDnKO+UE/JHaystpsossCy8e 7XMVaayo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABPZtpHhf6T40rqrNiv3pMRz bCs8Om3eA/ZjMcc+WTAZa/eG8j+ZEczwv+RVLouDV1CN81snB6V6G7+JJhds1+pxy3t+fy4d2mv DDQA=
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
index 68d1b67b8c1a..a39d13a6614d 100644
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

