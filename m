Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7DB332EDE
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 21:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788472084; cv=none; b=bx+2Vlc12tqZql/PN2G/iZt5eMkxYj0TU612abIkfZKbtRKhdB079p5vkcWD1vaFvvfOr83QNrzh7t0/eKpAfdtUuQR7OnUjzPxoE++qzEJugkeknO3rwFKwGodBDRXHC90DtkiTaDktYEpEpihkyP/PMXlKgxQju6xdD2B6tOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788472084; c=relaxed/simple;
	bh=xrGev7HfpiJKJhNhMvv1hFUHxfo/+xYAxxZ8TwoEtiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENlMb/Mj2zlMFScBh851WwTVxVHcxxZXrL9lnoP4jxU0ZjtloCFK6L/JYRCG0Vsd6FqToz2ADFNDWiofsGoiOzKGV+vQSkYLCxd1LWm0oX6nJ/esl8TrHdY+4OwP3qYo4wOsM03Ac15/upuGHfkC/U8qjlG6Vsv5TTqiRbvlPyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcKF56TF; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcKF56TF"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495501e57beso1082635e9.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 14:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788472081; x=1789076881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/3BZwnHLc8pK/e8UfZHeaS93dQlbxhtA1fIAiO9PhJA=;
        b=NcKF56TF3+ZXPyC7S4D2/PbvkF/OPC7ABFHOq+B9GkyS8xg96te81UXqZcZdbUcQA6
         oknaFxBX1HwTjES54Ysd/4v8fa/iOuTbIEKjUluFFc/KlxQ9v0m44XpeFofw3sKONK+H
         4eX3XarT8MMunKxLGSVIrgIhJWcLHvoqIrq+KUCh9SY20VwEtEtEx46WtUYMQxha8JGg
         Ng1Sx0J3wbjw5sK9HeJ2t8bhkx9nVqpajI1PfMYDTIUYDCTGI+Ut9pCyf1UTiiSHL9uw
         9060eyMXEjNz/705p7mkkUVjbAREIvuu3jaWnn1tqni16SYwG091jqkFEeR5BpuUXcFV
         fJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788472081; x=1789076881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/3BZwnHLc8pK/e8UfZHeaS93dQlbxhtA1fIAiO9PhJA=;
        b=O4zy/N47IC613vqdGPnFOx1IbkmAuaS4BSc84EmhhN/LmqrQxdCFabkJyGeAPuXEki
         z7gDIIy3CnIXwm7SxA+MXBa29zdN+kncPuM3odEXBtF9EkpIe0iHoMrWdl0D3yiVezWh
         /d2cKxDadKIi/eAlWBmhLkGbMfEDFTThamxpNHyIWideK2TLLVGh+bD2YYcKQAdZms5G
         4IOn+oVgFT+wZfsLMz57aZ9nMR5b/IZYTJfwx0HLC78g7ZS18adyn08XtX2Pwzjm2vHU
         BqFJcNEuf2+E7VnJQlIxE040YoxVYSFog1ZN8BIR2tpQ8Ijeo71QHpuEh9q1/Lmh7sFe
         63rw==
X-Gm-Message-State: AFuF++lLMuTiZ/zcwyVP+M2Eggx3Lw4ubMxN8DchkQZ9nixa1ggvnRhO
	VDZ5BqiSuMY/ihOdJ2xGnuXrFyMtCby/WuBLA5k7nbNBMZS1XVl3GbKTkGx8iaXS
X-Gm-Gg: AYBFou0WQICZWeTnJy3nMFulpDyutXyryKeLHwAmgYj99JaDHwjnzu2P2BM6DjLkQDA
	iScf+Mzga8w0aA7VaQRBjZpLhilc23wAeFsDYvAVXkzmKw5gkJOD3pS1wpCwLM29BAGQYPvs7ly
	VXOygSmZ6opJCJtgPvPDXVMEGluyrm0WD3GL4nvU5fEcBdNM4g60WlIy27Jmy4DFiG3qbCz+CQN
	iILvnHLekqciGifnWS8aAgfcay9wI/YZwBbzSPj+Q+RCvukgDjb8qTcJgLvZv/QwzLeBt7Sre6n
	aGaQAtAfxmJ7eIFMdswkHQIg1BZMUG3BBIWBO9bDM5bXFW9qAn3dZxXQ6ixEq2v93NDhy8rT8D/
	wxJOKbszvIoJmynRjiCUYjMiLpYQRlOzLaEd6nu+7f0h5Y6aMwwl5zY5ktCjV9p8KDTFgFVECyI
	QoX+bkoszTiQSqNDIFyO/8sc1o3iuqUArvYgqekocYQzW9kLTl/g0oGkektaSAEyFxm2Lz7piLA
	sG5tuK4OxEF50KM2VBupAQl6KdxpuiVMOLuzeIhihpAJGr2uJoWMEh7xTngUR+KSNGzxp8nA4cJ
	1wzCR7xc4+pTBJmVBQoFJe7qda8=
