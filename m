Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD8040B6E9
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641264; cv=none; b=ZPBD901Bm1Kgkcx799WuodKc/6m8HxEf29X3gf4mSFncYd6IOXx6K0mttGd2j4hEw6o84VeboiA3Nhk8rHccb63EVNUuRH1xJ4FpAdfFUAKzcxX3zHjgMqZW0Rk8iigp9ivUt/PXGbBmtJqPSYDR+n/XwfGEmyLm1o/Zuj5bs+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641264; c=relaxed/simple;
	bh=0oGrY7jTTimVhb+eJfUgncyf8jPrkZNdCJuoG7LWJIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JShwviarnZFJNAmVcwXrG0Kxq2EHwMYaR/TzxFVD1bUCYndfzSLivRx72bjAxiZ5nnu/kT8KkuoydYhQ3Zo1c2A3ujmCItKnO3SQdQEWkO0vdLyQwMwMrLSC2lkghajDrJiE5tRw1PKyEHo74hUwA5A+SZ4RW/WGAMsImptAngM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQTPolGn; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQTPolGn"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-490b12270b3so9106595e9.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 23:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780641259; x=1781246059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKOA1Ko+IZQ1+zC21FgziY0+TI0a5iMA/JoBEpo0OSs=;
        b=ZQTPolGnIa8bSnOdKXg8hCC70EWRKO0p0hOxj0QV9gjJwtQGYz6JqBIM2MjGd5RCJj
         g+T2RTo4TYEhJnuRQI7pRXAZkTTf/qIXs5FqOGLBGkeE5xRVrsup3du8gw0cBx7ZB9Xt
         Yj1Jg99U+OA5SgWcIExpNqibk3GlMIne2nnSfQNNbRvoc0HNhZkWIeR8hHS/W+uEdlD9
         SKIxaBVhxkthA8vi8DE7yDu3qN+vbsqa4WLmBv4wpsQ5z+A//04z8385n///6rWhy1Og
         0wn6eANt8aXn0cHBMDveg578vXyjkj2FynSPThGweDEGvAUzfQ7PuU3puwihYSb1GTaY
         vDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780641259; x=1781246059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UKOA1Ko+IZQ1+zC21FgziY0+TI0a5iMA/JoBEpo0OSs=;
        b=VJlom4tI+SeHWVT3+hy3OtpcJY/kUGZLU9H6K4H8Dd+Ne9m4G5kHebrJVpmBqxEBBE
         swyXY713vh4Hqhx6tQkg/ayyRV4gkfOvyiMx5GU0ZljJOp0zWgRxbOM5N6xjz1p8L+IS
         NFzsQ3o3LrCydK0WEcuVcxNSRPt/2/+YigeWSBBeTRDb/EX5wpCSIr+oty5+oKdidalM
         pt1lsmz7eF63PIigbCUg3Y6HHGwo6llHxZOjUCT7MbEpisFOLykma1ryR8+Byo6YLCKB
         6UIttGhekBIK2iiOkpH3xAXaQAoNRGecmOqMq6vGjAH6rKCu4WDOIfsaRxJOfJrhJ5tA
         ambQ==
X-Gm-Message-State: AOJu0YyZLSkl0qHuNpKX59/cVeU/NfEcDwPUamVwDNLtbPTt7Rq7nnxu
	J72w8JIRTTwzCUxSfXUgWlcU8iBgbFxne8cgg+7/gPKLjHJGSU1TKyBbqw3cEsZq
X-Gm-Gg: Acq92OGJWG0a9xV58b9sjI2RSTCQOySBjcQpsbIIn5aY0YbaXVMXQrJV6iqYGYJSnOP
	dooDe9HfIcmPpYxrcLTy5Tp6X7LbYPGEQZuoUZd2bylIOtgzRZZiU4UrSWeGNjU7ivImT352J3a
	rl+3AQff45S4qYHqb1IYtrL0zERCqi0IyRYXIkZKT0AZs09taphNk+RaBwRHuwsfqESyfRRJION
	37zZys7bdzQ2ZnSlMzjYPvxJ8g1ydmawZF43EmBJUn67ZJizte+lwypELRSIQQBVOZ/ZtMtwDj9
	vecjCOY6VLjA1/CfwGOhIMNu/8aIA2EltESL/MgTdgwKy3rxE3IzfgexWPG1ODqECzO3ndjfL4B
	qfC7Oh+rloEXt0Xw0pLcxmQx+WFEXOwaCBj4EToJvi0s/Kdxh7veA4G5sL3UUG1eDbLtJO/0wht
	mfNFssQiwoANwS2jMd1WbZi9f0V+BcYTclV5+lkUA8xX6Ep8Yt6ks6oDNGHAOEHsxuJmY5iTskr
	odq6Qig/dgxSX0m6tpm/dGh9HzMb6VgyNi5B/At4BpG3rycJy+38kiROnN4BjEWdeUai6LENEmM
