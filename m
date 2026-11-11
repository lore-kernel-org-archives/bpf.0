Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415717;
	b=gnyTDX3KrUp/ff1YTVckJzPAMvM1rl5JzB7r/S40vedVw3Ovhayd91PGYx8JDmuWTkA4
	 apSHJnZlHuz1rl2pRP8fttjvKcS7CWVMmWQOdhmMYnKrjCrCDqwM02X+/aDQDQg0VNFZC
	 Qg8pjw+EbAzNl1m2fIg6LNzUsZ7CX/hzQaPJsKZR78kVEKfYqABvFmai5milKFPNPS/9r
	 cdR9pfanKU/OON7L5kJiEn/X88yRu+uza41nARd66Z+HtnuXNFAaIyV+00iZFQFRSho/U
	 k8DlYnpWrEpNOWHM2ihjvQw8bf4I1jQ/PA6NT8vtdIFg3brT60tVitEhiYXkFjGE7WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415717;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CQJbqIBrSK1uzdi9/oqocDydKd1KKZnHFLuOurGyzP8=;
	b=daHJVx0K1QzBo6nrlrNgswnFRnsqwCEnRsuYU+6V4GilxYvMlZ16koDKjMJ/ySpV2S0C
	 wAplekbXLrHzVzY4r5lKztusYKzBy4PeK5GQKn7LgO39rgidrEL0ebSSBy+kBuQnzyV8P
	 4lEpkj2XWTng+/CUY5T9W4Za3YsDYJZxyQn8dcH3JUAvP/oN/1bqHMc8HlIHUz7qcyMtj
	 /1LthjSQ3ngznabaZO6+/y0ATsQjEbzPGeh5yep5zCeM8QicG4/dkyabKkrijIl7g8DHz
	 SzTTSoK4UnYEIkvMmmRiJ6EKJv/tVPequnZ/J48JQ3lphw8o8fVe1imQSld5qWRQwEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mWoy1Oyk;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AFB606A33B
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5AFB606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mWoy1Oyk
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b197cd42b0so9587a91.2
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415716; x=1795020516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CQJbqIBrSK1uzdi9/oqocDydKd1KKZnHFLuOurGyzP8=;
        b=mWoy1OykTwY/6CfCwFn2hsbFeuDV42nUicvRbWyfeaHweE3hqwAy2eT9pplvTZt0gd
         cXWRgoRtSQPJeliovJWzjD1EGE2dMrp/rRF6jxm3zMsA9uI1mnZVN3Mb75CufrP0g7Ac
         Zg4MSkBOH8gIoUriThHJ0+70Wkq7rcZXvrS2yGgdtyNQy1GgSVu55X6SQkKvw4zoXJ5g
         QHxjGh83qFp3/sgYfGtDPtSwEjV0cs5RyG+4/tqPS7oFUofP4CjIn+COR0hvMLYA5JJ+
         jz1i9hiqxv2264otxkBjqyAsEW12BNfXbWp10UFCaS2slVADAyqtT2e25heVXxeEgtYv
         cNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415716; x=1795020516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CQJbqIBrSK1uzdi9/oqocDydKd1KKZnHFLuOurGyzP8=;
        b=FqQO/HcyQ6flYEYd6Lw0tADin9xznV4eLf5LSfyD6RFb6Y7/6kam7iK1GdatvDmN6J
         2/tbbNo5klx6xuBqEo66Xpwl48h0QJo0CnUhRk0grVPF8+5ZKKWSdatLfmAjENez7ck2
         57YOe9t8zWwEGRy7l6fXsiGFVHfCCAS+X3CAD9DZ9DRn1312eipDvQl3vorHaF+P9wFo
         BAaXhk44MP3mQFQFvuvbQgsp0jsieTrQUcdUxg6ECN27ZIilKlHSR5sPW2cdFeocELmk
         suclrIKLobyQFpaiHWqse8l+gS5UKidm48UMt90DZ6N8FOtYh36mEuJ4hDYIxwos7LMY
         WLRQ==
X-Gm-Message-State: APuU4Z+nexgtFWsnlZzrLKXIqtxnXr3s7G0X1SXjo+kmxp6/6gfxXLpy
	7pFLjrZnyyFvX97onXaBBNosL2uaZ0PtUCO2HVWWajX2xuKQy806qfyoaEhs3g==