X-Received: by 2002:a05:6000:41cb:b0:484:4880:449d with SMTP id ffacd0b85a97d-4858703f685mr3928574f8f.3.1788472080919;
        Thu, 03 Sep 2026 14:48:00 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883be361sm1440022f8f.22.2026.09.03.14.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 14:48:00 -0700 (PDT)
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
Subject: [PATCH bpf v1 1/8] bpf: Check ancestor frames for rbtree callbacks
Date: Thu,  3 Sep 2026 23:47:47 +0200
Message-ID: <20260903214758.2727663-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903214758.2727663-1-memxor@gmail.com>
References: <20260903214758.2727663-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2864; i=memxor@gmail.com; h=from:subject; bh=xrGev7HfpiJKJhNhMvv1hFUHxfo/+xYAxxZ8TwoEtiE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvma+Y2p4jU6GbLBbyJSkElz/6Zft4XtE6h2mP7V72bS d5Lyrs6SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJGH8owMk5nesSlEnOqqrX1W V2jVcPKa9+awuM9T1keaHkxe3fTegZFh9lLzFZefnr79y1d3Ok/74bNPtN/J+W68Gbs85MrxtEm dHAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

bpf_rbtree_add() invokes its comparator while the caller holds the root
lock. The native insertion code retains raw parent and link pointers across
the callback, so the verifier prohibits unlocking, consuming tree nodes,
or changing RCU state from that callback.

in_rbtree_lock_required_cb() only checks the innermost verifier frame.
Static subprogram calls are permitted while holding a spin lock, and such a
call pushes a frame without in_callback_fn set. Consequently, all callback
restrictions disappear in the nested frame. The subprogram can unlock the
tree, remove and drop the node being compared, then relock. Native insertion
resumes with the stale parent pointer and links freed memory into the tree.

Walk all active frames for the rbtree callback instead. Benign static
subprograms remain permitted, while callback restrictions follow execution
into nested frames.

Fixes: a44b1334aadd ("bpf: Allow calling static subprogs while holding a bpf_spin_lock")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 32d31fa67036..26139fa09f12 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10235,9 +10235,10 @@ static void account_current_path(struct bpf_verifier_env *env)
 					frame ? state->frame[frame - 1] : NULL);
 }
 
-/* Are we currently verifying the callback for a rbtree helper that must
- * be called with lock held? If so, no need to complain about unreleased
- * lock
+/*
+ * Are we currently verifying the callback for an rbtree kfunc that must
+ * be called with a lock held, or one of that callback's subprogs? If so,
+ * no need to complain about an unreleased lock.
  */
 static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env)
 {
@@ -10245,17 +10246,19 @@ static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env)
 	struct bpf_insn *insn = env->prog->insnsi;
 	struct bpf_func_state *callee;
 	int kfunc_btf_id;
+	u32 frame;
 
-	if (!state->curframe)
-		return false;
-
-	callee = state->frame[state->curframe];
+	for (frame = state->curframe; frame; frame--) {
+		callee = state->frame[frame];
+		if (!callee->in_callback_fn)
+			continue;
 
-	if (!callee->in_callback_fn)
-		return false;
+		kfunc_btf_id = insn[callee->callsite].imm;
+		if (is_rbtree_lock_required_kfunc(kfunc_btf_id))
+			return true;
+	}
 
-	kfunc_btf_id = insn[callee->callsite].imm;
-	return is_rbtree_lock_required_kfunc(kfunc_btf_id);
+	return false;
 }
 
 static bool retval_range_within(struct bpf_retval_range range, const struct bpf_reg_state *reg)
-- 
2.53.0

