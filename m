Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793583019;
	b=AQ+MZHecaBXzQLRsGjOwbROe55vKhoTxLYT03wsRT38NWO0coWmse3Eghx0onOguX0ly
	 fzujfP9JKcwQ07Fh/abGFrE9YOgnlrJIXYMAhygQtxKeZEqdwM9VaqE1BJI6fhW8YLY3W
	 DHUJq1Bn5qUqJ9QEENSANxfHkceIzFJ+jD99opJZ57vh4VQl/vrcnhZJdxRwm29zhmVZg
	 w0RI4fyZEo/r7aZt4p5rczstj3A9I5L+BwqQDatEHVL1PZCvStmoqGwGaySNzqnx7C5z8
	 JFo3av7GzlDuCVaT6abLfgoQ/mI5Jccbb2XtNPGjMGlDP6CfV6ZmZDDY5FVLEIBh3aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793583019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=riyfKVnlEe7swalaxxD/lIqAVeRQDKnxbYtGxOPrQ4w=;
	b=dF7axkah1za+TqZw6lpm4pUWuVkQwaZ9y9yisF/SdSA+mMkLXB5Q9cRIdBi6rXTOTL0L
	 rnFpbkgMRguORWIanhpEN+5Vf2MZqLMeYuGOX5RZ+XY3+qaw9jX9WkO9R8jd6nUlxpSOF
	 Wu2q5d//H5vjqKKO9nqMpu66nb08TuwcNogKoQ5fJhIpNgT8MwBxXF1bndlMFAe0zGG1E
	 f+q+R0LmS1ucn6AaE9rMMwaWIdJkuPIHnT93RkhIgnD7k56jC4DfgEtzqtvb9myZmM3D/
	 Ef85RibSyyvuTqvJNiP0CTgLYjcv27b3zwuMd04zndnCfR1Yede0qUE+gOJCI/1WotA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ou1EavRP;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6759C606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 01:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6759C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ou1EavRP
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso1103738a91.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 17:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793583019; x=1794187819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=riyfKVnlEe7swalaxxD/lIqAVeRQDKnxbYtGxOPrQ4w=;
        b=ou1EavRPdfVXryGCi17pjKz+0f/n/7naIUIBHpXJKemgEOCCr2VfRVnqKbD4MV8bvH
         6BJjaQNegqCOvQl2cXh+WI7W1CWG4XIAqq1+vqyBtgnt/uJ7+JyPlUgAWJAqhEbOyah8
         5DTCWtrlfwUDFmvNuYbntkKXLQ/og4EfJRymunFVeKlr3GdEfnDqBtVfAJxkoQcJE0ZU
         PhK1XuXjzUs7HK28TQ8vVhQwsbW52OT5b+iw9/9FfIB18LtcHZfeHCeHtCdCygl/NxmL
         L99yqwlu+fBnnP/jq6s8ARBv4Q/KD6uYk5ZQdP1UftwWcdpuTQZAjKu6AF38dpc2g1wW
         gAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793583019; x=1794187819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=riyfKVnlEe7swalaxxD/lIqAVeRQDKnxbYtGxOPrQ4w=;
        b=NhmVPeEaDRb5/4DiUW+PcFTDn7+0F1RYoIveOIgvH4wuLOtElkZxy20TFkZ4VL0uZS
         NojezRg0BP0hIZV8fW38bdw5XmNjJLvgKXj90crq+eGRckkb/TO+Y0oq/avYVlVoOVGF
         nFVTS8qcp8KY4yfBBCjyqdYcBGNFArzyjdd+7NlS7/knVdMesbn+Bnvt5uLF8DxymHnu
         xmDJ9oNUo3H9YGl4Lehzg9EqkfMomge5DVoRNBeCZpF0AGQM7IYy3TDzh4tWov1J3vao
         VxNL8WByhBMDT/D8wum5R4QCNZCj3HWz0kCDSUYk9QO1zF8ufvtxPT+a0twtpzpivJ2F
         po+Q==
X-Gm-Message-State: APuU4Z/Gk2oNLIEyYYFdreck3xN7ans10Mdx3ntFGe9p6D5AySwrrZvX
	iXU7vx1CkfZDPWNwm3gWqgWLXfYz0/HTDMQ6x5DtbYHhXEJxvstkG2x4aJf9YQ==
