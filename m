Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793583026;
	b=TpEFxkNHsKuXJ2EkWkePRESxDIjc/4ieCCz8MI6w/NTlGNCG6swbfIefl4YC6IvaZ8lj
	 u8YAcIgfaD8qY7pE21E/USpmMuznTkkeWoY6fjigly9eSioZabuujMIcTg+kdYFBftrkI
	 RPuyoscvBLijNrOZ0vuaEsU4jgRxyfFGJCQE9l9y1kZ19mep7pmG5ersTgGZhrVafPu1P
	 t6cTf5K7wUr3Pk13IO/3VvnTYiqnvMtQX1AyUu9Yr6nbPBSeInlisTHNjB1fmIqtzmOA0
	 RL3YwHcX7V2KuDHX6+uksBY0qjFXbCUiAo9Oqaac1Lwt0tsLmMBj3usCeLR0D6WOOMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793583026;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3iLY6anmYFrBPLCj/eAvCwyoX5QOa0FuDZT2hKQyuVc=;
	b=CRdXNBg9ZqZKi4y0xfW/xj4NuAKgcsYka1PmpzfhoGximhb8PdBn1LyDwIGInxp07Bzp
	 eR94Y8zxvyrlIU6aZPMSG9jgk9/rE0/VXQXNFPcKzHEeX6Gd90sqddhKubL8jglb1cTdV
	 sIb5Tf/axe1YyH2Hwit/O6LpKtIQbncRb/VYm55ytq3Y4P2eYdZKgu4CYKNuA+ILDf7J4
	 y4rfxm7sz0Afl13ayHaU+wNaTMH65RhEWx3n2iyYjkMteGQqjLvFBba4wBe86qmgrYO4y
	 1IxemWvy+h14H0TOygjmeCZH+ya5JAnu5UEE3mVIX90kKhXEU4skiiAnIrzcW+cie0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nt+5aehJ;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B573606A32D
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 01:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B573606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nt+5aehJ
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so1748335a91.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 17:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793583026; x=1794187826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3iLY6anmYFrBPLCj/eAvCwyoX5QOa0FuDZT2hKQyuVc=;
        b=Nt+5aehJqxJ3u7X49/1X0R17If3Cl/za3lYAujss0Yo4iwJK/De2UP+FIPhECOwGgJ
         TjjabfFDOFFw9sEE00sZ/sCFmEFVk7IxgE4iQ3sT6/cNO3IpKpclCXHBRLbw9yr7JcyW
         TTPKqXyTBjgfnLcMVHV4EjvbBGlmFi6xSgI2CvomPLzx63wqaVdmfdOHQB5G2k/ZS8OW
         7/FxaRGZ4nHfaFXLyJZ8mM1Wvx4bnpK/WTXbp8/s+WHawTVOgxSo7Qt15a3R+n/s+x5V
         MNCz2/J1OShrdchPUBoJK/05I62Jh/TmArrqZ6v+6FlTo64+9XhroL7Jq5zaPsTExl5O
         OBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793583026; x=1794187826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3iLY6anmYFrBPLCj/eAvCwyoX5QOa0FuDZT2hKQyuVc=;
        b=Faxa4IsrxCJoUSJ08QiU4ybQiu8/+J9m8GUNIfOMmjxYqPx2mkMlsbKFvewirCxrsg
         H3TzzekX/fobBbxBGJcCmYy5r89yeoa6l3/xIkyastiElNCwgWkA0+07QA9vEY3AdStG
         GHNjRwU6GAPPgrYDaSyxw8QCmq6dozJk5hbLTBYLsGZ9H0UgnRZV+Gwb3uL18SqWdo8S
         3zYLytY21tLMxpy58z6+qYRr/OkPt/X6t7VJ8A6GTLSo4Tg3GKyCYUtet/Exe58/HHui
         /83gmKezJHsH4EB4R/XOdybwjtwVKJnSyia3NV9yn94if1+AP0R/jfw/UcoLTDOeGWma
         UtAA==
X-Gm-Message-State: APuU4Z+uoFdgEbl5eCd8xHgWdHXK27cfrDKTMghhEv+CxibQoWWP1wlC
	W3G59cMH5aDueFjZeuI0pPc+cBEXnOFosCb7OzAwuzzXEoJtjclJmrR8b5NNbw==
