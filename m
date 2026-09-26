Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4445A3909A3
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 05:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790398878; cv=none; b=QGB+OB6ylrdZ0WWZvS4qN8nvGO1jxJdXLlIPkZ129frjqte5Ih/UW/017M4Uwc6rHVnXRCJPrOI9TaHHWobAWP3cj379/qWPwYchJm/TmxHpEzK8GB8RF9mKE6vZe3DnKzKmESlhkW6huMX6hZRlcr6dWvn1kkhCXPlf19ky2wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790398878; c=relaxed/simple;
	bh=oHTRCdiUdjjcVUnrRbNYXvELh1U4+tIjosSdNGTeUk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sd+WiWCv17GBXrBD14k3Qyb96UrO6IxPg29Eg56KVJC1GDPPdtrYHs/m+8T1ryO/t+vWZuX8CaZXBCRWLdcyLGhNt3KeGMvYVzfvvgO2XTU6r4yYNLgSIPukb4KN2wVt18rDRA5e8fTW4beges5xCCVxLPXHl1oecOOqsZ/0JXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 062B02D4596969; Fri, 25 Sep 2026 22:01:13 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 13/21] libbpf: Resolve the compiler's _Unwind_Resume to the kernel's kfunc
Date: Fri, 25 Sep 2026 22:01:12 -0700
Message-ID: <20260926050113.2219410-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926050006.2213110-1-yonghong.song@linux.dev>
References: <20260926050006.2213110-1-yonghong.song@linux.dev>
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
 tools/lib/bpf/libbpf.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 238e35c1ee3f..7eb15a013a83 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8797,6 +8797,16 @@ static void fixup_verifier_log(struct bpf_program =
*prog, char *buf, size_t buf_s
 	}
 }
=20
+/*
+ * LLVM terminates a cleanup landing pad with a call to _Unwind_Resume, =
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
@@ -8813,12 +8823,12 @@ static int bpf_program_record_relos(struct bpf_pr=
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
@@ -9294,17 +9304,20 @@ static int bpf_object__resolve_ksym_func_btf_id(s=
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
+	kern_name =3D kern_extern_name(local_name);
+
+	kfunc_id =3D find_ksym_btf_id(obj, kern_name, BTF_KIND_FUNC, &kern_btf,=
 &mod_btf);
 	if (kfunc_id < 0) {
 		if (kfunc_id =3D=3D -ESRCH && ext->is_weak)
 			return 0;
 		pr_warn("extern (func ksym) '%s': not found in kernel or module BTFs\n=
",
-			ext->name);
+			kern_name !=3D local_name ? kern_name : ext->name);
 		return kfunc_id;
 	}
=20
--=20
2.53.0-Meta

