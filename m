Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361162;
	b=HZnSPXcDrXxrDjknAZblacE4l9ZHPEJQKLCGzgRie0gIBf4KOqQGtbO+p3eM2KGkaTaL
	 p0bu5W9HDEGUQYiqM0PJm+1zbcfXs/z0cKl8bsrlb7R8l4+fBxhwaXrskcoR8It1l0eNt
	 C1kR1vdJJUZXwJxY3MtiwRqH+p/lRm8oq7A7uh5gUghAyyII5rvW3ICE2K6TCgKQTkZhM
	 tv5g+XMiiFyMifsrUsRAA3P65jrDGFyEP5cVt+wXhpsHg8Ebet7T5tJ6WCPUVvlDUdYy9
	 sMp9XI+VfOaD6p/ZsYhFNzm90/uNv1FlQE7Kw4E5EMPWJdTGPvC90GJXihaWHjonwEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=Iaj1sSwxGW2T2ZYTzsyLzlK1pKpVJ1ZuRU1k4FtQ+9k=;
	b=KN8+x7O5mGOoZOxcbVdp8hvTbJAM3bKsk6MGRE1691cJz+hv3r0aopjJSSznivzpABF7
	 u8H68BeHA+ku8vDuVSmTrMYGIGLHPmY79hn0ahr+Itt1wFFXpLm3u7uEZMRa0Gvm/+wrV
	 0q1g1jZi+lfEJXEMMfIkNY400FqQ82a5i9fiVfOF6W/RamG7EMwTLLsKc7hLDqTtfWLlI
	 LI6yGAGKCHODfUi9wL/IVg/dKUOzirw5z8z/jPmTs8DdmLxWE62FeeGbY5ep/uck7DV6w
	 KlJRcNHxvSTGEo/uR+QInv//MblsASmmdaF5QCCIaGlT3w1JQbnU4TamdGbpeDc7d5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mecgm0v0;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1854D606A32C
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 11:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1854D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mecgm0v0
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1a3c08d6928so718891c88.0
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 04:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793361160; x=1793965960; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iaj1sSwxGW2T2ZYTzsyLzlK1pKpVJ1ZuRU1k4FtQ+9k=;
        b=Mecgm0v0oSdcH99fhKlHSdy15snsTKlHtBODX0A8cRlguZJ4WhHDeXYFZdqzLI2vOy
         4+xC7JptTaFDIk8l1ThE+HXwDPkblcNPxxuhW773V+m4+EYPm3FgGSDmBgpc1QMe1tKc
         t/SMuxejQTO/NIPtxHI+6z+f2T6YLBKpOLLLD6Wl0Vwjt8WAeEzPixbQdb6iXm9gLNKK
         p9tsrR25PXWFtkh9ZV4781RGuxtXoyrVnjBa/r5U7jXsfTtuTYrFNv9CCLPAfrL/G/HG
         cGsSBJmcAbZ8Kc0jBWAkskqXc+xyQR0NtzrTg4304wS8df/WODcdFvAOczuavikcZAS0
         504A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361160; x=1793965960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iaj1sSwxGW2T2ZYTzsyLzlK1pKpVJ1ZuRU1k4FtQ+9k=;
        b=gznYhSxoNaxhz7N7BNgr9bSN2ufiDOX/2jaiThvscNoEe4rDtl+eQ03dX35vTmb0J1
         +Cnq70fMqnzx8aLSCtGSWyajct1ifDqKSVHbPhERvuMr8GbR798PLMGlZt+6qsrGqnVO
         CVo+6B30zLY4FFx2E+O5OVL7dhoJf2BRqC1HUpLdCdnaBQGacdXbCMDxrgpPoWKX9elW
         oaPxK8Zfhf3Z3XqgU65QiknmqdCHmOr5z9TD34NRIywc8zFRc9YGRBcs53XfHO7YWh0H
         IiMX0F3D6SQlVy2D126Bm6fsOBLNLrujz96kEFp+ZZbC6x1BZKYWtYr19io3W2a1swoE
         YYDw==
X-Gm-Message-State: AFq9FYIpzfLigSF4Xvf4MLnvRL+VelD7nlrkYxwFCTk/bg0OdJw2UTAz
	t+VlEhBmrFRBokkw2yyQQ6/NREo49zDnPkm4RXllgjo/tPj8QTB4HRma
