Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2BE36828B
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 21:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773697616; cv=none; b=l3HRKpHKKi+vXrGjEZusaYA949vB9wOlJwQb6Sc32wFtvq7o8T1IvuOrFSnKqCtQPy52GPbTn8SRZyCrzTzC4IT8eemOyAGBjxzC5gpjFS4Jh3Vfe65ujPVOd2LP6QR5kapZ1GV4L5CK+73m2L4fbGuq3/lQ43h/9d+4tyMkaRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773697616; c=relaxed/simple;
	bh=9nOAOlTOisYqwwOSi9e2cqiUB9PWtP5arUyayXtety0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fuYdDBE3F5tmnP6c5oCgWCLkfgvWTQ+rFZTMipVO2WEWAFIZB1NF1axIZvXudE0J9jYwkNzi+tmiHsdVZUT9/XwZZvjkBJYacOw3g/ogLqENwbSN+AtKo6lARFOhGs35PzkvBn+ZgcLIzK7Oqv9EWtQ9ek26aZvmhxMhNsgJmeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=df4jGNK0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="df4jGNK0"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4856cd3f1ffso8852715e9.3
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 14:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773697613; x=1774302413; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LunrNXy2Z2HN5//xXICP0dSach9pKoHpWQJL2mrgD+o=;
        b=df4jGNK0E+Rkawf8h5TvKFAOudQNsUpVtnBAJjFpNAGzMMvXQrsSb6vFCJdpjlDmvl
         +IJyqBkPjqlaig6YHJKbiBBAhoNoV7VkTFFHyyGv5jjyWrit9uaqexR5lHleK8ncBQZN
         83BsZy7kqlS5ODXPR23eJoI3nvVr6YSKyn1365E4f45LvW2uWsZe4SrOq0yPixdM9Yti
         ApSq2FGI/Q5sw/1VXQtQnLCKYmbzo3Bq2PHFDUruKsQBvrziayIhdmrXzegtVh6U0eR0
         5tYv73bW8F81taJtEqQ1F5h3obs8oj7hV8+gCfcBFrJ/wfqZMWXKCPRuQj/F5M1uoyiQ
         zXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773697613; x=1774302413;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LunrNXy2Z2HN5//xXICP0dSach9pKoHpWQJL2mrgD+o=;
        b=fSacjiqdo5kbt3q9P0xEINSbx56bCswQK2TxKnHqPomlbDuxxX65icnyVPnOSHapCQ
         Rmx7H4rwKvM+14V31SEijrthhEQ+E0+oAcT4k39Xop+Kbj2WnC+UmFxFNjit6D1FC/FE
         L0RTExBubVsjX90lmpymbLZ/kdrX891yZEgDr1Os3lJMtcMN4Paxd7u9atVdPs2OoJTS
         pS8F6KAYZOlXUOkhAK4O47TDMjkJKd2dC/h6KUYXjo4z1LpU9yFt5iegrQOlj5njSlsW
         l4ZIuh73Xdvghdz3+L/09nfMbfWo0/gPRthKRRH4lf3CyemrHs+Gyl0q7vOdPBb6bWp9
         7KmQ==
X-Gm-Message-State: AOJu0YyKXPzA9qi8iB20Sc/ql7zoR/+jCTYxY+UG8cKNfeqJ8jth88ig
	S/snwwToTIbv5an5qwR4yCN61Roi9+wjc7e45IRZZ90Doag6RzO00rTM
X-Gm-Gg: ATEYQzzzlxMSOt83dFyxnh0WB7op7mty2vQzFz8FG1ayII2YXwk1LzYgGxN74G+JID2
	k9DX4ypH0DW2r6yTXBu8ERhTLbsJtsPtK8l5I5BQpbrHolpjjcycBK8NRosk2+Dx18Nz+pCDTCc
	s1ojkyrnB0D28CJc3eay33Oo9cfTdQ1utyXMgyRW0iWrH/Yr+4A1L/FfAmPDGcsOhrnhzSFlK1V
	Kq3X/55hmvRlyxZd50efvgXt8UcqSVU8dLuw4+gnJ+nSu4/hayMHMiQudaEN0EVkAByLpk9OZgk
	3wlV17ej/d1ots9uy3eNem78GzmrjsW6wehm34k6fSqDlrKDqHhYSfmD7NPYt7q3bn5MCflf5TE
	il71Mx38HoJM3QiyoN3lOIT6lb0Cof+L8gFqTi1nTyKGam87kx2w5pltetAEALbfOM2hitIrWuk
	O1qgtc52RkagFL
