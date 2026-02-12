Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51821EE7C6
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 01:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770858887; cv=none; b=QC+V/UjqIVivkpNM29APg2a2aMjHLXpQFR6ro3HehDVjIRwPiib7umfMg7U98inUkViS+wzWSF8I57Nw1hXmX4xNZUiKOvBfTBOtMe87GqT/WrIgzOuxwFa+8dLIMKe0h97UBV5zvjhhl9Qp/0rB4bNevtDgoxnibTbcntoHYQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770858887; c=relaxed/simple;
	bh=Lp/MVZHJvNcQOEssRh3JY87ZfF7lWBxbNzkGY7/Zp+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Js1wzq5K5Pnx+UdLuSOuU8eDvE3pLMPFxtwLjHjV5NypXd7rH0y+HGYujZJUPEfBViRMt84AVicB+d8QmUsu4U4b0a4YHh5sG5yfh1i2VJOE3Z1mU0OVwg3GdxiOaOCPykOS5ZReWwXRmcyGYh9F19cBvJF1WsHLJKJcKifUkwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a2DBIDi8; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a2DBIDi8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770858884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqSdIynY+Fpb6wP9Mu8x9/648E6VVvAD4Mr1vf4V3Ak=;
	b=a2DBIDi8F1/UOBUoHnsaCx4Mxoo5NK7/SNkLKiWbIatSaBizE1MsRse7NylZmkn8lmtGfl
	zYmaWABeGWsGu8Al8KpfIIh4weHFS3NrwsDlmwj8y4gsN3lOcbKICvF+1Dq5imuWO9kg06
	0hfhmKFz7WXddLJuwNsNuGZzGTdXrFI=
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
Subject: [PATCH bpf-next v1 11/14] selftests/bpf: Free bpf_object in test_sysctl
Date: Wed, 11 Feb 2026 17:13:53 -0800
Message-ID: <20260212011356.3266753-12-ihor.solodrai@linux.dev>
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

ASAN reported a resource leak due to the bpf_object not being tracked
in test_sysctl. Add an out parameter to load_sysctl_prog() to properly
clean up bpf_object if a program was loaded from a file.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/prog_tests/test_sysctl.c    | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_sysctl.c b/tools/testing/selftests/bpf/prog_tests/test_sysctl.c
index 273dd41ca09e..31f4bba87c3e 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_sysctl.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_sysctl.c
@@ -1459,7 +1459,8 @@ static int load_sysctl_prog_insns(struct sysctl_test *test,
 	return ret;
 }
 
-static int load_sysctl_prog_file(struct sysctl_test *test)
+static int load_sysctl_prog_file(struct sysctl_test *test,
+				 struct bpf_object **objp)
 {
 	struct bpf_object *obj;
 	int prog_fd;
@@ -1471,14 +1472,17 @@ static int load_sysctl_prog_file(struct sysctl_test *test)
 		return -1;
 	}
 
+	*objp = obj;
 	return prog_fd;
 }
 
-static int load_sysctl_prog(struct sysctl_test *test, const char *sysctl_path)
+static int load_sysctl_prog(struct sysctl_test *test, const char *sysctl_path,
+			    struct bpf_object **objp)
 {
-		return test->prog_file
-			? load_sysctl_prog_file(test)
-			: load_sysctl_prog_insns(test, sysctl_path);
+	if (test->prog_file)
+		return load_sysctl_prog_file(test, objp);
+	*objp = NULL;
+	return load_sysctl_prog_insns(test, sysctl_path);
 }
 
 static int access_sysctl(const char *sysctl_path,
@@ -1529,6 +1533,7 @@ static int access_sysctl(const char *sysctl_path,
 static int run_test_case(int cgfd, struct sysctl_test *test)
 {
 	enum bpf_attach_type atype = test->attach_type;
+	struct bpf_object *obj = NULL;
 	char sysctl_path[128];
 	int progfd = -1;
 	int err = 0;
@@ -1538,7 +1543,7 @@ static int run_test_case(int cgfd, struct sysctl_test *test)
 	snprintf(sysctl_path, sizeof(sysctl_path), "/proc/sys/%s",
 		 test->sysctl);
 
-	progfd = load_sysctl_prog(test, sysctl_path);
+	progfd = load_sysctl_prog(test, sysctl_path, &obj);
 	if (progfd < 0) {
 		if (test->result == LOAD_REJECT)
 			goto out;
@@ -1573,7 +1578,10 @@ static int run_test_case(int cgfd, struct sysctl_test *test)
 	/* Detaching w/o checking return code: best effort attempt. */
 	if (progfd != -1)
 		bpf_prog_detach(cgfd, atype);
-	close(progfd);
+	if (obj)
+		bpf_object__close(obj);
+	else if (progfd != -1)
+		close(progfd);
 	printf("[%s]\n", err ? "FAIL" : "PASS");
 	return err;
 }
-- 
2.53.0

