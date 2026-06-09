Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAD92D0C98
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001800; cv=none; b=fjEFQqkCQX8VzMYH+9+yvd/CaKIEDXOEZFtQ0woP5kAXYT4TX9CNqlvwwV4LUstuRKCrJIEt3xLMQCEHPXGHEt5CMsgTBo+/YuruUTF3Uys7v9jlDlkJg46fy76+ltML8ilJL7tgaDfArQ2suXWpK4H24jdvsAG1xPJqD/PGvFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001800; c=relaxed/simple;
	bh=Vv1cZAv+0c1IBEatJNuSKcFZRHTQi6NTL8A+Gzrw4oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACUQcwX+uZTbqc5HOx/SEMUb5GffocSHwm/aR226dCq+GmHH6oBHgUNgq3D7wJUgShjV7cNvQG8bh+G32SO9kEPMQXLhD9Uepl8oK3ps2IQOeLLTL+kB7ZCrzkMdN08Y3X73oYy0yK4OJ0brzLNfVKkL7nSIbpo01xciAy3hs5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6hU5L9d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6hU5L9d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5FE1F00893;
	Tue,  9 Jun 2026 10:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781001799;
	bh=v+v3iXW2lWkTytq7OLGagYfrOsYjsQexmVsAgWSCYOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j6hU5L9dPlFTi8BPytDvqO9bhClesKaDy9vEvOlx3xzgAv7ytEOhRxsN0Cz52emLx
	 qsC7ay6AP9amZfZ0+o+GON3+PeeCrU26XPMW/QAYE7bxZr4qit45v8YoSMo/TiEOWb
	 RS8FFq3nVZFOkVUZj70nLfXVxn8QRT19rqpYaI97VYR4NMOLzB+VZsvWADRD+pLXmn
	 iQIbNS2IwYAuSal5TvNH07bnWkN5dUCkwMZ9DsAn6eUjOyfY7Moj/4Qg7D4qHHBcyo
	 d0nsQk58T/rcJFm5m6nJbaM2Vmr5PG9IWs8jOZ6G8CVfdEFIGOStPZJSaCwGqLGVJ1
	 E1Jc6hoVEgd/A==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH bpf-next 3/6] libbpf: Add path_fd to struct bpf_link_create_opts
Date: Tue,  9 Jun 2026 12:42:41 +0200
Message-ID: <20260609104244.588321-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609104244.588321-1-jolsa@kernel.org>
References: <20260609104244.588321-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding the path_fd field to struct bpf_link_create_opts and passing it
through kernel attr interface.

Assisted-by: Codex:GPT-5.4
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/bpf.c | 1 +
 tools/lib/bpf/bpf.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index f37e3416f61a..96819c082c77 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -842,6 +842,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 		attr.link_create.uprobe_multi.ref_ctr_offsets = ptr_to_u64(OPTS_GET(opts, uprobe_multi.ref_ctr_offsets, 0));
 		attr.link_create.uprobe_multi.cookies = ptr_to_u64(OPTS_GET(opts, uprobe_multi.cookies, 0));
 		attr.link_create.uprobe_multi.pid = OPTS_GET(opts, uprobe_multi.pid, 0);
+		attr.link_create.uprobe_multi.path_fd = OPTS_GET(opts, uprobe_multi.path_fd, 0);
 		if (!OPTS_ZEROED(opts, uprobe_multi))
 			return libbpf_err(-EINVAL);
 		break;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 012354131cf6..7534a593edae 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -444,6 +444,7 @@ struct bpf_link_create_opts {
 			const unsigned long *ref_ctr_offsets;
 			const __u64 *cookies;
 			__u32 pid;
+			__u32 path_fd;
 		} uprobe_multi;
 		struct {
 			__u64 cookie;
@@ -477,7 +478,7 @@ struct bpf_link_create_opts {
 	};
 	size_t :0;
 };
-#define bpf_link_create_opts__last_field uprobe_multi.pid
+#define bpf_link_create_opts__last_field uprobe_multi.path_fd
 
 LIBBPF_API int bpf_link_create(int prog_fd, int target_fd,
 			       enum bpf_attach_type attach_type,
-- 
2.54.0

