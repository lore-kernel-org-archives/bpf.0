Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F68D3CF688
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 05:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789883026; cv=none; b=NKoVCZ1vhwlVISrTLPm5lNu9XqvxrEXzFzN5JyCC5rWpZiNaiTYwwO9GD+SR7Ijbf6jRJDb9bdW0uM17XO8sBtUwe305/iUZ3lQ79VmZAD4r/vxkOKP4X2/0LBg/hhRR8x1rwssF/lndkAENEcMkcw9cehEQK+WXt6/FrZh0PkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789883026; c=relaxed/simple;
	bh=cf7ekHu0j6xLkl/CsxMr6Sg2CA/QWUZEn8gZAPLGYHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQAaPo9jLoDM4nwP2OjDDxFLeWQfS+zdhrcnyTcl7pJ5zeYDjKToh5v8gvcfUH9gLnNFQFcq7/ljCyR1rdv2S3efnHZD5yb9Zi9G+kYeR4Y8zHV30oEU+OV5adqoiXc7r/dmANWOsYaBxy4ayTqtH0+ksmL38BdcoejuaBLBc3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 9C9EC2BEBABB84; Sat, 19 Sep 2026 22:43:32 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 13/20] libbpf: Resolve the compiler's _Unwind_Resume to the kernel's kfunc
Date: Sat, 19 Sep 2026 22:43:32 -0700
Message-ID: <20260920054332.871309-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920054225.864535-1-yonghong.song@linux.dev>
References: <20260920054225.864535-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

LLVM terminates a cleanup landing pad with a call to _Unwind_Resume: the
base unwind ABI's entry point for carrying an unwind on once a frame's
cleanups have run. The kernel provides that terminator as a kfunc, but
not under that name: claiming _Unwind_Resume in the kernel's own symbol
table, for a function whose body never runs, would be needlessly confusin=
g,
so it is called bpf_unwind_resume.

Both load paths take the detour. A direct load resolves the name against
the kernel's BTF while libbpf runs. A light skeleton instead writes the
name into the loader program's blob of bytes, for that program to resolve
when it runs, so the name recorded there has to be translated as well.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/libbpf.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2f53afc985cf..2fa27e78aaab 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8351,6 +8351,15 @@ static void fixup_verifier_log(struct bpf_program =
*prog, char *buf, size_t buf_s
 	}
 }
=20
+/* LLVM terminates a cleanup landing pad with a call to _Unwind_Resume, =
the
+ * base unwind ABI's entry point for carrying an unwind on once a frame'=
s
+ * cleanups have run. The kernel knows it as bpf_unwind_resume.
+ */
+static const char *kern_extern_name(const char *name)
+{
+	return strcmp(name, "_Unwind_Resume") ? name : "bpf_unwind_resume";
+}
+
 static int bpf_program_record_relos(struct bpf_program *prog)
 {
 	struct bpf_object *obj =3D prog->obj;
@@ -8367,12 +8376,12 @@ static int bpf_program_record_relos(struct bpf_pr=
ogram *prog)
 				continue;
 			kind =3D btf_is_var(btf__type_by_id(obj->btf, ext->btf_id)) ?
 				BTF_KIND_VAR : BTF_KIND_FUNC;
-			bpf_gen__record_extern(obj->gen_loader, ext->name,
+			bpf_gen__record_extern(obj->gen_loader, kern_extern_name(ext->name),
 					       ext->is_weak, !ext->ksym.type_id,
 					       true, kind, relo->insn_idx);
 			break;
 		case RELO_EXTERN_CALL:
-			bpf_gen__record_extern(obj->gen_loader, ext->name,
+			bpf_gen__record_extern(obj->gen_loader, kern_extern_name(ext->name),
 					       ext->is_weak, false, false, BTF_KIND_FUNC,
 					       relo->insn_idx);
 			break;
@@ -8812,17 +8821,19 @@ static int bpf_object__resolve_ksym_func_btf_id(s=
truct bpf_object *obj,
 	struct module_btf *mod_btf =3D NULL;
 	const struct btf_type *kern_func;
 	struct btf *kern_btf =3D NULL;
+	const char *kern_name;
 	int ret;
=20
 	local_func_proto_id =3D ext->ksym.type_id;
=20
-	kfunc_id =3D find_ksym_btf_id(obj, ext->essent_name ?: ext->name, BTF_K=
IND_FUNC, &kern_btf,
-				    &mod_btf);
+	kern_name =3D kern_extern_name(ext->essent_name ?: ext->name);
+
+	kfunc_id =3D find_ksym_btf_id(obj, kern_name, BTF_KIND_FUNC, &kern_btf,=
 &mod_btf);
 	if (kfunc_id < 0) {
 		if (kfunc_id =3D=3D -ESRCH && ext->is_weak)
 			return 0;
 		pr_warn("extern (func ksym) '%s': not found in kernel or module BTFs\n=
",
-			ext->name);
+			strcmp(kern_name, "bpf_unwind_resume") ? ext->name : kern_name);
 		return kfunc_id;
 	}
=20
--=20
2.53.0-Meta

