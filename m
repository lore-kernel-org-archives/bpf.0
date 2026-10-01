Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6530A4E0B73
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790847349; cv=none; b=Goxl2Bwc8zGoGBjjAsB2OEnQdcGxAhqmaiYaMCQOZ7SHxWsjjcasB3XeQXWQUp+YVkjs65B+u6Ugh1UtVEk86GzE4KR626U0s2GUxVG00dZ6FzJS2CdlY6ipchv3W3MimeayS3PRLR0sci5SDlzIkypNAvfizCHoH8me/FQTkp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790847349; c=relaxed/simple;
	bh=R9VpuZgq7vFSy5UYs4t82wH9U4uVkVrxbunMOVVX/JU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hDExPmK68Jg29VbEK8TRSBtqkSCSwxzN8ORhHbNRNMABGwxqHrlQLj2ImpGogQ2OU27cB47+hSiumXmov87l98FO7tUihjUrbrckTUPFhBat76VZnmJzSvphXBA2F6QzYxmdMTiHVb2zTV560F222iZa6v8M4eme+h9RZ9bhN7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWaEiXUO; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWaEiXUO"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-3396cec93b6so7171302eec.3
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2026 02:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790847345; x=1791452145; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W5AuqYzQ2ZzAZr/hbIpKCvkK3yyzAVxb0HnkMvxVjgc=;
        b=BWaEiXUOQh9CtQWgHfJ/+TDi+l5knS063v/zlRZdGi7nd2EnwryP1xaLRaHQaUEUE6
         LepCnjljle1reTUJnegWUEkww11/musRfeJ4tmxb/fgY8/5Fg+ApSfKjVOA63sAOjr/y
         JcqG/k43RoTbwS63gZb6FRCDupZTyeScylOSe49hyr++/0jHICHzTbzPG5QJT6Cj+vFh
         q5bw13ernSqI5E3gz+hB8fTYEAiJfPpH2oDwnmLGaCf2kowZMISQtX9pxVAP5YJ/KEnM
         EH1HprRFYapNbIh5dJWh2MZtDB6O5b79l5izZhOI1fJ0GA2Rdec/WUW5PvXYjzLvwVFK
         Q1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790847345; x=1791452145;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W5AuqYzQ2ZzAZr/hbIpKCvkK3yyzAVxb0HnkMvxVjgc=;
        b=GJKs0cWBCN2Ydovrgy4LQMB9dcKqEjllxU0ubc+B0ifyIPvVBBvCRaLbkyQfJPGT7r
         hwpAo9SlFCOSd1PI0u+i0+wBM/rxTV+T9SWl9DSe86/xR9tgRSjb6v062cfKVi/fWQIF
         80ejiTRHPmc/f3FtyZuPP6r5TAGw1zDjp8qSP+tkAq0fzAmBBq5asqWBBJxETs7Qu+eH
         fm9Y9NAoGwqwYC+4SCZv8Jk8MF95s62wQodZW0SUI3r0Ezj2rZtvS9quQ537hCoXC1NT
         uaX//tkgxXR44Of1s3xcaitVGMoP32J4XL2QiAB7j3KgRHU7hRdDcY2xiAZQWayj14Ia
         xurg==
X-Gm-Message-State: AFuF++lc2KiZFcZVNeHWVJQHamY+fAPT6SnNpJt8JF1vONt8/CiflWrk
	EFv1lvCeoZlKlQzOglQjzte9IUhXQnp6JTKJlxFJTB87MIueELHXbPmO