X-Gm-Gg: AYBFou0d6pPIk1m++WPo8g/vRB3rM3bZDEshqKmGxj2Sa8K3xq571udLk8weBkCySIq
	9JiFXBdYiVmrmC5L5eSvjkYfOeYh/CuCzte+ju2YS404QMUbO5DXkGX/3zuDKeRNtUn2PS6ESlr
	V93kTeNc34KH0HWdh6wVCqNWKv3IkJwheupqROJiYYutLwBMlQww5Q1z7oF7zeLaHmpQ5iW3HcK
	SEgcuADTYSDkOhDczKsQVp2JmTLA5Xuc8mfun4JyyWplaT0/aTJoGT4CYQmvcOPlzCgW4C20zpn
	vDSK0xKZDqsPAV0ksiOGBWMotroOWGV7SPST2RwWEnf+fg5GNiwBd+nBKESdt1vmcsKPD/Yz20D
	pzU+P3kFb0ChMIQe4k6gsO5JNH9wVa/vF5UM2AmUiclyXRuPT5TLp8VbwrpifTDfgzBIHVoIsiw
	w+HdDJMKQ/4tOrRbiun01n5gSXwhnYihfYhLcBkq8cHUc578+/OnsnYxA9v/2vubwCXDk+5h14+
	JbmcUoQTBJv8xHCfLaxDZWLSPT1Lc0JFvUMaGxfNhd2IZbVpPuXGW/+3BpFD6N6qKnIAMNZUFFu
	7mFApkREf+c5qp1crxX3udjVdEXMxzNRbv8kmhkKbr3HbwfM43oUhb8CMbcw3oweDHuyDgN51Pc
	oE34BlypchLIa9AIHKeI/4RSD679usnt+7ou0H2esk/pAoD9Z3fedgDywRGblv/6Y8nNo85xJGA
	==
X-Received: by 2002:a17:90b:4ac3:b0:3ac:8ee5:e007 with SMTP id 98e67ed59e1d1-3b182eabff1mr2672328a91.20.1794415715699;
        Wed, 11 Nov 2026 08:48:35 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c74bf3sm69845a91.10.2026.11.11.08.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:48:35 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 26/29] bpf: Remove scalar ids from the join of states
Date: Wed, 11 Nov 2026 16:45:49 +0000
Message-ID: <20261111164557.2659679-27-alexei.starovoitov@gmail.com>
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

Removal of dead code, as in regsafe(). Scalars have no ids any more. No
prog is verified differently.

Two states are joined in two passes. The first one records which id of one
state goes with which id of the other: jid_note(). The second one computes
the registers. A scalar kept its id only if the pair was good: the
registers that share the id in one state share it in the other one, with
the same BPF_ADD_CONST and delta, see scalar_link_consistent(). A link
that one state did not have was dropped.

Now the join of two scalars is the join of their ranges. Remove
scalar_link_consistent() and the scalars from jid_note() and jid_good().
All other callers of jid_note() pass true for 'consistent': the parameter
goes.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/join.c | 54 ++++++++++++++---------------------------------
 1 file changed, 16 insertions(+), 38 deletions(-)

diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
index cc4494aef187..2b8c94b7dc50 100644
--- a/kernel/bpf/join.c
+++ b/kernel/bpf/join.c
@@ -75,18 +75,16 @@ static void jid_mark_bad(struct bpf_join_state *js, u32 a, u32 b)
 			js->pairs[i].bad = true;
 }
 
