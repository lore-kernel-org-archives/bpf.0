Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8242C36C9EE;
	Tue, 24 Mar 2026 08:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774340481; cv=none; b=jzdz/Zjt+Td2mn9dyQY/9V29oqbWoGRWMTutNLuUL/qGS93IxcU2qgGNhxTM7xmPr+K7/NlliNy8sCr5BinSUtS0ZhZa6oifQKbuNoLf+BABOaGhupZiMAqun/wUsUlf1cwmU02gDWOIBDhpViqkudVygyPudLCmlb175KYY1Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774340481; c=relaxed/simple;
	bh=WL0GPEH8KqOwkDPCafANY5Ae0q1y/x6djVxx5qSKxJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OyU6N9/q1prSZl5em0sLbvrR0Czui1c2jQMmRgmabQi6GTz/AsrXZEbwjQ4hEA6cTxniMvkP5hnrnXu6/xETdngB0ZFLIpPy8W2K5AcX2p9ofugH+y7fKhkRgOVu153aT8xc3cAxqmh5dv2HLyiGDXZ9WY6XDojWqjjHzXfJQZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iil2TM9W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iil2TM9W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2A8C19424;
	Tue, 24 Mar 2026 08:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774340481;
	bh=WL0GPEH8KqOwkDPCafANY5Ae0q1y/x6djVxx5qSKxJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iil2TM9WKpv6FXhe7gDI9YmlM3PJGDALKJSS4Ged3dSuNcw+kUn26ioL/P8eKI6A6
	 UfinkwAPkZ9TmptHwmOU5CFzH+PJm8Ya2gExNDHfoXtKBXWlbjm2Y2Sa1uyOjTGIZf
	 7oVOTR/mGdAZOtFpVNZSoqtcjzWqGBEHWXZer/VLxkgrFrrm0D2BG01pVxFosgnoiz
	 GU4Sa09Lyc5iit4OGC+egUPnkbq2UyKGGOX1NTRUAPy+W2f6+JW/Ms2/SPWJuN3jUG
	 j+JYnuJJKaAns4N4M+Bi/ZSeLnKBl2w9g/HXq9G2b/SG28MfrVNpvH1zE0A5PQJqoH
	 Mh0iK0KQQ8Ejw==
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
Subject: [PATCHv4 bpf-next 14/25] libbpf: Add bpf_object_cleanup_btf function
Date: Tue, 24 Mar 2026 09:18:35 +0100
Message-ID: <20260324081846.2334094-15-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324081846.2334094-1-jolsa@kernel.org>
References: <20260324081846.2334094-1-jolsa@kernel.org>
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
index bbdfc9160199..c6cd6ccb870b 100644
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

