Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CD3377ECC
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 03:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785210896; cv=none; b=dUQixOInSvgXO29UOXkWgtFEK89zRFoINpXnpw9vj6bLWptdUg8+NV/2u5LR38T4216t0NwRCyt6BjvtPxo+WOXILjZjNncGplptk4rgcqTT1AMBiaSBFS4eAAb5qNH1Wrzf1uuibf1GuzzwuQagerK3iaJu5n9aki/isfIW9Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785210896; c=relaxed/simple;
	bh=ND5wDqCDor5YxPSXbG9cRzx/A4Tk522xjEhVH+Vm8OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFRxuYhuIgSk8hIQu5WwcNDSdLjelvSnQhLjSMaDOPJ3u7/NH2TDmPqlf0t5x0nvKq2NUAIMr1I3PtvlYnh+PmwaTsaodAvXXVq9kbh2gEkHp3OZvZO3uRqAHtG6W3dgqynLjYVnB644zvMC2fUvLw8LK2ZHZdcbC3hqSGMrLS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id C73CC206A08328; Mon, 27 Jul 2026 20:54:42 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next v4 1/3] bpf: Reject >8 byte return values on return-reading trampoline paths
Date: Mon, 27 Jul 2026 20:54:42 -0700
Message-ID: <20260728035442.3008329-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728035437.3007984-1-yonghong.song@linux.dev>
References: <20260728035437.3007984-1-yonghong.song@linux.dev>
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
Reviewed-by: Leon Hwang <leon.hwang@linux.dev>
Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/bpf_struct_ops.c | 12 ++++++++++++
 kernel/bpf/verifier.c       | 25 +++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 51b16e5f5534..4e7a48c02be5 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -445,6 +445,18 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_d=
esc *st_ops_desc,
 			goto errout;
 		}
=20
+		/*
+		 * A >8 byte return value is passed back in a register pair,
+		 * which the struct_ops trampoline does not preserve (only
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
index e6f35f4e715b..8d0635ee48c7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19027,6 +19027,20 @@ btf_attach_func_proto(struct bpf_verifier_log *l=
og, struct btf *btf, u32 func_id
 	return btf_type_by_id(btf, func->type);
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
@@ -19291,6 +19305,14 @@ int bpf_check_attach_target(struct bpf_verifier_=
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
@@ -19565,6 +19587,9 @@ int bpf_check_attach_btf_id_multi(struct btf *btf=
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

