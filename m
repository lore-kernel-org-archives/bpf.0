Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793583001;
	b=Z8YvkwpWxNyAjuk9Da5ehEbN8y+TVR6OU8k6C2ne423iN9jky1qjR6PgI9HbhZHoLpCg
	 n7irhmGBn3PMrrmMGylhzNE+1SImdBmWCwBszxzAIcx4R8J/R3h7y+o63hdxvQi5z0cGC
	 uvrtSB73z3gKSc9yLVOEsS+xnGSwe7hVDay9K7zKLNis70Z2d763Wkl9JWqMwNrSHvRvh
	 GGsDQOJcL4PSpyzgZBHEZFSpCCzsGrvEt/AqhIpjkU5z4KibnGRGzNupc6MjoMaK5qFED
	 /km+PBvPDcDbcW0r87OA/hnX0d0+8pLYVAlVlANVoo9qS2BXeaR21uaajWZiLDLl7ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793583001;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GERrYBq4XlxSR0MWwMjmqVJCX0NXXt1UYYKQYwv2fUI=;
	b=RGb6as1JeCzlut2pL1vJhDm8TpIa/V3OjjPNiyxOgDEv5WoBYxodYLant9qFqGeaYQ41
	 ZStMsmQ9h2a3vUM1vGDdyf7QUu0tP4T5Yp89ySaLUdZ8j0gH4Ao8xnGy3Ru3ZtDpuPqWY
	 PfgQy1ro2pfg2RZNZ38nXCf2Im2vEyb52LZhyhGHTlpRyv+vckd/f04P7C9ZqfVgAarbZ
	 mOxLJgN3BJ4MPWs9QHS4gObAcG04CSsIRoGQQeTWt/n4vb2p2OP1FwPwQMsy7pJt+scZt
	 daND/Lg3/6Rg2C3QIJGHOdtxZaadDA9dF2v3XMQtJwFXpzaOq8xL9ZlKyLW60/ZrGvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nvPhuyus;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8877606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 01:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8877606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nvPhuyus
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e9d7791b00so18144775ad.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 17:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793583000; x=1794187800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GERrYBq4XlxSR0MWwMjmqVJCX0NXXt1UYYKQYwv2fUI=;
        b=nvPhuyus0x7M7I5tGwgInstkhgbd+XM/QPRALmf1kHMLC/Yzk/hEpdx87UA4g7Y7Hd
         SwB++khEGQM/eivS7BOEbGNax4sZ0goVv15Gb2TYZv2uyxzmcDR19t/zfa3c48J7OB6j
         ZBfZbx2J8EBBQZdu2hmAERMMFucxCvFFF/RaezgCUrQUpWJWWunmh3SLn/p0tcc2CHMv
         DipWLq5IaVuoOUiDsZq4znX1E7BExQ1iyc54eoPq+fqibDqQro6bIy1xqRwh/1aTuC16
         9Up7tpb1nvl3SjjYd6Uu8xJEQ235gQnHFaQSeF/c8cpmh9kgaoOqJ6INSEm+lV/KhSKx
         t6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793583000; x=1794187800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GERrYBq4XlxSR0MWwMjmqVJCX0NXXt1UYYKQYwv2fUI=;
        b=sJ446KcFzFlciVPdMM701Tqeph02LFAlUybhXJsFgw1N/7tj5MpmTzT5heiO1dyUbZ
         pVAJoQzrXXtmV3QwpFh1GjmR764cdP2PXLHVf+3OxYbU7RTKsg6lzL2YFj97z7iO9H0t
         jYYKEMXaILLerd/HmUs5B3QqgauP/cp2ZA0rLxgfomxQLs7BoDDIBY5ZJrZ1ZHSbhqWF
         0qfRiYCnp3zqXQPXKu0ssBHatzIKog9PJZ+ECQHjGmddcwmA2tcKn+j+bWTJlwN0WB31
         OHA6lVQq0GWs91Whlwk3gCKSTqcIWsfIJ93fnP0et6Z0NxZ77enIlS5G0REDnbH1FyBI
         QUGA==