X-Gm-Gg: AYBFou02L9gzkpUlq9hO56VLtI3iBDQ3uTWOnlQPNIJ+mBYcbXCpBATq2tjQSR8W48w
	ZxlX4+4JQYOP1AjHCkCLgr7hvr3RAd2k4mLPMJPLRoX/PU76VY8KJ8y0FscBlLdWj0oRDTHeePZ
	HDF4aX9MhhQP5XOOW3HfY0qSd8AjizHN1Tu+eT8TlRh8R0uL1Pelj0M9GEWErWMtfciVt39plXM
	BgWagR3NDK4MbSITu3z5MZbxrUJY0aYRzwA/z4HxzFN+1M0v5OIZcRyks9wPTHHMlcLJIh6f8eD
	hpYcty0+SPQsHicLPwBBiLEjP12P7WCm4SjURKqW3RmgVMKm0T0VHRGmqKtILqyKJ9NkNHDZ/UC
	egATBRAp7yIVVMdg+EsafE0QXlq0OhdJtYR3WDsP6ksR0JsYaKIOJk578fdzKM2jYZkHQ0iec3d
	pNJ5L66IsP4a83daDbWZbloXG/y7FRzdZop/Ba+NCOvc/jewYf3JZu8zGZqei4jcHBVw==
X-Received: by 2002:a05:7301:df43:b0:34a:e7ba:863c with SMTP id 5a478bee46e88-34ce0156f0fmr4531959eec.18.1790847345224;
        Thu, 01 Oct 2026 02:35:45 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db37507a7sm6003982eec.13.2026.10.01.02.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 02:35:44 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Thu, 01 Oct 2026 17:35:32 +0800
Subject: [PATCH bpf-next 1/4] bpf: Add a list of deferred instruction
 patches
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-bpf-verifier-patch-batch-v1-1-a12df8a09160@gmail.com>
References: <20261001-bpf-verifier-patch-batch-v1-0-a12df8a09160@gmail.com>
In-Reply-To: <20261001-bpf-verifier-patch-batch-v1-0-a12df8a09160@gmail.com>
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

bpf_patch_insn_data() applies a patch right away. It moves the tail of
the instruction and aux data arrays, and it walks the whole program to
fix up branches and every table that names instructions. A pass that
patches M instructions of an N instruction program does O(N * M) work.

pyperf180 from the selftests has 930 bpf_map_lookup_elem() calls on
hash maps. bpf_do_misc_fixups() inlines each of them into 3 instructions
of a 24k instruction program, which takes about a fifth of the time to
load it.

Add a list of patches that a pass queues with bpf_patch_list_add() and
applies with bpf_patch_list_commit() in O(N + inserted instructions).
Until the commit nothing moves, the pass keeps addressing instructions
and aux data by their index in the unpatched program, so patches are
queued in increasing order.

The commit maps each old index to a new one and names a patched
instruction by the first instruction of its patch, as
bpf_patch_insn_data() does. Branches, aux data, subprog starts, line
info, instruction arrays, function pointers and poke descriptors all
follow the map. The new image is built aside first, so a branch that
gets out of range leaves the program untouched.

A patch of a single instruction moves nothing and is applied right
away.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 include/linux/bpf.h          |   1 +
 include/linux/bpf_verifier.h |  26 ++++
 kernel/bpf/bpf_insn_array.c  |  18 +++
 kernel/bpf/fixups.c          | 295 +++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        |   1 +
 5 files changed, 341 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4bae3796c42f6..17932ff8b0ae9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -4299,6 +4299,7 @@ int bpf_insn_array_ready(struct bpf_map *map);
 void bpf_insn_array_release(struct bpf_map *map);
 void bpf_insn_array_adjust(struct bpf_map *map, u32 first, u32 len);
 void bpf_insn_array_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);
+void bpf_insn_array_remap(struct bpf_map *map, const u32 *new_off, u32 cnt, u32 grow);
 
 #ifdef CONFIG_BPF_SYSCALL
 void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image);
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 811342e3c0419..5a968539589f8 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -929,6 +929,27 @@ struct bpf_fd_array {
 	};
 };
 
