Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361174;
	b=kJUaCyT6HqYUlwGm71ZScCbbaDmPByX86jNaTPwzf7pGTaj45x1e9vIQiOOWmDJ5fJ0N
	 UxBmlhEQADMyNtooW2e5ecFA3GoiKynfKbcZCDwpSa5Px8zQ0/1xgCl64sYwtMwTVxcJ8
	 KZoufuphuzLe/giA2IVeGh7j+gxuzeg9FLqriIAu3MEEco4VLwZT1xGjb4TQL8x1poVtM
	 /Yx1hnk2NgEEpBkg3oovkn3rCl09SRQ43mK251m/O9e1JaJo24+vl5imZnfW8H0vyLLCK
	 LOXPVVt+2YXBVKZbAoGgsHKNVjWTYlWIH5zqAh8EOOCcNnZNtlsHVlJbrc+MaLHPhfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=D25azTNyiIXfYBfQtWHSChfm+RG7wZ+rEc2MJkCnUUE=;
	b=JnhsnmLSoUfa2aCyfDJgFuJTqdWmxsGBlKL8aQwmvfBy2oZCQXk/7mrIFhgiN+ooOEOj
	 qdarrkHf1U0RGWsxxf7o/B08inYy2ZZjpKaFA+SShIvQpzCTRdye6JJLg/SryWse0KZvB
	 BeYs0FfRFa0i+4ah8FMkUF3qPb0yXIG5T5vpOB5ZTwYk1cm6RPfRECL5yT+eXbhFfnzxY
	 t/BoCKqMzVfkThYLWVzJ0xeH8S6K925MZgANTZ50Rhjh8CTIVuAJJu7OocTokUtfqSti4
	 mvtzKFGxGme4UGecImSOEI/hncqNZxW64rLWORa80du/Tl/cJW0UipqJKCO7zO63Cbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LsYsf8+2;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1DB60A260A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 11:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B1DB60A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LsYsf8+2
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1ae18eb9b69so28991c88.0
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 04:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793361173; x=1793965973; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D25azTNyiIXfYBfQtWHSChfm+RG7wZ+rEc2MJkCnUUE=;
        b=LsYsf8+2GWbDTfS5zRQm6kyTfcXZRBqA4gxEEQGhZvp+8T6tiyEsqKQX4fEmqMJPJv
         D9+nYhX3374EUFS1KBt8fYee83T1JSYNj2My3AO+K6tTuaaZQJqxmt9ppZSmYZcS+ngy
         /EVhK0F1M+uo1Zw3fg9/0PRzQiIM7uyu+/41IEYMTEHKlgzUiYVabUokuuygQ2QnjhvM
         Z/GFiqICqCf7+Lzjj/fXZ0STCU3gYCMkdvI8VXP8NNq5v7eiXsUZRoTp+k7nHkyj3aVd
         MP7Hc+yO9zfqXgNcni4qfir2m9YXjwGCWbbdeP2pcmYJ/qL2GEDu8P8aoGY5H8dAnBlu
         dlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361173; x=1793965973;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D25azTNyiIXfYBfQtWHSChfm+RG7wZ+rEc2MJkCnUUE=;
        b=1skMtGSKJCRQRrm7OHMnlcbucVFQF2dVpocUYZh00U97s0wyPyXWFgN4dYkMLsFnTT
         s/KSodQ1OsOCPu+esfh5oXyAD8lTWnc+GL8I3HknSoECvRQKSkx9Xn37oqhmE05dOMfl
         vL/LlbQMQNPyjPlOB7P549anXp4g4ifFeEnfzv9HDCHLR4+v0oBnQhEvUhaCaWQWcvEg
         zIq57cI2OVR9XbA3pXnAQSlT2iVCd9e3uHaLjTlDH2BB2GQmuUGGrPYcYT3476/Pzc+1
         BiAcQFOMED3zz8uyc3Q/Fql0NSCOTUdRC3vLPN2Zr/Rt28W/bPMWaqZZel7FoA4mweV5
         BTUw==
X-Gm-Message-State: AFq9FYIOxASJtEoCoon1heNHYyBFIduWWAn5wuPVHsPljmSvLVbHVzmN
	agtGpTFFb17GN1mic4w6N2ZVHW1UHCnp4IhJtPF25fl3A3gkOfwNcC46
