Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415811;
	b=XitRIeNSnqDHPsKPPpZVKJf2RTZVjxSpKE1Ol/nflvIPC2resQ/OlXdqqrP7nogf85uw
	 i57gxe9BZxnIjZ/0v77IDOEeQLmcUnTfk14dH8BKNujNBw9QjY5omjzyl3gf/HsJdhUay
	 97e9ks4i2DGlP0srYgElXKwcSb+Q/LZcBhkGr5/1L3ZqsSZqb2igUMB7C2laHSD1XDJ8o
	 oUaG5pzdWzgQHvBpzstxdGI+Gdhcw2/XcvjW3wxSErsQD+jjjCX7KBeeo3p23EFVXrVFO
	 mX5K3sYMe9Ad8dlz3Q4k5WiDnRe+LfvZaw9Mb7WGzvTECtdan1EETb8RZ8/csrkURrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415811;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Zmyl29a9OWmZRVOvcD2h4qz3pMZ6pnPcT/bggWBhOhw=;
	b=cic1yg4UtcZQdEIbFlofNpIgX3IP/4QmYtSYMFVFZrEcy3cDrCvtSq4Qzgpr2Y7Rf68/
	 QFFsIT1CW/LPJkmF926EtBtALw+sa+DJXUAl0tPYRnYhCRz1O13idDJu5972WbRvpSPck
	 a2wDpFn/qIYXF2r1g+jcAoKE6dcSznj6paB7OtBknhwQ9dj8LqcHO9+DT7IcsWm5RzLzC
	 5YK3h1uqtbWofxx4tkW9DqOO6N/hddtlGPT2LWYeguvHfvhKK9eC+PTLBkd6EnK4epFt9
	 uCEwcIh7CiWt2TmxjWSSZfUAPka+jghoqD/PWC+qlYD1I/nB6AGsclK+lFnrlkvTIVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mSwUtHBe;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58177606A334
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58177606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mSwUtHBe
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ed2b4348fcso13466915ad.2
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415811; x=1795020611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zmyl29a9OWmZRVOvcD2h4qz3pMZ6pnPcT/bggWBhOhw=;
        b=mSwUtHBeDkFoHikGP6hblzqDR5Z8nZxFlcK7qx5nMriQL270m8ZBHly7jWz2OwywW6
         5tO4L6qits+J9MTmygBCkgTL6ukGfNwB8XuUVUoaELiNyTFxR2zUIMxlfytnEvqEzzI3
         qK1IPd3Fn4EGyRn4rqfeQaQMXMdN1u+KtkCrq/5GKRjFV5y2IhwZDWGbBgKxML0rSvTn
         Eg50iPPDwrGMLjkdlcKLyd8puuQArAV7Hr8g7B42pszYV9Gh/TPGlZ1ivXeO0OQ1QSW/
         NJVtq0LThdvA4VmbvHQ9gFsC05V3DvUhU90agd7sjvU547yzgyyG+uX5ddiFoGHRHqls
         BJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415811; x=1795020611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zmyl29a9OWmZRVOvcD2h4qz3pMZ6pnPcT/bggWBhOhw=;
        b=oie9oGc0QCu7w7wXi1mbrTwg66ZfaCoJlOS2ccDDTeXUuvaqUsdcyZiVO3SLBUVJKq
         GoXxuTvSGxwiK018CdSj6sr58F7iBeaHi+2ydnonOHzezzm4IQ2EumE2zNi63QTSBUr6
         TPwAPxv/TKQYizTVRCBpY+iW+JHyT63y+MxrXGnaWmWQeLTXpbtLRBZC9iflle4Qayyg
         kKQC7d0gyeJAxWbZViqEtRy4Eg1W5eFysAYOosMJmUeuklcu54KOjUHl2V6zm6XTXImV
         TmFf0P++h2+hhVcS6kfsSr7jNq2afROBhWengvkpsVpaLxmogRPp0H9PeSFSjvvqfNQV
         Tfpw==
X-Gm-Message-State: APuU4Z+dBbhtELJ7UGNL4mLW2VQDHJO7WnSLVAolIinD0vgDJz/ntwsn
	fM4v/4tnMgkfZ3omrLSVQLYp8kxUs+GQwxWptTScaNZAmzr3GsiXCasksrmGBA==