X-Gm-Gg: AYBFou2UVvSXVSdIA83uirpqKGy4kcnASWTfeyYIvEpQJN6od5OIrwM/ehoc3Tp06SU
	psNTtShdxEWl//wrD1A6MKHp39AC1MeOowWV7D1mtWwC8/s2mWOQzcP1ZwisOgDZdk5mgr6RyqV
	QZwXrOFoqxc7Tl9wz2qFAiWjPcS/s0//zfV0t1qrYMDc0m9AyIkrM+DT19+75+sW9V7hEfaTBxL
	fM5Z/igN0Ht3XcPNZz2O5u6yxlvzg3lbIzavcbswX8uOQttpnsRB8cxQGrZREyI5c0IaXpTxUuH
	/MtYKJHaPbYFu0/kZyqmc/tTc2NBqBjplJgiCBwKHfgeN6YKGwKuP7jBaa4CF/ejPbP64PnvUcc
	cCZtm0NHvYRt92GwWV+jRUZgy15B+R6i32srhnvt6fdOQPowTt/e5NZ6x26saqJX79S1t0eWH2q
	EDuawEaRhvcFRXfBOv6v0Q61GX6LOxHziFMBdoXS+B8LRCqMYZQ2XRy02kTRPBHYzWFsuViOSRr
	J/hfWOMSkxFFhrPG9vd6PQ+tQnbKNvxUOP29dIe3qfAPb+f5AAEtO4U/MYZFFIpGd1b7rfKCrlv
	AmuU6ww50pnXxsw4es0p9AQUQtz71kZRIkLMmzKMX5m/Am3uteedJjFCAfjDpLrvmk7Utn8UZHR
	orfm+f/Cgdr/bWx0ifiR0raf9tc8yHWmVPDnderLmnHxbgZIsBfQkpNduLY4UsnsXwteA3yp5Bm
	o=
X-Received: by 2002:a17:90b:3886:b0:3ab:1b19:78f4 with SMTP id 98e67ed59e1d1-3ae89574e34mr7290845a91.6.1793583025482;
        Sun, 01 Nov 2026 17:30:25 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845429e6sm11596497a91.6.2026.11.01.17.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 17:30:24 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	odys.yuan@gmail.com
Subject: [PATCH bpf-next v3 07/13] bpf: Teach the patch list to insert in front of an instruction
Date: Mon,  2 Nov 2026 01:29:34 +0000
Message-ID: <20261102012940.1756142-8-alexei.starovoitov@gmail.com>
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

Two passes put new insns in front of an insn that stays.
bpf_convert_ctx_accesses() puts the prologue in front of the first insn of
the prog. bpf_do_misc_fixups() puts the setup of the may_goto count in
front of a subprog. A call of the subprog must run the setup. A jump back
to its first insn must not, because the count would start again.

A patch with the new insns and a copy of the insn is not sufficient. The
commit of the patch list has one map from old index to new index,
new_off[]. A patched insn maps to the first insn of its patch. That is
correct for the call and incorrect for the jump. __bpf_patch_insn_data()
has the mode BPF_PATCH_MOVE_TARGET for the tables, and adjust_jmp_off()
walks all insns again for the jumps.

Add bpf_patch_list_insert(). It queues the inserted insns and a copy of the
insn as one patch. The new field 'target' of the patch counts the inserted
insns. The commit calculates a second map, new_tgt[], which adds 'target'
to new_off[]. Thus new_off[i] is the first inserted insn, and new_tgt[i] is
insn i. The two maps differ only there.

  old image     patch list      new_off[]  new_tgt[]  new image
  0: call +1                     0          0          0: call +1
  1: exit                        1          1          1: exit
  2: r1 += -1   insert 1 insn    2          3          2: i1
                                                       3: r1 += -1
  3: goto -2                     4          4          4: goto -2

