Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=131.188.11.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627189;
	b=eiXiM11Uy0xkIk4/tUa/2u5jR9QvwOil7iMkfrtJaCy9RRqInM8FprcgQ17nw6giUOeS
	 AcEDrbDl5E0Fvqg/hHp8GPYTet6hjT8k0LzAfn1Q+5/AS4bwwLpLILXlFV7kMLWCsE1t8
	 z8Viu9eLLwkv9+lb3gqhC7DxC5NPj29l2Lssf+sBVfNoSVAN7UTmHxrRrqUERaICMbQFa
	 is8F42/rQtkB9VS9w9vuZbF/jPdfdWGbmd0Pfft8h5vy5YNFaqxUMToE8aBLeSIZy+kHr
	 0tQm2rSUuwhGpYX+Nt4b9axAclMIswdAxxIFfFuW44XKG5nmzwS/HbQ6Sljz7R4H5bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627189;
	h=DMARC-Filter:DKIM-Signature:Received:X-Virus-Scanned:X-RRZE-Flag:
	 X-RRZE-Submit-IP:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Oc65kn/qlGgSksKwqthkCtoqSlDD5Kcyd3zMyDT94Mo=;
	b=TwmxRJgZU8379qYIxzxhEIofjTcxdhObXeyD1Tor5E+2Ys256tW01OHrB3WIZUZwKG88
	 +ZXheiGh2taK4PbeKDLayrDC6yBNemlVNdutzsTxIReDWACiHhbU/z9S0Buo5QyJ6wz+n
	 /SAmAbsVOsxaF6W6fxQU9N4sgtFKomVa4DdVV6HeHrZnw2MZZ8xHRs25WItHrOt7E7bXY
	 4Ok1atT/rVDk7xXzedPcTLx/UD0CiKkQ2jMt59wWKVnJcrKoTXbcWS8MG0r8g5WJMDK7p
	 bupALiLNLueFrFUf79mwpBYiOHdwOHwnNow2r+BYaTyNNwJPnbUjZ0NqrW90GhLbWgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fau.de;
	spf=pass smtp.mailfrom=fau.de;
	dkim=pass header.d=fau.de header.i=@fau.de header.a=rsa-sha256 header.s=fau-2021 header.b=XV6AzWwj;
	arc=none smtp.remote-ip=131.188.11.20
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E128606A321;
	Wed, 25 Nov 2026 17:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E128606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.a=rsa-sha256 header.s=fau-2021 header.b=XV6AzWwj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1795627181; bh=Oc65kn/qlGgSksKwqthkCtoqSlDD5Kcyd3zMyDT94Mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=XV6AzWwjRqNxjTb5oYleMmZClRd1TGsxtur+iSP+izYWSeVNp0r5pJNxrD+xt7YnJ
	 A7F16fYJHYWgU99it9p4tFvv1UflBVa5uhy0oG89RdpcFvJkOlai/pHrMTwluC367l
	 MZZ1DrOakTC4YMBbfziHEnuj6uhgg+OZDFnWy9sEhUgW/Tr3tpdCFk16a1KjJ7mPo3
	 UPVHMJLIvJP8SsjaEFzC/CxQy93aQEk8J5X8BvAVRvZe+glu0v4a0h/GzK77ZPCaWU
	 dp5OP3c9ktoHUiYyUjsGT3jNHvhICyPd9js0UhdIT1+a4AhBXW5gxluu0rkDylQ3C8
	 5RwFA3qM/fMsQ==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4jZRHx2fYXz8tYN;
	Wed, 25 Nov 2026 18:19:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:620:618:5b8:2:80b3:0:59e
