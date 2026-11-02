Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793583014;
	b=tD3QBfr9ndAAH4TDEVmaAHf6OJiU5IRFB10D0fw/+CeIOzD6UORCk+CoPjecd9565U10
	 oFWpegp3RrD0ipSVA5kWOtb9iLjGeR3drLVr4LwhL3qjN9Hv9R0DYQFRo32mEuLNhZcxk
	 LCuwSWV3m2EvwjVA5HBqVFMK8m27hDNL06KUAZFX7Ua/t62RZHYRS4WPztAo+My3TH/6q
	 fv0NWrlL6oiFc1SxT7z0q0mEc6PWRJ4BUyq+yTT2vzxiwg/itnjAmAfnsimloPIGGyEhO
	 ro8RvYrWB0Z9U07oaGsz1WFOvJzO5XDD1mY6BBAezuCwADVBEC2J4MVCAaIF2ngwGMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793583014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KVRXwTJ3NwzbSKLzfrIsWpjEomu/QVH/AfgMH7jRxtU=;
	b=MekdILg2mEdAygQmJIDYajlV/5HK63E1HrIyNjqDQtjRQRpA+TD4GAAFfF0lrSZd1RB+
	 P6ij/AGA30Qb/YIY9Ma1Nghu+FpP+A3Ui42bg1Z42pKU9MmUzbPY4HndV4jyYcq2Retvb
	 MptJ28aCdhd4jFvlkH4oQRxIA4R6KcJgGSWAXazEYVH42h9x2eToDaVXjxSbLBfA8EKIz
	 0Cv3Rq+d1X2ECs5kGQ8w6NCLeRFF+6d1t0MaJS4YYbnM/h0wmbyz+T5cr2TZrxBkejE+B
	 Pw4rh5B93rhkxqyF3yOoafliW9MGQt6oTibEpNTfzB6k5HCLR8aPi0+fMreS+YeyuiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Og7/5P0O";
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A437C606A327
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 01:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A437C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Og7/5P0O
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e9eb579c0eso12232085ad.3
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 17:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793583013; x=1794187813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KVRXwTJ3NwzbSKLzfrIsWpjEomu/QVH/AfgMH7jRxtU=;
        b=Og7/5P0OnDRnL7AtC4/fcZdVAcnDwElrP9K4RWE2Xts2HfX3q/SKIKqtxzygotJruK
         Wviua8k3iPFiSNgJ/ug1yAU1uM6s2k4PN1UTLFgsX8pJclTkPmR54SKS8d2HZScZE0lg
         Yd6uXBZ5ujHv4AZcUCPUBDVcVFjCEtl3R+8Ce6IiiXeO6SXEVm5nEr+oxnNiUhWG6JAt
         pqKg65PththHReESZ0Z42HJIzPHKMiY4CeUoSygZDRDSoilzu4aCADcyn5svurMuw9qZ
         2Le6uAxwy8bWxL00x0yCz0m64zz+/80n7Gx795XrGyhuJoIzRIZnvWD+ayv0JpufvLPZ
         serw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793583013; x=1794187813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KVRXwTJ3NwzbSKLzfrIsWpjEomu/QVH/AfgMH7jRxtU=;
        b=elEWwzl7RVR7tTPcw9CifPl6WwlRXnJLxMmx9VLuUsA6wrVSyOD4FWxzlaZDVmj6/6
         Jyg32WZc8etBW3KVfUMufnDLnP4B0HY1E5+VSnRI76KnG045nxTyWqSCdaNZKj8kRsbV
         7Nddh2xLiHDBF5NcfdwM/KEhzp3iqkRqMO062L00wplbA/mYnCFdWPY3m7ld5y+EPPV7
         E1H/iWtXRZQFdZkjXGeJEDg61b0fhINwB0a3iH1KoybOUF9TdGWIuiLwFELj23WKDyGT
         yKjwqVsV3kLPLSNWgxE5ozUmN3BaGvuIb3Q1i4cYQo90Tm1rsg70EXp1SZhzwit1Z2zX
         QZPw==
X-Gm-Message-State: APuU4Z/57ByzQFvLxLaebmjH09p3alnpgVsp49Rb76ojl71N555Op1KT
	AJlW/YQjvtsU72PAUPlAG4zMVKtw+b+rcStYGd5oXEELY5pnvJd0dZ2rLWmS6A==
