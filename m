Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E2E471254;
	Wed, 22 Jul 2026 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706513; cv=none; b=PJhbUgrPSypT/wn2OSBoCM1AFmOldQWxRf16Ap8ZYp3t4cgFEhfVnci0WxciRXos/0CbxPC3oa5NG819EXOSI9YjLHj0bVraUYqL0m2yBUGklTuWJpAIlz5T3jgL7B4ho1CdqrRYRoXuFfqhNZmH4HAHAM0EzVCWhzNl/QZKCCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706513; c=relaxed/simple;
	bh=SAuWJEs3ejcv+3zY7oC3QLSgIO+Hihatb+rLU0Zxqgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I8E1x82IZTTZke+999c+X1rxeh+YmB9rG2vIKO1mEW1LdeskhPZwRLpuFkCtBqUZHXERph5DYDLEz0CuGqcmnyIpRYVkhhDvzCvv/OyOQeXAULl/NttGD3LamUKy4QUzyMKUEggi7x1dZHVIx7rtTtHdLOND2AqyA904hYlxTtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VDyVqf8/; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VDyVqf8/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=un
	QlmtBlrXEmAs+njOjBB0p+7BQiFeGGMAjYNK9uENM=; b=VDyVqf8/AgMkCEhNMZ
	z9POJSezdg8WppdgaX3HnUKwtJ5FlmGS70hFLvii39JEjCrQYTnO3cZM1bnzZjY5
	FANV1tUzXRb2yPHww5jeBSwK9UxZxxhGHQ7KHS2LXFF5IWl6QCff47K+zA1L6AAd
	gH/Hl7emQd7BxumCE0WQwKzVw=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnrw+kdWBq8DkpJA--.55057S6;
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
Subject: [PATCH v2 bpf-next 4/5] selftests/bpf: Fix memory leak on subtest_states reallocation
Date: Wed, 22 Jul 2026 15:47:47 +0800
Message-Id: <20260722074748.674080-5-yangfeng59949@163.com>
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
X-CM-TRANSID:PigvCgDnrw+kdWBq8DkpJA--.55057S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFWxXFW5Xr1UAFyxXF17GFg_yoW8Xr1rpF
	WDGrWrKr13JanxZrnrJr1Uua9YgryIqw4xK34jy34UAF17Xr93trn7t3yUtrsxJrWrZr4F
	v3Wv9rs8Zw48WF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jY5l8UUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbCzwg6smpgdahMbQAA35

From: Feng Yang <yangfeng@kylinos.cn>

Fix memory leak in subtest_states reallocation,
and revert subtest_num if allocation fails.

Fixes: 0925225956bb ("bpf/selftests: Add granular subtest output for prog_test")
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 tools/testing/selftests/bpf/test_progs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index ed9ad7ad3352..ea9c887201ae 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -573,18 +573,19 @@ bool test__start_subtest_with_desc(const char *subtest_name, const char *subtest
 	struct subtest_state *subtest_state;
 	const char *subtest_display_name;
 	size_t sub_state_size = sizeof(*subtest_state);
+	void *tmp;
 
 	if (env.subtest_state)
 		test__end_subtest();
 
 	state->subtest_num++;
-	state->subtest_states =
-		realloc(state->subtest_states,
-			state->subtest_num * sub_state_size);
-	if (!state->subtest_states) {
+	tmp = realloc(state->subtest_states, state->subtest_num * sub_state_size);
+	if (!tmp) {
+		state->subtest_num--;
 		fprintf(stderr, "Not enough memory to allocate subtest result\n");
 		return false;
 	}
+	state->subtest_states = tmp;
 
 	subtest_state = &state->subtest_states[state->subtest_num - 1];
 
-- 
2.43.0