The call lands on the inserted insn i1, and the jump lands on 'r1 += -1'.
All that names insn i goes through one of the two maps:

  what names insn i       new index   reason
  ----------------------  ----------  -------------------------------------
  call, function pointer  new_off[i]  It enters the subprog. The inserted
                                      insns must run.
  subprog, line info      new_off[i]  The subprog starts with the inserted
                                      insns, and with a line info record.
  jump, insn array,       new_tgt[i]  It goes to insn i. The inserted insns
  indirect_target flag                must not run again.
  poke descriptor         new_tgt[i]  It names the tail call at insn i.

The copy of insn i is behind the inserted insns. When it is a backward jump
or call, it gets longer by their number, as with bpf_adj_moved_insn().

When insn i has a queued patch, the new insns go in front of all of it.
bpf_convert_ctx_accesses() inserts the store of ctx for the epilogue in
front of insn 0. Then it inserts the prologue in front of the store.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h          |  3 +-
 include/linux/bpf_verifier.h |  6 +++
 kernel/bpf/bpf_insn_array.c  | 11 +++---
 kernel/bpf/core.c            | 74 +++++++++++++++++++++++++++++++-----
 kernel/bpf/fixups.c          | 39 ++++++++++++++++---
 5 files changed, 111 insertions(+), 22 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ba96b4fc893a..b21a29a76b94 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -4380,7 +4380,8 @@ int bpf_insn_array_ready(struct bpf_map *map);
 void bpf_insn_array_release(struct bpf_map *map);
 void bpf_insn_array_adjust(struct bpf_map *map, u32 first, u32 len);
 void bpf_insn_array_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);
-void bpf_insn_array_remap(struct bpf_map *map, const u32 *new_off, u32 cnt, s32 grow);
+void bpf_insn_array_remap(struct bpf_map *map, const u32 *new_off, const u32 *new_tgt,
+			  u32 cnt, s32 grow);
 
 #ifdef CONFIG_BPF_SYSCALL
 void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image);
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b77a0ba477f1..f8498de5eff5 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1064,6 +1064,7 @@ struct bpf_insn_patch {
 	u32 off;
 	u32 len;
 	u32 start;		/* first insn of the patch in bpf_patch_list.insns */
+	u32 target;		/* insn of the patch that jumps to 'off' land on */
 	struct bpf_insn orig;	/* the replaced insn when the patch was queued */
 };
 
