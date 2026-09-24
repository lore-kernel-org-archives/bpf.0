Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01C63DFC8A
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269613; cv=none; b=dwHXU8gbJKee5xQoLrojIXx5TzKkM/W3bfNh9xabT9Be5QuBRYQSHYk1EjVXvDNXEYqDaIpWCo0Ah6KyytiSrh/1Atxka/nkX9FrrhjaBhdpRzK5Esm2aw7WlHgcfTpt135R4AL4/ySAWd2nU6GUfTp+Yo4rSKyYtGeIdFl0FGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269613; c=relaxed/simple;
	bh=yKZW5tGrHD7oxdBBUBC/Pru7acNA+iNdHgp2ZBONH4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnAMU2L3vEtWaQjoVs6QE1C5bVkwWv4IDlU8VRvZZ9MIE4qSRMUIjk7XSwNK0kwABSJo19DaubRhZf1kVrZ7RsSSns239Q2gxadyILitM/jLd2UQ5351HIttudvZOxMDYW9GUJ9RLZz3SEmCsq/m+vaS4GbCtrdPk2zTFEYrHaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pGoz0Mqc; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGoz0Mqc"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49e78a58e17so332235e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790269610; x=1790874410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XiQOd3DCyEO8dalhQ5FSKS1yxHMMnZol5+5wGc4F+7A=;
        b=pGoz0MqcV0o96aDPuA/QghqbMpAH0RWXgorhCga9JbdfSfFMhpbFkUETA7fVOUDr2o
         papxf/9kwUkYYUfxnR97gtk1cjIlHp6mqt6FekzQYlYqmEsaHN1VxNKhXSt8l38HRLeD
         s4wMOl4hU4ybjdg5iTAlOBsLk5RDLB+dWL71qFOX+1BjvrXsVkFbXuCrZImW8Eb+z68F
         6GN343UNpVXEV7JAT62yWTYPcinzcJepPMOl8dJY6KldTQgb/Hx8yRWoQ0TZO6/wL4Sr
         O70A8CbcpG0IquWnq2xxA5aOW+aTnTkFERFCfVP++MVrH2NahNeYVh8uPmIlKiKZf079
         uAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269610; x=1790874410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XiQOd3DCyEO8dalhQ5FSKS1yxHMMnZol5+5wGc4F+7A=;
        b=fomc8DmLhMwD5JcCIxMCCCpB+aJsnKgnTSeYwg8BiHoh9+h39E5c8Aacnwt4hZEaXI
         XGnQGlJg56Up3vjo6Ds2mGWeb3z7qu6VnYGr5gcGJV/7ivHIQmgBxSAm3xyoAveUpcer
         Sm2o5Ir9uIOsZpKWNvrofALsapQCmPg4v6Oe0z4oUp+fnifnuZE6EWSEHOws8nywjsq0
         p+6aFefs/IzfK0F2LofXlSOa5v0+9eLrnfnb5Tu9PCP2n204CCrCM7eZ7hSU2X6I/qDv
         wjXa/U4JVaGK7eqzkuG4lcyg5DpM1dBO+TPj1rSCOfDA/nTxFzICKanqCKNsJUBkO6Rl
         rQDQ==
X-Gm-Message-State: AFuF++l682ON8SDuXYzI0c1xFjHow8AYHyRiWdYaESz2OKU9Foo9R6Ed
	N3AQ8UpOMSCnEWP1FMkR1cyDSBDWCoxLrslAsc4ayD3/CyLA2BYRsCmaK+6L+WvB
