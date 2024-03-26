Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3605129E85
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 04:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711426526; cv=none; b=nr9xnCs5r6pLwMgDUuJWaPOGS3nNAVSKclLIKUyg3F4ixFGrCiRLMh5a6wvEDjWtCLVz2dPpp0N1VJ/kUni9kZi8pQhOGeV10lOxTLvF7k/K+bhC1t7OvWWD2LhApj5bGzY06fSvMm8gURA5a04PTwpxQswjmfubzvErdMz4rjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711426526; c=relaxed/simple;
	bh=MjzhK43W8Km1fOVGIaxoMRkoJx9J7e5IMBpI3kx6NBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8z0d1CU6FWTw7MQLfPMAruWBnaRddm2hl5Y8lixd4lwE4JCQ5K8ouQPrz9vh0oCV9/1MjCLEDC9onazXABC4v5IEjS8Ewb8pbkpTxcYq0TDCfxmBUEeYXaLDCHwZawopDBZ12sjK9PrZgy/LZUTQgS+59rnWhzl6R2JO8jF2po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id AFA2524E712F; Mon, 25 Mar 2024 21:15:13 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 6/8] selftests/bpf: Add {load,search}_kallsyms_custom_local()
Date: Mon, 25 Mar 2024 21:15:13 -0700
Message-ID: <20240326041513.1199440-1-yonghong.song@linux.dev>
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

These two functions allow selftests to do loading/searching
kallsyms based on their specific compare functions.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/trace_helpers.c | 27 +++++++++++++++++++++
 tools/testing/selftests/bpf/trace_helpers.h |  5 ++++
 2 files changed, 32 insertions(+)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/=
selftests/bpf/trace_helpers.c
index fc9de4a89aea..7f45b4cb41fe 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -114,6 +114,11 @@ struct ksyms *load_kallsyms_local(void)
 	return load_kallsyms_local_common(ksym_cmp);
 }
=20
+struct ksyms *load_kallsyms_custom_local(ksym_cmp_t cmp_cb)
+{
+	return load_kallsyms_local_common(cmp_cb);
+}
+
 int load_kallsyms(void)
 {
 	pthread_mutex_lock(&ksyms_mutex);
@@ -153,6 +158,28 @@ struct ksym *ksym_search_local(struct ksyms *ksyms, =
long key)
 	return &ksyms->syms[0];
 }
=20
+struct ksym *search_kallsyms_custom_local(struct ksyms *ksyms, const voi=
d *p,
+					  ksym_search_cmp_t cmp_cb)
+{
+	int start =3D 0, mid, end =3D ksyms->sym_cnt;
+	struct ksym *ks;
+	int result;
+
+	while (start < end) {
+		mid =3D start + (end - start) / 2;
+		ks =3D &ksyms->syms[mid];
+		result =3D cmp_cb(p, ks);
+		if (result < 0)
+			end =3D mid;
+		else if (result > 0)
+			start =3D mid + 1;
+		else
+			return ks;
+	}
+
+	return NULL;
+}
+
 struct ksym *ksym_search(long key)
 {
 	if (!ksyms)
diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/=
selftests/bpf/trace_helpers.h
index 9da0d0484eed..d1ed71789049 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -14,6 +14,7 @@ struct ksym {
 struct ksyms;
=20
 typedef int (*ksym_cmp_t)(const void *p1, const void *p2);
+typedef int (*ksym_search_cmp_t)(const void *p1, const struct ksym *p2);
=20
 int load_kallsyms(void);
 struct ksym *ksym_search(long key);
@@ -24,6 +25,10 @@ struct ksym *ksym_search_local(struct ksyms *ksyms, lo=
ng key);
 long ksym_get_addr_local(struct ksyms *ksyms, const char *name);
 void free_kallsyms_local(struct ksyms *ksyms);
=20
+struct ksyms *load_kallsyms_custom_local(ksym_cmp_t cmp_cb);
+struct ksym *search_kallsyms_custom_local(struct ksyms *ksyms, const voi=
d *p1,
+					  ksym_search_cmp_t cmp_cb);
+
 /* open kallsyms and find addresses on the fly, faster than load + searc=
h. */
 int kallsyms_find(const char *sym, unsigned long long *addr);
=20
--=20
2.43.0

