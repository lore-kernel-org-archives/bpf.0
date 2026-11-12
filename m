Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498851;
	b=MMHEPi/yBW5qKx6OiFfQkBZlcTtAPY1jYhNJw4mSCrmhyNkQ5IPFFSDwL+wwVI56h0ao
	 Ayw+8/Z/PQynR7mMQbSz09fPqdY5GdKS0dNELy5Rn1GOTVCi27aiINGTVBTVGWKfYkziX
	 TtV2pcv5MCY1d/ztJp9yvoR2DOwLq9834oQrG3WJoD5jYPC00lCXYj8pV+vCu4xhwVYSu
	 zrHGH+D9AD/s/stVTHhY7gFvKnzIg7A9EX0AT8a1EVhOWXUtdV+IrOXyI52loq8tAoMmk
	 bwGqwRxBzChtG9p+jFFcc+DWhKokB0TBrCa90r68Jxss3SOdLMz/VYE6B0tGjG39i0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498851;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PUfac4JZ8jOSf3KpvW8DHmAcT7h1Lf/4ztm3rUdkarM=;
	b=vHg8US3bIu2IDQhWw7xl24ox4bBUIvwXCnU83gIUbZwyyGY2t2Dj1ICF6OCtbNZ3Lkov
	 hQd6NUnswbLRyLfvCn0rnAqYUkLv2huBWwBlUWE5uUDkhtexJg3YiJl4oyyEu1oK5+EHy
	 ur0s7E7OVE1K9jJyAGK/utIHCMsJoCt+E2g0tQcoQ5e6SBJ5mHrYops3tQHrWs6W1bKlL
	 IJhw6L1/Qe9yKbTUDZysdlA5vRN71IerhVTTEEz9PwSFkPL+ydGP2G2b3lk1P3p1o8XEx
	 x8Po8gC03Kq/bUFUp6sy+hSOV2H/GSTXvPD11uJLKwVv2C4894yjFNb8L+chpbqqvMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r1fuvxV7;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A666606A323
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 15:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A666606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r1fuvxV7
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so8745a12.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 07:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794498850; x=1795103650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PUfac4JZ8jOSf3KpvW8DHmAcT7h1Lf/4ztm3rUdkarM=;
        b=r1fuvxV703+TC/DdFeFREwN+jE1zuP0mRZhPIe9u9f1aGqS40ND27XZCyUFAwXkjdN
         T3OEqdNDFddlr2YoklnNdshqAbTQIOuUtTzIHeJX+mTGYFUYawESwArFbgcGW68+dCIl
         vUFxWq0v44yEULhYzBVFFxtu+Oir6Pb4MMdLeSxv4ZkmA6flS17fbsxzZeRh4E1WfL3z
         yjT6a7ILyve2sk4ufJadiKNYEXyfGmJSlLPwq0T+WIHieWLocx3kl+OS20unyGlFpx8n
         wJ0i7xFPWB3nwpIXddy8bxS9ydtOy6na+X63xmk4dskgxhMGLUsIiVysa2keIznEeGOB
         4JQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498850; x=1795103650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PUfac4JZ8jOSf3KpvW8DHmAcT7h1Lf/4ztm3rUdkarM=;
        b=1diIkwSjAioqtd8HIPTLN3bMq5VsmaeHTd/zV1XAnIo/PtgBx6yUlrYyEESAz479Rp
         UNSZASdDRco2d70pqSv+Fx4UJOjf8KdYPgbLIzQo/sHFgkbG/AKV7rjxVpQHzqg16qCg
         q9bXup7I9ICX0Oau2c4IHCKuccrsFC3it/t2z2gbsY5B+LHhMPEZckFhWj70qANrDuoF
         rIu9Nylg+rDnhrmChgjUb3qkR1QD3bTpgBwP40jrYJPzL775Wb9BLNi3+xgUSQbQLvsX
         utttLmbBgjgmmYGVuw9+eZqh6cyjxptKSSobuNM7GXL5ueNYIhoh0Pcpg1F07F8uWp1t
         0DbA==
X-Gm-Message-State: APuU4Z9l8SHnGrzUiFsJ37WAukwP+RXX0h3I+lEmc+6rQBN5CdcvZejw
	XZGQvJgTch7g+ixGidvi18ULjAbsA/kWWaXI9K9bNETbBesql/vUluhk1QXZUg==
