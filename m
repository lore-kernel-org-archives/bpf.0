Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361192;
	b=Mei1CIrV1dZEt+McUQX4L9R6lRoLWWYnFgtGOyh0lDo1a67BeHyYNvUdv2Vj8dLCDAQZ
	 GvJLK/MlLR4MEgVsXZUyo7W7TtIsIRhM2wR/AwJUb8Os78fQMhQrvZon+M/ZzePCnSu46
	 6Wvp3Zu7JP96ce/trdIcNC9R1t7OD7fXnC5vhrXr2l3T1aOtjLJ3CD3in5RCEWD21Xz0r
	 vbDXF6YPpRQ+nBW09MGkYLiKFZTjrCer1EADvBhgKqrUAIwO/0ZaJuLLp/GlAFUGCMDSV
	 d/IkwPZFS/o8e5rIzrkRfI02xlCMgJYJGpXV2VfTDNgzK5pKqvEpJEVugjJR4EoGmdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361192;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=g6z9OZ5gYoVLIMl6ioIDO2iCZCYJG2Psr+4cjGoooGE=;
	b=vXBmWa4Q5+UAg+YAQe9Nr1Yd21SDbJDg9+4BaRALh1jz3TpNuh8JJ6dwHH5eimCq+sZA
	 O1yiivqeVZ/aHugUORj2w7876PtfyGwSK7HbnyigGUOTEb7vlQYkowIQvf3RCjG3dOqsz
	 z46HqSheDxFwDGtK7x90cGixCicXpq09CmEJma02+g+HPh7SxgCU2t1Fdt47SbY4lYkMu
	 bnQaVW0BL3jILJMv9HqQdhY17pZq9FVzrO6/qsiEsFBGX7YGjQELKekUGO4wx0uNR0dQL
	 2op4f7QzwCt32MV/s9yJ7j7dvwz54uIwIll4Ccz1S+it6DRK7MY/v4Me62kuUA98k7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fLXMbpem;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A848606A334
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 11:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A848606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fLXMbpem
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-14394530ec6so782192c88.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 04:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793361190; x=1793965990; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g6z9OZ5gYoVLIMl6ioIDO2iCZCYJG2Psr+4cjGoooGE=;
        b=fLXMbpemFq5cqB9BZAlfppiBX8meY0vktU9FdBdzZLM3FvTpThi7TKRUa1B5B0EHMl
         In80QZ8yyrkpwbQV4c8HIIB/fYTjonfx/teMZfqRo68eALj5X6LNt+Rtl95h0ouxop1z
         oVZtY8eYjnetuhLIvDSt6eMAzC1FT6hceqiVqOvH9lntxT4W03MNZxlPgNeBVIViAnFS
         xE4Y9GZnxDUb8tN2InRyZ0s7ap1wwwJkDeATwlp+DYavw+8hKiJma8lJfHZbjNa5Ztcg
         uo7nBPp0fLID+wiXpwrjju2+iyGG+hjPdcuQJpNxu7ZFicrb+xBR/BGCHsdtso54aGYk
         tQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361190; x=1793965990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g6z9OZ5gYoVLIMl6ioIDO2iCZCYJG2Psr+4cjGoooGE=;
        b=oPzmy0ycXzc42ufTvB+yhCVGWzaMoEVeT9GwUu3dCHT+16wGtQ1OEKkgVzgdO0bZRO
         v42rNhH0OIM6/CBEFcQibUSfSxpnTlLTYn/7j7tKZ2HNXnKulzVCvwdPzUdg1StKhWqz
         cLcwsQxbZCRKHh+8cqerP+kTi0IC0W/xQDHbRLZcJTPo+5WBWuHI+hCewD/cVrlfT16s
         6eTE1DDpVXPL6wyonoyFhZXFnQHEa5+Q19g/HR/VBGr+gNQQp25AhkdeM6yhFGQJy/l/
         4P9YsMyso8kciX4wJfWZF5/0dtRmsYsKPX2SY29hmNbmALzNB6pK65UnB32mFcsQ8Tbb
         lAqA==
