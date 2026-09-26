Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5315438643B
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 05:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790398881; cv=none; b=bMGy/6sqNt5McombII65l7vmtL7CYTgK8V4EPRyB/swQVcm2kqaUKjGW29RZE45Gd5r5ItUAU3sV2UeC8ekycueaPTgMY5pkVhFOGSG71ONBxlE9GsOKixTyMr069r1zjGF2NWWtWxILpcsmpmlOT5bxv+mZ6EhvL5C2dyKFV3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790398881; c=relaxed/simple;
	bh=nO7Z3khNcR3jrNKqHTlo7KhMcu2/n2id34chO+UGHQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUxeZmFdi2Fx031XN4WHo7wfgP5oTJliFqwlTLRh1tpuAghM2Tman2nz/Lq+r9F6TI2bFse8wqdRITMwzlUWHExgHpWfDlKQDvxiD+8mTec6BXann3EcAs+5PdsLM50bvyIhmRZYZdLp4XsS6x6u9aPdnBYyVpgSsPT7USwkHnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 210C82D4596987; Fri, 25 Sep 2026 22:01:18 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 14/21] libbpf: Add cleanup_info to bpf_prog_load_opts
Date: Fri, 25 Sep 2026 22:01:18 -0700
Message-ID: <20260926050118.2219932-1-yonghong.song@linux.dev>
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

Let a caller hand the kernel an exception cleanup table: struct
bpf_prog_load_opts grows cleanup_info, cleanup_info_cnt and
cleanup_info_rec_size, and bpf_prog_load() passes all three on to
BPF_PROG_LOAD.

The attr size it computes grows by one field rather than three:
cleanup_info_cnt is the last of them in the BPF_PROG_LOAD attr, so
offsetofend() on it already covers the other two.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/bpf.c | 6 +++++-
 tools/lib/bpf/bpf.h | 7 ++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index b49822d212ae..2e761f020b14 100644
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
+	attr.cleanup_info_rec_size =3D OPTS_GET(opts, cleanup_info_rec_size, 0)=
;
+	attr.cleanup_info =3D ptr_to_u64(OPTS_GET(opts, cleanup_info, NULL));
+	attr.cleanup_info_cnt =3D OPTS_GET(opts, cleanup_info_cnt, 0);
+
 	if (log_level) {
 		attr.log_buf =3D ptr_to_u64(log_buf);
 		attr.log_size =3D log_size;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 826d9cc9ab65..2c292d56c9a3 100644
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

