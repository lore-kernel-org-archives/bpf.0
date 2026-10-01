Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61334A49A3
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861497; cv=none; b=dvZSd7a6GnA40ad061yIG94RB8geRC4GBzfE4CixXZC1YAAqzovFXBKeGBHfw8c4kGBm03tdxsoecgcBmxVN1vQcSzZUZiH/QiB1c3DPoSm5BgzT44GWc2E9ek29DofaaSJr/+HvM+lhG0P7p+scT7bo+hmZ3dySJvFOKJ2S4Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861497; c=relaxed/simple;
	bh=1p0FJ63onCFKtmdr4prcpHpYIELpe2HRTW84eSqwpsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFUhA01bOE6JkT7rCUM+JxoG5V5JGeQ00JUDtV3kD0i+z/a+p3vcWbaN4y5BYqCS6dtl/RNTTGmQ92ZC0P0ezeij1EaxoOxffW8+4Ghn4mPmKkdijaAKB9RGT804/KzdhUvlQQ2iYhw6kSNb2JCvWRhOEpv9mVXrdzI1eDHnabs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id A30862E6E12451; Thu,  1 Oct 2026 06:31:25 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v8 15/22] libbpf: Add cleanup_info to bpf_prog_load_opts
Date: Thu,  1 Oct 2026 06:31:25 -0700
Message-ID: <20261001133125.1344001-1-yonghong.song@linux.dev>
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

Let a caller hand the kernel an exception cleanup table: struct
bpf_prog_load_opts grows cleanup_info_cnt, cleanup_info and
cleanup_info_rec_size, and bpf_prog_load() passes all three on to
BPF_PROG_LOAD.

The attr size it computes now ends at cleanup_info_cnt, the last of the
three new fields in the BPF_PROG_LOAD attr, so it covers all of them. In
the opts, cleanup_info_cnt comes first so that it fills the four bytes
after fd_array_cnt the pointer would otherwise leave as a hole.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/bpf.c | 6 +++++-
 tools/lib/bpf/bpf.h | 7 ++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index b49822d212ae..b4031f62bdee 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -295,7 +295,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 		  const struct bpf_insn *insns, size_t insn_cnt,
 		  struct bpf_prog_load_opts *opts)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, keyring_id);
+	const size_t attr_sz =3D offsetofend(union bpf_attr, cleanup_info_cnt);
 	void *finfo =3D NULL, *linfo =3D NULL;
 	const char *func_info, *line_info;
 	__u32 log_size, log_level, attach_prog_fd, attach_btf_obj_fd;
@@ -370,6 +370,10 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 	attr.fd_array =3D ptr_to_u64(OPTS_GET(opts, fd_array, NULL));
 	attr.fd_array_cnt =3D OPTS_GET(opts, fd_array_cnt, 0);
=20
+	attr.cleanup_info =3D ptr_to_u64(OPTS_GET(opts, cleanup_info, NULL));
+	attr.cleanup_info_rec_size =3D OPTS_GET(opts, cleanup_info_rec_size, 0)=
;
+	attr.cleanup_info_cnt =3D OPTS_GET(opts, cleanup_info_cnt, 0);
+
 	if (log_level) {
 		attr.log_buf =3D ptr_to_u64(log_buf);
 		attr.log_size =3D log_size;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 826d9cc9ab65..cbe56ddc8cf7 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -128,9 +128,14 @@ struct bpf_prog_load_opts {
=20
 	/* if set, provides the length of fd_array */
 	__u32 fd_array_cnt;
+
+	/* exception cleanup table, from the .bpf_cleanup section */
+	__u32 cleanup_info_cnt;
+	const void *cleanup_info;
+	__u32 cleanup_info_rec_size;
 	size_t :0;
 };
-#define bpf_prog_load_opts__last_field fd_array_cnt
+#define bpf_prog_load_opts__last_field cleanup_info_rec_size
=20
 LIBBPF_API int bpf_prog_load(enum bpf_prog_type prog_type,
 			     const char *prog_name, const char *license,
--=20
2.53.0-Meta

