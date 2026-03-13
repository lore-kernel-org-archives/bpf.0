Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469183803F5
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 21:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773435901; cv=none; b=sG6iMcIXezUraxaaKhg/EqNqwPhB9qd/BmUnN4lyBxZxFjYkrT4O4vxeYfz+gcd69QXRgOHKPdYPUa0EMqrJt30llkDE2TuxeIBkAE66HmHy9c5JhOXE0WiDFCO03stYoQTW8Q1cid4Tj3bSw/B/D343wCjNjefkMtALNKCU9D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773435901; c=relaxed/simple;
	bh=wHOuczz9fx5PZPT77d10988cEd0BnGCsuUmGUjAiTnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hdDaYOaN0bkBnpCZIPeEjiNEDKwlP9p3qEtIz4WLxxEXLeASw5CgdOI0LzUVyxHi/dTGVpPwWcl3Xsf5UocfQ8DKzmCc2x8H1Akn4EPBCaJMfAFwF48di5kgqTuvGEQ3N3Nj0RoH2sfFtu6xbizStXhu2/MAMmIo+0n12MMMOMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TogdoIYG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TogdoIYG"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4852ff06541so27350465e9.2
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 14:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773435899; x=1774040699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0okvbViHVjMZEvO6zcjXt/8wrAN5YLOhEFKgf5ZYjLw=;
        b=TogdoIYG2Nto9Kl2jVgbKClxe8Hg21DLFRWiQVRJcFq1gVGADVZGB/BenYm0SDKekW
         XITtBZTurlNiTFPeth1EnFDfw0pzX3bQgs9yNdas6v+v37L4FsuMHUHIHByDDBARz+8f
         88HDd6mI/2I37Zmfw9+BSyDmaF5PJVwFqHhXl8KdL+O4V0GublbZA3oqkDfeOSsDzhQg
         qgDo2Ast4+kVnnJ1/HUH0mO8CBw2szT5m4Zg/CuDZyE9o3mRmNqgdFU4nzNN8op3/mam
         A1xzpEVSe037FHra2OY0C1HRAAI4jz+UBNNolzwh07+HgWCQ7SiMRRpVcaIDFujyj2T2
         egLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773435899; x=1774040699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0okvbViHVjMZEvO6zcjXt/8wrAN5YLOhEFKgf5ZYjLw=;
        b=HMJg+QWakSUodLjTCdghhbjSnzYjuXFW+BYRKixCTn9kR2cWLfL4+o6BMQR7R6s3xf
         0uzJgHVSYexVxLMr6qehKil5w2Kq0LbkfkXSpkiMLXXO+3zRYDbS72TcJSM7gDEqB2U6
         LSm391KvzGN8xKqGJkByWIrCQqf8DKtJjhqLALStVE9uomsAPsgSdRvB1IbH55SRWAfL
         grn3vq4g66ZL0fZ7LwqDYbeC+5j114hIbqacX3rCWQdAlGEgurNKNa1TWu/X2PKq30su
         z5mwzXS5YdnqvBcZkK4H8oT6g1PwTHTCUQtcNIeFsd9yWoCWo/YmqI/Yn6UPuaTDzziX
         gd/g==
X-Gm-Message-State: AOJu0Yw+JjYMVEMYh0YBcrrHYRxyxuwxV8qgV7QEvLon4f0jR1cqOeQB
	yFieLfUkLx6fr9TBc/c9leyBNO8pKfNT7tAV5gvhoCjrF4Hjbn/Y4RBx
X-Gm-Gg: ATEYQzz7ioFTd2TtWFfDsoqGTPpp9wOyAaOtdb+omX5a6XBThMIFecDfThJbJ6BnImI
	0+UF3EMg5tfTlrELRfKe50ZZX1wiIuv1GT7pV5F95YMxXnPrBQnkKDU/X4Mk5y+p7Xv3nI6Y45R
	M59tSOprb8eLm3CDuYF87CJJifpNNffMqyHyJGayzZ9swoRbda5Jo2PUzztrMcmp/MOYoz6dm40
	P3YxDkprarS28E5wVyBQNz5h3K1vfJg2+B2RF83vABohN4sL2xC69BWSEWcDFXhN8yF7kWZp81x
	k7DvBLqwd0jiM6J9dLHuMPc/3GZOwupss5+ZxnhYkNH+dutmDl2g9g+V97L6avX7ple2Pmyurwp
	RX2XHpkakoasVK9Slfh9iV4FPxTqz/c53WlMsPRzM3JoJJJ2IK8UYz1tCB+xDvYZ/M8wJrSVt+l
	hlwbdg7ilEqbEf0mnRAg==
X-Received: by 2002:a05:600c:45d5:b0:485:40a6:442e with SMTP id 5b1f17b1804b1-4855649c956mr79848365e9.0.1773435898435;
        Fri, 13 Mar 2026 14:04:58 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:42::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b6070acsm197354025e9.8.2026.03.13.14.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 14:04:58 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 13 Mar 2026 14:04:23 -0700
Subject: [PATCH bpf-next v4 3/5] bpf: Verifier support for sleepable
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-sleepable_tracepoints-v4-3-debc688a66b3@meta.com>
References: <20260313-sleepable_tracepoints-v4-0-debc688a66b3@meta.com>
In-Reply-To: <20260313-sleepable_tracepoints-v4-0-debc688a66b3@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773435891; l=3239;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=KK2VUt4LeQRJCwlL8cwddPhpZ4lAwCmSWkt5dF0HPII=;
 b=lmEMWv5LAgNiU37rbt1knXIwYTW8EwlRWkPU6VhEHnLjbLCYzekudBPU6OrLu8fJOpWAlhR5o
 3jOhxj+pX1lAvhmOEyKmp4L2/iqMkv0gMoZUna1MrIcsVI/Z/xxNQEV
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

Replace the verbose error message that enumerates allowed program
types with a generic "program of this type cannot be sleepable"
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
index 8e4f69918693..18ea384f1aa2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -25216,6 +25216,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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
@@ -25432,6 +25438,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		case BPF_MODIFY_RETURN:
 		case BPF_TRACE_ITER:
 		case BPF_TRACE_FSESSION:
+		case BPF_TRACE_RAW_TP:
 			return true;
 		default:
 			return false;
@@ -25439,7 +25446,9 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 	}
 	return prog->type == BPF_PROG_TYPE_LSM ||
 	       prog->type == BPF_PROG_TYPE_KPROBE /* only for uprobes */ ||
-	       prog->type == BPF_PROG_TYPE_STRUCT_OPS;
+	       prog->type == BPF_PROG_TYPE_STRUCT_OPS ||
+	       prog->type == BPF_PROG_TYPE_RAW_TRACEPOINT ||
+	       prog->type == BPF_PROG_TYPE_TRACEPOINT;
 }
 
 static int check_attach_btf_id(struct bpf_verifier_env *env)
@@ -25461,7 +25470,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	}
 
 	if (prog->sleepable && !can_be_sleepable(prog)) {
-		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
+		verbose(env, "Program of this type cannot be sleepable\n");
 		return -EINVAL;
 	}
 

-- 
2.52.0

