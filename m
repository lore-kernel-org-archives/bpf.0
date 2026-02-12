Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF59426AAAB
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 01:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770858896; cv=none; b=OiUsBpLH71meKI9S4CC9+QmWZvgPl9t3TBCkhsN9lDgLI0hPdzciemN9vUoOyF/KYOsTbjQReP9H4sknhC+6xjLZKXH8QZd1aokr/rXbdm2aROoyZZt5nTzs7/LchI0Qp8ddyzIuMz6hv+w79NfClMe28hfi5PsWG1r8gnGzSR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770858896; c=relaxed/simple;
	bh=JhWpkW+RBS4CdBILjprhBmN5mYv1DZA64wlcJPzPyIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGMxP+LqTLdSPwcIzGOqA4an1hKEE5bMSnEDGd5N9nCAmsi5g96eLmG+Dir6P3wCvZnmBmwaYz1vJoTs4acCNeEJOB7y8oUxpzwjCKTf1KsuCmWOHHHiWvJ7mkrqpnrFPUzldzr6t1mZFYvyBFGDf0MFpGuIOAcS//I/GKRJ1yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hm7X0r+B; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hm7X0r+B"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770858893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYateGUYWZT4rVCY9MRSYAbu22ESy2nd9yzyOUitGHE=;
	b=hm7X0r+BvmsCtZ775mK4d194tSwnprvL2mzSJrGozF2/uKZJWRz8yCAzYRsN6JjwzPIqe6
	e7EV6aESyd5+uw3IPsh4tSUNHW3u2bWNyngYvMMfNQ/2AoXOLR6IsGLsUM8foUyFIaO4Ys
	ZzWHD6HIVEBnrWer1MAJtqAG2rGkwb8=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 14/14] selftests/bpf: Check BPFTOOL env var in detect_bpftool_path()
Date: Wed, 11 Feb 2026 17:13:56 -0800
Message-ID: <20260212011356.3266753-15-ihor.solodrai@linux.dev>
In-Reply-To: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
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

Also replace strncpy() with snprintf() for proper null-termination.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/bpftool_helpers.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpftool_helpers.c b/tools/testing/selftests/bpf/bpftool_helpers.c
index a5824945a4a5..5435ecd720d1 100644
--- a/tools/testing/selftests/bpf/bpftool_helpers.c
+++ b/tools/testing/selftests/bpf/bpftool_helpers.c
@@ -12,13 +12,21 @@
 static int detect_bpftool_path(char *buffer)
 {
 	char tmp[BPFTOOL_PATH_MAX_LEN];
+	const char *env_path;
+
+	/* First, check if BPFTOOL environment variable is set */
+	env_path = getenv("BPFTOOL");
+	if (env_path && access(env_path, X_OK) == 0) {
+		snprintf(buffer, BPFTOOL_PATH_MAX_LEN, "%s", env_path);
+		return 0;
+	}
 
 	/* Check default bpftool location (will work if we are running the
 	 * default flavor of test_progs)
 	 */
 	snprintf(tmp, BPFTOOL_PATH_MAX_LEN, "./%s", BPFTOOL_DEFAULT_PATH);
 	if (access(tmp, X_OK) == 0) {
-		strncpy(buffer, tmp, BPFTOOL_PATH_MAX_LEN);
+		snprintf(buffer, BPFTOOL_PATH_MAX_LEN, "%s", tmp);
 		return 0;
 	}
 
@@ -27,7 +35,7 @@ static int detect_bpftool_path(char *buffer)
 	 */
 	snprintf(tmp, BPFTOOL_PATH_MAX_LEN, "../%s", BPFTOOL_DEFAULT_PATH);
 	if (access(tmp, X_OK) == 0) {
-		strncpy(buffer, tmp, BPFTOOL_PATH_MAX_LEN);
+		snprintf(buffer, BPFTOOL_PATH_MAX_LEN, "%s", tmp);
 		return 0;
 	}
 
-- 
2.53.0

