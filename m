Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207841;
	b=fE3nJPVa1ejpSk/A6tjXQlDOE/ZamCDagi8nLj/nNYmhYRALSjoD436F02Grz1mae3ey
	 gAeoGRYEP0bCCdH4cn0wJRij7deFKhPzn2lVpqZbzPdf66VL17zYQb0h/1uJNjw4ByknL
	 EBRXmXfWIhee0feW4oOxU1vOr7oAfi1loZL5rkL+EbjbB1rOnRL1gM98U/fNMrejPx09/
	 7FojjoRvCSwKKR8L33KHZcFe1An6sgDoWjic5S8r2sOkBe0qy1vfHKCogDcowufKr0juy
	 k2m12Eh+dlg/HSRAF+Gj1V/CIcgbmWywbf7LfuOcESAJDrzQNDDBK3Okll36E2fU6Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vdHc+NM7jFBQ8BVsIOpFkkMYs95wwImzj3s18Ndv3K4=;
	b=depRlvxsDpDa3b4h+WrtqpVq7JIuQYNwgQwnDNgs4Y8ZrGX8n91GC6f+UluDwN74FNWF
	 ZpztfslYq0KhxGa6xVnJ/GxqVXJKf93XgWIWfnucjFQTGkWSomRWxN0V37DZIPrjgzXEZ
	 ja8f9sJYo+QPKejxlXYHybG8dkDZZ/6kdAen41SkcLClYu/EJG+5e/6SomxTVYiWRaLGw
	 J2xa/CGgQfXaB490smqCnbrEVPQgWBEOvVhzywL30lKcVuHwj9k0aH9gB80qiuxhz4jSf
	 Y3cb5HKgp9YZp4lNUs3wiBUKa6AMzyUy7qXL6y3xoMsfpVxZHJTM3XHa/QVRoNW9x7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SKKWB1+O;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDB6606A68D
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDDB6606A68D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SKKWB1+O
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2f04e3bf46dso7379705ad.2
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795207839; x=1795812639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vdHc+NM7jFBQ8BVsIOpFkkMYs95wwImzj3s18Ndv3K4=;
        b=SKKWB1+OtwgApg4TT8rI+bAwlwQ5TNAjTy53MkIX44pw83KX83P8hlNBqj4SE4EZG1
         YVaj1Qz/GwH84JDUEZhA0BU515uEkvQnET0pL/Shrbb7Td0T/fOBkP/nDRBQlFY5HmFJ
         5EXfRDqqJ2GGweemlxEO5AxumrDTQy7yCLJMSj4AKzGO8Wo9UI1N3DBJMe2CY5t2gRkr
         +9YE3gXgC8vqThYoiOj4ex+dgwU9hwMjq7GgAwyuKwxLUW4iTMni5HQfkBVhOwIk0AgE
         nzpystXW9xbiGqkNUyVYILs6fGJCgPG3FrRXNnTZBPbcVvqrYQBneQ9nBBHPAp/dStcg
         mliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207839; x=1795812639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vdHc+NM7jFBQ8BVsIOpFkkMYs95wwImzj3s18Ndv3K4=;
        b=JxxEq31D47uY3ZKSXDGukXilTelv7DiDuS+QWMCdaYxnfed6m482ubjo3/70A7Q4PA
         Zpdr8OMR+/lxfWMOaeBeUQj4J3k7lhMHpGcErbEUSPdLUIY0cWMYER0Hs9LHyxMGiVG3
         AkZlhguVP/0kwRX3VfKNjZ/MF36DrdqLHQh5RV5VMwaHjp+UNa58HJjGOP0wXmSA/svk
         yUWuKS+aoMUxi9pYA3JsrtAVd/McOE4WhpRVLk8F1JsW4rUaKMF+LDyY3QGx4ZKCyWUy
         48/Uz4+JA7LGaFBiY0G73KvJBFA81Kt+PcxYBb61pHztR6kpzJjyQw7lydizH2H/34k2
         Wlvw==
X-Gm-Message-State: APuU4Z/QFI9qEgrA3wWfViUDcRRGioWm940e30xO57+a5h/wYY+jxNo+
	VskQLgamA8bhLjrZ0mypSU9UK+gDbEsggvnvxd3pi4YkM5mH6Aw85V5L6H/ZwQ==
X-Gm-Gg: AZFdTZf9YQDlHKjhAYBbwFhtIHaSq5Wn9sH1O6fegh9jP9V6gH+3rd5/0gN4ecZGTXj
	hYDn7kyACAT8847ktDcb2qTTKG8sUP7Ay6MFxly588DiOPvz3oT5+OXaLTIGVsuB9bQOdjTtSb8
	8oqf1Iu3J9RZXdHlDLoKa7KlLB2wAoIzpVuqUUvIgkI4bfGDgg3M5ss8G9p6e5hhGAhpYhx+2fb
	TwgL5PEf/Sw5hCT/cAWqLvZmi69s+WZFrBku5+tW9h1wag/fsGhEl3jTlNzCcXIhg7tVM3kfAeu
	YEl1Wy/Q2Vbo0JzLa3BJ3v1DVq9bTm0AWhgLx5XXy2ZTmowRKyFJuWDuZCSbFHm/J4AD5lZTDzm
	9l31vJRCvrlpCzatzEjnXljI/LDy3OsdxmqyoxEa0k4Xvm8UAfrBQQA/EApovs6aapJVvEXGf+R
	3rfA3pekGTe1dTvDYdh9vYsVC51CWh8cPFhDGEUno1LhVw/eH6Q6/mZwMB2nQ6cmj2fUMwmIA+R
	pHwWoMVecJH9DIDdSgd0MjO/sbmUS+gssvu4Ij3ngQRCo9M53hhB1Cs3JYOvy5CyQbNZoYDII1I
	+p/IdlcvIOv90+fdMwt98ayfRacPnVNoNMZBo3HJBRGMQfDOmNkGcc1lJEQT6X2kIlY0MTgKGTn
	0PmjwlqiXmeLROc6lYIksho4xt6xGQQvNx2HlzsOgY4CBwsXUtO+W2Hh3PLIS0e+fBVWaRpqeQp
	U=
X-Received: by 2002:a17:903:2410:b0:2e9:460e:ca4e with SMTP id d9443c01a7336-2f03efb1371mr49134025ad.1.1795207838877;
        Fri, 20 Nov 2026 12:50:38 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f118c88sm18815765ad.56.2026.11.20.12.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:50:38 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 06/49] bpf: Record what each insn reads and writes
Date: Fri, 20 Nov 2026 20:49:14 +0000
Message-ID: <20261120204959.614908-7-alexei.starovoitov@gmail.com>
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
index 9ae46e3a8d6..7977f8452e9 100644
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
 
 /* Where may_goto that the verifier adds goes, see check_loop_guard() */
 enum bpf_guard_edge {
@@ -858,10 +882,19 @@ struct bpf_insn_aux_data {
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
index 06bd1cd3d18..1c1aeec4069 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19836,6 +19836,7 @@ bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
 			if (fn->arg_type[i] == ARG_UNUSED)
 				break;
 			cs->arg_slot_cnt++;
+			cs->implicit_slot_cnt += fn->arg_type[i] == ARG_PTR_TO_PROG_AUX;
 		}
 		return true;
 	}
-- 
2.55.0

