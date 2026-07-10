Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D8F2BDC28
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694658; cv=none; b=PeF/KaxQBqFugfWVh9jaHFJsL4XBO5fnZwySwtOq2J+Q2gJE3WDecdOZS0bAD+N/27FiONfrbRYHxvM/F7AxmK8ErQ1KZK9gn6CULVNZBys5zJyYQEmkolJYlxIoJW+tjzQe7bsQ+fCEjR3Z2vqRP3W1zyXbNz/ttG4meir6QIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694658; c=relaxed/simple;
	bh=K862sya+xE/LSTph9joiypyDeU/mwlmeE+XTZkM8CRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sCW+l/Kr34VU0nm4r5RxFBtvCUXmOn0i7SAU5+KO7fW53I3zD+eeo5q2L0lsHKklxLvNNvQjI4yk3kevI4C9PZSCtvD6xUI4mu3g8AXrg35wX2FobWPkLDciv9QSKg1bX6VxqsucyC4PxqRYXK3BWuOdH6lQnLHMaTgH1J35UEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 8D84A1D6982D22; Fri, 10 Jul 2026 07:44:04 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf 1/2] bpf: Reject >8 byte return values on return-reading trampoline paths
Date: Fri, 10 Jul 2026 07:44:04 -0700
Message-ID: <20260710144404.2579671-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

btf_distill_func_proto() builds the function model used for the
fentry/fexit/fmod_ret/fsession trampolines and struct_ops. It has
accepted a 16-byte __int128 return value since the trampoline was
introduced: __get_type_size() returns the integer's type size, and the
return-type check only rejected ret < 0.

But the BPF trampoline preserves only 8 bytes of the return value (RAX on
x86, i.e. R0). For an attach type that reads the target's return value th=
e
second half (RDX / R3) is neither saved nor restored, so a program
attached to a function returning a 16-byte value corrupts the value seen
by the real caller and itself observes only half of it. struct_ops
trampolines have the same limitation.

This affects the attach types that read the target's return value: fexit,
fmod_ret and fsession (plus the _multi variants of fexit and fsession),
and struct_ops. fentry/fentry_multi run before the target returns and are
unaffected.

Reject a >8 byte return value for these attach types in
bpf_check_attach_target() and bpf_check_attach_btf_id_multi(), and for
struct_ops in bpf_struct_ops_desc_init().

Fixes: fec56f5890d9 ("bpf: Introduce BPF trampoline")
Cc: Leon Hwang <leon.hwang@linux.dev>
Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/bpf_struct_ops.c | 12 ++++++++++++
 kernel/bpf/verifier.c       | 25 +++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 51b16e5f5534..bbb44ef8f87a 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -445,6 +445,18 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_d=
esc *st_ops_desc,
 			goto errout;
 		}
=20
+		/*
+		 * A >8 byte return value is passed back in the R0:R2 register
+		 * pair, which the struct_ops trampoline does not preserve (only
+		 * 8 bytes of the return value are saved and restored).
+		 */
+		if (st_ops->func_models[i].ret_size > 8) {
+			pr_warn("func ptr %s in struct %s has a >8 byte return value, which i=
s not supported\n",
+				mname, st_ops->name);
+			err =3D -EOPNOTSUPP;
+			goto errout;
+		}
+
 		stub_func_addr =3D *(void **)(st_ops->cfi_stubs + moff);
 		err =3D prepare_arg_info(btf, st_ops->name, mname,
 				       func_proto, stub_func_addr,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6515d4d3c003..26d281b77a6e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18873,6 +18873,20 @@ static int btf_id_allow_sleepable(u32 btf_id, un=
signed long addr, const struct b
 	return -EINVAL;
 }
=20
+static bool attach_uses_trampoline_retval(enum bpf_attach_type type)
+{
+	switch (type) {
+	case BPF_MODIFY_RETURN:
+	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FEXIT_MULTI:
+	case BPF_TRACE_FSESSION:
+	case BPF_TRACE_FSESSION_MULTI:
+		return true;
+	default:
+		return false;
+	}
+}
+
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
@@ -19137,6 +19151,14 @@ int bpf_check_attach_target(struct bpf_verifier_=
log *log,
 		if (ret < 0)
 			return ret;
=20
+		if (tgt_info->fmodel.ret_size > 8 &&
+		    attach_uses_trampoline_retval(prog->expected_attach_type)) {
+			bpf_log(log,
+				"Attach to function %s with a >8 byte return value is not supported =
for this attach type\n",
+				tname);
+			return -EOPNOTSUPP;
+		}
+
 		/*
 		 * *.multi programs don't need an address during program
 		 * verification, we just take the module ref if needed.
@@ -19413,6 +19435,9 @@ int bpf_check_attach_btf_id_multi(struct btf *btf=
, struct bpf_prog *prog, u32 bt
 	err =3D btf_distill_func_proto(NULL, btf, t, tname, &tgt_info->fmodel);
 	if (err < 0)
 		return err;
+	if (tgt_info->fmodel.ret_size > 8 &&
+	    attach_uses_trampoline_retval(prog->expected_attach_type))
+		return -EOPNOTSUPP;
 	if (btf_is_module(btf)) {
 		/* The bpf program already holds reference to module. */
 		if (WARN_ON_ONCE(!prog->aux->mod))
--=20
2.53.0-Meta

