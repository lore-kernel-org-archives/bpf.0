Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F2612A17B
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 04:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711426508; cv=none; b=Z623gT/hS3NsfVjD4nCTxGtNZe7rCS/QLmbQncUXBGToRRWQ6iuubHsxYWDViA71Jg9HIE9fDh9SN/2Kmvo9GmuMiqFvrCMofxwXv5Ng9OA2arvT44ManLAj9pKkDuJOWRTQEd8aqU2SfQhbci6ORtC/6TUhqulmqfB45JN32fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711426508; c=relaxed/simple;
	bh=SJFOIDR0Wn5dmwRkG+R7G+Xr68IDtJ4o5KyAhIjIhbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MidX4VrMoM9slOnRmHzJODnjOfZ8xhzLiU+lcczCRgJzgsY8+1XXG6NxoW+FNZQkzqmbKXGxCSNINNDynXP4SkNsd6wctm7tNIBZh6ujp2hbEEeuvp2GFUAB9fKvYrB2xb6q9HzrG7fuR6IUzcU80xPoVwIxGjm+nIX8/G+dyZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 44BBF24E709E; Mon, 25 Mar 2024 21:14:53 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 2/8] libbpf: Mark libbpf_kallsyms_parse static function
Date: Mon, 25 Mar 2024 21:14:53 -0700
Message-ID: <20240326041453.1197949-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326041443.1197498-1-yonghong.song@linux.dev>
References: <20240326041443.1197498-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently libbpf_kallsyms_parse() function is declared as a global
function but actually it is not a API and there is no external
users in bpftool/bpf-selftests. So let us mark the function as
static.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/libbpf.c          | 5 ++++-
 tools/lib/bpf/libbpf_internal.h | 5 -----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8eb2cd4ef288..1f5581b9d11b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7982,7 +7982,10 @@ static int bpf_object__sanitize_maps(struct bpf_ob=
ject *obj)
 	return 0;
 }
=20
-int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *ctx)
+typedef int (*kallsyms_cb_t)(unsigned long long sym_addr, char sym_type,
+			     const char *sym_name, void *ctx);
+
+static int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *ctx)
 {
 	char sym_type, sym_name[500];
 	unsigned long long sym_addr;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
index 864b36177424..a0dcfb82e455 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -518,11 +518,6 @@ int btf_ext_visit_str_offs(struct btf_ext *btf_ext, =
str_off_visit_fn visit, void
 __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *type=
_name,
 				 __u32 kind);
=20
-typedef int (*kallsyms_cb_t)(unsigned long long sym_addr, char sym_type,
-			     const char *sym_name, void *ctx);
-
-int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *arg);
-
 /* handle direct returned errors */
 static inline int libbpf_err(int ret)
 {
--=20
2.43.0

