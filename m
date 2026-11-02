Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793583050;
	b=ho7/ES8TSIhdnyQVfS1El7X5IDpB1vuJeKp2UJMzZOdE/+5jdDhvigF+tijaf+fr5IkS
	 luznOKZ6vIHyR4xciQieE9H5TVsu4/lJW1NgoRVFDqmp2XqPFKkV6ULBbcme2S/lNO9Y6
	 02tVXn1g8fbeS54EYLBpD7hxQxD3trDvf0qlXluU8vNk6yFpPQlHhV8VemgFA0Z++z8m0
	 opYaZWLnynMc6VvsqdFaSqaOeQ5v3/skvQcM23MZz4SAM946hH1MMexKXtH161+TBuqjp
	 S+gdC/CwBF35mOkGFAvlvdVSqcZ2KftzOxEM15aSlpyRS4uRjQz4WpGaIeRh6ElJXiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793583050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gBjy4qtnB2XUL4IZgKiMyX1X+dN1eLGoMVnl8wdz1jY=;
	b=AwbwI78JBE+rf10XkmA8s9qNT3xhBnPGqDmI2DGQzI2csDw+fJ5XX+Giu0WNuTtpA9Jk
	 N6GZl5KzcRZsicIYENcL8+wQEI3A6VrRasUB3saUyISc301l1WL+KByU8c3TI4y7AnoK/
	 PX3ukhye7vvStCBUdWLBMvm8SxF68xrOLidNB8YJ7L/ZuEUlhK1RUITskhTv51ugY9QoY
	 jiqVYlWTdaYxn03krtjqfSUw13AU9ZnxhW4/oCVJ2G+/rYXn26R1+ESuk+W5M8kxSS41B
	 hXGuvMcry71sxrl3lHP92+G87ZdDeEtcjtbPOP36HIg0sO893bjrJBJ5EY5AXRQuX5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qyjpow8J;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22663606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 01:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22663606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qyjpow8J
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a070781f63so886511b3a.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 17:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793583049; x=1794187849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gBjy4qtnB2XUL4IZgKiMyX1X+dN1eLGoMVnl8wdz1jY=;
        b=Qyjpow8JJ6uRBeBPHwXBtu1CzRZTV5uJCKzTf9WmtC8+K2JPT+msN9qQ3MrYO7S5QW
         mwkO2hCOg0bX749UEBiavPmADhZcz7eUkqqCRlnolOKHNmis5xjVT80FTtC9yKV1tZ5x
         eCwj60jKLatji2lCiynPxP17+RaCPkw4h3Fw8mJ1XuW06pNRNAFzYXAijc0SkGcOyrxy
         UuXH3wkfAeKfDDZx8G9MxvPPTwoU556mSFsXpGvCNE41nmr89WSbHk7MetUNq7ZKZtjY
         pzeCtPfCVqeT6r0XI87G9AA/VZUiMCAidg9f0n4lnAASDUC2IBF0VmVApQjukPUZq2gH
         kgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793583049; x=1794187849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gBjy4qtnB2XUL4IZgKiMyX1X+dN1eLGoMVnl8wdz1jY=;
        b=ZXurMhYMsaMxmkLK4FjUESDVIisbKqH15TDHjXTLFm9FKs/2v60yI74XnYlFQR/67Q
         kVqY+CnBkgkjbJYp5QMwaJkdJsSoUYru2wOT59atRw0bkr+K96t0WVGRONZaZw0Zcwxf
         FQKdZ5RzPKiw9vov0O9TJ/3XaatEIBuqgjGWZ9jvNgWf0zpvuw4ClLeHxNpkYwFyY9Kt
         TRqIix58b1yxsKA4Pl5ZPpqNLPV5CBwALsqjPd/4USdmC7mUMvbDF4SbtZiYsnkzb3ra
         mvf5A9WqrEFcN3wrGa0WtuRJ+K+LyF8tVmhwU1TEm20rGFeUw++Ddz8j/o6ClmuSnuXn
         oG7A==
