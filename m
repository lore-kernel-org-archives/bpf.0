Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924451DDC35
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 01:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775093292; cv=none; b=gutWVw+8V9HJrYRrfBgxTNO7zsRzc1pti1LYQv/v444TiI0yFJKz4ztiYDTca3bfXIMI/gPexh0jTQTb1RqRQuy0p9lIxiLwGoxGMWhf4b8Bb+R+J5v6I4iID3gvTpMLB/8oWYVoXpS1MWpGfe9eS+v8Z1JVu4q0Ch1Mz3MYGoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775093292; c=relaxed/simple;
	bh=85msIH2vxzUqmGN0fr8TiRKepHcejn8TRLA2/tAAuY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLlfPHHCY13Nc1lnao4SxTWlvHQQibehEgRMZtEysKAgSn9xyomvdp3VXAwWl2/YZq9P4T5jwiTIm/1MRfim8Q8+OumBlz0pyg7Xa6ag+RPp5RHFQEfdVUFM0/janRQP7tWV3xvUV+wwimucEyJlS2oFJKrEV1kiDW3H7K9hzzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 2418333280504; Wed,  1 Apr 2026 18:27:58 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 06/10] bpf: Enable stack argument support for x86_64
Date: Wed,  1 Apr 2026 18:27:58 -0700
Message-ID: <20260402012758.3920069-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402012727.3916819-1-yonghong.song@linux.dev>
References: <20260402012727.3916819-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add stack argument support for x86_64.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 5 +++++
 include/linux/filter.h      | 1 +
 kernel/bpf/btf.c            | 9 ++++++++-
 kernel/bpf/core.c           | 5 +++++
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e9b78040d703..32864dbc2c4e 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3937,6 +3937,11 @@ bool bpf_jit_supports_kfunc_call(void)
 	return true;
 }
=20
+bool bpf_jit_supports_stack_args(void)
+{
+	return true;
+}
+
 void *bpf_arch_text_copy(void *dst, void *src, size_t len)
 {
 	if (text_poke_copy(dst, src, len) =3D=3D NULL)
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 68f018dd4b9c..a5035fb80a6b 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1160,6 +1160,7 @@ bool bpf_jit_inlines_helper_call(s32 imm);
 bool bpf_jit_supports_subprog_tailcalls(void);
 bool bpf_jit_supports_percpu_insn(void);
 bool bpf_jit_supports_kfunc_call(void);
+bool bpf_jit_supports_stack_args(void);
 bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_jit_supports_exceptions(void);
 bool bpf_jit_supports_ptr_xchg(void);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c5f3aa05d5a3..1cbe0f2b0e41 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -20,6 +20,7 @@
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
 #include <linux/bpf.h>
+#include <linux/filter.h>
 #include <linux/bpf_lsm.h>
 #include <linux/skmsg.h>
 #include <linux/perf_event.h>
@@ -7897,8 +7898,14 @@ int btf_prepare_func_args(struct bpf_verifier_env =
*env, int subprog)
 			tname, nargs, MAX_BPF_FUNC_REG_ARGS);
 		return -EINVAL;
 	}
-	if (nargs > MAX_BPF_FUNC_REG_ARGS)
+	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
+		if (!bpf_jit_supports_stack_args()) {
+			bpf_log(log, "JIT does not support function %s() with %d args\n",
+				tname, nargs);
+			return -ENOTSUPP;
+		}
 		sub->incoming_stack_arg_depth =3D (nargs - MAX_BPF_FUNC_REG_ARGS) * BP=
F_REG_SIZE;
+	}
=20
 	/* check that function is void or returns int, exception cb also requir=
es this */
 	t =3D btf_type_by_id(btf, t->type);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index a04b31eb4c49..01de4f7f3a82 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3156,6 +3156,11 @@ bool __weak bpf_jit_supports_kfunc_call(void)
 	return false;
 }
=20
+bool __weak bpf_jit_supports_stack_args(void)
+{
+	return false;
+}
+
 bool __weak bpf_jit_supports_far_kfunc_call(void)
 {
 	return false;
--=20
2.52.0