@@ -1084,6 +1085,7 @@ struct bpf_patch_list {
 struct bpf_patch_image {
 	struct bpf_insn *insns;
 	u32 *new_off;
+	u32 *new_tgt;
 	u32 *new_linfo;
 	u32 cnt;
 	u32 new_cnt;
@@ -1110,6 +1112,8 @@ struct bpf_insn *__bpf_patch_list_add(struct bpf_patch_list *pl,
 				      const struct bpf_insn *patch, u32 len);
 int __bpf_patch_list_del(struct bpf_patch_list *pl, const struct bpf_prog *prog,
 			 u32 off);
+int __bpf_patch_list_insert(struct bpf_patch_list *pl, const struct bpf_prog *prog,
+			    u32 off, const struct bpf_insn *insns, u32 cnt);
 void bpf_patch_list_release(struct bpf_patch_list *pl);
 int bpf_patch_list_build(const struct bpf_patch_list *pl, const struct bpf_prog *prog,
 			 struct bpf_patch_image *img);
@@ -2082,6 +2086,8 @@ struct bpf_insn *bpf_patch_list_add(struct bpf_verifier_env *env, u32 off,
 int bpf_patch_list_commit(struct bpf_verifier_env *env);
 void bpf_patch_list_free(struct bpf_verifier_env *env);
 int bpf_patch_list_del(struct bpf_verifier_env *env, u32 off);
+int bpf_patch_list_insert(struct bpf_verifier_env *env, u32 off,
+			  const struct bpf_insn *insns, u32 cnt);
 
 int bpf_flip_opcode(u32 opcode);
 u8 bpf_rev_opcode(u8 opcode);
diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
index e2e4aee00c4d..79c5441ddd00 100644
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
 	u32 i, off;
@@ -270,7 +271,7 @@ void bpf_insn_array_remap(struct bpf_map *map, const u32 *new_off, u32 cnt, s32
 		if (off < cnt && new_off[off] == new_off[off + 1])
 			insn_array->values[i].xlated_off = INSN_DELETED;
 		else
-			insn_array->values[i].xlated_off = off <= cnt ? new_off[off] : off + grow;
+			insn_array->values[i].xlated_off = off <= cnt ? new_tgt[off] : off + grow;
 	}
 }
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 633728a5f0ea..2deb5584dc85 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -645,16 +645,19 @@ static int patch_list_move_down(struct bpf_insn *insns, u32 len, u32 by)
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
@@ -666,7 +669,7 @@ static int patch_list_adj_insn(struct bpf_insn *insn, const u32 *new_off,
 	if (tgt < 0 || tgt > cnt)
 		return -EFAULT;
 
-	rel = (s64)new_off[tgt] - pos - 1;
+	rel = (s64)(call ? new_off : new_tgt)[tgt] - pos - 1;
 	return insn_set_rel(insn, rel, is_imm);
 }
 
@@ -715,6 +718,7 @@ struct bpf_insn *__bpf_patch_list_add(struct bpf_patch_list *pl,
 	p = &pl->patches[pl->cnt++];
 	p->off = off;
 	p->len = len;
+	p->target = 0;
 	p->start = pl->insn_cnt;
 	p->orig = prog->insnsi[off];
 	memcpy(pl->insns + p->start, patch, len * sizeof(*patch));
@@ -737,11 +741,56 @@ int __bpf_patch_list_del(struct bpf_patch_list *pl, const struct bpf_prog *prog,
 	p = &pl->patches[pl->cnt++];
 	p->off = off;
 	p->len = 0;
+	p->target = 0;
 	p->start = pl->insn_cnt;
 	p->orig = prog->insnsi[off];
 	return 0;
 }
 
+/*
+ * Queue 'insns[0..cnt)' to go in front of insn 'off'. Jumps to 'off',
+ * instruction arrays and poke descriptors still name the insn at 'off', while
+ * subprogs, line info, function pointers and calls that start at 'off' start
+ * at the first inserted insn. Inserting in front of a queued patch puts the
+ * insns in front of it. 'off' is the start of a subprog, so nothing falls
+ * through to the inserted insns.
+ */
+int __bpf_patch_list_insert(struct bpf_patch_list *pl, const struct bpf_prog *prog,
+			    u32 off, const struct bpf_insn *insns, u32 cnt)
+{
+	struct bpf_insn_patch *p = pl->cnt ? &pl->patches[pl->cnt - 1] : NULL;
+	int err;
+
+	if (!p || off != p->off) {
+		err = patch_list_reserve_patch(pl) ?: patch_list_reserve_insns(pl, 1);
+		if (err)
+			return err;
+		p = &pl->patches[pl->cnt++];
+		p->off = off;
+		p->len = 1;
+		p->target = 0;
+		p->start = pl->insn_cnt;
+		p->orig = prog->insnsi[off];
+		pl->insns[pl->insn_cnt++] = p->orig;
+	}
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
+	return 0;
+}
+
 void bpf_patch_list_release(struct bpf_patch_list *pl)
 {
 	kvfree(pl->patches);
@@ -784,9 +833,10 @@ static int patch_image_map_linfo(struct bpf_patch_image *img, const struct bpf_p
 /*
  * Build the image of 'prog' with the queued patches applied in img->insns,
  * without touching 'prog'. img->new_off[] maps each old insn to the start of
- * its patch, a removed insn to the next one that stays. img->new_linfo[] is
- * there when insns are removed, see patch_image_map_linfo(). On -ERANGE,
- * img->bad is the old insn whose jump got out of range.
+ * its patch, img->new_tgt[] to where jumps to it land, both map a removed insn
+ * to the next one that stays. img->new_linfo[] is there when insns are
+ * removed, see patch_image_map_linfo(). On -ERANGE, img->bad is the old insn
+ * whose jump got out of range. No list has both removed and inserted insns.
  */
 int bpf_patch_list_build(const struct bpf_patch_list *pl, const struct bpf_prog *prog,
 			 struct bpf_patch_image *img)
@@ -797,12 +847,15 @@ int bpf_patch_list_build(const struct bpf_patch_list *pl, const struct bpf_prog
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
@@ -831,7 +884,7 @@ int bpf_patch_list_build(const struct bpf_patch_list *pl, const struct bpf_prog
 		for (n = 0; n < len; n++) {
 			img->insns[pos + n] = src[n];
 			err = patch_list_adj_insn(&img->insns[pos + n], img->new_off,
-						  cnt, i, n, len, pos + n);
+						  img->new_tgt, cnt, i, n, len, pos + n);
 			if (err) {
 				img->bad = i;
 				return err;
@@ -845,6 +898,7 @@ void bpf_patch_image_free(struct bpf_patch_image *img)
 {
 	kvfree(img->insns);
 	kvfree(img->new_linfo);
+	kvfree(img->new_tgt);
 	kvfree(img->new_off);
 	memset(img, 0, sizeof(*img));
 }
@@ -861,7 +915,7 @@ void bpf_patch_image_install(struct bpf_prog *prog, const struct bpf_patch_image
 
 	for (i = 0; i < prog->aux->size_poke_tab; i++)
 		prog->aux->poke_tab[i].insn_idx =
-			bpf_patch_image_remap(img, img->new_off,
+			bpf_patch_image_remap(img, img->new_tgt,
 					      prog->aux->poke_tab[i].insn_idx);
 
 	for (i = 0, j = 0; i < prog->aux->nr_linfo; i++) {
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 7f8d51617b2e..147fcc4d2f43 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -394,6 +394,29 @@ int bpf_patch_list_del(struct bpf_verifier_env *env, u32 off)
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
+			    (p && (off < p->off || (off == p->off && !p->len))),
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
@@ -402,6 +425,7 @@ void bpf_patch_list_free(struct bpf_verifier_env *env)
 /*
  * Fill the aux data of the 'p->len' insns at 'slot' from the aux data 'old'
  * of the insn they replace, the same way as adjust_insn_aux_data() does.
+ * The insns in front of p->target were inserted, as with BPF_PATCH_MOVE_TARGET.
  */
 static void patch_list_adj_aux(struct bpf_prog *prog, struct bpf_insn_patch *p,
 			       struct bpf_insn *patch,
@@ -421,7 +445,7 @@ static void patch_list_adj_aux(struct bpf_prog *prog, struct bpf_insn_patch *p,
 		/* messages name the insn of the original program */
 		slot[i].orig_idx = last->orig_idx;
 		slot[i].zext_dst = bpf_insn_def32(prog, &patch[i]) >= 0;
-		if (!memcmp(&patch[i], orig, sizeof(*orig))) {
+		if (i >= p->target && !memcmp(&patch[i], orig, sizeof(*orig))) {
 			slot[i].non_stack_access = last->non_stack_access;
 			last->non_stack_access = false;
 		} else if (bpf_is_mem_insn(&patch[i])) {
@@ -433,9 +457,9 @@ static void patch_list_adj_aux(struct bpf_prog *prog, struct bpf_insn_patch *p,
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
@@ -595,7 +619,10 @@ static void patch_list_remap_subprogs(struct bpf_verifier_env *env,
 /*
  * Apply all queued patches and removals in one go. Everything that names an
  * insn of the old image follows it to the new one. A patched insn is named by
- * the first insn of its patch, like with bpf_patch_insn_data().
+ * the first insn of its patch, like with bpf_patch_insn_data(). If insns were
+ * inserted in front of an insn, jumps, instruction arrays and poke descriptors
+ * name the insn itself, while subprogs, line info, function pointers and calls
+ * name the first inserted insn.
  *
  * An entry that names a removed insn:
  *   jump, call, poke descriptor  names the next insn that stays
@@ -663,7 +690,7 @@ int bpf_patch_list_commit(struct bpf_verifier_env *env)
 	patch_list_remap_subprogs(env, &img);
 	for (i = 0; i < env->insn_array_map_cnt; i++)
 		bpf_insn_array_remap(env->insn_array_maps[i], img.new_off,
-				     img.cnt, img.grow);
+				     img.new_tgt, img.cnt, img.grow);
 
 	bpf_patch_image_install(prog, &img);
 out:
-- 
2.55.0