+/* one deferred patch: insn 'off' is replaced by 'len' insns */
+struct bpf_insn_patch {
+	u32 off;
+	u32 len;
+	u32 start;		/* first insn of the patch in bpf_patch_list.insns */
+	struct bpf_insn orig;	/* the replaced insn when the patch was queued */
+};
+
+/*
+ * Patches queued by a rewrite pass, applied together by
+ * bpf_patch_list_commit() in O(prog->len + inserted insns).
+ */
+struct bpf_patch_list {
+	struct bpf_insn_patch *patches;
+	struct bpf_insn *insns;
+	u32 cnt;
+	u32 cap;
+	u32 insn_cnt;
+	u32 insn_cap;
+};
+
 /* single container for all structs
  * one verifier_env per bpf_check() call
  */
@@ -973,6 +994,7 @@ struct bpf_verifier_env {
 	bool signature;
 	u32 insn_aux_data_len;
 	struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
+	struct bpf_patch_list patch_list;
 	const struct bpf_line_info *prev_linfo;
 	struct bpf_verifier_log log;
 	struct bpf_diag *diag;
@@ -1834,5 +1856,9 @@ int bpf_jit_subprogs(struct bpf_verifier_env *env);
 int bpf_fixup_call_args(struct bpf_verifier_env *env);
 int bpf_do_misc_fixups(struct bpf_verifier_env *env);
 int bpf_insn_def32(struct bpf_prog *prog, struct bpf_insn *insn);
+struct bpf_insn *bpf_patch_list_add(struct bpf_verifier_env *env, u32 off,
+				    const struct bpf_insn *patch, u32 len);
+int bpf_patch_list_commit(struct bpf_verifier_env *env);
+void bpf_patch_list_free(struct bpf_verifier_env *env);
 
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
index 92bbb71576ae3..74f07ced85cb0 100644
--- a/kernel/bpf/bpf_insn_array.c
+++ b/kernel/bpf/bpf_insn_array.c
@@ -253,6 +253,24 @@ void bpf_insn_array_adjust(struct bpf_map *map, u32 first, u32 len)
 	}
 }
 
+/*
+ * Move each offset to new_off[offset], new_off[] covers [0, cnt]. Offsets
+ * past the end of the old program only move by 'grow'.
+ */
+void bpf_insn_array_remap(struct bpf_map *map, const u32 *new_off, u32 cnt, u32 grow)
+{
+	struct bpf_insn_array *insn_array = cast_insn_array(map);
+	u32 off;
+	int i;
+
+	for (i = 0; i < map->max_entries; i++) {
+		off = insn_array->values[i].xlated_off;
+		if (off == INSN_DELETED)
+			continue;
+		insn_array->values[i].xlated_off = off <= cnt ? new_off[off] : off + grow;
+	}
+}
+
 void bpf_insn_array_adjust_after_remove(struct bpf_map *map, u32 off, u32 len)
 {
 	struct bpf_insn_array *insn_array = cast_insn_array(map);
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 37cf130ebb57b..39566f3825108 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -404,6 +404,301 @@ struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
 	return __bpf_patch_insn_data(env, off, patch, len, BPF_PATCH_KEEP_TARGET);
 }
 
