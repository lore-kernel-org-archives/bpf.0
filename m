Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A523A12AACE
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 04:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711426525; cv=none; b=gBlEY2CkaL+8Kx/9/j/VLI6g5EB8G1c4t6eYxpRMrv9bVepzoVcY/5Z5Ny+K6CgbPFtLzmndBWagvFdg8IkcqKE36Ej97wQBA3y7ctE9fCaJzwZK5FN4TNCri9XZOpmot9o4TcoRaUlObXhXsN5gfMTKqg6STjYefjjOyBpv6nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711426525; c=relaxed/simple;
	bh=N+ZS0D6/p9van+/GW5y3SOSOUgVt5rrjTA8Am1Cjngk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/CovSgi1dySh4rz1Utexj808WAX3yOu/c6OtgeYdGDTsk5P2yXv1LxA4nhILD0eiV7VjTBGXS1UL+1xoqBlVe6TVFd83F9mFNZNVsyinjzcIA2mTvKtliVgHejvcUF7gGr8sBYLinlDATXW0qOupgClLj6So2OpLY4Iwyr9LoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 8CB8024E711A; Mon, 25 Mar 2024 21:15:08 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 5/8] selftests/bpf: Refactor trace helper func load_kallsyms_local()
Date: Mon, 25 Mar 2024 21:15:08 -0700
Message-ID: <20240326041508.1199239-1-yonghong.song@linux.dev>
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

Refactor trace helper function load_kallsyms_local() such that
it invokes a common function with a compare function as input.
The common function will be used later for other local functions.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/trace_helpers.c | 19 ++++++++++++-------
 tools/testing/selftests/bpf/trace_helpers.h |  2 ++
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/=
selftests/bpf/trace_helpers.c
index 27fd7ed3e4b0..fc9de4a89aea 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -61,12 +61,7 @@ void free_kallsyms_local(struct ksyms *ksyms)
 	free(ksyms);
 }
=20
-static int ksym_cmp(const void *p1, const void *p2)
-{
-	return ((struct ksym *)p1)->addr - ((struct ksym *)p2)->addr;
-}
-
-struct ksyms *load_kallsyms_local(void)
+static struct ksyms *load_kallsyms_local_common(ksym_cmp_t cmp_cb)
 {
 	FILE *f;
 	char func[256], buf[256];
@@ -100,7 +95,7 @@ struct ksyms *load_kallsyms_local(void)
 			goto error;
 	}
 	fclose(f);
-	qsort(ksyms->syms, ksyms->sym_cnt, sizeof(struct ksym), ksym_cmp);
+	qsort(ksyms->syms, ksyms->sym_cnt, sizeof(struct ksym), cmp_cb);
 	return ksyms;
=20
 error:
@@ -109,6 +104,16 @@ struct ksyms *load_kallsyms_local(void)
 	return NULL;
 }
=20
+static int ksym_cmp(const void *p1, const void *p2)
+{
+	return ((struct ksym *)p1)->addr - ((struct ksym *)p2)->addr;
+}
+
+struct ksyms *load_kallsyms_local(void)
+{
+	return load_kallsyms_local_common(ksym_cmp);
+}
+
 int load_kallsyms(void)
 {
 	pthread_mutex_lock(&ksyms_mutex);
diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/=
selftests/bpf/trace_helpers.h
index 04fd1da7079d..9da0d0484eed 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -13,6 +13,8 @@ struct ksym {
 };
 struct ksyms;
=20
+typedef int (*ksym_cmp_t)(const void *p1, const void *p2);
+
 int load_kallsyms(void);
 struct ksym *ksym_search(long key);
 long ksym_get_addr(const char *name);
--=20
2.43.0

