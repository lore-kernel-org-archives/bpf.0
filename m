Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD983CD8B7
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241504; cv=none; b=VdJxlT3GjYjZU69j/5CWRJuEkR5IAqeOP1sItAQYkfQ+aR3kZCbR53gJQI6H6TKK0i+5tII0eP0Coeb3lev6ZU762aigdC7RQ1Uc4SLUO2o+k1jpqoxwLcn2ZAla8X/1vbUZOLi2BKX1jyZMqnLnywEeC5ngvuzjnbeNsLq0FzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241504; c=relaxed/simple;
	bh=VhR0eFsn+I0v/Eg6siW9gMGJOZDp2bozUV748H0mBsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dSbWeb+WxhX6HagZuJqRlSynWWWE0CrbctckpLY5nMySneSkdbGMgrtnN0nl1QyZRCYPveVdOuPOeeINZrEvKfp05PJXL+YSunGkycmk2gh0+qjkygRKiR6E8XS5s/Xy0kUkiooqReA8YWwA6VgPOXdwL3V+ythR05NYOtpDU+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loqRQyhD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loqRQyhD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45203C2BCB0;
	Wed, 15 Apr 2026 08:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776241504;
	bh=VhR0eFsn+I0v/Eg6siW9gMGJOZDp2bozUV748H0mBsQ=;
	h=From:To:Cc:Subject:Date:From;
	b=loqRQyhDTCG0Mnc4R29aed/BCcIP9CSv7xdrS76ddn/rZEBbSrxizDQa4sSuvd7zu
	 Ww5rrJeJm+OMXqQpiQt6OkhDkRQdKwIfgG4Z4Wc0j63v0/l5Y1JImg0/wGRxAFC57M
	 cDgItsv2LyxPYFnLEGefPiFjKqi5qbMCcaxpo+r1EtLfZxutpL1sOpr2uqX8bMSHED
	 wlcKTSZCgpDTRUnbWwlzz5aJB1Gc+G/XseKULD4oNCKG9atGB6Rj+ZJcppKRQ3NlLo
	 ipN4ATh2sRXby/25LKAxJRm6jlnsmopgNL4JyYwTX4cTjbeFpCzio23Z1ryDdKwtWr
	 IySLWCwv0nMhQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>
Subject: [PATCHv2 bpf] libbpf: Prevent double close of btf objects
Date: Wed, 15 Apr 2026 10:24:52 +0200
Message-ID: <20260415082452.1489147-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
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

Incrementing obj->btf_module_cnt only if there's no failure
and releasing btf object in error path.

Fixes: 91abb4a6d79d ("libbpf: Support attachment of BPF tracing programs to kernel modules")
[1] https://sashiko.dev/#/patchset/20260324081846.2334094-1-jolsa%40kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
v2 changes:
- squashed patches together, because they depend on each other [ci]
- added Fixes tag [ci]

 tools/lib/bpf/libbpf.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8b0c3246097f..79d9607d26e2 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5806,7 +5806,6 @@ static int load_module_btfs(struct bpf_object *obj)
 {
 	struct bpf_btf_info info;
 	struct module_btf *mod_btf;
-	struct btf *btf;
 	char name[64];
 	__u32 id = 0, len;
 	int err, fd;
@@ -5825,6 +5824,8 @@ static int load_module_btfs(struct bpf_object *obj)
 		return 0;
 
 	while (true) {
+		struct btf *btf = NULL;
+
 		err = bpf_btf_get_next_id(id, &id);
 		if (err && errno == ENOENT)
 			return 0;
@@ -5878,7 +5879,7 @@ static int load_module_btfs(struct bpf_object *obj)
 		if (err)
 			goto err_out;
 
-		mod_btf = &obj->btf_modules[obj->btf_module_cnt++];
+		mod_btf = &obj->btf_modules[obj->btf_module_cnt];
 
 		mod_btf->btf = btf;
 		mod_btf->id = id;
@@ -5888,9 +5889,11 @@ static int load_module_btfs(struct bpf_object *obj)
 			err = -ENOMEM;
 			goto err_out;
 		}
+		obj->btf_module_cnt++;
 		continue;
 
 err_out:
+		btf__free(btf);
 		close(fd);
 		return err;
 	}
-- 
2.53.0

