Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160751;
	b=F+maB6lCJrUaj0TQeVZEQjalS0Ov64L+DNcXrxe0BecM6NflsT/rRrO03wPJ3/8Zk9J1
	 4czevLLJEyVITKN9Y5Ctxo9+/X5XQrmoPXuUpH8ZOj6he0UwGAg3lfSVzBMuuDA4dJWri
	 +lsNZagVSGtwUbjzh6OI3JT3UQL2ZXMBsUqWM2S0BsjuIK2nyc6svXr6aaHdfO9POOc7L
	 1zqIdLZlLMDRC/lS5K7TT83jIe2G77FFMBQ4Dmh8WpRvYpOrxSFc5UqBBrhaZO8LlXAW5
	 qVbQxFO4a9bXbU+j7WHZqQVZ7PLXVoVhaWKDrX9UBrkUwzZXMKjS44mp9m5nAfV1WBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/H2PW26I1VrsITCow9ub5YNuMrrYqB5NvkRwGW9pMLY=;
	b=lMRqUkBniJ9vzpqoOKEb8Ow22JRjKW1YiuMz2TlE+FvWi0wCwvpLglYLNjYTbbXuAZTN
	 Anrkgqc7uj04rdQYkBIIWGNWz01wULc59krwH6oJU+PKtA+62AzuZwruKpPOVrB5BoRfy
	 n815Szw2wDgdcAPkP1MG2mKp2bXddolVnOih5pqbz39WZYqVKoUW1IC6RsypK4KfaJXHu
	 AO53ERRvNR9+MN7bRGxsR3c7twL9V+ze4ZNJMKD/xvLx2Q9rF0l8/fmcxYs+xk3rCR0Bb
	 fNBaJqXmzP2e2uB3rwOQwGqWr9o+x3e12n/mWAs1rlcw8U9RmVbLmRRgMlBG5erdzSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="u/2UHVyV";
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276C9606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 276C9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u/2UHVyV
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso447260a12.2
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160750; x=1795765550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/H2PW26I1VrsITCow9ub5YNuMrrYqB5NvkRwGW9pMLY=;
        b=u/2UHVyVaS83rvnfo7sQIpP63fbFjV/74j1dHQRVeluUceQ/dkvbuS1pgK/3A40+mY
         CxXox02EJbEjxb5ZQPXBTeuIBO5B4sDIl2vo7urUhDUwcqLyCOpSW9WiJ+36eQZL+cr7
         SviYfc/RVIPxClXbNm0OL/j2UxASDOFYuIDe1ipXC3TXJrZwE3CTrARGf8M6Tp59wqBI
         RH7B94YRUs8TO9unAsPRDXT/SLNjhNjhgMSvOaVnFPvkx7ITnILLwWlX7XMld4v1Y1fh
         gWPTqR6uGmZmqbSwg4K38X8QNlMVmpT6mwPlb0JjrLP7OIO8crAn4Cy8lOXztFu4O//T
         p0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160750; x=1795765550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/H2PW26I1VrsITCow9ub5YNuMrrYqB5NvkRwGW9pMLY=;
        b=ukWzbbbFAyrRKW/G/u3nkAd5zq2bsGrUeA6lfLCYBhibAWYhLA9KTIoKUJkQbwDxBa
         jzyf6PiN2jnmM+SPNCX+yLAE6ag6tI+Kh13JdtAyTuBh9O5ZB27qN3ooKdKOJ3yw48Hl
         9GEoInx4GX+EcmA9hRChKSr39okGjomG1FGhARakpgHZB/2Pqhe6xyAjt905LyezwU4x
         3lLNm89cwnZzsz1nQTvHZ6Sog/12tfQvkfcvpc78+F3V2F4HIfsfNyuGewvCPY5aV/E6
         gwZ5jVgPD9lm6gMg5+EVYDFqRINImgcCxMCiS/88fIGPKj9EKkQgCnzg9so62Ukf05N3
         rPZw==
X-Gm-Message-State: APuU4Z/WH7UF8TZQS38PXindQ3sVRi8R3aeVkS9+8SsfF1B7rV1os6YB
	6GJH0k+E1DXVi+UTzETXcsf9kKdEjIupiTO0K+IgcAdbf2/f3QHPWLm1ognrVg==
