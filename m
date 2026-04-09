Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020F9314B63
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 01:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775698425; cv=none; b=STHRJK3lPe5em7pxYBCwGT6Se4GAwCYs/UftSynggIsFVtPkHP1Kb4QS+0lVWVBGGw/SEkHZUsWd7yD3s1PZT11ThhYsxDd3VtSTy9larcQxp28VFcsqQ/VcpZXXflX5OlDx4rV6FrBeUBuiPje5UoJO8DuYN05VZ89ZrA+Mt6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775698425; c=relaxed/simple;
	bh=wek6ZN7grW7LLGSjcSMX5akby/m1sMoKPajtN09yTPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HHrQoeU2qMCsD7sPLYw0Et3whbziYlaNpc339Qe7WwsF6eFF9MSeSbPQHW+cNxoi5WItws8Zmifc6E5IDFbCPmapbPiavKiLxsAqFQeP0+1xNWuZ54MgsLhJi8R5XkXGRIS6ice8XbUcaUz88lAkjOvxo9zRgXRKNVuUaA+jj/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F798GGA4; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F798GGA4"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-128b9b7e3edso610007c88.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 18:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775698419; x=1776303219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfWx6M+vtxqn+oYba5E6UaGYTmQ1cvwfH86EWioC4vY=;
        b=F798GGA48+NaJ2fPx+opr/EwKNutVHDFUnb22eqeQDtBOCvjxBYlHEZue6+rE9Lkxh
         JtTFvD4ZTOTcKa+s6LbKS+U5gjx+797sUENORV8YWMdQWLCD6GN4NqQT8lPYsmKlopLO
         fFhfK2gf1NZ5Exp9EPreoB3Y0RyXWBbUrpAj6nqdgfrLqAubHzRqLZuAOg3eaeJqPqGD
         wLMdIEVaoXIFDNh1yI7sn5VlUC2vKuAOS5ihm/THGZB7SBcQPIfnNbVAMxZ8IeCgV0Ku
         Kv3sb25X1KRN1HNo/OzHwzUS38FBl+KiZELKdnPqf2PSlcDJZXp6uo+lbmfC53DLWXCL
         sa4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775698419; x=1776303219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pfWx6M+vtxqn+oYba5E6UaGYTmQ1cvwfH86EWioC4vY=;
        b=mUOAIBLSTGhrDWCqtc7RmHn/qYVng8u+xH7B8n1Pj2AUz6MEG6zJzXJzbPQLK4IEcX
         AH7s7g7zQ/5Ge03Kf1Wxqn1oQ4FSdZHag5lFJgby2RFezKS7L2An+y64Rz8eGmLd9aC7
         2obfGpmI+r/ve9ggmB76S7BzaHJfFXnJBr8E9Z+3WIfyaarcVqYVe+nzXnBoLvVRjfSV
         +3DQd79R3Am3UZzmsAg2Q5WTyqo4b2Nxn2y76+/6cYcVlBMYxM+V/58YxmijlBQ2AWAK
         UuKNiJfHyYruvl321UTO2dFDK5N4+hLiE/RkWVodAS3q/c+RwbiJ8rOjG3l7YukKejon
         nl8A==
X-Gm-Message-State: AOJu0Yy0/RtihIl8uwgNfyVq1gBUAit8vthnMXy5JDbDWmEKgbzfSxWJ
	EP2P4+kdWOGFmLENMvFArlTq0K0TpJxxyE2FgwN/IsHlITT/6+kV0cLgfpxsXRPX
X-Gm-Gg: AeBDietCRqCc/Rzr7lRP2tvkwSmD7ayNiuDftpTZzxEhHWuG9mxf0UnzUFtrdlGqfKF
	DCLdhQKQOBqze4n9KJ/WMpDZbUyyBXeeaA9xBmlSq8UMc7TvsgURT0ZiI8YLFZgrj+4L6rD33o2
	u85A6tskcllVbX3FeDpvEI/ZT67GAqatzGfaw3oMi9WfvnOd5QHQ9BrI7pKjYNh38lGwGCq0qcs
	I4I9BU297OxHQqOiQm9s/LxdtR11UFBw8X7pFaS2c0nghOKmz428F5AomY8mT3FJE6NignGR7cL
	6aQD/PJ89J3VYMrN2MQ2JNZzatnImJ3GFEbTaqKSJHQO8wP8NmxB0VBH9DSjAr2NVd3c6cg4s0p
	bshllU/jCn1zH9JKb5npGiFG0QSe6Dn2fOWjJPjoE63PMzz3GYmoKX5Tyri6e0/aS83tr046HLw
	CrpbPOEtJBWrkqxvWeT7KN/nqb8xJGGqLxvo0pJW1+AARorhIR4KJR7s2niwcCjUV4xRKDydS8Y
	GE=
