Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793583032;
	b=oib0NYXUlaHAFZ/eNJXqtsvAOVkRSiuUfzrAIuydk/GPI1oPY8xEv/AKG9aDWC3DBaw+
	 1pGbWzXJfyjSgCiHjLqHlbq73haTewTHkBBMC9nELL5q7Y57bPGxCnWylJvbYAY/5OmkJ
	 GMw936/IG/bECDEslxb2dHN6n8Vcvus8a3lY1GfKC8aNtkKr3pIdHDoijgV4E491bXuqe
	 QxWX5KTfIuGQfE0/43uXVJ8BwElHpdlGiWTzQXYCYOvoNO9aPmahlSy7Ls/ScXPf2Ssgt
	 EnklDdbFUT+x6mOux6dujN8VrgkLRLiqK9w5V/MsMWO9ctzuchIUvdAsOlD8fbkzkwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793583032;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oKkxh+oCXMZObQBpyjNzLLk7fMSBA49e/1/H9whFDSg=;
	b=knxqhiWv0E5WbfZZsCjJLRJ2Pv97osiCfZJssJAmdG6yMpmNX6kl6GT5U53x9fKedY/d
	 q+yYbfQiOzj5dp9PBLBGxFCE9EIZrg8j2AZpOt3fw92OQ1fOsRO6R+VJzsotWS2EL3CN4
	 2dbHeIikeGPkt+TmiMFEh9zzAb9XG0FoVdLIfvzEaDVPo2171fVDmXIWtq9o5f0vym6C4
	 dEpcYYHWJmUslL0AJQHdLjgdLVwhN73Cnr6jmAzi7bfQ4JabmXX0omgDpjivzt5dJ7i8q
	 5ivhW5h22orEqvkeSp8g8+5JQxzr0xVsaZ1Vv9ENslBzMmkH8fU1Y+LXmKDEAwa0vYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TGENWmEa;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ED6606A327
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 01:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24ED6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TGENWmEa
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a06ca6e8f4so1564942b3a.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 17:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793583031; x=1794187831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oKkxh+oCXMZObQBpyjNzLLk7fMSBA49e/1/H9whFDSg=;
        b=TGENWmEakToiv2vmngSUJmXFlr8V66BG05khs+H6uIMX9ToGWcdAUanC39Bu4QDvn8
         eJLaOUAfvSkSul3EjUXKM0pokUjiQ5+u4t7MiM3TRKncTP0gDVpVRhewjjyyQFoyT4q4
         hh+F2jVYjhzG08Dj7VjE/wEnd9EpDcFYsd8xg12P+jRUnoW+iLqJ5yiDM306vpdEXSgT
         bvaMQt5WomKfgXUlcPOHI6kaqwnOdLXZVTVOkM9iLGCF+EW3rGyTycpPKgvWnEl+lmOM
         IIWpqWG9CdEyd8slEBUv67T/iVY6DRv/HI+ds4Iyi31WW/5MXqzWJDCvlrFko1VUP2vA
         0w6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793583031; x=1794187831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oKkxh+oCXMZObQBpyjNzLLk7fMSBA49e/1/H9whFDSg=;
        b=dQoyIpvSQJfpNG8MAlmA3yaPUcpxPiKwU4VLPRyTnWj0GAJzH5XCYf9miVP6N19XlY
         BZWllrRzQixsaMtpG6XBdZdwOTgtZojGlpStPylDBHWo1oP6DvxA54r0MaqKAF7acHaW
         LTemlekRxYbpg7pweLkLimdRnbl7GlVWdWO52BSksq4fNbPK/2xtA3kB3OXi6ghzgvYv
         jr8YAkk6Kb+bCrzBzcr24cu/Ojgeit/EJXHkdwZu32oXCZuznvMv1xPNacRBSMT6+YFU
         +b0d6N74FVn+jZu8gbvkSOKC5fevPSTmcx8h6a7J2DlKXJuTvQYTWgabW4xefPEptxFj
         Ej1g==
X-Gm-Message-State: APuU4Z8zVG8XhLrCyOnTSjPso/NDyCufQaQXk2aWdxTv8dvPBPkz27fI
	vX+K3reeWPUEXtiG42P5BiL74t/6dTUo22QBSLx7yH0apruv/jR/ggIiq4tLAA==
