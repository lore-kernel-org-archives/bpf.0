Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111EF26B971
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187935; cv=none; b=DSYTsPUUnzH8zOLRPNwA24/GdDIUMe7sUXgpf61MucMViHudmo/STFSjqbjlIzE60O6zwQOhQcEz3d432/e4+h2LhfLIWnxsQRXnJj4PklOQACIBiDTkjKhiQx5kKrdlv2udlZIGZMDOsssPCTTmrfmNyIE1PE/J5Cm+QGKjPsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187935; c=relaxed/simple;
	bh=FZph9IV8rAQJz0gX5JawMm59xWKu8ACieH1pNlvriEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rj4xy1K64zGZDv2bes13aobVlo7y9DE1gxgPOeeQa4HOZepwN/xZBAog7Lo0qsEpyAUVrYAkKUJViaXRd1FBk2dD85j+eyDT5YKzyD0T/TTdOftREn9TMynOWUyjHwowinj72+5+e1RocL3pTsH2o67uAOQ1qnRQjxMalkbekaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OXP2ymJz; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OXP2ymJz"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-658034ce0e3so4262408a12.3
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 09:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1769187932; x=1769792732; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x1X9uw3m1KzZgxmGpwRkGtH9I7YAOqbbW1p3NEbA+Lg=;
        b=OXP2ymJzVVizZtyLCmqPa5b3/gptVXB2Popd31q6jzmmZEeCK8aUoO1IYCsudx+m2L
         3rHUrQStVb1SWynYCEdlu+0jSPynLeh7yop4iFAk5EERW8HFC75xNaYHsSXDuARJREsg
         JqmarKNFRU+yx5hLkMNTLAE2E77Dt8GfUWw0jMhWyWE9WhPnI1F7AtqjuZ3SWT4UcipE
         QovYBwyLDm5MEC2OGgFmSWJ3Et2IhEW17RlR7QMwv9PDphSZaOTJxhGhHyypmvXQWhuc
         u1lw0aNp9Pgl3Tr1RRFcpAcQfebe3D+4LYI4c9dcLDK6re5+eZEjwS07WlsdQQjiSt8b
         RigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769187932; x=1769792732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x1X9uw3m1KzZgxmGpwRkGtH9I7YAOqbbW1p3NEbA+Lg=;
        b=DhFA0Xm4mzrlONeKkwNh+DAJ28HRJxMqo2yinvIfo9yTzvRJBQvRWMaE0UFQU6eN7h
         2AyHaFxo+LlVg17mUWN+oUGUaNLPCtFbmm3+XAQkQNB4hiyb72w2TN5KZdiFgdQh50+N
         TAYLKIVUIgP+hD+KFmCz9PBlY8UWy29Sjrk53VAByZgTxAYN45uTytE9qsYkFxwqYhUn
         +7hSB3C97GvaLTj1Ya5v3Vyt2cQNI2fW+APpZG3gfduU4+Dx3e0+gQQqtEEQ10WeTqtm
         JHiAlvB9ZjKkbbTB7kpyydUIyHGEtf2wHzhPXjuhBj6y+DFnv5lCC37O4Ci7X8B8lE9h
         qYpA==
X-Gm-Message-State: AOJu0Yxq3RdtQdNVV7z/5K5S83m8FWp0n+3L9zveWIkYGXr4qz80BBhO
	qdWp7TuFIYTdA5WBYPRc+81VCIIMgTV3abYSCpH5RtCKxldNJj8yk9GiioVZwECy8fE=
X-Gm-Gg: AZuq6aI3/wJ/aX/WJ5gUC5WWRsfJ20pukOQj1KJfmCPwQC5JjCMMsbNSEnFWfJmTQ+S
	PqxNAP+Y5PZJy5Q58axjkmEyUAIw0zIj6FNvFvDHc+iyG6hvBO5BvV/KC0yaBmIkj7BNRGBk64q
	VlsKTkGC12S33sJHPWwImTkDwDMVqhANHD518Rpi0Q1sxXmxqczmpsReKifyBy/9XenxTRyxMzn
	Cp2Qj4boGHL360y5Q6rgG98aJvsTYO7YMVOk9/Yw1c1sxlfrAsaA70DdIj6EUyX/Zqo0aIutiWC
	7ekMM/k5tiDqvs1drLmGR8gVF8DAzoA0lYwT5w5EBQ6l9qYOhaTnRIAhTTtdVyXdg+yTLm3fiqV
	CfudfVjdvIE2IJxkKGFHO3vmBC6gb7XKeULyZS6IS8ssBI//+lSC7RG2ifGhUpEUuOzrx61FrvN
	8VcxEMUv1Wsb+CwUKvPnymYvsOgvfOOActt2BxOlW4+bhEXmbs050=
X-Received: by 2002:a17:906:fe0a:b0:b87:63a8:8849 with SMTP id a640c23a62f3a-b885ae8019dmr300711466b.46.1769187932380;
        Fri, 23 Jan 2026 09:05:32 -0800 (PST)