X-Received: by 2002:a05:600c:37c9:b0:490:adb6:7957 with SMTP id 5b1f17b1804b1-490c262dcb5mr28704535e9.33.1780641259205;
        Thu, 04 Jun 2026 23:34:19 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3e59f5sm130638045e9.14.2026.06.04.23.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 23:34:18 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 06/17] bpf: Track verifier reference diagnostic history
Date: Fri,  5 Jun 2026 08:33:56 +0200
Message-ID: <20260605063412.974640-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605063412.974640-1-memxor@gmail.com>
References: <20260605063412.974640-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6801; i=memxor@gmail.com; h=from:subject; bh=0oGrY7jTTimVhb+eJfUgncyf8jPrkZNdCJuoG7LWJIU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUspt6j9/NI9WZOMkhV/aP2+teXbiuWaAqd2Hz93v77rZ mMOS/7JjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAExk+3ZGhvn5hQrXj3G9ntt+ fmvM3K9xPGrvK3NFkv7ZLTnXluR/tpHhn9mnqizTQ/Lrv62LdFXaNtVg+pITAfvzblbaMZ5bfX2 zGwcA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add reference acquire and release events to diagnostic history so Resource
Lifetime Safety reports can show the lifetime of a specific reference id
along the path.

Record acquisitions after the verifier assigns the reference id. Record
releases only after release_reference_nomark() succeeds, including the
kptr_xchg RCU conversion path that consumes an owning reference.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 57 ++++++++++++++++++++++++++++++++++++++--
 kernel/bpf/diagnostics.h | 11 ++++++++
 kernel/bpf/verifier.c    | 12 +++++++--
 3 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 1bdc7e69fbce..56c1236ffe7c 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -842,13 +842,38 @@ void bpf_diag_record_stack_arg(struct bpf_verifier_state *state, u32 insn_idx,
 	bpf_diag_append_history(state, &event);
 }
 
+static void bpf_diag_record_ref(struct bpf_verifier_state *state, u32 insn_idx,
+				u8 kind, u32 ref_id)
+{
+	struct bpf_diag_history_event event = {
+		.insn_idx = insn_idx,
+		.kind = kind,
+		.ref.ref_id = ref_id,
+	};
+
+	bpf_diag_append_history(state, &event);
+}
+
+void bpf_diag_record_ref_acquire(struct bpf_verifier_state *state, u32 insn_idx,
+				 u32 ref_id)
+{
+	bpf_diag_record_ref(state, insn_idx, BPF_DIAG_HISTORY_REF_ACQUIRE,
+			    ref_id);
+}
+
+void bpf_diag_record_ref_release(struct bpf_verifier_state *state, u32 insn_idx,
+				 u32 ref_id)
+{
+	bpf_diag_record_ref(state, insn_idx, BPF_DIAG_HISTORY_REF_RELEASE,
+			    ref_id);
+}
+
 static int bpf_diag_history_start_idx(const struct bpf_verifier_state *state,
 				      const struct bpf_diag_history_opts *opts)
 {
 	int i;
 
-	if (!opts || (opts->scope != BPF_DIAG_HISTORY_SCOPE_REG &&
-		      opts->scope != BPF_DIAG_HISTORY_SCOPE_STACK_ARG))
+	if (!opts || opts->scope == BPF_DIAG_HISTORY_SCOPE_ALL)
 		return 0;
 
 	for (i = state->diag_history_cnt; i > 0; i--) {
@@ -864,6 +889,10 @@ static int bpf_diag_history_start_idx(const struct bpf_verifier_state *state,
 		    event->stack_arg.slot == opts->stack_arg_slot &&
 		    event->stack_arg.frameno == opts->frameno)
 			return i - 1;
+		if (opts->scope == BPF_DIAG_HISTORY_SCOPE_REF &&
+		    event->kind == BPF_DIAG_HISTORY_REF_ACQUIRE &&
+		    event->ref.ref_id == opts->ref_id)
+			return i - 1;
 	}
 
 	return 0;
@@ -886,6 +915,10 @@ static bool bpf_diag_history_event_visible(const struct bpf_diag_history_event *
 		return opts->scope == BPF_DIAG_HISTORY_SCOPE_STACK_ARG &&
 		       event->stack_arg.slot == opts->stack_arg_slot &&
 		       event->stack_arg.frameno == opts->frameno;
+	case BPF_DIAG_HISTORY_REF_ACQUIRE:
+	case BPF_DIAG_HISTORY_REF_RELEASE:
+		return opts->scope == BPF_DIAG_HISTORY_SCOPE_REF &&
+		       event->ref.ref_id == opts->ref_id;
 	default:
 		return false;
 	}
@@ -1084,6 +1117,21 @@ static void bpf_diag_print_reg_mod(struct bpf_verifier_env *env,
 			       event->reg.dst_reg, old_buf, new_buf);
 }
 