X-Gm-Gg: AYBFou2OWdpoavCk9lorZI2J5By1hzFdxlOs6m8jRSM46lyqzwE+zJavcOYgFEdXI4X
	drg/H2WiDqMoLuOysj6mVkyIg5ts16BscQ58FOUTWetPwyYBIT5lPhy/YFgm5c1BGwHA7oRju71
	MkY0U2Cm9lxKdj/W4cJJ+A+IZglBpPSy1jdva8C0drLxY+gaZ6m4DWbkY39caW8FCIiLpFjX/kS
	qvKtD6FCRjvW8GwO6waU7aTyjYGrwVjUS5/2Ya6ouSRLHMYdlbcmNZVIVIKiPPKAhTmm1DC1AUo
	BjzWHOZjh1NLUqrXHNHJDl479UWEezOGjVSxs2/mex1tw5efMYGR4UMbEQfCDkrxqLrHbdRGRzx
	Se1JNbjboaab11fdqKS7DgJJ48XWXauQ6PlNbT7Ssb7tw2hoCTi8f4fV0XQbOM00YCjdpnacOUt
	HwJfDG2FxkKORyf9IQQMSJqXpQKJ19ESWziTdEL2vL7Zr5I3STRVuhhQExko2zHINRACzwQnH4r
	lhBeVi0pR7ixBPYXSREAsJ5hTxKWVbeTMa/adtN84JEZEXsuCz8IMK6q+AnhLzIMl8tR15oFcTj
	5+yw8up+sBdChb4/8kRLlRzTkXtjLh/hIXjEs89edJK/fJ2sNBCZ2RBrvtN167yc+czOexEkrlB
	HFzU6Xnk83N0dFqsaoFlFXBS7yROryppfQzSpr+THuGamX3uP+UqBXTR5qr1bpn07ShrFz+a7kg
	I=
X-Received: by 2002:a05:6a00:2e8f:b0:8a0:1c79:b442 with SMTP id d2e1a72fcca58-8a9b69872fbmr7832377b3a.0.1793583031325;
        Sun, 01 Nov 2026 17:30:31 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad963d6acsm1318151b3a.18.2026.11.01.17.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 17:30:30 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	odys.yuan@gmail.com
Subject: [PATCH bpf-next v3 08/13] bpf: Move bpf_convert_ctx_accesses() to the patch list
Date: Mon,  2 Nov 2026 01:29:35 +0000
Message-ID: <20261102012940.1756142-9-alexei.starovoitov@gmail.com>
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

bpf_convert_ctx_accesses() replaces each ctx access with insns that access
the kernel struct. It also adds barriers, and the prologue and the epilogue
of the prog type. It calls bpf_patch_insn_data() for each of them. Each
call costs O(N) in a prog of N insns.

Queue the changes in the patch list. A commit builds the new image of the
prog from the old image and the list. The pass needs two commits:

  insert   the store of ctx for the epilogue, in front of insn 0
  insert   the prologue, in front of the store
  commit
  loop     starts behind the inserted insns
           queue a patch: barrier, ctx access, epilogue
           write in place: for example BPF_MEM becomes BPF_PROBE_MEM
  commit

The first commit is necessary because of the writes in place.
bpf_patch_list_insert() puts a copy of insn 0 in the list, and the commit
takes the copy. A write to insn 0 of the old image would be lost.

What else is not mechanical:
 - gen_prologue() ends the prologue with a copy of the first insn of the
   prog. bpf_patch_list_insert() makes this copy. Thus insert the prologue
   without its last insn, after a check that it is this copy.
 - A barrier in front of an insn is a patch: 'nospec' and a copy of the
   insn. It is not inserted, because a jump to the insn must run the
   barrier. bpf_patch_list_add() returns the queued copy of the insn, and
   the loop continues with the copy. A write in place goes to the copy, and
   a second patch replaces it.
 - Only the first 'exit' of the main prog gets the epilogue. Each other
   'exit' becomes a 'gotol' back to it. The pass calculates the offset from
   old indexes, and the commit adjusts it.

