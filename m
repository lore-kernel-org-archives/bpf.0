Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F1E3932C3
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 01:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786845472; cv=none; b=jgVelkgQBGBCK5xmguiNhMftYISRZw3zMxOk9uN6wS/PYrRFTgJFeVonvg0ElcpB2kSATQefzZddhMX9Db6OjVqYIAVnlWtDNbXKhnWpzJene1vU+gNa/E2JB9bxVDDeZRR/a1sWbG7zw3MRmXWEqtvmAPwTgcEzloPMmBTxYD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786845472; c=relaxed/simple;
	bh=hMipgugHg+2Fpezsdy5mPC6kk6+iLt09etL/3QuyDe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ipv3WPbofvI9wfkJ7bK5BQtrgzPcEJIRKb+tXvb6BS7iaTfH4SAD3qaDYawynsLtte40Q9PY8hgFlMLsgcpxo38Sq7Az2pMaxzXGMn6mScO9tWR7QkybBwWl9ZmlJtuOfFg+sCka0m9cugwscO0EP4ws8O4DW/gHyzzYngmOZTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hfk9b42V; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hfk9b42V"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-4744516a312so266444f8f.1
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 18:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786845469; x=1787450269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bLUz8aI3LlDuvA1jh+wKmchgH4wZt3IFcgzEEbmgDd8=;
        b=Hfk9b42Venjr7/HQIrKD7HCffcWddNJRrw86u8aEvysSzGidsVfTJC4VPhVUU/ABj0
         8Jyh38+4DYeSaN5kw3d/TpL8cAtsec30GxWr2wmScXvAt7EMZcWx1TxXikgD/ZomiqBI
         sFHM+aDshIV64KaSh+++d4qny1vitGQRwOzfSlFpCwoYhHiuDqBerpezqrrIiP9vxA+g
         +zW88vnQ8GzWDHufn1siWtEYEN45f0oqH69ym6hUqKIeggqYfKwr5qhmN2y14JSeoIno
         KMU17HPFDsBEIwxQOjZplUcNuMNziJBMO0IKh+GCjaUP7KwZVHUtVsr+miHe5CwgQ3Q0
         R8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786845469; x=1787450269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bLUz8aI3LlDuvA1jh+wKmchgH4wZt3IFcgzEEbmgDd8=;
        b=cD4Or+9muAKqwnxyRIt7QnBqTNP78pHHK2+KJelzF5rFgF89NMNOlWG3HhJArvix0b
         kjjgXCeEsDbL4vsNZcqMP+qXSJXnxxjUWtszOTDO1vws4NntVfpci4GIh1GaUhqqRER6
         tLBBIZsNtjTjwD2fmr7gXE3H39LjFAoNkzuRA3C0cxfJeoveFpG/X9dGDjbQktnQIWlT
         uBjJnsod5bcrMoSm/qvlt24sswHENznMrmGO+7NCHvVOMrjGonaiZ4uFQD1bTxvuazU3
         YNEKwq4/kfcAlGl2j2HKG6r6t56lT8P5lptHyr/GaU8T8Y2taCmzzddlDrGWXjSfc/PB
         o6GA==
X-Gm-Message-State: AOJu0YyhJGoBJNJWLugwGnKueFTD6FxA4dP0T/6r1cR9+Gz3Xp+TlMir
	X5C9ZI/O+NbnZYzD6kNEBBGSub3nNYfnjhEo/w7HPmhEG3CjMGTPnFY/OR+x/h6G
X-Gm-Gg: AR+sD10enbHFhjRQzU+negH4xpH2f1duKiVDvFOx7M95OoOLuC62lt7jijsqBw92wHz
	Y1xOwLqPqGsFg3b26WB5ZA1kPbzt5j0fX9cKxvPksGTn6l8DA0HFBMRuk0YiT3tcj7m3r1MRgrf
	chi46f9ZQr1OYbdTbEWdszzpzyM1EwzPb2wTafNRQE3SGVYzY6oE0nCPCasWQVNEn4Zi1TH8hpo
	Kbl9RpAUWyr0NNaZn1g//xiMcu8fY7Ft5q1TtuVNjKHa7W8+dgb5wOKjw40gbjnUOehO3cqvOIX
	Mm2hRu/PgJjnUuyv8uvW8n8KZzTKM23Qnm+FnqfPqtFS19xt14YObWfNsc0VQcuSrl1GfZ3zLvN
	2DYCVupghnfZXg3LtwSiNJw/7twGUHtZrGfbzs4pJuBh3QR7Nii0whnb7jzdfa+vVI/Ak+2sB9J
	qsTQ+rL3vKRBmrORDbJH1FlESOMXqlWrn3PhQV2kgr+XcZ/FGv7PE2MXfeENpYDAPAxNRce8kDh
	ikNQGEC+AYVsgGmH5BeWA2JZTAJ+z/fd64wD1Y9Imo+tqPQOkPsMT6iqufF+PiYWBL36D+UycX2
	SOhwtnNYd7hvTgSCIIYfkH/wTOg=