Received: from luis-tp.epfl.ch (unknown [IPv6:2001:620:618:5b8:2:80b3:0:59e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX18OWnlv7IYC88aN6lMQ+NteuFB6Zkk9YpE=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4jZRHm50b7z8sd2;
	Wed, 25 Nov 2026 18:19:32 +0100 (CET)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Alexei Starovoitov <ast@kernel.org>,
	bpf@vger.kernel.org
Cc: Luis Gerhorst <luis.gerhorst@fau.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Henriette Herzog <henriette.herzog@rub.de>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 1/4] bpf: Add bpf_insert_insns() to insert insns next to an insn
Date: Wed, 25 Nov 2026 18:12:49 +0100
Message-ID: <45c622fb6bba40629594679c01eed836d58acd89.1795625597.git.luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795625597.git.luis.gerhorst@fau.de>
References: <20261125-nospec-result-reply-d60fdc6da8ef@fau.de> <cover.1795625597.git.luis.gerhorst@fau.de>
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

bpf_patch_insn_data() replaces an insn with a patch and moves the aux
data of the insn to the last insn of the patch. To insert insns in front
of or behind an insn, the callers put a copy of the insn into the patch.
This has a number of consequences:

- The copy is not the last insn of the patch if the insns are inserted
  behind it. adjust_insn_aux_data() finds it by comparing all insns of
  the patch with a copy of the original insn, and moves non_stack_access
  back to it. The other fields stay at the last insn, so the insn is
  left with zeroed aux data for the passes that follow.

- The copy moves down inside the patch if insns are inserted in front of
  it. The callers have to adjust it with bpf_adj_moved_insn().

- The callers that insert in front of the insn have to say if the
  targets of the insn follow it, with BPF_PATCH_MOVE_TARGET. This only
  covers the indirect targets, they have to move the jumps to the insn
  with adjust_jmp_off() themselves.

Add bpf_insert_insns() which takes only the new insns and where they
go: in front of the insn, with a jump to the insn running them or
skipping them, or behind the insn. It builds the patch, adjusts the
copy, moves the jumps to the insn if they are to skip the new insns, and
tells adjust_insn_aux_data() where the copy is. The insn keeps
all of its aux data. Every other insn of a patch is new and is marked
for non-stack access if it accesses memory, which no longer needs the
comparison.

Use it where a patch only inserts:

- the zero extension and the randomization of the upper 32 bits in
  bpf_opt_subreg_zext_lo32_rnd_hi32()
- the prologue, the save of the ctx for the epilogue and the
  initialization of the may_goto counter, which used
  BPF_PATCH_MOVE_TARGET
- the per-CPU address of a ld_imm64 in bpf_do_misc_fixups()
- the nospec in front of and behind an insn in
  bpf_convert_ctx_accesses()

bpf_insert_insns() returns an ERR_PTR(), so that the callers still
return -ERANGE if the insn can not be adjusted.

bpf_patch_insn_data() is left for the patches that replace the insn.
Where such a patch still contains the insn, the insn now counts as new
and is marked for non-stack access if it accesses memory. This makes no
difference, because none of these patches contains a stack access.

No functional change.

Assisted-by: Claude:claude-mythos-5-2
Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
---
 include/linux/bpf_verifier.h |   1 +
 kernel/bpf/fixups.c          | 284 +++++++++++++++++------------------
 2 files changed, 141 insertions(+), 144 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b43eb97bcd44..2f9fa9d889a4 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1217,6 +1217,7 @@ struct bpf_verifier_env {
 	char tmp_str_buf[TMP_STR_BUF_LEN];
 	char tmp_arg_name[32];
 	struct bpf_insn insn_buf[INSN_BUF_SIZE];
+	struct bpf_insn insert_buf[INSN_BUF_SIZE];
 	struct bpf_insn epilogue_buf[INSN_BUF_SIZE];
 	struct bpf_scc_callchain callchain_buf;
 	struct bpf_liveness *liveness;
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index a656634fa9e4..485feffe0536 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -170,82 +170,60 @@ enum bpf_patch_mode {
 	BPF_PATCH_MOVE_TARGET,	/* targets of 'off' follow the original insn to 'off + len - 1' */
 };
 
+/* The patch does not contain the insn that it replaces. */
+#define BPF_PATCH_NO_ORIG	-1
+
 /* single env->prog->insni[off] instruction was replaced with the range
  * insni[off, off + cnt).  Adjust corresponding insn_aux_data by copying
  * [0, off) and [off, end) to new locations, so the patched range stays zero
+ *
+ * The aux data of the original insn stays with the insn if the range still
+ * contains it, at index 'orig'. Otherwise 'orig' is BPF_PATCH_NO_ORIG and the
+ * aux data moves to the last insn of the range.
  */
 static void adjust_insn_aux_data(struct bpf_verifier_env *env,
 				 struct bpf_prog *new_prog, u32 off, u32 cnt,
-				 struct bpf_insn *original_insn,
-				 enum bpf_patch_mode mode)
+				 int orig, enum bpf_patch_mode mode)
 {
 	struct bpf_insn_aux_data *data = env->insn_aux_data;
 	struct bpf_insn *insn = new_prog->insnsi;
+	u32 last = off + cnt - 1;
+	u32 keep = orig == BPF_PATCH_NO_ORIG ? last : off + orig;
+	u32 target = mode == BPF_PATCH_MOVE_TARGET ? keep : off;
+	bool indirect_target = data[off].indirect_target;
 	u32 old_seen = data[off].seen;
-	u32 prog_len;
+	u32 prog_len = new_prog->len;
 	int i;
 
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
+	if (cnt > 1) {
+		env->insn_aux_data_len = prog_len;
+		memmove(data + last, data + off,
+			sizeof(struct bpf_insn_aux_data) * (prog_len - last));
+		/* The aux data of the original insn is at 'off' and 'last' now. */
+		data[keep] = data[last];
+		for (i = off; i <= last; i++)
+			if (i != keep)
+				memset(data + i, 0, sizeof(struct bpf_insn_aux_data));
 	}
-	prog_len = new_prog->len;
-	env->insn_aux_data_len = prog_len;
 
-	memmove(data + off + cnt - 1, data + off,
-		sizeof(struct bpf_insn_aux_data) * (prog_len - off - cnt + 1));
-	memset(data + off, 0, sizeof(struct bpf_insn_aux_data) * (cnt - 1));
-	for (i = off; i < off + cnt - 1; i++) {
+	for (i = off; i <= last; i++) {
 		/* Expand insni[off]'s seen count to the patched range. */
 		data[i].seen = old_seen;
 		data[i].zext_dst = bpf_insn_def32(new_prog, insn + i) >= 0;
 		/*
-		 * In BPF_PATCH_MOVE_TARGET mode the original insn is the last
-		 * slot by construction.
+		 * A new insn can access memory. Systematically mark it for
+		 * non-stack access, only the original insn keeps its marking.
 		 */
-		if (mode == BPF_PATCH_KEEP_TARGET &&
-		    !memcmp(insn + i, original_insn, sizeof(struct bpf_insn))) {
-			data[i].non_stack_access =
-				data[off + cnt - 1].non_stack_access;
-			data[off + cnt - 1].non_stack_access = false;
-		} else if (bpf_is_mem_insn(insn + i)) {
-			data[i].non_stack_access = true;
-		}
+		if (orig == BPF_PATCH_NO_ORIG || i != keep)
+			data[i].non_stack_access = bpf_is_mem_insn(insn + i);
 	}
 
 	/*
-	 * Last slot instruction could be a newly generated
-	 * BPF_ST/BPF_LDX/BPF_STX, systematically mark it for non-stack access
-	 * if it is not the original instruction, otherwise keep the
-	 * original marking
+	 * An indirect jump to 'off' goes where the other targets of 'off' go.
+	 * This matches bpf_insn_array_adjust().
 	 */
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
+	data[keep].indirect_target = 0;
+	data[target].indirect_target = indirect_target;
 }
 
 static void adjust_subprog_starts(struct bpf_verifier_env *env, u32 off, u32 len)
@@ -310,13 +288,12 @@ static bool bpf_rewrite_must_abort(void)
 
 static struct bpf_prog *__bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
 					      const struct bpf_insn *patch, u32 len,
-					      enum bpf_patch_mode mode)
+					      int orig, enum bpf_patch_mode mode)
 {
 	struct bpf_prog *new_prog;
 	struct bpf_insn_aux_data *new_data = NULL;
 	/* The first slot whose targets move. */
 	u32 first = mode == BPF_PATCH_MOVE_TARGET ? off : off + 1;
-	struct bpf_insn original_insn;
 
 	if (bpf_rewrite_must_abort())
 		return NULL;
@@ -332,7 +309,6 @@ static struct bpf_prog *__bpf_patch_insn_data(struct bpf_verifier_env *env, u32
 		env->insn_aux_data = new_data;
 	}
 
-	memcpy(&original_insn, env->prog->insnsi + off, sizeof(struct bpf_insn));
 	new_prog = bpf_patch_insn_single(env->prog, off, patch, len);
 	if (IS_ERR(new_prog)) {
 		if (PTR_ERR(new_prog) == -ERANGE)
@@ -341,7 +317,7 @@ static struct bpf_prog *__bpf_patch_insn_data(struct bpf_verifier_env *env, u32
 				env->insn_aux_data[off].orig_idx);
 		return NULL;
 	}
-	adjust_insn_aux_data(env, new_prog, off, len, &original_insn, mode);
+	adjust_insn_aux_data(env, new_prog, off, len, orig, mode);
 	adjust_subprog_starts(env, off, len);
 	adjust_insn_arrays(env, first, len);
 	bpf_adjust_func_ptrs(env, off, len);
@@ -352,7 +328,8 @@ static struct bpf_prog *__bpf_patch_insn_data(struct bpf_verifier_env *env, u32
 struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
 				     const struct bpf_insn *patch, u32 len)
 {
-	return __bpf_patch_insn_data(env, off, patch, len, BPF_PATCH_KEEP_TARGET);
+	return __bpf_patch_insn_data(env, off, patch, len, BPF_PATCH_NO_ORIG,
+				     BPF_PATCH_KEEP_TARGET);
 }
 
 /*
@@ -431,6 +408,62 @@ static int adjust_jmp_off(struct bpf_prog *prog, u32 tgt_idx, u32 delta)
 	return 0;
 }
 
+/* Where bpf_insert_insns() puts the new insns relative to the insn at 'off'. */
+enum bpf_insert_pos {
+	BPF_INSERT_BEFORE,	/* in front of the insn, a jump to the insn runs them too */
+	BPF_INSERT_ENTRY,	/* in front of the insn, a jump to the insn skips them */
+	BPF_INSERT_AFTER,	/* behind the insn */
+};
+
+/*
+ * Insert 'cnt' insns next to env->prog->insnsi[off]. Unlike with
+ * bpf_patch_insn_data(), the insn is not replaced: it keeps its aux data,
+ * wherever it ends up. Returns the new prog or an ERR_PTR().
+ */
+static struct bpf_prog *bpf_insert_insns(struct bpf_verifier_env *env, u32 off,
+					 const struct bpf_insn *insns, u32 cnt,
+					 enum bpf_insert_pos pos)
+{
+	enum bpf_patch_mode mode = pos == BPF_INSERT_ENTRY ? BPF_PATCH_MOVE_TARGET :
+							     BPF_PATCH_KEEP_TARGET;
+	struct bpf_insn *patch = env->insert_buf;
+	struct bpf_prog *new_prog;
+	/* The index of the insn in the patch. */
+	u32 orig;
+
+	if (verifier_bug_if(cnt >= INSN_BUF_SIZE, env, "%u insns inserted", cnt))
+		return ERR_PTR(-EFAULT);
+
+	if (pos == BPF_INSERT_AFTER) {
+		orig = 0;
+		memcpy(patch + 1, insns, cnt * sizeof(*insns));
+	} else {
+		orig = cnt;
+		memcpy(patch, insns, cnt * sizeof(*insns));
+	}
+	patch[orig] = env->prog->insnsi[off];
+
+	/* The insn moved down by 'orig' insns. */
+	if (bpf_adj_moved_insn(&patch[orig], orig)) {
+		verbose(env, "insn %d cannot be patched due to 16-bit range\n",
+			env->insn_aux_data[off].orig_idx);
+		return ERR_PTR(-ERANGE);
+	}
+
+	new_prog = __bpf_patch_insn_data(env, off, patch, cnt + 1, orig, mode);
+	if (!new_prog)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * The jumps to the insn still name 'off'. Adjustment will succeed
+	 * because __bpf_patch_insn_data() didn't fail.
+	 */
+	if (pos == BPF_INSERT_ENTRY)
+		WARN_ON(adjust_jmp_off(new_prog, off, cnt));
+
+	return new_prog;
+}
+
 static int adjust_subprog_starts_after_remove(struct bpf_verifier_env *env,
 					      u32 off, u32 cnt)
 {
@@ -757,7 +790,7 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 	struct bpf_insn *patch;
 	/* use env->insn_buf as two independent buffers */
 	struct bpf_insn *zext_patch = env->insn_buf;
-	struct bpf_insn *rnd_hi32_patch = &env->insn_buf[2];
+	struct bpf_insn *rnd_hi32_patch = &env->insn_buf[1];
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
 	int i, patch_len, delta = 0, len = env->prog->len;
 	struct bpf_insn *insns = env->prog->insnsi;
@@ -765,10 +798,10 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 	bool rnd_hi32;
 
 	rnd_hi32 = attr->prog_flags & BPF_F_TEST_RND_HI32;
-	zext_patch[1] = BPF_ZEXT_REG(0);
-	rnd_hi32_patch[1] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, 0);
-	rnd_hi32_patch[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_AX, 32);
-	rnd_hi32_patch[3] = BPF_ALU64_REG(BPF_OR, 0, BPF_REG_AX);
+	zext_patch[0] = BPF_ZEXT_REG(0);
+	rnd_hi32_patch[0] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, 0);
+	rnd_hi32_patch[1] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_AX, 32);
+	rnd_hi32_patch[2] = BPF_ALU64_REG(BPF_OR, 0, BPF_REG_AX);
 	for (i = 0; i < len; i++) {
 		int adj_idx = i + delta;
 		struct bpf_insn insn;
@@ -801,11 +834,10 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 				continue;
 
 			imm_rnd = get_random_u32();
-			rnd_hi32_patch[0] = insn;
-			rnd_hi32_patch[1].imm = imm_rnd;
-			rnd_hi32_patch[3].dst_reg = load_reg;
+			rnd_hi32_patch[0].imm = imm_rnd;
+			rnd_hi32_patch[2].dst_reg = load_reg;
 			patch = rnd_hi32_patch;
-			patch_len = 4;
+			patch_len = 3;
 			goto apply_patch_buffer;
 		}
 