X-Gm-Message-State: AFq9FYJtylzFpgUCWzJWoYMEPXmij/dqFdy6sz8frywKgunwGuWBGIhv
	OTO4JO+DxwnFJQroLdJgNXLzd7b1DrzzVU2DY6betqkKWeZfr3WQB4Vb
X-Gm-Gg: AYBFou20lHfXnh/7krLkPwdmECWjIu4DvsPvW7u7QAzkWGjuMWqOuB8d4aPK5PxK+6Q
	13A+EZaHKm31/t5SYxYS5l39emE9x1x4qiSHOa1lWrkKWCVT5oGWLAy+EMZ+mLOAwxv2lr3rts6
	gmG/ordGdPfx1mkDj8yPXyfdJUWlv+xmqk/ioPHQH+7QIlIKjUgGs4KBYEc7bxhEmnLyGVM1OBm
	Jww+4EOi7n5iku6YtKe21Z+MWExNUL9puujCgNuVZuyh+tU96y8p7rS19jvWl7e6fwfDTAhetUD
	8dXUCy/DpwIjglbSFEbqix/TwUVeyDRqqMSp1RhkDS66IBKiiXBiSG8yr6q4bjrQyoNdTT94q6W
	P49qtDJ2b0lWxgTdD1nwOE6Po/l5lhTDIEjFfZ+hBpvxsXeHRmSBUmDfzvC7/Y7/Th4xibCQgQI
	mdrz9XNno2TMCZzSvEyVqKN9BTwmoQPZMJVUcUHHQmfqqQRIA4m2xVE9RtJ1N5qvkZn52PPK5t7
	9DovhffriPKoWICZ3L9Cpuv7LQEUAUa0aPJp+0wYKQJUo8FymM53aMp5JHHToci47ItxdZH5qbO
	FNDkYyem1cZmSk3cDi0O289g
X-Received: by 2002:a05:7022:7f0f:b0:1a7:d426:6dd2 with SMTP id a92af1059eb24-1ac5e31fb9dmr2707595c88.26.1793361190226;
        Fri, 30 Oct 2026 04:53:10 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcd6f1sm6437304c88.20.2026.10.30.04.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:53:09 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 30 Oct 2026 07:51:57 -0400
Subject: [PATCH bpf-next v2 12/22] bpf: Teach the patch list to insert in
 front of an instruction
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
Message-Id: <20261030-bpf-verifier-patch-batch-v2-12-55cd43439f7c@gmail.com>
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

bpf_convert_ctx_accesses() puts the prologue in front of the first
instruction, and bpf_do_misc_fixups() the setup of the may_goto counter
in front of each subprog that needs one. They patch the instruction
with the new ones followed by itself in BPF_PATCH_MOVE_TARGET mode,
then move the jumps to it with adjust_jmp_off().

The patch list names a patched instruction by the first instruction of
its patch, which would send the jumps to it to the inserted ones.

Add bpf_patch_list_insert() for that. Record in a queued patch which of
its instructions the jumps to the patched one land on, the instruction
itself after an insertion. Map jumps, instruction arrays and poke
descriptors there on commit, while subprogs, line info, function
pointers and calls keep starting at the first inserted instruction.
Keep the jumps of the instruction pointing where they did when it moves
behind the inserted ones, as bpf_adj_moved_insn() does.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 include/linux/bpf.h          |  3 +-
 include/linux/bpf_verifier.h |  6 ++++
 kernel/bpf/bpf_insn_array.c  | 11 ++++----
 kernel/bpf/core.c            | 66 ++++++++++++++++++++++++++++++++++++++------
 kernel/bpf/fixups.c          | 39 +++++++++++++++++++++-----
 5 files changed, 104 insertions(+), 21 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9bb5e0c823627..bc8db33ceac32 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -4378,7 +4378,8 @@ int bpf_insn_array_ready(struct bpf_map *map);
 void bpf_insn_array_release(struct bpf_map *map);
 void bpf_insn_array_adjust(struct bpf_map *map, u32 first, u32 len);
 void bpf_insn_array_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);
