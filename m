Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DCE3148BF
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 02:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775009813; cv=none; b=Bte/6mHd/KynpKVWQ3hdvv0BSNjgrgRMr2zyf2CKNIVt6qDDYr8J5uZDEiCQxtwrOEDNz43/LT/PlDvQMx4ElvK19wdj+hbsZ4wGlanfvCTGcRZmzWO6wXQFVTfcDp56tKrYohFknY868hs+pwfeW5wfr8FcEawmv7WBaSIRP7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775009813; c=relaxed/simple;
	bh=CDxhrmYdJjo3XlbHE/0MudHjYBfc/MJfXgvDPf2198w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NM/E3N8FB5QMHfRmVNqGENGotWQZDjzPiIvt4NH3WDJoNfTrQK0lUAijnXhEK4EjTf7fut5bmqAFf/QUhvRG3NfK57yS3kXXXJ4rwuCKgNe+BBIUMXWKRWmpJR+i1cdLTGd8eg2x1hCNHSjBklPWB/LXhE6X+aniV4XaqvPkUCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fvq80OnJ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fvq80OnJ"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35c206f0481so5926379a91.0
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 19:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775009811; x=1775614611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdlTb6HQImjBHDnnyNpemqsDpk9SwlxfGYi0JMBPxtM=;
        b=Fvq80OnJXd0vEfbb1pbt8SKBwo16aE7REKmoNRHN199DGFzv5RqbKbx+fdE3kQXhQc
         IHBk/rZ9k4OWPqjVoF+vN1P0A00jm1zyM2zIEsU132FBEh/1l8lz59vlQRPvh/3vqR8l
         etZ6kfwqoTbMTcW/Xlhq/uA0jxK6eOTVuGRMW1Zdhm5qgqeHC4gH7c/Se1XhrfvOpq7f
         BBHBRcTsMn4/paSOpK4D/uA2j4VasfEVp8m+zrKPoMuYuO6aq4k8c2VE2tZXdYzLIsqI
         2kVxn4HtvI+T2DVA3Q4mPF2Ejq7L6BcbQs/6ntYB6hNhQctMKFcPByJcMY2nlBxryhiw
         A+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775009811; x=1775614611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sdlTb6HQImjBHDnnyNpemqsDpk9SwlxfGYi0JMBPxtM=;
        b=c6cM4EtGJChB2MLvEMqd658cmavxY7La0D2iL37N/QiZHphl0lfCJ2khzEY3+YAwSx
         rqbS1/3RjBAQjuLQWBmT9Lwa/h8eW3PD+z5Tmd9a+EFGjGpGn1uunaRqevWZzwxyUTo1
         6R+n2vg2M26mV/E73r4FjKiEJed51vb2cQl1fXgkHWjigpYGYEcm/reMBYKc84+3d54J
         Rc84hLKg2H5hSe5cpBrjC4IwPSktW/Tl0DiAlb9ofSF63LF9RTHoNn3yNDTQhY8Ek95d
         4+rtm4b5w1WLBVdwcDDN1v/LDl2QcmPo2wS2F2MfHYUXp+DvU/GbeK0uSMg+SurXYc7v
         8uVw==
X-Gm-Message-State: AOJu0Yw///5gpzGkU2rcKDsHXFgZiCvra0YvyzEErgUn8R2DbeuiaezQ
	xw+UmPrjYGMGEjE61Lym6irICqiE8HPswX+Kq6MzXMuvrhd8/Zi+DZ2qAXScSw==
X-Gm-Gg: ATEYQzwzZUhDbadWowEDoJTTqy3GFbXrSML2Ed9xGI1wISEcrJ2Am9tn0YcRvK6sIwM
	5AXoEcDK1nG+b0WWj4M8bvETD0EUQ7WDs3AvP2oA7ULqqviVJgdaz0U5Wgn930fiJ5Iuvc526ys
	cdKiTBaX0gl6Q/mJRxWOSc30w4B2/9nuX/NdjC+KObKg7v8P33lTCA2Gczys7IkaZ+YifZfvjNA
	LSCOaY3nIf+MPX3hpBaoj/N7aZZj9cfo2k+Yp9CNBvFkmMmE2SrEPO4M56PP1UqIenYzIXulVjm
	a8AA6/HtrmPlzbtSw0fjng99PCUAfmAytlcM36/J/M9cVx9xeGLIuu89a4UfExqUaaYUgMcvYvn
	XJAJ2x3i8DralDu1DrbAn4m1mpDM6BCmjqN5RXaSFqLGc9g9U83cmAlcyzkmrbiXjzlcH3hzTBn
	3ywxGdgZwzLiFYgJRyuGQ0LAgNqizoXjIhNjy+qkZZxIfn2QqDxPxi5rb0n1n7ql2nvQpFA1RIO
	UDPTcAruTwlmsOadn0K/0crpUD5rNXV6qG7NrJRdPA9yqA+RrCRHWtg1fUUNA==