X-Gm-Gg: AYBFou3DNV0LUHVVK2XyLY7XbMF5eaQd0CAj5CRM083zqsUuNIOKCh+ONILfyHZZWkI
	GBIc36SfoTRopZGpIR9YzNUwpLtKRjCVSTorOqiZP2bsdBUVdmIuPfFoTtsbyEo1SwBqGLusCqn
	rN+nIAGYGN80v9U/SKrtLk0t7hRD8ih5gGSHyh9bcvLV88akIuiyDLlbv4zJB9qre4abz2+mrik
	NKiTbFel5AAZBpP4K6PwiC7InogjvlrQtVMH6xlFtsaIWX9YpBRDQpx4C+ff8UYM8RaVjMxSQjs
	NP6t3U1uTaXXGM/1pqOr6hlqEwjLYwI/zuUYI2WGrm0M7mDzfT73YYfk5cxTIzHx5mgT+jAV6KS
	SUVwA+eK4eAVgMEbLQcPb5y3KuVNTKttVnAXneeKIwCqTAsE7qR3nqEtqqBDoB/D0zanV/jXZXU
	jhqnnQaDhfYNAaVv1dAcVGDCCov2tFw3p/uDBdQVQalmhFfTTrPRue0FHZyTwAETDeXncZ2o2l2
	6eqAE+K7kP9AWOTdlPJxocAIYBxrtWnQGgEpQVKspcXm4XZ421qBF8dRN6fApAqkog/KytbX6pn
	w9Yw2gMCViEqRuI4LiN41v8h
X-Received: by 2002:a05:7022:3a03:b0:152:9e88:daaa with SMTP id a92af1059eb24-1ac5f181628mr3327498c88.36.1793361172984;
        Fri, 30 Oct 2026 04:52:52 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcd6f1sm6437304c88.20.2026.10.30.04.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:52:52 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 30 Oct 2026 07:51:54 -0400
Subject: [PATCH bpf-next v2 09/22] bpf: Strip nops through the patch list
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
Message-Id: <20261030-bpf-verifier-patch-batch-v2-9-55cd43439f7c@gmail.com>
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

bpf_opt_remove_nops() removes every "ja 0" and "may_goto +0" with
verifier_remove_insns(). After removing may_goto +0, it looks at the
instruction in front of it again, since a may_goto +1 there has turned
into another may_goto +0.

Each removal moves the tail of the program and walks all of it, so
loading 131072 "ja 0" takes about 53 seconds.

Mark the nops in a bitmap first, queue their removal with
bpf_patch_list_del() and commit them once. Take a forward jump over
removed instructions as one of +0, and keep looking back from a
removed may_goto as long as that turns another one into a nop.
verifier_remove_insns() and its static helpers have no users left,
remove them.

Time of BPF_PROG_LOAD of n "ja 0" followed by "r0 = 0; exit", average
of three runs, x86_64 VM with 32 vCPUs, before and after this patch:

              before     after
  n = 32768    3.207 s   0.203 s
  n = 131072  52.940 s   0.766 s

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 kernel/bpf/fixups.c | 236 +++++++++++-----------------------------------------
 1 file changed, 47 insertions(+), 189 deletions(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 95f4fe5d607e6..7c7c38eb9f0c2 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -298,14 +298,6 @@ static void adjust_insn_arrays(struct bpf_verifier_env *env, u32 first, u32 len)
 		bpf_insn_array_adjust(env->insn_array_maps[i], first, len);
 }
 
-static void adjust_insn_arrays_after_remove(struct bpf_verifier_env *env, u32 off, u32 len)
-{
-	int i;
-
-	for (i = 0; i < env->insn_array_map_cnt; i++)
-		bpf_insn_array_adjust_after_remove(env->insn_array_maps[i], off, len);
-}
-
 static void adjust_poke_descs(struct bpf_prog *prog, u32 first, u32 len)
 {
 	struct bpf_jit_poke_descriptor *tab = prog->aux->poke_tab;
@@ -743,133 +735,6 @@ static int adjust_jmp_off(struct bpf_prog *prog, u32 tgt_idx, u32 delta)
 	return 0;
 }
 
