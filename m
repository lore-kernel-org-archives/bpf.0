Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415722;
	b=I2ec9EYxQsdsjF3ZiRe+iUX8hd1D+2idKT83gDZ/S5HwDGh0fIPFPv/PQ7PRrSMkAItp
	 US4T/tbyDE766sNw1cILJWYtEy49G5voUyvBWfscoOGcmI17KLMhauIwf25r0lqkcf9JY
	 dPMDQ9j1YY3+v7lfnfVuzRw0vUgMLHXDzuEsOQ6V/vFdUY8Xz/ZYBAfy05OS8rjt9ws4A
	 hzqicqkmDrOrf4Ju27Ti5ejhX8XWWEketDSWXmx7eG+zsHNvqCO3tSwQoFAbCrPZ9h3Qs
	 +xBlMYvq12kBnc4tWDgU7LBOhreGCbxyIq5nsfFo88cKMT3gJHc2L1JYZ1V88zdxSqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Zx06yrQ/Lhtxp8BNtSWBpja/YxxMhH8doRDKJe5Y8Og=;
	b=PWOwpTkx72EAKYThHeNhNGoMUBpaFiHeuSj81W2XrEv9EzkAMRRqhN563ZQBjKI+d0n9
	 ZR3pV56MnSF/t7lssDPK5hrpy7MhKFQbkj4gxqpILdLpoB/7Zu30uxNSgDHoHrDP3chsD
	 KELYqAZEXaXKOZlDTHMKzmW+xm/nhsNWCLko/2tYxj0edDAk/2lD7kCr7kLX0pqBgTxXI
	 3ycQGrohifUJBTAN3z2Ga37G72M90DYuHD9IENMYV7n30fony4zWJCYju4ojK8/6YHEjM
	 17GQcHAF5P1Wf5ZLJCaGpek4GofgBXLSMY8CDyeLt/7GFyn6Of2N8Sdg/WB0WnJGDsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xKjQlXWe;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F060606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F060606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xKjQlXWe
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b0b3754f57so1964870a91.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415722; x=1795020522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zx06yrQ/Lhtxp8BNtSWBpja/YxxMhH8doRDKJe5Y8Og=;
        b=xKjQlXWe0mUUL+6cHak0RVvcZLbhx5ORR/QZCQhKTM7/CVyneC2tqqBnt4Bs4sb6qz
         eY0OXMLCNtnye/70o0OPPMk7xA0j09/b6ZTccMyWpf8ZmlelJxRQlow852RCo+3wcl7C
         DKZQFMCahc5h9ENb3+o+mkS39qtW3dJLzIb/52KD3id53xnfDJQMzcWLPnUg10SuEZRW
         fYV7HKPavRA09LXHxOpYNoPARjEy07jiLXCtZMs7Flz6Q1NVP1cEjmYP8ixvkC9DNJb9
         E9vT0h71+jTxApu2tbB5xg8sho+L+lmBa1ZYXYpcAtH7qWLJm7VYqW7BkUutp4xql/18
         8cpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415722; x=1795020522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zx06yrQ/Lhtxp8BNtSWBpja/YxxMhH8doRDKJe5Y8Og=;
        b=GEempAGcaHumka1vdMbDd1L2qd01wsG5CSSEz402nKRVSgCqB7fUEfdJbDKAaVkqif
         9bJStn5iKbTaZMqL0o7B9K0RrbQkXeyctemqZ2BLu1H+1X3EklwJdBxH3iMBjeatKP43
         c1Xcdzqopy0QymZc6XC+7PPfo+SrLwiEWCDMVaytSmThV+JDmhmZbXIv9DmmjkAfGKwu
         3jkZHgN4MOdsIMC6O8emztFZ5842KIiBvoqto7DyEeXVdZJimIRzVIDMw9bWnuZTUjqh
         sarrfSDhXt7Kz5AhD/xSiljadJcrgQi9Zig0qRs0ghEbskE/tdBCR/X+rTNcjQN9A/m3
         oQ3w==
X-Gm-Message-State: APuU4Z8lZrp89vzy+pNMztWJUU9yrocwHgdQnZ9nWQZENyK0VxJi4pXr
	b1pTneTjTo1LvduAaE2QbtfaikUttNIsgIq7MWVZXiPi2UOiav6MyhuyrPeEXw==
