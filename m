Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB99218ADD
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775840995; cv=none; b=AZoJyFwod3MD5NFP53DnMBpH610Rs8/SOEa/uk6u/E/6USFimlQXxWDjOXvIu9uZGnpEMg5E8j76egiGANKYFNrjeYkRVzwR0k10nGxUcZLg7RY57vyn6baODz1LIKyqi/j4p+xGwvnF8/H2ee/XrdnQmNrLCJy3fDfSROyVuH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775840995; c=relaxed/simple;
	bh=i39XFeBvh2v9Ka8BJRtzWd/6BaF8Mzuvcdn/1nCpqmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rhK+51VCYM9lGzyF4ZL6ltV3goQiaAutO5IXAUgjfXeyVBv4Kyr/nRp3JztrdaDDDEzCScjkF6vfLhtLIlA3jQCDrFOt8Y0+b0eFV8MGS+yhKAyZsEPROaSpCyh7ijeNtue5rnsPZE5G6nWLCePEkmi/rtiX50qKN4qxLeEaDzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFV2X3zM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFV2X3zM"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso27184215e9.2
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 10:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775840993; x=1776445793; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90/3zxIyEQAJ+2qsKxTylxgOIicIZrZQy7FspHiE6rQ=;
        b=DFV2X3zMNsR/nlakUM+jpqfa+7rQhg9x2wC5JsXHUREwKSiBN7Rt+cdIbh1O63u4ab
         Gz8pmtPKt8ksLw/K3gbS0ZAC1dipdplO1uidm+96gpk77YozUBmt1xE9pwDb3cyUHkbY
         gwyGyM15Is/d40u/cAhY9lELrJAdDh0Ew+vTBzO6F76rbyG/RfjMHIGwPfNlr9fJE1k5
         6IRnjfWeU0QLNWZoN9pM2KnZ7Kvv5+BxYTJYHilgPdMf+xlEEdffv8ZHPzaz7Le34jDT
         7PgiGPfCV6nDyqAmNdchDS5rcu39xoHkEtcKjBx2ttiUYf8QJjUjLgjg1U4Vh/k1nHOG
         F8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775840993; x=1776445793;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=90/3zxIyEQAJ+2qsKxTylxgOIicIZrZQy7FspHiE6rQ=;
        b=Z9phZ+DaJd3uAoXZzcoxegDI9cbP2rYEpgOxlRLKHmrfbommbgFk7nAlN8vQmFf5aD
         Rtc+0/HARvkzMVSRTziv7GHKked2xahz9ynlKZvKV13n7TNhZBmdGKWvpXQS57vcTROl
         lNsO4EDybUvJXorKmE0tqa8g46Auiyl6ulriv2LK/FKX8FgnRozJc6mohfFzHtAWoSZo
         PcVQ/tTXe7F77kO0hzlfegX8XA/V2vhXzUkdo6E4SDhBtRLWpamKD+SI96BqrM87sNNm
         MPuUXBaO5CR0xl06IeTXV9H03RevZo/+Y7QiYgCLS8suU+8EZfw0Z4dGvNxNlkIWpQNz
         iK0Q==
X-Gm-Message-State: AOJu0Yyq545pAwT47ICflfQb5FUF5/BFnD6k4APXpzHqzj7nj/r6lcoZ
	hE9aKI3fqr3cUTyt9d0tHxy7VEbUhnZgK0qkm4wU4T3kENNWCD0pGa+x
X-Gm-Gg: AeBDiesGrJ6+iXwg9XSuMEnvtbn9vwoyDEI0Ob+Z4lPc+czf3cfQ0xAyTvAMJR6gZfb
	Mb3O/gVjjBxVlMbokeUT2jl8AlomN98nQqmOs5mcmffb3El5b+msJWFsq6gRipxNG6ctHxh4s1/
	gV8xXxgVFK3l7tmudnWzasdo9M5goM4yVKCyRDygPewPw1fPowOoGkwWCIE2f3dwznJAV0ECGH0
	wygq0QxROMq4rEV6s6fjStvdbRVII7tqW1HwJeyty4KflVb6dVSBfYVYVmACeru/Y5n/xD2PvaB
	Jvb9Ysvgww/bXbV/SWoKaIVL/efSrvbKjizFq8IwKMW/p/47A7RkK/mRQ1aVO722CKfhfd/wSX4
	QG7+4TGGdpMEEJV6DmHIN1u0hMwTflaPiMpoG1EEyyy5D1yLt4BZ1ephyTkheRGIGvUs7NAJVfu
	1QKTen+t5CeAYABRWEDI5hHJY=
X-Received: by 2002:a05:600c:c088:b0:486:fa35:aef2 with SMTP id 5b1f17b1804b1-488d67bf744mr38005135e9.4.1775840992717;
        Fri, 10 Apr 2026 10:09:52 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5b3c597sm82647855e9.12.2026.04.10.10.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 10:09:52 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 10 Apr 2026 10:09:32 -0700
Subject: [PATCH bpf-next v9 4/6] bpf: Verifier support for sleepable
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-sleepable_tracepoints-v9-4-e719e664e84c@meta.com>
References: <20260410-sleepable_tracepoints-v9-0-e719e664e84c@meta.com>
In-Reply-To: <20260410-sleepable_tracepoints-v9-0-e719e664e84c@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775840983; l=3396;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=1fyHrscJQBJa8L2lP0qsAiHPeEWMu97S4XOcXjNUgSw=;
 b=ZIKXDasm/K5VTuMEpFAafvPusEdMclkcygQHvBXChCmJWV/Z37XTpgxxMXieFWhkQlRJrX1SZ
 8Awapl7jN1KCzzWcoyTRxmcERPIX6xNaY/DR7YVwpTbZYhJRUQwk9aR
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
index 9c1135d373e2..fcb497fc293a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -25753,6 +25753,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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
@@ -25969,6 +25975,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		case BPF_MODIFY_RETURN:
 		case BPF_TRACE_ITER:
 		case BPF_TRACE_FSESSION:
+		case BPF_TRACE_RAW_TP:
 			return true;
 		default:
 			return false;
@@ -25976,7 +25983,9 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 	}
 	return prog->type == BPF_PROG_TYPE_LSM ||
 	       prog->type == BPF_PROG_TYPE_KPROBE /* only for uprobes */ ||
-	       prog->type == BPF_PROG_TYPE_STRUCT_OPS;
+	       prog->type == BPF_PROG_TYPE_STRUCT_OPS ||
+	       prog->type == BPF_PROG_TYPE_RAW_TRACEPOINT ||
+	       prog->type == BPF_PROG_TYPE_TRACEPOINT;
 }
 
 static int check_attach_btf_id(struct bpf_verifier_env *env)
@@ -25998,7 +26007,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	}
 
 	if (prog->sleepable && !can_be_sleepable(prog)) {
-		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
+		verbose(env, "Program of this type cannot be sleepable\n");
 		return -EINVAL;
 	}
 

-- 
2.52.0

