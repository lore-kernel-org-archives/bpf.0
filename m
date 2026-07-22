Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D894047143A;
	Wed, 22 Jul 2026 07:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706527; cv=none; b=d+/r6vbQxc7i5zFPZSIiWvQ64ZPMD9YUu681TUS0e+n7Yl59ROeOvpxvwOune6qSAk0VPKn0JAoTfdYMdjT8VTY5PyLiu2utADn/nBKpYvuCC62W360jAboXMjnHBv9V8syrY8GrnkmBz4b6JQI0VuOBgBcJcG9PTyuNGu6QfV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706527; c=relaxed/simple;
	bh=/CyqYapRFwqKdaSXapus7/vEhO8Iy9GGexphq1elrKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k0L9XPUdmdSJiyTWskVlU9K20fiXqUPLuPiNJFuQMSlcInE9wtSIE0uOFsfdlkuHvTbqDVVWsd0XVOVqpUafPJotIQR7b2jlGyTzyqD+WhkC0Cn8wkCTjzgAwwlKjgyKM/BgLQ5eiN3Q64CSTHWznK7+nzxzFqe+BQFxmSVb4vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MI2gk4AQ; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MI2gk4AQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Tk
	vSE4ocXd7ie/+zMu3wzISFvbgwrwWJ/UIs/8Ewglo=; b=MI2gk4AQ7K80+BRuS1
	q4F1bQxQ00v3uaA7L555XL+WXbowq4x2/xTZhHY4xwTuqmSygWbY5JftxQIzKoXu
	VBjREVLn9z9o78JbNzSMEYmyNTWzSBMwpxMfRKHtPdltg4gFQPVcN01IThnqyd4U
	GRfVYNiUolR4nmYxGVu+/R7V8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnrw+kdWBq8DkpJA--.55057S5;
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
Subject: [PATCH v2 bpf-next 3/5] selftests/bpf: Use calloc to allocate subtest_states
Date: Wed, 22 Jul 2026 15:47:46 +0800
Message-Id: <20260722074748.674080-4-yangfeng59949@163.com>
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
X-CM-TRANSID:PigvCgDnrw+kdWBq8DkpJA--.55057S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Xw18tr1kurW8KF4UKr13twb_yoW8JrWxpF
	WkGr4jgr17tFnIqFnrJr4UCrsYgwnrX3yxKryUZw1UAr17Xryftrn7KrWjqFnIgrWFvryr
	Z3Wv9rs8Cw4UJF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jyVbkUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8gg6smpgdajBOwAA3f

From: Feng Yang <yangfeng@kylinos.cn>

An early return triggered by read_prog_test_msg leaves uninitialized elements,
which leads to memory corruption during free_test_states cleanup.

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 tools/testing/selftests/bpf/test_progs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 88c65ce5b018..ed9ad7ad3352 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1516,15 +1516,13 @@ static int dispatch_thread_send_subtests(int sock_fd, struct test_state *state)
 	struct subtest_state *subtest_state;
 	int subtest_num = state->subtest_num;
 
-	state->subtest_states = malloc(subtest_num * sizeof(*subtest_state));
+	state->subtest_states = calloc(subtest_num, sizeof(*subtest_state));
 	if (!state->subtest_states)
 		return -ENOMEM;
 
 	for (int i = 0; i < subtest_num; i++) {
 		subtest_state = &state->subtest_states[i];
 
-		memset(subtest_state, 0, sizeof(*subtest_state));
-
 		if (read_prog_test_msg(sock_fd, &msg, MSG_SUBTEST_DONE))
 			return 1;
 
-- 
2.43.0

