Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B586434CFB3
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464963; cv=none; b=ZxrSUiT+tnHAGWP+7BcOxSxjebUDf0cMCh+3lW6tIgMdKPKOnA0lro9B2dz6GuRkoOl6oTxq3tBVppI7qL2x0rxe6mahn+UTWrzOfOLOgvLRQWq+dpv+xDhxCVMZZfuJszDOtZpMuaR7nEdS6VG2wDF9s+iEIJz+SfTs9HtdVoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464963; c=relaxed/simple;
	bh=9nOAOlTOisYqwwOSi9e2cqiUB9PWtP5arUyayXtety0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SckGjsfQELBHjCSALeV/TWxdvIIQZqjeCL6f5I5bCUDv8hnm+HpksAjsvnv9sVade/YLep0WGEP8RFGmcP/OruU4/BJxpVlMq0muaY/CfTiEShnr2FMqPIBydyF5jbQSM2lKGLxde6dXcOLzJx+YrAVxUa3cIqJJxK7UBQd0Mmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFCAV52L; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFCAV52L"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48541edecf9so2372365e9.1
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 11:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774464958; x=1775069758; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LunrNXy2Z2HN5//xXICP0dSach9pKoHpWQJL2mrgD+o=;
        b=bFCAV52LIfkuI/FBpfvElrIfr+u7UhqyqK5UsMKSH/NjKUDgRYoElUx9TVZ7/DF2k3
         B80/1J8PyRDfaUUKT7Vjfc9b1nk6uGZW2XrJOnMgEmDkBZ+PYKTnQi3DBrStIRj6f6sv
         vpOB9DNAd3Xu4QhqMY1Ps9t9UwTEmmfpzl/QxQTehAf84zFkvrloJ0WMP4PY4n52ZbJ8
         52Rz35SqooBKBY7nUEEzzzaSu03B9ghaZ7a99yuvHsK+WR4ri2k6PBEA9AyCVbmz1TTJ
         bekarTOfGlkeNh+3laVlA1RfW7QkUg8dmTZ7vvK5NVxl/h5ERcefBDO9Y9JrxIYQ7x3M
         XGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774464958; x=1775069758;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LunrNXy2Z2HN5//xXICP0dSach9pKoHpWQJL2mrgD+o=;
        b=iPn5Xy1fSa+Z0A0YmJ5H2jN2eEEkpoK6pNHng5Q3XE0SP91YiCqKmmQUWUjsRaITMq
         qkVorcXMl0KVlxtzYvmITBva7XxYCXHbjHYfHQxitMe1EM772JhC/boNfic5kqa8cmHO
         Clcv00iUdFfjSBzOJ8mep9uoW5qCjbumZoIUyQt07TFu6jLNwkb1B0NpJy4LNhZ7exNi
         o5vQD6QTBNzVKOivUlNOz7TaYab9UPTefqtZIv8ccNruMYS2Vmg96bD5tjI3vN0dmDPv
         FOtJdxGTuTj+yFXH9QgxoExwijPPZsLuBozmVFu/x7jd8XoE34Zyq8HdicnMvAwq1Yy4
         BaYg==
X-Gm-Message-State: AOJu0Ywjmf/4kEofKucocsXXC0/N21aieku7/Dn+SlehU+X4oxnQoITb
	Fb5MQpdsTVqze2DQ55eY0Akvc7/AWm4ZOWWlmp27mk5XTUHY0Y/zejA4tBjdxTal
X-Gm-Gg: ATEYQzw6lre3zQVn5mHwDCLnhvoJ5c6urjZEFHyyZqBXkNMzmv5roEuVXw9KDFA26sB
	EG5H4NpxUycWh31bM5cCrwbWOklAFJVjUaATc1AjkOM2ir7jUWg7E2z0r1i4UYZwFHAscpfEo4a
	O/uHTvl5GqSoP3cLxKc6CcuRO53zusc+oxTHrsQdUsqOk6YM74lKZ6h3HZmeEn0V2rV1/uwo82D
	EEM6MycCIQa1iCk32hY2av/McSCjQdrUdCirrKTeVdvBZ82qOLjyOSWAGJw8NotAIXidwwY7Dk4
	0dIilQq2xO304OkJgk4ejeczdMU5/omuXXyBG5ABTPM1CRYKWE1mE8N1TUO90PD/vTgiS0o5hN2
	5Z1WCvZkuBhH+H/Wdm8lYj7bc3fBLU6Ljz5d7WX5vmB9RJlPYPCNYdgt4okHi8iyJCAFvBTCiZ5
	h/B5FqlTtc2Czq
X-Received: by 2002:a05:600c:1394:b0:485:4388:348b with SMTP id 5b1f17b1804b1-48715f0389dmr71607175e9.0.1774464957784;
        Wed, 25 Mar 2026 11:55:57 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871fb4bf57sm325575e9.0.2026.03.25.11.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 11:55:57 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 25 Mar 2026 11:55:21 -0700
Subject: [PATCH bpf-next v6 4/6] bpf: Verifier support for sleepable
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-sleepable_tracepoints-v6-4-2b182dacea13@meta.com>
References: <20260325-sleepable_tracepoints-v6-0-2b182dacea13@meta.com>
In-Reply-To: <20260325-sleepable_tracepoints-v6-0-2b182dacea13@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774464950; l=3358;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=d+hTYccHRDSzAvFALs2kdiRPOgGLqMJVSwu4/FZvIDI=;
 b=l1Ufa2T1B6Z0MOrS/LtjTsK9hu4xBiUC7SFNbf7mmwawVXhdR7kFIlCyvsJHTzi5eElcKgh0/
 V81+PDeKmiiDMUeM7XrqSLjveG1DoafaICbl/NpVhcFcRsxFLe10Slq
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

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

