Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E453A516153
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790024504; cv=none; b=Fb589VzbHWHRmOzhc28ZIHGU9qqthbJSpr4Ts3RI5qTIvejJkAiS2mxgWJvUs0NplMYxXEJaPLUBXB1PgAY6AQGQRxR86uM+UJ/kY4VtQ/hQ9II84MxwA49/08ovA+xtNpw/llA+UpzhKlNqJ1j55jzmGI75Ti4fHZVb3bnZPSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790024504; c=relaxed/simple;
	bh=nI3HtS2IiQXubSDnOGUwXMPvIJYXD7SJ2tyBd5W1GQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIUiOxKew0b7Zo+z1aebpYmyRFCJnAbZRsZs+HuXacRMlpGXCvR8ugsxDmGBeSB3JI06jcfIMHH2+3R5S4b50ueFVLpSiDfqbaoHJj3+TnT1+Jeq/pl7eSmaEJ03+Y0P7aPj6DA4zlKYZcBjkmRF8a6dh0SxQnDUbZPXj3+ZpYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 0878F2C44911FD; Mon, 21 Sep 2026 14:01:40 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 13/20] libbpf: Resolve the compiler's _Unwind_Resume to the kernel's kfunc
Date: Mon, 21 Sep 2026 14:01:39 -0700
Message-ID: <20260921210140.1722891-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921210033.1715000-1-yonghong.song@linux.dev>
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
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
 tools/lib/bpf/libbpf.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index cd1ea1bb53cb..13ae9175e968 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8379,6 +8379,15 @@ static void fixup_verifier_log(struct bpf_program =
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
@@ -8395,12 +8404,12 @@ static int bpf_program_record_relos(struct bpf_pr=
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
@@ -8876,17 +8885,20 @@ static int bpf_object__resolve_ksym_func_btf_id(s=
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

