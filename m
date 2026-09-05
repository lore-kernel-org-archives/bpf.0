Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4D13BB690
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 07:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591634; cv=none; b=n6CsAvC24OWYhRt+T99BLJe2pY+FPOBuecZVsoBZh09V8hlNtg+1tAELugEE2K3Ytbb5uyH/KcSBeGOzlVK/pDd56ol7CGabg7MEa+k7uIPygslRE9jt8xBqtyngjWFNS3cdA9RJR/EwVpX0qlRjears80aajvNdSX6I/+uZmZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591634; c=relaxed/simple;
	bh=6bnWaGYBPIlPAJF4wCUhV0SkVqiCekIf4B3sWUrKHic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIwVznej/rwaHUuLxDAM0amIlpnnYGRvfNDKSrRRj5eH9JXQ7ZhoqltI96zqZLr7dgen/h0LoPGmtI1HTPLUxUJwp/4511rY6gP8MAWPtboOe2ZWyqQpjqfPAgD2tbwpC0FQOdWPqf80KFoPh2TnREd2oIsuzaLU8HeFVy2Sv/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q07SPght; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q07SPght"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49ccf0fbf41so7299835e9.0
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 00:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591612; x=1789196412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rd+Ay2xU3OpPm2PLYk+HfnkJqfAjwOwJmvSvxhVRUBQ=;
        b=q07SPghtUyVlDyDXveV98qMhLLkX/8VLMmRy+6pwoWtANg1J4fsW2xaT2RKuMoy+Un
         fCm9L53lSyGvfxBoW6Tl3MnJkBk56eFw+6GGnwSknyKmvkwp7r3IaTCkBFNfnJZK8MFH
         MiUz4PkkRRPhsVpLex3cKtloj3VSMhGhQN5cantn2OPKFsVvLSXUb8IECUEBGoaYVwJ6
         zg0YH+J6xtl3P9WJVNJnd7a3XMEepBGzjMbqgilWfR/MkqWPdyvD6155EZqM/IqOL5wn
         UjjVIiU0PBb0FLCaDca+jzGyQzw/syUPFI4CPF8z4X++/N7ztZs3UjJKPxYzW7r3SxQC
         FucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591612; x=1789196412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rd+Ay2xU3OpPm2PLYk+HfnkJqfAjwOwJmvSvxhVRUBQ=;
        b=FWTmVnKRJ6nHtqmI9ck5I7bJfDSfOsr1zr2cEgqIpoX+u1UwSpAJbU6gHCaO5zKMtn
         h48cjqJXedoflkwDkVlikQ8EPjiU9idPGn5G562Ogo2uUQBCdk7T4hR7qKGoviQ7bc/T
         hhWx5s0nqCGdeuDo5Cvf+oUxK03Qe2nu84J/7fbDjMtV9BEufY4xQbqOhpXtl84uZPF2
         umUjBWZzBuZk923sAHz5jckjIT5pctVLQdDkl7LIIyUYSGpnoyD4Hp9W3ZJvAQLbNtvf
         P/heLfz5H26zIkQX6E02z3oDnKBek0eSqHS0BNkLaDZ3TxC6zh5PgD7dpLJHSvBhfHtE
         cxJw==
X-Gm-Message-State: AFuF++noU3je1KnFK4V3Y02ZmrvFJaVtSjE5Oi04DDDUByqqBnXAj8Nu
	7XSEJoUw+cjCxVTXpkhbcrLRvUHM+f3fytW2SeEh2priNwcb8CocLaDL4rAArqQ1
X-Gm-Gg: AYBFou2pQOyNsMI5Re2sJ/8tNSkij9rObwxk3VSUXWklPfdeWdy28g3DPJeOEqR9iRS
	/K8Q/7JkYTwAybL3MBO44swe6qT61vsNvEumB1FHutXqUgxBYmYNgkqvx8C+t8BdW+lEFSGw437
	9YkOULTWgIgvQbroOP0Jb2aL7A7Nm5/jhH+u/CCIzVDw96Sv60kBuFkeylkcu2rLvTZ+rvGx8+K
	2CaKzd7A/7iPQ9H19sd9DfnsJzsZ9jg7FV+73odttbFmaSCegZM2v8KQY5OfpjXX6erJ4Ykl6mc
	9WqdIeR849jktBhEhmi5eV3SduLf9R/0kQHePJVgmM84kH5Piz4WZkbmqcaTewg5GtDVhYvnB/2
	mS4Vg/+/GEzwNu0RnpU+Nioh7HsZao3yAgQ2R+Ifu8JP0wpKa1I8GyiBceGyfUkdumXEtt16/mi
	oivyW493t26yeMyfbAinrYDHYvP3pJLFlh6pxTxKCsT+kW4E+QXwTg7na24LfWRcHwZyJHyBgE3
	xcxGVXo3fQnrg6aKARLQ4WkCv6dCxctekUBtBGz9GGQWJI/qoxuU182crgEc5zLYeabiuXnVCh9
	WLZeQHAgpzkY+Esv4Lq0sx8zhso=