X-Gm-Gg: AYBFou007IIrX/gnDo5yVleCdAASCfOAgOYZHQx4KLNCnzRvyPtRLPoa9Sy7vftlspr
	q8imkqsAYTFs+WodE1LgNvsFZRF9NtPbZSU8xF/2zSJ6PXRU0bibLftL6a6Rjy/5/NLIQ9ihB1y
	pn6jSHRffiDJiGLXL8JcQoVi05AJfbnG5QmkcgKfiy+XCbYTMhN/BsOabWhpexW4rtH/1VqJXQx
	FAzouAC8gS7QjpOIFvYVHvt9j0bwzB4/S7inOhK37utx24tV19CxIDnBcGBvtntQE4QAdh1cGif
	WCoIhBpzJzprMm3pzHG3gu3ttMEt5ODu0sioLzT8H2D3kkchEapI5h6tAx43nNNKQNHAP+Vs5pw
	Sh+axPEobw9uM8wNYQrn/epxtyk4R/X3cHuiNpLT/XWeBCn1P850HOsXZMYJkv3Ts7KccmSYemG
	KiEG7c3AUUDjmVbgVvtQxRqu/wM6leryiUlxdYOMJVQMRycpwYy9zAU9MxhyDFg2ecu8eQe3ryH
	uHOitG9+WaPp0rhxW9eACnbhYElaEvD2W+/Itj06AKtGpCVsBRLWHvXmkZzMpGsI2lI76IkJidu
	aWrpQllBdpNX2Tb/XvB9NBlGw3PsRt6frEEk6Q==
X-Received: by 2002:a05:600c:198b:b0:49c:edd8:ba35 with SMTP id 5b1f17b1804b1-49fe66ca13dmr53125115e9.6.1790269609654;
        Thu, 24 Sep 2026 10:06:49 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a3627a8sm574753f8f.23.2026.09.24.10.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:06:49 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 1/7] bpf: Correct verifier diagnostic attribution for stack reads
Date: Thu, 24 Sep 2026 19:06:35 +0200
Message-ID: <20260924170646.2366016-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924170646.2366016-1-memxor@gmail.com>
References: <20260924170646.2366016-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6096; i=memxor@gmail.com; h=from:subject; bh=yKZW5tGrHD7oxdBBUBC/Pru7acNA+iNdHgp2ZBONH4s=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtrRJGzSNe6P3+OiN1/tiGvmf9xdr+GeLKRPv80hchXP fLf6+52lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCJFKxkZ/u6bzH3ooH7EvY0z H6kmHkldcEEojfe6wKl4DrNfCY9vrGf478CZVvSl6f5cI5sdh4wnJh0+LnTWI+fmxJyciU0ibsY JDAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Verifier memory diagnostics currently label every fixed-offset stack
read rejected by check_stack_read_fixed_off() as uninitialized. Dynptr,
iterator, and IRQ-flag slots instead contain initialized
verifier-managed state, so the report incorrectly suggests
initialization or CAP_PERFMON.

The variable-offset read without a destination register is currently
reached by atomic read-modify-write instructions, but that follows from
the call sites rather than the check_stack_read() interface. Its
diagnostic also attributes the access to a helper.

Classify rejected stack reads by slot type. Retain the existing
uninitialized report for STACK_INVALID, and describe verifier-managed
slots as opaque state. Use instruction-neutral wording for the
variable-offset read while leaving the existing verifier messages
unchanged.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/bpf/20260815065956.49D2B1F000E9@smtp.kernel.org/
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 63 ++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4c20e5bf8b69..7fbe32ce9449 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3978,19 +3978,46 @@ static int mark_reg_stack_read(struct bpf_verifier_env *env,
 	return 0;
 }
 