X-Gm-Message-State: AFq9FYJeDxxWKxZzSZi6+FEhre6AMZsCG8d6Tem1mJPcLrb3UxEWKmWN
	lwsXEXEc7Tsjy68GhHPrpDDcv2582lI2ZCHXXfa+8dNKTQvZexhdUocNMtu13w==
X-Gm-Gg: AYBFou1jBzJss6d4qXIwX8832Erwn49D8lgdmmUGz5LsCNOSkjBr9h+3bzBhSGsC+GJ
	ogzBAij93KSUUkpbLwl+oPQAF4C1+IIgdDTtjW7J7SIUoeZ8pvKNHdLpOeOcbC/AbWhUQRmUqsc
	nuHf1q8neeZIIzE7+DkEUALDmib7JKwK2tE3DD6IQgVVFz8S6bolesADn2+4uJNL3gHNE02khGi
	8JyaE6Dud69dYiZZNqVJs4H9RQaIOYkbIxmlundganlUbLnNSXCnLSDTK+pP8u9i2Ku+epG6c2c
	ouTL1yVH7DbNDG/AbpdjG5VF1kCH0a61wBOfrZzO0ZfVearUaQzaitceys2jlfimPTRetWti5cL
	YTedYq9Vd315DlAgVGGUZPLBIq+x2gVRu8MJUXEK8S0YLNRUOL0NQH2h09y06y3BX+w9uCxB9co
	tgtGARqVhQ2Yn9RzkCTW4yI9ZqZjzRD56+aQmlwdVmMKDI+mwef7wMA5IPvqOdHUninVWWsrOTf
	/EQvJWi0zYFUUwIEPKQJ6nhqHgZmeGfpbXgBMLemF6RiA7O5YitiN2YB4Y593dZS47KEAhFgKLX
	rcQvRdoX+oR9Tbieaj2Bqe3DbqDWaNg4izwbg56FIZ2LGyYsDVgGQbjJ+PGuB6vNmgGgaLEYiBl
	uqNAoBwNCiKXtaVrf408IyGf8pc2pBPLSsqzb+XaSsRo/Pk+7nAhqyOKtbBsmzAle2hVunKNXKU
	laP/31nNVJJYbqTBnb6IQ=
X-Received: by 2002:a05:6a21:e8a:b0:3e2:a849:64c5 with SMTP id adf61e73a8af0-3e928d46874mr7235668637.19.1793583049051;
        Sun, 01 Nov 2026 17:30:49 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad9d06815sm1266075b3a.31.2026.11.01.17.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 17:30:48 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	odys.yuan@gmail.com
Subject: [PATCH bpf-next v3 11/13] bpf: Remove the old instruction patching code
Date: Mon,  2 Nov 2026 01:29:38 +0000
Message-ID: <20261102012940.1756142-12-alexei.starovoitov@gmail.com>
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

All passes queue their changes in the patch list. The functions that change
the prog immediately have no users. Remove bpf_patch_insn_data(),
bpf_patch_insn_single() and bpf_remove_insns(). Remove their helpers too,
which adjust the jumps and move the tables after each call.

bpf_patch_list_add() calls adjust_insn_aux_data() for a patch of 1 insn,
which it writes in place. Set zext_dst and non_stack_access in
bpf_patch_list_add() instead. Change the comments about the old code.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h          |   2 -
 include/linux/bpf_verifier.h |   2 -
 include/linux/filter.h       |  16 ---
 kernel/bpf/bpf_insn_array.c  |  34 ------
 kernel/bpf/core.c            | 193 ----------------------------------
 kernel/bpf/fixups.c          | 197 +++--------------------------------
 kernel/bpf/verifier.c        |  45 --------
 7 files changed, 15 insertions(+), 474 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b21a29a76b94..a80e81ca19ec 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -4378,8 +4378,6 @@ struct bpf_prog *bpf_prog_find_from_stack(void);
 int bpf_insn_array_init(struct bpf_map *map, const struct bpf_prog *prog);
 int bpf_insn_array_ready(struct bpf_map *map);
 void bpf_insn_array_release(struct bpf_map *map);
