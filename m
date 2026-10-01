Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CF44B7A3C
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861495; cv=none; b=t8upilPW8YmTF84LIo8HDsCbZNOBUUF8pz8bxph9lZYlK4Aay9WqZy3puPj5XCWDxLuL/YsydqUSy4kGt2w9ABIYYvBV9EHwzQS2BXgud7bf4f7WuZM0ZEon/UlyJaWIBI9KXxxqfMi/FnkuI4dEVqEoQxFwOVZiBE/xgcU/TcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861495; c=relaxed/simple;
	bh=Gy45vOFYMjnjgObkZEInDwUTrsaTsXaykHIf1iKROkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEMWa2dUqORt14dpUZdGu4xmCysUYUA1V18jdIuHFO+cZU5IDhxLE6Jgi3HYvanFlDkkScOibTG7nLV8HZuV96n7ywRgqIr6umxRWfHMA3J2kaxMcGIC12Zb8xQkcW8tgnKCGu3bvrApVIB9jGua/GMaRtg4JDm69CPDdMsABus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 85E8C2E6E12437; Thu,  1 Oct 2026 06:31:18 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v8 14/22] libbpf: Resolve the compiler's _Unwind_Resume to the kernel's kfunc
Date: Thu,  1 Oct 2026 06:31:18 -0700
Message-ID: <20261001133118.1342926-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001133006.1335369-1-yonghong.song@linux.dev>
References: <20261001133006.1335369-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

LLVM terminates a cleanup landing pad with a call to _Unwind_Resume: the
base unwind ABI's entry point for carrying an unwind on once a frame's
cleanups have run. The kernel provides that terminator as a kfunc, but no=
t
under that name: claiming _Unwind_Resume in the kernel's own symbol table=
,
for a function whose body never runs, would be needlessly confusing, so i=
t
is called bpf_unwind_resume.

The compiler emits the call but not the declaration: _Unwind_Resume lands
in the object as a plain undefined symbol, with nothing in .ksyms. libbpf
takes every undefined NOTYPE symbol for an extern and refuses one it has =
no
BTF for ("failed to find BTF for extern '_Unwind_Resume'"), so the progra=
m
declares it itself -- extern void _Unwind_Resume(void *) __ksym; -- as th=
e
selftests here do, and as a language runtime emitting cleanup pads has to=
.
What follows translates that name; it does not manufacture the declaratio=
n.

Both load paths take the detour. A direct load resolves the name against
the kernel's BTF while libbpf runs. A light skeleton instead writes the
name into the loader program's blob of bytes, for that program to resolve
when it runs, so the name recorded there has to be translated as well.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/libbpf.c | 45 ++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fdd69aac39bd..80fd0dcd0248 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8802,6 +8802,23 @@ static void fixup_verifier_log(struct bpf_program =
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
@@ -8810,6 +8827,7 @@ static int bpf_program_record_relos(struct bpf_prog=
ram *prog)
 	for (i =3D 0; i < prog->nr_reloc; i++) {
 		struct reloc_desc *relo =3D &prog->reloc_desc[i];
 		struct extern_desc *ext =3D &obj->externs[relo->ext_idx];
+		const char *name;
 		int kind;
=20
 		switch (relo->type) {
@@ -8818,14 +8836,14 @@ static int bpf_program_record_relos(struct bpf_pr=
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
@@ -9299,17 +9317,24 @@ static int bpf_object__resolve_ksym_func_btf_id(s=
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
--=20
2.53.0-Meta