X-Gm-Gg: AYBFou2X0dGhGhmBLIXdWviO52KaC0jwe5W0Ll8ILwxYOnQ/iUfxVknazJK4tOt07Ol
	j/DMwfVBOY4OWvfI9EubXlEesiSfkcky1+MCxI6sB1dwyObvfEpe95bmPY0iNMLJfOqwk5kxvFQ
	aevygpG5IDQ8y8fWa4yIoDeb3uT35MAKbbUCPNxOM8jhPybPhT/1B1JxAXdKHZOCzMeoDRmDz26
	M8djBoZj+0pG8j+HzucOFk3rpoUXN/4H3VoWID9gyJDKeXjHUsfzS27PFZA8xWNzrkwGjIpbAH3
	T6Kn7nRWr94H+WgtaXX4xT5H5CWQ+kJDWjhkv3e6F8ezDhko1vVH7MMb3WNb5/+HuF3B+FZo2Sh
	Hu35wCLlv6LaTER4uYWUsyWjdsCpOY8Gw6hTEhxHW81yOVBymklBZNOpfc+CjfqTeoZLZpFNOUR
	Lv3bPkh2nl8/ByoIXzdlJ5pEHE66J0MyBHnzzUJ7RClTH7YHsPOVIAyzSSPOFv8iHFD1ce6gnbl
	QpqZCPY6rgkjmeRtHdaLGyT48/mhUDOg4FXxqPokA/n3YqpXD8OP/dcc532TMCPMnOvfQomxASb
	BJMjYRnhgKUCDPdC3Xrir53W6I6SL+qgx/jDdM/87icx3Nauf+T124VjWpYaSuW4Ynd+Z4nIsjX
	aOQLPkwx0CVNNO/UpLPZSYvtIRWczhJ1v3azSPfOQ0otXs9NEuVbD1xrUhHO2n5YKu8sMztYBSw
	==
X-Received: by 2002:a17:90b:2fd0:b0:3ac:af8b:6f3 with SMTP id 98e67ed59e1d1-3ae898149e2mr6552618a91.52.1793583018416;
        Sun, 01 Nov 2026 17:30:18 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae8441a6f0sm11635649a91.1.2026.11.01.17.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 17:30:18 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	odys.yuan@gmail.com
Subject: [PATCH bpf-next v3 06/13] bpf: Allow patching an instruction twice through the patch list
Date: Mon,  2 Nov 2026 01:29:33 +0000
Message-ID: <20261102012940.1756142-7-alexei.starovoitov@gmail.com>
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

bpf_convert_ctx_accesses() can patch one insn two times. The first patch
puts a barrier ('nospec') in front of the insn. The second patch replaces
the insn, for example a ctx access. bpf_patch_insn_data() moves the insn
immediately, and the second call gets its new index. The patch list only
queues a patch, and no insn moves before the commit. Thus a queued insn has
no index, and bpf_patch_list_add() accepts only one patch for each insn.

Let a second bpf_patch_list_add() for the same insn replace the last insn
of the queued patch. That is where the first patch puts the insn. The
result is one patch. Here insn i reads skb->ifindex:

  queued patch of insn i    after the second bpf_patch_list_add()
  nospec                    nospec
  r0 = *(u32 *)(r1 + 40)    r0 = *(u64 *)(r1 + 16)
                            if r0 == 0 goto +1
                            r0 = *(u32 *)(r0 + 224)

 - The pass writes the second patch as if it was the only patch of insn i.
   But in the list its insns are behind the barrier. Thus a backward jump
   or call that leaves the patch gets longer by the number of insns in
   front: 'gotol -5' becomes 'gotol -6'. A forward jump, as the
   'if r0 == 0 goto +1' above, does not change.
 - In this pass only the 'gotol' from an 'exit' back to the first epilogue
   is such a backward jump. No prog has it behind a barrier. A prog with an
   epilogue needs CAP_PERFMON, and then the verifier adds no barrier. The
   list adjusts the jump all the same, because bpf_patch_list_add() must
   not depend on what its callers queue.
 - The second patch changes the length of the queued patch. Thus the insns
   in front of the last insn must not jump behind the patch. A barrier does
   not jump. For such a jump bpf_patch_list_add() returns -EFAULT with a
   WARN.
 - A second patch of 1 insn goes to the list. It is not written in place,
   because the commit takes the insn from the list.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/core.c   | 64 +++++++++++++++++++++++++++++++++++++++++++--
 kernel/bpf/fixups.c |  9 ++++---
 2 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index e96de7a2c786..633728a5f0ea 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -602,6 +602,46 @@ static int insn_set_rel(struct bpf_insn *insn, s64 rel, bool is_imm)
 	return 0;
 }
 