X-Received: by 2002:a05:600c:1f91:b0:483:703e:4ad5 with SMTP id 5b1f17b1804b1-485566faaddmr235927515e9.22.1773697612978;
        Mon, 16 Mar 2026 14:46:52 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea9d7e1sm21178585e9.7.2026.03.16.14.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:46:52 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 16 Mar 2026 14:46:46 -0700
Subject: [PATCH bpf-next v5 3/5] bpf: Verifier support for sleepable
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-sleepable_tracepoints-v5-3-85525de71d25@meta.com>
References: <20260316-sleepable_tracepoints-v5-0-85525de71d25@meta.com>
In-Reply-To: <20260316-sleepable_tracepoints-v5-0-85525de71d25@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773697607; l=3358;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=d+hTYccHRDSzAvFALs2kdiRPOgGLqMJVSwu4/FZvIDI=;
 b=GBbNyeUj69qhemH3m9k9xUnEMrGXSNyHp1nVHy17BbytBkWVfWtUOzZyhxPrzQQZA46ncaQtF
 7/1KTox6gYtAg/FCeo/Dcl+bzQz2gBPS8avxWwvY5VSVNHk7M6+f7xP
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=QUfct6THKRRhwIGGKcldE2w7zXPci1gMPcF7qij1gwA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Allow BPF_PROG_TYPE_RAW_TRACEPOINT, BPF_PROG_TYPE_TRACEPOINT, and
BPF_TRACE_RAW_TP (tp_btf) programs to be sleepable by adding them
to can_be_sleepable().

For BTF-based raw tracepoints (tp_btf), add a load-time check in
bpf_check_attach_target() that rejects sleepable programs attaching
to non-faultable tracepoints with a descriptive error message.

For classic raw tracepoints (raw_tp), add an attach-time check in
bpf_raw_tp_link_attach() that rejects sleepable programs on
non-faultable tracepoints. The attach-time check is needed because
the tracepoint name is not known at load time for classic raw_tp.

The attach-time check for classic tracepoints (tp) in
__perf_event_set_bpf_prog() was added in the previous patch.

Replace the verbose error message that enumerates allowed program
types with a generic "Program of this type cannot be sleepable"
message, since the list of sleepable-capable types keeps growing.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/syscall.c  |  5 +++++
 kernel/bpf/verifier.c | 13 +++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 274039e36465..bc19f6cdf752 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4261,6 +4261,11 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
 	if (!btp)
 		return -ENOENT;
 
+	if (prog->sleepable && !tracepoint_is_faultable(btp->tp)) {
+		bpf_put_raw_tracepoint(btp);
+		return -EINVAL;
+	}
+
 	link = kzalloc_obj(*link, GFP_USER);
 	if (!link) {
 		err = -ENOMEM;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 01c18f4268de..a4836f564cb1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -25255,6 +25255,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		btp = bpf_get_raw_tracepoint(tname);
 		if (!btp)
 			return -EINVAL;
+		if (prog->sleepable && !tracepoint_is_faultable(btp->tp)) {
+			bpf_log(log, "Sleepable program cannot attach to non-faultable tracepoint %s\n",
+				tname);
+			bpf_put_raw_tracepoint(btp);
+			return -EINVAL;
+		}
 		fname = kallsyms_lookup((unsigned long)btp->bpf_func, NULL, NULL, NULL,
 					trace_symbol);
 		bpf_put_raw_tracepoint(btp);
@@ -25471,6 +25477,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		case BPF_MODIFY_RETURN:
 		case BPF_TRACE_ITER:
 		case BPF_TRACE_FSESSION:
+		case BPF_TRACE_RAW_TP:
 			return true;
 		default:
 			return false;
@@ -25478,7 +25485,9 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 	}
 	return prog->type == BPF_PROG_TYPE_LSM ||
 	       prog->type == BPF_PROG_TYPE_KPROBE /* only for uprobes */ ||
-	       prog->type == BPF_PROG_TYPE_STRUCT_OPS;
+	       prog->type == BPF_PROG_TYPE_STRUCT_OPS ||
+	       prog->type == BPF_PROG_TYPE_RAW_TRACEPOINT ||
+	       prog->type == BPF_PROG_TYPE_TRACEPOINT;
 }
 
 static int check_attach_btf_id(struct bpf_verifier_env *env)
@@ -25500,7 +25509,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	}
 
 	if (prog->sleepable && !can_be_sleepable(prog)) {
-		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
+		verbose(env, "Program of this type cannot be sleepable\n");
 		return -EINVAL;
 	}
 

-- 
2.52.0

