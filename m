Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA6B31E838
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 01:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775783524; cv=none; b=mTRa/TygretdpGidmNY6Ymc67YjEXaqd4PMVMpMH9fQ9z41JIIAdYRrFER3KtY36Wa01OQJRapz3n5+Xx4Cy1eGDZYzFJCmKq5Z5VPcJejCnrX5Lqz51U6dvmP67iFSNgwD4ceOBiFaEAh7U9H8pFHpS/vyQd5d6a5L4Zv/JRjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775783524; c=relaxed/simple;
	bh=VGItYQ3fH5GHYSDh4HH0D3+LcXn/k+e+BcaHIIkx6Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjEbfu38bL8aZa+aGJis5QnQYZZuQLBeDZBzINJGLq2aEq9+dxyAebjIMj2IwDJVLEBh92ZtS0YOa1CtEwqsnhpU43oLahwEq/hI/AAlhjgq74inERZxMpN1UDJXW4JI57E53pxUNkGyZYaJatEePP+9Zm82h51ht5c8iAQV+5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/5r/wBw; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/5r/wBw"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso810514eec.0
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 18:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775783521; x=1776388321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQZXzqSG3chRcYIXCvMnshRzT1wEL4PVf09o1k7dvh4=;
        b=l/5r/wBweb5nH7sf8B1hP0jAUAdceu8VEjbdi68YiaRKRoyM6KNpBPxmJwXBjA2rlm
         4R3d240eKNnp4oORK3x1779RUMYjkHw5GaaWs3oHFv2M1ROaOh4mbbvyqpLoDlrbPv3Z
         UyI2qxqoYh4kIyldBxfK8p0GaYdT/7hKHNtka4aj3irCtCXmzcSLlB8woZrxQFLyN0bV
         rhH5SA+WD2x/njPaqcoAKl/wfdatjBvoW3KvhLeItcrIazGKDyB5XpS7VfF8bp10FEBf
         /nuUv+h2c6kdLoM+ZvK+xYcEkNtS28Wmz0DBcVyDSCzCg7uZoy7uY5/VwO8SGrlxhjHP
         lK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775783521; x=1776388321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XQZXzqSG3chRcYIXCvMnshRzT1wEL4PVf09o1k7dvh4=;
        b=Dz4HUfZChL3bXrK3Wq8ccYNa4Tjx0+F7qY+xxRJM92MN647WoE59ch68b9yXPEr0XA
         qgWMw9fI70Sm1D2zw2EVkC4fpGXDVRea4TsdePkYI4eQz1MPT/Wl+gBQitjmOV+ZypTX
         sMusMI5EUAj0ZXdS8dD7Ibr3MgRkFLrX6r2Fn/qvtK1Sc0ilwUew0dLp3A9AB+oW/vqu
         O35BPOxdEsu2kguisMpDJYb7H69+a2YKOlfmLet0u4ILFFkPdlyB80JocoDIeegRVVCf
         7OkpRDDNwIO8fQqJMsxlXbucTh2xujA0RsCdwmygv/UfL8dWiAKk/4OYg4VLq46sZXWl
         96EQ==
X-Gm-Message-State: AOJu0YyP9KpxX/42//oQC0yeuSxcKVYYCgesTdCPvE/ypW+w9FClwm8y
	pvSwJusSieFhUhNNb74kaVyyDrDtMoQEOdOPNmMSAwQHfF2NcZMm2QXvCVYEQc0S
X-Gm-Gg: AeBDiesJo+bpntGwrwD/sKmtDifo+P0XOlQOFykA0V8UEAAOnYx74sI2+ZAAt+WWtqE
	TnjY3+yAr0RPX/O1tVkjnC/BcU16QoTRGIcufn7PmVpeO2ADQcedNQCNjFrEhFJF4RToVLNSJIn
	NG61TbERgE9XqJRyx+bOjb5j+zk9FvkG/XZc4mi9OFgxbdoCiN3jcNiNEaMxa9MfswFgr36kWpc
	TYjFQWljYh3ZGoaf4z7eIQcGoSfQqt571vZuxReur/aQsv7Jv0Exkd+LSbUtY1OBgfkq+mkhykW
	DmB/i/3Z9zoEx2gkR0aN+xtndP+FYH6jYbgV27x8R0grU/0E6Mo0QyU+rcAvWuyTh8pTwuxVlt4
	OEeLbQ0cx/3HXs8JrpeCca0VrWg5Vb5b4HKp8tQGZek1Q725c/1Wqn3tGeDJBdGGTvPadBW5hKM
	/UuHlrGUk5O+7k39EubJ5lvSs/7gx6gxAhNQKsYUa7WVhbWO3zoCswL5d0/arBzfkxtn+mJvXiV
	ohltQI=