X-Gm-Gg: AYBFou36SV3auzAlnQcJkytLIzg9V8Y4tW2owjlWG1UotR1uwRHPYFoQjnT/8MjnXsd
	ytn7w+UQCpk8bMrrk9jXQhwDQu7OXkVryfD/R3p8hTKFh4YsjIjPE00ky1cxG4M0M/py+DiSniV
	GpG3W6Ak5hPR4rfPJ81RXEcpy+uPMtBs5Kv0U05VCo49gjoyHTPIjc/TqAcdtI8PyWUT2Dy7VVw
	Z0C5MPHBHNmqL7+ah9wsVvRx1TK5nDpMdGabkIK8+aAjvNkufBpSglMTibYER6wtcnLnAO70c6U
	4uasAA4mUknAxmIE81jfIz+M9V+EFwlKgaj7gtyZV6zrxk1lEWPkAMFU6NjlSeLjgnDnW51wzeH
	70V8YVVxWMTCnJIYvay0ZIuF9sKQhL7pCxYjzi5f/26FBycsCqj57KM3jMYFUG07H+gvWqFt5LB
	CFtjbORsYI36Fy9mzglETC6WqwFzrchKwOBeABJHvP2tpAfRyrZDxUnmu1/BlWhJryrwCTlsJaF
	7l5xuaLZMuFBTz4BDNPZfITZgRQaxnfJlNPNWiRN+MQAaLZv1eKYALjkg3pMvEhC8tkkowphfl7
	Tz9eMdUYBVQPnJcp3pNBn9xnwQ==
X-Received: by 2002:a05:7022:2203:b0:18d:c38c:bcc9 with SMTP id a92af1059eb24-1ac56e8a821mr4357307c88.3.1793361160023;
        Fri, 30 Oct 2026 04:52:40 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcd6f1sm6437304c88.20.2026.10.30.04.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:52:39 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 30 Oct 2026 07:51:52 -0400
Subject: [PATCH bpf-next v2 07/22] bpf: Let the patch list remove
 instructions
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
Message-Id: <20261030-bpf-verifier-patch-batch-v2-7-55cd43439f7c@gmail.com>
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

verifier_remove_insns() removes a range of instructions. It moves the
tail of the program and of the aux data, walks all branches, and fixes
up the subprogs, the line info, the function pointers and the
instruction arrays, at the same O(N * M) cost as patching.

The patch list can only replace instructions, so bpf_opt_remove_nops()
and bpf_opt_remove_dead_code() can't move over to it.

Add bpf_patch_list_del() to queue the removal of an instruction along
with patches. Map a removed instruction to the next one that stays, so
that jumps to it land there. Drop the line info of removed
instructions, except that the last one moves to the next instruction
that stays if that has none of its own. Remove the subprogs whose
instructions are all removed, with their func_info, and mark the
function pointers to them and the entries of instruction arrays
deleted. Tell offloaded programs about each removed range.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 include/linux/bpf_verifier.h |   9 +++
 kernel/bpf/bpf_insn_array.c  |  10 ++-
 kernel/bpf/core.c            |  27 +++++++-
 kernel/bpf/fixups.c          | 142 ++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 176 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 49a6e443de75d..ace314cc539dd 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1089,6 +1089,7 @@ struct bpf_patch_image {
 	u32 new_cnt;
 	s32 grow;
 	u32 bad;
+	bool del;
 };
 
 /* Map an offset in the old program, which may be past its end. */
@@ -1098,9 +1099,16 @@ static inline u32 bpf_patch_image_remap(const struct bpf_patch_image *img,
 	return off <= img->cnt ? map[off] : off + img->grow;
 }
 
+static inline bool bpf_patch_image_deleted(const struct bpf_patch_image *img, u32 off)
+{
+	return off < img->cnt && img->new_off[off] == img->new_off[off + 1];
+}
+
 struct bpf_insn *__bpf_patch_list_add(struct bpf_patch_list *pl,
 				      const struct bpf_prog *prog, u32 off,
 				      const struct bpf_insn *patch, u32 len);
+int __bpf_patch_list_del(struct bpf_patch_list *pl, const struct bpf_prog *prog,
+			 u32 off);
 void bpf_patch_list_release(struct bpf_patch_list *pl);
 int bpf_patch_list_build(const struct bpf_patch_list *pl, const struct bpf_prog *prog,
 			 struct bpf_patch_image *img);