-static int adjust_subprog_starts_after_remove(struct bpf_verifier_env *env,
-					      u32 off, u32 cnt)
-{
-	int i, j;
-
-	/* find first prog starting at or after off (first to remove) */
-	for (i = 0; i < env->subprog_cnt; i++)
-		if (env->subprog_info[i].start >= off)
-			break;
-	/* find first prog starting at or after off + cnt (first to stay) */
-	for (j = i; j < env->subprog_cnt; j++)
-		if (env->subprog_info[j].start >= off + cnt)
-			break;
-	/* if j doesn't start exactly at off + cnt, we are just removing
-	 * the front of previous prog
-	 */
-	if (env->subprog_info[j].start != off + cnt)
-		j--;
-
-	if (j > i) {
-		struct bpf_prog_aux *aux = env->prog->aux;
-		int move;
-
-		/* move fake 'exit' subprog as well */
-		move = env->subprog_cnt + 1 - j;
-
-		memmove(env->subprog_info + i,
-			env->subprog_info + j,
-			sizeof(*env->subprog_info) * move);
-		env->subprog_cnt -= j - i;
-
-		/* remove func_info and its aux */
-		if (aux->func_info) {
-			move = aux->func_info_cnt - j;
-
-			memmove(aux->func_info + i,
-				aux->func_info + j,
-				sizeof(*aux->func_info) * move);
-			if (aux->func_info_aux)
-				memmove(aux->func_info_aux + i,
-					aux->func_info_aux + j,
-					sizeof(*aux->func_info_aux) * move);
-			aux->func_info_cnt -= j - i;
-			/* func_info->insn_off is set after all code rewrites,
-			 * in adjust_btf_func() - no need to adjust
-			 */
-		}
-		/* The exception callback is live, so it cannot sit inside the removed range. */
-		if (env->exception_callback_subprog >= j)
-			env->exception_callback_subprog -= j - i;
-	} else {
-		/* convert i from "first prog to remove" to "first to adjust" */
-		if (env->subprog_info[i].start == off)
-			i++;
-	}
-
-	/* update fake 'exit' subprog as well */
-	for (; i <= env->subprog_cnt; i++)
-		env->subprog_info[i].start -= cnt;
-
-	return 0;
-}
-
-static int bpf_adj_linfo_after_remove(struct bpf_verifier_env *env, u32 off,
-				      u32 cnt)
-{
-	struct bpf_prog *prog = env->prog;
-	u32 i, l_off, l_cnt, nr_linfo;
-	struct bpf_line_info *linfo;
-
-	nr_linfo = prog->aux->nr_linfo;
-	if (!nr_linfo)
-		return 0;
-
-	linfo = prog->aux->linfo;
-
-	/* find first line info to remove, count lines to be removed */
-	for (i = 0; i < nr_linfo; i++)
-		if (linfo[i].insn_off >= off)
-			break;
-
-	l_off = i;
-	l_cnt = 0;
-	for (; i < nr_linfo; i++)
-		if (linfo[i].insn_off < off + cnt)
-			l_cnt++;
-		else
-			break;
-
-	/* First live insn doesn't match first live linfo, it needs to "inherit"
-	 * last removed linfo.  prog is already modified, so prog->len == off
-	 * means no live instructions after (tail of the program was removed).
-	 */
-	if (prog->len != off && l_cnt &&
-	    (i == nr_linfo || linfo[i].insn_off != off + cnt)) {
-		l_cnt--;
-		linfo[--i].insn_off = off + cnt;
-	}
-
-	/* remove the line info which refer to the removed instructions */
-	if (l_cnt) {
-		memmove(linfo + l_off, linfo + i,
-			sizeof(*linfo) * (nr_linfo - i));
-
-		prog->aux->nr_linfo -= l_cnt;
-		nr_linfo = prog->aux->nr_linfo;
-	}
-
-	/* pull all linfo[i].insn_off >= off + cnt in by cnt */
-	for (i = l_off; i < nr_linfo; i++)
-		linfo[i].insn_off -= cnt;
-
-	/* fix up all subprogs (incl. 'exit') which start >= off */
-	for (i = 0; i <= env->subprog_cnt; i++)
-		if (env->subprog_info[i].linfo_idx > l_off) {
-			/* program may have started in the removed region but
-			 * may not be fully removed
-			 */
-			if (env->subprog_info[i].linfo_idx >= l_off + l_cnt)
-				env->subprog_info[i].linfo_idx -= l_cnt;
-			else
-				env->subprog_info[i].linfo_idx = l_off;
-		}
-
-	return 0;
-}
-
 /* Clean up dynamically allocated fields of aux data for instructions [start, ...] */
 void bpf_clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len)
 {
@@ -886,44 +751,6 @@ void bpf_clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len)
 	}
 }
 
