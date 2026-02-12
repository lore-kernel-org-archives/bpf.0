Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA441347FD1
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 21:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770932086; cv=none; b=TTEBcOsvi5sPXQjlZiPzL5XfadpVjszwR+k73Z2+wXkZFp2hOHbsVhhzssSxiVBLSXsiyaXydn+1lhu4DTD57YdCfisU/CWT/M1EGOK5S3B5kmYdOFW04oqeiGaR69iPnR8PSstwLG/PiPnWxrGYwZCGP+Ksb8n7OvO3TSQGsQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770932086; c=relaxed/simple;
	bh=nUzwImlZk92voyBq52jwOlgVmeBCcT5uzZYRLBFFtL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EzXiFgnh4C7YU96DiHKU/k5LCHTH/JAPhSJ/ZWcuv9iiibYxQ+dNR2KPvv55eyGYPCkcLzVUM2rJ+HD41tRtc4HNKQ+UV+XDuuPfui2bLd9yzkrsOY9F2JtUnlAkHRhrZrgJsj13jwzsrAygP9NvqVHFz13PoeGKDKOGzsqOPVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaC9m1tz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaC9m1tz"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2aaecf9c325so1625315ad.1
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 13:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770932085; x=1771536885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGbUKV/m5JdUFbpFQOqruwpcQrNu9Nb00PZ9XviuhrQ=;
        b=QaC9m1tzJvgjOXDLimvyXHiPskwBW2DZ4DHJ4r0n4v4w94zy1qFtqzPzLuOhO73fvH
         8232WJj+2dEb6i4iny3DfG/l4mraf08npomiI3Z9LdN1AhDSwA14HT5W4Q9adjsadEa4
         +BYJMwD73DseMw10HyBAWP5y8GkPT3YVcw1lFZYF9+i80cFuyQI6NqY4cY8GytXAYgHc
         SWO7oUllKrid+a7bDXzO0py7eeYNmF6Y3aSmTiPbVqNgIoyEbmouqJrMSzXw0nAxSD4Z
         I0hwmMv0Ih++MO/WphIkWH1kvIHfkLj2AT8FJ0q7SNBaImIHQnMWrzjzIFrzUrbHYbI1
         fWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770932085; x=1771536885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JGbUKV/m5JdUFbpFQOqruwpcQrNu9Nb00PZ9XviuhrQ=;
        b=bon3XUKZOdRlaubisnz25zkDPzuuDAVfUgwanMYYxTa8m+3LsWogdysj7vt0AAqObm
         l4ieosJ9Wy/KxNXnN6Y0R+W+0yQEr7lgeEvAqTTAoIYvQQ3IcVxreXDLEfr1NytiAbjL
         QrXCgtLQF9lM5uJLLVwwkS7crGQqPmn+bL6qmwhZ1oWlfmadSbLJhg+zx9nRHRgqVvdt
         pmGosA/jiLzX/FSl/pb6vH3zIWxu97hf7pvJKTKbBdZ/URGqRKs2IqMGzTIrdCZuDjTj
         wdqK7lNtNMZRJzCvBys1CrnM9Csq2/uk9//b+O5XARDr2etazqUVemIqBlV4RuxgE0qW
         UoLQ==
X-Gm-Message-State: AOJu0Yw5kyZuhNk09UBEjh+fn8YwdtxbyVULQSU4eND+93ny3LU+2mxr
	ikQ/4HBQo3QR+cgcxHODU0n+uJ/p5PXcw9fOKEQBMuCyVS4seMnUT67GjAq777AP