+static void bpf_diag_print_ref_event(struct bpf_verifier_env *env,
+				     const struct bpf_diag_history_event *event)
+{
+	if (event->kind == BPF_DIAG_HISTORY_REF_ACQUIRE) {
+		bpf_diag_report_source(env, event->insn_idx, '+',
+				       "owned resource (id=%u)",
+				       event->ref.ref_id);
+		return;
+	}
+
+	bpf_diag_report_source(env, event->insn_idx, '-',
+			       "owned resource (id=%u)",
+			       event->ref.ref_id);
+}
+
 void bpf_diag_print_history(struct bpf_verifier_env *env,
 			    const struct bpf_diag_history_opts *opts)
 {
@@ -1122,6 +1170,11 @@ void bpf_diag_print_history(struct bpf_verifier_env *env,
 			bpf_diag_print_reg_mod(env, event);
 			printed = true;
 			break;
+		case BPF_DIAG_HISTORY_REF_ACQUIRE:
+		case BPF_DIAG_HISTORY_REF_RELEASE:
+			bpf_diag_print_ref_event(env, event);
+			printed = true;
+			break;
 		default:
 			break;
 		}
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index b8dfe8103966..c6ace61547c6 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -69,6 +69,9 @@ struct bpf_diag_history_event {
 			u8 reason;
 			struct bpf_diag_reg_snapshot old, new;
 		} stack_arg;
+		struct {
+			u32 ref_id;
+		} ref;
 	};
 };
 
@@ -78,12 +81,15 @@ enum bpf_diag_history_kind {
 	BPF_DIAG_HISTORY_BRANCH,
 	BPF_DIAG_HISTORY_REG_MOD,
 	BPF_DIAG_HISTORY_STACK_ARG,
+	BPF_DIAG_HISTORY_REF_ACQUIRE,
+	BPF_DIAG_HISTORY_REF_RELEASE,
 };
 
 enum bpf_diag_history_scope {
 	BPF_DIAG_HISTORY_SCOPE_ALL,
 	BPF_DIAG_HISTORY_SCOPE_REG,
 	BPF_DIAG_HISTORY_SCOPE_STACK_ARG,
+	BPF_DIAG_HISTORY_SCOPE_REF,
 };
 
 enum bpf_diag_stack_arg_reason {
@@ -97,6 +103,7 @@ struct bpf_diag_history_opts {
 	u32 frameno;
 	int regno;
 	int stack_arg_slot;
+	u32 ref_id;
 };
 
 struct bpf_verifier_env;
@@ -134,6 +141,10 @@ void bpf_diag_record_stack_arg(struct bpf_verifier_state *state, u32 insn_idx,
 			       enum bpf_diag_stack_arg_reason reason,
 			       const struct bpf_reg_state *old_reg,
 			       const struct bpf_reg_state *new_reg);
+void bpf_diag_record_ref_acquire(struct bpf_verifier_state *state, u32 insn_idx,
+				 u32 ref_id);
+void bpf_diag_record_ref_release(struct bpf_verifier_state *state, u32 insn_idx,
+				 u32 ref_id);
 void bpf_diag_print_history(struct bpf_verifier_env *env,
 			    const struct bpf_diag_history_opts *opts);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 188201d48108..9b9ffa57b95a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1434,6 +1434,7 @@ static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, int par
 	s->type = REF_TYPE_PTR;
 	s->id = ++env->id_gen;
 	s->parent_id = parent_id;
+	bpf_diag_record_ref_acquire(env->cur_state, insn_idx, s->id);
 	return s->id;
 }
 
@@ -8998,8 +8999,12 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 	if (err)
 		return err;
 
-	if (find_reference_state(vstate, id))
-		WARN_ON_ONCE(release_reference_nomark(vstate, id));
+	if (find_reference_state(vstate, id)) {
+		err = release_reference_nomark(vstate, id);
+		WARN_ON_ONCE(err);
+		if (!err)
+			bpf_diag_record_ref_release(vstate, env->insn_idx, id);
+	}
 
 	while ((id = idstack_pop(idstack))) {
 		/*
@@ -9088,6 +9093,9 @@ static int ref_convert_alloc_rcu_protected(struct bpf_verifier_env *env, u32 id)
 	int err;
 
 	err = release_reference_nomark(env->cur_state, id);
+	if (err)
+		return err;
+	bpf_diag_record_ref_release(env->cur_state, env->insn_idx, id);
 
 	bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
 		if (reg->id != id)
-- 
2.53.0

