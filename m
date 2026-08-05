Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772EB47FAF2;
	Wed,  5 Aug 2026 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785944052; cv=none; b=aAPBIKx+J8cR109AK3xf0kdWBF2lNbQpdfsEY/WDEKATp/1pCHYyw3TE03sNRJ8KZH1e5h7epVum4Jo6t48lhvw8nYjpWHFp5tuGyxBYQyGWPzfQt6fsqW2NgnXTcer5S9PF7+4h46qB9PGazTuKU1wQr1HW/owWWWTkpC4y2gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785944052; c=relaxed/simple;
	bh=5QGg8UA6TP6BiR80nmMNPD+9XP0RRFAEKZsYNq+PShI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3M2WJ5o0Ynu0+EMTo8XyeCU5797uLnDOEJ272ku68U6IlfgH/nKQ8UDmRXYzkKIBlh5hMpQTTehD3P3MPbam4quzCaF1vpFIsoDjL8zwyP9VxT0+9Ah3r2OqBIppsVEBFSwVdPPTvZSvefawGYgVkw8Ei5jBsU1c2EzNCEfc3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=slDBi+5+; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="slDBi+5+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785944039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htN/R7/vpvjJoj57m1JcFVCCQB3lZ4Dh9rkDr6cbV4k=;
	b=slDBi+5+gotQFoyTbh6AFITlB5cTmV9fuhq7RoT6Fpqi3I0AymEJxofg4tke/BeUYogbSZ
	w3r+PNeAJ/ulwtRneVutsoRd7FY8LML8XLlV8k/RkNvnWbn83aJ0YD/81IIn7eLxhAMbsU
	zzI+yo/btDFe7qoxmjoOe7rNv1PdkoY=
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
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: [PATCH bpf-next v2 1/3] bpf: Add KF_SPINLOCK_SAFE flag for kfuncs under bpf_spin_lock
Date: Wed,  5 Aug 2026 23:33:38 +0800
Message-ID: <20260805153340.34776-2-kaitao.cheng@linux.dev>
In-Reply-To: <20260805153340.34776-1-kaitao.cheng@linux.dev>
References: <20260805153340.34776-1-kaitao.cheng@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kaitao Cheng <chengkaitao@kylinos.cn>

Introduce the KF_SPINLOCK_SAFE kfunc metadata flag in BTF so kfuncs may
be explicitly marked as safe to call while holding bpf_spin_lock.

Allow kfuncs defined in kernel modules to be marked with KF_SPINLOCK_SAFE.

Example: BTF_ID_FLAGS(func, $kfunc_name, KF_SPINLOCK_SAFE)

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 include/linux/btf.h   |  1 +
 kernel/bpf/verifier.c | 20 +++++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index c09b7994de4e..3f5255d095a2 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -79,6 +79,7 @@
 #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its first argument */
 #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its second argument */
 #define KF_IMPLICIT_ARGS (1 << 16) /* kfunc has implicit arguments supplied by the verifier */
+#define KF_SPINLOCK_SAFE (1 << 17) /* kfunc is allowed inside bpf_spin_lock-ed region */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b274004fccfd..9c1f8d552655 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11832,11 +11832,21 @@ static bool is_bpf_stream_kfunc(u32 btf_id)
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
+	return *kfunc.flags & KF_SPINLOCK_SAFE;
 }
 
 static bool is_sync_callback_calling_kfunc(u32 btf_id)
@@ -17415,7 +17425,7 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
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