-static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
-{
-	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
-	unsigned int orig_prog_len = env->prog->len;
-	int err;
-
-	if (bpf_rewrite_must_abort())
-		return -EINTR;
-
-	if (bpf_prog_is_offloaded(env->prog->aux))
-		bpf_prog_offload_remove_insns(env, off, cnt);
-
-	bpf_clear_insn_aux_data(env, off, cnt);
-
-	err = bpf_remove_insns(env->prog, off, cnt);
-	if (err)
-		return err;
-
-	/* before subprogs are adjusted, since it looks at them */
-	bpf_adjust_func_ptrs_after_remove(env, off, cnt);
-
-	err = adjust_subprog_starts_after_remove(env, off, cnt);
-	if (err)
-		return err;
-
-	err = bpf_adj_linfo_after_remove(env, off, cnt);
-	if (err)
-		return err;
-
-	adjust_insn_arrays_after_remove(env, off, cnt);
-
-	memmove(aux_data + off,	aux_data + off + cnt,
-		sizeof(*aux_data) * (orig_prog_len - off - cnt));
-	env->insn_aux_data_len -= cnt;
-
-	return 0;
-}
-
 static const struct bpf_insn NOP = BPF_JMP_IMM(BPF_JA, 0, 0, 0);
 static const struct bpf_insn MAY_GOTO_0 = BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 0, 0);
 
@@ -1028,32 +855,63 @@ int bpf_opt_remove_dead_code(struct bpf_verifier_env *env)
 	return bpf_patch_list_commit(env);
 }
 
+/*
+ * Whether insn i is a nop once the insns in 'removed' are gone. Only forward
+ * jumps over removed insns can turn into one.
+ */
+static bool insn_is_nop(struct bpf_verifier_env *env, int i,
+			const unsigned long *removed)
+{
+	struct bpf_insn insn = env->prog->insnsi[i];
+	int t = i + 1 + insn.off;
+
+	if (env->insn_aux_data[i].indirect_target)
+		return false;
+	if (insn.code != NOP.code && insn.code != MAY_GOTO_0.code)
+		return false;
+	if (insn.off > 0 && find_next_zero_bit(removed, t, i + 1) == t)
+		insn.off = 0;
+
+	return !memcmp(&insn, &NOP, sizeof(NOP)) ||
+	       !memcmp(&insn, &MAY_GOTO_0, sizeof(MAY_GOTO_0));
+}
+
 int bpf_opt_remove_nops(struct bpf_verifier_env *env)
 {
-	struct bpf_insn_aux_data *aux = env->insn_aux_data;
-	struct bpf_insn *insn = env->prog->insnsi;
 	int insn_cnt = env->prog->len;
-	bool is_may_goto_0, is_ja;
-	int i, err;
+	unsigned long *removed;
+	int i, j, err = 0;
 
-	for (i = 0; i < insn_cnt; i++) {
-		is_may_goto_0 = !memcmp(&insn[i], &MAY_GOTO_0, sizeof(MAY_GOTO_0));
-		is_ja = !memcmp(&insn[i], &NOP, sizeof(NOP));
+	removed = bitmap_zalloc(insn_cnt, GFP_KERNEL_ACCOUNT);
+	if (!removed)
+		return -ENOMEM;
 
-		if (!is_may_goto_0 && !is_ja)
-			continue;
-		if (aux[i].indirect_target)
+	for (i = 0; i < insn_cnt; i++) {
+		if (!insn_is_nop(env, i, removed))
 			continue;
+		/*
+		 * Removing may_goto +0 can turn the may_goto +1 in front of it
+		 * into another one, look back as long as it does.
+		 */
+		for (j = i; ; ) {
+			__set_bit(j, removed);
+			if (env->prog->insnsi[j].code != MAY_GOTO_0.code)
+				break;
+			while (--j >= 0 && test_bit(j, removed))
+				;
+			if (j < 0 || !insn_is_nop(env, j, removed))
+				break;
+		}
+	}
 
-		err = verifier_remove_insns(env, i, 1);
+	for_each_set_bit(i, removed, insn_cnt) {
+		err = bpf_patch_list_del(env, i);
 		if (err)
-			return err;
-		insn_cnt--;
-		/* Go back one insn to catch may_goto +1; may_goto +0 sequence */
-		i -= (is_may_goto_0 && i > 0) ? 2 : 1;
+			break;
 	}
+	bitmap_free(removed);
 
-	return 0;
+	return err ?: bpf_patch_list_commit(env);
 }
 
 int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,

-- 
2.43.0

