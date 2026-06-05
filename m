Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A8840F8F6
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641275; cv=none; b=gYeWuEmipny/kZXGss/099nUFiLziqIpkQJXNVUzyArMWPYA8C27KxR053MvCo0Nw3AGRLxe/gug8xdjuqtjHmlORiyms+Eu0JM5w9M5DRocWsFVAtW9/tG4RNbN3pU65jnuirqe7iN5URI9fp3+x1tgtYw5jSAKQJGLNEklDHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641275; c=relaxed/simple;
	bh=K2K2rE5pXxubjQrMs130zleMtJqZKKTYvk5pm1ZVZrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XrfXBjpAdWdpriAKO3v0LJgO0nKqt5L8C5q7igpvCfiTkEX6N5e4mxcwxLH0UL5cuu4+aHVHR7XHzQ0Q9eCCvZ0YLIPsCugr7FfuafB3Fci5yn2D9U/XUnhBRhHzsK8eCmz9n4QjRMTWd4x+qEUuMbts5GSteusKI2QFpyFHb2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rx1uY8Q6; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rx1uY8Q6"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-4600ddc4017so1166715f8f.0
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 23:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780641273; x=1781246073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1XFCDgyisbKq2bSLcQdBNHZ+HkUNCw06nQ1l443S0g=;
        b=rx1uY8Q6c090B/E41myMuIeIxgLA4itmSSzKb4dXFNkHeOp9Ong1r6t9xjWwGLNnG6
         nGpUef3fjPeBaxJTHA2kWwqohu0x1MJ8BEyaIzJH68jTWzjbZ5pHln4JJX4xwDhtVmm2
         Hm8DWDkZKREKTgBLEkuEltHRkOgwoWKCZc83bMAnyXUbPDve/72ATKleNiDSvo3+rcLU
         OyFX/uGoruM9OhWrjGWKOOSRg+UJkRU7SLouFRTo3+7VrGH26fNpN5IWBmWtwx9eg6i4
         op1lvMBE2U4DIdUznX4sttPjjqSSnX42h9tOy06PaYym9/CmLPUcYP6eWueJz+QfgEzr
         5Dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780641273; x=1781246073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b1XFCDgyisbKq2bSLcQdBNHZ+HkUNCw06nQ1l443S0g=;
        b=KUcXBgEGTlsafUVi/50bbmy/qjFaAYx25hjRKninptSFzMe49CaK5XyrFxcZfGIt10
         MuFNZ6x9ccjBMtjss+Xsr0IeH1beFLQDUwqHzDxQEsG+RMviBwUaW2GjHpJqrXxeMUTS
         6yMsHR8neQC1HrHXw2KFYhk89djkXPOSoGOF9/Y1wZUXqKBya7DHaBH1UkmRtNTDtRxW
         yAj1nr5ZgeXRuzUwRp12JM6Dp87lUFBZ0VJIIiSRcOPoxFIcpwl4dEyyGxLOqmrCnXJU
         yXHzCEO2TnEHdquHWUSl2v/xnrdcjDCr80GSSV9K+Q3eHZe9ScfbuP8t5vpeZGt4Msv9
         jLqg==
X-Gm-Message-State: AOJu0Ywe3i0ScNia8JaCAvqfXHV9nis6aKHnW551HCwLlv5UEQGxsnoF
	aRlPwt5a8ukB7VYrOf/jMUICY1Zequ1E8k34LKuMCgQ9Ykf6DjeTrT4rdgLrrfxV
X-Gm-Gg: Acq92OHI4vuVf1XPVCPrkn4/bz5zqcr/Rz/5DGr3aiLX07THPArHZEZYIswaFf6pGWO
	ypRJPPjgkOodMgxActtM57CkwrvIj+TP3Upgvr7WJtIwQMgaqx7BQ/Cmm3zY3zP09Heoi8A9zgY
	K7mrsk3H0ASrbL4I4eaMwoVrojYI0Q6v2g8n4XhDuCXrqEJliomaTlgMiPkcsMZq0PU+IYqd6Fn
	kMlU6phK20TtCTIpr/5fcudXz1uZvHsWsKIGytIAJ7T2De1dMS92x2mQotTgmL3gYrKGd64airG
	Jm4fs4GmcCJ5zB6SWJOPp28nQzcHWVRScH2/Ycqu8gls/4o325AMAkzEquiu+F2XJ7AISX5orJM
	lsM6Beh4Mw2ZGSw+eUo2/r8/b5G0b5NEWDDzCMTLBERPqiKIvNkTELoqpCBswPasXuIzbFpnJKT
	cY8C6/0C8IpzDha/l0WrsjCP/WJkkzXz6X+1dRiu5g8cNf1DxwCjmGAqtReloDB/J9Vl5JBe8Bl
	SsitEUo6yM4iNC+MkFNiccssZ+idIqUY92jS8PHwugrAj3EJlg/loz+pwUtwZ+Whpbjag4gxF9i
X-Received: by 2002:a5d:518b:0:b0:441:1e41:19c with SMTP id ffacd0b85a97d-4603050194dmr2214986f8f.20.1780641272872;
        Thu, 04 Jun 2026 23:34:32 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda3651sm10128437f8f.32.2026.06.04.23.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 23:34:32 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 17/17] bpf: Gate verifier diagnostics on log level