@@ -830,19 +862,18 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 				    "zext_dst is set, but no reg is defined"))
 			return -EFAULT;
 
-		zext_patch[0] = insn;
-		zext_patch[1].dst_reg = load_reg;
-		zext_patch[1].src_reg = load_reg;
+		zext_patch[0].dst_reg = load_reg;
+		zext_patch[0].src_reg = load_reg;
 		patch = zext_patch;
-		patch_len = 2;
+		patch_len = 1;
 apply_patch_buffer:
-		new_prog = bpf_patch_insn_data(env, adj_idx, patch, patch_len);
-		if (!new_prog)
-			return -ENOMEM;
+		new_prog = bpf_insert_insns(env, adj_idx, patch, patch_len, BPF_INSERT_AFTER);
+		if (IS_ERR(new_prog))
+			return PTR_ERR(new_prog);
 		env->prog = new_prog;
 		insns = new_prog->insnsi;
 		aux = env->insn_aux_data;
-		delta += patch_len - 1;
+		delta += patch_len;
 	}
 
 	return 0;
@@ -909,6 +940,7 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 	const struct bpf_verifier_ops *ops = env->ops;
 	int i, cnt, size, ctx_field_size, ret, delta = 0, epilogue_cnt = 0;
 	const int insn_cnt = env->prog->len;
