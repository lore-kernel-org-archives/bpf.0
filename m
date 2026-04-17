Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B673CCFD2;
	Fri, 17 Apr 2026 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776454036; cv=none; b=RGn512ZGzlyJX1IHduXeHSAKROKt5g7ohKTzU2R/EoAWknvh8PePOX23pxCeXrCncbefhYKx7sUIN4ZQV75n/IRRoX7xqDpoefKKtL6XxkWYdmKlVBsz7hDiqBWahbbC2fsoRzMRWDpmhPYLBDscRBZjaEDcMeXpb3+uk2VqYco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776454036; c=relaxed/simple;
	bh=u05u45HUS8ATtTsX+D0d0hBQ0asPtpz53NlMMfZmxa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5+sHkxDtuRg/cMnOkNHwW175NrkputXzLaDfTTYxLhz0b18dwp2I1L5oEoXnljlahdXvS+heYlMLwkdFhtxNfCFonhuqL0gh8tSjaXUnPpYwc0LN3yTreOeAd+jaXtdGfn7Cg3ETqXo22kqA+t+Z1puAc4dx5EljqsbGQCMN9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOOZj2Ot; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOOZj2Ot"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8E3C19425;
	Fri, 17 Apr 2026 19:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776454036;
	bh=u05u45HUS8ATtTsX+D0d0hBQ0asPtpz53NlMMfZmxa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eOOZj2OtnHkzwnZ+WiXKM5xkjb+ZgxNvnESEYj1YzDV+WqUYcC1TyNBPvoNcxKjYV
	 38bjS4ykPmVoJ/AK5N7A1j8GbSQHOk9eDTUbwBCztOE9ixnKmGVxrbO/Hbz9n2nqGX
	 COZ6vdAzKnSBwrySFqAutM4esqmYIurDxLX1ZeV4g895ybc5gIWlAtkFZzRaGoK1Jb
	 l9YskI4TzVeAYgK/s+NFvm6eLdH+d6DshqDCvTRVUTDdauzEczDU/ya/g24+gSo69q
	 PsLeLSp/mG9i8FkyFcJJ0FZ9FUbOrr1gYm9DKEQeor7Zx41oHI08i0fSS4gpCo2b7G
	 TovpZLsH6l+cw==
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
Subject: [PATCHv5 bpf-next 11/28] bpf: Move sleepable verification code to btf_id_allow_sleepable
Date: Fri, 17 Apr 2026 21:24:45 +0200
Message-ID: <20260417192502.194548-12-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417192502.194548-1-jolsa@kernel.org>
References: <20260417192502.194548-1-jolsa@kernel.org>
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
 kernel/bpf/verifier.c | 79 +++++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 32 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9e913386aad5..739e730add96 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19124,6 +19124,52 @@ static bool is_tracing_multi_id(const struct bpf_prog *prog, u32 btf_id)
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
@@ -19414,38 +19460,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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

