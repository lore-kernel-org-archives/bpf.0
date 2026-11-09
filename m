Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206974;
	b=jThcE20WbPp7yEWiRnpRRHpuBVpN+jL16EEo6tlyBMjSZKjNpPMwxOEpFBokYwR5Lu5Z
	 B6T1BRdIgl/gC270x2QfcjF3F0YnXF0vxNYTdL+HLsO7e9odTjb550lvMNVINqgqJwrlx
	 VQ0/BuhbNmENNTXLoU4cMy0PHtWgoaa08/+JGd8uaJJtH96p4C2SMUjWdZIlIEWh4Pwe2
	 YvwGvYL/qJge6Pp3J9vK9cA4xEMWYHG8Q+WIKUhDKYx3/hCf/7xoMrHDkUJmRSk1OvldC
	 PcJjmjLEi6+QiqBVilWkrhI17IId/WrybAqDBFN3snzMhckr1e5HWWSz8C52d9DDs8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CQJbqIBrSK1uzdi9/oqocDydKd1KKZnHFLuOurGyzP8=;
	b=SloT0+C/CctLzc5FJM7Js+I3B/mDtbAZqnZcSqSeFdUcHfauHdvMvmCwiwbVihLGZmF9
	 IH8l3IkyxEicC5F+oeZIx0WMR0HJVef2FhcD3UpE3/fbv1nwvEIPft9WLhbtwrDfiJycC
	 92u0FwWkKP+mbOYEvHqXvjcfd4qh74R0esTec0E0YwbYkVLJTZM5VSpF59aq+ZmOPAZBa
	 F8tOQZQGXV3+1x/9iKDTlHZlyasSUxdZbfO9iYby7cF8xatBpb2IF4KHkrPaj4JCuGPra
	 PuVRfz2RPDkVas56HAzt7koTYpTObeHn5Iwrafm3EAa0SwhWh6VMr87ibMiS3ynv/5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="O/++LoTz";
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A020606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 06:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A020606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O/++LoTz
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e9d7791b00so4104785ad.0
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 22:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794206973; x=1794811773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CQJbqIBrSK1uzdi9/oqocDydKd1KKZnHFLuOurGyzP8=;
        b=O/++LoTzuWDQQaS69XFdKJklzp7hRmsdiR3nQPcmolief0cuPhjgpNNZG93lb60Qef
         tNS3w7bEw1Clqlgus2xCGrZjNyur8wNOiqg4CHuKAZc90g8nL1PoNm+G+Rk18ns5QTS6
         Norg2jYg/yUJk6czgP3T9xomB74XRWdlET47PN8SjH97fktSiv1pqR/6KILR060o77E5
         6OhpdxDakS/sK63TScuY4rxB+lkz4IeoUmYdzkmZw2hPFgBuTHsn7fs+3Bw7gU7eC1MQ
         M2BbfnxNx5241SFEFwfQ/9YTFy0NzmoP3Lbwqdin6aql+6nUjbn1zrstSz//SI9F5Mt5
         PEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794206973; x=1794811773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CQJbqIBrSK1uzdi9/oqocDydKd1KKZnHFLuOurGyzP8=;
        b=uhpcY3zicHATUOYhQl3qrwOQqGhdjCQ6sKNJz8PowM/GIyfsmD3TZ1v8BDA5bpbqSi
         hGT28qriR5RnwCQ+aUlgenGatOqaf+hx1aZewUrecZfa+0XButdEWtcF5mROmwf3Fljy
         YeOJoyKzvn+es+IS24n2Yx1ghxuMMvblQLaTziGwIy9Tu4hYD96aJeSIsPrSYTZ985jq
         t20MnTy9vlotqyNOQVwatJDAb/l2T9HLqcniJOgpvfbPsDAWaD9bsGu0d52aEmJke9DN
         2lGQ43TV38uHqawGVcnyQbCgyHXAyl0msQsYmULZNxayyT3pC151o1hg8V7oAck4JgDN
         hmjA==
X-Gm-Message-State: APuU4Z+ykyJQGSFKwtIaK4n1aEx8Ho9UpegBE3uA+cvsgMiIdCD0eeV8
	k+w0FynBZmlb6+w00HMBrZ2pVa9E0Q01eIEx5eC4l54MV39z5GtgoCDuFlj7kQ==
X-Gm-Gg: AYBFou29qee4zvHo+fCNzIhDFegpelpHEb+KDobSZpt+2CZAtfyFxUAOMj3qTY0EL0P
	ywojKc6/rV7GNVCXqWObasuwQWINVskf8xdYd1UmcLnt4x1aUaT2Xf5mU64stzYWm5eSeY4SC19
	Ui6cNEW9ePJ2ZahhTCGa1ZP9HrVNu6M4kTuI3J0mzn0vo4Av1vaweZCQ7Q+a1yV+okvqhedpA0B
	XRqKuLtP9OCB2Oo7Vvx6B0aL7EzX+7GNuwJb00oiT1KavihsLMH30n9MxyFXDREwucj9I+LdbYK
	t3Mc6TquTQy5JKtKbku48eM4Wyw33E0uKXF6bsEMRzh8HPC3aaP08NGMk0qY3yIcPkAhm1ZdyTd
	hVNR/vTol/LEWUFBw+XmD0/Bn3ZNFbnFM73O3FTt2rnq0/uz0gx+QkYLzeCv0meH3KTO4G0WWoP
	iaakB/XB6Sn3UlOrI2Ih0mYVk2OszBa0zRqw49bWP5MZ+0Th1IhRJG4cNlqNPtSePrmcYhwjVMb
	vC9DNb2XefYRWgdV3Ree6x60cUR4GV8XRNERgO/0U69H/INhZR7Lef57qL0wlEXkuWDRa1WzTkT
	bRSCV3xgD1OtWbXayk+eWMhFGNgderWKwRzXXZL4lQ0kRmrni7B0hXhr1kVvW7iZczPkkZCbxCO
	5Gy0eSGJMpFzAs5KTPVF1zVIWGo5UW4JhfZjMvGY+jeuhc1lR0M2kguDm8jI5niafXqY0UwQKyw
	==
X-Received: by 2002:a17:902:d985:b0:2ed:56ee:af84 with SMTP id d9443c01a7336-2ed837981d9mr28962345ad.62.1794206973334;
        Sun, 08 Nov 2026 22:49:33 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed817153bfsm7895695ad.51.2026.11.08.22.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:49:33 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 23/26] bpf: Remove scalar ids from the join of states
Date: Mon,  9 Nov 2026 06:47:07 +0000
Message-ID: <20261109064715.2382452-24-alexei.starovoitov@gmail.com>
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