X-Gm-Gg: AZuq6aJKItiMZksQbz8XfCk5NvaxTQzIFCcKH9380oQbvR92livp/DzA8TDxW4zxcv5
	LNoVyx9gU6ZriBHxd3Ptptwu81eqpOpzyW29bANkRMIvJnqGa1qu9e7Oj5IuU1NvlPHQ4PjEtpD
	KD4VShAZh2/I8KfgJ/knBKIubqqVNVXSUFSK+XsuFWzewCl1wg0LPZefHLB+7uHIUq9O0muFBIL
	gS3BV2avyoyoDHfsAAcp+5Zw60LZvXEOldSy8FHxy/TC/f8lqI5B10fU5Vi5XHn5MvV/0krf1hn
	O6EQJwWOsNURC0JwV5uJ7I9SFAO/uW/DF8GHpk0nKKa0SLaVBNJ4Njw0VTVaN+7gmSMD6mz39Qt
	XFZvlufxIwi1z7naRfvFs2PnYD+2rCBGBa0TP1jsG7a1rT3SrZMSEu73INNq3gfdkEr/O2Hrj09
	7EhWMGT987cuoj3Tm1MsEtelfa05DIUxSLafImhdWbA1z1KlAT4zZ2MO1j5M0=
X-Received: by 2002:a17:903:3c2e:b0:2a0:f0e5:74eb with SMTP id d9443c01a7336-2ab4d869ab0mr2339865ad.28.1770932084476;
        Thu, 12 Feb 2026 13:34:44 -0800 (PST)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab29979b13sm58728405ad.61.2026.02.12.13.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 13:34:43 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	kuba@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 4/4] bpf: rename bpf_reg_state->off to bpf_reg_state->delta
Date: Thu, 12 Feb 2026 13:34:24 -0800
Message-ID: <20260212-ptrs-off-migration-v2-4-00820e4d3438@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260212-ptrs-off-migration-v2-0-00820e4d3438@gmail.com>
References: <20260212-ptrs-off-migration-v2-0-00820e4d3438@gmail.com>
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
 include/linux/bpf_verifier.h |  6 +++---
 kernel/bpf/log.c             |  8 ++++----
 kernel/bpf/verifier.c        | 18 +++++++++---------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index a97bdbf3a07b63246ebf2021816e81c147989381..c1e30096ea7bfc90b4eb79ab40f4fbd25b69188a 100644
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
@@ -145,9 +145,9 @@ struct bpf_reg_state {
 	 * Upper bit of ID is used to remember relationship between "linked"
 	 * registers. Example:
 	 * r1 = r2;    both will have r1->id == r2->id == N
-	 * r1 += 10;   r1->id == N | BPF_ADD_CONST and r1->off == 10
+	 * r1 += 10;   r1->id == N | BPF_ADD_CONST and r1->delta == 10
 	 * r3 = r2;    both will have r3->id == r2->id == N
-	 * w3 += 10;   r3->id == N | BPF_ADD_CONST32 and r3->off == 10
+	 * w3 += 10;   r3->id == N | BPF_ADD_CONST32 and r3->delta == 10
 	 */
 #define BPF_ADD_CONST64 (1U << 31)
 #define BPF_ADD_CONST32 (1U << 30)
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
index 2c5794dad66889b7f872aa9882652efae877ac1a..0162f946032fe317ce1e5cf4a82e86a9357eca2b 100644
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
@@ -16219,14 +16219,14 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
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
@@ -17305,18 +17305,18 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
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
@@ -17324,7 +17324,7 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 			 * Must preserve off, id and subreg_def flag,
 			 * otherwise another sync_linked_regs() will be incorrect.
 			 */
-			reg->off = saved_off;
+			reg->delta = saved_off;
 			reg->id = saved_id;
 			reg->subreg_def = saved_subreg_def;
 
@@ -19629,7 +19629,7 @@ static void clear_singular_ids(struct bpf_verifier_env *env,
 			continue;
 		if (idset_cnt_get(idset, reg->id & ~BPF_ADD_CONST) == 1) {
 			reg->id = 0;
-			reg->off = 0;
+			reg->delta = 0;
 		}
 	}));
 }
@@ -19766,7 +19766,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 			return false;
 
 		/* Both have offset linkage: offsets must match */
-		if ((rold->id & BPF_ADD_CONST) && rold->off != rcur->off)
+		if ((rold->id & BPF_ADD_CONST) && rold->delta != rcur->delta)
 			return false;
 
 		if (!check_scalar_ids(rold->id, rcur->id, idmap))

-- 
2.51.1
