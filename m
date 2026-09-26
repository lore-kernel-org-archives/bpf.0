Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE0447884F
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432457; cv=none; b=PtILivS3iUnXJ1jOUzda9nwKnTWfEadgObxWluWnGHD0G1lP+yhMYXizbD09U2+YoYePx6OJaV9Hf4qaxe+gmLmHxXOK6e1JNBBnTQlf7pFRrkbNSwcqBrhYnTPZLzIzdhzxqeDqtvFVNxYfhMl/4jVsdPtVpXqS0hcwu6ZWIEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432457; c=relaxed/simple;
	bh=H67jLIPu6f+sQ5QSsRX28HjQlv3c5aiI3KOD894jCdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3MGFaTnBLYnAx4eH/0Tc+RTsBEWIyxpKDnabTStX/wFONfdRrJTP6G3xGrk56oFH2AAR6aK3iVhKZdBb9rP6H4eFjsll6RczU/DDRWLt8qz9lSmwPEpZGje+CyLun8d/z34EuSG9NEvI9ofT6akGch8tAiRGZsZKcfN/LJtRyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3myPCWe; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3myPCWe"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0df0bb2d6so303554a91.3
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432455; x=1791037255; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=emwBwB833yl+6qjNTN0VJe4uMR9DfSw9VXzBPJaYQsI=;
        b=P3myPCWeeeJ42nxpTo3TXJIJNhoMcoSFcjdj7hjPQ1nv73UKtlKYfOF1V1NJ4NRr0x
         FiSGElKbe+c/rWHJOLOAgzeKPC9Dgy4A++oY1mm52vuxYHI/LEKjm56zuiVrObfFys42
         PLMo6XWDqCyCDdZAG7QYus+0UTqX5Kid6xDEDYUEJ8ERsLk69WHSgncaqbDrSKHpUali
         TMby5NEb0lFZKz5oRqxho1UX7yAQdhJ+KDKokK5v2mU/w9kdxkx9OPFLvmqGnJHNIL7g
         5XOmRe09E6AWLtOgYcI0UYdxuFKvnexhoZjHX1oSGLrb4pq1vqNXmCeB59Q/kq9JT274
         WitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432455; x=1791037255;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=emwBwB833yl+6qjNTN0VJe4uMR9DfSw9VXzBPJaYQsI=;
        b=aJVDo8IQGc78FfhV7TjFfIIktruTr3zwR2eFTWvT2EypE7f2g2vQKKfMAvI21ypnbB
         JLp75quBTK5/J0LtgkJgCpYuFBoZPd0a4jNGSZVhF0tmuOiqB2cUlEpTcjlW1rek+W0H
         PhKJBPc4O4jPHhw2zH2glpt+jNXxCYfPzLqGX/rqMYQvNjrniaQZznk/0wzdACFZ0s0t
         0avK28Mv2/9cUUHGbBs0AjCT20q+eVGb456EZ576oinhHd+dtklsu6L+GhEkPIFwVbGd
         t4s+MYz0NLmhfRADOBxWCViywJ1fnax8OmqbK8PWw3qeQvZOzyzuoOEBgVLRbdCASiq4
         dtaQ==
X-Gm-Message-State: AFq9FYJH9I/e+87Vo1aACtHgtnT/f3p1tiv/4Fni+08bWtQHCk1xyjZT
	INnEV5VUc9OoqnF2HaPBOTOMTAR7KAfp8s1PKgOQP+5u82TsAVIj9pZ67N7ZacS7U44=
X-Gm-Gg: AYBFou1Bd85zDMOG0Hz3PRc+4IQqImbX0rDdcES5ewNq9RjMADKbzsVRvb6JRmgCoyT
	g629ZJASByRgg76jW6HhzBAW0QmmAbiWdXONetLEYspU/gDKDTkq6XPvXrBrxrZyWOpAZujFnwF
	CfEs0YaVUnT3pXNsZVQ/l8FS66E+bvXWehwYFclTZHVSa/kAPl7JqYIfVF3/GhFGgiM/KRZsVKi
	Kjzy9Wf/rElALf6RzJTlYGPfHmW0IdoN0GX/c71H3iaLdGuU+paxaK67xxQHcor3BspakZaclw3
	1xsBWD9oaNOf+FWWuyNro3xvjaup3i4dbzRL+HYY2mJooNfxjz92PWilOhjhFo3XmoF2cHSdcBK
	A+iZ5g2fpTrByg53choUrQZTdikQaP2htejGlQLgztODWUXe7zcq+LdkhGrMr9aTq56s5EvfpYP
	DPJHRRnMZojoyQuxbi/CbsI0xRFL8pRy4e8uoYV1Z62/WnP3LDV80/X1yc/BeLmgfbtqvoJfK7f
	js2INWajJXn4mQFx2oAZc239KwHDAI0RenN7A/LKA==
X-Received: by 2002:a17:90b:1c89:b0:3a0:ace4:d2b4 with SMTP id 98e67ed59e1d1-3a0ace4d752mr4982889a91.23.1790432455517;
        Sat, 26 Sep 2026 07:20:55 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:20:55 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 09/36] bpf: add bpf_set_reg_range()
Date: Sat, 26 Sep 2026 07:20:07 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-9-c8e5ab5ba79f@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

A utility function for setting a register's range and step information.
Used by SCEV widening and clamping logic further in the series.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/verifier.c        | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b6cfac01ef3f..94c0dddaaaa7 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1745,6 +1745,8 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env,
 				 struct bpf_insn *insn, int arg,
 				 int insn_idx);
 int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env);
+int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+		      struct cnum64 range, u16 step);
 
 int bpf_stack_liveness_init(struct bpf_verifier_env *env);
 void bpf_stack_liveness_free(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03dbc0e00398..f2d44e026e4b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16934,6 +16934,18 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	return 0;
 }
 
+int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+		      struct cnum64 range, u16 step)
+{
+	reg->r64 = range;
+	reg->r32 = CNUM32_UNBOUNDED;
+	reg->step = step;
+	reg->base = imod(cnum64_smin(range), step);
+	reg->var_off = tnum_unknown;
+	reg_bounds_sync(reg); /* this should infer the tnum alignment */
+	return reg_bounds_sanity_check(env, reg, "bpf_set_reg_range");
+}
+
 /* check validity of 32-bit and 64-bit arithmetic operations */
 static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {

-- 
2.55.0
