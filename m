Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160710;
	b=4FDsw4EZ65yUWwQ/moPMiqzk8NZp7mGKyHEWaAnLVJGz3dv+R4o6KzIC6S5gyI2l/gWI
	 g8hAkoFDUPsfLGUc+OLfO0Atz8cBrh1bxlEP7Ks5/Wx+Q/yvCK2c0O74uRvz2Cf4R0gXp
	 OcJws+siwu2q/paIMihmKWkRPABM8H/jxmhLcLux7z04rl52APYDPhhXPe/Uhlhysi6ki
	 5BfpX+xuIHXyUFMvZiYacAjzb0F3Mg64tSdluoLvcoU2ac5qjb5adRnYyXSw+MrQERhPb
	 W4puo6KRl18ynU7S9nuUw2hRxLmyY3hUR7AUR5FF62AK8tRD0vRYw3DSBSM65wuIUUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160710;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=m2see/PzKV42EE80dLm+z8/B68209qQzu8QhniFAbho=;
	b=qwW9rhguoWfYSkZ/7jxGiEvRBJ9aQ3+cJRHvGOm9qjy63DZHhT2iZNXauKRgjqFSh4GS
	 GStE+ycv01LMl3Kdy5P9Ws6VXqE+nivHD9ZyYpEdhA90C+L9oRHFsg2eim7wxP0fzMlOl
	 5p+Kdb8p0p6SJgZ3Sx6V40B4si7kSzief5Zs2Wlx7RRJErvW2NuumOxOSTqf4KRKWnTFd
	 36jFNKTN7TRNjWyKACr6xP2Wxv9GmsI6CqDbhZ7L65C2GQEnMVsytNpvF48HYnxst8VA9
	 kks209n0wN7t3vz/eOfQMgF0JsiqVfrIF9oEDtEo88ysd7FRG0uO7YSFr7TyKuRU1EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PNrcca7L;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A344606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A344606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PNrcca7L
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2f0458cc9easo2782935ad.3
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160710; x=1795765510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m2see/PzKV42EE80dLm+z8/B68209qQzu8QhniFAbho=;
        b=PNrcca7LrjIurrLjPjGLDZrxBdohcpXZoeyRBFiFmkkpfnuubRNvwTcvCKLZ5zu+UU
         CtI+lyEYxd/A2x/IkycFeqlACCVkNAng2H7MDGwnibkqub/Q5UGVvhEKbo7gHLish3Pp
         Dslh55tB7ExP++X+PD+NdNZi9qpFsE++AaIWZzQdJ9maPnemk9aMnrMDcMkVmEw3Gwml
         qnzm7bN7dbh/W1LFKUB7dKa4qYmbU8vRaI+qdQPXfLRfex7O1QuUbckROL9USrHbfsbA
         4Ok9T9k+cs3Abk5xjW3sNfuZuc80bl7mkT6LZwhwlklKt5lq5gN5GEWrE2r55VV2XWll
         rJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160710; x=1795765510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m2see/PzKV42EE80dLm+z8/B68209qQzu8QhniFAbho=;
        b=F/wXEAkz0gkyJkJzy+CMfioEHRl9WXUga8aGhnFbFwJrLKfetVGoGnCXwXjbMjq0UX
         i16O+uHpEQOP7qGQCEi+0AuEeJWvO0iItVSyCTQOLjSn8GIkGGWo6I+uboSoeeej2zVB
         F31bkhYdELbkirv3EZTSL3IrOY3dSMVvpgO8MY1Q2lfI9AHEI15rFGzdSy7cSgrXPZc2
         1Don6+uYKIyE+QpFuM2FOb1wactAhDd40DH/U30Y3yinHaz+WzwnF9M9n3HD84wc9cd0
         kXvJikg0ADHghgl+uvVLGnMbYz3xa8BHbxZ/pNPNBykzpBGNWE3LxzdFTvIbRbIEWZ/c
         9zLQ==
X-Gm-Message-State: APuU4Z/YxkPqHGrGB+cZbMbDzB195DYDQSGVN95QL5BT0MQQSAumZ2KG
	UL8ieM3nIhFscMLaBDtYI4QRHM/J7wfKou1cDPG2xMYCkHF0+eHaq/9cfEb2vQ==