-void bpf_insn_array_adjust(struct bpf_map *map, u32 first, u32 len);
-void bpf_insn_array_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);
 void bpf_insn_array_remap(struct bpf_map *map, const u32 *new_off, const u32 *new_tgt,
 			  u32 cnt, s32 grow);
 
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 65313a26abb2..6a1fc8995940 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1597,8 +1597,6 @@ struct bpf_func_ptr *bpf_map_func_ptrs(struct bpf_verifier_env *env,
 struct bpf_func_ptr *bpf_map_range_func_ptrs(struct bpf_verifier_env *env,
 					     const struct bpf_map *map,
 					     u64 off, u64 size, u32 *cnt);
-void bpf_adjust_func_ptrs(struct bpf_verifier_env *env, u32 off, u32 len);
-void bpf_adjust_func_ptrs_after_remove(struct bpf_verifier_env *env, u32 off, u32 len);
 int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val,
 			bool is_ldsx);
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 904ac8613098..8a8134752f30 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1372,22 +1372,6 @@ static inline bool bpf_dump_raw_ok(const struct cred *cred)
 	return kallsyms_show_value(cred);
 }
 
-struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
-				       const struct bpf_insn *patch, u32 len);
-
-#ifdef CONFIG_BPF_SYSCALL
-struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
-				     const struct bpf_insn *patch, u32 len);
-#else
-static inline struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
-						   const struct bpf_insn *patch, u32 len)
-{
-	return ERR_PTR(-ENOTSUPP);
-}
-#endif /* CONFIG_BPF_SYSCALL */
-
-int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt);
-
 static inline bool xdp_return_frame_no_direct(void)
 {
 	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
index 79c5441ddd00..0ef9c708d18d 100644
--- a/kernel/bpf/bpf_insn_array.c
+++ b/kernel/bpf/bpf_insn_array.c
@@ -236,23 +236,6 @@ void bpf_insn_array_release(struct bpf_map *map)
 	atomic_set_release(&insn_array->used, 0);
 }
 