X-Gm-Gg: AYBFou1ffwIaHOMOHBJNc6puBoLO2wGkgaZ8SVo6GfTkX/Uo1Fo95QjlVqzVpoD+dlu
	6gYbd9PLVoa3uy+F8RGP2u4Bzjg/UfwYNudpLpLtcsP6YoWpiiI3UTfhKG0OAUeot/578jX7ipa
	eL8V4dZCkncJLWZtsasIua5CLOLfjYjG9cEB6FDAUel1MDYqitRrWgoq8+7/Vui4YMIFKRr2eYi
	Jp5b9FxxJFHANocBHSNpTUm5YyhB2k684Bar+RYcNHdD3vMPsWWeHfKQoQV6NpGX4BFMEl6dgB/
	Xfr1nbXaUVvswvegTrFyYgQW4sxqTYObcn6ye4219W86H0OtUklNO/kmIhNp4dG3FPYfPQ8oq3J
	QYWkVB1qfwXxsbAi3M1/INZ5hjoaAa0osqc+54M/XLmABXWodSBUbQeZ1WkWoql9utnR0u/+0PT
	syhEGRUBnor49nu2rCIiiq2Zu8M7pSY8zJE5/vKJEjpRbzw5kI0Tqtl3gslI1kNuQc0aclqwGRs
	DMVtnFIaJJjCfPF0uRaq/vNFDBE1N4OqaFQqyobK4mSha9Yzc2QpVeDrUJSTwk6eWRQ2OUIRG8E
	twHmMjncmUtY8oSnY4OsN793ju8EEexbMyD3lcr1J4tY2+l9piIzTmyKWEnSvhhA+xNrbY7onK2
	bMkqqY8yBeeaJhm0UanrvUBHJk1y+3VyG2HcGeUE9/QcsXoOBCyBt0GAZN+/NIo8RMkLdg/UHnB
	Y=
X-Received: by 2002:a17:90b:4c82:b0:3ac:8446:c1a5 with SMTP id 98e67ed59e1d1-3b182f253e0mr2953890a91.48.1794415721645;
        Wed, 11 Nov 2026 08:48:41 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d35525sm18124a91.16.2026.11.11.08.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:48:41 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 27/29] bpf: Remove scalar ids from the log and from bpf_verifier.h
Date: Wed, 11 Nov 2026 16:45:50 +0000
Message-ID: <20261111164557.2659679-28-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
References: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
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

Removal of dead code, the rest of it. Nothing sets the id of a scalar. No
prog is verified differently, no line of a log changes.

Remove BPF_ADD_CONST*, what prints 'id=N+M', clear_scalar_id(), struct
bpf_idset, idset_scratch, tmp_id_gen and the declaration of
bpf_clear_singular_ids().

