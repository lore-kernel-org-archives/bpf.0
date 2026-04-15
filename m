Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A362A39526B
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776264596; cv=none; b=P3CNx5YWw5iP+WOcfYM4uiP6SQB3hybju25RBtSv675ilZvQ2iD2OQrrdHw/JTF4BAbEEKof8W/jWo4grfHcGfo1qJeWNpgkEfaoYbQ2GFRygrtqJYo5iI19ZMGnTv0y2Npx7k8e4UVNq/YCqw5b9PDSkfxXvnP6JyjOcIwAJ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776264596; c=relaxed/simple;
	bh=JrRRJfcbkAlfOBA4lZb/BRm9u97OoWEoqpiT8IJG2us=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fUfHzOk6cLMswCn5mhFAaMH62UpMa0qnMFI8XCnTcrTQ2v2keh4LnMmapesWIc095muZtljmkJ+sOdRwXMOw9wb7k0yUk29vyDM746a2dFHhgBu2Hz8+nCZjyhq8pfM0AhjRVPWTei5pgTyFKh66Z/0qBuJDUvdcE3p6wSN0V1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRqjdpTl; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRqjdpTl"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so61143005e9.2
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 07:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776264593; x=1776869393; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVrwBTWPMb8xLu3ot8WG97FFvusy622OfUMfNgwWhk4=;
        b=HRqjdpTljN6m49cBL8c9XcRuTy6v2yPcjpzQXWEIhJuQm7KNVozFwoUI2e7liFUYcv
         V79HHxsKkdNUvCt89R9iyf1uDGe7l7nztjUDM8sTxfDQxQRpw/gP7oJRoJMT1yVBb2uw
         8/2j4q2Jpkg3WmPS60erllrcuBQguHOhdNNI71ULHLLKn9WaJsUSjP9YIvF8G03KCZN1
         3HgGWJb9f8Z3bmA6wCUlYz3THypjnnlPMVg//CnLy3Y7zMGJRJElfRhtB3lpeEVy53IK
         oyOT2gXRwpGp1uQWerNWsRy4Pz9ob7cXFCQxTWUR0d3JFExRh8LQTiBtSgl2h7mtn9rk
         hJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776264593; x=1776869393;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sVrwBTWPMb8xLu3ot8WG97FFvusy622OfUMfNgwWhk4=;
        b=HhAwuBQAv57VLZX8VRdrbmsYjryhPlHxcBBqHdoo7xRSydusg+7fA9U727Ij/4GYsi
         QbQwmRBIPkdnDEPFh2aHAmoTYQ/Vb7vj6fq9DDOuDHcg9MERzkc7j0duCAmVlaaR2e2J
         /7FMh6EWhKuxqAHET/DTDbQLPvI2bMsaz4Ay0Bx3Oab418Ezzw1GF4H9bHR//VrD8oWh
         keVJ+auA3BMNk9FYrtu7gkXqttVW7jukYT9gcR/RvFSymtA6keYJnGyidN9k1Mw3/PFS
         TEmJleq73fU6K3Qr4Y/I4v0Z5YVJF5tQcnrRvDv+0ysHmvFKOCduA0A/ldTLv6BlVc3e
         CUYQ==
X-Gm-Message-State: AOJu0Yzu9kuVb0EHUIWMAoxogkqxuQt98oQ5lMf41X9yMc+1Ys0qOCzq
	7x0Al3TWIdeARuEdxMxMjUp7X0LQLSmj1wltDtdtv3dmFCCFKRAIl82/
X-Gm-Gg: AeBDietyiKWsuub0vuqS4R/IyJQJRaImaB2OL0NPseFj8u3KSRgoGVIgzGZ7KDF59vI
	Xed4jM6UW2YkB8f2Ap+XdeTm9YuavujfMCAjWJTPXKhDvilR+re7IBvs3qHim9f20Dgn7yRvKKU
	qCLXMnN1KvHhgxJz8zVaPJqx7sbQ1qTZ5EdzqAqjj4RzkATIROKN+779RggP656w0nF8LbCw8sJ
	i/fu7tTo9UlzmwuV4V3dENxrxfm1F+/F7URKGCLCfT+0rCqV/K48MUdKyuDAhxziRqGgXQigIQn
	9OAO//WIiQGyM851+8dJ80IcHkXChOlsXFaSB+nKXlDbRZqsDZwr+SBKS54bDUpESO6b1U+Ekkh
	Os+qfoTIVbBkAcJo3IVmigVGdCxOQ77X8+1WvKecSUkwcaYgIPHrXcNLxuFgp4DhzOC00syRMO1
	YIIxVLA1Xn8s+GFg==
