Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A06C1272CC
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 20:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670141; cv=none; b=J2jCWSzwanG5Z31jAz2MW+YGiVF+zCJhVnsbhyx5Kq1fSz68iykiIh7X8GQDpcS9n3uGoWENm665IwMaAiAHqpTmH1gXNGkXq+iR4iSg5Y1x6l1I+9x7ArCod6+RAaR5H8Gq7ya6+hF6W+AQG1DiAgA/6DS6OemgUBjpmkXo3eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670141; c=relaxed/simple;
	bh=ll3Z/X8MG4ctgT1VjA3QJxlrGJWaAATIywq7+FyiysA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyACyiDGSaMSb4Vn3VMce9AUOdOTC6xATNVLUivn0+AM8xVtbBsLeBIN2aDMpxXeKqlbmXv63lBmP1TBwzdAVLIvVW4OHTRIXkau+7pfMc+AXVYc9FnpePbyZaxSJY1Wo7Y6zbmQxTrfriZYVUFKKid1lZk275qotNLSKiHqlgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 1F24214A9145; Tue,  5 Mar 2024 12:22:06 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [RFC PATCH bpf-next 2/5] libbpf: Refactor bpf_program_attach_fd()
Date: Tue,  5 Mar 2024 12:22:06 -0800
Message-ID: <20240305202206.3891411-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240305202155.3890667-1-yonghong.song@linux.dev>
References: <20240305202155.3890667-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Refactor function bpf_program_attach_fd() to provide a helper function
which has attach_type as one of input parameters. This will make later
libbpf change easier to understand.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/libbpf.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6c2979f1b471..97b573516675 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12151,11 +12151,10 @@ static int attach_lsm(const struct bpf_program =
*prog, long cookie, struct bpf_li
 }
=20
 static struct bpf_link *
-bpf_program_attach_fd(const struct bpf_program *prog,
-		      int target_fd, const char *target_name,
-		      const struct bpf_link_create_opts *opts)
+__bpf_program_attach_fd(const struct bpf_program *prog, int target_fd,
+			enum bpf_attach_type attach_type, const char *target_name,
+			const struct bpf_link_create_opts *opts)
 {
-	enum bpf_attach_type attach_type;
 	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link *link;
 	int prog_fd, link_fd;
@@ -12171,7 +12170,6 @@ bpf_program_attach_fd(const struct bpf_program *p=
rog,
 		return libbpf_err_ptr(-ENOMEM);
 	link->detach =3D &bpf_link__detach_fd;
=20
-	attach_type =3D bpf_program__expected_attach_type(prog);
 	link_fd =3D bpf_link_create(prog_fd, target_fd, attach_type, opts);
 	if (link_fd < 0) {
 		link_fd =3D -errno;
@@ -12185,6 +12183,16 @@ bpf_program_attach_fd(const struct bpf_program *=
prog,
 	return link;
 }
=20
+static struct bpf_link *
+bpf_program_attach_fd(const struct bpf_program *prog,
+		      int target_fd, const char *target_name,
+		      const struct bpf_link_create_opts *opts)
+{
+	return __bpf_program_attach_fd(prog, target_fd,
+				       bpf_program__expected_attach_type(prog),
+				       target_name, opts);
+}
+
 struct bpf_link *
 bpf_program__attach_cgroup(const struct bpf_program *prog, int cgroup_fd=
)
 {
--=20
2.43.0

