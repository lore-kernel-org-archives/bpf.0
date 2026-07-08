Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FFE227EB9
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 04:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783483672; cv=none; b=C9vh2nEQC3lMD1qvXsXexy4b9w6K9MWkGV7Dae2yj0KwMnbmc775FRS1yU/ugvuUxbnbwvhx+GSE3WKZjDMi/SlzPHE8fN6EV7CRIECppV9m7cRzYoIxBcYHTaRyERaZkAgzUJ9Q1+p/hZ4Wdfdw6zUrSUZ5L9v1HCT+VIs6v7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783483672; c=relaxed/simple;
	bh=8swmYAR+/6otHc1Ryp6mIjsbVwj3FwgWMUXpva1kH0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NS1wkw2t1ZMt8SFFS4NiZS46ZWSI+eeFmF/UyuFBenFbLEkH31eQLY+0yh0S+lmVkBgfeDIJOgCCW9w9ZHnvJHfExqv6q4s1DWhHkP6I2WnGQla3pmKok+a/zo8loPLQizfvA+qJDXDooLZQ3s9E4khZoYW6YJD3ZIIuKlaWhDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Extl9Ppk; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Extl9Ppk"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so270214a91.3
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 21:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783483670; x=1784088470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10qPjWYDzeLxQu8C4TztyEizuK1kElcvmyLTGp2Xdls=;
        b=Extl9Ppk7/H3Htvkicx5cVWCKICnLncvFWiJ2qpYJlJxJ919iA1GZ8EX/mntQ6Hxjg
         erzij1Ugdq0APlQC4tMiwwuzcSuQcypX2h01NyH5JSI1gCXEjOGRp8OsooOPdSMWBQG+
         TXp01aA5Y2HyQ5/blhgSBkfz6BfO+1xOfCN9Ou4KGfL07KwpR+bpp/bAzvdsFSwY/SLa
         G2lacIhT4TrWJeFsZoKRB0guuHfAms6gFFqxEWhASNqY3FNnw1gNcaL8GNQYZRF/Jtwe
         HPyZEl73WTjJ+8aOugZXI28ae9mSBemOd6wSA1NbbPMPbT54YJB3aXApaVNDRW0oiuoq
         sD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783483670; x=1784088470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=10qPjWYDzeLxQu8C4TztyEizuK1kElcvmyLTGp2Xdls=;
        b=RmNvsuWPRUYLw7LNHx3J1wZdykW97sF0KmdrezxJpjzPAlQWAywFuCYk/Pih9foMF5
         ZpbUjbqRxhuPKMcxT6KUrOoIgYNSN/dDPCkPKuquXYa959mJMVaOZ403u77fXA2UCWOh
         ICma3loL+71umB7PpQ848glmOqB90vTCxQOLTESi/2mSZx675kvqYmd9fgJVNU6wlPmi
         YoRkchL0ojgfo/ei0V2kOt9+hVSFu3YIKTWuBOFpHVluAVmclMVhlP5wjyF23pBD0Aj4
         7WfVyheJ4xSOgJUgH2UnSUizDcGEewFiCg9QQxabS8Vj0K5qdlCr+4A662WXsRPNAPDl
         cp5A==
X-Gm-Message-State: AOJu0YzdwWTS9ueQ6PcgwXfA3BNi6+1OicuoFW+QoZbNrPg4R+HxNcgC
	jUFt89prB5JnZm9ma2sRQVYyQ30Uu8XdGeE2Sg00vdggHcad35g13iEEGEReV3hLqkRmqw==
X-Gm-Gg: AfdE7cmb5X073VAoQiQcYfTMG3ckpPzUUGk0xVcbUbAPsjxxJl7GS6oad5KBjj5R3Ca
	lqja5AIPzZCCwt957KW6y6iXN7QlN8aUuGxIytXBXtrjp+SaI2QPN3si21dzMESTIyFkGAEXXHK
	HOkFJxIYvlRenl4MJmugQS+apUwANE3bvbf8Goxe6qVhbMOD9/R25lg2N4Wnq9q0NrDubLm7sYO
	hU8wdKITNmMGxASzPzM2ID+f+oOv99YO1Z/gEXpKg3LcEd5NWd06TkXCeWc9eltor70ev+4dK05
	2Cqr6OjmC5OX0w9QbjFifwbXK8jBAMZd0pV5KKfYybrU8T++kfamhEHsNAjqnYQKY5nzdFSCLBA
	fGnnK5D3suvZKKhk8+l02AWSnzRYAUwaZVdpKUHDFHyFo4wBpHeyEaawidkHvRrkmQvtz8jRsy+
	8KvqHrBlrF01nvOghK50wREBInaCquHNVQclmvvIUdP/H+yVeKaAiF/4RFOI2BizrD42T+r+fD/
	Gkm6YXmnc17IeI9j72CSG8EUu0Z4IolSQ==
