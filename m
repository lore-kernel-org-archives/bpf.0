Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62070241139;
	Wed,  4 Mar 2026 22:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772663048; cv=none; b=VeU7/MYN+jZYD4HzV43D2Bts2gCqU++LsqdtgRXZJsVMPX7KxVVnps8IaROWaeezAojAsmLqmpmgrXiCDskKqCCiQvh6LO1rUX6X8snwyd6LYAq3M6qEfMSfkRZ0a1oqqFpynlpK4B/fR1mt3wxfH4lV8tsNNSZJIOU4aL3JiAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772663048; c=relaxed/simple;
	bh=fFfxsDnv287J+jrT+ZdftoHXoSRd0t47gMvczyt1+lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FbYyFtj+qE8TEAGvrHgI5rVXLdqKnnEsLtFOmwsKiNix27NZ79WQfTRADCn0zW0toCmCcfmqZXiCxzZgyS9iTs2BJafsQ5xIADeYRkIvwW2jf7Cx5x7OQv/1ayAbmlvFREZZZn0s1WRsWszV9KZ3HN7Kztr8/KS2bAZrjvMz3y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dI9jLjF2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dI9jLjF2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC33C4CEF7;
	Wed,  4 Mar 2026 22:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772663048;
	bh=fFfxsDnv287J+jrT+ZdftoHXoSRd0t47gMvczyt1+lU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dI9jLjF2LUfea6aemwAFCLJNEzWM4S4Z6jwE1tZ/UJ+h9AM3T2LRvJMhVRtnntEqN
	 dV7orHZ//UHqpp11NIfnKFXUqbrS1OQbqwgc9N9JzZrOK7QouX4Y72L4D7W0OGuxpg
	 jXceJtFpkkrGRULdsSspCdcSeWoyMXKpS/fj+M2VvaeZSrOdLjqDTJAF/GJqQ6HD10
	 sDJng10RA42++2rgXpWvWZP+jZGNBvGug+J4EbJg3edSJT0jSwiqD4VD8vLfev1yt1
	 GujNZpQE+fLRRlY7FhrfmdVX5GYXorhyZ9105+v9Of7CxvP12GDeKYHOO9nS8YUrwo
	 AIkUBsF7UDaWw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCHv2 bpf-next 13/23] libbpf: Add bpf_object_cleanup_btf function
Date: Wed,  4 Mar 2026 23:21:31 +0100
Message-ID: <20260304222141.497203-14-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304222141.497203-1-jolsa@kernel.org>
References: <20260304222141.497203-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding bpf_object_cleanup_btf function to cleanup btf objects.
It will be used in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1eb3869e3444..34987ce7cdc8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8885,13 +8885,10 @@ static void bpf_object_unpin(struct bpf_object *obj)
 			bpf_map__unpin(&obj->maps[i], NULL);
 }
 
-static void bpf_object_post_load_cleanup(struct bpf_object *obj)
+static void bpf_object_cleanup_btf(struct bpf_object *obj)
 {
 	int i;
 
-	/* clean up fd_array */
-	zfree(&obj->fd_array);
-
 	/* clean up module BTFs */
 	for (i = 0; i < obj->btf_module_cnt; i++) {
 		close(obj->btf_modules[i].fd);
@@ -8899,6 +8896,8 @@ static void bpf_object_post_load_cleanup(struct bpf_object *obj)
 		free(obj->btf_modules[i].name);
 	}
 	obj->btf_module_cnt = 0;
+	obj->btf_module_cap = 0;
+	obj->btf_modules_loaded = false;
 	zfree(&obj->btf_modules);
 
 	/* clean up vmlinux BTF */
@@ -8906,6 +8905,15 @@ static void bpf_object_post_load_cleanup(struct bpf_object *obj)
 	obj->btf_vmlinux = NULL;
 }
 
+static void bpf_object_post_load_cleanup(struct bpf_object *obj)
+{
+	/* clean up fd_array */
+	zfree(&obj->fd_array);
+
+	/* clean up BTF */
+	bpf_object_cleanup_btf(obj);
+}
+
 static int bpf_object_prepare(struct bpf_object *obj, const char *target_btf_path)
 {
 	int err;
-- 
2.53.0

