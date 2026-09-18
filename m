Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B87E355F49
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 04:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789704565; cv=none; b=pCAbsFNBbx9MACWY3vR1uSUN7anhnA2GSZKNyMVo51N2eS65VY2IbcCWlla+0hh8RaDKwInZ06gPe4sZElghS1n/sJx4qSouRwQvA5QjSRKLUhzq8j4tgEPZi5x/YMkGsMQqj20IX0C4bLwi/GLQvxGkf2PMcdRP2SBPvg3U5t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789704565; c=relaxed/simple;
	bh=fwntZdPeiuJTnqJDgs5mNStFO4JndV9retFpYgqqll4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=b/+ICLmyASnVi5XcSZsnbY7X9HxuPDbHDcD+/7yzAFJRI53SydGIxuTpt95+BG4Q6aAWhgMKLbD3uOIoZV+giu7003uNwEKH0AwqxixGxpX8VaV1Ber6rNART8K4Ijo0967zULg6nnDKILBz3bAWGXWIWEZqEzYBxo/yPLKaebk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tb5PQC3n; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tb5PQC3n"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2dd753a52bbso7057625ad.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 21:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789704563; x=1790309363; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YZqJR4y+eWh6bqSl2cVAFyOPmB6ncJ2AaOppEDk+lIg=;
        b=Tb5PQC3ng680V/ygg3JRSpArvop49XwnoAXxQBpA/FvZ6Dr7XcES0biZyWf8Nmr2nh
         LsibnxWeDEoVqv/wtP9drpL+VG4NB925zL8A+bc16iUEY6CQI4k0MaERrNpavw+4QDSg
         8QjiBLHpvo1BHK54Xcu33EOxrr89RYZqly6QHNNcc2Oa8mvCfjQvl0lvVPVKuME9sAt6
         oP1RBZPD+6ebp/pGkTRkW1LM8eBmdqEDMrRfnm+JLxIX6ISRIazSXeSb5l4ZhHMNtWvf
         S5nsUk/TJtw0pGWIv6PYCrU+HZaHTU3DdWsror67WdiTdQuEAzGVzgs4kWuTSdhx6x7e
         slcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789704563; x=1790309363;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YZqJR4y+eWh6bqSl2cVAFyOPmB6ncJ2AaOppEDk+lIg=;
        b=zQ7Sm6CLWqByKgnlKYJ1xXacCOeLanYivB1/bDgfJt9cDvRK+kHWidSPYgdE7RYnUR
         etWDNfwc9YtxqlCwqJwgv3UGJGLyaNMe6UwV5MxGrAN7/LXi4mzmw1F21Hr4cfPVK9/S
         v0/QlKREZrBw412ZBGJDrkDZPLAel2bwEaIvmIVdmfqP4Ozr0ubHUhzJjKTgVA0/qDdR
         x5uhnIjcMn5oP9e5YPe9frnABRPnWN73SqzsWXW2uG3uL4V0hk86B9xSEKVdftVO5eiv
         ks50hLbQXU5kGp8qA3/alP4HpQM2dw0o3jm2tHmssFPF0HyN26GPYXe/yfeZTsqfR1A4
         T4Kg==
X-Forwarded-Encrypted: i=1; AKwUvByeSLyiopHq17LNT7th07W88pfc7brNdGhEkhb0HGFKRhWcg1/jESbAmAellWMVJlFmquM=@vger.kernel.org
X-Gm-Message-State: AFuF++lckFRkvkfsZr3O5n74fJHx/2yhsgVmyU4J0eUXBBBCOAWZ7UhL
	H47Hdqqvmq6YuK0LmWPCSFPpCX3bwMmjtmoZnv58hHfxsUrWh68EVka0yD9VbK4swDH0u9lphSw
	p+Q==
X-Received: from pldv20.prod.google.com ([2002:a17:902:ca94:b0:2dd:5048:500e])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:11cc:b0:2dd:7979:246
 with SMTP id d9443c01a7336-2ddb1b78d80mr27353945ad.16.1789704562990; Thu, 17
 Sep 2026 21:09:22 -0700 (PDT)
Date: Fri, 18 Sep 2026 14:09:17 +1000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918040919.3402577-1-tweek@google.com>
Subject: [PATCH bpf-next v3 1/3] bpftool: Skip non-autoload programs when
 generating light skeletons
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	"=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, KP Singh <kpsingh@kernel.org>, Leon Hwang <leon.hwang@linux.dev>, 
	Emil Tsalapatis <emil@etsalapatis.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When generating a light skeleton (bpftool gen skeleton -L),
bpf_object__load() skips loading programs marked as non-autoload (e.g.
SEC("?...")), so the generated loader program only records and populates
file descriptors for autoloaded programs.

Previously, bpftool emitted struct bpf_prog_desc fields, link fields,
and attach/detach/destroy functions for all programs in the BPF object,
causing the loader program to store subsequent program FDs into
incorrect skeleton struct fields when non-autoload programs were
present.