-void bpf_insn_array_adjust(struct bpf_map *map, u32 first, u32 len)
-{
-	struct bpf_insn_array *insn_array = cast_insn_array(map);
-	int i;
-
-	if (len <= 1)
-		return;
-
-	for (i = 0; i < map->max_entries; i++) {
-		if (insn_array->values[i].xlated_off < first)
-			continue;
-		if (insn_array->values[i].xlated_off == INSN_DELETED)
-			continue;
-		insn_array->values[i].xlated_off += len - 1;
-	}
-}
-
 /*
  * Move each offset to new_tgt[offset], new_off[] and new_tgt[] cover [0, cnt].
  * An insn is removed when new_off[] maps it to the same offset as the next
@@ -275,23 +258,6 @@ void bpf_insn_array_remap(struct bpf_map *map, const u32 *new_off, const u32 *ne
 	}
 }
 
-void bpf_insn_array_adjust_after_remove(struct bpf_map *map, u32 off, u32 len)
-{
-	struct bpf_insn_array *insn_array = cast_insn_array(map);
-	int i;
-
-	for (i = 0; i < map->max_entries; i++) {
-		if (insn_array->values[i].xlated_off < off)
-			continue;
-		if (insn_array->values[i].xlated_off == INSN_DELETED)
-			continue;
-		if (insn_array->values[i].xlated_off < off + len)
-			insn_array->values[i].xlated_off = INSN_DELETED;
-		else
-			insn_array->values[i].xlated_off -= len;
-	}
-}
-
 /*
  * This function is called by JITs. The image is the real program
  * image, the offsets array set up the xlated -> jitted mapping.
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index b9d9d0de5b92..0586ed020397 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -337,199 +337,6 @@ int bpf_prog_calc_tag(struct bpf_prog *fp)
 	return 0;
 }
 
-static int bpf_adj_delta_to_imm(struct bpf_insn *insn, u32 pos, s32 end_old,
-				s32 end_new, s32 curr, const bool probe_pass)
-{
-	const s64 imm_min = S32_MIN, imm_max = S32_MAX;
-	s32 delta = end_new - end_old;
-	s64 imm = insn->imm;
-
-	if (curr < pos && curr + imm + 1 >= end_old)
-		imm += delta;
-	else if (curr >= end_new && curr + imm + 1 < end_new)
-		imm -= delta;
-	if (imm < imm_min || imm > imm_max)
-		return -ERANGE;
-	if (!probe_pass)
-		insn->imm = imm;
-	return 0;
-}
-
-static int bpf_adj_delta_to_off(struct bpf_insn *insn, u32 pos, s32 end_old,
-				s32 end_new, s32 curr, const bool probe_pass)
-{
-	s64 off_min, off_max, off;
-	s32 delta = end_new - end_old;
-
-	if (insn->code == (BPF_JMP32 | BPF_JA)) {
-		off = insn->imm;
-		off_min = S32_MIN;
-		off_max = S32_MAX;
-	} else {
-		off = insn->off;
-		off_min = S16_MIN;
-		off_max = S16_MAX;
-	}
-
-	if (curr < pos && curr + off + 1 >= end_old)
-		off += delta;
-	else if (curr >= end_new && curr + off + 1 < end_new)
-		off -= delta;
-	if (off < off_min || off > off_max)
-		return -ERANGE;
-	if (!probe_pass) {
-		if (insn->code == (BPF_JMP32 | BPF_JA))
-			insn->imm = off;
-		else
-			insn->off = off;
-	}
-	return 0;
-}
-
-static int bpf_adj_branches(struct bpf_prog *prog, u32 pos, s32 end_old,
-			    s32 end_new, const bool probe_pass)
-{
-	u32 i, insn_cnt = prog->len + (probe_pass ? end_new - end_old : 0);
-	struct bpf_insn *insn = prog->insnsi;
-	int ret = 0;
-
-	for (i = 0; i < insn_cnt; i++, insn++) {
-		u8 code;
-
-		/* In the probing pass we still operate on the original,
-		 * unpatched image in order to check overflows before we
-		 * do any other adjustments. Therefore skip the patchlet.
-		 */
-		if (probe_pass && i == pos) {
-			i = end_new;
-			insn = prog->insnsi + end_old;
-		}
-		if (bpf_pseudo_func(insn)) {
-			ret = bpf_adj_delta_to_imm(insn, pos, end_old,
-						   end_new, i, probe_pass);
-			if (ret)
-				return ret;
-			continue;
-		}
-		code = insn->code;
-		if ((BPF_CLASS(code) != BPF_JMP &&
-		     BPF_CLASS(code) != BPF_JMP32) ||
-		    BPF_OP(code) == BPF_EXIT)
-			continue;
-		/* Adjust offset of jmps if we cross patch boundaries. */
-		if (BPF_OP(code) == BPF_CALL) {
-			if (insn->src_reg != BPF_PSEUDO_CALL)
-				continue;
-			ret = bpf_adj_delta_to_imm(insn, pos, end_old,
-						   end_new, i, probe_pass);
-		} else {
-			ret = bpf_adj_delta_to_off(insn, pos, end_old,
-						   end_new, i, probe_pass);
-		}
-		if (ret)
-			break;
-	}
-
-	return ret;
-}
-
-static void bpf_adj_linfo(struct bpf_prog *prog, u32 off, u32 delta)
-{
-	struct bpf_line_info *linfo;
-	u32 i, nr_linfo;
-
-	nr_linfo = prog->aux->nr_linfo;
-	if (!nr_linfo || !delta)
-		return;
-
-	linfo = prog->aux->linfo;
-
-	for (i = 0; i < nr_linfo; i++)
-		if (off < linfo[i].insn_off)
-			break;
-
-	/* Push all off < linfo[i].insn_off by delta */
-	for (; i < nr_linfo; i++)
-		linfo[i].insn_off += delta;
-}
-
-struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
-				       const struct bpf_insn *patch, u32 len)
-{
-	u32 insn_adj_cnt, insn_rest, insn_delta = len - 1;
-	const u32 cnt_max = S16_MAX;
-	struct bpf_prog *prog_adj;
-	int err;
-
-	/* Since our patchlet doesn't expand the image, we're done. */
-	if (insn_delta == 0) {
-		memcpy(prog->insnsi + off, patch, sizeof(*patch));
-		return prog;
-	}
-
-	insn_adj_cnt = prog->len + insn_delta;
-
-	/* Reject anything that would potentially let the insn->off
-	 * target overflow when we have excessive program expansions.
-	 * We need to probe here before we do any reallocation where
-	 * we afterwards may not fail anymore.
-	 */
-	if (insn_adj_cnt > cnt_max &&
-	    (err = bpf_adj_branches(prog, off, off + 1, off + len, true)))
-		return ERR_PTR(err);
-
-	/* Several new instructions need to be inserted. Make room
-	 * for them. Likely, there's no need for a new allocation as
-	 * last page could have large enough tailroom.
-	 */
-	prog_adj = bpf_prog_realloc(prog, bpf_prog_size(insn_adj_cnt),
-				    GFP_USER);
-	if (!prog_adj)
-		return ERR_PTR(-ENOMEM);
-
-	prog_adj->len = insn_adj_cnt;
-
-	/* Patching happens in 3 steps:
-	 *
-	 * 1) Move over tail of insnsi from next instruction onwards,
-	 *    so we can patch the single target insn with one or more
-	 *    new ones (patching is always from 1 to n insns, n > 0).
-	 * 2) Inject new instructions at the target location.
-	 * 3) Adjust branch offsets if necessary.
-	 */
-	insn_rest = insn_adj_cnt - off - len;
-
-	memmove(prog_adj->insnsi + off + len, prog_adj->insnsi + off + 1,
-		sizeof(*patch) * insn_rest);
-	memcpy(prog_adj->insnsi + off, patch, sizeof(*patch) * len);
-
-	/* We are guaranteed to not fail at this point, otherwise
-	 * the ship has sailed to reverse to the original state. An
-	 * overflow cannot happen at this point.
-	 */
-	BUG_ON(bpf_adj_branches(prog_adj, off, off + 1, off + len, false));
-
-	bpf_adj_linfo(prog_adj, off, insn_delta);
-
-	return prog_adj;
-}
-
-int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
-{
-	int err;
-
-	/* Branch offsets can't overflow when program is shrinking, no need
-	 * to call bpf_adj_branches(..., true) here
-	 */
-	memmove(prog->insnsi + off, prog->insnsi + off + cnt,
-		sizeof(struct bpf_insn) * (prog->len - off - cnt));
-	prog->len -= cnt;
-
-	err = bpf_adj_branches(prog, off, off + cnt, off, false);
-	WARN_ON_ONCE(err);
-	return err;
-}
-
 static int patch_list_reserve_patch(struct bpf_patch_list *pl)
 {
 	struct bpf_insn_patch *p;
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index d0d099c34c80..ead78713e04f 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -165,132 +165,10 @@ static int get_callee_stack_depth(struct bpf_verifier_env *env,
 }
 #endif
 
-enum bpf_patch_mode {
-	BPF_PATCH_KEEP_TARGET,	/* targets of 'off' keep naming 'off', the first new insn */
-	BPF_PATCH_MOVE_TARGET,	/* targets of 'off' follow the original insn to 'off + len - 1' */
-};
-
-/* single env->prog->insni[off] instruction was replaced with the range
- * insni[off, off + cnt).  Adjust corresponding insn_aux_data by copying
- * [0, off) and [off, end) to new locations, so the patched range stays zero
- */
-static void adjust_insn_aux_data(struct bpf_verifier_env *env,
-				 struct bpf_prog *new_prog, u32 off, u32 cnt,
-				 struct bpf_insn *original_insn,
-				 enum bpf_patch_mode mode)
-{
-	struct bpf_insn_aux_data *data = env->insn_aux_data;
-	struct bpf_insn *insn = new_prog->insnsi;
-	u32 old_seen = data[off].seen;
-	u32 prog_len;
-	int i;
-
-	/* aux info at OFF always needs adjustment, no matter fast path
-	 * (cnt == 1) is taken or not. There is no guarantee INSN at OFF is the
-	 * original insn at old prog.
-	 */
-	data[off].zext_dst = bpf_insn_def32(new_prog, insn + off + cnt - 1) >= 0;
-
-	if (cnt == 1) {
-		/*
-		 * A non-memory accessing insn could have been replaced by a
-		 * memory accessing insn, systematically mark it for non-stack
-		 * access
-		 */
-		data[off].non_stack_access = bpf_is_mem_insn(insn + off);
-		return;
-	}
-	prog_len = new_prog->len;
-	env->insn_aux_data_len = prog_len;
-
-	memmove(data + off + cnt - 1, data + off,
-		sizeof(struct bpf_insn_aux_data) * (prog_len - off - cnt + 1));
-	memset(data + off, 0, sizeof(struct bpf_insn_aux_data) * (cnt - 1));
-	for (i = off; i < off + cnt - 1; i++) {
-		/* Expand insni[off]'s seen count to the patched range. */
-		data[i].seen = old_seen;
-		data[i].zext_dst = bpf_insn_def32(new_prog, insn + i) >= 0;
-		/*
-		 * In BPF_PATCH_MOVE_TARGET mode the original insn is the last
-		 * slot by construction.
-		 */
-		if (mode == BPF_PATCH_KEEP_TARGET &&
-		    !memcmp(insn + i, original_insn, sizeof(struct bpf_insn))) {
-			data[i].non_stack_access =
-				data[off + cnt - 1].non_stack_access;
-			data[off + cnt - 1].non_stack_access = false;
-		} else if (bpf_is_mem_insn(insn + i)) {
-			data[i].non_stack_access = true;
-		}
-	}
-
-	/*
-	 * Last slot instruction could be a newly generated
-	 * BPF_ST/BPF_LDX/BPF_STX, systematically mark it for non-stack access
-	 * if it is not the original instruction, otherwise keep the
-	 * original marking
-	 */
-	if (bpf_is_mem_insn(insn + off + cnt - 1) &&
-	    memcmp(insn + off + cnt - 1, original_insn, sizeof(struct bpf_insn)))
-		data[off + cnt - 1].non_stack_access = true;
-
-	/*
-	 * The indirect_target flag of the original instruction was moved to the last of the
-	 * new instructions by the above memmove and memset, but the indirect jump target is
-	 * actually the first instruction, so move it back. This also matches with the behavior
-	 * of bpf_insn_array_adjust(), which preserves xlated_off to point to the first new
-	 * instruction. For BPF_PATCH_MOVE_TARGET the original instruction is the last one,
-	 * so the flag already sits where needed.
-	 */
-	if (mode == BPF_PATCH_KEEP_TARGET && data[off + cnt - 1].indirect_target) {
-		data[off].indirect_target = 1;
-		data[off + cnt - 1].indirect_target = 0;
-	}
-}
-
-static void adjust_subprog_starts(struct bpf_verifier_env *env, u32 off, u32 len)
-{
-	int i;
-
-	if (len == 1)
-		return;
-	/* NOTE: fake 'exit' subprog should be updated as well. */
-	for (i = 0; i <= env->subprog_cnt; i++) {
-		if (env->subprog_info[i].start <= off)
-			continue;
-		env->subprog_info[i].start += len - 1;
-	}
-}
-
-static void adjust_insn_arrays(struct bpf_verifier_env *env, u32 first, u32 len)
-{
-	int i;
-
-	if (len == 1)
-		return;
-
-	for (i = 0; i < env->insn_array_map_cnt; i++)
-		bpf_insn_array_adjust(env->insn_array_maps[i], first, len);
-}
-
-static void adjust_poke_descs(struct bpf_prog *prog, u32 first, u32 len)
-{
-	struct bpf_jit_poke_descriptor *tab = prog->aux->poke_tab;
-	int i, sz = prog->aux->size_poke_tab;
-	struct bpf_jit_poke_descriptor *desc;
-
-	for (i = 0; i < sz; i++) {
-		desc = &tab[i];
-		if (desc->insn_idx < first)
-			continue;
-		desc->insn_idx += len - 1;
-	}
-}
-
 /*
- * Some post-verification instruction rewriting passes require an
- * O(prog->len) operation per instruction. Keep their shared primitives
- * killable and preemptible.
+ * A post-verification rewriting pass can queue a patch for each instruction
+ * of a large program. Keep the primitives that queue them killable and
+ * preemptible.
  */
 static bool bpf_rewrite_must_abort(void)
 {
@@ -300,53 +178,6 @@ static bool bpf_rewrite_must_abort(void)
 	return false;
 }
 
-static struct bpf_prog *__bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
-					      const struct bpf_insn *patch, u32 len,
-					      enum bpf_patch_mode mode)
-{
-	struct bpf_prog *new_prog;
-	struct bpf_insn_aux_data *new_data = NULL;
-	/* The first slot whose targets move. */
-	u32 first = mode == BPF_PATCH_MOVE_TARGET ? off : off + 1;
-	struct bpf_insn original_insn;
-
-	if (bpf_rewrite_must_abort())
-		return NULL;
-
-	if (len > 1) {
-		new_data = vrealloc(env->insn_aux_data,
-				    array_size(env->prog->len + len - 1,
-					       sizeof(struct bpf_insn_aux_data)),
-				    GFP_KERNEL_ACCOUNT | __GFP_ZERO);
-		if (!new_data)
-			return NULL;
-
-		env->insn_aux_data = new_data;
-	}
-
-	memcpy(&original_insn, env->prog->insnsi + off, sizeof(struct bpf_insn));
-	new_prog = bpf_patch_insn_single(env->prog, off, patch, len);
-	if (IS_ERR(new_prog)) {
-		if (PTR_ERR(new_prog) == -ERANGE)
-			verbose(env,
-				"insn %d cannot be patched due to 16-bit range\n",
-				env->insn_aux_data[off].orig_idx);
-		return NULL;
-	}
-	adjust_insn_aux_data(env, new_prog, off, len, &original_insn, mode);
-	adjust_subprog_starts(env, off, len);
-	adjust_insn_arrays(env, first, len);
-	bpf_adjust_func_ptrs(env, off, len);
-	adjust_poke_descs(new_prog, first, len);
-	return new_prog;
-}
-
-struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
-				     const struct bpf_insn *patch, u32 len)
-{
-	return __bpf_patch_insn_data(env, off, patch, len, BPF_PATCH_KEEP_TARGET);
-}
-
 /*
  * Queue the replacement of insn 'off' by 'patch[0..len)' until
  * bpf_patch_list_commit(), see __bpf_patch_list_add(). Replacing one insn by
@@ -368,10 +199,13 @@ struct bpf_insn *bpf_patch_list_add(struct bpf_verifier_env *env, u32 off,
 		return ERR_PTR(-EFAULT);
 
 	if (len == 1 && (!p || off != p->off)) {
-		env->prog->insnsi[off] = *patch;
-		adjust_insn_aux_data(env, env->prog, off, 1, NULL,
-				     BPF_PATCH_KEEP_TARGET);
-		return &env->prog->insnsi[off];
+		struct bpf_insn *insn = &env->prog->insnsi[off];
+
+		*insn = *patch;
+		env->insn_aux_data[off].zext_dst = bpf_insn_def32(env->prog, insn) >= 0;
+		/* a new insn may access memory, systematically mark it non-stack */
+		env->insn_aux_data[off].non_stack_access = bpf_is_mem_insn(insn);
+		return insn;
 	}
 
 	/* -ERANGE takes a second patch with a 16-bit jump back out of it: no pass has one */
