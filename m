Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3392723E358
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 19:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196097; cv=none; b=I+lkaiwwKUHA77Gy9ALKZwfEjlpZba+1VngQ1Yh77n0N3yS1HF6ZUfK8sg2uivhfXIsjD0ehvoEgtmpOFwEB6Rg7ZzNQM0u7gfYoyYc/RVFA4fQaI57d+G0OuFRMEwqc2oTYpCp9kQ2lRmbBHuQFmVU7cWWZW1h3wEZrE4IEX10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196097; c=relaxed/simple;
	bh=Fcy8Hdph+JGAbuaKjHtHApVTVVOyug4zKWkgdce1BEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qIc99s3WNKjwDRahMTui7I2j+7RrUJhbjbO8pspgMyhq37bxsqJrO6UyCetJFM/CPnRbZY8czIcx1lOPrMY/z3yCsaPSuv2NhiFAW+QK7pz07yuNeTWE9b4V4lvytIZ8qWeUBCEqC/iTZiJeMegtJ300Gf9d+gihYkx21MHfo5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPsdAiwO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPsdAiwO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB1EC19425;
	Tue, 14 Apr 2026 19:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776196096;
	bh=Fcy8Hdph+JGAbuaKjHtHApVTVVOyug4zKWkgdce1BEI=;
	h=From:To:Cc:Subject:Date:From;
	b=LPsdAiwOBNup2ovMex6nfWy7+BWT4bnrMW65xrL3t3/7LZX2UmJ0Z479BaVmPtmXR
	 PMETsB+qYfwcVxBIA8rrKX6St2myymuK8c9jJGv8MrwwERdLun7jy26Ak2Vf2lopDr
	 uIaMs24IqnZUcul2RSroFTtRoZTk/gHVa2I0pHh/dUbp+f7XQVJPi8t2X9vWY3b70y
	 YAEB1i2Lkr1W6D9wPu2Jv6cOD15b3bGu6JCN04Mm6dP6R5NwAvbo1oSbyRaDpikQx4
	 QQpXH/rW7DQstlRxuNoUUw9/ixN0QSMcre2znqbxutPA0NQ3UWuRWrlhD+kExqPMfn
	 8lje1RThtVWqA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf 1/2] libbpf: Fix btf object leak in load_module_btfs
Date: Tue, 14 Apr 2026 21:48:03 +0200
Message-ID: <20260414194804.1428676-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko found leak in the load_module_btfs error path [1],
which happens when libbpf_ensure_mem fails, then the btf
object is leaked.

Adding missing btf__free object and making sure each iteration
starts with NULL-ed btf pointer.

[1] https://sashiko.dev/#/patchset/20260324081846.2334094-1-jolsa%40kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0be7017800fe..b60ac8094a9e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5752,7 +5752,6 @@ static int load_module_btfs(struct bpf_object *obj)
 {
 	struct bpf_btf_info info;
 	struct module_btf *mod_btf;
-	struct btf *btf;
 	char name[64];
 	__u32 id = 0, len;
 	int err, fd;
@@ -5771,6 +5770,8 @@ static int load_module_btfs(struct bpf_object *obj)
 		return 0;
 
 	while (true) {
+		struct btf *btf = NULL;
+
 		err = bpf_btf_get_next_id(id, &id);
 		if (err && errno == ENOENT)
 			return 0;
@@ -5837,6 +5838,7 @@ static int load_module_btfs(struct bpf_object *obj)
 		continue;
 
 err_out:
+		btf__free(btf);
 		close(fd);
 		return err;
 	}
-- 
2.53.0