X-Gm-Gg: AZFdTZes7SSNsfWumQQQ9JmZfPdBYOCYdHD8EQgW7qE+x7h0zkddOJHOHzcLyVIczaQ
	wT2wXEDUw7Fv6+l+10jZtiEBbowBWRH8m37u0L5+OsT3Mks4k1rHFaNHg0yJ1DGJYMTFcBCCNjd
	vB0b5/P+2LszNbrdlwyZzpg9v8WGMHqXsGDROPwSFbqZJlIkP3XgThwSUtab8ozEW/1n0tji+Fq
	8r1zx2uRg4XAnLqSIwOmjcffGHUJc7ciKPI7R7zCJ84g56jbOejHTAy1gvv5ZJgv/k81zourrb7
	vImhdQX4RO/BxNKb9d+b4hSflF0jFG9TnbrwTc7x4wCeNptLrbpfMvzWZ6VF58D4VQSRIx7RpN8
	aE9No1nG3qvPTveEVs2oe1et/wgNmRkwDMooc4YNrRE4/Pg/sjWXQERoTIakR3CzCl+vNoKBo1l
	UUNi1EFuCNLi1lUEoyp5BL4eP6rr/6S9adMzYh+QK+mbqx/sFaws4B1P10fYqAov8dL/CDxhGi4
	OubS1EsoxmMTfCZbgaJrueBNFlT9JYEZ18jznK2vdAfvdoAAeX/V5xKD4eZy9McrkXdJAC2SJsd
	V9dxs7Ch7MZzoTvV+MkLaqDrBa3SGIpDJo76aAkRNdhYge8QYL+BYL6Jh3chxdTSJp07jelzNXV
	6HtW/tQSjah740xQdLIIzrocNBZGwhf4kSxnhilp7fBLGRa/MuaXB3tJaQAP2a3iyyvpsQeED3Q
	==
X-Received: by 2002:a17:903:32ce:b0:2ed:146c:cbad with SMTP id d9443c01a7336-2f03f17cdf9mr25087825ad.19.1795160709359;
        Thu, 19 Nov 2026 23:45:09 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0dc0ebsm10240645ad.33.2026.11.19.23.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:45:09 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 06/49] bpf: Record what each insn reads and writes
Date: Fri, 20 Nov 2026 07:41:38 +0000
Message-ID: <20261120074430.2704488-7-alexei.starovoitov@gmail.com>
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

Liveness knows what an insn reads and writes, and drops most of that
when it is done. A later patch walks back from an unproven insn and
needs the same data. Keep it in bpf_insn_aux_data:

  r2 += r3                   use_regs: r2 r3, def_regs: r2
  r2 = *(u64 *)(r10 - 8)     may_read_mask: fp-8
  *(u64 *)(r1 + 0) = r2      writes_outer, if r1 points to the frame
                             of a caller

Give registers and stack slots one number, the xreg:

  0 .. 10      11 .. 13            14 ..
  r0 .. r10    hidden registers    fp-8, fp-16, ...

Two sets of reads were too large:
- LD_ABS and LD_IND read all registers and wrote none. They read r6 and
  the source register, and they clobber r0-r5.
- bpf_timer_set_callback() does not read r3. The verifier sets that
  argument.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h | 33 ++++++++++++++++++++++++++++
 kernel/bpf/liveness.c        | 42 ++++++++++++++++++++++++------------
 kernel/bpf/verifier.c        |  1 +
 3 files changed, 62 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index ed271135fe5..ac20aa50835 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -382,6 +382,30 @@ struct bpf_retval_range {
 	bool return_32bit;
 };
 
+/*
+ * An xreg is a register or a stack slot of a frame:
+ *
+ *	0 .. 10		11 .. 13		MAX_BPF_EXT_REG ..
+ *	r0 .. r10	hidden registers	fp-8, fp-16, ...
+ *
+ * A state has no value for a hidden register. No mask of xregs has its bit.
+ */
+#define MAX_BPF_XREG (MAX_BPF_EXT_REG + MAX_BPF_STACK_SLOTS)
+
+static inline bool bpf_xreg_is_slot(u32 xregno)
+{
+	return xregno >= MAX_BPF_EXT_REG;
+}
+
+static inline u32 bpf_spi_to_xreg(u32 spi)
+{
+	return MAX_BPF_EXT_REG + spi;
+}
+
+static inline u32 bpf_xreg_to_spi(u32 xregno)
+{
+	return xregno - MAX_BPF_EXT_REG;
+}
 
 #define LOOP_STACK_SIZE 16
 
