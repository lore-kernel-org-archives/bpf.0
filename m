Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CE03FB07B;
	Wed, 27 May 2026 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882124; cv=none; b=DqaU1PR4+Vw954x3W5NVqrqrcSIbIj0CkmNEwAgJxS3xl2GL2do9QiycF7R8/rnSMkJr6VTaDy8NdDmaxpVEKtJTKWl2Zc0doCgUJQT2Bva96dbH5NJrh9pJ3Xz9u5UA4yEMO+5rgKUEeJ2Ua29isCaYS4XBYaiMAZU/5Y+3fdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882124; c=relaxed/simple;
	bh=QNfebMcl4APxqpyt1mTDH7hFGNm9iiBXSadXlIXwybU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLeKWr3c2Xq9IRYNhDweH76mXjKz+3qIkXoVv0rhryzg3jEmjwR3f3QdGwidmyAHEyl3c4CESDrMFiZhDDruO4c6Z2NGTo2rGcyJVvTNMikZGvYntJl/QnSWqMQZxqMYwCHNKJ46gvIkjtb7sgGEDPdSoJ+ZQZxdAoMGtwbBRXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuIlCYFF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuIlCYFF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976D41F000E9;
	Wed, 27 May 2026 11:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779882120;
	bh=NdbPOr6fmUd2QbdqBGriM5GigxJ7RopyDy2eqoBQJKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DuIlCYFFPV4PiuP+ljouAiINQVBSjukQ439WDtSusRDTzKOPv1fg+nDSa+7iLqfAd
	 s1EPnE1+BHk+yc+g2L7rUsUQvFKfdLgZdwT2BJf9IB9yXr6Lpzps1Ez5inc7DybbOQ
	 uDDIbm78/brvig3mkKl53Se1t6Fq/FAWebduuLo3ffEXcDyI721DaACiph3feXAZLP
	 eYx0ah6U6bVbJrqMtqkN9IEfBOb3QyUTHR9fhmgaLQE+oOJRv45J+zkT1yR71H23s3
	 FCI6WFl/7wrM5lF7MPKBaqIUE6ySFFmEsSqKTy6cHERbIz/tTRZr/7OcUeli+0LUiP
	 CrTRNKw570B4A==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCHv6 bpf-next 11/29] bpf: Move sleepable verification code to btf_id_allow_sleepable
Date: Wed, 27 May 2026 13:39:33 +0200
Message-ID: <20260527113951.46265-12-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527113951.46265-1-jolsa@kernel.org>
References: <20260527113951.46265-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move sleepable verification code to btf_id_allow_sleepable function.
It will be used in following changes.

Adding code to retrieve type's name instead of passing it from
bpf_check_attach_target function, because this function will be
called from another place in following changes and it's easier
to retrieve the name directly in here.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/verifier.c | 82 ++++++++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 32 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 58450cb88beb..9eb0ebd0f93c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18844,6 +18844,55 @@ static bool is_tracing_multi_id(const struct bpf_prog *prog, u32 btf_id)
 	return is_tracing_multi(prog->expected_attach_type) && bpf_multi_func_btf_id[0] == btf_id;
 }
 
+static int btf_id_allow_sleepable(u32 btf_id, unsigned long addr, const struct bpf_prog *prog,
+				  const struct btf *btf)
+{
+	const struct btf_type *t;
+	const char *tname;
+
+	switch (prog->type) {
+	case BPF_PROG_TYPE_TRACING:
+		t = btf_type_by_id(btf, btf_id);
+		if (!t)
+			return -EINVAL;
+		tname = btf_name_by_offset(btf, t->name_off);
+		if (!tname)
+			return -EINVAL;
+
+		/*
+		 * *.multi sleepable programs will pass initial sleepable check,
+		 * the actual attached btf ids are checked later during the link
+		 * attachment.
+		 */
+		if (is_tracing_multi_id(prog, btf_id))
+			return 0;
+		if (!check_attach_sleepable(btf_id, addr, tname))
+			return 0;
+		/*
+		 * fentry/fexit/fmod_ret progs can also be sleepable if they are
+		 * in the fmodret id set with the KF_SLEEPABLE flag.
+		 */
+		else {
+			u32 *flags = btf_kfunc_is_modify_return(btf, btf_id, prog);
+
+			if (flags && (*flags & KF_SLEEPABLE))
+				return 0;
+		}
+		break;
+	case BPF_PROG_TYPE_LSM:
+		/*
+		 * LSM progs check that they are attached to bpf_lsm_*() funcs.
+		 * Only some of them are sleepable.
+		 */
+		if (bpf_lsm_is_sleepable_hook(btf_id))
+			return 0;
+		break;
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
@@ -19141,38 +19190,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		}
 
 		if (prog->sleepable) {
-			ret = -EINVAL;
-			switch (prog->type) {
-			case BPF_PROG_TYPE_TRACING:
-				/* *.multi sleepable programs will pass initial sleepable check,
-				 * the actual attached btf ids are checked later during the link
-				 * attachment.
-				 */
-				if (is_tracing_multi_id(prog, btf_id))
-					ret = 0;
-				if (!check_attach_sleepable(btf_id, addr, tname))
-					ret = 0;
-				/* fentry/fexit/fmod_ret progs can also be sleepable if they are
-				 * in the fmodret id set with the KF_SLEEPABLE flag.
-				 */
-				else {
-					u32 *flags = btf_kfunc_is_modify_return(btf, btf_id,
-										prog);
-
-					if (flags && (*flags & KF_SLEEPABLE))
-						ret = 0;
-				}
-				break;
-			case BPF_PROG_TYPE_LSM:
-				/* LSM progs check that they are attached to bpf_lsm_*() funcs.
-				 * Only some of them are sleepable.
-				 */
-				if (bpf_lsm_is_sleepable_hook(btf_id))
-					ret = 0;
-				break;
-			default:
-				break;
-			}
+			ret = btf_id_allow_sleepable(btf_id, addr, prog, btf);
 			if (ret) {
 				module_put(mod);
 				bpf_log(log, "%s is not sleepable\n", tname);
-- 
2.54.0

