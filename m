Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372574BD78C
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542911; cv=none; b=iOhrtXkq1ODUzA0Ps9nbWOFg0BcURuAD8k5dlkgHRq4/GWbVCvAtGIWbprQa7OTua+xAJrg8uUzwe3VQk7iBx8yIS2AhLK85mTG+HKgDR9VUmcXUxQGmfyPFPNhqnaNN/1GZCZlpI4LVDI06mo7gLvGYD74CbdIK7FTpl0WNm0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542911; c=relaxed/simple;
	bh=7O2ER0mqkzurSGRa2+y2kWBoV7Q+XEfOWwW9/31QeZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGejLcJ5RF+qOyNeam3WMkyZi69yB0EZ2/RXi+06YzJwJKV9lrqBfB0P9LL0qJiwp/ifRWvlBXBeBsZkKCaKabn2deQNNFezssGm00+5FNbpwk+blyC9PwlGtuR++TMi3BR0xRrRnWcQy4HC7hiDLetBnhGJYh4SPjwVfOlFzok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fe/N196C; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fe/N196C"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3a706146559so2967200a91.2
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542898; x=1792147698; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PLzc07tUHoMHvuhz78NGb96tuEU3WsknyMDAlqCV+Tg=;
        b=Fe/N196CzHs6jg7Gfc/ymnC7a8BeDH9Q0o5yW+hXuIqCHkrgzbq8+OzIKAPC7zEEHX
         /cKtBijW+tKviuVXMMhygUcR7H2XkkVV1Hfx0GjSnjxA4U6+y/FY62uS7UnHdWC3BpG8
         lnZJ89tHap3qSb634p2kZlEP7KkvcGlOzPgH94j8I8Xw9lfLvbFzH3Km+e/vdRPTa+ps
         GGEQX3pbG6krW9lkivaEkkutzAs78eXeXRPe4Fx4XrkSzg1VsywsGEFyRGfbtM0gvvB4
         OQz77YjaAu0qVhaSLnQBmdNIXeXaZCzLrBGITbBZOsN/Qbhea/y6X95iPmwQaCd4edrC
         20XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542898; x=1792147698;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PLzc07tUHoMHvuhz78NGb96tuEU3WsknyMDAlqCV+Tg=;
        b=e2LfEnvkjdgp3OC/NZmij1gNn7C4ItLXRrW/uw8x3XdLws3q/lyoUQ6Z1L+IR7vV4x
         Xq2O8cqmMfFao2DMwUSJo+CYuC8pcIu6DoXJxBx/ZjmKBaV1pw9bgtrfvKhRcI7uh43q
         fylWLXKPNO2ZmJM1MhYvaIzmtpxy2THRltjRQxiJ8LLOubfRi4ZouocNwn9aXaeJeO+c
         9IVSEXb1/Lf0Skf8QXpjYIEpW1+YcWqdME/hr+HG52GGsDuRdA1pVX203uZfVjFD7dzx
         LomSX0wMDuiAqTY6RZFUp17RtJHaHwLW1MMvP5suikDTv5m3JxPn7TqKZsF+fcMlO5Q8
         OAXQ==
X-Gm-Message-State: AFq9FYIOFiDMU3yOH48/dmS4kGt7sTASK0K1AN+KPg3u5wwu7wJj3F7u
	hICcbWmCAEqix9Zk1n3wXQeYL/VMvTQkY71ZYIUJ0TOXsZTOu4kd9b0FJwWvuMvk
