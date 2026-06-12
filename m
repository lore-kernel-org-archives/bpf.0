Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13346374187
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781257150; cv=none; b=bSYvXMkUnueqGsSsMtaRxM50BT8flAcxA9ssRai7186P72AwGwLcpF+zRwv2vtLgy22DmFLPNuyiqkDAiT0XH9LOgTDJK4tvtSneJAeqKFsrmgaipTRD5lrApoYl7fmE0TPsw0ixKg8vd4vfRU9mEZMz7gNmLwvqzr2dqReED4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781257150; c=relaxed/simple;
	bh=fMPjgpkhHAVWTUa3/OPZlyraceW64OrfimWAL5Zh2D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P46JFP/66qPgf/WqSELYiK18goEEiK0C4PungFHL11r3dEHB0dwBE6Smv5M/WJZLR5uWP23HIKZgOWKl6TRZs5UANUr4jLyHbKocbzSNrP96mJ5AfM7bYwYoCR3GBvvmG4v4Ie57QjSNOI++x8xGwe7VVTmGFftKazlGA5X9i8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.57.97])
	by mtasvr (Coremail) with SMTP id _____wDHNkSp0ytqsqyBAg--.13644S3;
	Fri, 12 Jun 2026 17:38:49 +0800 (CST)
Received: from localhost.localdomain (unknown [10.162.57.97])
	by mail-app1 (Coremail) with SMTP id yy_KCgB3x5+n0ytqJIjoAQ--.2089S2;
	Fri, 12 Jun 2026 17:38:48 +0800 (CST)
From: Tianci Cao <ziye@zju.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com,
	ziye@zju.edu.cn
Subject: [PATCH bpf-next 1/2] bpf: support shift operations with non-const src operand
Date: Fri, 12 Jun 2026 17:38:08 +0800
Message-ID: <20260612093818.18609-2-ziye@zju.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612093818.18609-1-ziye@zju.edu.cn>
References: <20260612093818.18609-1-ziye@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgB3x5+n0ytqJIjoAQ--.2089S2
X-CM-SenderInfo: qtstiiaquyiko62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?XzxOIgXKKxbFmtjJiESix3B1w3tzYfmPt4q7bPP17nv9Zvsme7sPvU0377+RBBKdO8
	083rnS2Yx6ydJM+hN30hkgAllvNz+7K5d7U8c8dSwtNinCglYZvI44VlTDi4zQJikBzKur
	MNHlZnEitQ47puTV/8UW+fFSUrDrtSoKKU7hEq1T
X-Coremail-Antispam: 1Uk129KBj93XoW3Jr4kWr18Aw1DuF1UArWfCrX_yoW3tryUpF
	ZrCrsxZFs5Cayvvrn7ZanxXrZ5Xr4ktw18Aryqy34xtr17Xa43JrsFgF1ftay3AFZrZr42
	qa1jg39rZF10yFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1yrW5UUUUU==

Currently, the BPF verifier only allows shift operations when the shift
amount is a known constant. This is overly restrictive for cases where
the shift amount is bounded but not fully determined at verification time.
For example, the following code is rejected by the verifier even though
the shift amount is bounded to [1, 4]:

    u32 shift = bpf_get_prandom_u32();
    shift &= 3;    // shift is in range [0, 3]
    shift += 1;    // shift is in range [1, 4]
    r1 <<= shift;  // non-const but bounded shift amount

Modify the shift helper functions (scalar_min_max_lsh,
scalar32_min_max_lsh, scalar_min_max_rsh, scalar32_min_max_rsh,
scalar_min_max_arsh, scalar32_min_max_arsh) to handle non-const
but bounded shift amounts.

Update is_safe_to_compute_dst_reg_range() to remove the src_is_const
check for shift operations. This approach ensures the verifier
remains sound while allowing more programs to pass verification.

Also modify the comment on is_safe_to_compute_dst_reg_range.
Shifts by more than insn bitness are legal in the BPF ISA; they are
currently implementation-defined behaviour of the underlying architecture,
rather than UB, and have been made legal for performance reasons.
See: https://lore.kernel.org/bpf/20210706112502.2064236-47-sashal@kernel.org