X-Gm-Gg: AYBFou1bJuZL9bghOz/cgyJRlRczLO7vufzD4+XrpBP8/f7mxuSrnj5i/LDkL/S9qgq
	VcP2RMtF6W1y+W50BkLc2s0Bu306racyy1oTqdEsa2ZqivAPJ76Z4oQR3pLzm9S1I2UV23uurDf
	/i/twfVluhCTyptPVaH7n4Yk8Oq0LlOrytYvW4skuCu+SFHZAG7CKa6CSNUxdGzo1QFKoAa5lsP
	rZgB/Wl/uh5wkAwNG9hDmyFe+auZOX/sTtGmj9DqnYiiBCz3cMQOw5nW/aYxEYONc9/YHn1WoL1
	/13OkSnP7+hZ28EGBzLqHlF4XFT4Dxs9Yc0l8dHVPlggbixlt17MMXih7hTX2PoiyEcTlFGWXAt
	zDjXio1AMhA4JPhflyqd1iquKtWX6FmChIJ+3G6Mg6C9g7Ts/Qn7dKWtbG4RveytDzxt9apVw6h
	B2j0Z7EqSJS3KtQ922WKAPlqKVQdiip2BGAsTVqjGZns0MbtDrkjab2t2ZBlA+bz/xYEt73+DIJ
	QONiXIdLxYOegBmjytnYh/cBucvHdaHsNA0wGWy/68oM4UN1A0aJfJbpTrnf63W3CXIvsFbYn5I
	OQ0N39zJS9se4oCAKMXvxlgvO68a1KOYyeDGZ1uLChTGsUfjlTcVODJ/6UI1kz2uQvD85ZT6I3i
	EpulxRp0GSNTA92jmoZ7STfkZ/zbM5E6Qs/9sYUza5QgJOwnipys9aeJmrUvwaEaxv1s3Sn1apQ
	YYiLaUkJLR+zWiNc4f8+E=
X-Received: by 2002:a17:903:388b:b0:2e9:3dd0:c7d with SMTP id d9443c01a7336-2eb364301b0mr68878855ad.20.1793583012567;
        Sun, 01 Nov 2026 17:30:12 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3922f56bsm20745605ad.16.2026.11.01.17.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 17:30:11 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	odys.yuan@gmail.com
Subject: [PATCH bpf-next v3 05/13] bpf: Move the bpf_opt_*() passes to the patch list
Date: Mon,  2 Nov 2026 01:29:32 +0000
Message-ID: <20261102012940.1756142-6-alexei.starovoitov@gmail.com>
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

bpf_opt_remove_dead_code() and bpf_opt_remove_nops() call
verifier_remove_insns() for each range that they remove.
bpf_opt_subreg_zext_lo32_rnd_hi32() calls bpf_patch_insn_data() for each
32-bit result whose upper half it sets: 4605 times in pyperf180 with
BPF_F_TEST_RND_HI32. Each call costs O(N) in a prog of N insns.

Queue the changes in the patch list, and commit one time at the end of each
pass. A commit costs O(N + inserted insns). Then verifier_remove_insns()
and its static helpers have no users. Remove them. Only
bpf_opt_remove_nops() is not mechanical.

The removal of a nop can make the jump in front of it a nop. The pass
cannot see that in the offset, because no insn moves before the commit.
Only a forward jump can become a nop. Thus walk from the end: at insn i the
walk knows which insns behind i stay. 'next' is the first of them. A 'goto'
or a may_goto is a nop when its target is behind i and not behind 'next'.

  old image        next  target  patch list
  0: r0 = 0        4
  1: goto +2       4     4       removal
  2: may_goto +1   4     4       removal
  3: may_goto +0   4     4       removal
  4: exit          5                          the walk starts here

The list takes insns in their order. Thus the walk marks the nops in a
bitmap, and a second walk queues the removals.

What users can see: bpf_opt_remove_nops() also removes a 'goto' or a
may_goto over 'goto +0' only. Before this patch 'goto +1; goto +0' becomes
'goto +0'. In bpf_opt_subreg_zext_lo32_rnd_hi32() a jump that gets out of
range gives -ERANGE, and the message names the jump. Before this patch the
pass returns -ENOMEM, and the message names the patched insn.

Load times in an x86_64 VM with 8 vCPUs, before and after this patch.
BPF_PROG_LOAD of a prog with n 'goto +0', mean of 3 runs:

              before     after
  n = 32768    2.040 s   0.060 s
  n = 131072  33.333 s   0.244 s

Wall time of 'veristat -q <obj>' with BPF_F_TEST_RND_HI32, mean of 10 runs:

              before     after
  pyperf180   0.549 s    0.087 s
  pyperf600   1.625 s    0.221 s

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/fixups.c | 266 +++++++++-----------------------------------
 1 file changed, 52 insertions(+), 214 deletions(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 588a3a3b6615..6fe47e400bc2 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -273,14 +273,6 @@ static void adjust_insn_arrays(struct bpf_verifier_env *env, u32 first, u32 len)
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
@@ -754,133 +746,6 @@ static int adjust_jmp_off(struct bpf_prog *prog, u32 tgt_idx, u32 delta)
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
@@ -897,44 +762,6 @@ void bpf_clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len)
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
 
@@ -1029,49 +856,66 @@ int bpf_opt_remove_dead_code(struct bpf_verifier_env *env)
 	keep_funcs_with_addr_taken(env);
 
 	for (i = 0; i < insn_cnt; i++) {
-		int j;
-
-		j = 0;
-		while (i + j < insn_cnt && !aux_data[i + j].seen)
-			j++;
-		if (!j)
+		if (aux_data[i].seen)
 			continue;
-
-		err = verifier_remove_insns(env, i, j);
+		err = bpf_patch_list_del(env, i);
 		if (err)
 			return err;
-		insn_cnt = env->prog->len;
 	}
 
