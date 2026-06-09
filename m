Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0367441930D;
	Tue,  9 Jun 2026 12:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781009624; cv=none; b=A7oWCXKyDWJcgWrSoNknjN1F71u6oNLwuzHNFtq4GjQrSjM6vOKdUE9x0g9A/IU9jjFG9ObdEfNW1An06P0y+b6+5+bNYEAr9Bn1AhjL1etHjrd3VblC8bsOwUvGFounA70YJrCXJcBjcpCtpMbTp3xTEzX+qRk3SVzzMElSqNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781009624; c=relaxed/simple;
	bh=hKq87oloK4wQOobWABNNaOIg2C7pwg1eUmkYrjTqUaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqmy5UtisjC5C9FxfkDqDv8dCpUWij3jz4L5feSJKN95jqtGm0KPfFim9U5aEvbqVcT7/fr9N6J6jooMq4zs6Ndj1zW65hLUd+KeRQRRSmxwTUzBXyMr44peuw1XtOmyOfIpzp2IHRwaF8iHUtYYagaR2ibZW2VrnxnXcf1Gh9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZkKwzQVb; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZkKwzQVb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Lk
	u9J1QQClxXUHMC+AqzpMiIb0/zD0xqOOn1lD3TYNc=; b=ZkKwzQVbBrmWQSyeXw
	UIiQIcAPBLyihU8wDAuVFq7Q9HqpWhh+Xrs1bVrI3AmBCA++VYgzpDKuOw5ARnYN
	F2bpJy/bwfoiZtgeDdGf0wWaEnJ//+AxwLMe0ZL6cesTlPKFdEL+E53ysVU+j1x6
	0fG4alVjvxShCmm9SQaq2NRIQ=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBXfwCHDChqml32CQ--.44113S4;
	Tue, 09 Jun 2026 20:52:33 +0800 (CST)
From: chenyuan_fl@163.com
To: chenyuan_fl@163.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bot+bpf-ci@kernel.org,
	bpf@vger.kernel.org,
	chenyuan@kylinos.cn,
	clm@meta.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH bpf v6 2/2] selftests/bpf: strengthen bpf_kfunc_implicit_arg to verify aux injection
Date: Tue,  9 Jun 2026 20:52:14 +0800
Message-ID: <20260609125214.3096351-3-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609125214.3096351-1-chenyuan_fl@163.com>
References: <20260608142618.3064380-1-chenyuan_fl@163.com>
 <20260609125214.3096351-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXfwCHDChqml32CQ--.44113S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFW8WF1ftry5ury5Gw48WFg_yoW8XFy3pa
	97Jr10kr97Xa17XFn7GF48XFWrKFs3XrW8AF1DGr95Zr4kX340qF18tFyFvFnI9r4Fq3Wf
	AayxKFW5uw48ZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR1rWrUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5hLLiWooDJK5bAAA3-

From: Yuan Chen <chenyuan@kylinos.cn>

Verify that the KF_IMPLICIT_ARGS injection path correctly passes
the bpf_prog_aux pointer by checking aux->name in
bpf_kfunc_implicit_arg() for the expected program name prefix.
If the verifier incorrectly skipped injection (as could happen
with pahole 1.30's BTF mismatch), the stale register would not
contain a valid aux pointer and the name check would fail.

This is a positive test exercised by the existing kfunc_implicit_args
selftest, which calls bpf_kfunc_implicit_arg(5) and expects a return
value of 5.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 30f1cd23093c..624d57a5c79a 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1906,7 +1906,11 @@ int bpf_kfunc_multi_st_ops_test_1_assoc(struct st_ops_args *args, struct bpf_pro
 
 int bpf_kfunc_implicit_arg(int a, struct bpf_prog_aux *aux)
 {
-	if (aux && a > 0)
+	/* Verify the kernel injected the correct bpf_prog_aux pointer
+	 * rather than leaving a stale register value. */
+	if (!aux || strncmp(aux->name, "test_kfunc", sizeof("test_kfunc") - 1))
+		return -EINVAL;
+	if (a > 0)
 		return a;
 	return -EINVAL;
 }
-- 
2.54.0