X-Gm-Gg: AZFdTZfQ9l6uJG0+IV8NXc2wcjroLSA3wSvCk3yLRwrfcJrsl7tmjvNGVqgR8CWEjNh
	iNhU/mR5koOqK5aqv0Ua+aVJ2NsQvtvdFhDq9y5DywSV9oEsRc1hawu7WYpsgd9Nirmq4fxDs3v
	v1Im3VzQ3L9exEXF0/Y8A6xmYxnMpYSlVclChKDZ0uEH7nwB6q7FZt8DG3Zs1vRGWm8LNPFDSdM
	TiJ6iksbGFUlsLaJN5hOmzp0c8ntc5VlSQOMSvxnYLF/3oCFJJzJfmVCnf/fYB20jQ/8rhrn8oi
	d/6gLln54M//QMNQLnj8WVsBVd0b15XEaLfXt5WutKi+e49nzCuaaXN43Dl61JDRUnXI21BYIee
	0ibl/M+5s9BTcHlCPbFHlBvwmaey8XBuEkAGjYXqBQwLXyh7aZ2Q5RbU0uwVS+YdZ8QYAri5OO2
	J9oXH4OHRJd2OPbsLIAYKvumhSkgDrzKCHekxbBB+Y0O0IVl93qYWr4rTvpcACN75GmYOilq+Fz
	yYF5hT8t850n+J3sCApBBvEURsMsG40AVWGsxIzcWyry3DVcNzLpRvMX+RIEUX12+7GcyiBV8Oi
	aLp0FtvioDXK5H58fxpA8vnRA7qFHq8amdaPFwC9lFoiHhRWyI/LYh3uxtImykVCehj9MpeZGz1
	X1l5PrDlFp1h70v0lhh0/jjtcmt7KCgrNpmhDMaSDujv5zBdc0sn5Zmq6T34ruPOfx33YYHStPm
	M=
X-Received: by 2002:a17:90b:1649:b0:3b1:2810:dfd6 with SMTP id 98e67ed59e1d1-3b41cb50c4fmr2070032a91.64.1795160750102;
        Thu, 19 Nov 2026 23:45:50 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41cfbdb9csm1282592a91.2.2026.11.19.23.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:45:49 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 13/49] bpf: Remember how many bytes of a packet are checked
Date: Fri, 20 Nov 2026 07:41:45 +0000
Message-ID: <20261120074430.2704488-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
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

The range of a packet pointer is lost when the number that is added can
be negative:

  if (data + 54 > data_end) return;
  p = data + 20;       range 54
  p += -4..4;          range 0
  *p                   fails, but the offset is 16..24

The check of 54 bytes holds for the packet, wherever the pointer goes.
Keep that number in pkt_min_len. If the largest offset of the pointer is
below pkt_min_len, the range is at least pkt_min_len.

A join takes the smaller number. A state with the larger number does
not subsume a state with the smaller number. The join rule does not
look at the number: each trip of a scan loop checks one byte more, so
all exits of the loop would stay apart.

Equations will let a jump refine a pointer that has any offset, and
they bring a far pointer back:

  r9 = data + r2                  r2 is 0..255, 8 bytes are checked
  r8 = r9 + 0x7fffffffffffffc0    the largest offset wraps
  if r2 > 100 goto out            refines r2, r9 and r8
  r8 -= 0x7fffffffffffffc0        r8 is r9 again

An earlier patch has the rule for that: an id and a range hold only
within BPF_MAX_VAR_OFF of the start. So r8 has no range, and pointers
with one id are all near, or they are copies of one far pointer.