X-Gm-Gg: AYBFou2v8zRY0WTZ99s2ZeebLVxGk1HKypV5oTz4mbfcmm84MhFtgB6ZyR1RJQb4KDC
	wMArAiyOzYh9cNfZo5nNbG44+I72pF7gpCrEORTHXxwsZjH9eQlJfpxFFsMjJ1TtMhxNEMAUWCs
	DAGYrS4PZBDqlpqwr0pE6+TmQGPoiopgvWE8yDro/CVPpAOGLYCc8/Q3sY8q5i7qYO7VQ+0g4hi
	FBTJCExMPSKZmCMafklVGmx/u+tILJsjoy3rkuwP4Fhi3b9v9NDXOdXc1ZlSJqZgSUBQAgsJjXi
	jBHpo9zLYRGGJmRWAcAdA+U36yD6gWOrvwKs6qFzQE+n3bICeZS6tLyI0eme8FvWGgIA2RxARHh
	vpUTvXnAA/iSspS9cTInYD5dKy8YvFg874Q/wTF8BPPCZen9D6mzvp7KrlfB+ul3yf5tjy9buB4
	6knRhreHLn+yqpq+TbenWmXwja5XpiYcG5lRZVxneJRQtDRAG3aQwhQgeucpyh3zNc4YNXxH2Yi
	lav7GzDRdq/D80=
X-Received: by 2002:a17:90b:1844:b0:3aa:fdad:7d6e with SMTP id 98e67ed59e1d1-3ab3a90e672mr1519453a91.10.1791542898294;
        Fri, 09 Oct 2026 03:48:18 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:18 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 01/51] bpf: represent stack access effects with arg_access_info
Date: Fri,  9 Oct 2026 03:47:19 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-1-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The following patches in the series add support for may_write property
inference. To properly track this property there is a need to
distinguish three ways the helpers/kfuncs affect stack:
- read;
- write and destroy all previous stack tracking information for
  affected slots;
- both read and write the stack slots, potentially preserving some of
  the tracking information.

The later property can't be encoded by signed access_byte convention.
Hence, introduce arg_access_info with a size and separate may_read,
may_write and must_write bits. Convert the liveness access recording
paths to use it. Proper may_write calculation and support will be
added in the following patches.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  8 ++++
 kernel/bpf/liveness.c        | 96 ++++++++++++++++++++++++++++----------------
 2 files changed, 69 insertions(+), 35 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c51083c761cf..d4f32acba236 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1723,6 +1723,14 @@ bool bpf_is_may_goto_insn(struct bpf_insn *insn);
 void bpf_verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *insn);
 bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
 			  struct bpf_call_summary *cs);