-static void jid_note(struct bpf_join_state *js, u32 ida, u32 idb, bool consistent)
+static void jid_note(struct bpf_join_state *js, u32 a, u32 b)
 {
-	u32 a = ida & ~BPF_ADD_CONST, b = idb & ~BPF_ADD_CONST;
+	bool consistent, other = false;
 	struct join_idpair *p;
-	bool other = false;
 	u32 i;
 
 	if (!a || !b)
 		return;
 	/* a name of what the caller has, see BPF_INHERITED_ID */
-	if (a != b && (a | b) >= BPF_INHERITED_ID)
-		consistent = false;
+	consistent = a == b || (a | b) < BPF_INHERITED_ID;
 	for (i = 0; i < js->npairs; i++) {
 		p = &js->pairs[i];
 		if (p->a == a && p->b == b) {
@@ -111,15 +109,12 @@ static void jid_note(struct bpf_join_state *js, u32 ida, u32 idb, bool consisten
 	p->bad = !consistent;
 }
 
-static bool jid_good(struct bpf_join_state *js, u32 ida, u32 idb)
+static bool jid_good(struct bpf_join_state *js, u32 a, u32 b)
 {
-	u32 a = ida & ~BPF_ADD_CONST, b = idb & ~BPF_ADD_CONST;
 	u32 i;
 
 	if (!a || !b || js->pairs_overflow)
 		return false;
-	if ((ida ^ idb) & BPF_ADD_CONST)
-		return false;
 	for (i = 0; i < js->npairs; i++)
 		if (js->pairs[i].a == a && js->pairs[i].b == b)
 			return !js->pairs[i].bad;
@@ -199,15 +194,6 @@ static bool reg_value_equal(const struct bpf_reg_state *ra, const struct bpf_reg
 	return !memcmp(ra, rb, offsetof(struct bpf_reg_state, id));
 }
 
-static bool scalar_link_consistent(const struct bpf_reg_state *ra, const struct bpf_reg_state *rb)
-{
-	if ((ra->id ^ rb->id) & BPF_ADD_CONST)
-		return false;
-	if ((ra->id & BPF_ADD_CONST) && ra->delta != rb->delta)
-		return false;
-	return true;
-}
-
 /*
  * Join two registers, regsafe() documents what each type needs.
  * Pass 1 records id pairs, pass 2 computes @dst, which is a copy of @ra on entry.
@@ -229,16 +215,8 @@ static bool join_reg(struct bpf_join_state *js, struct bpf_reg_state *dst,
 	case SCALAR_VALUE:
 		if (js->env->explore_alu_limits && !reg_value_equal(ra, rb))
 			return false;
-		if (pass == 1) {
-			jid_note(js, ra->id, rb->id, scalar_link_consistent(ra, rb));
-			return true;
-		}
-		join_range(js, dst, ra, rb);
-		/* a link that exists on one side only is dropped */
-		if (ra->id && !jid_good(js, ra->id, rb->id)) {
-			dst->id = 0;
-			dst->delta = 0;
-		}
+		if (pass == 2)
+			join_range(js, dst, ra, rb);
 		return true;
 	case PTR_TO_MAP_KEY:
 	case PTR_TO_MAP_VALUE:
@@ -269,7 +247,7 @@ static bool join_reg(struct bpf_join_state *js, struct bpf_reg_state *dst,
 		if (ra->r64.base != rb->r64.base)
 			return false;
 		if (pass == 1) {
-			jid_note(js, ra->id, rb->id, true);
+			jid_note(js, ra->id, rb->id);
 			return true;
 		}
 		if (!jid_strict_ok(js, ra->id, rb->id))
@@ -291,9 +269,9 @@ static bool join_reg(struct bpf_join_state *js, struct bpf_reg_state *dst,
 	}
 
 	if (pass == 1) {
-		jid_note(js, ra->id, rb->id, true);
-		jid_note(js, ra->parent_id, rb->parent_id, true);
-		jid_note(js, ra->map_uid, rb->map_uid, true);
+		jid_note(js, ra->id, rb->id);
+		jid_note(js, ra->parent_id, rb->parent_id);
+		jid_note(js, ra->map_uid, rb->map_uid);
 		return true;
 	}
 	if (!jid_strict_ok(js, ra->id, rb->id) ||
@@ -350,8 +328,8 @@ static bool join_special_slot(struct bpf_join_state *js, const struct bpf_stack_
 		break;
 	}
 	if (pass == 1) {
-		jid_note(js, ra->id, rb->id, true);
-		jid_note(js, ra->parent_id, rb->parent_id, true);
+		jid_note(js, ra->id, rb->id);
+		jid_note(js, ra->parent_id, rb->parent_id);
 		return true;
 	}
 	return jid_strict_ok(js, ra->id, rb->id) &&
@@ -563,12 +541,12 @@ static void join_refs_note(struct bpf_join_state *js, const struct bpf_verifier_
 {
 	int i;
 
-	jid_note(js, a->active_irq_id, b->active_irq_id, true);
-	jid_note(js, a->active_lock_id, b->active_lock_id, true);
+	jid_note(js, a->active_irq_id, b->active_irq_id);
+	jid_note(js, a->active_lock_id, b->active_lock_id);
 	for (i = 0; i < a->acquired_refs; i++) {
-		jid_note(js, a->refs[i].id, b->refs[i].id, true);
+		jid_note(js, a->refs[i].id, b->refs[i].id);
 		if (a->refs[i].type == REF_TYPE_PTR)
-			jid_note(js, a->refs[i].parent_id, b->refs[i].parent_id, true);
+			jid_note(js, a->refs[i].parent_id, b->refs[i].parent_id);
 	}
 }
 
-- 
2.55.0

