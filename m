Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F24421231
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238394; cv=none; b=VeRFFwb95fesHf3I6JQmP9LK4GFQ9h5HhCBctleQ6kD3xdW0WZMoHJx8eTVFj81N0Xfxn7DQOoOtIShjtPyiP3/dqXNnnX+HQt4wZLtGhK87K7kk8W9Shp2q+E3sovTkHmUYa94DqxB4VWP6laKJoTUyXqWdYDhT071hQkbvytQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238394; c=relaxed/simple;
	bh=bhekp6pZTIksoRBlb4nvGAGjkqKDs/cfz5GjQFzqQhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItQCkvtnaNnSVp21rYuVIUeMbdVQmYs5GGxsFscALcdSUDI2iWrfDZcocEQJukKvxv9CsdmPxOuBdxknGizDcFVkM7KDWqUvDYJ18arAWP/WtNTLvDLY7QCjSJDRkrjYUhGETmVys+DBnWyMD7LGt15aZOv9ZKyqcveAUWQ8fIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8ToGP3G; arc=none smtp.client-ip=74.125.225.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8ToGP3G"
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-485ac0c75b9so763777f8f.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 01:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790238391; x=1790843191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LnxjJEVSaZhi1Q+Nox0yiPWflsnntAx/S0tN4QU6XjU=;
        b=Z8ToGP3GjLLqzzmvcJg5PdirW3ixV0Y7bhaP5s5BfHyBMqkQn2feL8wu5z/92cD4sq
         k96vUCGDv0XrkHYHFTCaZ8JYHPmQkwMrCifdgR1cXfY6gZkiWTUlQR25EU6mqT/MjYL9
         V56tYPP2MAiRSf8Eq0uPDGVajTYkzgkwd6dEsU0cVMadcWQ2k4kOVufL4/u0POnuYDZ/
         WdXZUDgiJa7qoRKb/f5nKXQJqYsdrEdh5qx/vb1FPQ0iE8/XxE4lx9msp8RqPR8KS4/o
         kxIPM69YWenKC0VSF0JauCACYKgU6LdD9GkIVOm3tyodghZViz/GhDScJSLaL8xVqb7t
         nskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790238391; x=1790843191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LnxjJEVSaZhi1Q+Nox0yiPWflsnntAx/S0tN4QU6XjU=;
        b=BS4ynPUPk5UAWfjLIPaFlBh4CE3Hu1KUUDioZc9Hh+smNgRwaRUQdI7yKoWO7j9SSZ
         4iZ4br5HDbefMJRhJSTle5vXvt8y1JWZuFaGGWUCOq+g56cYEj4bktqrISIRayUoHsH2
         wRHDh1BwtEl39oXL5RcrIOtN3ItV1ePSmTrfrKyxXRiyjs5fcJ5z7OzUhCBmPKNEOegK
         ol61wHm263EAjdVBiSf17iVoaxzQy3zkVCD44hA5Oofr7nXRWRJX0DKgsObOsSEvQFoI
         kd+Qcs5dIG5s/lvfGkT8osowX7zOTz3tkievbxCoFRVoTlYu/CrzCIG/J3lWf6SPbRLD
         5vQw==
X-Gm-Message-State: AFuF++khV4a0ZH2OZ7tOdQbJbJgOVhAO0O53sw1i4iposcvL+ZsONyYS
	n99IjZRv+xl1a/IstwDSysnlnLRIp3J7vViampp37w122E5fViSavxhkRjOP1/cc
