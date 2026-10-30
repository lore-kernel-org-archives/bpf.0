Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361202;
	b=zmqNZ2po0L6uY571AA0NIXuRoHW7LdikyKPLrwnKjAgn15fQ9JDcPCr+Wkh31iUzhQtj
	 WBn8mQjQ6MYHTFWtajsBp8gdk1PhaqFlkFCHIz2aPMw98Du84xQBooqaxVaYddp6lu3nq
	 9knuQfqdGAh+AOD9Bj1mdJhI9JZm3DeVtPa8nsO+gnpcSxh/actsqD1Poe5+4Su7RY2zh
	 TbpMlChGkTENZ2CoqRDWt8mY/o/iNx7b0NMfhooETs1ipYa5PxZ4H0ttN+SLfANNlckUg
	 MVbaH7EU8eHox1C4O4WHhyloh0bjADDyLZQ/0W6njznA/ATm2KAcxWbCYSuF/ulRtcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=lZKd5uP9xhIuLtTGrO2A9gbQECjDP9CCvg1QwDJYWs8=;
	b=Qkvmg9Qx719bfQm9zbGjtUheFNMk94EQqrcbDNIUabhzCoWea0gJvykCXM9cJG55EJaA
	 bAdcVKYbbVwtiC5DDkwfkh2MYCPGUK5AZB6usaI3Yumr283x+yrgkRMjO0wch7H7dq5DS
	 fzpGgwxWd/98W1XAiQWqrnMulEsHUzlrxPht2rXCjBe5z0gn1czonRazw6G/4YeuFDjO1
	 d0ahQb+THwoqLdMbiSCwPUO9vhXE7ExaCXLxDmj/gYtFQRNZmuW8nSQc9yt7QtTgqYyR4
	 Sj6yg5gBraBMf4wZMrhtatS40drp7JxoaxFQMTvxJdCDRq7HtrGPUruLH47NqzRzbPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VUquGmoG;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6DD60A3838
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 11:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C6DD60A3838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VUquGmoG
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-181516de561so550872c88.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 04:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793361202; x=1793966002; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lZKd5uP9xhIuLtTGrO2A9gbQECjDP9CCvg1QwDJYWs8=;
        b=VUquGmoGpJ9kGE17Zv91BFiLuqtAnTci/5c8erYPTARzSBWnFBQXgs114L/zhv60sY
         LRcSGossp7I/Ma9EGFGitVT+KVcF8NYVDeYhLhzQT+W6VH6JSKZ22fDnRj+bBR5Dknht
         YcJVp9IcGFEdkOAFwk5QhfH4svcyoGSYmqJk6DyqTwu8R7L+LRRK0hVe8XPIB1ezEyPj
         mhZUoVxgNwOyyN5JHAzi7wxTi+ud1eNeuGXaNSCws5WxM24wSfB9RJYeDeotdi5zMZwl
         +hoRusfnHubRZKsFspCrkngoGr7U5NlH0co96zgEgqTQgvGuWKl3+MVumJKVA9qV5Ym1
         EjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361202; x=1793966002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lZKd5uP9xhIuLtTGrO2A9gbQECjDP9CCvg1QwDJYWs8=;
        b=JzpSateJKb1kZeYjJbynAArVyXhE6Y5mRSje63emSqXeORqhGfWrysJoF5i/jr14J0
         gygpjN8NgmdNXshejTkiZ/HnRid1daS/GVlKaLlz3Rru6uAQPSdFmQga+9YSpfAX5Ep2
         8Ism/+bz0EnZFgyEoizaFW5wBQSC7J9cgdP+/dczTU3uynZCIo1AvGbj7+CZKCrez5CJ
         z5oipuxY/7nKr5ZKxSsNtsjMV1a0/XWEnzc82Kadz/sGmp1A27DsuNtUfQFmZ+VTdp2L
         D3z9JEQBVDY+rQQGqNLbHElVmhBEYqwOHZU/ga/QPDkOpbUXw1X0ysHuvqWfAqmNndJz
         c4pQ==
X-Gm-Message-State: AFq9FYKfR5bvfxlzfXRo0qGTZKiuEy5cMit0r50WWaWtnzfHAkg0ODHu
	FeXt9kLnoOIIqWM20ZjWsPuFOQNOo8O0CkZBrV8vfDmT+OFTH6B/X7KQ
X-Gm-Gg: AYBFou2PS32mRRwvqI0dL86kj9vOB2ByQ7VcfGzCT1z/z9LPWaT9+Fl3Rm0A5lAlFZu
	r4ILycX+Y94wDFCvMVvJy/q+D8wSxc4I5eE2rIw3HE0jH0GiWLda5dJr0blDccaXvtFHGB5TRBo
	0s0qAk6a63IJpUYhBpbUnKN9/w29KEnuDVxPS2yMFdjt6A8nIM8w282ZUHAlsx0jjK/Du5J7bUZ
	re4pvYRGLzVbgI0VzeYC021LhHskX7mzTFqdsEsxwMuRIQsnIud/L72Q496YQfLE6hEVEctpAfB
	TOgYzHkg3GvICXy+VkeJ8YZz8uDfGOzEphwUhuGD/8PE1QhUsbfBZLaiWUPNtSGCcfs2YA/Zm9k
	C9ebJ+eDw6ObHowMxTQ3NkvnQ3ZM9own08OPOcicQztWsfut/+PS7kYeeMi/xHPC3kgx2x62pAU
	qO5+oIfwKuI5dsUjsNahpEpM5E6SzBwX54STAIpVji121uL+jURY7OeijUgnWEPMhnMHir08c1e
	lE9/+0aTRjpen1oNGQRdBFedtn6VwZ2c0ppOr/TZwCF1r45tnLORQtWQt2cP5+YhbVABTAnQNRG
	TVVBSz/JENT04dXY1rZmNpDV
