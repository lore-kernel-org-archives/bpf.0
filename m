Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9F33A453F
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 08:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832419; cv=none; b=GtrYvaa1btnuaTDFWCyprVwFK/E/8wDyQ1gQHRdmz1HOrvTy2UddCenTMkwPZ17+qwEtZMj0WZgfpzuh3UlSan1lLnGafZ/IDRoNiP4iPtigAj3CuCVd8a0OWtPKuF8Tnci33QJXOGTXs4DM7DNVUNEjxI7I5Uw4W1PbWPSMbE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832419; c=relaxed/simple;
	bh=TWvXjznhvap8+7uTmdlZ8XJGAaPOlu++Wb9pL2Y4lDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hYHSKlTlF6Glextbgz8RtUMe0cCye4OdS/ltk63IM4BiXYUFBitkEVoqc3Fng9qUttggDmsp6kVKlBAuCXbCeIyRNvAfGBufTpXwFV1eb+56DXjkjWEUEnbVyGxc7p/trMsRTuwlUt4LfobUPzQTo2x6TjVduh9syEP4JsgnHQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QAZX6Rbg; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QAZX6Rbg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785832415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2x9G6vdPTfR8M9PABCPUJFIp7iRrBvjAJ3LuJWAPLuk=;
	b=QAZX6RbgVb3+dsRodbf9XxPUSyYsHskNrB5qotAtFeO/ANUDfjr/41B4RnCqOf/vUp1kvP
	spdVvk3wWNiEpyMBXuCd7da1A3nQaoRFjl/sEoPVyE2hAFK5QucJgMEbfk0vXWBeaaXS54
	BG6QFPfrufn2Q9IHkSso151wMlubeDI=
From: Kaitao Cheng <kaitao.cheng@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: [PATCH] bpf: add KF_SPIN_LOCK flag for kfuncs under bpf_spin_lock
Date: Tue,  4 Aug 2026 16:32:12 +0800
Message-ID: <20260804083212.79271-1-kaitao.cheng@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kaitao Cheng <chengkaitao@kylinos.cn>

Introduce the KF_SPIN_LOCK kfunc metadata flag in BTF so kfuncs may be
explicitly marked as safe to call while holding bpf_spin_lock.

Allow kfuncs defined in kernel modules to be marked with KF_SPIN_LOCK.

Example: BTF_ID_FLAGS(func, $kfunc_name, KF_SPIN_LOCK)

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 include/linux/btf.h   |  1 +
 kernel/bpf/verifier.c | 20 +++++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index c09b7994de4e..380dc10b6750 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -79,6 +79,7 @@
 #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its first argument */
 #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its second argument */
 #define KF_IMPLICIT_ARGS (1 << 16) /* kfunc has implicit arguments supplied by the verifier */
+#define KF_SPIN_LOCK    (1 << 17) /* kfunc is allowed inside bpf_spin_lock-ed region */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7aa47342dc65..9f3feba3c2fe 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11657,11 +11657,21 @@ static bool is_bpf_stream_kfunc(u32 btf_id)
 	       btf_id == special_kfunc_list[KF_bpf_stream_print_stack];
 }
 
-static bool kfunc_spin_allowed(u32 btf_id)
+static bool kfunc_spin_allowed(struct bpf_verifier_env *env, s32 func_id, s16 offset)
 {
-	return is_bpf_graph_api_kfunc(btf_id) || is_bpf_iter_num_api_kfunc(btf_id) ||
-	       is_bpf_res_spin_lock_kfunc(btf_id) || is_bpf_arena_kfunc(btf_id) ||
-	       is_bpf_stream_kfunc(btf_id);
+	struct bpf_kfunc_meta kfunc;
+	int err;
+
+	if (is_bpf_graph_api_kfunc(func_id) || is_bpf_iter_num_api_kfunc(func_id) ||
+	    is_bpf_res_spin_lock_kfunc(func_id) || is_bpf_arena_kfunc(func_id) ||
+	    is_bpf_stream_kfunc(func_id))
+		return true;
+
+	err = fetch_kfunc_meta(env, func_id, offset, &kfunc);
+	if (err || !kfunc.flags)
+		return false;
+
+	return *kfunc.flags & KF_SPIN_LOCK;
 }
 
 static bool is_sync_callback_calling_kfunc(u32 btf_id)
@@ -17289,7 +17299,7 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 				     insn->imm != BPF_FUNC_spin_unlock &&
 				     insn->imm != BPF_FUNC_kptr_xchg) ||
 				    (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
-				     (insn->off != 0 || !kfunc_spin_allowed(insn->imm)))) {
+				     !kfunc_spin_allowed(env, insn->imm, insn->off))) {
 					verbose(env,
 						"function calls are not allowed while holding a lock\n");
 					return -EINVAL;
-- 
2.50.1 (Apple Git-155)