-	return 0;
+	return bpf_patch_list_commit(env);
+}
+
+/*
+ * Whether insn i is a nop once the insns between it and 'next' are gone: "ja"
+ * or may_goto that goes to 'next' at most.
+ */
+static bool insn_is_nop(struct bpf_verifier_env *env, int i, int next)
+{
+	struct bpf_insn insn = env->prog->insnsi[i];
+
+	if (env->insn_aux_data[i].indirect_target)
+		return false;
+	if (insn.off < 0 || i + 1 + insn.off > next)
+		return false;
+	insn.off = 0;
+
+	return !memcmp(&insn, &NOP, sizeof(NOP)) ||
+	       !memcmp(&insn, &MAY_GOTO_0, sizeof(MAY_GOTO_0));
 }
 
 int bpf_opt_remove_nops(struct bpf_verifier_env *env)
 {
-	struct bpf_insn_aux_data *aux = env->insn_aux_data;
-	struct bpf_insn *insn = env->prog->insnsi;
 	int insn_cnt = env->prog->len;
-	bool is_may_goto_0, is_ja;
-	int i, err;
+	unsigned long *removed;
+	int i, next, err = 0;
 
-	for (i = 0; i < insn_cnt; i++) {
-		is_may_goto_0 = !memcmp(&insn[i], &MAY_GOTO_0, sizeof(MAY_GOTO_0));
-		is_ja = !memcmp(&insn[i], &NOP, sizeof(NOP));
+	removed = kvcalloc(BITS_TO_LONGS(insn_cnt), sizeof(long), GFP_KERNEL_ACCOUNT);
+	if (!removed)
+		return -ENOMEM;
 
-		if (!is_may_goto_0 && !is_ja)
-			continue;
-		if (aux[i].indirect_target)
-			continue;
+	/*
+	 * Removing may_goto +0 turns the may_goto +1 in front of it into
+	 * another one. Only a forward jump can turn into a nop, so walk from
+	 * the end: all that insn i jumps over is decided when the walk gets to
+	 * it. 'next' is the first insn behind i that stays. For a forward jump
+	 * it is in the subprog of i, because a subprog doesn't end with one.
+	 */
+	for (i = insn_cnt - 1, next = insn_cnt; i >= 0; i--) {
+		if (insn_is_nop(env, i, next))
+			__set_bit(i, removed);
+		else
+			next = i;
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
+	kvfree(removed);
 
-	return 0;
+	return err ?: bpf_patch_list_commit(env);
 }
 
 int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
@@ -1082,9 +926,8 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 	struct bpf_insn *zext_patch = env->insn_buf;
 	struct bpf_insn *rnd_hi32_patch = &env->insn_buf[2];
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
-	int i, patch_len, delta = 0, len = env->prog->len;
+	int i, patch_len, len = env->prog->len;
 	struct bpf_insn *insns = env->prog->insnsi;
-	struct bpf_prog *new_prog;
 	bool rnd_hi32;
 
 	rnd_hi32 = attr->prog_flags & BPF_F_TEST_RND_HI32;
@@ -1093,13 +936,12 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 	rnd_hi32_patch[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_AX, 32);
 	rnd_hi32_patch[3] = BPF_ALU64_REG(BPF_OR, 0, BPF_REG_AX);
 	for (i = 0; i < len; i++) {
-		int adj_idx = i + delta;
 		struct bpf_insn insn;
 		int load_reg;
 
-		insn = insns[adj_idx];
+		insn = insns[i];
 		load_reg = insn_def_regno(&insn);
-		if (!aux[adj_idx].zext_dst) {
+		if (!aux[i].zext_dst) {
 			u8 code, class;
 			u32 imm_rnd;
 
@@ -1120,7 +962,7 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 
 			/* ctx load could be transformed into wider load. */
 			if (class == BPF_LDX &&
-			    aux[adj_idx].ptr_type == PTR_TO_CTX)
+			    aux[i].ptr_type == PTR_TO_CTX)
 				continue;
 
 			imm_rnd = get_random_u32();
@@ -1159,16 +1001,12 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 		patch = zext_patch;
 		patch_len = 2;
 apply_patch_buffer:
-		new_prog = bpf_patch_insn_data(env, adj_idx, patch, patch_len);
-		if (!new_prog)
-			return -ENOMEM;
-		env->prog = new_prog;
-		insns = new_prog->insnsi;
-		aux = env->insn_aux_data;
-		delta += patch_len - 1;
+		patch = bpf_patch_list_add(env, i, patch, patch_len);
+		if (IS_ERR(patch))
+			return PTR_ERR(patch);
 	}
 
-	return 0;
+	return bpf_patch_list_commit(env);
 }
 
 /*
-- 
2.55.0