'delta' was the constant between two scalars with the same id. For
a pointer it is always 0, and log.c printed it for pointers only if it was
not. Its four bytes stay, as 'unused': they lie between 'type' and a union
that is aligned to 8 bytes, and regsafe() and the join compare the bytes
before var_off with memcmp(). Padding there has no defined content.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h | 46 +++++++-----------------------------
 kernel/bpf/log.c             | 10 ++------
 2 files changed, 10 insertions(+), 46 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5a6bb40310f2..e7bfb2bcd954 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -60,10 +60,8 @@ struct bpf_stack_range {
 struct bpf_reg_state {
 	/* Ordering of fields matters.  See regsafe() */
 	enum bpf_reg_type type;
-	/*
-	 * Constant delta between "linked" scalars with the same ID.
-	 */
-	s32 delta;
+	/* 0. regsafe() compares the bytes before var_off: there is no hole among them. */
+	u32 unused;
 	union {
 		/* valid when type == PTR_TO_PACKET */
 		int range;
@@ -179,18 +177,9 @@ struct bpf_reg_state {
 	 * the dynptr to determine proper reference freeing.
 	 * Similarly to dynptrs, we use ID to track "belonging" of a reference
 	 * to a specific instance of bpf_iter.
+	 * A scalar has no id. The scalars that it is linked to are static: computed before the
+	 * main pass, see bpf_scev_next_linked_reg().
 	 */
-	/*
-	 * Upper bit of ID is used to remember relationship between "linked"
-	 * registers. Example:
-	 * r1 = r2;    both will have r1->id == r2->id == N
-	 * r1 += 10;   r1->id == N | BPF_ADD_CONST and r1->delta == 10
-	 * r3 = r2;    both will have r3->id == r2->id == N
-	 * w3 += 10;   r3->id == N | BPF_ADD_CONST32 and r3->delta == 10
-	 */
-#define BPF_ADD_CONST64 (1U << 31)
-#define BPF_ADD_CONST32 (1U << 30)
-#define BPF_ADD_CONST (BPF_ADD_CONST64 | BPF_ADD_CONST32)
 	u32 id;
 	/*
 	 * Tracks the parent object this register was derived from.
@@ -1112,27 +1101,18 @@ struct bpf_id_pair {
  *   comes out for it, only if the same places have the same names.
  * - bpf_flow_return() puts the ids of the call that waits back. All other ids get new values.
  * - What comes out has the ranges of all calls that share the state at the entry. So a name is good
- *   for what holds whatever the ranges are: the same object. Other ids have no name: a number
- *   loses its id, any other argument keeps the frames of the caller, see arg_needs_caller().
- * - env->id_gen stays below BPF_MAX_ID. So no id is a name or has a bit of BPF_ADD_CONST.
+ *   for what holds whatever the ranges are: the same object. Other ids have no name: such an
+ *   argument keeps the frames of the caller, see arg_needs_caller().
+ * - env->id_gen stays below BPF_MAX_ID. So no id is a name.
  */
 #define BPF_INHERITED_ID	0x20000000
 #define BPF_MAX_ID		(BPF_INHERITED_ID / 2)
 
 struct bpf_idmap {
-	u32 tmp_id_gen;
 	u32 cnt;
 	struct bpf_id_pair map[BPF_ID_MAP_SIZE];
 };
 
-struct bpf_idset {
-	u32 num_ids;
-	struct {
-		u32 id;
-		u32 cnt;
-	} entries[BPF_ID_MAP_SIZE];
-};
-
 struct bpf_liveness;
 struct scev;
 
@@ -1278,10 +1258,7 @@ struct bpf_verifier_env {
 	 * via callx. Allocated when the first such edge is recorded.
 	 */
 	unsigned long *callx_edges;
-	union {
-		struct bpf_idmap idmap_scratch;
-		struct bpf_idset idset_scratch;
-	};
+	struct bpf_idmap idmap_scratch;
 	struct {
 		int *insn_state;
 		int *insn_stack;
@@ -1447,12 +1424,6 @@ void bpf_verbose_snum32(struct bpf_verifier_env *env, s32 num);
 		bpf_log(&env->log, "verifier bug: " fmt "\n", ##args);				\
 	})
 
-static inline void clear_scalar_id(struct bpf_reg_state *reg)
-{
-	reg->id = 0;
-	reg->delta = 0;
-}
-
 static inline void mark_calls_callback(struct bpf_verifier_env *env, int idx)
 {
 	env->insn_aux_data[idx].calls_callback = true;
@@ -1589,7 +1560,6 @@ void bpf_mark_reg_not_init(const struct bpf_verifier_env *env,
 void bpf_mark_reg_known_scalar(struct bpf_reg_state *reg, u64 imm);
 void bpf_mark_reg_unknown(struct bpf_reg_state *reg);
 int bpf_grow_stack_state(struct bpf_verifier_env *env, struct bpf_func_state *state, int size);
-void bpf_clear_singular_ids(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 
 static inline int bpf_get_spi(s32 off)
 {
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 84659a757b43..ffbec587a916 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -696,7 +696,7 @@ static void print_reg_state(struct bpf_verifier_env *env,
 		if (state->frameno != reg->frameno)
 			verbose(env, "[%d]", reg->frameno);
 		if (tnum_is_const(reg->var_off)) {
-			bpf_verbose_snum(env, reg->var_off.value + reg->delta);
+			bpf_verbose_snum(env, reg->var_off.value);
 			return;
 		}
 	}
@@ -704,9 +704,7 @@ static void print_reg_state(struct bpf_verifier_env *env,
 		verbose(env, "%s", btf_type_name(reg->btf, reg->btf_id));
 	verbose(env, "(");
 	if (reg->id)
-		verbose_a("id=%d", reg->id & ~BPF_ADD_CONST);
-	if (reg->id & BPF_ADD_CONST)
-		verbose(env, "%+d", reg->delta);
+		verbose_a("id=%d", reg->id);
 	if (reg->parent_id)
 		verbose_a("parent_id=%d", reg->parent_id);
 	if (type_is_non_owning_ref(reg->type))
@@ -720,10 +718,6 @@ static void print_reg_state(struct bpf_verifier_env *env,
 			  reg->map_ptr->key_size,
 			  reg->map_ptr->value_size);
 	}
-	if (t != SCALAR_VALUE && reg->delta) {
-		verbose_a("off=");
-		bpf_verbose_snum(env, reg->delta);
-	}
 	if (type_is_pkt_pointer(t)) {
 		verbose_a("r=");
 		verbose_unum(env, reg->range);
-- 
2.55.0