smax can go from S64_MAX to -3, and the difference does not fit in s64.
bpf_trim_pkt_range() computes it in u64.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h | 11 ++++++++++-
 kernel/bpf/log.c             |  2 ++
 kernel/bpf/verifier.c        | 31 ++++++++++++++++++++-----------
 3 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e1432f48fea..ed15e63456f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -117,7 +117,10 @@ struct bpf_reg_state {
 	u32 id;
 	union {
 		/* valid when type == PTR_TO_PACKET */
-		int range;
+		struct {
+			int range;
+			int pkt_min_len;	/* see pkt_min_len() */
+		};
 		/*
 		 * Valid when type == PTR_TO_STACK. Inside the callee two registers
 		 * can be both PTR_TO_STACK like R1=fp-8 and R2=fp-8, but one of them
@@ -2212,6 +2215,12 @@ int bpf_loop_at_index(struct bpf_verifier_env *env, u32 idx);
 bool bpf_is_nested_loop(struct bpf_verifier_env *env, int inner_header, int outer_header);
 
 
+/* How many bytes are checked from the start of the packet, wherever the pointer is */
+static inline int pkt_min_len(const struct bpf_reg_state *reg)
+{
+	return reg->r64.size ? reg->pkt_min_len : max(reg->range, reg->pkt_min_len);
+}
+
 static inline u32 bpf_xreg_cnt(const struct bpf_verifier_state *st)
 {
 	u32 fr, nr = 0;
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index e58202955f1..0d381e31421 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -666,6 +666,8 @@ static void print_reg_state(struct bpf_verifier_env *env,
 	if (type_is_pkt_pointer(t)) {
 		verbose_a("r=");
 		verbose_unum(env, reg->range);
+		if (pkt_min_len(reg) && pkt_min_len(reg) != reg->range)
+			verbose_a("min_len=%d", pkt_min_len(reg));
 	}
 	if (base_type(t) == PTR_TO_MEM) {
 		verbose_a("sz=");
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3229372c5f4..e8377d15b02 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16513,7 +16513,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 	u8 opcode = BPF_OP(insn->code);
 	u32 dst = insn->dst_reg;
 	const char *reason;
-	int ret, bounds_ret;
+	int ret, bounds_ret, min_len;
 	bool to_scalar;
 	s64 smax;
 
@@ -16644,6 +16644,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 	 * constraints violations.
 	 */
 	__mark_scalar32_unbounded(scalar_of(dst_reg));
+	min_len = pkt_min_len(ptr_reg);
 
 	switch (opcode) {
 	case BPF_ADD:
@@ -16673,7 +16674,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 			 */
 			if (dst_reg->range < 0 ||
 			    (!known && (smin_val < 0 || reg_umax(dst_reg) >= dst_reg->range)))
-				memset(&dst_reg->raw, 0, sizeof(dst_reg->raw));
+				dst_reg->range = 0;
 		}
 		break;
 	case BPF_SUB:
@@ -16719,7 +16720,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 			 * prior comparison as arithmetic invalidates them.
 			 */
 			if ((!known && smin_val < 0) || dst_reg->range < 0)
-				memset(&dst_reg->raw, 0, sizeof(dst_reg->raw));
+				dst_reg->range = 0;
 		}
 		scalar_step_reset(scalar_of(dst_reg));
 		break;
@@ -16759,14 +16760,15 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 	 * step tell about it (alignment, umin). No other pointer has its id, so
 	 * it is enough that its range loses what its umax loses.
 	 */
+	smax = reg_smax(dst_reg);
 	if (reg_is_pkt_pointer(dst_reg) &&
-	    (known || (opcode == BPF_SUB && dst_reg->range > 0))) {
+	    (known || (opcode == BPF_SUB && dst_reg->range > 0)))
 		__update_scalar32_bounds(scalar_of(dst_reg));
-	} else {
-		smax = reg_smax(dst_reg);
+	else
 		reg_bounds_sync(dst_reg);
-		bpf_trim_pkt_range(dst_reg, smax);
-	}
+	if (reg_is_pkt_pointer(dst_reg))
+		dst_reg->pkt_min_len = min_len;
+	bpf_trim_pkt_range(dst_reg, smax);
 	bpf_blur_far_offset(env, dst_reg);
 	bounds_ret = sanitize_check_bounds(env, insn, dst_reg);
 	if (bounds_ret == -EACCES)
@@ -17866,12 +17868,19 @@ bool bpf_same_memory_origin(const struct bpf_reg_state *reg_a,
  * 'range - smax' bytes from a packet pointer are in the packet. reg_bounds_sync() can make smax
  * smaller than @smax: with a step of 8, or with 3 zero bits in var_off, 58 becomes 56. Make the
  * range smaller by the same number, so that the number of bytes does not grow. umax is not
- * sufficient: it is U64_MAX when the offset can be negative.
+ * sufficient: it is U64_MAX when the offset can be negative. A jump can take smax from S64_MAX
+ * to -3: the difference does not fit in s64. If smax is larger than @smax the range is lost.
+ * If smax is below pkt_min_len, the range is at least pkt_min_len.
  */
 void bpf_trim_pkt_range(struct bpf_reg_state *reg, s64 smax)
 {
-	if (type_is_pkt_pointer(reg->type) && reg->range > 0)
-		reg->range = max_t(s64, reg->range - (smax - reg_smax(reg)), 0);
+	u64 lost = (u64)smax - reg_smax(reg);
+
+	if (!type_is_pkt_pointer(reg->type) || reg->range < 0)
+		return;
+	reg->range = lost < reg->range ? reg->range - lost : 0;
+	if (reg->pkt_min_len > reg_smax(reg))
+		reg->range = max(reg->range, reg->pkt_min_len);
 }
 
 /*
-- 
2.55.0

