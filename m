Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ED4279DC9
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871652; cv=none; b=D8nUX/VjOSCohHzjNceuv0igCE37wntw2YnILnP6tkGvxkK+varsis00PrWbZUC7q+ztvwpz+K1Gx/rgALQ0d+uUnRrqll8Z2cGdc1zQ7G1D0bkjl4r8GnfGVzgl4QQf4lA5r3e8GooavB2dFbHplKlQQbTn/EHWuqkwBLpu75c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871652; c=relaxed/simple;
	bh=+SaPuX5M5TsULTI24qI/PzgrfyH8QWL/gtsCwfhWgUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eB53ix7lnlEz1AgGaYXw6ovLYYIfaIRWDknEnTA6wIJTJ+LrmMyvrseLGVCo+KVgPX3YVo9lVBHlgXHnw8o0IOIYtqXwcfCifHgmjkPChvvVtxjJCVbFZXu2cqL72Xxv2DqL1hG58uS+mCcSHMWsovOBBlywejvihW6eEz+wlUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b88X132m; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b88X132m"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so3527993f8f.3
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 08:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776871649; x=1777476449; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DG7r+fX7s1omhIGpgcAgCpvP8cdsVkiDmcfQ39W2x2o=;
        b=b88X132mGuiXfxKTl7nLjpl50mpCWWoL51toqfKtacC1V7NcRUMqbMtb2vtXc5/GkI
         DRC09EM/KuHdSBvyoQRYkGbjIdVgVpPg2p6Aaz3fckw4ztdqY8pmxCR+t6eSo3zg8Ggx
         9wLB1wSl5+LwAElkng6yFdpl1aDqSew2uMNOoxPXShGCLXNzXE7kDr6iOtocX644SyoM
         /24riFOvvVtekZWBuVoOprnut0Fco/sSlf8haG9dyu0bsLwb+Wr9WBmxWL6LZqC92D+2
         i3Litm2tgJlXYyrkvkBvkQ5sAbOrDg9GJxGPT77OYc++m7YyRIrxyTY4V9lYZ9BhxNVc
         xj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776871649; x=1777476449;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DG7r+fX7s1omhIGpgcAgCpvP8cdsVkiDmcfQ39W2x2o=;
        b=HkTS0MeAKzs9tfA3B2c9p1eWvzrDfbMMjuXCIxFo2BPjdQt3RXnMh+1f5UQ92p2zXM
         UuQj46/nzuYfoPgozehAbghf/b3/ltcOspemU3mbP5ZG06epqD1g7XQvrpc2IIy9Kzl9
         sUN6BFXKXsT3nBvoKu/Z2F3HZlFgx+5993J2t+mbY6ecU6N+e5DdvwrGiFBcavflMSqR
         SDUTnhFFP17q6qSTd6O8IrJX34gcUY1TU5tMiiMNmXG+emOCURTkAuEogdlwYtZAiwu9
         WBAPuy7OJCoUJjoySGNkIyd764MZT/Kdj/+1fpzcfWAuV8g6am3OBSKgV/WumrOBtlPP
         r60Q==
X-Gm-Message-State: AOJu0YwaIf00qdHkSckTmJDuf3crZ5HVc8n0wwfPmaqY3ZMrJC80p3Q3
	3ifG7cuDMXeqYrMb3VbR9g5wJVtC0sGr91JvchUlSPq1Wv2at0In8bgyW9xRkmx2
X-Gm-Gg: AeBDieuY59U3+AaJk6k4HNf6xMMziqbgUtM3yQAu56zyeXEZE9Y2aZpGu36LQ+tgrxI
	Ynyi26VDAVMoqUKYMk1f9o2bB4+zIh/WHJ43aTxUFS3bmsZU6crr9m/Rh4UqqmfhYBToN/Fuf44
	6iPdDEHmOXivtGgKzv4XxTwEiCsMs6LGU5GO0aMqoKar5eUqp4fuoPE+F29mGqPHiU0PAj3JqMx
	GWY71y23Knc2ELj3JF0YJrpvYzHZGk79McOHXzPKucH1VpzHPOAqJMb82FZW/fdnX4DYsMlRjh+
	OKUgzGxibD8FjtzqXmaZaT32GPTAMrFta/giMWksqQCTaLJ99+nLFJcDSoWAO2HeXa3Ml3m+1P6
	IT4CkMg4Z4NKFV3j/9OlUSg/gRj8S3616xqkeLfmHaI9pURWHJhLmbounBZxYZcPSPiuMv5K+Vf
	JgF0yxdRb4UMy/aR26CIUPMHA=
X-Received: by 2002:a5d:5f46:0:b0:43d:761d:5423 with SMTP id ffacd0b85a97d-43fe3dcc03bmr35934272f8f.16.1776871649346;
        Wed, 22 Apr 2026 08:27:29 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc375dsm42051390f8f.14.2026.04.22.08.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 08:27:29 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 22 Apr 2026 08:27:09 -0700
Subject: [PATCH bpf-next v12 4/6] bpf: Verifier support for sleepable
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-sleepable_tracepoints-v12-4-744bf0e3b311@meta.com>
References: <20260422-sleepable_tracepoints-v12-0-744bf0e3b311@meta.com>
In-Reply-To: <20260422-sleepable_tracepoints-v12-0-744bf0e3b311@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776871642; l=3405;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=Ac5+kVuTHMmxd2jh/8dcKeAz+KyadOU0D2xIptU5iu8=;
 b=M9sPIs6BBzrIrHBnm3LJcSnQc1gWfd4NUvSkkv9GUrFz3RVE463llYZopy2iNbvhgvbQuOTdd
 SbIrx4YqA5XBJZOTNp+y3xONq6i6UeCunU4may8df3hs0kTiLLHflnt
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