+	const struct bpf_insn nospec = BPF_ST_NOSPEC();
 	struct bpf_insn *epilogue_buf = env->epilogue_buf;
 	struct bpf_insn *insn_buf = env->insn_buf;
 	struct bpf_insn *insn;
@@ -930,13 +962,11 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			subprogs[0].stack_depth += 8;
 			insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_1,
 						      -subprogs[0].stack_depth);
-			insn_buf[cnt++] = env->prog->insnsi[0];
-			new_prog = __bpf_patch_insn_data(env, 0, insn_buf, cnt,
-							 BPF_PATCH_MOVE_TARGET);
-			if (!new_prog)
-				return -ENOMEM;
+			new_prog = bpf_insert_insns(env, 0, insn_buf, cnt, BPF_INSERT_ENTRY);
+			if (IS_ERR(new_prog))
+				return PTR_ERR(new_prog);
 			env->prog = new_prog;
-			delta += cnt - 1;
+			delta += cnt;
 
 			ret = add_kfunc_in_insns(env, epilogue_buf, epilogue_cnt - 1);
 			if (ret < 0)
@@ -967,10 +997,11 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 						   env->prog->aux->attach_btf_id))
 				return -EINVAL;
 			env->prog->aux->has_prologue = true;
-			new_prog = __bpf_patch_insn_data(env, 0, insn_buf, cnt,
-							 BPF_PATCH_MOVE_TARGET);
-			if (!new_prog)
-				return -ENOMEM;
+			/* the prologue ends with a copy of the first insn */
+			new_prog = bpf_insert_insns(env, 0, insn_buf, cnt - 1,
+						    BPF_INSERT_ENTRY);
+			if (IS_ERR(new_prog))
+				return PTR_ERR(new_prog);
 
 			env->prog = new_prog;
 			delta += cnt - 1;
