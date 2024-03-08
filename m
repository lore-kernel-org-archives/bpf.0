Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F2721344
	for <bpf@vger.kernel.org>; Fri,  8 Mar 2024 01:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709860113; cv=none; b=Av+B7doU0OycWmPfmhrhZ1Es0VqIIvUsIAF8dmf3DP7A/HEvxsfh5PK9JqevNmoYy/yzwU/SQczDlyXbdMz/tHLxHq5m3ebxS0AOzgCqrZwrfqOGlXFeLuViY4+z4/bdpMTSBJKFxZHUGv7aaU1IAc+Ch9ZnMNzWmg5xWq1BoxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709860113; c=relaxed/simple;
	bh=oJSNW/hmaPm3fO5cI8Q//O98lVu1sQcq/IZz6B3w3RA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BkKOrSLm0EnJCiGraNktgXswNPJMvz53O5yONKiH7JsDpiDPPkOqB841t6dS97vgk5r4hCCivU8K/96MNTFdvFq7bzNWTY8x3OrvYvgGn9/LqLjxIKAJAPn91lO/zen3YJWdGDRhu7cck114naQ+86t2YM1W5zScCjcLrELaaXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhGL3VbT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhGL3VbT"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dd611d5645so6531315ad.1
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 17:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709860110; x=1710464910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lNO6MUM1XQN/fA7/+ZFYcvnsx/bodyKeSUW0Kv64/w=;
        b=hhGL3VbTeNBsEyOIfnV7q54SbxvzETG3H9X8UdpI1an7o8RMVwM1cBI43iD84EFldI
         xq8PRCw1v5uvK1U+EBVK5VVgI+odPiCE41ZImjZy5VxLtGQQtH7vAfz5xHaqxxVOn1jk
         gLHb8a6iedEVrcCUkmT+bJ93Bnvzvndcf6aZzPjoATJwD/ieGPZACSfiGiOlLpIelGN4
         Bh1e6Ms2sKUK4VddS9JkV6rmWyoo05n6vl2DT5PUuJoPjL/gH39xukP2Tzts/89vKV6s
         3g65SbyAhtdPeuQi+2MJRaZKZN4eBjvHFt1dh69j0xYDhbP01/r4Qf/G+/MV6XOuVVTF
         6whA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709860110; x=1710464910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lNO6MUM1XQN/fA7/+ZFYcvnsx/bodyKeSUW0Kv64/w=;
        b=tsuICK5L2XB1/MOG5PaCOIPKry4rGA6YbQXKE/8mJaL/X7ms+1fUxxnnz9DJSt30hV
         7SfH8elLcEz/2JnxCybeRApb9Dt/2LXC26SRt988GO1QoSnaEcf8GURgNxGWPPotWHMi
         BQHQJq/r0MwPq5xsQrbssi4KZK2YJZBaX248tJQzQSdAcx/f7V7hzLeo9jccZm5VZ//A
         u9ngc1FSYxx5LnC2NvDYhdXeJYDfA5AjMywkT0P8FhpEQ61rszcc2n9etriBlEyvZen8
         HwRj5TxYcwp5rN350xScmL7ypy5sjFyCWdWLdPBM/kKURa6QVXHWrNzdqRjZ0DEeFYKQ
         zqzw==
X-Gm-Message-State: AOJu0YxAkmJhgY72agxRc/MD4o5IE85PepcjxmK4XNes2ugDDfhvrnHT
	Nz3VLfkGaZpu3XbaVvUIilwODqWqL9MQEITZPYhlzCgKkhomM9VojuGEr/ln
X-Google-Smtp-Source: AGHT+IH3LmY8um4QfWO9Vz5IlIKIu4RcjPZ/VOanHoOrMmCGtDlzXHJV3149i9SmiZdoH8wCtAcUkw==
X-Received: by 2002:a17:902:d511:b0:1dd:91c:249f with SMTP id b17-20020a170902d51100b001dd091c249fmr4447234plg.24.1709860110405;
        Thu, 07 Mar 2024 17:08:30 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:428c])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709026f0100b001dd66642652sm360454plk.190.2024.03.07.17.08.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Mar 2024 17:08:30 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	torvalds@linux-foundation.org,
	brho@google.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 04/14] bpf: Add x86-64 JIT support for bpf_addr_space_cast instruction.
Date: Thu,  7 Mar 2024 17:08:02 -0800
Message-Id: <20240308010812.89848-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
References: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

LLVM generates bpf_addr_space_cast instruction while translating
pointers between native (zero) address space and
__attribute__((address_space(N))).
The addr_space=1 is reserved as bpf_arena address space.

