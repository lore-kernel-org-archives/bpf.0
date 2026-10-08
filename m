Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F82C383305
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 07:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791445881; cv=none; b=pT0rsd3BsBqDKlvjxQ4cai7BiEFLS58xUIkssL/a+ZK9ZJ78Uygz4kQWIt2Of3Hs20iPHawUzyGG9T3PI3ekiCgReq069nFBn2J+jx7U9WLp2hQIQAQgdXxUajPTxC8FPsb6iEQlK4wVTajGQTtUDee7b0526sMzv3C74Szt95s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791445881; c=relaxed/simple;
	bh=XKsr7h+4cZzXQR7NO9K86mM9/oEUP1T25r9TSVI+c4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAcfXBSfvl7sb6Re145phhjr7lGE8IWCgU90vJb5i7o9qxdKE1ueNts2uxFjUktyn6Z+5SrkaxinTDcRMiM9WT5uWccDqEpzWVfiIAAndzmqAtZHBppe+CfuAhWQwzleMh4IF48NN7Y6B7JQdA4qM3NLizozpno2q5v7APaQ3TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 70B482FDA0C332; Thu,  8 Oct 2026 00:51:16 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v9 15/23] libbpf: Resolve the compiler's _Unwind_Resume to the kernel's kfunc
Date: Thu,  8 Oct 2026 00:51:16 -0700
Message-ID: <20261008075116.3003815-1-yonghong.song@linux.dev>
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
 tools/lib/bpf/libbpf.c | 45 ++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index cb09ded90773..5f41d3ba2822 100644
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
--=20
2.53.0-Meta

