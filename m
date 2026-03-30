Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0D63E2752
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 22:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909239; cv=none; b=Z+Tsc9Xn/Ch5OWxnWtwdanbX6AcONp7Aayvht9Lmnp24Hgjg6VrgOB8X7gXtlXxVB1OOh+7ED8DIAXDrEmilsbA4fSkFTpGsDWsOpr7cfbA8L2ZY/BN09BXJB7Uc2+Q8PeIQ3ESbIjDCM1mhC+tqs9ZYhC9L3YQHaxhC9+EwVzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909239; c=relaxed/simple;
	bh=EHHrio0iG3Cj3F4MFlAQbAHvRNthH5DG823oKzHsqZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fGvpSWKzkpyXQl1GacrJlbk4kZAmJY+ePyV3o/PN49mI2DMLz/lek0+EfqJkpNt1OtWmE1aSB9GwGyFMEtKxYYh8ELce4FPFQgWsAcOfokXCtcDZDfzghjFW6nTCJ1WofHUoYcHZMEKEFetopP2iCsH9t7oVZACz6zLWBU4Ygh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9D4zwps; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9D4zwps"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486ff201041so49677365e9.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 15:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774909231; x=1775514031; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gcBnXzu6ezinCaJL4kqD0rP5JRLO5GSx8RDAqgog/Jg=;
        b=V9D4zwpscMTSrf7/Rzpm6PO2W92TSU0hMxVPIddzNaOEfi+KA3ZTx/fykNdvcjjl5G
         GloaCMIg1t/lxuX+PBIC04K0cH0Ng356m+eGjZvpgpmigd4E02u8a3/ljaFK0RTdhUpT
         easf/trFs3oSxnBKt5AZ0psL6iQTFS8ZsiIB8Nk5hqLDsZHFR8+5VuGxzdNyH/GwyEs9
         d0olFp1VX4Q/If9eXN2Eds7sqAsnS6t/fkB8WCYxAkjVZsejNH032UWaiLvmQJgBOjzZ
         q5sicnEfWnJeZle4OLom27HmMf7eMy8kNRg8YyfLiqBU7JucD3ekzp6ElyM9DE+RPKH4
         gZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774909231; x=1775514031;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gcBnXzu6ezinCaJL4kqD0rP5JRLO5GSx8RDAqgog/Jg=;
        b=WT87Ilt0g06AcNmOsGK2Q203qTTO/d/ea68FdHTf4gxduQpN4yffAAmBd731m/ET2j
         IloNx0Ti/D5jrjqEVtzfQRT0UlG+NqmvFEOms013eC4hL8lYuLYVqIgtknJ+Wfr8/Rsp
         risVufn0cLPKCNMYfdr5Vh/KdZrbwdspszxKdHSGA6Z8IPLak6mimHeCxzgLCgbFIr5S
         TVzV1zCYwXVX7vyQkgEoufTV3t+3V+0pzWwmADZsJfikrrn5KFxiXQl44qeYgfNYgoZj
         itNGeI0BRHLW8Rot6RpASmqbEVATtbQHZzBrBZ1pV4U3kYK6eF+LjGyRWL/jw9wmKUrS
         rvyQ==
X-Gm-Message-State: AOJu0YwjWcYvWL8YxLU1bCjzd0c9+zJi4qhiRj8Bwf57iI8kFTaPFl6G
	Ecu87I83IpSc69WaraQRWdw7KmJUOxGvRW1gB5xRj9TEInaYYehheay5
X-Gm-Gg: ATEYQzy9x3uMlJxT9CMqglF9qwcikIZSiDFIUTCuvusvbMYZ0HVdbT/i1bEjVkNNsNo
	AWVXrH4xXTuxUsbGUs3JarMaANvwiou9oSjaVtHOijtK5mLAJ8Kd84k5mK4pmpQBGBqi09r+/oq
	CwkN2i1xY5MpqmwtLRRNH3m+5wxShGxSQMLidVLtATvhFC07Ie1edO3YcxElLfv6Z3rd0MbPejY
	3qiJ6pi0rEw58jfqT/VZhC5fA5MgxbdwTeizpldMZvmEF/0eODejG8ugPzXArvSJyRywDLEyGrb
	jaO89MOcjb+P+8D9hZT5JgzZ23YuPdupMVbiWHfAKl6NMb4zbKYsffdbs2Hs+cJ0PyqdTZdpfC+
	2Ym/9SICuPygwEDQLQUBAShx+VyGw/lg4Y8vCgMdF6Cwbt3XcQjElN2kSO7nqiITPUgxI+GKHaY
	u500wBOyjBaS/U2g==
X-Received: by 2002:a05:600c:c113:b0:487:1114:d431 with SMTP id 5b1f17b1804b1-48727ec3c36mr180770065e9.18.1774909230340;
        Mon, 30 Mar 2026 15:20:30 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873062ee36sm204556335e9.8.2026.03.30.15.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:20:30 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 30 Mar 2026 15:17:27 -0700
Subject: [PATCH bpf-next v8 4/6] bpf: Verifier support for sleepable
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-sleepable_tracepoints-v8-4-2e323467f3a0@meta.com>
References: <20260330-sleepable_tracepoints-v8-0-2e323467f3a0@meta.com>
In-Reply-To: <20260330-sleepable_tracepoints-v8-0-2e323467f3a0@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774909220; l=3412;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=rMFmeX/Kr1QIYfON9aGi9giW5IDGvio92KfTbBOv5OI=;
 b=ZkmVePhWF7gPocejvwhGplrCwf6hzNduLL4PZkqi53yc1ji7muBoLyT9XMnJOgc+Ec9inXtLf
 PClA3LH0ZAdDiG4ooirf9NRgJuju/uSDB/kW/ggAgx5/sqBs9dN/Tse
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

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/syscall.c  |  5 +++++
 kernel/bpf/verifier.c | 13 +++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 51ade3cde8bb..047fafaad4b1 100644
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
index 8c1cf2eb6cbb..ddf74b9fb5c6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -25339,6 +25339,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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
@@ -25555,6 +25561,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		case BPF_MODIFY_RETURN:
 		case BPF_TRACE_ITER:
 		case BPF_TRACE_FSESSION:
+		case BPF_TRACE_RAW_TP:
 			return true;
 		default:
 			return false;
@@ -25562,7 +25569,9 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 	}
 	return prog->type == BPF_PROG_TYPE_LSM ||
 	       prog->type == BPF_PROG_TYPE_KPROBE /* only for uprobes */ ||
-	       prog->type == BPF_PROG_TYPE_STRUCT_OPS;
+	       prog->type == BPF_PROG_TYPE_STRUCT_OPS ||
+	       prog->type == BPF_PROG_TYPE_RAW_TRACEPOINT ||
+	       prog->type == BPF_PROG_TYPE_TRACEPOINT;
 }
 
 static int check_attach_btf_id(struct bpf_verifier_env *env)
@@ -25584,7 +25593,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	}
 
 	if (prog->sleepable && !can_be_sleepable(prog)) {
-		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
+		verbose(env, "Program of this type cannot be sleepable\n");
 		return -EINVAL;
 	}
 

-- 
2.52.0

