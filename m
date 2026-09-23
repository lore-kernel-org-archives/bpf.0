Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E5A5678EE
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190727; cv=none; b=l5tkJfyUIgEGkF6/LUoc9RRUAku7A76WNBJmphna7sDWmahpyZq5xgHGnn/bjTNpswHjZGwPmVXFbb1DZmi3ai+92cv32u4qgtLX9AHuxdnhBaigmFNpxhyXkIgym06G+9Sfg5XJJrkfK5D2BtL8Kua86Kt8l4aJp5hHGrLjlj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190727; c=relaxed/simple;
	bh=+DLIlBJXlikcjQAqOD6ldL+u2/QxCX4Q0UQXw9BLaec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6ITMh3jwuh+PN2gaxS4ng+WLhfNVXiyGOwcqg1fCXtxUffEi95pUHm5y6W0FbIYNH1OpX7ONaI+lqQykMUf17JAjU2WgCnl6drnUE6aPU/ILI7MB7MTayF95pR/ofV5uDLHYUTU8vW+FzPEuvtisuKr4NjOfBggkCkmObbZtn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwLZos+h; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwLZos+h"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49e78a58e17so4402625e9.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790190724; x=1790795524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6R41lbLUu+wX7Hfq0qnbn82WpRXUbOjqLYIrd6t0lsg=;
        b=PwLZos+hUmQ67JQ7m6ah+YOvKEnQKn5qHiva8yy23HxbvpBsh8ToxnHs1Ztouul55H
         s7bUnzfwwp4fdCTQkQobvje78sAaWig4ro8j9yg4cElVsosOPwTw2VxRl6b4XeN2qBui
         qiXN8OxRBUJkvEwGcgxArAFWxI1yl+61opDTwDEdgmFI7mLwtr6XmpQJGBJ41o2+IZ11
         Hb0EmLyEy/jOiP29tuHrqEzbNckRlDbgHdVeOQciAChuShE4KOmSzSsKE9dhE0x4mnwK
         wYL0SdP0BMB3GSJqUCxgoq+gzEzyGiN9SagtTTenRsVbfEiGUe9VV5gB02CF40PafCDA
         sFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190724; x=1790795524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6R41lbLUu+wX7Hfq0qnbn82WpRXUbOjqLYIrd6t0lsg=;
        b=V1tCxV1MDb3oaiwxJ6c+vLRQsX32X7QTk8FJT+JsAqHJY2kKe+tYBEaOWGoFp5FBhg
         XyFTvOHnWJ4m0sPCuDXYcyFy1gTf/vu4sCW6DELuicx1Xq6GXIX0kurFPsBpgvPSnNxc
         5DHs9lTYyqnIY8o28bAI/ncFUgLDhvvl+J6YVJS78/b82UCuN7q9wBliyG3Eoo4a96QY
         npYqYl4X5fEodocrVPmBhBSGvfRc4XOu5VmfjsshcCvU7Bs3ctSyUCWu3giknKUAnxkh
         F5UDlzT3b+SFqYzx9OB9mdAMoRix44H3vgAj+BHi4k1NpNdoHiUcLkK+sFeZbAeXoBB4
         m+2A==
X-Gm-Message-State: AFuF++mhdjYR1vU1EQUw8wNZzd1uSLvOVbm9UjbNYJDWW2joYlwJBofz
	1hCAOX0vtHGV3eiYHjEsZzbHXMHtHr40Vg6P93y95qy8xe4LW2vaIEh7YUoPK0gv
X-Gm-Gg: AYBFou3YEz1soV1cJ54uG9+eKZxG8Bl0MaYaGuzltIqKLeu3obcUzgfXJCqn3b7VRmV
	KhCwr9wPpiu+cG5sp9zBM+tw2RrnBC9o4BpwTtsA8znSPIz3zaVWA+ryo7tqwH7HxJ9TJ8XZBic
	UTAl7YKoKaZ+0j1pzH4RfC2OZKMkPHY0/jik5mTDQf+mn70eWM0Nys6GsK2G+qq9puRkQYTCEjy
	IPM2m/aWoDdBCXYZvYoey/Lni6lmEHmDQ8zwooUM2ABhzhS7GpG46HG5X7rhiu629/ytjwY0Ry8
	tsY0q4ECzw+xRWmDYoA8DgBaE+/3EkPQJJqYhhpMx8zGYMf2sr3at2UPoOByhWANbqjDXM30dlc
	X0Jiitv0lLlnkRkuXVW1q4G+SZh0jBnePSEU60d3tIpeSc6VI2fHX9oVIQxI/E5sbFstol+NfLW
	oxgXnqhKw+MjH6Oh3m6NaCl/iQGzopQnOLEUBm9KAI82qOPTgI599kA9MjtIgBUewGr6j0YPpqh
	cPFtxUsr71IKgEALp7j3Jph0mKGe2/zD7VwOIEuTG7TSrasukDNAium8TrjeAfPz4PKgX90lwer
	lHMqcJJu4w+ESdaRldT0zZ2Pmc0j1Ag5xAePVGDhbaWtPMoX
