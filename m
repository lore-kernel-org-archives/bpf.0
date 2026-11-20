Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207885;
	b=0eT9+lfKYyTlz2RWaIM/vsHkybC3SeR7AijFy1v8Z+QLMp/rgqKMVFrOSqMlNOOgimgG
	 JNkq+2fzlMiauOZoLmkFfQsUZu8s+LNF+E9Ov7Dtb8GgF0mDvmi4SDzyjihmqtJIy5ea+
	 A6QDYq3smKFwVHfgAOS4X7StUf5U6ZkbB1gzfk+5DVWDueTBCM9bZ1Ln7jQY9JY1ACbXe
	 YQkqh8SMvfOpp9PvWlpm3NqIilUu9LaKPJzNpZ8LLbKcDcvt3mHpg9XIpUX+jXwfkRk4A
	 oELbL7OIr6ByP4nQHyoRl7BR9iu+IlVZHOEpWW0bJ2UIAZs3N7cElz533ZoYpF+Z+AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NIDPchP/JKanP257kaQ+TAFvxgnnBcz5k6gRF3FGLT4=;
	b=IpisbTFmTeN8WiWjDHB89VGt5GAvZi5XeBmHp15QBHfx8q0cnUn3mHtl6lLl6KaoUZ1r
	 a07AdZaReyefNTECHHWDFjud6O/vwZlafoz1zXs6gTxUk8g+8T/w+3YGJTR8WU3BoecMj
	 30qkZTIIjQoAHWIJvInG+TkCgdBPLLe7+TpMX8B6kLH7HfjcGYLT2KqOmF8Ki4o42B2Bf
	 5XtXT1cQqOBE9Z59Mc7g47rd6H+QWxuUuSjU8dTQ7PPmr7K+FPgpbquH2FCpvnAOA/BPJ
	 7xHQBvobjsM2LdBc9etW124ra1q/Fm3O9lJmxL7xMAkbke/63wDXPVFKUmQ78UuEJjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LM3L2cWZ;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B51606A337
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61B51606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LM3L2cWZ
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2f03920c4a0so9056225ad.3
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795207881; x=1795812681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NIDPchP/JKanP257kaQ+TAFvxgnnBcz5k6gRF3FGLT4=;
        b=LM3L2cWZJg5ErRTNozUNanOn8LW/cU5+b1Bj2ry4mEfyYbF26OOSASiH02+YRNLdNS
         +4APiUNGn5mLaw0Ktl7BX65MOv/EUcMLsKc9Opalf4JrqzmWKA7eBQjAEXFkhAwwt++X
         jiV1wuxinNK3Q2iRqi/e4Wj8jzQFAYJNoW/4hoXFlSOS5nYINXS9T6mU32XkY/Tvi2/7
         ojT++0E8Y+YYz+MyMmFSv3wBOd+OZy2KGfcrQt98eWQQw99jrkaE1Rsgaapoaf7veSJz
         DO3Hi2XvFB8BGblc2zrudWNPkB/OBDonUCevZb1q4WOeiEeUrlippHH+nIhMwMYOH5q9
         9sfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207881; x=1795812681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NIDPchP/JKanP257kaQ+TAFvxgnnBcz5k6gRF3FGLT4=;
        b=DwG1veZHs9jmp+j/bOCuKXLPH+AnQSKFsJq7XIYjNcD+TFm486m+hcLzLvuG6pY2v3
         VmlK3PtIr9pmC9PyAAYvBXoHSQ+QZI/X6E8inKFQcWUgdtDqrM9dTc9Ck3iB/2bLdYZt
         WqEpMJNmOn4hj31ZE4RUSPHiRqvRWANbeJRJ+yTOUcH/xo6Ci5oyp6BqWYSLpou/JfMN
         LaDg9MgQmZ6PB7AOp23tlAtfgi35sIWE9bgCh/fLXtzD7PWiFJ8ZyeTC6dZbEPS55fzt
         24rGESegKExhheDjXvDHkQ2p6KsYbzToq3xe363e4lZmyo/FkBOBSdhpLonVmBblMqxO
         KlhQ==