X-Gm-Message-State: APuU4Z/bVtghVI9Ehi0s8unYjWKIDJzPSFNSqSdx/42NA48gzKUzYdWC
	Qw/tvZKikHM8zT1oN/aZgvFP47/MuNtyNaNnSgmykqYQfdzeFUg5wtcW8i24mw==
X-Gm-Gg: AYBFou1REUfSL/RC0tH7q5Ky9RuXAgupkxkGnQeh6qpjvUewf+LzBgJcdkZw332TaN4
	MDw/P3ugG/qKf7ngZ2nhf9bYF/7Q6QbkXT64hOhzGIi6CD8T5DPGI5+PHwSj3CjL1FiyohMEu1b
	DxzyIzVpMgM1kylGeP7hv/Msr13lI+KIyxaCeDz6iAZc1kGneJXP4JQ8/Z95n0WzLdNyk+DnnIG
	avJJ0gVIEsS7mMzjK0X3LG0XFHxePqxavyGU2qAzu6K2wD50Gy0Uhp5+jL0HJJltxJJgus1dKRQ
	jC+Vhe0ZlbNucWBIc23dd/WX9Jbca212TL5H5B+oiEowZ9K7Hr0tQWJPm/ftxvW4Ub0tF9inkCw
	ZGP6oAaxX52qxWY1xH3vVd+2CfOfR0557NCLetgKboDzy9myiRQntW9KMl6Kcy7ohPxlWKq3KaU
	afO2xyWsJIiOwNe7uy+aFUIzzSWPReZxsjxh6E3cfnpLjYYSBniFCA2jzdbgjRhjS465BKKzSNb
	grGiCweN632Pbw9iIle++3RdU2f/e1muykkQgYVEAfV7gi3dxN7tQHExcWr5ZdVp38RbrOKpOl4
	xiFJpsZH8YU099o0RI+ejk+DCY2PpdYlVooPOpn0sEsQWO/4U6Dss1SdF/p4bah1fd3ThSmvDWH
	clj6DMhSBliPQu/0e1tJsHuUvx9nfpYqmPDwzIAcX9po+vW7U1VPBXRgkoO9xax+4BWLIOc9ZlA
	==
X-Received: by 2002:a17:903:240e:b0:2df:b250:ad9a with SMTP id d9443c01a7336-2eb364dded7mr76885005ad.48.1793583000073;
        Sun, 01 Nov 2026 17:30:00 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392baf3dsm19737225ad.76.2026.11.01.17.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 17:29:59 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	odys.yuan@gmail.com
Subject: [PATCH bpf-next v3 03/13] bpf: Queue the rewrites of bpf_do_misc_fixups()
Date: Mon,  2 Nov 2026 01:29:30 +0000
Message-ID: <20261102012940.1756142-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102012940.1756142-1-alexei.starovoitov@gmail.com>
References: <20261102012940.1756142-1-alexei.starovoitov@gmail.com>
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

From: Qiliang Yuan <odys.yuan@gmail.com>

The main loop of bpf_do_misc_fixups() patches divisions, may_goto, calls of
helpers and more. It calls bpf_patch_insn_data() for each patch, and each
call costs O(N) in a prog of N insns.

Queue the patches in the patch list with bpf_patch_list_add(). One commit
behind the loop, before the setup of the may_goto count, builds the new
image in O(N + inserted insns). No insn moves while the loop runs. Thus the
loop uses old indexes only: 'i + delta' becomes 'i'.

Some patches end with a call of a helper. The code at patch_call_imm then
writes the address of the helper to that call. It writes to the queued copy
of the call, which bpf_patch_list_add() returns. Thus 'insn' can point into
the list, and the loop sets it from the index before the next insn.

The patch of may_goto goes to the target with a conditional jump, which has
a 16-bit offset. When that offset is out of range, the patch uses 'gotol'.
The loop selects the jump when it queues the patch, but the offset is final
only at the commit. Each patch between may_goto and its target makes the
offset longer by its growth. The growth of a patch is its length - 1.

  may_goto  patches between it and its target  offset that selects the jump
  --------  ---------------------------------  ----------------------------
  backward  all are queued                     old offset - their growth
  forward   none is queued                     old offset

New may_goto_off() calculates the first row. In the second row the jump can
get out of range at the commit. Then the load fails, as it does with
bpf_patch_insn_data().