What users can see:
 - A jump that gets out of range gives -ERANGE, and the message names the
   jump. Before this patch the pass returns -ENOMEM, and the message names
   the patched insn.
 - A jump back to insn 0 lands behind the inserted insns and keeps its
   offset. Before this patch the offset first gets longer by their number,
   and adjust_jmp_off() then restores it. Thus an offset near -32768 fails
   the load.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/fixups.c | 131 +++++++++++++++++++-------------------------
 1 file changed, 55 insertions(+), 76 deletions(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 147fcc4d2f43..9216b19370c3 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1098,13 +1098,11 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprogs = env->subprog_info;
 	const struct bpf_verifier_ops *ops = env->ops;
-	int i, cnt, size, ctx_field_size, ret, delta = 0, epilogue_cnt = 0;
-	const int insn_cnt = env->prog->len;
+	int i, cnt, size, ctx_field_size, ret, epilogue_cnt = 0, first = 0;
 	struct bpf_insn *epilogue_buf = env->epilogue_buf;
 	struct bpf_insn *insn_buf = env->insn_buf;
 	struct bpf_insn *insn;
 	u32 target_size, size_default, off;
-	struct bpf_prog *new_prog;
 	enum bpf_access_type type;
 	bool is_narrower_load;
 	int epilogue_idx = 0;
@@ -1117,17 +1115,13 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			return -EFAULT;
 		} else if (epilogue_cnt) {
 			/* Save the ARG_PTR_TO_CTX for the epilogue to use */
-			cnt = 0;
 			subprogs[0].stack_depth += 8;
-			insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_1,
-						      -subprogs[0].stack_depth);
-			insn_buf[cnt++] = env->prog->insnsi[0];
-			new_prog = __bpf_patch_insn_data(env, 0, insn_buf, cnt,
-							 BPF_PATCH_MOVE_TARGET);
-			if (!new_prog)
-				return -ENOMEM;
-			env->prog = new_prog;
-			delta += cnt - 1;
+			insn_buf[0] = BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_1,
+						  -subprogs[0].stack_depth);
+			ret = bpf_patch_list_insert(env, 0, insn_buf, 1);
+			if (ret)
+				return ret;
+			first++;
 
 			ret = add_kfunc_in_insns(env, epilogue_buf, epilogue_cnt - 1);
 			if (ret < 0)
@@ -1158,13 +1152,15 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 						   env->prog->aux->attach_btf_id))
 				return -EINVAL;
 			env->prog->aux->has_prologue = true;
-			new_prog = __bpf_patch_insn_data(env, 0, insn_buf, cnt,
-							 BPF_PATCH_MOVE_TARGET);
-			if (!new_prog)
-				return -ENOMEM;
-
-			env->prog = new_prog;
-			delta += cnt - 1;
+			/* the prologue ends with the first insn of the program */
+			if (verifier_bug_if(memcmp(&insn_buf[cnt - 1], env->prog->insnsi,
+						   sizeof(*insn_buf)), env,
+					    "prologue doesn't end with the first insn"))
+				return -EFAULT;
+			ret = bpf_patch_list_insert(env, 0, insn_buf, cnt - 1);
+			if (ret)
+				return ret;
+			first += cnt - 1;
 
 			ret = add_kfunc_in_insns(env, insn_buf, cnt - 1);
 			if (ret < 0)
@@ -1172,21 +1168,26 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 		}
 	}
 
-	if (delta)
-		WARN_ON(adjust_jmp_off(env->prog, 0, delta));
+	/*
+	 * The loop below rewrites some insns in place. No insn may have a queued
+	 * patch when the loop gets to it: the list holds a copy of the insn.
+	 */
+	ret = bpf_patch_list_commit(env);
+	if (ret)
+		return ret;
 
 	if (bpf_prog_is_offloaded(env->prog->aux))
 		return 0;
 
