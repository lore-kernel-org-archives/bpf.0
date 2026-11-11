Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374182;
	b=fUVrcZQ+X85tFqOjgAgV61XWBQvykXxNcrpoE3McMSe+gXPUqWsYy7dC//7gAlZTXbcd
	 lOBhCPJMjMl7uacJ5yX9qO2XY1fi3Y/y+In79ARiyzc/hSdvRGb9B5LiYw44ww0jB7jWG
	 +Kt+ICxKj167NOKqMZV6s9zAfxaOjmY7DB/5TlmqhxCrNYIYtZxt8p2Sgigi9AfFmrDca
	 R9RSHVyfzauaXD72cBSePFvbZPvkmFKQQ4BNbBsBMfiCOiF5GtdeavQiFjp6Q7R8hwO/D
	 EZxgiQy/e5Mi0Pfafw369IpfGXegTEBYQ7CJJDdU9sewYyCkUTJ/Fg2/r8Unm9bjFEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374182;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CQJbqIBrSK1uzdi9/oqocDydKd1KKZnHFLuOurGyzP8=;
	b=1OsCbouUjvArPQgcfLLbdoDemV1+osHVCg/r7QT5L4fiaF4kQZoKgsTNHo7/AQYmjkXp
	 jc3RvMtej23vFm+S7y1HkLkPdGGnUXVe/fGd4LOR9o0EI5zq4VjB7AcgURq1xB5dKntKN
	 vKKTyqVb2djZyDqMXAziO3ULMeNxz4k0Ux/CuguGj0qA3zbfGTNCqJ8+IEZ5be6R9f6sl
	 vvpzKz3sWH50xjLJw5CmYrsX3OZw4cQEbdqGK+Jmz0ufpsdSB5nl3w+Z7DfUmfJkkCgij
	 yF3GLtriu+daHXJ46vunszo6QMDeJv5Yk3xjGUV5gOUP5zXQk19xQaoz5yrsfskWNBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OALHJVjj;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C59606A320
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 05:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9C59606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OALHJVjj
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so1115556a12.3
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 21:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794374181; x=1794978981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CQJbqIBrSK1uzdi9/oqocDydKd1KKZnHFLuOurGyzP8=;
        b=OALHJVjjFk26rTiQhLt2dec6KJX1HCSmESqtOoS2BKy3xGLDvzEhrZErEqI6iMYZi1
         F55ytFyMbcpEOco4e/bsCsNDvkLdlO27zeSsgjakg0ANF9BnxQMR/8n0tLHYqaSNYXJa
         b7p0wu7eo3H+80ll75vQ+BP8zDChclXJTOUcXQkXG7kHkAcVTyvBcupRkg2SjNjj9BCD
         8HcvHvxZahDeucCN2vtsQDGcduDfnWjRy/+yr/4WxOmGl8QsQWHtk0/PhBCj/wCB+ab2
         M+c3zjk2jtJ3jT8xoLr6uHcldeC62N04MALeHSFb0AZIjwS15AhJwVuTfp4RygI3z0+J
         3O8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374181; x=1794978981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CQJbqIBrSK1uzdi9/oqocDydKd1KKZnHFLuOurGyzP8=;
        b=XILP/OsFTRprLRP3q+BHAU5jipQeW0s8fac7KsQJtc1xclBEc337fqSYfqQ+O0kW4g
         WFX99CLvuu2sOhOl5atFE/cixm7aYP0x4QtLUxSR27fpBtoqmsiUUgwrzYpPJuSATPZ+
         e9LbGJjSNwuP8AdRQpIFXbREoOhOoBU/g0UGIVbIf8yENcdO3xQxPbcPFUCbIo2i1uaO
         jEpb+ZtKYBAJSa5X/Uoj5quJBgE5DifqpjCPVlwIXzzZTAh/Ohd2lM0P0MtEid2ozLQD
         n2pJpsPOXOkwYGfczUyCnmmPlxRwhhktY2YlaGiL/9gSkGCASXqA4NczFOEbblvXiQlg
         MNkw==
X-Gm-Message-State: APuU4Z/cXWbHMtJZ7U14Gj5oq7+SjzBXCi5sR7Az2JUoA8l3FfytFRQA
	+ryIMdp1KHcnZzCE03CKYDZ6eTaFyY2aw2I9n90iz5MjaqKLAeQ6vjf7EbDxRw==
X-Gm-Gg: AYBFou1Az6pn0mvxasxxCB3RxhhEODfODhgbmmtALNJz+pXI1DIBvtv3ypGGsgXnzpb
	9VIvbWDuURSoqXUA6m7CFz4iCxgkPyileW0M/r4zBZm3kHINm90xAK/ugaDEyNO9in8ggqqDc1x
	qS3BFRAksxcCOdkQJxxxwsGwSvBcOX9T+2L1u62jhC0OQBJ5wBuCUvcS1Iaf2B05jzuFDoTc6hz
	SCGy2NQgaeW+wLJm/cyFuTC4bUFV7ScKZcnn3BN6F9zrd25lngFKPYOXcH/LNOljInQWPtZBLtq
	5m6Bko1CsTOMiwJdbAx6cR2MwMX2XQ7QjCN1mbzt2MwAqSbuSMkt2EAfJriC+Cd+SLGg3ME3UvO
	Au5R1vuJDe/L2YOdCpTbkn4CR/R9JB4D7+9msxkeuwjNaAag5QN0L+ShjDYye8qrXNfp1nnJ78l
	XiK5hwnHklgudkJnIVD5JVGpSyra970dggC0u/K2A3HVH9ZCyXNPMgqIlzPn9IXonnIKvRZyn6A
	j9vlj0T8wH/FYpBTlioPfKBFRYKisL0WabM7bQA0vK/kb63yDQb/oBDWOM970b1z4dq5OY5S4FS
	zIAhXlxHJRyzL6xCrwoAUGBIvfiDEKzQ75DBx/zNR/o4W65j8hr5NDeg5+yKNtTmrIvbUoaN4W5
	n+xRLeDryF0j4E2n9kiuzGnxmkT1Uzu4dYmeVaDtLbTzrCQt4Qa6ceS+AFjAv9+av7hGGaQUQoe
	8=
X-Received: by 2002:a17:90b:4b84:b0:3ac:fe93:a731 with SMTP id 98e67ed59e1d1-3b182f9d622mr1256989a91.56.1794374181220;
        Tue, 10 Nov 2026 21:16:21 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17dba5ed0sm2710858a91.17.2026.11.10.21.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 21:16:20 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 26/29] bpf: Remove scalar ids from the join of states
Date: Wed, 11 Nov 2026 05:13:37 +0000
Message-ID: <20261111051341.2800252-27-alexei.starovoitov@gmail.com>
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