-void bpf_insn_array_remap(struct bpf_map *map, const u32 *new_off, u32 cnt, s32 grow);
+void bpf_insn_array_remap(struct bpf_map *map, const u32 *new_off, const u32 *new_tgt,
+			  u32 cnt, s32 grow);
 
 #ifdef CONFIG_BPF_SYSCALL
 void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image);
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index ace314cc539dd..9562665757a79 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1065,6 +1065,7 @@ struct bpf_insn_patch {
 	u32 off;
 	u32 len;
 	u32 start;		/* first insn of the patch in bpf_patch_list.insns */
+	u32 target;		/* insn of the patch that jumps to 'off' land on */
 	struct bpf_insn orig;	/* the replaced insn when the patch was queued */
 };
 
@@ -1085,6 +1086,7 @@ struct bpf_patch_list {
 struct bpf_patch_image {
 	struct bpf_insn *insns;
 	u32 *new_off;
+	u32 *new_tgt;
 	u32 cnt;
 	u32 new_cnt;
 	s32 grow;
@@ -1109,6 +1111,8 @@ struct bpf_insn *__bpf_patch_list_add(struct bpf_patch_list *pl,
 				      const struct bpf_insn *patch, u32 len);
 int __bpf_patch_list_del(struct bpf_patch_list *pl, const struct bpf_prog *prog,
 			 u32 off);
+int __bpf_patch_list_insert(struct bpf_patch_list *pl, const struct bpf_prog *prog,
+			    u32 off, const struct bpf_insn *insns, u32 cnt);
 void bpf_patch_list_release(struct bpf_patch_list *pl);
 int bpf_patch_list_build(const struct bpf_patch_list *pl, const struct bpf_prog *prog,
 			 struct bpf_patch_image *img);
@@ -2075,6 +2079,8 @@ struct bpf_insn *bpf_patch_list_add(struct bpf_verifier_env *env, u32 off,
 int bpf_patch_list_commit(struct bpf_verifier_env *env);
 void bpf_patch_list_free(struct bpf_verifier_env *env);
 int bpf_patch_list_del(struct bpf_verifier_env *env, u32 off);
+int bpf_patch_list_insert(struct bpf_verifier_env *env, u32 off,
+			  const struct bpf_insn *insns, u32 cnt);
 
 int bpf_flip_opcode(u32 opcode);
 u8 bpf_rev_opcode(u8 opcode);
diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
index 5330e2d7f4062..cf67315be0359 100644
--- a/kernel/bpf/bpf_insn_array.c
+++ b/kernel/bpf/bpf_insn_array.c
@@ -254,11 +254,12 @@ void bpf_insn_array_adjust(struct bpf_map *map, u32 first, u32 len)
 }
 
 /*
- * Move each offset to new_off[offset], new_off[] covers [0, cnt]. An insn is
- * removed when it maps to the same offset as the next one. Offsets past the
- * end of the old program only move by 'grow'.
+ * Move each offset to new_tgt[offset], new_off[] and new_tgt[] cover [0, cnt].
+ * An insn is removed when new_off[] maps it to the same offset as the next
+ * one. Offsets past the end of the old program only move by 'grow'.
  */
-void bpf_insn_array_remap(struct bpf_map *map, const u32 *new_off, u32 cnt, s32 grow)
+void bpf_insn_array_remap(struct bpf_map *map, const u32 *new_off, const u32 *new_tgt,
+			  u32 cnt, s32 grow)
 {
 	struct bpf_insn_array *insn_array = cast_insn_array(map);
 	u32 off;
@@ -271,7 +272,7 @@ void bpf_insn_array_remap(struct bpf_map *map, const u32 *new_off, u32 cnt, s32
 		if (off < cnt && new_off[off] == new_off[off + 1])
 			insn_array->values[i].xlated_off = INSN_DELETED;
 		else
-			insn_array->values[i].xlated_off = off <= cnt ? new_off[off] : off + grow;
+			insn_array->values[i].xlated_off = off <= cnt ? new_tgt[off] : off + grow;
 	}
 }
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 10efd1dd36689..6e356e16613b3 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -642,16 +642,19 @@ static int patch_list_move_down(struct bpf_insn *insns, u32 len, u32 by)
 /*
  * insn is number 'idx' of the 'len' insns that replace insn 'off' of the old
  * image (an insn that isn't patched is its own patch of length 1). It lands
- * at 'pos' of the new image. 'new_off' maps the old image to the new one.
+ * at 'pos' of the new image. 'new_off' maps the old image to the start of
+ * each patch, which calls go to, 'new_tgt' to where jumps go.
  */
 static int patch_list_adj_insn(struct bpf_insn *insn, const u32 *new_off,
-			       u32 cnt, u32 off, u32 idx, u32 len, u32 pos)
+			       const u32 *new_tgt, u32 cnt, u32 off, u32 idx,
+			       u32 len, u32 pos)
 {
-	bool is_imm;
+	bool is_imm, call;
 	s64 rel, tgt;
 
 	if (!insn_get_rel(insn, &rel, &is_imm))
 		return 0;
+	call = bpf_pseudo_func(insn) || bpf_pseudo_call(insn);
 
 	/* relative to the first insn of the patch */
 	tgt = (s64)idx + rel + 1;
@@ -663,7 +666,7 @@ static int patch_list_adj_insn(struct bpf_insn *insn, const u32 *new_off,
 	if (tgt < 0 || tgt > cnt)
 		return -EFAULT;
 
-	rel = (s64)new_off[tgt] - pos - 1;
+	rel = (s64)(call ? new_off : new_tgt)[tgt] - pos - 1;
 	return insn_set_rel(insn, rel, is_imm);
 }
 
@@ -710,6 +713,7 @@ struct bpf_insn *__bpf_patch_list_add(struct bpf_patch_list *pl,
 	p = &pl->patches[pl->cnt++];
 	p->off = off;
 	p->len = len;
+	p->target = 0;
 	p->start = pl->insn_cnt;
 	p->orig = prog->insnsi[off];
 	memcpy(pl->insns + p->start, patch, len * sizeof(*patch));
@@ -732,8 +736,49 @@ int __bpf_patch_list_del(struct bpf_patch_list *pl, const struct bpf_prog *prog,
 	p = &pl->patches[pl->cnt++];
 	p->off = off;
 	p->len = 0;
+	p->target = 0;
+	p->start = pl->insn_cnt;
+	p->orig = prog->insnsi[off];
+	return 0;
+}
+
+/*
+ * Queue 'insns[0..cnt)' to go in front of insn 'off'. Jumps to 'off',
+ * instruction arrays and poke descriptors still name the insn at 'off', while
+ * subprogs, line info, function pointers and calls that start at 'off' start
+ * at the first inserted insn.
+ */
+int __bpf_patch_list_insert(struct bpf_patch_list *pl, const struct bpf_prog *prog,
+			    u32 off, const struct bpf_insn *insns, u32 cnt)
+{
+	struct bpf_insn_patch *p;
+	int err;
+
+	err = patch_list_reserve_patch(pl) ?: patch_list_reserve_insns(pl, 1);
+	if (err)
+		return err;
+	p = &pl->patches[pl->cnt++];
+	p->off = off;
+	p->len = 1;
+	p->target = 0;
 	p->start = pl->insn_cnt;
 	p->orig = prog->insnsi[off];
+	pl->insns[pl->insn_cnt++] = p->orig;
+
+	err = patch_list_reserve_insns(pl, cnt);
+	if (err)
+		return err;
+
+	/* the last patch is at the end of pl->insns */
+	err = patch_list_move_down(pl->insns + p->start, p->len, cnt);
+	if (err)
+		return err;
+	memmove(pl->insns + p->start + cnt, pl->insns + p->start,
+		p->len * sizeof(*insns));
+	memcpy(pl->insns + p->start, insns, cnt * sizeof(*insns));
+	p->len += cnt;
+	p->target += cnt;
+	pl->insn_cnt += cnt;
 	return 0;
 }
 
@@ -747,7 +792,8 @@ void bpf_patch_list_release(struct bpf_patch_list *pl)
 /*
  * Build the image of 'prog' with the queued patches applied in img->insns,
  * without touching 'prog'. img->new_off[] maps each old insn to the start of
- * its patch. On -ERANGE, img->bad is the old insn whose jump got out of range.
+ * its patch, img->new_tgt[] to where jumps to it land. On -ERANGE, img->bad is
+ * the old insn whose jump got out of range.
  */
 int bpf_patch_list_build(const struct bpf_patch_list *pl, const struct bpf_prog *prog,
 			 struct bpf_patch_image *img)
@@ -758,12 +804,15 @@ int bpf_patch_list_build(const struct bpf_patch_list *pl, const struct bpf_prog
 	memset(img, 0, sizeof(*img));
 	img->cnt = cnt;
 	img->new_off = kvmalloc_array(cnt + 1, sizeof(u32), GFP_KERNEL_ACCOUNT);
-	if (!img->new_off)
+	img->new_tgt = kvmalloc_array(cnt + 1, sizeof(u32), GFP_KERNEL_ACCOUNT);
+	if (!img->new_off || !img->new_tgt)
 		return -ENOMEM;
 
 	for (i = 0, k = 0; i <= cnt; i++) {
 		img->new_off[i] = i + img->grow;
+		img->new_tgt[i] = img->new_off[i];
 		if (k < pl->cnt && pl->patches[k].off == i) {
+			img->new_tgt[i] += pl->patches[k].target;
 			img->del |= !pl->patches[k].len;
 			img->grow += pl->patches[k++].len - 1;
 		}
@@ -786,7 +835,7 @@ int bpf_patch_list_build(const struct bpf_patch_list *pl, const struct bpf_prog
 		for (n = 0; n < len; n++) {
 			img->insns[pos + n] = src[n];
 			err = patch_list_adj_insn(&img->insns[pos + n], img->new_off,
-						  cnt, i, n, len, pos + n);
+						  img->new_tgt, cnt, i, n, len, pos + n);
 			if (err) {
 				img->bad = i;
 				return err;
@@ -799,6 +848,7 @@ int bpf_patch_list_build(const struct bpf_patch_list *pl, const struct bpf_prog
 void bpf_patch_image_free(struct bpf_patch_image *img)
 {
 	kvfree(img->insns);
+	kvfree(img->new_tgt);
 	kvfree(img->new_off);
 	memset(img, 0, sizeof(*img));
 }
@@ -816,7 +866,7 @@ void bpf_patch_image_install(struct bpf_prog *prog, const struct bpf_patch_image
 
 	for (i = 0; i < prog->aux->size_poke_tab; i++)
 		prog->aux->poke_tab[i].insn_idx =
-			bpf_patch_image_remap(img, img->new_off,
+			bpf_patch_image_remap(img, img->new_tgt,
 					      prog->aux->poke_tab[i].insn_idx);
 
 	if (img->del)
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index a56b743be0062..bb4fd75a70624 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -417,6 +417,29 @@ int bpf_patch_list_del(struct bpf_verifier_env *env, u32 off)
 	return __bpf_patch_list_del(pl, env->prog, off);
 }
 
+/* Queue insns to go in front of insn 'off', see __bpf_patch_list_insert(). */
+int bpf_patch_list_insert(struct bpf_verifier_env *env, u32 off,
+			  const struct bpf_insn *insns, u32 cnt)
+{
+	struct bpf_patch_list *pl = &env->patch_list;
+	struct bpf_insn_patch *p = pl->cnt ? &pl->patches[pl->cnt - 1] : NULL;
+	int err;
+
+	if (bpf_rewrite_must_abort())
+		return -EINTR;
+
+	if (verifier_bug_if(!cnt || off >= env->prog->len ||
+			    (p && off <= p->off),
+			    env, "insns inserted at %u out of order", off))
+		return -EFAULT;
+
+	err = __bpf_patch_list_insert(pl, env->prog, off, insns, cnt);
+	if (err == -ERANGE)
+		verbose(env, "insn %d cannot be patched due to 16-bit range\n",
+			env->insn_aux_data[off].orig_idx);
+	return err;
+}
+
 void bpf_patch_list_free(struct bpf_verifier_env *env)
 {
 	bpf_patch_list_release(&env->patch_list);
@@ -425,6 +448,7 @@ void bpf_patch_list_free(struct bpf_verifier_env *env)
 /*
  * Fill the aux data of the 'p->len' insns at 'slot' from the aux data 'old'
  * of the insn they replace, the same way as adjust_insn_aux_data() does.
+ * The insns in front of p->target were inserted, as with BPF_PATCH_MOVE_TARGET.
  */
 static void patch_list_adj_aux(struct bpf_prog *prog, struct bpf_insn_patch *p,
 			       struct bpf_insn *patch,
@@ -442,7 +466,7 @@ static void patch_list_adj_aux(struct bpf_prog *prog, struct bpf_insn_patch *p,
 	for (i = 0; i < p->len - 1; i++) {
 		slot[i].seen = last->seen;
 		slot[i].zext_dst = bpf_insn_def32(prog, &patch[i]) >= 0;
-		if (!memcmp(&patch[i], orig, sizeof(*orig))) {
+		if (i >= p->target && !memcmp(&patch[i], orig, sizeof(*orig))) {
 			slot[i].non_stack_access = last->non_stack_access;
 			last->non_stack_access = false;
 		} else if (bpf_is_mem_insn(&patch[i])) {
@@ -454,9 +478,9 @@ static void patch_list_adj_aux(struct bpf_prog *prog, struct bpf_insn_patch *p,
 	    memcmp(&patch[p->len - 1], orig, sizeof(*orig)))
 		last->non_stack_access = true;
 
-	/* indirect jumps to the replaced insn land on the first new one */
-	if (last->indirect_target) {
-		slot[0].indirect_target = 1;
+	/* indirect jumps to the replaced insn land on p->target */
+	if (last->indirect_target && p->target != p->len - 1) {
+		slot[p->target].indirect_target = 1;
 		last->indirect_target = 0;
 	}
 }
@@ -533,8 +557,9 @@ static void patch_list_del_subprogs(struct bpf_verifier_env *env,
 /*
  * Apply all queued patches and removals in one go. Everything that names an
  * insn of the old image follows it to the new one. A patched insn is named by
- * the first insn of its patch, a removed insn by the next insn that stays,
- * like with bpf_patch_insn_data().
+ * the first insn of its patch, or the insn itself if insns were inserted in
+ * front of it, a removed insn by the next insn that stays, like with
+ * bpf_patch_insn_data().
  */
 int bpf_patch_list_commit(struct bpf_verifier_env *env)
 {
@@ -649,7 +674,7 @@ int bpf_patch_list_commit(struct bpf_verifier_env *env)
 
 	for (i = 0; i < env->insn_array_map_cnt; i++)
 		bpf_insn_array_remap(env->insn_array_maps[i], img.new_off,
-				     img.cnt, img.grow);
+				     img.new_tgt, img.cnt, img.grow);
 
 	err = 0;
 out:

-- 
2.43.0