What users can see:
 - A jump that patches push out of its 16-bit range fails the load with
   -ERANGE, not with -ENOMEM. The message names the jump, not the patched
   insn: "insn %d cannot be patched due to 16-bit range". For a jump in a
   patch, as the one of may_goto, it names the insn that the patch
   replaces.
 - A backward may_goto that patches push beyond -32768 loads. Before this
   patch the load fails.

Wall time of 'veristat -q <obj>' in an x86_64 VM with 8 vCPUs, mean of 30
runs, before and after this patch:

              before     after
  pyperf180   0.147 s    0.083 s
  pyperf600   0.430 s    0.219 s

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/fixups.c | 294 ++++++++++++++++++--------------------------
 1 file changed, 118 insertions(+), 176 deletions(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index aee645cbb63b..0a5b35a00f9f 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1969,18 +1969,21 @@ static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *pat
 /*
  * Expand may_goto: load the count from the stack, jump to the target of
  * may_goto when it is zero, then the tail that updates the count.
- * Use gotol when the target is too far for 16-bit offset of a conditional jump.
+ * 'off' is the offset of may_goto, 'reach' how far it jumps once the patches
+ * queued so far are applied, see may_goto_off().
+ * Use gotol when 'reach' is too far for 16-bit offset of a conditional jump.
  */
-static int may_goto_expand(struct bpf_insn *insn_buf, int off, int stack_off,
-			   const struct bpf_insn *tail, int tail_cnt)
+static int may_goto_expand(struct bpf_insn *insn_buf, int off, int reach,
+			   int stack_off, const struct bpf_insn *tail, int tail_cnt)
 {
 	int cnt = 0;
 
 	/* Forward jump has to step over the tail */
 	off = off >= 0 ? off + tail_cnt : off - 1;
+	reach = reach >= 0 ? reach + tail_cnt : reach - 1;
 
 	insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_10, stack_off);
-	if (off == (s16)off) {
+	if (reach == (s16)reach) {
 		insn_buf[cnt++] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, off);
 	} else {
 		insn_buf[cnt++] = BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 1);
@@ -1990,6 +1993,27 @@ static int may_goto_expand(struct bpf_insn *insn_buf, int off, int stack_off,
 	return cnt + tail_cnt;
 }
 
+/*
+ * The offset of may_goto at 'idx' once the patches queued in front are applied.
+ * The patches that a forward may_goto jumps over aren't queued yet, so its
+ * offset stays as it is.
+ */
+static int may_goto_off(struct bpf_verifier_env *env, const struct bpf_insn *insn,
+			u32 idx)
+{
+	struct bpf_patch_list *pl = &env->patch_list;
+	u32 tgt = idx + insn->off + 1;
+	int off = insn->off;
+	u32 k = pl->cnt;
+
+	if (off >= 0)
+		return off;
+	/* all queued patches are in front of idx */
+	while (k > 0 && pl->patches[k - 1].off >= tgt)
+		off -= pl->patches[--k].len - 1;
+	return off;
+}
+
 /* Do various post-verification rewrites in a single program pass.
  * These rewrites simplify JIT and interpreter implementations.
  */
@@ -2006,7 +2030,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 	struct bpf_insn *insn_buf = env->insn_buf;
 	struct bpf_prog *new_prog;
 	struct bpf_map *map_ptr;
-	int i, ret, cnt, delta = 0, cur_subprog = 0;
+	int i, ret, cnt, cur_subprog = 0;
 	struct bpf_subprog_info *subprogs = env->subprog_info;
 	u16 stack_depth = subprogs[cur_subprog].stack_depth;
 	u16 stack_depth_extra = 0;
@@ -2038,7 +2062,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		}
 
-		if (env->insn_aux_data[i + delta].needs_zext)
+		if (env->insn_aux_data[i].needs_zext)
 			/* Convert BPF_CLASS(insn->code) == BPF_ALU64 to 32-bit ALU */
 			insn->code = BPF_ALU | BPF_OP(insn->code) | BPF_SRC(insn->code);
 