@@ -2066,6 +2074,7 @@ struct bpf_insn *bpf_patch_list_add(struct bpf_verifier_env *env, u32 off,
 				    const struct bpf_insn *patch, u32 len);
 int bpf_patch_list_commit(struct bpf_verifier_env *env);
 void bpf_patch_list_free(struct bpf_verifier_env *env);
+int bpf_patch_list_del(struct bpf_verifier_env *env, u32 off);
 
 int bpf_flip_opcode(u32 opcode);
 u8 bpf_rev_opcode(u8 opcode);
diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
index dbfcf1eddb91e..5330e2d7f4062 100644
--- a/kernel/bpf/bpf_insn_array.c
+++ b/kernel/bpf/bpf_insn_array.c
@@ -254,8 +254,9 @@ void bpf_insn_array_adjust(struct bpf_map *map, u32 first, u32 len)
 }
 
 /*
- * Move each offset to new_off[offset], new_off[] covers [0, cnt]. Offsets
- * past the end of the old program only move by 'grow'.
+ * Move each offset to new_off[offset], new_off[] covers [0, cnt]. An insn is
+ * removed when it maps to the same offset as the next one. Offsets past the
+ * end of the old program only move by 'grow'.
  */
 void bpf_insn_array_remap(struct bpf_map *map, const u32 *new_off, u32 cnt, s32 grow)
 {
@@ -267,7 +268,10 @@ void bpf_insn_array_remap(struct bpf_map *map, const u32 *new_off, u32 cnt, s32
 		off = insn_array->values[i].xlated_off;
 		if (off == INSN_DELETED)
 			continue;
-		insn_array->values[i].xlated_off = off <= cnt ? new_off[off] : off + grow;
+		if (off < cnt && new_off[off] == new_off[off + 1])
+			insn_array->values[i].xlated_off = INSN_DELETED;
+		else
+			insn_array->values[i].xlated_off = off <= cnt ? new_off[off] : off + grow;
 	}
 }
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index d2c36db09c8c9..75d6399ce0965 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -658,6 +658,25 @@ struct bpf_insn *__bpf_patch_list_add(struct bpf_patch_list *pl,
 	return &pl->insns[p->start + len - 1];
 }
 
