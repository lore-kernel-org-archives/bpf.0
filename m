Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCC53AFD1F
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 04:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791519360; cv=none; b=qjUriuAdd7cIIQr5Wq50iaZca49hLTRyDxXlCQyFXewHy4jD5hga5K8UhMAPeyLQ2yWP8CUvHapnyNoC9KamN0nALjqgdFzsc/+jbsmCbol4ElNlwIlIYtRHXQDrH+3Dy+FJ8iis9zd4g1jR7VZx4aAoOgGGHFWVEbyZfh1F/YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791519360; c=relaxed/simple;
	bh=3hKcSC9M9Diu6ed21PEq7WGRHdOQeoeotBvXkhY86qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1arQwzAnU+g0/Pv+YIIRpxeKUhBPPJi1SaHJM16Bf11lPUPxqxCCA+HNPgr+IjCcOd04lHvJdHSEtUrNAp2lT6ketNP4ixzDwaMMRbBeyYaqA5znqy+059QcSBEnNU1PH/fFyywVh0KxzddMdNrTMi49yDxI35t/v4Of/tCStk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 651003008C524A; Thu,  8 Oct 2026 21:15:39 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v10 10/24] bpf: Do not use a private stack for a program that can unwind
Date: Thu,  8 Oct 2026 21:15:39 -0700
Message-ID: <20261009041539.28288-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009041447.17092-1-yonghong.song@linux.dev>
References: <20261009041447.17092-1-yonghong.song@linux.dev>
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
index 2b9640099269..f45dd3157f7f 100644
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
index 59b275bfc949..35013a5d8401 100644
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
+	 * slot off. Do not use a private stack for any program that can
+	 * unwind, on every arch for now.
+	 */
+	if (env->cleanup_info_cnt || bpf_prog_may_unwind(env))
+		priv_stack_mode =3D NO_PRIV_STACK;
+
 	if (priv_stack_mode =3D=3D PRIV_STACK_UNKNOWN)
 		priv_stack_mode =3D bpf_enable_priv_stack(env->prog);
=20
--=20
2.53.0-Meta