X-Received: by 2002:a17:90b:3e89:b0:35b:b52d:f34d with SMTP id 98e67ed59e1d1-35dc6e35ecbmr1650370a91.5.1775009811108;
        Tue, 31 Mar 2026 19:16:51 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe637393sm3021766a91.7.2026.03.31.19.16.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 31 Mar 2026 19:16:50 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 5/6] bpf: Move verifier helpers to header
Date: Tue, 31 Mar 2026 19:16:34 -0700
Message-ID: <20260401021635.34636-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260401021635.34636-1-alexei.starovoitov@gmail.com>
References: <20260401021635.34636-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Move several helpers to header as preparation for
the subsequent stack liveness patches.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h | 30 ++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        | 32 ++++----------------------------
 2 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 0d797de30a3a..3fccf61afbc8 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -877,6 +877,31 @@ static inline struct bpf_subprog_info *subprog_info(struct bpf_verifier_env *env
 	return &env->subprog_info[subprog];
 }
 
+struct call_summary {
+	u8 num_params;
+	bool is_void;
+	bool fastcall;
+};
+
+static inline bool bpf_helper_call(const struct bpf_insn *insn)
+{
+	return insn->code == (BPF_JMP | BPF_CALL) &&
+	       insn->src_reg == 0;
+}
+
+static inline bool bpf_pseudo_call(const struct bpf_insn *insn)
+{
+	return insn->code == (BPF_JMP | BPF_CALL) &&
+	       insn->src_reg == BPF_PSEUDO_CALL;
+}
+
+static inline bool bpf_pseudo_kfunc_call(const struct bpf_insn *insn)
+{
+	return insn->code == (BPF_JMP | BPF_CALL) &&
+	       insn->src_reg == BPF_PSEUDO_KFUNC_CALL;
+}
+
+__printf(2, 3) void verbose(void *private_data, const char *fmt, ...);
 __printf(2, 0) void bpf_verifier_vlog(struct bpf_verifier_log *log,
 				      const char *fmt, va_list args);
 __printf(2, 3) void bpf_verifier_log_write(struct bpf_verifier_env *env,
@@ -1109,6 +1134,11 @@ int compute_postorder(struct bpf_verifier_env *env);
 bool insn_is_cond_jump(u8 code);
 bool is_may_goto_insn(struct bpf_insn *insn);
 
+int find_subprog(struct bpf_verifier_env *env, int off);
+void verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *insn);
+bool get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
+		      struct call_summary *cs);
+
 int bpf_stack_liveness_init(struct bpf_verifier_env *env);
 void bpf_stack_liveness_free(struct bpf_verifier_env *env);
 int bpf_update_live_stack(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 493f6acaa386..88285fae21fa 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -256,24 +256,6 @@ static void bpf_map_key_store(struct bpf_insn_aux_data *aux, u64 state)
 			     (poisoned ? BPF_MAP_KEY_POISON : 0ULL);
 }
 
-static bool bpf_helper_call(const struct bpf_insn *insn)
-{
-	return insn->code == (BPF_JMP | BPF_CALL) &&
-	       insn->src_reg == 0;
-}
-
-static bool bpf_pseudo_call(const struct bpf_insn *insn)
-{
-	return insn->code == (BPF_JMP | BPF_CALL) &&
-	       insn->src_reg == BPF_PSEUDO_CALL;
-}
-
-static bool bpf_pseudo_kfunc_call(const struct bpf_insn *insn)
-{
-	return insn->code == (BPF_JMP | BPF_CALL) &&
-	       insn->src_reg == BPF_PSEUDO_KFUNC_CALL;
-}
-
 struct bpf_map_desc {
 	struct bpf_map *ptr;
 	int uid;
@@ -371,7 +353,7 @@ static const char *btf_type_name(const struct btf *btf, u32 id)
 static DEFINE_MUTEX(bpf_verifier_lock);
 static DEFINE_MUTEX(bpf_percpu_ma_lock);
 
-__printf(2, 3) static void verbose(void *private_data, const char *fmt, ...)
+__printf(2, 3) void verbose(void *private_data, const char *fmt, ...)
 {
 	struct bpf_verifier_env *env = private_data;
 	va_list args;
@@ -4260,7 +4242,7 @@ static const char *disasm_kfunc_name(void *data, const struct bpf_insn *insn)
 	return btf_name_by_offset(desc_btf, func->name_off);
 }
 
-static void verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *insn)
+void verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {
 	const struct bpf_insn_cbs cbs = {
 		.cb_call	= disasm_kfunc_name,
@@ -18532,17 +18514,11 @@ static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
 	}
 }
 
-struct call_summary {
-	u8 num_params;
-	bool is_void;
-	bool fastcall;
-};
-
 /* If @call is a kfunc or helper call, fills @cs and returns true,
  * otherwise returns false.
  */
-static bool get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
-			     struct call_summary *cs)
+bool get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
+		      struct call_summary *cs)
 {
 	struct bpf_kfunc_call_arg_meta meta;
 	const struct bpf_func_proto *fn;
-- 
2.52.0

