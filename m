Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECEF3CF030
	for <bpf@vger.kernel.org>; Sun,  9 Aug 2026 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786287778; cv=none; b=urzh9mSuP5Bqt/fssU932heOnexD+u2KFN/3VNn3CwT++yIdrdKDRCqYE56JcvhBDOnp3NpJVtC+vQzzU31M90x6pn2Kji80AMcaGKMlMurxqhdAZaCQvB2vyozJAa8dm1m1rsY0DFqZt6+2NkE0BgzsNDsBchZRAllU5Af9dhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786287778; c=relaxed/simple;
	bh=Id5pefIyKE/U91Zn8zI+k2Hjyo9tKnshYz+qiSarsd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7Si8OnY8+gD+eW+cGGI7dBz9k99HN2re6WLMAjNXYQ5CWSNDOO8NxCqX/rgN0sapWo/MYKmF4ZpcXjPVJUoa/dACvaXkv3wD88Al5Pzt64HEgscd/xOM9goweocDYak8NiFoLBNpmJ52FXMOlksB/IC1lUiB62Cg/FD5eCUNyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HQpv1WvT; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HQpv1WvT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786287763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0TMqdN/yDSpEh6YcQdZh+gNoQqcZgWyH9Vy4rBrBQRs=;
	b=HQpv1WvT1UmCIhKrrK/hJSqT5fZtbdawTE1ZrFyjEmAcOWT1K8Vb7JPZ4kOaEKOPypM9IR
	JoCXc9oro8JJWaZMh9i+8cUJ1YWBDa/B6f3Z+hW/9kdQAEJyowYhdffyJri1AR6TRIk+YZ
	Yqs0DQeUxDYlaB2Dp+SGMV8bAIuzOSA=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Avinash Duduskar <avinash.duduskar@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Jordan Rife <jordan@jrife.io>,
	Rong Tao <rongtao@cestc.cn>,
	Eyal Birger <eyal.birger@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Jingguo Tan <tanjingguo@huawei.com>,
	Lin Ma <malin89@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 05/13] libbpf: Add tracing_multi link support for bpf progs
Date: Sun,  9 Aug 2026 23:01:03 +0800
Message-ID: <20260809150111.45000-6-leon.hwang@linux.dev>
In-Reply-To: <20260809150111.45000-1-leon.hwang@linux.dev>
References: <20260809150111.45000-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

By design, a tracing_multi link does not support both kernel functions
and bpf progs at the same time.

In libbpf, the bpf_tracing_multi_opts options provides two new fields for
tracing bpf progs:

* 'fds': the fd array of the target bpf progs. One fd must be provided
         multiple times for multiple targets.
* 'funcs': the function name array of the target bpf progs.

The 'cnt' field indicates the size of both 'fds' and 'funcs' arrays.

The 'funcs' will be translated to 'ids' by 'libbpf_find_prog_btf_id()'.

At last, 'fds'+'ids' will be passed to kernel.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.c    |  1 +
 tools/lib/bpf/bpf.h    |  2 ++
 tools/lib/bpf/libbpf.c | 37 +++++++++++++++++++++++++++++++++----
 tools/lib/bpf/libbpf.h |  4 +++-
 4 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 96819c082c77..a20585174903 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -852,6 +852,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 		attr.link_create.tracing_multi.ids = ptr_to_u64(OPTS_GET(opts, tracing_multi.ids, 0));
 		attr.link_create.tracing_multi.cookies = ptr_to_u64(OPTS_GET(opts, tracing_multi.cookies, 0));
 		attr.link_create.tracing_multi.cnt = OPTS_GET(opts, tracing_multi.cnt, 0);
