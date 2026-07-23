Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D741D30D41E;
	Thu, 23 Jul 2026 08:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784796713; cv=none; b=l1ouQQPnP7Q316SGN0f1reSjmHhOfmFeDyirg3u0t4gJR7p7xpTr7CgupVJPYwy88gl6jTZwxteqwjLkx9Uk5eDY+b2i2qA+r7I+D1JNeP14wtAToPvbhCWx7NvFaAVIqlO5q3SNnn4nhs4ZQw7vGNhLr1GEHD0wuMZhVvLT+wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784796713; c=relaxed/simple;
	bh=Ptv3KKXYe9IIyp076Rfs11b3OoD014ljlRkwecbsQN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X9DVxVjqB6N4FsJv4CwnpOhzbyzokWdmD2TzzyvmQeUmwpJ0T/cmfo6nLocwYwMmR8atYjE8KSJ+1OugidddSGeFgMX0CJxa2rBOD+o6qPG9V0lGQkdSQXUPR/7/KKHAw6xvQ4wP5agAvsBCsqADkcNcjvXMmuLSsMeEzka0/es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mixBmNrG; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mixBmNrG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=OD
	vUJpcRF5+MzbyTiaOy2oxOnDk3KNf2ayxIkVFMbzk=; b=mixBmNrGbZ4l14zKeB
	kgHiVJrbLJlIyZ+o0qI51DrRUwPOAY2sE/q1zMgBufBWJfJlDMJVUPfacBRKo6V9
	KMieNJJVrb6849t7MTmrdveVOzf7SMuBq231loOSwOK58e+nI4+UkYWwBGiDLwna
	/3JHLacxzelSE9Y2SMr3AEYqo=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAXxSj01WFqpPy0Ig--.27305S7;
	Thu, 23 Jul 2026 16:51:03 +0800 (CST)
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
Subject: [PATCH v3 bpf-next 5/5] selftests/bpf: Fix memory leak on subtest_states reallocation
Date: Thu, 23 Jul 2026 16:51:00 +0800
Message-Id: <20260723085100.482147-6-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260723085100.482147-1-yangfeng59949@163.com>
References: <20260723085100.482147-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAXxSj01WFqpPy0Ig--.27305S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFWxXFW5Xr1UAFyxXF17GFg_yoW8Xr1rpF
	WkGrWrKr13JFsxZrnrJr1Uua9YgryIqw4xK34jy34UAF17Xr93trn7t3yUtrsxJrWrZr4F
	v3Wv9rs8Zw48XFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnBMtUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC0BelHmph1fev3gAA3k

From: Feng Yang <yangfeng@kylinos.cn>

Fix memory leak in subtest_states reallocation,
and revert subtest_num if allocation fails.

Fixes: 0925225956bb ("bpf/selftests: Add granular subtest output for prog_test")
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 tools/testing/selftests/bpf/test_progs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 07da45230c4b..aa06bab30966 100644
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