X-Received: by 2002:a05:600d:d:b0:488:ba5f:984f with SMTP id 5b1f17b1804b1-488d67b8dadmr241232165e9.6.1776264592840;
        Wed, 15 Apr 2026 07:49:52 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f094e2f1sm23686965e9.6.2026.04.15.07.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:49:51 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 15 Apr 2026 07:49:06 -0700
Subject: [PATCH bpf-next v10 4/6] bpf: Verifier support for sleepable
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-sleepable_tracepoints-v10-4-161f40b33dd7@meta.com>
References: <20260415-sleepable_tracepoints-v10-0-161f40b33dd7@meta.com>
In-Reply-To: <20260415-sleepable_tracepoints-v10-0-161f40b33dd7@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776264581; l=3405;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=v53AjnC1t2g/4sdLILAarGyoJ8JbY8HIwY7F6rRSUes=;
 b=VFAiWd0hLwDGrr3RCH72VqJJTnGxef0K3odGCsyhrN52d8TzTaM8ouB53SIxaVboJXzC+GemZ
 WBduRZq/UwEAahdl2BBFtMf8SA1vWQiCefcGdwUog3EFjJ0J7WUPbo/
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Allow BPF_PROG_TYPE_RAW_TRACEPOINT, BPF_PROG_TYPE_TRACEPOINT, and
BPF_TRACE_RAW_TP (tp_btf) programs to be sleepable by adding them
to can_be_sleepable().

For BTF-based raw tracepoints (tp_btf), add a load-time check in
bpf_check_attach_target() that rejects sleepable programs attaching
to non-faultable tracepoints with a descriptive error message.

For raw tracepoints (raw_tp), add an attach-time check in
bpf_raw_tp_link_attach() that rejects sleepable programs on
non-faultable tracepoints. The attach-time check is needed because
the tracepoint name is not known at load time for raw_tp.

The attach-time check for classic tracepoints (tp) in
__perf_event_set_bpf_prog() was added in the previous patch.

Replace the verbose error message that enumerates allowed program
types with a generic "Program of this type cannot be sleepable"
message, since the list of sleepable-capable types keeps growing.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/syscall.c  |  5 +++++
 kernel/bpf/verifier.c | 13 +++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b73b25c63073..ce00e87431c8 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4285,6 +4285,11 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
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
index 9e4980128151..5e31b92e04ea 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19289,6 +19289,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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
@@ -19505,6 +19511,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		case BPF_MODIFY_RETURN:
 		case BPF_TRACE_ITER:
 		case BPF_TRACE_FSESSION:
+		case BPF_TRACE_RAW_TP:
 			return true;
 		default:
 			return false;
@@ -19512,7 +19519,9 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 	}
 	return prog->type == BPF_PROG_TYPE_LSM ||
 	       prog->type == BPF_PROG_TYPE_KPROBE /* only for uprobes */ ||
-	       prog->type == BPF_PROG_TYPE_STRUCT_OPS;
+	       prog->type == BPF_PROG_TYPE_STRUCT_OPS ||
+	       prog->type == BPF_PROG_TYPE_RAW_TRACEPOINT ||
+	       prog->type == BPF_PROG_TYPE_TRACEPOINT;
 }
 
 static int check_attach_btf_id(struct bpf_verifier_env *env)
@@ -19534,7 +19543,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	}
 
 	if (prog->sleepable && !can_be_sleepable(prog)) {
-		verbose(env, "Only fentry/fexit/fsession/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
+		verbose(env, "Program of this type cannot be sleepable\n");
 		return -EINVAL;
 	}
 

-- 
2.52.0

