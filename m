Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8842D3126D7
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 22:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771626423; cv=none; b=imdptgQgwRMlWObEpJdIOsnDbo4EUAPbaRMUaGlqGCI7kVDwVbhmVsLtFAlaUCqC5ZjJbsVBOKdIq2PWJXgMq23VZx7BSAzesJcOmj5Y26zxxL/cn49ZYvDTPTGd77SlZh7/awQe5bWtKWZHahS22rUtRsDxdvUerHDvdOJhIjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771626423; c=relaxed/simple;
	bh=b91pEac6YrQf6AA0BkSypFpVCQSBxS1GtFd+o1jKsNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZIOK2MH4LKh57Db8kY7AFztSXDoI0u+PUBAZURZ/pDuLMP1aWg1M3DGxWA7Tgie+eY+l002i5uz4boyB/q9LR0RLvAVTUvn3XfBsOGyxI7lBhik1tc75DDlR1Uxbij0sVS/8jyQTGTU6Pbi9RJwPSxU376Fazmm5DOph9//tCfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KA6h99nr; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KA6h99nr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771626419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aF3XpM5Vp8Ae6GR1ZtZNYmZ1UwRARFZZQsmTjQhrewc=;
	b=KA6h99nr3OpKSOHhBN4nWmF9Crwf8vreYTxv7+UQE80tAfuEzhesTkHwmA9YmH13Sk9YRb
	7sZLh1vLRaGS6LobrcOftpF33hBMFpNJ3EHU5D8vptTu4pbVr4h0SC5+5TbwLeN6KVPUuK
	YSBEnTuhLHK4P38OenLgau58rlN2DrY=
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
Subject: [PATCH bpf v3 11/15] selftests/bpf: Free bpf_object in test_sysctl
Date: Fri, 20 Feb 2026 14:26:00 -0800
Message-ID: <20260220222604.1155148-12-ihor.solodrai@linux.dev>
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

ASAN reported a resource leak due to the bpf_object not being tracked
in test_sysctl. Add obj field to struct sysctl_test to properly clean
it up.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/test_sysctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_sysctl.c b/tools/testing/selftests/bpf/prog_tests/test_sysctl.c
index 273dd41ca09e..2a1ff821bc97 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_sysctl.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_sysctl.c
@@ -27,6 +27,7 @@ struct sysctl_test {
 		OP_EPERM,
 		SUCCESS,
 	} result;
+	struct bpf_object *obj;
 };
 
 static struct sysctl_test tests[] = {
@@ -1471,6 +1472,7 @@ static int load_sysctl_prog_file(struct sysctl_test *test)
 		return -1;
 	}
 
+	test->obj = obj;
 	return prog_fd;
 }
 
@@ -1573,6 +1575,7 @@ static int run_test_case(int cgfd, struct sysctl_test *test)
 	/* Detaching w/o checking return code: best effort attempt. */
 	if (progfd != -1)
 		bpf_prog_detach(cgfd, atype);
+	bpf_object__close(test->obj);
 	close(progfd);
 	printf("[%s]\n", err ? "FAIL" : "PASS");
 	return err;
-- 
2.53.0

