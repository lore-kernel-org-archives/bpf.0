Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C60F2BE7AB
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776532627; cv=none; b=eHe651iSf+pGXKMhLNNKbNqV8lRFkAKfnXPDs3blTRVKDykK2KrQHM93zxmO+Nj5Z3qzvmzqujvyFNyD8YgrBCT3TeI2xp3Ibx7OcjH+64FVSQzzB3an67j6oWm8ZWk5mx4AiKN1k9Z+KYbvQove01szRcEYafGgudUfSKQgQuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776532627; c=relaxed/simple;
	bh=gXRHIKFLYEukNjAcwzahlZg1BT7q+4dqDZARyDESuk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6TvEVShYEo5uH0rbUcJLFDyekew10AqChlpPIyYADTRMJG0fhBOpr3LN4YKzNeykTWNiqwgslAihMNq+1kqK2OI4UOU6aHVsRrAQ3Y1ErE/kIHW1pKsTBHt2uoy3YB/SznBFIXIyI9HMdSnUqiFciRjT54tuEURdkQWsxKano4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdfGKddf; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdfGKddf"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7dbd23bc684so1028617a34.2
        for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 10:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776532625; x=1777137425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCEzhbjAa/tL8wRw/GnZGGjMLhmZOW7TTSpKmTmJQ9g=;
        b=bdfGKddfP3lc2+8kVsBttXKOZzhxKStVEMSOaj6T05P80AAuHEbvfsiWkL2xQGLYJ1
         r/dhi+/E2fJSiVSQ3Sj/xX8AZcBxyVlgli2geX+zzMyrJsV1fdBRad1MC1jq76HvAKIM
         2xIwwN573PLRu/0sJ2b6jX8o5ZbpuUQPdwakI9MSs4ilqQcKUx8s77rJa1wqHnKVQlEv
         HY5wg6iF5H/wW+YJPa/PH5cqc6SlCkbyRJFnhNbL8VPzIYCQnkspjIpbT4FAZewzD+dk
         E/zSfsUr/q5lRpnMZJC71NdU/Pk+QfvS0szC65N8N7NelVIAEAXH0S3g39JzzM9oHHBe
         2caA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776532625; x=1777137425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zCEzhbjAa/tL8wRw/GnZGGjMLhmZOW7TTSpKmTmJQ9g=;
        b=TiYZa5pbB67oR26Zs3z5SW9rbJmbj2Sh5UTqiAg/n+V0KXR6/E4BAqsvexrnp7O/7k
         jByPCKeBRWbyZqRRG1geLhuwYDlTgk/S1uAYoUskVRZkNi0yec5SjIO6JgzJlGOnhx9F
         8qGQCnBfq9DTkwDGvIQevTf0RkwnwMI0KD1bACEw6SKr3FGtIMXKmLhfHN/cteiMwV43
         pfF4aP85qOqr8Kk2C72caLa/oET72RtZPAqCIwYIJQDwF7FAhSMNyNud1cEUDbrNnf6N
         zkkdJj5vJbOqt25FIyqwP0FZaR+q+QLO3Froo1FtEJ7vsx9xbZPePvufYIIO3Ko8bh9Y
         bAIg==
X-Gm-Message-State: AOJu0YxRYCSSgGF6noPlllv3oNojV8i3rMrY2AiY83dLWBZP/mQbC4Xy
	EukQLJsBxxKjLecVlRL4aFdofraTmV5DvvWdiZUT5BJeUhPimzP3URg/Y3ennPqtzQVZog==
X-Gm-Gg: AeBDievU4WVXHdCwSCIHkjgZxd3uPgJp76Bogoy5C22qpl2Ls9xPc1mqPDAPGJn0zHD
	bH+F4A0xeW1+arX0ZBOLO4v6eQaXuwsbUeUoAxPqUvta9FJa1dMTA5YEn/9mD8cYq6yS02llorI
	bpuwvZO6ICr0Jb9Uhkz11D3414oc+GDNU9UQVBx+yRAEx7W2bDmywgtO0yW82d3gpAZqKAu926Z
	fJnAlh1MB7SIDMWbfv30peO+AEM/lh8PZWWryGLhgl6jS6o7I7skB4FtTqei8KYlN10k4vxfque
	nS3MfhkukypjcCaDZxR/0qJbQ7oG7gtktq0d9jC6dh/UBHy4LNgQxDQ/lZiybkE0rVjlRXCU/Cr
	97jP0ryMxTF7TgcoBZhZVrJu7sQrM/IgfckV2MeopdwlXzaCzlL9U9HF2m2xOoy0MrwA8H/1GWh
	eU0MrlUcRIgFZZ8G0AVR8xtxg9t4p5nvUNq2OYAQUVMli4i14yTEqjBaiUgW71tx/mZXYwNhfmC
	qeSBwk1GrTHvRyo4pe51M+m2S4ILFY5rP6sn4xMVdltiLBaaL90lxo=
X-Received: by 2002:a05:6830:3709:b0:7d7:d2f5:1d61 with SMTP id 46e09a7af769-7dc94fac1f2mr4755355a34.4.1776532624902;
        Sat, 18 Apr 2026 10:17:04 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:57::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc97503381sm4034677a34.3.2026.04.18.10.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 10:17:03 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 1/4] bpf: Add support for verifier warning messages
