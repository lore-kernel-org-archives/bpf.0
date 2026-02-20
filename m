Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1956F3126D4
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 22:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771626432; cv=none; b=G6ef3L6MGq5vgKPUw2Y+XiCf/YoncDMahTqE1CY8dXitqUxE5tnt5uVIEnd6Vd64DXDdL8YrlJ3Px4Zwx9Fp/9g0xR48/KqLB6lOuQVOAJN85smLrK7XZCQqdaL228bNyVTDzqb2+4EsHbWnnk0k6qj+dVd7HVIMTFXAVNXZSUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771626432; c=relaxed/simple;
	bh=LoE3/QDGa0O5bMCeA89eMlDkdtumaKYvDQbCH180jas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/yBtW/I0YIJo4fyWmzO527JbkfG+fMef6CRRwHHdeEsdBgQgZ81TWBH311C2TUEGhAXMmPQGJB5MtaOd3zwCEVQknRop4uGnCOjBeDD/1oYqx0xrQ+ly4/csUAJG8sllyJDxoGUeuAVBwI8gFfRr85SFMtliLeIabHnPPvLWMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IKnlsEM8; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IKnlsEM8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771626429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zlRPfCL6Z3VvwP0IxBvMo9cRo8Rws71WMdB3wopHR1U=;
	b=IKnlsEM8iENXS1a1a7ZMKG5/uc46X92ivJh2uG7a3lc007GR4TmaSMEX6XICvbW6PDSQXD
	wUYHKFL5l/Vm7ygwo3XYhQmyNz8i9jpiNDoURcxqzalDnJIjp62InPlFV55cb16UIDKQaY
	91R+/kWpxYpeQ+VdTM1IyS3wLgnv/BA=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v3 14/15] selftests/bpf: Check BPFTOOL env var in detect_bpftool_path()
Date: Fri, 20 Feb 2026 14:26:03 -0800
Message-ID: <20260220222604.1155148-15-ihor.solodrai@linux.dev>
In-Reply-To: <20260220222604.1155148-1-ihor.solodrai@linux.dev>
References: <20260220222604.1155148-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The bpftool_maps_access and bpftool_metadata tests may fail on BPF CI
with "command not found", depending on a workflow.
This happens because detect_bpftool_path() only checks two hardcoded
relative paths:
  - ./tools/sbin/bpftool
  - ../tools/sbin/bpftool

Add support for a BPFTOOL environment variable that allows specifying
the exact path to the bpftool binary.

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/bpftool_helpers.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpftool_helpers.c b/tools/testing/selftests/bpf/bpftool_helpers.c
index c99776b03f52..774a22d624e7 100644
--- a/tools/testing/selftests/bpf/bpftool_helpers.c
+++ b/tools/testing/selftests/bpf/bpftool_helpers.c
@@ -14,6 +14,17 @@
 static int detect_bpftool_path(char *buffer, size_t size)
 {
 	char tmp[BPFTOOL_PATH_MAX_LEN];
+	const char *env_path;
+
+	/* First, check if BPFTOOL environment variable is set */
+	env_path = getenv("BPFTOOL");
+	if (env_path && access(env_path, X_OK) == 0) {
+		strscpy(buffer, env_path, size);
+		return 0;
+	} else if (env_path) {
+		fprintf(stderr, "bpftool '%s' doesn't exist or is not executable\n", env_path);
+		return 1;
+	}
 
 	/* Check default bpftool location (will work if we are running the
 	 * default flavor of test_progs)
@@ -33,7 +44,7 @@ static int detect_bpftool_path(char *buffer, size_t size)
 		return 0;
 	}
 
-	/* Failed to find bpftool binary */
+	fprintf(stderr, "Failed to detect bpftool path, use BPFTOOL env var to override\n");
 	return 1;
 }
 
-- 
2.53.0

