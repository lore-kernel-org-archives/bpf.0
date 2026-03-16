Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB153537F5;
	Mon, 16 Mar 2026 07:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773647645; cv=none; b=M2s7G6Z9ibQHeQLtSRE0Si3iMTHS0cfDPJFGEGbSJmrqwJxqhhc26WsDM1VDLJ3J8mBludxiehyxAwC5Uh+Ttj6kQCUUg/wRC5nh8+KVMOIFeMIrjDF11HMthn37UYid0USGRqXFRthlGYh/pB53pc1NIcGoj8VvNo8eWEP2rTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773647645; c=relaxed/simple;
	bh=dICowSopfDBsRbmNTHcXo44uKSggWvJxVkcUlfMBe1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5ado6W85cQ+Y7X8QF9DzghqAmreHfyLghzptFy4QOfqCfSM10dxQtd8Ni1tSIx2vQ7mSXAuJX3Ze87dbtntExy5DHRmbwzcBi67bEn5EsGYx/R604iiSupo4SrlweSoWrEvTI3UPxWDYWX+UXUO0GD0sitJK8Z1Q8h4w0oBPSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNU+M6YQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNU+M6YQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2DFC19421;
	Mon, 16 Mar 2026 07:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773647645;
	bh=dICowSopfDBsRbmNTHcXo44uKSggWvJxVkcUlfMBe1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YNU+M6YQhnLYtogH64p1OdAUluT5raVMKBYhMAwIe1g4RAH82zne96ZdCA2zrcpQa
	 WzT9iS3ViKXYXLkmYh1YzdnXEYWYVCNGklWKZzIH738pVJAwy65CBdNv2CJc3xDJaY
	 tB5ga+DvvEAAQ9g+HHUXZNt2xNEXSQete8n+QuKEAzRuXx2gHLqhojcP7HowBoVfMR
	 8ERH6mcbb/I3sZ+RYtaHoHsd0C74cbYq3NzP1kyaqVNNm0LEU6jNVfMaSRZa062Yzd
	 tiqgAapWBvGivU+vRHrNvqIxdAH+TXhL+JMzKHb/MrI7OF8jK0YpykuxeZ4tbHbXPc
	 7oG+q/0DfE+xQ==
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
Subject: [PATCHv3 bpf-next 13/24] libbpf: Add bpf_object_cleanup_btf function
Date: Mon, 16 Mar 2026 08:51:27 +0100
Message-ID: <20260316075138.465430-14-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316075138.465430-1-jolsa@kernel.org>
References: <20260316075138.465430-1-jolsa@kernel.org>
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
index 06fb382557b4..64c1ab005e6d 100644
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