-static void bpf_diag_stack_read_uninit(struct bpf_verifier_env *env, int off, int i,
-				       int size)
+static void bpf_diag_stack_read_invalid(struct bpf_verifier_env *env, int off, int i, int size,
+					enum bpf_stack_slot_type type)
 {
-	const char *reason;
+	const char *problem, *reason, *suggestion, *kind;
+
+	if (type == STACK_INVALID) {
+		reason = bpf_diag_fmt(
+			env, "This rejected read uses %d bytes at stack offset %d, but byte %d in that range is uninitialized on this path. "
+			"Programs loaded with CAP_PERFMON can be allowed to read uninitialized stack bytes, but this program is being rejected without that allowance.",
+			size, off, i);
+		bpf_diag_memory(
+			env, env->insn_idx, "uninitialized stack read", reason,
+			"Initialize every byte in the stack range before reading it, adjust the offset and size so the read covers only initialized bytes, "
+			"or load with CAP_PERFMON if uninitialized stack reads are intended.");
+		return;
+	}
 
-	reason = bpf_diag_fmt(env,
-			      "This rejected read uses %d bytes at stack offset %d, but byte %d in that range is uninitialized on this path. "
-		"Programs loaded with CAP_PERFMON can be allowed to read uninitialized stack bytes, but this program is being rejected without that allowance.",
-		size, off, i);
-	bpf_diag_memory(
-		env, env->insn_idx, "uninitialized stack read", reason,
-		"Initialize every byte in the stack range before reading it, adjust the offset and size so the read covers only initialized bytes, "
-		"or load with CAP_PERFMON if uninitialized stack reads are intended.");
+	switch (type) {
+	case STACK_DYNPTR:
+		kind = "dynptr";
+		suggestion = "Use dynptr helpers or kfuncs to access the object represented by the dynptr instead of reading the dynptr state directly.";
+		break;
+	case STACK_ITER:
+		kind = "iterator";
+		suggestion = "Use iterator kfuncs to advance or destroy the iterator instead of reading its state directly.";
+		break;
+	case STACK_IRQ_FLAG:
+		kind = "IRQ flag";
+		suggestion = "Pass the saved IRQ flag to the matching restore kfunc instead of reading its state directly.";
+		break;
+	default:
+		return;
+	}
+
+	problem = bpf_diag_fmt(env, "direct read of %s stack state", kind);
+	reason = bpf_diag_fmt(
+		env, "This rejected read uses %d bytes at stack offset %d, but byte %d in that range belongs to verifier-managed %s state. "
+		"This state has an opaque representation that BPF programs cannot read directly.",
+		size, off, i, kind);
+	bpf_diag_memory(env, env->insn_idx, problem, reason, suggestion);
 }
 
 /* Read the stack at 'off' and put the results into the register indicated by
@@ -4081,7 +4108,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 					} else {
 						verbose(env, "invalid read from stack off %d+%d size %d\n",
 							off, i, size);
-						bpf_diag_stack_read_uninit(env, off, i, size);
+						bpf_diag_stack_read_invalid(env, off, i, size, type);
 					}
 					return -EACCES;
 				}
@@ -4140,7 +4167,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 			} else {
 				verbose(env, "invalid read from stack off %d+%d size %d\n",
 					off, i, size);
-				bpf_diag_stack_read_uninit(env, off, i, size);
+				bpf_diag_stack_read_invalid(env, off, i, size, type);
 			}
 			return -EACCES;
 		}
@@ -4238,13 +4265,13 @@ static int check_stack_read(struct bpf_verifier_env *env,
 		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
 		verbose(env, "variable offset stack pointer cannot be passed into helper function; var_off=%s off=%d size=%d\n",
 			tn_buf, off, size);
-		reason = bpf_diag_fmt(env,
-				      "The helper would access the stack through variable offset %s plus fixed offset %d and size %d. "
-			"Helper stack memory arguments require a constant stack offset and a precise initialized range.",
+		reason = bpf_diag_fmt(
+			env, "The instruction would access the stack through variable offset %s plus fixed offset %d and size %d. "
+			"This stack access requires a constant stack offset and a precise initialized range.",
 			tn_buf, off, size);
 		bpf_diag_memory(
-			env, env->insn_idx, "variable stack access", reason,
-			"Use a fixed stack offset for helper memory arguments, or copy the needed bytes into a fixed stack slot first.");
+			env, env->insn_idx, "variable-offset stack access", reason,
+			"Use a fixed stack offset for the instruction, selecting the target stack slot on separate control-flow paths if necessary.");
 		return -EACCES;
 	}
 	/* Variable offset is prohibited for unprivileged mode for simplicity
-- 
2.53.0

