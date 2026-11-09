Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206980;
	b=v4mT4s6vhkmsJeUB0m8fUCnJbUVT0esFWhHtogSNd6Q0rzaltVjhnE3LCVFc55IRs2ri
	 gbZjS2XbWBY38Iu1zuwXdFhBZ0iF0oJWsIRF5aQ/0y2Yos4DObjHWubo3K+H52Ac/3CPx
	 fc0fvz0jKGYlXmKOxz3tc7NFTEvuyIOUQmMsXSUIne6u8TV7/Q+psWqRF7c7/nZFd2h6R
	 Tc7za2WX65I1BeGJXBnMSUXfmkE7E4+ihTdAoh03rW5jsKEhn422SE8AoMPh7sdrivo0k
	 BD6NoquXg+SYWvvbO5nQH4B9PqTiokFkwc4O1uA40lpKtmqYo/eQBaK/+GWwb5sF7jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206980;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XYoflCT7X4A890yycUfEZyFTFXxvITts0kBCLSEDBYs=;
	b=kzI0SDhDHv0+Wv34RqhVe6DGctKQhk6Nj01KOZL8IqRR2OKyhULjnao9x3Piy7Sxk6Tg
	 bzHkNmqMqp/m/Ktgvm64/g3neXA11IjT2LMyiI1RITP1jPUV+B76xPADog2zRZve4IBAy
	 kDMqvcM45iDoxYRPP470/I/h73ai2IL6kGksVBDaxenyHEuAHXczu38oPi8BY6HGWL5oJ
	 NVhBgtyLzzxy+BUC5VhTsOOZgNk/ZIzKtyoml0XaOuTb72YeW6w6b/fLUeqQJcet5LYZM
	 CVFKYxg8zQrPIgWnJqq+DEynzVsCS4KJYqNgF1YJiEfKavf0a21h7O3myHEU7C6u1og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oyk4mkNg;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C979F606A321
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 06:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C979F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oyk4mkNg
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8b58d6f67a5so251785b3a.2
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 22:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794206979; x=1794811779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XYoflCT7X4A890yycUfEZyFTFXxvITts0kBCLSEDBYs=;
        b=oyk4mkNghmdq4RG+C19AD7bP8XFTqJ50bjxzBcoHvpDcpAaHMnx1l140qliJswMc1H
         ST3Gw+57cPBfzF0FvmV3DiTqUBbCF1P2YYyLGh+nQDcKm0ZaMY8OCslT4TvOn9zaC/4k
         MPUvw7r7IuHLRtJYtCX0dnZWLRTqDnWPZCTwxj/8dLog+LMqq3WLrQBTQFACp/bRzXcP
         NqM2IAANxyugdBTdNlgkt6imzI5alUlzqruEoxAP7lVFy0EsthipcjgsiSlhggoFkbXS
         q6SPGzw9gOi5N6ungsX7So/aAHVtnM0SzEitQUjdH+Nq+R3ABztand6voO/M/yZpBr/W
         UT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794206979; x=1794811779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XYoflCT7X4A890yycUfEZyFTFXxvITts0kBCLSEDBYs=;
        b=d1Ujc8PplFju9sOzjQ8Dzs4ybFuf73gWgVraHGOOaHSjuRkmF05jZwyixjvXRaLkiQ
         OV6QQcCZ5HMEeIX0tMjM+vPf95kOV3+uTXvzlmPCRyuKTIeN5tuTJDDenODbOERb8PHa
         M6tViD18bIR4rv4sYcomX0Kyzg6Qa53eVhH9vp1pd9HXKIQ5wyEKo22rFfi+bUTs6lAT
         hlCMNrjAzppgJBYmG7feJzFE2gfhZsMGH76VbN2GAjr6rlayFeORjGAAFJVtjtV2WfFu
         7VgXj5vzWwgkJnEqaULr6vJCqUaYZ8+y+6Uk7WHvwQ1j+PGwKdjyxt2r3/Ux5X4MkBp+
         vhlQ==
X-Gm-Message-State: APuU4Z9ajHeylNBrPAkDFRcCVskzyRenp/zowPlAsnXLTas+nG2gmVxZ
	Ae/M17+F8iD2xnwjEjEVPg+5TNO20lC9lgwWVBqcc+QA8NBpx5dtH6/BaX10aQ==
X-Gm-Gg: AYBFou17nmvp4GlLgHAfui4eBB4fUdJD6Qp0xZGnELptoirHza80pzGQaZsUHpjl38p
	npwtBNEFF/wRK3Eq7j60duUObuDml/W9de1DMvBM3wu4CuTWGwbt6b4Js1uM+YXFvGwGmQQrmC/
	o6cl+DCz8pdodsfqtw60cEuV2N+t8doQbGK3tBV+A3BXRiqpXSmEZmlfxB+p8lI4gbMlF36PnnX
	OLAOqbOErBzkr4yzVmAn5lbnGV17+OtzimC4pIl3XIQ2Dvs6tKAu9l+l6aHHVngzrUrIXtl0x8r
	/DFyw9o5ksKHYxrH3J6eKjK6jiFoJ8E4g4/sRUKqxOUvG/HTIBaGqzk1DcAiECLsN0/DwqwgcZw
	zrNrLjTh1cKe8ExmsF9Dc9ghwSpoyjL9zCeUiOPKJz7h2B4Zal54bDMNAzVHvopJAIPD5Ra0QkM
	74hbINvdxpJmOv4Q9kTFRjqUGKohYzhF3zuBp9+TWHoy4WFyJf5YpnAM943PdrtRqH9gFiZ/EuW
	XoOnlR7qfuuUcvQvKbF0pJA1WVbtI6fO/kM33aEdIsMJGDgJ4PbpkFGCtcuIFyYsyoKjRGK+jFL
	ZsqYGL4Ve84iz5t7hgTW1x1uc5GaMuH3wAEs+NVZKbl9Rtfpd70xOpbuA+XHnWPg7YtGmoJT5/B
	B74U+SSAK9oebmndnUgFGCeee2beCB1pCqQr569ve4WRuSNHtsL1wzgssEkUmqqzpSYQe53diNQ
	==
X-Received: by 2002:a17:90b:4d07:b0:3ae:2969:903f with SMTP id 98e67ed59e1d1-3b12d488d5emr3071738a91.45.1794206979133;
        Sun, 08 Nov 2026 22:49:39 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1278918f4sm5619960a91.6.2026.11.08.22.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:49:38 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 24/26] bpf: Remove scalar ids from the log and from bpf_verifier.h
Date: Mon,  9 Nov 2026 06:47:08 +0000
Message-ID: <20261109064715.2382452-25-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
References: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
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
index 651174144f5f..cee25ec87403 100644
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