@@ -424,8 +258,7 @@ void bpf_patch_list_free(struct bpf_verifier_env *env)
 
 /*
  * Fill the aux data of the 'p->len' insns at 'slot' from the aux data 'old'
- * of the insn they replace, the same way as adjust_insn_aux_data() does.
- * The insns in front of p->target were inserted, as with BPF_PATCH_MOVE_TARGET.
+ * of the insn they replace. The insns in front of p->target were inserted.
  */
 static void patch_list_adj_aux(struct bpf_prog *prog, struct bpf_insn_patch *p,
 			       struct bpf_insn *patch,
@@ -619,10 +452,10 @@ static void patch_list_remap_subprogs(struct bpf_verifier_env *env,
 /*
  * Apply all queued patches and removals in one go. Everything that names an
  * insn of the old image follows it to the new one. A patched insn is named by
- * the first insn of its patch, like with bpf_patch_insn_data(). If insns were
- * inserted in front of an insn, jumps, instruction arrays and poke descriptors
- * name the insn itself, while subprogs, line info, function pointers and calls
- * name the first inserted insn.
+ * the first insn of its patch. If insns were inserted in front of an insn,
+ * jumps, instruction arrays and poke descriptors name the insn itself, while
+ * subprogs, line info, function pointers and calls name the first inserted
+ * insn.
  *
  * An entry that names a removed insn:
  *   jump, call, poke descriptor  names the next insn that stays
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5bdf41a9bef0..935b163f81e4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6416,51 +6416,6 @@ struct bpf_func_ptr *bpf_map_func_ptrs(struct bpf_verifier_env *env,
 	return bpf_map_range_func_ptrs(env, map, 0, (u64)map->value_size, cnt);
 }
 
-/* instructions [off, off + len) replaced the instruction at 'off' */
-void bpf_adjust_func_ptrs(struct bpf_verifier_env *env, u32 off, u32 len)
-{
-	struct bpf_func_ptr *p;
-	u32 i;
-
-	if (len <= 1)
-		return;
-
-	for (i = 0; i < env->func_ptr_cnt; i++) {
-		p = &env->func_ptrs[i];
-		if (p->xlated_off <= off || p->xlated_off == BPF_FUNC_PTR_DELETED)
-			continue;
-		p->xlated_off += len - 1;
-	}
-}
-
-/*
- * Instructions [off, off + len) are about to be removed. It's called before
- * the starts of subprogs are adjusted. A subprog is gone when all of its
- * instructions are. Otherwise, e.g. when its first instruction is a nop,
- * it starts where the removed instructions did.
- */
-void bpf_adjust_func_ptrs_after_remove(struct bpf_verifier_env *env, u32 off, u32 len)
-{
-	struct bpf_func_ptr *p;
-	int subprog;
-	u32 i;
-
-	for (i = 0; i < env->func_ptr_cnt; i++) {
-		p = &env->func_ptrs[i];
-		if (p->xlated_off < off || p->xlated_off == BPF_FUNC_PTR_DELETED)
-			continue;
-		if (p->xlated_off >= off + len) {
-			p->xlated_off -= len;
-			continue;
-		}
-		subprog = bpf_find_subprog(env, p->xlated_off);
-		if (subprog > 0 && env->subprog_info[subprog + 1].start > off + len)
-			p->xlated_off = off;
-		else
-			p->xlated_off = BPF_FUNC_PTR_DELETED;
-	}
-}
-
 #define BTF_TYPE_SAFE_RCU(__type)  __PASTE(__type, __safe_rcu)
 #define BTF_TYPE_SAFE_RCU_OR_NULL(__type)  __PASTE(__type, __safe_rcu_or_null)
 #define BTF_TYPE_SAFE_TRUSTED(__type)  __PASTE(__type, __safe_trusted)
-- 
2.55.0

