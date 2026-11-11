Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374188;
	b=xqmojGmZF/0+XpXEd9U7pNMOVhV4OKcgfXKT4yHGeStnVhuX6WJCvTnKNfXcK9yRxHoD
	 pa2+v3YLvNW7u7t2H4ItZ320JBKpxkQbYhlwkQr+ivrhvrHEglzaaHSdZwSj0QnXq6lX5
	 t4YU7ASBlYVu4MoeA39NFz+ToSF5C4xBnUVKb2DBBHoF2PQXu6xP65V40cpHjTeusGCYs
	 Onx1vmmBYyT3SuMFQizdNFC4VEiCwX6ZQetJATRKm6bqhTc5wKNVGkzqbVFW/0Sh7/oX2
	 xyGaN279qFlAZTENeJunuyoDE6LJ5vsk3lyqT7oYGty15ycXwBdX7dR4FsU4rCPTFOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Zx06yrQ/Lhtxp8BNtSWBpja/YxxMhH8doRDKJe5Y8Og=;
	b=2vt9OyvCmdMktiSqX6/klYNBX/u00fND1qvsX0/OCQNM5+sItlIYHQLs5Nm8dR66D7tq
	 qvSI/6Owp5+icykcMM089wRUido860qsVucMGZbpzJstmDIWEJbSObKge8PmM462crzj/
	 /btiDZB7c2msYD5x5/lk7j27D7ZsUzuVn/uAzRVNhd5OAtdBFKvPzyoNb/DGHvuRcH6q0
	 KMj86g0LnMTXcI6XXLS7MPcP2r0N20DBuvYZOIsUFqBZUkiokw/GhCcypbz4oRe1Y/Ddz
	 di09EaH4TWibVj1Q2McD1J28Tmkf3HSVKjHUnDOouc57wco4MC2nD/x9mTCXGpgVmfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KpSIGOoL;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC887606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 05:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC887606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KpSIGOoL
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e95bd1c14cso25427375ad.2
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 21:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794374187; x=1794978987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zx06yrQ/Lhtxp8BNtSWBpja/YxxMhH8doRDKJe5Y8Og=;
        b=KpSIGOoLTxk/si7HNBQ+XvdcH6jLk6WHRBT6ND/i0jEqdOF1kBpRaLUV3++CG4yAjP
         sp69AeHwN3tupYc8mQdQ3JjhhEJlD0hkLwXZ0cHDestM/1mUZddo8hL6/Z2NvK0TWqyO
         yxCR2Hniij2ZiLcHwLVXJMdXg9nL9S3HW/zsBbenMSGtS5C21K8YTi/5akLhRXz1jbFH
         ULF1WZcHERu8SByM0xLFVZqVI+TjToj2kL7mzQuAvatrY5cqPe4124ClAmuqJZpTAOaL
         qcWAsTx3dG/QiIYmFNbwDgQYUOWoYb3BCpXn4S4s9Ln0EyWezFNqt7U5Y5zhtejV/5Gr
         /f3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374187; x=1794978987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zx06yrQ/Lhtxp8BNtSWBpja/YxxMhH8doRDKJe5Y8Og=;
        b=QV0J/lK60CDnKFPmB4HcOFnFd2aKNF5CAJNUwCwIXZa39hlm/E6w8/Z/LFXepUv+No
         mDD2CvBjgamFnjRRKRBpvhov0aCqGqxcizh6jEG1/JmaZtJwkzD9YeG+HApRacg7i0N1
         wsXG3Zgd+KdFdnjPYRozlt7WWJcJYn3grLNZOvfWhRBbUmtJN/Ztrd4k5GWPnkpdZzPK
         PRFt5Q/hq3nZHkFvH6EJFHH4O8Z+xeO5vQ0nxWtplrTE9FtyJR/IGMAbnXkU7Ly3be0h
         Mq10+gEgrnauuMJjH3r89lApJ5nY7VcH2yAI4pnhT9WCpnYmpTOsWLPPSNtbMaLjIkoQ
         YjzQ==
X-Gm-Message-State: APuU4Z8eLaHebQ65qCXpJt75Rv0lzU8bvxsjhyHE+gvknFxAF/E97uTo
	eGWyeUNb7DR8I8xSAWx7AtlpmWNCfvzvcIJUo79A0dt0qE2sqSeOanf3Z5vKEQ==
X-Gm-Gg: AYBFou3MFhoUGqpuQtjXMEbnzfQl7s2+ju49mzxn++pbZHDiKCpx9zRx45AJIvusmeL
	5avuVYsK48Ahw9LksIlqLSQfqV7o1iQT5V2CkQj3tOdJY4U4iEs6dBmb4jR8zSRi7QjdNBS8Q2b
	zjH2MQ+QiROvI8V3ydfoUItOKyuk0zY/U0FXEe0GLaVk/ABnbqj3WaygfKXMgXraLD1NYOKsLvd
	B/78EZwGBPPcH1tNgGR1JoHOpXQ+pzJ+g3vB2LefmvB1yxbNJcOZb8ETmQFslxrTD7YjNoJMpHM
	1fuiC5ljkU8k1ycRhlllnovgC9WbpxMCFtO85KkhFl+S/mKuoxO4Vhwj/JY9IkYDidRPq/a1ZmF
	UEOW87MqLhCzFRoHXlcVfCx5ilxF8UPF8zhYVcR3NLK5761J3ONMLaCn4IEexJsoiL2h8j5GvG1
	/IqmpPtDImUYJ9KS9+z330ftk9Fhx3lu8IFlewjVSIv5Kx7Zd8kkL0ie6+YNxjEhiAMgKPxKrA3
	kL5FnhVgaw1cmd7fxiDuEYv8Zru6h95AM09rpssgT+dM82+gJhG2o9r/2mj1Z8y1ClUnEZxgbIc
	Zo8o/Pyoxr+qStZheFOJV2J3AHpvrr/8e89Bu3KMWTOuHIlkYURIkWQMXfi/HGZjKumJNJJIjuY
	Ah3wg73jwJ1lcnhTn+Np5zEZqfmx4Wo0SX5XtK8HYBHsSz23sNaGSJrhI+vmX7xpOQnxEyLHveg
	==
X-Received: by 2002:a17:90b:37cb:b0:39e:6d82:dca with SMTP id 98e67ed59e1d1-3b182eda92emr1378153a91.30.1794374187021;
        Tue, 10 Nov 2026 21:16:27 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db321dfsm2750688a91.5.2026.11.10.21.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 21:16:26 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 27/29] bpf: Remove scalar ids from the log and from bpf_verifier.h
Date: Wed, 11 Nov 2026 05:13:38 +0000
Message-ID: <20261111051341.2800252-28-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
References: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
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

