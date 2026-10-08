Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F723D5236
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 07:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791445857; cv=none; b=Wsbb7uC6gThnFKOJfH96qa6GPUzJjxkmIszaM1wMWuG3cr1saVw5SJkqbGR1wq52F8Ho41OsjaIpMrn9cn1DMt2byY+Oo8guKvwq3/0Hm3oXn1BdQBv7o5PI7yWWjzlM3XWYFwAhgeoJt13rvXNPJ8awvNCrRWywhy039Bq6ufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791445857; c=relaxed/simple;
	bh=4hISCYcVvJhemmKa4SInh3Z9gPxuk9V/dDPLOAT3b1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fH0hoAfKIcOdy0W6/MRtjlp9899Taj8jX4bPRuonvQ38piy0gYB3f6dwKKOHh/FdRYsIPorCHBz2n0V4oDszkguKo2s9XTLhu3yh0xRAL8A3/RMhGAdVE7ypucd7v0Rm3Ridg1l6O6D5sVvCUx6eXhvbZ27ugscxm51jI1PZ8qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id B892C2FDA0C091; Thu,  8 Oct 2026 00:50:45 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v9 09/23] bpf: Do not use a private stack for a program that can unwind
Date: Thu,  8 Oct 2026 00:50:45 -0700
Message-ID: <20261008075045.2999417-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008074959.2993751-1-yonghong.song@linux.dev>
References: <20261008074959.2993751-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A private stack keeps its frame pointer in %r9 on x86-64, saved and
restored around every call. An unwind skips the restore: a frame resumed
at its pad then addresses its stack through a stale pointer, and one sent
to its epilogue pops its callee-saved registers one slot off.

So force NO_PRIV_STACK for a program that can unwind, with a table or
not, on every arch for now.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/exception.c | 10 ++++++++++
 kernel/bpf/exception.h |  1 +
 kernel/bpf/verifier.c  | 11 +++++++++++
 3 files changed, 22 insertions(+)

diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
index 6155f5d73420..035eb4d87588 100644
--- a/kernel/bpf/exception.c
+++ b/kernel/bpf/exception.c
@@ -183,6 +183,16 @@ static void mark_call_sites(struct bpf_verifier_env =
*env)
 	}
 }
=20
+bool bpf_prog_may_unwind(const struct bpf_verifier_env *env)
+{
+	u32 i;
+
+	for (i =3D 0; i < env->subprog_cnt; i++)
+		if (env->subprog_info[i].might_unwind)
+			return true;
+	return false;
+}
+
 int bpf_exc_check_prog(struct bpf_verifier_env *env)
 {
 	int err;
diff --git a/kernel/bpf/exception.h b/kernel/bpf/exception.h
index 1d7fc795619f..dea45c7e4925 100644
--- a/kernel/bpf/exception.h
+++ b/kernel/bpf/exception.h
@@ -14,6 +14,7 @@ int bpf_exc_check_info(struct bpf_verifier_env *env, co=
nst union bpf_attr *attr,
 		       bpfptr_t uattr);
 void bpf_exc_prepare(struct bpf_verifier_env *env);
 int bpf_exc_check_prog(struct bpf_verifier_env *env);
+bool bpf_prog_may_unwind(const struct bpf_verifier_env *env);
 int bpf_exc_pad_of_call(struct bpf_verifier_env *env, u32 idx);
 bool bpf_is_unwind_kfunc(const struct bpf_insn *insn);
 bool bpf_is_unwind_resume_kfunc(const struct bpf_insn *insn);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 59b275bfc949..585be741c689 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5801,6 +5801,17 @@ static int check_max_stack_depth(struct bpf_verifi=
er_env *env)
 		}
 	}
=20
+	/*
+	 * A private stack keeps its frame pointer in %r9 on x86-64, restored
+	 * by a pop after the call that an unwind skips. A frame resumed at a
+	 * pad then addresses its stack through a stale pointer, and a frame
+	 * sent to its epilogue instead pops its callee-saved registers one
+	 * slot off. Refuse a private stack for any program that can unwind,
+	 * on every arch for now.
+	 */
+	if (env->cleanup_info_cnt || bpf_prog_may_unwind(env))
+		priv_stack_mode =3D NO_PRIV_STACK;
+
 	if (priv_stack_mode =3D=3D PRIV_STACK_UNKNOWN)
 		priv_stack_mode =3D bpf_enable_priv_stack(env->prog);
=20
--=20
2.53.0-Meta