@@ -981,9 +1012,6 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 		}
 	}
 
-	if (delta)
-		WARN_ON(adjust_jmp_off(env->prog, 0, delta));
-
 	if (bpf_prog_is_offloaded(env->prog->aux))
 		return 0;
 
@@ -996,29 +1024,20 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 
 		if (env->insn_aux_data[i + delta].nospec) {
 			WARN_ON_ONCE(env->insn_aux_data[i + delta].alu_state);
-			struct bpf_insn *patch = insn_buf;
 
-			*patch++ = BPF_ST_NOSPEC();
-			*patch = *insn;
-			ret = bpf_adj_moved_insn(patch++, 1);
-			if (ret) {
-				verbose(env, "insn %d cannot be patched due to 16-bit range\n",
-					env->insn_aux_data[i + delta].orig_idx);
-				return ret;
-			}
-			cnt = patch - insn_buf;
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
+			new_prog = bpf_insert_insns(env, i + delta, &nospec, 1,
+						    BPF_INSERT_BEFORE);
+			if (IS_ERR(new_prog))
+				return PTR_ERR(new_prog);
 
-			delta    += cnt - 1;
+			delta    += 1;
 			env->prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
 			/* This can not be easily merged with the
 			 * nospec_result-case, because an insn may require a
 			 * nospec before and after itself. Therefore also do not
 			 * 'continue' here but potentially apply further
-			 * patching to insn. *insn should equal patch[1] now.
+			 * patching to insn.
 			 */
 		}
 