Co-developed-by: Yazhou Tang <tangyazhou518@outlook.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
---
 kernel/bpf/verifier.c | 100 ++++++++++++++++++++++++++++++++----------
 1 file changed, 76 insertions(+), 24 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8ed484cb1a8a..6eba2af1b5c4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14184,7 +14184,8 @@ static void scalar32_min_max_lsh(struct bpf_reg_state *dst_reg,
 	struct tnum subreg = tnum_subreg(dst_reg->var_off);
 
 	__scalar32_min_max_lsh(dst_reg, umin_val, umax_val);
-	dst_reg->var_off = tnum_subreg(tnum_lshift(subreg, umin_val));
+	dst_reg->var_off = (umin_val == umax_val) ?
+			   tnum_subreg(tnum_lshift(subreg, umin_val)) : tnum_unknown;
 	/* Not required but being careful mark reg64 bounds as unknown so
 	 * that we are forced to pick them up from tnum and zext later and
 	 * if some path skips this step we are still safe.
@@ -14229,7 +14230,8 @@ static void scalar_min_max_lsh(struct bpf_reg_state *dst_reg,
 	__scalar64_min_max_lsh(dst_reg, umin_val, umax_val);
 	__scalar32_min_max_lsh(dst_reg, umin_val, umax_val);
 
-	dst_reg->var_off = tnum_lshift(dst_reg->var_off, umin_val);
+	dst_reg->var_off = (umin_val == umax_val) ?
+			   tnum_lshift(dst_reg->var_off, umin_val) : tnum_unknown;
 	/* We may learn something more from the var_off */
 	__update_reg_bounds(dst_reg);
 }