@@ -2061,13 +2085,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 
 			cnt = patch - insn_buf;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2152,13 +2172,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				cnt = patch - insn_buf;
 			}
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2182,13 +2198,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			*patch++ = BPF_MOV64_IMM(insn->dst_reg, 0);
 
 			cnt = patch - insn_buf;
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2202,13 +2214,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				return -EFAULT;
 			}
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2221,7 +2229,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			bool issrc, isneg, isimm;
 			u32 off_reg;
 
-			aux = &env->insn_aux_data[i + delta];
+			aux = &env->insn_aux_data[i];
 			if (!aux->alu_state ||
 			    aux->alu_state == BPF_ALU_NON_POINTER)
 				goto next_insn;
@@ -2255,13 +2263,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				*patch++ = BPF_ALU64_IMM(BPF_MUL, off_reg, -1);
 			cnt = patch - insn_buf;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2295,16 +2299,13 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			 * after subtraction, rinse and repeat.
 			 */
 			stack_depth_extra = 16;
-			cnt = may_goto_expand(insn_buf, insn->off, stack_off_cnt,
-					      tail, ARRAY_SIZE(tail));
-
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
+			cnt = may_goto_expand(insn_buf, insn->off,
+					      may_goto_off(env, insn, i),
+					      stack_off_cnt, tail, ARRAY_SIZE(tail));
 
-			delta += cnt - 1;
-			env->prog = prog = new_prog;
-			insn = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		} else if (bpf_is_may_goto_insn(insn)) {
 			int stack_off = -stack_depth - 8;
@@ -2314,16 +2315,13 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			};
 
 			stack_depth_extra = 8;
-			cnt = may_goto_expand(insn_buf, insn->off, stack_off,
-					      tail, ARRAY_SIZE(tail));
-
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
+			cnt = may_goto_expand(insn_buf, insn->off,
+					      may_goto_off(env, insn, i),
+					      stack_off, tail, ARRAY_SIZE(tail));
 
-			delta += cnt - 1;
-			env->prog = prog = new_prog;
-			insn = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2333,7 +2331,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		     insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE)) {
 			struct bpf_map *map;
 
-			aux = &env->insn_aux_data[i + delta];
+			aux = &env->insn_aux_data[i];
 			map = env->used_maps[aux->map_index];
 			if (map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY)
 				goto next_insn;
@@ -2344,7 +2342,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			 * We are *skipping* first half of ld_imm64 insn
 			 * with 'i++;', patching over second half of it
 			 * with that same half + mov64_percpu_reg insn.
-			 * All because bpf_patch_insn_data() can only
+			 * All because a patch can only
 			 * replace one 8-byte insn, which does not work
 			 * well for ld_imm64 insn.
 			 */
@@ -2354,13 +2352,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			cnt = 2;
 
 			i++;
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2369,19 +2363,15 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		if (insn->src_reg == BPF_PSEUDO_CALL)
 			goto next_insn;
 		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
-			ret = bpf_fixup_kfunc_call(env, insn, insn_buf, i + delta, &cnt);
+			ret = bpf_fixup_kfunc_call(env, insn, insn_buf, i, &cnt);
 			if (ret)
 				return ret;
 			if (cnt == 0)
 				goto next_insn;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta	 += cnt - 1;
-			env->prog = prog = new_prog;
-			insn	  = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2420,7 +2410,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn->imm = 0;
 			insn->code = BPF_JMP | BPF_TAIL_CALL;
 
-			aux = &env->insn_aux_data[i + delta];
+			aux = &env->insn_aux_data[i];
 			if (env->bpf_capable && !prog->blinding_requested &&
 			    prog->jit_requested &&
 			    !bpf_map_key_poisoned(aux) &&
@@ -2430,7 +2420,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 					.reason = BPF_POKE_REASON_TAIL_CALL,
 					.tail_call.map = aux->map_ptr_state.map_ptr,
 					.tail_call.key = bpf_map_key_immediate(aux),
-					.insn_idx = i + delta,
+					.insn_idx = i,
 				};
 
 				ret = bpf_jit_add_poke_descriptor(prog, &desc);
@@ -2466,17 +2456,13 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 								 map)->index_mask);
 			insn_buf[2] = *insn;
 			cnt = 3;
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
-		aux = &env->insn_aux_data[i + delta];
+		aux = &env->insn_aux_data[i];
 		if (aux->arg_prog) {
 			/* The verifier will process callback_fn as many times as necessary
 			 * with different maps and the register states prepared by
@@ -2500,18 +2486,14 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[2] = *insn;
 			cnt = 3;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto patch_call_imm;
 		}
 
 		/* bpf_per_cpu_ptr() and bpf_this_cpu_ptr() */
-		if (env->insn_aux_data[i + delta].call_with_percpu_alloc_ptr) {
+		if (env->insn_aux_data[i].call_with_percpu_alloc_ptr) {
 			/* patch with 'r1 = *(u64 *)(r1 + 0)' since for percpu data,
 			 * bpf_mem_alloc() returns a ptr to the percpu data ptr.
 			 */
@@ -2519,13 +2501,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[1] = *insn;
 			cnt = 2;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta += cnt - 1;
-			env->prog = prog = new_prog;
-			insn = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto patch_call_imm;
 		}
 
@@ -2543,7 +2521,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		     insn->imm == BPF_FUNC_redirect_map    ||
 		     insn->imm == BPF_FUNC_for_each_map_elem ||
 		     insn->imm == BPF_FUNC_map_lookup_percpu_elem)) {
-			aux = &env->insn_aux_data[i + delta];
+			aux = &env->insn_aux_data[i];
 			if (bpf_map_ptr_poisoned(aux))
 				goto patch_call_imm;
 
@@ -2562,14 +2540,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				if (bpf_map_is_percpu_map(map_ptr->map_type))
 					prog->jit_required = true;
 
-				new_prog = bpf_patch_insn_data(env, i + delta,
-							       insn_buf, cnt);
-				if (!new_prog)
-					return -ENOMEM;
-
-				delta    += cnt - 1;
-				env->prog = prog = new_prog;
-				insn      = new_prog->insnsi + i + delta;
+				insn = bpf_patch_list_add(env, i, insn_buf, cnt);
+				if (IS_ERR(insn))
+					return PTR_ERR(insn);
 				goto next_insn;
 			}
 