X-Gm-Gg: AYBFou0VIbt2CJfPQp7I7Jr6Yu088O1lxgptGO4jXUv9x6aSbaNqavx4J2Q+UeBx4Zk
	0mGaJS3sJbbcpKcQOGzX0G777Dzmvtn9RMMXMHrpIVVth/G9l9OXTJpjgfr84p3BRNAnvtAHRkK
	GtE38H3d8ZDV6Nvf7OHK+QgWqB7Ld5H14MVQA5C+1QdM/6gK9RYEB9Gb+gEBNOeUUhJ87bNjFCd
	xqPEg4xXrSdaRdgLphDdlJI63vU3A02EDeyCL4Y7zKFPdsOjDN4e3fvBMK6gqe3XUwHf5fiw1h2
	bzSqv9SiYPrtxGVQc9Zp9q3zDn6T25hpsvv+9ycbYGfbgjs6JuUDl1RiGQtCdmnYJdeG1Cusn2/
	hhSbFNweheLwCCWgbua2SQU2Sa8RpfDZtk6d1ZFNwyQMRZEamsopAbys+dGxuWa+j9fLm23kN8e
	PtCKovqZWTaakdpkvaO/ny049OO8osUtlfiQQ3z7oMt+Q0li6KMYl4SRnpjcNt6cuB6/LJ0dB+R
	G+sISzy71Fd1W6SmbNPSBvlGCvz6h67BPtzzwHBdi9YsINz0m7wOwr/zj+lAr3GQ9bSMYOuDGZs
	yA95pfxSEBGbAe3Vgfe+ooC1llTpltblpMJnQexCRLXu9woHkiCvVXGif7eOt3nnzOl2VvTHACN
	leAq55wmMK1mL1LkLdhQ7ZN5ZdGeAfN/RWEv2cj/j3zpOcpl8LcuE5UtbfZZ9LCCl+rilZBL+cg
	R25cOJsxz+vuAaQQlxfMqU
X-Received: by 2002:a17:90b:57cd:b0:3b0:9cc6:62ba with SMTP id 98e67ed59e1d1-3b182f3ec75mr5735507a91.38.1794498850385;
        Thu, 12 Nov 2026 07:54:10 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d67adcfsm3176847a12.8.2026.11.12.07.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:54:09 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 05/12] bpf: Split scalar_alu() out of adjust_scalar_min_max_vals()
Date: Thu, 12 Nov 2026 15:53:30 +0000
Message-ID: <20261112155337.1040699-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112155337.1040699-1-alexei.starovoitov@gmail.com>
References: <20261112155337.1040699-1-alexei.starovoitov@gmail.com>
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

adjust_scalar_min_max_vals() is the transfer function of an ALU insn
with two scalar operands. Two calls in it need the environment of the
verifier: sanitize_val_alu() and maybe_fork_scalars(). Scalar evolution
is going to evaluate expressions such as h + (n & 255) * 20 and needs
the transfer function without them.

Cut the function in two. scalar_alu(dst, src, insn) is
is_safe_to_compute_dst_reg_range(), the switch, the zero extension of
an ALU32 result and the reduction. adjust_scalar_min_max_vals() calls
sanitize_val_alu(), maybe_fork_scalars() and then scalar_alu(). It still
gets its source operand by value, so 'r1 += r1' does not pass one scalar
as dst and src.

The two calls used to come after is_safe_to_compute_dst_reg_range().
sanitize_val_alu() is called for ADD and SUB, maybe_fork_scalars() for
AND and OR, and the range of these four is always safe to compute.

bpf_mark_reg_unknown(dst_reg) becomes scalar_set_unknown(dst) in two
places. The rest of a SCALAR_VALUE register is 0 already.

No functional change.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 59 +++++++++++++++++++-----------------
 2 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4708131cceb6..15528f3a352e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -2069,6 +2069,7 @@ void bpf_trim_pkt_range(struct bpf_reg_state *reg, s64 smax);
 void scalar_set_unknown(struct scalar *s);
 void scalar_set_const(struct scalar *s, u64 imm);
 void scalar_add(struct scalar *dst, const struct scalar *a, const struct scalar *b);