X-Gm-Gg: AYBFou0007aluce/p42STmFB/xyhv8Ozbqw10XfffQ1HsFsqLpDfodXaAPFz9bVJaMN
	K8vhy6Ej0cRw6trl6TA3Iz3FWt9C+s1G3OV8m8UFxWav8n10ql4uEIMi2BLdScV1WK2cb2BEaiI
	3SwlVBOrZdY+tAyg2Lu0jHT3QYq4iT5RNXQfdUo2qI1XdFtwXs9ciRz/O4vCkXKWSgK7BNVXpRk
	ysAEKvWb5RkeEr1iqCoOoSI2iZ6BNz1VEMsaXDVejDCIG+XOegCjAXZbL9BmcwMMzWNATcExBAO
	Kl51GVZCNuyV6ri+bhNas5XPimCUnfNlRkcs4BbX6yG5dSng/PrEcRXfmZxHIBEZqwWqx+kcVYD
	a4ep1agryoF+k9Jnif+z4FIBMQL8LLIOfmAdHjFY89pA4Mq4yaniIpsJUplBtkBmlpjCGG6L2DF
	dRx0zFSr4XJb97aClDM6wSU7Xl2fJzgvExxxHPC28I0V/oQ8PbcT8kbLcHi/XT3jxxG1EJjtvua
	QS+/G3A+KGw5QXAB1haHER/RSlZvh4u7hCeto+Em5B9TmoE45o84pIIzgUx+e3WhiJgAU+cnTyY
	/er4+bUnpE1BynqZb68vN/sgeN5gccmMr/qDr9/mfSjvCgvi
X-Received: by 2002:a05:6000:2893:b0:487:10a9:57cb with SMTP id ffacd0b85a97d-488719756c5mr2366523f8f.49.1790238390867;
        Thu, 24 Sep 2026 01:26:30 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886877a2a5sm13801325f8f.26.2026.09.24.01.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 01:26:30 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 12/18] bpf: Size the per-frame verifier structures for a 2 KiB stack
Date: Thu, 24 Sep 2026 10:25:48 +0200
Message-ID: <20260924082607.2695649-13-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924082607.2695649-1-memxor@gmail.com>
References: <20260924082607.2695649-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6945; i=memxor@gmail.com; h=from:subject; bh=bhekp6pZTIksoRBlb4nvGAGjkqKDs/cfz5GjQFzqQhw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvLvRT7ZUote7d7JZWssZpYWzO9OG3zLQm9hPWpfQcyv 9e/XlvbUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIlYejP8lbJTfHnfW0h51X/Z 3D2WG45ZSfyLjv7ovV/1W+7pn37d2xn+ez+8WaqcZ8R8RelFyAMtQU83jl0buKr2eJ9r13XPXP2 XHwA=
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
words per frame, a fixed few hundred bytes per verifier environment.
tmp_str_buf, which formats a frame's slot list for the log, grows from
320 to 1408 bytes so that all 256 slots still fit, and the log's line
buffer from 1 to 2 KiB so that a line built from it is not cut; the
environment stays within its 64 KiB allocation. The liveness masks are
only as wide as the stack a frame uses, so most frames cost the same as
before; a frame that is read as a whole, through a pointer of unknown
offset or by bpf_loop() with two callbacks, now carries masks of eight
words, 192 bytes per instruction per frame instead of 48. Measured over
the 5075 selftest programs, that is 0.2% of the total peak verifier
memory: strobemeta_bpf_loop and pyperf600_bpf_loop grow by 11% (1.2 MiB
and 0.6 MiB), a few dozen small programs by 40 to 100 KiB each,
everything else is unchanged. The next patch bounds such reads by the
program's budget, so this cost is only paid once a JIT grants it.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h                  | 26 ++++++++++++-------
 include/linux/filter.h                        |  5 ++++
 kernel/bpf/liveness.c                         |  2 +-
 .../selftests/bpf/progs/verifier_live_stack.c |  6 ++---
 4 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3ff1d4f753d3..f7964410f330 100644
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
@@ -717,7 +719,11 @@ struct bpf_insn_aux_data {
 #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF program */
 #define MAX_USED_BTFS 64 /* max number of BTFs accessed by one BPF program */
 
-#define BPF_VERIFIER_TMP_LOG_SIZE	1024
+/*
+ * Longest line the verifier log can carry: a full stack mask of
+ * MAX_BPF_STACK_SLOTS slots, see TMP_STR_BUF_LEN, plus its prefix.
+ */
+#define BPF_VERIFIER_TMP_LOG_SIZE	2048
 
 struct bpf_verifier_log {
 	/* Logical start and end positions of a "log window" of the verifier log.
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 4f0662e42897..fe72e71984e5 100644
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
index 1d83a4cf6ec5..2f52315d8bdd 100644
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
index c3b08089fef1..a916d4049a0b 100644
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
@@ -2874,7 +2874,7 @@ __naked void narrow_store_defines_nothing(void)
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

