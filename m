Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4289438642E;
	Wed,  4 Mar 2026 22:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772662985; cv=none; b=o7QSZg3M66NwXh4IGEXiVLUGMDL1UxQh2izjoaV+UE5fRFnWe1Vra3La8X+QrXzWKvryf5LgoFBQJtDxMPJr24+2iKut6B9QYnUYSZa5kVgP5sse3pTpzBqs/FxxhKFevkm3GHQ1p5L82n7XzSx477D7ehGlxrPZmb6ZofEpXyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772662985; c=relaxed/simple;
	bh=koGqXZnE7rDiADJMKu7hALANraTCY602j2b0PQVrS1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4m9GtPw3EVd61g0Bwyck6lZb4nKzdXgWStmhXBP6DbzdFkmdBHwd72e1Oqq4wZc+6HEou6392/fKJdW8yGog4PoCORtBKq/fbu7LcQL1CMu+iZPlK+s3gbAz8o4Dk/u5HjKysENfFoQhGjdXSVTQzmWrGzG4AnmVhM+uanrbYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNnWvDha; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNnWvDha"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D72C4CEF7;
	Wed,  4 Mar 2026 22:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772662985;
	bh=koGqXZnE7rDiADJMKu7hALANraTCY602j2b0PQVrS1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SNnWvDha56RYpVFcB2/hEmk13vCFkzNFePZzC47BRClY8dgFBQrAgBbKPmTaJIgXl
	 hgi/DilKIGBlEue1sl2Y5wRdoL0mwJrKXM2FrJugXkKgajjL8NhpwGQNKP8tje9D86
	 WArYS06F0F2Z/OXE1eoBffOgC0levKuHgRw6O9rE67rJCLMuTXx/mZzD0sewYChjUo
	 Lq1pXkFXaZ2XueCs2k1Lg0EiDGgG969ni3ArtIGcXo5R8hq3LQej0SFiwd+159sgs3
	 B7Br9f+PzsOpFsASdZL5Ep758cCmXqxdOHdH5oyUp7cnAOVlK+1+i1ZnCgQb6FJTNQ
	 IJk5QZk+uhVAg==
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
Subject: [PATCHv2 bpf-next 07/23] bpf: Move sleepable verification code to btf_id_allow_sleepable
Date: Wed,  4 Mar 2026 23:21:25 +0100
Message-ID: <20260304222141.497203-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304222141.497203-1-jolsa@kernel.org>
References: <20260304222141.497203-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move sleepable verification code to btf_id_allow_sleepable
function. It will be used in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf_verifier.h |  3 ++
 kernel/bpf/verifier.c        | 79 +++++++++++++++++++-----------------
 2 files changed, 45 insertions(+), 37 deletions(-)

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
index 832a87da5a86..ff29e27a85d0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24959,6 +24959,47 @@ static bool is_tracing_multi_id(const struct bpf_prog *prog, u32 btf_id)
 	return is_tracing_multi(prog->expected_attach_type) && bpf_multi_func_btf_id[0] == btf_id;
 }
 
+int btf_id_allow_sleepable(u32 btf_id, unsigned long addr, const struct bpf_prog *prog,
+			   const struct btf *btf)
+{
+	switch (prog->type) {
+	case BPF_PROG_TYPE_TRACING:
+
+		/* *.multi sleepable programs will pass initial sleepable check,
+		 * the actual attached btf ids are checked later during the link
+		 * attachment.
+		 */
+		if (is_tracing_multi_id(prog, btf_id))
+			return 0;
+		/* fentry/fexit/fmod_ret progs can be sleepable if they are
+		 * attached to ALLOW_ERROR_INJECTION and are not in denylist.
+		 */
+		else if (!check_non_sleepable_error_inject(btf_id) &&
+		    within_error_injection_list(addr))
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
@@ -25247,43 +25288,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		}
 
 		if (prog->sleepable) {
-			ret = -EINVAL;
-			switch (prog->type) {
-			case BPF_PROG_TYPE_TRACING:
-
-				/* *.multi sleepable programs will pass initial sleepable check,
-				 * the actual attached btf ids are checked later during the link
-				 * attachment.
-				 */
-				if (is_tracing_multi_id(prog, btf_id))
-					ret = 0;
-				/* fentry/fexit/fmod_ret progs can be sleepable if they are
-				 * attached to ALLOW_ERROR_INJECTION and are not in denylist.
-				 */
-				else if (!check_non_sleepable_error_inject(btf_id) &&
-				    within_error_injection_list(addr))
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