X-Received: by 2002:a05:600c:198b:b0:49c:edd8:ba35 with SMTP id 5b1f17b1804b1-49fe66ca13dmr3004705e9.6.1790190724219;
        Wed, 23 Sep 2026 12:12:04 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48867b49661sm8483978f8f.0.2026.09.23.12.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:12:03 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 12/18] bpf: Size the per-frame verifier structures for a 2 KiB stack
Date: Wed, 23 Sep 2026 21:11:19 +0200
Message-ID: <20260923191139.2816206-13-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923191139.2816206-1-memxor@gmail.com>
References: <20260923191139.2816206-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6316; i=memxor@gmail.com; h=from:subject; bh=+DLIlBJXlikcjQAqOD6ldL+u2/QxCX4Q0UQXw9BLaec=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWuL4nehY4lXJofdrnzR/mK/ROVFrYmLkjbvYvlWP+PyL UmL6d8fdJSyMIhxMciKKbKU/N/HZHyi8neg7TJumDmsTCBDGLg4BWAiVjcY/ldwZT/wan80RWXt /EPyjD0SVgm9D2ueRUvNZnkx3eyTQS/DP9szMUXbTB5MMer5EvBpHduJ6lqW3vVe+ue9mmyuH4m Q4AAA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The verifier keeps a few structures whose size follows the deepest
frame a program may have: the backtracking and scratched-slot bitmaps,
the jump history slot index and the clamp of the liveness masks. They
are all expressed through MAX_BPF_STACK_SLOTS, which derives from
MAX_BPF_STACK, the frame size of the interpreter.

Introduce MAX_BPF_STACK_JIT, the stack budget a program may get on a
JIT that can lay out frames of any size, and derive those structures
from it so that a frame may be as deep as that budget. Nothing grants
the budget yet, so no program verifies differently; the only visible
change is that the liveness log prints a whole-frame read up to the new
depth, so the three selftests matching such reads are updated.

The backtracking and scratched-slot bitmaps grow from one to four
words per frame, a fixed few hundred bytes per verifier environment, and
tmp_str_buf, which formats a frame's slot list for the log, grows from
320 to 1408 bytes so that all 256 slots still fit; the environment stays
within its 64 KiB allocation. The liveness masks are only as wide as
the stack a frame uses, so most frames cost the same as before; a frame
that is read as a whole, through a pointer of unknown offset or by
bpf_loop() with two callbacks, now carries masks of eight words, 192
bytes per instruction per frame instead of 48. Measured over the 5075
selftest programs, that is 0.2% of the total peak verifier memory:
strobemeta_bpf_loop and pyperf600_bpf_loop grow by 11% (1.2 MiB and
0.6 MiB), a few dozen small programs by 40 to 100 KiB each, everything
else is unchanged. The next patch bounds such reads by the program's
budget, so this cost is only paid once a JIT grants it.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h                  | 20 ++++++++++---------
 include/linux/filter.h                        |  5 +++++
 kernel/bpf/liveness.c                         |  2 +-
 .../selftests/bpf/progs/verifier_live_stack.c |  6 +++---
 4 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d8cafd3d74aa..11fa9f1f087c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -19,11 +19,12 @@
  * that converting umax_value to int cannot overflow.
  */
 #define BPF_MAX_VAR_SIZ	(1 << 29)
-/* size of tmp_str_buf in bpf_verifier.
- * we need at least 306 bytes to fit full stack mask representation
- * (in the "-8,-16,...,-512" form)
+/*
+ * size of tmp_str_buf in bpf_verifier.
+ * we need at least 1399 bytes to fit full stack mask representation
+ * (in the "-8,-16,...,-2048" form)
  */