rY = addr_space_cast(rX, 0, 1) is processed by the verifier and
converted to normal 32-bit move: wX = wY

rY = addr_space_cast(rX, 1, 0) has to be converted by JIT:

aux_reg = upper_32_bits of arena->user_vm_start
aux_reg <<= 32
wX = wY // clear upper 32 bits of dst register
if (wX) // if not zero add upper bits of user_vm_start
  wX |= aux_reg

JIT can do it more efficiently:

mov dst_reg32, src_reg32  // 32-bit move
shl dst_reg, 32
or dst_reg, user_vm_start
rol dst_reg, 32
xor r11, r11
test dst_reg32, dst_reg32 // check if lower 32-bit are zero
cmove r11, dst_reg	  // if so, set dst_reg to zero
			  // Intel swapped src/dst register encoding in CMOVcc

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 42 ++++++++++++++++++++++++++++++++++++-
 include/linux/filter.h      |  1 +
 kernel/bpf/core.c           |  5 +++++
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 38705a1abe62..27058d7395f6 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1276,13 +1276,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 	bool tail_call_seen = false;
 	bool seen_exit = false;
 	u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
-	u64 arena_vm_start;
+	u64 arena_vm_start, user_vm_start;
 	int i, excnt = 0;
 	int ilen, proglen = 0;
 	u8 *prog = temp;
 	int err;
 
 	arena_vm_start = bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
+	user_vm_start = bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
 
 	detect_reg_usage(insn, insn_cnt, callee_regs_used,
 			 &tail_call_seen);
@@ -1350,6 +1351,40 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 			break;
 
 		case BPF_ALU64 | BPF_MOV | BPF_X:
+			if (insn->off == BPF_ADDR_SPACE_CAST &&
+			    insn->imm == 1U << 16) {
+				if (dst_reg != src_reg)
+					/* 32-bit mov */
+					emit_mov_reg(&prog, false, dst_reg, src_reg);
+				/* shl dst_reg, 32 */
+				maybe_emit_1mod(&prog, dst_reg, true);
+				EMIT3(0xC1, add_1reg(0xE0, dst_reg), 32);
+
+				/* or dst_reg, user_vm_start */
+				maybe_emit_1mod(&prog, dst_reg, true);
+				if (is_axreg(dst_reg))
+					EMIT1_off32(0x0D,  user_vm_start >> 32);
+				else
+					EMIT2_off32(0x81, add_1reg(0xC8, dst_reg),  user_vm_start >> 32);
+
+				/* rol dst_reg, 32 */
+				maybe_emit_1mod(&prog, dst_reg, true);
+				EMIT3(0xC1, add_1reg(0xC0, dst_reg), 32);
+
+				/* xor r11, r11 */
+				EMIT3(0x4D, 0x31, 0xDB);
+
+				/* test dst_reg32, dst_reg32; check if lower 32-bit are zero */
+				maybe_emit_mod(&prog, dst_reg, dst_reg, false);
+				EMIT2(0x85, add_2reg(0xC0, dst_reg, dst_reg));
+
+				/* cmove r11, dst_reg; if so, set dst_reg to zero */
+				/* WARNING: Intel swapped src/dst register encoding in CMOVcc !!! */
+				maybe_emit_mod(&prog, AUX_REG, dst_reg, true);
+				EMIT3(0x0F, 0x44, add_2reg(0xC0, AUX_REG, dst_reg));
+				break;
+			}
+			fallthrough;
 		case BPF_ALU | BPF_MOV | BPF_X:
 			if (insn->off == 0)
 				emit_mov_reg(&prog,
@@ -3432,6 +3467,11 @@ void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
 	}
 }
 
+bool bpf_jit_supports_arena(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_ptr_xchg(void)
 {
 	return true;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index b119f04ecb0b..c99bc3df2d28 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -962,6 +962,7 @@ bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_jit_supports_exceptions(void);
 bool bpf_jit_supports_ptr_xchg(void);
+bool bpf_jit_supports_arena(void);
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie);
 bool bpf_helper_changes_pkt_data(void *func);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index a8ecf69c7754..bdbdc75cdcd5 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2932,6 +2932,11 @@ bool __weak bpf_jit_supports_far_kfunc_call(void)
 	return false;
 }
 
+bool __weak bpf_jit_supports_arena(void)
+{
+	return false;
+}
+
 /* Return TRUE if the JIT backend satisfies the following two conditions:
  * 1) JIT backend supports atomic_xchg() on pointer-sized words.
  * 2) Under the specific arch, the implementation of xchg() is the same
-- 
2.43.0