+/* Queue the removal of insn 'off'. Jumps to it land on the next insn that stays. */
+int __bpf_patch_list_del(struct bpf_patch_list *pl, const struct bpf_prog *prog,
+			 u32 off)
+{
+	struct bpf_insn_patch *p;
+	int err;
+
+	err = patch_list_reserve_patch(pl);
+	if (err)
+		return err;
+
+	p = &pl->patches[pl->cnt++];
+	p->off = off;
+	p->len = 0;
+	p->start = pl->insn_cnt;
+	p->orig = prog->insnsi[off];
+	return 0;
+}
+
 void bpf_patch_list_release(struct bpf_patch_list *pl)
 {
 	kvfree(pl->patches);
@@ -684,8 +703,10 @@ int bpf_patch_list_build(const struct bpf_patch_list *pl, const struct bpf_prog
 
 	for (i = 0, k = 0; i <= cnt; i++) {
 		img->new_off[i] = i + img->grow;
-		if (k < pl->cnt && pl->patches[k].off == i)
+		if (k < pl->cnt && pl->patches[k].off == i) {
+			img->del |= !pl->patches[k].len;
 			img->grow += pl->patches[k++].len - 1;
+		}
 	}
 	img->new_cnt = cnt + img->grow;
 
@@ -724,7 +745,7 @@ void bpf_patch_image_free(struct bpf_patch_image *img)
 
 /*
  * Put the new image in 'prog', which has room for it, and move the poke
- * descriptors and the line info along.
+ * descriptors and, unless insns were removed, the line info along.
  */
 void bpf_patch_image_install(struct bpf_prog *prog, const struct bpf_patch_image *img)
 {
@@ -738,6 +759,8 @@ void bpf_patch_image_install(struct bpf_prog *prog, const struct bpf_patch_image
 			bpf_patch_image_remap(img, img->new_off,
 					      prog->aux->poke_tab[i].insn_idx);
 
+	if (img->del)
+		return;
 	for (i = 0; i < prog->aux->nr_linfo; i++)
 		prog->aux->linfo[i].insn_off =
 			bpf_patch_image_remap(img, img->new_off,
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 940265cb80ebf..1a1a374a076b1 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -408,6 +408,22 @@ struct bpf_insn *bpf_patch_list_add(struct bpf_verifier_env *env, u32 off,
 	return __bpf_patch_list_add(pl, env->prog, off, patch, len);
 }
 
+/* Queue the removal of insn 'off' until bpf_patch_list_commit(). */
+int bpf_patch_list_del(struct bpf_verifier_env *env, u32 off)
+{
+	struct bpf_patch_list *pl = &env->patch_list;
+
+	if (bpf_rewrite_must_abort())
+		return -EINTR;
+
+	if (verifier_bug_if(off >= env->prog->len ||
+			    (pl->cnt && off <= pl->patches[pl->cnt - 1].off),
+			    env, "insn %u removed out of order", off))
+		return -EFAULT;
+
+	return __bpf_patch_list_del(pl, env->prog, off);
+}
+
 void bpf_patch_list_free(struct bpf_verifier_env *env)
 {
 	bpf_patch_list_release(&env->patch_list);
@@ -453,9 +469,79 @@ static void patch_list_adj_aux(struct bpf_prog *prog, struct bpf_insn_patch *p,
 }
 
 /*
- * Apply all queued patches in one go. Everything that names an insn of the
- * old image follows it to the new one, a patched insn is named by the first
- * insn of its patch, like with bpf_patch_insn_data().
+ * Drop the line info of removed insns. The last one before the next insn
+ * that stays moves to it, unless that insn has its own line info.
+ */
+static void patch_list_adj_linfo(struct bpf_verifier_env *env,
+				 const struct bpf_patch_image *img, u32 *linfo_map)
+{
+	struct bpf_prog_aux *aux = env->prog->aux;
+	struct bpf_line_info *linfo = aux->linfo;
+	u32 i, j, pos, next, nr = aux->nr_linfo;
+
+	for (i = 0, j = 0; i < nr; i++) {
+		pos = bpf_patch_image_remap(img, img->new_off, linfo[i].insn_off);
+		linfo_map[i] = j;
+		if (bpf_patch_image_deleted(img, linfo[i].insn_off)) {
+			next = i + 1 < nr ?
+			       bpf_patch_image_remap(img, img->new_off, linfo[i + 1].insn_off) :
+			       U32_MAX;
+			if (pos >= img->new_cnt || next == pos)
+				continue;
+		}
+		linfo[j] = linfo[i];
+		linfo[j++].insn_off = pos;
+	}
+	linfo_map[nr] = j;
+	aux->nr_linfo = j;
+
+	/* NOTE: fake 'exit' subprog should be updated as well. */
+	for (i = 0; i <= env->subprog_cnt; i++)
+		env->subprog_info[i].linfo_idx =
+			linfo_map[min(env->subprog_info[i].linfo_idx, nr)];
+}
+
+/* Remove the subprogs whose insns are all removed, with their func_info. */
+static void patch_list_del_subprogs(struct bpf_verifier_env *env,
+				    const u32 *new_off)
+{
+	struct bpf_subprog_info *info = env->subprog_info;
+	struct bpf_prog_aux *aux = env->prog->aux;
+	int i, j, exc_cb = env->exception_callback_subprog;
+
+	for (i = 0, j = 0; i < env->subprog_cnt; i++) {
+		if (new_off[info[i].start] == new_off[info[i + 1].start]) {
+			/* The exception callback is live, so it isn't removed. */
+			if (env->exception_callback_subprog > i)
+				exc_cb--;
+			continue;
+		}
+		if (i != j) {
+			info[j] = info[i];
+			if (aux->func_info)
+				aux->func_info[j] = aux->func_info[i];
+			if (aux->func_info_aux)
+				aux->func_info_aux[j] = aux->func_info_aux[i];
+		}
+		j++;
+	}
+	if (i == j)
+		return;
+
+	/* move fake 'exit' subprog as well */
+	info[j] = info[i];
+	/* func_info->insn_off is set after all code rewrites, in adjust_btf_func() */
+	if (aux->func_info)
+		aux->func_info_cnt -= i - j;
+	env->subprog_cnt = j;
+	env->exception_callback_subprog = exc_cb;
+}
+
+/*
+ * Apply all queued patches and removals in one go. Everything that names an
+ * insn of the old image follows it to the new one. A patched insn is named by
+ * the first insn of its patch, a removed insn by the next insn that stays,
+ * like with bpf_patch_insn_data().
  */
 int bpf_patch_list_commit(struct bpf_verifier_env *env)
 {
@@ -463,7 +549,8 @@ int bpf_patch_list_commit(struct bpf_verifier_env *env)
 	struct bpf_insn_aux_data *data = NULL;
 	struct bpf_prog *prog = env->prog;
 	struct bpf_patch_image img = {};
-	u32 i, k, end;
+	u32 *linfo_map = NULL;
+	u32 i, k, n, end;
 	struct bpf_insn_patch *p;
 	int err = 0;
 
@@ -488,20 +575,43 @@ int bpf_patch_list_commit(struct bpf_verifier_env *env)
 			 GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 	if (!data)
 		goto out;
+	if (img.del && prog->aux->nr_linfo) {
+		linfo_map = kvmalloc_array(prog->aux->nr_linfo + 1,
+					   sizeof(*linfo_map), GFP_KERNEL_ACCOUNT);
+		if (!linfo_map)
+			goto out;
+	}
 
 	prog = bpf_prog_realloc(prog, bpf_prog_size(img.new_cnt), GFP_USER);
 	if (!prog)
 		goto out;
 	env->prog = prog;
 
+	if (img.del && bpf_prog_is_offloaded(prog->aux)) {
+		/* the aux data still describes the old image */
+		for (k = 0; k < pl->cnt; k = n) {
+			for (n = k; n < pl->cnt && !pl->patches[n].len &&
+			     pl->patches[n].off == pl->patches[k].off + n - k; n++)
+				;
+			if (n == k)
+				n++;
+			else
+				bpf_prog_offload_remove_insns(env, pl->patches[k].off,
+							      n - k);
+		}
+	}
+
 	bpf_patch_image_install(prog, &img);
 
 	for (i = 0, k = 0; i < img.cnt; i = end) {
 		if (k < pl->cnt && pl->patches[k].off == i) {
 			p = &pl->patches[k++];
-			patch_list_adj_aux(prog, p, &pl->insns[p->start],
-					   &env->insn_aux_data[i],
-					   &data[img.new_off[i]]);
+			if (p->len)
+				patch_list_adj_aux(prog, p, &pl->insns[p->start],
+						   &env->insn_aux_data[i],
+						   &data[img.new_off[i]]);
+			else
+				bpf_clear_insn_aux_data(env, i, 1);
 			end = i + 1;
 			continue;
 		}
@@ -514,25 +624,43 @@ int bpf_patch_list_commit(struct bpf_verifier_env *env)
 	env->insn_aux_data_len = img.new_cnt;
 	data = NULL;
 
+	/* before subprogs are removed, since it looks at them */
 	for (i = 0; i < env->func_ptr_cnt; i++) {
 		struct bpf_func_ptr *fp = &env->func_ptrs[i];
+		int subprog;
 
 		if (fp->xlated_off == BPF_FUNC_PTR_DELETED)
 			continue;
+		if (bpf_patch_image_deleted(&img, fp->xlated_off)) {
+			subprog = bpf_find_subprog(env, fp->xlated_off);
+			if (subprog <= 0 ||
+			    img.new_off[env->subprog_info[subprog].start] ==
+			    img.new_off[env->subprog_info[subprog + 1].start]) {
+				fp->xlated_off = BPF_FUNC_PTR_DELETED;
+				continue;
+			}
+		}
 		fp->xlated_off = bpf_patch_image_remap(&img, img.new_off, fp->xlated_off);
 	}
 
+	if (img.del)
+		patch_list_del_subprogs(env, img.new_off);
+
 	/* NOTE: fake 'exit' subprog should be updated as well. */
 	for (i = 0; i <= env->subprog_cnt; i++)
 		env->subprog_info[i].start =
 			bpf_patch_image_remap(&img, img.new_off, env->subprog_info[i].start);
 
+	if (linfo_map)
+		patch_list_adj_linfo(env, &img, linfo_map);
+
 	for (i = 0; i < env->insn_array_map_cnt; i++)
 		bpf_insn_array_remap(env->insn_array_maps[i], img.new_off,
 				     img.cnt, img.grow);
 
 	err = 0;
 out:
+	kvfree(linfo_map);
 	vfree(data);
 	bpf_patch_image_free(&img);
 	bpf_patch_list_release(pl);

-- 
2.43.0