-#define TMP_STR_BUF_LEN 320
+#define TMP_STR_BUF_LEN 1408
 /* Patch buffer size */
 #define INSN_BUF_SIZE 32
 
@@ -243,12 +244,13 @@ enum bpf_stack_slot_type {
 #define BPF_REG_SIZE 8	/* size of eBPF register in bytes */
 
 /*
- * Largest number of BPF_REG_SIZE stack slots a single frame can have. A frame
- * may use any part of the MAX_BPF_STACK budget; check_max_stack_depth()
- * enforces the bound on the combined depth of frames sharing the kernel stack
- * and on each frame using a private stack.
+ * Largest number of BPF_REG_SIZE stack slots a single frame can have, sized
+ * for the largest stack budget any JIT supports. A frame may use any part of
+ * its program's budget; check_max_stack_depth() enforces the budget on the
+ * combined depth of frames sharing the kernel stack and on each frame using
+ * a private stack.
  */
-#define MAX_BPF_STACK_SLOTS	(MAX_BPF_STACK / BPF_REG_SIZE)
+#define MAX_BPF_STACK_SLOTS	(MAX_BPF_STACK_JIT / BPF_REG_SIZE)
 
 /* 4-byte stack slot granularity for liveness analysis */
 #define BPF_HALF_REG_SIZE	4
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 422284b4fa96..5688bc647df6 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -98,6 +98,11 @@ struct ctl_table_header;
 
 /* BPF program can access up to 512 bytes of stack space. */
 #define MAX_BPF_STACK	512
+/*
+ * Stack budget of a program on a JIT that lays out frames of that size.
+ * The interpreter and JITs without such support keep MAX_BPF_STACK.
+ */
+#define MAX_BPF_STACK_JIT	2048
 
 /* Helper macros for filter block array initializers. */
 
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 07eb84ae0b7f..f83254d41043 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -15,7 +15,7 @@
  * Half-slot 0 covers [fp-4, fp), half-slot 1 covers [fp-8, fp-4), and so on,
  * hence FRAME_HALF_SPIS - 1 is the deepest half-slot a frame can have.
  */
-#define FRAME_HALF_SPIS		(MAX_BPF_STACK / BPF_HALF_REG_SIZE)
+#define FRAME_HALF_SPIS		(MAX_BPF_STACK_JIT / BPF_HALF_REG_SIZE)
 #define FRAME_MAX_WORDS		BITS_TO_LONGS(FRAME_HALF_SPIS)
 
 /* Masks tracked for each instruction of a frame */
diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index a94365decd5f..ec27cb40dbef 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -1953,7 +1953,7 @@ static __used __naked void fwd_parent_key_to_helper(void)
 SEC("socket")
 __log_level(2)
 __success
-__msg("call bpf_map_update_elem{{.*}}; use: fp1-8..-512 fp0-8")
+__msg("call bpf_map_update_elem{{.*}}; use: fp1-8..-2048 fp0-8")
 __naked void helper_arg_fallback_keeps_scanning(void)
 {
 	asm volatile (
@@ -2267,7 +2267,7 @@ static __used __naked void merge_leaf_read(void)
 SEC("socket")
 __log_level(2)
 __success
-__msg("call bpf_loop#181            ; use: fp2-8..-512 fp1-8..-512 fp0-8..-512")
+__msg("call bpf_loop#181            ; use: fp2-8..-2048 fp1-8..-2048 fp0-8..-2048")
 __naked void bpf_loop_two_callbacks(void)
 {
 	asm volatile (
@@ -2872,7 +2872,7 @@ __naked void narrow_store_defines_nothing(void)
 SEC("socket")
 __log_level(2)
 __msg("stack use/def subprog#{{[0-9]+}} merge_read_all_callee (d2,cs{{[0-9]+}}):")
-__msg("(79) r0 = *(u64 *)(r1 +0){{.*}}; use: fp0-8..-512")
+__msg("(79) r0 = *(u64 *)(r1 +0){{.*}}; use: fp0-8..-2048")
 __naked void merge_keeps_whole_frame_read(void)
 {
 	asm volatile (
-- 
2.53.0

