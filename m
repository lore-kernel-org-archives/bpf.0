Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF0B4119FD
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577639; cv=none; b=U8JyL2iGbm6Z+EHIhNz3pz7hcnigw5HbJerCya1Qt2hRVUeq0KXNBkVyhDo7Uf0ZCsqW+KGIvtEAKV1bwr6ChKYbJCJbQx3dHfs6Q9Ug9/8WrLFigQ7aqQ/a2NhaP1EsznsmBkvma60yKemEc0B1NiuQl7PyXBWEN7zvekqOp/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577639; c=relaxed/simple;
	bh=f/VfQPi86gCRUsfOQR3HVgWwSGHnZuCoN16RzfKf76c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2c3pLbY1EbXybvLciJ8hzNxUBpDsOUv1XhMl5QAi9wcexOupW+rZm09LI7ZUuZ2QzsTu6ynYDKXskm9mgXDgpna3o95NycZNAkrTzqNHtPRfNMSXpX8/jTH+mgG5ZbPT14RnwzMDyBDmgpSa+Y3e64rCLXVoWOK0AVa17PI6Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhYooLNZ; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhYooLNZ"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47825ef3fd4so90873f8f.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786577636; x=1787182436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qwFoJOdTzplHXbeFQ4Qj8yad9z8Ts4HWFA9U8V5LQ7Q=;
        b=ZhYooLNZJspOPZd3bnQ0OL9QMiPmfPDHR1ibNML3HTMOMe1n572cT8JS0yvF10G2OE
         O4BS+ikA4BJsydgQuYPyYB61VcwdfiHvi08I7raCN+vJZVIP/Qrxbar7S9TCibzezi9H
         CO+8qruSbtvUw6Eyp1nE3RzkBp+r2yPLAK9tUXHC6uxLmxuBQQHm7wbTHkMk52m8z0lE
         kvmdnemOdwoWqolh/owW3L3hLN5PUNf9YCsDfcCf8zYtnH30TMBdJJ/gecpCUWrLOiBE
         gqMe7N95qQfBXF14j8P1Oa8ab4apKObdsoS8kiqJrdW5OUj3VyTEUMmWRFj6COeJjTqL
         QaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786577636; x=1787182436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qwFoJOdTzplHXbeFQ4Qj8yad9z8Ts4HWFA9U8V5LQ7Q=;
        b=kwT47RHz24kFmelgBNNmNYAav7Ft8Tf/p6xVoEvxQ1Ll4IWKJfHfxXZYi+eSV20ToN
         OEyz7Zgip2UQ3CaExfoNDJXlxUo7EdQW+/iyPe1CbETKcbL8Pb64DvB5IB1/RqQZgPDf
         M/Hi1u+C0Qac1rLseDI/365v5yx0POv5CeF3bYGhYni8v7fyCY58ORUgx//2DhWmp/yk
         oBLqq4+a/wb3WLer0wKgk6a5MkJKYdCZoeq3MkGAO9e0IPYG2nF8mvS7IRDbUZ8zgNEk
         wQUsAKkGtSOOenySZHK5rZ67ciBmqij90AdyGFGomHPXiUoPE/yHFqfUvih/0HT0/6eM
         ruGg==
X-Gm-Message-State: AOJu0Yw/bT4j+czlry9W0l/YWza3CxWXokA7VBYVMs2SdekPVMqvevfG
	0zJrZBrxu2FhZ/xSh89jI9+83xrK+maJcBR0Bc70wLxnyEwYRC5h8HH7HEER4Urw
X-Gm-Gg: AR+sD12rs/jmD4TyH5jeUhtS9KCb0N/VpD7BOWrXfRH/JW+OxLtETQ1/MOQm7bUyCSk
	GyXWDmZukKPXGzqdWczmKO6hMM1If7KNprc/6TF/mFa1jEANcZ11JxrRlMdELGIdqpRLY8EC/Xh
	ekNge5Rvt2MiSpDt1u9ZrRaSQoyhU5XbtymbIta3jzF6MZxAaVBOiYpcmswAgaRxnnvJ45VaY+z
	O04t2WSZpnTK3n53uwISJpYhQB+6M0Piye3qGnfDGpsohJBt37U3g2XFr+/zQ+PzGidIoAJ334Q
	Tm9T9rFkSSSoNZMCT5GGS/Ek0lJKkMGAkKlczUuhtVy9+QavDiDqey9fiNwFozRRJNQ0li1JZcY
	X68yJ0tS4h1Yqwey+MPjj3dXQIjtbJS9TVnHzr9GHQt/XjA4WGbbdgaKJ2D/Q8LL9WPEzSLoqnR
	/FO1B8jW3FDDPmdqq6R8yzfqH5seRxu2i2S5wuTqW2Oc7jf8XkVdPx7bYx1RlS8Kj10O4fziqDc
	Ek2cVfFltp+6UUzcLXdBIUh5+voHUWhL+UEHC7AG7PyrUbj8whwBgF9ZLTJZliXWk8dMxEjCgOq
	CbgyPiYYxc5HD2TS+zEJniBBjJk=