X-Received: by 2002:a05:701b:2202:b0:12b:fb81:d69b with SMTP id a92af1059eb24-12bfb81d909mr7421913c88.19.1775698418979;
        Wed, 08 Apr 2026 18:33:38 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::c05])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c0ce7dfe8sm15943230c88.3.2026.04.08.18.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 18:33:38 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 10/14] bpf: change logging scheme for live stack analysis
Date: Wed,  8 Apr 2026 18:33:12 -0700
Message-ID: <20260408-patch-set-v1-10-1a666e860d42@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408-patch-set-v1-0-1a666e860d42@gmail.com>
References: <20260408-patch-set-v1-0-1a666e860d42@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Instead of breadcrumps like:

  (d2,cs15) frame 0 insn 18 +live -16
  (d2,cs15) frame 0 insn 17 +live -16

Print final accumulated stack use/def data per-func_instance
per-instruction. printed func_instance's are ordered by callsite and
depth. For example:

  stack use/def subprog#0 shared_instance_must_write_overwrite (d0,cs0):
    0: (b7) r1 = 1
    1: (7b) *(u64 *)(r10 -8) = r1        ; def: fp0-8
    2: (7b) *(u64 *)(r10 -16) = r1       ; def: fp0-16
    3: (bf) r1 = r10
    4: (07) r1 += -8
    5: (bf) r2 = r10
    6: (07) r2 += -16
    7: (85) call pc+7                    ; use: fp0-8 fp0-16
    8: (bf) r1 = r10
    9: (07) r1 += -16
   10: (bf) r2 = r10
   11: (07) r2 += -8
   12: (85) call pc+2                    ; use: fp0-8 fp0-16
   13: (b7) r0 = 0
   14: (95) exit
  stack use/def subprog#1 forwarding_rw (d1,cs7):
   15: (85) call pc+1                    ; use: fp0-8 fp0-16
   16: (95) exit
  stack use/def subprog#1 forwarding_rw (d1,cs12):
   15: (85) call pc+1                    ; use: fp0-8 fp0-16
   16: (95) exit
  stack use/def subprog#2 write_first_read_second (d2,cs15):
   17: (7a) *(u64 *)(r1 +0) = 42
   18: (79) r0 = *(u64 *)(r2 +0)         ; use: fp0-8 fp0-16
   19: (95) exit

For groups of three or more consecutive stack slots, abbreviate as
follows:

   25: (85) call bpf_loop#181            ; use: fp2-8..-512 fp1-8..-512 fp0-8..-512

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |   5 -
 kernel/bpf/liveness.c        | 250 +++++++++++++++++++++++++++++--------------
 2 files changed, 172 insertions(+), 83 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9f412142be7f8eed2053edd30a9ffd26ab012a5b..75f3ae48431cbb675d76af3d899064cafed2f9ee 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -256,11 +256,6 @@ static inline spis_t spis_and(spis_t a, spis_t b)
 	return (spis_t){{ a.v[0] & b.v[0], a.v[1] & b.v[1] }};
 }
 
