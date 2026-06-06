Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76536382361;
	Sat,  6 Jun 2026 12:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749773; cv=none; b=DiauLOxqDgkpQ7HVFpOsCm8SqXij1HhdGOZFAgrXvxaW2HW/w9Ry0g3e/VVuI5kSTmSSyFZljXzVp0pUTcy1ZIVrvJxcHxiofjQnahX2B/NQSpXE43HGYLRog252lm9ADMkwCuaOC6ZRHbkowfOyjDSfY7W+UFGLml49mSSgigw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749773; c=relaxed/simple;
	bh=s/1yhbDjnxdZLeTW8XOWGmeqKDWtoEkcV8FviDCNWiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zk1rulPXhJmZpASnzgWQSM8xZsE8o1jBm+liPxlkwbZGA6PYBB0Njt0nck+DzBL42wyQOG23dkRX58dBQUqEVYsn2h0HeReOBIISiPIIx9SWv9qrpoayG3BThA/T7cTeSyzAC23IaTuQQupWX5dbSdXHuJpbYsv8XUsvHh2PeUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1vIOKaN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1vIOKaN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AAB1F00893;
	Sat,  6 Jun 2026 12:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780749772;
	bh=EGkQN0ymBm8LC2ltH/r5zMF9uK4u24+7wGF3kPVealE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K1vIOKaNUg0NCRi8DOZzuItob6iK1Y//evDADFT8F3EDONsx9ahd7p/R+3+cFXyKs
	 PiRXDYb9s49vPAm/Av4014kT+ou5WPu0WsuRRDEBM5wt3WUIX42YDRRKQOoSw6ZaMS
	 XthXQKjdJS+FJQzxle1MVeCBsU6rnbJ0UabdnTleV0iY+4GOtuV6U20ckWd3sEkETY
	 l8wPCBAa7UHW8H8UYgUzWK3OYMpm9JkHxnYhikh/Ay6Kp/5MT/I13ncE5+d0FZKxl7
	 TnvnE33+5hS0Q+JgSW0jS6RiXFqTc8IpLHWdeJsHwd5Ius81z5UeKNCJY/8/JtxLoN
	 iYm4QZfQlFEOQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCHv8 bpf-next 17/29] libbpf: Add bpf_object_cleanup_btf function
Date: Sat,  6 Jun 2026 14:39:42 +0200
Message-ID: <20260606123955.345967-18-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606123955.345967-1-jolsa@kernel.org>
References: <20260606123955.345967-1-jolsa@kernel.org>
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
index 62f088359c5e..5bdaa5eb1f50 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8941,13 +8941,10 @@ static void bpf_object_unpin(struct bpf_object *obj)
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
@@ -8955,6 +8952,8 @@ static void bpf_object_post_load_cleanup(struct bpf_object *obj)
 		free(obj->btf_modules[i].name);
 	}
 	obj->btf_module_cnt = 0;
+	obj->btf_module_cap = 0;
+	obj->btf_modules_loaded = false;
 	zfree(&obj->btf_modules);
 
 	/* clean up vmlinux BTF */
@@ -8962,6 +8961,15 @@ static void bpf_object_post_load_cleanup(struct bpf_object *obj)
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
2.54.0