Date: Sat, 18 Apr 2026 19:16:56 +0200
Message-ID: <20260418171701.610025-2-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260418171701.610025-1-memxor@gmail.com>
References: <20260418171701.610025-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4983; h=from:subject; bh=gXRHIKFLYEukNjAcwzahlZg1BT7q+4dqDZARyDESuk4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfPxniyP8Px9WZntkWzqXs8S/mxiCjr/VO+Iw6LWU+fvV2vf fuzdUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgImYX2FkeHRQfe7NM3VnFYLvVv+TPK DzpX2Zn4C46ex7Jz7GxDufusfIcCeHb1/9I+2Nu1n9bD2SQp4sPNd1a9mMa1/cXdg4GT/W8wEA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a mode where log_level 16 can be used to receive warnings and have
an associated log buffer. Add a warn() macro that emits messages to log
buffer without any restrictions, aggregate the warnings emitted, and
then use it to decide whether we reset the log or not.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/kfuncs.rst |  4 +++-
 include/linux/bpf_verifier.h | 11 +++++++++--
 kernel/bpf/log.c             |  2 +-
 kernel/bpf/verifier.c        | 21 +++++++++++++++++++--
 4 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 75e6c078e0e7..47d60011d8eb 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -353,7 +353,9 @@ marked with KF_DEPRECATED should also have any relevant information
 captured in its kernel doc. Such information typically includes the
 kfunc's expected remaining lifespan, a recommendation for new
 functionality that can replace it if any is available, and possibly a
-rationale for why it is being removed.
+rationale for why it is being removed. When verifier warning logging is
+requested, the verifier will emit a warning when a BPF program uses a
+deprecated kfunc.
 
 Note that while on some occasions, a KF_DEPRECATED kfunc may continue to be
 supported and have its KF_DEPRECATED flag removed, it is likely to be far more
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b148f816f25b..515afcb83ec7 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -689,15 +689,21 @@ struct bpf_verifier_log {
 #define BPF_LOG_LEVEL2	2
 #define BPF_LOG_STATS	4
 #define BPF_LOG_FIXED	8
+#define BPF_LOG_LEVEL_WARN	16
 #define BPF_LOG_LEVEL	(BPF_LOG_LEVEL1 | BPF_LOG_LEVEL2)
-#define BPF_LOG_MASK	(BPF_LOG_LEVEL | BPF_LOG_STATS | BPF_LOG_FIXED)
+#define BPF_LOG_MASK	(BPF_LOG_LEVEL | BPF_LOG_STATS | BPF_LOG_FIXED | BPF_LOG_LEVEL_WARN)
 #define BPF_LOG_KERNEL	(BPF_LOG_MASK + 1) /* kernel internal flag */
 #define BPF_LOG_MIN_ALIGNMENT 8U
 #define BPF_LOG_ALIGNMENT 40U
 
 static inline bool bpf_verifier_log_needed(const struct bpf_verifier_log *log)
 {
-	return log && log->level;
+	return log && (log->level & ~BPF_LOG_LEVEL_WARN);
+}
+
+static inline bool bpf_verifier_warn_needed(const struct bpf_verifier_log *log)
+{
+	return log && (log->level & BPF_LOG_LEVEL_WARN);
 }
 
 #define BPF_MAX_SUBPROGS 256
@@ -848,6 +854,7 @@ struct bpf_verifier_env {
 	bool bypass_spec_v4;
 	bool seen_direct_write;
 	bool seen_exception;
+	bool warnings;
 	struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
 	const struct bpf_line_info *prev_linfo;
 	struct bpf_verifier_log log;
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 011e4ec25acd..2cf79fac8d43 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -154,7 +154,7 @@ void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos)
 	if (WARN_ON_ONCE(new_pos > log->end_pos))
 		return;
 
-	if (!bpf_verifier_log_needed(log) || log->level == BPF_LOG_KERNEL)
+	if (!log || log->level == 0 || log->level == BPF_LOG_KERNEL)
 		return;
 
 	/* if position to which we reset is beyond current log window,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 69d75515ed3f..8de2a4e5f5de 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -47,6 +47,7 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
 enum bpf_features {
 	BPF_FEAT_RDONLY_CAST_TO_VOID = 0,
 	BPF_FEAT_STREAMS	     = 1,
+	BPF_FEAT_VERIFIER_WARNINGS   = 2,
 	__MAX_BPF_FEAT,
 };
 
@@ -282,6 +283,20 @@ __printf(2, 3) static void verbose(void *private_data, const char *fmt, ...)
 	va_end(args);
 }
 
+__printf(2, 3) static void warn(void *private_data, const char *fmt, ...)
+{
+	struct bpf_verifier_env *env = private_data;
+	va_list args;
+
+	if (!bpf_verifier_warn_needed(&env->log))
+		return;
+
+	va_start(args, fmt);
+	bpf_verifier_vlog(&env->log, fmt, args);
+	va_end(args);
+	env->warnings = true;
+}
+
 static void verbose_invalid_scalar(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *reg,
 				   struct bpf_retval_range range, const char *ctx,
@@ -1683,7 +1698,8 @@ static int pop_stack(struct bpf_verifier_env *env, int *prev_insn_idx,
 		if (err)
 			return err;
 	}
-	if (pop_log)
+	/* Preserve warning output across branch explorations. */
+	if (pop_log && !(env->warnings && bpf_verifier_warn_needed(&env->log)))
 		bpf_vlog_reset(&env->log, head->log_pos);
 	if (insn_idx)
 		*insn_idx = head->insn_idx;
@@ -18803,7 +18819,8 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 
 	ret = do_check(env);
 out:
-	if (!ret && pop_log)
+	if (!ret && pop_log &&
+	    !(env->warnings && bpf_verifier_warn_needed(&env->log)))
 		bpf_vlog_reset(&env->log, 0);
 	free_states(env);
 	return ret;
-- 
2.52.0