-static inline spis_t spis_xor(spis_t a, spis_t b)
-{
-	return (spis_t){{ a.v[0] ^ b.v[0], a.v[1] ^ b.v[1] }};
-}
-
 static inline spis_t spis_not(spis_t s)
 {
 	return (spis_t){{ ~s.v[0], ~s.v[1] }};
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index c3098369bee801eecc76ee40315cdeb49acf14b0..832c10846ec5eaea5840b66d85fc23b305d7925c 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -6,6 +6,7 @@
 #include <linux/hashtable.h>
 #include <linux/jhash.h>
 #include <linux/slab.h>
+#include <linux/sort.h>
 
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
 
@@ -266,64 +267,6 @@ static int mark_stack_write(struct func_instance *instance, u32 frame, u32 insn_
 	return 0;
 }
 
-static char *fmt_instance(struct bpf_verifier_env *env, struct func_instance *instance)
-{
-	snprintf(env->tmp_str_buf, sizeof(env->tmp_str_buf),
-		 "(d%d,cs%d)", instance->depth, instance->callsite);
-	return env->tmp_str_buf;
-}
-
-/*
- * When both halves of an 8-byte SPI are set, print as "-8","-16",...
- * When only one half is set, print as "-4h","-8h",...
- */
-static void bpf_fmt_spis_mask(char *buf, ssize_t buf_sz, spis_t spis)
-{
-	bool first = true;
-	int spi, n;
-
-	buf[0] = '\0';
-
-	for (spi = 0; spi < STACK_SLOTS / 2 && buf_sz > 0; spi++) {
-		bool lo = spis_test_bit(spis, spi * 2);
-		bool hi = spis_test_bit(spis, spi * 2 + 1);
-
-		if (!lo && !hi)
-			continue;
-		n = snprintf(buf, buf_sz, "%s%d%s",
-			     first ? "" : ",",
-			     -(spi + 1) * BPF_REG_SIZE + (lo && !hi ? BPF_HALF_REG_SIZE : 0),
-			     lo && hi ? "" : "h");
-		first = false;
-		buf += n;
-		buf_sz -= n;
-	}
-}
-
-static void log_mask_change(struct bpf_verifier_env *env, struct func_instance *instance,
-			    char *pfx, u32 frame, u32 insn_idx,
-			    spis_t old, spis_t new)
-{
-	spis_t changed_bits, new_ones, new_zeros;
-
-	changed_bits = spis_xor(old, new);
-	new_ones = spis_and(new, changed_bits);
-	new_zeros = spis_and(spis_not(new), changed_bits);
-
-	if (spis_is_zero(changed_bits))
-		return;
-	bpf_log(&env->log, "%s frame %d insn %d ", fmt_instance(env, instance), frame, insn_idx);
-	if (!spis_is_zero(new_ones)) {
-		bpf_fmt_spis_mask(env->tmp_str_buf, sizeof(env->tmp_str_buf), new_ones);
-		bpf_log(&env->log, "+%s %s ", pfx, env->tmp_str_buf);
-	}
-	if (!spis_is_zero(new_zeros)) {
-		bpf_fmt_spis_mask(env->tmp_str_buf, sizeof(env->tmp_str_buf), new_zeros);
-		bpf_log(&env->log, "-%s %s", pfx, env->tmp_str_buf);
-	}
-	bpf_log(&env->log, "\n");
-}
-
 int bpf_jmp_offset(struct bpf_insn *insn)
 {
 	u8 code = insn->code;
@@ -399,7 +342,6 @@ __diag_pop();
 static inline bool update_insn(struct bpf_verifier_env *env,
 			       struct func_instance *instance, u32 frame, u32 insn_idx)
 {
-	struct bpf_insn_aux_data *aux = env->insn_aux_data;
 	spis_t new_before, new_after;
 	struct per_frame_masks *insn, *succ_insn;
 	struct bpf_iarray *succ;
@@ -426,13 +368,6 @@ static inline bool update_insn(struct bpf_verifier_env *env,
 	new_before = spis_or(spis_and(new_after, spis_not(insn->must_write)),
 			     insn->may_read);
 	changed |= !spis_equal(new_before, insn->live_before);
-	if (unlikely(env->log.level & BPF_LOG_LEVEL2) &&
-	    (!spis_is_zero(insn->may_read) || !spis_is_zero(insn->must_write) ||
-	     insn_idx == instance->subprog_start ||
-	     aux[insn_idx].prune_point)) {
-		log_mask_change(env, instance, "live",
-				frame, insn_idx, insn->live_before, new_before);
-	}
 	insn->live_before = new_before;
 	return changed;
 }
@@ -462,12 +397,6 @@ static void update_instance(struct bpf_verifier_env *env, struct func_instance *
 				changed |= update_insn(env, instance, frame, insn_postorder[i]);
 		}
 	} while (changed);
-
-	if (env->log.level & BPF_LOG_LEVEL2)
-		bpf_log(&env->log, "%s live stack update done in %d iterations\n",
-			fmt_instance(env, instance), cnt);
-
-	return 0;
 }
 
 static bool is_live_before(struct func_instance *instance, u32 insn_idx, u32 frameno, u32 half_spi)
@@ -547,6 +476,173 @@ bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 half_sp
 	return false;
 }
 
