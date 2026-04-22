Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38BA370D6B
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 19:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776886956; cv=none; b=G7yVx8p6K94UqQqPonJjdOxpF/IJa6jCB1jVuc/B/zLPZAdvo58CqGk11/x+gLJtfRo8MKaJasfR/KrhmROD7jJWCKUme39i1k0HRXboD53qx+Qr6ZOW4AsjeWNFJK3PQRgyIW5dRY4ZJ+n5IQVhJTw4tIvL9dcx+TuyXMV0kLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776886956; c=relaxed/simple;
	bh=+SaPuX5M5TsULTI24qI/PzgrfyH8QWL/gtsCwfhWgUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qsZIwgQJYgarcpwinr7WdjTeHmju0EWcTSL1jg/KQcq1Rasgb/JM1mt4m9gKW03UTRTkIT5zjHykaibplxzG879F9DqvrvAn70k9Q19dboPqLxUq2guxmwwLUIcoemh1UfImz4LLX8GKEhEKMpo+B/1/HOh7EEAwiZwhaST1EEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwBJBJx6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwBJBJx6"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso61146385e9.1
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 12:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776886953; x=1777491753; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DG7r+fX7s1omhIGpgcAgCpvP8cdsVkiDmcfQ39W2x2o=;
        b=LwBJBJx6lLQpUMTmkka3CywsxZ0P17MlfYMMqTJo7vCpAhSLSv1wbXslZEOpeS5ub4
         +e5d83GbMn4eJvVCWOteaEGG/OFdok+lkr6UDt9q/eo1nyyVPCW45PX9B6uk/fH5hWEV
         s9uDbXP3w008Y3FkvIV10aRFZIb6RiwOamXnTGb1Dvm8SBlJneZ/hwb3IX1wlJssE2gU
         +NT91Vyt+BINkjXJhTSkjglEA/K/IBL3+WaOGj2b8oQ5EgI0lmfRLsTBDOxXWS/P/lv+
         J4xl3Ss8ZIZEEDTZ4Kwvkl2eOXlOvG8sj0U7xMZMCzAXx8Wypu1Gyuf4lHpVpNn3+C9+
         +Qrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776886953; x=1777491753;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DG7r+fX7s1omhIGpgcAgCpvP8cdsVkiDmcfQ39W2x2o=;
        b=LKydmY1Zt56w16dBxx91Pbv/IysHvsq8WKhMm4QGHqNxjjDnV40h4HQj1Us7fsjVTZ
         KmAB9rYzLpWrTDKJh9dIC+tND046jPj1MTdRKyw5iSOKUHzqi/CiwXNJMQXCoXWeDbVW
         ADvdpCe0klbxbUwcoqaVqhbdPzugHvvXtm8BMqMh6XltnV52ES22mumSVEnMLZNdDliS
         yJTrjLsVdB73QI9jJHG+2lDLa2icHjCz2rtRF7LW66cnP10xnmqEjDTXIihR8xgopV75
         h6X4WFiMcyxT6FhNnldk+Il4h2dhV7ifVBTnqy8jf0lULLKf9/pgR7nubZZNbxcD8riI
         ZLkQ==
X-Gm-Message-State: AOJu0YzkUMFQMOS3h4tqaERzg8K8dKZi3lJ9ZgZY8sVm+jl3sHTCZjJM
	Wmcid+GQJfjQlM3eYdu6E/tmix0W1ylG1I/b2Jmt6yjd7a9qxHSh1tbD
X-Gm-Gg: AeBDieuoIn5GKOuEbdNO+GA2CM1lyMULsVkRePFnYD0kkEE5RSvh6osg5idYLovt1Px
	1RU7YaMslxo6nXuafjrJdQDFETmgEr1r1Hzp0YPidB2aOQft3oxFqbzev4WX0KXrGT4UDLHsC0V
	zfTwynAuAZfkJj1C2Q03Q4h+6BmzfJBKWGGEXaaRGgUfZasrQ1dmSz0CmDjkqX/nCKC1s+eWaVs
	tY+jB/MS1/ODk+gqX5JRNgFp8czZObSwRKilo9yvgyy6/tqpOjSeFN7pA2D8UqdyCw/yHEgu8BL
	D1aTB7MpE1iR1Um2GZagSi+0z1ImDM18YyD310tKDPdgNZJzm6RlKeOuSOWCmv8lEWouU9LkSpQ
	pt10zlB/r20i4lknC7MUR5mJl6BmUzYd5Ojm2zB8CYHVm0f23ru9xiBx9HvSDrwrxAHcFPKKOlJ
	OnIPyRvL8w7QOEzRYne4sGd8oL
X-Received: by 2002:a05:600c:b96:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48a53390f6cmr145082415e9.9.1776886953139;
        Wed, 22 Apr 2026 12:42:33 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc10777csm532272175e9.8.2026.04.22.12.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 12:42:32 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 22 Apr 2026 12:41:09 -0700
Subject: [PATCH bpf-next v13 4/6] bpf: Verifier support for sleepable
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-sleepable_tracepoints-v13-4-99005dff21ef@meta.com>
References: <20260422-sleepable_tracepoints-v13-0-99005dff21ef@meta.com>
In-Reply-To: <20260422-sleepable_tracepoints-v13-0-99005dff21ef@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776886944; l=3405;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=Ac5+kVuTHMmxd2jh/8dcKeAz+KyadOU0D2xIptU5iu8=;
 b=loU/W1hjIHY5qN/OcpHNMK9319zCR4ZkhbivzJf2r7V+sPY4zI0ejoUt4jaXvY4zXeBKv4iW3
 cS912QvTcI0A7d0ODuGBfX8P7plfU8wTJrHedT45HV9z/6nhm/WKYDg
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

