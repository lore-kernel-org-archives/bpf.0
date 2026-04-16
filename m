Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A60346AC4
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776333648; cv=none; b=kxyp0PQzM5KQRDVnxgWf0g12jAeWePpeo7ANUQXFHj/txkt2csZhwx4Y6d09Wng01PF/+BGAtHSgKjt+ZsRhEMQLUwXBV6IeIlYeirbBv+dtW/q9ReK5mI7F6ogdi2s4eVwwkc1sTffosy0iorIa84LlU1wZUCZ22XnEb1vH2nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776333648; c=relaxed/simple;
	bh=XLc8P9lrbgxCpAo6QVZjyvfeDE0TEazGhlD3vhYdLuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tlSCwWQORuXh/Vri47MSLiRXTydDAnDuzoPJu+LZtbfPYigz2d+4+pGadg/SZSUTtZxxVN63IBN0chIdWKz7WL+0BVPnzsWwH33cleSDX/bXTc0UnF7l0pdN3CkqLUgjT82EO5VpFQ7PxgKcw30uTSCfEVB3fnJcsS89g+gdQSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieXHju5z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieXHju5z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B20C2BCAF;
	Thu, 16 Apr 2026 10:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776333647;
	bh=XLc8P9lrbgxCpAo6QVZjyvfeDE0TEazGhlD3vhYdLuc=;
	h=From:To:Cc:Subject:Date:From;
	b=ieXHju5zbMkvpSCQwkQylX2xjhFnlsVo3jRfvORF6NqiZnXnx6WFuYGiYHis9gInS
	 uigU+5jJ0yDdfjM5rjSKVpdld8cJTM7jBmNJdIzWtMMMa34fKFiTiSidG1AfJyUDL2
	 tkJ8frPFgwRcOz5yhJQFX0OVErFkzU1GEEnEiXPRhJMPQ6o+aIyhKilUU6taj1li9/
	 1CpCY3jNQu8YO3P1+YGcoGuYP3PEHH3rPd9BGEQez7RxeCg4wh7XLN8Kal6htrT9I6
	 NQLXljOfdtJLB3/5XllYvT88NTgWg4n9Qm9LKm9CElI6f68/RgddDnRuW+v67Ei2gp
	 1/X3HBPwfux/A==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>
Subject: [PATCHv3 bpf] libbpf: Prevent double close and leak of btf objects
Date: Thu, 16 Apr 2026 12:00:34 +0200
Message-ID: <20260416100034.1610852-1-jolsa@kernel.org>
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

Also libbpf_ensure_mem failure leaves btf object not assigned
and it's leaked.

Replacing the err_out label with break to make the error path
less confusing as suggested by Alan.

Incrementing obj->btf_module_cnt only if there's no failure
and releasing btf object in error path.

Fixes: 91abb4a6d79d ("libbpf: Support attachment of BPF tracing programs to kernel modules")
[1] https://sashiko.dev/#/patchset/20260324081846.2334094-1-jolsa%40kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
v2: https://lore.kernel.org/bpf/20260415082452.1489147-1-jolsa@kernel.org/

v3 changes:
- replacing the err_out label with break [Alan]
- subject change [Alan]

 tools/lib/bpf/libbpf.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8b0c3246097f..3a80a018fc7d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5852,11 +5852,12 @@ static int load_module_btfs(struct bpf_object *obj)
 		info.name = ptr_to_u64(name);
 		info.name_len = sizeof(name);
 
+		btf = NULL;
 		err = bpf_btf_get_info_by_fd(fd, &info, &len);
 		if (err) {
 			err = -errno;
 			pr_warn("failed to get BTF object #%d info: %s\n", id, errstr(err));
-			goto err_out;
+			break;
 		}
 
 		/* ignore non-module BTFs */
@@ -5870,15 +5871,15 @@ static int load_module_btfs(struct bpf_object *obj)
 		if (err) {
 			pr_warn("failed to load module [%s]'s BTF object #%d: %s\n",
 				name, id, errstr(err));
-			goto err_out;
+			break;
 		}
 
 		err = libbpf_ensure_mem((void **)&obj->btf_modules, &obj->btf_module_cap,
 					sizeof(*obj->btf_modules), obj->btf_module_cnt + 1);
 		if (err)
-			goto err_out;
+			break;
 
-		mod_btf = &obj->btf_modules[obj->btf_module_cnt++];
+		mod_btf = &obj->btf_modules[obj->btf_module_cnt];
 
 		mod_btf->btf = btf;
 		mod_btf->id = id;
@@ -5886,16 +5887,16 @@ static int load_module_btfs(struct bpf_object *obj)
 		mod_btf->name = strdup(name);
 		if (!mod_btf->name) {
 			err = -ENOMEM;
-			goto err_out;
+			break;
 		}
-		continue;
+		obj->btf_module_cnt++;
+	}
 
-err_out:
+	if (err) {
+		btf__free(btf);
 		close(fd);
-		return err;
 	}
-
-	return 0;
+	return err;
 }
 
 static struct bpf_core_cand_list *
-- 
2.53.0

