Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277A92FF158
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 22:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771626426; cv=none; b=Wj2avEo67qqAsHac5n1sVdjWEToDUPqQljXuVNL+F23e/M1YQxClrD2OHv1wP3QdYITPmE9VkbNpR1xMMcUQ9nfNo8CwXZwCQQt/ZW4Zm1VAd6VE+BZ/fa0otdnAGNSPkKUT6sS8gQDRx6idu33taW26zA+12M2xHUB+ZR/96gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771626426; c=relaxed/simple;
	bh=h961jMMm4JJyJcQlY8YrVLwS5sTBx6k5KbbDlRkBr00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C33pPPu5rWu+8Ej1mLY8+Fv+VYlb3cib6COj7EREMkT7U0XDDhaCKMKnhvD1019eDtoWIeg2b9uU7ObaJ1w5sslw3+HjmjVtfudaS+79HBmEri/HfPN7EU4I0EEBRTyb9Zm3aQmRLs7TeP3d164T4NPjk3olHx4hAkUGERfOLdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uWf/HyjT; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uWf/HyjT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771626413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8BXgjUvpFvmAGdcTDbsEt6D0aG0frHJEowSE/Bfp8go=;
	b=uWf/HyjTwnDesAyJz/ftFOvOaAeRCDB3DJI2WqiBU395ei2hhUW0dCI23FBQFIvyMAyV/V
	EDwJAc5jUYmYqSeGlyBXhvXW4+/8/5et6KdWyTPV1UNpki925psSHzTusHM8TZGW6K1AIM
	b+njpR1ffiQ3C9GETVqPFtUX+XU8FKU=
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
Subject: [PATCH bpf v3 09/15] selftests/bpf: Fix double thread join in uprobe_multi_test
Date: Fri, 20 Feb 2026 14:25:58 -0800
Message-ID: <20260220222604.1155148-10-ihor.solodrai@linux.dev>
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

