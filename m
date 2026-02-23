Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E70D36A03B
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 19:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873721; cv=none; b=Arus4+1XF1TkDz4I2a1L8wfttwygERYHxoXBSnlBYO0hFb1fp/j42SAxM/L+6gofzmewYjBJq7GBLCyCX3lXY94LgVjjAgi6L98UYzZtOz0UKdJc6fEc146OQX/W0kvIYQG1iPR6PduAhhfUlC62CXVHIQH7tx9SpWq+8rWoJhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873721; c=relaxed/simple;
	bh=h961jMMm4JJyJcQlY8YrVLwS5sTBx6k5KbbDlRkBr00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6V1f9qN03mn3lohf/V7QtH+sg7vnVhgtkfU455MlVRHQg9a+lH93gHzj89hTMOcmhp15B05oXFcbFmEoe6PVM09x1T85xvX3D4CNqNCOtXplTkrVNV58yqbAWOvO1o6kTog9++8EWL13jKzWRNEbDbQR5nChRsI9zrs3Bk+Dt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wQc4vYNu; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wQc4vYNu"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771873718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8BXgjUvpFvmAGdcTDbsEt6D0aG0frHJEowSE/Bfp8go=;
	b=wQc4vYNuleNSy49+4CkYZmF3KzZR5O+b6IyDCu6MsNBDX4PqcVN6L2uOgUYCCPwnhUPGOu
	TAWtvYyQtaP7xxtCU3Ovsmh2AMaSBxH5DtqVXkIwnLIV/tMGXeg2YOLxUzVBWJZnRIf/2K
	y5EzkM8vUtX2Gc7BGUa7Jd0ZiwWZ5b0=
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
Subject: [PATCH bpf v4 14/20] selftests/bpf: Fix double thread join in uprobe_multi_test
Date: Mon, 23 Feb 2026 11:07:30 -0800
Message-ID: <20260223190736.649171-15-ihor.solodrai@linux.dev>
In-Reply-To: <20260223190736.649171-1-ihor.solodrai@linux.dev>
References: <20260223190736.649171-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

ASAN reported a "joining already joined thread" error. The
release_child() may be called multiple times for the same struct
child.

Fix by resetting child->thread to 0 after pthread_join.

Also memset(0) static child variable in test_attach_api().

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 2ee17ef1dae2..56cbea280fbd 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -62,8 +62,10 @@ static void release_child(struct child *child)
 		return;
 	close(child->go[1]);
 	close(child->go[0]);
-	if (child->thread)
+	if (child->thread) {
 		pthread_join(child->thread, NULL);
+		child->thread = 0;
+	}
 	close(child->c2p[0]);
 	close(child->c2p[1]);
 	if (child->pid > 0)
@@ -331,6 +333,8 @@ test_attach_api(const char *binary, const char *pattern, struct bpf_uprobe_multi
 {
 	static struct child child;
 
+	memset(&child, 0, sizeof(child));
+
 	/* no pid filter */
 	__test_attach_api(binary, pattern, opts, NULL);
 
-- 
2.53.0

