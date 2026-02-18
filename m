Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56662D7D2E
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 00:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771374705; cv=none; b=LKXhrdO1iuD/e2Qw/mUIj/80JWyrGio44i+S3LGv13lAUSPXfiE3qqiMpgwyVHgf+TXNuupjT66e23v88wAzw7M+wEMRC6U29Tgx3ukSJkBMTMLp+I9are/xFmSERduavo2rlvByU5esF8R8qQjnHKzdkX23DyTyyy1ZCBiOLg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771374705; c=relaxed/simple;
	bh=XKGbSecU2dLHUHRJGHYW7f3B0TIZ1V1qfLoZdjsr3M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHy4Dv5L+1t1ReFHDu7amXA9pADIITrGdhYN/IQe3gUEwpDqdKIa7X/AmjJ0vvF5JZHTtHmuSQ9A0+EUuV60Ix5pM0CS54t8ozhVpzS+RWWIbrS1Gus/dXASbtSmq99bsP9g+PV1bLbfTy5G+RPbiDky9WF4/seMDZs9gUXQrYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZTWz0uoR; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZTWz0uoR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771374701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PkyNMdzaljwPDsSqK2+KDJHRyF0c97m/yxN597Cj3Rw=;
	b=ZTWz0uoR9UzyZ9mQO0/+AawhgR43jQeE9NrfZDHcik4GVP7dQ0U4iujPCQyKgWSg53SCsl
	204PqA0J7tJaOxL2s0QWjfha8fmppx01FbPB6IGOEh/KudI2c+jbX7dJYsEc5QkJwjaK1C
	150qOm0KHt4iDy+9WWWg9IS8Nvdecjk=
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
Subject: [PATCH bpf v2 11/15] selftests/bpf: Free bpf_object in test_sysctl
Date: Tue, 17 Feb 2026 16:30:37 -0800
Message-ID: <20260218003041.1156774-12-ihor.solodrai@linux.dev>
In-Reply-To: <20260218003041.1156774-1-ihor.solodrai@linux.dev>
References: <20260218003041.1156774-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

ASAN reported a resource leak due to the bpf_object not being tracked
in test_sysctl. Add obj field to struct sysctl_test to properly clean
up bpf_object if a program was loaded from a file.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../testing/selftests/bpf/prog_tests/test_sysctl.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_sysctl.c b/tools/testing/selftests/bpf/prog_tests/test_sysctl.c
index 273dd41ca09e..4349b846f1b3 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_sysctl.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_sysctl.c
@@ -27,6 +27,7 @@ struct sysctl_test {
 		OP_EPERM,
 		SUCCESS,
 	} result;
+	struct bpf_object *obj;
 };
 
 static struct sysctl_test tests[] = {
@@ -1471,14 +1472,16 @@ static int load_sysctl_prog_file(struct sysctl_test *test)
 		return -1;
 	}
 
+	test->obj = obj;
 	return prog_fd;
 }
 
 static int load_sysctl_prog(struct sysctl_test *test, const char *sysctl_path)
 {
-		return test->prog_file
-			? load_sysctl_prog_file(test)
-			: load_sysctl_prog_insns(test, sysctl_path);
+	if (test->prog_file)
+		return load_sysctl_prog_file(test);
+	test->obj = NULL;
+	return load_sysctl_prog_insns(test, sysctl_path);
 }
 
 static int access_sysctl(const char *sysctl_path,
@@ -1573,7 +1576,10 @@ static int run_test_case(int cgfd, struct sysctl_test *test)
 	/* Detaching w/o checking return code: best effort attempt. */
 	if (progfd != -1)
 		bpf_prog_detach(cgfd, atype);
-	close(progfd);
+	if (test->obj)
+		bpf_object__close(test->obj);
+	else if (progfd != -1)
+		close(progfd);
 	printf("[%s]\n", err ? "FAIL" : "PASS");
 	return err;
 }
-- 
2.53.0