X-Received: by 2002:a05:6000:188e:b0:480:b3:aaf4 with SMTP id ffacd0b85a97d-4815a5bbdf8mr1238985f8f.4.1786577636565;
        Wed, 12 Aug 2026 16:33:56 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a569c2bsm1369095f8f.12.2026.08.12.16.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 16:33:56 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 16/16] bpf: Gate verifier diagnostics on log level
Date: Thu, 13 Aug 2026 01:33:19 +0200
Message-ID: <20260812233326.3575958-17-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812233326.3575958-1-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3989; i=memxor@gmail.com; h=from:subject; bh=f/VfQPi86gCRUsfOQR3HVgWwSGHnZuCoN16RzfKf76c=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauWQe/j5Mmq+eW7lH6+Vdy/xduEpd9p07bkOr3V9ez2d 1nVRVd0lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCJrbRn+2d78u6u/9VKtw83P auW1lSoTts57t0Brw7fVZ75ld+z4dI3hf4Fi+YvHir0l3CnVn+XzZp9oMn3B5p/O0rbDZNLW7GJ eRgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Verifier diagnostics collect active-path history and render richer reports for
selected verifier failures. That work is useful only when the caller requests
normal verifier log output.

Do not enable diagnostic collection or report rendering for BPF_LOG_STATS-only
loads. Stats-only loads still need the verifier's summary counters, but not
the extra path history used by diagnostic reports.

Keep enablement in the verifier environment and requested log mode so async
callback verification uses the same diagnostic policy as the main verifier
pass.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a14315d19866..fea0b96ea5f2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5326,7 +5326,10 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	 * of caller's stack as shown on the example above.
 	 */
 	if (idx && subprog[idx].has_tail_call && depth >= 256) {
-		const char *chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
+		const char *chain = NULL;
+
+		if (bpf_diag_enabled(env))
+			chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
 
 		verbose(env,
 			"tail_calls are not allowed when call stack of previous frames is %d bytes. Too large\n",
@@ -5358,11 +5361,12 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		if (subprog_depth > env->max_stack_depth)
 			env->max_stack_depth = subprog_depth;
 		if (subprog_depth > MAX_BPF_STACK) {
-			const char *chain;
+			const char *chain = NULL;
 
 			verbose(env, "stack size of subprog %d is %d. Too large\n",
 				idx, subprog_depth);
-			chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
+			if (bpf_diag_enabled(env))
+				chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
 			bpf_diag_limit(
 				env, subprog[idx].start, "subprogram stack depth",
 				"Reduce stack usage in this subprogram, or move large data out of the BPF stack.",
@@ -5382,9 +5386,10 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 			verbose(env, "combined stack size of %d calls is %d. Too large\n",
 				total, depth);
 			{
-				const char *chain;
+				const char *chain = NULL;
 
-				chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
+				if (bpf_diag_enabled(env))
+					chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
 				bpf_diag_limit(
 					env, subprog[idx].start, "combined call stack depth",
 					"Reduce stack usage or call depth along this call chain.",
@@ -5456,11 +5461,12 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 
 		frame = bpf_subprog_is_global(env, idx) ? 0 : frame + 1;
 		if (frame >= MAX_CALL_FRAMES) {
-			const char *chain;
+			const char *chain = NULL;
 
 			verbose(env, "the call stack of %d frames is too deep !\n",
 				frame);
-			chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
+			if (bpf_diag_enabled(env))
+				chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
 			bpf_diag_limit(
 				env, call_insn, "bpf2bpf call frames",
 				"Reduce the number of nested bpf2bpf calls on this path.",
@@ -9585,11 +9591,12 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 	int err;
 
 	if (state->curframe + 1 >= MAX_CALL_FRAMES) {
-		const char *chain;
+		const char *chain = NULL;
 
 		verbose(env, "the call stack of %d frames is too deep\n",
 			state->curframe + 2);
-		chain = bpf_diag_alloc_state_call_chain(env, state, subprog);
+		if (bpf_diag_enabled(env))
+			chain = bpf_diag_alloc_state_call_chain(env, state, subprog);
 		bpf_diag_limit(
 			env, callsite, "bpf2bpf call frames",
 			"Reduce the number of nested bpf2bpf calls on this path.",
-- 
2.53.0