+/* Whether one of the 'len' insns of a patch in front of the last one jumps past it. */
+static bool patch_list_jumps_past(const struct bpf_insn *insns, u32 len)
+{
+	bool is_imm;
+	s64 rel;
+	u32 k;
+
+	for (k = 0; k + 1 < len; k++)
+		if (insn_get_rel(&insns[k], &rel, &is_imm) && (s64)k + rel + 1 >= len)
+			return true;
+	return false;
+}
+
+/*
+ * The 'len' insns of a patch were moved down by 'by' insns inside it. Keep
+ * what they referred to in front of the patch, the same way as
+ * bpf_adj_moved_insn() does: a call to the start of the patch, the old start
+ * of a subprog, stays there, a jump to itself doesn't.
+ */
+static int patch_list_move_down(struct bpf_insn *insns, u32 len, u32 by)
+{
+	bool is_imm, call;
+	s64 rel, tgt;
+	u32 k;
+	int err;
+
+	for (k = 0; k < len; k++) {
+		if (!insn_get_rel(&insns[k], &rel, &is_imm))
+			continue;
+		call = bpf_pseudo_func(&insns[k]) || bpf_pseudo_call(&insns[k]);
+		tgt = (s64)k + rel + 1;
+		if (tgt > 0 || (tgt == 0 && !call))
+			continue;
+		err = insn_set_rel(&insns[k], rel - by, is_imm);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 /*
  * insn is number 'idx' of the 'len' insns that replace insn 'off' of the old
  * image (an insn that isn't patched is its own patch of length 1). It lands
@@ -634,7 +674,10 @@ static int patch_list_adj_insn(struct bpf_insn *insn, const u32 *new_off,
  * Queue the replacement of insn 'off' of 'prog' by 'patch[0..len)'. Patches
  * are queued in increasing order of 'off' and applied together, so a pass
  * keeps addressing insns by their index in 'prog'. Jumps in the patch that
- * leave it are relative to the patch placed at 'off'.
+ * leave it are relative to the patch placed at 'off'. Patching 'off' again
+ * replaces the last insn of its patch, where the insn being patched went, and
+ * the insns in front of it must not jump past it. Jumps of the new insns that
+ * leave the patch are relative to the first of them, as for a first patch.
  *
  * Return the copy of the last insn of the patch, which stays valid until the
  * next call.
@@ -645,9 +688,26 @@ struct bpf_insn *__bpf_patch_list_add(struct bpf_patch_list *pl,
 				      const struct bpf_prog *prog, u32 off,
 				      const struct bpf_insn *patch, u32 len)
 {
-	struct bpf_insn_patch *p;
+	struct bpf_insn_patch *p = pl->cnt ? &pl->patches[pl->cnt - 1] : NULL;
 	int err;
 
+	if (p && off == p->off) {
+		if (WARN_ON_ONCE(patch_list_jumps_past(pl->insns + p->start, p->len)))
+			return ERR_PTR(-EFAULT);
+		err = patch_list_reserve_insns(pl, len - 1);
+		if (err)
+			return ERR_PTR(err);
+		/* the last patch is at the end of pl->insns */
+		memcpy(pl->insns + p->start + p->len - 1, patch, len * sizeof(*patch));
+		err = patch_list_move_down(pl->insns + p->start + p->len - 1, len,
+					   p->len - 1);
+		if (err)
+			return ERR_PTR(err);
+		p->len += len - 1;
+		pl->insn_cnt += len - 1;
+		return &pl->insns[p->start + p->len - 1];
+	}
+
 	err = patch_list_reserve_patch(pl) ?: patch_list_reserve_insns(pl, len);
 	if (err)
 		return ERR_PTR(err);
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 6fe47e400bc2..7f8d51617b2e 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -350,28 +350,31 @@ struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
 /*
  * Queue the replacement of insn 'off' by 'patch[0..len)' until
  * bpf_patch_list_commit(), see __bpf_patch_list_add(). Replacing one insn by
- * one moves nothing and is done right away.
+ * one moves nothing and is done right away in the program, unless 'off' has a
+ * queued patch: the commit takes the insn from there.
  */
 struct bpf_insn *bpf_patch_list_add(struct bpf_verifier_env *env, u32 off,
 				    const struct bpf_insn *patch, u32 len)
 {
 	struct bpf_patch_list *pl = &env->patch_list;
+	struct bpf_insn_patch *p = pl->cnt ? &pl->patches[pl->cnt - 1] : NULL;
 
 	if (bpf_rewrite_must_abort())
 		return ERR_PTR(-EINTR);
 
 	if (verifier_bug_if(!len || off >= env->prog->len ||
-			    (pl->cnt && off <= pl->patches[pl->cnt - 1].off),
+			    (p && (off < p->off || (off == p->off && !p->len))),
 			    env, "insn %u patched out of order", off))
 		return ERR_PTR(-EFAULT);
 
-	if (len == 1) {
+	if (len == 1 && (!p || off != p->off)) {
 		env->prog->insnsi[off] = *patch;
 		adjust_insn_aux_data(env, env->prog, off, 1, NULL,
 				     BPF_PATCH_KEEP_TARGET);
 		return &env->prog->insnsi[off];
 	}
 
+	/* -ERANGE takes a second patch with a 16-bit jump back out of it: no pass has one */
 	return __bpf_patch_list_add(pl, env->prog, off, patch, len);
 }
 
-- 
2.55.0

