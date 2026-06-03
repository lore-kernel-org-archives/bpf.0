Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696EA3AB482;
	Wed,  3 Jun 2026 11:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484943; cv=none; b=eonHudTFpJU9xtYlsJbhWo7qCavKCUirQHrXaryDIW3OtmH78Ohwbb0SaYvoTu9MgEd3KQ2bx0BkEu4B9ywTy0Os+vMWDavuqNzLi1Cl+HfMR1QPt4CjyMsxvunvlW8CHuX902IzbZm3HXdO9ygQnApK7pDyCVMl4tcgvZC4wlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484943; c=relaxed/simple;
	bh=+QQGUHyoM8LHA4f9vy2PwGXXc70sR6q1y57vIUgXUkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulwtqkmfLocX/wbssNpm0wmC4tuTirldj9z6ShHE9jaz60nr87cZarO2YXrJ9Z4QWZKvh4JewMTPHbt9GqQ1VE4O8cc/NUI0DgAabuEo42G03KKoYxx7Y9MkPYhO2iHZHaqYBgS6H3eRAw4Efp6XNmJYCsPeGb1ciRSzKKSV7yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3X3mUUx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3X3mUUx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EA31F00893;
	Wed,  3 Jun 2026 11:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780484942;
	bh=UiGubeBbw7tJDPKBEB6Vh35i/cOxFAJHqLWnM0bllE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L3X3mUUx8YiK+psU8GjlXflaCJj0SEHxY+f1lUj1zfFRG9cVFBFYCVmAH0DQ2uU8Y
	 16vpXhUkL6IcFF5bV1aLjJ5DfhqMt0Y4IuSpW6fIH6ZKwXtutR91gZC+TGJQ3V9mQg
	 ieTiBitWecl+VidJVBCD0IxzXx842zCVKrfcdI7tLY+WmU1UqatGC4NKS7y4eErgUs
	 wgaseemDNyv0F3v0y9a97T01Wzlhf37x6RBYldhF9bdiVASt5KjCrzNUIDToaawM5O
	 7G5ztzJUqCBK0LCCZU74LRPBtzqZ+7wHQ4b+F9NhMe1b6SHB6ote5pG1rrLK8JLkMF
	 I0rq3NRTDEJyA==
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
Subject: [PATCHv7 bpf-next 17/29] libbpf: Add bpf_object_cleanup_btf function
Date: Wed,  3 Jun 2026 13:05:41 +0200
Message-ID: <20260603110554.29590-18-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603110554.29590-1-jolsa@kernel.org>
References: <20260603110554.29590-1-jolsa@kernel.org>
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
index 2f5ac3e91d21..240cc37fe621 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8940,13 +8940,10 @@ static void bpf_object_unpin(struct bpf_object *obj)
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
@@ -8954,6 +8951,8 @@ static void bpf_object_post_load_cleanup(struct bpf_object *obj)
 		free(obj->btf_modules[i].name);
 	}
 	obj->btf_module_cnt = 0;
+	obj->btf_module_cap = 0;
+	obj->btf_modules_loaded = false;
 	zfree(&obj->btf_modules);
 
 	/* clean up vmlinux BTF */
@@ -8961,6 +8960,15 @@ static void bpf_object_post_load_cleanup(struct bpf_object *obj)
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

