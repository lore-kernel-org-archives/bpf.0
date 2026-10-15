Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93423BBFD0
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 04:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792036969; cv=none; b=usx4XuoEspZ8qImdsm9epk1ZXsQO4y0wKGVAlO67f9YlZQvg3ObS/kX5yKbeE348Jq61M1kCdj4+r/rvfWRpnGZoVZ0v8wQPltHlEPrdersh9W7RGoLpusHGMN+hW0CXiipgf7ZsLQg0+fpRG2HIxrsjPp6QQE8ub/wt3Dpc+ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792036969; c=relaxed/simple;
	bh=chQeTVhJrl7coJY/Bsfn8Ny2mlxVnECoUqEoWvoeN8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alSqRNmog8reudLIOWcHpAqPGX+mYT7h9+3DvVR6BHlhbTVf+yXFUuhwRZ4Su1c3ftxfv0oLQGtw8lWZGNyOc0TCwvlLvKciQz0B5Be6xKf0I0ca4SAQnJizU3Gviq3jUELuDdT2swlTu2k6CWnu8Z6iEUwBkJR8xppGYA3LBsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id E8B2831498EB36; Wed, 14 Oct 2026 21:02:34 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v11 10/26] bpf: Do not use a private stack for a program that can unwind
Date: Wed, 14 Oct 2026 21:02:34 -0700
Message-ID: <20261015040234.859897-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015040143.854070-1-yonghong.song@linux.dev>
References: <20261015040143.854070-1-yonghong.song@linux.dev>
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

So force NO_PRIV_STACK for a program that has a table or can unwind, on
every arch for now.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/exception.c | 10 ++++++++++
 kernel/bpf/exception.h |  1 +
 kernel/bpf/verifier.c  | 11 +++++++++++
 3 files changed, 22 insertions(+)

diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
index 43e01d0be44f..5945fdf5f75c 100644
--- a/kernel/bpf/exception.c
+++ b/kernel/bpf/exception.c
@@ -183,6 +183,16 @@ void bpf_exc_mark_call_sites(struct bpf_verifier_env=
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
index 6d6550daa98e..ecbca25dabef 100644
--- a/kernel/bpf/exception.h
+++ b/kernel/bpf/exception.h
@@ -14,6 +14,7 @@ int bpf_exc_check_info(struct bpf_verifier_env *env, co=
nst union bpf_attr *attr,
 		       bpfptr_t uattr);
 void bpf_exc_mark_call_sites(struct bpf_verifier_env *env);
 int bpf_exc_check_prog(struct bpf_verifier_env *env);
+bool bpf_prog_may_unwind(const struct bpf_verifier_env *env);
 int bpf_exc_pad_of_call(struct bpf_verifier_env *env, u32 idx);
 bool bpf_is_unwind_kfunc(const struct bpf_insn *insn);
 bool bpf_is_unwind_resume_kfunc(const struct bpf_insn *insn);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ec5496aa12f7..0392d013b3b7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5956,6 +5956,17 @@ static int check_max_stack_depth(struct bpf_verifi=
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