Furthermore, bpf_object__load() can update a program's autoload status
during preparation (e.g. for struct_ops programs when resolving kernel
BTF members or adjusting autoload based on map autocreate settings).
Move bpf_object__gen_loader() and bpf_object__load() out of gen_trace()
into do_skeleton() before counting programs and emitting struct fields so
that struct field declarations and attach/detach/destroy functions all
observe the final post-load autoload state.

Skip programs with !bpf_program__autoload(prog) when counting programs
and generating progs/links struct fields as well as attach, detach, and
destroy functions for light skeletons.

Fixes: d510296d331a ("bpftool: Use syscall/loader program in "prog load" an=
d "gen skeleton" command.")
Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
v2 -> v3:
  - Move comment from gen_trace() to do_skeleton()
  - Add comment to do_skeleton() why the loader is called early
v1 -> v2:
  - Move bpf_object__gen_loader() and bpf_object__load() out of gen_trace()

 .../bpf/bpftool/Documentation/bpftool-gen.rst |  4 +-
 tools/bpf/bpftool/gen.c                       | 76 ++++++++++++-------
 2 files changed, 52 insertions(+), 28 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bp=
ftool/Documentation/bpftool-gen.rst
index d0a36f442db7..1cdecf3e4fa5 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
@@ -184,7 +184,9 @@ OPTIONS
 -L, --use-loader
     For skeletons, generate a "light" skeleton (also known as "loader"
     skeleton). A light skeleton contains a loader eBPF program. It does no=
t use
-    the majority of the libbpf infrastructure, and does not need libelf.
+    the majority of the libbpf infrastructure, and does not need libelf. B=
PF
+    programs marked as non-autoload (e.g., via **SEC("?...")**) are skippe=
d and
+    not included in the generated skeleton.
=20
 -S, --sign
     For skeletons, generate a signed skeleton. This option must be used wi=
th
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index a50540ef6521..1e55f0e67d91 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -583,6 +583,9 @@ static void codegen_attach_detach(struct bpf_object *ob=
j, const char *obj_name)
 	bpf_object__for_each_program(prog, obj) {
 		const char *tp_name;
=20
+		if (!bpf_program__autoload(prog))
+			continue;
+
 		codegen("\
 			\n\
 			\n\
@@ -629,6 +632,8 @@ static void codegen_attach_detach(struct bpf_object *ob=
j, const char *obj_name)
 		", obj_name);
=20
 	bpf_object__for_each_program(prog, obj) {
+		if (!bpf_program__autoload(prog))
+			continue;
 		codegen("\
 			\n\
 				ret =3D ret < 0 ? ret : %1$s__%2$s__attach(skel);   \n\
@@ -646,6 +651,8 @@ static void codegen_attach_detach(struct bpf_object *ob=
j, const char *obj_name)
 		", obj_name);
=20
 	bpf_object__for_each_program(prog, obj) {
+		if (!bpf_program__autoload(prog))
+			continue;
 		codegen("\
 			\n\
 				skel_closenz(skel->links.%1$s_fd);	    \n\
@@ -676,6 +683,8 @@ static void codegen_destroy(struct bpf_object *obj, con=
st char *obj_name)
 		obj_name);
=20
 	bpf_object__for_each_program(prog, obj) {
+		if (!bpf_program__autoload(prog))
+			continue;
 		codegen("\
 			\n\
 				skel_closenz(skel->progs.%1$s.prog_fd);	    \n\
@@ -701,9 +710,9 @@ static void codegen_destroy(struct bpf_object *obj, con=
st char *obj_name)
 		obj_name);
 }
=20
-static int gen_trace(struct bpf_object *obj, const char *obj_name, const c=
har *header_guard)
+static int gen_trace(struct bpf_object *obj, const char *obj_name, const c=
har *header_guard,
+		     const struct gen_loader_opts *opts)
 {
-	DECLARE_LIBBPF_OPTS(gen_loader_opts, opts);
 	struct bpf_load_and_run_opts sopts =3D {};
 	char sig_buf[MAX_SIG_SIZE];
 	__u8 prog_sha[SHA256_DIGEST_LENGTH];
@@ -712,23 +721,6 @@ static int gen_trace(struct bpf_object *obj, const cha=
r *obj_name, const char *h
 	char ident[256];
 	int err =3D 0;
=20
-	if (sign_progs)
-		opts.gen_hash =3D true;
-
-	err =3D bpf_object__gen_loader(obj, &opts);
-	if (err)
-		return err;
-
-	err =3D bpf_object__load(obj);
-	if (err) {
-		p_err("failed to load object file");
-		goto out;
-	}
-
-	/* If there was no error during load then gen_loader_opts
-	 * are populated with the loader program.
-	 */
-
 	/* finish generating 'struct skel' */
 	codegen("\
 		\n\
@@ -752,7 +744,7 @@ static int gen_trace(struct bpf_object *obj, const char=
 *obj_name, const char *h
 				goto cleanup;				    \n\
 			skel->ctx.sz =3D (char *)&skel->links - (char *)skel; \n\
 		",
-		obj_name, opts.data_sz);
+		obj_name, opts->data_sz);
 	bpf_object__for_each_map(map, obj) {
 		const void *mmap_data =3D NULL;
 		size_t mmap_size =3D 0;
@@ -795,22 +787,22 @@ static int gen_trace(struct bpf_object *obj, const ch=
ar *obj_name, const char *h
 			static const char opts_data[] __attribute__((__aligned__(8))) =3D \"\\\=
n\
 		",
 		obj_name);
-	print_hex(opts.data, opts.data_sz);
+	print_hex(opts->data, opts->data_sz);
 	codegen("\
 		\n\
 		\";							    \n\
 			static const char opts_insn[] __attribute__((__aligned__(8))) =3D \"\\\=
n\
 		");
-	print_hex(opts.insns, opts.insns_sz);
+	print_hex(opts->insns, opts->insns_sz);
 	codegen("\
 		\n\
 		\";\n");
=20
 	if (sign_progs) {
-		sopts.insns =3D opts.insns;
-		sopts.insns_sz =3D opts.insns_sz;
-		sopts.data =3D opts.data;
-		sopts.data_sz =3D opts.data_sz;
+		sopts.insns =3D opts->insns;
+		sopts.insns_sz =3D opts->insns_sz;
+		sopts.data =3D opts->data;
+		sopts.data_sz =3D opts->data_sz;
 		sopts.excl_prog_hash =3D prog_sha;
 		sopts.excl_prog_hash_sz =3D sizeof(prog_sha);
 		sopts.signature =3D sig_buf;
@@ -1250,6 +1242,7 @@ static int do_skeleton(int argc, char **argv)
 	char header_guard[MAX_OBJ_NAME_LEN + sizeof("__SKEL_H__")];
 	size_t map_cnt =3D 0, prog_cnt =3D 0, attach_map_cnt =3D 0, file_sz, mmap=
_sz;
 	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
+	DECLARE_LIBBPF_OPTS(gen_loader_opts, gen_opts);
 	char obj_name[MAX_OBJ_NAME_LEN] =3D "", *obj_data;
 	struct bpf_object *obj =3D NULL;
 	const char *file;
@@ -1326,6 +1319,29 @@ static int do_skeleton(int argc, char **argv)
 		goto out_obj;
 	}
=20
+	/* If we are generating a loader, load the object early (before
+	 * counting programs and emitting skeleton struct definitions), as
+	 * bpf_object__load() may disable (i.e., autoload=3Dfalse) some programs
+	 * if their requirements are not met.
+	 */
+	if (use_loader) {
+		if (sign_progs)
+			gen_opts.gen_hash =3D true;
+
+		err =3D bpf_object__gen_loader(obj, &gen_opts);
+		if (err)
+			goto out;
+
+		err =3D bpf_object__load(obj);
+		if (err) {
+			p_err("failed to load object file");
+			goto out;
+		}
+		/* If there was no error during load, gen_opts is populated with
+		 * the loader program.
+		 */
+	}
+
 	bpf_object__for_each_map(map, obj) {
 		if (!get_map_ident(map, ident, sizeof(ident))) {
 			p_err("ignoring unrecognized internal map '%s'...",
@@ -1339,6 +1355,8 @@ static int do_skeleton(int argc, char **argv)
 		map_cnt++;
 	}
 	bpf_object__for_each_program(prog, obj) {
+		if (use_loader && !bpf_program__autoload(prog))
+			continue;
 		prog_cnt++;
 	}
=20
@@ -1402,6 +1420,8 @@ static int do_skeleton(int argc, char **argv)
 	if (prog_cnt) {
 		printf("\tstruct {\n");
 		bpf_object__for_each_program(prog, obj) {
+			if (use_loader && !bpf_program__autoload(prog))
+				continue;
 			if (use_loader)
 				printf("\t\tstruct bpf_prog_desc %s;\n",
 				       bpf_program__name(prog));
@@ -1415,6 +1435,8 @@ static int do_skeleton(int argc, char **argv)
 	if (prog_cnt + attach_map_cnt) {
 		printf("\tstruct {\n");
 		bpf_object__for_each_program(prog, obj) {
+			if (use_loader && !bpf_program__autoload(prog))
+				continue;
 			if (use_loader)
 				printf("\t\tint %s_fd;\n",
 				       bpf_program__name(prog));
@@ -1451,7 +1473,7 @@ static int do_skeleton(int argc, char **argv)
 			goto out;
 	}
 	if (use_loader) {
-		err =3D gen_trace(obj, obj_name, header_guard);
+		err =3D gen_trace(obj, obj_name, header_guard, &gen_opts);
 		goto out;
 	}
=20
--=20
2.55.0.1082.g2b9226bbc0-goog