X-Received: by 2002:a05:7300:4316:b0:2c1:82c2:bc31 with SMTP id 5a478bee46e88-2d40fce76c1mr2728506eec.10.1775783521275;
        Thu, 09 Apr 2026 18:12:01 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::2:f3a8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5627c44fcsm2174922eec.23.2026.04.09.18.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 18:12:00 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v2 09/13] bpf: change logging scheme for live stack analysis
Date: Thu,  9 Apr 2026 18:11:28 -0700
Message-ID: <20260409-patch-set-v2-9-651804512349@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409-patch-set-v2-0-651804512349@gmail.com>
References: <20260409-patch-set-v2-0-651804512349@gmail.com>
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
 kernel/bpf/liveness.c        | 238 +++++++++++++++++++++++++++++--------------
 2 files changed, 162 insertions(+), 81 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1ee94e36806d..5d6c6d1f46ed 100644
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
index c13f57ddf582..f296c3304752 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -6,6 +6,7 @@
 #include <linux/hashtable.h>
 #include <linux/jhash.h>
 #include <linux/slab.h>
+#include <linux/sort.h>
 
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
 
@@ -261,64 +262,6 @@ static int mark_stack_write(struct func_instance *instance, u32 frame, u32 insn_
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
@@ -394,7 +337,6 @@ __diag_pop();
 static inline bool update_insn(struct bpf_verifier_env *env,
 			       struct func_instance *instance, u32 frame, u32 insn_idx)
 {
-	struct bpf_insn_aux_data *aux = env->insn_aux_data;
 	spis_t new_before, new_after;
 	struct per_frame_masks *insn, *succ_insn;
 	struct bpf_iarray *succ;
@@ -421,13 +363,6 @@ static inline bool update_insn(struct bpf_verifier_env *env,
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
@@ -457,10 +392,6 @@ static void update_instance(struct bpf_verifier_env *env, struct func_instance *
 				changed |= update_insn(env, instance, frame, insn_postorder[i]);
 		}
 	} while (changed);
-
-	if (env->log.level & BPF_LOG_LEVEL2)
-		bpf_log(&env->log, "%s live stack update done in %d iterations\n",
-			fmt_instance(env, instance), cnt);
 }
 
 static bool is_live_before(struct func_instance *instance, u32 insn_idx, u32 frameno, u32 half_spi)
@@ -540,6 +471,163 @@ bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 half_sp
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
+static int spi_off(int spi)
+{
+	return -(spi + 1) * BPF_REG_SIZE;
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
+		const char *space = first ? "" : " ";
+
+		if (!lo && !hi)
+			continue;
+
+		if (!lo || !hi) {
+			/* half-spi */
+			n = snprintf(buf, buf_sz, "%sfp%d%d%s",
+				     space, frame, spi_off(spi) + (lo ? STACK_SLOT_SZ : 0), "h");
+		} else if (spi + 2 < STACK_SLOTS / 2 &&
+			   spis_test_bit(spis, spi * 2 + 2) &&
+			   spis_test_bit(spis, spi * 2 + 3) &&
+			   spis_test_bit(spis, spi * 2 + 4) &&
+			   spis_test_bit(spis, spi * 2 + 5)) {
+			/* 3+ consecutive full spis */
+			run_start = spi;
+			while (spi + 1 < STACK_SLOTS / 2 &&
+			       spis_test_bit(spis, (spi + 1) * 2) &&
+			       spis_test_bit(spis, (spi + 1) * 2 + 1))
+				spi++;
+			n = snprintf(buf, buf_sz, "%sfp%d%d..%d",
+				     space, frame, spi_off(run_start), spi_off(spi));
+		} else {
+			/* just a full spi */
+			n = snprintf(buf, buf_sz, "%sfp%d%d", space, frame, spi_off(spi));
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
@@ -1430,12 +1518,7 @@ static void print_subprog_arg_access(struct bpf_verifier_env *env,
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
@@ -1821,6 +1904,9 @@ int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env)
 			goto out;
 	}
 
+	if (env->log.level & BPF_LOG_LEVEL2)
+		err = print_instances(env);
+
 out:
 	for (k = 0; k < insn_cnt; k++)
 		kvfree(env->callsite_at_stack[k]);

-- 
2.53.0
