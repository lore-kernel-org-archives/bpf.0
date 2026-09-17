Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A47415B6C
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 05:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789624682; cv=none; b=Akuk/deAOQRifN747lOKcERQjCPoQ32i3uo21oDvnPZGJ1jCW9qMXE/g5C0Hq5gvbntli5AhAMHxpEzEyXbc61vhTcTTLuqiG2zO7k0i1099/xge1K9YCRPVYX7W3O9mo697XVAe54ZCxyFFaQGQXiKPBlA0zu59aftGxgi7eAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789624682; c=relaxed/simple;
	bh=NTLgQRT7BW0KI0dyDxiq7Q6OwPx5xhObkHYQBJXQl4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQmOsBCQTz9L0xqQZ+mM4MBXRGh0SgG5I923XkfMMATXuQv8nONjNXrPEvqgDCUrxRTNAc399pfPtHp6KH6F6X9FlFsJzfvCgr7X4fPBmFcGN8aHT3diYxyDNvcw1g3lV7Tve2bVdBUCIXubBF8M4PgIyT5/CgKpxfzHUjtZwes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 8B9FA2B48B2848; Wed, 16 Sep 2026 22:57:57 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 14/20] libbpf: Add cleanup_info to bpf_prog_load_opts
Date: Wed, 16 Sep 2026 22:57:57 -0700
Message-ID: <20260917055757.3933206-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917055645.3926444-1-yonghong.song@linux.dev>
References: <20260917055645.3926444-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Let a caller hand the kernel an exception cleanup table. Extend struct
bpf_prog_load_opts with cleanup_info, cleanup_info_cnt and
cleanup_info_rec_size, pass them through to BPF_PROG_LOAD, and grow the
attr size bpf_prog_load() computes to cover the new fields.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/bpf.c | 6 +++++-
 tools/lib/bpf/bpf.h | 7 ++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 96819c082c77..bcf490570961 100644
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
+	attr.cleanup_info_cnt =3D OPTS_GET(opts, cleanup_info_cnt, 0);
+	attr.cleanup_info_rec_size =3D OPTS_GET(opts, cleanup_info_rec_size, 0)=
;
+
 	if (log_level) {
 		attr.log_buf =3D ptr_to_u64(log_buf);
 		attr.log_size =3D log_size;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 7534a593edae..6f62a99e1e3e 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -128,9 +128,14 @@ struct bpf_prog_load_opts {
=20
 	/* if set, provides the length of fd_array */
 	__u32 fd_array_cnt;
+
+	/* exception cleanup table, from the .bpf_cleanup section */
+	const void *cleanup_info;
+	__u32 cleanup_info_cnt;
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