+static char *fmt_subprog(struct bpf_verifier_env *env, int subprog)
+{
+	snprintf(env->tmp_str_buf, sizeof(env->tmp_str_buf),
+		 "subprog#%d %s", subprog, env->subprog_info[subprog].name);
+	return env->tmp_str_buf;
+}
+
+static char *fmt_instance(struct bpf_verifier_env *env, struct func_instance *instance)
+{
+	snprintf(env->tmp_str_buf, sizeof(env->tmp_str_buf),
+		 "(d%d,cs%d)", instance->depth, instance->callsite);
+	return env->tmp_str_buf;
+}
+
+/*
+ * When both halves of an 8-byte SPI are set, print as "-8","-16",...
+ * When only one half is set, print as "-4h","-8h",...
+ * Runs of 3+ consecutive fully-set SPIs are collapsed: "fp0-8..-24"
+ */
+static char *fmt_spis_mask(struct bpf_verifier_env *env, int frame, bool first, spis_t spis)
+{
+	int buf_sz = sizeof(env->tmp_str_buf);
+	char *buf = env->tmp_str_buf;
+	int spi, n, run_start;
+
+	buf[0] = '\0';
+
+	for (spi = 0; spi < STACK_SLOTS / 2 && buf_sz > 0; spi++) {
+		bool lo = spis_test_bit(spis, spi * 2);
+		bool hi = spis_test_bit(spis, spi * 2 + 1);
+
+		if (!lo && !hi)
+			continue;
+
+		/* half-spi, print individually */
+		if (!lo || !hi) {
+			n = snprintf(buf, buf_sz, "%sfp%d%d%s",
+				     first ? "" : " ",
+				     frame,
+				     -(spi + 1) * BPF_REG_SIZE +
+					(lo ? BPF_HALF_REG_SIZE : 0),
+				     "h");
+			first = false;
+			buf += n;
+			buf_sz -= n;
+			continue;
+		}
+
+		/* full spi, peek 4 bits ahead to check for 3+ consecutive */
+		if (spi + 2 < STACK_SLOTS / 2 &&
+		    spis_test_bit(spis, spi * 2 + 2) &&
+		    spis_test_bit(spis, spi * 2 + 3) &&
+		    spis_test_bit(spis, spi * 2 + 4) &&
+		    spis_test_bit(spis, spi * 2 + 5)) {
+			run_start = spi;
+			while (spi + 1 < STACK_SLOTS / 2 &&
+			       spis_test_bit(spis, (spi + 1) * 2) &&
+			       spis_test_bit(spis, (spi + 1) * 2 + 1))
+				spi++;
+			n = snprintf(buf, buf_sz, "%sfp%d%d..%d",
+				     first ? "" : " ",
+				     frame,
+				     -(run_start + 1) * BPF_REG_SIZE,
+				     -(spi + 1) * BPF_REG_SIZE);
+		} else {
+			n = snprintf(buf, buf_sz, "%sfp%d%d",
+				     first ? "" : " ",
+				     frame,
+				     -(spi + 1) * BPF_REG_SIZE);
+		}
+		first = false;
+		buf += n;
+		buf_sz -= n;
+	}
+	return env->tmp_str_buf;
+}
+
+static void print_instance(struct bpf_verifier_env *env, struct func_instance *instance)
+{
+	int start = env->subprog_info[instance->subprog].start;
+	struct bpf_insn *insns = env->prog->insnsi;
+	struct per_frame_masks *masks;
+	int insn_idx, frame, pos, insn_pos, i;
+	int len = instance->insn_cnt;
+	bool has_use, has_def;
+
+	if (!(env->log.level & BPF_LOG_LEVEL2))
+		return;
+
+	verbose(env, "stack use/def %s ", fmt_subprog(env, instance->subprog));
+	verbose(env, "%s:\n", fmt_instance(env, instance));
+	fmt_instance(env, instance);
+	for (i = 0; i < len; i++) {
+		insn_idx = start + i;
+		has_use = false;
+		has_def = false;
+		pos = env->log.end_pos;
+		verbose(env, "%3d: ", insn_idx);
+		bpf_verbose_insn(env, &insns[insn_idx]);
+		bpf_vlog_reset(&env->log, env->log.end_pos - 1); /* remove \n */
+		insn_pos = env->log.end_pos;
+		verbose(env, "%*c;", bpf_vlog_alignment(insn_pos - pos), ' ');
+		pos = env->log.end_pos;
+		verbose(env, " use: ");
+		for (frame = instance->depth; frame >= 0; --frame) {
+			masks = get_frame_masks(instance, frame, insn_idx);
+			if (!masks || spis_is_zero(masks->may_read))
+				continue;
+			verbose(env, "%s", fmt_spis_mask(env, frame, !has_use, masks->may_read));
+			has_use = true;
+		}
+		if (!has_use)
+			bpf_vlog_reset(&env->log, pos);
+		pos = env->log.end_pos;
+		verbose(env, " def: ");
+		for (frame = instance->depth; frame >= 0; --frame) {
+			masks = get_frame_masks(instance, frame, insn_idx);
+			if (!masks || spis_is_zero(masks->must_write))
+				continue;
+			verbose(env, "%s", fmt_spis_mask(env, frame, !has_def, masks->must_write));
+			has_def = true;
+		}
+		if (!has_def)
+			bpf_vlog_reset(&env->log, has_use ? pos : insn_pos);
+		verbose(env, "\n");
+		if (bpf_is_ldimm64(&insns[insn_idx]))
+			i++;
+	}
+}
+
+static int cmp_instances(const void *pa, const void *pb)
+{
+	struct func_instance *a = *(struct func_instance **)pa;
+	struct func_instance *b = *(struct func_instance **)pb;
+	int dcallsite = (int)a->callsite - b->callsite;
+	int ddepth = (int)a->depth - b->depth;
+
+	if (dcallsite)
+		return dcallsite;
+	if (ddepth)
+		return ddepth;
+	return 0;
+}
+
+/* print use/def slots for all instances ordered by callsite first, then by depth */
+static int print_instances(struct bpf_verifier_env *env)
+{
+	struct func_instance *instance, **sorted_instances;
+	struct bpf_liveness *liveness = env->liveness;
+	int i, bkt, cnt;
+
+	cnt = 0;
+	hash_for_each(liveness->func_instances, bkt, instance, hl_node)
+		cnt++;
+	sorted_instances = kvmalloc_objs(*sorted_instances, cnt, GFP_KERNEL_ACCOUNT);
+	if (!sorted_instances)
+		return -ENOMEM;
+	cnt = 0;
+	hash_for_each(liveness->func_instances, bkt, instance, hl_node)
+		sorted_instances[cnt++] = instance;
+	sort(sorted_instances, cnt, sizeof(*sorted_instances), cmp_instances, NULL);
+	for (i = 0; i < cnt; i++)
+		print_instance(env, sorted_instances[i]);
+	kvfree(sorted_instances);
+	return 0;
+}
+
 /*
  * Per-register tracking state for compute_subprog_args().
  * Tracks which frame's FP a value is derived from
@@ -1423,12 +1519,7 @@ static void print_subprog_arg_access(struct bpf_verifier_env *env,
 	if (!(env->log.level & BPF_LOG_LEVEL2))
 		return;
 
-	verbose(env, "subprog#%d %s:\n", subprog,
-		env->prog->aux->func_info
-		? btf_name_by_offset(env->prog->aux->btf,
-				     btf_type_by_id(env->prog->aux->btf,
-						    env->prog->aux->func_info[subprog].type_id)->name_off)
-		: "");
+	verbose(env, "%s:\n", fmt_subprog(env, subprog));
 	for (i = 0; i < len; i++) {
 		int idx = start + i;
 		bool has_extra = false;
@@ -1805,6 +1896,9 @@ int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env)
 			break;
 	}
 
+	if (env->log.level & BPF_LOG_LEVEL2)
+		err = print_instances(env);
+
 out:
 	for (k = 0; k < insn_cnt; k++)
 		kvfree(env->callsite_at_stack[k]);

-- 
2.53.0