+/* Stack effects used for state pruning; must_write implies may_write. */
+struct arg_access_info {
+	u32 size;		/* Maximum extent; U32_MAX if unknown. */
+	u8 may_read:1;		/* Incoming contents or initialization may be needed. */
+	u8 may_write:1;
+	u8 must_write:1;	/* Prior verifier state is destroyed throughout size. */
+};
+
 s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env,
 				  struct bpf_insn *insn, int arg,
 				  int insn_idx);
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index cd9523f69298..7b317fb5ca82 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1437,17 +1437,14 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
 }
 
 /*
- * Record access_bytes from helper/kfunc or load/store insn.
- *   access_bytes > 0:      stack read
- *   access_bytes < 0:      stack write
- *   access_bytes == S64_MIN: unknown   — conservative, mark [0..slot] as read
- *   access_bytes == 0:      no access
- *
+ * Record reads for every touched half-slot. A definite
+ * write requires full coverage, a known size, and a single possible offset.
  */
 static int record_stack_access_off(struct func_instance *instance, s64 fp_off,
-				   s64 access_bytes, u32 frame, u32 insn_idx)
+				   struct arg_access_info info, u32 frame, u32 insn_idx)
 {
 	s32 slot_hi, slot_lo;
+	int err;
 
 	if (fp_off >= 0)
 		/*
@@ -1456,49 +1453,53 @@ static int record_stack_access_off(struct func_instance *instance, s64 fp_off,
 		 * by the main verifier pass later.
 		 */
 		return 0;
-	if (access_bytes == S64_MIN) {
+
+	if (info.may_read && info.size == U32_MAX) {
 		/* helper/kfunc read unknown amount of bytes from fp_off until fp+0 */
 		slot_hi = (-fp_off - 1) / STACK_SLOT_SZ;
 		return mark_stack_read(instance, frame, insn_idx, 0, slot_hi);
 	}
-	if (access_bytes > 0) {
+	if (info.may_read) {
 		/* Mark any touched slot as use */
 		slot_hi = (-fp_off - 1) / STACK_SLOT_SZ;
-		slot_lo = max_t(s32, (-fp_off - access_bytes) / STACK_SLOT_SZ, 0);
-		return mark_stack_read(instance, frame, insn_idx, slot_lo, slot_hi);
-	} else if (access_bytes < 0) {
+		slot_lo = max_t(s32, (-fp_off - info.size) / STACK_SLOT_SZ, 0);
+		err = mark_stack_read(instance, frame, insn_idx, slot_lo, slot_hi);
+		if (err)
+			return err;
+	}
+	if (info.must_write && info.size != U32_MAX) {
 		/* Mark only fully covered slots as def */
-		access_bytes = -access_bytes;
 		slot_hi = (-fp_off) / STACK_SLOT_SZ - 1;
-		slot_lo = max_t(s32, (-fp_off - access_bytes + STACK_SLOT_SZ - 1) / STACK_SLOT_SZ, 0);
+		slot_lo = max_t(s32, (-fp_off - info.size + STACK_SLOT_SZ - 1) / STACK_SLOT_SZ, 0);
 		return mark_stack_write(instance, frame, insn_idx, slot_lo, slot_hi);
 	}
 	return 0;
 }
 
-/*
- * 'arg' is FP-derived argument to helper/kfunc or load/store that
- * reads (positive) or writes (negative) 'access_bytes' into 'use' or 'def'.
- */
-static int record_stack_access(struct bpf_verifier_env *env, struct func_instance *instance,
+/* Record access through a pointer with a known frame and possibly known offsets. */
+static int record_stack_access(struct bpf_verifier_env *env,
+			       struct func_instance *instance,
 			       const struct arg_track *arg,
-			       s64 access_bytes, u32 frame, u32 insn_idx)
+			       struct arg_access_info info, u32 frame, u32 insn_idx)
 {
 	int i, err;
 
-	if (access_bytes == 0)
+	if (!info.size)
 		return 0;
 	if (arg->off_cnt == 0) {
-		if (access_bytes > 0 || access_bytes == S64_MIN)
-			return mark_stack_read_all(env, instance, frame, insn_idx);
+		if (info.may_read) {
+			err = mark_stack_read_all(env, instance, frame, insn_idx);
+			if (err)
+				return err;
+		}
 		return 0;
 	}
-	if (access_bytes != S64_MIN && access_bytes < 0 && arg->off_cnt != 1)
+	if (info.size != U32_MAX && info.must_write && arg->off_cnt != 1)
 		/* multi-offset write cannot set stack_def */
 		return 0;
 
 	for (i = 0; i < arg->off_cnt; i++) {
-		err = record_stack_access_off(instance, arg->off[i], access_bytes, frame, insn_idx);
+		err = record_stack_access_off(instance, arg->off[i], info, frame, insn_idx);
 		if (err)
 			return err;
 	}
@@ -1533,9 +1534,10 @@ static int record_load_store_access(struct bpf_verifier_env *env,
 				    struct arg_track *at, int insn_idx)
 {
 	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
+	struct arg_access_info info = {};
 	int depth = instance->depth;
-	s32 sz = bpf_size_to_bytes(BPF_SIZE(insn->code));
 	u8 class = BPF_CLASS(insn->code);
+	bool read = false, write = false;
 	struct arg_track resolved, *ptr;
 	int oi;
 
@@ -1552,23 +1554,26 @@ static int record_load_store_access(struct bpf_verifier_env *env,
 	switch (class) {
 	case BPF_LDX:
 		ptr = &at[insn->src_reg];
+		read = true;
 		break;
 	case BPF_STX:
 		if (BPF_MODE(insn->code) == BPF_ATOMIC) {
 			if (insn->imm == BPF_STORE_REL)
-				sz = -sz;
+				write = true;
+			else
+				read = true;
 			if (insn->imm == BPF_LOAD_ACQ)
 				ptr = &at[insn->src_reg];
 			else
 				ptr = &at[insn->dst_reg];
 		} else {
 			ptr = &at[insn->dst_reg];
-			sz = -sz;
+			write = true;
 		}
 		break;
 	case BPF_ST:
 		ptr = &at[insn->dst_reg];
-		sz = -sz;
+		write = true;
 		break;
 	default:
 		return 0;
@@ -1587,32 +1592,53 @@ static int record_load_store_access(struct bpf_verifier_env *env,
 		ptr = &resolved;
 	}
 
+	info.may_read = read;
+	info.may_write = write;
+	info.must_write = write;
+	info.size = bpf_size_to_bytes(BPF_SIZE(insn->code));
 	if (ptr->frame >= 0 && ptr->frame <= depth)
-		return record_stack_access(env, instance, ptr, sz, ptr->frame, insn_idx);
+		return record_stack_access(env, instance, ptr, info, ptr->frame, insn_idx);
 	if (ptr->frame == ARG_IMPRECISE)
 		return record_imprecise(env, instance, ptr->mask, insn_idx);
 	/* ARG_NONE: not derived from any frame pointer, skip */
 	return 0;
 }
 
+/* Adapt the signed helper/kfunc access size until both producers are converted. */
+static struct arg_access_info stack_access_info(s64 bytes)
+{
+	bool write = bytes < 0 && bytes != S64_MIN && -bytes < U32_MAX;
+
+	return (struct arg_access_info) {
+		.size = bytes == S64_MIN
+			? U32_MAX
+			: min_t(u64, bytes < 0 ? -bytes : bytes, U32_MAX),
+		.may_read = bytes > 0 || bytes == S64_MIN,
+		.may_write = write,
+		.must_write = write,
+	};
+}
+
 static int record_arg_access(struct bpf_verifier_env *env,
 			     struct func_instance *instance,
 			     struct bpf_insn *insn,
 			     struct arg_track *at, int arg_idx,
 			     int insn_idx)
 {
+	struct arg_access_info info;
 	int depth = instance->depth;
 	int frame = at->frame;
 	int err = 0;
-	s64 bytes;
 
 	if (!arg_is_fp(at))
 		return 0;
 
 	if (bpf_helper_call(insn)) {
-		bytes = bpf_helper_stack_access_bytes(env, insn, arg_idx, insn_idx);
+		info = stack_access_info(bpf_helper_stack_access_bytes(env, insn,
+								       arg_idx, insn_idx));
 	} else if (bpf_pseudo_kfunc_call(insn)) {
-		bytes = bpf_kfunc_stack_access_bytes(env, insn, arg_idx, insn_idx);
+		info = stack_access_info(bpf_kfunc_stack_access_bytes(env, insn,
+								      arg_idx, insn_idx));
 	} else {
 		for (int f = 0; f <= depth; f++) {
 			err = mark_stack_read_all(env, instance, f, insn_idx);
@@ -1621,11 +1647,11 @@ static int record_arg_access(struct bpf_verifier_env *env,
 		}
 		return 0;
 	}
-	if (bytes == 0)
+	if (!info.size)
 		return 0;
 
 	if (frame >= 0 && frame <= depth)
-		err = record_stack_access(env, instance, at, bytes, frame, insn_idx);
+		err = record_stack_access(env, instance, at, info, frame, insn_idx);
 	else if (frame == ARG_IMPRECISE)
 		err = record_imprecise(env, instance, at->mask, insn_idx);
 	return err;

-- 
2.53.0