X-Received: by 2002:a05:7022:628d:b0:184:40db:6bb9 with SMTP id a92af1059eb24-1a94876dbd0mr10003072c88.8.1793361201527;
        Fri, 30 Oct 2026 04:53:21 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcd6f1sm6437304c88.20.2026.10.30.04.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:53:21 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 30 Oct 2026 07:51:59 -0400
Subject: [PATCH bpf-next v2 14/22] bpf: Move bpf_convert_ctx_accesses() to
 the patch list
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-bpf-verifier-patch-batch-v2-14-55cd43439f7c@gmail.com>
References: <20261030-bpf-verifier-patch-batch-v2-0-55cd43439f7c@gmail.com>
In-Reply-To: <20261030-bpf-verifier-patch-batch-v2-0-55cd43439f7c@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

bpf_convert_ctx_accesses() patches the program for every context
access that it rewrites and every barrier that it adds, one
bpf_patch_insn_data() at a time.

Each of these patches costs O(prog->len), so a program with many
context accesses pays it once for every one of them.

Queue the prologue, the store of the context pointer for the epilogue
and the rewrites, and commit them at the end of the pass. Queue a
barrier in front of an instruction before rewriting the instruction,
whose rewrite then replaces the last instruction of the barrier. As
ops->gen_prologue() ends the prologue with the first instruction of the
program, insert the prologue without it with bpf_patch_list_insert().
As the epilogue is now found by its index in the unpatched program,
which can be 0, mark that there is none yet with -1.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 kernel/bpf/fixups.c | 132 +++++++++++++++++++---------------------------------
 1 file changed, 49 insertions(+), 83 deletions(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 6d99de1be2581..08c89f2baffb6 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1090,16 +1090,15 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprogs = env->subprog_info;
 	const struct bpf_verifier_ops *ops = env->ops;
-	int i, cnt, size, ctx_field_size, ret, delta = 0, epilogue_cnt = 0;
+	int i, cnt, size, ctx_field_size, ret, epilogue_cnt = 0;
 	const int insn_cnt = env->prog->len;
 	struct bpf_insn *epilogue_buf = env->epilogue_buf;
 	struct bpf_insn *insn_buf = env->insn_buf;
 	struct bpf_insn *insn;
 	u32 target_size, size_default, off;
-	struct bpf_prog *new_prog;
 	enum bpf_access_type type;
 	bool is_narrower_load;
-	int epilogue_idx = 0;
+	int epilogue_idx = -1;
 
 	if (ops->gen_epilogue) {
 		epilogue_cnt = ops->gen_epilogue(epilogue_buf, env->prog,
@@ -1109,17 +1108,12 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
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
 
 			ret = add_kfunc_in_insns(env, epilogue_buf, epilogue_cnt - 1);
 			if (ret < 0)
@@ -1150,13 +1144,14 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
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
 
 			ret = add_kfunc_in_insns(env, insn_buf, cnt - 1);
 			if (ret < 0)
@@ -1164,21 +1159,18 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 		}
 	}
 
-	if (delta)
-		WARN_ON(adjust_jmp_off(env->prog, 0, delta));
-
 	if (bpf_prog_is_offloaded(env->prog->aux))
-		return 0;
-
-	insn = env->prog->insnsi + delta;
+		return bpf_patch_list_commit(env);
 
-	for (i = 0; i < insn_cnt; i++, insn++) {
+	for (i = 0; i < insn_cnt; i++) {
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
@@ -1186,17 +1178,13 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
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
@@ -1226,42 +1214,34 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
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
-			if (epilogue_idx) {
+			if (epilogue_idx >= 0) {
 				/* jump back to the earlier generated epilogue */
-				insn_buf[0] = BPF_JMP32_A(epilogue_idx - i - delta - 1);
+				insn_buf[0] = BPF_JMP32_A(epilogue_idx - i - 1);
 				cnt = 1;
 			} else {
 				memcpy(insn_buf, epilogue_buf,
 				       epilogue_cnt * sizeof(*epilogue_buf));
 				cnt = epilogue_cnt;
-				/* epilogue_idx cannot be 0. It must have at
-				 * least one ctx ptr saving insn before the
-				 * epilogue.
-				 */
-				epilogue_idx = i + delta;
+				epilogue_idx = i;
 			}
 			goto patch_insn_buf;
 		} else {
@@ -1269,7 +1249,7 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 		}
 
 		if (type == BPF_WRITE &&
-		    env->insn_aux_data[i + delta].nospec_result) {
+		    env->insn_aux_data[i].nospec_result) {
 			/* nospec_result is only used to mitigate Spectre v4 and
 			 * to limit verification-time for Spectre v1.
 			 */
@@ -1278,17 +1258,13 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
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
@@ -1341,22 +1317,18 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
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
 
@@ -1424,18 +1396,12 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
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
2.43.0