X-Gm-Message-State: APuU4Z9eCd1Wh13sRBD5cqGcfZN4XKZY/n+o+gwh9w0bVmjTp8Z0m1Pc
	Ic+O2uxl07Fq4uJvV0hfYI2E/8q9lx6ryknmsdxngdEgTI7JmIHU3MIVfWqo4Q==
X-Gm-Gg: AZFdTZencd74ajfXTDJT6uM8KVo+sExM8VLWestU1eRMlgm3g1FEgAQIyc27WBXituc
	iGH9hwE1TjCAieF1ep/n8gK55mEjqK/WfSjoQMr2t7P8T0RMO4FecgxHMJTSACrjg2cMgF7oz/Z
	pVjkq0nqFOWGdJaHr1/e+uHckbq3laOM+yBKFiy6wn8QLPznFuYx+9xJPQjWO1cD1LYAwOgFD3f
	HfzspNQA59rUf3u8Qt03asD91sHCKpk5RjvDzTfpW9mMzwyqwF1pAHTbkLd+TJP/aMLSOO8eKES
	uI6Hw59unaHqfSuehGPyrcFfyWrvRjP631svLfpxaUllACQr097VBcfF8UyYUkxzQ6V14b+50VU
	UVezDzL/mq1gskyRNOvSAv1aPddpt129rYObPVuZPwdvS6Up7AH0kkcPD/0XVTNVgjCtWvqagYV
	7PliS/jz4KSqFYRrXRLbYJIbV0aI7Y19Yn5CaD9V3nlzYCrGr4DiDNdjus5Irn+8Nu5WipyNgPD
	93GwHjgbt/d0n5NEZst0126xjSqZ+AvgHOab3zjhnyrmbyF6UsoqsW2L6cgWe+EvlkwKOsUVpjN
	JhYNtjEwhhgzuv6kH4Y+32Cm8zd8op+CgEG7O/Ck2jOpCcvNAoM3VFDZbW2deaypUzqQ6sgpHcl
	RFbxNd495aInRxQMP1Dwbr1LTRavCtGRsZcTptKsMUvl821GwBo6B+AnAkTDq3tnD18p5eb+U5g
	==
X-Received: by 2002:a17:903:41c2:b0:2ef:e348:505e with SMTP id d9443c01a7336-2f03f1ed345mr46643925ad.58.1795207880431;
        Fri, 20 Nov 2026 12:51:20 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0dcbe3sm18867665ad.28.2026.11.20.12.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:51:20 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 13/49] bpf: Remember how many bytes of a packet are checked
Date: Fri, 20 Nov 2026 20:49:21 +0000
Message-ID: <20261120204959.614908-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
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
index 2efb9d61501..f110909413b 100644
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
@@ -2270,6 +2273,12 @@ int bpf_loop_at_index(struct bpf_verifier_env *env, u32 idx);
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
index d67f6d6780b..8d90ed783d0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16524,7 +16524,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 	u8 opcode = BPF_OP(insn->code);
 	u32 dst = insn->dst_reg;
 	const char *reason;
-	int ret, bounds_ret;
+	int ret, bounds_ret, min_len;
 	bool to_scalar;
 	s64 smax;
 
@@ -16655,6 +16655,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 	 * constraints violations.
 	 */
 	__mark_scalar32_unbounded(scalar_of(dst_reg));
+	min_len = pkt_min_len(ptr_reg);
 
 	switch (opcode) {
 	case BPF_ADD:
@@ -16684,7 +16685,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 			 */
 			if (dst_reg->range < 0 ||
 			    (!known && (smin_val < 0 || reg_umax(dst_reg) >= dst_reg->range)))
-				memset(&dst_reg->raw, 0, sizeof(dst_reg->raw));
+				dst_reg->range = 0;
 		}
 		break;
 	case BPF_SUB:
@@ -16730,7 +16731,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 			 * prior comparison as arithmetic invalidates them.
 			 */
 			if ((!known && smin_val < 0) || dst_reg->range < 0)
-				memset(&dst_reg->raw, 0, sizeof(dst_reg->raw));
+				dst_reg->range = 0;
 		}
 		scalar_step_reset(scalar_of(dst_reg));
 		break;
@@ -16770,14 +16771,15 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
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
@@ -17883,12 +17885,19 @@ bool bpf_same_memory_origin(const struct bpf_reg_state *reg_a,
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

