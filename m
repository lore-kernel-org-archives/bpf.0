Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A2F471259;
	Wed, 22 Jul 2026 07:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706514; cv=none; b=kwVkGXxoKEJwi8cSzA280Lm+xOjOr79/yIHG38JSAJZHrkiW2RL4d1CJdpaU9o0DkfAkSOZS6CVl+HjSGQTq5UuXKrFu1sAeWDBEEcUOjvxUqNvglbQVy2khC3QqxEXZg4eyGP6XKTU6NK2/72DSc4+nlpUknMrSNKrA1UJh1f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706514; c=relaxed/simple;
	bh=icBQ7+5hLhxN86ad0zpnx3TAM/L6Rz1brWUB8KKO+PE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JFb2jR4uHVqT9mQO2Wnwb710CcrvEetPcFNUYprLBkiTsi8wMgDiEOWLhJZ7M4qgG1d3HlRe6xNv5WeZjDGZFp8jYRLt6RNdEgaV5JtkXEZMvfDsoqBGrOr439gi5d7n3c1J+Nq1q2+z2Z85WQ+QsHq2WAKvNADOfqWcIuwC2UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KoQzthBc; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KoQzthBc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=8i
	XR2R/F4v5Mjm6Ek/zklsIoQfVxNcCfO5tik3HycDE=; b=KoQzthBck1vsXo1HG2
	0nsmghX6hWHuj6oeqUtLxLLcXNkKma3vBngXa+bn/xbG5bAlZMQrWbElMVGcEPP3
	XUzimCXv0VSp81zQoUi5ytIMVUKdM7VaOcM6O7WJaBMkRNtKK8n6kUBIkrZYodyg
	gJGg9W2KTmjt9Vy8fhjHkeiak=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnrw+kdWBq8DkpJA--.55057S7;
	Wed, 22 Jul 2026 15:47:52 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 bpf-next 5/5] selftests/bpf: Fix potential NULL pointer dereference in strscpy call
Date: Wed, 22 Jul 2026 15:47:48 +0800
Message-Id: <20260722074748.674080-6-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260722074748.674080-1-yangfeng59949@163.com>
References: <20260722074748.674080-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDnrw+kdWBq8DkpJA--.55057S7
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw13Ww1DZFW3WF1kAFyUAwb_yoWkAFcE9w
	4jgr97GF1jya43Aw1UGr1FkFZ3Xw4qqF4kXr1UtFy3tFy5Xan8W3WkJrs8A3WrW39xtFy2
	qws5ur97tr47CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8kcTPUUUUU==
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbCzwg6smpgdahMdgAA3i

From: Feng Yang <yangfeng@kylinos.cn>

In test__start_subtest_with_desc, if strdup fails or an empty name is passed,
the function returns early. Later, worker_main_send_subtests copies the name via strscpy,
which leads to a NULL pointer dereference.

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 tools/testing/selftests/bpf/test_progs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index ea9c887201ae..ab88268db9e2 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1882,7 +1882,8 @@ static int worker_main_send_subtests(int sock, struct test_state *state)
 
 		msg.subtest_done.num = i;
 
-		strscpy(msg.subtest_done.name, subtest_state->name, MAX_SUBTEST_NAME);
+		const char *name = subtest_state->name ? : "";
+		strscpy(msg.subtest_done.name, name, MAX_SUBTEST_NAME);
 
 		msg.subtest_done.error_cnt = subtest_state->error_cnt;
 		msg.subtest_done.skipped = subtest_state->skipped;
-- 
2.43.0