@@ -2645,14 +2618,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 						  BPF_REG_0, 0);
 			cnt = 3;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
-						       cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2675,13 +2643,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[0] = BPF_ALU32_REG(BPF_XOR, BPF_REG_0, BPF_REG_0);
 			cnt = 1;
 #endif
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2694,13 +2658,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[2] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
 			cnt = 3;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 #endif
@@ -2728,13 +2688,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[cnt++] = BPF_JMP_A(1);
 			insn_buf[cnt++] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2760,13 +2716,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				cnt = 1;
 			}
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2786,13 +2738,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				cnt = 2;
 			}
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2802,12 +2750,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			/* Load IP address from ctx - 16 */
 			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -16);
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
-			if (!new_prog)
-				return -ENOMEM;
-
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i, insn_buf, 1);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2857,13 +2802,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[10] = BPF_MOV64_IMM(BPF_REG_0, -ENOENT);
 			cnt = 11;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2875,13 +2816,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[1] = BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_1, BPF_REG_0, 0);
 			cnt = 2;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 patch_call_imm:
@@ -2897,7 +2834,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		}
 		insn->imm = BPF_CALL_IMM(fn->func);
 next_insn:
-		if (subprogs[cur_subprog + 1].start == i + delta + 1) {
+		if (subprogs[cur_subprog + 1].start == i + 1) {
 			subprogs[cur_subprog].stack_depth += stack_depth_extra;
 			subprogs[cur_subprog].stack_extra = stack_depth_extra;
 
@@ -2912,9 +2849,14 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			stack_depth_extra = 0;
 		}
 		i++;
-		insn++;
+		insn = &prog->insnsi[i];
 	}
 
+	ret = bpf_patch_list_commit(env);
+	if (ret)
+		return ret;
+	prog = env->prog;
+
 	env->prog->aux->stack_depth = subprogs[0].stack_depth;
 	for (i = 0; i < env->subprog_cnt; i++) {
 		int delta = bpf_jit_supports_timed_may_goto() ? 2 : 1;
-- 
2.55.0

