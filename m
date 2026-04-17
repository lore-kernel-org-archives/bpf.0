Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECFE3537F5;
	Fri, 17 Apr 2026 19:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776454097; cv=none; b=hvo6DnyZD8ajPzpYvMBD5Yc1vU7IKzyDZSDTJso8zj2NQGLUB7Ni7Fd0ENHer/8U59I4TKkgFsPGcAK2tET4nxjJnXJYDKJUxUsVZGQOEpd6e/HKwa6XXpdPYPPONI/YHFNKw+sCSFQ/vfjVXppjAl2NtHS1r4SIfjFUZihuJ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776454097; c=relaxed/simple;
	bh=JY+vq1YdnbSn+Bq6+ua20Bgr3dgtcBN+ehsolIQAnNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHGotYV8Opwgxo1Rx+NYaAa92p2QJ1XWrViBT/8PPVTz/wGyWdHXnQPOuOKHm9vC19eUmyKsGiyhmrwzSGeK8qGnch2aDDgKjAfUpvDsI+wugRtTADBIZ8X/Qho5u+6wTbc9XGTyeKnRa4NoxVy0mteRF7sUDddEcHzI1kKMNrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObZzTVQa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObZzTVQa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADABFC2BCB4;
	Fri, 17 Apr 2026 19:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776454097;
	bh=JY+vq1YdnbSn+Bq6+ua20Bgr3dgtcBN+ehsolIQAnNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ObZzTVQaL9DCllkV2LgAAsUnGpCmPYxeJcYQoHvnV3VGammvcIZSBK9R3qGphm6RY
	 hRdHhjF0kwSdgEYSkkmNL/GaBpcEwEhdBVUMqlgh+jhBeNs2IPv6bFY+xabUDUsVkX
	 g7WyT1EsKDZ3pOtaDggf1ZiTuSiFadrslF+wepSxlFnhk2bS0UTarkY6gNW6u1R/+S
	 W4iY5N5XamhtibFHEgv+N5Cd6lXicKTOLfFxkqcpqZ22J37UFWwU0Xz8aMUdrJfRet
	 PVRhI/oMycnrJlszGoeNtg8TOp99tpTbmgO6EAiXju5/lnSZIRwJDC6l3vuRLkyEDG
	 RKmN1OwFxX9WA==
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
Subject: [PATCHv5 bpf-next 17/28] libbpf: Add bpf_object_cleanup_btf function
Date: Fri, 17 Apr 2026 21:24:51 +0200
Message-ID: <20260417192502.194548-18-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417192502.194548-1-jolsa@kernel.org>
References: <20260417192502.194548-1-jolsa@kernel.org>
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
index f1f627c86f35..59de338126fb 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8942,13 +8942,10 @@ static void bpf_object_unpin(struct bpf_object *obj)
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
@@ -8956,6 +8953,8 @@ static void bpf_object_post_load_cleanup(struct bpf_object *obj)
 		free(obj->btf_modules[i].name);
 	}
 	obj->btf_module_cnt = 0;
+	obj->btf_module_cap = 0;
+	obj->btf_modules_loaded = false;
 	zfree(&obj->btf_modules);
 
 	/* clean up vmlinux BTF */
@@ -8963,6 +8962,15 @@ static void bpf_object_post_load_cleanup(struct bpf_object *obj)
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