@@ -811,10 +835,19 @@ struct bpf_insn_aux_data {
 	u64 non_stack_access:1; /* instruction can access non-stack memory */
 	/* true if some jump or call instruction targets this instruction */
 	u64 jump_target:1;
+	/* it can read or write the frame of a caller, in a call with a known callee */
+	u32 reads_outer:1;
+	u32 writes_outer:1;
+	DECLARE_BITMAP(may_read_mask, MAX_BPF_STACK_SLOTS);
 
 	unsigned int orig_idx; /* original instruction index, initialized once */
 	/* registers alive before this instruction. */
 	u16 live_regs_before;
+	/*
+	 * Registers that it reads and writes. The arguments of a static function and of callx
+	 * are not in @use_regs. The bits above r10 are not valid.
+	 */
+	u16 use_regs, def_regs;
 	/*
 	 * Bitmask of R0-R9 that hold known values at this instruction.
 	 * const_reg_mask: scalar constants that fit in 32 bits.
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 4a58c5f4db8..6e6b2c6d88c 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -770,29 +770,40 @@ static void half_spis_to_slots(unsigned long *slots, const unsigned long *mask,
 }
 
 /*
- * Precompute, for each instruction, the OR of may_write and live_before masks
+ * Precompute, for each instruction, the OR of may_read, may_write and live_before masks
  * over its top frame across all func_instances reaching it, stash them in the
- * insn_aux_data.
+ * insn_aux_data. The other frames set reads_outer and writes_outer.
  */
 static void compute_may_write_masks(struct bpf_verifier_env *env)
 {
-	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_insn_aux_data *aux = env->insn_aux_data, *a;
 	struct bpf_liveness *liveness = env->liveness;
 	struct func_instance *instance;
+	unsigned long *read, *write;
 	struct frame_masks *fm;
-	u32 nbits;
+	u32 nbits, f;
 	int i;
 
 	list_for_each_entry(instance, &liveness->func_instances, node) {
-		fm = instance->frames[instance->depth];
-		if (!fm)
-			continue;
-		nbits = frame_mask_bits(fm);
-		for (i = 0; i < instance->insn_cnt; i++) {
-			half_spis_to_slots(aux[instance->subprog_start + i].may_write_mask,
-					   rel_mask(fm, i, FM_MAY_WRITE), nbits);
-			half_spis_to_slots(aux[instance->subprog_start + i].live_stack_before,
-					   rel_mask(fm, i, FM_LIVE_BEFORE), nbits);
+		for (f = 0; f <= instance->depth; f++) {
+			fm = instance->frames[f];
+			if (!fm)
+				continue;
+			nbits = frame_mask_bits(fm);
+			for (i = 0; i < instance->insn_cnt; i++) {
+				a = &aux[instance->subprog_start + i];
+				read = rel_mask(fm, i, FM_MAY_READ);
+				write = rel_mask(fm, i, FM_MAY_WRITE);
+				if (f < instance->depth) {
+					a->reads_outer |= !bitmap_empty(read, nbits);
+					a->writes_outer |= !bitmap_empty(write, nbits);
+					continue;
+				}
+				half_spis_to_slots(a->may_read_mask, read, nbits);
+				half_spis_to_slots(a->may_write_mask, write, nbits);
+				half_spis_to_slots(a->live_stack_before,
+						   rel_mask(fm, i, FM_LIVE_BEFORE), nbits);
+			}
 		}
 	}
 }
@@ -2680,7 +2691,8 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 			break;
 		case BPF_ABS:
 		case BPF_IND:
-			/* stick with defaults */
+			def = mask_widen(ALL_CALLER_SAVED_REGS);
+			use = reg64_mask(BPF_REG_6) | (mode == BPF_IND ? src : 0);
 			break;
 		}
 		break;
@@ -2953,6 +2965,8 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 		u32 in = state[i].in;
 
 		insn_aux[i].live_regs_before = mask_lo(in) | mask_hi(in);
+		insn_aux[i].use_regs = mask_lo(state[i].use) | mask_hi(state[i].use);
+		insn_aux[i].def_regs = mask_lo(state[i].def);
 		/*
 		 * On architectures where 32-bit operations do not reset upper halves
 		 * of the registers, the verifier needs to zero extend a destination
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 363ba494cb9..491b4ecd5f9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19834,6 +19834,7 @@ bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
 			if (fn->arg_type[i] == ARG_UNUSED)
 				break;
 			cs->arg_slot_cnt++;
+			cs->implicit_slot_cnt += fn->arg_type[i] == ARG_PTR_TO_PROG_AUX;
 		}
 		return true;
 	}
-- 
2.55.0