+void scalar_alu(struct scalar *dst, const struct scalar *src, const struct bpf_insn *insn);
 void scalar_zext32(struct scalar *s);
 void scalar_union(struct scalar *acc, const struct scalar *src);
 int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c208603a10e7..9721530636e3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17894,33 +17894,27 @@ static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_insn *ins
 	return adjust_scalar_min_max_vals(env, insn, reg, *src);
 }
 
-/* WARNING: This function does calculations on 64-bit values, but the actual
+/*
+ * dst = dst <op> src: the transfer function of the ALU insn @insn, all but BPF_MOV.
+ * @src can't be @dst. BPF_NEG and BPF_END ignore its value: any valid scalar will do.
+ *
+ * WARNING: This function does calculations on 64-bit values, but the actual
  * execution may occur on 32-bit values. Therefore, things like bitshifts
  * need extra checks in the 32-bit case.
  */
-static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
-				      struct bpf_insn *insn,
-				      struct bpf_reg_state *dst_reg,
-				      struct scalar src_val)
+void scalar_alu(struct scalar *dst, const struct scalar *src, const struct bpf_insn *insn)
 {
-	struct scalar *dst = scalar_of(dst_reg), *src = &src_val, tmp;
 	u8 opcode = BPF_OP(insn->code);
 	s16 off = insn->off;
 	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
-	int ret;
+	struct scalar tmp;
 
 	if (!is_safe_to_compute_dst_reg_range(insn, src)) {
-		bpf_mark_reg_unknown(dst_reg);
-		return 0;
-	}
-
-	if (sanitize_needed(opcode)) {
-		ret = sanitize_val_alu(env, insn);
-		if (ret < 0)
-			return sanitize_err(env, insn, ret);
+		scalar_set_unknown(dst);
+		return;
 	}
 
-	/* The count of a shift is a range: a bit of dst_reg can end up in more than one place */
+	/* The count of a shift is a range: a bit of dst can end up in more than one place */
 	if ((opcode == BPF_LSH || opcode == BPF_RSH || opcode == BPF_ARSH) &&
 	    cnum64_umin(src->r64) != cnum64_umax(src->r64))
 		dst->var_off = tnum_unknown;
@@ -17966,7 +17960,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		if (bpf_insn_is_hmul(insn) &&
 		    (!scalar_is_const(dst, false) ||
 		     !scalar_is_const(src, false))) {
-			bpf_mark_reg_unknown(dst_reg);
+			scalar_set_unknown(dst);
 			break;
 		}
 		if (!alu32 && insn->off == BPF_UHMUL) {
@@ -18019,22 +18013,12 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		scalar_step_reset(dst);
 		break;
 	case BPF_AND:
-		if (tnum_is_const(src->var_off)) {
-			ret = maybe_fork_scalars(env, insn, dst_reg, src);
-			if (ret)
-				return ret;
-		}
 		dst->var_off = tnum_and(dst->var_off, src->var_off);
 		scalar32_min_max_and(dst, src);
 		scalar_min_max_and(dst, src);
 		scalar_step_reset(dst);
 		break;
 	case BPF_OR:
-		if (tnum_is_const(src->var_off)) {
-			ret = maybe_fork_scalars(env, insn, dst_reg, src);
-			if (ret)
-				return ret;
-		}
 		dst->var_off = tnum_or(dst->var_off, src->var_off);
 		scalar32_min_max_or(dst, src);
 		scalar_min_max_or(dst, src);
@@ -18087,6 +18071,27 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	if (alu32 && opcode != BPF_END)
 		scalar_zext32(dst);
 	scalar_bounds_sync(dst);
+}
+
+static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn *insn,
+				      struct bpf_reg_state *dst_reg, struct scalar src_val)
+{
+	u8 opcode = BPF_OP(insn->code);
+	int ret;
+
+	if (sanitize_needed(opcode)) {
+		ret = sanitize_val_alu(env, insn);
+		if (ret < 0)
+			return sanitize_err(env, insn, ret);
+	}
+
+	if ((opcode == BPF_AND || opcode == BPF_OR) && tnum_is_const(src_val.var_off)) {
+		ret = maybe_fork_scalars(env, insn, dst_reg, &src_val);
+		if (ret)
+			return ret;
+	}
+
+	scalar_alu(scalar_of(dst_reg), &src_val, insn);
 	return 0;
 }
 
-- 
2.55.0

