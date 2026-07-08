Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6674F3E5EC0
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783541435; cv=none; b=D+t2z3Fg/TfhyEc1gBWrUdrFiEIl7jJFBcx5HeHvQiY1mC3dhteQeJXp/zuwHYSDFV4F6vgIRiRm168K/wcnnsFzm2TG5cNxgMMIQNizOTsS5QZV5KH5keBhFLO9lCxxqC6CUcNhqdUax2xACgTPdc7owr0DFZKOAOx5FozeGEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783541435; c=relaxed/simple;
	bh=D79dVg8vkpHJn8r2tMTF+JUxih+w/syUhB0RP8czEFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5mCzGbOIbT7x6nVIkaK1rgXIj3a1PTyHpDo8hdWY+hIeKcSATA0SVmWB8h6oP6Nsnm1GuKIDGw9t/s3qqSraXywG/RBZY/poqVYWWpl87VC14I++Cj8ilPpPnm/+U+oiSmM9bJhAYJL6zlelb17C+heF3U4xAKT1caDUzruIS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 987C21D0B6F8F3; Wed,  8 Jul 2026 13:10:15 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 07/12] bpf: Reject >8 byte return values on return-reading trampoline paths
Date: Wed,  8 Jul 2026 13:10:15 -0700
Message-ID: <20260708201015.2159760-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708200939.2153664-1-yonghong.song@linux.dev>
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

btf_distill_func_proto() builds the function model used for kfunc calls,
the fentry/fexit/fmod_ret/fsession trampolines and struct_ops. A followin=
g
patch relaxes it to accept a >8 and <=3D16 byte return value, which for t=
he
BPF target is passed back in the R0:R2 register pair.

But the BPF trampoline cannot preserve such a return. It saves and restor=
es
only 8 bytes of the return value (RAX on x86, i.e. R0), so the second hal=
f
(RDX / R2) is not preserved across a program that observes the return
value. A program attached to a function returning a 16-byte value (e.g.
current_time() or ns_to_timespec64(), which return struct timespec64)
would corrupt the value seen by the real caller and read a partial return
value itself. struct_ops trampolines have the same limitation.

This only matters for the attach types that actually read the target's
return value: fexit, fmod_ret and fsession (plus the _multi variants of
fexit and fsession). fentry and fentry_multi run before the target return=
s
and never touch the return value, so they can attach to a >8 byte-returni=
ng
function safely.

Reject a >8 byte return value for the return-reading attach types in
bpf_check_attach_target() and bpf_check_attach_btf_id_multi(), and for
struct_ops in bpf_struct_ops_desc_init(), ahead of the following patch th=
at
would otherwise let such a return through. kfunc and BPF-to-BPF subprogra=
m
calls, which the JIT does handle, are unaffected.

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
index ca8b2f436c20..121f56e3fb16 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19112,6 +19112,20 @@ static int btf_id_allow_sleepable(u32 btf_id, un=
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
@@ -19376,6 +19390,14 @@ int bpf_check_attach_target(struct bpf_verifier_=
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
@@ -19652,6 +19674,9 @@ int bpf_check_attach_btf_id_multi(struct btf *btf=
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