Date: Fri,  5 Jun 2026 08:34:07 +0200
Message-ID: <20260605063412.974640-18-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605063412.974640-1-memxor@gmail.com>
References: <20260605063412.974640-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4676; i=memxor@gmail.com; h=from:subject; bh=K2K2rE5pXxubjQrMs130zleMtJqZKKTYvk5pm1ZVZrU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUspt6y1qLCJJ+Jj6p8NpwOLVaak12+8ILnUd8nFxzk1D GKVt3d0lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCIX9jEyNOZMUjdp4zwi/SrB 7t18/rl1FdcNdGVfrq/eGaBba9I2hZGhe0d0bWmpxNXNwYqLrb5s/mjOqXL7W+uTi94T1zVrlJg wAgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Verifier diagnostics collect per-path history and render richer reports for
selected verifier failures. That work is useful only when the caller requests
normal verifier log output.

Do not enable diagnostic collection or report rendering for BPF_LOG_STATS-only
loads. Stats-only loads still need the verifier's summary counters, but not
the extra path history used by diagnostic reports.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/diagnostics.c     | 33 +++++++++++++++++++++++++++++++--
 kernel/bpf/verifier.c        |  1 +
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 55921b8a5d5c..ca9a8620955a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -526,6 +526,7 @@ struct bpf_verifier_state {
 	struct bpf_diag_history_event *diag_history;
 	u32 diag_history_cnt;
 	u32 diag_history_omitted;
+	bool diag_enabled;
 	u32 dfs_depth;
 	u32 callback_unroll_depth;
 	u32 may_goto_depth;
diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 62cfb0fc3ed0..8587279ccaa7 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -87,6 +87,11 @@ static void bpf_diag_print_wrapped_text(struct bpf_verifier_env *env,
 					BPF_DIAG_TEXT_INDENT, text);
 }
 
+static bool bpf_diag_enabled(const struct bpf_verifier_env *env)
+{
+	return env && (env->log.level & BPF_LOG_LEVEL);
+}
+
 void bpf_diag_format_btf_type(char *buf, size_t size,
 			      const struct btf_type *type,
 			      const char *type_name)
@@ -120,7 +125,7 @@ static void bpf_diag_vprint_indented(struct bpf_verifier_env *env,
 {
 	char buf[1024];
 
-	if (!bpf_verifier_log_needed(&env->log))
+	if (!bpf_diag_enabled(env))
 		return;
 
 	vscnprintf(buf, sizeof(buf), fmt, args);
@@ -473,6 +478,9 @@ void bpf_diag_report_header(struct bpf_verifier_env *env,
 {
 	char problem_buf[BPF_DIAG_MSG_LEN];
 
+	if (!bpf_diag_enabled(env))
+		return;
+
 	strscpy(problem_buf, problem ?: "", sizeof(problem_buf));
 	if (problem_buf[0] >= 'a' && problem_buf[0] <= 'z')
 		problem_buf[0] += 'A' - 'a';
@@ -485,6 +493,9 @@ void bpf_diag_report_reason(struct bpf_verifier_env *env, const char *fmt, ...)
 {
 	va_list args;
 
+	if (!bpf_diag_enabled(env))
+		return;
+
 	bpf_diag_report_section(env, "Reason");
 
 	va_start(args, fmt);
@@ -494,6 +505,9 @@ void bpf_diag_report_reason(struct bpf_verifier_env *env, const char *fmt, ...)
 
 void bpf_diag_report_section(struct bpf_verifier_env *env, const char *title)
 {
+	if (!bpf_diag_enabled(env))
+		return;
+
 	verbose(env, "\n%s:\n", title);
 }
 
@@ -501,6 +515,9 @@ void bpf_diag_report_suggestion(struct bpf_verifier_env *env, const char *fmt, .
 {
 	va_list args;
 
+	if (!bpf_diag_enabled(env))
+		return;
+
 	bpf_diag_report_section(env, "Suggestion");
 
 	va_start(args, fmt);
@@ -607,6 +624,9 @@ void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx,
 	int insn_width, i;
 	va_list args;
 
+	if (!bpf_diag_enabled(env))
+		return;
+
 	va_start(args, fmt);
 	vscnprintf(msg, sizeof(msg), fmt, args);
 	va_end(args);
@@ -1228,6 +1248,12 @@ void bpf_diag_copy_history(struct bpf_verifier_state *dst,
 {
 	struct bpf_diag_history_event *history;
 
+	dst->diag_enabled = src->diag_enabled;
+	if (!src->diag_enabled) {
+		bpf_diag_clear_history(dst);
+		return;
+	}
+
 	if (!src->diag_history_cnt) {
 		bpf_diag_clear_history(dst);
 		dst->diag_history_omitted = src->diag_history_omitted;
@@ -1272,7 +1298,7 @@ static void bpf_diag_append_history(struct bpf_verifier_state *state,
 {
 	struct bpf_diag_history_event *history;
 
-	if (!state)
+	if (!state || !state->diag_enabled)
 		return;
 
 	if (state->diag_history_cnt < BPF_DIAG_HISTORY_MAX) {
@@ -1855,6 +1881,9 @@ void bpf_diag_print_history(struct bpf_verifier_env *env,
 	int start_idx;
 	u32 i;
 
+	if (!bpf_diag_enabled(env))
+		return;
+
 	bpf_diag_report_section(env, "Causal path");
 
 	if (!state)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3446ee9acaa1..359c4f4c0d42 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19238,6 +19238,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	state->speculative = false;
 	state->branches = 1;
 	state->in_sleepable = env->prog->sleepable;
+	state->diag_enabled = env->log.level & BPF_LOG_LEVEL;
 	state->frame[0] = kzalloc_obj(struct bpf_func_state, GFP_KERNEL_ACCOUNT);
 	if (!state->frame[0]) {
 		kfree(state);
-- 
2.53.0

