Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B613E3D92
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242189; cv=none; b=TehaVL/mtEImmfwMlo5GSN68p/A5D/3JN+YKRa3K5jEsVMJa4pD795F9Ecx/WU9ojJIDOQlIXVOWGELaGmMLgljQeR1cLe1MAUoPxEA3J2DMzVMdK6DRJY8v4hSFbKpkFwYlbzIthssMGZpn/WbO8p767LC8nTso+vil7LLb3mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242189; c=relaxed/simple;
	bh=DxADR/Z3L79bnFJpantLa09fZvFM/nAApOZ8iWpOU2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5yGdm0jNj4eBknepbOinEBFudLGeayDT0yX3uBpGAOsIXWEchZdYYhCa3dIHIFUnODPyT0AZjTq5dnhSPhkOr2tc3j++qC0FPlchEyx4PVC076iFVnd18RHMCyB3HND6ZFtyK8HzDAJDCSE/YehGOStk61N/tmpB1UQwAvHXRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jT6RpnXd; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jT6RpnXd"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-488615e6cfcso294966f8f.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 02:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790242185; x=1790846985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cQMGBmafDls2avY0DjvYgDRcEpBYRvnA2el1XMvcYL8=;
        b=jT6RpnXdaXNnJC4jeAdFnDulPbUCfyIDOp0J3RHRU7dKlykUIco7uvnQnKBqKp1E2E
         hII2dWl/pmyKxgST8iRDxmrAcCwsdEJKfeZDlXX2fDFqN/hUcdRkjz16QSILtIVD4zLt
         B2ONfEmNIznC9PZOuFgrVue/qxhHeHLdua2FGD9sjLtW9nVqMC7EhgVBTbDEK8L713LA
         sG+Gu6dcf0HIQ6T5Sg64kb+A8SZCAhuXpKr7siPHDTDT6ilo/DREWgnftOvBSyDnz0nN
         qVnTmnd+XSJIM+mZJAOL338FlUS5EkAzXCWoHE+YZi4sQvX2GrR4k3+cqSM8Kih0zuqB
         j/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790242185; x=1790846985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cQMGBmafDls2avY0DjvYgDRcEpBYRvnA2el1XMvcYL8=;
        b=jQBmTJLXwoPQGuz9KIcxcsjiAbrJKbCmyBde6M9IClonQAQB4mGnPXVGwLtyE8pHxl
         IbvN+Wy5RSR2yldK/Bq2rSzfEoHhMADscgqhx0Tn8go/IgTnvTtyjLeHIqMH3dkj8UlL
         ODsjbpmqC/63W+lRXb9kZnEfCQ8CYRLcFTLNP7NKnKUfRNabBOLQ/81iFL5clcLZ27SL
         udr7TfEGPHh1surCzFkJjUjyke7Y/C0braW9F68MwJF8VkyU53rQwX1vtvW1Unt1yPU6
         jLfh5eVOktoihNJLaHV2b5RnjBUARFBdx2nz4cwW3Z4n3MQIa6B6HzTyFuj6WOOa5H32
         PNAA==
X-Gm-Message-State: AFuF++k29Y0nmv9d/3ILFe9NqlL5PpkYrL3kqoTONtxjCffMJd5K4HQB
	wqvPaIRUyfK9ugJDjyj3zKeod12XqKXhAvGEV4/5unRLK+7NdKfHzTalhvmRSXEK
X-Gm-Gg: AYBFou0wRJrN95j3sARDE6EiHT+1f7dOBID6Bpc4+yCu8WPxYhYXpNO2AKWaCGJW+nx
	zg+o/hY9nN7fW0Mq8wX+GBmOUUPsbzufhA7TYMAAiXTtGQ77ysYuh41zoktTAJU0a5oN1ONTnDm
	e73Rl1nEZ3uER03U9ytGlchuqSFWL5E2OhmSxSx4RCztzZGOz8z5qlhEVKo9QqD9ivVLEovLX6i
	s3Bg9dTEHXO5tRKCIE0CJsYvCUBajxoxQKHc/sxVw35xgi1P8kV80rcd6WaWn3y3s5HG2t+EfZ+
	Yx5VGUUoTFASFay+GWrvd9BI+5joDx9Ts8nBgEutdq0UXWCaGHTmzwnIWsxE1KLjj2hU+9HiasA
	j1mSjW9GDVkmIdfs0iTZBxCazKQpI+tff7xCl1DycCS8phQGWWRD1cdjLd8/p4VX50t4UitDf+h
	9JkH5XJhMSSV0ZotaKXG4/nvZ/4lIC8rlrRU/REICdKmeaskyemIG1mv/p20elQGGA8MQlSFuIC
	zGQZcpPdA2fXK08FyNi6Zm1gDhgGa1ffmBhdpx7yzLItqsGeSaY2831qSO06UrQAZnhNB8um5XI
	n+UAzCwmPWjSmUPS//BcCJLfoomIEgpISuqunw==
X-Received: by 2002:a05:600c:c101:b0:49d:27ee:79c9 with SMTP id 5b1f17b1804b1-49fe66d63fcmr25730265e9.8.1790242184831;
        Thu, 24 Sep 2026 02:29:44 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886848646dsm12080535f8f.10.2026.09.24.02.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 02:29:44 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/7] bpf: Correct verifier diagnostic attribution for stack reads
Date: Thu, 24 Sep 2026 11:29:30 +0200
Message-ID: <20260924092941.3174809-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924092941.3174809-1-memxor@gmail.com>
References: <20260924092941.3174809-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6096; i=memxor@gmail.com; h=from:subject; bh=DxADR/Z3L79bnFJpantLa09fZvFM/nAApOZ8iWpOU2A=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvL2+zODRN3sx6bP/v4ma4nPx+0fm28kFyR1G9e9n3vJ 5fWf+c7OkpZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCRm6qMDJdSdFseV1xao5y+ WvXf22e6b5vnmbduk3i18lxsRuTZju+MDJuvTJ+f782V+e0At/T7KUxmk/q5C3eenvy6YIGE3MW yRFYA
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
index fec5a1ae6a4d..dbb3153fe1b5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3975,19 +3975,46 @@ static int mark_reg_stack_read(struct bpf_verifier_env *env,
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
@@ -4079,7 +4106,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 					} else {
 						verbose(env, "invalid read from stack off %d+%d size %d\n",
 							off, i, size);
-						bpf_diag_stack_read_uninit(env, off, i, size);
+						bpf_diag_stack_read_invalid(env, off, i, size, type);
 					}
 					return -EACCES;
 				}
@@ -4138,7 +4165,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 			} else {
 				verbose(env, "invalid read from stack off %d+%d size %d\n",
 					off, i, size);
-				bpf_diag_stack_read_uninit(env, off, i, size);
+				bpf_diag_stack_read_invalid(env, off, i, size, type);
 			}
 			return -EACCES;
 		}
@@ -4237,13 +4264,13 @@ static int check_stack_read(struct bpf_verifier_env *env,
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