X-Received: by 2002:a05:600c:4e14:b0:495:3bc6:d381 with SMTP id 5b1f17b1804b1-49987a4f03bmr249199375e9.2.1786845469093;
        Sat, 15 Aug 2026 18:57:49 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f229681sm17866402f8f.16.2026.08.15.18.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 18:57:48 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 01/14] bpf: Correct verifier diagnostic attribution for stack reads
Date: Sun, 16 Aug 2026 03:57:29 +0200
Message-ID: <20260816015746.2632990-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816015746.2632990-1-memxor@gmail.com>
References: <20260816015746.2632990-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6017; i=memxor@gmail.com; h=from:subject; bh=hMipgugHg+2Fpezsdy5mPC6kk6+iLt09etL/3QuyDe0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIatRQsSaZYvmWU7WO+sLv7MksU+X/JNYb+K0+PeGv1pZr 35IT1nSUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIkIv2H4nyYslPpe/dmtTX87 Vj4+rtaYJxhw6k1B3briKpPbqnEeHYwML1Mkrix2+u4oxaZ+QqbCy+5WtzCX0L2GwutmZZmm2px sAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Verifier memory diagnostics currently label every fixed-offset stack
read rejected by check_stack_read_fixed_off() as uninitialized. Dynptr,
iterator, and IRQ-flag slots instead contain initialized verifier-managed
state, so the report incorrectly suggests initialization or CAP_PERFMON.

The variable-offset read without a destination register is reached by
atomic read-modify-write instructions, but its diagnostic attributes the
access to a helper.

Classify rejected stack reads by slot type. Retain the existing
uninitialized report for STACK_INVALID, and describe verifier-managed
slots as opaque state. Describe the variable-offset read as an atomic
operation while leaving the existing verifier messages unchanged.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/bpf/20260815065956.49D2B1F000E9@smtp.kernel.org/
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 63 ++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d17f14b35b79..5d0a2d3ef594 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3817,19 +3817,46 @@ static int mark_reg_stack_read(struct bpf_verifier_env *env,
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
@@ -3921,7 +3948,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 					} else {
 						verbose(env, "invalid read from stack off %d+%d size %d\n",
 							off, i, size);
-						bpf_diag_stack_read_uninit(env, off, i, size);
+						bpf_diag_stack_read_invalid(env, off, i, size, type);
 					}
 					return -EACCES;
 				}
@@ -3980,7 +4007,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 			} else {
 				verbose(env, "invalid read from stack off %d+%d size %d\n",
 					off, i, size);
-				bpf_diag_stack_read_uninit(env, off, i, size);
+				bpf_diag_stack_read_invalid(env, off, i, size, type);
 			}
 			return -EACCES;
 		}
@@ -4079,13 +4106,13 @@ static int check_stack_read(struct bpf_verifier_env *env,
 		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
 		verbose(env, "variable offset stack pointer cannot be passed into helper function; var_off=%s off=%d size=%d\n",
 			tn_buf, off, size);
-		reason = bpf_diag_fmt(env,
-				      "The helper would access the stack through variable offset %s plus fixed offset %d and size %d. "
-			"Helper stack memory arguments require a constant stack offset and a precise initialized range.",
+		reason = bpf_diag_fmt(
+			env, "The atomic operation would access the stack through variable offset %s plus fixed offset %d and size %d. "
+			"Atomic stack operations require a constant stack offset and a precise initialized range.",
 			tn_buf, off, size);
 		bpf_diag_memory(
-			env, env->insn_idx, "variable stack access", reason,
-			"Use a fixed stack offset for helper memory arguments, or copy the needed bytes into a fixed stack slot first.");
+			env, env->insn_idx, "variable-offset atomic stack access", reason,
+			"Use a fixed stack offset for the atomic operation, selecting the target stack slot on separate control-flow paths if necessary.");
 		return -EACCES;
 	}
 	/* Variable offset is prohibited for unprivileged mode for simplicity
-- 
2.53.0

