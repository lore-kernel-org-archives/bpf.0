Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9242F0680
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 19:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196107; cv=none; b=rDTw2n87cpQnbo5TDOzfXKNRQ1Zefdv59M5DH9ANOC+N5NJNtTS9eoR9oMqoxLeAB4PSVU/+5q9jz8wBZgD3T9v56NiS80sO9hYSvY3Io3BlA8sIDYnF+PpaiSq6H0UxMyO+19OCP2jCZR0rv3LSuh6LVHrdRq+0iS5di/5QA2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196107; c=relaxed/simple;
	bh=8GOCqgr5GLDp+kKGECSHln1ryMWF3dm6aID70R9QCQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fB0Vkp4G8gy3DBPYMLDFrzlTdCoWkXPMLoKapeSqBclOo6DWiCw4CCvU7EyjCsxWdNvIyamXVWywrxIdjVkK8QdYIrHbt8gV72l8FmmhuD6ChxHVUDF4qqP1r4blRZZdGO8TzAt5L7w7zlICQOZ543Gb/KRBTTuJJSGfGLuPwgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F94YfXmU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F94YfXmU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E19BC19425;
	Tue, 14 Apr 2026 19:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776196106;
	bh=8GOCqgr5GLDp+kKGECSHln1ryMWF3dm6aID70R9QCQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F94YfXmUtCRzWyDSdDlzOm3lxy1hqeNL7zZwBxzs2M/2X7PSkDBncRHRVFieBvb5b
	 zWpaMPpwHvlifq8F6EYZYe9lZuPkVtHVzpZ/fGeUohoEP/gh0AzuByuJgB9trNJnW/
	 XdYQS/eUQlhGZsZ6L3PLDzVczA5LWHIETPR3meI3ESC9VF1JV8tq+p8XgFcNzPN8eA
	 8CBytQr9x5WeBPI0Rr9BjTtRFTrvrxQZbB1ciso+VIdZ9YSnMdW7NQpNb8UfrzYn5S
	 Ro1QNXeaxwoBryMyQCjFIFvs/ffKK0uML0DsjO39JHyY6u7lfLnA6sgOij5SHh3ji5
	 Ni1lXY1iepGmw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf 2/2] libbpf: Prevent double close of btf objects
Date: Tue, 14 Apr 2026 21:48:04 +0200
Message-ID: <20260414194804.1428676-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414194804.1428676-1-jolsa@kernel.org>
References: <20260414194804.1428676-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko found possible double close of btf object fd [1],
which happens when strdup in load_module_btfs fails at which
point the obj->btf_module_cnt is already incremented.

The error path close btf fd and so does later cleanup code in
bpf_object_post_load_cleanup function.

[1] https://sashiko.dev/#/patchset/20260324081846.2334094-1-jolsa%40kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b60ac8094a9e..33e7a09915dd 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5825,7 +5825,7 @@ static int load_module_btfs(struct bpf_object *obj)
 		if (err)
 			goto err_out;
 
-		mod_btf = &obj->btf_modules[obj->btf_module_cnt++];
+		mod_btf = &obj->btf_modules[obj->btf_module_cnt];
 
 		mod_btf->btf = btf;
 		mod_btf->id = id;
@@ -5835,6 +5835,7 @@ static int load_module_btfs(struct bpf_object *obj)
 			err = -ENOMEM;
 			goto err_out;
 		}
+		obj->btf_module_cnt++;
 		continue;
 
 err_out:
-- 
2.53.0

