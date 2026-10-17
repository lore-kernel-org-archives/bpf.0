Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0348A2D0C7E
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 02:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792205598; cv=none; b=ZkKxQ+Paz0fbY0gIfpO5AlNoYDjk5paufp+gAeGArjItg7FoZlfSVEhqBs9vJCxbvnGGkd4yl0TJ7mMiJ8wVG6dLzUwa/pVvbcPvPBnLvtjk/xT65y98E62ViWtixgud+AUed/n6C1cBEcKEY2Cz2NNdSNA9vDY18yG+CrYhB4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792205598; c=relaxed/simple;
	bh=icNQKYQcou7O/bX52vvM8vUzTIh5qY5BQQCjbvQfiKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0mM63EUmDuRNd7dLv+J7fyQfaA0dwbKOvAB6BMzUuKUcG+HmUYmTzFLgNlwt3n+FMRaw8DuO4PCB78RI5PWMgPTYZpFhvi/s/Kns0VoroaNgw0W9Hvwt3urjIgHXjiVVJXFaq1fUbjR0qIyxo4t6riGAS16VYhWxVoCrtCorWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 6181A31B3B00D4; Fri, 16 Oct 2026 19:52:58 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v12 17/25] libbpf: Resolve the compiler's _Unwind_Resume to the kernel's kfunc
Date: Fri, 16 Oct 2026 19:52:58 -0700
Message-ID: <20261017025258.1927910-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017025129.1914859-1-yonghong.song@linux.dev>
References: <20261017025129.1914859-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

LLVM ends a cleanup landing pad with a call to _Unwind_Resume, the
unwind ABI's name for carrying an unwind on. The kernel's kfunc is
bpf_unwind_resume: _Unwind_Resume in the kernel's own symbol table, for a
function whose body never runs, would only confuse.

The compiler emits the call but no declaration, and libbpf refuses an
extern it has no BTF for, so the program declares it itself (extern void
_Unwind_Resume(void *) __ksym;), as a language runtime has to. libbpf
only translates the name, both where it resolves the kfunc itself and
where it records the name for a light skeleton's loader to resolve.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/libbpf.c | 56 ++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index cb09ded90773..b3cfd7c58776 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9187,6 +9187,23 @@ static void fixup_verifier_log(struct bpf_program =
*prog, char *buf, size_t buf_s
 	}
 }
=20
+/*
+ * LLVM terminates a cleanup landing pad with a call to _Unwind_Resume, =
the
+ * base unwind ABI's entry point for carrying an unwind on once a frame'=
s
+ * cleanups have run. The kernel knows it as bpf_unwind_resume. Any othe=
r
+ * extern, and a variable of that name, is looked up by @name unchanged.
+ */
+static const char *kern_extern_name(const struct bpf_object *obj,
+				    const struct extern_desc *ext, const char *name)
+{
+	const char *essent =3D ext->essent_name ?: ext->name;
+
+	if (!btf_is_func(btf__type_by_id(obj->btf, ext->btf_id)) ||
+	    strcmp(essent, "_Unwind_Resume"))
+		return name;
+	return "bpf_unwind_resume";
+}
+
 static int bpf_program_record_relos(struct bpf_program *prog)
 {
 	struct bpf_object *obj =3D prog->obj;
@@ -9195,6 +9212,7 @@ static int bpf_program_record_relos(struct bpf_prog=
ram *prog)
 	for (i =3D 0; i < prog->nr_reloc; i++) {
 		struct reloc_desc *relo =3D &prog->reloc_desc[i];
 		struct extern_desc *ext =3D &obj->externs[relo->ext_idx];
+		const char *name;
 		int kind;
=20
 		switch (relo->type) {
@@ -9203,14 +9221,14 @@ static int bpf_program_record_relos(struct bpf_pr=
ogram *prog)
 				continue;
 			kind =3D btf_is_var(btf__type_by_id(obj->btf, ext->btf_id)) ?
 				BTF_KIND_VAR : BTF_KIND_FUNC;
-			bpf_gen__record_extern(obj->gen_loader, ext->name,
-					       ext->is_weak, !ext->ksym.type_id,
-					       true, kind, relo->insn_idx);
+			name =3D kern_extern_name(obj, ext, ext->name);
+			bpf_gen__record_extern(obj->gen_loader, name, ext->is_weak,
+					       !ext->ksym.type_id, true, kind, relo->insn_idx);
 			break;
 		case RELO_EXTERN_CALL:
-			bpf_gen__record_extern(obj->gen_loader, ext->name,
-					       ext->is_weak, false, false, BTF_KIND_FUNC,
-					       relo->insn_idx);
+			name =3D kern_extern_name(obj, ext, ext->name);
+			bpf_gen__record_extern(obj->gen_loader, name, ext->is_weak, false,
+					       false, BTF_KIND_FUNC, relo->insn_idx);
 			break;
 		case RELO_CORE: {
 			struct bpf_core_relo cr =3D {
@@ -9684,17 +9702,24 @@ static int bpf_object__resolve_ksym_func_btf_id(s=
truct bpf_object *obj,
 	struct module_btf *mod_btf =3D NULL;
 	const struct btf_type *kern_func;
 	struct btf *kern_btf =3D NULL;
+	const char *local_name, *kern_name;
 	int ret;
=20
 	local_func_proto_id =3D ext->ksym.type_id;
=20
-	kfunc_id =3D find_ksym_btf_id(obj, ext->essent_name ?: ext->name, BTF_K=
IND_FUNC, &kern_btf,
-				    &mod_btf);
+	local_name =3D ext->essent_name ?: ext->name;
+	kern_name =3D kern_extern_name(obj, ext, local_name);
+
+	kfunc_id =3D find_ksym_btf_id(obj, kern_name, BTF_KIND_FUNC, &kern_btf,=
 &mod_btf);
 	if (kfunc_id < 0) {
 		if (kfunc_id =3D=3D -ESRCH && ext->is_weak)
 			return 0;
-		pr_warn("extern (func ksym) '%s': not found in kernel or module BTFs\n=
",
-			ext->name);
+		if (kern_name !=3D local_name)
+			pr_warn("extern (func ksym) '%s' ('%s' in the kernel): not found in k=
ernel or module BTFs\n",
+				ext->name, kern_name);
+		else
+			pr_warn("extern (func ksym) '%s': not found in kernel or module BTFs\=
n",
+				ext->name);
 		return kfunc_id;
 	}
=20
@@ -9707,9 +9732,14 @@ static int bpf_object__resolve_ksym_func_btf_id(st=
ruct bpf_object *obj,
 		if (ext->is_weak)
 			return 0;
=20
-		pr_warn("extern (func ksym) '%s': func_proto [%d] incompatible with %s=
 [%d]\n",
-			ext->name, local_func_proto_id,
-			mod_btf ? mod_btf->name : "vmlinux", kfunc_proto_id);
+		if (kern_name !=3D local_name)
+			pr_warn("extern (func ksym) '%s': func_proto [%d] incompatible with '=
%s' in %s [%d]\n",
+				ext->name, local_func_proto_id, kern_name,
+				mod_btf ? mod_btf->name : "vmlinux", kfunc_proto_id);
+		else
+			pr_warn("extern (func ksym) '%s': func_proto [%d] incompatible with %=
s [%d]\n",
+				ext->name, local_func_proto_id,
+				mod_btf ? mod_btf->name : "vmlinux", kfunc_proto_id);
 		return -EINVAL;
 	}
=20
--=20
2.53.0-Meta