X-Gm-Gg: AYBFou0bLkZ4s3BrJibnmJdIjsT1RIIbaEfKVCe+9SfXKe2TQEOXq38zGW0h4hH4/NF
	PpEpc8DFlzqscEBYDm/4x3au1KjB9j/tq4/eSnLjPm2bAD/4Z/+gljP/X2mINU6b8rMgaXtcpB/
	MGwMSl6xhfk+Y33Uozt/P1jOMdrrfWQQeK+EeXSy2ABxLn+qs4Yg/e2XXnQNbnMsSO/b2tdERar
	LFnCfycnRkkbkvG/GDbItggC/3ICnpml2ruOj4oHrhjdi7vvzW1Wi2V84HXLJA5qKkPmb2LAlsO
	bjmV8WZ+i3tJZZbnXEiDvUJYJwsO+Liack2QcW+rVMHHOJwXyaukBHXquv/7wmyvxU+GbG6UfDJ
	huagJq9Zs/TuybdK7eLj6AQFwYsz/WnznD1H1Ylz3B7nDJSWBtw8SIjHRxvjjIMGWaa+TSyyw5Q
	gVaq8deuyE0RtwPr63uXR2y9C4omeuedmFODMZFPOcZXgLODORPvfuNUQ+PcdZ2eQSJhlPQ/90j
	ZXQ0E/7YFDkYoo+ZpO3JyQHddlq8MqoRVB73UDw17rDe+61JaHxLuRnorhxIg50c6JBbXSV+QCv
	CmuNZPZKki2xD703SnOSZUg9xheGqPOS2U6xF1jfKOi94Meycrfk4KJwJbgZXZNPiVWr0qkyVbB
	ORUH6Usn9t+SiIn2WW1ku0ehX0XjK0/gs9JayXZGoMQTIWaJMW7NIVzrdOzkODwr5ryIW7Gm3e4
	w=
X-Received: by 2002:a17:902:e54a:b0:2ea:1b9b:b938 with SMTP id d9443c01a7336-2edd7a89eccmr34025065ad.55.1794415810487;
        Wed, 11 Nov 2026 08:50:10 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6dd9119sm21583135ad.64.2026.11.11.08.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:50:09 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 3/6] bpf: Add scalar_add() and four more operations on struct scalar
Date: Wed, 11 Nov 2026 16:49:46 +0000
Message-ID: <20261111164950.2674588-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111164950.2674588-1-alexei.starovoitov@gmail.com>
References: <20261111164950.2674588-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The sum of two values is written six times. Four copies are in
verifier.c: adjust_scalar_min_max_vals(), adjust_ptr_min_max_vals(),
add_scalar_to_reg() and recompute_ptr() add the step, the ranges and
var_off line by line. Two are in scev.c, which has no register to pass to
verifier.c's helpers: scev_value_add() adds ranges and knows nothing of
var_off and step, bpf_clamp_scev_regs() adds r64 and the step.

Make the operations that scev.c needs take a struct scalar. Each of them
is code that verifier.c has, none is a second copy:

 - scalar_add() replaces the four copies in verifier.c.
   scalar_min_max_add() and scalar32_min_max_add() go. The sum of a
   pointer and a scalar takes no 32-bit range from its operands:
   adjust_ptr_min_max_vals() and recompute_ptr() forget r32 of the pointer
   first, reg_bounds_sync() derives it from r64, as before.
 - scalar_set_const() was ___mark_reg_known(). add_scalar_to_reg() makes
   a constant with it, and no register of 80 bytes.
 - scalar_set_unknown() was bpf_reg_forget_range().
 - scalar_zext32() was zext_32_to_64(). It calls cnum64_zext32(): an empty
   r32 gives an empty r64, it gave [0, U32_MAX]. Such a register is a
   violation that reg_bounds_sanity_check() reports either way.
 - scalar_union() was bpf_reg_union_range().

None of them calls reg_bounds_sync(): the callers do, where they did.

