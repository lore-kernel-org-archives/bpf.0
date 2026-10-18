Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10006349B15
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 09:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792315597; cv=none; b=DYbJj49icLFtaMf6LR5JOyjqiN9+eL4NQXJbX+wxA2pVtXP9+OTv+C/3AjFB1U1Fy0KFAalqrHPJmJ15sRl/Yx6QjZwWyQUlfLZV9IWyj+7s3FGjkxHKRbycQ5ltnCuaiTWdj39QGMk/8VxHxKrJi0sDsgO2qV8LB4ytrMyA24M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792315597; c=relaxed/simple;
	bh=sqARz4DDY1N+PlAJEiB0r03j6B9CK5WMxtFBbcAoFe4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UpoUwKrk/sBEEiXcOIZWj6s6aBSld/XtbtcZh7NVIQjPYS4om6/bKhBgwcb71VjsaxOJMrIKb/GT87ANWy/SzRhsmR0o+ZrEuy+b6d92hgSw7LUVPua63Gw1nlCBhrYpHcOviT5DiVkNbyh9g+ZM3OdfCarqf13I+vdSt/j6SOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYqfs6pL; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYqfs6pL"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93cc1ab5f6cso156508085a.0
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 02:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792315595; x=1792920395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XkDhS0lrLqY3csnPxpMgprHIENPXU4BhnWQmwT8yNMw=;
        b=AYqfs6pL2YQIbd2gCLPZD7kI2o7Z4DdOcxcBl+8zihBnMBZPSZHJend/UvEY5x11wq
         eg7/+hORMoIT92/fQ99/h5CNn22YtV0pbJskz6/58rSHFvy1rHha/RQYTG6vTEqWQJl3
         K5mbZatbuZZRFwiY5oL8Gd7NVXbFrj8Qmms4oU6vCJXaiBn80VVX5sclo24vB7Macq62
         ISU1MCJxCL3kbqIqPMk+a+YANhcqV8P5OmiDKWtKYaTt0hTSFaDMvXr8MizXGZEBOzTQ
         7uM5eaCItSP6sO7CkTX38LqVRh9e/A3mD/grMbDc05F5WaHizmxSF89vSMQlOGNlMGZQ
         HEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792315595; x=1792920395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XkDhS0lrLqY3csnPxpMgprHIENPXU4BhnWQmwT8yNMw=;
        b=qQcq51ayJnOdOgo93+j+DsdPQDTIftcCH2EDNU4ORAKgEBH3AxuAKpLAus6AYbWtvj
         UmNXXKcSyguI1azvqX1ZiihqMwdWFkmv+M+rnsSZpHiWeGGYBb0P5oKSYrRv/ZhPjCTv
         qOjOVqkpHTiexvrQSjMsn/i9/l2tDqC9oBbF+TSbmX1QyTLA2qCzJ5EVuCY6tlYceSg4
         cawA5hFVZPexpjTbG3+ubPfHtvWv/RhYZNspZR2ISPqT9jeV3LwvzMD1g5Dk0GLFp3F1
         N6jNYe5hQgenYJGNC1/V9Cw7rKpLZf4sgWoaGLtEHliYNagnOx13FhPPRCfC9x8Xpms+
         SeOw==
X-Gm-Message-State: AFq9FYK6QJbe2oAas0w51GnqL7sqICttKKqr7Lvz3IQXzynBBekbyVh7
	59I+Stex2eyI1cWQsBGU4R21+aQrjsg2WRc4Go9G96KCBOq7jSAoGIf23ambHziXb87rBg==