Received: from cloudflare.com (79.191.62.3.ipv4.supernova.orange.pl. [79.191.62.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b417339sm134754166b.22.2026.01.23.09.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 09:05:31 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 23 Jan 2026 18:05:18 +0100
Subject: [PATCH bpf-next v2 1/4] bpf, verifier: Support direct helper calls
 from prologue/epilogue
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-1-0e50db4d4663@cloudflare.com>
References: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-0-0e50db4d4663@cloudflare.com>
In-Reply-To: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-0-0e50db4d4663@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
 netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Prepare to remove support for calling kfuncs from prologue & epilogue.

Instead allow direct helpers calls using BPF_EMIT_CALL. Such calls already
contain helper offset relative to __bpf_call_base and must bypass the
verifier's patch_call_imm fixup, which expects BPF helper IDs rather than a
pre-resolved offsets.

Add a finalized_call flag to bpf_insn_aux_data to mark call instructions
with resolved offsets so the verifier can skip patch_call_imm fixup for
these calls.

Note that the target of BPF_EMIT_CALL should be wrapped with BPF_CALL_x to
prevent an ABI mismatch between BPF and C on 32-bit architectures.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 29 ++++++++++++++++++++++++++---
 net/core/filter.c            |  3 +--
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 8355b585cd18..1ccbb47aca2d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -561,6 +561,7 @@ struct bpf_insn_aux_data {
 	bool non_sleepable; /* helper/kfunc may be called from non-sleepable context */
 	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
 	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog percpu alloc */
+	bool finalized_call; /* call holds resolved helper offset relative to __bpf_call_base */
 	u8 alu_state; /* used in combination with alu_limit */
 	/* true if STX or LDX instruction is a part of a spill/fill
 	 * pattern for a bpf_fastcall call.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c7f5234d5fd2..0b4feedc14c9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22201,6 +22201,19 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/* Mark helper calls within prog->insns[off ... off+cnt-1] range as resolved,
+ * meaning imm contains the helper offset. Used for prologue & epilogue.
+ */
+static void mark_helper_calls_finalized(struct bpf_verifier_env *env, int off, int cnt)
+{
+	int i;
+
+	for (i = 0; i < cnt; i++) {
+		if (bpf_helper_call(&env->prog->insnsi[i + off]))
+			env->insn_aux_data[i + off].finalized_call = true;
+	}
+}
+
 /* convert load instructions that access fields of a context type into a
  * sequence of instructions that access fields of the underlying structure:
  *     struct __sk_buff    -> struct sk_buff
@@ -22267,6 +22280,8 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			ret = add_kfunc_in_insns(env, insn_buf, cnt - 1);
 			if (ret < 0)
 				return ret;
+
+			mark_helper_calls_finalized(env, 0, cnt - 1);
 		}
 	}
 
@@ -22280,6 +22295,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 
 	for (i = 0; i < insn_cnt; i++, insn++) {
 		bpf_convert_ctx_access_t convert_ctx_access;
+		bool finalize_helper_calls = false;
 		u8 mode;
 
 		if (env->insn_aux_data[i + delta].nospec) {
@@ -22346,6 +22362,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 				 * epilogue.
 				 */
 				epilogue_idx = i + delta;
+				finalize_helper_calls = true;
 			}
 			goto patch_insn_buf;
 		} else {
@@ -22495,12 +22512,14 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 		if (!new_prog)
 			return -ENOMEM;
+		env->prog = new_prog;
 
-		delta += cnt - 1;
+		if (finalize_helper_calls)
+			mark_helper_calls_finalized(env, i + delta, cnt - 1);
 
 		/* keep walking new program and skip insns we just inserted */
-		env->prog = new_prog;
-		insn      = new_prog->insnsi + i + delta;
+		delta += cnt - 1;
+		insn = new_prog->insnsi + i + delta;
 	}
 
 	return 0;
@@ -23909,6 +23928,9 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		}
 patch_call_imm:
+		if (env->insn_aux_data[i + delta].finalized_call)
+			goto next_insn;
+
 		fn = env->ops->get_func_proto(insn->imm, env->prog);
 		/* all functions that have prototype and verifier allowed
 		 * programs to call them, must be real in-kernel functions
@@ -23920,6 +23942,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			return -EFAULT;
 		}
 		insn->imm = fn->func - __bpf_call_base;
+		env->insn_aux_data[i + delta].finalized_call = true;
 next_insn:
 		if (subprogs[cur_subprog + 1].start == i + delta + 1) {
 			subprogs[cur_subprog].stack_depth += stack_depth_extra;
diff --git a/net/core/filter.c b/net/core/filter.c
index d14401193b01..cb39388f69a9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9082,8 +9082,7 @@ static int bpf_unclone_prologue(struct bpf_insn *insn_buf, bool direct_write,
 	/* ret = bpf_skb_pull_data(skb, 0); */
 	*insn++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
 	*insn++ = BPF_ALU64_REG(BPF_XOR, BPF_REG_2, BPF_REG_2);
-	*insn++ = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
-			       BPF_FUNC_skb_pull_data);
+	*insn++ = BPF_EMIT_CALL(bpf_skb_pull_data);
 	/* if (!ret)
 	 *      goto restore;
 	 * return TC_ACT_SHOT;

-- 
2.43.0