@@ -14256,7 +14258,8 @@ static void scalar32_min_max_rsh(struct bpf_reg_state *dst_reg,
 	 * var_off of the result.
 	 */
 
-	dst_reg->var_off = tnum_rshift(subreg, umin_val);
+	dst_reg->var_off = (umin_val == umax_val) ?
+			   tnum_rshift(subreg, umin_val) : tnum_unknown;
 	reg_set_urange32(dst_reg, reg_u32_min(dst_reg) >> umax_val,
 			 reg_u32_max(dst_reg) >> umin_val);
 
@@ -14284,7 +14287,8 @@ static void scalar_min_max_rsh(struct bpf_reg_state *dst_reg,
 	 * and rely on inferring new ones from the unsigned bounds and
 	 * var_off of the result.
 	 */
-	dst_reg->var_off = tnum_rshift(dst_reg->var_off, umin_val);
+	dst_reg->var_off = (umin_val == umax_val) ?
+			   tnum_rshift(dst_reg->var_off, umin_val) : tnum_unknown;
 	reg_set_urange64(dst_reg, reg_umin(dst_reg) >> umax_val,
 			 reg_umax(dst_reg) >> umin_val);
 
@@ -14299,18 +14303,44 @@ static void scalar_min_max_rsh(struct bpf_reg_state *dst_reg,
 static void scalar32_min_max_arsh(struct bpf_reg_state *dst_reg,
 				  struct bpf_reg_state *src_reg)
 {
-	u64 umin_val = reg_u32_min(src_reg);
+	u32 umin_val = reg_u32_min(src_reg);
+	u32 umax_val = reg_u32_max(src_reg);
+	s32 smin = reg_s32_min(dst_reg);
+	s32 smax = reg_s32_max(dst_reg);
 
-	/* Upon reaching here, src_known is true and
-	 * umax_val is equal to umin_val.
-	 * Blow away the dst_reg umin_value/umax_value and rely on
-	 * dst_reg var_off to refine the result.
+	/*
+	 * BPF_ARSH on 32-bit subregister. The shift amount [umin, umax]
+	 * may be non-constant, so we conservatively derive signed bounds:
+	 *
+	 *   smin >= 0: non-negative value; right-shift reduces magnitude.
+	 *              result in [s32_max >> umax_val, s32_min >> umin_val]
+	 *              e.g. [4,8] >> [1,2] → [1,4]
+	 *   smax <  0: negative value; right-shift increases (toward 0).
+	 *              result in [s32_min >> umin_val, s32_max >> umax_val]
+	 *              e.g. [-8,-4] >> [1,2] → [-4,-1]
+	 *   mixed:     result in [s32_min >> umin_val, s32_max >> umin_val]
+	 *              e.g. [-8,8] >> [1,2] → [-4,4]
+	 *
+	 * var_off is set to tnum_unknown because without a constant shift
+	 * amount we cannot precisely track which bits remain known.
 	 */
-	reg_set_srange32(dst_reg,
-			 (u32)(((s32)reg_s32_min(dst_reg)) >> umin_val),
-			 (u32)(((s32)reg_s32_max(dst_reg)) >> umin_val));
-
-	dst_reg->var_off = tnum_arshift(tnum_subreg(dst_reg->var_off), umin_val, 32);
+	if (umin_val == umax_val) {
+		reg_set_srange32(dst_reg, (u32)(smin >> umin_val),
+				 (u32)(smax >> umin_val));
+		dst_reg->var_off = tnum_arshift(tnum_subreg(dst_reg->var_off),
+						umin_val, 32);
+	} else {
+		if (smin >= 0)
+			reg_set_srange32(dst_reg, (u32)(smin >> umax_val),
+					 (u32)(smax >> umin_val));
+		else if (smax < 0)
+			reg_set_srange32(dst_reg, (u32)(smin >> umin_val),
+					 (u32)(smax >> umax_val));
+		else
+			reg_set_srange32(dst_reg, (u32)(smin >> umin_val),
+					 (u32)(smax >> umin_val));
+		dst_reg->var_off = tnum_unknown;
+	}
 
 	__mark_reg64_unbounded(dst_reg);
 	__update_reg32_bounds(dst_reg);
@@ -14320,14 +14350,36 @@ static void scalar_min_max_arsh(struct bpf_reg_state *dst_reg,
 				struct bpf_reg_state *src_reg)
 {
 	u64 umin_val = reg_umin(src_reg);
+	u64 umax_val = reg_umax(src_reg);
+	s64 smin = reg_smin(dst_reg);
+	s64 smax = reg_smax(dst_reg);
 
-	/* Upon reaching here, src_known is true and umax_val is equal
-	 * to umin_val.
+	/*
+	 * BPF_ARSH (arithmetic right shift) on 64-bit register.
+	 * Same three-branch logic as the 32-bit variant (scalar32_min_max_arsh):
+	 *
+	 *   smin >= 0: result in [smax >> umax_val, smin >> umin_val]
+	 *              e.g. [4,8] >> [1,2] → [1,4]
+	 *   smax <  0: result in [smin >> umin_val, smax >> umax_val]
+	 *              e.g. [-8,-4] >> [1,2] → [-4,-1]
+	 *   mixed:     result in [smin >> umin_val, smax >> umin_val]
+	 *              e.g. [-8,8] >> [1,2] → [-4,4]
+	 *
+	 * var_off is set to tnum_unknown since a non-constant shift amount
+	 * prevents precise bit tracking.
 	 */
-	reg_set_srange64(dst_reg, reg_smin(dst_reg) >> umin_val,
-			 reg_smax(dst_reg) >> umin_val);
-
-	dst_reg->var_off = tnum_arshift(dst_reg->var_off, umin_val, 64);
+	if (umin_val == umax_val) {
+		reg_set_srange64(dst_reg, smin >> umin_val, smax >> umin_val);
+		dst_reg->var_off = tnum_arshift(dst_reg->var_off, umin_val, 64);
+	} else {
+		if (smin >= 0)
+			reg_set_srange64(dst_reg, smin >> umax_val, smax >> umin_val);
+		else if (smax < 0)
+			reg_set_srange64(dst_reg, smin >> umin_val, smax >> umax_val);
+		else
+			reg_set_srange64(dst_reg, smin >> umin_val, smax >> umin_val);
+		dst_reg->var_off = tnum_unknown;
+	}
 
 	/* Its not easy to operate on alu32 bounds here because it depends
 	 * on bits being shifted in from upper 32-bits. Take easy way out
@@ -14423,14 +14475,14 @@ static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
 	case BPF_MOD:
 		return src_is_const;
 
-	/* Shift operators range is only computable if shift dimension operand
-	 * is a constant. Shifts greater than 31 or 63 are undefined. This
-	 * includes shifts by a negative number.
+	/*
+	 * Shifts greater than 31 or 63 are implementation-defined behaviour.
+	 * This includes shifts by a negative number.
 	 */
 	case BPF_LSH:
 	case BPF_RSH:
 	case BPF_ARSH:
-		return (src_is_const && reg_umax(src_reg) < insn_bitness);
+		return reg_umax(src_reg) < insn_bitness;
 	default:
 		return false;
 	}
-- 
2.43.0