+		attr.link_create.tracing_multi.fds = ptr_to_u64(OPTS_GET(opts, tracing_multi.fds, 0));
 		if (!OPTS_ZEROED(opts, tracing_multi))
 			return libbpf_err(-EINVAL);
 		break;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 7534a593edae..63961db29b74 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -474,6 +474,8 @@ struct bpf_link_create_opts {
 			const __u32 *ids;
 			const __u64 *cookies;
 			__u32 cnt;
+			__u32 :32;
+			const int *fds;
 		} tracing_multi;
 	};
 	size_t :0;
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 514e4e9daa82..d698a64ff800 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12687,10 +12687,12 @@ bpf_program__attach_tracing_multi(const struct bpf_program *prog, const char *pa
 {
 	LIBBPF_OPTS(bpf_link_create_opts, lopts);
 	int prog_fd, link_fd, err, cnt;
+	struct bpf_link *link = NULL;
 	__u32 *free_ids = NULL;
-	struct bpf_link *link;
 	const __u64 *cookies;
+	const char **funcs;
 	const __u32 *ids;
+	const int *fds;
 
 	if (!OPTS_VALID(opts, bpf_tracing_multi_opts))
 		return libbpf_err_ptr(-EINVAL);
@@ -12705,12 +12707,22 @@ bpf_program__attach_tracing_multi(const struct bpf_program *prog, const char *pa
 	cnt = OPTS_GET(opts, cnt, 0);
 	ids = OPTS_GET(opts, ids, NULL);
 	cookies = OPTS_GET(opts, cookies, NULL);
+	fds = OPTS_GET(opts, fds, NULL);
+	funcs = OPTS_GET(opts, funcs, NULL);
 
-	if (!!ids != !!cnt)
+	if (ids && fds)
+		return libbpf_err_ptr(-EINVAL);
+	if (!!fds != !!funcs)
+		return libbpf_err_ptr(-EINVAL);
+	if (fds && !cnt)
 		return libbpf_err_ptr(-EINVAL);
-	if (pattern && (ids || cookies))
+	if (ids && !cnt)
 		return libbpf_err_ptr(-EINVAL);
-	if (!pattern && !ids)
+	if (!fds && !ids && cnt)
+		return libbpf_err_ptr(-EINVAL);
+	if (pattern && (fds || ids || cookies))
+		return libbpf_err_ptr(-EINVAL);
+	if (!pattern && !ids && !fds)
 		return libbpf_err_ptr(-EINVAL);
 
 	if (pattern) {
@@ -12720,11 +12732,28 @@ bpf_program__attach_tracing_multi(const struct bpf_program *prog, const char *pa
 		if (cnt == 0)
 			return libbpf_err_ptr(-EINVAL);
 		ids = (const __u32 *) free_ids;
+	} else if (fds) {
+		size_t cap = 0;
+		int i;
+
+		err = libbpf_ensure_mem((void **) &free_ids, &cap, sizeof(*free_ids), cnt);
+		if (err)
+			return libbpf_err_ptr(err);
+
+		for (i = 0; i < cnt; i++) {
+			err = libbpf_find_prog_btf_id(funcs[i], fds[i], prog->obj->token_fd);
+			if (err < 0)
+				goto error;
+
+			free_ids[i] = err;
+		}
+		ids = (const __u32 *) free_ids;
 	}
 
 	lopts.tracing_multi.ids = ids;
 	lopts.tracing_multi.cookies = cookies;
 	lopts.tracing_multi.cnt = cnt;
+	lopts.tracing_multi.fds = fds;
 
 	link = calloc(1, sizeof(*link));
 	if (!link) {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index b965ad571540..7b2cfa1ad572 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -732,10 +732,12 @@ struct bpf_tracing_multi_opts {
 	const __u32 *ids;
 	const __u64 *cookies;
 	size_t cnt;
+	const int *fds;
+	const char **funcs;
 	size_t :0;
 };
 
-#define bpf_tracing_multi_opts__last_field cnt
+#define bpf_tracing_multi_opts__last_field funcs
 
 LIBBPF_API struct bpf_link *
 bpf_program__attach_tracing_multi(const struct bpf_program *prog, const char *pattern,
-- 
2.55.0

