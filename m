Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F8D376483
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873900; cv=none; b=QZDLOl8GplS4FQS4Hyk6Nj5vp2auIlQFxFKFbLzB66p88W9kpsSUpvVtqineopnk8azqJ462QRoWm5LSGYXYt7fkYOYmb8CmWJ3TNmd8MKIeehdWMQAqRntvP6/u0XlG6hLsfxmwYI6qLV/pcYKA4DGwrOrEZIRV5H4MxgU6lE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873900; c=relaxed/simple;
	bh=mkdXOMtAiZEE/kIjEnKL+A+FZpU22LHBLHxeu9Pl4a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djU/sjYfCrSf14o3Kvp7xMdvdhS8fyQVU17mEy/xhBvQhTV/lXN7ZMup3/XMM41WtWNBSFZq3/GAa4giWAFI/Imn/TkghNb0NGLnNL3P3axQC+D+q5PjC0rMwk/C5SDSaXvne1Mi/JEC2jdTQcSaP/LlFqYJOhrYLtPo1H4LXm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iKDJGFNs; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iKDJGFNs"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771873897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aI++4j9Xuw5+ouqhgv9iItaYJYo/emEExNe9kGFLeT0=;
	b=iKDJGFNskx8mHxqengOw62UYLArotI/SBVLFolIBSXCENqKmX4sF9Cc6h++BV65/qtuTn7
	3fr+M/h89t0gHBwryERFTkmsza67VLliJDyYTJNqmhNBi+LoHRUBVve6FtS++0Fuq97Z/W
	R6PN8GekuIwtvq7JzLdCq5PqoO7Wd6Q=
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
Subject: [PATCH bpf v4 19/20] selftests/bpf: Check BPFTOOL env var in detect_bpftool_path()
Date: Mon, 23 Feb 2026 11:11:17 -0800
Message-ID: <20260223191118.655185-2-ihor.solodrai@linux.dev>
In-Reply-To: <20260223191118.655185-1-ihor.solodrai@linux.dev>
References: <20260223190736.649171-1-ihor.solodrai@linux.dev>
 <20260223191118.655185-1-ihor.solodrai@linux.dev>
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
index 595a636fa13b..929fc257f431 100644
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

