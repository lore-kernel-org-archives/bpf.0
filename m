Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97EF33E351;
	Sat,  6 Jun 2026 12:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749713; cv=none; b=CwucU/9CRbF6N+jElmZMZzST7pYOlA/G6McGjBpcq/MY3vegvnmMvJfTwCCwwOhdAY121zo7+ABjs7J/iSdLQZ/W3GgWyR5gNNxW1u4o1JZGsC5JuO7QzaGnOLBEPV2kjh18Pt/4iROmAUlP89ZeooHKwlzEwN3iPzCAXHkf1fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749713; c=relaxed/simple;
	bh=pqhq31CDuTt2uWkohy03E3xwsrlvDQ5LSvSl5t4bFGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXuQFIgxt1OGQGtW8I/wTgFJhwQE2Qh/IkB0dCD76X4iiBMjP1Bvj5T7sqzTs4kOLVQA57aPG4eC4lx8ddEVJNhoXWxoN7H1/BMRovvfpr8GdfmYK+SPJikUVnSGeAuMo2xMyUgZDpT2G1eo3EVJtfZGCrWz6yj1VVZuBzBsoeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1yMUSYk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1yMUSYk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCE91F00898;
	Sat,  6 Jun 2026 12:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780749712;
	bh=HNwd0wgm5XSAMH/tsUYa1IDp7jpTMNgjioXFfDifgOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R1yMUSYkBMui7SxonyRj4t/q5V9iPaKVIwduFC/jlOpdbIfB3hqNODY+4yQwXOgf7
	 3e+nYw+DEjhOTl1BGmL138mr+n+/EaiaaQtnj9urZ3VbtAb+6q9p52ia3GJp+RWAeY
	 V5i0EFweygIkZniHs15i3VkPoX49S4pLFj/k1FT1Z7r+iQy2mGWRmRegiiT+kqY7AS
	 AiwQKLLVua6n/bvgRtKGw+MtjI2OZCL/vjtcyGdEqy8v2a6W38WU231pclBS3by0Pr
	 eO/+JFzUC29j49r+ZyRHhXTKZhdP25Oqs+sJsz7oiC7OFr6h5vDcsEmiaRuf2TPy9v
	 MPWztz7cQCGRA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCHv8 bpf-next 11/29] bpf: Move sleepable verification code to btf_id_allow_sleepable
Date: Sat,  6 Jun 2026 14:39:36 +0200
Message-ID: <20260606123955.345967-12-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606123955.345967-1-jolsa@kernel.org>
References: <20260606123955.345967-1-jolsa@kernel.org>
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
index 091c9606d961..bf9ada761539 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18767,6 +18767,55 @@ static bool is_tracing_multi_id(const struct bpf_prog *prog, u32 btf_id)
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
@@ -19064,38 +19113,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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