+/*
+ * Queue the replacement of insn 'off' by 'patch[0..len)'. Nothing moves until
+ * bpf_patch_list_commit(), so a pass keeps addressing insns and their aux data
+ * by their index in env->prog. Patches must be queued in increasing order of
+ * 'off'. Jumps in the patch that leave it are relative to the patch placed at
+ * 'off', the same way as for bpf_patch_insn_data().
+ *
+ * Return the copy of the last insn of the patch, which stays valid until the
+ * next call.
+ */
+struct bpf_insn *bpf_patch_list_add(struct bpf_verifier_env *env, u32 off,
+				    const struct bpf_insn *patch, u32 len)
+{
+	struct bpf_patch_list *pl = &env->patch_list;
+	struct bpf_insn_patch *p;
+	struct bpf_insn *insns;
+	u32 cap;
+
+	if (bpf_rewrite_must_abort())
+		return ERR_PTR(-EINTR);
+
+	if (verifier_bug_if(!len || off >= env->prog->len ||
+			    (pl->cnt && off <= pl->patches[pl->cnt - 1].off),
+			    env, "insn %u patched out of order", off))
+		return ERR_PTR(-EFAULT);
+
+	/* Replacing one insn by one moves nothing, do it right away. */
+	if (len == 1) {
+		env->prog->insnsi[off] = *patch;
+		adjust_insn_aux_data(env, env->prog, off, 1, NULL,
+				     BPF_PATCH_KEEP_TARGET);
+		return &env->prog->insnsi[off];
+	}
+
+	if (pl->cnt == pl->cap) {
+		cap = max(pl->cap * 2, 16U);
+		p = kvrealloc(pl->patches, array_size(cap, sizeof(*p)),
+			      GFP_KERNEL_ACCOUNT);
+		if (!p)
+			return ERR_PTR(-ENOMEM);
+		pl->patches = p;
+		pl->cap = cap;
+	}
+
+	if (pl->insn_cnt + len > pl->insn_cap) {
+		cap = max3(pl->insn_cap * 2, pl->insn_cnt + len, 64U);
+		insns = kvrealloc(pl->insns, array_size(cap, sizeof(*insns)),
+				  GFP_KERNEL_ACCOUNT);
+		if (!insns)
+			return ERR_PTR(-ENOMEM);
+		pl->insns = insns;
+		pl->insn_cap = cap;
+	}
+
+	p = &pl->patches[pl->cnt++];
+	p->off = off;
+	p->len = len;
+	p->start = pl->insn_cnt;
+	p->orig = env->prog->insnsi[off];
+	memcpy(pl->insns + p->start, patch, len * sizeof(*patch));
+	pl->insn_cnt += len;
+
+	return &pl->insns[p->start + len - 1];
+}
+
+void bpf_patch_list_free(struct bpf_verifier_env *env)
+{
+	struct bpf_patch_list *pl = &env->patch_list;
+
+	kvfree(pl->patches);
+	kvfree(pl->insns);
+	memset(pl, 0, sizeof(*pl));
+}
+
+/* Extract the pc-relative operand of a jump, a subprog call or a ld_imm64 of a subprog. */
+static bool insn_get_rel(const struct bpf_insn *insn, s64 *rel, bool *is_imm)
+{
+	u8 code = insn->code;
+
+	if (bpf_pseudo_func(insn) || bpf_pseudo_call(insn)) {
+		*rel = insn->imm;
+		*is_imm = true;
+		return true;
+	}
+	if ((BPF_CLASS(code) != BPF_JMP && BPF_CLASS(code) != BPF_JMP32) ||
+	    BPF_OP(code) == BPF_CALL || BPF_OP(code) == BPF_EXIT)
+		return false;
+
+	*is_imm = code == (BPF_JMP32 | BPF_JA);
+	*rel = *is_imm ? insn->imm : insn->off;
+	return true;
+}
+
+/*
+ * insn is number 'idx' of the 'len' insns that replace insn 'off' of the old
+ * image (an insn that isn't patched is its own patch of length 1). It lands
+ * at 'pos' of the new image. 'new_off' maps the old image to the new one.
+ */
+static int patch_list_adj_insn(struct bpf_insn *insn, const u32 *new_off,
+			       u32 cnt, u32 off, u32 idx, u32 len, u32 pos)
+{
+	bool is_imm;
+	s64 rel, tgt;
+
+	if (!insn_get_rel(insn, &rel, &is_imm))
+		return 0;
+
+	/* relative to the first insn of the patch */
+	tgt = (s64)idx + rel + 1;
+	if (tgt >= 0 && tgt < len)
+		return 0;
+
+	/* the patch pushed what follows 'off' down by len - 1 */
+	tgt = tgt < 0 ? off + tgt : off + tgt - len + 1;
+	if (tgt < 0 || tgt > cnt)
+		return -EFAULT;
+
+	rel = (s64)new_off[tgt] - pos - 1;
+	if (is_imm) {
+		if (rel < S32_MIN || rel > S32_MAX)
+			return -ERANGE;
+		insn->imm = rel;
+	} else {
+		if (rel < S16_MIN || rel > S16_MAX)
+			return -ERANGE;
+		insn->off = rel;
+	}
+	return 0;
+}
+
+/*
+ * Fill the aux data of the 'p->len' insns at 'slot' from the aux data 'old'
+ * of the insn they replace, the same way as adjust_insn_aux_data() does.
+ */
+static void patch_list_adj_aux(struct bpf_prog *prog, struct bpf_insn_patch *p,
+			       struct bpf_insn *patch,
+			       const struct bpf_insn_aux_data *old,
+			       struct bpf_insn_aux_data *slot)
+{
+	struct bpf_insn_aux_data *last = slot + p->len - 1;
+	struct bpf_insn *orig = &p->orig;
+	u32 i;
+
+	*last = *old;
+	last->zext_dst = bpf_insn_def32(prog, &patch[p->len - 1]) >= 0;
+	memset(slot, 0, sizeof(*slot) * (p->len - 1));
+
+	for (i = 0; i < p->len - 1; i++) {
+		slot[i].seen = last->seen;
+		slot[i].zext_dst = bpf_insn_def32(prog, &patch[i]) >= 0;
+		if (!memcmp(&patch[i], orig, sizeof(*orig))) {
+			slot[i].non_stack_access = last->non_stack_access;
+			last->non_stack_access = false;
+		} else if (bpf_is_mem_insn(&patch[i])) {
+			slot[i].non_stack_access = true;
+		}
+	}
+
+	if (bpf_is_mem_insn(&patch[p->len - 1]) &&
+	    memcmp(&patch[p->len - 1], orig, sizeof(*orig)))
+		last->non_stack_access = true;
+
+	/* indirect jumps to the replaced insn land on the first new one */
+	if (last->indirect_target) {
+		slot[0].indirect_target = 1;
+		last->indirect_target = 0;
+	}
+}
+
+static u32 patch_list_remap(const u32 *new_off, u32 cnt, u32 grow, u32 off)
+{
+	return off <= cnt ? new_off[off] : off + grow;
+}
+
+/*
+ * Apply all queued patches in one go. Everything that names an insn of the
+ * old image follows it to the new one, a patched insn is named by the first
+ * insn of its patch, like with bpf_patch_insn_data().
+ */
+int bpf_patch_list_commit(struct bpf_verifier_env *env)
+{
+	struct bpf_patch_list *pl = &env->patch_list;
+	struct bpf_prog *prog = env->prog;
+	u32 cnt = prog->len, new_cnt, grow = 0, end, i, k, n;
+	struct bpf_insn_aux_data *data;
+	struct bpf_insn *insns = NULL;
+	struct bpf_insn_patch *p;
+	u32 *new_off = NULL;
+	int err = 0;
+
+	if (!pl->cnt)
+		goto out;
+
+	err = -ENOMEM;
+	new_off = kvmalloc_array(cnt + 1, sizeof(*new_off), GFP_KERNEL_ACCOUNT);
+	if (!new_off)
+		goto out;
+
+	for (i = 0, k = 0; i <= cnt; i++) {
+		new_off[i] = i + grow;
+		if (k < pl->cnt && pl->patches[k].off == i)
+			grow += pl->patches[k++].len - 1;
+	}
+	new_cnt = cnt + grow;
+
+	/*
+	 * Build the new image aside first, so that a jump that goes out of
+	 * range leaves the program untouched.
+	 */
+	insns = kvmalloc_array(new_cnt, sizeof(*insns), GFP_KERNEL_ACCOUNT);
+	if (!insns)
+		goto out;
+
+	for (i = 0, k = 0; i < cnt; i++) {
+		const struct bpf_insn *src = &prog->insnsi[i];
+		u32 len = 1;
+
+		if (k < pl->cnt && pl->patches[k].off == i) {
+			src = &pl->insns[pl->patches[k].start];
+			len = pl->patches[k++].len;
+		}
+
+		for (n = 0; n < len; n++) {
+			insns[new_off[i] + n] = src[n];
+			err = patch_list_adj_insn(&insns[new_off[i] + n], new_off,
+						  cnt, i, n, len, new_off[i] + n);
+			if (err == -ERANGE) {
+				verbose(env, "insn %d cannot be patched due to 16-bit range\n",
+					env->insn_aux_data[i].orig_idx);
+				goto out;
+			}
+			if (verifier_bug_if(err, env, "insn %u jumps out of the program", i))
+				goto out;
+		}
+	}
+
+	err = -ENOMEM;
+	data = vrealloc(env->insn_aux_data,
+			array_size(new_cnt, sizeof(*data)),
+			GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	if (!data)
+		goto out;
+	env->insn_aux_data = data;
+
+	prog = bpf_prog_realloc(prog, bpf_prog_size(new_cnt), GFP_USER);
+	if (!prog)
+		goto out;
+	env->prog = prog;
+
+	memcpy(prog->insnsi, insns, sizeof(*insns) * new_cnt);
+	prog->len = new_cnt;
+
+	/* Move aux data from the end, an insn never moves to a lower index. */
+	end = cnt;
+	for (k = pl->cnt; k-- > 0;) {
+		p = &pl->patches[k];
+		memmove(data + new_off[p->off + 1], data + p->off + 1,
+			sizeof(*data) * (end - p->off - 1));
+		patch_list_adj_aux(prog, p, &pl->insns[p->start], &data[p->off],
+				   &data[new_off[p->off]]);
+		end = p->off;
+	}
+	env->insn_aux_data_len = new_cnt;
+
+	/* NOTE: fake 'exit' subprog should be updated as well. */
+	for (i = 0; i <= env->subprog_cnt; i++)
+		env->subprog_info[i].start =
+			patch_list_remap(new_off, cnt, grow, env->subprog_info[i].start);
+
+	for (i = 0; i < prog->aux->nr_linfo; i++)
+		prog->aux->linfo[i].insn_off =
+			patch_list_remap(new_off, cnt, grow, prog->aux->linfo[i].insn_off);
+
+	for (i = 0; i < env->insn_array_map_cnt; i++)
+		bpf_insn_array_remap(env->insn_array_maps[i], new_off, cnt, grow);
+
+	for (i = 0; i < env->func_ptr_cnt; i++) {
+		if (env->func_ptrs[i].xlated_off == BPF_FUNC_PTR_DELETED)
+			continue;
+		env->func_ptrs[i].xlated_off =
+			patch_list_remap(new_off, cnt, grow, env->func_ptrs[i].xlated_off);
+	}
+
+	for (i = 0; i < prog->aux->size_poke_tab; i++)
+		prog->aux->poke_tab[i].insn_idx =
+			patch_list_remap(new_off, cnt, grow, prog->aux->poke_tab[i].insn_idx);
+
+	err = 0;
+out:
+	kvfree(insns);
+	kvfree(new_off);
+	bpf_patch_list_free(env);
+	return err;
+}
+
 /*
  * insn was moved down by delta insns inside its own patch. Operands relative
  * to the pc that point in front of the old position did not move with it.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b840b3eb9b229..7c1bed0c66c64 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22753,6 +22753,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 err_free_env:
 	bpf_free_subprog_jts(env);
 	vfree(env->insn_aux_data);
+	bpf_patch_list_free(env);
 	kvfree(env->fd_array);
 	bpf_stack_liveness_free(env);
 	kvfree(env->cfg.insn_postorder);

-- 
2.43.0