@@ -1090,16 +1109,12 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			/* nospec_result is only used to mitigate Spectre v4 and
 			 * to limit verification-time for Spectre v1.
 			 */
-			struct bpf_insn *patch = insn_buf;
-
-			*patch++ = *insn;
-			*patch++ = BPF_ST_NOSPEC();
-			cnt = patch - insn_buf;
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
+			new_prog = bpf_insert_insns(env, i + delta, &nospec, 1,
+						    BPF_INSERT_AFTER);
+			if (IS_ERR(new_prog))
+				return PTR_ERR(new_prog);
 
-			delta    += cnt - 1;
+			delta    += 1;
 			env->prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
 			continue;
@@ -2192,23 +2207,20 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 
 			/*
 			 * We are *skipping* first half of ld_imm64 insn
-			 * with 'i++;', patching over second half of it
-			 * with that same half + mov64_percpu_reg insn.
-			 * All because bpf_patch_insn_data() can only
-			 * replace one 8-byte insn, which does not work
-			 * well for ld_imm64 insn.
+			 * with 'i++;', to insert the mov64_percpu_reg insn
+			 * behind the second half of it.
 			 */
 
-			insn_buf[0] = insn[1];
-			insn_buf[1] = BPF_MOV64_PERCPU_REG(insn->dst_reg, insn->dst_reg);
-			cnt = 2;
+			insn_buf[0] = BPF_MOV64_PERCPU_REG(insn->dst_reg, insn->dst_reg);
+			cnt = 1;
 
 			i++;
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
+			new_prog = bpf_insert_insns(env, i + delta, insn_buf, cnt,
+						    BPF_INSERT_AFTER);
+			if (IS_ERR(new_prog))
+				return PTR_ERR(new_prog);
 
-			delta    += cnt - 1;
+			delta    += cnt;
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
 			goto next_insn;
@@ -2818,28 +2830,12 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, -stack_depth,
 						     BPF_MAX_LOOPS);
 		}
-		/* Copy first actual insn to preserve it */
-		insn_buf[cnt] = env->prog->insnsi[subprog_start];
-		ret = bpf_adj_moved_insn(&insn_buf[cnt], cnt);
-		if (ret) {
-			verbose(env, "insn %d cannot be patched due to 16-bit range\n",
-				env->insn_aux_data[subprog_start].orig_idx);
-			return ret;
-		}
-		cnt++;
 
-		new_prog = __bpf_patch_insn_data(env, subprog_start, insn_buf, cnt,
-						 BPF_PATCH_MOVE_TARGET);
-		if (!new_prog)
-			return -ENOMEM;
+		new_prog = bpf_insert_insns(env, subprog_start, insn_buf, cnt,
+					    BPF_INSERT_ENTRY);
+		if (IS_ERR(new_prog))
+			return PTR_ERR(new_prog);
 		env->prog = prog = new_prog;
-		/*
-		 * If may_goto is a first insn of a prog there could be a jmp
-		 * insn that points to it, hence adjust all such jmps to point
-		 * to insn after BPF_ST that inits may_goto count.
-		 * Adjustment will succeed because bpf_patch_insn_data() didn't fail.
-		 */
-		WARN_ON(adjust_jmp_off(env->prog, subprog_start, cnt - 1));
 	}
 
 	/* Since poke tab is now finalized, publish aux to tracker. */
-- 
2.56.1