X-Gm-Gg: AYBFou3PoxSt3nBCHpjYpFgFIHT4pOnh64CaTd1Jh/CS6HwtDyYa/2SvW2nQtAVofWK
	w1D35qteRzqHG2CIXzGgTflcVmCL0+GIHVRfktckT9Vz1SFpkQNbycbGp4UtkabuIn7DX8XUv+T
	8Mfwe/efnmpD5MOwTHQ+OnDims3J2R7Wav2lRRf5nsN7pJLaawVZ3jamJOqnBqE0WQZVqjknbI3
	lMMAsJqhgyRc+s9ackwSU6cV+o/emu5RCIIVyyDEodZCbnP4UIKN146jip5YKNxMjaG9+vvV1FL
	K5A63sJvgUYBboxnfwFYcR4iv6iXL6qx334q18Mcr/6MJcuvlHsBK8Z1DB+NuHzlcsX0At7K3Sd
	dFeRNb52E16ye2UC/auJLCSnhE2inUNwpezucOyOa8XFo3I/nwWY9gQMlXHxg3c4j6ReE8zy9yJ
	OntPGIzUhAq8AACeCMjox8n7Mm6DK95zb81lXv6HnOPnXEiTESMwRb71cWOH5U7j8D81iZ
X-Received: by 2002:a05:620a:c47:b0:93e:bdeb:f067 with SMTP id af79cd13be357-93f29d5a24bmr780953485a.48.1792315594891;
        Sun, 18 Oct 2026 02:26:34 -0700 (PDT)
Received: from localhost ([103.41.177.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a197c21sm655123385a.31.2026.10.18.02.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 02:26:34 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zateev <hackerowskiy@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] libbpf: Prefer mounted tracefs over debugfs
Date: Sun, 18 Oct 2026 11:26:29 +0200
Message-ID: <20261018092629.585046-1-hackerowskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tracefs path helpers look up /sys/kernel/debug/tracing first, even
when tracefs is already mounted at /sys/kernel/tracing. This can trigger
an unnecessary legacy tracefs mount and selects a path beneath debugfs,
which is commonly restricted.

Prefer the direct tracefs mount when statfs() reports TRACEFS_MAGIC.
Checking the filesystem type avoids selecting an existing but unmounted
sysfs mountpoint. Preserve the existing debugfs fallback and the default
tracefs path when neither location is available.

Fixes: a1ac9fd6c650 ("libbpf: fallback to tracefs mount point if debugfs is not mounted")
Closes: https://github.com/libbpf/libbpf/issues/966
Assisted-by: LLM
Signed-off-by: Eduard Zateev <hackerowskiy@gmail.com>
---

Validation on Fedora 44 (aarch64):
- Built static and shared libbpf with the default warning settings.
- Exercised all five path helpers using wrapped syscalls for both mounts,
  tracefs only, debugfs only, an unmounted tracefs directory, and neither
  path available. The original code fails the both-mounts scenario.
- Confirmed the direct tracefs paths on the host's mounted tracefs.
Privileged BPF attach/mount tests were not run.

 tools/lib/bpf/libbpf.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index cb09ded90..9db0a8bde 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -59,6 +59,10 @@
 #define BPF_FS_MAGIC		0xcafe4a11
 #endif
 
+#ifndef TRACEFS_MAGIC
+#define TRACEFS_MAGIC		0x74726163
+#endif
+
 #define MAX_EVENT_NAME_LEN	64
 
 #define BPF_FS_DEFAULT_PATH "/sys/fs/bpf"
@@ -12713,12 +12717,17 @@ static int append_to_file(const char *file, const char *fmt, ...)
 
 static bool use_debugfs(void)
 {
-	static int has_debugfs = -1;
+	static int needs_debugfs = -1;
+	struct statfs st_fs;
 
-	if (has_debugfs < 0)
-		has_debugfs = faccessat(AT_FDCWD, DEBUGFS, F_OK, AT_EACCESS) == 0;
+	if (needs_debugfs < 0) {
+		if (statfs(TRACEFS, &st_fs) == 0 && st_fs.f_type == TRACEFS_MAGIC)
+			needs_debugfs = 0;
+		else
+			needs_debugfs = faccessat(AT_FDCWD, DEBUGFS, F_OK, AT_EACCESS) == 0;
+	}
 
-	return has_debugfs == 1;
+	return needs_debugfs == 1;
 }
 
 static const char *tracefs_path(void)

base-commit: a6303535c2ad9d49598d52556183911f02287791
-- 
2.55.0

