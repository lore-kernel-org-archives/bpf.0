Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9FD4AD4A8
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358777; cv=none; b=CObuGGa4IqjpBNuUr+ZxDmXSSRUpfyaAViXX05sM57MerJ8/u6GftXCuySqme+EbsyXjOKjQuoUfPqqkcSGLcaiB9zgaMnZ+sE/uDzLFRx/6Bh6BDUNBvGZvg7of7hr5ZvuGl44YmrJ/3QnU3qGAtomEDMiOU35BbyIQF0h9v5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358777; c=relaxed/simple;
	bh=dhTqFVBNfg5qowKu+9HybHWdngaGAKQin2zsMAYGsLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cX/WU6uy+7wI7mwRPLMv2sS8Kx2n6ACMxMZS/2adgfxBjoOlzC29HYAY2ypIRYzhs9BPNcf1c3OVQpSxwAcOPBks8+MtUf790+iDQKMhIBQJMdJ2TMaOu0y2kJcBfeGW5ltueOdp3Y+NAa74YLKf9Jlr/vG1eZDMBPfbgcj3Rus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=D7uO2uVA; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="D7uO2uVA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=px+Mby0PtaK48i7m1ZxRTCsrQXHyaZdzB8sQCB9jwwI=; b=D7uO2uVAKpDJSrOc8qug3qWBQr
	i0j1Z+U7PtW0hhLzPVYXj4X7H9uUasmw6VRYiYGrHtgOdGu2N5YEwUygX1ND/kigP5OASaV/d3X3V
	3JGg709VnkQPxjzV/p15kw/jdtBe/GR4cMCx5x5PhFsSENESnEESLcQ4AK6g/M1o6uwGGENApEfh6
	XfVsc+uGPqNrL/x2iLl+FEX9bmSYo0vnw5BNvJaqoAuuOzNmBaaiMVByth7Yy1uiT+JWx5BiwLbC4
	Q58xbBjtFakOZbvMvPHZaxZi9CGOlHhYU0UWO84unGHn8mnWjT/HUtwZOU17g29DoJA5+9r2Y3JQH
	ghDKCMuA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xAA6J-000Jjq-32;
	Fri, 25 Sep 2026 19:52:48 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: eddyz87@gmail.com,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 04/16] bpf: Leave out the hidden exit edge of a subprogram without an exit
Date: Fri, 25 Sep 2026 19:52:31 +0200
Message-ID: <20260925175244.1136329-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925175244.1136329-1-daniel@iogearbox.net>
References: <20260925175244.1136329-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28134/Fri Sep 25 08:25:58 2026)

visit_abnormal_return_insn() gives tail_call and ld_{abs,ind} insns a
second successor, the exit_idx of their subprogram, so that the hidden
exit from the subprogram is part of the CFG. check_subprogs() only
assigns exit_idx when it walks over a BPF_EXIT, and a subprogram whose
last insn jumps back into itself never has one, so exit_idx stays zero
and the edge points at insn 0 of the program:

  0: r0 = 0
  1: r0 = *(u8 *)skb[0]
  2: goto -2

For a subprogram other than main, update_insn() then reads the liveness
masks at a negative relative index. Such a subprogram can still load
when it leaves through a bpf_throw(), so mark exit_idx as unset in that
case and leave the hidden edge out, as there is no exit for it to reach.

Fixes: e40f5a6bf88a ("bpf: correct stack liveness for tail calls")
Fixes: ee861486e377 ("bpf: Fix ld_{abs,ind} failure path analysis in subprogs")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/bpf_verifier.h |  6 +++++-
 kernel/bpf/cfg.c             | 10 +++++++---
 kernel/bpf/verifier.c        |  1 +
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 67363c25526d..0b224498d307 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -815,7 +815,11 @@ struct bpf_subprog_info {
 	u32 start; /* insn idx of function entry point */
 	u32 linfo_idx; /* The idx to the main_prog->aux->linfo */
 	u32 postorder_start; /* The idx to the env->cfg.insn_postorder */
-	u32 exit_idx; /* Index of one of the BPF_EXIT instructions in this subprogram */
+	/*
+	 * Index of one of the BPF_EXIT instructions in this subprogram, or
+	 * U32_MAX when it has none.
+	 */
+	u32 exit_idx;
 	u16 stack_depth; /* max. stack depth used by this function */
 	u16 stack_extra;
 	u32 insns_total;
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 69e484b25b59..f3f545c53264 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -515,17 +515,21 @@ static int visit_abnormal_return_insn(struct bpf_verifier_env *env, int t)
 {
 	struct bpf_subprog_info *subprog;
 	struct bpf_iarray *jt;
+	u32 n;
 
 	if (env->insn_aux_data[t].jt)
 		return 0;
 
-	jt = bpf_iarray_realloc(NULL, 2);
+	/* A subprogram without an exit has no hidden exit edge to take. */
+	subprog = bpf_find_containing_subprog(env, t);
+	n = subprog->exit_idx == U32_MAX ? 1 : 2;
+	jt = bpf_iarray_realloc(NULL, n);
 	if (!jt)
 		return -ENOMEM;
 
-	subprog = bpf_find_containing_subprog(env, t);
 	jt->items[0] = t + 1;
-	jt->items[1] = subprog->exit_idx;
+	if (n == 2)
+		jt->items[1] = subprog->exit_idx;
 	env->insn_aux_data[t].jt = jt;
 	return 0;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c495dc9070de..015909fe6843 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2470,6 +2470,7 @@ static int add_subprog(struct bpf_verifier_env *env, int off)
 		return -E2BIG;
 	}
 	/* determine subprog starts. The end is one before the next starts */
+	env->subprog_info[env->subprog_cnt].exit_idx = U32_MAX;
 	env->subprog_info[env->subprog_cnt++].start = off;
 	sort(env->subprog_info, env->subprog_cnt,
 	     sizeof(env->subprog_info[0]), cmp_subprogs, NULL);
-- 
2.43.0