X-Received: by 2002:a05:600c:3b17:b0:49c:fc6e:8cb1 with SMTP id 5b1f17b1804b1-49cfc6e8db3mr67454905e9.21.1788591612145;
        Sat, 05 Sep 2026 00:00:12 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588135600sm9758644f8f.2.2026.09.05.00.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 00:00:11 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 5/8] bpf: Reject fall-through across subprogram boundaries
Date: Sat,  5 Sep 2026 08:59:56 +0200
Message-ID: <20260905070003.3193366-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905070003.3193366-1-memxor@gmail.com>
References: <20260905070003.3193366-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2862; i=memxor@gmail.com; h=from:subject; bh=6bnWaGYBPIlPAJF4wCUhV0SkVqiCekIf4B3sWUrKHic=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv23mXiW6vPh1ptXeyj3aUqZsGRl78v/9OmebdeVIv96 NRnOuzfUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIlwyTIydEfOcv7z5KTnp4Nv Z35neRHrUrp0scuqZHmLaMfUdwFxXQx/Bd46ZrC/ZQl2FyzzWbyPd1mFzXlGk4PT/r3dlWtp+IK DGQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

check_subprogs() verifies that each subprogram ends in an exit or an
unconditional jump, preventing control flow from falling through into
the next subprogram. However, this check runs before CO-RE relocations
are applied.

When a relocation cannot be resolved, bpf_core_patch_insn() poisons its
target by replacing it with an invalid BPF_CALL. A relocation targeting
the terminal instruction of a non-final subprogram can therefore create
a fall-through edge into the next subprogram after the invariant was
checked.

The per-subprogram DFS in bpf_compute_postorder() then visits the next
subprogram twice and writes past its prog->len-sized postorder array.
Stack liveness analysis relies on the same containment and can access its
per-subprogram arrays out of bounds as well.

Reject fall-through edges whose endpoints belong to different
subprograms in push_insn(). This reestablishes the invariant on the final
instruction stream at the common CFG edge insertion point. Cross-subprog
pseudo-call edges remain valid because they are represented as branch
edges.

Fixes: efcda22aa541 ("bpf: compute instructions postorder per subprogram")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/cfg.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 842c7d1eabcc..e3c904328ede 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -102,6 +102,7 @@ enum {
  */
 static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
 {
+	struct bpf_subprog_info *subprog;
 	int *insn_stack = env->cfg.insn_stack;
 	int *insn_state = env->cfg.insn_state;
 
@@ -121,6 +122,26 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
 		return -EINVAL;
 	}
 
+	/*
+	 * check_subprogs() prevents control flow from falling through a
+	 * subprogram boundary, but runs before CO-RE relocations can rewrite an
+	 * instruction. Reestablish the invariant on the final instruction stream
+	 * before constructing the CFG used by later per-subprogram passes.
+	 */
+	if (e == FALLTHROUGH) {
+		subprog = bpf_find_containing_subprog(env, t);
+		if (w < subprog->start || w >= (subprog + 1)->start) {
+			verbose_linfo(env, t, "%d: ", t);
+			verbose(env, "fall-through out of subprog from insn %d to %d\n", t, w);
+			bpf_diag_program_structure(
+				env, t, "fall-through leaves subprogram",
+				"Keep fall-through control flow inside the current subprogram.",
+				"Instruction %d falls through to instruction %d outside its subprogram.",
+				t, w);
+			return -EINVAL;
+		}
+	}
+
 	if (e == BRANCH) {
 		/* mark branch target for state pruning */
 		mark_prune_point(env, w);
-- 
2.53.0

