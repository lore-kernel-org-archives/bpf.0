Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426313537CF;
	Mon, 16 Mar 2026 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773647585; cv=none; b=jsxrLG8Ql/iAQ2mmu/+4oXjxer0HPqmx9/9lHOexNlTjcjXP44U2uBXrCqtY9+r7kVbU+5HDPqz77cCh7qdyOpyH64AObSe6BZ08lP8NUuEJsc4pY6WoL5hUTBwIq4kyjMFSdtUEiz6+ZqIxr9TG49XBk0OGdWb9TPMo3mXEuJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773647585; c=relaxed/simple;
	bh=F8s7wIK4mOkVJfHhvw8J+VnOvVCr4A2P3lZlHSgAmL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ny9Kv4FIMc8CR8JBPWHqOzqRpwc6GEqLj/K2UhXde2qW6Rlf14eyUQ1azro0dNmV3v0lv8EItnoIZ4FxOs89k3jEmePa6W6HfU+74yTt+ta8ozG1GTgjHo7qhuUnJzv3CVtbwSR1VYC37zRWZvuTGlFzy7RVhlsmuuV87RclY2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruAAmHcj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruAAmHcj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63F7C19421;
	Mon, 16 Mar 2026 07:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773647584;
	bh=F8s7wIK4mOkVJfHhvw8J+VnOvVCr4A2P3lZlHSgAmL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ruAAmHcjYy5q+2uQ4x6wIE9ogrDVsAs2PALMJB8E8XWp+Xm7cJM5INLG3rhHULlLq
	 xtYSKkc+kV0AXnnmZanqPxgig51eLycZ7OEz8ZBdF9tLnxrbgb8W1srcaCroxqDEPV
	 xWvUIfRcs4bSpCJ+YcCA6j2g8JzDmeWX8memIbiiuN1+tP61LrgntH83GMjYsaCADi
	 f2CtaxPVYsQfH3Lu/F3K3ngpFPpHv3ualvHpn9y5Zgxk6/KnLne+TInfddMnqb/OPw
	 XeXLqNtsG129NAZE7gwkKt3g+yY5R/9Cd/jLKW5TTzheI8sZG3FV3hS2X2yH89DndE
	 8GDojkhOo3NHQ==
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
Subject: [PATCHv3 bpf-next 07/24] bpf: Move sleepable verification code to btf_id_allow_sleepable
Date: Mon, 16 Mar 2026 08:51:21 +0100
Message-ID: <20260316075138.465430-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316075138.465430-1-jolsa@kernel.org>
References: <20260316075138.465430-1-jolsa@kernel.org>
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
 include/linux/bpf_verifier.h |  3 ++
 kernel/bpf/verifier.c        | 79 +++++++++++++++++++++---------------
 2 files changed, 50 insertions(+), 32 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 090aa26d1c98..186726fcf52a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -932,6 +932,9 @@ static inline void bpf_trampoline_unpack_key(u64 key, u32 *obj_id, u32 *btf_id)
 		*btf_id = key & 0x7FFFFFFF;
 }
 
+int btf_id_allow_sleepable(u32 btf_id, unsigned long addr, const struct bpf_prog *prog,
+			   const struct btf *btf);
+
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b29cd244ee27..7085688eb719 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -25059,6 +25059,52 @@ static bool is_tracing_multi_id(const struct bpf_prog *prog, u32 btf_id)
 	return is_tracing_multi(prog->expected_attach_type) && bpf_multi_func_btf_id[0] == btf_id;
 }
 
+int btf_id_allow_sleepable(u32 btf_id, unsigned long addr, const struct bpf_prog *prog,
+			   const struct btf *btf)
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
+		/* *.multi sleepable programs will pass initial sleepable check,
+		 * the actual attached btf ids are checked later during the link
+		 * attachment.
+		 */
+		if (is_tracing_multi_id(prog, btf_id))
+			return 0;
+		if (!check_attach_sleepable(btf_id, addr, tname))
+			return 0;
+		/* fentry/fexit/fmod_ret progs can also be sleepable if they are
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
+		/* LSM progs check that they are attached to bpf_lsm_*() funcs.
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
@@ -25349,38 +25395,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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
2.53.0