-	insn = env->prog->insnsi + delta;
-
-	for (i = 0; i < insn_cnt; i++, insn++) {
+	for (i = first; i < env->prog->len; i++) {
 		bpf_convert_ctx_access_t convert_ctx_access;
 		enum bpf_reg_type ptr_type;
 		u8 mode;
 
-		if (env->insn_aux_data[i + delta].nospec) {
-			WARN_ON_ONCE(env->insn_aux_data[i + delta].alu_state);
+		insn = &env->prog->insnsi[i];
+
+		if (env->insn_aux_data[i].nospec) {
+			WARN_ON_ONCE(env->insn_aux_data[i].alu_state);
 			struct bpf_insn *patch = insn_buf;
 
 			*patch++ = BPF_ST_NOSPEC();
@@ -1194,17 +1195,13 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			ret = bpf_adj_moved_insn(patch++, 1);
 			if (ret) {
 				verbose(env, "insn %d cannot be patched due to 16-bit range\n",
-					env->insn_aux_data[i + delta].orig_idx);
+					env->insn_aux_data[i].orig_idx);
 				return ret;
 			}
 			cnt = patch - insn_buf;
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			/* This can not be easily merged with the
 			 * nospec_result-case, because an insn may require a
 			 * nospec before and after itself. Therefore also do not
@@ -1234,32 +1231,28 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			    insn->code == (BPF_STX | BPF_ATOMIC | BPF_H) ||
 			    insn->code == (BPF_STX | BPF_ATOMIC | BPF_W) ||
 			    insn->code == (BPF_STX | BPF_ATOMIC | BPF_DW)) &&
-			   env->insn_aux_data[i + delta].ptr_type == PTR_TO_ARENA) {
+			   env->insn_aux_data[i].ptr_type == PTR_TO_ARENA) {
 			insn->code = BPF_STX | BPF_PROBE_ATOMIC | BPF_SIZE(insn->code);
 			env->prog->aux->num_exentries++;
 			continue;
 		} else if (insn->code == (BPF_STX | BPF_ATOMIC | BPF_DW) &&
 			   insn->imm == BPF_LOAD_ACQ &&
-			   env->insn_aux_data[i + delta].arena_member) {
+			   env->insn_aux_data[i].arena_member) {
 			/* an acquire load of an __arena member is rewritten like a plain load */
-			cnt = arena_member_fixup(env, i + delta, insn, insn_buf);
+			cnt = arena_member_fixup(env, i, insn, insn_buf);
 			if (cnt < 0)
 				return cnt;
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			continue;
 		} else if (insn->code == (BPF_JMP | BPF_EXIT) &&
 			   epilogue_cnt &&
-			   i + delta < subprogs[1].start) {
+			   i < subprogs[1].start) {
 			/* Generate epilogue for the main prog */
 			if (epilogue_idx) {
 				/* jump back to the earlier generated epilogue */
-				insn_buf[0] = BPF_JMP32_A(epilogue_idx - i - delta - 1);
+				insn_buf[0] = BPF_JMP32_A(epilogue_idx - i - 1);
 				cnt = 1;
 			} else {
 				memcpy(insn_buf, epilogue_buf,
@@ -1269,7 +1262,7 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 				 * least one ctx ptr saving insn before the
 				 * epilogue.
 				 */
-				epilogue_idx = i + delta;
+				epilogue_idx = i;
 			}
 			goto patch_insn_buf;
 		} else {
@@ -1277,7 +1270,7 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 		}
 
 		if (type == BPF_WRITE &&
-		    env->insn_aux_data[i + delta].nospec_result) {
+		    env->insn_aux_data[i].nospec_result) {
 			/* nospec_result is only used to mitigate Spectre v4 and
 			 * to limit verification-time for Spectre v1.
 			 */
@@ -1286,17 +1279,13 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			*patch++ = *insn;
 			*patch++ = BPF_ST_NOSPEC();
 			cnt = patch - insn_buf;
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			continue;
 		}
 
-		ptr_type = env->insn_aux_data[i + delta].ptr_type;
+		ptr_type = env->insn_aux_data[i].ptr_type;
 		switch ((int)ptr_type) {
 		case PTR_TO_CTX:
 			if (!ops->convert_ctx_access)
@@ -1349,22 +1338,18 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 				return -EFAULT;
 			}
 
-			cnt = arena_member_fixup(env, i + delta, insn, insn_buf);
+			cnt = arena_member_fixup(env, i, insn, insn_buf);
 			if (cnt < 0)
 				return cnt;
 			if (!cnt)
 				continue;
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			continue;
 		}
 
-		ctx_field_size = env->insn_aux_data[i + delta].ctx_field_size;
+		ctx_field_size = env->insn_aux_data[i].ctx_field_size;
 		size = BPF_LDST_BYTES(insn);
 		mode = BPF_MODE(insn->code);
 
@@ -1432,18 +1417,12 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 						       size * 8, 0);
 
 patch_insn_buf:
-		new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-		if (!new_prog)
-			return -ENOMEM;
-
-		delta += cnt - 1;
-
-		/* keep walking new program and skip insns we just inserted */
-		env->prog = new_prog;
-		insn      = new_prog->insnsi + i + delta;
+		insn = bpf_patch_list_add(env, i, insn_buf, cnt);
+		if (IS_ERR(insn))
+			return PTR_ERR(insn);
 	}
 
-	return 0;
+	return bpf_patch_list_commit(env);
 }
 
 static u32 *bpf_dup_subprog_starts(struct bpf_verifier_env *env)
-- 
2.55.0