X-Received: by 2002:a17:90b:1cc6:b0:387:e0db:3d8f with SMTP id 98e67ed59e1d1-38943d40c9dmr733573a91.42.1783483670001;
        Tue, 07 Jul 2026 21:07:50 -0700 (PDT)
Received: from u2404-VMware-Virtual-Platform.tailf6b5e0.ts.net ([24.4.24.156])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31189cd8234sm4198982eec.9.2026.07.07.21.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 21:07:49 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	shuah@kernel.org,
	mmullins@fb.com,
	shung-hsi.yu@suse.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf v3 1/2] bpf: Reject negative const offsets for buffer pointers
Date: Tue,  7 Jul 2026 21:07:14 -0700
Message-ID: <20260708040715.116680-2-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708040715.116680-1-sun.jian.kdev@gmail.com>
References: <20260708040715.116680-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier rejects variable offsets for PTR_TO_TP_BUFFER and PTR_TO_BUF
accesses, but it currently accepts a constant negative offset produced by
pointer arithmetic.

For example, a raw tracepoint writable program can load ctx[0] as a
PTR_TO_TP_BUFFER, move it by -8, and then access the adjusted pointer.
The access is before the tracepoint writable buffer base and should be
rejected.

Keep rejecting negative instruction offsets explicitly. Once the register
offset is known to be constant, reject const var_off values outside the
same +/-BPF_MAX_VAR_OFF range used by other verifier pointer offset
checks before computing the effective access range.

Fixes: 9df1c28bb752 ("bpf: add writable context for raw tracepoints")
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 kernel/bpf/verifier.c | 48 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 21a365d436a5..28eb5c438212 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5326,14 +5326,19 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 static int __check_buffer_access(struct bpf_verifier_env *env,
 				 const char *buf_info,
 				 const struct bpf_reg_state *reg,
-				 argno_t argno, int off, int size)
+				 argno_t argno, int off, int size,
+				 u32 *access_end)
 {
+	s64 start, var_off;
+	u64 end;
+
 	if (off < 0) {
 		verbose(env,
 			"%s invalid %s buffer access: off=%d, size=%d\n",
 			reg_arg_name(env, argno), buf_info, off, size);
 		return -EACCES;
 	}
+
 	if (!tnum_is_const(reg->var_off)) {
 		char tn_buf[48];
 
@@ -5344,6 +5349,36 @@ static int __check_buffer_access(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
+	var_off = (s64)reg->var_off.value;
+	if (var_off >= BPF_MAX_VAR_OFF || var_off <= -BPF_MAX_VAR_OFF) {
+		verbose(env, "%s %s buffer offset %lld is not allowed\n",
+			reg_arg_name(env, argno), buf_info, var_off);
+		return -EACCES;
+	}
+
+	start = var_off + off;
+	if (start < 0) {
+		verbose(env,
+			"%s invalid negative %s buffer offset: off=%d, var_off=%lld\n",
+			reg_arg_name(env, argno), buf_info, off, var_off);
+		return -EACCES;
+	}
+
+	if (size < 0) {
+		verbose(env, "%s invalid %s buffer access: off=%lld, size=%d\n",
+			reg_arg_name(env, argno), buf_info, start, size);
+		return -EACCES;
+	}
+
+	end = (u64)start + (u64)size;
+	if (end > U32_MAX) {
+		verbose(env, "%s invalid %s buffer access: off=%lld, size=%d\n",
+			reg_arg_name(env, argno), buf_info, start, size);
+		return -EACCES;
+	}
+
+	*access_end = (u32)end;
+
 	return 0;
 }
 
@@ -5351,14 +5386,14 @@ static int check_tp_buffer_access(struct bpf_verifier_env *env,
 				  const struct bpf_reg_state *reg,
 				  argno_t argno, int off, int size)
 {
+	u32 access_end;
 	int err;
 
-	err = __check_buffer_access(env, "tracepoint", reg, argno, off, size);
+	err = __check_buffer_access(env, "tracepoint", reg, argno, off, size, &access_end);
 	if (err)
 		return err;
 
-	env->prog->aux->max_tp_access = max(reg->var_off.value + off + size,
-					    env->prog->aux->max_tp_access);
+	env->prog->aux->max_tp_access = max(access_end, env->prog->aux->max_tp_access);
 
 	return 0;
 }
@@ -5370,13 +5405,14 @@ static int check_buffer_access(struct bpf_verifier_env *env,
 			       u32 *max_access)
 {
 	const char *buf_info = type_is_rdonly_mem(reg->type) ? "rdonly" : "rdwr";
+	u32 access_end;
 	int err;
 
-	err = __check_buffer_access(env, buf_info, reg, argno, off, size);
+	err = __check_buffer_access(env, buf_info, reg, argno, off, size, &access_end);
 	if (err)
 		return err;
 
-	*max_access = max(reg->var_off.value + off + size, *max_access);
+	*max_access = max(access_end, *max_access);
 
 	return 0;
 }
-- 
2.43.0

