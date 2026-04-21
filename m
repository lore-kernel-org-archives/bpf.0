Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145AA231836
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791713; cv=none; b=e2vc+gfUT04dwH0GU6UNYki9I6CoPu27XCNAnZuXVmIr4TJ8S3Q0L7nfxQAIO+bpQRFRqspWkChfnr0LuC6Z7fh/B0wdDz1rCJhUrymz+9nAETX6uRU2iJ+uSQWpYHHdzX2voKev5XLwBIH9uf8NL8MBCPSfHxKZNYN6ReQYSys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791713; c=relaxed/simple;
	bh=+SaPuX5M5TsULTI24qI/PzgrfyH8QWL/gtsCwfhWgUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QjZIgpPhPPDsnoQIz9Rdi1Jpb8y6uq2DPySqFXKYIxUbPDMhJhaDW938bfgXEpUMjyQMxW+zo8OsBh5vscLMHxibr6mp23IwLrkTyeQM1OUNLoEQz/nV2lKEYt2HicSHSwOekEzap7oCMbqHHvvdMuxOlcX43EjBJbKAE5aeCGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WESw++NK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WESw++NK"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so57679135e9.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 10:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776791710; x=1777396510; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DG7r+fX7s1omhIGpgcAgCpvP8cdsVkiDmcfQ39W2x2o=;
        b=WESw++NKbBHplaVuAfAVX8Xer8gMPIV4fSw2UUPueYX+oKDS4KUc63O3Dc8y1fXKC1
         dquJZf6GPMpOHPeJTfuz/iY42hqeNysInzzjQt4VIch59u6XrYXPkrlhWYlRXcFmd8mt
         07LBn7gVJNhLAdXhqmAILXw50AUkqmGmP1H9rLfJ2kLisPPRzhNuFJQc7ffPGGno1E5v
         TxrqmhW4NkLVkFhLeWgJRcAZCKU/qAEVomw2458i0Eo5Kjz6Lzj0Jfk8LPfzoBwSIJYk
         la7PJeEzn6UJnDbmLM/ExqTTL8H5mIrxnfvk9b+HuboFAJG8yxyFOOQN7YhpMWpk2tZy
         MM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776791710; x=1777396510;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DG7r+fX7s1omhIGpgcAgCpvP8cdsVkiDmcfQ39W2x2o=;
        b=q0XRyEjXxRALT1gZFPX2sdKxmFoY54rbLhMXI1vva87C+IDHw+l+7jb9EjFje+sJu4
         BzocM7bo1FYWPnmfaOeIYphdPbdok2QEE2IRw+jMnYRF6Y+LvNW/huSB75NHisiRPPbH
         m20chX9yjZufv8BEHoQWOuReKXV1PBKB/1YJ5prLousiJO0oRmW4ty+dPNt8I8GEE/Ke
         oxGovqn8tKtakf3F/eM2xEmg4/kcbva0YHsR5jutxG5una2whpGPUKZNBUrqFlmtqp+3
         IPkmduYevQCv69DrgqI86JrJAQfEPurcg+nZCSF/4u7855csWAUooGkUmBUrMT6qZqkx
         zIsw==
X-Gm-Message-State: AOJu0YzsGuThFLItX+IBTsxl62Myo3QzCDPiB75R4phLljX7I7f34fP9
	kUd/4U2/YyG7qEJK37VDb03C/L75rZ9l7OkQffSwqZSE2IDaYS8Jabnk
X-Gm-Gg: AeBDievZp2/DH9F+P3OeBWXmAmcF/FEby4JfVS/fKhmQ6haGhelWHcuz/+X4pua2EFi
	aFElr4S/tMJNODWdfCPni2o31iskJaTV7CpDOyFjy73YB2ZnpA11QTeksRa6MKuF1yiTj7+9pur
	YBYDBB0U1z/bbfwbV21jheT6D3Tqzh9XwhtkdxVC2yawF5GhD+LlMdkmgS8XbAHiy9Z+CRn09OR
	kipX5wyt1aN/JKQWOOn4kgOHiqc2WwziN20GXtUSQG5MHXktRNHye5K4pg5U7SkW5XWvvhIfh/E
	MNOGLFMq0pVUE4CeD5vLnLp3xQrrs18/eg22kbPLIhrkzE3y+2FGbvVRGr5eldqzTV/iv06dkJG
	x/nDbAU/Bya9oPbnROgZ4ezUUcvTJrLRb2w4WmuwULBlObgL4aVH/Emaml5Fpq+yywqQqKat6pE
	2sgVN29FZ9pA2wklrfOiCjF1Zu
X-Received: by 2002:a05:600c:a086:b0:48a:568f:ae82 with SMTP id 5b1f17b1804b1-48a568fb009mr46570805e9.10.1776791710165;
        Tue, 21 Apr 2026 10:15:10 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc10777csm439995285e9.8.2026.04.21.10.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 10:15:09 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 21 Apr 2026 10:14:20 -0700
Subject: [PATCH bpf-next v11 4/6] bpf: Verifier support for sleepable
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-sleepable_tracepoints-v11-4-d8ff138d6f05@meta.com>
References: <20260421-sleepable_tracepoints-v11-0-d8ff138d6f05@meta.com>
In-Reply-To: <20260421-sleepable_tracepoints-v11-0-d8ff138d6f05@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776791703; l=3405;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=Ac5+kVuTHMmxd2jh/8dcKeAz+KyadOU0D2xIptU5iu8=;
 b=/lzHPlhMcpaHAxU8fHlu23awb11qYwSYBLRs/EjQIlTD1als7PuQHgIZfgPGKr1yjFgzPfo/r
 JoTvBKQLRelCOifasaa8++B7dGfp3gLAUyh1sw3VhU58KATvToPhsTC
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
index a3c0214ca934..3b1f0ba02f61 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4281,6 +4281,11 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
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
index 185210b73385..5b4806fdb648 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19267,6 +19267,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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
@@ -19483,6 +19489,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		case BPF_MODIFY_RETURN:
 		case BPF_TRACE_ITER:
 		case BPF_TRACE_FSESSION:
+		case BPF_TRACE_RAW_TP:
 			return true;
 		default:
 			return false;
@@ -19490,7 +19497,9 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 	}
 	return prog->type == BPF_PROG_TYPE_LSM ||
 	       prog->type == BPF_PROG_TYPE_KPROBE /* only for uprobes */ ||
-	       prog->type == BPF_PROG_TYPE_STRUCT_OPS;
+	       prog->type == BPF_PROG_TYPE_STRUCT_OPS ||
+	       prog->type == BPF_PROG_TYPE_RAW_TRACEPOINT ||
+	       prog->type == BPF_PROG_TYPE_TRACEPOINT;
 }
 
 static int check_attach_btf_id(struct bpf_verifier_env *env)
@@ -19512,7 +19521,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	}
 
 	if (prog->sleepable && !can_be_sleepable(prog)) {
-		verbose(env, "Only fentry/fexit/fsession/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
+		verbose(env, "Program of this type cannot be sleepable\n");
 		return -EINVAL;
 	}
 

-- 
2.52.0

