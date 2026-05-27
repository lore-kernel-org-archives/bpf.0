Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CBC3FD94F;
	Wed, 27 May 2026 11:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882182; cv=none; b=BDFZvqnoKHPIeMfv+aCfkpff/zF94EofPetMXbC6CXZAN2LQknZcHtWOAoERt5r7epN2QVflSDqJCXdKsfXfYyhytVIWppPzroGlgd9475u7uzeeUBXPyXwz6HNleFwrG1IiTvTvjWPR8j7Pu7VstBYSy+NVGQQhT30ow6UGVZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882182; c=relaxed/simple;
	bh=+QQGUHyoM8LHA4f9vy2PwGXXc70sR6q1y57vIUgXUkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlLUrcQN/ISSwcPGWze0uH//AyIkcVUVZq3A6xrUQIiPS007Egq3i4f/BG4LsTzUfzM2ZPfv4JlDn5oDrkaTNCPAFet/feLuxd9LEYC6gcpA9uI6avCj5apsj/d00TDNB5lk5dEk57/MVqYfgbpoDfT+dvYryR302BhwAHkrF2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KX9vXX6J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KX9vXX6J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0611F000E9;
	Wed, 27 May 2026 11:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779882180;
	bh=UiGubeBbw7tJDPKBEB6Vh35i/cOxFAJHqLWnM0bllE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KX9vXX6Jp2y0vZ16V3g0UJkCqMtUvlyvAaD6/uIewmn1qC+YNNLKolRreaKk1NKNj
	 weXcjCBQTvj6z1fC/KHm3zxowArN20VQopestsk8Honc1RXpryxwUnCbf+py4RRcTV
	 DdPmyVcii+befEyMnN5/nED4CAPK9n8vd2gdNaT755bqWbMHu9c5uOeHnvUlcksEXO
	 3gbGFzSNqMHmh23NOPHLM2tvwo86YM084Dg9OPcocJrOKfr4fND9QIdkz5Wc8grvKT
	 SRLhCRgaNDEuZjOnPRuFh+Wm0DlAtftehMmqbI4R0DLkZkZNn2t3NFs4B3WbWbbSZ4
	 0g+7XrRp/nJlQ==
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
Subject: [PATCHv6 bpf-next 17/29] libbpf: Add bpf_object_cleanup_btf function
Date: Wed, 27 May 2026 13:39:39 +0200
Message-ID: <20260527113951.46265-18-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527113951.46265-1-jolsa@kernel.org>
References: <20260527113951.46265-1-jolsa@kernel.org>
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