No other functional change.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   7 +-
 kernel/bpf/join.c            |   2 +-
 kernel/bpf/scev.c            |   2 +-
 kernel/bpf/verifier.c        | 160 ++++++++++++++++-------------------
 4 files changed, 80 insertions(+), 91 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 00f8680ecb3d..5d472bb8f2d0 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -2062,11 +2062,14 @@ int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env);
 bool bpf_same_memory_origin(const struct bpf_reg_state *reg_a,
 			    const struct bpf_reg_state *reg_b);
 void bpf_trim_pkt_range(struct bpf_reg_state *reg, s64 smax);
+void scalar_set_unknown(struct scalar *s);
+void scalar_set_const(struct scalar *s, u64 imm);
+void scalar_add(struct scalar *dst, const struct scalar *a, const struct scalar *b);
+void scalar_zext32(struct scalar *s);
+void scalar_union(struct scalar *acc, const struct scalar *src);
 int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		      struct cnum64 r64, struct cnum32 r32, u16 base, u16 step);
 bool bpf_reg_union_compatible(const struct bpf_reg_state *a, const struct bpf_reg_state *b);
-void bpf_reg_union_range(struct bpf_reg_state *acc, const struct bpf_reg_state *src);
-void bpf_reg_forget_range(struct bpf_reg_state *reg);
 void bpf_reg_widen_range(struct bpf_reg_state *reg, const struct bpf_reg_state *old,
 			 const struct bpf_loop_rungs *rungs, int linear);
 int bpf_reg_union(struct bpf_verifier_env *env, struct bpf_reg_state *acc,
diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
index 9db52e8f36ca..196712ecfd59 100644
--- a/kernel/bpf/join.c
+++ b/kernel/bpf/join.c
@@ -160,7 +160,7 @@ static bool join_range(struct bpf_join_state *js, struct bpf_reg_state *dst,
 {
 	if (scalar_equal(scalar_of(ra), scalar_of(rb)))
 		return true;
-	bpf_reg_union_range(dst, rb);
+	scalar_union(scalar_of(dst), scalar_of(rb));
 	if (!js->widen || scalar_equal(scalar_of(dst), scalar_of(ra)))
 		return true;
 	/*
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index a477a3029baa..46c7c654164c 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -5037,7 +5037,7 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 		if (test_bit(r, iters->forget_regs)) {
 			reg = scev_reg_for_linear(cur_func, r);
 			if (reg && reg->type == PTR_TO_ARENA) {
-				bpf_reg_forget_range(reg);
+				scalar_set_unknown(scalar_of(reg));
 				mark_scev_reg_scratched(env, r);
 			}
 			continue;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eabefa35631c..1d43f64e5f26 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -220,8 +220,6 @@ static bool is_trusted_reg(struct bpf_verifier_env *env, const struct bpf_reg_st
 static inline bool in_sleepable_context(struct bpf_verifier_env *env);
 static bool in_rcu_callback(struct bpf_verifier_env *env);
 static const char *non_sleepable_context_description(struct bpf_verifier_env *env);
-static void scalar32_min_max_add(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg);
-static void scalar_min_max_add(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg);
 
 static void bpf_map_ptr_store(struct bpf_insn_aux_data *aux,
 			      struct bpf_map *map,
@@ -1877,17 +1875,20 @@ static void bpf_diag_record_caller_saved(struct bpf_verifier_env *env,
 	}
 }
 
+static void scalar_step_reset(struct scalar *s)
+{
+	s->base = 0;
+	s->step = 1;
+}
+
 static void reg_step_reset(struct bpf_reg_state *reg)
 {
-	reg->base = 0;
-	reg->step = 1;
+	scalar_step_reset(scalar_of(reg));
 }
 
-static void scalar_step_add(struct bpf_reg_state *dst_reg,
-			    const struct bpf_reg_state *a,
-			    const struct bpf_reg_state *b)
+static void scalar_step_add(struct scalar *dst, const struct scalar *a, const struct scalar *b)
 {
-	const struct bpf_reg_state *reg;
+	const struct scalar *reg;
 	s64 amount, tmp;
 
 	if (tnum_is_const(b->var_off)) {
@@ -1897,7 +1898,7 @@ static void scalar_step_add(struct bpf_reg_state *dst_reg,
 		reg = b;
 		amount = (s64)a->var_off.value;
 	} else {
-		reg_step_reset(dst_reg);
+		scalar_step_reset(dst);
 		return;
 	}
 
@@ -1917,14 +1918,26 @@ static void scalar_step_add(struct bpf_reg_state *dst_reg,
 	 *
 	 * Conservatively reset the stride if either wrap is possible.
 	 */
-	if (check_add_overflow(reg_smin(reg), amount, &tmp) ||
-	    check_add_overflow(reg_smax(reg), amount, &tmp)) {
-		reg_step_reset(dst_reg);
+	if (check_add_overflow(cnum64_smin(reg->r64), amount, &tmp) ||
+	    check_add_overflow(cnum64_smax(reg->r64), amount, &tmp)) {
+		scalar_step_reset(dst);
 		return;
 	}
 
-	dst_reg->base = (reg->base + imod(amount, reg->step)) % reg->step;
-	dst_reg->step = reg->step;
+	dst->base = (reg->base + imod(amount, reg->step)) % reg->step;
+	dst->step = reg->step;
+}
+
+/*
+ * dst = a + b in each of the four parts. @dst can be @a or @b.
+ * The sum of reduced scalars is not always reduced: the caller calls reg_bounds_sync().
+ */
+void scalar_add(struct scalar *dst, const struct scalar *a, const struct scalar *b)
+{
+	scalar_step_add(dst, a, b);
+	dst->r32 = cnum32_add(a->r32, b->r32);
+	dst->r64 = cnum64_add(a->r64, b->r64);
+	dst->var_off = tnum_add(a->var_off, b->var_off);
 }
 
 static void scalar_step_scale(struct bpf_reg_state *dst_reg, u64 amount)
@@ -1982,19 +1995,27 @@ static void scalar_step_scale(struct bpf_reg_state *dst_reg, u64 amount)
  * the range where the conversion leaves them unchanged.
  * Call before updating the register's bounds. Requires 0 < bits < 64.
  */
-static void reg_step_check_unsigned(struct bpf_reg_state *reg, u32 bits)
+static void scalar_step_check_unsigned(struct scalar *s, u32 bits)
 {
-	if (reg_umax(reg) >= (1ULL << bits))
-		reg_step_reset(reg);
+	if (cnum64_umax(s->r64) >= (1ULL << bits))
+		scalar_step_reset(s);
 }
 
-/* This helper doesn't clear reg->id */
-static void ___mark_reg_known(struct bpf_reg_state *reg, u64 imm)
+/* Nothing is known about the value, or about the variable part of the offset of a pointer. */
+void scalar_set_unknown(struct scalar *s)
 {
-	reg->var_off = tnum_const(imm);
-	reg->r64 = cnum64_from_urange(imm, imm);
-	reg->r32 = cnum32_from_urange((u32)imm, (u32)imm);
-	reg_step_reset(reg);
+	s->var_off = tnum_unknown;
+	s->r64 = CNUM64_UNBOUNDED;
+	s->r32 = CNUM32_UNBOUNDED;
+	scalar_step_reset(s);
+}
+
+void scalar_set_const(struct scalar *s, u64 imm)
+{
+	s->var_off = tnum_const(imm);
+	s->r64 = cnum64_const(imm);
+	s->r32 = cnum32_const(imm);
+	scalar_step_reset(s);
 }
 
 /* Mark the unknown part of a register (variable offset or scalar value) as
@@ -2007,7 +2028,7 @@ static void __mark_reg_known(struct bpf_reg_state *reg, u64 imm)
 	reg->id = 0;
 	reg->parent_id = 0;
 	reg->map_uid = 0;
-	___mark_reg_known(reg, imm);
+	scalar_set_const(scalar_of(reg), imm);
 }
 
 void bpf_mark_reg_known_scalar(struct bpf_reg_state *reg, u64 imm)
@@ -2203,14 +2224,14 @@ static void __update_reg64_bounds(struct bpf_reg_state *reg)
 		 * u64:  ---[xxxxxx]-----
 		 * tnum: --xx----------x-
 		 */
-		___mark_reg_known(reg, reg_umin(reg));
+		scalar_set_const(scalar_of(reg), reg_umin(reg));
 	} else if (!umin_in_tnum && tnum_next == tmax) {
 		/* The u64 range and the tnum only overlap in the maximum value
 		 * represented by the tnum, called tmax.
 		 * u64:  ---[xxxxxx]-----
 		 * tnum: xx-----x--------
 		 */
-		___mark_reg_known(reg, tmax);
+		scalar_set_const(scalar_of(reg), tmax);
 	} else if (!umin_in_tnum && tnum_next <= reg_umax(reg) &&
 		   tnum_step(reg->var_off, tnum_next) > reg_umax(reg)) {
 		/* The u64 range and the tnum only overlap in between umin
@@ -2218,7 +2239,7 @@ static void __update_reg64_bounds(struct bpf_reg_state *reg)
 		 * u64:  ---[xxxxxx]-----
 		 * tnum: xx----x-------x-
 		 */
-		___mark_reg_known(reg, tnum_next);
+		scalar_set_const(scalar_of(reg), tnum_next);
 	}
 }
 
@@ -2400,9 +2421,7 @@ void bpf_mark_reg_unknown(struct bpf_reg_state *reg)
 {
 	memset(reg, 0, sizeof(*reg));
 	reg->type = SCALAR_VALUE;
-	reg->var_off = tnum_unknown;
-	__mark_reg_unbounded(reg);
-	reg_step_reset(reg);
+	scalar_set_unknown(scalar_of(reg));
 }
 
 static void mark_reg_unknown(struct bpf_verifier_env *env,
@@ -6267,12 +6286,12 @@ static int check_buffer_access(struct bpf_verifier_env *env,
 	return 0;
 }
 
-/* BPF architecture zero extends alu32 ops into 64-bit registesr */
-static void zext_32_to_64(struct bpf_reg_state *reg)
+/* s = (u32)s. BPF architecture zero extends alu32 ops into 64-bit registers. */
+void scalar_zext32(struct scalar *s)
 {
-	reg_step_check_unsigned(reg, 32);
-	reg->var_off = tnum_subreg(reg->var_off);
-	reg_set_urange64(reg, reg_u32_min(reg), reg_u32_max(reg));
+	scalar_step_check_unsigned(s, 32);
+	s->var_off = tnum_subreg(s->var_off);
+	s->r64 = cnum64_zext32(s->r32);
 }
 
 /* truncate register to smaller size (in bytes)
@@ -6282,7 +6301,7 @@ static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
 {
 	u64 mask = (1ULL << (size * 8)) - 1;
 
-	reg_step_check_unsigned(reg, size * 8);
+	scalar_step_check_unsigned(scalar_of(reg), size * 8);
 
 	/* clear high bits in bit representation */
 	reg->var_off = tnum_cast(reg->var_off, size);
@@ -6330,7 +6349,7 @@ static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
 	if (reg_smin(reg) >= -limit && reg_smax(reg) < limit)
 		return;
 
-	/* See commen at reg_step_check_unsigned(). */
+	/* See comment at scalar_step_check_unsigned(). */
 	reg_step_reset(reg);
 
 	if (tnum_is_const(reg->var_off)) {
@@ -6413,13 +6432,13 @@ static void coerce_subreg_to_size_sx(struct bpf_reg_state *reg, int size)
 	 * value of the low 32 bits and the sign extension is a no-op.
 	 *
 	 * This has to precede reg_step_reset() below: the base/step line stays.
-	 * It is about all 64 bits: zext_32_to_64() in the caller discards it
+	 * It is about all 64 bits: scalar_zext32() in the caller discards it
 	 * if the upper 32 bits are not zero.
 	 */
 	if (reg_s32_min(reg) >= field_smin && reg_s32_max(reg) <= field_smax)
 		return;
 
-	/* See comment at reg_step_check_unsigned(). */
+	/* See comment at scalar_step_check_unsigned(). */
 	reg_step_reset(reg);
 
 	if (tnum_is_const(reg->var_off)) {
@@ -7143,19 +7162,13 @@ static bool get_func_retval_range(struct bpf_prog *prog,
 
 static void add_scalar_to_reg(struct bpf_reg_state *dst_reg, s64 val)
 {
-	struct bpf_reg_state fake_reg;
+	struct scalar off;
 
 	if (!val)
 		return;
 
-	fake_reg.type = SCALAR_VALUE;
-	__mark_reg_known(&fake_reg, val);
-
-	scalar_step_add(dst_reg, dst_reg, &fake_reg);
-	scalar32_min_max_add(dst_reg, &fake_reg);
-	scalar_min_max_add(dst_reg, &fake_reg);
-	dst_reg->var_off = tnum_add(dst_reg->var_off, fake_reg.var_off);
-
+	scalar_set_const(&off, val);
+	scalar_add(scalar_of(dst_reg), scalar_of(dst_reg), &off);
 	reg_bounds_sync(dst_reg);
 }
 
@@ -17024,9 +17037,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 		 * added into the variable offset, and we copy the fixed offset
 		 * from ptr_reg.
 		 */
-		scalar_step_add(dst_reg, ptr_reg, off_reg);
-		dst_reg->r64 = cnum64_add(ptr_reg->r64, off_reg->r64);
-		dst_reg->var_off = tnum_add(ptr_reg->var_off, off_reg->var_off);
+		scalar_add(scalar_of(dst_reg), scalar_of(dst_reg), scalar_of(off_reg));
 		dst_reg->raw = ptr_reg->raw;
 		if (reg_is_pkt_pointer(ptr_reg)) {
 			if (!known)
@@ -17168,18 +17179,6 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 	return 0;
 }
 
-static void scalar32_min_max_add(struct bpf_reg_state *dst_reg,
-				 struct bpf_reg_state *src_reg)
-{
-	dst_reg->r32 = cnum32_add(dst_reg->r32, src_reg->r32);
-}
-
-static void scalar_min_max_add(struct bpf_reg_state *dst_reg,
-			       struct bpf_reg_state *src_reg)
-{
-	dst_reg->r64 = cnum64_add(dst_reg->r64, src_reg->r64);
-}
-
 static void scalar32_min_max_sub(struct bpf_reg_state *dst_reg,
 				 struct bpf_reg_state *src_reg)
 {
@@ -17260,7 +17259,7 @@ static void scalar_min_max_uhmul(struct bpf_reg_state *dst_reg,
 	u64 dst = reg_const_value(dst_reg, false);
 	u64 src = reg_const_value(src_reg, false);
 
-	___mark_reg_known(dst_reg, bpf_uhmul64(dst, src));
+	scalar_set_const(scalar_of(dst_reg), bpf_uhmul64(dst, src));
 }
 
 static void scalar_min_max_shmul(struct bpf_reg_state *dst_reg,
@@ -17269,7 +17268,7 @@ static void scalar_min_max_shmul(struct bpf_reg_state *dst_reg,
 	s64 dst = reg_const_value(dst_reg, false);
 	s64 src = reg_const_value(src_reg, false);
 
-	___mark_reg_known(dst_reg, bpf_shmul64(dst, src));
+	scalar_set_const(scalar_of(dst_reg), bpf_shmul64(dst, src));
 }
 
 static void scalar32_min_max_udiv(struct bpf_reg_state *dst_reg,
@@ -17956,10 +17955,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	 */
 	switch (opcode) {
 	case BPF_ADD:
-		scalar_step_add(dst_reg, dst_reg, &src_reg);
-		scalar32_min_max_add(dst_reg, &src_reg);
-		scalar_min_max_add(dst_reg, &src_reg);
-		dst_reg->var_off = tnum_add(dst_reg->var_off, src_reg.var_off);
+		scalar_add(scalar_of(dst_reg), scalar_of(dst_reg), scalar_of(&src_reg));
 		break;
 	case BPF_SUB:
 		scalar32_min_max_sub(dst_reg, &src_reg);
@@ -18003,7 +17999,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	case BPF_DIV:
 		/* BPF div specification: x / 0 = 0 */
 		if ((alu32 && reg_u32_max(&src_reg) == 0) || (!alu32 && reg_umax(&src_reg) == 0)) {
-			___mark_reg_known(dst_reg, 0);
+			scalar_set_const(scalar_of(dst_reg), 0);
 			break;
 		}
 		if (alu32)
@@ -18101,7 +18097,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	 * but we should not zero extend the result.
 	 */
 	if (alu32 && opcode != BPF_END)
-		zext_32_to_64(dst_reg);
+		scalar_zext32(scalar_of(dst_reg));
 	reg_bounds_sync(dst_reg);
 	return 0;
 }
@@ -18315,14 +18311,6 @@ bool bpf_reg_union_compatible(const struct bpf_reg_state *a, const struct bpf_re
 	       a->id == b->id && a->parent_id == b->parent_id && a->map_uid == b->map_uid;
 }
 
-/* Nothing is known about the number or the variable part of the offset anymore. */
-void bpf_reg_forget_range(struct bpf_reg_state *reg)
-{
-	reg->var_off = tnum_unknown;
-	__mark_reg_unbounded(reg);
-	reg_step_reset(reg);
-}
-
 /*
  * @reg is what @old became after a trip around a cycle, @old included. The end
  * of the range that moved is going to move again. Put it where it may come
@@ -18349,7 +18337,7 @@ void bpf_reg_widen_range(struct bpf_reg_state *reg, const struct bpf_reg_state *
 	    ((max > reg_smax(old) && !(rungs && rungs->has_max && max <= rungs->max[1])) ||
 	     (min < reg_smin(old) && !(rungs && rungs->has_min && min >= rungs->min[1])))) {
 		if (linear == 64 || min < 0 || max > U32_MAX) {
-			bpf_reg_forget_range(reg);
+			scalar_set_unknown(scalar_of(reg));
 			return;
 		}
 		min = 0;
@@ -18371,7 +18359,7 @@ void bpf_reg_widen_range(struct bpf_reg_state *reg, const struct bpf_reg_state *
 		min = stop;
 	}
 	if (min == S64_MIN && max == S64_MAX) {
-		bpf_reg_forget_range(reg);
+		scalar_set_unknown(scalar_of(reg));
 		return;
 	}
 	/*
@@ -18383,7 +18371,7 @@ void bpf_reg_widen_range(struct bpf_reg_state *reg, const struct bpf_reg_state *
 	 */
 	if ((max == S64_MAX && (reg_smax(old) == S32_MAX || reg_smax(old) == U32_MAX)) ||
 	    (min == S64_MIN && reg_smin(old) == S32_MIN)) {
-		bpf_reg_forget_range(reg);
+		scalar_set_unknown(scalar_of(reg));
 		return;
 	}
 	/* every part has to include what it did before, hence no reg_bounds_sync() */
@@ -18409,7 +18397,7 @@ void bpf_reg_widen_range(struct bpf_reg_state *reg, const struct bpf_reg_state *
 		reg_step_reset(reg);
 }
 
-void bpf_reg_union_range(struct bpf_reg_state *acc, const struct bpf_reg_state *src)
+void scalar_union(struct scalar *acc, const struct scalar *src)
 {
 	bool acc_const = cnum64_is_const(acc->r64), src_const = cnum64_is_const(src->r64);
 	/* A constant is its own base. Its step is 0: every number divides 0. */
@@ -18609,7 +18597,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 					mark_reg_unknown(env, regs,
 							 insn->dst_reg);
 				}
-				zext_32_to_64(dst_reg);
+				scalar_zext32(scalar_of(dst_reg));
 				reg_bounds_sync(dst_reg);
 			}
 		} else {
@@ -19489,9 +19477,7 @@ static bool recompute_ptr(struct bpf_verifier_env *env, struct bpf_reg_state *ds
 	    !bpf_is_widenable_reg_type(ptr_reg))
 		return false;
 	__mark_reg32_unbounded(&sum);
-	scalar_step_add(&sum, ptr_reg, off_reg);
-	sum.r64 = cnum64_add(ptr_reg->r64, off_reg->r64);
-	sum.var_off = tnum_add(ptr_reg->var_off, off_reg->var_off);
+	scalar_add(scalar_of(&sum), scalar_of(&sum), scalar_of(off_reg));
 	reg_bounds_sync(&sum);
 	if (reg_is_empty(&sum) || const_tnum_range_mismatch(&sum) ||
 	    const_tnum_range_mismatch_32(&sum))
-- 
2.55.0

